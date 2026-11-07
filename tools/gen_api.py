#!/usr/bin/env python3
# Regenerates Sources/tgapi/api_sources/Api*.swift from Telegram-iOS's
# submodules/TelegramApi/swift_scheme.tl, in the same format Telegram's own generator
# used before 13.1 (Telegram now ships a table-driven engine instead).
#
#   python3 tools/gen_api.py <Telegram-iOS>/submodules/TelegramApi/swift_scheme.tl Sources/tgapi/api_sources [--full] [--extra tools/schema_extra_233.json]
#
# --extra adds constructors a released client has but the public repository doesn't
# yet (recovered from the IPA with tools/extract_schema.py). They only ever add to
# what Lead can parse, so older clients keep working.
#
# Use swift_scheme.tl, not the schema.json next to it: Telegram's build generates
# from the .tl, and the .json lags behind (in 13.1.1 channel, channelFull and
# userFull differ — a parser built from it failed on every real channel).
#
# Checked against Telegram's last generated files (layer 230): byte-identical for
# every unchanged constructor and method (--full).
#
# By default the output is slim: only the types TLParser can meet inside the
# responses it handles (ROOTS) plus the methods it builds (FUNCTIONS), everything
# internal (so the linker can drop and strip it), no descriptionFields(). That keeps
# Lead.dylib small. When TLParser starts handling a new response type, add it to ROOTS.
import json, re, sys, os, glob

# Response types TLParser.stripAntiSelfDestruct / transformVideoToVoiceSendMedia parse.
ROOTS = [
    'Updates', 'Update', 'Message', 'messages.Messages', 'messages.ChatFull', 'users.UserFull',
    'messages.Chats', 'messages.DiscussionMessage', 'messages.PeerDialogs', 'messages.Dialogs',
    'updates.Difference', 'updates.ChannelDifference', 'payments.StarsStatus',
    'stories.AllStories', 'stories.PeerStories', 'stories.Stories', 'help.PromoData',
    'contacts.ResolvedPeer', 'contacts.Found', 'messages.ForumTopics',
    # Everything else that carries chats: Telegram stores those channels again (view
    # counters, send-as, participants, sponsored…), so their noforwards bit must go too.
    'ChatInvite', 'account.AutoSaveSettings', 'account.BusinessChatLinks', 'account.ChatThemes',
    'account.PrivacyRules', 'account.ResolvedBusinessChatLinks', 'channels.AdminLogResults',
    'channels.ChannelParticipant', 'channels.ChannelParticipants', 'channels.SendAsPeers',
    'chatlists.ChatlistInvite', 'chatlists.ChatlistUpdates', 'chatlists.ExportedInvites',
    'communities.ParticipantJoinedChats', 'communities.PeerLinkRequests', 'contacts.Blocked',
    'contacts.SponsoredPeers', 'contacts.TopPeers', 'help.RecentMeUrls', 'messages.InactiveChats',
    'messages.MessageReactionsList', 'messages.MessageViews', 'messages.PeerSettings',
    'messages.QuickReplies', 'messages.SavedDialogs', 'messages.SearchResultsCalendar',
    'messages.SponsoredMessages', 'messages.VotesList', 'messages.WebPage',
    'messages.WebPagePreview', 'payments.CheckedGiftCode', 'payments.ResaleStarGifts',
    'payments.SavedStarGifts', 'payments.StarGiftActiveAuctions',
    'payments.StarGiftAuctionAcquiredGifts', 'payments.StarGiftAuctionState', 'payments.StarGifts',
    'payments.UniqueStarGift', 'phone.GroupCall', 'phone.GroupCallStars',
    'phone.GroupParticipants', 'phone.JoinAsPeers', 'premium.MyBoosts', 'stats.PublicForwards',
    'stories.FoundStories', 'stories.StoryReactionsList', 'stories.StoryViewsList',
    'wallet.Transactions',
]
# Methods TLParser builds requests for.
FUNCTIONS = ['messages.sendMedia']

FULL = False

KEYWORDS = {'default', 'static', 'self', 'protocol', 'public', 'private', 'open', 'final', 'class', 'struct',
            'func', 'var', 'let', 'in', 'is', 'as', 'repeat', 'return', 'case', 'switch', 'where', 'for',
            'while', 'if', 'else', 'import', 'extension', 'operator', 'true', 'false', 'nil', 'do', 'catch',
            'throw', 'try', 'init', 'deinit', 'subscript', 'enum', 'internal', 'fileprivate', 'inout',
            'super', 'Self', 'Any', 'Type', 'protocol', 'typealias', 'associatedtype', 'defer', 'guard',
            'continue', 'break', 'fallthrough', 'rethrows', 'throws'}

