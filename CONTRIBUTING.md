# Contributing

## Building & Testing

swift-syntax is a SwiftPM package, so you can build and test it using anything that supports packages - opening in Xcode, Visual Studio Code with [Swift for Visual Studio Code](https://github.com/swift-server/vscode-swift) installed, or through the command line using `swift build` and `swift test`.

> 💡 Tip: Running swift-syntax’s self-parse tests takes the majority of testing time. If you want to iterate quickly, you can skip these tests:
> - In Xcode
>   1. Product -> Scheme -> Edit Scheme…
>   2. Select the Arguments tab in the Run section
>   3. Add a `SKIP_LONG_TESTS` environment variable with value `1`
> - On the command line: Set the `SKIP_LONG_TESTS` environment variable to `1` when running tests, e.g by running `SKIP_LONG_TESTS=1 swift test`

> 💡 Tip: If you are only modifying the `SwiftParser` module, you can run only the parser tests by selecting the `SwiftParserTest` target. 
> - In Xcode: Select the `SwiftParserTest` scheme. If you can’t find it in your Schemes, you need to manually add it using Product -> Scheme -> New Scheme…
> - On the command line: Run `swift test --test-product SwiftParserTests`

## Formatting

swift-syntax is formatted using [swift-format](http://github.com/apple/swift-format) to ensure a consistent style.

To format your changes run `format.py` at the root of this repository. If you have a `swift-format` executable ready, you can pass it to `format.py`. If you do not, `format.py` will build its own copy of `swift-format` in `/tmp/swift-format`.

If you are seeing surprising formatting results, you most likely have a `swift-format` installed on your system that’s not the most recent version built from the `main` branch. To fix this, clone [swift-format](http://github.com/apple/swift-format), build it using `swift build` and pass the freshly built executable to `format.py` as `--swift-format path/to/swift-format/.build/debug/swift-format`. Alternatively, you can uninstall `swift-format` on your system and `format.py` will build it from scratch.

Generated source code is not formatted to make it easier to spot changes when re-running code generation.

## Generating Source Code

If you want to modify the generated files, open the [CodeGeneration](CodeGeneration) package and run the `generate-swift-syntax` executable.

## Additional Verification

swift-syntax has additional verification methods (see the sections below) that provide more extensive validation. They have a significant runtime impact on swift-syntax and are thus not enabled by default when building swift-syntax, but are enabled in CI. If CI fails and you are unable to reproduce the failure locally, make sure that `SKIP_LONG_TESTS` is not set and try enabling these validations.

### RawSyntax Validation

When the `SWIFTSYNTAX_ENABLE_RAWSYNTAX_VALIDATION` environment variable is set while building swift-syntax, SwiftSyntax will perform additional validation that the layout of the syntax tree is correct. It validates that 
1. every child of a syntax node has the correct kind, which should be guaranteed by the Swift type system in most cases
2. each token only has one of the token kinds that is specified in the syntax tree layout of the `CodeGeneration` package. 

If this validation hits an assertion failure that a token is not accepted at a certain position in the syntax tree, double-check if the token kind that is being stored in the syntax tree actually makes sense here. If it does not, check if there is a parser bug or whether you need to remap the token kind. If it does make sense, add the token kind to `.token(choices:)` of the syntax node in CodeGeneration, re-generate that source code and run tests again.

> 💡 Tip: If you want to run tests in Xcode with RawSyntax validation enabled, you can also modify Package.swift and replace the check for `SWIFTSYNTAX_ENABLE_RAWSYNTAX_VALIDATION` with `true`.

### Test Case Mutation

When the `SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION` environment variable is set while building swift-syntax, SwiftParser records alternative tokens that the parser was looking for at specific offsets in the source file, e.g. whether it also checked for a `struct` keyword when the source code contained a `class` keyword. It will then use that information to mutate the test case by e.g. substituting `class` with `struct`.

When testing finds one of these failures, it will show you the syntax tree that produced the failure. Create a new test case with the source code the failure gives you and fix the failure.

## Swift Version

We require that swift-syntax builds with the latest released compiler and the previous major version (e.g. with Swift 5.8 and Swift 5.7).