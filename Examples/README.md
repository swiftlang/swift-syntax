# Examples

Each example can be executed by navigating into this folder and running `swift run <example> <arguments>`. There is the following set of examples available:

- [AddOneToIntegerLiterals](Sources/AddOneToIntegerLiterals/AddOneToIntegerLiterals.swift): Command line tool to add 1 to every integer literal in a source file
- [CodeGenerationUsingSwiftSyntaxBuilder](Sources/CodeGenerationUsingSwiftSyntaxBuilder/CodeGenerationUsingSwiftSyntaxBuilder.swift): Code-generate a simple source file using SwiftSyntaxBuilder
- [ExamplePlugin](Sources/ExamplePlugin): Compiler plugin executable using [`SwiftCompilerPlugin`](../Sources/SwiftCompilerPlugin)
- [MacroExamples](Sources/MacroExamples): A collection of Swift macros

Furthermore, SwiftSyntax uses [`SwiftSyntaxBuilder`](../Sources/SwiftSyntaxBuilder) extensively to generate its own code. That code can be found in the [CodeGeneration](../CodeGeneration) package.

## Some Example Usages

[**BartyCrouch**](https://github.com/Flinesoft/BartyCrouch): A tool to incrementally update strings files to help with localization.

[**Hatch**](https://github.com/sdidla/Hatch): Provides a simple, extensible parser to obtain a hierarchical list of symbols.

[**Muter**](https://github.com/muter-mutation-testing/muter): Automated mutation testing for Swift.

[**Periphery**](https://github.com/peripheryapp/periphery): A tool to detect unused code.

[**Sitrep**](https://github.com/twostraws/Sitrep): A source code analyzer for Swift projects.

[**Swift AST Explorer**](https://swift-ast-explorer.com/): A Swift AST visualizer.

[**Swift Stress Tester**](https://github.com/swiftlang/swift-stress-tester): A test driver for `sourcekitd` and Swift evolution.

[**swift-format**](https://github.com/swiftlang/swift-format): Formatting technology for Swift source code.

[**SwiftLint**](https://github.com/realm/SwiftLint): A tool to enforce Swift style and conventions.
