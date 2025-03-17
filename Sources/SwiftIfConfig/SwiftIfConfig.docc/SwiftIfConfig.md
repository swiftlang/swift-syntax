# SwiftIfConfig

A library to evaluate `#if` conditionals within a Swift syntax tree.

## Overview

Swift provides the ability to conditionally compile parts of a source file based on various build-time conditions, including information about the target (operating system, processor architecture, environment), information about the compiler (version, supported attributes and features), and user-supplied conditions specified as part of the build (e.g., `DEBUG`), which we collectively refer to as the *build configuration*. These conditions can occur within a `#if` in the source code, e.g.,

```swift
func f() {
#if DEBUG
  log("called f")
#endif

#if os(Linux)
  // use Linux API
#elseif os(iOS) || os(macOS)
  // use iOS/macOS API
#else
  #error("unsupported platform")
#endif
}
```

The syntax tree and its parser do not reason about the build configuration. Rather, the syntax tree produced by parsing this code will include `IfConfigDeclSyntax` nodes wherever there is a `#if`, and each such node contains a list of clauses, each with a condition to check (e.g., `os(Linux)`) and a list of syntax nodes that are conditionally part of the program. Therefore, the syntax tree captures all the information needed to process the source file for any build configuration.

The `SwiftIfConfig` library provides utilities to determine which syntax nodes are part of a particular build configuration. Each utility requires that one provides a specific build configuration (i.e., an instance of a type that conforms to the <doc:BuildConfiguration> protocol), and provides a different view on essentially the same information:

* <doc:ActiveSyntaxVisitor> and <doc:ActiveSyntaxAnyVisitor> are visitor types that only visit the syntax nodes that are included ("active") for a given build configuration, implicitly skipping any nodes within inactive `#if` clauses.
* `SyntaxProtocol.removingInactive(in:)` produces a syntax node that removes all inactive regions (and their corresponding `IfConfigDeclSyntax` nodes) from the given syntax tree, returning a new tree that is free of `#if` conditions.
* `IfConfigDeclSyntax.activeClause(in:)` determines which of the clauses of an `#if` is active for the given build configuration, returning the active clause.
* `SyntaxProtocol.configuredRegions(in:)` produces a `ConfiguredRegions` value that can be used to efficiently test whether a given syntax node is in an active, inactive, or unparsed region, remove inactive syntax, or determine the
    active clause for a given `#if`. Use `ConfiguredRegions` for repeated queries.
