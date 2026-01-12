//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#if compiler(>=6)
public import SwiftSyntax
#else
import SwiftSyntax
#endif

/// Removes redundant parentheses from expressions.
///
/// Examples:
/// - `((x))` -> `x`
/// - `(x)` -> `x` (where x is a simple expression)
///
public struct RemoveRedundantParentheses: SyntaxRefactoringProvider {
  public static func refactor(
    syntax: TupleExprSyntax,
    in context: Void
  ) -> ExprSyntax {
    // Check if the tuple expression has exactly one element and no label.
    guard let element = getSingleUnlabeledElement(from: syntax) else {
      return ExprSyntax(syntax)
    }

    let innerExpr = element.expression

    // Case 1: Nested parentheses ((expression)) -> (expression)
    // Recursively strip inner parentheses to handle cases like (((x))) -> x
    if let innerTuple = innerExpr.as(TupleExprSyntax.self) {
      return preserveTrivia(from: syntax, to: refactor(syntax: innerTuple, in: ()))
    }

    // Case 2: Parentheses around simple expressions
    if canRemoveParentheses(around: innerExpr, in: syntax.parent) {
      return preserveTrivia(from: syntax, to: innerExpr)
    }

    // Default: Return unchanged
    return ExprSyntax(syntax)
  }

  private static func getSingleUnlabeledElement(from tuple: TupleExprSyntax) -> LabeledExprSyntax? {
    guard tuple.elements.count == 1,
      let element = tuple.elements.first,
      element.label == nil
    else {
      return nil
    }
    return element
  }

  private static func preserveTrivia(from outer: TupleExprSyntax, to inner: ExprSyntax) -> ExprSyntax {
    let newLeading = outer.leftParen.leadingTrivia + outer.leftParen.trailingTrivia + inner.leadingTrivia
    let newTrailing = inner.trailingTrivia + outer.rightParen.leadingTrivia + outer.rightParen.trailingTrivia
    return inner.with(\.leadingTrivia, newLeading).with(\.trailingTrivia, newTrailing)
  }

  private static func canRemoveParentheses(around expr: ExprSyntax, in parent: Syntax?) -> Bool {
    guard isSimpleExpression(expr) else {
      return false
    }
    if expr.is(ClosureExprSyntax.self) && parent?.is(ConditionElementSyntax.self) == true {
      return false
    }

    return true
  }

  private static func isSimpleExpression(_ expr: ExprSyntax) -> Bool {
    // Allow-list of simple expressions that typically don't depend on precedence
    // in a way that requires parentheses when used in most contexts,
    // or are self-contained.
    switch expr.kind {
    case .declReferenceExpr,
      .integerLiteralExpr,
      .floatLiteralExpr,
      .stringLiteralExpr,
      .booleanLiteralExpr,
      .memberAccessExpr,
      .dictionaryExpr,
      .subscriptCallExpr,
      .arrayExpr,
      .closureExpr,
      .macroExpansionExpr,
      .tryExpr,
      .awaitExpr:
      return true
    case .functionCallExpr:
      guard let functionCall = expr.as(FunctionCallExprSyntax.self) else {
        return false
      }
      // Closures called immediately (e.g. `{ ... }()`) behave differently and may require
      // parentheses for disambiguation.
      return !functionCall.calledExpression.is(ClosureExprSyntax.self)
    default:
      return false
    }
  }
}
