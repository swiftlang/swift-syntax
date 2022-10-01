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
    .library(name: "SwiftOperators", type: .static, targets: ["SwiftOperators"]),
    .library(name: "SwiftParser", type: .static, targets: ["SwiftParser"]),
    .library(name: "SwiftSyntax", type: .static, targets: ["SwiftSyntax"]),
    .library(name: "SwiftSyntaxParser", type: .static, targets: ["SwiftSyntaxParser"]),
    .library(name: "SwiftSyntaxBuilder", type: .static, targets: ["SwiftSyntaxBuilder"]),
  ],
  targets: [
    .target(
      name: "SwiftBasicFormat",
      dependencies: ["SwiftSyntax"],
      exclude: [
        "CMakeLists.txt"
      ]
    ),
    .target(
      name: "SwiftDiagnostics",
      dependencies: ["SwiftSyntax"],
      exclude: [
        "CMakeLists.txt"
      ]
    ),
    .target(
      name: "SwiftSyntax",
      dependencies: [],
      exclude: [
        "CMakeLists.txt",
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
        "SyntaxTransform.swift.gyb",
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
      dependencies: ["SwiftBasicFormat", "SwiftSyntax", "SwiftParser"],
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
    .target(
      name: "SwiftParser",
      dependencies: ["SwiftBasicFormat", "SwiftDiagnostics", "SwiftSyntax"],
      exclude: [
        "CMakeLists.txt",
        "README.md",
        "TypeAttribute.swift.gyb",
        "DeclarationModifier.swift.gyb",
        "DeclarationAttribute.swift.gyb",
      ]
    ),
    .target(
      name: "SwiftOperators",
      dependencies: ["SwiftSyntax", "SwiftParser", "SwiftDiagnostics"]
    ),
    .target(
      name: "SwiftCompilerSupport",
      dependencies: [
        "SwiftSyntax", "SwiftParser", "SwiftDiagnostics", "SwiftOperators"],
      exclude: [
        "CMakeLists.txt",
        "SwiftCompilerSupport.h"
      ]
    ),
    .executableTarget(
      name: "lit-test-helper",
      dependencies: ["SwiftSyntax", "SwiftSyntaxParser"]
    ),
    .executableTarget(
      name: "swift-parser-test",
      dependencies: ["SwiftDiagnostics", "SwiftSyntax", "SwiftParser",
                     "SwiftOperators",
                     .product(name: "ArgumentParser", package: "swift-argument-parser")]
    ),
    .testTarget(
      name: "SwiftBasicFormatTest",
      dependencies: ["SwiftBasicFormat"]
    ),
    .testTarget(
      name: "SwiftSyntaxTest",
      dependencies: ["SwiftSyntax", "_SwiftSyntaxTestSupport"]
    ),
    .testTarget(
      name: "SwiftSyntaxBuilderTest",
      dependencies: ["_SwiftSyntaxTestSupport", "SwiftSyntaxBuilder"]
    ),
    .testTarget(
      name: "SwiftSyntaxParserTest",
      dependencies: ["SwiftSyntaxParser", "_SwiftSyntaxTestSupport"],
      exclude: ["Inputs"]
    ),
    .testTarget(
      name: "PerformanceTest",
      dependencies: ["SwiftSyntax", "SwiftSyntaxParser", "SwiftParser"],
      exclude: ["Inputs"]
    ),
    .testTarget(
      name: "SwiftParserTest",
      dependencies: ["SwiftDiagnostics", "SwiftOperators", "SwiftParser",
                     "_SwiftSyntaxTestSupport", "SwiftSyntaxBuilder"]
    ),
    .testTarget(
      name: "SwiftOperatorsTest",
      dependencies: ["SwiftOperators", "_SwiftSyntaxTestSupport",
                     "SwiftParser"]
    ),
  ]
)

if ProcessInfo.processInfo.environment["SWIFTCI_USE_LOCAL_DEPS"] == nil {
  // Building standalone.
  package.dependencies += [
    .package(url: "https://github.com/apple/swift-argument-parser.git", Version("1.0.1")..<Version("1.2.0")),
  ]
} else {
  package.dependencies += [
    .package(path: "../swift-argument-parser")
  ]
}
