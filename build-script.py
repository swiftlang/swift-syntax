#!/usr/bin/env python


"""Utility script used to build, test and install SwiftSyntax.
"""


from __future__ import absolute_import, print_function, unicode_literals

import argparse
import collections
import os
import platform
import shlex
import subprocess
import sys
import tempfile

from copy import copy


try:
    from pipes import quote
except ImportError:
    # Python 3
    from shutil import quote


try:
    basestring
except NameError:
    # Python 3
    basestring = str


# -----------------------------------------------------------------------------
# Constants

PACKAGE_DIR = os.path.abspath(os.path.dirname(__file__))
WORKSPACE_DIR = os.path.realpath(os.path.join(PACKAGE_DIR, os.pardir))

# We have to use this name in the installed dylib so that the compiler will
# treat it as a part of stdlib to copy the dylib to the framework dir.
INSTALL_NAME = 'swiftSwiftSyntax'
INSTALL_DYLIB_NAME = 'lib{}.dylib'.format(INSTALL_NAME)

GYB_EXEC = os.path.join(WORKSPACE_DIR, 'swift', 'utils', 'gyb')
LIT_EXEC = os.path.join(WORKSPACE_DIR, 'llvm', 'utils', 'lit', 'lit.py')

INCR_TRANSFER_ROUNDTRIP_EXEC = os.path.join(
    WORKSPACE_DIR, 'swift', 'utils', 'incrparse',
    'incr_transfer_round_trip.py')


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
    """Prints a message to stderr and then flushes the output.
    """

    _print(*objects, file=sys.stdout, flush=True)


def note(*objects):
    """Prints a note to stderr and then flushes the output.
    """

    _print('NOTE:', *objects, file=sys.stdout, flush=True)


def error(*objects):
    """Prints an error message to stderr and then flushes the output.
    """

    _print('ERROR:', *objects, file=sys.stderr, flush=True)


def fatal_error(*objects):
    """Prints an error message to stdout and then exits with error code 1.
    """

    error(*objects)
    sys.exit(1)


def log_section(name):
    """Function decorator used to log a section header before running the
    wrapped function and then an ending header after.
    """

    def decorator(func):
        def wrapper(*args, **kwargs):
            info('-- {}'.format(name))
            result = func(*args, **kwargs)
            info('-- END: {}'.format(name))
            return result

        return wrapper
    return decorator


def build_swiftpm_command(swiftpm_exec,
                          products=None,
                          build_dir=None,
                          swiftc_args=None,
                          disable_sandbox=False,
                          release=False,
                          verbose=False):
    """Builds and returns a valid Swift PM command using the provided
    executable path and option combination.
    """

    command = shlex.split(swiftpm_exec)
    command += ['--package-path', PACKAGE_DIR]

    if build_dir:
        command += ['--build-path', build_dir]
    if release:
        command += ['--configuration', 'release']
    if verbose:
        command.append('--verbose')

    if disable_sandbox:
        command.append('--disable-sandbox')

    for product in products or []:
        command += ['--product', product]

    for arg in swiftc_args or []:
        command += ['-Xswiftc', arg]

    return command


# -----------------------------------------------------------------------------
# Shell Utilities

def quote_command(command):
    """Returns a quoted and escaped shell command. Commands can be strings or
    an iterable of strings.
    """

    if isinstance(command, basestring):
        return quote(command)

    if isinstance(command, collections.Iterable):
        return ' '.join(map(quote, command))

    raise TypeError('Invalid command type {}', type(command).__name__)


def check_call(command, *args, **kwargs):
    """Simple wrapper around the subprocess.check_call function which adds
    a verbose option to output the command before executing it.
    """

    if kwargs.pop('verbose', False):
        _print(quote_command(command))

    return subprocess.check_call(command, *args, **kwargs)


def mkdir_p(path):
    """Similar to the 'mkdir -p' command, this function recursively creates all
    directories in the given path if they don't already exist.
    """

    if os.path.exists(path):
        return

    os.makedirs(path)


def rsync(source, dest, archive=False, checksum=False, verbose=False):
    """Simple wrapper around the rsync command line utility.
    """

    command = ['rsync']
    if archive:
        command += ['--archive']
    if checksum:
        command += ['--checksum']

    command.append(source)
    command.append(dest)

    try:
        check_call(command, verbose=verbose)
    except subprocess.CalledProcessError:
        fatal_error('Failed to rsync {} to {}!'.format(source, dest))


# -----------------------------------------------------------------------------
# Environment Validation

MISSING_FILE_EPILOG = """
Make sure you have the main swift repo checked out next to the swift-syntax
repository. Refer to the README.md file for more information.
"""


