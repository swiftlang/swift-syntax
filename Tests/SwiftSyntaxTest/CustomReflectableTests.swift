import XCTest
import SwiftSyntax

private extension String {
  // This implementation is really slow; to use it outside a test it should be optimized.
  func trimmingTrailingWhitespace() -> String {
    return self.replacingOccurrences(of: "[ ]+\\n", with: "\n", options: .regularExpression)
  }
}


public class CustomReflectableTests: XCTestCase {

  public func testDump() {
    struct TestCase {
      let syntax: Any
      let expectedDumped: String
    }

    let testCases: [UInt: TestCase] = [
      #line: .init(syntax: UnknownSyntax(tokens: []),
                   expectedDumped: """
                                   - UnknownSyntax

                                   """),
      #line: .init(syntax: TokenSyntax.associatedtypeKeyword(leadingTrivia: [], trailingTrivia: []),
                   expectedDumped: """
                                   ▿ associatedtypeKeyword
                                     - text: "associatedtype"
                                     ▿ leadingTrivia: []
                                       - pieces: 0 elements
                                     ▿ trailingTrivia: []
                                       - pieces: 0 elements
                                     - tokenKind: SwiftSyntax.TokenKind.associatedtypeKeyword

                                   """),
      #line: {
        let leftToken = TokenSyntax.leftSquareBracketToken()
        let elements = ArrayElementListSyntax([])
        let rightToken = TokenSyntax.rightSquareBracketToken()
        let expr = ArrayExprSyntax(leftSquare: leftToken,
                                   elements: elements,
                                   rightSquare: rightToken)
        return .init(syntax: expr.tokens(viewMode: .sourceAccurate),
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

                                     """)
      }(),
      #line: {
        let leftToken = TokenSyntax.leftSquareBracketToken()
        let elements = ArrayElementListSyntax([])
        let rightToken = TokenSyntax.rightSquareBracketToken()
        let expr = ArrayExprSyntax(leftSquare: leftToken,
                                   elements: elements,
                                   rightSquare: rightToken)
        return .init(syntax: expr.tokens(viewMode: .sourceAccurate).reversed(),
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

                                     """)
      }(),
      #line: {
        let token1 = TokenSyntax.integerLiteral("1")
        let expr1 = IntegerLiteralExprSyntax(digits: token1)
        let token2 = TokenSyntax.integerLiteral("2")
        let expr2 = IntegerLiteralExprSyntax(digits: token2)
        let elements = [
          TupleExprElementSyntax(
            label: nil,
            colon: nil,
            expression: ExprSyntax(expr1),
            trailingComma: nil
          ),
          TupleExprElementSyntax(
            label: nil,
            colon: nil,
            expression: ExprSyntax(expr2),
            trailingComma: nil
          )
        ]
        let tuples = TupleExprElementListSyntax(elements)
        return .init(syntax: tuples,
                     expectedDumped: """
                                     ▿ TupleExprElementListSyntax
                                       ▿ TupleExprElementSyntax
                                         - unexpectedBeforeLabel: nil
                                         - label: nil
                                         - unexpectedBetweenLabelAndColon: nil
                                         - colon: nil
                                         - unexpectedBetweenColonAndExpression: nil
                                         ▿ expression: IntegerLiteralExprSyntax
                                           - unexpectedBeforeDigits: nil
                                           ▿ digits: integerLiteral("1")
                                             - text: "1"
                                             ▿ leadingTrivia: []
                                               - pieces: 0 elements
                                             ▿ trailingTrivia: []
                                               - pieces: 0 elements
                                             ▿ tokenKind: SwiftSyntax.TokenKind.integerLiteral
                                               - integerLiteral: "1"
                                         - unexpectedBetweenExpressionAndTrailingComma: nil
                                         - trailingComma: nil
                                       ▿ TupleExprElementSyntax
                                         - unexpectedBeforeLabel: nil
                                         - label: nil
                                         - unexpectedBetweenLabelAndColon: nil
                                         - colon: nil
                                         - unexpectedBetweenColonAndExpression: nil
                                         ▿ expression: IntegerLiteralExprSyntax
                                           - unexpectedBeforeDigits: nil
                                           ▿ digits: integerLiteral("2")
                                             - text: "2"
                                             ▿ leadingTrivia: []
                                               - pieces: 0 elements
                                             ▿ trailingTrivia: []
                                               - pieces: 0 elements
                                             ▿ tokenKind: SwiftSyntax.TokenKind.integerLiteral
                                               - integerLiteral: "2"
                                         - unexpectedBetweenExpressionAndTrailingComma: nil
                                         - trailingComma: nil

                                     """)
      }(),
      #line: {
        let token1 = TokenSyntax.integerLiteral("1")
        let expr1 = IntegerLiteralExprSyntax(digits: token1)
        let token2 = TokenSyntax.integerLiteral("2")
        let expr2 = IntegerLiteralExprSyntax(digits: token2)
        let elements = [TupleExprElementSyntax(label: nil,
                                                       colon: nil,
                                                       expression: ExprSyntax(expr1),
                                                       trailingComma: nil),
          TupleExprElementSyntax(label: nil,
                                         colon: nil,
                                         expression: ExprSyntax(expr2),
                                         trailingComma: nil)]
        let tuples = TupleExprElementListSyntax(elements)
        return .init(syntax: tuples.reversed(),
                     expectedDumped: """
                                     ▿ Swift.ReversedCollection<SwiftSyntax.TupleExprElementListSyntax>
                                       ▿ _base: TupleExprElementListSyntax
                                         ▿ TupleExprElementSyntax
                                           - unexpectedBeforeLabel: nil
                                           - label: nil
                                           - unexpectedBetweenLabelAndColon: nil
                                           - colon: nil
                                           - unexpectedBetweenColonAndExpression: nil
                                           ▿ expression: IntegerLiteralExprSyntax
                                             - unexpectedBeforeDigits: nil
                                             ▿ digits: integerLiteral("1")
                                               - text: "1"
                                               ▿ leadingTrivia: []
                                                 - pieces: 0 elements
                                               ▿ trailingTrivia: []
                                                 - pieces: 0 elements
                                               ▿ tokenKind: SwiftSyntax.TokenKind.integerLiteral
                                                 - integerLiteral: "1"
                                           - unexpectedBetweenExpressionAndTrailingComma: nil
                                           - trailingComma: nil
                                         ▿ TupleExprElementSyntax
                                           - unexpectedBeforeLabel: nil
                                           - label: nil
                                           - unexpectedBetweenLabelAndColon: nil
                                           - colon: nil
                                           - unexpectedBetweenColonAndExpression: nil
                                           ▿ expression: IntegerLiteralExprSyntax
                                             - unexpectedBeforeDigits: nil
                                             ▿ digits: integerLiteral("2")
                                               - text: "2"
                                               ▿ leadingTrivia: []
                                                 - pieces: 0 elements
                                               ▿ trailingTrivia: []
                                                 - pieces: 0 elements
                                               ▿ tokenKind: SwiftSyntax.TokenKind.integerLiteral
                                                 - integerLiteral: "2"
                                           - unexpectedBetweenExpressionAndTrailingComma: nil
                                           - trailingComma: nil

                                     """)
      }(),
    ]

    testCases.forEach { keyAndValue in
      let (key: line, value: testCase) = keyAndValue
      let actualDumped = dumped(testCase.syntax)
      XCTAssertEqual(testCase.expectedDumped.trimmingTrailingWhitespace(), actualDumped.trimmingTrailingWhitespace(), line: line)
    }
  }


  public func dumped(_ syntax: Any) -> String {
    var result = ""
    dump(syntax, to: &result)
    return result
  }
}
