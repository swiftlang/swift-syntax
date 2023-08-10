//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// This test file has been translated from swift/test/Parse/noimplicitcopy_attr.swift

import XCTest

final class NoimplicitcopyAttrTests: ParserTestCase {
  func testNoimplicitcopyAttr1() {
    assertParse(
      """
      f// RUN: %target-typecheck-verify-swift -parse -parse-stdlib -disable-availability-checking -verify-syntax-tree
      """
    )
  }

  func testNoimplicitcopyAttr2() {
    assertParse(
      """
      import Swift
      """
    )
  }

  func testNoimplicitcopyAttr3() {
    assertParse(
      """
      class Klass {}
      """
    )
  }

  func testNoimplicitcopyAttr4() {
    assertParse(
      """
      func argumentsAndReturns(@_noImplicitCopy _ x: Klass) -> Klass {
          return x
      }
      """
    )
  }

  func testNoimplicitcopyAttr5() {
    assertParse(
      """
      func letDecls(@_noImplicitCopy  _ x: Klass) -> () {
          @_noImplicitCopy let y: Klass = x
          print(y)
      }
      """
    )
  }

  func testNoimplicitcopyAttr6() {
    assertParse(
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
    assertParse(
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
    assertParse(
      """
      @_noImplicitCopy var g: Builtin.NativeObject = getKlass()
      @_noImplicitCopy let g2: Builtin.NativeObject = getKlass()
      """
    )
  }

}
