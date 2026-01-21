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
  public struct Context {
    /// The indentation width to use for the generated do-catch block.
    /// If `nil`, a default indentation of 2 spaces will be used.
    public let indentationWidth: Trivia?

    public init(indentationWidth: Trivia? = nil) {
      self.indentationWidth = indentationWidth
    }
  }

  public static func refactor(syntax: TryExprSyntax, in context: Context = Context()) throws -> CodeBlockItemListSyntax
  {
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
      tryExpression = syntax
        .with(\.tryKeyword, newTryKeyword)
        .with(\.questionOrExclamationMark, nil)
    } else {
      tryExpression = syntax.with(\.questionOrExclamationMark, nil)
    }

    // Extract the base indentation from the source file
    let baseIndentation = syntax.firstToken(viewMode: .sourceAccurate)?.indentationOfLine ?? []

    // Determine the indentation width (default to 2 spaces if not provided)
    let indentWidth = context.indentationWidth ?? .spaces(2)

    // Create the do-catch statement
    let doStatement = DoStmtSyntax(
      doKeyword: .keyword(.do),
      body: CodeBlockSyntax(
        leftBrace: .leftBraceToken(),
        statements: CodeBlockItemListSyntax([
          CodeBlockItemSyntax(
            item: .expr(ExprSyntax(tryExpression))
          )
        ]),
        rightBrace: .rightBraceToken()
      ),
      catchClauses: CatchClauseListSyntax([
        CatchClauseSyntax(
          catchKeyword: .keyword(.catch),
          body: CodeBlockSyntax(
            leftBrace: .leftBraceToken(),
            statements: CodeBlockItemListSyntax([
              CodeBlockItemSyntax(
                item: .expr(ExprSyntax("<#code#>" as ExprSyntax))
              )
            ]),
            rightBrace: .rightBraceToken()
          )
        )
      ])
    )

    // Format the do-catch statement with the proper indentation
    let format = BasicFormat(
      indentationWidth: indentWidth,
      initialIndentation: baseIndentation
    )
    
    let formatted = doStatement.formatted(using: format).as(DoStmtSyntax.self)!

    return CodeBlockItemListSyntax([
      CodeBlockItemSyntax(item: .stmt(StmtSyntax(formatted)))
    ])
  }
}
