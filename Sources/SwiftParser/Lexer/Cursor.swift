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

enum LexerCursorState: Equatable {
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
  case afterStringLiteral(delimiterLength: Int)

  /// The lexer has lexed the closing quote of a string literal that had raw
  /// string delimiters and is now looking for the closing raw string delimiters.
  case afterClosingStringQuote(delimiterLength: Int)

  func shouldLexTrivia(cursor: Lexer.Cursor) -> Bool {
    switch self {
    case .normal: return true
    case .afterRawStringDelimiter: return false
    case .inStringLiteral(kind: let kind, delimiterLength: _):
      switch kind {
      case .singleLine, .singleQuote:
        return cursor.peek(matches: "\r", "\n")
      case .multiLine: return false
      }
    case .afterStringLiteral: return false
    case .afterClosingStringQuote: return false
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
  struct Cursor: Equatable {
    var input: UnsafeBufferPointer<UInt8>
    var previous: UInt8
    var state: LexerCursorState

    init(input: UnsafeBufferPointer<UInt8>, previous: UInt8, state: LexerCursorState) {
      self.input = input
      self.previous = previous
      self.state = state
    }

    public static func == (lhs: Cursor, rhs: Cursor) -> Bool {
      return lhs.input.baseAddress == rhs.input.baseAddress && lhs.previous == rhs.previous && lhs.state == rhs.state
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
}

// MARK: - Peeking

extension Lexer.Cursor {
  func peek(at offset: Int = 0) -> UInt8? {
    assert(offset >= 0)
    guard offset < self.input.count else {
      return nil
    }
    return self.input[offset]
  }

  /// Essentially a UInt8 that is expressible by integer and string literals.
  struct PeekMatch: ExpressibleByUnicodeScalarLiteral, ExpressibleByIntegerLiteral {
    let value: UInt8

    init(unicodeScalarLiteral value: Unicode.Scalar) {
      self.value = UInt8(ascii: Unicode.Scalar(unicodeScalarLiteral: value))
    }

    init(integerLiteral value: UInt8) {
      self.value = value
    }
  }

  // MARK: Positive matches

  /// Stamped out copy of `peek(at:matches:)` in case we are matching a single
  /// character to avoid construction of an array.
  func peek(at offset: Int = 0, matches character: PeekMatch) -> Bool {
    guard let peeked = self.peek(at: offset) else {
      return false
    }
    return peeked == character.value
  }

  /// Stamped out copy of `peek(at:matches:)` in case we are matching two
  /// characters to avoid construction of an array.
  func peek(at offset: Int = 0, matches character1: PeekMatch, _ character2: PeekMatch) -> Bool {
    guard let peeked = self.peek(at: offset) else {
      return false
    }
    return peeked == character1.value || peeked == character2.value
  }

  /// Returns `true` if we are not at the end of the file and the character at
  /// offset `offset` is in `characters`.
  @_disfavoredOverload  // favor the stamped out copies
  func peek(at offset: Int = 0, matches characters: PeekMatch...) -> Bool {
    guard let peeked = self.peek(at: offset) else {
      return false
    }
    return characters.contains { peeked == $0.value }
  }

  // MARK: Negative matches

  /// Stamped out copy of `peek(at:doesntMatch:)` in case we are matching two
  /// characters to avoid construction of an array.
  func peek(at offset: Int = 0, doesntMatch character: PeekMatch) -> Bool {
    guard let peeked = self.peek(at: offset) else {
      return false
    }
    return peeked != character.value
  }

  /// Stamped out copy of `peek(at:doesntMatch:)` in case we are matching two
  /// characters to avoid construction of an array.
  func peek(at offset: Int = 0, doesntMatch character1: PeekMatch, _ character2: PeekMatch) -> Bool {
    guard let peeked = self.peek(at: offset) else {
      return false
    }
    return peeked != character1.value && peeked != character2.value
  }

  /// Returns `true` if we are not at the end of the file and the character at
  /// offset `offset` is not in `characters`.
  @_disfavoredOverload  // favor the stamped out copies
  func peek(at offset: Int = 0, doesntMatch characters: PeekMatch...) -> Bool {
    guard let peeked = self.peek(at: offset) else {
      return false
    }
    return characters.allSatisfy { peeked != $0.value }
  }
}

extension Lexer.Cursor {
  func isLeftBound(_ bufferBegin: Lexer.Cursor) -> Bool {
    // The first character in the file is not left-bound.
    if self.input.baseAddress == bufferBegin.input.baseAddress {
      return false
    }

    switch self.previous {
    case UInt8(ascii: " "), UInt8(ascii: "\r"), UInt8(ascii: "\n"), UInt8(ascii: "\t"),  // whitespace
      UInt8(ascii: "("), UInt8(ascii: "["), UInt8(ascii: "{"),  // opening delimiters
      UInt8(ascii: ","), UInt8(ascii: ";"), UInt8(ascii: ":"),  // expression separators
      0:  // whitespace / last char in file
      return false
    case UInt8(ascii: "/"):
      if self.input.baseAddress! - 1 != bufferBegin.input.baseAddress
        && self.input.baseAddress!.advanced(by: -2).pointee == UInt8(ascii: "*")
      {
        return false  // End of a slash-star comment, so whitespace.
      } else {
        return true
      }
    case 0xA0:
      if self.input.baseAddress! - 1 != bufferBegin.input.baseAddress
        && self.input.baseAddress!.advanced(by: -2).pointee == 0xC2
      {
        return false  // End of a Non-breaking whitespace (U+00A0).
      } else {
        return true
      }
    default:
      return true
    }
  }

  func isRightBound(_ isLeftBound: Bool) -> Bool {
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
      if (self.peek(at: 1, matches: "/", "*")) {
        return false
      } else {
        return true
      }
    case 0xC2:
      if self.peek(at: 1, matches: 0xA0) {
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

extension Lexer.Cursor {
  func textUpTo(_ other: Lexer.Cursor) -> SyntaxText {
    let count = other.input.baseAddress! - self.input.baseAddress!
    assert(count >= 0)
    return SyntaxText(baseAddress: self.input.baseAddress, count: count)
  }
}

extension Lexer.Cursor {
  mutating func backUp(by offset: Int) {
    assert(!self.isAtStartOfFile)
    self.previous = self.input.baseAddress!.advanced(by: -(offset + 1)).pointee
    self.input = UnsafeBufferPointer(start: self.input.baseAddress!.advanced(by: -offset), count: self.input.count + offset)
  }

  mutating func advance() -> UInt8? {
    var input = self.input[...]
    guard let c = input.popFirst() else {
      return nil  // end of input
    }
    self.previous = c
    self.input = UnsafeBufferPointer(rebasing: input)
    return c
  }

  mutating func advance(matching: UInt8) -> UInt8? {
    guard self.peek() == matching else {
      return nil
    }
    return self.advance()
  }

  mutating func advance(while predicate: (Unicode.Scalar) -> Bool) {
    var next = self
    while !next.isAtEndOfFile,
      let c = next.validateUTF8CharacterAndAdvance(),
      predicate(c)
    {
      self = next
    }
  }

  mutating func advance(if predicate: (Unicode.Scalar) -> Bool) -> Bool {
    guard !self.isAtEndOfFile else {
      return false
    }

    var tmp = self
    guard let c = tmp.validateUTF8CharacterAndAdvance() else {
      return false
    }

    guard predicate(c) else {
      return false
    }

    self = tmp
    return true
  }

  mutating func advanceToEndOfLine() -> Bool {
    while true {
      switch self.peek() {
      case UInt8(ascii: "\n"):
        fallthrough
      case UInt8(ascii: "\r"):
        return true
      case nil:
        return false
      case .some:
        _ = self.advance()
      }
    }
  }

  mutating func advanceToEndOfSlashStarComment() -> Bool {
    // Make sure to advance over the * so that we don't incorrectly handle /*/ as
    // the beginning and end of the comment.
    _ = self.advance()

    var depth = 1
    var isMultiline = false

    while true {
      switch self.advance() {
      case UInt8(ascii: "*"):
        // Check for a '*/'
        if self.advance(if: { $0 == Unicode.Scalar("/") }) {
          depth -= 1
          if depth == 0 {
            return isMultiline
          }
        }
      case UInt8(ascii: "/"):
        // Check for a '/*'
        if self.advance(if: { $0 == Unicode.Scalar("*") }) {
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

  mutating func advanceIfCustomDelimiter() -> Int? {
    assert(self.previous == UInt8(ascii: "#"))

    var clone = self
    var length = 1
    clone.advance(while: { char in
      let isDelimeter = (char == Unicode.Scalar("#"))
      if isDelimeter { length += 1 }
      return isDelimeter
    })

    guard clone.peek(matches: #"""#) else {
      return nil
    }
    self = clone
    return length
  }

  /// advanceIfMultilineDelimiter - Centralized check for multiline delimiter.
  mutating func advanceIfMultilineDelimiter(
    _ customDelimiterLen: Int,
    _ isOpening: Bool = false
  ) -> Bool {
    // Test for single-line string literals that resemble multiline delimiter.
    var tmpPtr = self
    _ = tmpPtr.advance()
    if isOpening && customDelimiterLen != 0 {
      while tmpPtr.peek(doesntMatch: "\r", "\n") {
        if tmpPtr.advance(if: { $0 == Unicode.Scalar(UInt8(ascii: #"""#)) }) {
          if tmpPtr.delimiterMatches(customDelimiterLen) {
            return false
          }
          continue
        }
        _ = tmpPtr.advance()
      }
    }

    tmpPtr = self
    if (tmpPtr.previous == UInt8(ascii: #"""#) && tmpPtr.advance(matching: UInt8(ascii: #"""#)) != nil && tmpPtr.advance(matching: UInt8(ascii: #"""#)) != nil) {
      self = tmpPtr
      return true
    }

    return false
  }

  mutating func lexStringQuote() -> Lexer.Result {
    func newState(currentState: LexerCursorState, kind: StringLiteralKind) -> LexerCursorState {
      switch currentState {
      case .afterStringLiteral(delimiterLength: 0):
        return .normal
      case .afterStringLiteral(delimiterLength: let delimiterLength):
        return .afterClosingStringQuote(delimiterLength: delimiterLength)
      case .afterRawStringDelimiter(delimiterLength: let delimiterLength):
        return .inStringLiteral(kind: kind, delimiterLength: delimiterLength)
      default:
        return .inStringLiteral(kind: kind, delimiterLength: 0)
      }
    }

    if self.previous == UInt8(ascii: "'") {
      return Lexer.Result(.singleQuote, newState: newState(currentState: self.state, kind: .singleQuote))
    }

    assert(self.previous == UInt8(ascii: #"""#))

    var lookingForMultilineString = self
    if lookingForMultilineString.advance(matching: UInt8(ascii: #"""#)) != nil, lookingForMultilineString.advance(matching: UInt8(ascii: #"""#)) != nil {
      if case .afterRawStringDelimiter(delimiterLength: let delimiterLength) = state {
        // If this is a string literal, check if we have the closing delimiter on the same line to correctly parse things like `#"""#` as a single line string containing a quote.
        var isSingleLineString = lookingForMultilineString

        if isSingleLineString.delimiterMatches(delimiterLength) {
          // If we have the correct number of delimiters now, we have something like `#"""#`.
          // This is a single-line string.
          return Lexer.Result(.stringQuote, newState: newState(currentState: self.state, kind: .singleLine))
        }

        // Scan ahead until the end of the line. Every time we see a closing
        // quote, check if it is followed by the correct number of closing delimiters.
        while isSingleLineString.peek(doesntMatch: "\r", "\n") {
          if isSingleLineString.advance(if: { $0 == Unicode.Scalar(UInt8(ascii: #"""#)) }) {
            if isSingleLineString.delimiterMatches(delimiterLength) {
              return Lexer.Result(.stringQuote, newState: newState(currentState: self.state, kind: .singleLine))
            }
            continue
          }
          _ = isSingleLineString.advance()
        }
      }

      self = lookingForMultilineString
      return Lexer.Result(.multilineStringQuote, newState: newState(currentState: self.state, kind: .multiLine))
    } else {
      return Lexer.Result(.stringQuote, newState: newState(currentState: self.state, kind: .singleLine))
    }
  }

  mutating func validateUTF8CharacterAndAdvance() -> Unicode.Scalar? {
    guard let curByte = self.advance() else {
      return nil
    }

    if (curByte < 0x80) {
      return Unicode.Scalar(curByte)
    }

    // Read the number of high bits set, which indicates the number of bytes in
    // the character.
    let encodedBytes = (~(UInt32(curByte) << 24)).leadingZeroBitCount
    func isStartOfUTF8Character(_ scalar: Unicode.Scalar) -> Bool {
      // RFC 2279: The octet values FE and FF never appear.
      // RFC 3629: The octet values C0, C1, F5 to FF never appear.
      let c = scalar.value
      return c <= 0x80 || (c >= 0xC2 && c < 0xF5)
    }
    // If this is 0b10XXXXXX, then it is a continuation character.
    if (encodedBytes == 1 || !isStartOfUTF8Character(Unicode.Scalar(curByte))) {
      // Skip until we get the start of another character.  This is guaranteed to
      // at least stop at the nul at the end of the buffer.
      self.advance(while: { !isStartOfUTF8Character($0) })
      return nil
    }

    // Drop the high bits indicating the # bytes of the result.
    var charValue = UInt32(curByte << encodedBytes) >> encodedBytes

    // Read and validate the continuation bytes.
    for _ in 1..<encodedBytes {
      guard let curByte = self.peek() else {
        return nil
      }
      // If the high bit isn't set or the second bit isn't clear, then this is not
      // a continuation byte!
      if (curByte < 0x80 || curByte >= 0xC0) {
        return nil
      }

      // Accumulate our result.
      charValue <<= 6
      charValue |= UInt32(curByte & 0x3F)
      _ = self.advance()
    }

    // UTF-16 surrogate pair values are not valid code points.
    if (charValue >= 0xD800 && charValue <= 0xDFFF) {
      return nil
    }

    // If we got here, we read the appropriate number of accumulated bytes.
    // Verify that the encoding was actually minimal.
    // Number of bits in the value, ignoring leading zeros.
    let numBits = 32 - charValue.leadingZeroBitCount
    if (numBits <= 5 + 6) {
      return encodedBytes == 2 ? Unicode.Scalar(charValue) : nil
    }
    if (numBits <= 4 + 6 + 6) {
      return encodedBytes == 3 ? Unicode.Scalar(charValue) : nil
    }
    return encodedBytes == 4 ? Unicode.Scalar(charValue) : nil
  }

  mutating func maybeConsumeNewlineEscape() -> Bool {
    var tmpPtr = self
    while true {
      switch tmpPtr.advance() {
      case UInt8(ascii: " "), UInt8(ascii: "\t"):
        continue
      case UInt8(ascii: "\r"):
        _ = tmpPtr.advance(if: { $0 == Unicode.Scalar("\n") })
        fallthrough
      case UInt8(ascii: "\n"):
        self = tmpPtr
        return true
      case 0:
        return false
      default:
        return false
      }
    }
  }

  /// delimiterMatches - Does custom delimiter ('#' characters surrounding quotes)
  /// match the number of '#' characters after '\' inside the string? This allows
  /// interpolation inside a "raw" string. Normal/cooked string processing is
  /// the degenerate case of there being no '#' characters surrounding the quotes.
  /// If delimiter matches, advances byte pointer passed in and returns true.
  /// Also used to detect the final delimiter of a string when IsClosing == true.
  mutating func delimiterMatches(
    _ customDelimiterLength: Int,
    _ isClosing: Bool = false
  ) -> Bool {
    guard customDelimiterLength > 0 else {
      return true
    }

    var tmpPtr = self
    while tmpPtr.advance(matching: UInt8(ascii: "#")) != nil {

    }

    if tmpPtr.input.baseAddress! - self.input.baseAddress! < customDelimiterLength {
      return false
    }

    for _ in 0..<customDelimiterLength {
      _ = self.advance()
    }
    return true
  }

  static func skipToEndOfInterpolatedExpression(_ curPtr: Lexer.Cursor, _ isMultilineString: Bool) -> Lexer.Cursor {
    var curPtr = curPtr
    var openDelimiters = [UInt8]()
    var allowNewline = [isMultilineString]
    var customDelimiter = [Int]()

    let inStringLiteral = { () -> Bool in
      guard let last = openDelimiters.last else {
        return false
      }
      return last == UInt8(ascii: #"""#) || last == UInt8(ascii: #"'"#)
    }
    while true {
      // This is a simple scanner, capable of recognizing nested parentheses and
      // string literals but not much else.  The implications of this include not
      // being able to break an expression over multiple lines in an interpolated
      // string.  This limitation allows us to recover from common errors though.
      //
      // On success scanning the expression body, the real lexer will be used to
      // relex the body when parsing the expressions.  We let it diagnose any
      // issues with malformed tokens or other problems.
      var customDelimiterLen = 0
      let last = curPtr
      switch curPtr.advance() {
      // String literals in general cannot be split across multiple lines
      // interpolated ones are no exception - unless multiline literals.
      case UInt8(ascii: "\n"), UInt8(ascii: "\r"):
        if allowNewline.last! {
          continue
        }
        // Will be diagnosed as an unterminated string literal.
        return last
      case 0:
        guard !last.isAtEndOfFile else {
          // CC token or random NUL character.
          continue
        }
        // Will be diagnosed as an unterminated string literal.
        return last

      case UInt8(ascii: "#"):
        guard !inStringLiteral(), let delim = curPtr.advanceIfCustomDelimiter() else {
          continue
        }
        let quote = curPtr.advance(matching: UInt8(ascii: #"""#))
        customDelimiterLen = delim
        assert(
          quote != nil,
          "advanceIfCustomDelimiter() must stop in front of a quote"
        )
        fallthrough

      case UInt8(ascii: #"""#), UInt8(ascii: #"'"#):
        if (!inStringLiteral()) {
          // Open string literal.
          openDelimiters.append(curPtr.previous)
          allowNewline.append(curPtr.advanceIfMultilineDelimiter(customDelimiterLen, true))
          customDelimiter.append(customDelimiterLen)
          continue
        }

        // In string literal.

        // Skip if it's an another kind of quote in string literal. e.g. "foo's".
        guard openDelimiters.last == curPtr.previous else {
          continue
        }

        // Multi-line string can only be closed by '"""'.
        if (allowNewline.last! && !curPtr.advanceIfMultilineDelimiter(customDelimiterLen)) {
          continue
        }

        // Check whether we have equivalent number of '#'s.
        guard curPtr.delimiterMatches(customDelimiter.last!, true) else {
          continue
        }

        // Close string literal.
        _ = openDelimiters.popLast()
        _ = allowNewline.popLast()
        _ = customDelimiter.popLast()
        continue
      case UInt8(ascii: "\\"):
        // We ignore invalid escape sequence here. They should be diagnosed in
        // the real lexer functions.
        if (inStringLiteral() && curPtr.delimiterMatches(customDelimiter.last!)) {
          let last = curPtr
          switch curPtr.advance() {
          case UInt8(ascii: "("):
            // Entering a recursive interpolated expression
            openDelimiters.append(UInt8(ascii: "("))
            continue
          case UInt8(ascii: "\n"), UInt8(ascii: "\r"), 0:
            // Don't jump over newline/EOF due to preceding backslash.
            // Let the outer switch to handle it.
            curPtr = last
            continue
          default:
            continue
          }
        }
        continue

      // Paren nesting deeper to support "foo = \((a+b)-(c*d)) bar".
      case UInt8(ascii: "("):
        if (!inStringLiteral()) {
          openDelimiters.append(UInt8(ascii: "("))
        }
        continue
      case UInt8(ascii: ")"):
        if openDelimiters.isEmpty {
          // No outstanding open delimiters; we're done.
          return last
        } else if openDelimiters.last == UInt8(ascii: "(") {
          // Pop the matching bracket and keep going.
          _ = openDelimiters.popLast()
          if openDelimiters.isEmpty {
            // No outstanding open delimiters; we're done.
            return last
          }
          continue
        } else {
          // It's a right parenthesis in a string literal.
          assert(inStringLiteral())
          continue
        }
      case UInt8(ascii: "/"):
        if (inStringLiteral()) {
          continue
        }

        if curPtr.peek(matches: "*") {
          let commentStart = last
          let isMultilineComment = curPtr.advanceToEndOfSlashStarComment()
          if isMultilineComment && !allowNewline.last! {
            // Multiline comment is prohibited in string literal.
            // Return the start of the comment.
            return commentStart
          }
        } else if curPtr.peek(matches: "/") {
          if !allowNewline.last! {
            // '//' comment is impossible in single line string literal.
            // Return the start of the comment.
            return last
          }
          // Advance to the end of the comment.
          if curPtr.advanceToEndOfLine() {
            _ = curPtr.advance()
          }
        }
        continue
      case nil:
        return curPtr
      default:
        // Normal token character.
        continue
      }
    }
  }
}

extension Lexer {
  struct Result {
    let tokenKind: RawTokenKind
    let flags: Lexer.Lexeme.Flags
    let error: LexerError?
    let newState: LexerCursorState?

    init(
      _ tokenKind: RawTokenKind,
      flags: Lexer.Lexeme.Flags = [],
      error: LexerError? = nil,
      newState: LexerCursorState? = nil
    ) {
      self.tokenKind = tokenKind
      self.flags = flags
      self.error = error
      self.newState = newState
    }
  }
}

extension Lexer.Cursor {
  mutating func nextToken(_ contentStart: Lexer.Cursor) -> Lexer.Lexeme {
    // Leading trivia.
    let leadingTriviaStart = self
    let newlineInLeadingTrivia: NewlinePresence
    if self.state.shouldLexTrivia(cursor: self) {
      newlineInLeadingTrivia = self.lexTrivia(.leading)
    } else {
      newlineInLeadingTrivia = .absent
    }

    // Token text.
    let textStart = self

    let result = self.lexImpl(contentStart: contentStart)

    // Trailing trivia.
    let trailingTriviaStart = self
    let newlineInTrailingTrivia: NewlinePresence
    if (result.newState ?? self.state).shouldLexTrivia(cursor: self) {
      newlineInTrailingTrivia = self.lexTrivia(.trailing)
    } else {
      newlineInTrailingTrivia = .absent
    }
    assert(
      newlineInTrailingTrivia == .absent,
      "trailingTrivia should not have a newline"
    )

    var flags = result.flags
    if newlineInLeadingTrivia == .present {
      flags.insert(.isAtStartOfLine)
    }
    if let newState = result.newState {
      self.state = newState
    }

    return .init(
      tokenKind: result.tokenKind,
      flags: flags,
      error: result.error,
      start: leadingTriviaStart.pointer,
      leadingTriviaLength: leadingTriviaStart.distance(to: textStart),
      textLength: textStart.distance(to: trailingTriviaStart),
      trailingTriviaLength: trailingTriviaStart.distance(to: self)
    )
  }

  private mutating func lexImpl(contentStart: Lexer.Cursor) -> Lexer.Result {
    if case .inStringLiteral(kind: let kind, delimiterLength: let delimiterLength) = state {
      return self.lexStringLiteralContents(
        self,
        quoteChar: kind == .singleQuote ? UInt8(ascii: "'") : UInt8(ascii: #"""#),
        delimiterLength,
        isMultilineString: kind == .multiLine
      )
    }

    let start = self
    switch self.advance() {
    case UInt8(ascii: "@"): return Lexer.Result(.atSign)
    case UInt8(ascii: "{"): return Lexer.Result(.leftBrace)
    case UInt8(ascii: "["): return Lexer.Result(.leftSquareBracket)
    case UInt8(ascii: "("): return Lexer.Result(.leftParen)
    case UInt8(ascii: "}"): return Lexer.Result(.rightBrace)
    case UInt8(ascii: "]"): return Lexer.Result(.rightSquareBracket)
    case UInt8(ascii: ")"): return Lexer.Result(.rightParen)

    case UInt8(ascii: ","): return Lexer.Result(.comma)
    case UInt8(ascii: ";"): return Lexer.Result(.semicolon)
    case UInt8(ascii: ":"): return Lexer.Result(.colon)
    case UInt8(ascii: "\\"): return Lexer.Result(.backslash)

    case UInt8(ascii: "#"):
      if case .afterClosingStringQuote(delimiterLength: _) = state {
        self.advance(while: { $0 == Unicode.Scalar("#") })
        return Lexer.Result(.rawStringDelimiter, newState: .normal)
      }
      // Try lex a raw string literal.
      if let customDelimiterLength = self.advanceIfCustomDelimiter() {
        return Lexer.Result(.rawStringDelimiter, newState: .afterRawStringDelimiter(delimiterLength: customDelimiterLength))
      }

      // Try lex a regex literal.
      if let token = self.tryLexRegexLiteral(start, contentStart) {
        return Lexer.Result(token)
      }
      // Otherwise try lex a magic pound literal.
      return self.lexMagicPoundLiteral()
    case UInt8(ascii: "/"):
      // Try lex a regex literal.
      if let token = self.tryLexRegexLiteral(start, contentStart) {
        return Lexer.Result(token)
      }

      // Otherwise try lex a magic pound literal.
      return self.lexOperatorIdentifier(start, contentStart)
    case UInt8(ascii: "!"):
      if start.isLeftBound(contentStart) {
        return Lexer.Result(.exclamationMark)
      }
      return self.lexOperatorIdentifier(start, contentStart)

    case UInt8(ascii: "?"):
      if start.isLeftBound(contentStart) {
        return Lexer.Result(.postfixQuestionMark)
      }
      return self.lexOperatorIdentifier(start, contentStart)

    case UInt8(ascii: "<"):
      if self.peek(matches: "#") {
        return self.tryLexEditorPlaceholder(start, contentStart)
      }
      return self.lexOperatorIdentifier(start, contentStart)
    case UInt8(ascii: ">"):
      return self.lexOperatorIdentifier(start, contentStart)

    case UInt8(ascii: "="), UInt8(ascii: "-"), UInt8(ascii: "+"),
      UInt8(ascii: "*"), UInt8(ascii: "%"), UInt8(ascii: "&"),
      UInt8(ascii: "|"), UInt8(ascii: "^"), UInt8(ascii: "~"),
      UInt8(ascii: "."):
      return self.lexOperatorIdentifier(start, contentStart)
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
      return self.lexIdentifier(start)

    case UInt8(ascii: "$"):
      return self.lexDollarIdentifier(start)

    case UInt8(ascii: "0"), UInt8(ascii: "1"), UInt8(ascii: "2"),
      UInt8(ascii: "3"), UInt8(ascii: "4"), UInt8(ascii: "5"),
      UInt8(ascii: "6"), UInt8(ascii: "7"), UInt8(ascii: "8"),
      UInt8(ascii: "9"):
      return self.lexNumber(start, contentStart)
    case UInt8(ascii: #"'"#), UInt8(ascii: #"""#):
      return self.lexStringQuote()

    case UInt8(ascii: "`"):
      return self.lexEscapedIdentifier(start)
    case nil:
      return Lexer.Result(.eof)
    default:
      var tmp = start
      if tmp.advance(if: { Unicode.Scalar($0).isValidIdentifierStartCodePoint }) {
        return self.lexIdentifier(start)
      }

      if tmp.advance(if: { Unicode.Scalar($0).isOperatorStartCodePoint }) {
        return self.lexOperatorIdentifier(start, contentStart)
      }

      let shouldTokenize = self.lexUnknown(start)
      assert(shouldTokenize, "Invalid UTF-8 sequence should be eaten by lexTrivia as LeadingTrivia")
      return Lexer.Result(.unknown)
    }
  }
}

// MARK: - Trivia

extension Lexer.Cursor {
  fileprivate enum NewlinePresence {
    case absent
    case present
  }

  fileprivate mutating func lexTrivia(_ position: TriviaPosition) -> NewlinePresence {
    var hasNewline = false
    while true {
      let start = self

      switch self.advance() {
      // 'continue' - the character is a part of the trivia.
      // 'break' - the character should a part of token text.
      case nil:
        break
      case UInt8(ascii: "\n"):
        if case .trailing = position {
          break
        }
        hasNewline = true
        continue
      case UInt8(ascii: "\r"):
        if case .trailing = position {
          break
        }
        hasNewline = true
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
          _ = self.advanceToEndOfLine()
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
        _ = self.advanceToEndOfLine()
        continue
      case UInt8(ascii: "<"), UInt8(ascii: ">"):
        guard self.tryLexConflictMarker(start: start) else {
          break
        }
        continue
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
        if self.peek(matches: 0xBB), self.peek(at: 1, matches: 0xBF) {
          // BOM marker.
          _ = self.advance()
          _ = self.advance()
          continue
        }

        fallthrough
      default:
        var tmp = start
        if tmp.advance(if: { Unicode.Scalar($0).isValidIdentifierStartCodePoint }) {
          break
        }
        if tmp.advance(if: { Unicode.Scalar($0).isOperatorStartCodePoint }) {
          break
        }

        guard self.lexUnknown(start) else {
          continue
        }

        break
      }

      // `break` means the character was not a trivia. Reset the cursor and
      // return the result.
      self = start
      return hasNewline ? .present : .absent
    }
  }
}

// MARK: - Literals

extension Lexer.Cursor {
  /// lexStringLiteral:
  ///   string_literal ::= ["]([^"\\\n\r]|character_escape)*["]
  ///   string_literal ::= ["]["]["].*["]["]["] - approximately
  ///   string_literal ::= (#+)("")?".*"(\2\1) - "raw" strings
  mutating func lexStringLiteralContents(_ start: Lexer.Cursor, quoteChar: UInt8, _ customDelimiterLength: Int, isMultilineString: Bool) -> Lexer.Result {
    /*
    if IsMultilineString && *CurPtr != '\n' && *CurPtr != '\r' {
      diagnose(CurPtr, diag::lex_illegal_multiline_string_start)
        .fixItInsert(Lexer::getSourceLoc(CurPtr), "\n")
    }
*/

    DELIMITLOOP: while true {
      // Handle string interpolation.
      var tmpPtr = self
      guard tmpPtr.advance() != nil else {
        // This is the end of string, we are done.
        break DELIMITLOOP
      }
      if self.peek(matches: "\\") && tmpPtr.delimiterMatches(customDelimiterLength) && tmpPtr.peek(matches: "(") {
        // Consume tokens until we hit the corresponding ')'.
        self = Self.skipToEndOfInterpolatedExpression(tmpPtr, isMultilineString)
        if self.advance(if: { $0 == Unicode.Scalar(")") }) {
          // Successfully scanned the body of the expression literal.
          continue
        } else if self.peek(matches: "\r", "\n") && isMultilineString {
          // The only case we reach here is unterminated single line string in the
          // interpolation. For better recovery, go on after emitting an error.
          //          diagnose(CurPtr, diag::lex_unterminated_string)
          continue
        } else {
          //          diagnose(TokStart, diag::lex_unterminated_string)
          return Lexer.Result(.stringLiteralContents, newState: .normal)
        }
      }

      // String literals cannot have \n or \r in them (unless multiline).
      if self.peek(matches: "\r", "\n") && !isMultilineString {
        //        diagnose(TokStart, diag::lex_unterminated_string)
        return Lexer.Result(.unknown)
      }

      var clone = self
      let charValue = clone.lexCharacter(quoteChar, isMultilineString, customDelimiterLength)
      switch charValue {
      case .endOfString:
        // This is the end of string, we are done.
        break DELIMITLOOP
      case .error:
        // Remember we had already-diagnosed invalid characters.
        self = clone
      default:
        self = clone
      }
    }

    //    if QuoteChar == UInt8(ascii: #"'"#) {
    //      assert(!IsMultilineString && customDelimiterLength == 0,
    //             "Single quoted string cannot have custom delimitor, nor multiline")
    //      diagnoseSingleQuoteStringLiteral(TokStart, CurPtr)
    //    }

    return Lexer.Result(
      .stringLiteralContents,
      newState: .afterStringLiteral(delimiterLength: customDelimiterLength)
    )
  }
}

extension Lexer.Cursor {
  enum CharacterLex {
    case endOfString
    case error
    case success(Unicode.Scalar)
    case validated(Character)
  }
  /// lexCharacter - Read a character and return its UTF32 code.  If this is the
  /// end of enclosing string/character sequence (i.e. the character is equal to
  /// 'StopQuote'), this returns ~0U and advances 'CurPtr' pointing to the end of
  /// terminal quote.  If this is a malformed character sequence, it emits a
  /// diagnostic (when EmitDiagnostics is true) and returns ~1U.
  ///
  ///   character_escape  ::= [\][\] | [\]t | [\]n | [\]r | [\]" | [\]' | [\]0
  ///   character_escape  ::= unicode_character_escape
  mutating func lexCharacter(
    _ stopQuote: UInt8,
    _ isMultilineString: Bool,
    _ customDelimiterLen: Int
  ) -> CharacterLex {
    let charStart = self

    switch self.advance() {
    case UInt8(ascii: #"""#), UInt8(ascii: #"'"#):
      if self.previous == stopQuote {
        // Mutliline and custom escaping are only enabled for " quote.
        if stopQuote != UInt8(ascii: #"""#) {
          return .endOfString
        }
        if !isMultilineString && customDelimiterLen == 0 {
          return .endOfString
        }

        var tmpPtr = self
        if isMultilineString && !tmpPtr.advanceIfMultilineDelimiter(customDelimiterLen) {
          return .success(Unicode.Scalar(UInt8(ascii: #"""#)))
        }
        if customDelimiterLen > 0 && !tmpPtr.delimiterMatches(customDelimiterLen, /*IsClosing=*/ true) {
          return .success(Unicode.Scalar(UInt8(ascii: #"""#)))
        }
        self = tmpPtr
        return .endOfString
      }
      // Otherwise, this is just a character.
      return .success(Unicode.Scalar(self.previous))

    case 0:
      //      assert(CurPtr - 1 != BufferEnd && "Caller must handle EOF")
      //      if (EmitDiagnostics)
      //        diagnose(CurPtr-1, diag::lex_nul_character)
      return .success(Unicode.Scalar(self.previous))
    case UInt8(ascii: "\n"), UInt8(ascii: "\r"):  // String literals cannot have \n or \r in them.
      assert(isMultilineString, "Caller must handle newlines in non-multiline")
      return .success(Unicode.Scalar(self.previous))

    case UInt8(ascii: "\\"):  // Escapes.
      if !self.delimiterMatches(customDelimiterLen) {
        return .success(Unicode.Scalar("\\"))
      }
      guard
        let c = self.lexEscapedCharacter(isMultilineString),
        // Check to see if the encoding is valid.
        let cv = Unicode.Scalar(c)
      else {
        return .error
      }

      return .validated(Character(cv))
    default:
      // Normal characters are part of the string.
      // If this is a "high" UTF-8 character, validate it.
      //      if ((signed char)(CurPtr[-1]) >= 0) {
      //        if (isPrintable(CurPtr[-1]) == 0)
      //          if (!(IsMultilineString && (CurPtr[-1] == '\t')))
      //            if (EmitDiagnostics)
      //              diagnose(CharStart, diag::lex_unprintable_ascii_character)
      //        return CurPtr[-1]
      //      }
      self = charStart
      guard let charValue = self.validateUTF8CharacterAndAdvance() else {
        //      if (EmitDiagnostics)
        //        diagnose(CharStart, diag::lex_invalid_utf8)
        return .error
      }
      return .success(charValue)
    }
  }

  fileprivate mutating func lexEscapedCharacter(_ isMultilineString: Bool) -> UInt32? {
    // Escape processing.  We already ate the "\".
    switch self.peek() {
    // Simple single-character escapes.
    case UInt8(ascii: "0"): _ = self.advance(); return UInt32(UInt8(ascii: "\0"))
    case UInt8(ascii: "n"): _ = self.advance(); return UInt32(UInt8(ascii: "\n"))
    case UInt8(ascii: "r"): _ = self.advance(); return UInt32(UInt8(ascii: "\r"))
    case UInt8(ascii: "t"): _ = self.advance(); return UInt32(UInt8(ascii: "\t"))
    case UInt8(ascii: #"""#): _ = self.advance(); return UInt32(UInt8(ascii: #"""#))
    case UInt8(ascii: #"'"#): _ = self.advance(); return UInt32(UInt8(ascii: #"'"#))
    case UInt8(ascii: "\\"): _ = self.advance(); return UInt32(UInt8(ascii: "\\"))

    case UInt8(ascii: "u"):  //  \u HEX HEX HEX HEX
      _ = self.advance()
      guard self.peek(matches: "{") else {
        //        if (EmitDiagnostics)
        //          diagnose(CurPtr-1, diag::lex_unicode_escape_braces)
        return nil
      }

      guard let cv = self.lexUnicodeEscape() else {
        return nil
      }
      return cv

    case UInt8(ascii: " "), UInt8(ascii: "\t"), UInt8(ascii: "\n"), UInt8(ascii: "\r"):
      if isMultilineString && self.maybeConsumeNewlineEscape() {
        return UInt32(UInt8(ascii: "\n"))
      }
      fallthrough
    case nil:
      return nil
    case .some(let peekedValue):  // Invalid escape.
      //     if (EmitDiagnostics)
      //       diagnose(CurPtr, diag::lex_invalid_escape)
      // If this looks like a plausible escape character, recover as though this
      // is an invalid escape.
      let c = Unicode.Scalar(peekedValue)
      if c.isDigit || c.isLetter {
        _ = self.advance()
      }
      return nil
    }
  }

  fileprivate mutating func lexUnicodeEscape() -> UInt32? {
    assert(self.peek(matches: "{"), "Invalid unicode escape")
    _ = self.advance()

    let digitStart = self
    var numDigits = 0;
    while self.advance(if: { $0.isHexDigit }) {
      numDigits += 1
    }

    if self.peek(doesntMatch: "}") {
      //      if (Diags)
      //        Diags->diagnose(CurPtr, diag::lex_invalid_u_escape_rbrace)
      return nil
    }
    _ = self.advance()

    if (numDigits < 1 || numDigits > 8) {
      //      if (Diags)
      //        Diags->diagnose(CurPtr, diag::lex_invalid_u_escape)
      return nil
    }

    return UInt32(String(decoding: digitStart.input[0..<numDigits], as: UTF8.self), radix: 16)
  }
}

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
  mutating func lexNumber(
    _ tokStart: Lexer.Cursor,
    _ contentStart: Lexer.Cursor
  ) -> Lexer.Result {
    assert(
      (Unicode.Scalar(self.previous).isDigit || self.previous == UInt8(ascii: ".")),
      "Unexpected start"
    )

    if self.previous == UInt8(ascii: "0") && self.peek(matches: "x") {
      return self.lexHexNumber(tokStart)
    }

    if self.previous == UInt8(ascii: "0") && self.peek(matches: "o") {
      // 0o[0-7][0-7_]*
      _ = self.advance()
      if let peeked = self.peek(), peeked < UInt8(ascii: "0") || peeked > UInt8(ascii: "7") {
        let errorOffset = tokStart.distance(to: self)
        self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
        return Lexer.Result(
          .integerLiteral,
          error: LexerError(.invalidOctalDigitInIntegerLiteral, byteOffset: errorOffset)
        )
      }

      self.advance(while: {
        ($0 >= Unicode.Scalar("0") && $0 <= Unicode.Scalar("7")) || $0 == Unicode.Scalar("_")
      })

      let tmp = self
      if self.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
        let errorOffset = tokStart.distance(to: tmp)
        self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
        return Lexer.Result(
          .integerLiteral,
          error: LexerError(.invalidOctalDigitInIntegerLiteral, byteOffset: errorOffset)
        )
      }

      return Lexer.Result(.integerLiteral)
    }

    if tokStart.peek(matches: "0") && self.peek(matches: "b") {
      // 0b[01][01_]*
      _ = self.advance()
      if self.peek(doesntMatch: "0", "1") {
        let errorOffset = tokStart.distance(to: self)
        self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
        return Lexer.Result(
          .integerLiteral,
          error: LexerError(.invalidBinaryDigitInIntegerLiteral, byteOffset: errorOffset)
        )
      }

      self.advance(while: {
        $0 == Unicode.Scalar("0") || $0 == Unicode.Scalar("1") || $0 == Unicode.Scalar("_")
      })

      let tmp = self
      if self.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
        let errorOffset = tokStart.distance(to: tmp)
        self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
        return Lexer.Result(
          .integerLiteral,
          error: LexerError(.invalidBinaryDigitInIntegerLiteral, byteOffset: errorOffset)
        )
      }

      return Lexer.Result(.integerLiteral)
    }

    // Handle a leading [0-9]+, lexing an integer or falling through if we have a
    // floating point value.
    self.advance(while: { $0.isDigit || $0 == Unicode.Scalar("_") })

    // Lex things like 4.x as '4' followed by a tok::period.
    if self.peek(matches: ".") {
      // NextToken is the soon to be previous token
      // Therefore: x.0.1 is sub-tuple access, not x.float_literal
      if let peeked = self.peek(at: 1), !Unicode.Scalar(peeked).isDigit || tokStart.previous == UInt8(ascii: ".") {
        return Lexer.Result(.integerLiteral)
      }
    } else {
      // Floating literals must have '.', 'e', or 'E' after digits.  If it is
      // something else, then this is the end of the token.
      if self.isAtEndOfFile || self.peek(doesntMatch: "e", "E") {
        let tmp = self
        if self.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
          let errorOffset = tokStart.distance(to: tmp)
          self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
          return Lexer.Result(
            .integerLiteral,
            error: LexerError(.invalidDecimalDigitInIntegerLiteral, byteOffset: errorOffset)
          )
        }

        return Lexer.Result(.integerLiteral)
      }
    }

    // Lex decimal point.
    if self.advance(if: { $0 == Unicode.Scalar(".") }) {
      // Lex any digits after the decimal point.
      self.advance(while: { $0.isDigit || $0 == Unicode.Scalar("_") })
    }

    // Lex exponent.
    if self.advance(if: { $0 == Unicode.Scalar("e") || $0 == Unicode.Scalar("E") }) {
      _ = self.advance(if: { $0 == Unicode.Scalar("-") || $0 == Unicode.Scalar("+") })

      guard let peeked = self.peek(), Unicode.Scalar(peeked).isDigit else {
        // There are 3 cases to diagnose if the exponent starts with a non-digit:
        // identifier (invalid character), underscore (invalid first character),
        // non-identifier (empty exponent)
        let tmp = self
        var errorKind: LexerError.Kind
        if self.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
          if tmp.peek(matches: "_") {
            errorKind = .invalidFloatingPointExponentCharacter
          } else {
            errorKind = .invalidFloatingPointExponentDigit
          }
        } else {
          errorKind = .expectedDigitInFloatLiteral
        }

        let errorOffset = tokStart.distance(to: tmp)
        self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
        return Lexer.Result(.floatingLiteral, error: LexerError(errorKind, byteOffset: errorOffset))
      }

      self.advance(while: { char in
        char.isDigit || char == Unicode.Scalar("_")
      })

      let tmp = self
      if self.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
        let errorOffset = tokStart.distance(to: tmp)
        self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
        return Lexer.Result(
          .floatingLiteral,
          error: LexerError(.invalidFloatingPointExponentDigit, byteOffset: errorOffset)
        )
      }
    }

    return Lexer.Result(.floatingLiteral)
  }

  mutating func lexHexNumber(_ tokStart: Lexer.Cursor) -> Lexer.Result {
    // We assume we're starting from the 'x' in a '0x...' floating-point literal.
    assert(self.peek(matches: "x"), "not a hex literal")
    assert(self.previous == UInt8(ascii: "0"), "not a hex literal")

    // 0x[0-9a-fA-F][0-9a-fA-F_]*
    _ = self.advance()
    if self.isAtEndOfFile {
      return Lexer.Result(.integerLiteral)
    }
    guard let peeked = self.peek(), Unicode.Scalar(peeked).isHexDigit else {
      let errorOffset = tokStart.distance(to: self)
      self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
      return Lexer.Result(
        .integerLiteral,
        error: LexerError(.invalidHexDigitInIntegerLiteral, byteOffset: errorOffset)
      )
    }

    self.advance(while: { $0.isHexDigit || $0 == Unicode.Scalar("_") })

    if self.isAtEndOfFile {
      return Lexer.Result(.integerLiteral)
    }

    if self.peek(doesntMatch: ".", "p", "P") {
      let tmp = self
      if self.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
        let errorOffset = tokStart.distance(to: tmp)
        self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
        return Lexer.Result(
          .integerLiteral,
          error: LexerError(.invalidHexDigitInIntegerLiteral, byteOffset: errorOffset)
        )
      } else {
        return Lexer.Result(.integerLiteral)
      }
    }

    // (\.[0-9A-Fa-f][0-9A-Fa-f_]*)?
    var ptrOnDot: Lexer.Cursor? = self
    if self.advance(if: { $0 == Unicode.Scalar(".") }) {
      // If the character after the '.' is not a digit, assume we have an int
      // literal followed by a dot expression.
      if let peeked = self.peek(), !Unicode.Scalar(peeked).isHexDigit {
        self = ptrOnDot!
        return Lexer.Result(.integerLiteral)
      }

      self.advance(while: { $0.isHexDigit || $0 == Unicode.Scalar("_") })

      if self.isAtEndOfFile || self.peek(doesntMatch: "p", "P") {
        if let peeked = self.peek(at: 1), !Unicode.Scalar(peeked).isDigit {
          // e.g: 0xff.description
          self = ptrOnDot!
          return Lexer.Result(.integerLiteral)
        }
        return Lexer.Result(
          .integerLiteral,
          error: LexerError(.expectedBinaryExponentInHexFloatLiteral, byteOffset: tokStart.distance(to: self))
        )
      }
    } else {
      ptrOnDot = nil
    }

    // [pP][+-]?[0-9][0-9_]*
    assert(self.isAtEndOfFile || self.peek(matches: "p", "P"), "not at a hex float exponent?!")
    _ = self.advance()

    var signedExponent = false
    if self.advance(if: { $0 == Unicode.Scalar("+") || $0 == Unicode.Scalar("-") }) {
      // Eat the sign.
      signedExponent = true
    }

    if let peeked = self.peek(), !Unicode.Scalar(peeked).isDigit {
      if let ptrOnDot = ptrOnDot, let peeked = ptrOnDot.peek(at: 1), !Unicode.Scalar(peeked).isDigit && !signedExponent {
        // e.g: 0xff.fpValue, 0xff.fp
        self = ptrOnDot
        return Lexer.Result(.integerLiteral)
      }
      // Note: 0xff.fp+otherExpr can be valid expression. But we don't accept it.

      // There are 3 cases to diagnose if the exponent starts with a non-digit:
      // identifier (invalid character), underscore (invalid first character),
      // non-identifier (empty exponent)
      let tmp = self
      let errorKind: LexerError.Kind
      if self.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
        if tmp.peek(matches: "_") {
          errorKind = .invalidFloatingPointExponentCharacter
        } else {
          errorKind = .invalidFloatingPointExponentDigit
        }
      } else {
        errorKind = .expectedDigitInFloatLiteral
      }
      let errorOffset = tokStart.distance(to: tmp)
      self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
      return Lexer.Result(.floatingLiteral, error: LexerError(errorKind, byteOffset: errorOffset))
    }

    self.advance(while: { $0.isDigit || $0 == Unicode.Scalar("_") })

    let tmp = self
    if self.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
      let errorOffset = tokStart.distance(to: tmp)
      self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
      return Lexer.Result(
        .floatingLiteral,
        error: LexerError(.invalidFloatingPointExponentDigit, byteOffset: errorOffset)
      )
    }
    return Lexer.Result(.floatingLiteral)
  }
}

extension Lexer.Cursor {
  mutating func lexMagicPoundLiteral() -> Lexer.Result {
    let start = self
    var clone = self
    // Scan for [a-zA-Z]+ to see what we match.
    if let peeked = clone.peek(), Unicode.Scalar(peeked).isAsciiIdentifierStart {
      repeat {
        _ = clone.advance()
      } while clone.peek().map { Unicode.Scalar($0) }?.isAsciiIdentifierContinue == true
    }

    let literal = start.textUpTo(clone)

    let kind: RawTokenKind
    switch literal {
    case "assert": kind = .poundAssertKeyword
    case "sourceLocation": kind = .poundSourceLocationKeyword
    case "warning": kind = .poundWarningKeyword
    case "error": kind = .poundErrorKeyword
    case "if": kind = .poundIfKeyword
    case "else": kind = .poundElseKeyword
    case "elseif": kind = .poundElseifKeyword
    case "endif": kind = .poundEndifKeyword
    case "available": kind = .poundAvailableKeyword
    case "unavailable": kind = .poundUnavailableKeyword
    case "_hasSymbol": kind = .poundHasSymbolKeyword
    default:
      // If we didn't find a match, then just return `.pound`.  This is highly
      // dubious in terms of error recovery, but is useful for code completion and
      // SIL parsing.
      return Lexer.Result(.pound)
    }

    // If we found something specific, return it.
    self = clone
    return Lexer.Result(kind)
  }
}

// MARK: - Identifiers

extension Lexer.Cursor {
  /// lexIdentifier - Match [a-zA-Z_][a-zA-Z_$0-9]*
  mutating func lexIdentifier(_ tokStart: Lexer.Cursor) -> Lexer.Result {
    self = tokStart
    let didStart = self.advance(if: { $0.isValidIdentifierStartCodePoint })
    assert(didStart, "Unexpected start")

    // Lex [a-zA-Z_$0-9[[:XID_Continue:]]]*
    self.advance(while: { $0.isValidIdentifierContinuationCodePoint })

    let text = tokStart.textUpTo(self)
    if let keywordKind = RawTokenKind(keyword: text) {
      return Lexer.Result(keywordKind)
    } else if let keyword = Keyword(text), keyword.isLexerClassified {
      return Lexer.Result(.keyword(keyword))
    } else if text == "_" {
      return Lexer.Result(.wildcard)
    } else {
      return Lexer.Result(.identifier)
    }
  }

  mutating func lexEscapedIdentifier(_ quote: Lexer.Cursor) -> Lexer.Result {
    assert(self.previous == UInt8(ascii: "`"), "Unexpected start of escaped identifier")

    // Check whether we have an identifier followed by another backtick, in which
    // case this is an escaped identifier.
    let identifierStart = self
    if self.advance(if: { $0.isValidIdentifierStartCodePoint }) {
      // Keep continuing the identifier.
      self.advance(while: { $0.isValidIdentifierContinuationCodePoint })

      // If we have the terminating "`", it's an escaped identifier.
      if self.advance(if: { $0 == Unicode.Scalar("`") }) {
        return Lexer.Result(.identifier)
      }
    }

    // Special case; allow '`$`'.
    if quote.starts(with: "`$`".utf8) {
      self = quote
      _ = self.advance()
      _ = self.advance()
      _ = self.advance()
      return Lexer.Result(.identifier)
    }

    // The backtick is punctuation.
    self = identifierStart
    return Lexer.Result(.backtick)
  }

  mutating func lexOperatorIdentifier(_ tokStart: Lexer.Cursor, _ contentStart: Lexer.Cursor) -> Lexer.Result {
    self = tokStart
    let didStart = self.advance(if: { $0.isOperatorStartCodePoint })
    assert(didStart, "unexpected operator start")

    repeat {
      // '.' cannot appear in the middle of an operator unless the operator
      // started with a '.'.
      if self.peek(matches: ".") && tokStart.peek(doesntMatch: ".") {
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
      _ = ptr.advance()
      while ptr.input.baseAddress! < self.input.baseAddress! {
        defer { _ = ptr.advance() }
        if ptr.peek(matches: "/") && ptr.peek(at: 1, matches: "/", "*") {
          self = ptr
          break
        }
      }
    }

    // Decide between the binary, prefix, and postfix cases.
    // It's binary if either both sides are bound or both sides are not bound.
    // Otherwise, it's postfix if left-bound and prefix if right-bound.
    let leftBound = tokStart.isLeftBound(contentStart)
    let rightBound = self.isRightBound(leftBound)

    // Match various reserved words.
    if self.input.baseAddress! - tokStart.input.baseAddress! == 1 {
      switch tokStart.peek() {
      case UInt8(ascii: "="):
        // Refrain from emitting this message in operator name position.
        //        if (NextToken.isNot(tok::kw_operator) && leftBound != rightBound) {
        //          auto d = diagnose(TokStart, diag::lex_unary_equal)
        //          if (leftBound)
        //            d.fixItInsert(getSourceLoc(TokStart), " ")
        //          else
        //            d.fixItInsert(getSourceLoc(TokStart+1), " ")
        //        }
        // always emit 'tok::equal' to avoid trickle down parse errors
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
        //        diagnose(TokStart, diag::lex_unexpected_block_comment_end)
        return Lexer.Result(.unknown)
      default:
        break
      }
    } else {
      // Verify there is no "*/" in the middle of the identifier token, we reject
      // it as potentially ending a block comment.
      if tokStart.textUpTo(self).contains("*/") {
        //        diagnose(TokStart+Pos, diag::lex_unexpected_block_comment_end)
        return Lexer.Result(.unknown)
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

  mutating func lexDollarIdentifier(_ tokStart: Lexer.Cursor) -> Lexer.Result {
    assert(self.previous == UInt8(ascii: "$"))

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
  mutating func tryLexEditorPlaceholder(_ tokStart: Lexer.Cursor, _ contentStart: Lexer.Cursor) -> Lexer.Result {
    assert(self.previous == UInt8(ascii: "<") && self.peek(matches: "#"))
    var ptr = self
    _ = ptr.advance()
    while !ptr.isAtEndOfFile {
      defer { _ = ptr.advance() }
      if ptr.peek(matches: "\n") {
        break
      }
      guard !ptr.starts(with: "<#".utf8) else {
        break
      }

      if ptr.starts(with: "#>".utf8) {
        // Found it.
        _ = ptr.advance()
        _ = ptr.advance()
        self = ptr
        return Lexer.Result(.identifier)
      }
    }

    // Not a well-formed placeholder.
    return self.lexOperatorIdentifier(tokStart, contentStart)
  }
}

// MARK: - Unknown Syntax

extension Lexer.Cursor {
  private func findEndOfCurlyQuoteStringLiteral() -> Lexer.Cursor? {
    var body = self
    while true {
      // Don't bother with string interpolations.
      if body.peek(matches: "\\") && body.peek(at: 1, matches: "(") {
        return nil
      }

      // We didn't find the end of the string literal if we ran to end of line.
      if body.isAtEndOfFile || body.peek(matches: "\r", "\n") {
        return nil
      }

      // Get the next character.
      switch body.lexCharacter(0, false, 0) {
      case .error, .endOfString:
        // If the character was incorrectly encoded, give up.
        return nil
      case .success(let charValue) where charValue == Unicode.Scalar(UInt8(ascii: #"""#)):
        // If we found a straight-quote, then we're done.  Just return the spot
        // to continue.
        return body
      case .validated(let charValue) where charValue == Character(Unicode.Scalar(0x0000201D)!):
        // If we found an ending curly quote (common since this thing started with
        // an opening curly quote) diagnose it with a fixit and then return.
        //        if (EmitDiagnostics) {
        //          diagnose(CharStart, diag::lex_invalid_curly_quote)
        //              .fixItReplaceChars(getSourceLoc(CharStart), getSourceLoc(Body),
        //                                 "\"")
        //        }
        return body
      default:
        continue
      }
    }
  }

  mutating func lexUnknown(_ start: Lexer.Cursor) -> Bool {
    var tmp = start
    if tmp.advance(if: { Unicode.Scalar($0).isValidIdentifierContinuationCodePoint }) {
      // If this is a valid identifier continuation, but not a valid identifier
      // start, attempt to recover by eating more continuation characters.
      //      if (EmitDiagnosticsIfToken) {
      //        diagnose(CurPtr - 1, diag::lex_invalid_identifier_start_character)
      //      }
      while tmp.advance(if: { Unicode.Scalar($0).isValidIdentifierContinuationCodePoint }) {

      }
      self = tmp
      return true
    }

    // This character isn't allowed in Swift source.
    guard let codepoint = tmp.validateUTF8CharacterAndAdvance() else {
      //      diagnose(CurPtr - 1, diag::lex_invalid_utf8)
      //          .fixItReplaceChars(getSourceLoc(CurPtr - 1), getSourceLoc(Tmp), " ")
      self = tmp
      return false;  // Skip presumed whitespace.
    }
    if (codepoint.value == 0x000000A0) {
      // Non-breaking whitespace (U+00A0)
      while tmp.peek(matches: 0xC2) && tmp.peek(at: 1, matches: 0xA0) {
        _ = tmp.advance()
        _ = tmp.advance()
      }

      //      SmallString<8> Spaces
      //      Spaces.assign((Tmp - CurPtr + 1) / 2, ' ')
      //      diagnose(CurPtr - 1, diag::lex_nonbreaking_space)
      //        .fixItReplaceChars(getSourceLoc(CurPtr - 1), getSourceLoc(Tmp),
      //                           Spaces)
      self = tmp
      return false
    } else if (codepoint.value == 0x0000201D) {
      // If this is an end curly quote, just diagnose it with a fixit hint.
      //      if (EmitDiagnosticsIfToken) {
      //        diagnose(CurPtr - 1, diag::lex_invalid_curly_quote)
      //            .fixItReplaceChars(getSourceLoc(CurPtr - 1), getSourceLoc(Tmp), "\"")
      //      }
      self = tmp
      return true
    } else if (codepoint.value == 0x0000201C) {
      // If this is a start curly quote, do a fuzzy match of a string literal
      // to improve recovery.
      if let tmp2 = tmp.findEndOfCurlyQuoteStringLiteral() {
        tmp = tmp2
      }

      // Note, we intentionally diagnose the end quote before the start quote,
      // so that the IDE suggests fixing the end quote before the start quote.
      // This, in turn, works better with our error recovery because we won't
      // diagnose an end curly quote in the middle of a straight quoted
      // literal.
      //      if (EmitDiagnosticsIfToken) {
      //        diagnose(CurPtr - 1, diag::lex_invalid_curly_quote)
      //            .fixItReplaceChars(getSourceLoc(CurPtr - 1), getSourceLoc(EndPtr),
      //                               "\"")
      //      }
      self = tmp
      return true
    }

    //    diagnose(CurPtr - 1, diag::lex_invalid_character)
    //        .fixItReplaceChars(getSourceLoc(CurPtr - 1), getSourceLoc(Tmp), " ")

    //    char ExpectedCodepoint
    //    if ((ExpectedCodepoint =
    //             confusable::tryConvertConfusableCharacterToASCII(Codepoint))) {
    //
    //      llvm::SmallString<4> ConfusedChar
    //      EncodeToUTF8(Codepoint, ConfusedChar)
    //      llvm::SmallString<1> ExpectedChar
    //      ExpectedChar += ExpectedCodepoint
    //      auto charNames = confusable::getConfusableAndBaseCodepointNames(Codepoint)
    //      diagnose(CurPtr - 1, diag::lex_confusable_character, ConfusedChar,
    //               charNames.first, ExpectedChar, charNames.second)
    //          .fixItReplaceChars(getSourceLoc(CurPtr - 1), getSourceLoc(Tmp),
    //                             ExpectedChar)
    //    }

    self = tmp
    return false;  // Skip presumed whitespace.
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
    guard start.previous == UInt8(ascii: "\n") || start.previous == UInt8(ascii: "\r") else {
      return false
    }

    // Check to see if we have <<<<<<< or >>>>.
    guard start.starts(with: "<<<<<<< ".utf8) || start.starts(with: ">>>> ".utf8) else {
      return false
    }

    let kind = start.peek(matches: "<") ? ConflictMarker.normal : .perforce
    guard let end = Self.findConflictEnd(start, kind) else {
      // No end of conflict marker found.
      return false
    }

    // Diagnose at the conflict marker, then jump ahead to the end.
    //    diagnose(CurPtr, diag::lex_conflict_marker_in_file);
    self = end

    // Skip ahead to the end of the marker.
    if !self.isAtEndOfFile {
      _ = self.advanceToEndOfLine()
    }
    return true
  }

  /// Find the end of a version control conflict marker.
  static func findConflictEnd(_ curPtr: Lexer.Cursor, _ markerKind: ConflictMarker) -> Lexer.Cursor? {
    // Get a reference to the rest of the buffer minus the length of the start
    // of the conflict marker.
    let advanced = curPtr.input.baseAddress?.advanced(by: markerKind.introducer.utf8.count)
    var restOfBuffer = Lexer.Cursor(
      input: .init(start: advanced, count: curPtr.input.count - markerKind.introducer.utf8.count),
      previous: curPtr.input[markerKind.introducer.utf8.count - 1],
      state: .normal
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
        previous: restOfBuffer.input[markerKind.terminator.utf8.count - 1],
        state: .normal
      )
    }
    return nil
  }
}

extension Lexer.Cursor {
  mutating func tryLexRegexLiteral(
    _ tokStart: Lexer.Cursor,
    _ contentStart: Lexer.Cursor
  ) -> RawTokenKind? {
    guard !tokStart.isLeftBound(contentStart) else {
      return nil
    }

    var tmp = tokStart
    var poundCount = 0
    var parenCount = 0

    while tmp.advance(matching: UInt8(ascii: "#")) != nil {
      poundCount += 1
    }

    guard tmp.advance(matching: UInt8(ascii: "/")) != nil else {
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
    if poundCount == 0 && tmp.peek(matches: " ", "\n", "\t") {
      return nil
    }

    var isMultiline = false
    LOOP: while true {
      switch tmp.peek() {
      case UInt8(ascii: " "), UInt8(ascii: "\t"):
        _ = tmp.advance()
        continue
      case UInt8(ascii: "\n"), UInt8(ascii: "\r"):
        isMultiline = true
      case nil:
        break LOOP
      case .some:
        break
      }
      break
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
        if tmp.peek(matches: "/", "*") {
          return nil
        }

        var endLex = tmp
        for _ in 0..<poundCount {
          guard endLex.advance(matching: UInt8(ascii: "#")) != nil else {
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
        continue DELIMITLOOP
      }
    }

    // We either had a successful lex, or something that was recoverable.
    self = tmp
    return .regexLiteral
  }
}
