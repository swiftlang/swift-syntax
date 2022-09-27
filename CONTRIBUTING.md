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
2. Execute the following command
    ```bash
    swift-syntax/build-script.py build --toolchain /Library/Developer/Toolchains/swift-DEVELOPMENT-SNAPSHOT-<recent date>.xctoolchain/usr
    ```

## Testing

Because of SwiftSyntax’s integration with the Swift compiler project, testing certain parts of the project is a little bit more involved than others. 

The `SwiftParser` tests have no depdendencies, other `XCTests` require you to use a matching Swift Development Snapshot, `lit`-based test require a compiler build.

Run the tests that you belive are necessary locally. CI will always run all test before allowing the PR to be merged.

### SwiftParser

If you are only modifying the `SwiftParser` module, you can just run the tests using Xcode by testing the `SwiftParserTest` target. 

If you can’t find it in your Schemes, you need to manually add it using Product -> Scheme -> New Scheme…

### XCTests

The `SwiftSyntaxParser` module (the legacy parser) of this repository depends on the C++ parser library (`_InternalSwiftSyntaxParser.dylib`) to parse source code.
The syntax node definitions of that parser library need to match those used by your SwiftSyntax checkout.
Most of the time, the parser library included in the latest Swift Development Snapshot will fulfill this requirement. 

To run the tests in Xcode, select the latest Swift Development Snapshot in Xcode -> Toolchains, select the SwiftSyntax-Package scheme and hit Prodcut -> Test.

You can also run the tests from the command line using
```bash
./build-script.py test --toolchain /Library/Developer/Toolchains/swift-DEVELOPMENT-SNAPSHOT-<recent date>.xctoolchain/usr --skip-lit-tests
```

If you are seeing issues regarding a mismatched parser library, try the following
1. Update your Swift Development Snapshot
2. Revert your swift-syntax checkout to the date of your Swift Development Snapshot
3. Wait for a new Swift Development Snapshot
4. If the above options are not possible, build your own Swift toolchain locally and use that toolchain as the `--toolchain` parameter for SwiftSyntax’s `build-script.py` invocations
  - Note: Building your own toolchain will take more than 1 hour and even longer if you are running into any issues. We do not recomment building your own Swift toolchain unless you are familiar with Swift compiler development.

Tip: Running SwiftSyntax’s self-parse tests takes the majority of testing time. If you want to iterate quickly, you can skip these tests using the following steps:
1. Product -> Scheme -> Edit Scheme…
2. Select the Arguments tab in the Run section
3. Add a `SKIP_SELF_PARSE` environment variable with value `1`

### `lit`-based tests

A few tests of the `SwiftSyntaxParser` module (the legacy parser), which test the interaction between SwiftSyntax and the C++ parser library (`_InternalSwiftSyntaxParser.dylib`) are based LLVM’s `lit` and `FileCheck` tools.
To run these, build `FileCheck`, e.g. by building the Swift compiler and run the tests using the following command:
```bash
./build-script.py test --toolchain /Library/Developer/Toolchains/swift-DEVELOPMENT-SNAPSHOT-<recent date>.xctoolchain/usr --skip-lit-tests --filecheck-exec /path/to/build/Release+Asserts/llvm-macosx-x86_64/bin/FileCheck
```

## Generating source code

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
