# Updating a Macro to a New Major swift-syntax Version

Guidance of how to version macros when a new major swift-syntax version is released.

## Summary

Update the minor version of a macro when updating its swift-syntax version dependency.

## Detailed Explanation

All the ideas described in the following apply to all packages that depend on swift-syntax, not only macros.

For simplicity, this article assumes that `509` is the current swift-syntax version and `510` the next, but everything applies to any other major swift-syntax version update, including version jumps to `600`.

When starting to write a macro, no special considerations need to be made with regard to versioning. Depending on swift-syntax as with `from: "509.0.0"` will make sure that the macro receives any bug fix updates to swift-syntax 509. For example, a macro depending on swift-syntax 509 might be released as version 1.0, 1.2, 2.0, …

When swift-syntax releases version 510, the macro should release a new minor release in which it updates the swift-syntax dependency to `from: "510.0.0"`. For the sake of this example, let’s assume that the macro raises its version from 1.2 to 1.3 during this step.

Any client package that depends on the macro using an `from: "1.0"` and doesn’t have any other transitive dependencies on swift-syntax will automatically receive version `1.3` of the macro when updating the package dependencies using `swift package update` or Xcode’s *Update to Latest Package Versions* command.

Should a client depend on another macro, which hasn’t released a new version that depends on swift-syntax 510 yet, then SwiftPM will continue to select version 1.2 for the macro. In order for the client to update to version 1.3 of the macro, all macros need to release a version that is compatible with swift-syntax 510. The macro can continue to deliver updates for those clients by creating patch releases such as 1.2.1.

It is possible to mix-and-match swift-syntax and Swift compiler versions, i.e. swift-syntax 509 will also work with a Swift 5.10 compiler and a Swift 5.9 compiler works with swift-syntax 510 because swift-syntax is just an ordinary package dependency.

## Representation of New Syntax with Old swift-syntax Versions

If a swift-syntax verison is used that is older than the compiler’s version, then swift-syntax will not be able to represent the new syntactic structures (like new statements) in the source file because it doesn’t know about them.

In this case, swift-syntax will represent the unknown syntactic constructs as a mixture of unexpected syntax nodes in the `unexpected*` children of the syntax nodes. Depending on the macro’s behavior this might not pose any issues. For example, if the macro adds an completion-handler alternative to an async function, it most likely doesn’t care if some statement in the body couldn’t be parsed, since it is only interested in the signature.
