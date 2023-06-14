#!/usr/bin/env python3

import argparse
import os
import platform
import subprocess
import sys
import tempfile
from typing import Dict, List, Optional


# -----------------------------------------------------------------------------
# Constants

PACKAGE_DIR = os.path.dirname(os.path.realpath(__file__))
WORKSPACE_DIR = os.path.dirname(PACKAGE_DIR)
EXAMPLES_DIR = os.path.join(PACKAGE_DIR, "Examples")
SOURCES_DIR = os.path.join(PACKAGE_DIR, "Sources")
SWIFTIDEUTILS_DIR = os.path.join(SOURCES_DIR, "SwiftIDEUtils")
SWIFTSYNTAX_DIR = os.path.join(SOURCES_DIR, "SwiftSyntax")
SWIFTSYNTAX_DOCUMENTATION_DIR = \
        os.path.join(SWIFTSYNTAX_DIR, "Documentation.docc")
SWIFTBASICFORMAT_DIR = os.path.join(SOURCES_DIR, "SwiftBasicFormat")
SWIFTSYNTAXBUILDER_DIR = os.path.join(SOURCES_DIR, "SwiftSyntaxBuilder")
SWIFTPARSER_DIR = os.path.join(SOURCES_DIR, "SwiftParser")

CODE_GENERATION_DIR = os.path.join(PACKAGE_DIR, "CodeGeneration")
SYNTAXSUPPORT_DIR = \
        os.path.join(CODE_GENERATION_DIR, "Sources", "SyntaxSupport")

LLVM_DIR = os.path.join(WORKSPACE_DIR, "llvm-project", "llvm")
SWIFT_DIR = os.path.join(WORKSPACE_DIR, "swift")

INCR_TRANSFER_ROUNDTRIP_EXEC = os.path.join(
    PACKAGE_DIR, "utils", "incrparse", "incr_transfer_round_trip.py"
)

LIT_EXEC = os.path.join(LLVM_DIR, "utils", "lit", "lit.py")

GROUP_INFO_PATH = os.path.join(PACKAGE_DIR, "utils", "group.json")


def fail_for_called_process_error(
    succinct_description: str,
    error: subprocess.CalledProcessError
) -> None:
    printerr(f"FAIL: {succinct_description}")
    printerr(f"Executing: {escapeCmd(error.cmd)}")
    printerr(error.output)
    raise SystemExit(1)


# -----------------------------------------------------------------------------
# Xcode Projects Generation


def xcode_gen(config: str) -> None:
    print("** Generate SwiftSyntax as an Xcode project **")
    os.chdir(PACKAGE_DIR)
    swiftpm_call = ["swift", "package", "generate-xcodeproj"]
    if config:
        swiftpm_call.extend(["--xcconfig-overrides", config])
    check_call(swiftpm_call)


# -----------------------------------------------------------------------------
# Helpers


def printerr(message: str) -> None:
    print(message, file=sys.stderr)


def note(message: str) -> None:
    print("--- %s: note: %s" % (os.path.basename(sys.argv[0]), message))
    sys.stdout.flush()


def fatal_error(message: str) -> None:
    printerr(message)
    raise SystemExit(1)


def escapeCmdArg(arg: str) -> str:
    if '"' in arg or " " in arg:
        return '"%s"' % arg.replace('"', '\\"')
    else:
        return arg


def escapeCmd(cmd: List[str]) -> str:
    return " ".join([escapeCmdArg(arg) for arg in cmd])


def call(cmd: List[str], env: Dict[str, str] = dict(os.environ),
         stdout: Optional[int] = None, stderr: Optional[int] = subprocess.STDOUT,
         verbose: bool = False) -> int:
    if verbose:
        print(escapeCmd(cmd))
    process = subprocess.Popen(cmd, env=env, stdout=stdout, stderr=stderr)
    process.wait()

    return process.returncode


