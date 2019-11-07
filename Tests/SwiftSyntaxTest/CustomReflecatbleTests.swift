import XCTest
import SwiftSyntax


public class CustomReflectableTests: XCTestCase {

  public func testDump() {
    struct TestCase {
      let syntax: Any
      let expectedDumped: String
    }

    let testCases: [UInt: TestCase] = [
      #line: .init(syntax: SyntaxFactory.makeUnknownSyntax(tokens: []),
                   expectedDumped: """
                                   - SwiftSyntax.UnknownSyntax

                                   """),
      #line: .init(syntax: SyntaxFactory.makeToken(.associatedtypeKeyword,
                                                   presence: .present,
                                                   leadingTrivia: [],
                                                   trailingTrivia: []),
                   expectedDumped: """
                                   ▿ SwiftSyntax.TokenSyntax
                                     - text: "associatedtype"
                                     ▿ leadingTrivia: SwiftSyntax.Trivia
                                       - pieces: 0 elements
                                     ▿ trailingTrivia: SwiftSyntax.Trivia
                                       - pieces: 0 elements
                                     - tokenKind: SwiftSyntax.TokenKind.associatedtypeKeyword

                                   """),
      #line: {
        let leftToken = SyntaxFactory.makeToken(.leftSquareBracket,
                                                presence: .present,
                                                leadingTrivia: [],
                                                trailingTrivia: [])
        let elements = SyntaxFactory.makeBlankArrayElementList()
        let rightToken = SyntaxFactory.makeToken(.rightSquareBracket,
                                                 presence: .present,
                                                 leadingTrivia: [],
                                                 trailingTrivia: [])
        let expr = SyntaxFactory.makeArrayExpr(leftSquare: leftToken,
                                               elements: elements,
                                               rightSquare: rightToken)
        return .init(syntax: expr.tokens,
                     expectedDumped: """
                                     ▿ SwiftSyntax.TokenSequence
                                       ▿ SwiftSyntax.TokenSyntax
                                         - text: "["
                                         ▿ leadingTrivia: SwiftSyntax.Trivia
                                           - pieces: 0 elements
                                         ▿ trailingTrivia: SwiftSyntax.Trivia
                                           - pieces: 0 elements
                                         - tokenKind: SwiftSyntax.TokenKind.leftSquareBracket
                                       ▿ SwiftSyntax.TokenSyntax
                                         - text: "]"
                                         ▿ leadingTrivia: SwiftSyntax.Trivia
                                           - pieces: 0 elements
                                         ▿ trailingTrivia: SwiftSyntax.Trivia
                                           - pieces: 0 elements
                                         - tokenKind: SwiftSyntax.TokenKind.rightSquareBracket

                                     """)
      }(),
      #line: {
        let leftToken = SyntaxFactory.makeToken(.leftSquareBracket,
                                                presence: .present,
                                                leadingTrivia: [],
                                                trailingTrivia: [])
        let elements = SyntaxFactory.makeBlankArrayElementList()
        let rightToken = SyntaxFactory.makeToken(.rightSquareBracket,
                                                 presence: .present,
                                                 leadingTrivia: [],
                                                 trailingTrivia: [])
        let expr = SyntaxFactory.makeArrayExpr(leftSquare: leftToken,
                                               elements: elements,
                                               rightSquare: rightToken)
        return .init(syntax: expr.tokens.reversed(),
                     expectedDumped: """
                                     ▿ SwiftSyntax.ReversedTokenSequence
                                       ▿ SwiftSyntax.TokenSyntax
                                         - text: "]"
                                         ▿ leadingTrivia: SwiftSyntax.Trivia
                                           - pieces: 0 elements
                                         ▿ trailingTrivia: SwiftSyntax.Trivia
                                           - pieces: 0 elements
                                         - tokenKind: SwiftSyntax.TokenKind.rightSquareBracket
                                       ▿ SwiftSyntax.TokenSyntax
                                         - text: "["
                                         ▿ leadingTrivia: SwiftSyntax.Trivia
                                           - pieces: 0 elements
                                         ▿ trailingTrivia: SwiftSyntax.Trivia
                                           - pieces: 0 elements
                                         - tokenKind: SwiftSyntax.TokenKind.leftSquareBracket

                                     """)
      }(),
      #line: {
        let token1 = SyntaxFactory.makeToken(.integerLiteral("1"),
                                             presence: .present,
                                             leadingTrivia: [],
                                             trailingTrivia: [])
        let expr1 = SyntaxFactory.makeIntegerLiteralExpr(digits: token1)
        let token2 = SyntaxFactory.makeToken(.integerLiteral("2"),
                                             presence: .present,
                                             leadingTrivia: [],
                                             trailingTrivia: [])
        let expr2 = SyntaxFactory.makeIntegerLiteralExpr(digits: token2)
        let elements = [SyntaxFactory.makeTupleExprElement(label: nil,
                                                       colon: nil,
                                                       expression: ExprSyntax(expr1),
                                                       trailingComma: nil),
                        SyntaxFactory.makeTupleExprElement(label: nil,
                                                       colon: nil,
                                                       expression: ExprSyntax(expr2),
                                                       trailingComma: nil)]
        let tuples = SyntaxFactory.makeTupleExprElementList(elements)
        return .init(syntax: tuples,
                     expectedDumped: """
                                     ▿ SwiftSyntax.TupleExprElementListSyntax
                                       ▿ SwiftSyntax.TupleExprElementSyntax
                                         - label: nil
                                         - colon: nil
                                         ▿ expression: SwiftSyntax.IntegerLiteralExprSyntax
                                           ▿ digits: SwiftSyntax.TokenSyntax
                                             - text: "1"
                                             ▿ leadingTrivia: SwiftSyntax.Trivia
                                               - pieces: 0 elements
                                             ▿ trailingTrivia: SwiftSyntax.Trivia
                                               - pieces: 0 elements
                                             ▿ tokenKind: SwiftSyntax.TokenKind.integerLiteral
                                               - integerLiteral: "1"
                                         - trailingComma: nil
                                       ▿ SwiftSyntax.TupleExprElementSyntax
                                         - label: nil
                                         - colon: nil
                                         ▿ expression: SwiftSyntax.IntegerLiteralExprSyntax
                                           ▿ digits: SwiftSyntax.TokenSyntax
                                             - text: "2"
                                             ▿ leadingTrivia: SwiftSyntax.Trivia
                                               - pieces: 0 elements
                                             ▿ trailingTrivia: SwiftSyntax.Trivia
                                               - pieces: 0 elements
                                             ▿ tokenKind: SwiftSyntax.TokenKind.integerLiteral
                                               - integerLiteral: "2"
                                         - trailingComma: nil

                                     """)
      }(),
      #line: {
        let token1 = SyntaxFactory.makeToken(.integerLiteral("1"),
                                             presence: .present,
                                             leadingTrivia: [],
                                             trailingTrivia: [])
        let expr1 = SyntaxFactory.makeIntegerLiteralExpr(digits: token1)
        let token2 = SyntaxFactory.makeToken(.integerLiteral("2"),
                                             presence: .present,
                                             leadingTrivia: [],
                                             trailingTrivia: [])
        let expr2 = SyntaxFactory.makeIntegerLiteralExpr(digits: token2)
        let elements = [SyntaxFactory.makeTupleExprElement(label: nil,
                                                       colon: nil,
                                                       expression: ExprSyntax(expr1),
                                                       trailingComma: nil),
          SyntaxFactory.makeTupleExprElement(label: nil,
                                         colon: nil,
                                         expression: ExprSyntax(expr2),
                                         trailingComma: nil)]
        let tuples = SyntaxFactory.makeTupleExprElementList(elements)
        return .init(syntax: tuples.reversed(),
                     expectedDumped: """
                                     ▿ Swift.ReversedCollection<SwiftSyntax.TupleExprElementListSyntax>
                                       ▿ _base: SwiftSyntax.TupleExprElementListSyntax
                                         ▿ SwiftSyntax.TupleExprElementSyntax
                                           - label: nil
                                           - colon: nil
                                           ▿ expression: SwiftSyntax.IntegerLiteralExprSyntax
                                             ▿ digits: SwiftSyntax.TokenSyntax
                                               - text: "1"
                                               ▿ leadingTrivia: SwiftSyntax.Trivia
                                                 - pieces: 0 elements
                                               ▿ trailingTrivia: SwiftSyntax.Trivia
                                                 - pieces: 0 elements
                                               ▿ tokenKind: SwiftSyntax.TokenKind.integerLiteral
                                                 - integerLiteral: "1"
                                           - trailingComma: nil
                                         ▿ SwiftSyntax.TupleExprElementSyntax
                                           - label: nil
                                           - colon: nil
                                           ▿ expression: SwiftSyntax.IntegerLiteralExprSyntax
                                             ▿ digits: SwiftSyntax.TokenSyntax
                                               - text: "2"
                                               ▿ leadingTrivia: SwiftSyntax.Trivia
                                                 - pieces: 0 elements
                                               ▿ trailingTrivia: SwiftSyntax.Trivia
                                                 - pieces: 0 elements
                                               ▿ tokenKind: SwiftSyntax.TokenKind.integerLiteral
                                                 - integerLiteral: "2"
                                           - trailingComma: nil

                                     """)
      }(),
    ]

    testCases.forEach { keyAndValue in
      let (key: line, value: testCase) = keyAndValue
      let actualDumped = dumped(testCase.syntax)
      XCTAssertEqual(testCase.expectedDumped, actualDumped, line: line)
    }
  }


  public func dumped(_ syntax: Any) -> String {
    var result = ""
    dump(syntax, to: &result)
    return result
  }
}
