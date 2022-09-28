//===--- Indenter.swift ---------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//


import SwiftSyntax

extension Trivia {
  func indented(indentation: Trivia) -> Trivia {
    let mappedPieces = self.flatMap { (piece) -> [TriviaPiece] in
      if piece.isNewline {
        return [piece] + indentation.pieces
      } else {
        return [piece]
      }
    }
    return Trivia(pieces: mappedPieces)
  }
}

class Indenter: SyntaxRewriter {
  let indentation: Trivia

  init(indentation: Trivia) {
    self.indentation = indentation
  }

  /// Adds `indentation` after all newlines in the syntax tree.
  public static func indent<SyntaxType: SyntaxProtocol>(
    _ node: SyntaxType,
    indentation: Trivia
  ) -> SyntaxType {
    return Indenter(indentation: indentation).visit(Syntax(node)).as(SyntaxType.self)!
  }

  public override func visit(_ token: TokenSyntax) -> Syntax {
    return Syntax(TokenSyntax(
      token.tokenKind,
      leadingTrivia: token.leadingTrivia.indented(indentation: indentation),
      trailingTrivia: token.trailingTrivia.indented(indentation: indentation),
      presence: token.presence
    ))
  }
}
