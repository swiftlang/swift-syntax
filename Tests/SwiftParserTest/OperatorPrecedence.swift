import XCTest
import SwiftSyntax
import SwiftParser

public class OperatorPrecedenceTests: XCTestCase {
  func testLogicalExprs() throws {
    let opPrecedence = OperatorPrecedence.logicalOperators
    let parsed = try Parser.parse(source: "x && y || w && v || z")
    let sequenceExpr =
      parsed.statements.first!.item.as(SequenceExprSyntax.self)!
    let foldedExpr = try opPrecedence.fold(sequenceExpr)
    XCTAssertEqual("\(foldedExpr)", "x && y || w && v || z")
    XCTAssertNil(foldedExpr.as(SequenceExprSyntax.self))
  }

  func testSwiftExprs() throws {
    let opPrecedence = OperatorPrecedence.standardOperators
    let parsed = try Parser.parse(source: "(x + y > 17) && x && y || w && v || z")
    let sequenceExpr =
      parsed.statements.first!.item.as(SequenceExprSyntax.self)!
    let foldedExpr = try opPrecedence.fold(sequenceExpr)
    XCTAssertEqual("\(foldedExpr)", "(x + y > 17) && x && y || w && v || z")
    XCTAssertNil(foldedExpr.as(SequenceExprSyntax.self))
  }

  func testParsedLogicalExprs() throws {
    let logicalOperatorSources =
    """
    precedencegroup LogicalDisjunctionPrecedence {
      associativity: left
    }

    precedencegroup LogicalConjunctionPrecedence {
      associativity: left
      higherThan: LogicalDisjunctionPrecedence
    }

    // "Conjunctive"

    infix operator &&: LogicalConjunctionPrecedence

    // "Disjunctive"

    infix operator ||: LogicalDisjunctionPrecedence
    """

    let parsedOperatorPrecedence = try Parser.parse(source: logicalOperatorSources)
    var opPrecedence = OperatorPrecedence()
    try opPrecedence.addSourceFile(parsedOperatorPrecedence)

    let parsed = try Parser.parse(source: "x && y || w && v || z")
    let sequenceExpr =
      parsed.statements.first!.item.as(SequenceExprSyntax.self)!
    let foldedExpr = try opPrecedence.fold(sequenceExpr)
    XCTAssertEqual("\(foldedExpr)", "x && y || w && v || z")
    XCTAssertNil(foldedExpr.as(SequenceExprSyntax.self))
  }
}