def check_call(cmd: List[str], cwd: Optional[str] = None,
               env: Dict[str, str] = dict(os.environ), verbose: bool = False) -> None:
    if verbose:
        print(escapeCmd(cmd))
    subprocess.check_call(cmd, cwd=cwd, env=env, stderr=subprocess.STDOUT)


def realpath(path: Optional[str]) -> Optional[str]:
    if path is None:
        return None
    return os.path.realpath(path)


# -----------------------------------------------------------------------------
# Generating Files


def run_code_generation(
    source_dir: str,
    toolchain: str,
    verbose: bool
) -> None:
    print("** Running code generation **")

    swift_exec = os.path.join(toolchain, "bin", "swift")

    swiftpm_call = [
        swift_exec, 'run',
        "--package-path", CODE_GENERATION_DIR,
        "generate-swiftsyntax", source_dir
    ]
    
    if verbose:
        swiftpm_call.extend(["--verbose"])

    env = dict(os.environ)
    env["SWIFT_BUILD_SCRIPT_ENVIRONMENT"] = "1"
    env["SWIFTSYNTAX_ENABLE_RAWSYNTAX_VALIDATION"] = "1"
    check_call(swiftpm_call, env=env, verbose=verbose)


# -----------------------------------------------------------------------------
# Building SwiftSyntax


def get_swiftpm_invocation(
    toolchain: str, action: str, package_dir: str, build_dir: Optional[str],
    multiroot_data_file: Optional[str], release: bool
) -> List[str]:
    swift_exec = os.path.join(toolchain, "bin", "swift")

    swiftpm_call = [swift_exec, action]
    swiftpm_call.extend(["--package-path", package_dir])
    if platform.system() != "Darwin":
        swiftpm_call.extend(["--enable-test-discovery"])
    if release:
        swiftpm_call.extend(["--configuration", "release"])
    if build_dir:
        swiftpm_call.extend(["--scratch-path", build_dir])
    if multiroot_data_file:
        swiftpm_call.extend(["--multiroot-data-file", multiroot_data_file])

    return swiftpm_call


class Builder(object):
    verbose: bool
    toolchain: str
    build_dir: Optional[str]
    multiroot_data_file: Optional[str]
    release: bool
    enable_rawsyntax_validation: bool
    enable_test_fuzzing: bool
    disable_sandbox: bool

    def __init__(
        self,
        toolchain: str,
        build_dir: Optional[str],
        multiroot_data_file: Optional[str],
        release: bool,
        enable_rawsyntax_validation: bool,
        enable_test_fuzzing: bool,
        verbose: bool,
        disable_sandbox: bool = False,
    ) -> None:
        self.build_dir = build_dir
        self.multiroot_data_file = multiroot_data_file
        self.release = release
        self.enable_rawsyntax_validation = enable_rawsyntax_validation
        self.enable_test_fuzzing = enable_test_fuzzing
        self.disable_sandbox = disable_sandbox
        self.verbose = verbose
        self.toolchain = toolchain

    def __get_swiftpm_invocation(self, package_dir: str) -> List[str]:
        invocation = get_swiftpm_invocation(
            self.toolchain,
            "build",
            package_dir,
            self.build_dir,
            self.multiroot_data_file,
            self.release
        )
        if self.disable_sandbox:
            invocation.append("--disable-sandbox")
        if self.verbose:
            invocation.append("--verbose")
        return invocation

    def buildProduct(self, product_name: str) -> None:
        print("** Building product " + product_name + " **")
        self.__build(PACKAGE_DIR, product_name, is_product=True)

    def buildTarget(self, target_name: str) -> None:
        print("** Building target " + target_name + " **")
        self.__build(PACKAGE_DIR, target_name, is_product=False)

    def buildExample(self, example_name: str) -> None:
        print("** Building example " + example_name + " **")
        self.__build(EXAMPLES_DIR, example_name, is_product=True)

    def __build(self, package_dir: str, name: str, is_product: bool) -> None:
        command = list(self.__get_swiftpm_invocation(package_dir))
        command.extend(["--product" if is_product else "--target", name])

        env = dict(os.environ)
        env["SWIFT_BUILD_SCRIPT_ENVIRONMENT"] = "1"
        if self.enable_rawsyntax_validation:
            env["SWIFTSYNTAX_ENABLE_RAWSYNTAX_VALIDATION"] = "1"
        if self.enable_test_fuzzing:
            env["SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION"] = "1"
        # Tell other projects in the unified build to use local dependencies
        env["SWIFTCI_USE_LOCAL_DEPS"] = "1"
        env["SWIFT_SYNTAX_PARSER_LIB_SEARCH_PATH"] = \
            os.path.join(self.toolchain, "lib", "swift", "macosx")
        check_call(command, env=env, verbose=self.verbose)


