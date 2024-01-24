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

@_spi(RawSyntax) @_spi(BumpPtrAllocator) import SwiftSyntax

extension Lexer {
  /// A sequence of ``Lexer/Lexeme`` tokens starting from a ``Lexer/Cursor``
  /// that points into an input buffer.
  @_spi(Testing)
  public struct LexemeSequence: IteratorProtocol, Sequence, CustomDebugStringConvertible {
    fileprivate let sourceBufferStart: Lexer.Cursor
    fileprivate var cursor: Lexer.Cursor
    fileprivate var nextToken: Lexer.Lexeme
    /// If the lexer has more than one state on its state stack, it will
    /// allocate a new memory region in this allocator to represent the
    /// additional states on its stack. This is more efficient than paying the
    /// retain/release cost of an array.
    ///
    /// The states will be freed when the lexer is finished, i.e. when this
    /// ``LexemeSequence`` is deallocated.
    ///
    /// The memory footprint of not freeing past lexer states is negligible. It's
    /// usually less than 0.1% of the memory allocated by the syntax arena.
    var lexerStateAllocator = BumpPtrAllocator(initialSlabSize: 256)

    /// The offset of the trailing trivia end of `nextToken` relative to the source buffer’s start.
    var offsetToNextTokenEnd: Int {
      self.offsetToStart(self.nextToken) + self.nextToken.byteLength
    }

    /// See doc comments in ``LookaheadTracker``
    ///
    /// This is an `UnsafeMutablePointer` for two reasons
    ///  - When `LexemeSequence` gets copied (e.g. when a ``Lookahead`` gets created), it should still reference the same ``LookaheadTracker`` so that any lookahead performed in the ``Lookahead`` also affects the original ``Parser``. It thus needs to be a reference type
    ///  - ``LookaheadTracker`` is not a class to avoid reference counting it. The ``Parser`` that creates the ``LexemeSequence`` will always outlive any ``Lookahead`` created for it.
    let lookaheadTracker: UnsafeMutablePointer<LookaheadTracker>

    fileprivate init(sourceBufferStart: Lexer.Cursor, cursor: Lexer.Cursor, lookaheadTracker: UnsafeMutablePointer<LookaheadTracker>) {
      self.sourceBufferStart = sourceBufferStart
      self.cursor = cursor
      self.nextToken = self.cursor.nextToken(sourceBufferStart: self.sourceBufferStart, stateAllocator: lexerStateAllocator)
      self.lookaheadTracker = lookaheadTracker
    }

    @_spi(Testing)
    public mutating func next() -> Lexer.Lexeme? {
      return self.advance()
    }

    /// Record the offset of the end of `nextToken` as the furthest offset in ``LookaheadTracker``
    private func recordNextTokenInLookaheadTracker() {
      self.lookaheadTracker.pointee.recordFurthestOffset(self.offsetToNextTokenEnd)
    }

    mutating func advance() -> Lexer.Lexeme {
      defer {
        self.nextToken = self.cursor.nextToken(sourceBufferStart: self.sourceBufferStart, stateAllocator: lexerStateAllocator)
      }
      self.recordNextTokenInLookaheadTracker()
      return self.nextToken
    }

    /// Get the offset of the leading trivia start of `token` relative to `sourceBufferStart`.
    func offsetToStart(_ token: Lexer.Lexeme) -> Int {
      return self.sourceBufferStart.distance(to: token.cursor)
    }

    /// Advance the the cursor by `offset` and reset `currentToken`
    ///
    /// - Important: This should only be used for incremental parsing.
    mutating func advance(by offset: Int, currentToken: inout Lexer.Lexeme) {
      self.cursor = currentToken.cursor
      self.cursor.position = self.cursor.position.advanced(by: offset)

      self.nextToken = self.cursor.nextToken(sourceBufferStart: self.sourceBufferStart, stateAllocator: lexerStateAllocator)

      currentToken = self.advance()
    }

    /// Reset the lexeme sequence to the state we were in when lexing `splitToken`
    /// but after we consumed `consumedPrefix` bytes from `splitToken`.
    /// - Warning: Do not add more usages of this function.
    mutating func resetForSplit(splitToken: Lexeme, consumedPrefix: Int) -> Lexer.Lexeme {
      self.cursor = splitToken.cursor
      for _ in 0..<consumedPrefix {
        _ = self.cursor.advance()
      }
      self.nextToken = self.cursor.nextToken(sourceBufferStart: self.sourceBufferStart, stateAllocator: lexerStateAllocator)
      return self.advance()
    }

    func peek() -> Lexer.Lexeme {
      self.recordNextTokenInLookaheadTracker()
      return self.nextToken
    }

    /// Force the lexer to perform a state transition, re-lexing `currentToken`
    /// in the new state.
    mutating func perform(stateTransition: StateTransition, currentToken: inout Lexeme) {
      self.cursor = currentToken.cursor
      self.cursor.perform(stateTransition: stateTransition, stateAllocator: self.lexerStateAllocator)
      self.nextToken = self.cursor.nextToken(sourceBufferStart: self.sourceBufferStart, stateAllocator: self.lexerStateAllocator)
      currentToken = self.advance()
    }

    @_spi(Testing)
    public var debugDescription: String {
      let remainingText =
        self.nextToken.debugDescription + String(syntaxText: SyntaxText(baseAddress: self.cursor.input.baseAddress, count: self.cursor.input.count))
      if remainingText.count > 100 {
        return remainingText.prefix(100) + "..."
      } else {
        return remainingText
      }
    }
  }

  @_spi(Testing)
  public static func tokenize(
    _ input: UnsafeBufferPointer<UInt8>,
    from startIndex: Int = 0,
    lookaheadTracker: UnsafeMutablePointer<LookaheadTracker>
  ) -> LexemeSequence {
    precondition(input.isEmpty || startIndex < input.endIndex)
    let startChar = startIndex == input.startIndex ? UInt8(ascii: "\0") : input[startIndex - 1]
    let start = Cursor(input: input, previous: UInt8(ascii: "\0"))
    let cursor = Cursor(input: UnsafeBufferPointer(rebasing: input[startIndex...]), previous: startChar)
    return LexemeSequence(sourceBufferStart: start, cursor: cursor, lookaheadTracker: lookaheadTracker)
  }
}
