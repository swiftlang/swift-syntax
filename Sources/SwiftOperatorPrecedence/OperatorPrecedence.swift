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

/// Maintains information about operators and their relative precedence,
/// providing the core operations for "folding" sequence expression syntax into
/// a structured expression syntax tree.
public struct OperatorPrecedence {
  var precedenceGraph: PrecedenceGraph = .init()
  var operators: [OperatorName : Operator] = [:]

  public init() { }

  /// Initialize the operator precedence instance with a given set of
  /// operators and precedence groups.
  public init(
    precedenceGroups: [PrecedenceGroup],
    operators: [Operator],
    errorHandler: OperatorPrecedenceErrorHandler = { throw $0 }
  ) rethrows {
    for group in precedenceGroups {
      try record(group, errorHandler: errorHandler)
    }
    for op in operators {
      try record(op, errorHandler: errorHandler)
    }
  }

  /// Record the operator, if it matters.
  mutating func record(
    _ op: Operator,
    errorHandler: OperatorPrecedenceErrorHandler = { throw $0 }
  ) rethrows {
    // FIXME: Could do operator-already-exists checking for prefix/postfix
    // operators as well, since we parse them.
    if op.kind != .infix { return }

    if let existing = operators[op.name] {
      try errorHandler(.operatorAlreadyExists(existing: existing, new: op))
    } else {
      operators[op.name] = op
    }
  }

  /// Record the precedence group.
  mutating func record(
    _ group: PrecedenceGroup,
    errorHandler: OperatorPrecedenceErrorHandler = { throw $0 }
  ) rethrows {
    try precedenceGraph.add(group, errorHandler: errorHandler)
  }
}

extension OperatorPrecedence {
  /// Look for the precedence group corresponding to the given operator.
  func lookupOperatorPrecedenceGroupName(
    _ operatorName: OperatorName,
    referencedFrom syntax: SyntaxProtocol?,
    errorHandler: OperatorPrecedenceErrorHandler = { throw $0 }
  ) rethrows -> PrecedenceGroupName? {
    guard let op = operators[operatorName] else {
      try errorHandler(
        .missingOperator(operatorName, referencedFrom: syntax))
      return nil
    }

    return op.precedenceGroup
  }

  /// Determine the relative precedence between two precedence groups.
  func precedence(
    relating startGroupName: PrecedenceGroupName?,
    to endGroupName: PrecedenceGroupName?,
    startSyntax: SyntaxProtocol?,
    endSyntax: SyntaxProtocol?,
    errorHandler: OperatorPrecedenceErrorHandler = { throw $0 }
  ) rethrows -> Precedence {
    guard let startGroupName = startGroupName, let endGroupName = endGroupName
    else {
      return .unrelated
    }

    return try precedenceGraph.precedence(
      relating: startGroupName, to: endGroupName,
      startSyntax: startSyntax, endSyntax: endSyntax,
      errorHandler: errorHandler
    )
  }
}