# -----------------------------------------------------------------------------
# Testing


def verify_code_generated_files(
    toolchain: str, verbose: bool
) -> None:
    self_temp_dir = tempfile.mkdtemp()

    try:
        run_code_generation(
            source_dir=self_temp_dir,
            toolchain=toolchain,
            verbose=verbose
        )
    except subprocess.CalledProcessError as e:
        fail_for_called_process_error(
            "Source generation using SwiftSyntaxBuilder failed",
            e
        )

    print("** Verifing code generated files **")

    for module in ["SwiftBasicFormat", "SwiftIDEUtils", \
      "SwiftParser", "SwiftSyntax", "SwiftSyntaxBuilder"]:
      self_generated_dir = os.path.join(self_temp_dir, module, "generated")
      user_generated_dir = os.path.join(SOURCES_DIR, module, "generated")
      check_generated_files_match(self_generated_dir, user_generated_dir)
    

def check_generated_files_match(self_generated_dir: str,
                                user_generated_dir: str) -> None:
    command = [
        "diff",
        "--recursive",
        "--exclude",
        ".*",  # Exclude dot files like .DS_Store
        "--context=0",
        self_generated_dir,
        user_generated_dir,
    ]
    check_call(command)


def run_tests(
    toolchain: str,
    build_dir: Optional[str],
    multiroot_data_file: Optional[str],
    release: bool,
    enable_rawsyntax_validation: bool,
    enable_test_fuzzing: bool,
    filecheck_exec: Optional[str], 
    skip_lit_tests: bool, 
    verbose: bool
) -> None:
    print("** Running SwiftSyntax Tests **")

    if not skip_lit_tests:
        run_lit_tests(
            toolchain=toolchain,
            build_dir=build_dir,
            release=release,
            filecheck_exec=filecheck_exec,
            verbose=verbose,
        )

    run_xctests(
        toolchain=toolchain,
        build_dir=build_dir,
        multiroot_data_file=multiroot_data_file,
        release=release,
        enable_rawsyntax_validation=enable_rawsyntax_validation,
        enable_test_fuzzing=enable_test_fuzzing,
        verbose=verbose,
    )

# -----------------------------------------------------------------------------
# Lit Tests


def check_lit_exec() -> None:
    if not os.path.exists(LIT_EXEC):
        fatal_error(
            """
Error: Could not find lit.py.
Looking at '%s'.

Make sure you have the llvm repo checked out next to the swift-syntax repo.
Refer to README.md for more information.
"""
            % LIT_EXEC
        )


def check_incr_transfer_roundtrip_exec() -> None:
    if not os.path.exists(INCR_TRANSFER_ROUNDTRIP_EXEC):
        fatal_error(
            """
Error: Could not find incr_transfer_round_trip.py.

Make sure you have the main swift repo checked out next to the swift-syntax
repo.
Refer to README.md for more information.
"""
        )


