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

/// Collapses a nested `if` statement into a single `if` statement with a
/// combined condition list.
///
/// ## Before
///
/// ```swift
/// if a {
///   if b {
///     print("hello")
///   }
/// }
/// ```
///
/// ## After
///
/// ```swift
/// if a, b {
///   print("hello")
/// }
/// ```
public struct CollapseNestedIfStmt: SyntaxRefactoringProvider {
  public static func refactor(syntax outerIf: IfExprSyntax, in context: Void) -> IfExprSyntax {
    // 1. Ensure the outer `if` has no `else` block.
    guard outerIf.elseBody == nil else {
      return outerIf
    }

    // 2. Ensure the outer `if` body has exactly one statement.
    guard outerIf.body.statements.count == 1,
      let firstStatement = outerIf.body.statements.first
    else {
      return outerIf
    }

    // 3. Check if that statement is an `IfExprSyntax` (inner `if`).
    // It could be an `expression` statement containing the `IfExpr` or just the expression itself depending on parsing context,
    // but typically in a code block it's an expression statement.
    guard let expressionStmt = firstStatement.item.as(ExpressionStmtSyntax.self),
      let innerIf = expressionStmt.expression.as(IfExprSyntax.self)
    else {
      return outerIf
    }

    // 4. Ensure the inner `if` has no `else` block.
    guard innerIf.elseBody == nil else {
      return outerIf
    }

    // 5. Merge conditions.
    // We need to add a trailing comma to the last condition of the outer `if`
    // before appending the inner `if`'s conditions.
    var newConditions = outerIf.conditions

    // If the last condition doesn't have a trailing comma, verify we need to add one.
    // Actually, `ConditionElementListSyntax` elements usually handle commas.
    // We just need to make sure the last element of the *outer* list has a comma now that it's not last.

    if var lastOuterCondition = newConditions.last {
      // Remove existing trailing spaces/trivia before comma to be clean, logic can be refined.
      // But crucially, we must add a comma.
      if lastOuterCondition.trailingComma == nil {
        lastOuterCondition.condition = lastOuterCondition.condition.with(\.trailingTrivia, [])
        lastOuterCondition.trailingComma = .commaToken(trailingTrivia: .space)
        // Update the list with the modified condition
        let lastIndex = newConditions.index(before: newConditions.endIndex)
        newConditions = newConditions.with(\.[lastIndex], lastOuterCondition)
      }
    }

    // Add inner conditions.
    // We might need to adjust trivia on the first inner condition to look nice (e.g., remove leading newlines if any).
    let innerConditions = innerIf.conditions
    newConditions.append(contentsOf: innerConditions)

    // 6. Return new `IfExprSyntax` with combined conditions and inner body.
    return outerIf.with(\.conditions, newConditions)
      .with(\.body, innerIf.body)
  }
}
