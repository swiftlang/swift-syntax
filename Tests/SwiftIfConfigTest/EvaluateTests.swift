//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftDiagnostics
import SwiftIfConfig
import SwiftParser
import SwiftSyntax
@_spi(XCTestFailureLocation) @_spi(Testing) import SwiftSyntaxMacrosGenericTestSupport
import XCTest
import _SwiftSyntaxGenericTestSupport
import _SwiftSyntaxTestSupport

public class EvaluateTests: XCTestCase {
  func testLiterals() throws {
    let buildConfig = TestingBuildConfiguration(customConditions: ["DEBUG", "ASSERTS"])

    assertIfConfig("true", .active, configuration: buildConfig)
    assertIfConfig("false", .inactive, configuration: buildConfig)

    assertIfConfig(
      "1",
      .active,
      configuration: buildConfig,
      diagnostics: [
        DiagnosticSpec(
          message: "'1' is not a valid conditional compilation expression, use 'true'",
          line: 1,
          column: 1,
          fixIts: [
            FixItSpec(message: "replace with Boolean literal 'true'")
          ]
        )
      ]
    )
    assertIfConfig(
      "0",
      .inactive,
      configuration: buildConfig,
      diagnostics: [
        DiagnosticSpec(
          message: "'0' is not a valid conditional compilation expression, use 'false'",
          line: 1,
          column: 1,
          fixIts: [
            FixItSpec(message: "replace with Boolean literal 'false'")
          ]
        )
      ]
    )
    assertIfConfig(
      "2",
      .unparsed,
      configuration: buildConfig,
      diagnostics: [
        DiagnosticSpec(
          message: "invalid conditional compilation expression",
          line: 1,
          column: 1
        )
      ]
    )
  }

  func testCustomConfigs() throws {
    let buildConfig = TestingBuildConfiguration(customConditions: ["DEBUG", "ASSERTS", "try"])

    assertIfConfig("DEBUG", .active, configuration: buildConfig)
    assertIfConfig("NODEBUG", .inactive, configuration: buildConfig)
    assertIfConfig("!DEBUG", .inactive, configuration: buildConfig)
    assertIfConfig("!NODEBUG", .active, configuration: buildConfig)
    assertIfConfig("DEBUG && ASSERTS", .active, configuration: buildConfig)
    assertIfConfig("DEBUG && nope", .inactive, configuration: buildConfig)
    assertIfConfig("nope && DEBUG", .inactive, configuration: buildConfig)
    assertIfConfig("`try`", .active, configuration: buildConfig)
    assertIfConfig("`return`", .inactive, configuration: buildConfig)
    assertIfConfig(
      "nope && 3.14159",
      .unparsed,
      configuration: buildConfig,
      diagnostics: [
        DiagnosticSpec(
          message: "invalid conditional compilation expression",
          line: 1,
          column: 9
        )
      ]
    )
    assertIfConfig("DEBUG || ASSERTS", .active, configuration: buildConfig)
    assertIfConfig("DEBUG || nope", .active, configuration: buildConfig)
    assertIfConfig("nope || DEBUG", .active, configuration: buildConfig)
    assertIfConfig("nope || !DEBUG", .inactive, configuration: buildConfig)
    assertIfConfig(
      "DEBUG || 3.14159",
      .active,
      configuration: buildConfig,
      diagnostics: [
        DiagnosticSpec(
          message: "invalid conditional compilation expression",
          line: 1,
          column: 10
        )
      ]
    )
    assertIfConfig(
      "(DEBUG) || 3.14159",
      .active,
      configuration: buildConfig,
      diagnostics: [
        DiagnosticSpec(
          message: "invalid conditional compilation expression",
          line: 1,
          column: 12
        )
      ]
    )
    assertIfConfig(
      "BAR(_:)",
      .unparsed,
      diagnostics: [
        DiagnosticSpec(
          message: "invalid conditional compilation expression",
          line: 1,
          column: 1
        )
      ]
    )
  }

