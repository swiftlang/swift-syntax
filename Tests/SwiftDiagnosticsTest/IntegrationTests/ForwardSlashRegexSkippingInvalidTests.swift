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

// This test file has been translated from swift/test/StringProcessing/Parse/forward-slash-regex-skipping-invalid.swift

import XCTest

final class ForwardSlashRegexSkippingInvalidTests: XCTestCase {
  func testForwardSlashRegexSkippingInvalid1() {
    // We don't consider this a regex literal when skipping as it has an initial
    // space.
    assertParsedSource(
      """
      func a() { _ = / x*/ }
      """,
      expecting:
        """
        1 │ func a() { _ = / x*/ }
          │                 ╰─ error: bare slash regex literal may not start with space

        """
    )
  }

  func testForwardSlashRegexSkippingInvalid2() {
    // Same because of unbalanced ')'
    assertParsedSource(
      """
      func b() { _ = /x)*/ }
      """,
      expecting:
        """
        1 │ func b() { _ = /x)*/ }
          │                  ╰─ error: unexpected code ')*/' in function

        """
    )
  }

  func testForwardSlashRegexSkippingInvalid3() {
    // These also fail the heuristic, but have unbalanced `{` `}`, so we don't skip.
    assertParsedSource(
      """
      func c() { _ = / x}*/ }
      func d() { _ = / x{*/ }
      """,
      expecting:
        """
        1 │ func c() { _ = / x}*/ }
          │                 ╰─ error: bare slash regex literal may not start with space
        2 │ func d() { _ = / x{*/ }
          │                 ╰─ error: bare slash regex literal may not start with space

        """
    )
  }

  func testForwardSlashRegexSkippingInvalid4() {
    // Unterminated, and unbalanced `{}`.
    assertParsedSource(
      """
      func e() {
        _ = /         }
      }
      """,
      expecting:
        """
        1 │ func e() {
        2 │   _ = /         }
          │       ││         ╰─ error: expected '/' to end regex literal
          │       │╰─ error: bare slash regex literal may not start with space
          │       ╰─ note: to match this opening '/'
        3 │ }

        """
    )
  }

  func testForwardSlashRegexSkippingInvalid5() {
    assertParsedSource(
      """
      func f() {
        _ = /         {
      }
      """,
      expecting:
        """
        1 │ func f() {
        2 │   _ = /         {
          │       ││         ╰─ error: expected '/' to end regex literal
          │       │╰─ error: bare slash regex literal may not start with space
          │       ╰─ note: to match this opening '/'
        3 │ }

        """
    )
  }

  func testForwardSlashRegexSkippingInvalid6() {
    assertParsedSource(
      """
      func g() {
        _ = /x         }
      }
      """,
      expecting:
        """
        1 │ func g() {
        2 │   _ = /x         }
        3 │ }
          │ ╰─ error: extraneous brace at top level

        """
    )
  }

