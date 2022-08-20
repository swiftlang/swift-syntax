import XCTest
import SwiftSyntax
import SwiftParser
import SwiftOperatorPrecedence

/// Visitor that looks for ExprSequenceSyntax nodes.
private class ExprSequenceSearcher: SyntaxAnyVisitor {
  var foundSequenceExpr = false

  override func visit(
    _ node: SequenceExprSyntax
  ) -> SyntaxVisitorContinueKind {
    foundSequenceExpr = true
    return .skipChildren
  }

  override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind{
    return foundSequenceExpr ? .skipChildren : .visitChildren
  }
}

extension SyntaxProtocol {
  /// Determine whether the given syntax contains an ExprSequence anywhere.
  var containsExprSequence: Bool {
    let searcher = ExprSequenceSearcher(viewMode: .sourceAccurate)
    searcher.walk(self)
    return searcher.foundSequenceExpr
  }
}

public class OperatorPrecedenceTests: XCTestCase {
  func testLogicalExprs() throws {
    let opPrecedence = OperatorPrecedence.logicalOperators
    let parsed = try Parser.parse(source: "x && y || w && v || z")
    let sequenceExpr =
      parsed.statements.first!.item.as(SequenceExprSyntax.self)!
    let foldedExpr = try opPrecedence.foldSingle(sequenceExpr)
    XCTAssertEqual("\(foldedExpr)", "x && y || w && v || z")
    XCTAssertNil(foldedExpr.as(SequenceExprSyntax.self))
  }

  func testSwiftExprs() throws {
    let opPrecedence = OperatorPrecedence.standardOperators
    let parsed = try Parser.parse(source: "(x + y > 17) && x && y || w && v || z")
    let sequenceExpr =
        parsed.statements.first!.item.as(SequenceExprSyntax.self)!
    let foldedExpr = try opPrecedence.foldSingle(sequenceExpr)
    XCTAssertEqual("\(foldedExpr)", "(x + y > 17) && x && y || w && v || z")
    XCTAssertNil(foldedExpr.as(SequenceExprSyntax.self))
  }

  func testNestedSwiftExprs() throws {
    let opPrecedence = OperatorPrecedence.standardOperators
    let parsed = try Parser.parse(source: "(x + y > 17) && x && y || w && v || z")
    let foldedAll = try opPrecedence.foldAll(parsed)
    XCTAssertEqual("\(foldedAll)", "(x + y > 17) && x && y || w && v || z")
    XCTAssertFalse(foldedAll.containsExprSequence)
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
    let foldedExpr = try opPrecedence.foldSingle(sequenceExpr)
    XCTAssertEqual("\(foldedExpr)", "x && y || w && v || z")
    XCTAssertNil(foldedExpr.as(SequenceExprSyntax.self))
  }

  func testParseErrors() throws {
    let sources =
    """
    infix operator +
    infix operator +

    precedencegroup A {
      associativity: none
      higherThan: B
    }

    precedencegroup A {
      associativity: none
      higherThan: B
    }
    """

    let parsedOperatorPrecedence = try Parser.parse(source: sources)

    var opPrecedence = OperatorPrecedence()
    var errors: [OperatorPrecedenceError] = []
    opPrecedence.addSourceFile(parsedOperatorPrecedence) { error in
      errors.append(error)
    }

    XCTAssertEqual(errors.count, 2)
    guard case let .operatorAlreadyExists(existing, new) = errors[0] else {
      XCTFail("expected an 'operator already exists' error")
      return
    }

    _ = existing
    _ = new

    guard case let .groupAlreadyExists(existingGroup, newGroup) = errors[1] else {
      XCTFail("expected a 'group already exists' error")
      return
    }
    _ = newGroup
    _ = existingGroup
  }

  func testFoldErrors() throws {
    let parsedOperatorPrecedence = try Parser.parse(source:
      """
      precedencegroup A {
        associativity: none
      }

      precedencegroup C {
        associativity: none
        lowerThan: B
      }

      precedencegroup D {
        associativity: none
      }

      infix operator +: A
      infix operator -: A

      infix operator *: C

      infix operator ++: D
      """)

    var opPrecedence = OperatorPrecedence()
    try opPrecedence.addSourceFile(parsedOperatorPrecedence)

    do {
      var errors: [OperatorPrecedenceError] = []
      let parsed = try Parser.parse(source: "a + b * c")
      let sequenceExpr =
        parsed.statements.first!.item.as(SequenceExprSyntax.self)!
      _ = opPrecedence.foldSingle(sequenceExpr) { error in
        errors.append(error)
      }

      XCTAssertEqual(errors.count, 2)
      guard case let .missingGroup(groupName, location) = errors[0] else {
        XCTFail("expected a 'missing group' error")
        return
      }
      XCTAssertEqual(groupName, "B")
      _ = location
    }

    do {
      var errors: [OperatorPrecedenceError] = []
      let parsed = try Parser.parse(source: "a / c")
      let sequenceExpr =
        parsed.statements.first!.item.as(SequenceExprSyntax.self)!
      _ = opPrecedence.foldSingle(sequenceExpr) { error in
        errors.append(error)
      }

      XCTAssertEqual(errors.count, 1)
      guard case let .missingOperator(operatorName, location) = errors[0] else {
        XCTFail("expected a 'missing operator' error")
        return
      }
      XCTAssertEqual(operatorName, "/")
      _ = location
    }

    do {
      var errors: [OperatorPrecedenceError] = []
      let parsed = try Parser.parse(source: "a + b - c")
      let sequenceExpr =
        parsed.statements.first!.item.as(SequenceExprSyntax.self)!
      _ = opPrecedence.foldSingle(sequenceExpr) { error in
        errors.append(error)
      }

      XCTAssertEqual(errors.count, 1)
      guard case let .incomparableOperators(_, leftGroup, _, rightGroup) =
              errors[0] else {
        XCTFail("expected an 'incomparable operator' error")
        return
      }
      XCTAssertEqual(leftGroup, "A")
      XCTAssertEqual(rightGroup, "A")
    }

    do {
      var errors: [OperatorPrecedenceError] = []
      let parsed = try Parser.parse(source: "a ++ b - d")
      let sequenceExpr =
        parsed.statements.first!.item.as(SequenceExprSyntax.self)!
      _ = opPrecedence.foldSingle(sequenceExpr) { error in
        errors.append(error)
      }

      XCTAssertEqual(errors.count, 1)
      guard case let .incomparableOperators(_, leftGroup, _, rightGroup) =
              errors[0] else {
        XCTFail("expected an 'incomparable operator' error")
        return
      }
      XCTAssertEqual(leftGroup, "D")
      XCTAssertEqual(rightGroup, "A")
    }
  }
}
