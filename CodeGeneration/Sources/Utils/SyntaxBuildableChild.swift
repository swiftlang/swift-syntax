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

  /// If the child node has documentation associated with it, return it as single
  /// line string. Otherwise return an empty string.
  var documentation: String {
    flattened(indentedDocumentation: description ?? "")
  }

  /// Generate a Swift expression that creates a proper SwiftSyntax node of type
  /// `type.syntax` from a variable named `varName` of type `type.buildable` that
  /// represents this child node.
  func generateExprBuildSyntaxNode(varName: ExpressibleAsExprBuildable, formatName: String) -> ExpressibleAsExprBuildable {
    if type.isToken {
      return FunctionCallExpr(calledExpression: MemberAccessExpr(base: type.optionalChained(expr: varName), name: "buildToken")) {
        TupleExprElement(label: "format", expression: "format")
      }
    } else {
      var format: ExpressibleAsExprBuildable = formatName
      if isIndented {
        format = MemberAccessExpr(base: format, name: "_indented")
      }
      let expr = type.optionalChained(expr: varName)
      return FunctionCallExpr(calledExpression: MemberAccessExpr(base: expr, name: "build\(type.baseName)")) {
        TupleExprElement(label: "format", expression: format)
      }
    }
  }

  /// If this node is a token that can't contain arbitrary text, generate a Swift
  /// `assert` statement that verifies the variable with name var_name and of type
  /// `TokenSyntax` contains one of the supported text options. Otherwise return `nil`.
  func generateAssertStmtTextChoices(varName: String) -> ExpressibleAsExprBuildable? {
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

    var assertChoices: [ExpressibleAsExprBuildable] = []
    if type.isOptional {
      assertChoices.append(SequenceExpr {
        varName
        BinaryOperatorExpr("==")
        NilLiteralExpr()
      })
    }
    for textChoice in choices {
      assertChoices.append(SequenceExpr {
        MemberAccessExpr(base: type.forceUnwrappedIfNeeded(expr: varName), name: "text")
        BinaryOperatorExpr("==")
        StringLiteralExpr(raw: textChoice)
      })
    }
    let disjunction = ExprList(assertChoices.flatMap { [$0, BinaryOperatorExpr("||")] }.dropLast())
    return FunctionCallExpr(calledExpression: "assert") {
      SequenceExpr(elements: disjunction)
    }
  }
}
