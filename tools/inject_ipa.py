#!/usr/bin/env python3
# Puts Lead.dylib into a Telegram IPA: into the app itself and into its
# notification service extension, so the extension gets Lead's app-group fix
# (SideloadFix.m) and can read the account to show real notifications.
# Sign the result as usual, WITHOUT adding Lead.dylib again in the signer.
#
#   python3 tools/inject_ipa.py Telegram.ipa [-o Telegram-Lead.ipa] [--dylib Lead.dylib]
#                               [--all-extensions] [--remove sideloadFixer] [--extra other.dylib]
#
# Extra dylibs that link CydiaSubstrate.framework get it copied into Frameworks
# (--substrate).
#
# Only touches load commands (into the existing header padding) and adds the
# dylib to Payload/<app>/Frameworks. The IPA must be decrypted.
import argparse, os, plistlib, shutil, struct, subprocess, sys, tempfile

LC_SEGMENT_64 = 0x19
LC_LOAD_DYLIB = 0xC
LC_LOAD_WEAK_DYLIB = 0x80000018
LC_REEXPORT_DYLIB = 0x8000001F
LC_ENCRYPTION_INFO_64 = 0x2C
MH_MAGIC_64 = 0xFEEDFACF
FAT_MAGIC = 0xCAFEBABE
FAT_MAGIC_64 = 0xCAFEBABF
DYLIB_COMMANDS = (LC_LOAD_DYLIB, LC_LOAD_WEAK_DYLIB, LC_REEXPORT_DYLIB)


class InjectError(Exception):
    pass


def slices(data):
    """(offset, size) of every Mach-O in a thin or fat binary."""
    magic = struct.unpack_from('>I', data, 0)[0]
    if magic in (FAT_MAGIC, FAT_MAGIC_64):
        count = struct.unpack_from('>I', data, 4)[0]
        result = []
        for i in range(count):
            if magic == FAT_MAGIC:
                _, _, offset, size, _ = struct.unpack_from('>iiIII', data, 8 + i * 20)
            else:
                _, _, offset, size, _, _ = struct.unpack_from('>iiQQII', data, 8 + i * 32)
            result.append((offset, size))
        return result
    return [(0, len(data))]


def load_commands(data, base):
    magic, _, _, _, ncmds, sizeofcmds = struct.unpack_from('<IiiIII', data, base)
    if magic != MH_MAGIC_64:
        raise InjectError('not a 64-bit Mach-O slice (magic %08x)' % magic)
    offset = base + 32
    commands = []
    for _ in range(ncmds):
        cmd, size = struct.unpack_from('<II', data, offset)
        commands.append((cmd, offset, size))
        offset += size
    return ncmds, sizeofcmds, commands


def dylib_name(data, offset):
    name_offset = struct.unpack_from('<I', data, offset + 8)[0]
    raw = data[offset + name_offset:]
    return raw[:raw.index(b'\0')].decode()


def linked_dylibs(data):
    names = []
    for base, _ in slices(data):
        _, _, commands = load_commands(data, base)
        names += [dylib_name(data, off) for cmd, off, _ in commands if cmd in DYLIB_COMMANDS]
    return names


def check_decrypted(data, path):
    for base, _ in slices(data):
        _, _, commands = load_commands(data, base)
        for cmd, off, _ in commands:
            if cmd == LC_ENCRYPTION_INFO_64 and struct.unpack_from('<I', data, off + 16)[0] != 0:
                raise InjectError('%s is encrypted (App Store build). Use a decrypted IPA.' % path)


def free_header_space(data, base, sizeofcmds, commands):
    first = None
    for cmd, off, _ in commands:
        if cmd != LC_SEGMENT_64:
            continue
        nsects = struct.unpack_from('<I', data, off + 64)[0]
        for i in range(nsects):
            sect = off + 72 + i * 80
            sect_offset = struct.unpack_from('<I', data, sect + 48)[0]
            if sect_offset:
                first = sect_offset if first is None else min(first, sect_offset)
    if first is None:
        raise InjectError('no sections found')
    return first - (32 + sizeofcmds)


def add_dylib(data, path):
    """Appends LC_LOAD_WEAK_DYLIB `path` to every slice, in place."""
    name = path.encode() + b'\0'
    size = (24 + len(name) + 7) & ~7
    command = struct.pack('<IIIIII', LC_LOAD_WEAK_DYLIB, size, 24, 2, 0x10000, 0x10000) + name
    command += b'\0' * (size - len(command))
    for base, _ in slices(data):
        ncmds, sizeofcmds, commands = load_commands(data, base)
        if free_header_space(data, base, sizeofcmds, commands) < size:
            raise InjectError('not enough room in the Mach-O header for another load command')
        end = base + 32 + sizeofcmds
        data[end:end + size] = command
        struct.pack_into('<II', data, base + 16, ncmds + 1, sizeofcmds + size)


def remove_dylibs(data, needle):
    """Drops load commands whose dylib path contains `needle`. Returns the removed paths."""
    removed = []
    for base, _ in slices(data):
        ncmds, sizeofcmds, commands = load_commands(data, base)
        start = base + 32
        kept = bytearray()
        count = 0
        for cmd, off, size in commands:
            if cmd in DYLIB_COMMANDS and needle.lower() in dylib_name(data, off).lower():
                removed.append(dylib_name(data, off))
                continue
            kept += data[off:off + size]
            count += 1
        data[start:start + sizeofcmds] = kept + b'\0' * (sizeofcmds - len(kept))
        struct.pack_into('<II', data, base + 16, count, len(kept))
    return removed


