// swift-tools-version:5.7

import PackageDescription

let package = Package(
  name: "CodeGeneration",
  platforms: [
      .macOS(.v10_15),
    ],
  products: [
    .executable(name: "generate-swiftbasicformat", targets: ["generate-swiftbasicformat"]),
    .executable(name: "generate-swiftideutils", targets: ["generate-swiftideutils"]),
    .executable(name: "generate-swiftparser", targets: ["generate-swiftparser"]),
    .executable(name: "generate-swiftsyntax", targets: ["generate-swiftsyntax"]),
    .executable(name: "generate-swiftsyntaxbuilder", targets: ["generate-swiftsyntaxbuilder"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-syntax.git", revision: "74b1286795d6a4e4f5a106638dc99eb482df609d"),
    .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMinor(from: "1.1.4")),
  ],
  targets: [
    .executableTarget(
      name: "generate-swiftbasicformat",
      dependencies: [
        .product(name: "SwiftSyntax", package: "swift-syntax"),
        .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        "SyntaxSupport",
        "Utils"
      ]
    ),
    .executableTarget(
      name: "generate-swiftideutils",
      dependencies: [
        .product(name: "SwiftSyntax", package: "swift-syntax"),
        .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        "SyntaxSupport",
        "Utils"
      ]
    ),
    .executableTarget(
      name: "generate-swiftparser",
      dependencies: [
        .product(name: "SwiftSyntax", package: "swift-syntax"),
        .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        "SyntaxSupport",
        "Utils"
      ]
    ),
    .executableTarget(
      name: "generate-swiftsyntax",
      dependencies: [
        .product(name: "SwiftSyntax", package: "swift-syntax"),
        .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        "SyntaxSupport",
        "Utils"
      ]
    ),
      .executableTarget(
      name: "generate-swiftsyntaxbuilder",
      dependencies: [
        .product(name: "SwiftSyntax", package: "swift-syntax"),
        .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        "SyntaxSupport",
        "Utils"
      ]
    ),
    .target(
      name: "SyntaxSupport",
      exclude: [
        "gyb_helpers",
        "AttributeKinds.swift.gyb",
        "AttributeNodes.swift.gyb",
        "AvailabilityNodes.swift.gyb",
        "BuilderInitializableTypes.swift.gyb",
        "Classification.swift.gyb",
        "CommonNodes.swift.gyb",
        "DeclNodes.swift.gyb",
        "ExprNodes.swift.gyb",
        "GenericNodes.swift.gyb",
        "PatternNodes.swift.gyb",
        "StmtNodes.swift.gyb",
        "SyntaxBaseKinds.swift.gyb",
        "TokenSpec.swift.gyb",
        "Traits.swift.gyb",
        "Trivia.swift.gyb",
        "TypeNodes.swift.gyb"
      ]
    ),
    .target(
      name: "Utils",
      dependencies: [
        .product(name: "SwiftSyntax", package: "swift-syntax"),
        .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
        "SyntaxSupport"
      ]
    ),
  ]
)
