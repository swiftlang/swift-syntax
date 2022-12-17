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

// This test file has been translated from swift/test/Parse/string_literal_eof1.swift

import XCTest

final class StringLiteralEofTests: XCTestCase {
  func testStringLiteralEof1() {
    AssertParse(
      ##"""
      // NOTE: DO NOT add a newline at EOF.
      _ = 1️⃣"foo\(
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unterminated string literal
        // TODO: Old parser expected error on line 2: cannot find ')' to match opening '(' in string interpolation
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: #"extraneous code '"foo\(' at top level"#),
      ]
    )
  }

  func testStringLiteralEof2() {
    AssertParse(
      ##"""
      // NOTE: DO NOT add a newline at EOF.
      _ = 1️⃣"foo\("bar
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 2: cannot find ')' to match opening '(' in string interpolation
        // TODO: Old parser expected error on line 2: unterminated string literal
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: #"extraneous code '"foo\("bar' at top level"#),
      ]
    )
  }

  func testStringLiteralEof3() {
    AssertParse(
      ##"""
      _ = "foo \1️⃣
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 1: invalid escape sequence in literal
        DiagnosticSpec(message: #"expected '"' to end string literal"#)
      ]
    )
  }

  func testStringLiteralEof4() {
    AssertParse(
      ##"""
      // NOTE: DO NOT add a newline at EOF.
      _ = "foo \1️⃣
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unterminated string literal
        // TODO: Old parser expected error on line 2: invalid escape sequence in literal
        DiagnosticSpec(message: #"expected '"' to end string literal"#)
      ]
    )
  }

  func testStringLiteralEof5() {
    AssertParse(
      #"""
      // NOTE: DO NOT add a newline at EOF.
      _ = """
          foo1️⃣
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unterminated string literal
        DiagnosticSpec(message: #"expected '"""' to end string literal"#)
      ]
    )
  }

  func testStringLiteralEof6() {
    AssertParse(
      ##"""
      // NOTE: DO NOT add a newline at EOF.
      _ = 1️⃣"""
          foo
          \(
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unterminated string literal
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: "extraneous code at top level"),
        // TODO: Old parser expected error on line 4: cannot find ')' to match opening '(' in string interpolation
      ]
    )
  }

  func testStringLiteralEof7() {
    AssertParse(
      ##"""
      // NOTE: DO NOT add a newline at EOF.
      _ = 1️⃣"""
          foo
          \("bar
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unterminated string literal
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: "extraneous code at top level"),
        // TODO: Old parser expected error on line 4: cannot find ')' to match opening '(' in string interpolation
      ]
    )
  }

  func testStringLiteralEof8() {
    AssertParse(
      ##"""
      _ = """
          \(1️⃣"bar2️⃣
      3️⃣    baz4️⃣
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unterminated string literal
        DiagnosticSpec(message: "expected value in string literal"),
        DiagnosticSpec(message: #"unexpected code '"bar' in string literal"#),
        DiagnosticSpec(locationMarker: "2️⃣", message: #"expected ')' in string literal"#),
        DiagnosticSpec(locationMarker: "3️⃣", message: #"unexpected code '' in string literal"#),
        DiagnosticSpec(locationMarker: "4️⃣", message: #"expected '"""' to end string literal"#),
        // TODO: Old parser expected error on line 3: cannot find ')' to match opening '(' in string interpolation
        // TODO: Old parser expected error on line 3: unterminated string literal
      ]
    )
  }

}
