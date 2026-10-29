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

@_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) import SwiftParser
@_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) import SwiftSyntax
import XCTest

final class SendExpressionTests: ParserTestCase {
  override var languageFeatures: Parser.LanguageFeatures {
    [.sendCalls]
  }

  func testBasic() {
    assertParse(
      """
      send x.f()
      """,
      substructure: SendExprSyntax(
        expression: FunctionCallExprSyntax(
          calledExpression: MemberAccessExprSyntax(
            base: DeclReferenceExprSyntax(baseName: .identifier("x")),
            declName: DeclReferenceExprSyntax(baseName: .identifier("f"))
          ),
          leftParen: .leftParenToken(),
          arguments: [],
          rightParen: .rightParenToken()
        )
      )
    )
  }

  func testTryPrecedesSend() {
    assertParse(
      """
      try send x.f()
      """,
      substructure: TryExprSyntax(
        expression: SendExprSyntax(
          expression: FunctionCallExprSyntax(
            calledExpression: MemberAccessExprSyntax(
              base: DeclReferenceExprSyntax(baseName: .identifier("x")),
              declName: DeclReferenceExprSyntax(baseName: .identifier("f"))
            ),
            leftParen: .leftParenToken(),
            arguments: [],
            rightParen: .rightParenToken()
          )
        )
      )
    )
  }

  func testSendBeforeSelfCall() {
    assertParse(
      """
      send self.foo()
      """,
      substructure: SendExprSyntax(
        expression: FunctionCallExprSyntax(
          calledExpression: MemberAccessExprSyntax(
            base: DeclReferenceExprSyntax(baseName: .keyword(.self)),
            declName: DeclReferenceExprSyntax(baseName: .identifier("foo"))
          ),
          leftParen: .leftParenToken(),
          arguments: [],
          rightParen: .rightParenToken()
        )
      )
    )
  }

  func testSendBeforeIdentifierCall() {
    assertParse(
      """
      send foo()
      """,
      substructure: SendExprSyntax(
        expression: FunctionCallExprSyntax(
          calledExpression: DeclReferenceExprSyntax(baseName: .identifier("foo")),
          leftParen: .leftParenToken(),
          arguments: [],
          rightParen: .rightParenToken()
        )
      )
    )
  }

  func testSendBeforeDollarIdentifierCall() {
    assertParse(
      """
      send $0.f()
      """,
      substructure: SendExprSyntax(
        expression: FunctionCallExprSyntax(
          calledExpression: MemberAccessExprSyntax(
            base: DeclReferenceExprSyntax(baseName: .dollarIdentifier("$0")),
            declName: DeclReferenceExprSyntax(baseName: .identifier("f"))
          ),
          leftParen: .leftParenToken(),
          arguments: [],
          rightParen: .rightParenToken()
        )
      )
    )
  }

  func testAwaitPrecedesSend() {
    assertParse(
      """
      await send x.f()
      """,
      substructure: AwaitExprSyntax(
        expression: SendExprSyntax(
          expression: FunctionCallExprSyntax(
            calledExpression: MemberAccessExprSyntax(
              base: DeclReferenceExprSyntax(baseName: .identifier("x")),
              declName: DeclReferenceExprSyntax(baseName: .identifier("f"))
            ),
            leftParen: .leftParenToken(),
            arguments: [],
            rightParen: .rightParenToken()
          )
        )
      )
    )
  }

  func testSendRemainsUsableAsIdentifier() {
    assertParse(
      """
      let send = 1
      """
    )

    assertParse(
      """
      func send() {}
      """
    )

    assertParse(
      """
      send(x)
      """,
      substructure: FunctionCallExprSyntax(
        calledExpression: DeclReferenceExprSyntax(baseName: .identifier("send")),
        leftParen: .leftParenToken(),
        arguments: [LabeledExprSyntax(expression: DeclReferenceExprSyntax(baseName: .identifier("x")))],
        rightParen: .rightParenToken()
      )
    )

    assertParse(
      """
      x.send
      """
    )

    assertParse(
      """
      send = 2
      """
    )
  }

  func testSendLookaheadStaysSourceCompatible() {
    assertParse(
      "send(x)",
      substructure: FunctionCallExprSyntax(
        calledExpression: DeclReferenceExprSyntax(baseName: .identifier("send")),
        leftParen: .leftParenToken(),
        arguments: [LabeledExprSyntax(expression: DeclReferenceExprSyntax(baseName: .identifier("x")))],
        rightParen: .rightParenToken()
      )
    )
    assertParse("x.send(y)")
    assertParse(
      "send { }",
      substructure: FunctionCallExprSyntax(
        calledExpression: DeclReferenceExprSyntax(baseName: .identifier("send")),
        arguments: [],
        trailingClosure: ClosureExprSyntax(statements: [])
      )
    )
    assertParse("{ send in send }")
    assertParse("let send = 1")
    assertParse("send = 2")
    assertParse("foo(send)")
    assertParse(
      """
      send
      foo()
      """
    )
    assertParse("send.foo()")
    assertParse("send?.foo()")
    assertParse("send[0]")
    assertParse("send + 1")
    assertParse("send as Int")
  }

  func testSendFollowedByIdentifierOnNextLineIsNotAKeyword() {
    // Matches the C++ parser: 'send' followed by an identifier on the next
    // line is a reference to 'send' followed by a separate statement
    assertParse(
      """
      send
      logger.log()
      """,
      substructure: CodeBlockItemListSyntax([
        CodeBlockItemSyntax(item: .expr(ExprSyntax(DeclReferenceExprSyntax(baseName: .identifier("send"))))),
        CodeBlockItemSyntax(
          item: .expr(
            ExprSyntax(
              FunctionCallExprSyntax(
                calledExpression: MemberAccessExprSyntax(
                  base: DeclReferenceExprSyntax(baseName: .identifier("logger")),
                  declName: DeclReferenceExprSyntax(baseName: .identifier("log"))
                ),
                leftParen: .leftParenToken(),
                arguments: [],
                rightParen: .rightParenToken()
              )
            )
          )
        ),
      ])
    )
  }

  func testVariableNamedSend() {
    assertParse(
      """
      var send = 1
      send = 2
      print(send)
      let value = send
      """
    )
  }

  func testSendNotAKeywordBeforeOtherKeywords() {
    // Only an identifier, 'self' or a '$' identifier makes 'send' a keyword
    assertParse(
      """
      send1️⃣ try x.f()
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        )
      ],
      fixedSource: """
        send
        try x.f()
        """
    )
  }

  func testFeatureDisabled() {
    assertParse(
      """
      send1️⃣ x.f()
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        )
      ],
      fixedSource: """
        send
        x.f()
        """,
      languageFeatures: []
    )
  }
}
