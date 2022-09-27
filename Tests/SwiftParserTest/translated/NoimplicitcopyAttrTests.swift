// This test file has been translated from swift/test/Parse/noimplicitcopy_attr.swift

import XCTest

final class NoimplicitcopyAttrTests: XCTestCase {
  func testNoimplicitcopyAttr1() {
    AssertParse(
      """
      f// RUN: %target-typecheck-verify-swift -parse -parse-stdlib -disable-availability-checking -verify-syntax-tree
      """
    )
  }

  func testNoimplicitcopyAttr2() {
    AssertParse(
      """
      import Swift
      """
    )
  }

  func testNoimplicitcopyAttr3() {
    AssertParse(
      """
      class Klass {}
      """
    )
  }

  func testNoimplicitcopyAttr4() {
    AssertParse(
      """
      func argumentsAndReturns(@_noImplicitCopy _ x: Klass) -> Klass {
          return x
      }
      """
    )
  }

  func testNoimplicitcopyAttr5() {
    AssertParse(
      """
      func letDecls(@_noImplicitCopy  _ x: Klass) -> () {
          @_noImplicitCopy let y: Klass = x
          print(y)
      }
      """
    )
  }

  func testNoimplicitcopyAttr6() {
    AssertParse(
      """
      func varDecls(@_noImplicitCopy _ x: Klass, @_noImplicitCopy _ x2: Klass) -> () {
          @_noImplicitCopy var y: Klass = x
          y = x2
          print(y)
      }
      """
    )
  }

  func testNoimplicitcopyAttr7() {
    AssertParse(
      """
      func getKlass() -> Builtin.NativeObject {
          let k = Klass()
          let b = Builtin.unsafeCastToNativeObject(k)
          return Builtin.move(b)
      }
      """
    )
  }

  func testNoimplicitcopyAttr8() {
    AssertParse(
      """
      @_noImplicitCopy var g: Builtin.NativeObject = getKlass()
      @_noImplicitCopy let g2: Builtin.NativeObject = getKlass()
      """
    )
  }

}
