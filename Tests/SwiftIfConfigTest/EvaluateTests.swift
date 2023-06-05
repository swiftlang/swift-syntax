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
import XCTest
import SwiftSyntax
import SwiftParser
import SwiftIfConfig
import _SwiftSyntaxTestSupport

struct TestingBuildConfiguration : BuildConfiguration {
  var customConditions: Set<String> = []
  var features: Set<String> = []
  var attributes: Set<String> = []

  func isCustomConditionSet(name: String, syntax: TokenSyntax) -> Bool? {
    customConditions.contains(name)
  }

  func hasFeature(name: String, syntax: ExprSyntax) -> Bool? {
    features.contains(name)
  }

  func hasAttribute(name: String, syntax: ExprSyntax) -> Bool? {
    attributes.contains(name)
  }

  func isActiveTargetOS(name: String, syntax: SwiftSyntax.ExprSyntax) -> Bool? {
    name == "Linux"
  }

  func isActiveTargetArchitecture(name: String, syntax: SwiftSyntax.ExprSyntax) -> Bool? {
    name == "arm64"
  }

  func isActiveTargetEnvironment(name: String, syntax: SwiftSyntax.ExprSyntax) -> Bool? {
    name == "simulator"
  }

  func isActiveTargetRuntime(name: String, syntax: SwiftSyntax.ExprSyntax) -> Bool? {
    name == "_Native"
  }

  func isActiveTargetPointerAuthentication(name: String, syntax: SwiftSyntax.ExprSyntax) -> Bool? {
    name == "arm64e"
  }

  var targetPointerBitWidth: Int? { 64 }

  var endianness: SwiftIfConfig.Endianness? { .little }
}

public class EvaluateTests: XCTestCase {
  func testLiterals() throws {
    let buildConfig = TestingBuildConfiguration(customConditions: ["DEBUG", "ASSERTS"])

    func ifConfigState(_ condition: ExprSyntax) throws -> IfConfigState {
      try IfConfigState(condition: condition, configuration: buildConfig)
    }

    XCTAssertEqual(try ifConfigState("true"), .active)
    XCTAssertEqual(try ifConfigState("false"), .inactive)

    // FIXME: How can we produce warnings from this code?
    XCTAssertEqual(try ifConfigState("1"), .active)
    XCTAssertEqual(try ifConfigState("0"), .inactive)
  }

  func testCustomConfigs() throws {
    let buildConfig = TestingBuildConfiguration(customConditions: ["DEBUG", "ASSERTS"])

    func ifConfigState(_ condition: ExprSyntax) throws -> IfConfigState {
      try IfConfigState(condition: condition, configuration: buildConfig)
    }

    XCTAssertEqual(try ifConfigState("DEBUG"), .active)
    XCTAssertEqual(try ifConfigState("NODEBUG"), .inactive)
    XCTAssertEqual(try ifConfigState("!DEBUG"), .inactive)
    XCTAssertEqual(try ifConfigState("!NODEBUG"), .active)
    XCTAssertEqual(try ifConfigState("DEBUG && ASSERTS"), .active)
    XCTAssertEqual(try ifConfigState("DEBUG && nope"), .inactive)
    XCTAssertEqual(try ifConfigState("nope && DEBUG"), .inactive)
    XCTAssertEqual(try ifConfigState("nope && 3.14159"), .inactive)
    XCTAssertEqual(try ifConfigState("DEBUG || ASSERTS"), .active)
    XCTAssertEqual(try ifConfigState("DEBUG || nope"), .active)
    XCTAssertEqual(try ifConfigState("nope || DEBUG"), .active)
    XCTAssertEqual(try ifConfigState("nope || !DEBUG"), .inactive)
    XCTAssertEqual(try ifConfigState("DEBUG || 3.14159"), .active)
    XCTAssertEqual(try ifConfigState("(DEBUG) || 3.14159"), .active)
  }

  func testBadExpressions() throws {
    let buildConfig = TestingBuildConfiguration(customConditions: ["DEBUG", "ASSERTS"])

    func ifConfigState(_ condition: ExprSyntax) throws -> IfConfigState {
      try IfConfigState(condition: condition, configuration: buildConfig)
    }

    XCTAssertThrowsError(try ifConfigState("3.14159")) { error in
      XCTAssertEqual(String(describing: error), "invalid conditional compilation expression")
    }
  }

  func testFeatures() throws {
    let buildConfig = TestingBuildConfiguration(features: ["ParameterPacks"])

    func ifConfigState(_ condition: ExprSyntax) throws -> IfConfigState {
      try IfConfigState(condition: condition, configuration: buildConfig)
    }

    XCTAssertEqual(try ifConfigState("hasFeature(ParameterPacks)"), .active)
    XCTAssertEqual(try ifConfigState("hasFeature(HigherKindedGenerics)"), .inactive)
  }

  func testAttributes() throws {
    let buildConfig = TestingBuildConfiguration(attributes: ["available"])

    func ifConfigState(_ condition: ExprSyntax) throws -> IfConfigState {
      try IfConfigState(condition: condition, configuration: buildConfig)
    }

    XCTAssertEqual(try ifConfigState("hasAttribute(available)"), .active)
    XCTAssertEqual(try ifConfigState("hasAttribute(unsafeUnavailable)"), .inactive)
  }

  func testPlatform() throws {
    let buildConfig = TestingBuildConfiguration()

    func ifConfigState(_ condition: ExprSyntax) throws -> IfConfigState {
      try IfConfigState(condition: condition, configuration: buildConfig)
    }

    XCTAssertEqual(try ifConfigState("os(Linux)"), .active)
    XCTAssertEqual(try ifConfigState("os(BeOS)"), .inactive)
    XCTAssertEqual(try ifConfigState("arch(arm64)"), .active)
    XCTAssertEqual(try ifConfigState("arch(x86_64)"), .inactive)
    XCTAssertEqual(try ifConfigState("targetEnvironment(simulator)"), .active)
    XCTAssertEqual(try ifConfigState("targetEnvironment(blargh)"), .inactive)
    XCTAssertEqual(try ifConfigState("_endian(little)"), .active)
    XCTAssertEqual(try ifConfigState("_endian(big)"), .inactive)
    XCTAssertEqual(try ifConfigState("_runtime(_Native)"), .active)
    XCTAssertEqual(try ifConfigState("_runtime(_ObjC)"), .inactive)
    XCTAssertEqual(try ifConfigState("_ptrauth(arm64e)"), .active)
    XCTAssertEqual(try ifConfigState("_ptrauth(none)"), .inactive)
    XCTAssertEqual(try ifConfigState("_pointerBitWidth(_64)"), .active)
    XCTAssertEqual(try ifConfigState("_pointerBitWidth(_32)"), .inactive)
  }
}
