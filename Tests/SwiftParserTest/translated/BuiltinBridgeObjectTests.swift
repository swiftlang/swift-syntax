//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// This test file has been translated from swift/test/Parse/builtin_bridge_object.swift

import XCTest

final class BuiltinBridgeObjectTests: XCTestCase {
  func testBuiltinBridgeObject1() {
    AssertParse(
      """
      precedencegroup AssignmentPrecedence { assignment: true }
      """
    )
  }

  func testBuiltinBridgeObject2() {
    AssertParse(
      """
      var word: Builtin.Word
      """
    )
  }

  func testBuiltinBridgeObject3() {
    AssertParse(
      """
      class C {}
      """
    )
  }

  func testBuiltinBridgeObject4() {
    AssertParse(
      """
      var c: C
      let bo = Builtin.castToBridgeObject(c, word)
      c = Builtin.castReferenceFromBridgeObject(bo)
      word = Builtin.castBitPatternFromBridgeObject(bo)
      """
    )
  }

}
