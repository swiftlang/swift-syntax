# Filing Parser Bug Reports

Guide to provide steps for filing actionable bug reports for parser failures.

Reducing a test case requires the `swift-parser-cli` utility that you can build by checking out `swift-syntax` and running `swift build --package-path SwiftParserCLI` or openning the `SwiftParserCLI` package and building the `swift-parser-cli` target in Xcode.

## Round-Trip Failure or Parser Crash

If you encounter a case where printing the parsed syntax tree does not reproduce the original source file, that’s a round-tripping failure and is considered a serious bug in SwiftSyntax – preserving the original source is a core principle of this library. To reproduce and reduce the failure, perform the following steps

1. Reduce the failure by running 
    ```
    swift-parser-cli reduce /pth/to/file/that/does/not/roundtrip.swift
    ```
2. File a bug report on <https://github.com/apple/swift-syntax/issues/new/choose> with the reduced source code or fix the issue yourself by following the steps in <doc:FixingBugs>. 

## Parse of Valid Source Failed or Bad Diagnostic Produced

If you have source code that is parsed correctly by the current Swift compiler (and thus the old parser written in C++), but that is rejected by the new parser or if you think that a diagnostic produced by the new parser is not very helpful, perform the following steps to reduce the failure:

1. Run the following command to see the diagnostics produced by the parser
    ```
    swift-parser-cli print-diags /path/to/file.swift
    ``` 
2. Remove as much code as possible from your test file and check if it still produces the same diagnostic. 
3. File a bug report on <https://github.com/apple/swift-syntax/issues/new/choose> with the reduced source code or fix the issue yourself by following the steps in <doc:FixingBugs>.

## Parse of Valid Source Code Produced an Invalid Syntax Tree

If you have valid source code that produced a syntax tree which doesn’t represent the source code’s semantics correctly, perform the following steps:

1. Run the following command to print the parsed syntax tree
    ```
    swift-parser-cli print-tree /path/to/file.swift
    ``` 
2. Remove as much code as possible from your test file and check if it still produces the same invalid tree
3. File a bug report on <https://github.com/apple/swift-syntax/issues/new/choose> with the reduced source code or fix the issue yourself by following the steps in <doc:FixingBugs>.
