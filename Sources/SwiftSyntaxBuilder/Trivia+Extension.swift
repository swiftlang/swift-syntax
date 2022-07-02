//===----------------------------------------------------------------------===//
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
  /// Re-indents trivia that form a block comment to have consistent indentation.
  ///
  /// If the trivia start with a newline (i.e. the first non-whitespace trivia is on a fresh line) and that newline starts with spacing, the same spacing is applied to all the following lines. For example.
  /// ```
  ///   // first line
  /// // second line
  /// // third line
  /// ```
  /// picks up the indentation from the first line and transforms the trivia to
  /// ```
  ///   // first line
  ///   // second line
  ///   // third line
  /// ```
  func addingSpacingAfterNewlinesIfNeeded() -> Trivia {
    var updatedTriviaPieces = self.pieces
    if updatedTriviaPieces.count > 2,
       updatedTriviaPieces[0].isNewline,
       let indentation = self.makeIndentation(trivia: updatedTriviaPieces[1]) {
      
      for i in (2..<updatedTriviaPieces.count).reversed() where updatedTriviaPieces[i].isNewline {
        updatedTriviaPieces.insert(indentation, at: i + 1)
      }
    }
    
    return Trivia(pieces: updatedTriviaPieces)
  }
  
  private func makeIndentation(trivia: TriviaPiece) -> TriviaPiece? {
    switch trivia {
    case .spaces,
         .tabs: return trivia
    default:
      return nil
    }
  }
}
