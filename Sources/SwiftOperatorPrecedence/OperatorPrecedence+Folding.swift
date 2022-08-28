//===------------------ OperatorPrecedence+Folding.swift ------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//
import SwiftSyntax

extension ExprSyntax {
  // Is this an unresolved explicit cast?
  fileprivate var isUnresolvedExplicitCast: Bool {
    self.is(UnresolvedIsExprSyntax.self) || self.is(UnresolvedAsExprSyntax.self)
  }
}
extension OperatorPrecedence {
  private struct PrecedenceBound {
    let groupName: PrecedenceGroupName?
    let isStrict: Bool
    let syntax: SyntaxProtocol?
  }

  /// Determine whether we should consider an operator in the given group
  /// based on the specified bound.
  private func shouldConsiderOperator(
    fromGroup groupName: PrecedenceGroupName?,
    in bound: PrecedenceBound,
    fromGroupSyntax: SyntaxProtocol?,
    errorHandler: OperatorPrecedenceErrorHandler = { throw $0 }
  ) rethrows -> Bool {
    guard let boundGroupName = bound.groupName else {
      return true
    }

    guard let groupName = groupName else {
      return false
    }

    if groupName == boundGroupName {
      return !bound.isStrict
    }

    return try precedence(
      relating: groupName, to: boundGroupName,
      startSyntax: fromGroupSyntax, endSyntax: bound.syntax,
      errorHandler: errorHandler
    ) != .lowerThan
  }

  /// Look up the precedence group for the given expression syntax.
  private func lookupPrecedence(
    of expr: ExprSyntax,
    errorHandler: OperatorPrecedenceErrorHandler = { throw $0 }
  ) rethrows -> PrecedenceGroupName? {
    // A binary operator.
    if let binaryExpr = expr.as(BinaryOperatorExprSyntax.self) {
      let operatorName = binaryExpr.operatorToken.text
      return try lookupOperatorPrecedenceGroupName(
        operatorName, referencedFrom: binaryExpr.operatorToken,
        errorHandler: errorHandler
      )
    }

    // The ternary operator has a fixed precedence group name.
    if expr.is(UnresolvedTernaryExprSyntax.self) {
      return "TernaryPrecedence"
    }

    // An assignment operator has fixed precedence.
    if expr.is(AssignmentExprSyntax.self) {
      return "AssignmentPrecedence"
    }

    // Cast operators have fixed precedence.
    if expr.isUnresolvedExplicitCast {
      return "CastingPrecedence"
    }

    // FIXME: Handle all of the language-defined precedence relationships.
    return nil
  }

  /// Form a binary operation expression for, e.g., a + b.
  @_spi(Testing)
  public static func makeBinaryOperationExpr(
    lhs: ExprSyntax, op: ExprSyntax, rhs: ExprSyntax
  ) -> ExprSyntax {
    // The form of the binary operation depends on the operator itself,
    // which will be one of the unresolved infix operators.

    // An operator such as '+'.
    if let binaryOperatorExpr = op.as(BinaryOperatorExprSyntax.self) {
      return ExprSyntax(
        InfixOperatorExprSyntax(
          leftOperand: lhs,
          operatorOperand: ExprSyntax(binaryOperatorExpr),
          rightOperand: rhs)
      )
    }

    // A ternary operator x ? y : z.
    if let ternaryExpr = op.as(UnresolvedTernaryExprSyntax.self) {
      return ExprSyntax(
        TernaryExprSyntax(
          conditionExpression: lhs,
          ternaryExpr.unexpectedBeforeQuestionMark,
          questionMark: ternaryExpr.questionMark,
          ternaryExpr.unexpectedBetweenQuestionMarkAndFirstChoice,
          firstChoice: ternaryExpr.firstChoice,
          ternaryExpr.unexpectedBetweenFirstChoiceAndColonMark,
          colonMark: ternaryExpr.colonMark,
          secondChoice: rhs)
      )
    }

    // An assignment operator x = y.
    if let assignExpr = op.as(AssignmentExprSyntax.self) {
      return ExprSyntax(
        InfixOperatorExprSyntax(
          leftOperand: lhs,
          operatorOperand: ExprSyntax(assignExpr),
          rightOperand: rhs)
      )
    }

    // An "is" type check.
    if let isExpr = op.as(UnresolvedIsExprSyntax.self) {
      // FIXME: Do we actually have a guarantee that the right-hand side is a
      // type expression here?
      return ExprSyntax(
        IsExprSyntax(
          expression: lhs,
          isExpr.unexpectedBeforeIsTok,
          isTok: isExpr.isTok,
          typeName: rhs.as(TypeExprSyntax.self)!.type)
        )
    }

    // An "as" cast.
    if let asExpr = op.as(UnresolvedAsExprSyntax.self) {
      // FIXME: Do we actually have a guarantee that the right-hand side is a
      // type expression here?
      return ExprSyntax(
        AsExprSyntax(
          expression: lhs,
          asExpr.unexpectedBeforeAsTok,
          asTok: asExpr.asTok,
          asExpr.unexpectedBetweenAsTokAndQuestionOrExclamationMark,
          questionOrExclamationMark: asExpr.questionOrExclamationMark,
          typeName: rhs.as(TypeExprSyntax.self)!.type)
        )
    }

    // FIXME: Fallback that we should never need
    fatalError("Unknown binary operator")
  }

