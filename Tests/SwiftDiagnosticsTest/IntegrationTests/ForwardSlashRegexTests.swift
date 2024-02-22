//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// This test file has been translated from swift/test/StringProcessing/Parse/forward-slash-regex.swift

import XCTest

final class ForwardSlashRegexTests: XCTestCase {
  func testForwardSlashRegex1() {
    // These unfortunately become prefix `=` and infix `=/` respectively. We could
    // likely improve the diagnostic though.
    assertParsedSource(
      """
      do {
        let z=/0/
      }
      """,
      expecting:
        """
        1 │ do {
        2 │   let z=/0/
          │        ╰─ error: unexpected code '=/0/' in 'do' statement
        3 │ }

        """
    )
  }

  func testForwardSlashRegex2() {
    assertParsedSource(
      """
      _ = !/ /
      """,
      expecting:
        """
        1 │ _ = !/ /
          │       ╰─ error: bare slash regex literal may not start with space

        """
    )
  }

  func testForwardSlashRegex3() {
    assertParsedSource(
      """
      _ = !!/ /
      """,
      expecting:
        """
        1 │ _ = !!/ /
          │        ╰─ error: bare slash regex literal may not start with space

        """
    )
  }

  func testForwardSlashRegex4() {
    assertParsedSource(
      """
      _ = /^)
      """,
      expecting:
        """
        1 │ _ = /^)
          │     │  ╰─ error: expected '/' to end regex literal
          │     ╰─ note: to match this opening '/'

        """
    )
  }

  func testForwardSlashRegex5() {
    assertParsedSource(
      """
      do {
        _ = 0; /x /
      }
      """,
      expecting:
        """
        1 │ do {
        2 │   _ = 0; /x /
          │              ╰─ error: expected expression after operator
        3 │ }

        """
    )
  }

  func testForwardSlashRegex6() {
    assertParsedSource(
      """
      _ = /x/ ? 0 : 1
      do {
        _ = /x / ? 0 : 1
      }
      """,
      expecting:
        """
        1 │ _ = /x/ ? 0 : 1
        2 │ do {
        3 │   _ = /x / ? 0 : 1
          │            ├─ error: expected expression after operator
          │            ╰─ error: unexpected code '? 0 : 1' in 'do' statement
        4 │ }

        """
    )
  }

  func testForwardSlashRegex7() {
    assertParsedSource(
      """
      _ = /x/ ?? /x/
      do {
        _ = /x / ?? /x /
      }
      """,
      expecting:
        """
        1 │ _ = /x/ ?? /x/
        2 │ do {
        3 │   _ = /x / ?? /x /
          │            ├─ error: expected expression after operator
          │            ╰─ error: unexpected code '?? /x /' in 'do' statement
        4 │ }

        """
    )
  }

  func testForwardSlashRegex8() {
    // This is parsed as /x /...
    assertParsedSource(
      """
      do {
        _ = /x /...
      }
      """,
      expecting:
        """
        1 │ do {
        2 │   _ = /x /...
          │         │ ├─ error: expected expression in operator
          │         │ ╰─ error: unexpected code '...' in 'do' statement
          │         ╰─ error: consecutive statements on a line must be separated by newline or ';'
        3 │ }

        """
    )
  }

  func testForwardSlashRegex9() {
    // This is parsed as /x /...
    assertParsedSource(
      """
      do {
        _ = /x /...
      }
      """,
      expecting:
        """
        1 │ do {
        2 │   _ = /x /...
          │         │ ├─ error: expected expression in operator
          │         │ ╰─ error: unexpected code '...' in 'do' statement
          │         ╰─ error: consecutive statements on a line must be separated by newline or ';'
        3 │ }

        """
    )
  }

  func testForwardSlashRegex10() {
    assertParsedSource(
      """
      do {
        _ = true / false /;
      }
      """,
      expecting:
        """
        1 │ do {
        2 │   _ = true / false /;
          │                     ╰─ error: expected expression after operator
        3 │ }

        """
    )
  }

  func testForwardSlashRegex11() {
    assertParsedSource(
      """
      foo(/abc/, y: /abc /)
      """,
      expecting:
        """
        1 │ foo(/abc/, y: /abc /)
          │                     ╰─ error: expected expression after operator

        """
    )
  }

