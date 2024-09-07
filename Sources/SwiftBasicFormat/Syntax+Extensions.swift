//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#if swift(>=6)
public import SwiftSyntax
#else
import SwiftSyntax
#endif

extension TokenSyntax {
  /// The indentation of this token
  ///
  /// In contrast to `indentationOfLine`, this does not walk to previous tokens to
  /// find the indentation of the line this token occurs on.
  private var indentation: Trivia? {
    let previous = self.previousToken(viewMode: .sourceAccurate)
    return ((previous?.trailingTrivia ?? []) + leadingTrivia).indentation(isOnNewline: previous == nil)
  }

  /// Returns the indentation of the line this token occurs on
  public var indentationOfLine: Trivia {
    var token: TokenSyntax = self
    if let indentation = token.indentation {
      return indentation
    }
    while let previous = token.previousToken(viewMode: .sourceAccurate) {
      token = previous
      if let indentation = token.indentation {
        return indentation
      }
    }

    return []
  }
}

extension SyntaxProtocol {
  /// Indent this node’s lines by the provided amount.
  ///
  /// - Parameter includeFirstLine: Whether the first token of this node should be indented.
  ///   Pass `true` if you know that this node will be placed at the beginning of a line, even if its
  ///   current leading trivia does not start with a newline (such as at the very start of a file).
  public func indented(by indentation: Trivia, indentFirstLine: Bool = false) -> Syntax {
    Indenter(indentation: indentation, indentFirstLine: indentFirstLine)
      .rewrite(self)
  }
}

private class Indenter: SyntaxRewriter {
  private let indentation: Trivia
  private var shouldIndent: Bool

  init(indentation: Trivia, indentFirstLine: Bool) {
    self.indentation = indentation
    self.shouldIndent = indentFirstLine
  }

  private func indentIfNeeded() -> [TriviaPiece] {
    if shouldIndent {
      shouldIndent = false
      return indentation.pieces
    } else {
      return []
    }
  }

  private func indentAfterNewlines(_ content: String) -> String {
    content.split(separator: "\n").joined(separator: "\n" + indentation.description)
  }

  private func indent(_ trivia: Trivia, skipEmpty: Bool) -> Trivia {
    if skipEmpty, trivia.isEmpty { return trivia }

    var result: [TriviaPiece] = []
    // most times, we won’t have anything to insert so this will
    // reserve enough space
    result.reserveCapacity(trivia.count)

    for piece in trivia.pieces {
      result.append(contentsOf: indentIfNeeded())
      switch piece {
      case .newlines, .carriageReturns, .carriageReturnLineFeeds:
        shouldIndent = true
        // style decision: don’t indent totally blank lines
        result.append(piece)
      case .blockComment(let content):
        result.append(.blockComment(indentAfterNewlines(content)))
      case .docBlockComment(let content):
        result.append(.docBlockComment(indentAfterNewlines(content)))
      case .unexpectedText(let content):
        result.append(.unexpectedText(indentAfterNewlines(content)))
      default:
        result.append(piece)
      }
    }
    result.append(contentsOf: indentIfNeeded())
    return Trivia(pieces: result)
  }

  override func visit(_ token: TokenSyntax) -> TokenSyntax {
    let indentedLeadingTrivia = indent(token.leadingTrivia, skipEmpty: false)

    // compute this before indenting the trailing trivia since the
    // newline here is before the start of the trailing trivia (since
    // it is part of the string’s value)
    if case .stringSegment(let content) = token.tokenKind,
       let last = content.last,
       last.isNewline {
      shouldIndent = true
    }

    return token
      .with(\.leadingTrivia, indentedLeadingTrivia)
      // source files as parsed can’t have anything requiring indentation
      // here, but it’s easy to do `.with(\.trailingTrivia, .newline)` so
      // we should still check if there’s something to indent.
      .with(\.trailingTrivia, indent(token.trailingTrivia, skipEmpty: true))
  }
}
