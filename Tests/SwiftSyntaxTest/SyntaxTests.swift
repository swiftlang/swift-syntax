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

import SwiftSyntax
import XCTest

class SyntaxTests: XCTestCase {

  public func testHasError() {
    XCTAssertTrue(TokenSyntax.keyword(.func, presence: .missing).hasError)
    XCTAssertFalse(TokenSyntax.keyword(.func, presence: .present).hasError)
    XCTAssertTrue(UnexpectedNodesSyntax([]).hasError)
    XCTAssertTrue(MissingExprSyntax().hasError)
    XCTAssertFalse(CodeBlockItemListSyntax([]).hasError)

    XCTAssertTrue(
      FunctionDeclSyntax(
        funcKeyword: TokenSyntax.keyword(.func, presence: .missing),
        name: .identifier("foo"),
        signature: FunctionSignatureSyntax(parameterClause: FunctionParameterClauseSyntax(parameters: []))
      ).hasError
    )
    XCTAssertFalse(
      FunctionDeclSyntax(
        funcKeyword: TokenSyntax.keyword(.func, presence: .present),
        name: .identifier("foo"),
        signature: FunctionSignatureSyntax(parameterClause: FunctionParameterClauseSyntax(parameters: []))
      ).hasError
    )
  }

  public func testDetached() {
    let s = StructDeclSyntax(
      structKeyword: .keyword(.struct),
      name: .identifier("someStruct"),
      memberBlock: MemberBlockSyntax(leftBrace: .leftBraceToken(), members: [], rightBrace: .rightBraceToken())
    )

    XCTAssertEqual(Syntax(s), s.memberBlock.parent)
    XCTAssertNil(s.memberBlock.detached.parent)
  }

  public func testCasting() {
    let integerExpr = IntegerLiteralExprSyntax(
      literal: .integerLiteral("1", trailingTrivia: .space)
    )

    let expr = ExprSyntax(integerExpr)
    let node = Syntax(expr)
    XCTAssertTrue(expr.is(IntegerLiteralExprSyntax.self))
    XCTAssertTrue(node.is(IntegerLiteralExprSyntax.self))
    XCTAssertTrue(node.as(ExprSyntax.self)!.is(IntegerLiteralExprSyntax.self))

    XCTAssertTrue(node.isProtocol(ExprSyntaxProtocol.self))
    XCTAssertTrue(node.asProtocol(ExprSyntaxProtocol.self) is IntegerLiteralExprSyntax)
    XCTAssertTrue(expr.asProtocol(ExprSyntaxProtocol.self) is IntegerLiteralExprSyntax)
    XCTAssertTrue(expr.asProtocol(ExprSyntaxProtocol.self) as? IntegerLiteralExprSyntax == integerExpr)

    XCTAssertFalse(node.isProtocol(BracedSyntax.self))
    XCTAssertNil(node.asProtocol(BracedSyntax.self))
    XCTAssertFalse(expr.isProtocol(BracedSyntax.self))
    XCTAssertNil(expr.asProtocol(BracedSyntax.self))

    let classDecl = CodeBlockSyntax(
      leftBrace: TokenSyntax.leftBraceToken(),
      statements: CodeBlockItemListSyntax([]),
      rightBrace: TokenSyntax.rightBraceToken()
    )

    XCTAssertTrue(classDecl.isProtocol(BracedSyntax.self))
    XCTAssertNotNil(classDecl.asProtocol(BracedSyntax.self))

    let optNode: Syntax? = node
    switch optNode?.as(SyntaxEnum.self) {
    case .integerLiteralExpr: break
    default: XCTFail("failed to convert to SyntaxEnum")
    }

    switch expr.as(ExprSyntaxEnum.self) {
    case .integerLiteralExpr: break
    default: XCTFail("failed to convert to ExprSyntaxEnum")
    }

    XCTAssertNil(ExprSyntax(nil as IntegerLiteralExprSyntax?))
    XCTAssertEqual(ExprSyntax(integerExpr).as(IntegerLiteralExprSyntax.self)!, integerExpr)
  }

