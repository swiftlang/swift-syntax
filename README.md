# SwiftSyntax

SwiftSyntax is a set of Swift bindings for the
[libSyntax](https://github.com/apple/swift/tree/master/lib/Syntax) library. It
allows for Swift tools to parse, inspect, generate, and transform Swift source
code.

Its API is designed for performance critical applications. It uses value types almost exclusively and aims to avoid existential conversions where possible.

> Note: SwiftSyntax is still in development, and the API is not guaranteed to
> be stable. It's subject to change without warning.

## Usage

### Declare SwiftPM dependency with release tag
Add this repository to the `Package.swift` manifest of your project:

```swift
// swift-tools-version:5.2
import PackageDescription

let package = Package(
  name: "MyTool",
  dependencies: [
    .package(name: "SwiftSyntax", url: "https://github.com/apple/swift-syntax.git", .exact("<#Specify Release tag#>")),
  ],
  targets: [
    .target(name: "MyTool", dependencies: ["SwiftSyntax"]),
  ]
)
```

Replace `<#Specify Release tag#>` by the version of SwiftSyntax that you want to use (see the following table for mapping details).


| Xcode Release | Swift Release Tag | SwiftSyntax Release Tag  |
|:-------------------:|:-------------------:|:-------------------------:|
| Xcode 12.0   | swift-5.3-RELEASE   | 0.50300.0 |
| Xcode 11.4   | swift-5.2-RELEASE   | 0.50200.0 |
| Xcode 11.3   | swift-5.1-RELEASE   | 0.50100.0 |
| Xcode 10.2   | swift-5.0-RELEASE   | 0.50000.0 |


Then, import `SwiftSyntax` in your Swift code.


### Declare SwiftPM dependency with nightly build

1. Download and install the latest Trunk Development (master) [toolchain](https://swift.org/download/#snapshots).

2. Define the `TOOLCHAINS` environment variable as below to have the `swift` command point inside the toolchain:

```
$ export TOOLCHAINS=swift
```

3. To make sure everything is setup correctly, check the result of `xcrun --find swift`. It should point inside the OSS toolchain.

4. Add this entry to the `Package.swift` manifest of your project:

```swift
// swift-tools-version:4.2
import PackageDescription

let package = Package(
  name: "MyTool",
  dependencies: [
    .package(url: "https://github.com/apple/swift-syntax.git", .revision("swift-DEVELOPMENT-SNAPSHOT-2019-02-26")),
  ],
  targets: [
    .target(name: "MyTool", dependencies: ["SwiftSyntax"]),
  ]
)
```

Tags will be created for every nightly build in the form of `swift-DEVELOPMENT-SNAPSHOT-<DATE>`. Revision field
should be specified with the intended tag.

Different from building SwiftSyntax from source, declaring SwiftSyntax as a SwiftPM dependency doesn't require
the Swift compiler source because we always push gyb-generated files to a tag.

### Embedding SwiftSyntax in an Application

SwiftSyntax depends on the `lib_InternalSwiftSyntaxParser.dylib/.so` library which provides a C interface to the underlying Swift C++ parser. When you do `swift build` SwiftSyntax links and uses the library included in the Swift toolchain. If you are building an application make sure to embed `_InternalSwiftSyntaxParser` as part of your application's libraries.

You can either copy `lib_InternalSwiftSyntaxParser.dylib/.so` directly from the toolchain or even build it yourself from the [Swift repository](https://github.com/apple/swift), as long as you are matching the same tags or branches in both the SwiftSyntax and Swift repositories. To build it for the host os (macOS/linux) use the following steps:

```
git clone https://github.com/apple/swift.git
./swift/utils/update-checkout --clone
./swift/utils/build-parser-lib --release --no-assertions --build-dir /tmp/parser-lib-build
```

### Embedding in an iOS Application

You need to build `lib_InternalSwiftSyntaxParser.dylib` yourself, you cannot copy it from the toolchain. Follow the instructions above and change the invocation of `build-parser-lib` accordingly:

```
./swift/utils/build-parser-lib --release --no-assertions --build-dir /tmp/parser-lib-build-iossim --host iphonesimulator --architectures x86_64
./swift/utils/build-parser-lib --release --no-assertions --build-dir /tmp/parser-lib-build-ios --host iphoneos --architectures arm64
```

### Some Example Users

[**Swift AST Explorer**](https://swift-ast-explorer.kishikawakatsumi.com/): a Swift AST visualizer.

[**swift-format**](https://github.com/apple/swift-format): formatting technology for Swift source code.

[**Swift Stress Tester**](https://github.com/apple/swift-stress-tester): a test driver for sourcekitd and Swift evolution.

[**SwiftSemantics**](https://github.com/SwiftDocOrg/SwiftSemantics): parses Swift code into its constituent declarations.

[**Sitrep**](https://github.com/twostraws/Sitrep): A source code analyzer for Swift projects

[**SwiftRewriter**](https://github.com/inamiy/SwiftRewriter): a Swift code formatter.

[**SwiftPack**](https://github.com/omochi/SwiftPack): a tool for automatically embedding Swift library source.

[**Periphery**](https://github.com/peripheryapp/periphery): a tool to detect unused code.

[**BartyCrouch**](https://github.com/Flinesoft/BartyCrouch): a tool to incrementally update strings files to help App localization.

[**Muter**](https://github.com/muter-mutation-testing/muter): Automated mutation testing for Swift

[**Swift Variable Injector**](https://github.com/LucianoPAlmeida/variable-injector): a tool to replace string literals with environment variables values.

[**Pecker**](https://github.com/woshiccm/Pecker): a tool to detect unused code based on [SwiftSyntax](https://github.com/apple/swift-syntax.git) and [IndexStoreDB](https://github.com/apple/indexstore-db.git).

[**Piranha**](https://github.com/uber/piranha): a tool for refactoring code related to feature flags.

[**STAR**](https://github.com/thumbtack/star): a tool to find how often specified Swift type(s) are used in a project.

### Reporting Issues

If you should hit any issues while using SwiftSyntax, we appreciate bug reports on [bugs.swift.org](https://bugs.swift.org) in the [SwiftSyntax component](https://bugs.swift.org/issues/?jql=component%20%3D%20SwiftSyntax).

## Contributing

### Building SwiftSyntax from `master`

Since SwiftSyntax relies on definitions in the main Swift repository to generate the layout of the syntax tree using `gyb`, a checkout of [apple/swift](https://github.com/apple/swift) is still required to build `master` of SwiftSyntax.

To build the `master` version of SwiftSyntax, follow the following instructions:

1. Check `swift-syntax` and  `swift` out side by side:

```
- (enclosing directory)
  - swift
  - swift-syntax
```

2. Make sure you have a recent [master Swift toolchain](https://swift.org/download/#snapshots) installed.
3. Define the `TOOLCHAINS` environment variable as below to have the `swift` command point inside the toolchain:

```
$ export TOOLCHAINS=swift
```

4. To make sure everything is setup correctly, check the return statement of `xcrun --find swift`. It should point inside the latest installed master toolchain. If it points inside an Xcode toolchain, check that you exported the `TOOLCHAINS` environment variable correctly. If it points inside a version specific toolchain (like Swift 5.0-dev), you'll need to remove that toolchain.
5. Run `swift-syntax/build-script.py`.

If, despite following those instructions, you get compiler errors, the Swift toolchain might be too old to contain recent changes in Swift's SwiftSyntaxParser C library. In that case, you'll have to build the compiler and SwiftSyntax together with the following command:

```
$ swift/utils/build-script --swiftsyntax --swiftpm --llbuild
```

Swift-CI will automatically run the code generation step whenever a new toolchain (development snapshot or release) is published. It should thus almost never be necessary to perform the above build yourself.

Afterwards, SwiftPM can also generate an Xcode project to develop SwiftSyntax by running `swift package generate-xcodeproj`.

If you also want to run tests locally, read the section below as testing has additional requirements.

### Local Testing
SwiftSyntax uses some test utilities that need to be built as part of the Swift compiler project. To build the most recent version of SwiftSyntax and test it, follow the steps in [swift/README.md](https://github.com/apple/swift/blob/master/README.md) and pass `--llbuild --swiftpm --swiftsyntax` to the build script invocation to build SwiftSyntax and all its dependencies using the current `master` compiler.

SwiftSyntax can then be tested using the build script in `apple/swift` by running
```
swift/utils/build-script --swiftsyntax --swiftpm --llbuild -t --skip-test-cmark --skip-test-swift --skip-test-llbuild --skip-test-swiftpm
```
This command will build SwiftSyntax and all its dependencies, tell the build script to run tests, but skip all tests but the SwiftSyntax tests.

Note that it is not currently supported to build SwiftSyntax while building the Swift compiler using Xcode.

### CI Testing

Running `@swift-ci Please test` on the main Swift repository will also test the most recent version of SwiftSyntax.

Testing SwiftSyntax from its own repository is now available by commenting `@swift-ci Please test macOS platform`.

## Example

This is a program that adds 1 to every integer literal in a Swift file.

```swift
import SwiftSyntax
import Foundation

/// AddOneToIntegerLiterals will visit each token in the Syntax tree, and
/// (if it is an integer literal token) add 1 to the integer and return the
/// new integer literal token.
class AddOneToIntegerLiterals: SyntaxRewriter {
  override func visit(_ token: TokenSyntax) -> Syntax {
    // Only transform integer literals.
    guard case .integerLiteral(let text) = token.tokenKind else {
      return Syntax(token)
    }

    // Remove underscores from the original text.
    let integerText = String(text.filter { ("0"..."9").contains($0) })

    // Parse out the integer.
    let int = Int(integerText)!

    // Create a new integer literal token with `int + 1` as its text.
    let newIntegerLiteralToken = token.withKind(.integerLiteral("\(int + 1)"))
    
    // Return the new integer literal.
    return Syntax(newIntegerLiteralToken)
  }
}

let file = CommandLine.arguments[1]
let url = URL(fileURLWithPath: file)
let sourceFile = try SyntaxParser.parse(url)
let incremented = AddOneToIntegerLiterals().visit(sourceFile)
print(incremented)
```

This example turns this:

```swift
let x = 2
let y = 3_000
```

into:

```swift
let x = 3
let y = 3001
```
