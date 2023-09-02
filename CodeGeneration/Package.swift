// swift-tools-version:5.7

import Foundation
import PackageDescription

let package = Package(
  name: "CodeGeneration",
  platforms: [
    .macOS(.v10_15)
  ],
  products: [
    .executable(name: "generate-swift-syntax", targets: ["generate-swift-syntax"])
  ],
  dependencies: [
    // This directory is a standalone package that uses swift-syntax from the
    // outer directory.
    // If you are making significant changs to `CodeGeneration` locally and want
    // to avoid breaking the build of `CodeGeneration` itself by generating new
    // files in the parent swift-syntax package, it is encouraged to change the
    // dependency to the following. That way `CodeGeneration` has its own
    // checkout of swift-syntax that is unaffected by the newly generated files.
    // Be sure to revert the change before committing your changes.
    //
    // .package(url: "https://github.com/apple/swift-syntax", branch: "main")
    .package(path: "..")
  ],
  targets: [
    .executableTarget(
      name: "generate-swift-syntax",
      dependencies: [
        .product(name: "SwiftSyntax", package: "swift-syntax"),
        .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
        .product(name: "SwiftBasicFormat", package: "swift-syntax"),
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        "SyntaxSupport",
        "Utils",
      ],
      exclude: [
        "templates/swiftsyntax/SwiftSyntaxDoccIndexTemplate.md"
      ]
    ),
    .target(
      name: "SyntaxSupport",
      dependencies: [
        .product(name: "SwiftSyntax", package: "swift-syntax"),
        .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
      ]
    ),
    .target(
      name: "Utils",
      dependencies: [
        .product(name: "SwiftBasicFormat", package: "swift-syntax"),
        .product(name: "SwiftSyntax", package: "swift-syntax"),
        .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
        "SyntaxSupport",
      ]
    ),
    .testTarget(
      name: "ValidateSyntaxNodes",
      dependencies: [
        "SyntaxSupport"
      ]
    ),
  ]
)

if ProcessInfo.processInfo.environment["SWIFTCI_USE_LOCAL_DEPS"] == nil {
  // Building standalone.
  package.dependencies += [
    .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.2")
  ]
} else {
  package.dependencies += [
    .package(path: "../../swift-argument-parser")
  ]
}
