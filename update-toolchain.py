#!/usr/bin/env python


from __future__ import absolute_import, print_function, unicode_literals

import argparse
import os
import subprocess
import sys
import tempfile


try:
    # Python 2
    from pipes import quote
except ImportError:
    from shutil import quote


# -----------------------------------------------------------------------------
# Constants

PACKAGE_DIR = os.path.abspath(os.path.dirname(__file__))
BUILD_SCRIPT = os.path.join(PACKAGE_DIR, 'build-script.py')

ARGUMENT_PARSER_DESCRIPTION = """
Build and re-install SwiftSytnax for an existing toolchain.

This script calls ./build-script internally to rebuild SwiftSyntax using an
existing toolchain and install the build artifacts back to the toolchain.
"""


# -----------------------------------------------------------------------------
# Helpers

def _print(*objects, **kwargs):
    """Simple backport of the Python 3 print with flush support.
    """

    # Keyword only arguments
    sep = kwargs.get('sep', ' ')
    end = kwargs.get('end', '\n')
    file = kwargs.get('file', sys.stdout)
    flush = kwargs.get('flush', False)

    file.write(sep.join(objects) + end)

    if flush:
        file.flush()


def info(*objects):
    _print(*objects, file=sys.stdout, flush=True)


def error(*objects):
    _print('ERROR:', *objects, file=sys.stderr, flush=True)


def fatal_error(*objects):
    error(*objects)
    sys.exit(1)


def quote_command(command):
    return ' '.join([quote(arg) for arg in command])


# -----------------------------------------------------------------------------
# Build and Install

def build(swiftc_exec, build_dir):
    command = [
        BUILD_SCRIPT, '-v',
        '--release',
        '--build-dir', build_dir,
        '--swiftc-exec', swiftc_exec,
    ]

    info(quote_command(command))
    subprocess.check_call(command)


def install(swiftc_exec, build_dir, dylib_dir, module_dir):
    command = [
        BUILD_SCRIPT, '-v',
        '--release',
        '--install',
        '--build-dir', build_dir,
        '--dylib-dir', dylib_dir,
        '--swiftc-exec', swiftc_exec,
        '--swiftmodule-dir', module_dir,
    ]

    info(quote_command(command))
    subprocess.check_call(command)


# -----------------------------------------------------------------------------

def parse_args():
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawDescriptionHelpFormatter,
        description=ARGUMENT_PARSER_DESCRIPTION)

    parser.add_argument('--toolchain-dir',
                        required=True,
                        help='Directory of an existing toolchain.')

    return parser.parse_args()


def main():
    args = parse_args()

    if not os.geteuid() == 0:
        fatal_error('Re-run this script with root access!')

    build_dir = tempfile.mkdtemp()
    toolchain_usr_dir = os.path.join(args.toolchain_dir, 'usr')

    swiftc_exec = os.path.join(toolchain_usr_dir, 'bin', 'swiftc')
    dylib_dir = os.path.join(toolchain_usr_dir, 'lib', 'swift', 'macosx')
    module_dir = os.path.join(dylib_dir, 'x86_64')

    info('Using swiftc:', swiftc_exec)
    info('Using build directory:', build_dir)

    build(swiftc_exec, build_dir)
    install(swiftc_exec, build_dir, dylib_dir, module_dir)


if __name__ == '__main__':
    main()
