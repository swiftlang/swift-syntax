//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest

private func functionDecl(_ source: DeclSyntax) -> FunctionDeclSyntax {
  return source.cast(FunctionDeclSyntax.self)
}

final class SyntaxLayoutTests: XCTestCase {
  func testPropertyInParentIsTheChildsPositionInItsParent() {
    let decl = functionDecl("func foo() {}")
    XCTAssertEqual(decl.name.propertyInParent, FunctionDeclSyntax.layout[.name])
    XCTAssertNotEqual(decl.name.propertyInParent, FunctionDeclSyntax.layout[.funcKeyword])
    XCTAssertNotEqual(decl.name.propertyInParent, StructDeclSyntax.layout[.name])
  }

  func testPropertyInParentIsNilForTheRootAndForCollectionElements() {
    let decl = functionDecl("func foo() { bar() }")
    XCTAssertNil(decl.propertyInParent)
    XCTAssertNil(decl.body!.statements.first!.propertyInParent)
  }

  func testEqualPropertiesHashEqually() {
    let decl = functionDecl("func foo() {}")
    let names: Set<SyntaxLayoutProperty> = [FunctionDeclSyntax.layout[.name], StructDeclSyntax.layout[.name]]
    XCTAssertTrue(names.contains(decl.name.propertyInParent!))
    XCTAssertFalse(names.contains(FunctionDeclSyntax.layout[.funcKeyword]))
  }

  func testSubscriptReturnsTheChildAtAPosition() {
    let decl = functionDecl("func foo() {}")
    XCTAssertEqual(decl[FunctionDeclSyntax.layout[.name]]?.id, decl.name.id)
    XCTAssertNil(decl[FunctionDeclSyntax.layout[.genericWhereClause]])
  }

  func testSubscriptIsNilForAPositionInTheLayoutOfAnotherKind() {
    let decl = functionDecl("func foo() {}")
    XCTAssertNil(decl[StructDeclSyntax.layout[.name]])
  }
}
