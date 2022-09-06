//===------------------ OperatorPrecedenceError.swift ---------------------===//
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

import SwiftDiagnostics
import SwiftParser
import SwiftSyntax

extension OperatorPrecedenceError : DiagnosticMessage {
  public var severity: DiagnosticSeverity {
    .error
  }

  public var message: String {
    switch self {
    case .groupAlreadyExists(let existing, _):
      return "redefinition of precedence group '\(existing.name)'"

    case .missingGroup(let groupName, _):
      return "unknown precedence group '\(groupName)'"

    case .operatorAlreadyExists(let existing, _):
      return "redefinition of \(existing.kind) operator '\(existing.name)'"

    case .missingOperator(let operatorName, _):
      return "unknown infix operator '\(operatorName)'"

    case .incomparableOperators(_, let leftGroup, _, let rightGroup):
      if leftGroup == rightGroup {
        return "adjacent operators are in non-associative precedence group '\(leftGroup)'"
      }

      return "adjacent operators are in unordered precedence groups '\(leftGroup)' and '\(rightGroup)'"
    }
  }

  /// A string representation of each case.
  private var diagnosticCaseID: String {
    switch self {
    case .incomparableOperators:
      return "incomparable_operators"

    case .operatorAlreadyExists:
      return "operator_already_exists"

    case .missingOperator:
      return "missing_operator"

    case .missingGroup:
      return "missing_group"

    case .groupAlreadyExists:
      return "group_already_exists"
    }
  }

  public var diagnosticID: MessageID {
    MessageID(domain: "SwiftOperatorPrecedence", id: diagnosticCaseID)
  }
}

extension OperatorPrecedenceError {
  private func fixupDiagnosticDisplayNode<Node: SyntaxProtocol>(
    _ node: Node?
  ) -> Syntax {
    if let node = node {
      return Syntax(node)
    }

    return Syntax(MissingDeclSyntax(attributes: nil, modifiers: nil))
  }

  /// Produce the syntax node at which a diagnostic should be displayed.
  var diagnosticDisplayNode: Syntax {
    switch self {
    case .incomparableOperators(let leftOperator, _, _, _):
      return Syntax(leftOperator)

    case .missingOperator(_, let node):
      return fixupDiagnosticDisplayNode(node)

    case .operatorAlreadyExists(_, let newOperator):
      return fixupDiagnosticDisplayNode(newOperator.syntax)

    case .missingGroup(_, let node):
      return fixupDiagnosticDisplayNode(node)

    case .groupAlreadyExists(_, let newGroup):
      return fixupDiagnosticDisplayNode(newGroup.syntax)
    }
  }

  /// Produce a diagnostic for a given operator-precedence error.
  public var asDiagnostic: Diagnostic {
    .init(node: diagnosticDisplayNode, message: self)
  }
}
