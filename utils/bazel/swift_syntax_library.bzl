"""Convenience wrapper for swift_library targets using this repo's conventions"""

load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library", "swift_test")
load(":opt_wrapper.bzl", "opt_wrapper")

def swift_syntax_library(name, deps, srcs = None, testonly = False):
    swift_library(
        name = name,
        srcs = srcs or native.glob(
            ["Sources/{}/**/*.swift".format(name)],
            exclude = ["**/*.docc/**"],
            allow_empty = False,
        ),
        module_name = name,
        deps = deps,
        testonly = testonly,
    )

    opt_wrapper(
        name = name + "_opt",
        dep = name,
        testonly = testonly,
    )

def swift_syntax_test(name, deps):
    srcs = native.glob(
        ["Tests/{}/**/*.swift".format(name)],
        # These tests load source files they don't have access to in the iOS test bundle with bazel.
        exclude = ["**/StringLiteralRepresentedLiteralValueTests.swift"],
        allow_empty = False,
    )

    swift_test(
        name = name,
        srcs = srcs,
        module_name = name,
        deps = deps,
        testonly = True,
        data = srcs,
    )

    swift_library(
        name = name + ".library",
        srcs = srcs,
        module_name = name,
        tags = ["manual"],
        deps = deps,
        testonly = True,
    )

    ios_unit_test(
        name = name + ".ios",
        deps = [name + ".library"],
        # Keep in sync with Package.swift
        minimum_os_version = "13.0",
        tags = ["exclusive"],
        runner = "//:ios_test_runner",
    )
