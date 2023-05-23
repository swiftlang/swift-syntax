# Contributing

This guide refers to Swift Development Snapshots. These can be downloaded from [swift.org/download](https://swift.org/download/#snapshots). 
If you are seeing issues, it is generally a good idea to re-try with the latest Swift Development Snapshot.

## Building

The easiest option to build SwiftSyntax it to open it in Xcode. 

Alternatively you can also build it from the command line using `build-script.py`. To do this, perform the following steps

1. Check `swift-syntax` and `swift-argument-parser` out side by side:
     ```
     - (enclosing directory)
       - swift-argument-parser
       - swift-syntax
     ```
2. Execute the following command
    ```bash
    swift-syntax/build-script.py build --toolchain /Library/Developer/Toolchains/swift-DEVELOPMENT-SNAPSHOT-<recent date>.xctoolchain/usr
    ```

## Formatting

SwiftSyntax is being formatted using [swift-format](http://github.com/apple/swift-format) to ensure a consistent style.

To format your changes run `format.py` at the root of this repository. If you have a `swift-format` executable ready, you can pass it to `format.py`. If you do not, `format.py` will build its own copy of `swift-format` in /tmp/swift-format.

CI will ensure that all hand-written source code is correctly formatted. Generated source code is not formatted to make it easier to spot changes when re-running code generation.

## Testing

Because of SwiftSyntax’s integration with the Swift compiler project, testing certain parts of the project is a little bit more involved than others. 

The `SwiftParser` tests have no dependencies, other `XCTests` require you to use a matching Swift Development Snapshot, `lit`-based test require a compiler build.

Run the tests that you believe are necessary locally. CI will always run all test before allowing the PR to be merged.

### SwiftParser

If you are only modifying the `SwiftParser` module, you can just run the tests using Xcode by testing the `SwiftParserTest` target. 

If you can’t find it in your Schemes, you need to manually add it using Product -> Scheme -> New Scheme…

### XCTests

To run the tests in Xcode, select the SwiftSyntax-Package scheme and hit Product -> Test.

You can also run the tests from the command line using
```bash
./build-script.py test --toolchain /Library/Developer/Toolchains/swift-DEVELOPMENT-SNAPSHOT-<recent date>.xctoolchain/usr --skip-lit-tests
```

If you are seeing issues regarding a mismatched parser library, try the following
1. Update your Swift Development Snapshot
2. Revert your swift-syntax checkout to the date of your Swift Development Snapshot
3. Wait for a new Swift Development Snapshot
4. If the above options are not possible, build your own Swift toolchain locally and use that toolchain as the `--toolchain` parameter for SwiftSyntax’s `build-script.py` invocations
  - Note: Building your own toolchain will take more than 1 hour and even longer if you are running into any issues. We do not recommend building your own Swift toolchain unless you are familiar with Swift compiler development.

Tip: Running SwiftSyntax’s self-parse tests takes the majority of testing time. If you want to iterate quickly, you can skip these tests using the following steps:
1. Product -> Scheme -> Edit Scheme…
2. Select the Arguments tab in the Run section
3. Add a `SKIP_LONG_TESTS` environment variable with value `1`

### Additional Verification

swift-syntax has two additional verification methods (see the two sections below) that provide more extensive validation. They have significant runtime impact on swift-syntax and are thus not enabled by default when building swift-syntax, but are enabled in CI. If CI fails and you are unable to reproduce the failure locally, make sure that `SKIP_LONG_TESTS` is not set and try enabling these validations.

#### RawSyntax Validation

When the `SWIFTSYNTAX_ENABLE_RAWSYNTAX_VALIDATION` environment variable is set while building swift-syntax (or the check for that variable has been changed to always return `true` in Package.swift), SwiftSyntax will perform additional validation that the layout of the syntax tree is correct. It validates that every child of a syntax node has the correct kind (which should be guaranteed by the Swift type system in most cases) and, more importantly, validates that each token only has one of the token kinds that is specified in the syntax tree layout of the `CodeGeneration` package. 

If this validation hits an assertion failure that a token is not accepted at a certain position in the syntax tree, double check if the token kind that is being stored in the syntax tree actually makes sense here. If it does not, check if there is a parser bug or whether you need to remap the token kind. If it does make sense, add the token kind to `.token(choices:)` of the syntax node in CodeGeneration, re-generate that source code and run tests again.

#### Test Case Mutation

When the `SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION` environment variable is set while building swift-syntax (or the check for that variable has been changed to always return `true` in Package.swift), SwiftParser records alternative tokens that the parser was looking for at specific offsets in the source file (e.g. whether it also checked for a `struct` keyword when the source code contained a `class` keyword). It will then use that information to mutate the test case by e.g. substituting `class` by `struct`.

When testing finds one of these failures, it will show you the syntax tree that produced the failure. Create a new test case with the source code the failure gives you and fix the failure.

### `lit`-based Tests

A few tests are based LLVM’s `lit` and `FileCheck` tools.
To run these, build `FileCheck`, e.g. by building the Swift compiler and run the tests using the following command:
```bash
./build-script.py test --toolchain /Library/Developer/Toolchains/swift-DEVELOPMENT-SNAPSHOT-<recent date>.xctoolchain/usr --skip-lit-tests --filecheck-exec /path/to/build/Release+Asserts/llvm-macosx-x86_64/bin/FileCheck
```

## Generating Source Code

If you want to modify the code-generated files, perform the following steps:

1. Check out `swift` next to `swift-syntax`
    ```
    - (enclosing directory)
      - swift
      - swift-argument-parser
      - swift-syntax
    ```
2. Run the following command
    ```bash
    swift-syntax/build-script.py generate-source-code --toolchain /Library/Developer/Toolchains/swift-DEVELOPMENT-SNAPSHOT-<recent date>.xctoolchain/usr
    ```
3. The new source-generated file will be written into your `Sources` directory.

## Swift Version

We require that SwiftSyntax builds with the latest released compiler and the previous major version (e.g. with Swift 5.8 and Swift 5.7).
