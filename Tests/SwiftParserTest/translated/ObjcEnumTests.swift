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

// This test file has been translated from swift/test/Parse/objc_enum.swift

import XCTest

final class ObjcEnumTests: ParserTestCase {
  func testObjcEnum1() {
    assertParse(
      """
      @objc enum Foo: Int32 {
        case Zim, Zang, Zung
      }
      """
    )
  }

  func testObjcEnum2() {
    assertParse(
      """
      @objc enum Generic<T>: Int32 {
        case Zim, Zang, Zung
      }
      """
    )
  }

  func testObjcEnum3() {
    assertParse(
      """
      @objc(EnumRuntimeName) enum RuntimeNamed: Int32 {
        case Zim, Zang, Zung
      }
      """
    )
  }

  func testObjcEnum4() {
    assertParse(
      """
      @objc enum NoRawType {
        case Zim, Zang, Zung
      }
      """
    )
  }

  func testObjcEnum5() {
    assertParse(
      """
      @objc enum NonIntegerRawType: Float {
        case Zim = 1.0, Zang = 1.5, Zung = 2.0
      }
      """
    )
  }

  func testObjcEnum6() {
    assertParse(
      """
      enum NonObjCEnum: Int {
        case Zim, Zang, Zung
      }
      """
    )
  }

  func testObjcEnum7() {
    assertParse(
      """
      class Bar {
        @objc func foo(x: Foo) {}
        @objc func nonObjC(x: NonObjCEnum) {}
      }
      """
    )
  }

  func testObjcEnum8() {
    assertParse(
      """
      // <rdar://problem/23681566> @objc enums with payloads rejected with no source location info
      @objc enum r23681566 : Int32 {
        case Foo(progress: Int)
      }
      """
    )
  }

}
