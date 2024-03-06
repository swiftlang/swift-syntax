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

@_spi(Testing) import SwiftOperators
import SwiftParser
import SwiftSyntax
import XCTest
import _SwiftSyntaxTestSupport

/// Visitor that looks for ExprSequenceSyntax nodes.
private class ExprSequenceSearcher: SyntaxAnyVisitor {
  var foundSequenceExpr = false

  override func visit(
    _ node: SequenceExprSyntax
  ) -> SyntaxVisitorContinueKind {
    foundSequenceExpr = true
    return .skipChildren
  }

  override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
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

/// A syntax rewriter that folds explicitly-parenthesized sequence expressions
/// into  a structured syntax tree.
class ExplicitParenFolder: SyntaxRewriter {
  override func visit(_ node: TupleExprSyntax) -> ExprSyntax {
    // Identify syntax nodes of the form (x (op) y), which is a
    // TupleExprSyntax(SequenceExpr(x, (op), y)).
    guard node.elements.count == 1,
      let firstNode = node.elements.first,
      firstNode.label == nil,
      let sequenceExpr = firstNode.expression.as(SequenceExprSyntax.self),
      sequenceExpr.elements.count == 3,
      let leftOperand = sequenceExpr.elements.first,
      let middleExpr = sequenceExpr.elements.dropFirst().first,
      let rightOperand =
        sequenceExpr.elements.dropFirst(2).first
    else {
      return ExprSyntax(node)
    }

    return OperatorTable.makeBinaryOperationExpr(
      lhs: visit(leftOperand),
      op: visit(middleExpr),
      rhs: visit(rightOperand)
    )
  }
}

extension OperatorTable {
  /// Assert that parsing and folding the given "unfolded" source code
  /// produces the same syntax tree as the fully-parenthesized version of
  /// the same source.
  ///
  /// The `expectedSource` should be a fully-parenthesized expression, e.g.,
  /// `(a + (b * c))` that expresses how the initial code should have been
  /// folded.
  func assertExpectedFold(
    _ source: String,
    _ fullyParenthesizedSource: String
  ) throws {
    // Parse and fold the source we're testing.
    let parsed = Parser.parse(source: source)
    let foldedSyntax = try foldAll(parsed)
    XCTAssertFalse(foldedSyntax.containsExprSequence)

    // Parse and "fold" the parenthesized version.
    let parenthesizedParsed = Parser.parse(source: fullyParenthesizedSource)
    let parenthesizedSyntax = ExplicitParenFolder(viewMode: .sourceAccurate).rewrite(parenthesizedParsed)
    XCTAssertFalse(parenthesizedSyntax.containsExprSequence)

    // Make sure the two have the same structure.
    let subtreeMatcher = SubtreeMatcher(foldedSyntax, markers: [:])
    do {
      try subtreeMatcher.assertSameStructure(parenthesizedSyntax)
    } catch {
      XCTFail("Matching for a subtree failed with error: \(error)")
    }
  }
}

class OperatorPrecedenceTests: XCTestCase {
  func testLogicalExprsSingle() throws {
    let opPrecedence = OperatorTable.logicalOperators
    let parsed = Parser.parse(source: "x && y || w && v || z")
    let sequenceExpr =
      parsed.statements.first!.item.as(SequenceExprSyntax.self)!
    let foldedExpr = try opPrecedence.foldSingle(sequenceExpr)
    XCTAssertEqual("\(foldedExpr)", "x && y || w && v || z")
    XCTAssertNil(foldedExpr.as(SequenceExprSyntax.self))
  }

  func testLogicalExprs() throws {
    let opPrecedence = OperatorTable.logicalOperators
    try opPrecedence.assertExpectedFold("x && y || w", "((x && y) || w)")
    try opPrecedence.assertExpectedFold("x || y && w", "(x || (y && w))")
  }

