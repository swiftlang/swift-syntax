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
