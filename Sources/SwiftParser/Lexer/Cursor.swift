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

extension SyntaxText {
  fileprivate func containsPlaceholderEnd() -> Bool {
    guard self.count >= 2 else {
      return false
    }

    for idx in 0..<(self.count - 1) {
      let c = self[idx]
      guard c != UInt8(ascii: "\n") else {
        return false
      }

      if self[idx] == UInt8(ascii: "#"), self[idx + 1] == UInt8(ascii: ">") {
        return true
      }
    }
    return false
  }
}

enum StringLiteralKind: Equatable {
  /// A normal single-line string literal started by `"`.
  case singleLine
  /// A multi-line string literal started by `"""`.
  case multiLine
  /// A string literal started by a single quote `'`.
  case singleQuote
}

extension Lexer.Cursor {
  /// Because the lexer lexes tokens lazily it doesn't carry any state in its
  /// current call stack. Instead, we model the lexer state by an explicit state
  /// stack.
  ///
  /// New entries in the state stack are added when:
  ///  - A string literal is entered
  ///  - A string interpolation inside is entered
  enum State {
    /// Normal top-level lexing mode
    case normal

    /// The lexer has lexed `delimiterLength` raw string delimiters '##' but not
    /// the string quote itself.
    case afterRawStringDelimiter(delimiterLength: Int)

    /// The lexer is inside a string literal of `kind` after having lexed
    /// `delimiterLength` raw string delimiters.
    case inStringLiteral(kind: StringLiteralKind, delimiterLength: Int)

    /// The lexer has finished lexing the contents of a string literal and is now
    /// looking for the closing quote.
    case afterStringLiteral(isRawString: Bool)

    /// The lexer has lexed the closing quote of a string literal that had raw
    /// string delimiters and is now looking for the closing raw string delimiters.
    case afterClosingStringQuote

    /// We are located either
    ///  - at the '\' of a string interpolation
    ///  - after the `\` of a string interpolation or
    ///  - after the pounds of a raw string interpolation `\#`.
    case inStringInterpolationStart(stringLiteralKind: StringLiteralKind)

    /// We are lexing the expressions inside a string interpolation and have seen
    /// `parenCount` parentheses that haven't been closed yet, not counting the
    /// `(` that opens the string interpolation.
    ///
    /// `stringInterpolationStart` points to the first character inside the interpolation.
    case inStringInterpolation(stringLiteralKind: StringLiteralKind, parenCount: Int)

    /// We have parsed a string interpolation segment and are now expecting the closing `)`.
    case afterStringInterpolation

    /// The mode in which leading trivia should be lexed for this state or `nil`
    /// if no trivia should be lexed.
    func leadingTriviaLexingMode(cursor: Lexer.Cursor) -> TriviaLexingMode? {
      switch self {
      case .normal: return .normal
      case .afterRawStringDelimiter: return nil
      case .inStringLiteral: return nil
      case .afterStringLiteral: return nil
      case .afterClosingStringQuote: return nil
      case .inStringInterpolationStart: return nil
      case .inStringInterpolation(let stringLiteralKind, _):
        // Single line strings cannot span multiple lines, so we don't want to
        // consume any newline inside a string interpolation either.
        switch stringLiteralKind {
        case .singleLine, .singleQuote: return .noNewlines
        case .multiLine: return .normal
        }
      case .afterStringInterpolation: return .normal
      }
    }

    /// The mode in which trailing trivia should be lexed for this state or `nil`
    /// if no trivia should be lexed.
    func trailingTriviaLexingMode(cursor: Lexer.Cursor) -> TriviaLexingMode? {
      switch self {
      case .normal: return .noNewlines
      case .afterRawStringDelimiter: return nil
      case .inStringLiteral: return nil
      case .afterStringLiteral: return nil
      case .afterClosingStringQuote: return nil
      case .inStringInterpolationStart: return nil
      case .inStringInterpolation: return .noNewlines
      case .afterStringInterpolation: return .noNewlines
      }
    }

    /// If `true`, this state should be popped when a `\n` or `\r` is seen during
    /// trailing trivia lexing.
    /// This allows us to terminate single line string literal lexing when
    /// hitting a newline.
    var shouldPopStateWhenReachingNewlineInTrailingTrivia: Bool {
      switch self {
      case .normal: return false
      case .afterRawStringDelimiter: return false
      case .inStringLiteral(kind: let stringLiteralKind, delimiterLength: _): return stringLiteralKind != .multiLine
      case .afterStringLiteral: return false
      case .afterClosingStringQuote: return false
      case .inStringInterpolationStart: return false
      case .inStringInterpolation: return false
      case .afterStringInterpolation: return false
      }
    }
  }

  /// A data structure that holds the state stack entries in the lexer. It is
  /// optimized for situations where there's at most one state on the stack
  /// (in addition to the bottom `normal` mode) and to not create any ARC
  /// traffic.
  ///
  /// It does this by representing the bottom `normal` state implicitly and
  /// storing one additional state inline. If the stack needs to contain more
  /// entries, the required memory is allocated in a bump allocator that is
  /// expected to outlive the stack.
  struct StateStack {
    private var topState: State? = nil
    private var stateStack: UnsafeBufferPointer<State>? = nil

    var currentState: State {
      return topState ?? .normal
    }

    mutating func perform(stateTransition: Lexer.StateTransition, stateAllocator: BumpPtrAllocator) {
      switch stateTransition {
      case .push(newState: let newState):
        if let topState = topState {
          if let stateStack = stateStack {
            let newStateStack = stateAllocator.allocate(State.self, count: stateStack.count + 1)
            let (_, existingStateStackEndIndex) = newStateStack.initialize(from: stateStack)
            newStateStack[existingStateStackEndIndex] = topState
            self.stateStack = UnsafeBufferPointer(newStateStack)
          } else {
            let newStateStack = stateAllocator.allocate(State.self, count: 1)
            newStateStack[0] = topState
            self.stateStack = UnsafeBufferPointer(newStateStack)
          }
        }
        topState = newState
      case .replace(newState: let newState):
        topState = newState
      case .pop:
        if let stateStack = stateStack {
          topState = stateStack.last!
          if stateStack.count == 1 {
            self.stateStack = nil
          } else {
            self.stateStack = UnsafeBufferPointer(start: stateStack.baseAddress, count: stateStack.count - 1)
          }
        } else {
          topState = nil
        }
      }
    }
  }

  /// An error that was discovered in a lexeme while lexing it.
  struct LexingDiagnostic {
    let kind: TokenDiagnostic.Kind
    /// The position in the token at which the diagnostic is.
    let position: Lexer.Cursor

    init(_ kind: TokenDiagnostic.Kind, position: Lexer.Cursor) {
      self.kind = kind
      self.position = position
    }

    func tokenDiagnostic(tokenStart: Lexer.Cursor) -> TokenDiagnostic {
      return TokenDiagnostic(kind, byteOffset: tokenStart.distance(to: position))
    }
  }
}

extension Lexer {
  /// A pointer into the input source text.
  ///
  /// A ``Lexer/Cursor`` contains the lexer's scanning and analysis interface.
  /// Lexing is afforded a single byte of look-behind that is carried by the
  /// cursor and updated when the cursor advances. A cursor is a safe interface
  /// to reading bytes from an input buffer: all accesses to its input are
  /// bounds-checked.
  struct Cursor {
    var input: UnsafeBufferPointer<UInt8>
    var previous: UInt8
    /// If we have already lexed a token, the kind of the previously lexed token
    var previousTokenKind: RawTokenKind?
    private var stateStack: StateStack = StateStack()

    init(input: UnsafeBufferPointer<UInt8>, previous: UInt8) {
      self.input = input
      self.previous = previous
      self.stateStack = StateStack()
    }

    var currentState: State {
      stateStack.currentState
    }

    mutating func perform(stateTransition: Lexer.StateTransition, stateAllocator: BumpPtrAllocator) {
      self.stateStack.perform(stateTransition: stateTransition, stateAllocator: stateAllocator)
    }

    public func starts<PossiblePrefix>(with possiblePrefix: PossiblePrefix) -> Bool
    where PossiblePrefix: Sequence, PossiblePrefix.Element == UInt8 {
      return self.input.starts(with: possiblePrefix)
    }

    var pointer: UnsafePointer<UInt8> {
      return self.input.baseAddress!
    }
    func distance(to other: Self) -> Int {
      return self.pointer.distance(to: other.pointer)
    }

    var isAtEndOfFile: Bool {
      return self.input.isEmpty
    }

    var isAtStartOfFile: Bool {
      return !self.input.isEmpty && self.previous == UInt8(ascii: "\0")
    }

    /// Debug function to print the remaining source text to be lexed.
    var debugRemainingText: SyntaxText {
      return SyntaxText(baseAddress: input.baseAddress, count: input.count)
    }
  }

  enum StateTransition {
    /// Push a new state onto the state stack
    case push(newState: Cursor.State)
    /// Replace the current state on the state stack by `newState`
    case replace(newState: Cursor.State)
    /// Pop a single state from the state stack.
    case pop
  }

  struct Result {
    let tokenKind: RawTokenKind
    let flags: Lexer.Lexeme.Flags
    /// The error kind and the cursor pointing to the character at which the
    /// diagnostic occurred.
    let error: Cursor.LexingDiagnostic?
    let stateTransition: StateTransition?
    /// If set, overritdes the trailing trivia lexing mode of the current state
    /// for this lexeme.
    let trailingTriviaLexingMode: Lexer.Cursor.TriviaLexingMode?

    init(
      _ tokenKind: RawTokenKind,
      flags: Lexer.Lexeme.Flags = [],
      error: Cursor.LexingDiagnostic? = nil,
      stateTransition: StateTransition? = nil,
      trailingTriviaLexingMode: Lexer.Cursor.TriviaLexingMode? = nil
    ) {
      self.tokenKind = tokenKind
      self.flags = flags
      self.error = error
      self.stateTransition = stateTransition
      self.trailingTriviaLexingMode = trailingTriviaLexingMode
    }
  }
}

// MARK: - Entry point

