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

// This test file has been translated from swift/test/StringProcessing/Parse/forward-slash-regex-skipping-allowed.swift

import XCTest

final class ForwardSlashRegexSkippingAllowedTests: ParserTestCase {
  func testForwardSlashRegexSkippingAllowed3() {
    // Ensures there is a parse error
    assertParse(
      """
      var 1️⃣: Int
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected pattern in variable", fixIts: ["insert pattern"])
      ],
      fixedSource: """
        var <#pattern#>: Int
        """
    )
  }

  func testForwardSlashRegexSkippingAllowed4() {
    // Balanced `{}`, so okay.
    assertParse(
      """
      func a() { /1️⃣ {}/ }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "bare slash regex literal may not start with space",
          fixIts: [
            "convert to extended regex literal with '#'",
            #"insert '\'"#,
          ]
        )
      ],
      fixItsApplications: [
        .optIn(
          applyFixIts: ["convert to extended regex literal with '#'"],
          fixedSource: """
            func a() { #/ {}/# }
            """
        ),
        .optIn(
          applyFixIts: [#"insert '\'"#],
          fixedSource: #"""
            func a() { /\ {}/ }
            """#
        ),
      ]
    )
  }

  func testForwardSlashRegexSkippingAllowed5() {
    assertParse(
      #"""
      func b() { /1️⃣ \{}/ }
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "bare slash regex literal may not start with space",
          fixIts: [
            "convert to extended regex literal with '#'",
            #"insert '\'"#,
          ]
        )
      ],
      fixItsApplications: [
        .optIn(
          applyFixIts: ["convert to extended regex literal with '#'"],
          fixedSource: #"""
            func b() { #/ \{}/# }
            """#
        ),
        .optIn(
          applyFixIts: [#"insert '\'"#],
          fixedSource: #"""
            func b() { /\ \{}/ }
            """#
        ),
      ]
    )
  }

  func testForwardSlashRegexSkippingAllowed6() {
    assertParse(
      #"""
      func c() { /1️⃣ {"{"}/ }
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "bare slash regex literal may not start with space",
          fixIts: [
            "convert to extended regex literal with '#'",
            #"insert '\'"#,
          ]
        )
      ],
      fixItsApplications: [
        .optIn(
          applyFixIts: ["convert to extended regex literal with '#'"],
          fixedSource: #"""
            func c() { #/ {"{"}/# }
            """#
        ),
        .optIn(
          applyFixIts: [#"insert '\'"#],
          fixedSource: #"""
            func c() { /\ {"{"}/ }
            """#
        ),
      ]
    )
  }

  func testForwardSlashRegexSkippingAllowed7() {
    // Some cases of infix '/' that we should continue to skip.
    assertParse(
      """
      func d() {
        _ = 1 / 2 + 3 * 4
        _ = 1 / 2 / 3 / 4
      }
      """
    )
  }

  func testForwardSlashRegexSkippingAllowed8() {
    assertParse(
      #"""
      func e() {
        let arr = [1, 2, 3]
        _ = arr.reduce(0, /) / 2
        func foo(_ i: Int, _ fn: () -> Void) {}
        foo(1 / 2 / 3, { print("}}}{{{") })
      }
      """#
    )
  }

  func testForwardSlashRegexSkippingAllowed9() {
    // Some cases of prefix '/' that we should continue to skip.
    assertParse(
      """
      prefix operator /
      prefix func / <T> (_ x: T) -> T { x }
      """
    )
  }

  func testForwardSlashRegexSkippingAllowed11() {
    assertParse(
      """
      func f() {
        _ = /E.e
        (/E.e).foo(/0)
        func foo<T, U>(_ x: T, _ y: U) {}
        foo(/E.e, /E.e)
        foo((/E.e), /E.e)
        foo((/)(E.e), /E.e)
        func bar<T>(_ x: T) -> Int { 0 }
        _ = bar(/E.e) / 2
      }
      """
    )
  }

  func testForwardSlashRegexSkippingAllowed12() {
    assertParse(
      """
      postfix operator /
      prefix func / <T> (_ x: T) -> T { x }
      """
    )
  }

  func testForwardSlashRegexSkippingAllowed13() {
    // Some cases of postfix '/' that we should continue to skip.
    assertParse(
      """
      func g() {
          _ = 0/
          _ = 0/ / 1/
          _ = 1/ + 1/
          _ = 1 + 2/
      }
      """
    )
  }
}
