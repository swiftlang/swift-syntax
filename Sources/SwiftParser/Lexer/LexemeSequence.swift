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
    /// `LexemeSequence` is deallocated.
    ///
    /// The memory footpring of not freeing past lexer states is neglible. It's
    /// usually less than 0.1% of the memory allocated by the syntax arena.
    var lexerStateAllocator = BumpPtrAllocator(slabSize: 256)

    fileprivate init(sourceBufferStart: Lexer.Cursor, cursor: Lexer.Cursor) {
      self.sourceBufferStart = sourceBufferStart
      self.cursor = cursor
      self.nextToken = self.cursor.nextToken(sourceBufferStart: self.sourceBufferStart, stateAllocator: lexerStateAllocator)
    }

    @_spi(Testing)
    public mutating func next() -> Lexer.Lexeme? {
      return self.advance()
    }

    mutating func advance() -> Lexer.Lexeme {
      defer {
        self.nextToken = self.cursor.nextToken(sourceBufferStart: self.sourceBufferStart, stateAllocator: lexerStateAllocator)
      }
      return self.nextToken
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
      let remainingText = self.nextToken.debugDescription + String(syntaxText: SyntaxText(baseAddress: self.cursor.input.baseAddress, count: self.cursor.input.count))
      if remainingText.count > 100 {
        return remainingText.prefix(100) + "..."
      } else {
        return remainingText
      }
    }

    #if SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION
    /// If `pointer` is in the source buffer of this `LexemeSequence`, return
    /// its offset, otherwise `nil`. Should only be used for the parser's
    /// alternate token introspection
    func offset(of pointer: UnsafePointer<UInt8>) -> Int? {
      let offset = pointer - self.sourceBufferStart.input.baseAddress!
      if offset <= self.sourceBufferStart.input.count {
        return offset
      } else {
        return nil
      }
    }
    #endif
  }

  @_spi(Testing)
  public static func tokenize(
    _ input: UnsafeBufferPointer<UInt8>,
    from startIndex: Int = 0
  ) -> LexemeSequence {
    precondition(input.isEmpty || startIndex < input.endIndex)
    let startChar = startIndex == input.startIndex ? UInt8(ascii: "\0") : input[startIndex - 1]
    let start = Cursor(input: input, previous: UInt8(ascii: "\0"))
    let cursor = Cursor(input: UnsafeBufferPointer(rebasing: input[startIndex...]), previous: startChar)
    return LexemeSequence(sourceBufferStart: start, cursor: cursor)
  }
}
