// swift-tools-version:5.5

import PackageDescription
import Foundation

/// If we are in a controlled CI environment, we can use internal compiler flags
/// to speed up the build or improve it.
var swiftSyntaxSwiftSettings: [SwiftSetting] = []
if ProcessInfo.processInfo.environment["SWIFT_BUILD_SCRIPT_ENVIRONMENT"] != nil {
  let groupFile = URL(fileURLWithPath: #file)
    .deletingLastPathComponent()
    .appendingPathComponent("utils")
    .appendingPathComponent("group.json")
  swiftSyntaxSwiftSettings += [
    .define("SWIFTSYNTAX_ENABLE_ASSERTIONS"),
    .unsafeFlags([
      "-Xfrontend", "-group-info-path",
      "-Xfrontend", groupFile.path,
      // Enforcing exclusivity increases compile time of release builds by 2 minutes.
      // Disable it when we're in a controlled CI environment.
      "-enforce-exclusivity=unchecked",
    ]),
  ]
}
if ProcessInfo.processInfo.environment["SWIFTSYNTAX_ENABLE_RAWSYNTAX_VALIDATION"] != nil {
  swiftSyntaxSwiftSettings += [
    .define("SWIFTSYNTAX_ENABLE_RAWSYNTAX_VALIDATION")
  ]
}

var swiftParserSwiftSettings: [SwiftSetting] = []
if ProcessInfo.processInfo.environment["SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION"] != nil {
  swiftParserSwiftSettings += [
    .define("SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION")
  ]
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
    .library(name: "SwiftCompilerPlugin", type: .static, targets: ["SwiftCompilerPlugin"]),
    .library(name: "SwiftCompilerPluginMessageHandling", type: .static, targets: ["SwiftCompilerPluginMessageHandling"]),
    .library(name: "SwiftDiagnostics", type: .static, targets: ["SwiftDiagnostics"]),
    .library(name: "SwiftOperators", type: .static, targets: ["SwiftOperators"]),
    .library(name: "SwiftParser", type: .static, targets: ["SwiftParser"]),
    .library(name: "SwiftParserDiagnostics", type: .static, targets: ["SwiftParserDiagnostics"]),
    .library(name: "SwiftRefactor", type: .static, targets: ["SwiftRefactor"]),
    .library(name: "SwiftSyntax", type: .static, targets: ["SwiftSyntax"]),
    .library(name: "SwiftSyntaxBuilder", type: .static, targets: ["SwiftSyntaxBuilder"]),
    .library(name: "SwiftSyntaxMacros", type: .static, targets: ["SwiftSyntaxMacros"]),
  ],
  targets: [
    // MARK: - Internal helper targets

    .target(
      name: "_InstructionCounter"
    ),

    .target(
      name: "_SwiftSyntaxTestSupport",
      dependencies: ["SwiftBasicFormat", "SwiftSyntax", "SwiftSyntaxBuilder"]
    ),

    .testTarget(
      name: "SwiftSyntaxTestSupportTest",
      dependencies: ["_SwiftSyntaxTestSupport", "SwiftParser"]
    ),

    // MARK: - Library targets
    // Formatting style:
    //  - One section for each target and its test target
    //  - Sections are sorted alphabetically
    //  - Each target argument takes exactly one line, unless there are external dependencies.
    //    In that case package and internal dependencies are on different lines.
    //  - All array elements are sorted alphabetically

    // MARK: IDEUtils

    .target(
      name: "IDEUtils",
      dependencies: ["SwiftSyntax"],
      exclude: ["CMakeLists.txt"]
    ),

    .testTarget(
      name: "IDEUtilsTest",
      dependencies: ["_SwiftSyntaxTestSupport", "IDEUtils", "SwiftParser", "SwiftSyntax"]
    ),

    // MARK: SwiftBasicFormat

    .target(
      name: "SwiftBasicFormat",
      dependencies: ["SwiftSyntax"],
      exclude: ["CMakeLists.txt"]
    ),

    .testTarget(
      name: "SwiftBasicFormatTest",
      dependencies: ["_SwiftSyntaxTestSupport", "SwiftBasicFormat", "SwiftSyntaxBuilder"]
    ),

    // MARK: SwiftCompilerPlugin

    .target(
      name: "SwiftCompilerPlugin",
      dependencies: ["SwiftCompilerPluginMessageHandling", "SwiftSyntaxMacros"]
    ),

    .testTarget(
      name: "SwiftCompilerPluginTest",
      dependencies: ["SwiftCompilerPlugin"]
    ),

    // MARK: SwiftCompilerPluginMessageHandling

    .target(
      name: "SwiftCompilerPluginMessageHandling",
      dependencies: ["SwiftDiagnostics", "SwiftOperators", "SwiftParser", "SwiftSyntax", "SwiftSyntaxMacros"],
      exclude: ["CMakeLists.txt"]
    ),

    // MARK: SwiftDiagnostics

    .target(
      name: "SwiftDiagnostics",
      dependencies: ["SwiftSyntax"],
      exclude: ["CMakeLists.txt"]
    ),

    .testTarget(
      name: "SwiftDiagnosticsTest",
      dependencies: ["_SwiftSyntaxTestSupport", "SwiftDiagnostics", "SwiftParser", "SwiftParserDiagnostics"]
    ),

    // MARK: SwiftSyntax

    .target(
      name: "SwiftSyntax",
      dependencies: [],
      exclude: ["CMakeLists.txt"],
      swiftSettings: swiftSyntaxSwiftSettings
    ),

    .testTarget(
      name: "SwiftSyntaxTest",
      dependencies: ["_SwiftSyntaxTestSupport", "SwiftSyntax"]
    ),

    // MARK: SwiftSyntaxBuilder

    .target(
      name: "SwiftSyntaxBuilder",
      dependencies: ["SwiftBasicFormat", "SwiftParser", "SwiftParserDiagnostics", "SwiftSyntax"],
      exclude: ["CMakeLists.txt"]
    ),

    .testTarget(
      name: "SwiftSyntaxBuilderTest",
      dependencies: ["_SwiftSyntaxTestSupport", "SwiftSyntaxBuilder"]
    ),

    // MARK: SwiftSyntaxMacros

    .target(
      name: "SwiftSyntaxMacros",
      dependencies: ["SwiftDiagnostics", "SwiftParser", "SwiftSyntax", "SwiftSyntaxBuilder"],
      exclude: ["CMakeLists.txt"]
    ),

    .testTarget(
      name: "SwiftSyntaxMacrosTest",
      dependencies: ["_SwiftSyntaxTestSupport", "SwiftDiagnostics", "SwiftOperators", "SwiftParser", "SwiftSyntaxBuilder", "SwiftSyntaxMacros"]
    ),

    // MARK: SwiftParser

    .target(
      name: "SwiftParser",
      dependencies: ["SwiftSyntax"],
      exclude: ["CMakeLists.txt", "README.md"],
      swiftSettings: swiftParserSwiftSettings

    ),

    .testTarget(
      name: "SwiftParserTest",
      dependencies: ["_SwiftSyntaxTestSupport", "SwiftDiagnostics", "SwiftOperators", "SwiftParser", "SwiftSyntaxBuilder"],
      swiftSettings: swiftParserSwiftSettings
    ),

    // MARK: SwiftParserDiagnostics

    .target(
      name: "SwiftParserDiagnostics",
      dependencies: ["SwiftBasicFormat", "SwiftDiagnostics", "SwiftParser", "SwiftSyntax"],
      exclude: ["CMakeLists.txt"]
    ),

    .testTarget(
      name: "SwiftParserDiagnosticsTest",
      dependencies: ["SwiftDiagnostics", "SwiftParserDiagnostics"]
    ),

    // MARK: SwiftOperators

    .target(
      name: "SwiftOperators",
      dependencies: ["SwiftDiagnostics", "SwiftParser", "SwiftSyntax"],
      exclude: [
        "CMakeLists.txt"
      ]
    ),

    .testTarget(
      name: "SwiftOperatorsTest",
      dependencies: ["_SwiftSyntaxTestSupport", "SwiftOperators", "SwiftParser"]
    ),

    // MARK: SwiftRefactor

    .target(
      name: "SwiftRefactor",
      dependencies: ["SwiftParser", "SwiftSyntax"]
    ),

    .testTarget(
      name: "SwiftRefactorTest",
      dependencies: ["_SwiftSyntaxTestSupport", "SwiftRefactor", "SwiftSyntaxBuilder"]
    ),

    // MARK: - Executable targets

    .executableTarget(
      name: "swift-parser-cli",
      dependencies: [
        "_InstructionCounter", "SwiftDiagnostics", "SwiftOperators", "SwiftParser", "SwiftParserDiagnostics", "SwiftSyntax",
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
      ]
    ),

    // MARK: - Deprecated targets

    // MARK: lit-test-helper
    // TODO: All the lit-based tests should be migrated to XCTest so we don't have a
    // dependency on FileCheck

    .executableTarget(
      name: "lit-test-helper",
      dependencies: ["IDEUtils", "SwiftSyntax", "SwiftParser"]
    ),

    // MARK: PerformanceTest
    // TODO: Should be included in SwiftParserTest/SwiftSyntaxTest

    .testTarget(
      name: "PerformanceTest",
      dependencies: ["IDEUtils", "SwiftParser", "SwiftSyntax"],
      exclude: ["Inputs"]
    ),
  ]
)

if ProcessInfo.processInfo.environment["SWIFTCI_USE_LOCAL_DEPS"] == nil {
  // Building standalone.
  package.dependencies += [
    .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMinor(from: "1.2.2"))
  ]
} else {
  package.dependencies += [
    .package(path: "../swift-argument-parser")
  ]
}
