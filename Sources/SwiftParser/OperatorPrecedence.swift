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

/// Describes the relationship between two different precedence groups.
public enum PrecedenceRelation {
  /// The precedence group storing this relation has higher precedence than
  /// the named group.
  case higherThan(PrecedenceGroupName)

  /// The precedence group storing this relation has lower precedence than
  /// the named group.
  case lowerThan(PrecedenceGroupName)
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

  public init(
    name: PrecedenceGroupName, associativity: Associativity, assignment: Bool,
    relations: [PrecedenceRelation]
  ) {
    self.name = name
    self.associativity = associativity
    self.assignment = assignment
    self.relations = relations
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
public struct PrecedenceGraph {
  /// The known set of precedence groups, found by name.
  public var precedenceGroups: [PrecedenceGroupName : PrecedenceGroup] = [:]

  /// Add a new precedence group
  ///
  /// - throws: If there is already a precedence group with the given name,
  ///   throws PrecedenceGraphError.groupAlreadyExists.
  public mutating func add(_ group: PrecedenceGroup) throws {
    if let existing = precedenceGroups[group.name] {
      throw OperatorPrecedenceError.groupAlreadyExists(
        existing: existing, new: group)
    }

    precedenceGroups[group.name] = group
  }

  /// Look for the precedence group with the given name, or produce an error
  /// if such a group is not known.
  public func lookupGroup(
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
  public func precedence(
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
        if case let .lowerThan(otherGroupName) = relation {
          // If we hit our start group, we're done.
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
        if case let .higherThan(otherGroupName) = relation {
          // If we hit our end group, we're done.
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

  public init(
    kind: OperatorKind, name: OperatorName,
    precedenceGroup: PrecedenceGroupName?
  ) {
    self.kind = kind
    self.name = name
    self.precedenceGroup = precedenceGroup
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

extension OperatorPrecedence {
  /// Look for the precedence group corresponding to the given operator.
  public func lookupOperatorPrecedenceGroupName(
    _ operatorName: OperatorName
  ) throws -> PrecedenceGroupName? {
    guard let op = operators[operatorName] else {
      throw OperatorPrecedenceError.missingOperator(operatorName)
    }

    return op.precedenceGroup
  }

  /// Look for the precedence group corresponding to the given operator.
  public func lookupOperatorPrecedenceGroup(
    _ operatorName: OperatorName
  ) throws -> PrecedenceGroup? {
    guard let groupName = try lookupOperatorPrecedenceGroupName(operatorName)
    else {
      return nil
    }
    return try precedenceGraph.lookupGroup(groupName)
  }

  /// Determine the relative precedence between two precedence groups.
  public func precedence(
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
