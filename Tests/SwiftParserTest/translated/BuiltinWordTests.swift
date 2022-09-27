// This test file has been translated from swift/test/Parse/builtin_word.swift

import XCTest

final class BuiltinWordTests: XCTestCase {
  func testBuiltinWord1() {
    AssertParse(
      """
      precedencegroup AssignmentPrecedence { assignment: true }
      """
    )
  }

  func testBuiltinWord2() {
    AssertParse(
      """
      var word: Builtin.Word
      var i16: Builtin.Int16
      var i32: Builtin.Int32
      var i64: Builtin.Int64
      var i128: Builtin.Int128
      """
    )
  }

  func testBuiltinWord3() {
    AssertParse(
      """
      // Check that trunc/?ext operations are appropriately available given the
      // abstract range of potential Word sizes.
      """
    )
  }

  func testBuiltinWord4() {
    AssertParse(
      """
      word = Builtin.truncOrBitCast_Int128_Word(i128)
      word = Builtin.truncOrBitCast_Int64_Word(i64)
      word = Builtin.truncOrBitCast_Int32_Word(i32) 
      word = Builtin.truncOrBitCast_Int16_Word(i16)
      """
    )
  }

  func testBuiltinWord5() {
    AssertParse(
      """
      i16 = Builtin.truncOrBitCast_Word_Int16(word)
      i32 = Builtin.truncOrBitCast_Word_Int32(word)
      i64 = Builtin.truncOrBitCast_Word_Int64(word) 
      i128 = Builtin.truncOrBitCast_Word_Int128(word)
      """
    )
  }

  func testBuiltinWord6() {
    AssertParse(
      """
      word = Builtin.zextOrBitCast_Int128_Word(i128) 
      word = Builtin.zextOrBitCast_Int64_Word(i64) 
      word = Builtin.zextOrBitCast_Int32_Word(i32)
      word = Builtin.zextOrBitCast_Int16_Word(i16)
      """
    )
  }

  func testBuiltinWord7() {
    AssertParse(
      """
      i16 = Builtin.zextOrBitCast_Word_Int16(word) 
      i32 = Builtin.zextOrBitCast_Word_Int32(word) 
      i64 = Builtin.zextOrBitCast_Word_Int64(word)
      i128 = Builtin.zextOrBitCast_Word_Int128(word)
      """
    )
  }

  func testBuiltinWord8() {
    AssertParse(
      """
      word = Builtin.trunc_Int128_Word(i128)
      word = Builtin.trunc_Int64_Word(i64) 
      word = Builtin.trunc_Int32_Word(i32) 
      word = Builtin.trunc_Int16_Word(i16)
      """
    )
  }

  func testBuiltinWord9() {
    AssertParse(
      """
      i16 = Builtin.trunc_Word_Int16(word)
      i32 = Builtin.trunc_Word_Int32(word) 
      i64 = Builtin.trunc_Word_Int64(word) 
      i128 = Builtin.trunc_Word_Int128(word)
      """
    )
  }

  func testBuiltinWord10() {
    AssertParse(
      """
      word = Builtin.zext_Int128_Word(i128) 
      word = Builtin.zext_Int64_Word(i64) 
      word = Builtin.zext_Int32_Word(i32) 
      word = Builtin.zext_Int16_Word(i16)
      """
    )
  }

  func testBuiltinWord11() {
    AssertParse(
      """
      i16 = Builtin.zext_Word_Int16(word) 
      i32 = Builtin.zext_Word_Int32(word) 
      i64 = Builtin.zext_Word_Int64(word) 
      i128 = Builtin.zext_Word_Int128(word)
      """
    )
  }

}