def validate_file_exists(name, exec_path):
    """Helper function used to validate a file exists at an expected path. If
    not a fatal error is reported and the script exits.
    """

    if os.path.exists(exec_path):
        return

    fatal_error('Could not find {}\n{}'.format(name, MISSING_FILE_EPILOG))


def find_gyb():
    validate_file_exists('gyb', GYB_EXEC)


def find_lit():
    validate_file_exists('lit.py', LIT_EXEC)


def find_incr_transfer_roundtrip():
    validate_file_exists('incr_transfer_round_trip.py',
                         INCR_TRANSFER_ROUNDTRIP_EXEC)


def find_rsync():
    with open(os.devnull, 'w') as devnull:
        try:
            check_call(['rsync', '--version'], stdout=devnull, stderr=devnull)
        except subprocess.CalledProcessError:
            fatal_error('Could not find rsync.')


# -----------------------------------------------------------------------------
# Gyb Pre-process

@log_section('Templating Gyb Files')
def template_gyb_files(verbose, add_source_locations):
    """Template the .swift.gyb sources and install them in the gyb_generated
    directory. If the sources haven't changed the generated files will not be
    updated via the use of rsync's --checksum feature, which avoids unnecessary
    rebuilds.
    """

    temp_dir = tempfile.gettempdir()
    sources_dir = os.path.join(PACKAGE_DIR, 'Sources', 'SwiftSyntax')
    generated_dir = os.path.join(sources_dir, 'gyb_generated')

    mkdir_p(temp_dir)
    mkdir_p(generated_dir)

    for file in os.listdir(sources_dir):
        if not file.endswith('.gyb'):
            continue

        # Strip off the '.gyb' extension to get the name for the output file.
        output_file_name = file.rstrip('.gyb')

        gyb_command = [
            GYB_EXEC,
            os.path.join(sources_dir, file),
            '-o', os.path.join(temp_dir, output_file_name),
        ]

        # Source locations are added by default by gyb, and cleared by passing
        # `--line-directive=` (nothing following the `=`) to the generator. Our
        # flag is the reverse; we don't want them by default, only if
        # requested.
        if not add_source_locations:
            gyb_command.append('--line-directive=')

        try:
            check_call(gyb_command, verbose=verbose)
        except subprocess.CalledProcessError:
            fatal_error('Failed to template Gyb file {}'.format(file))

        # Copy the file if different from the file already present in
        # gyb_generated.
        rsync(
            source=os.path.join(temp_dir, output_file_name),
            dest=os.path.join(generated_dir, output_file_name),
            checksum=True,
            verbose=verbose)


# -----------------------------------------------------------------------------
# Build

@log_section('Building SwiftSyntax')
def build(swift_build_exec,
          swiftc_exec,
          build_dir,
          build_test_util,
          disable_sandbox=False,
          release=False,
          verbose=False):
    """Builds the SwiftSyntax dylib and optionally the lit-test-helper using
    Swift PM.
    """

    products = ['SwiftSyntax']

    # Only build lit-test-helper if we are planning to run tests
    if build_test_util:
        products.append('lit-test-helper')

    # Swift compiler needs to know the module link name.
    swiftc_args = ['-module-link-name', INSTALL_NAME]

    command = build_swiftpm_command(
        swiftpm_exec=swift_build_exec,
        products=products,
        build_dir=build_dir,
        swiftc_args=swiftc_args,
        disable_sandbox=disable_sandbox,
        release=release,
        verbose=verbose)

    env = copy(os.environ)
    env['SWIFT_EXEC'] = swiftc_exec
    env['SWIFT_SYNTAX_BUILD_SCRIPT'] = ''

    try:
        check_call(command, env=env, verbose=verbose)
    except subprocess.CalledProcessError:
        fatal_error('Failed to build SwiftSyntax')


# -----------------------------------------------------------------------------
# Test

def find_lit_test_helper_exec(swift_build_exec, build_dir, release=False):
    """Finds and returns the path to the built list-test-helper executable
    using Swift PM.
    """

    product = 'lit-test-helper'
    command = shlex.split(swift_build_exec) + [
        '--product', product,
        '--package-path', PACKAGE_DIR,
    ]

    if build_dir:
        command += ['--build-path', build_dir]
    if release:
        command += ['--configuration', 'release']

    command.append('--show-bin-path')

    bin_path = subprocess.check_output(command).strip()
    return os.path.join(bin_path, product)


