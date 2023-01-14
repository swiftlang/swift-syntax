//===----------------------------------------------------------------------===//
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
    if !self.nodeChoices.isEmpty {
      return self.name
    } else {
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

  var defaultInitialization: ExprSyntax? {
    if self.textChoices.count == 1, let token = token, token.associatedValueClass != nil {
      var textChoice = self.textChoices[0]
      if textChoice == "init" {
        textChoice = "`init`"
      }
      return ExprSyntax(".\(raw: token.swiftKind)(.\(raw: textChoice))")
    } else {
      return type.defaultInitialization
    }
  }

  /// If this node is a token that can't contain arbitrary text, generate a Swift
  /// `assert` statement that verifies the variable with name var_name and of type
  /// `TokenSyntax` contains one of the supported text options. Otherwise return `nil`.
  func generateAssertStmtTextChoices(varName: String) -> FunctionCallExprSyntax? {
    guard type.isToken else {
      return nil
    }

    let choices: [String]
    if !textChoices.isEmpty {
      choices = textChoices
    } else if tokenCanContainArbitraryText {
      // Don't generate an assert statement if token can contain arbitrary text.
      return nil
    } else if !tokenChoices.isEmpty {
      choices = tokenChoices.compactMap(\.text)
    } else {
      return nil
    }

    var assertChoices: [ExprSyntax] = []
    if type.isOptional {
      assertChoices.append(ExprSyntax(SequenceExprSyntax {
        IdentifierExprSyntax(identifier: .identifier(varName))
        BinaryOperatorExprSyntax(text: "==")
        NilLiteralExprSyntax()
      }))
    }
    for textChoice in choices {
      assertChoices.append(ExprSyntax(SequenceExprSyntax {
        MemberAccessExprSyntax(base: type.forceUnwrappedIfNeeded(expr: IdentifierExprSyntax(identifier: .identifier(varName))), name: "text")
        BinaryOperatorExprSyntax(text: "==")
        StringLiteralExprSyntax(content: textChoice)
      }))
    }
    let disjunction = ExprListSyntax(assertChoices.flatMap { [$0, ExprSyntax(BinaryOperatorExprSyntax(text: "||"))] }.dropLast())
    return FunctionCallExprSyntax(callee: ExprSyntax("assert")) {
      TupleExprElementSyntax(expression: SequenceExprSyntax(elements: disjunction))
    }
  }
}
