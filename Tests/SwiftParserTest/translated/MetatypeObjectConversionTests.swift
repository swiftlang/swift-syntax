//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

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
      """
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
      """
    )
  }

}
