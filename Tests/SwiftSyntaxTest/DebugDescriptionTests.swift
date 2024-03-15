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

import SwiftParser
import SwiftSyntax
import XCTest
import _SwiftSyntaxTestSupport

private extension String {
  // This implementation is really slow; to use it outside a test it should be optimized.
  func trimmingTrailingWhitespace() -> String {
    return self.replacingOccurrences(of: "[ ]+\\n", with: "\n", options: .regularExpression)
  }
}

class DebugDescriptionTests: XCTestCase {
  public func testDump() {
    struct TestCase {
      let syntax: Any
      let expectedDumped: String
    }

    let testCases: [UInt: TestCase] = [
      #line: .init(
        syntax: TokenSyntax.keyword(.associatedtype, leadingTrivia: [], trailingTrivia: []),
        expectedDumped: """
          ▿ keyword(SwiftSyntax.Keyword.associatedtype)
            - text: "associatedtype"
            ▿ leadingTrivia: []
              - pieces: 0 elements
            ▿ trailingTrivia: []
              - pieces: 0 elements
            ▿ tokenKind: SwiftSyntax.TokenKind.keyword
              - keyword: SwiftSyntax.Keyword.associatedtype

          """
      ),
      #line: {
        let leftToken = TokenSyntax.leftSquareToken()
        let elements = ArrayElementListSyntax([])
        let rightToken = TokenSyntax.rightSquareToken()
        let expr = ArrayExprSyntax(
          leftSquare: leftToken,
          elements: elements,
          rightSquare: rightToken
        )
        return .init(
          syntax: expr.tokens(viewMode: .sourceAccurate),
          expectedDumped: """
            ▿ SwiftSyntax.TokenSequence
              ▿ leftSquare
                - text: "["
                ▿ leadingTrivia: []
                  - pieces: 0 elements
                ▿ trailingTrivia: []
                  - pieces: 0 elements
                - tokenKind: SwiftSyntax.TokenKind.leftSquare
              ▿ rightSquare
                - text: "]"
                ▿ leadingTrivia: []
                  - pieces: 0 elements
                ▿ trailingTrivia: []
                  - pieces: 0 elements
                - tokenKind: SwiftSyntax.TokenKind.rightSquare

            """
        )
      }(),
      #line: {
        let leftToken = TokenSyntax.leftSquareToken()
        let elements = ArrayElementListSyntax([])
        let rightToken = TokenSyntax.rightSquareToken()
        let expr = ArrayExprSyntax(
          leftSquare: leftToken,
          elements: elements,
          rightSquare: rightToken
        )
        return .init(
          syntax: expr.tokens(viewMode: .sourceAccurate).reversed(),
          expectedDumped: """
            ▿ SwiftSyntax.ReversedTokenSequence
              ▿ rightSquare
                - text: "]"
                ▿ leadingTrivia: []
                  - pieces: 0 elements
                ▿ trailingTrivia: []
                  - pieces: 0 elements
                - tokenKind: SwiftSyntax.TokenKind.rightSquare
              ▿ leftSquare
                - text: "["
                ▿ leadingTrivia: []
                  - pieces: 0 elements
                ▿ trailingTrivia: []
                  - pieces: 0 elements
                - tokenKind: SwiftSyntax.TokenKind.leftSquare

            """
        )
      }(),
      #line: {
        let token1 = TokenSyntax.integerLiteral("1")
        let expr1 = IntegerLiteralExprSyntax(literal: token1)
        let token2 = TokenSyntax.integerLiteral("2")
        let expr2 = IntegerLiteralExprSyntax(literal: token2)
        let elements = [
          LabeledExprSyntax(expression: expr1),
          LabeledExprSyntax(expression: expr2),
        ]
        let tuples = LabeledExprListSyntax(elements)
        return .init(
          syntax: tuples,
          expectedDumped: """
            - LabeledExprListSyntax
            ├─[0]: LabeledExprSyntax
            │ ╰─expression: IntegerLiteralExprSyntax
            │   ╰─literal: integerLiteral("1")
            ╰─[1]: LabeledExprSyntax
              ╰─expression: IntegerLiteralExprSyntax
                ╰─literal: integerLiteral("2")

            """
        )
      }(),
      #line: {
        let token1 = TokenSyntax.integerLiteral("1")
        let expr1 = IntegerLiteralExprSyntax(literal: token1)
        let token2 = TokenSyntax.integerLiteral("2")
        let expr2 = IntegerLiteralExprSyntax(literal: token2)
        let elements = [
          LabeledExprSyntax(expression: expr1),
          LabeledExprSyntax(expression: expr2),
        ]
        let tuples = LabeledExprListSyntax(elements)
        return .init(
          syntax: tuples.reversed(),
          expectedDumped: """
            ▿ Swift.ReversedCollection<SwiftSyntax.LabeledExprListSyntax>
              - _base: LabeledExprListSyntax
            ├─[0]: LabeledExprSyntax
            │ ╰─expression: IntegerLiteralExprSyntax
            │   ╰─literal: integerLiteral("1")
            ╰─[1]: LabeledExprSyntax
              ╰─expression: IntegerLiteralExprSyntax
                ╰─literal: integerLiteral("2")

            """
        )
      }(),
    ]

    testCases.forEach { keyAndValue in
      let (key:line, value:testCase) = keyAndValue
      var actualDumped = ""
      dump(testCase.syntax, to: &actualDumped)
      assertStringsEqualWithDiff(
        actualDumped.trimmingTrailingWhitespace(),
        testCase.expectedDumped.trimmingTrailingWhitespace(),
        line: line
      )
    }
  }

  #if DEBUG
  // debugInitCall is only available in debug builds, so we can only test it in those.
  // swift-format-ignore
  @available(*, deprecated, message: "Purposefully tests debugInitCall, which is marked deprecated for debugger use only")
  func testDebugInitCall() {
    let sourceFile: SourceFileSyntax = """
      test(1, 2)
      """

    assertStringsEqualWithDiff(
      sourceFile.debugInitCall(includeTrivia: true).trimmingTrailingWhitespace(),
      """
      SourceFileSyntax(
          statements: CodeBlockItemListSyntax([
                CodeBlockItemSyntax(item: CodeBlockItemSyntax.Item(FunctionCallExprSyntax(
                        calledExpression: ExprSyntax(DeclReferenceExprSyntax(baseName: .identifier("test"))),
                        leftParen: .leftParenToken(),
                        arguments: LabeledExprListSyntax([
                              LabeledExprSyntax(
                                  expression: ExprSyntax(IntegerLiteralExprSyntax(literal: .integerLiteral("1"))),
                                  trailingComma: .commaToken(trailingTrivia: .space)
                                ),
                              LabeledExprSyntax(expression: ExprSyntax(IntegerLiteralExprSyntax(literal: .integerLiteral("2"))))
                            ]),
                        rightParen: .rightParenToken(),
                        additionalTrailingClosures: MultipleTrailingClosureElementListSyntax([])
                      )))
              ]),
          endOfFileToken: .endOfFileToken()
        )
      """
    )

    assertStringsEqualWithDiff(
      sourceFile.debugInitCall(includeTrivia: false).trimmingTrailingWhitespace(),
      """
      SourceFileSyntax(
          statements: CodeBlockItemListSyntax([
                CodeBlockItemSyntax(item: CodeBlockItemSyntax.Item(FunctionCallExprSyntax(
                        calledExpression: ExprSyntax(DeclReferenceExprSyntax(baseName: .identifier("test"))),
                        leftParen: .leftParenToken(),
                        arguments: LabeledExprListSyntax([
                              LabeledExprSyntax(
                                  expression: ExprSyntax(IntegerLiteralExprSyntax(literal: .integerLiteral("1"))),
                                  trailingComma: .commaToken()
                                ),
                              LabeledExprSyntax(expression: ExprSyntax(IntegerLiteralExprSyntax(literal: .integerLiteral("2"))))
                            ]),
                        rightParen: .rightParenToken(),
                        additionalTrailingClosures: MultipleTrailingClosureElementListSyntax([])
                      )))
              ]),
          endOfFileToken: .endOfFileToken()
        )
      """
    )
  }
  #endif
}
