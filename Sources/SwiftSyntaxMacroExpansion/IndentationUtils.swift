//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

// MARK: SyntaxProtocol.indentationOfFirstLine

extension SyntaxProtocol {
  /// The indentation of the first line in this token.
  var indentationOfFirstLine: Trivia {
    guard let firstToken = self.firstToken(viewMode: .sourceAccurate) else {
      return Trivia()
    }
    return firstToken.indentationOfLine
  }
}

// MARK: String.indented

extension String {
  /// Indents every new line in this string by `indentation`.
  ///
  /// - Note: The first line in the string gets indented as well.
  func indented(by indentation: Trivia) -> String {
    if isEmpty || indentation.isEmpty {
      return self
    }

    var indented = ""
    var remaining = self[...]
    while let nextNewline = remaining.firstIndex(where: { $0.isNewline }) {
      if nextNewline != remaining.startIndex {
        // Don’t add indentation if the line is empty.
        indentation.write(to: &indented)
      }
      indented += remaining[...nextNewline]
      remaining = remaining[remaining.index(after: nextNewline)...]
    }

    if !remaining.isEmpty {
      indentation.write(to: &indented)
      indented += remaining
    }

    return indented
  }
}

// MARK: SyntaxProtocol.stripp

fileprivate class IndentationStripper: SyntaxRewriter {
  override func visit(_ token: TokenSyntax) -> TokenSyntax {
    if token.leadingTrivia.contains(where: \.isNewline) || token.trailingTrivia.contains(where: \.isNewline) {
      return
        token
        .with(\.leadingTrivia, token.leadingTrivia.removingIndentation)
        .with(\.trailingTrivia, token.trailingTrivia.removingIndentation)
    } else {
      return token
    }
  }
}

extension Trivia {
  /// Remove all indentation from the trivia.
  var removingIndentation: Trivia {
    var resultPieces: [TriviaPiece] = []
    var isAfterNewline = false
    for piece in pieces {
      if piece.isSpaceOrTab && isAfterNewline {
        // Don’t add whitespace after a newline
        continue
      }
      isAfterNewline = piece.isNewline
      resultPieces.append(piece)
    }
    return Trivia(pieces: resultPieces)
  }

  /// Remove all indentation from the last line of this trivia
  var removingIndentationOnLastLine: Trivia {
    let lastNewlineIndex = pieces.lastIndex(where: \.isNewline) ?? pieces.startIndex

    return Trivia(pieces: pieces[..<lastNewlineIndex]) + Trivia(pieces: pieces[lastNewlineIndex...]).removingIndentation
  }
}

extension SyntaxProtocol {
  /// This syntax node with all indentation removed.
  var withIndentationRemoved: Self {
    return IndentationStripper().rewrite(self).cast(Self.self)
  }
}
