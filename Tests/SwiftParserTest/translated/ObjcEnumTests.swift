// This test file has been translated from swift/test/Parse/objc_enum.swift

import XCTest

final class ObjcEnumTests: XCTestCase {
  func testObjcEnum1() {
    AssertParse(
      """
      @objc enum Foo: Int32 {
        case Zim, Zang, Zung
      }
      """
    )
  }

  func testObjcEnum2() {
    AssertParse(
      """
      @objc enum Generic<T>: Int32 { 
        case Zim, Zang, Zung
      }
      """
    )
  }

  func testObjcEnum3() {
    AssertParse(
      """
      @objc(EnumRuntimeName) enum RuntimeNamed: Int32 {
        case Zim, Zang, Zung
      }
      """
    )
  }

  func testObjcEnum4() {
    AssertParse(
      """
      @objc enum NoRawType { 
        case Zim, Zang, Zung
      }
      """
    )
  }

  func testObjcEnum5() {
    AssertParse(
      """
      @objc enum NonIntegerRawType: Float { 
        case Zim = 1.0, Zang = 1.5, Zung = 2.0
      }
      """
    )
  }

  func testObjcEnum6() {
    AssertParse(
      """
      enum NonObjCEnum: Int {
        case Zim, Zang, Zung
      }
      """
    )
  }

  func testObjcEnum7() {
    AssertParse(
      """
      class Bar {
        @objc func foo(x: Foo) {}
        @objc func nonObjC(x: NonObjCEnum) {} 
      }
      """
    )
  }

  func testObjcEnum8() {
    AssertParse(
      """
      // <rdar://problem/23681566> @objc enums with payloads rejected with no source location info
      @objc enum r23681566 : Int32 {  
        case Foo(progress: Int)     
      }
      """
    )
  }

}
