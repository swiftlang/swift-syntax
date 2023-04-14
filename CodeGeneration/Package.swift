// swift-tools-version:5.7

import PackageDescription

let package = Package(
  name: "CodeGeneration",
  platforms: [
    .macOS(.v10_15)
  ],
  products: [
    .executable(name: "generate-swiftsyntax", targets: ["generate-swiftsyntax"])
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-syntax.git", revision: "94120e0cf9bf541e54fbc8512934daea23a9ad0c"),
    .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMinor(from: "1.2.2")),
  ],
  targets: [
    .executableTarget(
      name: "generate-swiftsyntax",
      dependencies: [
        .product(name: "SwiftSyntax", package: "swift-syntax"),
        .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        "SyntaxSupport",
        "Utils",
      ],
      exclude: [
        "templates/swiftsyntax/SwiftSyntaxDoccIndexTemplate.md"
      ]
    ),
    .target(
      name: "SyntaxSupport"
    ),
    .target(
      name: "Utils",
      dependencies: [
        .product(name: "SwiftSyntax", package: "swift-syntax"),
        .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
        "SyntaxSupport",
      ]
    ),
  ]
)
