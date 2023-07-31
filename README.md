# SwiftSyntax

SwiftSyntax is a set of Swift libraries for parsing, inspecting, generating, and transforming Swift source code.

## Documentation

You can read SwiftSyntax’s documentation on [swiftpackageindex.com](https://swiftpackageindex.com/apple/swift-syntax/documentation).

A great way to interactively explore the SwiftSyntax tree of a source file is https://swift-ast-explorer.com, developed by [@kishikawakatsumi](https://github.com/kishikawakatsumi).

## Adding SwiftSyntax as a Dependency

### Trunk Development (main)

The mainline branch of SwiftSyntax tracks the latest developments. It is not
an official release, and is subject to rapid changes in APIs and behaviors. To 
use it, add this repository to the `Package.swift` manifest of your project:

```swift
// swift-tools-version:5.7
import PackageDescription

let package = Package(
  name: "MyTool",
  dependencies: [
    .package(url: "https://github.com/apple/swift-syntax.git", branch: "main"),
  ],
  targets: [
    .target(name: "MyTool", dependencies: [
      .product(name: "SwiftSyntax", package: "swift-syntax"),
    ]),
  ]
)
```

Mainline SwiftSyntax also includes 

- `SwiftParser` for natively parsing source code
- `SwiftOperators` for folding SwiftSyntax trees containing operators
- `SwiftSyntaxBuilder` for generating Swift code with a result builder-style interface
- `SwiftSyntaxMacros` for providing syntactic macro support

### Releases

Releases of SwiftSyntax are aligned with corresponding language
and tooling releases and are stable. To use them, 
add this repository to the `Package.swift` manifest of your project:

```swift
// swift-tools-version:5.7
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
| Xcode 14.3   | swift-5.8-RELEASE   | 508.0.0   |
| Xcode 14.0   | swift-5.7-RELEASE   | 0.50700.1 |
| Xcode 13.3   | swift-5.6-RELEASE   | 0.50600.1 |
| Xcode 13.0   | swift-5.5-RELEASE   | 0.50500.0 |
| Xcode 12.5   | swift-5.4-RELEASE   | 0.50400.0 |
| Xcode 12.0   | swift-5.3-RELEASE   | 0.50300.0 |
| Xcode 11.4   | swift-5.2-RELEASE   | 0.50200.0 |

## Documentation

SwiftSyntax uses [DocC](https://developer.apple.com/documentation/docc) bundles
for its documentation. To view rendered documentation in Xcode, open the 
SwiftSyntax package and select

```
Product > Build Documentation
``` 

Associated articles are written in markdown, and can be viewed in a browser, 
text editor, or IDE.

- [SwiftSyntax](Sources/SwiftSyntax/Documentation.docc)
- [SwiftParser](Sources/SwiftParser/SwiftParser.docc)
- [SwiftOperators](Sources/SwiftOperators/SwiftOperators.docc)
- [SwiftSyntaxMacros](Sources/SwiftSyntaxMacros/SwiftSyntaxMacros.docc)

## Contributing

Start contributing to SwiftSyntax see [this guide](CONTRIBUTING.md) for more information.

## Reporting Issues

If you should hit any issues while using SwiftSyntax, we appreciate bug reports on [GitHub Issue](https://github.com/apple/swift-syntax/issues).

## Bazel

SwiftSyntax provides an experimental [Bazel](https://bazel.build) build configuration, maintained by Keith Smiley. 
To use it you can pull the source archive from the relevant release tag
into your `WORKSPACE` and depend on the libraries you need from the
[`BUILD.bazel`](BUILD.bazel) file. Each library also has an associated
`Library_opt` target (such as `SwiftSyntax_opt`) which forces
SwiftSyntax to always build with optimizations enabled. This may help
local runtime performance at the cost of debuggability, and initial
build time. Please tag any [issues](https://github.com/apple/swift-syntax/issues) related to the Bazel configuration with the label "Bazel".

## License

Please see [LICENSE](LICENSE.txt) for more information.
