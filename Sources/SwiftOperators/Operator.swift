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

/// Names an operator.
///
/// TODO: For now, we'll use strings, but we likely want to move this to a
/// general notion of an Identifier.
public typealias OperatorName = String

/// Describes the kind of an operator.
public enum OperatorKind: String, Sendable {
  /// Infix operator such as the + in a + b.
  case infix

  /// Prefix operator such as the - in -x.
  case prefix

  /// Postfix operator such as the ! in x!.
  case postfix
}

/// Describes an operator.
public struct Operator: Sendable {
  public let kind: OperatorKind
  public let name: OperatorName
  public let precedenceGroup: PrecedenceGroupName?
  public let syntax: OperatorDeclSyntax?

  public init(
    kind: OperatorKind,
    name: OperatorName,
    precedenceGroup: PrecedenceGroupName? = nil,
    syntax: OperatorDeclSyntax? = nil
  ) {
    self.kind = kind
    self.name = name
    self.precedenceGroup = precedenceGroup
    self.syntax = syntax
  }
}

extension Operator: CustomStringConvertible {
  /// The description of an operator is the source code that produces it.
  public var description: String {
    (syntax ?? synthesizedSyntax()).description
  }
}
