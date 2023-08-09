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

// This test file has been translated from swift/test/Parse/builtin_word.swift

import XCTest

final class BuiltinWordTests: ParserTestCase {
  func testBuiltinWord1() {
    assertParse(
      """
      precedencegroup AssignmentPrecedence { assignment: true }
      """
    )
  }

  func testBuiltinWord2() {
    assertParse(
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
    assertParse(
      """
      // Check that trunc/?ext operations are appropriately available given the
      // abstract range of potential Word sizes.
      """
    )
  }

  func testBuiltinWord4() {
    assertParse(
      """
      word = Builtin.truncOrBitCast_Int128_Word(i128)
      word = Builtin.truncOrBitCast_Int64_Word(i64)
      word = Builtin.truncOrBitCast_Int32_Word(i32)
      word = Builtin.truncOrBitCast_Int16_Word(i16)
      """
    )
  }

  func testBuiltinWord5() {
    assertParse(
      """
      i16 = Builtin.truncOrBitCast_Word_Int16(word)
      i32 = Builtin.truncOrBitCast_Word_Int32(word)
      i64 = Builtin.truncOrBitCast_Word_Int64(word)
      i128 = Builtin.truncOrBitCast_Word_Int128(word)
      """
    )
  }

  func testBuiltinWord6() {
    assertParse(
      """
      word = Builtin.zextOrBitCast_Int128_Word(i128)
      word = Builtin.zextOrBitCast_Int64_Word(i64)
      word = Builtin.zextOrBitCast_Int32_Word(i32)
      word = Builtin.zextOrBitCast_Int16_Word(i16)
      """
    )
  }

  func testBuiltinWord7() {
    assertParse(
      """
      i16 = Builtin.zextOrBitCast_Word_Int16(word)
      i32 = Builtin.zextOrBitCast_Word_Int32(word)
      i64 = Builtin.zextOrBitCast_Word_Int64(word)
      i128 = Builtin.zextOrBitCast_Word_Int128(word)
      """
    )
  }

  func testBuiltinWord8() {
    assertParse(
      """
      word = Builtin.trunc_Int128_Word(i128)
      word = Builtin.trunc_Int64_Word(i64)
      word = Builtin.trunc_Int32_Word(i32)
      word = Builtin.trunc_Int16_Word(i16)
      """
    )
  }

  func testBuiltinWord9() {
    assertParse(
      """
      i16 = Builtin.trunc_Word_Int16(word)
      i32 = Builtin.trunc_Word_Int32(word)
      i64 = Builtin.trunc_Word_Int64(word)
      i128 = Builtin.trunc_Word_Int128(word)
      """
    )
  }

  func testBuiltinWord10() {
    assertParse(
      """
      word = Builtin.zext_Int128_Word(i128)
      word = Builtin.zext_Int64_Word(i64)
      word = Builtin.zext_Int32_Word(i32)
      word = Builtin.zext_Int16_Word(i16)
      """
    )
  }

  func testBuiltinWord11() {
    assertParse(
      """
      i16 = Builtin.zext_Word_Int16(word)
      i32 = Builtin.zext_Word_Int32(word)
      i64 = Builtin.zext_Word_Int64(word)
      i128 = Builtin.zext_Word_Int128(word)
      """
    )
  }

}