extension Lexer.Cursor {
  mutating func nextToken(sourceBufferStart: Lexer.Cursor, stateAllocator: BumpPtrAllocator) -> Lexer.Lexeme {
    let cursor = self
    // Leading trivia.
    let leadingTriviaStart = self
    let newlineInLeadingTrivia: NewlinePresence
    var diagnostic: TokenDiagnostic? = nil
    if let leadingTriviaMode = self.currentState.leadingTriviaLexingMode(cursor: self) {
      let triviaResult = self.lexTrivia(mode: leadingTriviaMode)
      newlineInLeadingTrivia = triviaResult.newlinePresence
      diagnostic = TokenDiagnostic(combining: diagnostic, triviaResult.error?.tokenDiagnostic(tokenStart: cursor))
    } else {
      newlineInLeadingTrivia = .absent
    }

    // Token text.
    let textStart = self

    let result: Lexer.Result
    switch currentState {
    case .normal:
      result = lexNormal(sourceBufferStart: sourceBufferStart)
    case .afterRawStringDelimiter(delimiterLength: let delimiterLength):
      result = lexAfterRawStringDelimiter(delimiterLength: delimiterLength)
    case .inStringLiteral(kind: let stringLiteralKind, delimiterLength: let delimiterLength):
      result = lexInStringLiteral(stringLiteralKind: stringLiteralKind, delimiterLength: delimiterLength)
    case .afterStringLiteral(isRawString: _):
      result = lexAfterStringLiteral()
    case .afterClosingStringQuote:
      result = lexAfterClosingStringQuote()
    case .inStringInterpolationStart(stringLiteralKind: let stringLiteralKind):
      result = lexInStringInterpolationStart(stringLiteralKind: stringLiteralKind)
    case .inStringInterpolation(stringLiteralKind: let stringLiteralKind, parenCount: let parenCount):
      result = lexInStringInterpolation(stringLiteralKind: stringLiteralKind, parenCount: parenCount, sourceBufferStart: sourceBufferStart)
    case .afterStringInterpolation:
      result = lexAfterStringInterpolation()
    }

    if let stateTransition = result.stateTransition {
      self.stateStack.perform(stateTransition: stateTransition, stateAllocator: stateAllocator)
    }

    // Trailing trivia.
    let trailingTriviaStart = self
    if let trailingTriviaMode = result.trailingTriviaLexingMode ?? currentState.trailingTriviaLexingMode(cursor: self) {
      let triviaResult = self.lexTrivia(mode: trailingTriviaMode)
      diagnostic = TokenDiagnostic(combining: diagnostic, triviaResult.error?.tokenDiagnostic(tokenStart: cursor))
    }

    if self.currentState.shouldPopStateWhenReachingNewlineInTrailingTrivia && self.is(at: "\r", "\n") {
      self.stateStack.perform(stateTransition: .pop, stateAllocator: stateAllocator)
    }

    var flags = result.flags
    if newlineInLeadingTrivia == .present {
      flags.insert(.isAtStartOfLine)
    }

    self.previousTokenKind = result.tokenKind
    diagnostic = TokenDiagnostic(combining: diagnostic, result.error?.tokenDiagnostic(tokenStart: cursor))

    return .init(
      tokenKind: result.tokenKind,
      flags: flags,
      diagnostic: diagnostic,
      start: leadingTriviaStart.pointer,
      leadingTriviaLength: leadingTriviaStart.distance(to: textStart),
      textLength: textStart.distance(to: trailingTriviaStart),
      trailingTriviaLength: trailingTriviaStart.distance(to: self),
      cursor: cursor
    )
  }

}

// MARK: - Peeking

/// Essentially a UInt8 that is expressible by integer and string literals.
struct CharacterByte: ExpressibleByUnicodeScalarLiteral, ExpressibleByIntegerLiteral {
  let value: UInt8

  init(unicodeScalarLiteral value: Unicode.Scalar) {
    self.value = UInt8(ascii: Unicode.Scalar(unicodeScalarLiteral: value))
  }

  init(integerLiteral value: UInt8) {
    self.value = value
  }
}

extension Lexer.Cursor {
  func peek(at offset: Int = 0) -> UInt8? {
    assert(offset >= 0)
    guard offset < self.input.count else {
      return nil
    }
    return self.input[offset]
  }

  /// Same as `advanceValidatingUTF8Character` but without advancing the cursor.
  func peekScalar() -> Unicode.Scalar? {
    var tmp = self
    return tmp.advanceValidatingUTF8Character()
  }

  /// Peeks back `offset` bytes.
  /// `bufferBegin` is the start of the source file buffer to guard that we are
  /// not dereferencing a pointer that points before the source buffer.
  func peekBack(by offset: Int, bufferBegin: Lexer.Cursor) -> UInt8? {
    guard let bufferBaseAddress = bufferBegin.input.baseAddress,
      let selfBaseAddress = self.input.baseAddress
    else {
      return nil
    }
    guard bufferBaseAddress <= selfBaseAddress - offset else {
      return nil
    }
    return selfBaseAddress.advanced(by: -offset).pointee
  }

  // MARK: Positive matches

  /// Returns `true` if we are not at the end of the file and the character at
  /// offset `offset` is `character`.
  func `is`(offset: Int = 0, at character: CharacterByte) -> Bool {
    guard let peeked = self.peek(at: offset) else {
      return false
    }
    return peeked == character.value
  }

  /// Returns `true` if we are not at the end of the file and the character at
  /// offset `offset` is `character1` or `character2`.
  func `is`(offset: Int = 0, at character1: CharacterByte, _ character2: CharacterByte) -> Bool {
    guard let peeked = self.peek(at: offset) else {
      return false
    }
    return peeked == character1.value || peeked == character2.value
  }

  /// Returns `true` if we are not at the end of the file and the character at
  /// offset `offset` is `character1`, `character2`, or `character3`.
  func `is`(offset: Int = 0, at character1: CharacterByte, _ character2: CharacterByte, _ character3: CharacterByte) -> Bool {
    guard let peeked = self.peek(at: offset) else {
      return false
    }
    return peeked == character1.value || peeked == character2.value || peeked == character3.value
  }

  // MARK: Negative matches

  /// Returns `true` if we are not at the end of the file and the character at
  /// offset `offset` is not `character`.
  func `is`(offset: Int = 0, notAt character: CharacterByte) -> Bool {
    guard let peeked = self.peek(at: offset) else {
      return false
    }
    return peeked != character.value
  }

  /// Returns `true` if we are not at the end of the file and the character at
  /// offset `offset` is neither `character1` nor `character2`.
  func `is`(offset: Int = 0, notAt character1: CharacterByte, _ character2: CharacterByte) -> Bool {
    guard let peeked = self.peek(at: offset) else {
      return false
    }
    return peeked != character1.value && peeked != character2.value
  }

  /// Returns `true` if we are not at the end of the file and the character at
  /// offset `offset` is neither `character1` nor `character2` nor `character3`.
  func `is`(offset: Int = 0, notAt character1: CharacterByte, _ character2: CharacterByte, _ character3: CharacterByte) -> Bool {
    guard let peeked = self.peek(at: offset) else {
      return false
    }
    return peeked != character1.value && peeked != character2.value && peeked != character3.value
  }

  // MARK: Misc

  /// Returns the text from `self` to `other`.
  func text(upTo other: Lexer.Cursor) -> SyntaxText {
    let count = other.input.baseAddress! - self.input.baseAddress!
    assert(count >= 0)
    return SyntaxText(baseAddress: self.input.baseAddress, count: count)
  }
}

// MARK: - Advancing the cursor

extension Lexer.Cursor {
  /// If there is a character in the input, and return it, advancing the cursor.
  /// If the end of the input is reached, return `nil`.
  mutating func advance() -> UInt8? {
    var input = self.input[...]
    guard let c = input.popFirst() else {
      return nil  // end of input
    }
    self.previous = c
    self.input = UnsafeBufferPointer(rebasing: input)
    return c
  }

  /// If the current character is `matching`, advance the cursor and return `true`.
  /// Otherwise, this is a no-op and returns `false`.
  mutating func advance(matching: CharacterByte) -> Bool {
    if self.is(at: matching) {
      _ = self.advance()
      return true
    } else {
      return false
    }
  }

  /// If the current character is `matching`, advance the cursor and return `true`.
  /// Otherwise, this is a no-op and returns `false`.
  mutating func advance(matching character1: CharacterByte, _ character2: CharacterByte) -> Bool {
    if self.is(at: character1) || self.is(at: character2) {
      _ = self.advance()
      return true
    } else {
      return false
    }
  }

  /// If the current character is in `matching`, advance the cursor and return `true`.
  /// Otherwise, this is a no-op and returns `false`.
  @_disfavoredOverload  // favor the stamped out copies
  mutating func advance(matching characters: CharacterByte...) -> Bool {
    if characters.contains(where: { self.is(at: $0) }) {
      _ = self.advance()
      return true
    } else {
      return false
    }
  }

  /// If the current character matches `predicate`, consume it and return `true`.
  /// Otherwise, this is a no-op and returns `false`.
  mutating func advance(if predicate: (Unicode.Scalar) -> Bool) -> Bool {
    guard !self.isAtEndOfFile else {
      return false
    }

    var tmp = self
    guard let c = tmp.advanceValidatingUTF8Character() else {
      return false
    }

    if predicate(c) {
      self = tmp
      return true
    } else {
      return false
    }
  }

  /// Advance the cursor while `predicate` is satsified.
  mutating func advance(while predicate: (Unicode.Scalar) -> Bool) {
    while self.advance(if: predicate) {}
  }

  /// Advance the cursor to the end of the current line.
  mutating func advanceToEndOfLine() {
    while self.is(notAt: "\n", "\r") {
      _ = self.advance()
    }
  }

  /// Returns `true` if the comment spaned multiple lines and `false` otherwise.
  /// Assumes that the curser is currently pointing at the `*` of the opening `/*`.
  mutating func advanceToEndOfSlashStarComment() -> Bool {
    assert(self.previous == UInt8(ascii: "/"))
    // Make sure to advance over the * so that we don't incorrectly handle /*/ as
    // the beginning and end of the comment.
    let consumedStar = self.advance(matching: "*")
    assert(consumedStar)

    var depth = 1
    var isMultiline = false

    while true {
      switch self.advance() {
      case UInt8(ascii: "*"):
        // Check for a '*/'
        if self.advance(matching: "/") {
          depth -= 1
          if depth == 0 {
            return isMultiline
          }
        }
      case UInt8(ascii: "/"):
        // Check for a '/*'
        if self.advance(matching: "*") {
          depth += 1
        }

      case UInt8(ascii: "\n"), UInt8(ascii: "\r"):
        isMultiline = true
        continue
      case nil:
        return isMultiline
      case .some:
        continue
      }
    }
  }

  /// If this is the opening delimiter of a raw string literal, return the number
  /// of `#` in the raw string delimiter.
  /// Assumes that the parser is currently pointing at the first `#`.
  mutating func advanceIfOpeningRawStringDelimiter() -> Int? {
    assert(self.is(at: "#"))

    var tmp = self
    var length = 0
    while tmp.advance(matching: "#") {
      length += 1
    }

    if tmp.is(at: #"""#) {
      self = tmp
      return length
    }
    return nil
  }

  /// If this is the opening delimiter of a raw string literal, return the number
  /// of `#` in the raw string delimiter.
  /// Assumes that the parser is currently pointing at the character after the first `#`.
  /// In other words, the first `#` is expected to already be consumed.
  mutating func legacyAdvanceIfOpeningRawStringDelimiter() -> Int? {
    assert(self.previous == UInt8(ascii: "#"))

    var tmp = self
    var length = 1
    while tmp.advance(matching: "#") {
      length += 1
    }

    if tmp.is(at: #"""#) {
      self = tmp
      return length
    }
    return nil
  }

