import XCTest
import SwiftSyntax


public class CustomReflectableTests: XCTestCase {
  public static let allTests = [
    ("testDump", testDump),
    ("testConformanceToCustomReflectable", testConformanceToCustomReflectable),
  ]


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
        let elements = [SyntaxFactory.makeTupleElement(label: nil,
                                                       colon: nil,
                                                       expression: expr1,
                                                       trailingComma: nil),
                        SyntaxFactory.makeTupleElement(label: nil,
                                                       colon: nil,
                                                       expression: expr2,
                                                       trailingComma: nil)]
        let tuples = SyntaxFactory.makeTupleElementList(elements)
        return .init(syntax: tuples,
                     expectedDumped: """
                                     ▿ SwiftSyntax.TupleElementListSyntax
                                       ▿ SwiftSyntax.TupleElementSyntax
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
                                       ▿ SwiftSyntax.TupleElementSyntax
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
        let elements = [SyntaxFactory.makeTupleElement(label: nil,
                                                       colon: nil,
                                                       expression: expr1,
                                                       trailingComma: nil),
          SyntaxFactory.makeTupleElement(label: nil,
                                         colon: nil,
                                         expression: expr2,
                                         trailingComma: nil)]
        let tuples = SyntaxFactory.makeTupleElementList(elements)
        return .init(syntax: tuples.reversed(),
                     expectedDumped: """
                                     ▿ SwiftSyntax.TupleElementListSyntax.Reversed
                                       ▿ collection: SwiftSyntax.TupleElementListSyntax
                                         ▿ SwiftSyntax.TupleElementSyntax
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
                                         ▿ SwiftSyntax.TupleElementSyntax
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


  public func testConformanceToCustomReflectable() {
    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(getInput("near-empty.swift"))
      XCTAssertEqual(collectSyntaxNotConformedCustomReflectable(from: parsed), [])
    }())
    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(getInput("closure.swift"))
      XCTAssertEqual(collectSyntaxNotConformedCustomReflectable(from: parsed), [])
    }())
    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(getInput("nested-blocks.swift"))
      XCTAssertEqual(collectSyntaxNotConformedCustomReflectable(from: parsed), [])
    }())
    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(getInput("visitor.swift"))
      XCTAssertEqual(collectSyntaxNotConformedCustomReflectable(from: parsed), [])
    }())
  }


  public func collectSyntaxNotConformedCustomReflectable<S: Any>(from object: S) -> [String] {
    var paths = [String]()
    collectSyntaxNotConformedCustomReflectable(from: object, ancestors: ["root"], foundPaths: &paths)
    return paths
  }


  public func collectSyntaxNotConformedCustomReflectable<S: Any>(from object: S, ancestors: [String], foundPaths: inout [String]) {
    Mirror(reflecting: object).children.forEach { child in
      let (label: label, value: value) = child

      var currentPathComponents = ancestors
      currentPathComponents.append(label ?? "(nil)")

      if let syntax = value as? Syntax, !(syntax is CustomReflectable) {
        foundPaths.append("\(currentPathComponents.joined(separator: ".")): \(type(of: value as Any))")
      }

      collectSyntaxNotConformedCustomReflectable(from: value, ancestors: currentPathComponents, foundPaths: &foundPaths)
    }
  }


  public func dumped(_ syntax: Any) -> String {
    var result = ""
    dump(syntax, to: &result)
    return result
  }
}
