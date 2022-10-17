// This test file has been translated from swift/test/StringProcessing/Parse/prefix-slash.swift

import XCTest

final class PrefixSlashTests: XCTestCase {
  func testPrefixSlash1() {
    AssertParse(
      """
      // Test the behavior of prefix '/' with regex literals enabled.
      """
    )
  }

  func testPrefixSlash2() {
    AssertParse(
      """
      prefix operator /
      prefix func / <T> (_ x: T) -> T { x }
      """
    )
  }

  func testPrefixSlash3() {
    AssertParse(
      """
      enum E {
        case e
        func foo<T>(_ x: T) {}
      }
      """
    )
  }

  func testPrefixSlash4() {
    AssertParse(
      """
      _ = /E.e
      (/E.e).foo(/0)
      """
    )
  }

  func testPrefixSlash5() {
    AssertParse(
      """
      func foo<T, U>(_ x: T, _ y: U) {}
      """
    )
  }

  func testPrefixSlash6() {
    AssertParse(
      """
      foo(/E.e, /E.e)
      foo((/E.e), /E.e)
      foo((/)(E.e), /E.e)
      """
    )
  }

  func testPrefixSlash7() {
    AssertParse(
      """
      func bar<T>(_ x: T) -> Int { 0 }
      """
    )
  }

  func testPrefixSlash8() {
    AssertParse(
      """
      _ = bar(/E.e) / 2
      """
    )
  }

}
