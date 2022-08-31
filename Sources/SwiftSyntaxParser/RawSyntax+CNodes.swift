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

@_spi(RawSyntax) import SwiftSyntax

extension RawSyntax {
  private static func makeTokenFromCNode(
    _ p: CSyntaxNodePtr, in sourceBuffer: UnsafeBufferPointer<UInt8>, arena: SyntaxArena
  ) -> RawSyntax {
    let cnode = p.pointee
    assert(cnode.kind == 0)

    let tokenKind: RawTokenKind = RawTokenKind(serializationCode: cnode.token_data.kind)

    /// Whole text of the token including leading/trailing trivia.
    let wholeText: SyntaxText = {
      let r = cnode.token_data.range
      let sourceText = SyntaxText(
        baseAddress: sourceBuffer.baseAddress, count: sourceBuffer.count)
      let range = Int(r.offset) ..< Int(r.offset + r.length)
      return SyntaxText(rebasing: sourceText[range])
    }()

    // Prepare trivia.
    let leadingTriviaInfo = UnsafeBufferPointer<CTriviaPiece>(
      start: cnode.token_data.leading_trivia, count: Int(cnode.token_data.leading_trivia_count))
    let trailingTriviaInfo = UnsafeBufferPointer<CTriviaPiece>(
      start: cnode.token_data.trailing_trivia, count: Int(cnode.token_data.trailing_trivia_count))

    let leadingTriviaByteLength = leadingTriviaInfo.reduce(0, {$0 + Int($1.length)})
    let trailingTriviaByteLength = trailingTriviaInfo.reduce(0, {$0 + Int($1.length)})

    // Slice the text.
    let textRange = leadingTriviaByteLength ..< (wholeText.count - trailingTriviaByteLength)
    let tokenText = SyntaxText(rebasing: wholeText[textRange])

    // Helper to initialize raw trivia piece buffer from C trivia pieces.
    // 'start' is a text index in 'wholeText' where the trivia text starts.
    func initializeRawTriviaBuffer(
      _ buffer: UnsafeMutableBufferPointer<RawTriviaPiece>,
      _ start: Int, _ pieces: UnsafeBufferPointer<CTriviaPiece>
    ) {
      guard var ptr = buffer.baseAddress else { return }
      var start = start
      for cPiece in pieces {
        let end = start + numericCast(cPiece.length)
        let pieceText = SyntaxText(rebasing: wholeText[start..<end])
        let piece = RawTriviaPiece(serializationCode: cPiece.kind, text: pieceText)
        ptr.initialize(to: piece)
        start = end
        ptr += 1
      }
    }

    return .makeMaterializedToken(
      kind: tokenKind, text: tokenText,
      leadingTriviaPieceCount: leadingTriviaInfo.count,
      trailingTriviaPieceCount: trailingTriviaInfo.count,
      presence: cnode.present ? .present : .missing,
      arena: arena,
      initializingLeadingTriviaWith: {
        initializeRawTriviaBuffer($0, 0, leadingTriviaInfo)
      },
      initializingTrailingTriviaWith: {
        initializeRawTriviaBuffer($0, textRange.upperBound, trailingTriviaInfo)
      })
  }

  static func makeLayoutFromCNode(_ p: CSyntaxNodePtr, arena: SyntaxArena) -> RawSyntax {
    let cnode = p.pointee
    let syntaxKind = SyntaxKind(serializationCode: cnode.kind)
    assert(syntaxKind != .token)

    let children = UnsafeBufferPointer<CClientNode?>(
      start: cnode.layout_data.nodes, count: Int(cnode.layout_data.nodes_count))

    return makeLayout(
      kind: syntaxKind,
      uninitializedCount: children.count,
      arena: arena
    ) { buffer in
      guard var ptr = buffer.baseAddress else { return }
      for cnode in children {
        let element: RawSyntax? = cnode.map {
          // 'CClientNode' is a node created with `toOpaque()`
          RawSyntax.fromOpaque(UnsafeRawPointer($0))
        }
        ptr.initialize(to: element)
        ptr += 1
      }
    }
  }

  static func getOpaqueFromCNode(
    _ p: CSyntaxNodePtr,
    in sourceBuffer: UnsafeBufferPointer<UInt8>,
    arena: SyntaxArena
  ) -> CClientNode {
    let raw: RawSyntax
    if p.pointee.kind == 0 {
      raw = makeTokenFromCNode(p, in: sourceBuffer, arena: arena)
    } else {
      raw = makeLayoutFromCNode(p, arena: arena)
    }
    return CClientNode(mutating: raw.toOpaque())
  }
}