  func testForwardSlashRegexSkippingInvalid7() {
    assertParsedSource(
      #"""
      func i() {
        _ = /x "[abc]     {
      }
      """#,
      expecting:
        #"""
        1 │ func i() {
        2 │   _ = /x "[abc]     {
          │         ││           ╰─ error: expected '"' to end string literal
          │         │╰─ note: to match this opening '"'
          │         ╰─ error: consecutive statements on a line must be separated by newline or ';'
        3 │ }

        """#
    )
  }

  func testForwardSlashRegexSkippingInvalid8() {
    assertParsedSource(
      #"""
      func i() {
        _ = /x "[abc]     {
      }
      """#,
      expecting:
        #"""
        1 │ func i() {
        2 │   _ = /x "[abc]     {
          │         ││           ╰─ error: expected '"' to end string literal
          │         │╰─ note: to match this opening '"'
          │         ╰─ error: consecutive statements on a line must be separated by newline or ';'
        3 │ }

        """#
    )
  }

  func testForwardSlashRegexSkippingInvalid9() {
    assertParsedSource(
      """
      func j() {
        _ = /^ [abc]     {
      }
      """,
      expecting:
        """
        1 │ func j() {
        2 │   _ = /^ [abc]     {
          │       │             ╰─ error: expected '/' to end regex literal
          │       ╰─ note: to match this opening '/'
        3 │ }

        """
    )
  }

  func testForwardSlashRegexSkippingInvalid10() {
    assertParsedSource(
      #"""
      func k() {
        _ = /^ "[abc]     {
      }
      """#,
      expecting:
        #"""
        1 │ func k() {
        2 │   _ = /^ "[abc]     {
          │       │              ╰─ error: expected '/' to end regex literal
          │       ╰─ note: to match this opening '/'
        3 │ }

        """#
    )
  }

  func testForwardSlashRegexSkippingInvalid11() {
    assertParsedSource(
      """
      func l() {
        _ = /^    } abc     {
      }
      """,
      expecting:
        """
        1 │ func l() {
        2 │   _ = /^    } abc     {
          │       │                ╰─ error: expected '/' to end regex literal
          │       ╰─ note: to match this opening '/'
        3 │ }

        """
    )
  }

  func testForwardSlashRegexSkippingInvalid12() {
    assertParsedSource(
      #"""
      func m() {
        _ = / "
      }
      }
      """#,
      expecting:
        #"""
        1 │ func m() {
        2 │   _ = / "
          │       ││ ╰─ error: expected '/' to end regex literal
          │       │╰─ error: bare slash regex literal may not start with space
          │       ╰─ note: to match this opening '/'
        3 │ }
        4 │ }
          │ ╰─ error: extraneous brace at top level

        """#
    )
  }

  func testForwardSlashRegexSkippingInvalid13() {
    // Unbalanced `}`, make sure we don't consider the string literal `{`.
    assertParsedSource(
      #"""
      func n() { / "{"}/ }
      """#,
      expecting:
        #"""
        1 │ func n() { / "{"}/ }
          │             ╰─ error: bare slash regex literal may not start with space

        """#
    )
  }

  func testForwardSlashRegexSkippingInvalid14() {
    assertParsedSource(
      """
      func o() {
        _ = {
          0
          /x}}} /
          2
        }
      }
      """,
      expecting:
        """
        2 │   _ = {
        3 │     0
        4 │     /x}}} /
          │         ╰─ error: extraneous code at top level
        5 │     2
        6 │   }

        """
    )
  }

  func testForwardSlashRegexSkippingInvalid15() {
    assertParsedSource(
      """
      func p() {
        _ = 2
        /x} /
        .bitWidth
      }
      """,
      expecting:
        """
        1 │ func p() {
        2 │   _ = 2
        3 │   /x} /
          │       ╰─ error: extraneous code at top level
        4 │   .bitWidth
        5 │ }

        """
    )
  }

  func testForwardSlashRegexSkippingInvalid16() {
    assertParsedSource(
      """
      func err1() { _ = / 0xG}/ }
      """,
      expecting:
        """
        1 │ func err1() { _ = / 0xG}/ }
          │                    ╰─ error: bare slash regex literal may not start with space

        """
    )
  }

  func testForwardSlashRegexSkippingInvalid17() {
    assertParsedSource(
      """
      func err2() { _ = / 0oG}/ }
      """,
      expecting:
        """
        1 │ func err2() { _ = / 0oG}/ }
          │                    ╰─ error: bare slash regex literal may not start with space

        """
    )
  }

  func testForwardSlashRegexSkippingInvalid18() {
    assertParsedSource(
      """
      func err3() { _ = / {"/ }
      """,
      expecting:
        """
        1 │ func err3() { _ = / {"/ }
          │                    ╰─ error: bare slash regex literal may not start with space

        """
    )
  }

  func testForwardSlashRegexSkippingInvalid19() {
    assertParsedSource(
      """
      func err4() { _ = / {'/ }
      """,
      expecting:
        """
        1 │ func err4() { _ = / {'/ }
          │                    ╰─ error: bare slash regex literal may not start with space

        """
    )
  }

  func testForwardSlashRegexSkippingInvalid20() {
    assertParsedSource(
      """
      func err5() { _ = / {<#placeholder#>/ }
      """,
      expecting:
        """
        1 │ func err5() { _ = / {<#placeholder#>/ }
          │                    ╰─ error: bare slash regex literal may not start with space

        """
    )
  }
}
