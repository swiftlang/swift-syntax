// swift-tools-version:5.3

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

// Include the parser library as a binary dependency if both the host and the target are macOS.
//  - We need to require that the host is macOS (checked by `#if os(macOS)`) because package resolve will download and unzip the referenced framework, which requires `unzip` to be installed. Only macOS guarantees that `unzip` is installed, the Swift Docker images don’t have unzip installed, so package resolve would fail.
//  - We need to require that the target is macOS (checked by `.when`) because binary dependencies are only supported by SwiftPM on macOS.
#if os(macOS)
let parserLibraryTarget: [Target] = [.binaryTarget(
  name: "_InternalSwiftSyntaxParser",
  url: "https://github.com/apple/swift-syntax/releases/download/0.50700.1/_InternalSwiftSyntaxParser.xcframework.zip",
  checksum: "956b7acf0ad7177e1a0d250d4938412f1bebf95327e184849872d3cdf2c1e9f4"
)]
let parserLibraryDependency: [Target.Dependency] = [.target(name: "_InternalSwiftSyntaxParser", condition: .when(platforms: [.macOS]))]
#else
let parserLibraryTarget: [Target] = []
let parserLibraryDependency: [Target.Dependency] = []
#endif

let package = Package(
  name: "SwiftSyntax",
  products: [
    .library(name: "SwiftSyntax", type: .static, targets: ["SwiftSyntax"]),
    .library(name: "SwiftSyntaxParser", type: .static, targets: ["SwiftSyntaxParser"]),
    .library(name: "SwiftSyntaxBuilder", type: .static, targets: ["SwiftSyntaxBuilder"])
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
        "SyntaxFactory.swift.gyb",
        "SyntaxTraits.swift.gyb",
        "Trivia.swift.gyb",
        "Misc.swift.gyb",
        "SyntaxRewriter.swift.gyb",
        "SyntaxEnum.swift.gyb",
        "SyntaxClassification.swift.gyb",
        "SyntaxBuilders.swift.gyb",
        "TokenKind.swift.gyb",
        "SyntaxVisitor.swift.gyb",
        "SyntaxCollections.swift.gyb",
        "SyntaxBaseNodes.swift.gyb",
        "SyntaxAnyVisitor.swift.gyb",
        "SyntaxNodes.swift.gyb.template",
        "SyntaxKind.swift.gyb",
      ],
      swiftSettings: swiftSyntaxSwiftSettings
    ),
    .target(
      name: "SwiftSyntaxBuilder",
      dependencies: ["SwiftSyntax"],
      exclude: [
        "gyb_helpers",
        "ExpressibleAsProtocols.swift.gyb",
        "BuildableBaseProtocols.swift.gyb",
        "BuildableCollectionNodes.swift.gyb",
        "BuildableNodes.swift.gyb",
        "ResultBuilders.swift.gyb",
        "Tokens.swift.gyb",
        "TokenSyntax.swift.gyb",
      ]
    ),
    .target(
      name: "SwiftSyntaxParser",
      dependencies: ["SwiftSyntax"] + parserLibraryDependency,
      exclude: [
        "NodeDeclarationHash.swift.gyb"
      ],
      linkerSettings: swiftSyntaxParserLinkerSettings
    ),
    .target(
      name: "lit-test-helper",
      dependencies: ["SwiftSyntax", "SwiftSyntaxParser"]
    ),
    .testTarget(
      name: "SwiftSyntaxTest",
      dependencies: ["SwiftSyntax"]
    ),
    .testTarget(
      name: "SwiftSyntaxBuilderTest",
      dependencies: ["SwiftSyntaxBuilder"]
    ),
    .testTarget(
      name: "SwiftSyntaxParserTest",
      dependencies: ["SwiftSyntaxParser"],
      exclude: ["Inputs"]
    ),
    .testTarget(
      name: "PerformanceTest",
      dependencies: ["SwiftSyntax", "SwiftSyntaxParser"],
      exclude: ["Inputs"]
    ),
  ] + parserLibraryTarget
)
