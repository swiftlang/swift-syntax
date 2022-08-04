//===-------------- OperatorPrecedenceParsing.swift -----------------------===//
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

extension PrecedenceGroup {
  /// Form the semantic definition of a precedence group given its syntax.
  ///
  /// TODO: This ignores all semantic errors.
  init(from syntax: PrecedenceGroupDeclSyntax) {
    self.name = syntax.identifier.text

    for attr in syntax.groupAttributes {
      // Relation (lowerThan, higherThan)
      if let relation = attr.as(PrecedenceGroupRelationSyntax.self) {
        let isLowerThan = relation.higherThanOrLowerThan.text == "lowerThan"
        for otherGroup in relation.otherNames {
          let otherGroupName = otherGroup.name.text
          self.relations.append(isLowerThan ? .lowerThan(otherGroupName)
                                            : .higherThan(otherGroupName))
        }

        continue
      }

      // Assignment
      if let assignment = attr.as(PrecedenceGroupAssignmentSyntax.self) {
        self.assignment = assignment.flag.text == "true"
        continue
      }

      // Associativity
      if let associativity = attr.as(PrecedenceGroupAssociativitySyntax.self) {
        switch associativity.value.text {
        case "left":
          self.associativity = .left

        case "right":
          self.associativity = .right

        case "none":
          self.associativity = .none

        default:
          break
        }
      }
    }
  }
}

extension Operator {
  /// Form the semantic definition of an operator given its syntax.
  ///
  /// TODO: This ignores all semantic errors.
  init(from syntax: OperatorDeclSyntax) {
    let kindModifier = syntax.modifiers?.first { modifier in
      OperatorKind(rawValue: modifier.name.text) != nil
    }

    if let kindModifier = kindModifier {
      kind = OperatorKind(rawValue: kindModifier.name.text)!
    } else {
      kind = .infix
    }

    name = syntax.identifier.text

    if let groupSyntax = syntax.operatorPrecedenceAndTypes?
        .precedenceGroupAndDesignatedTypes {
      precedenceGroup = groupSyntax.firstToken?.text
    } else {
      precedenceGroup = nil
    }
  }
}

extension OperatorPrecedence {
  /// Integrate the operator and precedence group declarations from the given
  /// source file into the operator precedence tables.
  public mutating func addSourceFile(_ sourceFile: SourceFileSyntax) throws {
    for stmt in sourceFile.statements {
      if let operatorSyntax = stmt.item.as(OperatorDeclSyntax.self) {
        try record(Operator(from: operatorSyntax))
        continue
      }

      if let precedenceGroupSyntax = stmt.item.as(PrecedenceGroupDeclSyntax.self) {
        try record(PrecedenceGroup(from: precedenceGroupSyntax))
        continue
      }
    }
  }
}

extension OperatorPrecedence {
  private struct PrecedenceBound {
    let groupName: PrecedenceGroupName?
    let isStrict: Bool
  }

  /// Determine whether we should consider an operator in the given group
  /// based on the specified bound.
  private func shouldConsiderOperator(
    fromGroup groupName: PrecedenceGroupName?, in bound: PrecedenceBound
  ) throws -> Bool {
    guard let boundGroupName = bound.groupName else {
      return true
    }

    guard let groupName = groupName else {
      return false
    }

    if groupName == boundGroupName {
      return !bound.isStrict
    }

    return try precedence(relating: groupName, to: boundGroupName) != .lowerThan
  }

  /// Look up the precedence group for the given expression syntax.
  private func lookupPrecedence(of expr: ExprSyntax) -> PrecedenceGroupName? {
    if let binaryExpr = expr.as(BinaryOperatorExprSyntax.self) {
      guard let op = operators[binaryExpr.operatorToken.text] else {
        // FIXME: Report unknown operator.
        return nil
      }

      return op.precedenceGroup
    }

    // FIXME: Handle all of the language-defined precedence relationships.
    return nil
  }

  /// Form a binary operation expression for, e.g., a + b.
  private func makeBinaryOperationExpr(
    lhs: ExprSyntax, op: ExprSyntax, rhs: ExprSyntax
  ) -> ExprSyntax {
    // FIXME: As a short-term hack, form a parenthesized sequence expression
    // so we can see the resulting structure without having to introduce new
    // nodes.
    ExprSyntax(
      SyntaxFactory.makeTupleExpr(
        leftParen: SyntaxFactory.makeToken(.leftParen, presence: .present),
        elementList: SyntaxFactory.makeTupleExprElementList([
          SyntaxFactory.makeTupleExprElement(
            label: nil, colon: nil,
            expression: ExprSyntax(
              SyntaxFactory.makeSequenceExpr(
                elements: SyntaxFactory.makeExprList([lhs, op, rhs])
            )),
            trailingComma: nil)
        ]),
        rightParen: SyntaxFactory.makeToken(.rightParen, presence: .present))
      )
  }

