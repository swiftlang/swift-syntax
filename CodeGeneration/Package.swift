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
    .package(url: "https://github.com/swiftlang/swift-syntax", from: "510.0.0"),
    .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.2"),
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
