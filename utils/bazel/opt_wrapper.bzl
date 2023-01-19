"""
A rule for forcing all dependent targets to be built in the opt configuration

This is useful when you're using 'bazel run' with a target, but still want the
benefits of compiler optimizations.
"""

load("@build_bazel_rules_swift//swift:swift.bzl", "SwiftInfo")

def _force_opt_impl(settings, _attr):
    return {
        "//command_line_option:compilation_mode": "opt",
        "//command_line_option:features": settings["//command_line_option:features"] + [
            "-swift.opt_uses_osize",
            "swift.opt_uses_wmo",
        ],
    }

_force_opt = transition(
    implementation = _force_opt_impl,
    inputs = [
        "//command_line_option:features",
    ],
    outputs = [
        "//command_line_option:compilation_mode",
        "//command_line_option:features",
    ],
)

def _impl(ctx):
    dep = ctx.attr.dep[0]
    return [
        dep[CcInfo],
        dep[DefaultInfo],
        dep[SwiftInfo],
    ]

opt_wrapper = rule(
    implementation = _impl,
    attrs = {
        "dep": attr.label(cfg = _force_opt, mandatory = True),
        "_allowlist_function_transition": attr.label(
            default = "@bazel_tools//tools/allowlists/function_transition_allowlist",
        ),
    },
)
