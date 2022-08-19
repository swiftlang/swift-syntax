// swift-tools-version:5.5

import PackageDescription
import Foundation

/// If we are in a controlled CI environment, we can use internal compiler flags
/// to speed up the build or improve it.
let swiftSyntaxSwiftSettings: [SwiftSetting]
if ProcessInfo.processInfo.environment["SWIFT_BUILD_SCRIPT_ENVIRONMENT"] != nil {
  let groupFile = URL(fileURLWithPath: #file)
    .deletingLastPathComponent()
    .appendingPathComponent("utils")
    .appendingPathComponent("group.json")
  swiftSyntaxSwiftSettings = [.unsafeFlags([
    "-Xfrontend", "-group-info-path", 
    "-Xfrontend", groupFile.path, 
    // Enforcing exclusivity increases compile time of release builds by 2 minutes.
    // Disable it when we're in a controlled CI environment.
    "-enforce-exclusivity=unchecked",
  ])]
} else {
  swiftSyntaxSwiftSettings = []
}

/// If the `lib_InternalSwiftSyntaxParser.dylib` is not in the standard search
/// paths (which is the standard case on macOS),
/// `SWIFT_SYNTAX_PARSER_LIB_SEARCH_PATH` can be used to add a rpath at which
/// the parser lib should be searched.
let swiftSyntaxParserLinkerSettings: [LinkerSetting]
if let parserLibSearchPath = ProcessInfo.processInfo.environment["SWIFT_SYNTAX_PARSER_LIB_SEARCH_PATH"] {
  swiftSyntaxParserLinkerSettings = [.unsafeFlags([
    "-Xlinker", "-rpath", "-Xlinker", parserLibSearchPath
  ])]
} else {
  swiftSyntaxParserLinkerSettings = []
}

let package = Package(
  name: "SwiftSyntax",
  platforms: [
    .macOS(.v10_15),
    .iOS(.v13),
    .tvOS(.v13),
    .watchOS(.v6),
    .macCatalyst(.v13),
  ],
  products: [
    .library(name: "SwiftSyntax", type: .static, targets: ["SwiftSyntax"]),
    .library(name: "SwiftSyntaxParser", type: .static, targets: ["SwiftSyntaxParser"]),
    .library(name: "SwiftSyntaxBuilder", type: .static, targets: ["SwiftSyntaxBuilder"]),
    .executable(name: "generate-swift-syntax-builder", targets: ["generate-swift-syntax-builder"])
  ],
  targets: [
    .target(
      name: "_CSwiftSyntax",
      exclude: [
        "README.md"
      ]
    ),
    .target(
      name: "SwiftSyntax",
      dependencies: ["_CSwiftSyntax"],
      exclude: [
        "Misc.swift.gyb",
        "Raw/RawSyntaxNodes.swift.gyb",
        "Raw/RawSyntaxValidation.swift.gyb",
        "SyntaxAnyVisitor.swift.gyb",
        "SyntaxBaseNodes.swift.gyb",
        "SyntaxClassification.swift.gyb",
        "SyntaxCollections.swift.gyb",
        "SyntaxEnum.swift.gyb",
        "SyntaxFactory.swift.gyb",
        "SyntaxKind.swift.gyb",
        "SyntaxNodes.swift.gyb.template",
        "SyntaxRewriter.swift.gyb",
        "SyntaxTraits.swift.gyb",
        "SyntaxVisitor.swift.gyb",
        "TokenKind.swift.gyb",
        "Tokens.swift.gyb",
        "Trivia.swift.gyb",
      ],
      swiftSettings: swiftSyntaxSwiftSettings
    ),
    .target(
      name: "SwiftSyntaxBuilder",
      dependencies: ["SwiftSyntax"],
      exclude: [
        "gyb_helpers",
        "ResultBuilders.swift.gyb",
      ]
    ),
    .target(
      name: "SwiftSyntaxParser",
      dependencies: ["SwiftSyntax"],
      exclude: [
        "NodeDeclarationHash.swift.gyb",
        "Serialization.swift.gyb",
      ],
      linkerSettings: swiftSyntaxParserLinkerSettings
    ),
    .target(
      name: "_SwiftSyntaxTestSupport",
      dependencies: ["SwiftSyntax"]
    ),
    .executableTarget(
      name: "lit-test-helper",
      dependencies: ["SwiftSyntax", "SwiftSyntaxParser"]
    ),
    .executableTarget(
        name: "generate-swift-syntax-builder",
        dependencies: ["SwiftSyntaxBuilder"],
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
    .testTarget(
      name: "SwiftSyntaxTest",
      dependencies: ["SwiftSyntax", "_SwiftSyntaxTestSupport"]
    ),
    .testTarget(
      name: "SwiftSyntaxBuilderTest",
      dependencies: ["SwiftSyntaxBuilder"]
    ),
    .testTarget(
      name: "SwiftSyntaxParserTest",
      dependencies: ["SwiftSyntaxParser", "_SwiftSyntaxTestSupport"],
      exclude: ["Inputs"]
    ),
    .testTarget(
      name: "PerformanceTest",
      dependencies: ["SwiftSyntax", "SwiftSyntaxParser"],
      exclude: ["Inputs"]
    ),
  ]
)

#if swift(>=5.6)
// If `SWIFTCI_USE_LOCAL_DEPS` is set, we are in a CI enviornment that might disallow
// internet access, so we can't load swift-docc-plugin. Simply don't load it in these
// environments because we don't build docc in CI at the moment.
if ProcessInfo.processInfo.environment["SWIFTCI_USE_LOCAL_DEPS"] == nil {
    package.dependencies.append(.package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"))
}
#endif
