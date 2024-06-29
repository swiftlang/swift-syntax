# Swift Syntax

The swift-syntax package is a set of libraries that work on a source-accurate tree representation of Swift source code, called the SwiftSyntax tree. The SwiftSyntax tree forms the backbone of Swift’s macro system – the macro expansion nodes are represented as SwiftSyntax nodes and a macro generates a SwiftSyntax tree to be inserted into the source file.

## Documentation

You can read SwiftSyntax’s documentation on [swiftpackageindex.com](https://swiftpackageindex.com/swiftlang/swift-syntax/documentation).

A great way to interactively explore the SwiftSyntax tree of a source file is https://swift-ast-explorer.com, developed by [@kishikawakatsumi](https://github.com/kishikawakatsumi).

A set of example usages of swift-syntax can be found in [Examples](Examples).

## Releases

Releases of SwiftSyntax are aligned with corresponding language and tooling releases, for example the major version 509 of swift-syntax is aligned with Swift 5.9. 
 
To depend on swift-syntax in a SwiftPM package, add the following to your `Package.swift`.


```swift
dependencies: [
  .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "<#latest swift-syntax tag#>"),
],
```
 
To add swift-syntax as a dependency of your Xcode project, go to the *Package Dependencies* tab of your Xcode project, click the plus button and search for https://github.com/swiftlang/swift-syntax.git.

## Reporting Issues

If you should hit any issues while using SwiftSyntax, we appreciate bug reports on [GitHub Issue](https://github.com/swiftlang/swift-syntax/issues).

## Contributing

Start contributing to SwiftSyntax see [this guide](CONTRIBUTING.md) for more information.

## Bazel

SwiftSyntax provides an experimental [Bazel](https://bazel.build) build configuration, maintained by Keith Smiley. 
To use it you can pull the source archive from the relevant release tag
into your `WORKSPACE` and depend on the libraries you need from the
[`BUILD.bazel`](BUILD.bazel) file. Each library also has an associated
`Library_opt` target (such as `SwiftSyntax_opt`) which forces
SwiftSyntax to always build with optimizations enabled. This may help
local runtime performance at the cost of debuggability, and initial
build time. Please tag any [issues](https://github.com/swiftlang/swift-syntax/issues) related to the Bazel configuration with the label "Bazel".

## License

Please see [LICENSE](LICENSE.txt) for more information.