  func testForwardSlashRegex12() {
    assertParsedSource(
      """
      func testSubscript(_ x: S) {
        x[/x/]
        x[/x /]
        _ = x[/] / 2
      }
      """,
      expecting:
        """
        1 │ func testSubscript(_ x: S) {
        2 │   x[/x/]
        3 │   x[/x /]
          │         ╰─ error: expected expression after operator
        4 │   _ = x[/] / 2
        5 │ }

        """
    )
  }

  func testForwardSlashRegex13() {
    assertParsedSource(
      """
      func testReturn() -> Regex<Substring> {
        if .random() {
          return /x/
        }
        return /x /
      }
      """,
      expecting:
        """
        3 │     return /x/
        4 │   }
        5 │   return /x /
          │              ╰─ error: expected expression after operator
        6 │ }

        """
    )
  }

  func testForwardSlashRegex14() {
    assertParsedSource(
      """
      do {
        _ = [/abc/, /abc /]
      }
      """,
      expecting:
        """
        1 │ do {
        2 │   _ = [/abc/, /abc /]
          │                     ╰─ error: expected expression after operator
        3 │ }

        """
    )
  }

  func testForwardSlashRegex15() {
    assertParsedSource(
      """
      do {
        _ = [/abc /: /abc /]
      }
      """,
      expecting:
        """
        1 │ do {
        2 │   _ = [/abc /: /abc /]
          │              │       ╰─ error: expected expression after operator
          │              ╰─ error: expected expression after operator
        3 │ }

        """
    )
  }

  func testForwardSlashRegex16() {
    assertParsedSource(
      """
      do {
        _ = ((/abc /))
      }
      """,
      expecting:
        """
        1 │ do {
        2 │   _ = ((/abc /))
          │               ╰─ error: expected expression after operator
        3 │ }

        """
    )
  }

  func testForwardSlashRegex17() {
    // While '.' is technically an operator character, it seems more likely that
    // the user hasn't written the member name yet.
    assertParsedSource(
      """
      _ = 0. / 1 / 2
      """,
      expecting:
        """
        1 │ _ = 0. / 1 / 2
          │       ╰─ error: expected name in member access

        """
    )
  }

  func testForwardSlashRegex18() {
    assertParsedSource(
      """
      _ = 0 . / 1 / 2
      """,
      expecting:
        """
        1 │ _ = 0 . / 1 / 2
          │        ╰─ error: expected name in member access

        """
    )
  }

  func testForwardSlashRegex19() {
    assertParsedSource(
      """
      do {
        let /x/
      }
      """,
      expecting:
        """
        1 │ do {
        2 │   let /x/
          │       ├─ error: expected pattern in variable
          │       ╰─ error: expected '=' in variable
        3 │ }

        """
    )
  }

  func testForwardSlashRegex20() {
    assertParsedSource(
      """
      do {
        _ = try /x/; _ = try /x /
      }
      """,
      expecting:
        """
        1 │ do {
        2 │   _ = try /x/; _ = try /x /
          │                            ╰─ error: expected expression after operator
        3 │ }

        """
    )
  }

  func testForwardSlashRegex21() {
    assertParsedSource(
      """
      do {
        _ = try? /x/; _ = try? /x /
      }
      """,
      expecting:
        """
        1 │ do {
        2 │   _ = try? /x/; _ = try? /x /
          │                              ╰─ error: expected expression after operator
        3 │ }

        """
    )
  }

  func testForwardSlashRegex22() {
    assertParsedSource(
      """
      do {
        _ = try! /x/; _ = try! /x /
      }
      """,
      expecting:
        """
        1 │ do {
        2 │   _ = try! /x/; _ = try! /x /
          │                              ╰─ error: expected expression after operator
        3 │ }

        """
    )
  }

  func testForwardSlashRegex23() {
    assertParsedSource(
      #"""
      _ = qux(/, 1) / 2
      do {
        _ = qux(/, "(") / 2
        _ = qux(/, "(")/2
      }
      """#,
      expecting:
        """
        2 │ do {
        3 │   _ = qux(/, "(") / 2
        4 │   _ = qux(/, "(")/2
          │          │        ╰─ error: expected ')' to end function call
          │          ╰─ note: to match this opening '('
        5 │ }

        """
    )
  }

  func testForwardSlashRegex24() {
    assertParsedSource(
      """
      _ = /
      """,
      expecting:
        """
        1 │ _ = /
          │     │╰─ error: expected '/' to end regex literal
          │     ╰─ note: to match this opening '/'

        """
    )
  }

  func testForwardSlashRegex25() {
    assertParsedSource(
      """
      _ = /)
      """,
      expecting:
        """
        1 │ _ = /)
          │     │ ╰─ error: expected '/' to end regex literal
          │     ╰─ note: to match this opening '/'

