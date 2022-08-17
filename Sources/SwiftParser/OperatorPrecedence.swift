//===------------------ OperatorPrecedence.swift --------------------------===//
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

/// Names a precedence group.
///
/// TODO: For now, we'll use strings, but we likely want to move this to
/// a general notion of an Identifier.
public typealias PrecedenceGroupName = String

/// Names an operator.
///
/// TODO: For now, we'll use strings, but we likely want to move this to a
/// general notion of an Identifier.
public typealias OperatorName = String

/// The associativity of a precedence group.
public enum Associativity: String {
  /// The precedence group is nonassociative, meaning that one must
  /// parenthesize when there are multiple operators in a sequence, e.g.,
  /// if ^ was nonassociative, a ^ b ^ c would need to be disambiguated as
  /// either (a ^ b ) ^ c or a ^ (b ^ c).
  case none

  /// The precedence group is left-associative, meaning that multiple operators
  /// in the same sequence will be parenthesized from the left. This is typical
  /// for arithmetic operators, such that a + b - c is treated as (a + b) - c.
  case left

  /// The precedence group is right-associative, meaning that multiple operators
  /// in the same sequence will be parenthesized from the right. This is used
  /// for assignments, where a = b = c is treated as a = (b = c).
  case right
}

/// Describes the relationship of a precedence group to another precedence
/// group.
public struct PrecedenceRelation {
  /// Describes the kind of a precedence relation.
  public enum Kind {
    case higherThan
    case lowerThan
  }

  /// The relationship to the other group.
  public var kind: Kind

  /// The group name.
  public var groupName: PrecedenceGroupName

  /// The syntax that provides the relation. This specifically refers to the
  /// group name itself, but one can follow the parent pointer to find its
  /// position.
  public var syntax: PrecedenceGroupNameElementSyntax?

  /// Return a higher-than precedence relation.
  public static func higherThan(
    _ groupName: PrecedenceGroupName,
    syntax: PrecedenceGroupNameElementSyntax? = nil
  ) -> PrecedenceRelation {
    return .init(kind: .higherThan, groupName: groupName, syntax: syntax)
  }

  /// Return a lower-than precedence relation.
  public static func lowerThan(
    _ groupName: PrecedenceGroupName,
    syntax: PrecedenceGroupNameElementSyntax? = nil
  ) -> PrecedenceRelation {
    return .init(kind: .lowerThan, groupName: groupName, syntax: syntax)
  }
}

/// Precedence groups are used for parsing sequences of expressions in Swift
/// source code. Each precedence group defines the associativity of the
/// operator and its precedence relative to other precedence groups:
///
///     precedencegroup MultiplicativePrecedence {
///       associativity: left
///       higherThan: AdditivePrecedence
///     }
///
/// Operator declarations then specify which precedence group describes their
/// precedence, e.g.,
///
///     infix operator *: MultiplicationPrecedence
public struct PrecedenceGroup {
  /// The name of the group, which must be unique.
  public var name: PrecedenceGroupName

  /// The associativity for the group.
  public var associativity: Associativity = .none

  /// Whether the operators in this precedence group are considered to be
  /// assignment operators.
  public var assignment: Bool = false

  /// The set of relations to other precedence groups that are defined by
  /// this precedence group.
  public var relations: [PrecedenceRelation] = []

  /// The syntax node that describes this precedence group.
  public var syntax: PrecedenceGroupDeclSyntax? = nil

  public init(
    name: PrecedenceGroupName,
    associativity: Associativity = .none,
    assignment: Bool = false,
    relations: [PrecedenceRelation] = [],
    syntax: PrecedenceGroupDeclSyntax? = nil
  ) {
    self.name = name
    self.associativity = associativity
    self.assignment = assignment
    self.relations = relations
    self.syntax = syntax
  }
}

/// Describes errors that can occur when working with operator precedence graphs.
public enum OperatorPrecedenceError: Error {
  /// Error produced when a given precedence group already exists in the
  /// precedence graph.
  case groupAlreadyExists(existing: PrecedenceGroup, new: PrecedenceGroup)

  /// The named precedence group is missing from the precedence graph.
  case missingGroup(PrecedenceGroupName)

  /// Error produced when a given operator already exists.
  case operatorAlreadyExists(existing: Operator, new: Operator)

