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

// This test file has been translated from swift/test/Parse/string_literal_eof1.swift

import XCTest

final class StringLiteralEofTests: ParserTestCase {
  func testStringLiteralEof1() {
    assertParse(
      ##"""
      // NOTE: DO NOT add a newline at EOF.
      _ = ℹ️"foo\(1️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(
          message: "expected value and ')' in string literal",
          fixIts: ["insert value and ')'"]
        ),
        DiagnosticSpec(
          message: #"expected '"' to end string literal"#,
          notes: [NoteSpec(message: #"to match this opening '"'"#)],
          fixIts: [#"insert '"'"#]
        ),
      ],
      fixedSource: ##"""
        // NOTE: DO NOT add a newline at EOF.
        _ = "foo\(<#expression#>)"
        """##
    )
  }

  func testStringLiteralEof2() {
    assertParse(
      // NOTE: DO NOT add a newline at EOF.
      ##"""
      _ = 9️⃣"foo\8️⃣(7️⃣"bar1️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(
          message: #"expected '"' to end string literal"#,
          notes: [NoteSpec(locationMarker: "7️⃣", message: #"to match this opening '"'"#)],
          fixIts: [#"insert '"'"#]
        ),
        DiagnosticSpec(
          message: #"expected ')' in string literal"#,
          notes: [NoteSpec(locationMarker: "8️⃣", message: "to match this opening '('")],
          fixIts: ["insert ')'"]
        ),
        DiagnosticSpec(
          message: #"expected '"' to end string literal"#,
          notes: [NoteSpec(locationMarker: "9️⃣", message: #"to match this opening '"'"#)],
          fixIts: [#"insert '"'"#]
        ),
      ],
      fixedSource: ##"""
        _ = "foo\("bar")"
        """##
    )
  }

  func testStringLiteralEof3() {
    assertParse(
      ##"""
      _ = ℹ️"foo 1️⃣\2️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "invalid escape sequence in literal"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: #"expected '"' to end string literal"#,
          notes: [NoteSpec(message: #"to match this opening '"'"#)],
          fixIts: [#"insert '"'"#]
        ),
      ],
      fixedSource: ##"""
        _ = "foo \"
        """##
    )
  }

  func testStringLiteralEof4() {
    assertParse(
      ##"""
      // NOTE: DO NOT add a newline at EOF.
      _ = ℹ️"foo 1️⃣\2️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "invalid escape sequence in literal"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: #"expected '"' to end string literal"#,
          notes: [NoteSpec(message: #"to match this opening '"'"#)],
          fixIts: [#"insert '"'"#]
        ),
      ],
      fixedSource: ##"""
        // NOTE: DO NOT add a newline at EOF.
        _ = "foo \"
        """##
    )
  }

  func testStringLiteralEof5() {
    assertParse(
      #"""
      // NOTE: DO NOT add a newline at EOF.
      _ = ℹ️"""
          foo1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: #"expected '"""' to end string literal"#,
          notes: [NoteSpec(message: #"to match this opening '"""'"#)],
          fixIts: [#"insert '"""'"#]
        )
      ],
      fixedSource: #"""
        // NOTE: DO NOT add a newline at EOF.
        _ = """
            foo
        """
        """#
    )
  }

  func testStringLiteralEof6() {
    // NOTE: DO NOT add a newline at EOF.
    assertParse(
      ##"""
      _ = ℹ️"""
          foo
          \(1️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(
          message: "expected value and ')' in string literal",
          fixIts: ["insert value and ')'"]
        ),
        DiagnosticSpec(
          message: #"expected '"""' to end string literal"#,
          notes: [NoteSpec(message: #"to match this opening '"""'"#)],
          fixIts: [#"insert '"""'"#]
        ),
      ],
      fixedSource: ##"""
        _ = """
            foo
            \(<#expression#>)
        """
        """##
    )
  }

  func testStringLiteralEof7() {
    // NOTE: DO NOT add a newline at EOF.
    assertParse(
      ##"""
      _ = 1️⃣"""
          foo
          \2️⃣(3️⃣"bar4️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "4️⃣",
          message: #"expected '"' to end string literal"#,
          notes: [NoteSpec(locationMarker: "3️⃣", message: #"to match this opening '"'"#)],
          fixIts: [#"insert '"'"#]
        ),
        DiagnosticSpec(
          locationMarker: "4️⃣",
          message: "expected ')' in string literal",
          notes: [NoteSpec(locationMarker: "2️⃣", message: "to match this opening '('")],
          fixIts: ["insert ')'"]
        ),
        DiagnosticSpec(
          locationMarker: "4️⃣",
          message: #"expected '"""' to end string literal"#,
          notes: [NoteSpec(locationMarker: "1️⃣", message: #"to match this opening '"""'"#)],
          fixIts: [#"insert '"""'"#]
        ),
      ],
      fixedSource: ##"""
        _ = """
            foo
            \("bar")
        """
        """##
    )
  }

  func testStringLiteralEof8() {
    assertParse(
      ##"""
      _ = 1️⃣"""
          \2️⃣(3️⃣"bar4️⃣
          5️⃣baz6️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "4️⃣",
          message: #"expected '"' to end string literal"#,
          notes: [NoteSpec(locationMarker: "3️⃣", message: #"to match this opening '"'"#)],
          fixIts: [#"insert '"'"#]
        ),
        DiagnosticSpec(
          locationMarker: "5️⃣",
          message: "unexpected code 'baz' in string literal"
        ),
        DiagnosticSpec(
          locationMarker: "6️⃣",
          message: "expected ')' in string literal",
          notes: [NoteSpec(locationMarker: "2️⃣", message: "to match this opening '('")],
          fixIts: ["insert ')'"]
        ),
        DiagnosticSpec(
          locationMarker: "6️⃣",
          message: #"expected '"""' to end string literal"#,
          notes: [NoteSpec(locationMarker: "1️⃣", message: #"to match this opening '"""'"#)],
          fixIts: [#"insert '"""'"#]
        ),
      ],
      fixedSource: ##"""
        _ = """
            \("bar"
            baz)
        """
        """##
    )
  }
}
