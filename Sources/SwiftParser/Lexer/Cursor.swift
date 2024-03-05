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

extension SyntaxText {
  fileprivate func containsPlaceholderEnd() -> Bool {
    guard self.count >= 2 else {
      return false
    }

    for idx in 0..<(self.count - 1) {
      let c = self[idx]
      guard c != "\n" else {
        return false
      }

      if self[idx] == "#", self[idx + 1] == ">" {
        return true
      }
    }
    return false
  }
}

@_spi(Compiler)
public enum StringLiteralKind: Equatable {
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
  ///  - A regex literal is being lexed
  ///  - A narrow case for 'try?' and 'try!' to ensure correct regex lexing
  enum State {
    /// Normal top-level lexing mode
    case normal

    /// A narrow mode that's used for 'try?' and 'try!' to ensure we prefer to
    /// lex a regex literal rather than a binary operator. This is needed as the
    /// `previousTokenKind` will be `.postfixOperator`, which would normally
    /// indicate a binary operator is expected next, but in this case we know it
    /// must be an expression. See the comment in
    /// `tryScanOperatorAsRegexLiteral` for more info.
    /// NOTE: This is a complete hack, do not add new uses of this.
    case preferRegexOverBinaryOperator

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

    /// We have encountered a regex literal, and have its tokens to work
    /// through. `lexemes` is a pointer to the lexemes allocated in the state
    /// stack bump pointer allocator.
    case inRegexLiteral(index: UInt8, lexemes: UnsafePointer<RegexLiteralLexemes>)

    /// The mode in which leading trivia should be lexed for this state or `nil`
    /// if no trivia should be lexed.
    func leadingTriviaLexingMode(cursor: Lexer.Cursor) -> TriviaLexingMode? {
      switch self {
      case .normal, .preferRegexOverBinaryOperator: return .normal
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
      case .inRegexLiteral: return nil
      }
    }

    /// The mode in which trailing trivia should be lexed for this state or `nil`
    /// if no trivia should be lexed.
    func trailingTriviaLexingMode(cursor: Lexer.Cursor) -> TriviaLexingMode? {
      switch self {
      case .normal, .preferRegexOverBinaryOperator: return .noNewlines
      case .afterRawStringDelimiter: return nil
      case .inStringLiteral: return nil
      case .afterStringLiteral: return nil
      case .afterClosingStringQuote: return nil
      case .inStringInterpolationStart: return nil
      case .inStringInterpolation: return .noNewlines
      case .inRegexLiteral: return nil
      }
    }

