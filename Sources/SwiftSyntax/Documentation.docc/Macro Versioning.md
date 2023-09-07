# Updating a Macro to a New Major swift-syntax Version

Guidance of how to version macros when a new major swift-syntax version is released.

## Summary

A macro can depend on multiple versions of swift-syntax. If it is affected by source-breaking changes in swift-syntax, it can check the version of swift-syntax it is compiling against using e.g. `#if canImport(SwiftSyntax510)`.

## Detailed Explanation

All the ideas described in the following apply to all packages that depend on swift-syntax, not only macros.

For simplicity, this article assumes that 509 is the current swift-syntax version and 510 the next, but everything applies to any other major swift-syntax version update, including version jumps to e.g. 600.

Any given version macro can depend on multiple major swift-syntax versions at once. For example, if a macro supports both swift-syntax 509 and swift-syntax 510, it may declare its dependency on swift-syntax as 

```
.package(url: "https://github.com/apple/swift-syntax.git", "509.0.0"..<"511.0.0"),
```

In order to handle breaking API changes, clients can wrap uses of such APIs in conditional compilation clauses that check the version of swift-syntax it is building against. All versions of swift-syntax ≥ 509 will include an empty `SwiftSyntaxVersion509` module, swift-syntax ≥ 510 will include both a `SwiftSyntaxVersion510` and `SwiftSyntaxVersion509` module, and so on for any new releases. This allows clients to write

```swift
#if canImport(SwiftSyntax510)
// code specific to swift-syntax version >= 510
#elseif canImport(SwiftSyntax509)
// code to support swift-syntax version 509
#else
// code for swift-syntax < 509. Not needed for macros since macros require swift-syntax >= 509.
#endif
```

The `SwiftSyntax<version>` modules are empty and don’t contain any code. Their only purpose is to serve as targets for the `canImport` checks. 

## Representation of New Syntax with Old swift-syntax Versions

If a swift-syntax version is used that is older than the compiler’s version, then swift-syntax will not be able to represent the new syntactic structures (like new statements) in the source file because it doesn’t know about them.

In this case, swift-syntax will represent the unknown syntactic constructs as a mixture of unexpected syntax nodes in the `unexpected*` children of the syntax nodes. Depending on the macro’s behavior this might not pose any issues. For example, if the macro adds an completion-handler alternative to an async function, it most likely doesn’t care if some statement in the body couldn’t be parsed, since it is only interested in the signature.