  /// If we are positioned at the start of a multiline string delimiter, consume
  /// that delimiter and return `true`, otherwise return `false`.
  ///
  /// Assumes that the lexer is currently pointing at the character after the first `"`.
  /// In other words, the `"` is expected to already be consumed.
  ///
  /// `openingRawStringDelimiters` are the number of `#` that are preceeding the `"`.
  /// This is used to disambiguate e.g. `#"""#` as a single-line string literal.
  /// If we are looking for the closing `"""` of a string literal, this is `nil`.
  mutating func advanceIfMultilineStringDelimiter(
    openingRawStringDelimiters: Int?
  ) -> Bool {
    assert(self.previous == UInt8(ascii: #"""#))
    // Test for single-line string literals that resemble multiline delimiter.
    var sameLineCloseCheck = self
    _ = sameLineCloseCheck.advance()
    if let openingRawStringDelimiters = openingRawStringDelimiters, openingRawStringDelimiters != 0 {
      // Scan if the current line contains `"` followed by `openingRawStringDelimiters` `#` characters
      while sameLineCloseCheck.is(notAt: "\r", "\n") {
        if sameLineCloseCheck.advance(matching: #"""#) {
          if sameLineCloseCheck.advanceIfStringDelimiter(delimiterLength: openingRawStringDelimiters) {
            // The string literal is being terminated on a single line. Not a multi-line string literal.
            return false
          }
        } else {
          _ = sameLineCloseCheck.advance()
        }
      }
    }

    var tmp = self
    if tmp.advance(matching: #"""#) && tmp.advance(matching: #"""#) {
      self = tmp
      return true
    }

    return false
  }

  /// Read a single UTF-8 scalar, which may span multiple bytes.
  /// Returns `nil` if
  ///  - The cursor is at the end of the buffer or reaches the end of the buffer
  ///    while reading the character
  ///  - The cursor is currently placed at an invalid UTF-8 byte sequence. In
  ///    that case bytes are consumed until we reach the next start of a UTF-8
  ///    character.
  mutating func advanceValidatingUTF8Character() -> Unicode.Scalar? {
    return Unicode.Scalar.lexing(advance: { self.advance() }, peek: { self.peek(at: 0) })
  }

  /// Rever the lexer by `offset` bytes. This should only be used by `resetForSplit`.
  /// This must not back up by more bytes than the last token because that would
  /// require us to also update `previousTokenKind`, which we don't do in this
  /// function
  mutating func backUp(by offset: Int) {
    assert(!self.isAtStartOfFile)
    self.previous = self.input.baseAddress!.advanced(by: -(offset + 1)).pointee
    self.input = UnsafeBufferPointer(start: self.input.baseAddress!.advanced(by: -offset), count: self.input.count + offset)
  }
}

// MARK: - Boundness of operators

extension Lexer.Cursor {
  /// `bufferBegin` is a cursor that points to the start of the source file that
  /// is being lexed.
  func isLeftBound(sourceBufferStart: Lexer.Cursor) -> Bool {
    // The first character in the file is not left-bound.
    if self.input.baseAddress == sourceBufferStart.input.baseAddress {
      return false
    }

    switch self.previous {
    case UInt8(ascii: " "), UInt8(ascii: "\r"), UInt8(ascii: "\n"), UInt8(ascii: "\t"),  // whitespace
      UInt8(ascii: "("), UInt8(ascii: "["), UInt8(ascii: "{"),  // opening delimiters
      UInt8(ascii: ","), UInt8(ascii: ";"), UInt8(ascii: ":"),  // expression separators
      0:  // whitespace / last char in file
      return false
    case UInt8(ascii: "/"):
      if self.peekBack(by: 2, bufferBegin: sourceBufferStart) == UInt8(ascii: "*") {
        return false  // End of a slash-star comment, so whitespace.
      } else {
        return true
      }
    case 0xA0:
      if self.peekBack(by: 2, bufferBegin: sourceBufferStart) == 0xC2 {
        return false  // End of a Non-breaking whitespace (U+00A0).
      } else {
        return true
      }
    default:
      return true
    }
  }

  func isRightBound(isLeftBound: Bool) -> Bool {
    switch self.peek() {
    case UInt8(ascii: " "), UInt8(ascii: "\r"), UInt8(ascii: "\n"), UInt8(ascii: "\t"),  // whitespace
      UInt8(ascii: ")"), UInt8(ascii: "]"), UInt8(ascii: "}"),  // closing delimiters
      UInt8(ascii: ","), UInt8(ascii: ";"), UInt8(ascii: ":"):  // expression separators
      return false

    case 0:
      //        if (tokEnd == codeCompletionPtr) {         // code-completion
      //          return true
      //        }
      return false  // whitespace / last char in file

    case UInt8(ascii: "."):
      // Prefer the '^' in "x^.y" to be a postfix op, not binary, but the '^' in
      // "^.y" to be a prefix op, not binary.
      return !isLeftBound

    case UInt8(ascii: "/"):
      // A following comment counts as whitespace, so this token is not right bound.
      if (self.is(offset: 1, at: "/", "*")) {
        return false
      } else {
        return true
      }
    case 0xC2:
      if self.is(offset: 1, at: 0xA0) {
        return false  // Non-breaking whitespace (U+00A0)
      } else {
        return true
      }
    case nil:
      return false  // last char in file
    default:
      return true
    }
  }
}

// MARK: - Main entry point

extension Lexer.Cursor {
  private mutating func lexNormal(sourceBufferStart: Lexer.Cursor) -> Lexer.Result {
    switch self.peek() {
    case UInt8(ascii: "@"): _ = self.advance(); return Lexer.Result(.atSign)
    case UInt8(ascii: "{"): _ = self.advance(); return Lexer.Result(.leftBrace)
    case UInt8(ascii: "["): _ = self.advance(); return Lexer.Result(.leftSquareBracket)
    case UInt8(ascii: "("): _ = self.advance(); return Lexer.Result(.leftParen)
    case UInt8(ascii: "}"): _ = self.advance(); return Lexer.Result(.rightBrace)
    case UInt8(ascii: "]"): _ = self.advance(); return Lexer.Result(.rightSquareBracket)
    case UInt8(ascii: ")"): _ = self.advance(); return Lexer.Result(.rightParen)

    case UInt8(ascii: ","): _ = self.advance(); return Lexer.Result(.comma)
    case UInt8(ascii: ";"): _ = self.advance(); return Lexer.Result(.semicolon)
    case UInt8(ascii: ":"): _ = self.advance(); return Lexer.Result(.colon)
    case UInt8(ascii: "\\"): _ = self.advance(); return Lexer.Result(.backslash)

    case UInt8(ascii: "#"):
      // Try lex a raw string literal.
      if let delimiterLength = self.advanceIfOpeningRawStringDelimiter() {
        return Lexer.Result(.rawStringDelimiter, stateTransition: .push(newState: .afterRawStringDelimiter(delimiterLength: delimiterLength)))
      }

      // Try lex a regex literal.
      if let token = self.tryLexRegexLiteral(sourceBufferStart: sourceBufferStart) {
        return Lexer.Result(token)
      }
      // Otherwise try lex a magic pound literal.
      return self.lexMagicPoundLiteral()
    case UInt8(ascii: "/"):
      // Try lex a regex literal.
      if let token = self.tryLexRegexLiteral(sourceBufferStart: sourceBufferStart) {
        return Lexer.Result(token)
      }

      // Otherwise try lex a magic pound literal.
      return self.lexOperatorIdentifier(sourceBufferStart: sourceBufferStart)
    case UInt8(ascii: "!"):
      if self.isLeftBound(sourceBufferStart: sourceBufferStart) {
        _ = self.advance()
        return Lexer.Result(.exclamationMark)
      }
      return self.lexOperatorIdentifier(sourceBufferStart: sourceBufferStart)

    case UInt8(ascii: "?"):
      if self.isLeftBound(sourceBufferStart: sourceBufferStart) {
        _ = self.advance()
        return Lexer.Result(.postfixQuestionMark)
      }
      return self.lexOperatorIdentifier(sourceBufferStart: sourceBufferStart)

    case UInt8(ascii: "<"):
      if self.is(offset: 1, at: "#") {
        return self.tryLexEditorPlaceholder(sourceBufferStart: sourceBufferStart)
      }
      return self.lexOperatorIdentifier(sourceBufferStart: sourceBufferStart)
    case UInt8(ascii: ">"):
      return self.lexOperatorIdentifier(sourceBufferStart: sourceBufferStart)

    case UInt8(ascii: "="), UInt8(ascii: "-"), UInt8(ascii: "+"),
      UInt8(ascii: "*"), UInt8(ascii: "%"), UInt8(ascii: "&"),
      UInt8(ascii: "|"), UInt8(ascii: "^"), UInt8(ascii: "~"),
      UInt8(ascii: "."):
      return self.lexOperatorIdentifier(sourceBufferStart: sourceBufferStart)
    case UInt8(ascii: "A"), UInt8(ascii: "B"), UInt8(ascii: "C"),
      UInt8(ascii: "D"), UInt8(ascii: "E"), UInt8(ascii: "F"),
      UInt8(ascii: "G"), UInt8(ascii: "H"), UInt8(ascii: "I"),
      UInt8(ascii: "J"), UInt8(ascii: "K"), UInt8(ascii: "L"),
      UInt8(ascii: "M"), UInt8(ascii: "N"), UInt8(ascii: "O"),
      UInt8(ascii: "P"), UInt8(ascii: "Q"), UInt8(ascii: "R"),
      UInt8(ascii: "S"), UInt8(ascii: "T"), UInt8(ascii: "U"),
      UInt8(ascii: "V"), UInt8(ascii: "W"), UInt8(ascii: "X"),
      UInt8(ascii: "Y"), UInt8(ascii: "Z"),
      UInt8(ascii: "a"), UInt8(ascii: "b"), UInt8(ascii: "c"),
      UInt8(ascii: "d"), UInt8(ascii: "e"), UInt8(ascii: "f"),
      UInt8(ascii: "g"), UInt8(ascii: "h"), UInt8(ascii: "i"),
      UInt8(ascii: "j"), UInt8(ascii: "k"), UInt8(ascii: "l"),
      UInt8(ascii: "m"), UInt8(ascii: "n"), UInt8(ascii: "o"),
      UInt8(ascii: "p"), UInt8(ascii: "q"), UInt8(ascii: "r"),
      UInt8(ascii: "s"), UInt8(ascii: "t"), UInt8(ascii: "u"),
      UInt8(ascii: "v"), UInt8(ascii: "w"), UInt8(ascii: "x"),
      UInt8(ascii: "y"), UInt8(ascii: "z"),
      UInt8(ascii: "_"):
      return self.lexIdentifier()

    case UInt8(ascii: "$"):
      return self.lexDollarIdentifier()

    case UInt8(ascii: "0"), UInt8(ascii: "1"), UInt8(ascii: "2"),
      UInt8(ascii: "3"), UInt8(ascii: "4"), UInt8(ascii: "5"),
      UInt8(ascii: "6"), UInt8(ascii: "7"), UInt8(ascii: "8"),
      UInt8(ascii: "9"):
      return self.lexNumber()
    case UInt8(ascii: #"'"#), UInt8(ascii: #"""#):
      return self.lexStringQuote(isOpening: true, leadingDelimiterLength: 0)

    case UInt8(ascii: "`"):
      return self.lexEscapedIdentifier()
    case nil:
      return Lexer.Result(.eof)
    default:
      var tmp = self
      if tmp.advance(if: { Unicode.Scalar($0).isValidIdentifierStartCodePoint }) {
        return self.lexIdentifier()
      }

      if tmp.advance(if: { Unicode.Scalar($0).isOperatorStartCodePoint }) {
        return self.lexOperatorIdentifier(sourceBufferStart: sourceBufferStart)
      }

      switch self.lexUnknown() {
      case .lexemeContents(let result):
        return result
      case .trivia:
        assertionFailure("Invalid UTF-8 sequence should be eaten by lexTrivia as LeadingTrivia")
        return Lexer.Result(.unknown, error: LexingDiagnostic(.invalidUtf8, position: self))
      }
    }
  }

  private mutating func lexAfterRawStringDelimiter(delimiterLength: Int) -> Lexer.Result {
    switch self.peek() {
    case UInt8(ascii: #"'"#), UInt8(ascii: #"""#):
      return self.lexStringQuote(isOpening: true, leadingDelimiterLength: delimiterLength)
    case nil:
      return Lexer.Result(.eof)
    default:
      preconditionFailure("state 'afterRawStringDelimiter' expects to be positioned at a quote")
    }
  }

  private mutating func lexAfterStringLiteral() -> Lexer.Result {
    switch self.peek() {
    case UInt8(ascii: #"'"#), UInt8(ascii: #"""#):
      return self.lexStringQuote(isOpening: false, leadingDelimiterLength: 0)
    case nil:
      return Lexer.Result(.eof)
    default:
      preconditionFailure("state 'isAfterStringLiteral' expects to be positioned at a quote")
    }
  }

  private mutating func lexAfterClosingStringQuote() -> Lexer.Result {
    switch self.peek() {
    case UInt8(ascii: "#"):
      self.advance(while: { $0 == Unicode.Scalar("#") })
      return Lexer.Result(.rawStringDelimiter, stateTransition: .pop)
    case nil:
      return Lexer.Result(.eof)
    default:
      preconditionFailure("state 'afterClosingStringQuote' expects to be positioned at a '#'")
    }
  }

  private mutating func lexInStringInterpolationStart(stringLiteralKind: StringLiteralKind) -> Lexer.Result {
    switch self.peek() {
    case UInt8(ascii: "\\"):
      _ = self.advance()
      return Lexer.Result(.backslash)
    case UInt8(ascii: "#"):
      /// Consume the '#' that are part of this interpolation. We know that the
      /// number of '#' is correct because otherwise `isAtStringInterpolationAnchor`
      /// would have returned false in `lexInStringLiteral` and w we wouldn't have
      /// transitioned to the `afterBackslashOfStringInterpolation` state.
      self.advance(while: { $0 == Unicode.Scalar("#") })
      return Lexer.Result(.rawStringDelimiter)
    case UInt8(ascii: "("):
      _ = self.advance()
      return Lexer.Result(.leftParen, stateTransition: .replace(newState: .inStringInterpolation(stringLiteralKind: stringLiteralKind, parenCount: 0)))
    case nil:
      return Lexer.Result(.eof)
    default:
      preconditionFailure("state 'afterBackslashOfStringInterpolation' expects to be positioned at '#' or '('")
    }
  }

  private mutating func lexInStringInterpolation(stringLiteralKind: StringLiteralKind, parenCount: Int, sourceBufferStart: Lexer.Cursor) -> Lexer.Result {
    // Keep track of open parentheses
    switch self.peek() {
    case UInt8(ascii: "("):
      _ = self.advance()
      return Lexer.Result(.leftParen, stateTransition: .replace(newState: .inStringInterpolation(stringLiteralKind: stringLiteralKind, parenCount: parenCount + 1)))
    case UInt8(ascii: ")"):
      _ = self.advance()
      if parenCount == 0 {
        return Lexer.Result(.rightParen, stateTransition: .pop)
      } else {
        return Lexer.Result(.rightParen, stateTransition: .replace(newState: .inStringInterpolation(stringLiteralKind: stringLiteralKind, parenCount: parenCount - 1)))
      }
    case UInt8(ascii: "\r"), UInt8(ascii: "\n"):
      // We don't eat newlines as leading trivia in string interpolation of
      // single line strings but  `lexNormal` expects newlines to already be
      // eaten. If we reach a newline inside string interpolation of a
      // single-line string, emit an empty string segment to indicate to the
      // parser that the string has ended and pop out of string interpolation.
      assert(stringLiteralKind != .multiLine)
      return Lexer.Result(.stringSegment, stateTransition: .pop)
    default:
      // If we haven't reached the end of the string interpolation, lex as if we were in a normal expression.
      return self.lexNormal(sourceBufferStart: sourceBufferStart)
    }
  }

  private mutating func lexAfterStringInterpolation() -> Lexer.Result {
    switch self.peek() {
    case UInt8(ascii: ")"):
      _ = self.advance()
      return Lexer.Result(.rightParen, stateTransition: .pop)
    case nil:
      return Lexer.Result(.eof)
    default:
      preconditionFailure("state 'isAfterStringInterpolation' expects to be positoned at ')'")
    }
  }
}

// MARK: - Trivia

extension Lexer.Cursor {
  fileprivate enum NewlinePresence {
    case absent
    case present
  }

  enum TriviaLexingMode {
    /// Lex all trivia
    case normal
    /// Don't lex newlines (`\r` and `\r`) as trivia
    case noNewlines
    /// Lex the characters that escape a newline in a multi-line string literal
    /// as trivia.
    ///
    /// Matches the following regex: `\\?#*[ \t]*(\r\n|\r|\n)
    case escapedNewlineInMultiLineStringLiteral
  }

  fileprivate struct TriviaResult {
    let newlinePresence: NewlinePresence
    let error: LexingDiagnostic?
  }

  fileprivate mutating func lexTrivia(mode: TriviaLexingMode) -> TriviaResult {
    var newlinePresence = NewlinePresence.absent
    var error: LexingDiagnostic? = nil
    if mode == .escapedNewlineInMultiLineStringLiteral {
      _ = self.advance(matching: "\\")
      self.advance(while: { $0 == "#" })
      self.advance(while: { $0 == " " || $0 == "\t" })
      if self.advance(matching: "\r") {
        _ = self.advance(matching: "\n")
        return TriviaResult(newlinePresence: .present, error: nil)
      } else if self.advance(matching: "\n") {
        return TriviaResult(newlinePresence: .present, error: nil)
      } else {
        return TriviaResult(newlinePresence: .absent, error: nil)
      }
    }

    while true {
      let start = self

      switch self.advance() {
      // 'continue' - the character is a part of the trivia.
      // 'break' - the character should a part of token text.
      case nil:
        break
      case UInt8(ascii: "\n"):
        if mode == .noNewlines {
          break
        }
        newlinePresence = .present
        continue
      case UInt8(ascii: "\r"):
        if mode == .noNewlines {
          break
        }
        newlinePresence = .present
        continue

      case UInt8(ascii: " "):
        continue
      case UInt8(ascii: "\t"):
        continue
      case UInt8(ascii: "\u{000B}"):
        continue
      case UInt8(ascii: "\u{000C}"):
        continue
      case UInt8(ascii: "/"):
        switch self.peek() {
        case UInt8(ascii: "/"):
          self.advanceToEndOfLine()
          continue
        case UInt8(ascii: "*"):
          _ = self.advanceToEndOfSlashStarComment()
          continue
        default:
          break
        }
      case UInt8(ascii: "#"):
        guard start.isAtStartOfFile, self.advance(if: { $0 == "!" }) else {
          break
        }
        self.advanceToEndOfLine()
        continue
      case UInt8(ascii: "<"), UInt8(ascii: ">"):
        if self.tryLexConflictMarker(start: start) {
          error = LexingDiagnostic(.sourceConflictMarker, position: start)
          continue
        }
      // Start character of tokens.
      //        case (char)-1: case (char)-2:
      case  // Punctuation.
      UInt8(ascii: "{"), UInt8(ascii: "["), UInt8(ascii: "("),
        UInt8(ascii: "}"), UInt8(ascii: "]"), UInt8(ascii: ")"),
        UInt8(ascii: "@"), UInt8(ascii: ","), UInt8(ascii: ";"),
        UInt8(ascii: ":"), UInt8(ascii: "\\"), UInt8(ascii: "$"),

        // Start of integer/hex/float literals.
        UInt8(ascii: "0"), UInt8(ascii: "1"), UInt8(ascii: "2"),
        UInt8(ascii: "3"), UInt8(ascii: "4"), UInt8(ascii: "5"),
        UInt8(ascii: "6"), UInt8(ascii: "7"), UInt8(ascii: "8"),
        UInt8(ascii: "9"),

        // Start of literals.
        UInt8(ascii: #"""#), UInt8(ascii: #"'"#), UInt8(ascii: "`"),

        // Start of identifiers.
        UInt8(ascii: "A"), UInt8(ascii: "B"), UInt8(ascii: "C"),
        UInt8(ascii: "D"), UInt8(ascii: "E"), UInt8(ascii: "F"),
        UInt8(ascii: "G"), UInt8(ascii: "H"), UInt8(ascii: "I"),
        UInt8(ascii: "J"), UInt8(ascii: "K"), UInt8(ascii: "L"),
        UInt8(ascii: "M"), UInt8(ascii: "N"), UInt8(ascii: "O"),
        UInt8(ascii: "P"), UInt8(ascii: "Q"), UInt8(ascii: "R"),
        UInt8(ascii: "S"), UInt8(ascii: "T"), UInt8(ascii: "U"),
        UInt8(ascii: "V"), UInt8(ascii: "W"), UInt8(ascii: "X"),
        UInt8(ascii: "Y"), UInt8(ascii: "Z"),
        UInt8(ascii: "a"), UInt8(ascii: "b"), UInt8(ascii: "c"),
        UInt8(ascii: "d"), UInt8(ascii: "e"), UInt8(ascii: "f"),
        UInt8(ascii: "g"), UInt8(ascii: "h"), UInt8(ascii: "i"),
        UInt8(ascii: "j"), UInt8(ascii: "k"), UInt8(ascii: "l"),
        UInt8(ascii: "m"), UInt8(ascii: "n"), UInt8(ascii: "o"),
        UInt8(ascii: "p"), UInt8(ascii: "q"), UInt8(ascii: "r"),
        UInt8(ascii: "s"), UInt8(ascii: "t"), UInt8(ascii: "u"),
        UInt8(ascii: "v"), UInt8(ascii: "w"), UInt8(ascii: "x"),
        UInt8(ascii: "y"), UInt8(ascii: "z"),
        UInt8(ascii: "_"),

        // Start of operators.
        UInt8(ascii: "%"), UInt8(ascii: "!"), UInt8(ascii: "?"),
        UInt8(ascii: "="), UInt8(ascii: "-"), UInt8(ascii: "+"),
        UInt8(ascii: "*"), UInt8(ascii: "&"), UInt8(ascii: "|"),
        UInt8(ascii: "^"), UInt8(ascii: "~"), UInt8(ascii: "."):
        break
      case 0xEF:
        if self.is(at: 0xBB), self.is(offset: 1, at: 0xBF) {
          // BOM marker.
          _ = self.advance()
          _ = self.advance()
          continue
        }

        fallthrough
      default:
        if let peekedScalar = start.peekScalar(), peekedScalar.isValidIdentifierStartCodePoint {
          break
        }
        if let peekedScalar = start.peekScalar(), peekedScalar.isOperatorStartCodePoint {
          break
        }

        // `lexUnknown` expects that the first character has not been consumed yet.
        self = start
        if case .trivia(let unknownError) = self.lexUnknown() {
          error = error ?? unknownError
          continue
        } else {
          break
        }
      }

      // `break` means the character was not a trivia. Reset the cursor and
      // return the result.
      self = start
      return TriviaResult(newlinePresence: newlinePresence, error: error)
    }
  }
}

// MARK: - Literals

extension Lexer.Cursor {
  /// lexNumber:
  ///   integer_literal  ::= [0-9][0-9_]*
  ///   integer_literal  ::= 0x[0-9a-fA-F][0-9a-fA-F_]*
  ///   integer_literal  ::= 0o[0-7][0-7_]*
  ///   integer_literal  ::= 0b[01][01_]*
  ///   floating_literal ::= [0-9][0-9]_*\.[0-9][0-9_]*
  ///   floating_literal ::= [0-9][0-9]*\.[0-9][0-9_]*[eE][+-]?[0-9][0-9_]*
  ///   floating_literal ::= [0-9][0-9_]*[eE][+-]?[0-9][0-9_]*
  ///   floating_literal ::= 0x[0-9A-Fa-f][0-9A-Fa-f_]*
  ///                          (\.[0-9A-Fa-f][0-9A-Fa-f_]*)?[pP][+-]?[0-9][0-9_]*
  mutating func lexNumber() -> Lexer.Result {
    assert(self.peek().map(Unicode.Scalar.init)?.isDigit == true, "Unexpected start")

    if self.is(at: "0") && self.is(offset: 1, at: "x") {
      return self.lexHexNumber()
    }

    if self.is(at: "0") && self.is(offset: 1, at: "o") {
      // 0o[0-7][0-7_]*

      let zeroConsumed = self.advance(matching: "0")  // Consume '0'
      let oConsumed = self.advance(matching: "o")  // Consome 'o'
      assert(zeroConsumed && oConsumed)
      if let peeked = self.peek(), peeked < UInt8(ascii: "0") || peeked > UInt8(ascii: "7") {
        let errorPos = self
        self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
        return Lexer.Result(
          .integerLiteral,
          error: LexingDiagnostic(.invalidOctalDigitInIntegerLiteral, position: errorPos)
        )
      }

      self.advance(while: {
        ($0 >= Unicode.Scalar("0") && $0 <= Unicode.Scalar("7")) || $0 == Unicode.Scalar("_")
      })

      let tmp = self
      if self.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
        let errorPos = tmp
        self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
        return Lexer.Result(
          .integerLiteral,
          error: LexingDiagnostic(.invalidOctalDigitInIntegerLiteral, position: errorPos)
        )
      }

      return Lexer.Result(.integerLiteral)
    }

    if self.is(at: "0") && self.is(offset: 1, at: "b") {
      // 0b[01][01_]*
      let zeroConsumed = self.advance(matching: "0")  // Consume '0'
      let bConsumed = self.advance(matching: "b")  // Consume 'b'
      assert(zeroConsumed && bConsumed)
      if self.is(notAt: "0", "1") {
        let errorPos = self
        self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
        return Lexer.Result(
          .integerLiteral,
          error: LexingDiagnostic(.invalidBinaryDigitInIntegerLiteral, position: errorPos)
        )
      }

      self.advance(while: {
        $0 == Unicode.Scalar("0") || $0 == Unicode.Scalar("1") || $0 == Unicode.Scalar("_")
      })

      let tmp = self
      if self.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
        let errorPos = tmp
        self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
        return Lexer.Result(
          .integerLiteral,
          error: LexingDiagnostic(.invalidBinaryDigitInIntegerLiteral, position: errorPos)
        )
      }

      return Lexer.Result(.integerLiteral)
    }

    // Handle a leading [0-9]+, lexing an integer or falling through if we have a
    // floating point value.
    self.advance(while: { $0.isDigit || $0 == Unicode.Scalar("_") })

    // TODO: This can probably be unified with lexHexNumber somehow

    if self.is(at: ".") {
      if self.peek(at: 1) == nil {
        // If there are no more digits following the '.', we don't have a float
        // literal.
        return Lexer.Result(.integerLiteral)
      } else if let peeked = self.peek(at: 1), !Unicode.Scalar(peeked).isDigit {
        // ".a" is a member access and certainly not a float literal
        return Lexer.Result(.integerLiteral)
      } else if self.previousTokenKind == .period {
        // Lex x.0.1 is sub-tuple access, not x.float_literal.
        return Lexer.Result(.integerLiteral)
      }
    } else if self.isAtEndOfFile || self.is(notAt: "e", "E") {
      // Floating literals must have '.', 'e', or 'E' after digits.  If it is
      // something else, then this is the end of the token.
      let tmp = self
      if self.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
        let errorPos = tmp
        self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
        return Lexer.Result(
          .integerLiteral,
          error: LexingDiagnostic(.invalidDecimalDigitInIntegerLiteral, position: errorPos)
        )
      }

      return Lexer.Result(.integerLiteral)
    }

    // Lex decimal point.
    if self.advance(matching: ".") {
      // Lex any digits after the decimal point.
      self.advance(while: { $0.isDigit || $0 == Unicode.Scalar("_") })
    }

    // Lex exponent.
    if self.advance(matching: "e", "E") {
      _ = self.advance(matching: "-", "+")

      guard let peeked = self.peek(), Unicode.Scalar(peeked).isDigit else {
        // There are 3 cases to diagnose if the exponent starts with a non-digit:
        // identifier (invalid character), underscore (invalid first character),
        // non-identifier (empty exponent)
        let tmp = self
        var errorKind: TokenDiagnostic.Kind
        if self.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
          if tmp.is(at: "_") {
            errorKind = .invalidFloatingPointExponentCharacter
          } else {
            errorKind = .invalidFloatingPointExponentDigit
          }
        } else {
          errorKind = .expectedDigitInFloatLiteral
        }

        let errorPos = tmp
        self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
        return Lexer.Result(
          .floatingLiteral,
          error: LexingDiagnostic(errorKind, position: errorPos)
        )
      }

      self.advance(while: { $0.isDigit || $0 == Unicode.Scalar("_") })

      let tmp = self
      if self.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
        let errorPos = tmp
        self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
        return Lexer.Result(
          .floatingLiteral,
          error: LexingDiagnostic(.invalidFloatingPointExponentDigit, position: errorPos)
        )
      }
    }

    return Lexer.Result(.floatingLiteral)
  }

  mutating func lexHexNumber() -> Lexer.Result {
    // We assume we're starting from the 'x' in a '0x...' floating-point literal.
    let zeroConsumed = self.advance(matching: "0")
    let xConsumed = self.advance(matching: "x")
    assert(zeroConsumed && xConsumed, "not a hex literal")

    // 0x[0-9a-fA-F][0-9a-fA-F_]*
    guard let peeked = self.peek() else {
      return Lexer.Result(.integerLiteral, error: LexingDiagnostic(.expectedHexDigitInHexLiteral, position: self))
    }

    guard Unicode.Scalar(peeked).isHexDigit else {
      if Unicode.Scalar(peeked).isValidIdentifierContinuationCodePoint {
        let errorPos = self
        self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
        return Lexer.Result(.integerLiteral, error: LexingDiagnostic(.invalidHexDigitInIntegerLiteral, position: errorPos))
      } else {
        return Lexer.Result(.integerLiteral, error: LexingDiagnostic(.expectedHexDigitInHexLiteral, position: self))
      }
    }

    self.advance(while: { $0.isHexDigit || $0 == Unicode.Scalar("_") })

    if self.isAtEndOfFile || self.is(notAt: ".", "p", "P") {
      let tmp = self
      if self.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
        let errorPos = tmp
        self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
        return Lexer.Result(
          .integerLiteral,
          error: LexingDiagnostic(.invalidHexDigitInIntegerLiteral, position: errorPos)
        )
      } else {
        return Lexer.Result(.integerLiteral)
      }
    }

    // (\.[0-9A-Fa-f][0-9A-Fa-f_]*)?

    // If a '.' was consumed, the cursor pointing to the '.', otherwise nil
    var cursorToDot: Lexer.Cursor? = self
    if self.advance(matching: ".") {
      // If the character after the '.' is not a digit, assume we have an int
      // literal followed by a dot expression.
      if let peeked = self.peek(), !Unicode.Scalar(peeked).isHexDigit {
        self = cursorToDot!
        return Lexer.Result(.integerLiteral)
      }

      self.advance(while: { $0.isHexDigit || $0 == Unicode.Scalar("_") })

      if self.isAtEndOfFile || self.is(notAt: "p", "P") {
        if let peeked = self.peek(at: 1), !Unicode.Scalar(peeked).isDigit {
          // e.g: 0xff.description
          self = cursorToDot!
          return Lexer.Result(.integerLiteral)
        }
        return Lexer.Result(
          .integerLiteral,
          error: LexingDiagnostic(.expectedBinaryExponentInHexFloatLiteral, position: self)
        )
      }
    } else {
      cursorToDot = nil
    }

    // [pP][+-]?[0-9][0-9_]*
    let pConsumed = self.advance(matching: "p", "P")
    assert(self.isAtEndOfFile || pConsumed, "not at a hex float exponent?!")

    var signedExponent = false
    if self.advance(matching: "+", "-") {
      // Eat the sign.
      signedExponent = true
    }

    if let peeked = self.peek(), !Unicode.Scalar(peeked).isDigit {
      if let cursorToDot = cursorToDot, let peeked = cursorToDot.peek(at: 1), !Unicode.Scalar(peeked).isDigit && !signedExponent {
        // e.g: 0xff.fpValue, 0xff.fp
        self = cursorToDot
        return Lexer.Result(.integerLiteral)
      }
      // Note: 0xff.fp+otherExpr can be valid expression. But we don't accept it.

      // There are 3 cases to diagnose if the exponent starts with a non-digit:
      // identifier (invalid character), underscore (invalid first character),
      // non-identifier (empty exponent)
      let tmp = self
      let errorKind: TokenDiagnostic.Kind
      if self.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
        if tmp.is(at: "_") {
          errorKind = .invalidFloatingPointExponentCharacter
        } else {
          errorKind = .invalidFloatingPointExponentDigit
        }
      } else {
        errorKind = .expectedDigitInFloatLiteral
      }
      let errorPos = tmp
      self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
      return Lexer.Result(
        .floatingLiteral,
        error: LexingDiagnostic(errorKind, position: errorPos)
      )
    }