def patch_binary(binary, load_path, remove, skip_if='lead.dylib'):
    data = bytearray(open(binary, 'rb').read())
    check_decrypted(data, binary)
    notes = []
    for needle in remove:
        for removed in remove_dylibs(data, needle):
            notes.append('removed ' + removed)
    if any(os.path.basename(n).lower() == skip_if.lower() for n in linked_dylibs(data)):
        notes.append('%s already linked, left as is' % os.path.basename(load_path))
    else:
        add_dylib(data, load_path)
        notes.append('linked ' + load_path)
    mode = os.stat(binary).st_mode
    open(binary, 'wb').write(data)
    os.chmod(binary, mode)
    return notes


DEFAULT_SUBSTRATE = [os.path.expanduser('~/Documents/Injecy/cyan/extras/CydiaSubstrate.framework')]


def add_extra(app, executable, dylib, substrate):
    """Copies `dylib` into Frameworks and links it from the main executable (weak)."""
    frameworks = os.path.join(app, 'Frameworks')
    name = os.path.basename(dylib)
    shutil.copy2(dylib, os.path.join(frameworks, name))
    notes = patch_binary(executable, '@executable_path/Frameworks/' + name, [], skip_if=name)
    needs = [n for n in linked_dylibs(bytearray(open(dylib, 'rb').read())) if 'CydiaSubstrate.framework' in n]
    target = os.path.join(frameworks, 'CydiaSubstrate.framework')
    if needs and not os.path.isdir(target):
        source = next((p for p in ([substrate] if substrate else DEFAULT_SUBSTRATE) if p and os.path.isdir(p)), None)
        if not source:
            raise InjectError('%s needs CydiaSubstrate.framework; pass --substrate PATH' % name)
        shutil.copytree(source, target)
        notes.append('added CydiaSubstrate.framework (needed by %s)' % name)
    return notes


def bundle_executable(bundle):
    info = plistlib.load(open(os.path.join(bundle, 'Info.plist'), 'rb'))
    return os.path.join(bundle, info['CFBundleExecutable']), info


def main():
    here = os.path.dirname(os.path.abspath(__file__))
    default_dylib = os.path.join(here, '..', '.theos', '_', 'Library', 'MobileSubstrate', 'DynamicLibraries', 'Lead.dylib')
    parser = argparse.ArgumentParser(description='Inject Lead.dylib into a Telegram IPA and its notification extension.')
    parser.add_argument('ipa')
    parser.add_argument('-o', '--output')
    parser.add_argument('--dylib', default=default_dylib)
    parser.add_argument('--all-extensions', action='store_true', help='inject into every extension, not just notifications')
    parser.add_argument('--remove', action='append', default=[], metavar='NAME',
                        help='drop already injected dylibs whose path contains NAME (e.g. sideloadFixer)')
    parser.add_argument('--extra', action='append', default=[], metavar='DYLIB',
                        help='also inject this dylib into the app (repeatable)')
    parser.add_argument('--substrate', metavar='FRAMEWORK',
                        help='CydiaSubstrate.framework for extra dylibs that need it')
    args = parser.parse_args()

    if not os.path.isfile(args.dylib):
        sys.exit('Lead.dylib not found at %s (build with `make package FINALPACKAGE=1` or pass --dylib)' % args.dylib)
    output = args.output or os.path.splitext(args.ipa)[0] + '-Lead.ipa'
    work = tempfile.mkdtemp(prefix='lead-ipa-')
    try:
        subprocess.run(['unzip', '-q', os.path.abspath(args.ipa), '-d', work], check=True)
        payload = os.path.join(work, 'Payload')
        apps = [d for d in os.listdir(payload) if d.endswith('.app')]
        if len(apps) != 1:
            raise InjectError('expected one .app in Payload, found %d' % len(apps))
        app = os.path.join(payload, apps[0])

        frameworks = os.path.join(app, 'Frameworks')
        os.makedirs(frameworks, exist_ok=True)
        shutil.copy2(args.dylib, os.path.join(frameworks, 'Lead.dylib'))

        executable, _ = bundle_executable(app)
        print('%s:' % apps[0])
        for note in patch_binary(executable, '@executable_path/Frameworks/Lead.dylib', args.remove):
            print('  ' + note)
        for extra in args.extra:
            for note in add_extra(app, executable, extra, args.substrate):
                print('  ' + note)

        plugins = os.path.join(app, 'PlugIns')
        injected_nse = False
        for name in sorted(os.listdir(plugins)) if os.path.isdir(plugins) else []:
            appex = os.path.join(plugins, name)
            if not name.endswith('.appex'):
                continue
            executable, info = bundle_executable(appex)
            point = info.get('NSExtension', {}).get('NSExtensionPointIdentifier', '')
            is_nse = point == 'com.apple.usernotifications.service'
            if not (is_nse or args.all_extensions):
                continue
            print('PlugIns/%s (%s):' % (name, point or 'extension'))
            # Extensions live in <app>/PlugIns/<x>.appex/, the app's Frameworks two levels up.
            for note in patch_binary(executable, '@executable_path/../../Frameworks/Lead.dylib', args.remove):
                print('  ' + note)
            injected_nse = injected_nse or is_nse
        if not injected_nse:
            print('warning: no notification service extension found; notifications stay as they are')

        if os.path.exists(output):
            os.remove(output)
        subprocess.run(['zip', '-qry', os.path.abspath(output), 'Payload'], cwd=work, check=True)
        print('\nDone: %s\nSign it as usual, and do not add Lead.dylib in the signer again.' % output)
    except InjectError as error:
        sys.exit('error: %s' % error)
    finally:
        shutil.rmtree(work, ignore_errors=True)


if __name__ == '__main__':
    main()