  /// Determine the associativity between two precedence groups.
  private func associativity(
    firstGroup: PrecedenceGroupName?, secondGroup: PrecedenceGroupName?
  ) throws -> Associativity {
    guard let firstGroup = firstGroup, let secondGroup = secondGroup else {
      return .none
    }

    // If we have the same group, query its associativity.
    if firstGroup == secondGroup {
      return try precedenceGraph.lookupGroup(firstGroup).associativity
    }

    if try precedence(relating: firstGroup, to: secondGroup) == .higherThan {
      return .left
    }

    if try precedence(relating: secondGroup, to: firstGroup) == .higherThan {
      return .right
    }

    return .none
  }

  /// "Fold" an expression sequence where the left-hand side has been broken
  /// out and (potentially) folded somewhat, and the "rest" of the sequence is
  /// consumed along the way
  private func fold(
    _ lhs: ExprSyntax, rest: inout Slice<ExprListSyntax>,
    bound: PrecedenceBound
  ) throws -> ExprSyntax {
    if rest.isEmpty { return lhs }

    // We mutate the left-hand side in place as we fold the sequence.
    var lhs = lhs

    /// Get the operator, if appropriate to this pass.
    func getNextOperator() throws -> (ExprSyntax, PrecedenceGroupName?)? {
      let op = rest.first!

      // If the operator's precedence is lower than the minimum, stop here.
      let opPrecedence = lookupPrecedence(of: op)
      if try !shouldConsiderOperator(fromGroup: opPrecedence, in: bound) {
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
      assert(
        try! shouldConsiderOperator(fromGroup: op1Precedence, in: bound)
      )

      #if compiler(>=10.0) && false
      // If the operator is a cast operator, the RHS can't extend past the type
      // that's part of the cast production.
      if (isa<ExplicitCastExpr>(op1.op)) {
        LHS = makeBinOp(Ctx, op1.op, LHS, RHS, op1.precedence, S.empty());
        op1 = getNextOperator();
        if (!op1) return LHS;
        RHS = S[1];
        S = S.slice(2);
        continue;
      }
      #endif

      // Pull out the next binary operator.
      let op2 = rest.first!
      let op2Precedence = lookupPrecedence(of: op2)

      // If the second operator's precedence is lower than the
      // precedence bound, break out of the loop.
      if try !shouldConsiderOperator(fromGroup: op2Precedence, in: bound) {
        break
      }

      let associativity = try associativity(
        firstGroup: op1Precedence, secondGroup: op2Precedence
      )

      switch associativity {
      case .left:
        // Apply left-associativity immediately by folding the first two
        // operands.
        lhs = makeBinaryOperationExpr(lhs: lhs, op: op1, rhs: rhs)
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
          bound: PrecedenceBound(groupName: op1Precedence, isStrict: true))

      case .right:
        // Apply right-associativity by recursively folding operators
        // starting from this point, then immediately folding the LHS and RHS.
        rhs = try fold(
          rhs, rest: &rest,
          bound: PrecedenceBound(groupName: op1Precedence, isStrict: false)
        )

        lhs = makeBinaryOperationExpr(lhs: lhs, op: op1, rhs: rhs)

        // If we've drained the entire sequence, we're done.
        if rest.isEmpty {
          return lhs
        }

        // Otherwise, start all over with our new LHS.
        return try fold(lhs, rest: &rest, bound: bound)

      case .none:
        // If we ended up here, it's because we're either:
        //   - missing precedence groups,
        //   - have unordered precedence groups, or
        //   - have the same precedence group with no associativity.
        if let op1Precedence = op1Precedence,
            let op2Precedence = op2Precedence {
          if op1Precedence == op2Precedence {
            // FIXME: Must be a nonassociative group, diagnose
          } else {
            // FIXME: Diagnose unrelated groups
          }
        }

        // Recover by folding arbitrarily at this operator, then continuing.
        lhs = makeBinaryOperationExpr(lhs: lhs, op: op1, rhs: rhs)
        return try fold(lhs, rest: &rest, bound: bound)
      }
    }

    // Fold LHS and RHS together and declare completion.
    return makeBinaryOperationExpr(lhs: lhs, op: op1, rhs: rhs)
  }

  /// "Fold" an expression sequence into a structured syntax tree.
  public func fold(_ sequence: SequenceExprSyntax) throws -> ExprSyntax {
    let lhs = sequence.elements.first!
    var rest = sequence.elements.dropFirst()
    return try fold(
      lhs, rest: &rest, bound: PrecedenceBound(groupName: nil, isStrict: false)
    )
  }
}