def find_swiftpm_bin_path(
    package_dir: str, toolchain: str, build_dir: Optional[str], release: bool
) -> str:
    swiftpm_call = get_swiftpm_invocation(
        toolchain=toolchain,
        action="build",
        package_dir=package_dir,
        build_dir=build_dir,
        multiroot_data_file=None,
        release=release,
    )
    swiftpm_call.extend(["--show-bin-path"])

    bin_dir = subprocess.check_output(swiftpm_call)
    return bin_dir.strip().decode('utf-8')


def find_product_bin_path(
    toolchain: str, build_dir: Optional[str], release: bool
) -> str:
    return find_swiftpm_bin_path(PACKAGE_DIR, toolchain, build_dir, release)


def find_examples_bin_path(
    toolchain: str, build_dir: Optional[str], release: bool
) -> str:
    return find_swiftpm_bin_path(EXAMPLES_DIR, toolchain, build_dir, release)


def run_lit_tests(toolchain: str, build_dir: Optional[str], release: bool,
                  filecheck_exec: Optional[str], verbose: bool) -> None:
    print("** Running lit-based tests **")

    check_lit_exec()
    check_incr_transfer_roundtrip_exec()

    product_bin_path = find_product_bin_path(
        toolchain=toolchain, build_dir=build_dir, release=release)
    examples_bin_path = find_examples_bin_path(
        toolchain=toolchain, build_dir=build_dir, release=release)

    lit_test_helper_exec = os.path.join(product_bin_path, "lit-test-helper")

    lit_call = ["python3", LIT_EXEC]
    lit_call.append(os.path.join(PACKAGE_DIR, "lit_tests"))

    if filecheck_exec:
        lit_call.extend(["--param", "FILECHECK=" + filecheck_exec])
    if lit_test_helper_exec:
        lit_call.extend(["--param", "LIT_TEST_HELPER=" + lit_test_helper_exec])
    lit_call.extend(
        ["--param", "INCR_TRANSFER_ROUND_TRIP.PY=" + INCR_TRANSFER_ROUNDTRIP_EXEC]
    )
    lit_call.extend(["--param", "EXAMPLES_BIN_PATH=" + examples_bin_path])
    lit_call.extend(["--param", "TOOLCHAIN=" + toolchain])

    # Print all failures
    lit_call.extend(["--verbose"])
    # Don't show all commands if verbose is not enabled
    if not verbose:
        lit_call.extend(["--succinct"])
    check_call(lit_call, verbose=verbose)


# -----------------------------------------------------------------------------
# XCTest Tests


def run_xctests(
    toolchain: str, 
    build_dir: Optional[str],
    multiroot_data_file: Optional[str], 
    release: bool,
    enable_rawsyntax_validation: bool,
    enable_test_fuzzing: bool,
    verbose: bool
) -> None:
    print("** Running XCTests **")
    swiftpm_call = get_swiftpm_invocation(
        toolchain=toolchain,
        action="test",
        package_dir=PACKAGE_DIR,
        build_dir=build_dir,
        multiroot_data_file=multiroot_data_file,
        release=release,
    )

    if verbose:
        swiftpm_call.extend(["--verbose"])

    swiftpm_call.extend(["--test-product", "swift-syntaxPackageTests"])

    env = dict(os.environ)
    env["SWIFT_BUILD_SCRIPT_ENVIRONMENT"] = "1"
    if enable_rawsyntax_validation:
        env["SWIFTSYNTAX_ENABLE_RAWSYNTAX_VALIDATION"] = "1"
    if enable_test_fuzzing:
        env["SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION"] = "1"
    # Tell other projects in the unified build to use local dependencies
    env["SWIFTCI_USE_LOCAL_DEPS"] = "1"
    env["SWIFT_SYNTAX_PARSER_LIB_SEARCH_PATH"] = \
        os.path.join(toolchain, "lib", "swift", "macosx")
    check_call(swiftpm_call, env=env, verbose=verbose)

# -----------------------------------------------------------------------------
# Arugment Parsing functions


