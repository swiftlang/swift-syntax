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
    .library(name: "IDEUtils", type: .static, targets: ["IDEUtils"]),
    .library(name: "SwiftDiagnostics", type: .static, targets: ["SwiftDiagnostics"]),
    .library(name: "SwiftOperators", type: .static, targets: ["SwiftOperators"]),
    .library(name: "SwiftParser", type: .static, targets: ["SwiftParser"]),
    .library(name: "SwiftParserDiagnostics", type: .static, targets: ["SwiftParserDiagnostics"]),
    .library(name: "SwiftSyntax", type: .static, targets: ["SwiftSyntax"]),
    .library(name: "SwiftSyntaxParser", type: .static, targets: ["SwiftSyntaxParser"]),
    .library(name: "SwiftSyntaxBuilder", type: .static, targets: ["SwiftSyntaxBuilder"]),
    .library(name: "_SwiftSyntaxMacros", type: .static, targets: ["_SwiftSyntaxMacros"]),
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
      dependencies: ["SwiftBasicFormat", "SwiftSyntax", "SwiftParser", "SwiftParserDiagnostics"],
      exclude: [
        "CMakeLists.txt",
        "SyntaxExpressibleByStringInterpolationConformances.swift.gyb",
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
      dependencies: ["SwiftBasicFormat", "SwiftSyntax", "SwiftSyntaxBuilder"]
    ),
    .target(
      name: "IDEUtils",
      dependencies: ["SwiftSyntax"],
      exclude: [
        "SyntaxClassification.swift.gyb",
      ]
    ),
    .target(
      name: "SwiftParser",
      dependencies: ["SwiftDiagnostics", "SwiftSyntax"],
      exclude: [
        "CMakeLists.txt",
        "README.md",
        "TypeAttribute.swift.gyb",
        "DeclarationModifier.swift.gyb",
        "DeclarationAttribute.swift.gyb",
      ]
    ),
    .target(
      name: "SwiftParserDiagnostics",
      dependencies: ["SwiftBasicFormat", "SwiftDiagnostics", "SwiftParser", "SwiftSyntax"],
      exclude: [
        "CMakeLists.txt",
      ]
    ),
    .target(
      name: "SwiftOperators",
      dependencies: ["SwiftSyntax", "SwiftParser", "SwiftDiagnostics"],
      exclude: [
        "CMakeLists.txt",
      ]
    ),
    .target(
      name: "SwiftCompilerSupport",
      dependencies: ["SwiftSyntax", "SwiftParser", "SwiftParserDiagnostics",
                     "SwiftDiagnostics", "SwiftOperators"],
      exclude: [
        "CMakeLists.txt",
        "SwiftCompilerSupport.h"
      ]
    ),
    .target(
      name: "_SwiftSyntaxMacros",
      dependencies: [
        "SwiftSyntax", "SwiftSyntaxBuilder", "SwiftParser", "SwiftDiagnostics"
      ],
      exclude: [
        "CMakeLists.txt",
      ]),
    .executableTarget(
      name: "lit-test-helper",
      dependencies: ["IDEUtils", "SwiftSyntax", "SwiftSyntaxParser"]
    ),
    .executableTarget(
      name: "swift-parser-cli",
      dependencies: ["SwiftDiagnostics", "SwiftSyntax", "SwiftParser", "SwiftParserDiagnostics", "SwiftOperators", "_SwiftSyntaxMacros",
                     .product(name: "ArgumentParser", package: "swift-argument-parser")]
    ),
    .testTarget(name: "IDEUtilsTest", dependencies: ["_SwiftSyntaxTestSupport", "SwiftParser", "SwiftSyntax", "IDEUtils"]),
    .testTarget(
      name: "SwiftDiagnosticsTest",
      dependencies: ["_SwiftSyntaxTestSupport", "SwiftDiagnostics", "SwiftParser", "SwiftParserDiagnostics"]
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
      name: "SwiftSyntaxMacrosTest",
      dependencies: ["SwiftDiagnostics", "SwiftOperators", "SwiftParser",
                     "_SwiftSyntaxTestSupport", "SwiftSyntaxBuilder",
                     "_SwiftSyntaxMacros"]
    ),
    .testTarget(
      name: "PerformanceTest",
      dependencies: ["IDEUtils", "SwiftSyntax", "SwiftSyntaxParser", "SwiftParser"],
      exclude: ["Inputs"]
    ),
    .testTarget(
      name: "SwiftParserTest",
      dependencies: ["SwiftDiagnostics", "SwiftOperators", "SwiftParser",
                     "_SwiftSyntaxTestSupport", "SwiftSyntaxBuilder"]
    ),
    .testTarget(
      name: "SwiftParserDiagnosticsTest",
      dependencies: ["SwiftDiagnostics", "SwiftParserDiagnostics"]
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
