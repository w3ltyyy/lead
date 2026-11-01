#!/usr/bin/env python3
# Converts Telegram's swift_scheme.tl (what its build actually generates the API
# from) into the schema.json layout gen_api.py reads. The schema.json checked
# into TelegramApi is NOT kept in sync with it — generating from it gave Lead a
# parser for the wrong layer, and every real channel/message failed to parse.
#   python3 tools/tl_to_json.py <Telegram-iOS>/submodules/TelegramApi/swift_scheme.tl out.json
import json, re, sys

def signed(hex_id):
    v = int(hex_id, 16)
    return str(v - (1 << 32) if v >= 1 << 31 else v)

def convert(src):
    constructors, methods = [], []
    section = constructors
    for raw in open(src):
        line = raw.split('//')[0].strip()
        if not line:
            continue
        if line == '---functions---':
            section = methods; continue
        if line == '---types---':
            section = constructors; continue
        m = re.match(r'^([\w.]+)#([0-9a-fA-F]+)\s*(.*?)\s*=\s*([^;]+);$', line)
        if not m:
            continue
        name, hex_id, body, result = m.groups()
        params = []
        for tok in body.split():
            if tok.startswith('{') or tok in ('#', '[', 't', ']'):
                continue
            pm = re.match(r'^(\w+):(.+)$', tok)
            if pm:
                params.append({'name': pm.group(1), 'type': pm.group(2)})
        entry = {'id': signed(hex_id), 'params': params, 'type': result.strip()}
        if section is methods:
            entry['method'] = name
        else:
            entry['predicate'] = name
        section.append(entry)
    return {'constructors': constructors, 'methods': methods}

def main():
    schema = convert(sys.argv[1])
    json.dump(schema, open(sys.argv[2], 'w'))
    print(len(schema['constructors']), 'constructors', len(schema['methods']), 'methods')

if __name__ == '__main__':
    main()