SCALARS = {
    'int': ('Int32', -1471112230),
    'long': ('Int64', 570911930),
    'double': ('Double', 571523412),
    'string': ('String', -1255641564),
    'bytes': ('Buffer', -1255641564),
    'int256': ('Int256', 0x0929C32F),
}
SKIP_TYPES = {'True', 'Vector t', 'Error', 'Null', 'X', 'Bool_'}


def camel(name):
    parts = name.split('_')
    out = parts[0] + ''.join(p[:1].upper() + p[1:] for p in parts[1:])
    return out


def ident(name):
    n = camel(name)
    return '`%s`' % n if n in KEYWORDS else n


def plain(name):
    return camel(name)


def i32(v):
    v = int(v)
    if v >= 2 ** 31:
        v -= 2 ** 32
    return v


def swift_type_name(tl):
    # "messages.Messages" -> "Api.messages.Messages"
    return 'Api.' + tl


def split_type(tl):
    if '.' in tl:
        ns, name = tl.split('.', 1)
        return ns, name
    return None, tl


class Param:
    def __init__(self, name, tltype):
        self.name = name
        self.raw = tltype
        m = re.match(r'^(flags\d*)\.(\d+)\?(.*)$', tltype)
        if m:
            self.flag = (m.group(1), int(m.group(2)))
            t = m.group(3)
        else:
            self.flag = None
            t = tltype
        self.vector = False
        vm = re.match(r'^Vector<(.*)>$', t)
        if vm:
            self.vector = True
            t = vm.group(1)
        self.base = t
        self.is_flags = (t == '#')
        self.is_true = (t == 'true')

    @property
    def elem_swift(self):
        if self.is_flags:
            return 'Int32'
        if self.base in SCALARS:
            return SCALARS[self.base][0]
        return swift_type_name(self.base)

    @property
    def swift(self):
        t = self.elem_swift
        if self.vector:
            t = '[%s]' % t
        return t

    @property
    def opt_swift(self):
        return self.swift + ('?' if self.flag else '')

    @property
    def field(self):
        return ident(self.name)

    @property
    def label(self):
        return ident(self.name)

    @property
    def arg(self):
        return plain(self.name)


def flag_cond(p, prefix):
    fname = plain(p.flag[0])
    return 'Int(%s%s) & Int(1 << %d) != 0' % (prefix, fname, p.flag[1])


def ser_value(p, expr, indent):
    """Serialize a non-optional expression of param p's base type."""
    out = []
    ind = ' ' * indent
    if p.vector:
        out.append(ind + 'buffer.appendInt32(481674261)')
        out.append(ind + 'buffer.appendInt32(Int32(%s.count))' % expr)
        out.append(ind + 'for item in %s {' % expr)
        out += ser_scalar(p, 'item', indent + 4, boxed_obj=True)
        out.append(ind + '}')
    else:
        out += ser_scalar(p, expr, indent, boxed_obj=True)
    return out


def ser_scalar(p, expr, indent, boxed_obj):
    ind = ' ' * indent
    b = p.base
    if p.is_flags or b == 'int':
        return [ind + 'serializeInt32(%s, buffer: buffer, boxed: false)' % expr]
    if b == 'long':
        return [ind + 'serializeInt64(%s, buffer: buffer, boxed: false)' % expr]
    if b == 'double':
        return [ind + 'serializeDouble(%s, buffer: buffer, boxed: false)' % expr]
    if b == 'string':
        return [ind + 'serializeString(%s, buffer: buffer, boxed: false)' % expr]
    if b == 'bytes':
        return [ind + 'serializeBytes(%s, buffer: buffer, boxed: false)' % expr]
    if b == 'int256':
        return [ind + 'serializeInt256(%s, buffer: buffer, boxed: false)' % expr]
    return [ind + '%s.serialize(buffer, true)' % expr]


def ser_params(params, accessor, flagprefix, indent):
    out = []
    ind = ' ' * indent
    for p in params:
        if p.is_true:
            continue
        expr = accessor + p.field
        if p.flag:
            out.append(ind + 'if %s {' % flag_cond(p, flagprefix))
            out += ser_value(p, expr + '!', indent + 4)
            out.append(ind + '}')
        else:
            out += ser_value(p, expr, indent)
    return out


