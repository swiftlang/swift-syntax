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

@_spi(Testing)
public struct TriviaParser {
  @_spi(Testing)
  public static func parseTrivia(_ source: SyntaxText, position: TriviaPosition) -> [RawTriviaPiece] {
    if source.isEmpty { return [] }

    var pieces: [RawTriviaPiece] = []
    var cursor = Lexer.Cursor(
      input: UnsafeBufferPointer(start: source.baseAddress, count: source.count),
      previous: 0
    )

    while true {
      let start = cursor
      switch cursor.advance() {
      case nil:
        // Finished.
        precondition(cursor.isAtEndOfFile)
        return pieces

      case UInt8(ascii: "\n"):
        // "\n"/0A/LF: .newlines.
        cursor.advance(while: { $0 == "\n" })
        pieces.append(.newlines(start.distance(to: cursor)))
        continue

      case UInt8(ascii: "\r"):
        // "\r\n"/0D0A/CRLF: .carriageReturnLineFeeds.
        // "\r"/0D/CR: .carriageReturns.
        pieces.append(cursor.lexCarriageReturn(start: start))
        continue

      case UInt8(ascii: " "):
        // " "/20/Space: .spaces.
        cursor.advance(while: { $0 == " " })
        pieces.append(.spaces(start.distance(to: cursor)))
        continue

      case UInt8(ascii: "\t"):
        // "\t"/09/HT: .tabs.
        cursor.advance(while: { $0 == "\t" })
        pieces.append(.tabs(start.distance(to: cursor)))
        continue

      case UInt8(ascii: "\u{000B}"):
        // "\v"/0B/VT: .verticalTabs
        cursor.advance(while: { $0 == "\u{000B}" })
        pieces.append(.verticalTabs(start.distance(to: cursor)))
        continue

      case UInt8(ascii: "\u{000C}"):
        // "\f"/0C/FF: .formfeeds
        cursor.advance(while: { $0 == "\u{000C}" })
        pieces.append(.formfeeds(start.distance(to: cursor)))
        continue

      case UInt8(ascii: "/"):
        switch cursor.peek() {
        case UInt8(ascii: "/"):
          pieces.append(cursor.lexLineComment(start: start))
          continue
        case UInt8(ascii: "*"):
          pieces.append(cursor.lexBlockComment(start: start))
          continue
        default:
          break
        }

      case UInt8(ascii: "#"):
        cursor.advance(while: { $0 == "#" })
        pieces.append(.pounds(start.distance(to: cursor)))
        continue

      case UInt8(ascii: "<"), UInt8(ascii: ">"):
        // SCM conflict markers.
        if cursor.tryLexConflictMarker(start: start) {
          pieces.append(.unexpectedText(start.text(upTo: cursor)))
          continue
        }

      case UInt8(ascii: "\\"):
        cursor.advance(while: { $0 == "\\" })
        pieces.append(.backslashes(start.distance(to: cursor)))
        continue

      default:
        break
      }

      // Default handling for anything that didn't 'continue' in the above
      // switch statement.

      // Other characters must be "unexpected text". Advance to next trivia
      // piece start.
      cursor.advance(while: { char in
        switch char {
        case " ", "\n", "\r", "\t", "\u{000B}", "\u{000C}", "/", "#", "<", ">":
          return false
        default:
          return true
        }
      })

      // If the last piece was `.unexpectedText` (e.g `/` was in an
      // unexpected text trivia piece and were not a comment), merge it to
      // the last piece.
      if case .unexpectedText(let preUnexpected) = pieces.last {
        precondition(start.pointer == preUnexpected.baseAddress! + preUnexpected.count)
        let mergedText = SyntaxText(
          baseAddress: preUnexpected.baseAddress,
          count: preUnexpected.count + start.distance(to: cursor)
        )
        pieces[pieces.count - 1] = .unexpectedText(mergedText)
      } else {
        pieces.append(.unexpectedText(start.text(upTo: cursor)))
      }
    }

    return pieces
  }

}

extension Lexer.Cursor {
  fileprivate mutating func lexCarriageReturn(start: Lexer.Cursor) -> RawTriviaPiece {
    precondition(self.previous == UInt8(ascii: "\r"))
    if self.advance(if: { $0 == "\n" }) {
      var mark = self
      while true {
        if self.advance(if: { $0 == "\r" }),
          self.advance(if: { $0 == "\n" })
        {
          mark = self
          continue
        } else {
          self = mark
          break
        }
      }
      return .carriageReturnLineFeeds(start.distance(to: self) / 2)
    } else {
      var mark = self
      while true {
        if self.advance(if: { $0 == "\r" }), !self.advance(if: { $0 == "\n" }) {
          mark = self
          continue
        } else {
          self = mark
          break
        }
      }
      return .carriageReturns(start.distance(to: self))
    }
  }

  fileprivate mutating func lexLineComment(start: Lexer.Cursor) -> RawTriviaPiece {
    // "///...": .docLineComment.
    // "//...": .lineComment.
    precondition(self.previous == UInt8(ascii: "/") && self.is(at: "/"))
    let isDocComment = self.input.count > 1 && self.is(offset: 1, at: "/")
    self.advanceToEndOfLine()
    let contents = start.text(upTo: self)
    return isDocComment ? .docLineComment(contents) : .lineComment(contents)
  }

  fileprivate mutating func lexBlockComment(start: Lexer.Cursor) -> RawTriviaPiece {
    // "/**...*/": .docBlockComment.
    // "/*...*/": .blockComment.
    // "/**/": .blockComment.
    precondition(self.previous == UInt8(ascii: "/") && self.is(at: "*"))
    let isDocComment = self.input.count > 2 && self.is(offset: 1, at: "*") && self.is(offset: 2, notAt: "/")
    _ = self.advanceToEndOfSlashStarComment(slashPosition: start)
    let contents = start.text(upTo: self)
    return isDocComment ? .docBlockComment(contents) : .blockComment(contents)
  }
}
