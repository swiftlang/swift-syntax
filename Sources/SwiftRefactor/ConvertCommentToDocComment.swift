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
#else
import SwiftSyntax
#endif

public struct ConvertCommentToDocComment: SyntaxRefactoringProvider {
  public static func refactor(syntax: DeclSyntax, in context: ()) throws -> DeclSyntax {
    guard let firstToken = syntax.firstToken(viewMode: .sourceAccurate) else {
      throw RefactoringNotApplicableError("declaration has no tokens")
    }

    let leadingTrivia = firstToken.leadingTrivia

    let hasConvertibleComment = leadingTrivia.contains { piece in
      switch piece {
      case .lineComment, .blockComment:
        return true
      default:
        return false
      }
    }

    guard hasConvertibleComment else {
      throw RefactoringNotApplicableError(
        "no line or block comments found preceding this declaration"
      )
    }

    let newTrivia = Trivia(
      pieces: leadingTrivia.map { piece in
        switch piece {
        case let .lineComment(text):
          return .docLineComment(convertLineComment(text))
        case let .blockComment(text):
          return .docBlockComment(convertBlockComment(text))
        default:
          return piece
        }
      }
    )

    return syntax.with(
      \.leadingTrivia,
      newTrivia
    )
  }

  private static func convertLineComment(_ text: String) -> String {
    return "/" + text
  }

  /// Converts a block comment (`/* ... */`) to a doc block comment
  /// (`/** ... */`).
  private static func convertBlockComment(_ text: String) -> String {
    // text starts with "/*" and ends with "*/"
    // Insert an extra "*" after "/*" to produce "/**"
    return "/**" + text.dropFirst(2)
  }
}
