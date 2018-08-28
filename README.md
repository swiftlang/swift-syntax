# SwiftSyntax

SwiftSyntax is a set of Swift bindings for the
[libSyntax](https://github.com/apple/swift/tree/master/lib/Syntax) library. It
allows for Swift tools to parse, inspect, generate, and transform Swift source
code.

> Note: SwiftSyntax is still in development, and the API is not guaranteed to
> be stable. It's subject to change without warning.

## Usage

Add this repository to the `Package.swift` manifest of your project:

```swift
import PackageDescription

let package = Package(
  name: "MyTool",
  dependencies: [
    .package(url: "https://github.com/apple/swift-syntax.git", .branch("<#Specify Release tag#>")),
  ],
  targets: [
    .target(name: "MyTool", dependencies: ["SwiftSyntax"]),
  ]
)
```

Replace `<#Specify Release tag#>` by the version of SwiftSyntax that you want to use. Tags will be created for every release of the compiler in the form `swift-4.2-RELEASE` and for every nightly build in the form `swift-4.2-DEVELOPMENT-SNAPSHOT-2018-08-25-a`.

Then, import `SwiftSyntax` in your Swift code.

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
return token
}

// Remove underscores from the original text.
let integerText = String(text.filter { ("0"..."9").contains($0) })

// Parse out the integer.
let int = Int(integerText)!

// Return a new integer literal token with `int + 1` as its text.
return token.withKind(.integerLiteral("\(int + 1)"))
}
}

let file = CommandLine.arguments[1]
let url = URL(fileURLWithPath: file)
let sourceFile = try SourceFileSyntax.parse(url)
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
