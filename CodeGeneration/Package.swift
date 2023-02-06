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
    .package(url: "https://github.com/apple/swift-syntax.git", revision: "013a48e2312e57b7b355db25bd3ea75282ebf274"),
    .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMinor(from: "1.1.4")),
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
        "TypeNodes.swift.gyb",
      ]
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
