//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax
import XCTest

class UtilsTests: XCTestCase {

  public func testIsVoid() {
    XCTAssertTrue(TypeSyntax("Void").isVoid)
    XCTAssertTrue(TypeSyntax("Swift.Void").isVoid)
    XCTAssertTrue(TypeSyntax("()").isVoid)

    XCTAssertFalse(TypeSyntax("(Int, Int)").isVoid)
    XCTAssertFalse(TypeSyntax("Swift").isVoid)
    XCTAssertFalse(TypeSyntax("Swift.()").isVoid)
    XCTAssertFalse(TypeSyntax("Int").isVoid)
    XCTAssertFalse(TypeSyntax("(())").isVoid)
    XCTAssertFalse(TypeSyntax("(Void)").isVoid)
  }

  public func testIsInt() {
    XCTAssertTrue(TypeSyntax("Int").canRepresentBasicType(type: Int.self))
    XCTAssertTrue(TypeSyntax("Swift.Int").canRepresentBasicType(type: Int.self))
    XCTAssertTrue(TypeSyntax("Int").canRepresentBasicType(type: Swift.Int.self))
    XCTAssertTrue(TypeSyntax("Swift.Int").canRepresentBasicType(type: Swift.Int.self))

    // Only the canonical type syntax matches
    XCTAssertFalse(TypeSyntax("CInt").canRepresentBasicType(type: Int.self))
    XCTAssertFalse(TypeSyntax("Swift.CInt").canRepresentBasicType(type: Int.self))
    XCTAssertFalse(TypeSyntax("CInt").canRepresentBasicType(type: Swift.Int.self))
    XCTAssertFalse(TypeSyntax("Swift.CInt").canRepresentBasicType(type: Swift.Int.self))
  }

  public func testIsCInt() {
    // Match against the canonical type (platform dependent)
    XCTAssertEqual(TypeSyntax("Swift.Int").canRepresentBasicType(type: Swift.CInt.self), CInt.self == Int.self)
    XCTAssertEqual(TypeSyntax("Int").canRepresentBasicType(type: Swift.CInt.self), CInt.self == Int.self)
    XCTAssertEqual(TypeSyntax("Int").canRepresentBasicType(type: CInt.self), CInt.self == Int.self)
    XCTAssertEqual(TypeSyntax("Swift.Int").canRepresentBasicType(type: CInt.self), CInt.self == Int.self)

    XCTAssertFalse(TypeSyntax("Swift.CInt").canRepresentBasicType(type: Swift.CInt.self))
    XCTAssertFalse(TypeSyntax("CInt").canRepresentBasicType(type: Swift.CInt.self))
    XCTAssertFalse(TypeSyntax("CInt").canRepresentBasicType(type: CInt.self))
    XCTAssertFalse(TypeSyntax("Swift.CInt").canRepresentBasicType(type: CInt.self))
  }

  public func testIsArrayType() {
    // Only plain name types are supported
    XCTAssertFalse(TypeSyntax("[Int]").canRepresentBasicType(type: [Int].self))
    XCTAssertFalse(TypeSyntax("Int").canRepresentBasicType(type: [Int].self))
  }

  public func testIsOptionalType() {
    // Only plain name types are supported
    XCTAssertFalse(TypeSyntax("Int?").canRepresentBasicType(type: Int?.self))
    XCTAssertFalse(TypeSyntax("Optional<Int>").canRepresentBasicType(type: Int?.self))
    XCTAssertFalse(TypeSyntax("Int").canRepresentBasicType(type: [Int].self))
  }

  public func testIsTupleTypes() {
    // Only plain name types are supported
    XCTAssertFalse(TypeSyntax("()").canRepresentBasicType(type: Void.self))
    XCTAssertFalse(TypeSyntax("Void").canRepresentBasicType(type: Void.self))
    XCTAssertFalse(TypeSyntax("(Int, Int)").canRepresentBasicType(type: (Int, Int).self))
  }
}