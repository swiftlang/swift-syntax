// This test file has been translated from swift/test/StringProcessing/Parse/prefix-slash.swift

import XCTest

final class PrefixSlashTests: XCTestCase {
  func testPrefixSlash1() {
    assertParse(
      """
      // Test the behavior of prefix '/' with regex literals enabled.
      """
    )
  }

  func testPrefixSlash2() {
    assertParse(
      """
      prefix operator /
      prefix func / <T> (_ x: T) -> T { x }
      """
    )
  }

  func testPrefixSlash3() {
    assertParse(
      """
      enum E {
        case e
        func foo<T>(_ x: T) {}
      }
      """
    )
  }

  func testPrefixSlash4() {
    assertParse(
      """
      _ = /E.e
      (/E.e).foo(/0)
      """
    )
  }

  func testPrefixSlash5() {
    assertParse(
      """
      func foo<T, U>(_ x: T, _ y: U) {}
      """
    )
  }

  func testPrefixSlash6() {
    assertParse(
      """
      foo(/E.e, /E.e)
      foo((/E.e), /E.e)
      foo((/)(E.e), /E.e)
      """
    )
  }

  func testPrefixSlash7() {
    assertParse(
      """
      func bar<T>(_ x: T) -> Int { 0 }
      """
    )
  }

  func testPrefixSlash8() {
    assertParse(
      """
      _ = bar(/E.e) / 2
      """
    )
  }

}
