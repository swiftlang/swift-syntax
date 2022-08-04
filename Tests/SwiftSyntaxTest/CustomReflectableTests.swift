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
                                     ▿ leadingTrivia:
                                       - pieces: 0 elements
                                     ▿ trailingTrivia:
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
        return .init(syntax: expr.tokens(viewMode: .sourceAccurate),
                     expectedDumped: """
                                     ▿ SwiftSyntax.TokenSequence
                                       ▿ SwiftSyntax.TokenSyntax
                                         - text: "["
                                         ▿ leadingTrivia:
                                           - pieces: 0 elements
                                         ▿ trailingTrivia:
                                           - pieces: 0 elements
                                         - tokenKind: SwiftSyntax.TokenKind.leftSquareBracket
                                       ▿ SwiftSyntax.TokenSyntax
                                         - text: "]"
                                         ▿ leadingTrivia:
                                           - pieces: 0 elements
                                         ▿ trailingTrivia:
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
        return .init(syntax: expr.tokens(viewMode: .sourceAccurate).reversed(),
                     expectedDumped: """
                                     ▿ SwiftSyntax.ReversedTokenSequence
                                       ▿ SwiftSyntax.TokenSyntax
                                         - text: "]"
                                         ▿ leadingTrivia:
                                           - pieces: 0 elements
                                         ▿ trailingTrivia:
                                           - pieces: 0 elements
                                         - tokenKind: SwiftSyntax.TokenKind.rightSquareBracket
                                       ▿ SwiftSyntax.TokenSyntax
                                         - text: "["
                                         ▿ leadingTrivia:
                                           - pieces: 0 elements
                                         ▿ trailingTrivia:
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
                                         - garbageBeforeLabel: nil
                                         - label: nil
                                         - garbageBetweenLabelAndColon: nil
                                         - colon: nil
                                         - garbageBetweenColonAndExpression: nil
                                         ▿ expression: SwiftSyntax.IntegerLiteralExprSyntax
                                           - garbageBeforeDigits: nil
                                           ▿ digits: SwiftSyntax.TokenSyntax
                                             - text: "1"
                                             ▿ leadingTrivia:
                                               - pieces: 0 elements
                                             ▿ trailingTrivia:
                                               - pieces: 0 elements
                                             ▿ tokenKind: SwiftSyntax.TokenKind.integerLiteral
                                               - integerLiteral: "1"
                                         - garbageBetweenExpressionAndTrailingComma: nil
                                         - trailingComma: nil
                                       ▿ SwiftSyntax.TupleExprElementSyntax
                                         - garbageBeforeLabel: nil
                                         - label: nil
                                         - garbageBetweenLabelAndColon: nil
                                         - colon: nil
                                         - garbageBetweenColonAndExpression: nil
                                         ▿ expression: SwiftSyntax.IntegerLiteralExprSyntax
                                           - garbageBeforeDigits: nil
                                           ▿ digits: SwiftSyntax.TokenSyntax
                                             - text: "2"
                                             ▿ leadingTrivia:
                                               - pieces: 0 elements
                                             ▿ trailingTrivia:
                                               - pieces: 0 elements
                                             ▿ tokenKind: SwiftSyntax.TokenKind.integerLiteral
                                               - integerLiteral: "2"
                                         - garbageBetweenExpressionAndTrailingComma: nil
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
                                           - garbageBeforeLabel: nil
                                           - label: nil
                                           - garbageBetweenLabelAndColon: nil
                                           - colon: nil
                                           - garbageBetweenColonAndExpression: nil
                                           ▿ expression: SwiftSyntax.IntegerLiteralExprSyntax
                                             - garbageBeforeDigits: nil
                                             ▿ digits: SwiftSyntax.TokenSyntax
                                               - text: "1"
                                               ▿ leadingTrivia:
                                                 - pieces: 0 elements
                                               ▿ trailingTrivia:
                                                 - pieces: 0 elements
                                               ▿ tokenKind: SwiftSyntax.TokenKind.integerLiteral
                                                 - integerLiteral: "1"
                                           - garbageBetweenExpressionAndTrailingComma: nil
                                           - trailingComma: nil
                                         ▿ SwiftSyntax.TupleExprElementSyntax
                                           - garbageBeforeLabel: nil
                                           - label: nil
                                           - garbageBetweenLabelAndColon: nil
                                           - colon: nil
                                           - garbageBetweenColonAndExpression: nil
                                           ▿ expression: SwiftSyntax.IntegerLiteralExprSyntax
                                             - garbageBeforeDigits: nil
                                             ▿ digits: SwiftSyntax.TokenSyntax
                                               - text: "2"
                                               ▿ leadingTrivia:
                                                 - pieces: 0 elements
                                               ▿ trailingTrivia:
                                                 - pieces: 0 elements
                                               ▿ tokenKind: SwiftSyntax.TokenKind.integerLiteral
                                                 - integerLiteral: "2"
                                           - garbageBetweenExpressionAndTrailingComma: nil
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
