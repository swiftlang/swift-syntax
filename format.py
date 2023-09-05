#!/usr/bin/env python3

import argparse
import subprocess
from pathlib import Path
from textwrap import dedent
from typing import List


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description='''
    Format files in SwiftSyntax using swift-format. If swift-format is installed in your
    PATH or passed using --swift-format that executable is used to format the files.
    Otherwise swift-format is cloned and built by this script into /tmp
    ''')
    parser.add_argument(
        '--swift-format', default='swift-format',
        help='''
        The path to the swift-format executable.
        Looks for swift-format in PATH by default.
        ''')
    parser.add_argument(
        '--lint', action='store_true',
        help='''
        Instead of formatting in-place verify that the files are correctly formatted.
        Exit with 1 if files are not correctly formatted.
        '''
    )

    return parser.parse_args()


def clone_and_build_swiftformat() -> Path:
    """
    Clone the swift-format repository into /tmp, build it and return the path to the
    swift-format executable. This allows format.py to be fully standalone and run even
    if swift-format is not installed on your system yet.
    """
    print(dedent('''\
        swift-format was not found on your system. Cloning and building swift-format in /tmp/swift-format.

        To skip this step in the future build swift-format (https://github.com/apple/swift-format) yourself and
        - put it in your PATH or
        - pass the path to it to this script via --swift-format
        '''))  # noqa: E501
    try:
        swift_format_dir = Path('/tmp/swift-format')
        if swift_format_dir.exists():
            subprocess.check_call(['git', 'pull'], cwd=swift_format_dir)
        else:
            subprocess.check_call([
                'git', 'clone',
                'https://github.com/apple/swift-format.git'
            ], cwd=swift_format_dir.parent)
        subprocess.check_call([
            'swift', 'build',
            '--product', 'swift-format', '-c', 'release'
            ], cwd=swift_format_dir)
        bin_dir = subprocess.check_output([
            'swift', 'build', '-c', 'release',
            '--show-bin-path'
        ], encoding='utf-8', cwd=swift_format_dir)
        return Path(bin_dir.rstrip()) / 'swift-format'
    except subprocess.CalledProcessError:
        print(dedent('''
            format.py failed to build swift-format.

            Please build it yourself and pass the swift-format executable to format.py
            using the --swift-format parameter.
            '''))
        raise SystemExit(1)


def find_swiftformat(swift_format: str) -> Path:
    """
    Return a fully resolved path to the swift-format executable named or located at
    `swift_format`.
    If swift-format couldn't be found, this clones and builds swift-format.
    """
    try:
        output = subprocess.check_output(['which', swift_format], encoding='utf-8')
        return Path(output.rstrip())
    except subprocess.CalledProcessError:
        return clone_and_build_swiftformat()


def get_files_to_format() -> List[Path]:
    package_dir = Path(__file__).parent
    files_to_format = package_dir.glob('**/*.swift')

    def should_exclude(path: Path) -> bool:
        if 'lit_tests' in path.parts:
            return True
        elif 'generated' in path.parts:
            return True
        elif '/build' in path.parts:
            return True
        elif 'Inputs' in path.parts:
            return True
        elif '.build' in path.parts:
            return True
        return False

    files_to_format = [file for file in files_to_format if not should_exclude(file)]

    return files_to_format


def main() -> None:
    args = parse_args()
    swift_format = find_swiftformat(args.swift_format)
    files_to_format = get_files_to_format()

    if args.lint:
        try:
            subprocess.check_call([swift_format, 'lint', '--parallel', '--strict'] +
                                  files_to_format)
        except subprocess.CalledProcessError:
            print(dedent('''\
                The swift-syntax repo is not formatted according to the style guides.
                Run the following command to format swift-syntax

                swift-syntax/format.py --swift-format /path/to/executable/swift-format

                If the issue persists, fix any remaining issues manually and verify they
                match the swift-format style using

                swift-syntax/format.py --swift-format /path/to/executable/swift-format --lint
                '''))  # noqa: E501
            raise SystemExit(1)
    else:
        subprocess.check_call([swift_format, 'format', '--in-place', '--parallel'] +
                              files_to_format)


if __name__ == '__main__':
    main()
