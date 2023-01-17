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

@_spi(RawSyntax) import SwiftSyntax

extension Lexer {
  /// A sequence of ``Lexer/Lexeme`` tokens starting from a ``Lexer/Cursor``
  /// that points into an input buffer.
  public struct LexemeSequence: IteratorProtocol, Sequence, CustomDebugStringConvertible {
    fileprivate let sourceBufferStart: Lexer.Cursor
    fileprivate var cursor: Lexer.Cursor
    fileprivate var nextToken: Lexer.Lexeme

    fileprivate init(sourceBufferStart: Lexer.Cursor, cursor: Lexer.Cursor) {
      self.sourceBufferStart = sourceBufferStart
      self.cursor = cursor
      self.nextToken = self.cursor.nextToken(sourceBufferStart: self.sourceBufferStart)
    }

    public mutating func next() -> Lexer.Lexeme? {
      return self.advance()
    }

    mutating func advance() -> Lexer.Lexeme {
      defer {
        if self.cursor.isAtEndOfFile {
          self.nextToken = Lexeme(
            tokenKind: .eof,
            flags: [],
            error: nil,
            start: self.cursor.pointer,
            leadingTriviaLength: 0,
            textLength: 0,
            trailingTriviaLength: 0,
            cursor: self.cursor
          )
        } else {
          self.nextToken = self.cursor.nextToken(sourceBufferStart: self.sourceBufferStart)
        }
      }
      return self.nextToken
    }

    /// - Warning: Do not add more usages of this function.
    mutating func resetForSplit(of bytes: Int) -> Lexer.Lexeme {
      guard bytes > 0 else {
        return self.advance()
      }

      // FIXME: This is kind of ridiculous. We shouldn't have to look backwards
      // in the token stream. We should be fusing together runs of operator and
      // identifier characters in the parser, not splitting and backing up
      // again in the lexer.
      let backUpLength = self.nextToken.byteLength + bytes
      self.cursor.backUp(by: backUpLength)
      self.nextToken = self.cursor.nextToken(sourceBufferStart: self.sourceBufferStart)
      return self.advance()
    }

    func peek() -> Lexer.Lexeme {
      return self.nextToken
    }

    /// Force the lexer to perform a state transition, re-lexing `currentToken`
    /// in the new state.
    mutating func perform(stateTransition: StateTransition, currentToken: inout Lexeme) {
      self.cursor = currentToken.cursor
      self.cursor.perform(stateTransition: stateTransition)
      self.nextToken = self.cursor.nextToken(sourceBufferStart: self.sourceBufferStart)
      currentToken = self.advance()
    }

    public var debugDescription: String {
      let remainingText = self.nextToken.debugDescription + String(syntaxText: SyntaxText(baseAddress: self.cursor.input.baseAddress, count: self.cursor.input.count))
      if remainingText.count > 100 {
        return remainingText.prefix(100) + "..."
      } else {
        return remainingText
      }
    }
  }

  @_spi(RawSyntax)
  public static func tokenize(
    _ input: UnsafeBufferPointer<UInt8>,
    from startIndex: Int = 0
  ) -> LexemeSequence {
    assert(input.isEmpty || startIndex < input.endIndex)
    let startChar = startIndex == input.startIndex ? UInt8(ascii: "\0") : input[startIndex - 1]
    let start = Cursor(input: input, previous: UInt8(ascii: "\0"))
    let cursor = Cursor(input: UnsafeBufferPointer(rebasing: input[startIndex...]), previous: startChar)
    return LexemeSequence(sourceBufferStart: start, cursor: cursor)
  }
}
