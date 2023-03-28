// This test file has been translated from swift/test/StringProcessing/Parse/forward-slash-regex-skipping-allowed.swift

import XCTest

final class ForwardSlashRegexSkippingAllowedTests: XCTestCase {
  func testForwardSlashRegexSkippingAllowed1() {
    assertParse(
      """
      // Make sure we can skip in all of the below cases.
      """
    )
  }

  func testForwardSlashRegexSkippingAllowed2() {
    assertParse(
      #"""
      // The printing implementation differs in asserts and no-asserts builds, it will
      // either print `"Parse.NumFunctionsParsed" 0` or not print it at all. Make sure
      // we don't output any non-zero value.
      // CHECK-NOT: {{"Parse.NumFunctionsParsed" [^0]}}
      """#
    )
  }

  func testForwardSlashRegexSkippingAllowed3() {
    assertParse(
      """
      // Ensures there is a parse error
      var 1️⃣: Int
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected pattern in variable")
      ]
    )
  }

  func testForwardSlashRegexSkippingAllowed4() {
    assertParse(
      """
      // Balanced `{}`, so okay.
      func a() { 1️⃣/ {}/ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '/ {}/' in function")
      ]
    )
  }

  func testForwardSlashRegexSkippingAllowed5() {
    assertParse(
      #"""
      func b() { 1️⃣/ \{}/ }
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"unexpected code '/ \{}/' in function"#)
      ]
    )
  }

  func testForwardSlashRegexSkippingAllowed6() {
    assertParse(
      #"""
      func c() { 1️⃣/ {"{"}/ }
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"unexpected code '/ {"{"}/' in function"#)
      ]
    )
  }

  func testForwardSlashRegexSkippingAllowed7() {
    assertParse(
      """
      // Some cases of infix '/' that we should continue to skip.
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
    assertParse(
      """
      // Some cases of prefix '/' that we should continue to skip.
      prefix operator /
      prefix func / <T> (_ x: T) -> T { x }
      """
    )
  }

  func testForwardSlashRegexSkippingAllowed10() {
    assertParse(
      """
      enum E {
        case e
        func foo<T>(_ x: T) {}
      }
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
    assertParse(
      """
      // Some cases of postfix '/' that we should continue to skip.
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
