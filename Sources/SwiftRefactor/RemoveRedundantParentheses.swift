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
    guard let innerExpr = syntax.elements.singleUnlabeledExpression else {
      return ExprSyntax(syntax)
    }

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

  private static func preserveTrivia(from outer: TupleExprSyntax, to inner: ExprSyntax) -> ExprSyntax {
    let leadingTrivia = outer.leftParen.leadingTrivia
      .merging(outer.leftParen.trailingTrivia)
      .merging(inner.leadingTrivia)
    let trailingTrivia = inner.trailingTrivia
      .merging(outer.rightParen.leadingTrivia)
      .merging(outer.rightParen.trailingTrivia)
    return
      inner
      .with(\.leadingTrivia, leadingTrivia)
      .with(\.trailingTrivia, trailingTrivia)
  }

  private static func canRemoveParentheses(around expr: ExprSyntax, in parent: Syntax?) -> Bool {
    return isSimpleExpression(expr)
      && !(expr.is(ClosureExprSyntax.self) && parent?.is(ConditionElementSyntax.self) == true)
  }

  private static func isSimpleExpression(_ expr: ExprSyntax) -> Bool {
    // Allow-list of simple expressions that typically don't depend on precedence
    // in a way that requires parentheses when used in most contexts,
    // or are self-contained.
    switch expr.as(ExprSyntaxEnum.self) {
    case .arrayExpr,
      .booleanLiteralExpr,
      .closureExpr,
      .declReferenceExpr,
      .dictionaryExpr,
      .floatLiteralExpr,
      .forceUnwrapExpr,
      .integerLiteralExpr,
      .macroExpansionExpr,
      .memberAccessExpr,
      .nilLiteralExpr,
      .optionalChainingExpr,
      .regexLiteralExpr,
      .simpleStringLiteralExpr,
      .stringLiteralExpr,
      .subscriptCallExpr,
      .superExpr,
      .typeExpr:
      return true
    case .awaitExpr(let awaitExpr):
      // await is only simple if its expression is also simple
      return isSimpleExpression(awaitExpr.expression)
    case .unsafeExpr(let unsafeExpr):
      // Similar to await, unsafe is only simple if its expression is simple
      return isSimpleExpression(unsafeExpr.expression)
    case .tryExpr(let tryExpr):
      // Only try! and try? are simple; regular try is NOT simple
      // because it affects precedence (e.g., try (try! foo()).bar() vs try try! foo().bar())
      guard tryExpr.questionOrExclamationMark != nil else {
        return false
      }
      return isSimpleExpression(tryExpr.expression)
    case .functionCallExpr(let functionCall):
      // Closures called immediately (e.g. `{ ... }()`) behave differently and may require
      // parentheses for disambiguation.
      return !functionCall.calledExpression.is(ClosureExprSyntax.self)
    default:
      return false
    }
  }
}