    self.advance(while: { $0.isDigit || $0 == Unicode.Scalar("_") })

    let tmp = self
    if self.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
      let errorPos = tmp
      self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
      return Lexer.Result(
        .floatingLiteral,
        error: LexingDiagnostic(.invalidFloatingPointExponentDigit, position: errorPos)
      )
    }
    return Lexer.Result(.floatingLiteral)
  }
}

extension Lexer.Cursor {
  mutating func lexMagicPoundLiteral() -> Lexer.Result {
    let poundConsumed = self.advance(matching: "#")
    assert(poundConsumed)
    var tmp = self
    // Scan for [a-zA-Z]+ to see what we match.
    while let peeked = tmp.peek(), Unicode.Scalar(peeked).isAsciiIdentifierStart {
      _ = tmp.advance()
    }

    let literal = self.text(upTo: tmp)

    let kind: RawTokenKind
    switch literal {
    case "sourceLocation": kind = .poundSourceLocationKeyword
    case "if": kind = .poundIfKeyword
    case "else": kind = .poundElseKeyword
    case "elseif": kind = .poundElseifKeyword
    case "endif": kind = .poundEndifKeyword
    case "available": kind = .poundAvailableKeyword
    case "unavailable": kind = .poundUnavailableKeyword
    default:
      // If we didn't find a match, then just return `.pound`.  This is highly
      // dubious in terms of error recovery, but is useful for code completion and
      // SIL parsing.
      return Lexer.Result(.pound)
    }

    // If we found something specific, return it.
    self = tmp
    return Lexer.Result(kind)
  }
}

