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

import SwiftSyntax
import _SwiftSyntaxTestSupport
import SwiftSyntaxParser
import XCTest

private func parse(source: String) throws -> Syntax {
  return try Syntax(SyntaxParser.parse(source: source))
}

public class SyntaxComparisonTests: XCTestCase {
  public func testSame() throws {
    let expected = Syntax(makeFunc(identifier: .identifier("f")))

    let actual = Syntax(makeFunc(identifier: .identifier("f")))
    XCTAssertNil(actual.findFirstDifference(baseline: expected))

    let matcher = try SubtreeMatcher("struct A { func f() { } }", parse: parse)
    try XCTAssertNil(matcher.findFirstDifference(baseline: expected))
  }

  public func testDifferentType() throws {
    let expected = Syntax(makeFunc(identifier: .identifier("f")))
    let actual = Syntax(makeBody())

    let diff = try XCTUnwrap(actual.findFirstDifference(baseline: expected))
    XCTAssertEqual(diff.reason, .nodeType)
    XCTAssertTrue(Syntax(diff.baseline).is(FunctionDeclSyntax.self))
    XCTAssertTrue(Syntax(diff.node).is(CodeBlockSyntax.self))
  }

  public func testDifferentTokenKind() throws {
    let expected = Syntax(makeFunc(identifier: .identifier("f"), keyword: .classKeyword()))

    func expectations(_ diff: TreeDifference?, file: StaticString = #filePath, line: UInt = #line) throws {
      let diff = try XCTUnwrap(diff, file: file, line: line)
      XCTAssertEqual(diff.reason, .token)
      XCTAssertEqual(Syntax(diff.baseline).as(TokenSyntax.self)?.tokenKind, .classKeyword)
      XCTAssertEqual(Syntax(diff.node).as(TokenSyntax.self)?.tokenKind, .funcKeyword)
    }

    let actual = Syntax(makeFunc(identifier: .identifier("f")))
    try expectations(actual.findFirstDifference(baseline: expected))

    let matcher = try SubtreeMatcher("struct A { 1️⃣func f() { } }", parse: parse)
    try expectations(matcher.findFirstDifference(baseline: expected))
  }

  public func testDifferentTokenText() throws {
    let expected = Syntax(makeFunc(identifier: .identifier("f")))
    func expectations(_ diff: TreeDifference?, file: StaticString = #filePath, line: UInt = #line) throws {
      let diff = try XCTUnwrap(diff, file: file, line: line)
      XCTAssertEqual(diff.reason, .token)
      XCTAssertEqual(Syntax(diff.baseline).as(TokenSyntax.self)?.tokenKind, .identifier("f"))
      XCTAssertEqual(Syntax(diff.node).as(TokenSyntax.self)?.tokenKind, .identifier("g"))
    }

    let actual = Syntax(makeFunc(identifier: .identifier("g")))
    try expectations(actual.findFirstDifference(baseline: expected))

    let matcher = try SubtreeMatcher("struct A { 1️⃣func g() { } }", parse: parse)
    try expectations(matcher.findFirstDifference(afterMarker: "1️⃣", baseline: expected))
  }

  public func testDifferentTrivia() throws {
    let expected = Syntax(makeFunc(identifier: .identifier("f"), indent: 2))
    func expectations(_ diff: TreeDifference?, file: StaticString = #filePath, line: UInt = #line) throws {
      let diff = try XCTUnwrap(diff, file: file, line: line)
      XCTAssertEqual(diff.reason, .trivia)
      XCTAssertEqual(diff.baseline.leadingTrivia, .spaces(2))
      XCTAssertEqual(diff.node.leadingTrivia, [])
    }

    let actual = Syntax(makeFunc(identifier: .identifier("f")))
    XCTAssertNil(actual.findFirstDifference(baseline: expected))
    try expectations(actual.findFirstDifference(baseline: expected, includeTrivia: true))

    let matcher = try SubtreeMatcher("struct A {func f() { }}", parse: parse)
    try XCTAssertNil(matcher.findFirstDifference(baseline: expected))
    try expectations(matcher.findFirstDifference(baseline: expected, includeTrivia: true))
  }