def generate_xcodeproj(args: argparse.Namespace) -> None:
    xcode_gen(config=args.xcconfig_path)


def generate_source_code_command(args: argparse.Namespace) -> None:
    try:
        run_code_generation(
            source_dir=SOURCES_DIR,
            toolchain=args.toolchain,
            verbose=args.verbose
        )
    except subprocess.CalledProcessError as e:
        fail_for_called_process_error(
            "Source generation using SwiftSyntaxBuilder failed", e)


def verify_source_code_command(args: argparse.Namespace) -> None:
    try:
        verify_code_generated_files(
            toolchain=args.toolchain,
            verbose=args.verbose,
        )
    except subprocess.CalledProcessError:
        printerr(
            "FAIL: code-generated files committed to repository do " +
            "not match generated ones. Please re-generate the " +
            "code-generated-files using the following command, open a PR to the " +
            "SwiftSyntax project and merge it alongside the main PR." +
            "$ swift-syntax/build-script.py generate-source-code " +
            "--toolchain /path/to/toolchain.xctoolchain/usr"
        )
        raise SystemExit(1)


def build_command(args: argparse.Namespace) -> None:
    try:
        builder = Builder(
            toolchain=realpath(args.toolchain), # pyright: ignore
            build_dir=realpath(args.build_dir),
            multiroot_data_file=args.multiroot_data_file,
            release=args.release,
            enable_rawsyntax_validation=args.enable_rawsyntax_validation,
            enable_test_fuzzing=args.enable_test_fuzzing,
            verbose=args.verbose,
            disable_sandbox=args.disable_sandbox,
        )
        builder.buildTarget("SwiftSyntax-all")

        # Build examples
        builder.buildExample("AddOneToIntegerLiterals")
        builder.buildExample("CodeGenerationUsingSwiftSyntaxBuilder")
    except subprocess.CalledProcessError as e:
        fail_for_called_process_error("Building SwiftSyntax failed", e)


def test_command(args: argparse.Namespace) -> None:
    try:
        builder = Builder(
            toolchain=realpath(args.toolchain), # pyright: ignore
            build_dir=realpath(args.build_dir),
            multiroot_data_file=args.multiroot_data_file,
            release=args.release,
            enable_rawsyntax_validation=args.enable_rawsyntax_validation,
            enable_test_fuzzing=args.enable_test_fuzzing,
            verbose=args.verbose,
            disable_sandbox=args.disable_sandbox,
        )

        builder.buildProduct("lit-test-helper")
        builder.buildExample("ExamplePlugin")

        run_tests(
            toolchain=realpath(args.toolchain), # pyright: ignore
            build_dir=realpath(args.build_dir),
            multiroot_data_file=args.multiroot_data_file,
            release=args.release,
            enable_rawsyntax_validation=args.enable_rawsyntax_validation,
            enable_test_fuzzing=args.enable_test_fuzzing,
            filecheck_exec=realpath(args.filecheck_exec),
            skip_lit_tests=args.skip_lit_tests,
            verbose=args.verbose,
        )
        print("** All tests passed **")
    except subprocess.CalledProcessError as e:
        fail_for_called_process_error("Running tests failed", e)


# -----------------------------------------------------------------------------
# Arugment Parsing

_DESCRIPTION = """
Build and test script for SwiftSyntax.

The build script can also drive the test suite included in the SwiftSyntax
repo. This requires a custom build of the compiler project since it accesses
test utilities that are not shipped as part of the toolchains. See the Testing
section for arguments that need to be specified for this.
"""