def parse_value(p, var, indent):
    ind = ' ' * indent
    b = p.base
    if p.vector:
        if p.is_flags or b in SCALARS:
            sig = SCALARS['int' if p.is_flags else b][1]
            et = p.elem_swift
        else:
            sig = 0
            et = p.elem_swift
        return [ind + 'if let _ = reader.readInt32() {',
                ind + '    %s = Api.parseVector(reader, elementSignature: %d, elementType: %s.self)' % (var, sig, et),
                ind + '}']
    if p.is_flags or b == 'int':
        return [ind + '%s = reader.readInt32()' % var]
    if b == 'long':
        return [ind + '%s = reader.readInt64()' % var]
    if b == 'double':
        return [ind + '%s = reader.readDouble()' % var]
    if b == 'string':
        return [ind + '%s = parseString(reader)' % var]
    if b == 'bytes':
        return [ind + '%s = parseBytes(reader)' % var]
    if b == 'int256':
        return [ind + '%s = parseInt256(reader)' % var]
    return [ind + 'if let signature = reader.readInt32() {',
            ind + '    %s = Api.parse(reader, signature: signature) as? %s' % (var, p.elem_swift),
            ind + '}']


def desc_list(params, accessor):
    items = ['("%s", ConstructorParameterDescription(%s%s))' % (p.label, accessor, p.field) for p in params if not p.is_true]
    return '[' + ', '.join(items) + ']'


class Ctor:
    def __init__(self, c):
        self.id = i32(c['id'])
        self.predicate = c['predicate']
        ns, name = split_type(self.predicate)
        self.name = name
        self.type = c['type']
        self.params = [Param(p['name'], p['type']) for p in c['params']]
        self.fields = [p for p in self.params if not p.is_true]


def gen_type(tl, ctors):
    ns, name = split_type(tl)
    ext = 'Api.' + ns if ns else 'Api'
    full = 'Api.' + tl
    ctors = sorted(ctors, key=lambda c: c.name)
    L = []
    L.append('public extension %s {' % ext)
    indirect = any(c.fields for c in ctors) and is_indirect(tl)
    L.append('    %senum %s: TypeConstructorDescription {' % ('indirect ' if indirect else '', name))
    for c in ctors:
        if not c.fields:
            continue
        L.append('        public class Cons_%s: TypeConstructorDescription {' % c.name)
        for p in c.fields:
            L.append('            public var %s: %s' % (p.field, p.opt_swift))
        L.append('            public init(%s) {' % ', '.join('%s: %s' % (p.field, p.opt_swift) for p in c.fields))
        for p in c.fields:
            L.append('                self.%s = %s' % (p.field, p.field))
        L.append('            }')
        if FULL:
            L.append('            public func descriptionFields() -> (String, [(String, ConstructorParameterDescription)]) {')
            L.append('                return ("%s", %s)' % (c.name, desc_list(c.params, 'self.')))
            L.append('            }')
        L.append('        }')
    for c in ctors:
        if c.fields:
            L.append('        case %s(Cons_%s)' % (c.name, c.name))
        else:
            L.append('        case %s' % c.name)
    L.append('')
    L.append('        public func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {')
    L.append('            switch self {')
    for c in ctors:
        if c.fields:
            L.append('            case .%s(let _data):' % c.name)
        else:
            L.append('            case .%s:' % c.name)
        L.append('                if boxed {')
        L.append('                    buffer.appendInt32(%d)' % c.id)
        L.append('                }')
        L += ser_params(c.params, '_data.', '_data.', 16)
        L.append('                break')
    L.append('            }')
    L.append('        }')
    if FULL:
        L.append('')
        L.append('        public func descriptionFields() -> (String, [(String, ConstructorParameterDescription)]) {')
        L.append('            switch self {')
        for c in ctors:
            if c.fields:
                L.append('            case .%s(let _data):' % c.name)
                L.append('                return ("%s", %s)' % (c.name, desc_list(c.params, '_data.')))
            else:
                L.append('            case .%s:' % c.name)
                L.append('                return ("%s", [])' % c.name)
        L.append('            }')
        L.append('        }')
    L.append('')
    for c in ctors:
        L.append('        public static func parse_%s(_ reader: BufferReader) -> %s? {' % (c.name, name))
        if not c.fields:
            L.append('            return %s.%s' % (full, c.name))
            L.append('        }')
            continue
        idx = {}
        n = 0
        for p in c.params:
            if p.is_true:
                continue
            n += 1
            idx[p.name] = n
        for p in c.params:
            if p.is_true:
                continue
            k = idx[p.name]
            var = '_%d' % k
            L.append('            var %s: %s?' % (var, p.swift))
            if p.flag:
                fk = idx[p.flag[0]]
                L.append('            if Int(_%d ?? 0) & Int(1 << %d) != 0 {' % (fk, p.flag[1]))
                L += parse_value(p, var, 16)
                L.append('            }')
            else:
                L += parse_value(p, var, 12)
        conds = []
        for p in c.params:
            if p.is_true:
                continue
            k = idx[p.name]
            if p.flag:
                fk = idx[p.flag[0]]
                L.append('            let _c%d = (Int(_%d ?? 0) & Int(1 << %d) == 0) || _%d != nil' % (k, fk, p.flag[1], k))
            else:
                L.append('            let _c%d = _%d != nil' % (k, k))
            conds.append('_c%d' % k)
        L.append('            if %s {' % ' && '.join(conds))
        args = ', '.join('%s: _%d%s' % (p.arg, idx[p.name], '' if p.flag else '!') for p in c.fields)
        L.append('                return %s.%s(Cons_%s(%s))' % (full, c.name, c.name, args))
        L.append('            }')
        L.append('            else {')
        L.append('                return nil')
        L.append('            }')
        L.append('        }')
    L.append('    }')
    L.append('}')
    return L


