// swift-tools-version:5.6

import PackageDescription

let package = Package(
  name: "SwiftSyntaxGeneration",
  products: [
    .executable(name: "swift-syntax-builder-generation", targets: ["swift-syntax-builder-generation"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-syntax.git", revision: "5bc624dc3a8bca89d6ba6997cdb9392ecbed0ba2"),
  ],
  targets: [
    .executableTarget(
      name: "swift-syntax-builder-generation",
      dependencies: [
        .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
      ],
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
        "Tokens.swift.gyb",
        "Traits.swift.gyb",
        "Trivia.swift.gyb",
        "TypeNodes.swift.gyb"
      ]
    ),
  ]
)
