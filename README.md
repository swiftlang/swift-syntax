# SwiftSyntax

SwiftSyntax is a set of Swift bindings for the
[libSyntax](https://github.com/apple/swift/tree/main/lib/Syntax) library. It
allows Swift tools to parse, inspect, generate, and transform Swift source
code.

Its API is designed for performance-critical applications. It uses value types almost exclusively and aims to avoid existential conversions where possible.

> Note: SwiftSyntax is still in development, and the API is not guaranteed to
> be stable. It's subject to change without warning.

## Declare SwiftPM dependency with release tag

Add this repository to the `Package.swift` manifest of your project:

```swift
// swift-tools-version:5.6
import PackageDescription

let package = Package(
  name: "MyTool",
  dependencies: [
    .package(url: "https://github.com/apple/swift-syntax.git", exact: "<#Specify Release tag#>"),
  ],
  targets: [
    .target(name: "MyTool", dependencies: [
      .product(name: "SwiftSyntax", package: "swift-syntax"),
    ]),
  ]
)
```

Replace `<#Specify Release tag#>` by the version of SwiftSyntax that you want to use (see the following table for mapping details).

| Xcode Release | Swift Release Tag | SwiftSyntax Release Tag  |
|:-------------------:|:-------------------:|:-------------------------:|
| Xcode 14.0   | swift-5.7-RELEASE   | 0.50700.0 |
| Xcode 13.3   | swift-5.6-RELEASE   | 0.50600.1 |
| Xcode 13.0   | swift-5.5-RELEASE   | 0.50500.0 |
| Xcode 12.5   | swift-5.4-RELEASE   | 0.50400.0 |
| Xcode 12.0   | swift-5.3-RELEASE   | 0.50300.0 |
| Xcode 11.4   | swift-5.2-RELEASE   | 0.50200.0 |

Then, import `SwiftSyntax` in your Swift code.

## Documentation

Documentation can be found in the following places:
- For the parser: [Sources/SwiftParser/SwiftParser.docc](Sources/SwiftParser/SwiftParser.docc) 
  - You can either directly view this documentation on GitHub or build a documenation bundle by opening the project in Xcode and clicking Product -> Build Documentation
- General documentation: [Documentation](Documentation) 
- Examples of using SwiftSyntax: [Examples](Examples).

## Contributing

Start contributing to SwiftSyntax see [this guide](CONTRIBUTING.md) for more information.

## Reporting Issues

If you should hit any issues while using SwiftSyntax, we appreciate bug reports on [GitHub Issue](https://github.com/apple/swift-syntax/issues).

## License

 Please see [LICENSE](LICENSE.txt) for more information.