  /// Determine the associativity between two precedence groups.
  private func associativity(
    firstGroup: PrecedenceGroupName?,
    firstGroupSyntax: SyntaxProtocol?,
    secondGroup: PrecedenceGroupName?,
    secondGroupSyntax: SyntaxProtocol?,
    errorHandler: OperatorPrecedenceErrorHandler = { throw $0 }
  ) rethrows -> Associativity {
    guard let firstGroup = firstGroup, let secondGroup = secondGroup else {
      return .none
    }

    // If we have the same group, query its associativity.
    if firstGroup == secondGroup {
      guard let group = precedenceGraph.lookupGroup(firstGroup) else {
        try errorHandler(
          .missingGroup(firstGroup, referencedFrom: firstGroupSyntax))
        return .none
      }

      return group.associativity
    }

    if try precedence(
      relating: firstGroup, to: secondGroup,
      startSyntax: firstGroupSyntax, endSyntax: secondGroupSyntax,
      errorHandler: errorHandler
    ) == .higherThan {
      return .left
    }

    if try precedence(
      relating: secondGroup, to: firstGroup,
      startSyntax: secondGroupSyntax, endSyntax: firstGroupSyntax,
      errorHandler: errorHandler
    ) == .higherThan {
      return .right
    }

    return .none
  }

  /// "Fold" an expression sequence where the left-hand side has been broken
  /// out and (potentially) folded somewhat, and the "rest" of the sequence is
  /// consumed along the way
  private func fold(
    _ lhs: ExprSyntax, rest: inout Slice<ExprListSyntax>,
    bound: PrecedenceBound,
    errorHandler: OperatorPrecedenceErrorHandler = { throw $0 }
  ) rethrows -> ExprSyntax {
    if rest.isEmpty { return lhs }

    // We mutate the left-hand side in place as we fold the sequence.
    var lhs = lhs

    /// Get the operator, if appropriate to this pass.
    func getNextOperator() throws -> (ExprSyntax, PrecedenceGroupName?)? {
      let op = rest.first!

      // If the operator's precedence is lower than the minimum, stop here.
      let opPrecedence = try lookupPrecedence(
        of: op, errorHandler: errorHandler)
      if try !shouldConsiderOperator(
        fromGroup: opPrecedence, in: bound, fromGroupSyntax: op
      ) {
        return nil
      }

      return (op, opPrecedence)
    }

    // Extract out the first operator.
    guard var (op1, op1Precedence) = try getNextOperator() else {
      return lhs
    }

    // We will definitely be consuming at least one operator.
    // Pull out the prospective RHS and slice off the first two elements.
    rest = rest.dropFirst()
    var rhs = rest.first!
    rest = rest.dropFirst()

    while !rest.isEmpty {
      // If the operator is a cast operator, the RHS can't extend past the type
      // that's part of the cast production.
      if op1.isUnresolvedExplicitCast {
        lhs = Self.makeBinaryOperationExpr(lhs: lhs, op: op1, rhs: rhs)
        guard let (newOp1, newOp1Precedence) = try getNextOperator() else {
          return lhs
        }

        op1 = newOp1
        op1Precedence = newOp1Precedence

        rest = rest.dropFirst()
        rhs = rest.first!
        rest = rest.dropFirst()
        continue
      }

      // Pull out the next binary operator.
      let op2 = rest.first!
      let op2Precedence = try lookupPrecedence(
        of: op2, errorHandler: errorHandler)

      // If the second operator's precedence is lower than the
      // precedence bound, break out of the loop.
      if try !shouldConsiderOperator(
        fromGroup: op2Precedence, in: bound, fromGroupSyntax: op1,
        errorHandler: errorHandler
      ) {
        break
      }

      let associativity = try associativity(
        firstGroup: op1Precedence,
        firstGroupSyntax: op1,
        secondGroup: op2Precedence,
        secondGroupSyntax: op2,
        errorHandler: errorHandler
      )

      switch associativity {
      case .left:
        // Apply left-associativity immediately by folding the first two
        // operands.
        lhs = Self.makeBinaryOperationExpr(lhs: lhs, op: op1, rhs: rhs)
        op1 = op2
        op1Precedence = op2Precedence
        rest = rest.dropFirst()
        rhs = rest.first!
        rest = rest.dropFirst()

      case .right where op1Precedence != op2Precedence:
        // If the first operator's precedence is lower than the second
        // operator's precedence, recursively fold all such
        // higher-precedence operators starting from this point, then
        // repeat.
        rhs = try fold(
          rhs, rest: &rest,
          bound: PrecedenceBound(
            groupName: op1Precedence, isStrict: true, syntax: op1
          ),
          errorHandler: errorHandler
        )

      case .right:
        // Apply right-associativity by recursively folding operators
        // starting from this point, then immediately folding the LHS and RHS.
        rhs = try fold(
          rhs, rest: &rest,
          bound: PrecedenceBound(
            groupName: op1Precedence, isStrict: false, syntax: op1
          ),
          errorHandler: errorHandler
        )

        lhs = Self.makeBinaryOperationExpr(lhs: lhs, op: op1, rhs: rhs)

        // If we've drained the entire sequence, we're done.
        if rest.isEmpty {
          return lhs
        }

        // Otherwise, start all over with our new LHS.
        return try fold(
          lhs, rest: &rest, bound: bound, errorHandler: errorHandler
        )

      case .none:
        // If we ended up here, it's because we're either:
        //   - missing precedence groups,
        //   - have unordered precedence groups, or
        //   - have the same precedence group with no associativity.
        if let op1Precedence = op1Precedence,
            let op2Precedence = op2Precedence {
          try errorHandler(
            .incomparableOperators(
              leftOperator: op1, leftPrecedenceGroup: op1Precedence,
              rightOperator: op2, rightPrecedenceGroup: op2Precedence
            )
          )
        }

        // Recover by folding arbitrarily at this operator, then continuing.
        lhs = Self.makeBinaryOperationExpr(lhs: lhs, op: op1, rhs: rhs)
        return try fold(lhs, rest: &rest, bound: bound, errorHandler: errorHandler)
      }
    }

    // Fold LHS and RHS together and declare completion.
    return Self.makeBinaryOperationExpr(lhs: lhs, op: op1, rhs: rhs)
  }

