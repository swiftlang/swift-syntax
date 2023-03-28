// This test file has been translated from swift/test/StringProcessing/Parse/regex.swift

import XCTest

final class RegexTests: XCTestCase {
  func testRegex1() {
    assertParse(
      """
      _ = /abc/
      _ = #/abc/#
      _ = ##/abc/##
      """
    )
  }

  func testRegex2() {
    assertParse(
      """
      func foo<T>(_ x: T...) {}
      """
    )
  }

  func testRegex3() {
    assertParse(
      """
      foo(/abc/, #/abc/#, ##/abc/##)
      """
    )
  }

  func testRegex4() {
    assertParse(
      """
      let arr = [/abc/, #/abc/#, ##/abc/##]
      """
    )
  }

  func testRegex5() {
    assertParse(
      #"""
      _ = /\w+/.self
      _ = #/\w+/#.self
      _ = ##/\w+/##.self
      """#
    )
  }

  func testRegex6() {
    assertParse(
      ##"""
      _ = /#\/\#\\/
      _ = #/#/\/\#\\/#
      _ = ##/#|\|\#\\/##
      """##
    )
  }

  func testRegex7() {
    assertParse(
      """
      _ = (#/[*/#, #/+]/#, #/.]/#)
      """
    )
  }

}
