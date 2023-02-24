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

import SwiftSyntax

extension Trivia {
  /// Makes sure each newline of this trivia is followed by `indentation`. If this is not the case, the existing indentation is extended to `indentation`.
  /// `isOnNewline` determines whether the trivia starts on a new line. If this is the case, the function makes sure that the returned trivia starts with `indentation`.
  func indented(indentation: TriviaPiece, isOnNewline: Bool = false) -> Trivia {
    var indentedPieces: [TriviaPiece] = []
    for (index, piece) in self.enumerated() {
      let previousPieceIsNewline: Bool
      if index == 0 {
        previousPieceIsNewline = isOnNewline
      } else {
        previousPieceIsNewline = pieces[index - 1].isNewline
      }
      if previousPieceIsNewline {
        switch (piece, indentation) {
        case (.spaces(let nextPieceSpaces), .spaces(let indentationSpaces)):
          if nextPieceSpaces < indentationSpaces {
            indentedPieces.append(.spaces(indentationSpaces - nextPieceSpaces))
          }
        case (.tabs(let nextPieceTabs), .tabs(let indentationTabs)):
          if nextPieceTabs < indentationTabs {
            indentedPieces.append(.tabs(indentationTabs - nextPieceTabs))
          }
        default:
          indentedPieces.append(indentation)
        }
      }
      indentedPieces.append(piece)
    }
    if self.pieces.last?.isNewline == true {
      indentedPieces.append(indentation)
    }
    return Trivia(pieces: indentedPieces)
  }
}
