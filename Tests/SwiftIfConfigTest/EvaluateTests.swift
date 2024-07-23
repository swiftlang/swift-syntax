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
import SwiftIfConfig
import SwiftParser
import SwiftSyntax
import SwiftSyntaxMacrosGenericTestSupport
import XCTest
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
      nil,
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
    let buildConfig = TestingBuildConfiguration(customConditions: ["DEBUG", "ASSERTS"])

    assertIfConfig("DEBUG", .active, configuration: buildConfig)
    assertIfConfig("NODEBUG", .inactive, configuration: buildConfig)
    assertIfConfig("!DEBUG", .inactive, configuration: buildConfig)
    assertIfConfig("!NODEBUG", .active, configuration: buildConfig)
    assertIfConfig("DEBUG && ASSERTS", .active, configuration: buildConfig)
    assertIfConfig("DEBUG && nope", .inactive, configuration: buildConfig)
    assertIfConfig("nope && DEBUG", .inactive, configuration: buildConfig)
    assertIfConfig(
      "nope && 3.14159",
      nil,
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
      nil,
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
      nil,
      configuration: buildConfig,
      diagnostics: [
        DiagnosticSpec(
          message: "invalid conditional compilation expression",
          line: 1,
          column: 12
        )
      ]
    )
  }

  func testBadExpressions() throws {
    let buildConfig = TestingBuildConfiguration(customConditions: ["DEBUG", "ASSERTS"])

    assertIfConfig(
      "3.14159",
      nil,
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
  }

  func testVersions() throws {
    assertIfConfig("swift(>=5.5)", .active)
    assertIfConfig("swift(<6)", .active)
    assertIfConfig("swift(>=6)", .unparsed)
    assertIfConfig("compiler(>=5.8)", .active)
    assertIfConfig("compiler(>=5.9)", .active)
    assertIfConfig("compiler(>=5.10)", .unparsed)
    assertIfConfig(#"_compiler_version("5009.*.1")"#, .active)
    assertIfConfig(#"_compiler_version("5009.*.3.2.3")"#, .unparsed)
    assertIfConfig(#"_compiler_version("5010.*.0")"#, .unparsed)
    assertIfConfig("compiler(>=5.10) && 3.14159", .unparsed)
    assertIfConfig(
      "compiler(>=5.10) || 3.14159",
      nil,
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
      nil,
      diagnostics: [
        DiagnosticSpec(
          message: "invalid conditional compilation expression",
          line: 1,
          column: 20
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
    assertIfConfig("canImport(SwiftSyntax, _underlyingVersion: 5009.10", .inactive)
    assertIfConfig(
      "canImport(SwiftSyntax, _underlyingVersion: 5009.10.5.4.2.3.5",
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
  }
}
