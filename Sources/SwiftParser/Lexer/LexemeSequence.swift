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

#if compiler(>=6)
@_spi(RawSyntax) @_spi(BumpPtrAllocator) internal import SwiftSyntax
#else
@_spi(RawSyntax) @_spi(BumpPtrAllocator) import SwiftSyntax
#endif

extension Lexer {
  /// Owns the memory that the lexer's state stack spills into.
  ///
  /// Whoever creates this keeps it alive for as long as the lexeme sequence made
  /// from it, and anything copied from that sequence.
  @_spi(Testing)
  public final class StateAllocator {
    let allocator: BumpPtrAllocator

    /// Nodes already built for a state pushed onto the empty stack, so that a
    /// file entering the same state repeatedly builds one node rather than one
    /// per occurrence. Only these are shared, being the ones that recur.
    ///
    /// Bounded, so that a file entering many distinct states allocates rather
    /// than turning every transition into a long scan. Six entries suffice for
    /// the parser's own sources.
    var nodesOnEmptyStack: [UnsafePointer<Lexer.Cursor.StateStack.Node>] = []

    static let nodesOnEmptyStackLimit = 16

    @_spi(Testing)
    public init() {
      self.allocator = BumpPtrAllocator(initialSlabSize: 256)
      self.nodesOnEmptyStack.reserveCapacity(Self.nodesOnEmptyStackLimit)
    }
  }

  /// A sequence of ``Lexer/Lexeme`` tokens starting from a ``Lexer/Cursor``
  /// that points into an input buffer.
  @_spi(Testing)
  public struct LexemeSequence: IteratorProtocol, Sequence, CustomDebugStringConvertible {
    fileprivate let sourceBufferStart: UnsafePointer<UInt8>?
    fileprivate var cursor: Lexer.Cursor
    fileprivate var nextToken: Lexer.Lexeme
    /// Where the lexer allocates the states above the first one on its stack,
    /// which costs less than the retain and release an array would.
    ///
    /// Unmanaged so that copying a sequence to start a ``Lookahead`` stays a
    /// move; `unowned(unsafe)` costs a retain and release for every token, since
    /// the allocator is passed as a parameter. Whoever creates the sequence keeps
    /// the allocator alive for at least as long as anything copied from it.
    let lexerStateAllocator: Unmanaged<Lexer.StateAllocator>

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

    fileprivate init(
      sourceBufferStart: UnsafePointer<UInt8>?,
      cursor: Lexer.Cursor,
      lookaheadTracker: UnsafeMutablePointer<LookaheadTracker>,
      stateAllocator: Unmanaged<Lexer.StateAllocator>
    ) {
      self.sourceBufferStart = sourceBufferStart
      self.cursor = cursor
      self.lexerStateAllocator = stateAllocator
      self.nextToken = self.cursor.nextToken(
        sourceBufferStart: self.sourceBufferStart,
        stateAllocator: stateAllocator
      )
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
        self.nextToken = self.cursor.nextToken(
          sourceBufferStart: self.sourceBufferStart,
          stateAllocator: lexerStateAllocator
        )
      }
      self.recordNextTokenInLookaheadTracker()
      return self.nextToken
    }

    /// Get the offset of the leading trivia start of `token` relative to `sourceBufferStart`.
    func offsetToStart(_ token: Lexer.Lexeme) -> Int {
      return self.sourceBufferStart!.distance(to: token.cursor.pointer)
    }

    /// Advance the the cursor by `offset` and reset `currentToken`
    ///
    /// - Important: This should only be used for incremental parsing.
    mutating func advance(by offset: Int, currentToken: inout Lexer.Lexeme) {
      self.cursor = currentToken.cursor
      self.cursor.position = self.cursor.position.advanced(by: offset)

      self.nextToken = self.cursor.nextToken(
        sourceBufferStart: self.sourceBufferStart,
        stateAllocator: lexerStateAllocator
      )

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
      self.nextToken = self.cursor.nextToken(
        sourceBufferStart: self.sourceBufferStart,
        stateAllocator: lexerStateAllocator
      )
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
      self.nextToken = self.cursor.nextToken(
        sourceBufferStart: self.sourceBufferStart,
        stateAllocator: self.lexerStateAllocator
      )
      currentToken = self.advance()
    }

    @_spi(Testing)
    public var debugDescription: String {
      let remainingText =
        self.nextToken.debugDescription
        + String(syntaxText: SyntaxText(baseAddress: self.cursor.input.baseAddress, count: self.cursor.input.count))
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
    lookaheadTracker: UnsafeMutablePointer<LookaheadTracker>,
    stateAllocator: StateAllocator
  ) -> LexemeSequence {
    precondition(input.isEmpty || startIndex < input.endIndex)
    let startChar = startIndex == input.startIndex ? UInt8(ascii: "\0") : input[startIndex - 1]
    let cursor = Cursor(
      input: UnsafeBufferPointer(rebasing: input[startIndex...]),
      previous: startChar
    )
    return LexemeSequence(
      sourceBufferStart: input.baseAddress,
      cursor: cursor,
      lookaheadTracker: lookaheadTracker,
      stateAllocator: .passUnretained(stateAllocator)
    )
  }
}