// MARK: - String literals

// MARK: Lexing a character in a string literal

extension Lexer.Cursor {
  enum CharacterLex {
    /// A normal character as it occurs in the source file
    case success(Unicode.Scalar)

    /// An escaped character, e.g. `\n` or `\u{1234}`. It has been validated that
    /// this is a valid character
    case validatedEscapeSequence(Character)

    /// The end of a string literal has been reached.
    case endOfString

    /// The character could not be lexed because it's not a valid Unicode character.
    case error(TokenDiagnostic.Kind)
  }

  /// Lexes a single character in a string literal, handling escape sequences
  /// like `\n` or `\u{1234}` as a a single character.
  mutating func lexCharacterInStringLiteral(stringLiteralKind: StringLiteralKind, delimiterLength: Int) -> CharacterLex {
    let charStart = self

    switch self.peek() {
    case UInt8(ascii: #"""#):
      let quote = Unicode.Scalar(self.advance()!)
      switch stringLiteralKind {
      case .singleLine:
        var tmpPtr = self
        if !tmpPtr.advanceIfStringDelimiter(delimiterLength: delimiterLength) {
          return .success(quote)
        }
        self = tmpPtr
        return .endOfString
      case .multiLine:
        var tmpPtr = self
        if !tmpPtr.advanceIfMultilineStringDelimiter(openingRawStringDelimiters: nil) {
          return .success(quote)
        }
        if delimiterLength > 0 && !tmpPtr.advanceIfStringDelimiter(delimiterLength: delimiterLength) {
          return .success(quote)
        }
        self = tmpPtr
        return .endOfString
      case .singleQuote:
        // Otherwise, this is just a character.
        return .success(quote)
      }
    case UInt8(ascii: #"'"#):
      switch stringLiteralKind {
      case .singleQuote:
        let quoteConsumed = self.advance(matching: "'")
        assert(quoteConsumed)
        return .endOfString
      case .singleLine, .multiLine:
        // Otherwise, this is just a character.
        let character = self.advance()!
        return .success(Unicode.Scalar(character))
      }
    case 0:
      _ = self.advance()
      return .error(.nulCharacter)
    case UInt8(ascii: "\n"), UInt8(ascii: "\r"):  // String literals cannot have \n or \r in them.
      let character = self.advance()!
      assert(stringLiteralKind == .multiLine, "Caller must handle newlines in non-multiline")
      return .success(Unicode.Scalar(character))

    case UInt8(ascii: "\\"):  // Escapes.
      _ = self.advance()
      if !self.advanceIfStringDelimiter(delimiterLength: delimiterLength) {
        return .success(Unicode.Scalar("\\"))
      }
      switch self.lexEscapedCharacter(isMultilineString: stringLiteralKind == .multiLine) {
      case .success(let escapedCharacterCode):
        // Check to see if the encoding is valid.
        if let validatedScalar = Unicode.Scalar(escapedCharacterCode) {
          return .validatedEscapeSequence(Character(validatedScalar))
        } else {
          return .error(.invalidEscapeSequenceInStringLiteral)
        }
      case .error(let kind):
        return .error(kind)
      }
    default:
      _ = self.advance()
      self = charStart
      guard let charValue = self.advanceValidatingUTF8Character() else {
        return .error(.invalidUtf8)
      }
      // We disallow non-printable ASCII characters in a string literal, with
      // the exception of \t, which is valid only in multi-line string literals.
      if !charValue.isASCII || charValue.isPrintableASCII || stringLiteralKind == .multiLine && charValue == "\t" {
        return .success(charValue)
      } else {
        return .error(.unprintableAsciiCharacter)
      }
    }
  }

  enum EscapedCharacterLex {
    // Successfully lexed an escape sequence that represents the Unicode character
    // at the given codepoint
    case success(UInt32)
    case error(TokenDiagnostic.Kind)
  }

  /// Assuming that we are in a string literal and have already consumed a `\`,
  /// consume the escaped characters and return the Unicode character code
  /// (i.e. UTF-32 value) that the escaped character represents.
  ///
  /// If the character is not a valid escape sequence, return `nil`.
  private mutating func lexEscapedCharacter(isMultilineString: Bool) -> EscapedCharacterLex {
    assert(self.previous == UInt8(ascii: "\\") || self.previous == UInt8(ascii: "#"))
    // Escape processing.  We already ate the "\".
    switch self.peek() {
    // Simple single-character escapes.
    case UInt8(ascii: "0"): _ = self.advance(); return .success(UInt32(UInt8(ascii: "\0")))
    case UInt8(ascii: "n"): _ = self.advance(); return .success(UInt32(UInt8(ascii: "\n")))
    case UInt8(ascii: "r"): _ = self.advance(); return .success(UInt32(UInt8(ascii: "\r")))
    case UInt8(ascii: "t"): _ = self.advance(); return .success(UInt32(UInt8(ascii: "\t")))
    case UInt8(ascii: #"""#): _ = self.advance(); return .success(UInt32(UInt8(ascii: #"""#)))
    case UInt8(ascii: "'"): _ = self.advance(); return .success(UInt32(UInt8(ascii: "'")))
    case UInt8(ascii: "\\"): _ = self.advance(); return .success(UInt32(UInt8(ascii: "\\")))

    case UInt8(ascii: "u"):  // e.g. \u{1234}
      _ = self.advance()

      guard self.is(at: "{") else {
        return .error(.expectedHexCodeInUnicodeEscape)
      }

      return self.lexUnicodeEscape()
    case UInt8(ascii: "\n"), UInt8(ascii: "\r"):
      if isMultilineString && self.maybeConsumeNewlineEscape() {
        return .success(UInt32(UInt8(ascii: "\n")))
      }
      return .error(.invalidEscapeSequenceInStringLiteral)
    case nil:
      return .error(.invalidEscapeSequenceInStringLiteral)
    case .some(let peekedValue):  // Invalid escape.
      // If this looks like a plausible escape character, recover as though this
      // is an invalid escape.
      let c = Unicode.Scalar(peekedValue)
      if c.isDigit || c.isLetter {
        _ = self.advance()
      }
      return .error(.invalidEscapeSequenceInStringLiteral)
    }
  }

  /// Lex the contents of a `\u{1234}` escape sequence, assuming that we are
  /// placed at the opening `{`.
  ///
  /// If this is not a valid unicode escape, return `nil`.
  private mutating func lexUnicodeEscape() -> EscapedCharacterLex {
    let quoteConsumed = self.advance(matching: "{")
    assert(quoteConsumed)

    let digitStart = self
    var numDigits = 0
    while self.advance(if: { $0.isHexDigit }) {
      numDigits += 1
    }

    guard self.advance(matching: "}") else {
      return .error(.expectedClosingBraceInUnicodeEscape)
    }

    if numDigits == 0 || numDigits > 8 {
      return .error(.invalidNumberOfHexDigitsInUnicodeEscape)
    }

    if let codePoint = UInt32(String(decoding: digitStart.input[0..<numDigits], as: UTF8.self), radix: 16) {
      return .success(codePoint)
    } else {
      return .error(.invalidEscapeSequenceInStringLiteral)
    }
  }

  private mutating func maybeConsumeNewlineEscape() -> Bool {
    var tmp = self
    while true {
      switch tmp.advance() {
      case UInt8(ascii: " "), UInt8(ascii: "\t"):
        continue
      case UInt8(ascii: "\r"):
        _ = tmp.advance(if: { $0 == Unicode.Scalar("\n") })
        fallthrough
      case UInt8(ascii: "\n"):
        self = tmp
        return true
      case 0:
        return false
      default:
        return false
      }
    }
  }
}

// MARK: Lexing the string literal

extension Lexer.Cursor {
  private func stateTransitionAfterLexingStringQuote(kind: StringLiteralKind) -> Lexer.StateTransition {
    switch currentState {
    case .afterStringLiteral(isRawString: true):
      return .replace(newState: .afterClosingStringQuote)
    case .afterStringLiteral(isRawString: false):
      return .pop
    case .afterRawStringDelimiter(delimiterLength: let delimiterLength):
      return .replace(newState: .inStringLiteral(kind: kind, delimiterLength: delimiterLength))
    case .normal, .inStringInterpolation:
      return .push(newState: .inStringLiteral(kind: kind, delimiterLength: 0))
    default:
      preconditionFailure("Unexpected currentState '\(currentState)' for 'stateTransitionAfterLexingStringQuote'")
    }
  }

  /// `isOpening` is `true` if this string quote is the opening quote of a string
  /// literal and `false` if we are lexing the closing quote of a string literal.
  mutating func lexStringQuote(isOpening: Bool, leadingDelimiterLength: Int) -> Lexer.Result {
    if self.advance(matching: "'") {
      return Lexer.Result(.singleQuote, stateTransition: stateTransitionAfterLexingStringQuote(kind: .singleQuote))
    }

    let firstQuoteConsumed = self.advance(matching: #"""#)
    assert(firstQuoteConsumed)

    var lookingForMultilineString = self
    if lookingForMultilineString.advance(matching: #"""#), lookingForMultilineString.advance(matching: #"""#) {
      if leadingDelimiterLength > 0 {
        // If this is a string literal, check if we have the closing delimiter on the same line to correctly parse things like `#"""#` as a single line string containing a quote.
        var isSingleLineString = lookingForMultilineString

        if isSingleLineString.advanceIfStringDelimiter(delimiterLength: leadingDelimiterLength) {
          // If we have the correct number of delimiters now, we have something like `#"""#`.
          // This is a single-line string.
          return Lexer.Result(.stringQuote, stateTransition: stateTransitionAfterLexingStringQuote(kind: .singleLine))
        }

        // Scan ahead until the end of the line. Every time we see a closing
        // quote, check if it is followed by the correct number of closing delimiters.
        while isSingleLineString.is(notAt: "\r", "\n") {
          if isSingleLineString.advance(if: { $0 == Unicode.Scalar(UInt8(ascii: #"""#)) }) {
            if isSingleLineString.advanceIfStringDelimiter(delimiterLength: leadingDelimiterLength) {
              return Lexer.Result(.stringQuote, stateTransition: stateTransitionAfterLexingStringQuote(kind: .singleLine))
            }
            continue
          }
          _ = isSingleLineString.advance()
        }
      }

      self = lookingForMultilineString
      let trailingTriviaLexingMode: TriviaLexingMode?
      if isOpening && self.is(at: "\n", "\r") {
        // The opening quote of a multi-line string literal must be followed by
        // a newline that's not part of the represented string.
        trailingTriviaLexingMode = .escapedNewlineInMultiLineStringLiteral
      } else {
        trailingTriviaLexingMode = nil
      }

      return Lexer.Result(
        .multilineStringQuote,
        stateTransition: stateTransitionAfterLexingStringQuote(kind: .multiLine),
        trailingTriviaLexingMode: trailingTriviaLexingMode
      )
    } else {
      return Lexer.Result(.stringQuote, stateTransition: stateTransitionAfterLexingStringQuote(kind: .singleLine))
    }
  }

  /// Returns `true` if the cursor is positioned at `\##(` with `delimiterLength`
  /// pound characters.
  private func isAtStringInterpolationAnchor(delimiterLength: Int) -> Bool {
    guard self.is(at: "\\") else {
      return false
    }

    var tmp = self
    _ = tmp.advance()  // Skip over the '\' to look for '#' and '('
    return tmp.advanceIfStringDelimiter(delimiterLength: delimiterLength) && tmp.is(at: "(")
  }

  /// Returns `true` if we are positioned at a backslash that escapes the newline
  /// character in a multi-line string literal.
  private func isAtEscapedNewline(delimiterLength: Int) -> Bool {
    guard self.is(at: "\\") else {
      return false
    }

    var tmp = self
    let backslashConsumed = tmp.advance(matching: "\\")  // Skip over the '\' to look for '#' and '('
    assert(backslashConsumed)
    guard tmp.advanceIfStringDelimiter(delimiterLength: delimiterLength) else {
      return false
    }
    tmp.advance(while: { $0 == " " || $0 == "\t" })
    return tmp.is(at: "\r", "\n")
  }

  mutating func lexInStringLiteral(stringLiteralKind: StringLiteralKind, delimiterLength: Int) -> Lexer.Result {
    var error: LexingDiagnostic? = nil

    while true {
      switch self.peek() {
      case UInt8(ascii: "\\"):
        if self.isAtStringInterpolationAnchor(delimiterLength: delimiterLength) {
          return Lexer.Result(
            .stringSegment,
            error: error,
            stateTransition: .push(newState: .inStringInterpolationStart(stringLiteralKind: stringLiteralKind))
          )
        } else if self.isAtEscapedNewline(delimiterLength: delimiterLength) {
          return Lexer.Result(
            .stringSegment,
            trailingTriviaLexingMode: .escapedNewlineInMultiLineStringLiteral
          )
        }
      case UInt8(ascii: "\r"), UInt8(ascii: "\n"):
        if stringLiteralKind == .multiLine {
          // Make sure each line starts a new string segment so the parser can
          // validate the multi-line string literal's indentation.
          let character = self.advance()
          if character == UInt8(ascii: "\r") {
            _ = self.advance(matching: "\n")
          }
          return Lexer.Result(.stringSegment, error: error)
        } else {
          // Single line literals cannot span multiple lines.
          // Terminate the string here and go back to normal lexing (instead of `afterStringLiteral`)
          // since we aren't looking for the closing quote anymore.
          return Lexer.Result(.stringSegment, error: error, stateTransition: .pop)
        }
      case nil:
        return Lexer.Result(
          .stringSegment,
          error: error,
          stateTransition: .replace(newState: .afterStringLiteral(isRawString: delimiterLength > 0))
        )
      default:
        break
      }

      // Eat another character in the segment
      var clone = self
      let charValue = clone.lexCharacterInStringLiteral(stringLiteralKind: stringLiteralKind, delimiterLength: delimiterLength)
      switch charValue {
      case .success:
        self = clone
      case .validatedEscapeSequence(let escapedCharacter):
        self = clone
        if escapedCharacter == "\n" || escapedCharacter == "\r" {
          // Make sure each line starts a new string segment so the parser can
          // validate the multi-line string literal's indentation.
          return Lexer.Result(.stringSegment, error: error)
        }
      case .error(let errorKind):
        error = LexingDiagnostic(errorKind, position: self)
        self = clone
      case .endOfString:
        return Lexer.Result(
          .stringSegment,
          error: error,
          stateTransition: .replace(newState: .afterStringLiteral(isRawString: delimiterLength > 0))
        )
      }
    }
  }

  /// If the next `delimiterLength` characters are `#`, consume them and return
  /// `true`. Otherwise, don't consume anything and return `false`.
  mutating func advanceIfStringDelimiter(delimiterLength: Int) -> Bool {
    guard delimiterLength > 0 else {
      return true
    }

    var tmpPtr = self
    var numPounds = 0
    while tmpPtr.advance(matching: "#"), numPounds < delimiterLength {
      numPounds += 1
    }

    if numPounds < delimiterLength {
      return false
    }

    self = tmpPtr
    return true
  }
}

// MARK: - Identifiers

extension Lexer.Cursor {
  /// lexIdentifier - Match [a-zA-Z_][a-zA-Z_$0-9]*
  mutating func lexIdentifier() -> Lexer.Result {
    let tokStart = self
    let didStart = self.advance(if: { $0.isValidIdentifierStartCodePoint })
    assert(didStart, "Unexpected start")

    // Lex [a-zA-Z_$0-9[[:XID_Continue:]]]*
    self.advance(while: { $0.isValidIdentifierContinuationCodePoint })

    let text = tokStart.text(upTo: self)
    if let keyword = Keyword(text), keyword.isLexerClassified {
      return Lexer.Result(.keyword)
    } else if text == "_" {
      return Lexer.Result(.wildcard)
    } else {
      return Lexer.Result(.identifier)
    }
  }

  mutating func lexEscapedIdentifier() -> Lexer.Result {
    let quote = self
    let backtickConsumed = self.advance(matching: "`")
    assert(backtickConsumed, "Unexpected start of escaped identifier")

    // Check whether we have an identifier followed by another backtick, in which
    // case this is an escaped identifier.
    let identifierStart = self
    if self.advance(if: { $0.isValidIdentifierStartCodePoint }) {
      // Keep continuing the identifier.
      self.advance(while: { $0.isValidIdentifierContinuationCodePoint })

      // If we have the terminating "`", it's an escaped identifier.
      if self.advance(matching: "`") {
        return Lexer.Result(.identifier)
      }
    }

    // Special case; allow '`$`'.
    if quote.starts(with: "`$`".utf8) {
      self = quote
      let firstBacktickConsumed = self.advance(matching: "`")
      let dollarConsumed = self.advance(matching: "$")
      let secondBacktickConsumed = self.advance(matching: "`")
      assert(firstBacktickConsumed && dollarConsumed && secondBacktickConsumed)
      return Lexer.Result(.identifier)
    }

    // The backtick is punctuation.
    self = identifierStart
    return Lexer.Result(.backtick)
  }

  mutating func lexOperatorIdentifier(sourceBufferStart: Lexer.Cursor) -> Lexer.Result {
    let tokStart = self
    let didStart = self.advance(if: { $0.isOperatorStartCodePoint })
    assert(didStart, "unexpected operator start")

    repeat {
      // '.' cannot appear in the middle of an operator unless the operator
      // started with a '.'.
      if self.is(at: ".") && tokStart.is(notAt: ".") {
        break
      }
      let text = SyntaxText(baseAddress: self.input.baseAddress, count: self.input.count)
      if text.hasPrefix("<#") && text.containsPlaceholderEnd() {
        break
      }

      //      // If we are lexing a `/.../` regex literal, we don't consider `/` to be an
      //      // operator character.
      //      if ForwardSlashRegexMode != LexerForwardSlashRegexMode::None &&
      //          CurPtr.peek() == UInt8(ascii: "/") {
      //        break
      //      }
    } while self.advance(if: { $0.isOperatorContinuationCodePoint })

    if self.input.baseAddress! - tokStart.input.baseAddress! > 2 {
      // If there is a "//" or "/*" in the middle of an identifier token,
      // it starts a comment.
      var ptr = tokStart
      // Skip over the first character. A `//` or /*` at the beginning would have
      // been consumed as trivia.
      _ = ptr.advance()
      while ptr.input.baseAddress! < self.input.baseAddress! {
        if ptr.is(at: "/") && ptr.is(offset: 1, at: "/", "*") {
          self = ptr
          break
        }
        _ = ptr.advance()
      }
    }

    // Decide between the binary, prefix, and postfix cases.
    // It's binary if either both sides are bound or both sides are not bound.
    // Otherwise, it's postfix if left-bound and prefix if right-bound.
    let leftBound = tokStart.isLeftBound(sourceBufferStart: sourceBufferStart)
    let rightBound = self.isRightBound(isLeftBound: leftBound)

    // Match various reserved words.
    if self.input.baseAddress! - tokStart.input.baseAddress! == 1 {
      switch tokStart.peek() {
      case UInt8(ascii: "="):
        return Lexer.Result(.equal)
      case UInt8(ascii: "&"):
        if leftBound == rightBound || leftBound {
          break
        }
        return Lexer.Result(.prefixAmpersand)
      case UInt8(ascii: "."):
        return Lexer.Result(.period)
      case UInt8(ascii: "?"):
        if (leftBound) {
          return Lexer.Result(.postfixQuestionMark)
        }
        return Lexer.Result(.infixQuestionMark)
      default:
        break
      }
    } else if (self.input.baseAddress! - tokStart.input.baseAddress! == 2) {
      switch (tokStart.peek(), tokStart.peek(at: 1)) {
      case (UInt8(ascii: "-"), UInt8(ascii: ">")):  // ->
        return Lexer.Result(.arrow)
      case (UInt8(ascii: "*"), UInt8(ascii: "/")):  // */
        return Lexer.Result(.unknown, error: LexingDiagnostic(.unexpectedBlockCommentEnd, position: tokStart))
      default:
        break
      }
    } else {
      // Verify there is no "*/" in the middle of the identifier token, we reject
      // it as potentially ending a block comment.
      if tokStart.text(upTo: self).contains("*/") {
        return Lexer.Result(.unknown, error: LexingDiagnostic(.unexpectedBlockCommentEnd, position: tokStart))
      }
    }

    if leftBound == rightBound {
      return Lexer.Result(.binaryOperator)
    } else if leftBound {
      return Lexer.Result(.postfixOperator)
    } else {
      return Lexer.Result(.prefixOperator)
    }
  }

  mutating func lexDollarIdentifier() -> Lexer.Result {
    let tokStart = self
    let dollarConsumed = self.advance(matching: "$")
    assert(dollarConsumed)

    var isAllDigits = true
    while true {
      if let peeked = self.peek(), Unicode.Scalar(peeked).isDigit {
        _ = self.advance()
        continue
      } else if self.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
        isAllDigits = false
        continue
      }
      break
    }

    // If there is a standalone '$', treat it like an identifier.
    if self.input.baseAddress == tokStart.input.baseAddress {
      return Lexer.Result(.identifier)
    }

    if !isAllDigits {
      return Lexer.Result(.identifier)
    } else {
      return Lexer.Result(.dollarIdentifier)
    }
  }
}

// MARK: - Editor Placeholders

extension Lexer.Cursor {
  mutating func tryLexEditorPlaceholder(sourceBufferStart: Lexer.Cursor) -> Lexer.Result {
    assert(self.is(at: "<") && self.is(offset: 1, at: "#"))
    var ptr = self
    let leftAngleConsumed = ptr.advance(matching: "<")
    let poundConsumed = ptr.advance(matching: "#")
    assert(leftAngleConsumed && poundConsumed)
    LOOP: while let consumed = ptr.advance() {
      switch consumed {
      case UInt8(ascii: "\n"):
        break LOOP
      case UInt8(ascii: "<") where ptr.is(at: "#"):
        break LOOP
      case UInt8(ascii: "#") where ptr.is(at: ">"):
        let closingAngleConsumed = ptr.advance(matching: ">")
        assert(closingAngleConsumed)
        self = ptr
        return Lexer.Result(.identifier)
      default:
        break
      }
    }

    // Not a well-formed placeholder.
    return self.lexOperatorIdentifier(sourceBufferStart: sourceBufferStart)
  }
}

// MARK: - Unknown Syntax

extension Lexer.Cursor {
  private func findEndOfCurlyQuoteStringLiteral() -> Lexer.Cursor? {
    var body = self
    while true {
      // Don't bother with string interpolations.
      if body.is(at: "\\") && body.is(offset: 1, at: "(") {
        return nil
      }

      // We didn't find the end of the string literal if we ran to end of line.
      if body.isAtEndOfFile || body.is(at: "\r", "\n") {
        return nil
      }

      // Get the next character.
      switch body.lexCharacterInStringLiteral(stringLiteralKind: .singleLine, delimiterLength: 0) {
      case .error:
        // If the character was incorrectly encoded, give up.
        return nil
      case .endOfString, .success(Unicode.Scalar(0x201D)):
        // If we found a closing quote, then we're done.  Just return the spot
        // to continue.
        return body
      default:
        break
      }
    }
  }

  enum UnknownCharactersClassification {
    /// The characters consumed by `lexUnknown` should be classified as trivia
    case trivia(error: LexingDiagnostic)
    /// The characters consumed by `lexUnknown` should be classified as the contents of a lexeme
    case lexemeContents(Lexer.Result)
  }

  /// Assuming the cursor is positioned at neighter a valid identifier nor a
  /// valid operator start, advance the cursor by what can be considered a
  /// lexeme.
  mutating func lexUnknown() -> UnknownCharactersClassification {
    assert(!(self.peekScalar()?.isValidIdentifierStartCodePoint ?? false) && !(self.peekScalar()?.isOperatorStartCodePoint ?? false))
    let start = self
    var tmp = self
    if tmp.advance(if: { Unicode.Scalar($0).isValidIdentifierContinuationCodePoint }) {
      // If this is a valid identifier continuation, but not a valid identifier
      // start, attempt to recover by eating more continuation characters.
      tmp.advance(while: { Unicode.Scalar($0).isValidIdentifierContinuationCodePoint })
      self = tmp
      return .lexemeContents(Lexer.Result(.identifier, error: LexingDiagnostic(.invalidIdentifierStartCharacter, position: start)))
    }

    // This character isn't allowed in Swift source.
    guard let codepoint = tmp.advanceValidatingUTF8Character() else {
      self = tmp
      return .trivia(error: LexingDiagnostic(.invalidUtf8, position: start))
    }
    if codepoint.value == 0xA0 {  // Non-breaking whitespace (U+00A0)
      while tmp.is(at: 0xC2) && tmp.is(offset: 1, at: 0xA0) {
        _ = tmp.advance()
        _ = tmp.advance()
      }

      self = tmp
      return .trivia(error: LexingDiagnostic(.nonBreakingSpace, position: start))
    } else if codepoint.value == 0x201D {  // Closing curly quote (U+201D)
      // If this is an end curly quote, just diagnose it with a fixit hint.
      self = tmp
      return .lexemeContents(Lexer.Result(.unknown, error: LexingDiagnostic(.unicodeCurlyQuote, position: start)))
    } else if codepoint.value == 0x201C {  // Opening curly quote (U+201C)
      // If this is a start curly quote, do a fuzzy match of a string literal
      // to improve recovery.
      if let tmp2 = tmp.findEndOfCurlyQuoteStringLiteral() {
        tmp = tmp2
      }

      self = tmp

      // Identifiers are the closest representation of static string literals
      // we have in the parser. Classify the entire curly string as an identifier
      // for best recovery.
      return .lexemeContents(Lexer.Result(.identifier, error: LexingDiagnostic(.unicodeCurlyQuote, position: start)))
    } else if codepoint.value == 0 {  // Nul character
      self = tmp
      return .trivia(error: LexingDiagnostic(.nulCharacter, position: start))
    }

    // TODO: Try map confusables to ASCII characters
    self = tmp
    return .trivia(error: LexingDiagnostic(.invalidCharacter, position: start))
  }

  enum ConflictMarker {
    case normal
    case perforce

    var introducer: String {
      switch self {
      case .perforce:
        return ">>>> "
      case .normal:
        return "<<<<<<< "
      }
    }

    var terminator: String {
      switch self {
      case .perforce:
        return "<<<<\n"
      case .normal:
        return ">>>>>>> "
      }
    }
  }
  mutating func tryLexConflictMarker(start: Lexer.Cursor) -> Bool {
    // Only a conflict marker if it starts at the beginning of a line.
    guard start.previous == UInt8(ascii: "\n") || start.previous == UInt8(ascii: "\r") || start.previous == 0 else {
      return false
    }

    // Check to see if we have <<<<<<< or >>>>.
    guard start.starts(with: "<<<<<<< ".utf8) || start.starts(with: ">>>> ".utf8) else {
      return false
    }

    let kind = start.is(at: "<") ? ConflictMarker.normal : .perforce
    guard let end = Self.findConflictEnd(start, markerKind: kind) else {
      // No end of conflict marker found.
      return false
    }

    // Diagnose at the conflict marker, then jump ahead to the end.
    self = end

    // Skip ahead to the end of the marker.
    if !self.isAtEndOfFile {
      self.advanceToEndOfLine()
    }
    return true
  }

  /// Find the end of a version control conflict marker.
  static func findConflictEnd(_ curPtr: Lexer.Cursor, markerKind: ConflictMarker) -> Lexer.Cursor? {
    // Get a reference to the rest of the buffer minus the length of the start
    // of the conflict marker.
    let advanced = curPtr.input.baseAddress?.advanced(by: markerKind.introducer.utf8.count)
    var restOfBuffer = Lexer.Cursor(
      input: .init(start: advanced, count: curPtr.input.count - markerKind.introducer.utf8.count),
      previous: curPtr.input[markerKind.introducer.utf8.count - 1]
    )
    while !restOfBuffer.isAtEndOfFile {
      let terminatorStart = markerKind.terminator.utf8.first!
      restOfBuffer.advance(while: { byte in
        byte != Unicode.Scalar(terminatorStart)
      })

      guard restOfBuffer.starts(with: markerKind.terminator.utf8) else {
        _ = restOfBuffer.advance()
        continue
      }

      // Must occur at start of line.
      guard restOfBuffer.previous == UInt8(ascii: "\n") || restOfBuffer.previous == UInt8(ascii: "\r") else {
        continue
      }

      let advanced = restOfBuffer.input.baseAddress?.advanced(by: markerKind.terminator.utf8.count)
      return Lexer.Cursor(
        input: .init(start: advanced, count: restOfBuffer.input.count - markerKind.terminator.utf8.count),
        previous: restOfBuffer.input[markerKind.terminator.utf8.count - 1]
      )
    }
    return nil
  }
}

extension Lexer.Cursor {
  mutating func tryLexRegexLiteral(sourceBufferStart: Lexer.Cursor) -> RawTokenKind? {
    guard !self.isLeftBound(sourceBufferStart: sourceBufferStart) else {
      return nil
    }

    var tmp = self
    var poundCount = 0
    var parenCount = 0

    while tmp.advance(matching: "#") {
      poundCount += 1
    }

    guard tmp.advance(matching: "/") else {
      return nil
    }

    // For `/.../` regex literals, we need to ban space and tab at the start of
    // a regex to avoid ambiguity with operator chains, e.g:
    //
    // Builder {
    //   0
    //   / 1 /
    //   2
    // }
    //
    if poundCount == 0 && tmp.is(at: " ", "\n", "\t") {
      return nil
    }

    var isMultiline = false
    LOOP: while true {
      switch tmp.peek() {
      case UInt8(ascii: " "), UInt8(ascii: "\t"):
        _ = tmp.advance()
      case UInt8(ascii: "\n"), UInt8(ascii: "\r"):
        isMultiline = true
        break LOOP
      default:
        break LOOP
      }
    }

    var escaped = false
    DELIMITLOOP: while true {
      defer { escaped = false }

      let previousByte = tmp.previous
      switch tmp.advance() {
      case nil:
        return nil
      case UInt8(ascii: "/"):
        // If we're at the end of the literal, peek ahead to see if the closing
        // slash is actually the start of a comment.
        if tmp.is(at: "/", "*") {
          return nil
        }

        var endLex = tmp
        for _ in 0..<poundCount {
          guard endLex.advance(matching: "#") else {
            continue DELIMITLOOP
          }
        }

        // A regex literal may not end in a space or tab.
        if !isMultiline && poundCount == 0 && (previousByte == UInt8(ascii: " ") || previousByte == UInt8(ascii: "\t")) {
          return nil
        }

        tmp = endLex
        break DELIMITLOOP
      case let .some(next) where !Unicode.Scalar(next).isASCII:
        // Just advance into a UTF-8 sequence. It shouldn't matter that we'll
        // iterate through each byte as we only match against ASCII, and we
        // validate it at the end. This case is separated out so we can just deal
        // with the ASCII cases below.
        continue

      case UInt8(ascii: "\n"), UInt8(ascii: "\r"):
        guard isMultiline else {
          return nil
        }

      case UInt8(ascii: "\\") where !escaped:
        // Advance again for an escape sequence.
        _ = tmp.advance()
        escaped = true

      //      case let next
      //        where !next.isPrintableASCII && !(isMultiline && next == "\t"):
      //        // Diagnose unprintable ASCII.
      //        // Note that tabs are allowed in multi-line literals.
      //        // TODO: This matches the string literal behavior, but should we allow
      //        // tabs for single-line regex literals too?
      //        // TODO: Ideally we would recover and continue to lex until the ending
      //        // delimiter.
      //        throw DelimiterLexError(.unprintableASCII, resumeAt: cursor.successor())

      case UInt8(ascii: "("):
        parenCount += 1

      case UInt8(ascii: ")"):
        if parenCount == 0 {
          return nil
        }
        parenCount -= 1

      default:
        break
      }
    }

    // We either had a successful lex, or something that was recoverable.
    self = tmp
    return .regexLiteral
  }
}
