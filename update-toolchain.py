#!/usr/bin/env python
from __future__ import print_function

import argparse
import os
import subprocess
import sys
import tempfile
import errno
import platform
import shutil

BUILD_SCRIPT = os.path.dirname(os.path.abspath(__file__)) + '/build-script.py'

def printerr(message):
    print(message, file=sys.stderr)

def note(message):
    print("--- %s: note: %s" % (os.path.basename(sys.argv[0]), message))
    sys.stdout.flush()

def fatal_error(message):
    printerr(message)
    sys.exit(1)

def escapeCmdArg(arg):
    if '"' in arg or ' ' in arg:
        return '"%s"' % arg.replace('"', '\\"')
    else:
        return arg

def check_call(cmd, env=os.environ):
    print(' '.join([escapeCmdArg(arg) for arg in cmd]))
    return subprocess.check_call(cmd, env=env, stderr=subprocess.STDOUT)

def build(swiftc_exec, build_dir):
    check_call([BUILD_SCRIPT, '--release', '--swiftc-exec', swiftc_exec,
        '--build-dir', build_dir, '-v'])

def install(swiftc_exec, build_dir, dylib_dir, module_dir):
    check_call([BUILD_SCRIPT, '--release', '--install', '--swiftc-exec',
        swiftc_exec, '--dylib-dir', dylib_dir, '--swiftmodule-dir', module_dir,
        '--build-dir', build_dir, '-v'])

def main():
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawDescriptionHelpFormatter,
        description='''
Build and re-install SwiftSytnax for an existing toolchain.

This script calls ./build-script internally to rebuild SwiftSyntax using an
existing toolchain and install the build artifacts back to the toolchain.
''')

    basic_group = parser.add_argument_group('Basic')

    basic_group.add_argument('--toolchain-dir', default=None, help='''
        Directory of an existing toolchain.
        ''')

    args = parser.parse_args(sys.argv[1:])
    if not args.toolchain_dir:
        fatal_error("Need to specify --toolchain-dir")
    if not os.geteuid() == 0:
        fatal_error("\n!!!!!!!!Run this script with root access!!!!!!!!\n")

    build_dir = tempfile.mkdtemp()
    swiftc_exec = args.toolchain_dir + '/usr/bin/swiftc'
    dylib_dir = args.toolchain_dir + '/usr/lib/swift/macosx'
    module_dir = args.toolchain_dir + '/usr/lib/swift/macosx/x86_64'
    print('Using swiftc: ' + swiftc_exec)
    print('Using build directory: ' + build_dir)
    build(swiftc_exec=swiftc_exec, build_dir=build_dir)
    install(swiftc_exec=swiftc_exec, build_dir=build_dir, dylib_dir=dylib_dir,
        module_dir=module_dir)

if __name__ == '__main__':
    main()