INDIRECT = set()


def is_indirect(tl):
    return tl in INDIRECT


def ret_type(t):
    vm = re.match(r'^Vector<(.*)>$', t)
    if vm:
        e = vm.group(1)
        if e in SCALARS:
            return '[%s]' % SCALARS[e][0], e
        return '[%s]' % swift_type_name(e), e
    return swift_type_name(t), None


def gen_function(m):
    method = m['method']
    ns, name = split_type(method)
    ext = 'Api.functions.' + ns if ns else 'Api.functions'
    params = [Param(p['name'], p['type']) for p in m['params']]
    fields = [p for p in params if not p.is_true]
    rt, velem = ret_type(m['type'])
    L = []
    L.append('public extension %s {' % ext)
    L.append('    static func %s(%s) -> (FunctionDescription, Buffer, DeserializeFunctionResponse<%s>) {' % (
        ident(name), ', '.join('%s: %s' % (p.field, p.opt_swift) for p in fields), rt))
    L.append('        let buffer = Buffer()')
    L.append('        buffer.appendInt32(%d)' % i32(m['id']))
    L += ser_params(params, '', '', 8)
    desc = '[' + ', '.join('("%s", ConstructorParameterDescription(%s))' % (p.label, p.field) for p in fields) + ']'
    if not FULL:
        desc = '[]'
    L.append('        return (FunctionDescription(name: "%s", parameters: %s), buffer, DeserializeFunctionResponse { (buffer: Buffer) -> %s? in' % (method, desc, rt))
    L.append('            let reader = BufferReader(buffer)')
    L.append('            var result: %s?' % rt)
    if velem is not None:
        if velem in SCALARS:
            sig = SCALARS[velem][1]
            et = SCALARS[velem][0]
        else:
            sig = 0
            et = swift_type_name(velem)
        L.append('            if let _ = reader.readInt32() {')
        L.append('                result = Api.parseVector(reader, elementSignature: %d, elementType: %s.self)' % (sig, et))
        L.append('            }')
    else:
        L.append('            if let signature = reader.readInt32() {')
        L.append('                result = Api.parse(reader, signature: signature) as? %s' % rt)
        L.append('            }')
    L.append('            return result')
    L.append('        })')
    L.append('    }')
    L.append('}')
    return L


def type_sort_key(tl):
    ns, name = split_type(tl)
    return (1 if ns else 0, ns or '', name)


EXTRA = None


def load(schema_path):
    if schema_path.endswith('.tl'):
        sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
        from tl_to_json import convert
        s = convert(schema_path)
    else:
        s = json.load(open(schema_path))
    if EXTRA:
        known = {c['id'] for c in s['constructors']}
        s['constructors'] += [c for c in json.load(open(EXTRA))['constructors'] if c['id'] not in known]
    types = {}
    for c in s['constructors']:
        if c['type'] in SKIP_TYPES or c['predicate'] in ('vector', 'true', 'error', 'null'):
            continue
        types.setdefault(c['type'], []).append(Ctor(c))
    methods = []
    for m in s['methods']:
        if m['type'] == 'X' or any(p['type'] in ('!X', 'X') for p in m['params']):
            continue
        methods.append(m)
    if FULL:
        return types, methods
    methods = [m for m in methods if m['method'] in FUNCTIONS]
    missing = set(FUNCTIONS) - {m['method'] for m in methods}
    if missing:
        sys.exit('unknown FUNCTIONS: %s' % ', '.join(sorted(missing)))
    pending = list(ROOTS)
    for m in methods:
        pending.append(re.sub(r'^Vector<(.*)>$', r'\1', m['type']))
        pending += [Param(p['name'], p['type']).base for p in m['params']]
    keep = set()
    while pending:
        t = pending.pop()
        if t in keep or t not in types:
            continue
        keep.add(t)
        for c in types[t]:
            pending += [p.base for p in c.params]
    return {t: v for t, v in types.items() if t in keep}, methods


