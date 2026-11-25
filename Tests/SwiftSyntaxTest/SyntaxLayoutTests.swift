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

@_spi(RawSyntax) import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest

private func functionDecl(_ source: DeclSyntax) -> FunctionDeclSyntax {
  return source.cast(FunctionDeclSyntax.self)
}

private func returnStmt(_ source: StmtSyntax) -> ReturnStmtSyntax {
  return source.cast(ReturnStmtSyntax.self)
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
    let names: Set<AnySyntaxProperty> = [FunctionDeclSyntax.layout[.name], StructDeclSyntax.layout[.name]]
    XCTAssertTrue(names.contains(decl.name.propertyInParent!))
    XCTAssertFalse(names.contains(FunctionDeclSyntax.layout[.funcKeyword]))
  }

  func testSubscriptReturnsTheChildAtAPosition() {
    let decl = functionDecl("func foo() {}")
    XCTAssertEqual(decl[property: FunctionDeclSyntax.layout[.name]]??.id, decl.name.id)
  }

  func testSubscriptIsSomeNilForAnAbsentChild() {
    let decl = functionDecl("func foo() {}")
    let child = decl[property: FunctionDeclSyntax.layout[.genericWhereClause]]
    XCTAssertNotNil(child)
    XCTAssertNil(child!)
  }

  func testSubscriptIsNilForAPositionInTheLayoutOfAnotherKind() {
    let decl = functionDecl("func foo() {}")
    XCTAssertNil(decl[property: StructDeclSyntax.layout[.name]])
  }

  func testAPositionFindsTheCorrespondingChildInAnotherTree() {
    let original = functionDecl("func foo() {}")
    let edited = functionDecl("func bar(x: Int) {}")
    let position = original.name.propertyInParent!
    XCTAssertEqual(edited[property: position]??.as(TokenSyntax.self)?.text, "bar")
  }

  func testPropertyInParentOfAChildReachedThroughABaseOrChoicesType() {
    let stmt = returnStmt("return x")
    XCTAssertEqual(stmt.expression!.propertyInParent, ReturnStmtSyntax.layout[.expression])
    let item = functionDecl("func foo() { bar() }").body!.statements.first!
    XCTAssertEqual(item.item.propertyInParent, CodeBlockItemSyntax.layout[.item])
  }

  func testPropertyInParentIsTheSameThroughAGenericOrExistentialReceiver() {
    func generic(_ node: some SyntaxProtocol) -> AnySyntaxProperty? {
      return node.propertyInParent
    }
    let decl = functionDecl("func foo() {}")
    let existential: any SyntaxProtocol = decl.name
    XCTAssertEqual(generic(decl.name), FunctionDeclSyntax.layout[.name])
    XCTAssertEqual(existential.propertyInParent, FunctionDeclSyntax.layout[.name])
    XCTAssertEqual(Syntax(decl.name).propertyInParent, FunctionDeclSyntax.layout[.name])
  }

  func testPositionsDoNotDependOnWhetherTheNodeHoldsUnexpectedChildren() {
    let expr: ExprSyntax = "x"
    let unexpected = UnexpectedNodesSyntax([Syntax(TokenSyntax.identifier("junk"))])
    let plain = ReturnStmtSyntax(expression: expr)
    let withUnexpected = ReturnStmtSyntax(returnKeyword: .keyword(.return), unexpected, expression: expr)
    for stmt in [plain, withUnexpected] {
      XCTAssertEqual(stmt.returnKeyword.propertyInParent, ReturnStmtSyntax.layout[.returnKeyword])
      XCTAssertEqual(stmt.expression!.propertyInParent, ReturnStmtSyntax.layout[.expression])
      XCTAssertEqual(stmt[property: ReturnStmtSyntax.layout[.expression]]??.id, stmt.expression!.id)
    }
    XCTAssertEqual(
      withUnexpected.unexpectedBetweenReturnKeywordAndExpression!.propertyInParent,
      ReturnStmtSyntax.layout[.unexpectedBetweenReturnKeywordAndExpression]
    )
    XCTAssertNil(plain[property: ReturnStmtSyntax.layout[.unexpectedBetweenReturnKeywordAndExpression]]!)
  }

  func testPositionsInAKindThatDoesNotInterleaveUnexpectedChildren() {
    let decl = UnexpectedCodeDeclSyntax(
      unexpectedCode: UnexpectedNodesSyntax([Syntax(TokenSyntax.identifier("junk"))])
    )
    XCTAssertEqual(decl.unexpectedCode.propertyInParent, UnexpectedCodeDeclSyntax.layout[.unexpectedCode])
    XCTAssertEqual(decl[property: .unexpectedCode].id, decl.unexpectedCode.id)
  }

  func testTypedSubscriptReturnsTheChild() {
    let stmt = returnStmt("return x")
    let keyword: TokenSyntax = stmt[property: .returnKeyword]
    XCTAssertEqual(keyword.id, stmt.returnKeyword.id)
    let expr: ExprSyntax? = stmt[property: .expression]
    XCTAssertEqual(expr?.id, stmt.expression?.id)
    XCTAssertNil(returnStmt("return")[property: .expression])
  }

  func testTypedSubscriptReturnsAChoicesChildAsItsChoicesType() {
    let item = functionDecl("func foo() { bar() }").body!.statements.first!
    let value: CodeBlockItemSyntax.Item = item[property: .item]
    XCTAssertEqual(value.id, item.item.id)
  }

  func testPlaceholderChildTypeIsInferredFromTheNodeTypeAndProperty() {
    let expr = InfixOperatorExprSyntax(
      leftOperand: DeclReferenceExprSyntax(baseName: .identifier("a")),
      operator: BinaryOperatorExprSyntax(operator: .binaryOperator("+")),
      rightOperand: DeclReferenceExprSyntax(baseName: .identifier("b"))
    )
    let side = SyntaxProperty<InfixOperatorExprSyntax, _>.leftOperand
    let operand: ExprSyntax = expr[property: side]
    XCTAssertEqual(operand.id, expr.leftOperand.id)
  }

  func testSubscriptSetterReplacesAndRemovesTheChild() {
    var stmt = returnStmt("return x")
    stmt[property: .expression] = ExprSyntax("y")
    XCTAssertEqual(stmt.description, "return y")
    stmt[property: .expression] = nil
    XCTAssertNil(stmt.expression)

    var decl = functionDecl("func foo() -> Int {}")
    decl[property: .signature][property: .returnClause] = nil
    XCTAssertNil(decl.signature.returnClause)
    XCTAssertEqual(decl.name.text, "foo")
  }

  func testWithReplacesTheChildAndLeavesTheOriginalUnchanged() {
    let decl = functionDecl("func foo() {}")
    let renamed = decl.with(.name, .identifier("bar"))
    XCTAssertEqual(renamed.description, "func bar() {}")
    XCTAssertEqual(decl.description, "func foo() {}")

    let stmt = returnStmt("return x")
    let replaced = stmt.with(.expression, "y")
    XCTAssertEqual(replaced.description, "return y")
    XCTAssertEqual(replaced.expression!.propertyInParent, ReturnStmtSyntax.layout[.expression])
  }

  func testWithNilRemovesAnOptionalChild() {
    let removed = returnStmt("return x").with(.expression, nil)
    XCTAssertNil(removed.expression)
    XCTAssertEqual(removed.description, "return ")
  }

  func testPropertyOfChildIsThePositionThatChildReportsInItsParent() {
    let decl = functionDecl("func foo(x: Int) -> Int { return x }")
    for node in [Syntax(decl), Syntax(decl.signature), Syntax(decl.body!.statements.first!)] {
      let layoutView = node.raw.layoutView!
      let positions = layoutView.children.indices.filter { layoutView.children[$0] != nil }
        .map { layoutView.propertyOfChild(at: $0) }
      XCTAssertEqual(positions, node.children(viewMode: .all).map(\.propertyInParent))
    }
  }

  func testPropertyOfChildIsNilForACollectionAndOutOfRange() {
    let decl = functionDecl("func foo() { bar() }")
    XCTAssertNil(decl.body!.statements.raw.layoutView!.propertyOfChild(at: 0))
    XCTAssertNil(decl.raw.layoutView!.propertyOfChild(at: -1))
    XCTAssertNil(decl.raw.layoutView!.propertyOfChild(at: decl.raw.layoutView!.children.count))
  }
}