  public func testNodeType() {
    let integerExpr = IntegerLiteralExprSyntax(
      literal: TokenSyntax.integerLiteral("1", trailingTrivia: .space)
    )
    let expr = ExprSyntax(integerExpr)
    let node = Syntax(expr)

    XCTAssertTrue(integerExpr.syntaxNodeType == expr.syntaxNodeType)
    XCTAssertTrue(integerExpr.syntaxNodeType == node.syntaxNodeType)
    XCTAssertEqual("\(integerExpr.syntaxNodeType)", "IntegerLiteralExprSyntax")
  }

  public func testConstructFromSyntaxProtocol() {
    let integerExpr = IntegerLiteralExprSyntax(
      literal: .integerLiteral("1", trailingTrivia: .space)
    )

    XCTAssertEqual(Syntax(integerExpr), Syntax(fromProtocol: integerExpr as SyntaxProtocol))
    XCTAssertEqual(Syntax(integerExpr), Syntax(fromProtocol: integerExpr as ExprSyntaxProtocol))
  }

  public func testPositions() {
    let leading = Trivia(pieces: [.spaces(2)])
    let trailing = Trivia(pieces: [.spaces(1)])
    let funcKW = TokenSyntax.keyword(
      .func,
      leadingTrivia: leading,
      trailingTrivia: trailing
    )
    XCTAssertEqual("\(funcKW)", "  func ")
    XCTAssertEqual(funcKW.position, AbsolutePosition(utf8Offset: 0))
    XCTAssertEqual(funcKW.positionAfterSkippingLeadingTrivia, AbsolutePosition(utf8Offset: 2))
    XCTAssertEqual(funcKW.endPositionBeforeTrailingTrivia, AbsolutePosition(utf8Offset: 6))
    XCTAssertEqual(funcKW.endPosition, AbsolutePosition(utf8Offset: 7))
    XCTAssertEqual(funcKW.trimmedLength, SourceLength(utf8Length: 4))
  }

  public func testEnumCaseParameterSyntaxConvenienceInit() {
    let noFirstName = EnumCaseParameterSyntax(type: TypeSyntax("MyType"))
    XCTAssertEqual(noFirstName.formatted().description, "MyType")

    let node = EnumCaseParameterSyntax(firstName: "label", type: TypeSyntax("MyType"))
    XCTAssertEqual(node.formatted().description, "label: MyType")
  }

  public func testClosureCaptureSyntaxConvenienceInitWithEqual() {
    let noNameClosureCapture = ClosureCaptureSyntax(expression: ExprSyntax("123"))
    XCTAssertEqual(noNameClosureCapture.formatted().description, "123")

    let node = ClosureCaptureSyntax(name: "test", expression: ExprSyntax("123"))
    XCTAssertEqual(node.formatted().description, "test = 123")
  }

  func testShareSyntaxIndexInTreeBetweenTrees() throws {
    let source = "func foo() {}"

    let tree1 = DeclSyntax(stringLiteral: source)
    let tree2 = DeclSyntax(stringLiteral: source)

    let funcKeywordInTree1 = try XCTUnwrap(tree1.firstToken(viewMode: .sourceAccurate))
    XCTAssertEqual(funcKeywordInTree1.tokenKind, .keyword(.func))

    let opaqueIndexInTree1 = funcKeywordInTree1.id.indexInTree.toOpaque()

    let funcKeywordIdentifierInTree2 = try XCTUnwrap(
      SyntaxIdentifier.fromIndexInTree(
        SyntaxIdentifier.SyntaxIndexInTree(fromOpaque: opaqueIndexInTree1),
        relativeToRoot: tree2
      )
    )
    let funcKeywordInTree2 = tree2.node(at: funcKeywordIdentifierInTree2)
    XCTAssertEqual(funcKeywordInTree2?.as(TokenSyntax.self)?.tokenKind, .keyword(.func))
    XCTAssertNotEqual(funcKeywordInTree1.id, funcKeywordInTree2?.id)
  }
}
