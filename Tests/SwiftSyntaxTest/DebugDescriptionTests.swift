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

import XCTest
import SwiftSyntax
import _SwiftSyntaxTestSupport
import SwiftParser

private extension String {
  // This implementation is really slow; to use it outside a test it should be optimized.
  func trimmingTrailingWhitespace() -> String {
    return self.replacingOccurrences(of: "[ ]+\\n", with: "\n", options: .regularExpression)
  }
}

public class DebugDescriptionTests: XCTestCase {
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
        let leftToken = TokenSyntax.leftSquareBracketToken()
        let elements = ArrayElementListSyntax([])
        let rightToken = TokenSyntax.rightSquareBracketToken()
        let expr = ArrayExprSyntax(
          leftSquare: leftToken,
          elements: elements,
          rightSquare: rightToken
        )
        return .init(
          syntax: expr.tokens(viewMode: .sourceAccurate),
          expectedDumped: """
            ▿ SwiftSyntax.TokenSequence
              ▿ leftSquareBracket
                - text: "["
                ▿ leadingTrivia: []
                  - pieces: 0 elements
                ▿ trailingTrivia: []
                  - pieces: 0 elements
                - tokenKind: SwiftSyntax.TokenKind.leftSquareBracket
              ▿ rightSquareBracket
                - text: "]"
                ▿ leadingTrivia: []
                  - pieces: 0 elements
                ▿ trailingTrivia: []
                  - pieces: 0 elements
                - tokenKind: SwiftSyntax.TokenKind.rightSquareBracket

            """
        )
      }(),
      #line: {
        let leftToken = TokenSyntax.leftSquareBracketToken()
        let elements = ArrayElementListSyntax([])
        let rightToken = TokenSyntax.rightSquareBracketToken()
        let expr = ArrayExprSyntax(
          leftSquare: leftToken,
          elements: elements,
          rightSquare: rightToken
        )
        return .init(
          syntax: expr.tokens(viewMode: .sourceAccurate).reversed(),
          expectedDumped: """
            ▿ SwiftSyntax.ReversedTokenSequence
              ▿ rightSquareBracket
                - text: "]"
                ▿ leadingTrivia: []
                  - pieces: 0 elements
                ▿ trailingTrivia: []
                  - pieces: 0 elements
                - tokenKind: SwiftSyntax.TokenKind.rightSquareBracket
              ▿ leftSquareBracket
                - text: "["
                ▿ leadingTrivia: []
                  - pieces: 0 elements
                ▿ trailingTrivia: []
                  - pieces: 0 elements
                - tokenKind: SwiftSyntax.TokenKind.leftSquareBracket

            """
        )
      }(),
      #line: {
        let token1 = TokenSyntax.integerLiteral("1")
        let expr1 = IntegerLiteralExprSyntax(digits: token1)
        let token2 = TokenSyntax.integerLiteral("2")
        let expr2 = IntegerLiteralExprSyntax(digits: token2)
        let elements = [
          TupleExprElementSyntax(expression: expr1),
          TupleExprElementSyntax(expression: expr2),
        ]
        let tuples = TupleExprElementListSyntax(elements)
        return .init(
          syntax: tuples,
          expectedDumped: """
            - TupleExprElementListSyntax
            ├─[0]: TupleExprElementSyntax
            │ ╰─expression: IntegerLiteralExprSyntax
            │   ╰─digits: integerLiteral("1")
            ╰─[1]: TupleExprElementSyntax
              ╰─expression: IntegerLiteralExprSyntax
                ╰─digits: integerLiteral("2")

            """
        )
      }(),
      #line: {
        let token1 = TokenSyntax.integerLiteral("1")
        let expr1 = IntegerLiteralExprSyntax(digits: token1)
        let token2 = TokenSyntax.integerLiteral("2")
        let expr2 = IntegerLiteralExprSyntax(digits: token2)
        let elements = [
          TupleExprElementSyntax(expression: expr1),
          TupleExprElementSyntax(expression: expr2),
        ]
        let tuples = TupleExprElementListSyntax(elements)
        return .init(
          syntax: tuples.reversed(),
          expectedDumped: """
            ▿ Swift.ReversedCollection<SwiftSyntax.TupleExprElementListSyntax>
              - _base: TupleExprElementListSyntax
            ├─[0]: TupleExprElementSyntax
            │ ╰─expression: IntegerLiteralExprSyntax
            │   ╰─digits: integerLiteral("1")
            ╰─[1]: TupleExprElementSyntax
              ╰─expression: IntegerLiteralExprSyntax
                ╰─digits: integerLiteral("2")

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
                        calledExpression: ExprSyntax(IdentifierExprSyntax(identifier: .identifier("test"))),
                        leftParen: .leftParenToken(),
                        argumentList: TupleExprElementListSyntax([
                              TupleExprElementSyntax(
                                  expression: ExprSyntax(IntegerLiteralExprSyntax(digits: .integerLiteral("1"))),
                                  trailingComma: .commaToken(trailingTrivia: .space)
                                ),
                              TupleExprElementSyntax(expression: ExprSyntax(IntegerLiteralExprSyntax(digits: .integerLiteral("2"))))
                            ]),
                        rightParen: .rightParenToken()
                      )))
              ]),
          eofToken: .eof()
        )
      """
    )

    assertStringsEqualWithDiff(
      sourceFile.debugInitCall(includeTrivia: false).trimmingTrailingWhitespace(),
      """
      SourceFileSyntax(
          statements: CodeBlockItemListSyntax([
                CodeBlockItemSyntax(item: CodeBlockItemSyntax.Item(FunctionCallExprSyntax(
                        calledExpression: ExprSyntax(IdentifierExprSyntax(identifier: .identifier("test"))),
                        leftParen: .leftParenToken(),
                        argumentList: TupleExprElementListSyntax([
                              TupleExprElementSyntax(
                                  expression: ExprSyntax(IntegerLiteralExprSyntax(digits: .integerLiteral("1"))),
                                  trailingComma: .commaToken()
                                ),
                              TupleExprElementSyntax(expression: ExprSyntax(IntegerLiteralExprSyntax(digits: .integerLiteral("2"))))
                            ]),
                        rightParen: .rightParenToken()
                      )))
              ]),
          eofToken: .eof()
        )
      """
    )
  }
  #endif
}
