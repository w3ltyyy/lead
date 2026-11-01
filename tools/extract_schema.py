#!/usr/bin/env python3
# Recovers the TL schema a Telegram 13.x build (or fork) was compiled with, from
# the zlib-compressed "TLS1" schema image its table-driven API engine embeds
# (build-system/SwiftTL/Sources/SwiftTL/SchemaBlob.swift, version 3), and writes
# it in the schema.json layout gen_api.py reads.
#   python3 tools/extract_schema.py <App.app or a framework binary> out.json
import json, os, re, struct, sys, zlib

KINDS = {0: 'int', 1: 'long', 2: 'int256', 3: 'double', 4: 'string', 5: 'bytes', 6: 'object', 7: 'vector'}

def find_image(data):
    for match in re.finditer(rb'\x78\xda', data):
        try:
            image = zlib.decompressobj().decompress(data[match.start():match.start() + (8 << 20)])
        except zlib.error:
            continue
        if image[:4] == b'TLS1':
            return image
    return None

def snake(name):
    name = name.strip('`')
    return re.sub(r'(?<=[a-z0-9])([A-Z])', lambda m: '_' + m.group(1).lower(), name)

def decode(image):
    (magic, version, _hash, length, ntypes, nctors, nfuncs, nfields, ntc, pool_off, pool_len,
     types_off, tc_off, ctors_off, fields_off, funcs_off, _zero) = struct.unpack_from('<IIQIIIIIIIIIIIIII', image, 0)
    if version != 3:
        raise SystemExit('unsupported schema image version %d' % version)
    def string(off):
        start = pool_off + off
        return image[start:image.index(b'\0', start)].decode()
    types = []
    for i in range(ntypes):
        name, _, _ = struct.unpack_from('<III', image, types_off + i * 12)
        types.append(string(name))
    def field(index):
        (name, kind, elem, optional, boxed, bare, flags_index, flag_bit, _presence,
         obj_type, _bare_ctor, _storage) = struct.unpack_from('<IBBBBBbBBHHI', image, fields_off + index * 20)
        return dict(name=string(name), kind=kind, elem=elem, optional=optional, boxed=boxed, bare=bare,
                    flags_index=flags_index, flag_bit=flag_bit, type=types[obj_type])
    def tl_type(f):
        if f['kind'] == 6:
            return f['type']
        if f['kind'] == 7:
            inner = f['type'] if f['elem'] == 6 else KINDS[f['elem']]
            return ('Vector<%s>' if f['boxed'] else 'vector<%s>') % inner
        return KINDS[f['kind']]
    def params(first, count):
        fields = [field(first + i) for i in range(count)]
        # A field is a flags word ('#') only when another field is conditional on it.
        flag_words = {f['flags_index'] for f in fields if f['flags_index'] >= 0}
        out = []
        for index, f in enumerate(fields):
            t = tl_type(f)
            if f['flags_index'] >= 0:
                t = '%s.%d?%s' % (snake(fields[f['flags_index']]['name']), f['flag_bit'], t)
            elif index in flag_words:
                t = '#'
            out.append({'name': snake(f['name']), 'type': t})
        return out
    def qualified(name, type_name):
        # The pool keeps bare names; a constructor shares its type's namespace.
        if '.' not in name and '.' in type_name:
            return type_name.rsplit('.', 1)[0] + '.' + name
        return name
    constructors, methods = [], []
    for i in range(nctors):
        name, cid, type_index, _case, first, count, _pad, _size, _mask = struct.unpack_from('<IIHHIHHIi', image, ctors_off + i * 28)
        constructors.append({'id': str(struct.unpack('<i', struct.pack('<I', cid))[0]), 'predicate': qualified(string(name), types[type_index]),
                             'params': params(first, count), 'type': types[type_index]})
    for i in range(nfuncs):
        name, fid, first, count, _pad, result, _size, _mask = struct.unpack_from('<IIIHHIIi', image, funcs_off + i * 28)
        methods.append({'id': str(struct.unpack('<i', struct.pack('<I', fid))[0]), 'method': string(name),
                        'params': params(first, count), 'type': tl_type(field(result))})
    return {'constructors': constructors, 'methods': methods}

def binaries(path):
    if os.path.isfile(path):
        yield path
        return
    for root, _, files in os.walk(path):
        for name in files:
            full = os.path.join(root, name)
            if '.framework' in root and name == os.path.basename(root).replace('.framework', ''):
                yield full

def main():
    for binary in binaries(sys.argv[1]):
        image = find_image(open(binary, 'rb').read())
        if image:
            schema = decode(image)
            json.dump(schema, open(sys.argv[2], 'w'))
            print('%s: %d constructors, %d methods' % (os.path.basename(binary), len(schema['constructors']), len(schema['methods'])))
            return
    raise SystemExit('no TLS1 schema image found')

if __name__ == '__main__':
    main()