  /// The named operator is missing from the precedence graph.
  case missingOperator(OperatorName)
}

/// Describes the relative precedence of two groups.
public enum Precedence {
  case unrelated
  case higherThan
  case lowerThan
}

/// A graph formed from a set of precedence groups, which can be used to
/// determine the relative precedence of two precedence groups.
struct PrecedenceGraph {
  /// The known set of precedence groups, found by name.
  var precedenceGroups: [PrecedenceGroupName : PrecedenceGroup] = [:]

  /// Add a new precedence group
  ///
  /// - throws: If there is already a precedence group with the given name,
  ///   throws PrecedenceGraphError.groupAlreadyExists.
  mutating func add(_ group: PrecedenceGroup) throws {
    if let existing = precedenceGroups[group.name] {
      throw OperatorPrecedenceError.groupAlreadyExists(
        existing: existing, new: group)
    }

    precedenceGroups[group.name] = group
  }

  /// Look for the precedence group with the given name, or produce an error
  /// if such a group is not known.
  func lookupGroup(
    _ groupName: PrecedenceGroupName
  ) throws -> PrecedenceGroup {
    guard let group = precedenceGroups[groupName] else {
      throw OperatorPrecedenceError.missingGroup(groupName)
    }

    return group
  }

  /// Determine the precedence relationship between two precedence groups.
  ///
  /// Follow the precedence relationships among the precedence groups to
  /// determine the precedence of the start group relative to the end group.
  func precedence(
    relating startGroupName: PrecedenceGroupName,
    to endGroupName: PrecedenceGroupName
  ) throws -> Precedence {
    if startGroupName == endGroupName {
      return .unrelated
    }

    // Keep track of all of the groups we have seen during our exploration of
    // the graph. This detects cycles and prevents extraneous work.
    var groupsSeen: Set<PrecedenceGroupName> = []

    // Walk all of the lower-than relationships from the end group. If we
    // reach the start group, the start has lower precedence than the end.
    var stack: [PrecedenceGroupName] = [endGroupName]
    while let currentGroupName = stack.popLast() {
      let currentGroup = try lookupGroup(currentGroupName)

      for relation in currentGroup.relations {
        if relation.kind == .lowerThan {
          // If we hit our start group, we're done.
          let otherGroupName = relation.groupName
          if otherGroupName == startGroupName {
            return .lowerThan
          }

          if !groupsSeen.insert(otherGroupName).inserted {
            stack.append(otherGroupName)
          }
        }
      }
    }

    // Walk all of the higher-than relationships from the start group. If we
    // reach the end group, the start has higher precedence than the end.
    assert(stack.isEmpty)
    groupsSeen.removeAll()
    stack.append(startGroupName)
    while let currentGroupName = stack.popLast() {
      let currentGroup = try lookupGroup(currentGroupName)

      for relation in currentGroup.relations {
        if relation.kind == .higherThan {
          // If we hit our end group, we're done.
          let otherGroupName = relation.groupName
          if otherGroupName == endGroupName {
            return .higherThan
          }

          if !groupsSeen.insert(otherGroupName).inserted {
            stack.append(otherGroupName)
          }
        }
      }
    }

    // The two are incomparable.
    return .unrelated
  }
}

/// Describes the kind of an operator.
public enum OperatorKind: String {
  /// Infix operator such as the + in a + b.
  case infix

  /// Prefix operator such as the - in -x.
  case prefix

  /// Postfix operator such as the ! in x!.
  case postfix
}

/// Describes an operator.
public struct Operator {
  public let kind: OperatorKind
  public let name: OperatorName
  public let precedenceGroup: PrecedenceGroupName?
  public let syntax: OperatorDeclSyntax?

  public init(
    kind: OperatorKind, name: OperatorName,
    precedenceGroup: PrecedenceGroupName?,
    syntax: OperatorDeclSyntax? = nil
  ) {
    self.kind = kind
    self.name = name
    self.precedenceGroup = precedenceGroup
    self.syntax = syntax
  }
}

/// Maintains information about operators and their relative precedence,
/// providing the core operations for "folding" sequence expression syntax into
/// a structured expression syntax tree.
public struct OperatorPrecedence {
  var precedenceGraph: PrecedenceGraph = .init()
  var operators: [OperatorName : Operator] = [:]