        """
    )
  }

  func testForwardSlashRegex26() {
    assertParsedSource(
      #"""
      _ = /\()/
      """#,
      expecting:
        #"""
        1 │ _ = /\()/
          │         ╰─ error: extraneous code '/' at top level

        """#
    )
  }

  func testForwardSlashRegex27() {
    assertParsedSource(
      #"""
      do {
        let _: Regex = (/whatever\)/
      }
      """#,
      expecting:
        #"""
        1 │ do {
        2 │   let _: Regex = (/whatever\)/
          │                  │            ╰─ error: expected ')' to end tuple
          │                  ╰─ note: to match this opening '('
        3 │ }

        """#
    )
  }

  func testForwardSlashRegex28() {
    assertParsedSource(
      """
      do {
        _ = /(()()))/
      }
      """,
      expecting:
        """
        1 │ do {
        2 │   _ = /(()()))/
          │              ╰─ error: unexpected code ')/' in 'do' statement
        3 │ }

        """
    )
  }

  func testForwardSlashRegex29() {
    assertParsedSource(
      """
      do {
        _ = /[x])/
      }
      """,
      expecting:
        """
        1 │ do {
        2 │   _ = /[x])/
          │           ╰─ error: unexpected code ')/' in 'do' statement
        3 │ }

        """
    )
  }

  func testForwardSlashRegex30() {
    assertParsedSource(
      #"""
      do {
        _ = /[\]])/
      }
      """#,
      expecting:
        #"""
        1 │ do {
        2 │   _ = /[\]])/
          │          │╰─ error: unexpected code '])/' in 'do' statement
          │          ╰─ error: expected root in key path
        3 │ }

        """#
    )
  }

  func testForwardSlashRegex31() {
    assertParsedSource(
      #"""
      _ = ^/"/"
      """#,
      expecting:
        #"""
        1 │ _ = ^/"/"
          │         │╰─ error: expected '"' to end string literal
          │         ├─ error: consecutive statements on a line must be separated by newline or ';'
          │         ╰─ note: to match this opening '"'

        """#
    )
  }

  func testForwardSlashRegex32() {
    assertParsedSource(
      #"""
      _ = ^/"/"
      """#,
      expecting:
        #"""
        1 │ _ = ^/"/"
          │         │╰─ error: expected '"' to end string literal
          │         ├─ error: consecutive statements on a line must be separated by newline or ';'
          │         ╰─ note: to match this opening '"'

        """#
    )
  }

  func testForwardSlashRegex33() {
    assertParsedSource(
      #"""
      _ = ^/"[/"
      """#,
      expecting:
        #"""
        1 │ _ = ^/"[/"
          │          │╰─ error: expected '"' to end string literal
          │          ├─ error: consecutive statements on a line must be separated by newline or ';'
          │          ╰─ note: to match this opening '"'

        """#
    )
  }

  func testForwardSlashRegex34() {
    assertParsedSource(
      #"""
      _ = ^/"[/"
      """#,
      expecting:
        #"""
        1 │ _ = ^/"[/"
          │          │╰─ error: expected '"' to end string literal
          │          ├─ error: consecutive statements on a line must be separated by newline or ';'
          │          ╰─ note: to match this opening '"'

        """#
    )
  }

  func testForwardSlashRegex35() {
    assertParsedSource(
      """
      _ = / /
      """,
      expecting:
        """
        1 │ _ = / /
          │      ╰─ error: bare slash regex literal may not start with space

        """
    )
  }

  func testForwardSlashRegex36() {
    // There are intentionally trailing spaces here
    assertParsedSource(
      """
      _ = /               
      """,
      expecting:
        """
        1 │ _ = /               
          │     ││              ╰─ error: expected '/' to end regex literal
          │     │╰─ error: bare slash regex literal may not start with space
          │     ╰─ note: to match this opening '/'

        """
    )
  }

  func testForwardSlashRegex37() {
    // There are intentionally trailing spaces here
    assertParsedSource(
      """
      _ = /^                  
      """,
      expecting:
        """
        1 │ _ = /^                  
          │     │                   ╰─ error: expected '/' to end regex literal
          │     ╰─ note: to match this opening '/'

        """
    )
  }
}
