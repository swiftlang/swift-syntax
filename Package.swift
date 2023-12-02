// swift-tools-version:5.7

import Foundation
import PackageDescription

var swiftSyntaxSwiftSettings: [SwiftSetting] = []
var swiftSyntaxBuilderSwiftSettings: [SwiftSetting] = []
var swiftParserSwiftSettings: [SwiftSetting] = []

/// If we are in a controlled CI environment, we can use internal compiler flags
/// to speed up the build or improve it.
if ProcessInfo.processInfo.environment["SWIFT_BUILD_SCRIPT_ENVIRONMENT"] != nil {
  swiftSyntaxSwiftSettings += [
    .define("SWIFTSYNTAX_ENABLE_ASSERTIONS")
  ]
  swiftSyntaxBuilderSwiftSettings += [
    .define("SWIFTSYNTAX_NO_OSLOG_DEPENDENCY")
  ]
  swiftParserSwiftSettings += [
    .define("SWIFTSYNTAX_NO_OSLOG_DEPENDENCY")
  ]
}

if ProcessInfo.processInfo.environment["SWIFTSYNTAX_ENABLE_RAWSYNTAX_VALIDATION"] != nil {
  swiftSyntaxSwiftSettings += [
    .define("SWIFTSYNTAX_ENABLE_RAWSYNTAX_VALIDATION")
  ]
}

if ProcessInfo.processInfo.environment["SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION"] != nil {
  swiftParserSwiftSettings += [
    .define("SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION")
  ]
}

let package = Package(
  name: "swift-syntax",
  platforms: [
    .macOS(.v10_15),
    .iOS(.v13),
    .tvOS(.v13),
    .watchOS(.v6),
    .macCatalyst(.v13),
  ],
  products: [
    .library(name: "SwiftBasicFormat", targets: ["SwiftBasicFormat"]),
    .library(name: "SwiftCompilerPlugin", targets: ["SwiftCompilerPlugin"]),
    .library(name: "SwiftCompilerPluginMessageHandling", targets: ["SwiftCompilerPluginMessageHandling"]),
    .library(name: "SwiftDiagnostics", targets: ["SwiftDiagnostics"]),
    .library(name: "SwiftIDEUtils", targets: ["SwiftIDEUtils"]),
    .library(name: "SwiftOperators", targets: ["SwiftOperators"]),
    .library(name: "SwiftParser", targets: ["SwiftParser"]),
    .library(name: "SwiftParserDiagnostics", targets: ["SwiftParserDiagnostics"]),
    .library(name: "SwiftRefactor", targets: ["SwiftRefactor"]),
    .library(name: "SwiftSyntax", targets: ["SwiftSyntax"]),
    .library(name: "SwiftSyntaxBuilder", targets: ["SwiftSyntaxBuilder"]),
    .library(name: "SwiftSyntaxMacros", targets: ["SwiftSyntaxMacros"]),
    .library(name: "SwiftSyntaxMacroExpansion", targets: ["SwiftSyntaxMacroExpansion"]),
    .library(name: "SwiftSyntaxMacrosTestSupport", targets: ["SwiftSyntaxMacrosTestSupport"]),
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
      dependencies: ["SwiftDiagnostics", "SwiftOperators", "SwiftParser", "SwiftSyntax", "SwiftSyntaxMacros", "SwiftSyntaxMacroExpansion"],
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

    // MARK: SwiftIDEUtils

    .target(
      name: "SwiftIDEUtils",
      dependencies: ["SwiftSyntax"],
      exclude: ["CMakeLists.txt"]
    ),

    .testTarget(
      name: "SwiftIDEUtilsTest",
      dependencies: ["_SwiftSyntaxTestSupport", "SwiftIDEUtils", "SwiftParser", "SwiftSyntax"]
    ),

    // MARK: SwiftSyntax

    .target(
      name: "SwiftSyntax",
      dependencies: ["SwiftSyntax509", "SwiftSyntax510"],
      exclude: ["CMakeLists.txt"],
      swiftSettings: swiftSyntaxSwiftSettings
    ),

    .testTarget(
      name: "SwiftSyntaxTest",
      dependencies: ["_SwiftSyntaxTestSupport", "SwiftSyntax", "SwiftSyntaxBuilder"]
    ),

    // MARK: Verison marker modules

    .target(
      name: "SwiftSyntax509",
      dependencies: []
    ),

    .target(
      name: "SwiftSyntax510",
      dependencies: []
    ),

    // MARK: SwiftSyntaxBuilder

    .target(
      name: "SwiftSyntaxBuilder",
      dependencies: ["SwiftBasicFormat", "SwiftParser", "SwiftDiagnostics", "SwiftParserDiagnostics", "SwiftSyntax"],
      exclude: ["CMakeLists.txt"],
      swiftSettings: swiftSyntaxBuilderSwiftSettings
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

    // MARK: SwiftSyntaxMacroExpansion

    .target(
      name: "SwiftSyntaxMacroExpansion",
      dependencies: ["SwiftSyntax", "SwiftSyntaxBuilder", "SwiftSyntaxMacros", "SwiftDiagnostics", "SwiftOperators"],
      exclude: ["CMakeLists.txt"]
    ),

    .testTarget(
      name: "SwiftSyntaxMacroExpansionTest",
      dependencies: [
        "SwiftSyntax", "_SwiftSyntaxTestSupport", "SwiftDiagnostics", "SwiftOperators", "SwiftParser", "SwiftSyntaxBuilder", "SwiftSyntaxMacros",
        "SwiftSyntaxMacroExpansion", "SwiftSyntaxMacrosTestSupport",
      ]
    ),

    // MARK: SwiftSyntaxMacrosTestSupport

    .target(
      name: "SwiftSyntaxMacrosTestSupport",
      dependencies: ["_SwiftSyntaxTestSupport", "SwiftDiagnostics", "SwiftParser", "SwiftSyntaxMacros", "SwiftSyntaxMacroExpansion"]
    ),

    .testTarget(
      name: "SwiftSyntaxMacrosTestSupportTests",
      dependencies: ["SwiftDiagnostics", "SwiftSyntax", "SwiftSyntaxMacros", "SwiftSyntaxMacrosTestSupport"]
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
      dependencies: ["SwiftBasicFormat", "SwiftParser", "SwiftSyntax", "SwiftSyntaxBuilder"]
    ),

    .testTarget(
      name: "SwiftRefactorTest",
      dependencies: ["_SwiftSyntaxTestSupport", "SwiftRefactor"]
    ),

    // MARK: - Deprecated targets

    // MARK: PerformanceTest
    // TODO: Should be included in SwiftParserTest/SwiftSyntaxTest

    .testTarget(
      name: "PerformanceTest",
      dependencies: ["_InstructionCounter", "SwiftIDEUtils", "SwiftParser", "SwiftSyntax"],
      exclude: ["Inputs"]
    ),
  ]
)

// This is a fake target that depends on all targets in the package.
// We need to define it manually because the `SwiftSyntax-Package` target doesn't exist for `swift build`.

package.targets.append(
  .target(
    name: "SwiftSyntax-all",
    dependencies: package.targets.compactMap {
      if $0.type == .test {
        return nil
      } else {
        return .byName(name: $0.name)
      }
    }
  )
)
