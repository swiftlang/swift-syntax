# Filing BasicFormat Bug Reports

Guide to provide steps for filing actionable bug reports for `BasicFormat` failures.

- Attention: Keep in mind that the primary goal of BasicFormat is to add trivia to a SwiftSyntax tree in a way that allows the parser to parse the same tree again, e.g. making sure that a keyword and an identifier are separated by a space. BasicFormat intentionally has no functionality to e.g. split lines.

Reducing a failure requires the `swift-parser-cli` utility that you can build by checking out `swift-syntax` and running 
```
swift build --package-path SwiftParserCLI
```
or openning `SwiftParserCLI` package and building the `swift-parser-cli` target in Xcode.

1. After you have built `swift-parse-cli`, you can format a single source file using BasicFormat by running the following command. If you are only experiencing the issue while formatting a single node, e.g. while creating an `AccessorDeclSyntax` inside a macro, you can additionally pass the type of the node as `--node-type AccessorDeclSyntax` 
```
swift-parser-cli basic-format /path/to/file/that/formats/incorrectly.swift
```
2. Remove as much code from your source file while still experiencing the formatting issue.
3. File a bug report on <https://github.com/apple/swift-syntax/issues/new/choose> with the reduced source code.