def parse_args() -> argparse.Namespace:
    def add_default_build_arguments(parser: argparse.ArgumentParser) -> None:
        parser.add_argument(
            "-r", "--release", action="store_true", help="Build in release mode."
        )

        parser.add_argument(
            "--build-dir",
            default=None,
            help="""
            The directory in which build products shall be put. If omitted
            a directory named ".build" will be put in the swift-syntax
            directory.
            """,
        )

        parser.add_argument(
            "--disable-sandbox",
            action="store_true",
            help="Disable sandboxes when building with SwiftPM",
        )

        parser.add_argument(
            "--multiroot-data-file",
            help="""
            Path to an Xcode workspace to create a unified build of SwiftSyntax with
            other projects.
            """,
        )

        parser.add_argument(
            "--enable-rawsyntax-validation",
            action="store_true",
            help="""
            When constructing RawSyntax nodes validate that their layout matches that
            defined in `CodeGeneration` and that TokenSyntax nodes have a `tokenKind`
            matching the ones specified in `CodeGeneration`.
            """
        )

        parser.add_argument(
            "--enable-test-fuzzing",
            action="store_true",
            help="""
            For each `assertParse` test, perform mutations of the test case based on
            alternate token choices that the parser checks, validating that there are
            no round-trip or assertion failures.
            """
        )

        parser.add_argument(
            "--toolchain",
            required=True,
            help="The path to the toolchain that shall be used to build SwiftSyntax.",
        )

        parser.add_argument(
            "-v", "--verbose", action="store_true", help="Enable verbose logging."
        )

    def add_generate_source_code_args(parser: argparse.ArgumentParser) -> None:
            parser.add_argument(
                "--toolchain",
                required=True,
                help="The path to the toolchain that shall be used to build SwiftSyntax.",
            )

            parser.add_argument(
                "-v", "--verbose", action="store_true", help="Enable verbose logging."
            )

    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawDescriptionHelpFormatter, description=_DESCRIPTION
    )

    # -------------------------------------------------------------------------
    # Shared arguments

    sub_parsers = parser.add_subparsers()

    # -------------------------------------------------------------------------
    generate_xcodeproj_parser = sub_parsers.add_parser(
        "generate-xcodeproj",
        help="Generate an Xcode project for SwiftSyntax."
    )
    generate_xcodeproj_parser.set_defaults(func=generate_xcodeproj)

    generate_xcodeproj_parser.add_argument(
        "--xcconfig-path",
        help="The path to an xcconfig file for generating Xcode projct.",
    )

    generate_xcodeproj_parser.add_argument(
        "-v", "--verbose", action="store_true", help="Enable verbose logging."
    )

    # -------------------------------------------------------------------------
    generate_source_code_parser = sub_parsers.add_parser("generate-source-code")
    generate_source_code_parser.set_defaults(func=generate_source_code_command)
    
    add_generate_source_code_args(generate_source_code_parser)

    generate_source_code_parser.add_argument(
        "--add-source-locations",
        action="store_true",
        help="""
        Insert ###sourceLocation comments in generated code for line-directive.
        """,
    )

    # -------------------------------------------------------------------------
    build_parser = sub_parsers.add_parser("build")
    build_parser.set_defaults(func=build_command)

    add_default_build_arguments(build_parser)

    # -------------------------------------------------------------------------
    test_parser = sub_parsers.add_parser("test")
    test_parser.set_defaults(func=test_command)

    add_default_build_arguments(test_parser)

    test_parser.add_argument(
        "--skip-lit-tests", action="store_true",
        help="Don't run lit-based tests"
    )

    test_parser.add_argument(
        "--filecheck-exec",
        default=None,
        help="""
        Path to the FileCheck executable that was built as part of the LLVM repository.
        If not specified, it will be looked up from PATH.
        """,
    )

    # -------------------------------------------------------------------------
    verify_source_code_parser = sub_parsers.add_parser("verify-source-code")
    verify_source_code_parser.set_defaults(func=verify_source_code_command)
    
    add_generate_source_code_args(verify_source_code_parser)

    return parser.parse_args()


# -----------------------------------------------------------------------------


def main() -> None:
    args = parse_args()
    args.func(args)


if __name__ == "__main__":
    main()
