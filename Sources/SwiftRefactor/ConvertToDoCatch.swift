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
import SwiftBasicFormat
import SwiftParser
@_spi(RawSyntax) public import SwiftSyntax
import SwiftSyntaxBuilder
#else
import SwiftBasicFormat
import SwiftParser
@_spi(RawSyntax) import SwiftSyntax
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
/// do {
///   let result = try riskyFunction()
/// } catch {
///   <#code#>
/// }
/// ```
public struct ConvertToDoCatch: SyntaxRefactoringProvider {
  public static func refactor(syntax: TryExprSyntax, in context: Void = ()) throws -> CodeBlockItemListSyntax {
    // Validate that this is a force-try (try!) expression
    guard syntax.questionOrExclamationMark?.tokenKind == .exclamationMark else {
      throw RefactoringNotApplicableError("not a force-try expression")
    }

    // Create the try expression without the exclamation mark
    // Transfer any trailing trivia from the ! to the try keyword to preserve comments
    let tryExpression: TryExprSyntax
    if let exclamationMark = syntax.questionOrExclamationMark {
      let newTryKeyword = syntax.tryKeyword.with(
        \.trailingTrivia,
        syntax.tryKeyword.trailingTrivia + exclamationMark.trailingTrivia
      )
      tryExpression =
        syntax
        .with(\.tryKeyword, newTryKeyword)
        .with(\.questionOrExclamationMark, nil)
    } else {
      tryExpression = syntax.with(\.questionOrExclamationMark, nil)
    }

    // Infer the indentation width from the source file
    let indentationWidth = BasicFormat.inferIndentation(of: syntax) ?? .spaces(2)

    // Extract the base indentation from the source file (where the try! expression is)
    let baseIndentation = syntax.firstToken(viewMode: .sourceAccurate)?.indentationOfLine ?? []

    // Strip base indentation from try expression while preserving comments/newlines
    let tryExprWithoutBaseIndent = stripBaseIndentation(from: tryExpression, base: baseIndentation)

    // Create the do-catch statement with explicit structure
    let doStatement = DoStmtSyntax(
      leadingTrivia: baseIndentation,
      doKeyword: .keyword(.do, trailingTrivia: .space),
      body: CodeBlockSyntax(
        leftBrace: .leftBraceToken(trailingTrivia: .newline),
        statements: CodeBlockItemListSyntax([
          CodeBlockItemSyntax(
            item: .expr(ExprSyntax(tryExprWithoutBaseIndent))
          )
        ]).indented(by: baseIndentation + indentationWidth, indentFirstLine: true),
        rightBrace: .rightBraceToken(leadingTrivia: .newline + baseIndentation)
      ),
      catchClauses: CatchClauseListSyntax([
        CatchClauseSyntax(
          catchKeyword: .keyword(.catch, leadingTrivia: .space, trailingTrivia: .space),
          body: CodeBlockSyntax(
            leftBrace: .leftBraceToken(trailingTrivia: .newline),
            statements: CodeBlockItemListSyntax([
              CodeBlockItemSyntax(
                item: .expr(ExprSyntax("<#code#>" as ExprSyntax))
              )
            ]).indented(by: baseIndentation + indentationWidth, indentFirstLine: true),
            rightBrace: .rightBraceToken(leadingTrivia: .newline + baseIndentation)
          )
        )
      ])
    )

    return CodeBlockItemListSyntax([
      CodeBlockItemSyntax(item: .stmt(StmtSyntax(doStatement)))
    ])
  }

  /// Strips base indentation from a try expression's leading trivia while preserving comments and newlines.
  private static func stripBaseIndentation(from tryExpr: TryExprSyntax, base: Trivia) -> TryExprSyntax {
    let tryKeyword = tryExpr.tryKeyword
    var leadingPieces = tryKeyword.leadingTrivia.pieces
    var basePieces = base.pieces

    // Remove matching leading pieces (the base indentation)
    while !basePieces.isEmpty && !leadingPieces.isEmpty && leadingPieces[0] == basePieces[0] {
      leadingPieces.removeFirst()
      basePieces.removeFirst()
    }

    let newLeadingTrivia = Trivia(pieces: leadingPieces)
    let newTryKeyword = tryKeyword.with(\.leadingTrivia, newLeadingTrivia)
    return tryExpr.with(\.tryKeyword, newTryKeyword)
  }
}