@log_section('Running Lit Tests')
def run_lit_tests(swift_build_exec,
                  swiftc_exec,
                  build_dir,
                  filecheck_exec,
                  swift_syntax_test_exec,
                  release=False,
                  verbose=False):
    """Runs the Lit test suite for the build SwiftSyntax.
    """

    lit_test_helper_exec = find_lit_test_helper_exec(
        swift_build_exec=swift_build_exec,
        build_dir=build_dir,
        release=release)

    command = [
        LIT_EXEC,
        os.path.join(PACKAGE_DIR, 'lit_tests'),
    ]

    if swiftc_exec:
        command += ['--param', 'SWIFTC=' + swiftc_exec]
    if filecheck_exec:
        command += ['--param', 'FILECHECK=' + filecheck_exec]
    if lit_test_helper_exec:
        command += ['--param', 'LIT_TEST_HELPER=' + lit_test_helper_exec]
    if swift_syntax_test_exec:
        command += ['--param', 'SWIFT_SYNTAX_TEST=' + swift_syntax_test_exec]

    command += [
        '--param',
        'INCR_TRANSFER_ROUND_TRIP.PY=' + INCR_TRANSFER_ROUNDTRIP_EXEC
    ]

    # Print all failures
    command.append('--verbose')

    # Don't show all commands if verbose is not enabled
    if not verbose:
        command.append('--succinct')

    try:
        check_call(command, verbose=verbose)
    except subprocess.CalledProcessError:
        fatal_error('Lit test suite failed!')


@log_section('Running XCTest Tests')
def run_xctests(swift_test_exec, build_dir, release, swiftc_exec, verbose):
    """Runs the XCTest test suite for the built SwiftSyntax.
    """

    command = build_swiftpm_command(
        swiftpm_exec=swift_test_exec,
        build_dir=build_dir,
        release=release,
        verbose=verbose)

    env = copy(os.environ)
    if swiftc_exec:
        env['SWIFTC_EXEC'] = swiftc_exec

    try:
        check_call(command, env=env, verbose=verbose)
    except subprocess.CalledProcessError:
        fatal_error('XCTest test suite failed!')


# -----------------------------------------------------------------------------
# Install

def delete_rpath(rpath, binary, verbose=False):
    """Uses install_name_tool on Darwin systems to delete the rpath name in
    the given Mach-O binary.
    """

    if platform.system() != 'Darwin':
        fatal_error('Unable to remove RPATHs on this platform')

    command = ['install_name_tool', '-delete_rpath', rpath, binary]

    note('Removing RPATH from {}'.format(binary))
    check_call(command, verbose=verbose)


def change_rpath_id(rpath, binary, verbose=False):
    """Uses install_name_tool on Darwin systems to change the rpath name in
    the given Mach-O binary.
    """

    if platform.system() != 'Darwin':
        fatal_error('Unable to invoke install_name_tool on this platform')

    command = ['install_name_tool', '-id', rpath, binary]

    note('Changing id in {}'.format(binary))
    check_call(command, verbose=verbose)


@log_section('Installing SwiftSyntax')
def install(build_dir,
            dylib_dir,
            swiftmodule_dir,
            stdlib_rpath,
            verbose=False):
    """Installs the built SwiftSyntax dylib, swiftmodule and swiftdoc in the
    given build dir.
    """

    dylib_path = os.path.join(build_dir, 'libSwiftSyntax.dylib')
    module_path = os.path.join(build_dir, 'SwiftSyntax.swiftmodule')
    doc_path = os.path.join(build_dir, 'SwiftSyntax.swiftdoc')

    # Users should find the dylib as if it's a part of stdlib.
    dylib_rpath = os.path.join('@rpath', INSTALL_DYLIB_NAME)
    change_rpath_id(dylib_rpath, dylib_path, verbose=verbose)

    # We don't wanna hard-code the stdlib dylibs into rpath.
    delete_rpath(stdlib_rpath, dylib_path, verbose=verbose)

    install_path = os.path.join(dylib_path, INSTALL_DYLIB_NAME)
    rsync(dylib_path, install_path, archive=True, verbose=verbose)

    # Optionally install the swiftmodule file.
    if swiftmodule_dir:
        rsync(module_path, swiftmodule_dir, archive=True, verbose=verbose)
        rsync(doc_path, swiftmodule_dir, archive=True, verbose=verbose)


# -----------------------------------------------------------------------------

ARGUMENT_PARSER_DESCRIPTION = """
Build and test script for SwiftSytnax.

Build SwiftSyntax by generating all necessary files from the corresponding
.swift.gyb files first. For this, SwiftSyntax needs to be checked out alongside
the main swift repo (http://github.com/apple/swift/) in the following structure

- (containing directory)
  - swift
  - swift-syntax

It is not necessary to build the compiler project.

The build script can also drive the test suite included in the SwiftSyntax
repo. This requires a custom build of the compiler project since it accesses
test utilities that are not shipped as part of the toolchains. See the "Test"
section for arguments that need to be specified for this.
"""


