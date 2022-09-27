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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '@objc' enum cannot be generic, Fix-It replacements: 1 - 7 = ''
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '@objc' enum must declare an integer raw type
      ]
    )
  }

  func testObjcEnum5() {
    AssertParse(
      """
      @objc enum NonIntegerRawType: Float { 
        case Zim = 1.0, Zang = 1.5, Zung = 2.0
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '@objc' enum raw type 'Float' is not an integer type
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 3: non-'@objc' enums cannot be represented in Objective-C
        // TODO: Old parser expected error on line 3: type of the parameter cannot be represented in Objective-C
      ]
    )
  }

  func testObjcEnum8() {
    AssertParse(
      """
      // <rdar://problem/23681566> @objc enums with payloads rejected with no source location info
      @objc enum r23681566 : Int32 {  
        case Foo(progress: Int)     
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: 'r23681566' declares raw type 'Int32', but does not conform to RawRepresentable and conformance could not be synthesized
        // TODO: Old parser expected note on line 2: declared raw type 'Int32' here
        // TODO: Old parser expected error on line 3: enum with raw type cannot have cases with arguments
      ]
    )
  }

}