  func testSwiftExprs() throws {
    let opPrecedence = OperatorTable.standardOperators
    let parsed = Parser.parse(source: "(x + y > 17) && x && y || w && v || z")
    let sequenceExpr =
      parsed.statements.first!.item.as(SequenceExprSyntax.self)!
    let foldedExpr = try opPrecedence.foldSingle(sequenceExpr)
    XCTAssertEqual("\(foldedExpr)", "(x + y > 17) && x && y || w && v || z")
    XCTAssertNil(foldedExpr.as(SequenceExprSyntax.self))
  }

  func testNestedSwiftExprs() throws {
    let opPrecedence = OperatorTable.standardOperators
    let parsed = Parser.parse(source: "(x + y > 17) && x && y || w && v || z")
    let foldedAll = try opPrecedence.foldAll(parsed)
    XCTAssertEqual("\(foldedAll)", "(x + y > 17) && x && y || w && v || z")
    XCTAssertFalse(foldedAll.containsExprSequence)
  }

  func testAssignExprs() throws {
    let opPrecedence = OperatorTable.standardOperators
    try opPrecedence.assertExpectedFold("a = b + c", "(a = (b + c))")
    try opPrecedence.assertExpectedFold("a = b = c", "(a = (b = c))")
  }

  func testCastExprs() throws {
    let opPrecedence = OperatorTable.standardOperators
    try opPrecedence.assertExpectedFold("a is (b)", "(a is (b))")
    try opPrecedence.assertExpectedFold("a as c == nil", "((a as c) == nil)")
  }

  func testArrowExpr() throws {
    let opPrecedence = OperatorTable.standardOperators
    try opPrecedence.assertExpectedFold(
      "a = b -> c -> d",
      "(a = (b -> (c -> d)))"
    )
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

    let parsedOperatorPrecedence = Parser.parse(source: logicalOperatorSources)
    var opPrecedence = OperatorTable()
    try opPrecedence.addSourceFile(parsedOperatorPrecedence)

    let parsed = Parser.parse(source: "x && y || w && v || z")
    let sequenceExpr =
      parsed.statements.first!.item.as(SequenceExprSyntax.self)!
    let foldedExpr = try opPrecedence.foldSingle(sequenceExpr)
    XCTAssertEqual("\(foldedExpr)", "x && y || w && v || z")
    XCTAssertNil(foldedExpr.as(SequenceExprSyntax.self))
  }

  func testParseErrors() {
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

    let parsedOperatorPrecedence = Parser.parse(source: sources)

    var opPrecedence = OperatorTable()
    var errors: [OperatorError] = []
    opPrecedence.addSourceFile(parsedOperatorPrecedence) { error in
      errors.append(error)
    }

    XCTAssertEqual(errors.count, 2)
    guard case let .operatorAlreadyExists(existing, new) = errors[0] else {
      XCTFail("expected an 'operator already exists' error")
      return
    }

    XCTAssertEqual(errors[0].message, "redefinition of infix operator '+'")
    _ = existing
    _ = new

    guard case let .groupAlreadyExists(existingGroup, newGroup) = errors[1] else {
      XCTFail("expected a 'group already exists' error")
      return
    }
    XCTAssertEqual(errors[1].message, "redefinition of precedence group 'A'")
    _ = newGroup
    _ = existingGroup
  }

  func testUnaryErrors() {
    let sources =
      """
      prefix operator +
      prefix operator +

      postfix operator -
      prefix operator -

      postfix operator*
      postfix operator*
      """

    let parsedOperatorPrecedence = Parser.parse(source: sources)

    var opPrecedence = OperatorTable()
    var errors: [OperatorError] = []
    opPrecedence.addSourceFile(parsedOperatorPrecedence) { error in
      errors.append(error)
    }

    XCTAssertEqual(errors.count, 2)
    guard case let .operatorAlreadyExists(existing, new) = errors[0] else {
      XCTFail("expected an 'operator already exists' error")
      return
    }

    XCTAssertEqual(errors[0].message, "redefinition of prefix operator '+'")

    XCTAssertEqual(errors[1].message, "redefinition of postfix operator '*'")
    _ = existing
    _ = new
  }