  func testBadExpressions() throws {
    let buildConfig = TestingBuildConfiguration(customConditions: ["DEBUG", "ASSERTS"])

    assertIfConfig(
      "3.14159",
      .unparsed,
      configuration: buildConfig,
      diagnostics: [
        DiagnosticSpec(
          message: "invalid conditional compilation expression",
          line: 1,
          column: 1
        )
      ]
    )

    assertIfConfig(
      "A == B",
      .unparsed,
      configuration: buildConfig,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '&&' or '||' expression",
          line: 1,
          column: 3
        )
      ]
    )

    assertIfConfig(
      "^DEBUG",
      .unparsed,
      diagnostics: [
        DiagnosticSpec(
          message: "expected unary '!' expression",
          line: 1,
          column: 1
        )
      ]
    )
  }

  func testFeatures() throws {
    let buildConfig = TestingBuildConfiguration(features: ["ParameterPacks"])

    assertIfConfig("hasFeature(ParameterPacks)", .active, configuration: buildConfig)
    assertIfConfig("hasFeature(HigherKindedGenerics)", .inactive, configuration: buildConfig)
  }

  func testAttributes() throws {
    let buildConfig = TestingBuildConfiguration(attributes: ["available"])

    assertIfConfig("hasAttribute(available)", .active, configuration: buildConfig)
    assertIfConfig("hasAttribute(unsafeUnavailable)", .inactive, configuration: buildConfig)
  }

  func testPlatform() throws {
    assertIfConfig("os(Linux)", .active)
    assertIfConfig("os(BeOS)", .inactive)
    assertIfConfig("arch(arm64)", .active)
    assertIfConfig("arch(x86_64)", .inactive)
    assertIfConfig("targetEnvironment(simulator)", .active)
    assertIfConfig("targetEnvironment(blargh)", .inactive)
    assertIfConfig("_endian(little)", .active)
    assertIfConfig("_endian(big)", .inactive)
    assertIfConfig("_runtime(_Native)", .active)
    assertIfConfig("_runtime(_ObjC)", .inactive)
    assertIfConfig("_ptrauth(arm64e)", .active)
    assertIfConfig("_ptrauth(none)", .inactive)
    assertIfConfig("_pointerBitWidth(_64)", .active)
    assertIfConfig("_pointerBitWidth(_32)", .inactive)
    assertIfConfig("_hasAtomicBitWidth(_64)", .active)
    assertIfConfig("_hasAtomicBitWidth(_128)", .inactive)

    assertIfConfig(
      "_endian(mid)",
      .inactive,
      diagnostics: [
        DiagnosticSpec(
          message: "unknown endianness for build configuration '_endian' (must be 'big' or 'little')",
          line: 1,
          column: 9,
          severity: .warning
        )
      ]
    )

    assertIfConfig(
      "targetEnvironment(macabi)",
      .inactive,
      diagnostics: [
        DiagnosticSpec(
          message: "'macabi' has been renamed to 'macCatalyst'",
          line: 1,
          column: 19,
          severity: .warning,
          fixIts: [
            FixItSpec(message: "replace with 'macCatalyst'")
          ]
        )
      ]
    )
  }

  func testTargetOS() throws {
    assertIfConfig("TARGET_OS_DISHWASHER", .inactive)

    assertIfConfig(
      "TARGET_OS_IOS",
      .inactive,
      diagnostics: [
        DiagnosticSpec(
          message: "'TARGET_OS_*' preprocessor macros are not available in Swift; use 'os(iOS)' instead",
          line: 1,
          column: 1,
          severity: .warning,
          fixIts: [
            FixItSpec(message: "replace with 'os(iOS)'")
          ]
        )
      ]
    )

    assertIfConfig(
      "TARGET_OS_OSX",
      .inactive,
      diagnostics: [
        DiagnosticSpec(
          message: "'TARGET_OS_*' preprocessor macros are not available in Swift; use 'os(macOS)' instead",
          line: 1,
          column: 1,
          severity: .warning,
          fixIts: [
            FixItSpec(message: "replace with 'os(macOS)'")
          ]
        )
      ]
    )

    assertIfConfig(
      "TARGET_OS_MACCATALYST",
      .inactive,
      diagnostics: [
        DiagnosticSpec(
          message:
            "'TARGET_OS_*' preprocessor macros are not available in Swift; use 'targetEnvironment(macCatalyst)' instead",
          line: 1,
          column: 1,
          severity: .warning,
          fixIts: [
            FixItSpec(message: "replace with 'targetEnvironment(macCatalyst)'")
          ]
        )
      ]
    )

    assertIfConfig(
      "TARGET_OS_WIN32",
      .inactive,
      diagnostics: [
        DiagnosticSpec(
          message: "'TARGET_OS_*' preprocessor macros are not available in Swift; use 'os(...)' conditionals instead",
          line: 1,
          column: 1,
          severity: .warning
        )
      ]
    )
  }

  func testVersions() throws {
    assertIfConfig("swift(>=5.5)", .active)
    assertIfConfig("swift(<6)", .active)
    assertIfConfig("swift(>=6)", .unparsed)
    assertIfConfig(
      "swift(>=...)",
      .unparsed,
      diagnostics: [
        DiagnosticSpec(
          message: "'swift' version check has invalid version ''",
          line: 1,
          column: 9
        )
      ]
    )
    assertIfConfig("compiler(>=5.8)", .active)
    assertIfConfig("compiler(>=5.9)", .active)
    assertIfConfig("compiler(>=5.10)", .unparsed)
    assertIfConfig(#"_compiler_version("5009.*.1")"#, .active)
    assertIfConfig(#"_compiler_version("5009.*.3.2.3")"#, .unparsed)
    assertIfConfig(#"_compiler_version("5010.*.0")"#, .unparsed)
    assertIfConfig("_compiler_version(>=5.8)", .active)
    assertIfConfig("_compiler_version(>=12.0)", .unparsed)
    assertIfConfig("compiler(>=5.10) && 3.14159", .unparsed)
    assertIfConfig(
      "compiler(>=5.10) || 3.14159",
      .unparsed,
      diagnostics: [
        DiagnosticSpec(
          message: "invalid conditional compilation expression",
          line: 1,
          column: 21
        )
      ]
    )
    assertIfConfig("compiler(>=5.9) || 3.14159", .active)
    assertIfConfig(
      "compiler(>=5.9) && 3.14159",
      .unparsed,
      diagnostics: [
        DiagnosticSpec(
          message: "invalid conditional compilation expression",
          line: 1,
          column: 20
        )
      ]
    )
    assertIfConfig(
      #"_compiler_version("...")"#,
      .unparsed,
      diagnostics: [
        DiagnosticSpec(
          message: "found empty version component",
          line: 1,
          column: 20
        )
      ]
    )

    assertIfConfig(
      #"_compiler_version("5.7.100")"#,
      .active,
      diagnostics: [
        DiagnosticSpec(
          message: "the second version component is not used for comparison in legacy compiler versions",
          line: 1,
          column: 19,
          severity: .warning
        )
      ]
    )

    assertIfConfig(
      "swift(version: >=5.5)",
      .unparsed,
      diagnostics: [
        DiagnosticSpec(
          message: "'swift' requires a single unlabeled argument for the version comparison (>= or <= a version)",
          line: 1,
          column: 1,
          severity: .error
        )
      ]
    )

    assertIfConfig(
      #"_compiler_version("5009.*.1000")"#,
      .unparsed,
      diagnostics: [
        DiagnosticSpec(
          message: "compiler version component '1000' is not in the allowed range 0...999",
          line: 1,
          column: 20,
          severity: .error
        )
      ]
    )
  }

  func testCanImport() throws {
    assertIfConfig("canImport(SwiftSyntax)", .active)
    assertIfConfig("canImport(SwiftSyntax.Sub)", .active)
    assertIfConfig("canImport(SwiftParser)", .inactive)
    assertIfConfig("canImport(SwiftSyntax, _version: 5.9)", .active)
    assertIfConfig("canImport(SwiftSyntax, _version: 5.10)", .inactive)
    assertIfConfig(#"canImport(SwiftSyntax, _version: "5.9")"#, .active)
    assertIfConfig("canImport(SwiftSyntax, _underlyingVersion: 5009)", .active)
    assertIfConfig("canImport(SwiftSyntax, _underlyingVersion: 5009.10)", .inactive)
    assertIfConfig(
      "canImport(SwiftSyntax, _underlyingVersion: 5009.10.5.4.2.3.5)",
      .inactive,
      diagnostics: [
        DiagnosticSpec(
          message: "trailing components of version '5009.10.5.4' are ignored",
          line: 1,
          column: 44,
          severity: .warning
        )
      ]
    )
    assertIfConfig(
      "canImport(SwiftSyntax, _version: 20A301)",
      .unparsed,
      diagnostics: [
        DiagnosticSpec(
          message: "'canImport' version check has invalid version '20A301'",
          line: 1,
          column: 34,
          severity: .error
        )
      ]
    )
    assertIfConfig(
      #"canImport(SwiftSyntax, _version: "20A301")"#,
      .unparsed,
      diagnostics: [
        DiagnosticSpec(
          message: #"'canImport' version check has invalid version '"20A301"'"#,
          line: 1,
          column: 34,
          severity: .error
        )
      ]
    )

    assertIfConfig(
      "canImport(A, 2.2)",
      .unparsed,
      diagnostics: [
        DiagnosticSpec(
          message: #"second parameter of 'canImport' should be labeled as _version or _underlyingVersion"#,
          line: 1,
          column: 14,
          severity: .error
        )
      ]
    )

    assertIfConfig(
      "canImport(A, 2.2, 1.1)",
      .unparsed,
      diagnostics: [
        DiagnosticSpec(
          message: #"'canImport' can take only two parameters"#,
          line: 1,
          column: 1,
          severity: .error
        )
      ]
    )

    assertIfConfig(
      "canImport(A(b: 1, c: 2).B.C)",
      .unparsed,
      diagnostics: [
        DiagnosticSpec(
          message: "expected module name",
          line: 1,
          column: 11,
          severity: .error
        )
      ]
    )

    assertIfConfig(
      "canImport(SwiftSyntax) || canImport(ExplodingModule)",
      .active
    )
  }

  func testLikelySimulatorEnvironment() throws {
    assertIfConfig(
      "((os(iOS) || os(tvOS)) && (arch(i386) || arch(x86_64)))",
      .inactive,
      diagnostics: [
        DiagnosticSpec(
          message:
            "platform condition appears to be testing for simulator environment; use 'targetEnvironment(simulator)' instead",
          line: 1,
          column: 2,
          severity: .warning,
          fixIts: [
            FixItSpec(message: "replace with 'targetEnvironment(simulator)'")
          ]
        )
      ]
    )

    assertIfConfig(
      "((os(iOS) || os(tvOS)) && (arch(arm64) || arch(x86_64)))",
      .inactive
    )

    assertIfConfig(
      "((os(iOS) || os(tvOS)) && (arch(i386) || arch(x86_64))) && DEBUG",
      .inactive
    )
  }

  func testDefined() throws {
    let message =
      "compilation conditions in Swift are always boolean and do not need to be checked for existence with 'defined()'"

    assertIfConfig(
      "defined(FOO)",
      .active,
      configuration: TestingBuildConfiguration(customConditions: ["FOO"]),
      diagnostics: [
        DiagnosticSpec(
          message: message,
          line: 1,
          column: 1,
          severity: .error,
          fixIts: [
            FixItSpec(message: "remove 'defined()'")
          ]
        )
      ]
    )

    assertIfConfig(
      "defined(FOO)",
      .inactive,
      diagnostics: [
        DiagnosticSpec(
          message: message,
          line: 1,
          column: 1,
          severity: .error,
          fixIts: [
            FixItSpec(message: "remove 'defined()'")
          ]
        )
      ]
    )

    assertIfConfig(
      "defined(FOO) || BAR || defined(BAZ)",
      .inactive,
      diagnostics: [
        DiagnosticSpec(
          message: message,
          line: 1,
          column: 1,
          severity: .error,
          fixIts: [
            FixItSpec(message: "remove 'defined()'")
          ]
        ),
        DiagnosticSpec(
          message: message,
          line: 1,
          column: 24,
          severity: .error,
          fixIts: [
            FixItSpec(message: "remove 'defined()'")
          ]
        ),
      ]
    )
  }
}

/// Assert the results of evaluating the condition within an `#if` against the
/// given build configuration.
fileprivate func assertIfConfig(
  _ condition: ExprSyntax,
  _ expectedState: IfConfigRegionState,
  configuration: some BuildConfiguration = TestingBuildConfiguration(),
  diagnostics expectedDiagnostics: [DiagnosticSpec] = [],
  file: StaticString = #filePath,
  line: UInt = #line
) {
  // Evaluate the condition to check the state.
  let actualDiagnostics: [Diagnostic]
  let actualState: IfConfigRegionState
  (actualState, _, actualDiagnostics) = IfConfigRegionState.evaluating(condition, in: configuration)
  XCTAssertEqual(actualState, expectedState, file: file, line: line)

  // Check the diagnostics.
  if actualDiagnostics.count != expectedDiagnostics.count {
    XCTFail(
      """
      Expected \(expectedDiagnostics.count) diagnostics, but got \(actualDiagnostics.count):
      \(actualDiagnostics.map(\.debugDescription).joined(separator: "\n"))
      """,
      file: file,
      line: line
    )
  } else {
    for (actualDiag, expectedDiag) in zip(actualDiagnostics, expectedDiagnostics) {
      assertDiagnostic(
        actualDiag,
        in: .tree(condition),
        expected: expectedDiag,
        failureHandler: {
          XCTFail($0.message, file: $0.location.staticFilePath, line: $0.location.unsignedLine)
        }
      )
    }
  }
}
