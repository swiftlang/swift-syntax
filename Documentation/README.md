# Documentation

## Usage

Add this entry to the `Package.swift` manifest of your project:

```swift
// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "MyTool",
  dependencies: [
    .package(url: "https://github.com/apple/swift-syntax.git", .branch("main")),
  ],
  targets: [
    .target(name: "MyTool", dependencies: ["SwiftSyntax"]),
  ]
)
```

