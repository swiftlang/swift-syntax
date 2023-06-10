"""Convenience wrapper for swift_library targets using this repo's conventions"""

load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load(":opt_wrapper.bzl", "opt_wrapper")

def swift_syntax_library(name, deps, testonly = False):
    swift_library(
        name = name,
        srcs = native.glob(
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
