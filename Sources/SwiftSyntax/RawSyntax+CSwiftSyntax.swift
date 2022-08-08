//===------------------- RawSyntax+CSwiftSyntax.swift ---------------------===//
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

@_implementationOnly import _CSwiftSyntax

extension RawSyntax {
  static func createFromCSyntaxNode(
    _ p: CSyntaxNodePtr,
    in sourceBuffer: UnsafeBufferPointer<UInt8>,
    arena: SyntaxArena
  ) -> RawSyntax {
    let cnode = p.pointee
    if cnode.kind == 0 {
      // Token.

      func sliceSourceText(_ r: CRange) -> SyntaxText {
        let sourceText = SyntaxText(
          baseAddress: sourceBuffer.baseAddress, count: sourceBuffer.count)
        let range = Int(r.offset) ..< Int(r.offset + r.length)
        return SyntaxText(rebasing: sourceText[range])
      }

      let tokenKind: RawTokenKind = RawTokenKind.fromRawValue(cnode.token_data.kind)
      /// Whole text of the token including leading/trailing trivia.
      let wholeText: SyntaxText = sliceSourceText(cnode.token_data.range)

      // These numbers are being adjusted while materializing trivia.
      var tokenTextStart = 0
      var tokenTextEnd = wholeText.count

      // Prepare trivia.
      let leadingTriviaInfo = UnsafeBufferPointer<swiftparse_trivia_piece_t>(
        start: cnode.token_data.leading_trivia, count: numericCast(cnode.token_data.leading_trivia_count))
      let trailingTriviaInfo = UnsafeBufferPointer<swiftparse_trivia_piece_t>(
        start: cnode.token_data.trailing_trivia, count: numericCast(cnode.token_data.trailing_trivia_count))

      let pieceBuffer = arena.allocateRawTriviaPieceBuffer(
        count: leadingTriviaInfo.count + trailingTriviaInfo.count)
      let numLeadingTrivia = leadingTriviaInfo.count

      // Materialize the leading trivia, and advance 'tokenTextStart' to point
      // the end of leading trivia.
      for i in 0..<numLeadingTrivia {
        let cPiece = leadingTriviaInfo[i]
        let pieceStart = tokenTextStart
        let pieceEnd = tokenTextStart + numericCast(cPiece.length)
        let pieceText = SyntaxText(rebasing: wholeText[pieceStart ..< pieceEnd])
        let piece = RawTriviaPiece.fromRawValue(kind: cPiece.kind, text: pieceText)
        pieceBuffer.baseAddress!.advanced(by: i).initialize(to: piece)
        tokenTextStart = pieceEnd
      }
      // Materialize the trailing trivia, and retreat 'tokenTextEnd' to point
      // point the start of trailing trivia.
      for i in (0..<trailingTriviaInfo.count).reversed() {
        let cPiece = trailingTriviaInfo[i]
        let pieceStart = tokenTextEnd - numericCast(cPiece.length)
        let pieceEnd = tokenTextEnd
        let pieceText = SyntaxText(rebasing: wholeText[pieceStart ..< pieceEnd])
        let piece = RawTriviaPiece.fromRawValue(kind: cPiece.kind, text: pieceText)
        pieceBuffer.baseAddress!.advanced(by: numLeadingTrivia + i).initialize(to: piece)
        tokenTextEnd = pieceStart
      }

      // Slice the text
      let tokenText = SyntaxText(rebasing: wholeText[tokenTextStart ..< tokenTextEnd])

      // Total length of the pieces must match the whole text.
      assert(tokenText.count + pieceBuffer.reduce(0, {$0 + $1.byteLength}) == wholeText.count)

      return RawSyntax.materializedToken(
        kind: tokenKind, text: tokenText,
        triviaPieces: RawTriviaPieceBuffer(pieceBuffer),
        numLeadingTrivia: numericCast(numLeadingTrivia),
        byteLength: numericCast(wholeText.count),
        arena: arena)
    } else {
      // Layout.

      let syntaxKind = SyntaxKind(rawValue: numericCast(cnode.kind))!

      let count = Int(cnode.layout_data.nodes_count)
      if count == 0 {
        return makeEmptyLayout(kind: syntaxKind, arena: arena)
      }

      // '!' because we know 'count' is not 0.
      let nodes: UnsafePointer<CClientNode?> = cnode.layout_data.nodes!
      return makeLayout(
        kind: syntaxKind,
        uninitializedCount: count,
        arena: arena
      ) { buffer in
        var ptr = buffer.baseAddress!
        for i in 0 ..< count {
          let element: RawSyntax? = nodes[i].map {
            // 'CClinentNode' is a pointer to a 'RawSyntaxData'.
            return RawSyntax.fromOpaque(UnsafeRawPointer($0))
          }
          ptr.initialize(to: element)
          ptr += 1
        }
      }
    }
  }
}
