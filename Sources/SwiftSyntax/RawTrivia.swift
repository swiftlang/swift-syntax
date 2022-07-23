//===---------------- RawTrivia.swift - Raw Syntax Trivia -----------------===//
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

public typealias RawTriviaPieceBuffer = UnsafeBufferPointer<RawTriviaPiece>

/// Trivia data for RawSyntax tree.
@usableFromInline
enum RawTrivia {
  /// Substring of the source buffer. This can be parsed
  case unparsed(StringRef)
  case materialized(RawTriviaPieceBuffer)

  func withUnsafeText<T>(_ body: (StringRef) -> T) -> T {
    switch self {
    case .unparsed(let str):
      return body(str)
    case .materialized(let pieces):
      var out = ""
      for piece in pieces {
        piece.write(to: &out)
      }
      return out.withUTF8 { utf8 in
        return body(StringRef(baseAddress: utf8.baseAddress, count: utf8.count))
      }
    }
  }
}

extension RawTrivia: TextOutputStreamable {
  @usableFromInline
  func write<Target: TextOutputStream>(to target: inout Target) {
    switch self {
    case .unparsed(let str): String(stringRef: str).write(to: &target)
    case .materialized(let pieces):
      for piece in pieces {
        piece.write(to: &target)
      }
    }
  }
}

extension RawTrivia: CustomDebugStringConvertible {
  @usableFromInline
  var debugDescription: String {
    switch self {
    case .unparsed(let str): return String(stringRef: str).debugDescription
    case .materialized(let pieces):
      var out: String = ""
      for piece in pieces {
        piece.write(to: &out)
      }
      return out.debugDescription
    }
  }
}

extension Trivia {
  // Convert `RawTrivia` to `Triva`
  static func make(arena: SyntaxArena, raw: RawTrivia) -> Trivia {
    switch raw {
    case .materialized(let rawPieces):
      var pieces: [TriviaPiece] = []
      pieces.reserveCapacity(rawPieces.count)
      for raw in rawPieces {
        pieces.append(TriviaPiece(raw: raw))
      }
      return .init(pieces: pieces)
    case .unparsed(let string):
      let rawPieces = arena.parseTrivia(string, isTrailing: false)
      return .init(pieces: rawPieces.map(TriviaPiece.init(raw:)))
    }
  }
}
