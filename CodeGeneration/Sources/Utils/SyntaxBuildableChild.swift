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

import SwiftSyntax
import SwiftSyntaxBuilder
import SyntaxSupport

/// Extension to the ``Child`` type to provide functionality specific to
/// SwiftSyntaxBuilder.
extension Child {
  public enum InitializableBuilder {
    struct Wrapper: SyntaxNodeConvertible {
      var syntaxNodeKind: SyntaxNodeKind
      var isOptional: Bool
      let isNode = true
    }

    case otherType(type: any SyntaxNodeConvertible, parameterLabel: TokenSyntax)
    case sameType
  }

  public var initializableBuilder: InitializableBuilder? {
    guard self.isNode, let builderInitializableType = BUILDER_INITIALIZABLE_TYPES[self.syntaxNodeKind] else {
      return nil
    }
    guard let builderInitializableType, builderInitializableType != self.syntaxNodeKind else {
      return .sameType
    }
    guard let node = self.syntaxNodeKind.node else {
      fatalError("Base name \(builderInitializableType) does not have a syntax node")
    }
    return .otherType(
      type: InitializableBuilder.Wrapper(syntaxNodeKind: builderInitializableType, isOptional: self.isOptional),
      parameterLabel: node.layoutNode!.singleNonDefaultedChild.labelDeclName
    )
  }

  /// If the child node has a default value, return an expression of the form
  /// ` = default_value` that can be used as the default value to for a
  /// function parameter. Otherwise, return `nil`.
  public var defaultInitialization: InitializerClauseSyntax? {
    if let defaultValue {
      return InitializerClauseSyntax(
        equal: .equalToken(leadingTrivia: .space, trailingTrivia: .space),
        value: defaultValue
      )
    } else {
      return nil
    }
  }

  /// If this node is a token that can't contain arbitrary text, generate a Swift
  /// `precondition` statement that verifies the variable with name var_name and of type
  /// ``TokenSyntax`` contains one of the supported text options. Otherwise return `nil`.
  public func generateAssertStmtTextChoices(varName: String) -> FunctionCallExprSyntax? {
    guard case .token(choices: let choices, requiresLeadingSpace: _, requiresTrailingSpace: _) = kind else {
      return nil
    }

    let tokenCanContainArbitraryText = choices.contains {
      switch $0 {
      case .token(let token):
        return token.spec.text == nil
      case .keyword:
        return false
      }
    }

    let choicesTexts: [String]
    if tokenCanContainArbitraryText {
      // Don't generate a precondition statement if token can contain arbitrary text.
      return nil
    } else if !choices.isEmpty {
      choicesTexts = choices.compactMap {
        switch $0 {
        case .token(let token):
          return token.spec.text
        case .keyword(let keyword):
          return keyword.spec.name
        }
      }
    } else {
      return nil
    }

    var preconditionChoices: [ExprSyntax] = []
    let baseRefExpr = DeclReferenceExprSyntax(baseName: .identifier(varName))
    let memberBaseRefExpr = self.isOptional ? "\(baseRefExpr)!" : ExprSyntax(baseRefExpr)

    if self.isOptional {
      preconditionChoices.append(
        ExprSyntax(
          SequenceExprSyntax {
            baseRefExpr
            BinaryOperatorExprSyntax(text: "==")
            NilLiteralExprSyntax()
          }
        )
      )
    }
    for textChoice in choicesTexts {
      preconditionChoices.append(
        ExprSyntax(
          SequenceExprSyntax {
            MemberAccessExprSyntax(
              base: memberBaseRefExpr,
              name: "text"
            )
            BinaryOperatorExprSyntax(text: "==")
            StringLiteralExprSyntax(content: textChoice)
          }
        )
      )
    }
    let disjunction = ExprListSyntax(
      preconditionChoices.flatMap { [$0, ExprSyntax(BinaryOperatorExprSyntax(text: "||"))] }.dropLast()
    )
    return FunctionCallExprSyntax(callee: ExprSyntax("precondition")) {
      LabeledExprSyntax(expression: SequenceExprSyntax(elements: disjunction))
    }
  }
}
