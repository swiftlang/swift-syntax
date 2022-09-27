// This test file has been translated from swift/test/Parse/metatype_object_conversion.swift

import XCTest

final class MetatypeObjectConversionTests: XCTestCase {
  func testMetatypeObjectConversion1() {
    AssertParse(
      """
      class C {}
      struct S {}
      """
    )
  }

  func testMetatypeObjectConversion2() {
    AssertParse(
      """
      protocol NonClassProto {}
      protocol ClassConstrainedProto : class {}
      """
    )
  }

  func testMetatypeObjectConversion3() {
    AssertParse(
      """
      func takesAnyObject(_ x: AnyObject) {}
      """
    )
  }

  func testMetatypeObjectConversion4() {
    AssertParse(
      """
      func concreteTypes() {
        takesAnyObject(C.self) 
        takesAnyObject(S.self) 
        takesAnyObject(ClassConstrainedProto.self) 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: argument type 'S.Type' expected to be an instance of a class or class-constrained type
        // TODO: Old parser expected error on line 4: argument type '(any ClassConstrainedProto).Type' expected to be an instance of a class or class-constrained type
      ]
    )
  }

  func testMetatypeObjectConversion5() {
    AssertParse(
      """
      func existentialMetatypes(nonClass: NonClassProto.Type,
                                classConstrained: ClassConstrainedProto.Type,
                                compo: (NonClassProto & ClassConstrainedProto).Type) {
        takesAnyObject(nonClass) 
        takesAnyObject(classConstrained)
        takesAnyObject(compo)
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: argument type 'any NonClassProto.Type' expected to be an instance of a class or class-constrained type
      ]
    )
  }

}
