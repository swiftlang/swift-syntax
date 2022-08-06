import XCTest
import SwiftSyntax
import SwiftParser

public class OperatorPrecedenceTests: XCTestCase {
  func testLogicalExprs() throws {
    var opPrecedence = OperatorPrecedence()

    try opPrecedence.record(
      Operator(kind: .infix, name: "&&",
               precedenceGroup: "LogicalConjunctionPrecedence"))
    try opPrecedence.record(
      Operator(kind: .infix, name: "||",
               precedenceGroup: "LogicalDisjunctionPrecedence"))
    try opPrecedence.record(
      PrecedenceGroup(name: "LogicalConjunctionPrecedence",
                      associativity: .left, assignment: false,
                      relations: [.higherThan("LogicalDisjunctionPrecedence")]))
    try opPrecedence.record(
      PrecedenceGroup(name: "LogicalDisjunctionPrecedence",
                      associativity: .left, assignment: false,
                      relations: []))

    let parsed = try Parser.parse(source: "x && y || w && v || z")
    let sequenceExpr =
      parsed.statements.first!.item.as(SequenceExprSyntax.self)!
    let foldedExpr = try opPrecedence.fold(sequenceExpr)
    XCTAssertEqual("\(foldedExpr)", "x && y || w && v || z")
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
