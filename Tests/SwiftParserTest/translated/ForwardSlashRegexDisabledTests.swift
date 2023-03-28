// This test file has been translated from swift/test/StringProcessing/Parse/forward-slash-regex-disabled.swift

import XCTest

final class ForwardSlashRegexDisabledTests: XCTestCase {
  func testForwardSlashRegexDisabled1() {
    AssertParse(
      """
      prefix operator /
      prefix operator ^/
      prefix operator /^/
      """
    )
  }

  func testForwardSlashRegexDisabled2() {
    AssertParse(
      """
      precedencegroup P {
        associativity: left
      }
      """
    )
  }

  func testForwardSlashRegexDisabled3() {
    AssertParse(
      """
      // The divisions in the body of the below operators make sure we don't try and
      // consider them to be ending delimiters of a regex.
      infix operator /^/ : P
      func /^/ (lhs: Int, rhs: Int) -> Int { 1 / 2 }
      """
    )
  }

  func testForwardSlashRegexDisabled4() {
    AssertParse(
      """
      infix operator /^ : P
      func /^ (lhs: Int, rhs: Int) -> Int { 1 / 2 }
      """
    )
  }

  func testForwardSlashRegexDisabled5() {
    AssertParse(
      """
      infix operator ^^/ : P
      func ^^/ (lhs: Int, rhs: Int) -> Int { 1 / 2 }
      """
    )
  }

  func testForwardSlashRegexDisabled6() {
    AssertParse(
      """
      _ = #/x/#
      """
    )
  }

  func testForwardSlashRegexDisabled7() {
    AssertParse(
      """
      _ = /x/
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '/' is not a prefix unary operator
        // TODO: Old parser expected error on line 1: cannot find 'x' in scope
        // TODO: Old parser expected error on line 1: '/' is not a postfix unary operator
      ]
    )
  }

  func testForwardSlashRegexDisabled8() {
    AssertParse(
      """
      func baz(_ x: (Int, Int) -> Int, _ y: (Int, Int) -> Int) {}
      """
    )
  }

  func testForwardSlashRegexDisabled9() {
    AssertParse(
      """
      baz(/, /)
      baz(/^, /)
      baz(^^/, /)
      """
    )
  }

}