  /// "Fold" a sequence expression into a structured syntax tree.
  ///
  /// A sequence expression results from parsing an expression involving
  /// infix operators, such as `x + y * z`. Swift's grammar does not
  /// involve operator precedence, so a sequence expression is a flat list
  /// of all of the terms `x`, `+`, `y`, `*`, and `z`. This operation folds
  /// a single sequence expression into a structured syntax tree that
  /// represents the same source code, but describes the order of operations
  /// as if the expression has been parenthesized `x + (y * z)`.
  public func foldSingle(
    _ sequence: SequenceExprSyntax,
    errorHandler: OperatorPrecedenceErrorHandler = { throw $0 }
  ) rethrows -> ExprSyntax {
    let lhs = sequence.elements.first!
    var rest = sequence.elements.dropFirst()
    return try fold(
      lhs, rest: &rest,
      bound: PrecedenceBound(groupName: nil, isStrict: false, syntax: nil),
      errorHandler: errorHandler
    )
  }

  /// Syntax rewriter that folds all of the sequence expressions it
  /// encounters.
  private class SequenceFolder : SyntaxRewriter {
    /// The first operator precedecence that caused the error handler to
    /// also throw.
    var firstFatalError: OperatorPrecedenceError? = nil

    let opPrecedence: OperatorPrecedence
    let errorHandler: OperatorPrecedenceErrorHandler

    init(
      opPrecedence: OperatorPrecedence,
      errorHandler: @escaping OperatorPrecedenceErrorHandler
    ) {
      self.opPrecedence = opPrecedence
      self.errorHandler = errorHandler
    }

    override func visit(_ node: SequenceExprSyntax) -> ExprSyntax {
      // If the error handler threw in response to an error, don't
      // continue folding.
      if firstFatalError != nil {
        return ExprSyntax(node)
      }

      let newNode = super.visit(node).as(SequenceExprSyntax.self)!

      // If the error handler threw in response to an error, don't
      // continue folding.
      if firstFatalError != nil {
        return ExprSyntax(newNode)
      }

      // Try to fold this sequence expression.
      do {
        return try opPrecedence.foldSingle(newNode) { origError in
          do {
            try errorHandler(origError)
          } catch {
            firstFatalError = origError
            throw error
          }
        }
      } catch {
        return ExprSyntax(newNode)
      }
    }
  }

  /// Fold all sequence expressions within the given syntax tree into a
  /// structured syntax tree.
  ///
  /// This operation replaces all sequence expressions in the given syntax
  /// tree with structured syntax trees, by walking the tree and invoking
  /// `foldSingle` on each sequence expression it encounters. Use this to
  /// provide structure to an entire tree.
  public func foldAll<Node: SyntaxProtocol>(
    _ node: Node,
    errorHandler: OperatorPrecedenceErrorHandler = { throw $0 }
  ) rethrows -> SyntaxProtocol {
    return try withoutActuallyEscaping(errorHandler) { errorHandler in
      let folder = SequenceFolder(
        opPrecedence: self, errorHandler: errorHandler
      )
      let result = folder.visit(Syntax(node))

      // If the sequence folder encountered an error that caused the error
      // handler to throw, invoke the error handler again with the original
      // error.
      if let origFatalError = folder.firstFatalError {
        try errorHandler(origFatalError)
      }

      return result
    }
  }
}