  func testFoldErrors() throws {
    let parsedOperatorPrecedence = Parser.parse(
      source:
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
        """
    )

    var opPrecedence = OperatorTable()
    try opPrecedence.addSourceFile(parsedOperatorPrecedence)

    do {
      var errors: [OperatorError] = []
      let parsed = Parser.parse(source: "a + b * c")
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
      XCTAssertEqual(errors[0].message, "unknown precedence group 'B'")
      _ = location
    }

    do {
      var errors: [OperatorError] = []
      let parsed = Parser.parse(source: "a / c")
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
      XCTAssertEqual(errors[0].message, "unknown infix operator '/'")
      _ = location
    }

    do {
      var errors: [OperatorError] = []
      let parsed = Parser.parse(source: "a + b - c")
      let sequenceExpr =
        parsed.statements.first!.item.as(SequenceExprSyntax.self)!
      _ = opPrecedence.foldSingle(sequenceExpr) { error in
        errors.append(error)
      }

      XCTAssertEqual(errors.count, 1)
      guard
        case let .incomparableOperators(_, leftGroup, _, rightGroup) =
          errors[0]
      else {
        XCTFail("expected an 'incomparable operator' error")
        return
      }
      XCTAssertEqual(leftGroup, "A")
      XCTAssertEqual(rightGroup, "A")
      XCTAssertEqual(
        errors[0].message,
        "adjacent operators are in non-associative precedence group 'A'"
      )
    }

    do {
      var errors: [OperatorError] = []
      let parsed = Parser.parse(source: "a ++ b - d")
      let sequenceExpr =
        parsed.statements.first!.item.as(SequenceExprSyntax.self)!
      _ = opPrecedence.foldSingle(sequenceExpr) { error in
        errors.append(error)
      }

      XCTAssertEqual(errors.count, 1)
      guard
        case let .incomparableOperators(_, leftGroup, _, rightGroup) =
          errors[0]
      else {
        XCTFail("expected an 'incomparable operator' error")
        return
      }
      XCTAssertEqual(leftGroup, "D")
      XCTAssertEqual(rightGroup, "A")
      XCTAssertEqual(
        errors[0].message,
        "adjacent operators are in unordered precedence groups 'D' and 'A'"
      )
    }
  }

  func testTernaryExpr() throws {
    let opPrecedence = OperatorTable.standardOperators
    try opPrecedence.assertExpectedFold(
      "b + c ? y : z ? z2 : z3",
      "((b + c) ? y : (z ? z2 : z3))"
    )
  }

  func testTryAwait() throws {
    let opPrecedence = OperatorTable.standardOperators
    try opPrecedence.assertExpectedFold("try x + y", "try (x + y)")
    try opPrecedence.assertExpectedFold(
      "await x + y + z",
      "await ((x + y) + z)"
    )
  }

  func testInfixOperatorLookup() throws {
    let opPrecedence = OperatorTable.standardOperators
    do {
      let op = try XCTUnwrap(opPrecedence.infixOperator(named: "+"))
      XCTAssertEqual(op.kind, .infix)
      XCTAssertEqual(op.name, "+")
      XCTAssertEqual(op.precedenceGroup, "AdditionPrecedence")
    }
    do {
      let op = try XCTUnwrap(opPrecedence.infixOperator(named: "..."))
      XCTAssertEqual(op.kind, .infix)
      XCTAssertEqual(op.name, "...")
      XCTAssertEqual(op.precedenceGroup, "RangeFormationPrecedence")
    }
    XCTAssertNil(opPrecedence.infixOperator(named: "^*^"))
  }

  func testUnaryOperatorLookup() throws {
    let opPrecedence = OperatorTable.standardOperators
    do {
      let op = try XCTUnwrap(opPrecedence.prefixOperator(named: "-"))
      XCTAssertEqual(op.kind, .prefix)
      XCTAssertEqual(op.name, "-")
      XCTAssertNil(op.precedenceGroup)
    }

    do {
      let op = try XCTUnwrap(opPrecedence.postfixOperator(named: "..."))
      XCTAssertEqual(op.kind, .postfix)
      XCTAssertEqual(op.name, "...")
      XCTAssertNil(op.precedenceGroup)
    }

  }
}
