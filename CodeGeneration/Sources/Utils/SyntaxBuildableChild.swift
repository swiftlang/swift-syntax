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

/// Something that can either be a node of the given kind or a token of the
/// given token kind.
public enum SyntaxOrTokenNodeKind: Hashable {
  case node(kind: SyntaxNodeKind)
  case token(Token)
}

/// Extension to the ``Child`` type to provide functionality specific to
/// SwiftSyntaxBuilder.
extension Child {
  /// The type of this child, represented by a ``SyntaxBuildableType``, which can
  /// be used to create the corresponding `Buildable` and `ExpressibleAs` types.
  public var buildableType: SyntaxBuildableType {
    let buildableKind: SyntaxOrTokenNodeKind
    switch kind {
    case .node(kind: let kind):
      buildableKind = .node(kind: kind)
    case .nodeChoices:
      buildableKind = .node(kind: .syntax)
    case .collection(kind: let kind, _):
      buildableKind = .node(kind: kind)
    case .token:
      buildableKind = .token(self.tokenKind!)
    }
    return SyntaxBuildableType(
      kind: buildableKind,
      isOptional: isOptional
    )
  }

  public var parameterBaseType: TypeSyntax {
    switch kind {
    case .nodeChoices:
      return self.syntaxChoicesType
    default:
      return buildableType.parameterBaseType
    }
  }

  public var parameterType: TypeSyntax {
    return self.buildableType.optionalWrapped(type: parameterBaseType)
  }

  public var defaultValue: ExprSyntax? {
    if isOptional || isUnexpectedNodes {
      if buildableType.isBaseType && kind.isNodeChoicesEmpty {
        return ExprSyntax("\(buildableType.buildable).none")
      } else {
        return ExprSyntax("nil")
      }
    }
    if case .collection(_, defaultsToEmpty: true) = kind {
      return ExprSyntax("[]")
    }
    guard let token = token, isToken else {
      return buildableType.defaultValue
    }
    if token.text != nil {
      return ExprSyntax(".\(token.identifier)Token()")
    }
    if case .token(let choices, _, _) = kind,
      case .keyword(let keyword) = choices.only
    {
      return ExprSyntax(".\(token.memberCallName)(.\(keyword.spec.memberCallName))")
    }
    return nil
  }

  /// If the child node has a default value, return an expression of the form
  /// ` = default_value` that can be used as the default value to for a
  /// function parameter. Otherwise, return `nil`.
  public var defaultInitialization: InitializerClauseSyntax? {
    if providesDefaultInitialization, let defaultValue {
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
    if buildableType.isOptional {
      preconditionChoices.append(
        ExprSyntax(
          SequenceExprSyntax {
            DeclReferenceExprSyntax(baseName: .identifier(varName))
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
              base: buildableType.forceUnwrappedIfNeeded(expr: DeclReferenceExprSyntax(baseName: .identifier(varName))),
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
