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

/// Extension to the `Child` type to provide functionality specific to
/// SwiftSyntaxBuilder.
public extension Child {
  /// The type of this child, represented by a `SyntaxBuildableType`, which can
  /// be used to create the corresponding `Buildable` and `ExpressibleAs` types.
  var type: SyntaxBuildableType {
    SyntaxBuildableType(
      syntaxKind: syntaxKind,
      isOptional: isOptional
    )
  }

  var parameterBaseType: String {
    switch kind {
    case .nodeChoices:
      return self.name
    default:
      return type.parameterBaseType
    }
  }

  var parameterType: TypeSyntax {
    return self.type.optionalWrapped(type: SimpleTypeIdentifierSyntax(name: .identifier(parameterBaseType)))
  }

  /// If the child node has documentation associated with it, return it as single
  /// line string. Otherwise return an empty string.
  var documentation: String {
    flattened(indentedDocumentation: description ?? "")
  }

  /// If the child node has a default value, return an expression of the form
  /// ` = default_value` that can be used as the default value to for a
  /// function parameter. Otherwise, return `nil`.
  var defaultInitialization: InitializerClauseSyntax? {
    if isOptional || isUnexpectedNodes {
      return InitializerClauseSyntax(value: NilLiteralExprSyntax())
    }
    guard let token = token, isToken else {
      return type.defaultValue.map { InitializerClauseSyntax(value: $0) }
    }
    if token.isKeyword {
      return InitializerClauseSyntax(value: ExprSyntax(".\(raw: token.swiftKind)()"))
    }
    if token.text != nil {
      return InitializerClauseSyntax(value: ExprSyntax(".\(raw: token.swiftKind)Token()"))
    }
    guard case .token(let choices, _, _) = kind, choices.count == 1, token.associatedValueClass != nil else {
      return nil
    }
    var textChoice: String
    switch choices[0] {
    case .keyword(let text), .token(let text):
      textChoice = text
    }
    if textChoice == "init" {
      textChoice = "`init`"
    }
    return InitializerClauseSyntax(value: ExprSyntax(".\(raw: token.swiftKind)(.\(raw: textChoice))"))
  }

  /// If this node is a token that can't contain arbitrary text, generate a Swift
  /// `precondition` statement that verifies the variable with name var_name and of type
  /// `TokenSyntax` contains one of the supported text options. Otherwise return `nil`.
  func generateAssertStmtTextChoices(varName: String) -> FunctionCallExprSyntax? {
    guard case .token(choices: let choices, requiresLeadingSpace: _, requiresTrailingSpace: _) = kind else {
      return nil
    }

    let tokenCanContainArbitraryText = choices.contains {
      switch $0 {
      case .token(tokenKind: let tokenKind): return SYNTAX_TOKEN_MAP["\(tokenKind)Token"]?.text == nil
      case .keyword: return false
      }
    }

    let choicesTexts: [String]
    if tokenCanContainArbitraryText {
      // Don't generate an precondition statement if token can contain arbitrary text.
      return nil
    } else if !choices.isEmpty {
      choicesTexts = choices.compactMap {
        switch $0 {
        case .token(tokenKind: let tokenKind): return SYNTAX_TOKEN_MAP["\(tokenKind)Token"]?.text
        case .keyword(text: let text): return text
        }
      }
    } else {
      return nil
    }

    var preconditionChoices: [ExprSyntax] = []
    if type.isOptional {
      preconditionChoices.append(
        ExprSyntax(
          SequenceExprSyntax {
            IdentifierExprSyntax(identifier: .identifier(varName))
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
            MemberAccessExprSyntax(base: type.forceUnwrappedIfNeeded(expr: IdentifierExprSyntax(identifier: .identifier(varName))), name: "text")
            BinaryOperatorExprSyntax(text: "==")
            StringLiteralExprSyntax(content: textChoice)
          }
        )
      )
    }
    let disjunction = ExprListSyntax(preconditionChoices.flatMap { [$0, ExprSyntax(BinaryOperatorExprSyntax(text: "||"))] }.dropLast())
    return FunctionCallExprSyntax(callee: ExprSyntax("precondition")) {
      TupleExprElementSyntax(expression: SequenceExprSyntax(elements: disjunction))
    }
  }
}