def parse_args():
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawDescriptionHelpFormatter,
        description=ARGUMENT_PARSER_DESCRIPTION)

    # -------------------------------------------------------------------------
    parser.add_argument('-v', '--verbose',
                        action='store_true',
                        help='Enable extensive logging of executed steps.')

    parser.add_argument('--swiftc-exec',
                        default='swiftc',
                        help='Path to the swift executable. If not specified '
                             'the swiftc exeuctable will be inferred from '
                             'PATH.')

    # Used by both the build/test and install modes
    parser.add_argument('--build-dir',
                        help='Swift PM build directory. If omitted a '
                             'directory named ".build" will be put in the '
                             'swift-syntax directory.')

    # -------------------------------------------------------------------------
    build_group = parser.add_argument_group('Build')

    build_group.add_argument('-r', '--release',
                             action='store_true',
                             help='Build as a release build.')

    build_group.add_argument('--swift-build-exec',
                             default='swift build',
                             help='Path to the swift-build executable that '
                                  'is used to build SwiftPM projects. If '
                                  'not specified the the "swift build" '
                                  'command will be used.')

    build_group.add_argument('--add-source-locations',
                             action='store_true',
                             help='Insert "###sourceLocation" comments in '
                                  'generated code for line-directive.')

    build_group.add_argument('--disable-sandbox',
                             action='store_true',
                             help='Disable Swift PM sandboxes when building.')

    # -------------------------------------------------------------------------
    test_group = parser.add_argument_group('Test')

    test_group.add_argument('-t', '--test',
                            action='store_true',
                            help='Run tests')

    test_group.add_argument('--swift-test-exec',
                            default='swift test',
                            help='Path to the swift-test executable that '
                                 'is used to test SwiftPM projects. If not '
                                 'specified then the "swift test" command '
                                 'will be used.')

    test_group.add_argument('--swift-syntax-test-exec',
                            help='Path to the swift-syntax-test executable '
                                 'that was built from the main Swift repo. '
                                 'If not specified, it will be looked up '
                                 'from PATH.')

    test_group.add_argument('--filecheck-exec',
                            help='Path to the FileCheck executable that was '
                                 'built as part of the LLVM repository. If '
                                 'not specified, it will be looked up from '
                                 'PATH.')

    # -------------------------------------------------------------------------
    install_group = parser.add_argument_group('Install')

    install_group.add_argument('--install',
                               action='store_true',
                               help='Install the build artifact to a '
                                    'specified toolchain directory.')

    install_group.add_argument('--dylib-dir',
                               help='The directory to where the .dylib should '
                                    'be installed.')

    install_group.add_argument('--swiftmodule-dir',
                               help='The directory to where the .swiftmodule '
                                    'should be installed.')

    return parser.parse_args()


def main():
    args = parse_args()

    # -------------------------------------------------------------------------
    # Install

    if args.install:
        if not args.build_dir:
            fatal_error('Must specify build directory to copy from')
        if not args.dylib_dir:
            fatal_error('Must specify directory to install')

        find_rsync()

        if args.release:
            build_dir = os.path.join(args.build_dir, 'release')
        else:
            # Will or should we ever install non-release builds?
            build_dir = os.path.join(args.build_dir, 'debug')

        # Ensure the dylib install dir exists.
        mkdir_p(args.dylib_dir)

        swiftc_dir = os.path.dirname(args.swiftc_exec)
        stdlib_rpath = os.path.realpath(
            os.path.join(swiftc_dir, os.pardir, 'lib', 'swift', 'macosx'))

        install(
            build_dir=build_dir,
            dylib_dir=args.dylib_dir,
            swiftmodule_dir=args.swiftmodule_dir,
            stdlib_rpath=stdlib_rpath)

        sys.exit(0)

    # -------------------------------------------------------------------------
    # Validate Build Environment

    find_gyb()
    find_rsync()

    if args.test:
        find_lit()
        find_incr_transfer_roundtrip()

    # -------------------------------------------------------------------------
    # Build and Test

    template_gyb_files(
        add_source_locations=args.add_source_locations,
        verbose=args.verbose)

    build(
        swift_build_exec=args.swift_build_exec,
        swiftc_exec=args.swiftc_exec,
        build_dir=args.build_dir,
        build_test_util=args.test,
        disable_sandbox=args.disable_sandbox,
        release=args.release,
        verbose=args.verbose)

    if args.test:
        run_lit_tests(
            swift_build_exec=args.swift_build_exec,
            build_dir=args.build_dir,
            release=args.release,
            swiftc_exec=args.swiftc_exec,
            filecheck_exec=args.filecheck_exec,
            swift_syntax_test_exec=args.swift_syntax_test_exec,
            verbose=args.verbose)

        run_xctests(
            swift_test_exec=args.swift_test_exec,
            build_dir=args.build_dir,
            release=args.release,
            swiftc_exec=args.swiftc_exec,
            verbose=args.verbose)


if __name__ == '__main__':
    main()