  public init() { }

  /// Record the operator, if it matters.
  /// FIXME: Terrible API used only for tests
  public mutating func record(_ op: Operator) throws {
    if op.kind != .infix { return }

    if let existing = operators[op.name] {
      throw OperatorPrecedenceError.operatorAlreadyExists(
          existing: existing, new: op)
    }

    operators[op.name] = op
  }

  /// Record the precedence group.
  /// FIXME: Terrible API used only for tests
  public mutating func record(_ group: PrecedenceGroup) throws {
    try precedenceGraph.add(group)
  }
}

/// Prefabricated operator precedence graphs.
extension OperatorPrecedence {
  /// Operator precedence graph for the logical operators '&&' and '||', for
  /// example as it is used in `#if` processing.
  public static var logicalOperators: OperatorPrecedence {
    var opPrecedence = OperatorPrecedence()

    try! opPrecedence.record(
      Operator(kind: .infix, name: "&&",
               precedenceGroup: "LogicalConjunctionPrecedence"))
    try! opPrecedence.record(
      Operator(kind: .infix, name: "||",
               precedenceGroup: "LogicalDisjunctionPrecedence"))
    try! opPrecedence.record(
      PrecedenceGroup(name: "LogicalConjunctionPrecedence",
                      associativity: .left, assignment: false,
                      relations: [.higherThan("LogicalDisjunctionPrecedence")]))
    try! opPrecedence.record(
      PrecedenceGroup(name: "LogicalDisjunctionPrecedence",
                      associativity: .left, assignment: false,
                      relations: []))
    return opPrecedence
  }

