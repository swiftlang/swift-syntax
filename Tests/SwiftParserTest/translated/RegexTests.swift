// This test file has been translated from swift/test/StringProcessing/Parse/regex.swift

import XCTest

final class RegexTests: XCTestCase {
  func testRegex1() {
    AssertParse(
      """
      _ = /abc/
      _ = #/abc/#
      _ = ##/abc/##
      """
    )
  }

  func testRegex2() {
    AssertParse(
      """
      func foo<T>(_ x: T...) {}
      """
    )
  }

  func testRegex3() {
    AssertParse(
      """
      foo(/abc/, #/abc/#, ##/abc/##)
      """
    )
  }

  func testRegex4() {
    AssertParse(
      """
      let arr = [/abc/, #/abc/#, ##/abc/##]
      """
    )
  }

  func testRegex5() {
    AssertParse(
      #"""
      _ = /\w+/.self
      _ = #/\w+/#.self
      _ = ##/\w+/##.self
      """#
    )
  }

  func testRegex6() {
    AssertParse(
      ##"""
      _ = /#\/\#\\/
      _ = #/#/\/\#\\/#
      _ = ##/#|\|\#\\/##
      """##
    )
  }

  func testRegex7() {
    AssertParse(
      """
      _ = (#/[*/#, #/+]/#, #/.]/#)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot parse regular expression: expected ']'
        // TODO: Old parser expected error on line 1: cannot parse regular expression: quantifier '+' must appear after expression
      ]
    )
  }

}
