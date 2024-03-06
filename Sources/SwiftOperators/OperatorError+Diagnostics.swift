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
public import SwiftDiagnostics
import SwiftParser
import SwiftSyntax
#else
import SwiftDiagnostics
import SwiftParser
import SwiftSyntax
#endif

extension OperatorError: DiagnosticMessage {
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

  public var diagnosticID: MessageID {
    MessageID(domain: "SwiftOperators", id: "\(self)")
  }
}

extension OperatorError {
  /// Produce the syntax node at which a diagnostic should be displayed.
  var diagnosticDisplayNode: Syntax {
    switch self {
    case .incomparableOperators(let leftOperator, _, _, _):
      return Syntax(leftOperator)

    case .missingOperator(_, let node):
      return node

    case .operatorAlreadyExists(_, let newOperator):
      return Syntax(newOperator.syntax ?? newOperator.synthesizedSyntax())

    case .missingGroup(_, let node):
      return node

    case .groupAlreadyExists(_, let newGroup):
      return Syntax(newGroup.syntax ?? newGroup.synthesizedSyntax())
    }
  }

  /// Produce a diagnostic for a given operator-precedence error.
  public var asDiagnostic: Diagnostic {
    .init(node: diagnosticDisplayNode, message: self)
  }
}
