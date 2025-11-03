# SwiftWarningControl

A library to evaluate `@warn` diagnostic group controls within a Swift syntax tree.

## Overview

Swift provides a mechanism to control the behavior of specific diagnostic groups for a given declaration's lexical scope with the `@warn` attribute.

The syntax tree and its parser do not reason about warning group controls. The syntax tree produced by the parser represents the `@warn` attribute in a generic fashion, as it would any other basic attribute on a declaration. The per-declaration nature of the attribute means that for any given lexical scope, the behavior of a given diagnostic group can be queried by checking for the presence of this attribute in its parent declaration scope.

```swift
@warn(Deprecate, as: error)
func foo() {
  ...
  @warn(Deprecate, as: warning)
  func bar() {
    ...
    @warn("Deprecate", as: ignored, reason: "Foo")
    func baz() {
      ...
    }
  }
}
```

The `SwiftWarningControl` library provides a utility to determine, for a given source location and diagnostic group identifier, whether or not its behavior is affected by an `@warn` attribute of any of its parent declaration scope.

* `SyntaxProtocol.getWarningGroupControl(for diagnosticGroupIdentifier:)` produces the behavior control specifier (`WarningGroupControl`: `error`, `warning`, `ignored`) which applies at this node.

* `SyntaxProtocol.warningGroupControlRegionTree` holds a computed `WarningControlRegionTree` data structure value that can be used to efficiently test for the specified `WarningGroupControl` at a given source location and a given diagnostic group.