    /// If `true`, this state should be popped when a `\n` or `\r` is seen during
    /// trailing trivia lexing.
    /// This allows us to terminate single line string literal lexing when
    /// hitting a newline.
    var shouldPopStateWhenReachingNewlineInTrailingTrivia: Bool {
      switch self {
      case .normal, .preferRegexOverBinaryOperator: return false
      case .afterRawStringDelimiter: return false
      case .inStringLiteral(kind: let stringLiteralKind, delimiterLength: _): return stringLiteralKind != .multiLine
      case .afterStringLiteral: return false
      case .afterClosingStringQuote: return false
      case .inStringInterpolationStart: return false
      case .inStringInterpolation: return false
      case .inRegexLiteral: return false
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
        if let topState {
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
      case .pushRegexLexemes(let index, let lexemes):
        perform(stateTransition: .push(newState: .inRegexLiteral(index: index, lexemes: lexemes.allocate(in: stateAllocator))), stateAllocator: stateAllocator)
      case .replace(newState: let newState):
        topState = newState
      case .pop:
        if let stateStack {
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
    let position: Lexer.Cursor.Position

    init(_ kind: TokenDiagnostic.Kind, position: Lexer.Cursor.Position) {
      self.kind = kind
      self.position = position
    }

    init(_ kind: TokenDiagnostic.Kind, position: Lexer.Cursor) {
      self.init(kind, position: position.position)
    }

    func tokenDiagnostic(tokenStart: Lexer.Cursor) -> TokenDiagnostic {
      return TokenDiagnostic(kind, byteOffset: tokenStart.position.distance(to: position))
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
    struct Position {
      var input: UnsafeBufferPointer<UInt8>
      var previous: UInt8
    }
    var position: Position

    /// If we have already lexed a token, the kind of the previously lexed token
    var previousTokenKind: RawTokenKind?

    /// If we have already lexed a token, stores whether the previous lexeme‘s ending contains a newline.
    var previousLexemeTrailingNewlinePresence: NewlinePresence?

    /// If the `previousTokenKind` is `.keyword`, the keyword kind. Otherwise
    /// `nil`.
    var previousKeyword: Keyword?

    private var stateStack: StateStack = StateStack()

    init(input: UnsafeBufferPointer<UInt8>, previous: UInt8) {
      self.position = Position(input: input, previous: previous)
    }

    var input: UnsafeBufferPointer<UInt8> { position.input }
    var previous: UInt8 { position.previous }

    var currentState: State {
      stateStack.currentState
    }

    mutating func perform(stateTransition: Lexer.StateTransition, stateAllocator: BumpPtrAllocator) {
      self.stateStack.perform(stateTransition: stateTransition, stateAllocator: stateAllocator)
    }

    func starts(with possiblePrefix: some Sequence<UInt8>) -> Bool {
      return self.input.starts(with: possiblePrefix)
    }

    var pointer: UnsafePointer<UInt8> {
      self.position.pointer
    }
    func distance(to other: Self) -> Int {
      self.position.distance(to: other.position)
    }

    var isAtEndOfFile: Bool {
      self.position.isAtEndOfFile
    }

    var isAtStartOfFile: Bool {
      self.position.isAtStartOfFile
    }

    /// Debug function to print the remaining source text to be lexed.
    var debugRemainingText: SyntaxText {
      return SyntaxText(baseAddress: input.baseAddress, count: input.count)
    }
  }

  enum StateTransition {
    /// Push a new state onto the state stack
    case push(newState: Cursor.State)

    /// Push a set of regex literal lexemes onto the state stack. This avoids
    /// needing to plumb the state allocator through the lexer.
    case pushRegexLexemes(index: UInt8, lexemes: RegexLiteralLexemes)

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
    /// If set, overrides the trailing trivia lexing mode of the current state
    /// for this lexeme.
    let trailingTriviaLexingMode: Lexer.Cursor.TriviaLexingMode?

    /// If `tokenKind` is `.keyword`, the kind of keyword produced, otherwise
    /// `nil`.
    let keywordKind: Keyword?
    /// Indicates whether the end of the lexed token text contains a newline.
    let trailingNewlinePresence: Lexer.Cursor.NewlinePresence

    private init(
      _ tokenKind: RawTokenKind,
      flags: Lexer.Lexeme.Flags,
      error: Cursor.LexingDiagnostic?,
      stateTransition: StateTransition?,
      trailingTriviaLexingMode: Lexer.Cursor.TriviaLexingMode?,
      keywordKind: Keyword?,
      trailingNewlinePresence: Lexer.Cursor.NewlinePresence
    ) {
      self.tokenKind = tokenKind
      self.flags = flags
      self.error = error
      self.stateTransition = stateTransition
      self.trailingTriviaLexingMode = trailingTriviaLexingMode
      self.keywordKind = keywordKind
      self.trailingNewlinePresence = trailingNewlinePresence
    }

    /// Create a lexer result. Note that keywords should use `Result.keyword`
    /// instead.
    init(
      _ tokenKind: RawTokenKind,
      flags: Lexer.Lexeme.Flags = [],
      error: Cursor.LexingDiagnostic? = nil,
      stateTransition: StateTransition? = nil,
      trailingTriviaLexingMode: Lexer.Cursor.TriviaLexingMode? = nil,
      trailingNewlinePresence: Lexer.Cursor.NewlinePresence = .absent
    ) {
      precondition(tokenKind != .keyword, "Use Result.keyword instead")
      self.init(
        tokenKind,
        flags: flags,
        error: error,
        stateTransition: stateTransition,
        trailingTriviaLexingMode: trailingTriviaLexingMode,
        keywordKind: nil,
        trailingNewlinePresence: trailingNewlinePresence
      )
    }

    /// Produce a lexer result for a given keyword.
    static func keyword(_ kind: Keyword) -> Self {
      Self(
        .keyword,
        flags: [],
        error: nil,
        stateTransition: nil,
        trailingTriviaLexingMode: nil,
        keywordKind: kind,
        trailingNewlinePresence: .absent
      )
    }
  }
}

extension Lexer.Cursor.Position {
  var pointer: UnsafePointer<UInt8> {
    self.input.baseAddress!
  }

  func distance(to other: Self) -> Int {
    self.pointer.distance(to: other.pointer)
  }

  var isAtEndOfFile: Bool {
    self.input.isEmpty
  }

  var isAtStartOfFile: Bool {
    !self.input.isEmpty && self.previous == "\0"
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
      result = lexNormal(sourceBufferStart: sourceBufferStart, preferRegexOverBinaryOperator: false)
    case .preferRegexOverBinaryOperator:
      // In this state we lex a single token with the flag set, and then pop the state.
      result = lexNormal(sourceBufferStart: sourceBufferStart, preferRegexOverBinaryOperator: true)
      self.stateStack.perform(stateTransition: .pop, stateAllocator: stateAllocator)
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
    case .inRegexLiteral(let index, let lexemes):
      result = lexInRegexLiteral(lexemes.pointee[index...], existingPtr: lexemes)
    }

    var flags = result.flags
    if newlineInLeadingTrivia == .present {
      flags.insert(.isAtStartOfLine)
    }
    if let previousLexemeTrailingNewlinePresence, previousLexemeTrailingNewlinePresence == .present {
      flags.insert(.isAtStartOfLine)
    }

    self.previousLexemeTrailingNewlinePresence = result.trailingNewlinePresence

    if let stateTransition = result.stateTransition {
      self.stateStack.perform(stateTransition: stateTransition, stateAllocator: stateAllocator)
    }

    // Trailing trivia.
    let trailingTriviaStart = self
    if let trailingTriviaMode = result.trailingTriviaLexingMode ?? currentState.trailingTriviaLexingMode(cursor: self) {
      let triviaResult = self.lexTrivia(mode: trailingTriviaMode)
      self.previousLexemeTrailingNewlinePresence = triviaResult.newlinePresence
      diagnostic = TokenDiagnostic(combining: diagnostic, triviaResult.error?.tokenDiagnostic(tokenStart: cursor))
    }

    if self.currentState.shouldPopStateWhenReachingNewlineInTrailingTrivia && self.is(at: "\r", "\n") {
      self.stateStack.perform(stateTransition: .pop, stateAllocator: stateAllocator)
    }

    diagnostic = TokenDiagnostic(combining: diagnostic, result.error?.tokenDiagnostic(tokenStart: cursor))

    let lexeme = Lexer.Lexeme(
      tokenKind: result.tokenKind,
      flags: flags,
      diagnostic: diagnostic,
      start: leadingTriviaStart.pointer,
      leadingTriviaLength: leadingTriviaStart.distance(to: textStart),
      textLength: textStart.distance(to: trailingTriviaStart),
      trailingTriviaLength: trailingTriviaStart.distance(to: self),
      cursor: cursor
    )
    self.previousTokenKind = result.tokenKind
    self.previousKeyword = result.keywordKind

    return lexeme
  }

}

// MARK: - Peeking

/// Essentially a UInt8 that is expressible by integer and string literals.
struct CharacterByte: ExpressibleByUnicodeScalarLiteral, ExpressibleByIntegerLiteral {
  let value: UInt8

  init(unicodeScalarLiteral value: Unicode.Scalar) {
    self.value = UInt8(ascii: value)
  }

  init(integerLiteral value: UInt8) {
    self.value = value
  }
}

extension Lexer.Cursor {
  func peek(at offset: Int = 0) -> UInt8? {
    precondition(offset >= 0)
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
    precondition(count >= 0)
    return SyntaxText(baseAddress: self.input.baseAddress, count: count)
  }
}

// MARK: - Advancing the cursor

extension Lexer.Cursor.Position {
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

  /// Advance the cursor position by `n` bytes. The offset must be valid.
  func advanced(by n: Int) -> Self {
    precondition(n > 0)
    precondition(n <= self.input.count)
    var input = self.input.dropFirst(n - 1)
    let c = input.removeFirst()
    return .init(input: UnsafeBufferPointer(rebasing: input), previous: c)
  }
}

extension Lexer.Cursor {
  /// If there is a character in the input, and return it, advancing the cursor.
  /// If the end of the input is reached, return `nil`.
  mutating func advance() -> UInt8? {
    self.position.advance()
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

  /// Advance the cursor while `predicate` is satisfied.
  mutating func advance(while predicate: (Unicode.Scalar) -> Bool) {
    while self.advance(if: predicate) {}
  }

  /// Advance the cursor to the end of the current line.
  mutating func advanceToEndOfLine() {
    while self.is(notAt: "\n", "\r") {
      _ = self.advance()
    }
  }

  /// Returns `true` if the comment spanned multiple lines and `false` otherwise.
  /// Assumes that the curser is currently pointing at the `*` of the opening `/*`.
  mutating func advanceToEndOfSlashStarComment(slashPosition: Lexer.Cursor) -> TriviaResult {
    precondition(self.previous == "/")
    // Make sure to advance over the * so that we don't incorrectly handle /*/ as
    // the beginning and end of the comment.
    let consumedStar = self.advance(matching: "*")
    precondition(consumedStar)

    var depth = 1
    var newlinePresence = NewlinePresence.absent
    var error: LexingDiagnostic? = nil

    LOOP: while true {
      switch self.advance() {
      case "*":
        // Check for a '*/'
        if self.advance(matching: "/") {
          depth -= 1
          if depth == 0 {
            break LOOP
          }
        }
      case "/":
        // Check for a '/*'
        if self.advance(matching: "*") {
          depth += 1
        }

      case "\n", "\r":
        newlinePresence = .present
        continue
      case nil:
        error = LexingDiagnostic(.unterminatedBlockComment, position: slashPosition)
        break LOOP
      case .some:
        continue
      }
    }

    return TriviaResult(newlinePresence: newlinePresence, error: error)
  }

  /// If this is the opening delimiter of a raw string literal, return the number
  /// of `#` in the raw string delimiter.
  /// Assumes that the parser is currently pointing at the first `#`.
  mutating func advanceIfOpeningRawStringDelimiter() -> Int? {
    precondition(self.is(at: "#"))

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

  /// If we are positioned at the start of a multiline string delimiter, consume
  /// that delimiter and return `true`, otherwise return `false`.
  ///
  /// Assumes that the lexer is currently pointing at the character after the first `"`.
  /// In other words, the `"` is expected to already be consumed.
  ///
  /// `openingRawStringDelimiters` are the number of `#` that are preceding the `"`.
  /// This is used to disambiguate e.g. `#"""#` as a single-line string literal.
  /// If we are looking for the closing `"""` of a string literal, this is `nil`.
  mutating func advanceIfMultilineStringDelimiter(
    openingRawStringDelimiters: Int?
  ) -> Bool {
    precondition(self.previous == #"""#)
    // Test for single-line string literals that resemble multiline delimiter.
    var sameLineCloseCheck = self
    _ = sameLineCloseCheck.advance()
    if let openingRawStringDelimiters, openingRawStringDelimiters != 0 {
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
    case " ", "\r", "\n", "\t",  // whitespace
      "(", "[", "{",  // opening delimiters
      ",", ";", ":",  // expression separators
      0:  // whitespace / last char in file
      return false
    case "/":
      if self.peekBack(by: 2, bufferBegin: sourceBufferStart) == "*" {
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
    case " ", "\r", "\n", "\t",  // whitespace
      ")", "]", "}",  // closing delimiters
      ",", ";", ":":  // expression separators
      return false

    case 0:
      //        if (tokEnd == codeCompletionPtr) {         // code-completion
      //          return true
      //        }
      return false  // whitespace / last char in file

    case ".":
      // Prefer the '^' in "x^.y" to be a postfix op, not binary, but the '^' in
      // "^.y" to be a prefix op, not binary.
      return !isLeftBound

    case "/":
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
  private mutating func lexNormal(
    sourceBufferStart: Lexer.Cursor,
    preferRegexOverBinaryOperator: Bool
  ) -> Lexer.Result {
    switch self.peek() {
    case "@": _ = self.advance(); return Lexer.Result(.atSign)
    case "{": _ = self.advance(); return Lexer.Result(.leftBrace)
    case "[": _ = self.advance(); return Lexer.Result(.leftSquare)
    case "(": _ = self.advance(); return Lexer.Result(.leftParen)
    case "}": _ = self.advance(); return Lexer.Result(.rightBrace)
    case "]": _ = self.advance(); return Lexer.Result(.rightSquare)
    case ")": _ = self.advance(); return Lexer.Result(.rightParen)

    case ",": _ = self.advance(); return Lexer.Result(.comma)
    case ";": _ = self.advance(); return Lexer.Result(.semicolon)
    case ":": _ = self.advance(); return Lexer.Result(.colon)
    case "\\": _ = self.advance(); return Lexer.Result(.backslash)

    case "#":
      // Try lex shebang.
      if self.isAtStartOfFile, self.peek(at: 1) == "!" {
        self.advanceToEndOfLine()
        return Lexer.Result(.shebang)
      }
      // Try lex a raw string literal.
      if let delimiterLength = self.advanceIfOpeningRawStringDelimiter() {
        return Lexer.Result(.rawStringPoundDelimiter, stateTransition: .push(newState: .afterRawStringDelimiter(delimiterLength: delimiterLength)))
      }

      // Try lex a regex literal.
      if let result = self.lexRegexLiteral() {
        return result
      }
      // Otherwise try lex a magic pound literal.
      return self.lexMagicPoundLiteral()

    case "!", "?":
      if let result = lexPostfixOptionalChain(sourceBufferStart: sourceBufferStart) {
        return result
      }
      return self.lexOperatorIdentifier(
        sourceBufferStart: sourceBufferStart,
        preferRegexOverBinaryOperator: preferRegexOverBinaryOperator
      )

    case "<":
      if self.is(offset: 1, at: "#"),
        let result = self.tryLexEditorPlaceholder(sourceBufferStart: sourceBufferStart)
      {
        return result
      }
      return self.lexOperatorIdentifier(
        sourceBufferStart: sourceBufferStart,
        preferRegexOverBinaryOperator: preferRegexOverBinaryOperator
      )

    case "A", "B", "C", "D", "E", "F", "G", "H", "I",
      "J", "K", "L", "M", "N", "O", "P", "Q", "R",
      "S", "T", "U", "V", "W", "X", "Y", "Z",
      "a", "b", "c", "d", "e", "f", "g", "h", "i",
      "j", "k", "l", "m", "n", "o", "p", "q", "r",
      "s", "t", "u", "v", "w", "x", "y", "z", "_":
      return self.lexIdentifier()

    case "$":
      return self.lexDollarIdentifier()

    case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
      return self.lexNumber()
    case #"'"#, #"""#:
      return self.lexStringQuote(isOpening: true, leadingDelimiterLength: 0)

    case "`":
      return self.lexEscapedIdentifier()
    case nil:
      return Lexer.Result(.endOfFile)
    default:
      var tmp = self
      if tmp.advance(if: { $0.isValidIdentifierStartCodePoint }) {
        return self.lexIdentifier()
      }

      if tmp.advance(if: { $0.isOperatorStartCodePoint }) {
        return self.lexOperatorIdentifier(
          sourceBufferStart: sourceBufferStart,
          preferRegexOverBinaryOperator: preferRegexOverBinaryOperator
        )
      }

      switch self.lexUnknown() {
      case .lexemeContents(let result):
        return result
      case .trivia:
        preconditionFailure("Invalid UTF-8 sequence should be eaten by lexTrivia as LeadingTrivia")
      }
    }
  }

  private mutating func lexAfterRawStringDelimiter(delimiterLength: Int) -> Lexer.Result {
    switch self.peek() {
    case #"'"#, #"""#:
      return self.lexStringQuote(isOpening: true, leadingDelimiterLength: delimiterLength)
    case nil:
      return Lexer.Result(.endOfFile)
    default:
      preconditionFailure("state 'afterRawStringDelimiter' expects to be positioned at a quote")
    }
  }

  private mutating func lexAfterStringLiteral() -> Lexer.Result {
    switch self.peek() {
    case #"'"#, #"""#:
      return self.lexStringQuote(isOpening: false, leadingDelimiterLength: 0)
    case nil:
      return Lexer.Result(.endOfFile)
    default:
      preconditionFailure("state 'isAfterStringLiteral' expects to be positioned at a quote")
    }
  }

  private mutating func lexAfterClosingStringQuote() -> Lexer.Result {
    switch self.peek() {
    case "#":
      self.advance(while: { $0 == "#" })
      return Lexer.Result(.rawStringPoundDelimiter, stateTransition: .pop)
    case nil:
      return Lexer.Result(.endOfFile)
    default:
      preconditionFailure("state 'afterClosingStringQuote' expects to be positioned at a '#'")
    }
  }

  private mutating func lexInStringInterpolationStart(stringLiteralKind: StringLiteralKind) -> Lexer.Result {
    switch self.peek() {
    case "\\":
      _ = self.advance()
      return Lexer.Result(.backslash)
    case "#":
      /// Consume the '#' that are part of this interpolation. We know that the
      /// number of '#' is correct because otherwise `isAtStringInterpolationAnchor`
      /// would have returned false in `lexInStringLiteral` and w we wouldn't have
      /// transitioned to the `afterBackslashOfStringInterpolation` state.
      self.advance(while: { $0 == "#" })
      return Lexer.Result(.rawStringPoundDelimiter)
    case "(":
      _ = self.advance()
      return Lexer.Result(.leftParen, stateTransition: .replace(newState: .inStringInterpolation(stringLiteralKind: stringLiteralKind, parenCount: 0)))
    case nil:
      return Lexer.Result(.endOfFile)
    default:
      preconditionFailure("state 'afterBackslashOfStringInterpolation' expects to be positioned at '#' or '('")
    }
  }

  private mutating func lexInStringInterpolation(stringLiteralKind: StringLiteralKind, parenCount: Int, sourceBufferStart: Lexer.Cursor) -> Lexer.Result {
    // Keep track of open parentheses
    switch self.peek() {
    case "(":
      _ = self.advance()
      return Lexer.Result(
        .leftParen,
        stateTransition: .replace(newState: .inStringInterpolation(stringLiteralKind: stringLiteralKind, parenCount: parenCount + 1))
      )
    case ")":
      _ = self.advance()
      if parenCount == 0 {
        return Lexer.Result(.rightParen, stateTransition: .pop)
      } else {
        return Lexer.Result(
          .rightParen,
          stateTransition: .replace(newState: .inStringInterpolation(stringLiteralKind: stringLiteralKind, parenCount: parenCount - 1))
        )
      }
    case "\r", "\n":
      // We don't eat newlines as leading trivia in string interpolation of
      // single line strings but  `lexNormal` expects newlines to already be
      // eaten. If we reach a newline inside string interpolation of a
      // single-line string, emit an empty string segment to indicate to the
      // parser that the string has ended and pop out of string interpolation.
      precondition(stringLiteralKind != .multiLine)
      return Lexer.Result(.stringSegment, stateTransition: .pop)
    default:
      // If we haven't reached the end of the string interpolation, lex as if we were in a normal expression.
      return self.lexNormal(sourceBufferStart: sourceBufferStart, preferRegexOverBinaryOperator: false)
    }
  }
}

// MARK: - Trivia

extension Lexer.Cursor {
  enum NewlinePresence {
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

  struct TriviaResult {
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
      case "\n":
        if mode == .noNewlines {
          break
        }
        newlinePresence = .present
        continue
      case "\r":
        if mode == .noNewlines {
          break
        }
        newlinePresence = .present
        continue

      case " ":
        continue
      case "\t":
        continue
      case "\u{000B}":
        continue
      case "\u{000C}":
        continue
      case "/":
        switch self.peek() {
        case "/":
          self.advanceToEndOfLine()
          continue
        case "*":
          let starSlashResult = self.advanceToEndOfSlashStarComment(slashPosition: start)
          if starSlashResult.newlinePresence == .present {
            newlinePresence = .present
          }
          error = error ?? starSlashResult.error
          continue
        default:
          break
        }
      case "<", ">":
        if self.tryLexConflictMarker(start: start) {
          error = LexingDiagnostic(.sourceConflictMarker, position: start)
          continue
        }
      // Start character of tokens.
      //        case (char)-1: case (char)-2:
      case  // Punctuation.
      "{", "[", "(", "}", "]", ")", "@",
        ",", ";", ":", "\\", "$", "#",

        // Start of integer/hex/float literals.
        "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",

        // Start of literals.
        #"""#, #"'"#, "`",

        // Start of identifiers.
        "A", "B", "C", "D", "E", "F", "G", "H", "I",
        "J", "K", "L", "M", "N", "O", "P", "Q", "R",
        "S", "T", "U", "V", "W", "X", "Y", "Z",
        "a", "b", "c", "d", "e", "f", "g", "h", "i",
        "j", "k", "l", "m", "n", "o", "p", "q", "r",
        "s", "t", "u", "v", "w", "x", "y", "z", "_",

        // Start of operators.
        "%", "!", "?", "=", "-", "+", "*", "&", "|", "^", "~", ".":
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
  mutating func lexNumber() -> Lexer.Result {
    precondition(self.peek().map(Unicode.Scalar.init)?.isDigit == true, "Unexpected start")

    if self.is(at: "0") && self.is(offset: 1, at: "x") {
      return self.lexHexNumber()
    }

    if self.is(at: "0") && self.is(offset: 1, at: "o") {
      // 0o[0-7][0-7_]*

      let zeroConsumed = self.advance(matching: "0")  // Consume '0'
      let oConsumed = self.advance(matching: "o")  // Consume 'o'
      precondition(zeroConsumed && oConsumed)
      if let peeked = self.peek(), peeked < UInt8(ascii: "0") || peeked > UInt8(ascii: "7") {
        let errorPos = self
        self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
        return Lexer.Result(
          .integerLiteral,
          error: LexingDiagnostic(.invalidOctalDigitInIntegerLiteral, position: errorPos)
        )
      }

      self.advance(while: { ($0 >= "0" && $0 <= "7") || $0 == "_" })

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
      precondition(zeroConsumed && bConsumed)
      if self.is(notAt: "0", "1") {
        let errorPos = self
        self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
        return Lexer.Result(
          .integerLiteral,
          error: LexingDiagnostic(.invalidBinaryDigitInIntegerLiteral, position: errorPos)
        )
      }

      self.advance(while: { $0 == "0" || $0 == "1" || $0 == "_" })

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
    self.advance(while: { $0.isDigit || $0 == "_" })

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
      self.advance(while: { $0.isDigit || $0 == "_" })
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
          .floatLiteral,
          error: LexingDiagnostic(errorKind, position: errorPos)
        )
      }

      self.advance(while: { $0.isDigit || $0 == "_" })

      let tmp = self
      if self.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
        let errorPos = tmp
        self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
        return Lexer.Result(
          .floatLiteral,
          error: LexingDiagnostic(.invalidFloatingPointExponentDigit, position: errorPos)
        )
      }
    }

    return Lexer.Result(.floatLiteral)
  }

  mutating func lexHexNumber() -> Lexer.Result {
    // We assume we're starting from the 'x' in a '0x...' floating-point literal.
    let zeroConsumed = self.advance(matching: "0")
    let xConsumed = self.advance(matching: "x")
    precondition(zeroConsumed && xConsumed, "not a hex literal")

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

    self.advance(while: { $0.isHexDigit || $0 == "_" })

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

      self.advance(while: { $0.isHexDigit || $0 == "_" })

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
    precondition(self.isAtEndOfFile || pConsumed, "not at a hex float exponent?!")

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
        .floatLiteral,
        error: LexingDiagnostic(errorKind, position: errorPos)
      )
    }

    self.advance(while: { $0.isDigit || $0 == "_" })

    let tmp = self
    if self.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
      let errorPos = tmp
      self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
      return Lexer.Result(
        .floatLiteral,
        error: LexingDiagnostic(.invalidFloatingPointExponentDigit, position: errorPos)
      )
    }
    return Lexer.Result(.floatLiteral)
  }
}

extension Lexer.Cursor {
  mutating func lexMagicPoundLiteral() -> Lexer.Result {
    let poundConsumed = self.advance(matching: "#")
    precondition(poundConsumed)
    var tmp = self
    // Scan for [a-zA-Z]+ to see what we match.
    while let peeked = tmp.peek(), Unicode.Scalar(peeked).isAsciiIdentifierStart {
      _ = tmp.advance()
    }

    let literal = self.text(upTo: tmp)

    let kind: RawTokenKind
    switch literal {
    case "sourceLocation": kind = .poundSourceLocation
    case "if": kind = .poundIf
    case "else": kind = .poundElse
    case "elseif": kind = .poundElseif
    case "endif": kind = .poundEndif
    case "available": kind = .poundAvailable
    case "unavailable": kind = .poundUnavailable
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
    /// this is a valid unicode scalar.
    case validatedEscapeSequence(Unicode.Scalar)

    /// The end of a string literal has been reached.
    case endOfString

    /// The character could not be lexed because it's not a valid Unicode character.
    case error(TokenDiagnostic.Kind)
  }

  /// Lexes a single character in a string literal, handling escape sequences
  /// like `\n` or `\u{1234}` as a single character.
  mutating func lexCharacterInStringLiteral(stringLiteralKind: StringLiteralKind, delimiterLength: Int) -> CharacterLex {
    switch self.peek() {
    case #"""#:
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
    case #"'"#:
      switch stringLiteralKind {
      case .singleQuote:
        let quoteConsumed = self.advance(matching: "'")
        precondition(quoteConsumed)
        return .endOfString
      case .singleLine, .multiLine:
        // Otherwise, this is just a character.
        let character = self.advance()!
        return .success(Unicode.Scalar(character))
      }
    case 0:
      _ = self.advance()
      return .error(.nulCharacter)
    case "\n", "\r":  // String literals cannot have \n or \r in them.
      let character = self.advance()!
      precondition(stringLiteralKind == .multiLine, "Caller must handle newlines in non-multiline")
      return .success(Unicode.Scalar(character))

    case "\\":  // Escapes.
      _ = self.advance()
      if !self.advanceIfStringDelimiter(delimiterLength: delimiterLength) {
        return .success("\\")
      }
      switch self.lexEscapedCharacter(isMultilineString: stringLiteralKind == .multiLine) {
      case .success(let codePoint):
        return .validatedEscapeSequence(codePoint)
      case .error(let kind):
        return .error(kind)
      }
    default:
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
    case success(Unicode.Scalar)
    case error(TokenDiagnostic.Kind)
  }

  /// Assuming that we are in a string literal and have already consumed a `\`,
  /// consume the escaped characters and return the Unicode character code
  /// (i.e. UTF-32 value) that the escaped character represents.
  ///
  /// If the character is not a valid escape sequence, return `nil`.
  private mutating func lexEscapedCharacter(isMultilineString: Bool) -> EscapedCharacterLex {
    precondition(self.previous == "\\" || self.previous == "#")
    // Escape processing.  We already ate the "\".
    switch self.peek() {
    // Simple single-character escapes.
    case "0": _ = self.advance(); return .success("\0")
    case "n": _ = self.advance(); return .success("\n")
    case "r": _ = self.advance(); return .success("\r")
    case "t": _ = self.advance(); return .success("\t")
    case #"""#: _ = self.advance(); return .success(#"""#)
    case "'": _ = self.advance(); return .success("'")
    case "\\": _ = self.advance(); return .success("\\")

    case "u":  // e.g. \u{1234}
      _ = self.advance()

      guard self.is(at: "{") else {
        return .error(.expectedHexCodeInUnicodeEscape)
      }

      return self.lexUnicodeEscape()
    case "\n", "\r":
      if isMultilineString && self.maybeConsumeNewlineEscape() {
        return .success("\n")
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
    precondition(quoteConsumed)

    let digitStart = self
    self.advance(while: { $0.isHexDigit })

    let digitText = SyntaxText(
      baseAddress: digitStart.pointer,
      count: digitStart.distance(to: self)
    )

    guard self.advance(matching: "}") else {
      return .error(.expectedClosingBraceInUnicodeEscape)
    }

    guard 1 <= digitText.count && digitText.count <= 8 else {
      return .error(.invalidNumberOfHexDigitsInUnicodeEscape)
    }

    guard
      // FIXME: Implement 'UInt32(_: SyntaxText, radix:)'.
      let codePoint = UInt32(String(syntaxText: digitText), radix: 16),
      let scalar = Unicode.Scalar.init(codePoint)
    else {
      return .error(.invalidEscapeSequenceInStringLiteral)
    }

    return .success(scalar)
  }

  private mutating func maybeConsumeNewlineEscape() -> Bool {
    var tmp = self
    while true {
      switch tmp.advance() {
      case " ", "\t":
        continue
      case "\r":
        _ = tmp.advance(if: { $0 == "\n" })
        fallthrough
      case "\n":
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
    case .normal, .preferRegexOverBinaryOperator, .inStringInterpolation:
      return .push(newState: .inStringLiteral(kind: kind, delimiterLength: 0))
    case .inRegexLiteral, .inStringLiteral, .afterClosingStringQuote, .inStringInterpolationStart:
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
    precondition(firstQuoteConsumed)

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
          if isSingleLineString.advance(if: { $0 == #"""# }) {
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
    precondition(backslashConsumed)
    guard tmp.advanceIfStringDelimiter(delimiterLength: delimiterLength) else {
      return false
    }
    tmp.advance(while: { $0 == " " || $0 == "\t" })
    return tmp.is(at: "\r", "\n")
  }

  mutating func lexInStringLiteral(stringLiteralKind: StringLiteralKind, delimiterLength: Int) -> Lexer.Result {
    if self.isAtEndOfFile { return .init(.endOfFile) }

    var error: LexingDiagnostic? = nil

    while true {
      switch self.peek() {
      case "\\":
        if self.isAtStringInterpolationAnchor(delimiterLength: delimiterLength) {
          return Lexer.Result(
            .stringSegment,
            error: error,
            stateTransition: .push(newState: .inStringInterpolationStart(stringLiteralKind: stringLiteralKind))
          )
        } else if stringLiteralKind == .multiLine && self.isAtEscapedNewline(delimiterLength: delimiterLength) {
          return Lexer.Result(
            .stringSegment,
            trailingTriviaLexingMode: .escapedNewlineInMultiLineStringLiteral
          )
        }
      case "\r", "\n":
        if stringLiteralKind == .multiLine {
          // Make sure each line starts a new string segment so the parser can
          // validate the multi-line string literal's indentation.
          let character = self.advance()
          if character == "\r" {
            _ = self.advance(matching: "\n")
          }
          return Lexer.Result(.stringSegment, error: error, trailingNewlinePresence: .present)
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
        // Only overwrite error if we had not found an earlier error yet
        if error == nil {
          error = LexingDiagnostic(errorKind, position: self)
        }
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
    precondition(didStart, "Unexpected start")

    // Lex [a-zA-Z_$0-9[[:XID_Continue:]]]*
    self.advance(while: { $0.isValidIdentifierContinuationCodePoint })

    let text = tokStart.text(upTo: self)
    if let keyword = Keyword(text), keyword.isLexerClassified {
      return Lexer.Result.keyword(keyword)
    } else if text == "_" {
      return Lexer.Result(.wildcard)
    } else {
      return Lexer.Result(.identifier)
    }
  }

  mutating func lexEscapedIdentifier() -> Lexer.Result {
    let quote = self
    let backtickConsumed = self.advance(matching: "`")
    precondition(backtickConsumed, "Unexpected start of escaped identifier")

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
      precondition(firstBacktickConsumed && dollarConsumed && secondBacktickConsumed)
      return Lexer.Result(.identifier)
    }

    // The backtick is punctuation.
    self = identifierStart
    return Lexer.Result(.backtick)
  }

  /// Attempt to lex a postfix '!' or '?'.
  mutating func lexPostfixOptionalChain(sourceBufferStart: Lexer.Cursor) -> Lexer.Result? {
    // Must be left bound, otherwise this isn't postfix.
    guard self.isLeftBound(sourceBufferStart: sourceBufferStart) else { return nil }

    var transition: Lexer.StateTransition?
    if previousKeyword == .try {
      // If we have 'try' as the previous keyword kind, we have `try?` or `try!`
      // and need to transition into the state where we prefer lexing a regex
      // literal over a binary operator. See the comment in
      // `tryScanOperatorAsRegexLiteral` for more info.
      transition = .push(newState: .preferRegexOverBinaryOperator)
    }
    let kind: RawTokenKind = {
      switch self.peek() {
      case "!":
        return .exclamationMark
      case "?":
        return .postfixQuestionMark
      default:
        preconditionFailure("Must be at '!' or '?'")
      }
    }()
    _ = self.advance()
    return Lexer.Result(kind, stateTransition: transition)
  }

  /// Classify an operator token given its start and ending cursor.
  static func classifyOperatorToken(
    operStart: Lexer.Cursor,
    operEnd: Lexer.Cursor,
    sourceBufferStart: Lexer.Cursor
  ) -> (RawTokenKind, error: LexingDiagnostic?) {
    // Decide between the binary, prefix, and postfix cases.
    // It's binary if either both sides are bound or both sides are not bound.
    // Otherwise, it's postfix if left-bound and prefix if right-bound.
    let leftBound = operStart.isLeftBound(sourceBufferStart: sourceBufferStart)
    let rightBound = operEnd.isRightBound(isLeftBound: leftBound)

    // Match various reserved words.
    if operEnd.input.baseAddress! - operStart.input.baseAddress! == 1 {
      switch operStart.peek() {
      case "=":
        if leftBound != rightBound {
          var errorPos = operStart

          if rightBound {
            _ = errorPos.advance()
          }

          return (
            .equal,
            error: LexingDiagnostic(
              .equalMustHaveConsistentWhitespaceOnBothSides,
              position: errorPos
            )
          )
        } else {
          return (.equal, error: nil)
        }
      case "&":
        if leftBound == rightBound || leftBound {
          break
        }
        return (.prefixAmpersand, error: nil)
      case ".":
        return (.period, error: nil)
      case "?":
        if (leftBound) {
          return (.postfixQuestionMark, error: nil)
        }
        return (.infixQuestionMark, error: nil)
      default:
        break
      }
    } else if (operEnd.input.baseAddress! - operStart.input.baseAddress! == 2) {
      switch (operStart.peek(), operStart.peek(at: 1)) {
      case ("-", ">"):  // ->
        return (.arrow, error: nil)
      case ("*", "/"):  // */
        return (.unknown, error: LexingDiagnostic(.unexpectedBlockCommentEnd, position: operStart))
      default:
        break
      }
    } else {
      // Verify there is no "*/" in the middle of the identifier token, we reject
      // it as potentially ending a block comment.
      if operStart.text(upTo: operEnd).contains("*/") {
        return (.unknown, error: LexingDiagnostic(.unexpectedBlockCommentEnd, position: operStart))
      }
    }

    if leftBound == rightBound {
      return (.binaryOperator, error: nil)
    } else if leftBound {
      return (.postfixOperator, error: nil)
    } else {
      return (.prefixOperator, error: nil)
    }
  }

  mutating func lexOperatorIdentifier(
    sourceBufferStart: Lexer.Cursor,
    preferRegexOverBinaryOperator: Bool
  ) -> Lexer.Result {
    let tokStart = self
    let didStart = self.advance(if: { $0.isOperatorStartCodePoint })
    precondition(didStart, "unexpected operator start")

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
    } while self.advance(if: { $0.isOperatorContinuationCodePoint })

    // Check to see if we have a regex literal starting in the operator.
    do {
      var regexScan = tokStart
      while regexScan.input.baseAddress! < self.input.baseAddress! {
        // Scan for the first '/' in the operator to see if it starts a regex
        // literal.
        guard regexScan.is(at: "/") else {
          _ = regexScan.advance()
          continue
        }
        guard
          let result = self.tryLexOperatorAsRegexLiteral(
            at: regexScan,
            operatorStart: tokStart,
            operatorEnd: self,
            sourceBufferStart: sourceBufferStart,
            preferRegexOverBinaryOperator: preferRegexOverBinaryOperator
          )
        else { break }
        return result
      }
    }

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
    let (kind, error) = Self.classifyOperatorToken(
      operStart: tokStart,
      operEnd: self,
      sourceBufferStart: sourceBufferStart
    )
    return Lexer.Result(kind, error: error)
  }

  mutating func lexDollarIdentifier() -> Lexer.Result {
    let tokStart = self
    let dollarConsumed = self.advance(matching: "$")
    precondition(dollarConsumed)

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
  mutating func tryLexEditorPlaceholder(sourceBufferStart: Lexer.Cursor) -> Lexer.Result? {
    precondition(self.is(at: "<") && self.is(offset: 1, at: "#"))
    let start = self
    var ptr = self
    let leftAngleConsumed = ptr.advance(matching: "<")
    let poundConsumed = ptr.advance(matching: "#")
    precondition(leftAngleConsumed && poundConsumed)
    LOOP: while let consumed = ptr.advance() {
      switch consumed {
      case "\n":
        break LOOP
      case "<" where ptr.is(at: "#"):
        break LOOP
      case "#" where ptr.is(at: ">"):
        let closingAngleConsumed = ptr.advance(matching: ">")
        precondition(closingAngleConsumed)
        self = ptr
        return Lexer.Result(
          .identifier,
          error: LexingDiagnostic(.editorPlaceholder, position: start)
        )
      default:
        break
      }
    }

    // Not a well-formed placeholder.
    return nil
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
      case .endOfString, .success("\u{201D}"):
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

  /// Assuming the cursor is positioned at neither a valid identifier nor a
  /// valid operator start, advance the cursor by what can be considered a
  /// lexeme.
  mutating func lexUnknown() -> UnknownCharactersClassification {
    precondition(!(self.peekScalar()?.isValidIdentifierStartCodePoint ?? false) && !(self.peekScalar()?.isOperatorStartCodePoint ?? false))
    let start = self
    var tmp = self
    if tmp.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
      // If this is a valid identifier continuation, but not a valid identifier
      // start, attempt to recover by eating more continuation characters.
      tmp.advance(while: { $0.isValidIdentifierContinuationCodePoint })
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
    guard start.previous == "\n" || start.previous == "\r" || start.previous == 0 else {
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
      let terminatorStart = markerKind.terminator.unicodeScalars.first!
      restOfBuffer.advance(while: { byte in byte != terminatorStart })

      guard restOfBuffer.starts(with: markerKind.terminator.utf8) else {
        _ = restOfBuffer.advance()
        continue
      }

      // Must occur at start of line.
      guard restOfBuffer.previous == "\n" || restOfBuffer.previous == "\r" else {
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
