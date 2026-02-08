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

/// Inverts a negated `if` condition and swaps the branches.
///
/// ## Before
///
/// ```swift
/// if !x {
///   foo()
/// } else {
///   bar()
/// }
/// ```
///
/// ## After
///
/// ```swift
/// if x {
///   bar()
/// } else {
///   foo()
/// }
/// ```
public struct InvertIfCondition: SyntaxRefactoringProvider {
  public static func refactor(syntax ifExpr: IfExprSyntax, in context: Void) -> IfExprSyntax {
    // 1. Must have an `else` block (and it must be a CodeBlock, not another `if`).
    guard let elseBody = ifExpr.elseBody,
      case .codeBlock(let elseBlock) = elseBody
    else {
      return ifExpr
    }

    // 2. Must have exactly one condition.
    guard ifExpr.conditions.count == 1,
      let condition = ifExpr.conditions.first
    else {
      return ifExpr
    }

    // 3. Condition must be an expression (not a binding like `let x`).
    guard case .expression(let expr) = condition.condition else {
      return ifExpr
    }

    // 4. Expression must be a PrefixOperatorExpr with operator "!".
    guard let prefixOpExpr = expr.as(PrefixOperatorExprSyntax.self),
      prefixOpExpr.operator.text == "!"
    else {
      return ifExpr
    }

    // 5. Extract inner expression (remove the `!`).
    // Preserve trivia: The `!` might have leading trivia (e.g. comments/spaces).
    // Usually standard formatting is `if !cond`.
    // We should probably apply the `PrefixOperatorExpr`'s leading trivia to the inner expression
    // to preserve any comments attached to the negation.
    let innerExpr = prefixOpExpr.expression
      .with(\.leadingTrivia, prefixOpExpr.leadingTrivia)

    // 6. Create new condition list.
    let newCondition = condition.with(\.condition, .expression(innerExpr))
    let newConditions = ifExpr.conditions.with(\.[ifExpr.conditions.startIndex], newCondition)

    // 7. Swap bodies with Trivia preservation.
    // We strictly swap the trivia:
    // New body (was else) takes old body's trivia (space before `{`, space after `}`).
    // New else (was body) takes old else's trivia (space before `{`?, newline after `}`).

    let oldBody = ifExpr.body
    let oldElseBlock = elseBlock

    let newBody =
      oldElseBlock
      .with(\.leadingTrivia, oldBody.leadingTrivia)
      .with(\.trailingTrivia, oldBody.trailingTrivia)

    let newElseBody =
      oldBody
      .with(\.leadingTrivia, oldElseBlock.leadingTrivia)
      .with(\.trailingTrivia, oldElseBlock.trailingTrivia)

    return
      ifExpr
      .with(\.conditions, newConditions)
      .with(\.body, newBody)
      .with(\.elseBody, .codeBlock(newElseBody))
  }
}
