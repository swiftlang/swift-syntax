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

// This test file has been translated from swift/test/Parse/copy_expr.swift

import XCTest

final class CopyExprTests: ParserTestCase {
  func testGlobal() {
    assertParse(
      """
      var global: Int = 5
      func testGlobal() {
          let _ = copy global
      }
      """
    )
  }

  func testLet() {
    assertParse(
      """
      func testLet() {
          let t = String()
          let _ = copy t
      }
      """
    )
  }

  func testVar() {
    assertParse(
      """
      func testVar() {
          var t = String()
          t = String()
          let _ = copy t
      }
      """
    )
  }

  func testStillAbleToCallFunctionCalledCopy() {
    assertParse(
      """
      func copy() {}
      func copy(_: String) {}
      func copy(_: String, _: Int) {}
      func copy(x: String, y: Int) {}

      func useCopyFunc() {
          var s = String()
          var i = global

          copy()
          copy(s)
          copy(i) // expected-error{{cannot convert value of type 'Int' to expected argument type 'String'}}
          copy(s, i)
          copy(i, s) // expected-error{{unnamed argument #2 must precede unnamed argument #1}}
          copy(x: s, y: i)
          copy(y: i, x: s) // expected-error{{argument 'x' must precede argument 'y'}}
      }
      """
    )
  }

  // Ensure we can still parse a variable named copy.
  func testUseCopyVariable() {
    assertParse(
      """
      func useCopyVar(copy: inout String) {
          let s = copy
          copy = s

          // We can copy from a variable named `copy`
          let t = copy copy
          copy = t

          // We can do member access and subscript a variable named `copy`
          let i = copy.startIndex
          let _ = copy[i]
      }
      """
    )
  }

  func testPropertyWrapperWithCopy() {
    assertParse(
      """
      @propertyWrapper
      struct FooWrapper<T> {
          var value: T

          init(wrappedValue: T) { value = wrappedValue }

          var wrappedValue: T {
              get { value }
              nonmutating set {}
          }
          var projectedValue: T {
              get { value }
              nonmutating set {}
          }
      }

      struct Foo {
          @FooWrapper var wrapperTest: String

          func copySelf() {
              _ = copy self
          }

          func copyPropertyWrapper() {
              // should still parse, even if it doesn't semantically work out
              _ = copy wrapperTest // expected-error{{can only be applied to lvalues}}
              _ = copy _wrapperTest // expected-error{{can only be applied to lvalues}}
              _ = copy $wrapperTest // expected-error{{can only be applied to lvalues}}
          }
      }
      """
    )
  }

  func testAsCaseStmt() {
    assertParse(
      """
      class ParentKlass {}
      class SubKlass : ParentKlass {}

      func test(_ s: SubKlass) {
        switch s {
        case let copy as ParentKlass:
          fallthrough
        }
      }
      """
    )
  }

  func testParseCanCopyClosureDollarIdentifier() {
    assertParse(
      """
      class Klass {}
      let f: (Klass) -> () = {
        let _ = copy $0
      }
      """
    )
  }

  func testForLoop() {
    assertParse(
      """
      func test() {
        for copy in 1..<1024 {
        }
      }
      """
    )
  }

  func testCopySelf() {
    assertParse(
      """
      class Klass {
        func test() {
          let _ = copy self
        }
      }
      """
    )
  }
}
