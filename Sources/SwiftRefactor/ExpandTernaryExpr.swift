//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#if compiler(>=6)
import SwiftBasicFormat
public import SwiftSyntax
#else
import SwiftBasicFormat
import SwiftSyntax
#endif

/// Converts a ternary conditional expression to an if-else expression using
/// Swift 5.9's if-expression syntax.
///
/// ## Before
///
/// ```swift
/// let x = condition ? trueValue : falseValue
/// ```
///
/// ## After
///
/// ```swift
/// let x = if condition {
///     trueValue
/// } else {
///     falseValue
/// }
/// ```
public struct ExpandTernaryExpr: SyntaxRefactoringProvider {
  public static func refactor(syntax ternary: TernaryExprSyntax, in context: ()) -> IfExprSyntax {
    // Extract components with cleaned trivia
    let condition = ternary.condition
      .with(\.leadingTrivia, [])
      .with(\.trailingTrivia, [])
    let thenExpr = ternary.thenExpression
      .with(\.leadingTrivia, [])
      .with(\.trailingTrivia, [])
    let elseExpr = ternary.elseExpression
      .with(\.leadingTrivia, [])
      .with(\.trailingTrivia, [])

    // Infer indentation from context, falling back to 4 spaces
    let indentStep = BasicFormat.inferIndentation(of: ternary.root) ?? .spaces(4)

    // Build the if-expression
    return IfExprSyntax(
      leadingTrivia: ternary.leadingTrivia,
      ifKeyword: .keyword(.if, trailingTrivia: .space),
      conditions: ConditionElementListSyntax {
        ConditionElementSyntax(condition: .expression(ExprSyntax(condition)))
      },
      body: CodeBlockSyntax(
        leftBrace: .leftBraceToken(leadingTrivia: .space),
        statements: CodeBlockItemListSyntax {
          CodeBlockItemSyntax(
            leadingTrivia: .newline + indentStep,
            item: .expr(thenExpr)
          )
        },
        rightBrace: .rightBraceToken(leadingTrivia: .newline)
      ),
      elseKeyword: .keyword(.else, leadingTrivia: .space, trailingTrivia: .space),
      elseBody: .codeBlock(
        CodeBlockSyntax(
          statements: CodeBlockItemListSyntax {
            CodeBlockItemSyntax(
              leadingTrivia: .newline + indentStep,
              item: .expr(elseExpr)
            )
          },
          rightBrace: .rightBraceToken(leadingTrivia: .newline)
        )
      ),
      trailingTrivia: ternary.trailingTrivia
    )
  }
}
