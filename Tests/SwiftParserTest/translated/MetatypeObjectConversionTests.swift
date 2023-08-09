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

// This test file has been translated from swift/test/Parse/metatype_object_conversion.swift

import XCTest

final class MetatypeObjectConversionTests: ParserTestCase {
  func testMetatypeObjectConversion1() {
    assertParse(
      """
      class C {}
      struct S {}
      """
    )
  }

  func testMetatypeObjectConversion2() {
    assertParse(
      """
      protocol NonClassProto {}
      protocol ClassConstrainedProto : class {}
      """
    )
  }

  func testMetatypeObjectConversion3() {
    assertParse(
      """
      func takesAnyObject(_ x: AnyObject) {}
      """
    )
  }

  func testMetatypeObjectConversion4() {
    assertParse(
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
    assertParse(
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