  /// Operator precedence graph for the Swift standard library.
  ///
  /// This describes the operators within the Swift standard library at the
  /// type of this writing. It can be used to approximate the behavior one
  /// would get from parsing the actual Swift standard library's operators
  /// without requiring access to the standard library source code. However,
  /// because it does not incorporate user-defined operators, it will only
  /// ever be useful for a quick approximation.
  public static var standardOperators: OperatorPrecedence {
    var opPrecedence = OperatorPrecedence()

    try! opPrecedence.record(
      PrecedenceGroup(
        name: "AssignmentPrecedence",
        associativity: .right,
        assignment: true
      )
    )
    try! opPrecedence.record(
      PrecedenceGroup(
        name: "FunctionArrowPrecedence",
        associativity: .right,
        relations: [.higherThan("AssignmentPrecedence")]
      )
    )
    try! opPrecedence.record(
      PrecedenceGroup(
        name: "TernaryPrecedence",
        associativity: .right,
        relations: [.higherThan("FunctionArrowPrecedence")]
      )
    )
    try! opPrecedence.record(
      PrecedenceGroup(
        name: "DefaultPrecedence",
        relations: [.higherThan("TernaryPrecedence")]
      )
    )
    try! opPrecedence.record(
      PrecedenceGroup(
        name: "LogicalDisjunctionPrecedence",
        associativity: .left,
        relations: [.higherThan("TernaryPrecedence")]
      )
    )
    try! opPrecedence.record(
      PrecedenceGroup(
        name: "LogicalConjunctionPrecedence",
        associativity: .left,
        relations: [.higherThan("LogicalDisjunctionPrecedence")]
      )
    )
    try! opPrecedence.record(
      PrecedenceGroup(
        name: "ComparisonPrecedence",
        relations: [.higherThan("LogicalConjunctionPrecedence")]
      )
    )
    try! opPrecedence.record(
      PrecedenceGroup(
        name: "NilCoalescingPrecedence",
        associativity: .right,
        relations: [.higherThan("ComparisonPrecedence")]
      )
    )
    try! opPrecedence.record(
      PrecedenceGroup(
        name: "CastingPrecedence",
        relations: [.higherThan("NilCoalescingPrecedence")]
      )
    )
    try! opPrecedence.record(
      PrecedenceGroup(
        name: "RangeFormationPrecedence",
        relations: [.higherThan("CastingPrecedence")]
      )
    )
    try! opPrecedence.record(
      PrecedenceGroup(
        name: "AdditionPrecedence",
        associativity: .left,
        relations: [.higherThan("RangeFormationPrecedence")]
      )
    )
    try! opPrecedence.record(
      PrecedenceGroup(
        name: "MultiplicationPrecedence",
        associativity: .left,
        relations: [.higherThan("AdditionPrecedence")]
      )
    )
    try! opPrecedence.record(
      PrecedenceGroup(
        name: "BitwiseShiftPrecedence",
        relations: [.higherThan("MultiplicationPrecedence")]
      )
    )

    // "Exponentiative"

    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "<<",
        precedenceGroup: "BitwiseShiftPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&<<",
        precedenceGroup: "BitwiseShiftPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: ">>",
        precedenceGroup: "BitwiseShiftPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&>>",
        precedenceGroup: "BitwiseShiftPrecedence"
      )
    )

    // "Multiplicative"

    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "*",
        precedenceGroup: "MultiplicationPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&*",
        precedenceGroup: "MultiplicationPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "/",
        precedenceGroup: "MultiplicationPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "%",
        precedenceGroup: "MultiplicationPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&",
        precedenceGroup: "MultiplicationPrecedence"
      )
    )

    // "Additive"

    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "+",
        precedenceGroup: "AdditionPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&+",
        precedenceGroup: "AdditionPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "-",
        precedenceGroup: "AdditionPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&-",
        precedenceGroup: "AdditionPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "|",
        precedenceGroup: "AdditionPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "^",
        precedenceGroup: "AdditionPrecedence"
      )
    )

    // FIXME: is this the right precedence level for "..."?
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "...",
        precedenceGroup: "RangeFormationPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "..<",
        precedenceGroup: "RangeFormationPrecedence"
      )
    )

    // "Coalescing"

    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "??",
        precedenceGroup: "NilCoalescingPrecedence"
      )
    )

    // "Comparative"

    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "<",
        precedenceGroup: "ComparisonPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "<=",
        precedenceGroup: "ComparisonPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: ">",
        precedenceGroup: "ComparisonPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: ">=",
        precedenceGroup: "ComparisonPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "==",
        precedenceGroup: "ComparisonPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "!=",
        precedenceGroup: "ComparisonPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "===",
        precedenceGroup: "ComparisonPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "!==",
        precedenceGroup: "ComparisonPrecedence"
      )
    )
    // FIXME: ~= will be built into the compiler.
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "~=",
        precedenceGroup: "ComparisonPrecedence"
      )
    )

    // "Conjunctive"

    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&&",
        precedenceGroup: "LogicalConjunctionPrecedence"
      )
    )

    // "Disjunctive"

    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "||",
        precedenceGroup: "LogicalDisjunctionPrecedence"
      )
    )

    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "*=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&*=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "/=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "%=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "+=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&+=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "-=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&-=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "<<=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&<<=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: ">>=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&>>=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "^=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "|=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )

    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "~>",
        precedenceGroup: nil
      )
    )

    return opPrecedence
  }
}

extension OperatorPrecedence {
  /// Look for the precedence group corresponding to the given operator.
  func lookupOperatorPrecedenceGroupName(
    _ operatorName: OperatorName
  ) throws -> PrecedenceGroupName? {
    guard let op = operators[operatorName] else {
      throw OperatorPrecedenceError.missingOperator(operatorName)
    }

    return op.precedenceGroup
  }

  /// Look for the precedence group corresponding to the given operator.
  func lookupOperatorPrecedenceGroup(
    _ operatorName: OperatorName
  ) throws -> PrecedenceGroup? {
    guard let groupName = try lookupOperatorPrecedenceGroupName(operatorName)
    else {
      return nil
    }
    return try precedenceGraph.lookupGroup(groupName)
  }

  /// Determine the relative precedence between two precedence groups.
  func precedence(
    relating startGroupName: PrecedenceGroupName?,
    to endGroupName: PrecedenceGroupName?
  ) throws -> Precedence {
    guard let startGroupName = startGroupName, let endGroupName = endGroupName
    else {
      return .unrelated
    }

    return try precedenceGraph.precedence(
      relating: startGroupName, to: endGroupName
    )
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
    ExprSyntax(
      InfixOperatorExprSyntax(
        leftOperand: lhs, operatorOperand: op, rightOperand: rhs)
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
