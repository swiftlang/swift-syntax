// swift-tools-version:5.7

import PackageDescription

let package = Package(
  name: "CodeGeneration",
  platforms: [
      .macOS(.v10_15),
    ],
  products: [
    .executable(name: "generate-swiftbasicformat", targets: ["generate-swiftbasicformat"]),
    .executable(name: "generate-swiftsyntaxbuilder", targets: ["generate-swiftsyntaxbuilder"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-syntax.git", revision: "108a09851eb34b855bd0f9ff3e52ea396b531b58"),
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
        "AttributeNodes.swift.gyb",
        "AvailabilityNodes.swift.gyb",
        "BuilderInitializableTypes.swift.gyb",
        "Classification.swift.gyb",
        "CommonNodes.swift.gyb",
        "DeclNodes.swift.gyb",
        "ExpressibleAsConformances.swift.gyb",
        "ExprNodes.swift.gyb",
        "GenericNodes.swift.gyb",
        "NodeSerializationCodes.swift.gyb",
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
