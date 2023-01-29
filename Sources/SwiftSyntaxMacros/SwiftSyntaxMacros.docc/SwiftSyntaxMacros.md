# ``SwiftSyntaxMacros``



An experimental library to provide syntactic macro support for Swift. New macros can be introduced by creating new types that conform to the various `*Macro` protocols, e.g., `ExpressionMacro` for an expression-like macro. The `MacroSystem` can then rewrite uses of that those macros in the source code. This library is a prototype for a potential Swift macro feature, but is not tied in with the compiler like such a feature would be.

## Trying out macro expansion

The `swift-parser-cli` program has an `expand-macros` command that will expand any all of the example macros (see below) in the program's source. For example, providing it with the source code:

```swift
let b = #stringify(x + y)
```

will produce

```swift
let b = (x + y, #"x + y"#)
```

Use `swift-parser-cli` to test out your macros and see what kind of syntactic transformations are possible.

## Example macros

A number of example macros have been implemented in the file `MacroSytem+Examples.swift`. They include:

* `#line`: Implements the `#line` expression.
* `#column`: Implements the `#column` expression.
* `#function`: Implements the `#function` expression.
* `#stringify(x)`: returns both the value `x` and the string form of its expression, as a tuple.
* `#colorLiteral(red: <value>, green: <value>, blue: <value>, alpha: <value>)`: Implements the `#colorLiteral` expression.

New example macros can be added by defining new types that conform to the appropriate `*Macro` protocols, and adding those macros to the example macro system created by `MacroSystem.exampleSystem`. Have fun!

## What's the future for this library?

Well, that depends. The `SwiftSyntaxMacros` module is part of a potential vision for a macros feature in Swift, where the effect of macro evaluation is as it works here---executable Swift code that transforms a given syntax tree into another syntax tree. That design also integrates macros into the type checker, so that macros are only evaluated on well-typed inputs and are expected to either produce well-typed syntax trees as output or emit diagnostics along the way. If that design is accepted as the design for Swift, much of this module will remain as it is---but the examples themselves will be divided into a builtin set of macros that are always available to the compiler (e.g., to provide the implementation for things like `#line`) or moved into a separate examples module to provide documentation on how to use the feature.
