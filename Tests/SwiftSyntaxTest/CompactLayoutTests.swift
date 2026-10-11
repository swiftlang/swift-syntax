//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftParser
import SwiftSyntax
import XCTest

/// A node keeps no room for its `unexpected` children until it has one, so
/// writing one into a node that has none has to grow it, and taking the last one
/// away has to shrink it again. Both are decided when the node is rebuilt rather
/// than tracked, so what these guarantee is that a node reached by mutating
/// another is indistinguishable from the same node built outright.
final class CompactLayoutTests: XCTestCase {
  private var unexpected: UnexpectedNodesSyntax {
    UnexpectedNodesSyntax([Syntax(TokenSyntax.identifier("unexpectedHere"))])
  }

  private func nodeCount(_ node: Syntax) -> Int {
    1 + node.children(viewMode: .all).reduce(0) { $0 + nodeCount($1) }
  }

  private func assertSame(
    _ mutated: some SyntaxProtocol,
    _ built: some SyntaxProtocol,
    _ message: String,
    file: StaticString = #filePath,
    line: UInt = #line
  ) {
    XCTAssertEqual(mutated.description, built.description, "\(message): text", file: file, line: line)
    XCTAssertEqual(
      Syntax(mutated).children(viewMode: .all).map(\.kind),
      Syntax(built).children(viewMode: .all).map(\.kind),
      "\(message): children",
      file: file,
      line: line
    )
    XCTAssertEqual(
      nodeCount(Syntax(mutated)),
      nodeCount(Syntax(built)),
      "\(message): node count",
      file: file,
      line: line
    )
    XCTAssertEqual(mutated.hasError, built.hasError, "\(message): error flag", file: file, line: line)
  }

  /// Writing an unexpected child into a node that had none gives the same node as
  /// building it with that child in the first place.
  func testGrowingANodeToHoldAnUnexpectedChild() {
    let expression = ExprSyntax(IntegerLiteralExprSyntax(literal: .integerLiteral("1")))

    var grown = ReturnStmtSyntax(returnKeyword: .keyword(.return), expression: expression)
    XCTAssertFalse(grown.hasError, "a node built without unexpected children has no error")
    grown.unexpectedBetweenReturnKeywordAndExpression = unexpected

    let built = ReturnStmtSyntax(
      returnKeyword: .keyword(.return),
      unexpected,
      expression: expression
    )

    assertSame(grown, built, "grown to hold an unexpected child")
    XCTAssertTrue(grown.hasError, "an unexpected child makes the node an error node")
    XCTAssertEqual(grown.unexpectedBetweenReturnKeywordAndExpression?.description, "unexpectedHere")
  }

  /// Taking the last unexpected child away gives the same node as never having
  /// had one, which is the direction that has to shrink the node again.
  func testShrinkingANodeThatLosesItsLastUnexpectedChild() {
    let expression = ExprSyntax(IntegerLiteralExprSyntax(literal: .integerLiteral("1")))

    var shrunk = ReturnStmtSyntax(
      returnKeyword: .keyword(.return),
      unexpected,
      expression: expression
    )
    shrunk.unexpectedBetweenReturnKeywordAndExpression = nil

    let built = ReturnStmtSyntax(returnKeyword: .keyword(.return), expression: expression)

    assertSame(shrunk, built, "shrunk after losing its unexpected child")
    XCTAssertNil(shrunk.unexpectedBetweenReturnKeywordAndExpression)
  }

  /// Every `unexpected` slot of a node has to be reachable, not just the one in
  /// the middle: the slot before the first child and the one after the last are
  /// the edges of the region.
  func testEveryUnexpectedSlotOfANode() {
    let expression = ExprSyntax(IntegerLiteralExprSyntax(literal: .integerLiteral("1")))
    let base = ReturnStmtSyntax(returnKeyword: .keyword(.return), expression: expression)

    var withBefore = base
    withBefore.unexpectedBeforeReturnKeyword = unexpected
    assertSame(
      withBefore,
      ReturnStmtSyntax(unexpected, returnKeyword: .keyword(.return), expression: expression),
      "the slot before the first child"
    )

    var withAfter = base
    withAfter.unexpectedAfterExpression = unexpected
    assertSame(
      withAfter,
      ReturnStmtSyntax(returnKeyword: .keyword(.return), expression: expression, unexpected),
      "the slot after the last child"
    )

    var withAll = base
    withAll.unexpectedBeforeReturnKeyword = unexpected
    withAll.unexpectedBetweenReturnKeywordAndExpression = unexpected
    withAll.unexpectedAfterExpression = unexpected
    assertSame(
      withAll,
      ReturnStmtSyntax(
        unexpected,
        returnKeyword: .keyword(.return),
        unexpected,
        expression: expression,
        unexpected
      ),
      "every slot at once"
    )
  }

  /// A node that a rewriter rebuilds keeps its children, including the unexpected
  /// ones, whichever shape it started in.
  func testRewritingPreservesUnexpectedChildren() {
    let source = """
      func f() {
        return 1
      }
      """
    let parsed = Parser.parse(source: source)

    class Renamer: SyntaxRewriter {
      override func visit(_ token: TokenSyntax) -> TokenSyntax {
        token.tokenKind == .identifier("f") ? token.with(\.tokenKind, .identifier("g")) : token
      }
    }

    var edited = parsed
    if var stmt = edited.statements.first?.item.as(FunctionDeclSyntax.self)?.body?.statements.first?.item
      .as(ReturnStmtSyntax.self)
    {
      stmt.unexpectedAfterExpression = unexpected
      XCTAssertTrue(stmt.hasError)
      XCTAssertEqual(stmt.description.hasSuffix("unexpectedHere"), true)
    }

    let rewritten = Renamer(viewMode: .sourceAccurate).rewrite(edited)
    XCTAssertEqual(rewritten.description, source.replacingOccurrences(of: "func f", with: "func g"))
  }

  /// Growing and shrinking a node repeatedly must not drift, since each step
  /// rebuilds the node from the one before it.
  func testRepeatedGrowingAndShrinking() {
    let expression = ExprSyntax(IntegerLiteralExprSyntax(literal: .integerLiteral("1")))
    let base = ReturnStmtSyntax(returnKeyword: .keyword(.return), expression: expression)

    var node = base
    for _ in 0..<8 {
      node.unexpectedBetweenReturnKeywordAndExpression = unexpected
      XCTAssertTrue(node.hasError)
      node.unexpectedBetweenReturnKeywordAndExpression = nil
      XCTAssertFalse(node.hasError)
    }
    assertSame(node, base, "after eight rounds of growing and shrinking")
  }
}