def gen_header(types, methods):
    nss = sorted({split_type(t)[0] for t in types if split_type(t)[0]} )
    fns = sorted({split_type(m['method'])[0] for m in methods if split_type(m['method'])[0]})
    L = ['', 'public enum Api {']
    for n in nss:
        L.append('    public enum %s {}' % n)
    L.append('    public enum functions {')
    for n in fns:
        L.append('        public enum %s {}' % n)
    L.append('    }')
    L.append('}')
    L.append('')
    L.append('fileprivate let parsers: [Int32 : (BufferReader) -> Any?] = {')
    L.append('    var dict: [Int32 : (BufferReader) -> Any?] = [:]')
    L.append('    dict[-1471112230] = { return $0.readInt32() }')
    L.append('    dict[570911930] = { return $0.readInt64() }')
    L.append('    dict[571523412] = { return $0.readDouble() }')
    L.append('    dict[0x0929C32F] = { return parseInt256($0) }')
    L.append('    dict[-1255641564] = { return parseString($0) }')
    for t in sorted(types, key=type_sort_key):
        for c in sorted(types[t], key=lambda c: c.name):
            L.append('    dict[%d] = { return Api.%s.parse_%s($0) }' % (c.id, t, c.name))
    L.append('    return dict')
    L.append('}()')
    return L


def write(path, lines):
    text = '\n'.join(lines) + '\n'
    if not FULL:
        text = re.sub(r'^(\s*)public ', r'\1', text, flags=re.M)
    open(path, 'w').write(text)


def main():
    global FULL, EXTRA
    argv = sys.argv[1:]
    if '--extra' in argv:
        i = argv.index('--extra')
        EXTRA = argv[i + 1]
        del argv[i:i + 2]
    args = [a for a in argv if a != '--full']
    FULL = len(args) != len(argv)
    schema, outdir = args[0], args[1]
    old_files = glob.glob(os.path.join(outdir, 'Api[0-9]*.swift'))
    # Keep `indirect` exactly where the previous generation had it (cosmetic only).
    for f in old_files:
        lines = open(f).read().split('\n')
        for i, l in enumerate(lines):
            m = re.match(r'^    indirect enum (\w+):', l)
            e = re.match(r'^(?:public )?extension Api(?:\.(\w+))? \{', lines[i - 1]) if i else None
            if m and e:
                INDIRECT.add((e.group(1) + '.' if e.group(1) else '') + m.group(1))
    # Api0's runtime helpers (parse/parseVector) are carried over from the current Api0.swift.
    tmpl = open(os.path.join(outdir, 'Api0.swift')).read().replace('\nextension Api {\n    static func parse(_ buffer', '\npublic extension Api {\n    static func parse(_ buffer')
    types, methods = load(schema)
    helpers_start = tmpl.index('public extension Api {\n    static func parse(_ buffer: Buffer)')
    helpers_end = tmpl.index('    static func serializeObject(')
    for f in old_files:
        os.remove(f)
    L = gen_header(types, methods)
    L.append('')
    L.append(tmpl[helpers_start:helpers_end].rstrip('\n'))
    L.append('    static func serializeObject(_ object: Any, buffer: Buffer, boxed: Swift.Bool) {')
    L.append('        switch object {')
    for t in sorted(types, key=type_sort_key):
        L.append('        case let _1 as Api.%s:' % t)
        L.append('            _1.serialize(buffer, boxed)')
    L.append('        default:')
    L.append('            break')
    L.append('        }')
    L.append('    }')
    L.append('}')
    write(os.path.join(outdir, 'Api0.swift'), L)

    blocks = []
    for t in sorted(types, key=type_sort_key):
        blocks.append(gen_type(t, types[t]))
    fblocks = []
    for m in sorted(methods, key=lambda m: (split_type(m['method'])[0] or '', split_type(m['method'])[1])):
        fblocks.append(gen_function(m))
    # split into files of ~1800 lines
    files = []
    cur = []
    for b in blocks + fblocks:
        if cur and len(cur) + len(b) > 1800:
            files.append(cur)
            cur = []
        cur += b
    if cur:
        files.append(cur)
    for i, f in enumerate(files):
        write(os.path.join(outdir, 'Api%d.swift' % (i + 1)), f)
    print('types', len(types), 'methods', len(methods), 'files', len(files) + 1)


if __name__ == '__main__':
    main()
