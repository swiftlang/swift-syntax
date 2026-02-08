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

/// Removes redundant parentheses from a single-element tuple.
///
/// ## Before
///
/// ```swift
/// let x = (10)
/// ```
///
/// ## After
///
/// ```swift
/// let x = 10
/// ```
public struct RemoveRedundantParens: SyntaxRefactoringProvider {
  public static func refactor(syntax tupleExpr: TupleExprSyntax, in context: Void) -> ExprSyntax {
    // 1. Must be exactly one element.
    guard tupleExpr.elements.count == 1,
      let element = tupleExpr.elements.first
    else {
      return ExprSyntax(tupleExpr)
    }

    // 2. Must not have a label.
    guard element.label == nil else {
      return ExprSyntax(tupleExpr)
    }

    // 3. Extract the inner expression.
    let innerExpr = element.expression

    // 4. Safety Check: Precedence Ambiguity
    // If we are unwrapping a SequenceExpr (binary op) AND we are inside another SequenceExpr,
    // we assume it is UNSAFE because we don't know operator precedence.
    // Example: x * (y + z) -> unwrapping makes it x * y + z (different logic).

    // Check if inner is SequenceExpr
    // Check if inner is SequenceExpr
    if innerExpr.is(SequenceExprSyntax.self) {
      // Case: Parent is ExprList (standard SequenceExpr elements) -> Grandparent is SequenceExpr
      if let parent = tupleExpr.parent,
        parent.is(ExprListSyntax.self),
        let grandParent = parent.parent,
        grandParent.is(SequenceExprSyntax.self)
      {
        return ExprSyntax(tupleExpr)
      }

      // Case: Direct parent is SequenceExpr (fallback)
      if let parent = tupleExpr.parent, parent.is(SequenceExprSyntax.self) {
        return ExprSyntax(tupleExpr)
      }
    }

    // 5. Preserve Trivia
    // We want to keep comments attached to the parens, but maybe not the newlines inside?
    // A safe default is to take the tuple's leading/trailing trivia and apply it to the inner expression.
    // This replaces the inner expression's existing leading/trailing trivia if we use .with,
    // so we might want to append?
    // Actually, usually `( /* comment */ x )` -> `/* comment */ x`.
    // Let's replace.

    return
      innerExpr
      .with(\.leadingTrivia, tupleExpr.leadingTrivia)
      .with(\.trailingTrivia, tupleExpr.trailingTrivia)
  }
}
