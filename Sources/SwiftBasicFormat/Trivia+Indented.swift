import SwiftSyntax

extension Trivia {
  func indented(indentation: TriviaPiece) -> Trivia {
    var indentedPieces: [TriviaPiece] = []
    for (index, piece) in self.enumerated() {
      let nextPiece = index < pieces.count - 1 ? pieces[index + 1] : nil
      indentedPieces.append(piece)
      if piece.isNewline {
        switch (nextPiece, indentation) {
        case (.spaces(let nextPieceSpaces)?, .spaces(let indentationSpaces)):
          if nextPieceSpaces < indentationSpaces {
            indentedPieces.append(.spaces(indentationSpaces - nextPieceSpaces))
          }
        case (.tabs(let nextPieceTabs)?, .tabs(let indentationTabs)):
          if nextPieceTabs < indentationTabs {
            indentedPieces.append(.tabs(indentationTabs - nextPieceTabs))
          }
        default:
          indentedPieces.append(indentation)
        }
      }
    }
    return Trivia(pieces: indentedPieces)
  }
}
