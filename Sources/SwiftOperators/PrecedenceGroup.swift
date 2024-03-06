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

#if swift(>=6)
public import SwiftSyntax
#else
import SwiftSyntax
#endif

/// Names a precedence group.
///
/// TODO: For now, we'll use strings, but we likely want to move this to
/// a general notion of an Identifier.
public typealias PrecedenceGroupName = String

/// The associativity of a precedence group.
public enum Associativity: String, Sendable {
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
public struct PrecedenceRelation: Sendable {
  /// Describes the kind of a precedence relation.
  public enum Kind: Sendable {
    case higherThan
    case lowerThan

    var keyword: Keyword {
      switch self {
      case .higherThan: return .higherThan
      case .lowerThan: return .lowerThan
      }
    }
  }

  /// The relationship to the other group.
  public var kind: Kind

  /// The group name.
  public var groupName: PrecedenceGroupName

  /// The syntax that provides the relation. This specifically refers to the
  /// group name itself, but one can follow the parent pointer to find its
  /// position.
  public var syntax: PrecedenceGroupNameSyntax?

  /// Return a higher-than precedence relation.
  public static func higherThan(
    _ groupName: PrecedenceGroupName,
    syntax: PrecedenceGroupNameSyntax? = nil
  ) -> PrecedenceRelation {
    return .init(kind: .higherThan, groupName: groupName, syntax: syntax)
  }

  /// Return a lower-than precedence relation.
  public static func lowerThan(
    _ groupName: PrecedenceGroupName,
    syntax: PrecedenceGroupNameSyntax? = nil
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
public struct PrecedenceGroup: Sendable {
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

extension PrecedenceGroup: CustomStringConvertible {
  /// The description of a precedence group is the source code that produces it.
  public var description: String {
    (syntax ?? synthesizedSyntax()).description
  }
}