  public func testDifferentPresence() throws {
    let expected = Syntax(
      makeFunc(
        identifier: .identifier("f"),
        body: CodeBlockSyntax(
          leftBrace: .leftBraceToken(presence: .missing),
          statements: CodeBlockItemListSyntax([]),
          rightBrace: .leftBraceToken(presence: .missing)
        )
      )
    )
    func expectations(_ diff: TreeDifference?, file: StaticString = #filePath, line: UInt = #line) throws {
      let diff = try XCTUnwrap(diff, file: file, line: line)
      XCTAssertEqual(diff.reason, .presence)
      XCTAssertEqual(diff.baseline.as(TokenSyntax.self)?.presence, .missing)
      XCTAssertEqual(diff.node.as(TokenSyntax.self)?.presence, .present)
    }

    let actual = Syntax(makeFunc(identifier: .identifier("f")))
    try expectations(actual.findFirstDifference(baseline: expected))

    let matcher = try SubtreeMatcher("struct A { func f() { } }", parse: parse)
    try expectations(matcher.findFirstDifference(baseline: expected))
  }

  public func testMissingNode() throws {
    let expected = Syntax(makeFunc(identifier: .identifier("f"), body: makeBody(statementCount: 1)))
    func expectations(_ diff: TreeDifference?, file: StaticString = #filePath, line: UInt = #line) throws {
      let diff = try XCTUnwrap(diff, file: file, line: line)
      XCTAssertEqual(diff.reason, .missingNode)
    }

    let actual = Syntax(makeFunc(identifier: .identifier("f")))
    try expectations(actual.findFirstDifference(baseline: expected))

    let matcher = try SubtreeMatcher("struct A { func f() { } }", parse: parse)
    try expectations(matcher.findFirstDifference(baseline: expected))
  }

  public func testAdditionalNode() throws {
    let expected = Syntax(makeFunc(identifier: .identifier("f")))
    func expectations(_ diff: TreeDifference?, file: StaticString = #filePath, line: UInt = #line) throws {
      let diff = try XCTUnwrap(diff, file: file, line: line)
      XCTAssertEqual(diff.reason, .additionalNode)
    }

    let actual = Syntax(makeFunc(identifier: .identifier("f"), body: makeBody(statementCount: 1)))
    try expectations(actual.findFirstDifference(baseline: expected))

    let matcher = try SubtreeMatcher(
      """
      struct A {
        func f() {
          0
        }
      }
      """,
      parse: parse
    )
    try expectations(matcher.findFirstDifference(baseline: expected))
  }

  public func testMultipleSubtreeMatches() throws {
    let expectedFunc = Syntax(makeFunc(identifier: .identifier("f")))
    let expectedBody = Syntax(makeBody())

    let matcher = try SubtreeMatcher(
      """
      struct A {
        1️⃣
        let member = 1

        func f() 2️⃣{
          0
        }
      }
      """,
      parse: parse
    )
    let funcDiff = try XCTUnwrap(matcher.findFirstDifference(afterMarker: "1️⃣", baseline: expectedFunc))
    XCTAssertEqual(funcDiff.reason, .additionalNode)

    let bodyDiff = try XCTUnwrap(matcher.findFirstDifference(afterMarker: "2️⃣", baseline: expectedBody))
    XCTAssertEqual(bodyDiff.reason, .additionalNode)
  }

  /// Generates a `FunctionDeclSyntax` with the given `identifier`, `keyword`,
  /// and `body` with some optional leading indentation (which applied only to
  /// the start, not the entire body).
  private func makeFunc(
    identifier: TokenSyntax,
    keyword: TokenSyntax = .funcKeyword(),
    body: CodeBlockSyntax? = nil,
    indent: Int = 0
  ) -> FunctionDeclSyntax {
    let funcBody: CodeBlockSyntax
    if let body = body {
      funcBody = body
    } else {
      funcBody = makeBody()
    }
    let emptySignature = FunctionSignatureSyntax(
      input: ParameterClauseSyntax(
        leftParen: .leftParenToken(),
        parameterList: FunctionParameterListSyntax([]),
        rightParen: .rightParenToken()
      )
    )
    let fd = FunctionDeclSyntax(
      funcKeyword: keyword,
      identifier: identifier,
      signature: emptySignature,
      body: funcBody
    )
    if indent > 0 {
      return fd.withLeadingTrivia(.spaces(indent))
    }
    return fd
  }

  /// Creates a `CodeBlockSyntax` that consists of `statementCount` integer
  /// literals with increasing values. Ie. `makeBody(statementCount: 2)`
  /// generates:
  /// ```
  /// {
  ///   0
  ///   1
  /// }
  /// ```
  private func makeBody(statementCount: Int = 0) -> CodeBlockSyntax {
    var items = [CodeBlockItemSyntax]()
    for i in 0..<statementCount {
      let literal = IntegerLiteralExprSyntax(digits: .integerLiteral(String(i)))
      items.append(CodeBlockItemSyntax(item: .init(literal)))
    }
    let block = CodeBlockItemListSyntax(items)
    return CodeBlockSyntax(
      leftBrace: .leftBraceToken(),
      statements: block,
      rightBrace: .rightBraceToken()
    )
  }
}
