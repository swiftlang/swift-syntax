//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#if compiler(>=6)
public import SwiftSyntax
public import SwiftSyntaxBuilder
#else
import SwiftSyntax
import SwiftSyntaxBuilder
#endif

/// Converts a `try!` expression to a `do-catch` block.
///
/// This refactoring transforms force-try expressions into proper error handling
/// using do-catch blocks with a placeholder for the catch body.
///
/// Example:
/// ```swift
/// // Before:
/// let result = try! riskyFunction()
///
/// // After:
/// let result: ResultType
/// do {
///   result = try riskyFunction()
/// } catch {
///   <#code#>
/// }
/// ```
public struct ConvertToDoCatch: SyntaxRefactoringProvider {
  public static func refactor(syntax: TryExprSyntax, in context: ()) throws -> CodeBlockItemListSyntax {
    // Validate that this is a force-try (try!) expression
    guard syntax.questionOrExclamationMark?.tokenKind == .exclamationMark else {
      throw RefactoringNotApplicableError("not a force-try expression")
    }

    // Create the try expression without the exclamation mark
    let tryExpression = syntax.with(\.questionOrExclamationMark, nil)

    // Create the do-catch statement with proper spacing
    let doStatement = DoStmtSyntax(
      doKeyword: .keyword(.do, trailingTrivia: .space),
      body: CodeBlockSyntax(
        leftBrace: .leftBraceToken(trailingTrivia: .newline),
        statements: CodeBlockItemListSyntax([
          CodeBlockItemSyntax(
            leadingTrivia: .spaces(2),
            item: .expr(ExprSyntax(tryExpression))
          )
        ]),
        rightBrace: .rightBraceToken(leadingTrivia: .newline)
      ),
      catchClauses: CatchClauseListSyntax([
        CatchClauseSyntax(
          catchKeyword: .keyword(.catch, leadingTrivia: .space, trailingTrivia: .space),
          body: CodeBlockSyntax(
            leftBrace: .leftBraceToken(trailingTrivia: .newline),
            statements: CodeBlockItemListSyntax([
              CodeBlockItemSyntax(
                leadingTrivia: .spaces(2),
                item: .expr(ExprSyntax("<#code#>" as ExprSyntax))
              )
            ]),
            rightBrace: .rightBraceToken(leadingTrivia: .newline)
          )
        )
      ])
    )

    return CodeBlockItemListSyntax([
      CodeBlockItemSyntax(item: .stmt(StmtSyntax(doStatement)))
    ])
  }
}
