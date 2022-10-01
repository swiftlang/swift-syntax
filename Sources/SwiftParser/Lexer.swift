//===-------------------------- Lexer.swift -------------------------------===//
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

/// A lexical analyzer for the Swift programming language.
///
/// - Seealso: ``Lexer/Lexeme``
/// - Seealso: ``Lexer/Cursor``
public struct Lexer {
  /// A trivia-delimited region of source text.
  ///
  /// A lexeme is the fundamental output unit of lexical analysis. Each lexeme
  /// represents a fully identified, meaningful part of the input text that
  /// will can be consumed by a ``Parser``.
  public struct Lexeme {
    public struct Flags: OptionSet {
      public var rawValue: UInt8

      public init(rawValue: UInt8) {
        self.rawValue = rawValue
      }

      public static let isAtStartOfLine = Flags(rawValue: 1 << 0)
      public static let isMultilineStringLiteral = Flags(rawValue: 1 << 1)
    }

    @_spi(RawSyntax)
    public var tokenKind: RawTokenKind
    public var flags: Lexeme.Flags
    var start: UnsafePointer<UInt8>
    public var leadingTriviaByteLength: Int
    public var textByteLength: Int
    public var trailingTriviaByteLength: Int

    var isAtStartOfLine: Bool {
      return self.flags.contains(.isAtStartOfLine)
    }

    var isMultilineStringLiteral: Bool {
      assert(self.tokenKind == .stringLiteral)
      return self.flags.contains(.isMultilineStringLiteral)
    }

    @_spi(RawSyntax)
    public init(
      tokenKind: RawTokenKind,
      flags: Flags,
      start: UnsafePointer<UInt8>,
      leadingTriviaLength: Int,
      textLength: Int,
      trailingTriviaLength: Int
    ) {
      self.tokenKind = tokenKind
      self.flags = flags
      self.start = start
      self.leadingTriviaByteLength = leadingTriviaLength
      self.textByteLength = textLength
      self.trailingTriviaByteLength = trailingTriviaLength
    }

    public var byteLength: Int {
      leadingTriviaByteLength + textByteLength + trailingTriviaByteLength
    }

    @_spi(RawSyntax)
    public var wholeText: SyntaxText {
      SyntaxText(baseAddress: start, count: byteLength)
    }

    @_spi(RawSyntax)
    public var textRange: Range<SyntaxText.Index> {
      leadingTriviaByteLength ..< leadingTriviaByteLength + textByteLength
    }

    @_spi(RawSyntax)
    public var tokenText: SyntaxText {
      SyntaxText(baseAddress: start.advanced(by: leadingTriviaByteLength),
                 count: textByteLength)
    }
    @_spi(RawSyntax)
    public var leadingTriviaText: SyntaxText {
      SyntaxText(baseAddress: start,
                 count: leadingTriviaByteLength)
    }
    @_spi(RawSyntax)
    public var trailingTriviaText: SyntaxText {
      SyntaxText(baseAddress: start.advanced(by: leadingTriviaByteLength+textByteLength),
                 count: trailingTriviaByteLength)
    }
  }
}

extension Lexer {
  /// A sequence of ``Lexer/Lexeme`` tokens starting from a ``Lexer/Cursor``
  /// that points into an input buffer.
  public struct LexemeSequence: IteratorProtocol, Sequence {
    fileprivate let start: Lexer.Cursor
    fileprivate var cursor: Lexer.Cursor
    fileprivate var nextToken: Lexer.Lexeme

    fileprivate init(start: Lexer.Cursor, cursor: Lexer.Cursor) {
      self.start = start
      self.cursor = cursor
      self.nextToken = self.cursor.nextToken(self.start)
    }

    public mutating func next() -> Lexer.Lexeme? {
      return self.advance()
    }

    mutating func advance() -> Lexer.Lexeme {
      defer {
        if self.cursor.isAtEndOfFile {
          self.nextToken = Lexeme(
            tokenKind: .eof, flags: [], start: self.cursor.pointer,
            leadingTriviaLength: 0, textLength: 0, trailingTriviaLength: 0)
        } else {
          self.nextToken = self.cursor.nextToken(self.start)
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
      self.nextToken = self.cursor.nextToken(self.start)
      return self.advance()
    }

    func peek() -> Lexer.Lexeme {
      return self.nextToken
    }
  }

  @_spi(RawSyntax)
  public static func tokenize(
    _ input: UnsafeBufferPointer<UInt8>,
    from startIndex: Int = 0
  ) -> LexemeSequence {
    assert(input.isEmpty || startIndex < input.endIndex)
    let startChar = startIndex == input.startIndex ? UInt8(ascii: "\0") : input[startIndex-1]
    let start = Cursor(input: input, previous: UInt8(ascii: "\0"))
    let cursor = Cursor(input: UnsafeBufferPointer(rebasing: input[startIndex...]), previous: startChar)
    return LexemeSequence(start: start, cursor: cursor)
  }
}

extension Lexer {
  public static func lexToEndOfInterpolatedExpression(_ input: UnsafeBufferPointer<UInt8>, _ IsMultilineString: Bool) -> Int {
    let cursor = Lexer.Cursor(input: input, previous: 0)
    let advancedCursor = Lexer.Cursor.skipToEndOfInterpolatedExpression(cursor, IsMultilineString)
    return advancedCursor.input.baseAddress! - cursor.input.baseAddress!
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
  public struct Cursor: Equatable {
    var input: UnsafeBufferPointer<UInt8>
    var previous: UInt8

    public static func == (lhs: Cursor, rhs: Cursor) -> Bool {
      return lhs.input.baseAddress == rhs.input.baseAddress
    }

    public func starts<PossiblePrefix>(with possiblePrefix: PossiblePrefix) -> Bool
      where PossiblePrefix: Sequence, PossiblePrefix.Element == UInt8
    {
      return self.input.starts(with: possiblePrefix)
    }

    var pointer: UnsafePointer<UInt8> {
      return self.input.baseAddress!
    }
    func distance(to other: Self) -> Int {
      return self.pointer.distance(to: other.pointer)
    }

    func peek(at offset: Int = 0) -> UInt8 {
      assert(!self.isAtEndOfFile)
      assert(offset >= 0)
      assert(offset < self.input.count)
      return self.input[offset]
    }

    var isAtEndOfFile: Bool {
      return self.input.isEmpty
    }

    var isAtStartOfFile: Bool {
      return !self.input.isEmpty && self.previous == UInt8(ascii: "\0")
    }
  }
}

extension Lexer.Cursor {
  func isLeftBound(_ bufferBegin: Lexer.Cursor) -> Bool {
    // The first character in the file is not left-bound.
    if self.input.baseAddress == bufferBegin.input.baseAddress {
      return false
    }

    switch self.previous {
    case UInt8(ascii: " "), UInt8(ascii: "\r"), UInt8(ascii: "\n"), UInt8(ascii: "\t"), // whitespace
      UInt8(ascii: "("), UInt8(ascii: "["), UInt8(ascii: "{"),            // opening delimiters
      UInt8(ascii: ","), UInt8(ascii: ";"), UInt8(ascii: ":"),              // expression separators
      0:                          // whitespace / last char in file
      return false
    case UInt8(ascii: "/"):
      if self.input.baseAddress! - 1 != bufferBegin.input.baseAddress
          && self.input.baseAddress!.advanced(by: -2).pointee == UInt8(ascii: "*") {
        return false // End of a slash-star comment, so whitespace.
      } else {
        return true
      }
    case 0xA0:
      if self.input.baseAddress! - 1 != bufferBegin.input.baseAddress
          && self.input.baseAddress!.advanced(by: -2).pointee == 0xC2 {
        return false // End of a Non-breaking whitespace (U+00A0).
      } else {
        return true
      }
    default:
      return true
    }
  }

  func isRightBound(_ isLeftBound: Bool) -> Bool {
    guard !self.isAtEndOfFile else {
      return false // last char in file
    }

    switch self.peek() {
    case UInt8(ascii: " "), UInt8(ascii: "\r"), UInt8(ascii: "\n"), UInt8(ascii: "\t"), // whitespace
      UInt8(ascii: ")"), UInt8(ascii: "]"), UInt8(ascii: "}"),              // closing delimiters
      UInt8(ascii: ","), UInt8(ascii: ";"), UInt8(ascii: ":"):              // expression separators
      return false

    case 0:
      //        if (tokEnd == codeCompletionPtr) {         // code-completion
      //          return true
      //        }
      return false                            // whitespace / last char in file

    case UInt8(ascii: "."):
      // Prefer the '^' in "x^.y" to be a postfix op, not binary, but the '^' in
      // "^.y" to be a prefix op, not binary.
      return !isLeftBound

    case UInt8(ascii: "/"):
      // A following comment counts as whitespace, so this token is not right bound.
      if (self.peek(at: 1) == UInt8(ascii: "/") || self.peek(at: 1) == UInt8(ascii: "*")) {
        return false
      } else {
        return true
      }
    case 0xC2:
      if self.input.count > 1, self.peek(at: 1) == 0xA0 {
        return false // Non-breaking whitespace (U+00A0)
      } else {
        return true
      }
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
  fileprivate mutating func backUp(by offset: Int) {
    assert(!self.isAtStartOfFile)
    self.previous = self.input.baseAddress!.advanced(by: -(offset+1)).pointee
    self.input = UnsafeBufferPointer(start: self.input.baseAddress!.advanced(by: -offset), count: self.input.count + offset)
  }

  mutating func advance() -> UInt8? {
    var input = self.input[...]
    guard let c = input.popFirst() else {
      return nil // end of input
    }
    self.previous = c
    self.input = UnsafeBufferPointer(rebasing: input)
    return c
  }

  mutating func advance(matching: UInt8) -> UInt8? {
    guard !self.input.isEmpty else {
      return nil // end of input
    }
    guard self.peek() == matching else {
      return nil
    }
    return self.advance()
  }

  mutating func advance(while predicate: (Unicode.Scalar) -> Bool) {
    var next = self
    while
      !next.isAtEndOfFile,
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
      guard !self.isAtEndOfFile else {
        return false
      }
      switch self.peek() {
      case UInt8(ascii: "\n"):
        fallthrough
      case UInt8(ascii: "\r"):
        return true
      case _ where self.isAtEndOfFile:
        return false
      default:
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
      case _ where self.isAtEndOfFile:
        return isMultiline
      default:
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

    guard clone.advance(matching: UInt8(ascii: #"""#)) != nil else {
      return nil
    }
    self = clone
    return length
  }


  /// advanceIfMultilineDelimiter - Centralized check for multiline delimiter.
  mutating func advanceIfMultilineDelimiter(_ CustomDelimiterLen: Int,
                                            _ IsOpening: Bool = false) -> Bool {
    // Test for single-line string literals that resemble multiline delimiter.
    var TmpPtr = self
    _ = TmpPtr.advance()
    if IsOpening && CustomDelimiterLen != 0 {
      while !TmpPtr.isAtEndOfFile, TmpPtr.peek() != UInt8(ascii: "\r") && TmpPtr.peek() != UInt8(ascii: "\n") {
        if TmpPtr.advance(if: { $0 == Unicode.Scalar(UInt8(ascii: #"""#)) }) {
          if TmpPtr.delimiterMatches(CustomDelimiterLen) {
            return false
          }
          continue
        }
        _ = TmpPtr.advance()
      }
    }

    TmpPtr = self
    if (TmpPtr.previous == UInt8(ascii: #"""#) &&
        TmpPtr.advance(matching: UInt8(ascii: #"""#)) != nil &&
        TmpPtr.advance(matching: UInt8(ascii: #"""#)) != nil) {
      self = TmpPtr
      return true
    }

    return false
  }

  mutating func validateUTF8CharacterAndAdvance() -> Unicode.Scalar? {
    guard let CurByte = self.advance() else {
      return nil
    }

    if (CurByte < 0x80) {
      return Unicode.Scalar(CurByte)
    }

    // Read the number of high bits set, which indicates the number of bytes in
    // the character.
    let EncodedBytes = (~(UInt32(CurByte) << 24)).leadingZeroBitCount
    func isStartOfUTF8Character(_ S: Unicode.Scalar) -> Bool {
      // RFC 2279: The octet values FE and FF never appear.
      // RFC 3629: The octet values C0, C1, F5 to FF never appear.
      let C = S.value
      return C <= 0x80 || (C >= 0xC2 && C < 0xF5)
    }
    // If this is 0b10XXXXXX, then it is a continuation character.
    if (EncodedBytes == 1 ||
        !isStartOfUTF8Character(Unicode.Scalar(CurByte))) {
      // Skip until we get the start of another character.  This is guaranteed to
      // at least stop at the nul at the end of the buffer.
      self.advance(while: { !isStartOfUTF8Character($0) })
      return nil
    }

    // Drop the high bits indicating the # bytes of the result.
    var CharValue = UInt32(CurByte << EncodedBytes) >> EncodedBytes

    // Read and validate the continuation bytes.
    for _ in 1..<EncodedBytes {
      guard !self.isAtEndOfFile else {
        return nil
      }

      let CurByte = self.peek()
      // If the high bit isn't set or the second bit isn't clear, then this is not
      // a continuation byte!
      if (CurByte < 0x80 || CurByte >= 0xC0) {
        return nil
      }

      // Accumulate our result.
      CharValue <<= 6
      CharValue |= UInt32(CurByte & 0x3F)
      _ = self.advance()
    }

    // UTF-16 surrogate pair values are not valid code points.
    if (CharValue >= 0xD800 && CharValue <= 0xDFFF) {
      return nil
    }

    // If we got here, we read the appropriate number of accumulated bytes.
    // Verify that the encoding was actually minimal.
    // Number of bits in the value, ignoring leading zeros.
    let NumBits = 32-CharValue.leadingZeroBitCount
    if (NumBits <= 5+6) {
      return EncodedBytes == 2 ? Unicode.Scalar(CharValue) : nil
    }
    if (NumBits <= 4+6+6) {
      return EncodedBytes == 3 ? Unicode.Scalar(CharValue) : nil
    }
    return EncodedBytes == 4 ? Unicode.Scalar(CharValue) : nil
  }

  mutating func maybeConsumeNewlineEscape() -> Bool {
    var TmpPtr = self
    while true {
      switch TmpPtr.advance() {
      case UInt8(ascii: " "), UInt8(ascii: "\t"):
        continue
      case UInt8(ascii: "\r"):
        _ = TmpPtr.advance(if: { $0 == Unicode.Scalar("\n") })
        fallthrough
      case UInt8(ascii: "\n"):
        self = TmpPtr
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
  mutating func delimiterMatches(_ customDelimiterLength: Int,
                                 _ IsClosing: Bool = false) -> Bool {
    guard customDelimiterLength > 0 else {
      return true
    }

    var TmpPtr = self
    while TmpPtr.advance(matching: UInt8(ascii: "#")) != nil {

    }

    if TmpPtr.input.baseAddress! - self.input.baseAddress! < customDelimiterLength {
      return false
    }

    for _ in 0..<customDelimiterLength {
      _ = self.advance()
    }
    return true
  }

  static func skipToEndOfInterpolatedExpression(_ CurPtr: Lexer.Cursor, _ IsMultilineString: Bool) -> Lexer.Cursor {
    var CurPtr = CurPtr
    var OpenDelimiters = [UInt8]()
    var AllowNewline = [ IsMultilineString ]
    var CustomDelimiter = [Int]()

    let inStringLiteral = { () -> Bool in
      guard let last = OpenDelimiters.last else {
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
      var CustomDelimiterLen = 0
      let Last = CurPtr
      switch CurPtr.advance() {
        // String literals in general cannot be split across multiple lines
        // interpolated ones are no exception - unless multiline literals.
      case UInt8(ascii: "\n"), UInt8(ascii: "\r"):
        if AllowNewline.last! {
          continue
        }
        // Will be diagnosed as an unterminated string literal.
        return Last
      case 0:
        guard !Last.isAtEndOfFile else {
          // CC token or random NUL character.
          continue
        }
        // Will be diagnosed as an unterminated string literal.
        return Last

      case UInt8(ascii: "#"):
        guard !inStringLiteral(), let delim = CurPtr.advanceIfCustomDelimiter() else {
          continue
        }
        CustomDelimiterLen = delim
        assert(CurPtr.previous == UInt8(ascii: #"""#),
               "advanceIfCustomDelimiter() must stop at after the quote")
        fallthrough

      case UInt8(ascii: #"""#), UInt8(ascii: #"'"#):
        if (!inStringLiteral()) {
          // Open string literal.
          OpenDelimiters.append(CurPtr.previous)
          AllowNewline.append(CurPtr.advanceIfMultilineDelimiter(CustomDelimiterLen, true))
          CustomDelimiter.append(CustomDelimiterLen)
          continue
        }

        // In string literal.

        // Skip if it's an another kind of quote in string literal. e.g. "foo's".
        guard OpenDelimiters.last == CurPtr.previous else {
          continue
        }

        // Multi-line string can only be closed by '"""'.
        if (AllowNewline.last! &&
            !CurPtr.advanceIfMultilineDelimiter(CustomDelimiterLen)) {
          continue
        }

        // Check whether we have equivalent number of '#'s.
        guard CurPtr.delimiterMatches(CustomDelimiter.last!, true) else {
          continue
        }

        // Close string literal.
        _ = OpenDelimiters.popLast()
        _ = AllowNewline.popLast()
        _ = CustomDelimiter.popLast()
        continue
      case UInt8(ascii: "\\"):
        // We ignore invalid escape sequence here. They should be diagnosed in
        // the real lexer functions.
        if (inStringLiteral() &&
            CurPtr.delimiterMatches(CustomDelimiter.last!)) {
          let Last = CurPtr
          switch CurPtr.advance() {
          case UInt8(ascii: "("):
            // Entering a recursive interpolated expression
            OpenDelimiters.append(UInt8(ascii: "("))
            continue
          case UInt8(ascii: "\n"), UInt8(ascii: "\r"), 0:
            // Don't jump over newline/EOF due to preceding backslash.
            // Let the outer switch to handle it.
            CurPtr = Last
            continue
          default:
            continue
          }
        }
        continue

        // Paren nesting deeper to support "foo = \((a+b)-(c*d)) bar".
      case UInt8(ascii: "("):
        if (!inStringLiteral()) {
          OpenDelimiters.append(UInt8(ascii: "("))
        }
        continue
      case UInt8(ascii: ")"):
        if OpenDelimiters.isEmpty {
          // No outstanding open delimiters; we're done.
          return Last
        } else if OpenDelimiters.last == UInt8(ascii: "(") {
          // Pop the matching bracket and keep going.
          _ = OpenDelimiters.popLast()
          if OpenDelimiters.isEmpty {
            // No outstanding open delimiters; we're done.
            return Last
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

        if !CurPtr.isAtEndOfFile, CurPtr.peek() == UInt8(ascii: "*") {
          let CommentStart = Last
          let isMultilineComment = CurPtr.advanceToEndOfSlashStarComment()
          if isMultilineComment && !AllowNewline.last! {
            // Multiline comment is prohibited in string literal.
            // Return the start of the comment.
            return CommentStart
          }
        } else if !CurPtr.isAtEndOfFile, CurPtr.peek() == UInt8(ascii: "/") {
          if !AllowNewline.last! {
            // '//' comment is impossible in single line string literal.
            // Return the start of the comment.
            return Last
          }
          // Advance to the end of the comment.
          if CurPtr.advanceToEndOfLine() {
            _ = CurPtr.advance()
          }
        }
        continue
      case nil:
        return CurPtr
      default:
        // Normal token character.
        continue
      }
    }
  }
}

extension Lexer.Cursor {
  mutating func nextToken(_ ContentStart: Lexer.Cursor) -> Lexer.Lexeme {
    // Leading trivia.
    let leadingTriviaStart = self
    let newlineInLeadingTrivia = self.lexTrivia(.leading)

    // Token text.
    let textStart = self
    var (kind, flags) = self.lexImpl(ContentStart: ContentStart)

    // Trailing trivia.
    let trailingTriviaStart = self
    let newlineInTrailingTrivia = self.lexTrivia(.trailing)
    assert(newlineInTrailingTrivia == .absent,
           "trailingTrivia should not have a newline")

    if newlineInLeadingTrivia == .present {
      flags.insert(.isAtStartOfLine)
    }
    return .init(
      tokenKind: kind,
      flags: flags,
      start: leadingTriviaStart.pointer,
      leadingTriviaLength: leadingTriviaStart.distance(to: textStart),
      textLength: textStart.distance(to: trailingTriviaStart),
      trailingTriviaLength: trailingTriviaStart.distance(to: self))
  }

  private mutating func lexImpl(ContentStart: Lexer.Cursor) -> (RawTokenKind, Lexer.Lexeme.Flags) {
    let start = self
    switch self.advance() {
    case UInt8(ascii: "@"): return (.atSign, [])
    case UInt8(ascii: "{"): return (.leftBrace, [])
    case UInt8(ascii: "["): return (.leftSquareBracket, [])
    case UInt8(ascii: "("): return (.leftParen, [])
    case UInt8(ascii: "}"): return (.rightBrace, [])
    case UInt8(ascii: "]"): return (.rightSquareBracket, [])
    case UInt8(ascii: ")"): return (.rightParen, [])

    case UInt8(ascii: ","): return (.comma, [])
    case UInt8(ascii: ";"): return (.semicolon, [])
    case UInt8(ascii: ":"): return (.colon, [])
    case UInt8(ascii: "\\"): return (.backslash, [])

    case UInt8(ascii: "#"):
      // Try lex a raw string literal.
      if let customDelimiterLength = self.advanceIfCustomDelimiter() {
        return self.lexStringLiteral(start, customDelimiterLength)
      }

      // Try lex a regex literal.
      if let token = self.tryLexRegexLiteral(start, ContentStart) {
        return (token, [])
      }
      // Otherwise try lex a magic pound literal.
      return self.lexMagicPoundLiteral()
    case UInt8(ascii: "/"):
      // Try lex a regex literal.
      if let token = self.tryLexRegexLiteral(start, ContentStart) {
        return (token, [])
      }

      // Otherwise try lex a magic pound literal.
      return self.lexOperatorIdentifier(start, ContentStart)
    case UInt8(ascii: "!"):
      if start.isLeftBound(ContentStart) {
        return (.exclamationMark, [])
      }
      return self.lexOperatorIdentifier(start, ContentStart)

    case UInt8(ascii: "?"):
      if start.isLeftBound(ContentStart) {
        return (.postfixQuestionMark, [])
      }
      return self.lexOperatorIdentifier(start, ContentStart)

    case UInt8(ascii: "<"):
      if !self.isAtEndOfFile, self.peek() == UInt8(ascii: "#") {
        return self.tryLexEditorPlaceholder(start, ContentStart)
      }
      return self.lexOperatorIdentifier(start, ContentStart)
    case UInt8(ascii: ">"):
      return self.lexOperatorIdentifier(start, ContentStart)

    case UInt8(ascii: "="), UInt8(ascii: "-"), UInt8(ascii: "+"),
         UInt8(ascii: "*"), UInt8(ascii: "%"), UInt8(ascii: "&"),
         UInt8(ascii: "|"), UInt8(ascii: "^"), UInt8(ascii: "~"),
         UInt8(ascii: "."):
      return self.lexOperatorIdentifier(start, ContentStart)
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
      return self.lexNumber(start, ContentStart)
    case UInt8(ascii: #"'"#), UInt8(ascii: #"""#):
      return self.lexStringLiteral(start)

    case UInt8(ascii: "`"):
      return self.lexEscapedIdentifier(start)
    case nil:
      return (.eof, [])
    default:
      var Tmp = start
      if Tmp.advance(if: { Unicode.Scalar($0).isValidIdentifierStartCodePoint }) {
        return self.lexIdentifier(start)
      }

      if Tmp.advance(if: { Unicode.Scalar($0).isOperatorStartCodePoint }) {
        return self.lexOperatorIdentifier(start, ContentStart)
      }

      let shouldTokenize = self.lexUnknown(start)
      assert(shouldTokenize, "Invalid UTF-8 sequence should be eaten by lexTrivia as LeadingTrivia")
      return (.unknown, [])
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
        guard !self.isAtEndOfFile else {
          break
        }
        if case .trailing = position {
          // Don't lex comments as trailing trivia (for now).
          break
        }

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
      case
        // Punctuation.
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
        if self.input.count > 2,
           self.peek(at: 0) == 0xBB, self.peek(at: 1) == 0xBF {
          // BOM marker.
          _ = self.advance()
          _ = self.advance()
          continue
        }

        fallthrough
      default:
        var Tmp = start
        if Tmp.advance(if: { Unicode.Scalar($0).isValidIdentifierStartCodePoint }) {
          break
        }
        if Tmp.advance(if: { Unicode.Scalar($0).isOperatorStartCodePoint }) {
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
  mutating func lexStringLiteral(_ start: Lexer.Cursor, _ customDelimiterLength: Int = 0) -> (RawTokenKind, Lexer.Lexeme.Flags) {
    assert(self.previous == UInt8(ascii: #"""#) || self.previous == UInt8(ascii: #"'"#))

    let QuoteChar = self.previous
    let IsMultilineString = self.advanceIfMultilineDelimiter(customDelimiterLength, true)
    /*
    if IsMultilineString && *CurPtr != '\n' && *CurPtr != '\r' {
      diagnose(CurPtr, diag::lex_illegal_multiline_string_start)
        .fixItInsert(Lexer::getSourceLoc(CurPtr), "\n")
    }
*/

    var wasErroneous = false
    DELIMITLOOP: while true {
      // Handle string interpolation.
      var TmpPtr = self
      guard TmpPtr.advance() != nil else {
        // This is the end of string, we are done.
        break DELIMITLOOP
      }
      if !self.isAtEndOfFile, self.peek() == UInt8(ascii: "\\") &&
          !TmpPtr.isAtEndOfFile &&
           TmpPtr.delimiterMatches(customDelimiterLength) &&
            TmpPtr.peek() == UInt8(ascii: "(") {
        // Consume tokens until we hit the corresponding ')'.
        self = Self.skipToEndOfInterpolatedExpression(TmpPtr, IsMultilineString)
        if self.advance(if: { $0 == Unicode.Scalar(")") }) {
          // Successfully scanned the body of the expression literal.
          continue
        } else if !self.isAtEndOfFile, ((self.peek() == UInt8(ascii: "\r") || self.peek() == UInt8(ascii: "\n")) && IsMultilineString) {
          // The only case we reach here is unterminated single line string in the
          // interpolation. For better recovery, go on after emitting an error.
//          diagnose(CurPtr, diag::lex_unterminated_string)
          wasErroneous = true
          continue
        } else {
//          diagnose(TokStart, diag::lex_unterminated_string)
          return (.unknown, [])
        }
      }

      // String literals cannot have \n or \r in them (unless multiline).
      if !self.isAtEndOfFile, ((self.peek() == UInt8(ascii: "\r") || self.peek() == UInt8(ascii: "\n")) && !IsMultilineString)
          || self.isAtEndOfFile {
//        diagnose(TokStart, diag::lex_unterminated_string)
        return (.unknown, [])
      }

      let CharValue = self.lexCharacter(QuoteChar, IsMultilineString, customDelimiterLength)
      switch CharValue {
      case .endOfString:
        // This is the end of string, we are done.
        break DELIMITLOOP
      case .error:
        // Remember we had already-diagnosed invalid characters.
        wasErroneous = true
      default:
        break
      }
    }

//    if QuoteChar == UInt8(ascii: #"'"#) {
//      assert(!IsMultilineString && customDelimiterLength == 0,
//             "Single quoted string cannot have custom delimitor, nor multiline")
//      diagnoseSingleQuoteStringLiteral(TokStart, CurPtr)
//    }

    if wasErroneous {
      return (.unknown, [])
    }

    return (.stringLiteral, IsMultilineString ? .isMultilineStringLiteral : [])
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
  mutating func lexCharacter(_ StopQuote: UInt8, _ IsMultilineString: Bool,
                             _ CustomDelimiterLen: Int) -> CharacterLex {
    let CharStart = self

    switch self.advance() {
    case UInt8(ascii: #"""#), UInt8(ascii: #"'"#):
      if self.previous == StopQuote {
        // Mutliline and custom escaping are only enabled for " quote.
        if StopQuote != UInt8(ascii: #"""#) {
          return .endOfString
        }
        if !IsMultilineString && CustomDelimiterLen == 0 {
          return .endOfString
        }

        var TmpPtr = self
        if IsMultilineString &&
            !TmpPtr.advanceIfMultilineDelimiter(CustomDelimiterLen) {
          return .success(Unicode.Scalar(UInt8(ascii: #"""#)))
        }
        if CustomDelimiterLen > 0 &&
            !TmpPtr.delimiterMatches(CustomDelimiterLen, /*IsClosing=*/true) {
          return .success(Unicode.Scalar(UInt8(ascii: #"""#)))
        }
        self = TmpPtr
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
      assert(IsMultilineString, "Caller must handle newlines in non-multiline")
      return .success(Unicode.Scalar(self.previous))

    case UInt8(ascii: "\\"):  // Escapes.
      if !self.delimiterMatches(CustomDelimiterLen) {
        return .success(Unicode.Scalar("\\"))
      }
      guard
        let c = self.lexEscapedCharacter(IsMultilineString),
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
      self = CharStart
      guard let CharValue = self.validateUTF8CharacterAndAdvance() else {
        //      if (EmitDiagnostics)
        //        diagnose(CharStart, diag::lex_invalid_utf8)
        return .error
      }
      return .success(CharValue)
    }
  }


  fileprivate mutating func lexEscapedCharacter(_ IsMultilineString: Bool) -> UInt32? {
    guard !self.isAtEndOfFile else {
      return nil
    }

    // Escape processing.  We already ate the "\".
    switch self.peek() {
      // Simple single-character escapes.
    case UInt8(ascii: "0"):   _ = self.advance(); return UInt32(UInt8(ascii: "\0"))
    case UInt8(ascii: "n"):   _ = self.advance(); return UInt32(UInt8(ascii: "\n"))
    case UInt8(ascii: "r"):   _ = self.advance(); return UInt32(UInt8(ascii: "\r"))
    case UInt8(ascii: "t"):   _ = self.advance(); return UInt32(UInt8(ascii: "\t"))
    case UInt8(ascii: #"""#): _ = self.advance(); return UInt32(UInt8(ascii: #"""#))
    case UInt8(ascii: #"'"#): _ = self.advance(); return UInt32(UInt8(ascii: #"'"#))
    case UInt8(ascii: "\\"):  _ = self.advance(); return UInt32(UInt8(ascii: "\\"))

    case UInt8(ascii: "u"):  //  \u HEX HEX HEX HEX
      _ = self.advance()
      guard !self.isAtEndOfFile, self.peek() == UInt8(ascii: "{") else {
        //        if (EmitDiagnostics)
        //          diagnose(CurPtr-1, diag::lex_unicode_escape_braces)
        return nil
      }

      guard let cv = self.lexUnicodeEscape() else {
        return nil
      }
      return cv

    case UInt8(ascii: " "), UInt8(ascii: "\t"), UInt8(ascii: "\n"), UInt8(ascii: "\r"):
      if IsMultilineString && self.maybeConsumeNewlineEscape() {
        return UInt32(UInt8(ascii: "\n"))
      }
      fallthrough
    default:  // Invalid escape.
      //     if (EmitDiagnostics)
      //       diagnose(CurPtr, diag::lex_invalid_escape)
      // If this looks like a plausible escape character, recover as though this
      // is an invalid escape.
      let c = Unicode.Scalar(self.peek())
      if c.isDigit || c.isLetter {
        _ = self.advance()
      }
      return nil
    }
  }

  fileprivate mutating func lexUnicodeEscape() -> UInt32? {
    assert(self.peek() == UInt8(ascii: "{"), "Invalid unicode escape")
    _ = self.advance()

    let DigitStart = self
    var NumDigits = 0;
    while self.advance(if: { $0.isHexDigit }) {
      NumDigits += 1
    }

    if !self.isAtEndOfFile, self.peek() != UInt8(ascii: "}") {
//      if (Diags)
//        Diags->diagnose(CurPtr, diag::lex_invalid_u_escape_rbrace)
      return nil
    }
    _ = self.advance()

    if (NumDigits < 1 || NumDigits > 8) {
//      if (Diags)
//        Diags->diagnose(CurPtr, diag::lex_invalid_u_escape)
      return nil
    }

    return UInt32(String(decoding: DigitStart.input[0..<NumDigits], as: UTF8.self), radix: 16)
  }
}

extension Lexer.Cursor {
  enum ExpectedDigitKind {
    case binary
    case octal
    case decimal
    case hex
  }


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
  mutating func lexNumber(_ TokStart: Lexer.Cursor, _ ContentStart: Lexer.Cursor) -> (RawTokenKind, Lexer.Lexeme.Flags) {
    assert((Unicode.Scalar(self.previous).isDigit || self.previous == UInt8(ascii: ".")),
           "Unexpected start")

//    let expected_int_digit = { (loc: Lexer.Cursor, kind: ExpectedDigitKind) -> TokenKind in
//      diagnose(loc, diag::lex_invalid_digit_in_int_literal, StringRef(loc, 1),
//               (unsigned)kind)
//      loc.advance(while: { $0.isValidIdentifierContinuationCodePoint })
//      return .unknown(TokStart.adoptRange(upTo: loc) { stringBuf in
//        String(decoding: stringBuf, as: UTF8.self)
//      })
//    }

    if !self.isAtEndOfFile && self.previous == UInt8(ascii: "0") && self.peek() == UInt8(ascii: "x") {
      return self.lexHexNumber(TokStart)
    }

    if !self.isAtEndOfFile && self.previous == UInt8(ascii: "0") && self.peek() == UInt8(ascii: "o") {
      // 0o[0-7][0-7_]*
      _ = self.advance()
      if !self.isAtEndOfFile, self.peek() < UInt8(ascii: "0") || self.peek() > UInt8(ascii: "7") {
//        return expected_int_digit(self, .octal)
        self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
        return (.unknown, [])
      }

      self.advance(while: {
        ($0 >= Unicode.Scalar("0") && $0 <= Unicode.Scalar("7")) || $0 == Unicode.Scalar("_")
      })

//      let tmp = self
      if self.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
//        return expected_int_digit(tmp, .octal)
        self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
        return (.unknown, [])
      }

      return (.integerLiteral, [])
    }

    if !self.isAtEndOfFile && TokStart.peek() == UInt8(ascii: "0") && self.peek() == UInt8(ascii: "b") {
      // 0b[01][01_]*
      _ = self.advance()
      if !self.isAtEndOfFile, self.peek() != UInt8(ascii: "0") && self.peek() != UInt8(ascii: "1") {
//        return expected_int_digit(self, .binary)
        self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
        return (.unknown, [])
      }

      self.advance(while: {
        $0 == Unicode.Scalar("0") || $0 == Unicode.Scalar("1") || $0 == Unicode.Scalar("_")
      })

//      let tmp = self
      if self.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
//        return expected_int_digit(tmp, .binary)
        self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
        return (.unknown, [])
      }

      return (.integerLiteral, [])
    }

    // Handle a leading [0-9]+, lexing an integer or falling through if we have a
    // floating point value.
    self.advance(while: { $0.isDigit || $0 == Unicode.Scalar("_") })

    // Lex things like 4.x as '4' followed by a tok::period.
    if !self.isAtEndOfFile, self.peek() == UInt8(ascii: ".") {
      // NextToken is the soon to be previous token
      // Therefore: x.0.1 is sub-tuple access, not x.float_literal
      if self.input.count > 1, !Unicode.Scalar(self.peek(at: 1)).isDigit || TokStart.previous == UInt8(ascii: ".") {
        return (.integerLiteral, [])
      }
    } else {
      // Floating literals must have '.', 'e', or 'E' after digits.  If it is
      // something else, then this is the end of the token.
      if self.isAtEndOfFile || (self.peek() != UInt8(ascii: "e") && self.peek() != UInt8(ascii: "E")) {
        var tmp = self
        if tmp.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
//          return expected_int_digit(tmp, .decimal)
          self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
          return (.unknown, [])
        }

        return (.integerLiteral, [])
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

      guard !self.isAtEndOfFile, Unicode.Scalar(self.peek()).isDigit else {
        // There are 3 cases to diagnose if the exponent starts with a non-digit:
        // identifier (invalid character), underscore (invalid first character),
        // non-identifier (empty exponent)
//        let tmp = self
//        if (advanceIfValidContinuationOfIdentifier(CurPtr, BufferEnd))
//          diagnose(tmp, diag::lex_invalid_digit_in_fp_exponent, StringRef(tmp, 1),
//                   *tmp == '_')
//        else
//          diagnose(CurPtr, diag::lex_expected_digit_in_fp_exponent)

        self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
        return (.unknown, [])
      }

      self.advance(while: { char in
        char.isDigit || char == Unicode.Scalar("_")
      })

      if self.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
//        diagnose(tmp, diag::lex_invalid_digit_in_fp_exponent, StringRef(tmp, 1),
//                 false)
        self.advance(while: { $0.isValidIdentifierContinuationCodePoint })
        return (.unknown, [])
      }
    }

    return (.floatingLiteral, [])
  }

  mutating func lexHexNumber(_ TokStart: Lexer.Cursor) -> (RawTokenKind, Lexer.Lexeme.Flags) {
    // We assume we're starting from the 'x' in a '0x...' floating-point literal.
    assert(self.peek() == UInt8(ascii: "x"), "not a hex literal")
    assert(self.previous == UInt8(ascii: "0"), "not a hex literal")

    let expected_digit = { (end: Lexer.Cursor) -> (RawTokenKind, Lexer.Lexeme.Flags) in
      var end = end
      end.advance(while: { $0.isValidIdentifierContinuationCodePoint })
      return (.unknown, [])
    }

                                                   let expected_hex_digit = { (loc: Lexer.Cursor) -> (RawTokenKind, Lexer.Lexeme.Flags) in
//      diagnose(loc, diag::lex_invalid_digit_in_hex_literal, StringRef(loc, 1),
//               (unsigned)kind)
      return expected_digit(loc)
    }

    // 0x[0-9a-fA-F][0-9a-fA-F_]*
    _ = self.advance()
    guard !self.isAtEndOfFile, Unicode.Scalar(self.peek()).isHexDigit else {
      return expected_hex_digit(self)
    }

    self.advance(while: { $0.isHexDigit || $0 == Unicode.Scalar("_") })

    guard !self.isAtEndOfFile else {
      return (.integerLiteral, [])
    }

    if self.peek() != UInt8(ascii: ".") && self.peek() != UInt8(ascii: "p") && self.peek() != UInt8(ascii: "P") {
      let tmp = self
      if self.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
        return expected_hex_digit(tmp)
      } else {
        return (.integerLiteral, [])
      }
    }

    // (\.[0-9A-Fa-f][0-9A-Fa-f_]*)?
    var PtrOnDot: Lexer.Cursor? = self
    if self.advance(if: { $0 == Unicode.Scalar(".") }) {
      // If the character after the '.' is not a digit, assume we have an int
      // literal followed by a dot expression.
      if !self.isAtEndOfFile, !Unicode.Scalar(self.peek()).isHexDigit {
        self = PtrOnDot!
        return (.integerLiteral, [])
      }

      self.advance(while: { $0.isHexDigit || $0 == Unicode.Scalar("_") })

      if !self.isAtEndOfFile, self.peek() != UInt8(ascii: "p") && self.peek() != UInt8(ascii: "P") {
        if !Unicode.Scalar(PtrOnDot!.peek(at: 1)).isDigit {
          // e.g: 0xff.description
          self = PtrOnDot!
          return (.integerLiteral, [])
        }
//        diagnose(CurPtr, diag::lex_expected_binary_exponent_in_hex_float_literal)
        return (.unknown, [])
      }
    } else {
      PtrOnDot = nil
    }

    // [pP][+-]?[0-9][0-9_]*
    assert(self.isAtEndOfFile || self.peek() == UInt8(ascii: "p") || self.peek() == UInt8(ascii: "P"), "not at a hex float exponent?!")
    _ = self.advance()

    var signedExponent = false
    if self.advance(if: { $0 == Unicode.Scalar("+") || $0 == Unicode.Scalar("-") }) {
      // Eat the sign.
      signedExponent = true
    }

    if !self.isAtEndOfFile, !Unicode.Scalar(self.peek()).isDigit {
      if let PtrOnDot = PtrOnDot, !Unicode.Scalar(PtrOnDot.peek(at: 1)).isDigit && !signedExponent {
        // e.g: 0xff.fpValue, 0xff.fp
        self = PtrOnDot
        return (.integerLiteral, [])
      }
      // Note: 0xff.fp+otherExpr can be valid expression. But we don't accept it.

      // There are 3 cases to diagnose if the exponent starts with a non-digit:
      // identifier (invalid character), underscore (invalid first character),
      // non-identifier (empty exponent)
      if self.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
//        diagnose(tmp, diag::lex_invalid_digit_in_fp_exponent, StringRef(tmp, 1),
//                 *tmp == '_')
      } else {
//        diagnose(CurPtr, diag::lex_expected_digit_in_fp_exponent)
      }
      return expected_digit(self)
    }

    self.advance(while: { $0.isDigit || $0 == Unicode.Scalar("_") })

    if self.advance(if: { $0.isValidIdentifierContinuationCodePoint }) {
//      diagnose(tmp, diag::lex_invalid_digit_in_fp_exponent, StringRef(tmp, 1),
//               false)
      return expected_digit(self)
    }

    return (.floatingLiteral, [])
  }
}

extension Lexer.Cursor {
  mutating func lexMagicPoundLiteral() -> (RawTokenKind, Lexer.Lexeme.Flags) {
    let start = self
    var clone = self
    // Scan for [a-zA-Z]+ to see what we match.
    if !clone.isAtEndOfFile && Unicode.Scalar(clone.peek()).isAsciiIdentifierStart {
      repeat {
        _ = clone.advance()
      } while !clone.isAtEndOfFile && Unicode.Scalar(clone.peek()).isAsciiIdentifierContinue
    }

    let literal = start.textUpTo(clone)

    let kind: RawTokenKind
    switch literal {
    case "keyPath": kind = .poundKeyPathKeyword
    case "line": kind = .poundLineKeyword
    case "selector": kind = .poundSelectorKeyword
    case "file": kind = .poundFileKeyword
    case "fileID": kind = .poundFileIDKeyword
    case "filePath": kind = .poundFilePathKeyword
    case "column": kind = .poundColumnKeyword
    case "function": kind = .poundFunctionKeyword
    case "dsohandle": kind = .poundDsohandleKeyword
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
    case "fileLiteral": kind = .poundFileLiteralKeyword
    case "imageLiteral": kind = .poundImageLiteralKeyword
    case "colorLiteral": kind = .poundColorLiteralKeyword
    case "_hasSymbol": kind = .poundHasSymbolKeyword
    default:
      // If we didn't find a match, then just return `.pound`.  This is highly
      // dubious in terms of error recovery, but is useful for code completion and
      // SIL parsing.
      return (.pound, [])
    }

    // If we found something specific, return it.
    self = clone
    return (kind, [])
  }
}

// MARK: - Identifiers

extension Lexer.Cursor {
  /// lexIdentifier - Match [a-zA-Z_][a-zA-Z_$0-9]*
  mutating func lexIdentifier(_ tokStart: Lexer.Cursor) -> (RawTokenKind, Lexer.Lexeme.Flags) {
    self = tokStart
    let didStart = self.advance(if: { $0.isValidIdentifierStartCodePoint })
    assert(didStart, "Unexpected start")

    // Lex [a-zA-Z_$0-9[[:XID_Continue:]]]*
    self.advance(while: { $0.isValidIdentifierContinuationCodePoint })

    let text = tokStart.textUpTo(self)
    return (RawTokenKind(keyword: text) ?? .identifier, [])
  }

  mutating func lexEscapedIdentifier(_ Quote: Lexer.Cursor) -> (RawTokenKind, Lexer.Lexeme.Flags) {
    assert(self.previous == UInt8(ascii: "`"), "Unexpected start of escaped identifier")

    // Check whether we have an identifier followed by another backtick, in which
    // case this is an escaped identifier.
    let IdentifierStart = self
    if self.advance(if: { $0.isValidIdentifierStartCodePoint }) {
      // Keep continuing the identifier.
      self.advance(while: { $0.isValidIdentifierContinuationCodePoint })

      // If we have the terminating "`", it's an escaped identifier.
      if self.advance(if: { $0 == Unicode.Scalar("`") }) {
        return (.identifier, [])
      }
    }

    // Special case; allow '`$`'.
    if Quote.starts(with: "`$`".utf8) {
      self = Quote
      _ = self.advance()
      _ = self.advance()
      _ = self.advance()
      return (.identifier, [])
    }

    // The backtick is punctuation.
    self = IdentifierStart
    return (.backtick, [])
  }

  mutating func lexOperatorIdentifier(_ TokStart: Lexer.Cursor, _ ContentStart: Lexer.Cursor) -> (RawTokenKind, Lexer.Lexeme.Flags) {
    self = TokStart
    let didStart = self.advance(if: { $0.isOperatorStartCodePoint })
    assert(didStart, "unexpected operator start")

    repeat {
      // '.' cannot appear in the middle of an operator unless the operator
      // started with a '.'.
      if !self.isAtEndOfFile, self.peek() == UInt8(ascii: ".") && TokStart.peek() != UInt8(ascii: ".") {
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

    if self.input.baseAddress!-TokStart.input.baseAddress! > 2 {
      // If there is a "//" or "/*" in the middle of an identifier token,
      // it starts a comment.
      var Ptr = TokStart
      _ = Ptr.advance()
      while Ptr.input.baseAddress! < self.input.baseAddress! {
        defer { _ = Ptr.advance() }
        if self.input.count > 1, (Ptr.peek() == UInt8(ascii: "/") && (Ptr.peek(at: 1) == UInt8(ascii: "/") || Ptr.peek(at: 1) == UInt8(ascii: "*"))) {
          self = Ptr
          break
        }
      }
    }

    // Decide between the binary, prefix, and postfix cases.
    // It's binary if either both sides are bound or both sides are not bound.
    // Otherwise, it's postfix if left-bound and prefix if right-bound.
    let leftBound = TokStart.isLeftBound(ContentStart)
    let rightBound = self.isRightBound(leftBound)

    // Match various reserved words.
    if self.input.baseAddress! - TokStart.input.baseAddress! == 1 {
      switch TokStart.peek() {
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
        return (.equal, [])
      case UInt8(ascii: "&"):
        if leftBound == rightBound || leftBound {
          break
        }
        return (.prefixAmpersand, [])
      case UInt8(ascii: "."):
        if leftBound == rightBound {
          return (.period, [])
        }

        if rightBound {
          return (.prefixPeriod, [])
        }

        // If left bound but not right bound, handle some likely situations.

        // If there is just some horizontal whitespace before the next token, its
        // addition is probably incorrect.
        var AfterHorzWhitespace = self
        while !AfterHorzWhitespace.isAtEndOfFile, AfterHorzWhitespace.peek() == UInt8(ascii: " ") || AfterHorzWhitespace.peek() == UInt8(ascii: "\t") {
          _ = AfterHorzWhitespace.advance()
        }

//        // First, when we are code completing "x. <ESC>", then make sure to return
//        // a tok::period, since that is what the user is wanting to know about.
//        if (AfterHorzWhitespace.peek() == 0 &&
//            AfterHorzWhitespace == CodeCompletionPtr) {
//          diagnose(TokStart, diag::expected_member_name)
//          return formToken(tok::period, TokStart)
//        }

//        if AfterHorzWhitespace.isRightBound(leftBound) &&
//            // Don't consider comments to be this.  A leading slash is probably
//            // either // or /* and most likely occurs just in our testsuite for
//            // expected-error lines.
//            AfterHorzWhitespace.peek() != UInt8(ascii: "/") {
//          diagnose(TokStart, diag::extra_whitespace_period)
//            .fixItRemoveChars(getSourceLoc(CurPtr),
//                              getSourceLoc(AfterHorzWhitespace))
//          return formToken(tok::period, TokStart)
//        }

        // Otherwise, it is probably a missing member.
//        diagnose(TokStart, diag::expected_member_name)
        return (.unknown, [])
      case UInt8(ascii: "?"):
        if (leftBound) {
          return (.postfixQuestionMark, [])
        }
        return (.infixQuestionMark, [])
      default:
        break
      }
    } else if (self.input.baseAddress! - TokStart.input.baseAddress! == 2) {
      switch (TokStart.peek(), TokStart.peek(at: 1)) {
      case (UInt8(ascii: "-"), UInt8(ascii: ">")): // ->
        return (.arrow, [])
      case (UInt8(ascii: "*"), UInt8(ascii: "/")): // */
//        diagnose(TokStart, diag::lex_unexpected_block_comment_end)
        return (.unknown, [])
      default:
        break
      }
    } else {
      // Verify there is no "*/" in the middle of the identifier token, we reject
      // it as potentially ending a block comment.
      if TokStart.textUpTo(self).contains("*/") {
//        diagnose(TokStart+Pos, diag::lex_unexpected_block_comment_end)
        return (.unknown, [])
      }
    }

    if leftBound == rightBound {
      if leftBound {
        return (.unspacedBinaryOperator, [])
      } else {
        return (.spacedBinaryOperator, [])
      }
    } else if leftBound {
      return (.postfixOperator, [])
    } else {
      return (.prefixOperator, [])
    }
  }

  mutating func lexDollarIdentifier(_ tokStart: Lexer.Cursor) -> (RawTokenKind, Lexer.Lexeme.Flags) {
    assert(self.previous == UInt8(ascii: "$"))

    var isAllDigits = true
    while true {
      if !self.isAtEndOfFile, Unicode.Scalar(self.peek()).isDigit {
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
      return (.identifier, [])
    }

    if !isAllDigits {
      return (.identifier, [])
    } else {
      return (.dollarIdentifier, [])
    }
  }
}

// MARK: - Editor Placeholders

extension Lexer.Cursor {
  mutating func tryLexEditorPlaceholder(_ TokStart: Lexer.Cursor, _ ContentStart: Lexer.Cursor) -> (RawTokenKind, Lexer.Lexeme.Flags) {
    assert(self.previous == UInt8(ascii: "<") && self.peek() == UInt8(ascii: "#"))
    var Ptr = self
    _ = Ptr.advance()
    while !Ptr.isAtEndOfFile {
      defer { _ = Ptr.advance() }
      if (Ptr.peek() == UInt8(ascii: "\n")) {
        break
      }
      guard !Ptr.starts(with: "<#".utf8) else {
        break
      }

      if Ptr.starts(with: "#>".utf8) {
        // Found it.
        _ = Ptr.advance()
        _ = Ptr.advance()
        self = Ptr
        return (.identifier, [])
      }
    }

    // Not a well-formed placeholder.
    return self.lexOperatorIdentifier(TokStart, ContentStart)
  }
}

// MARK: - Unknown Syntax

extension Lexer.Cursor {
  private func findEndOfCurlyQuoteStringLiteral() -> Lexer.Cursor? {
    var Body = self
    while true {
      // Don't bother with string interpolations.
      if !Body.isAtEndOfFile, Body.peek(at: 0) == UInt8(ascii: "\\") && Body.peek(at: 1) == UInt8(ascii: "(") {
        return nil
      }

      // We didn't find the end of the string literal if we ran to end of line.
      if Body.isAtEndOfFile || Body.peek() == UInt8(ascii: "\r") || Body.peek() == UInt8(ascii: "\n") {
        return nil
      }

      // Get the next character.
      switch Body.lexCharacter(0, false, 0) {
      case .error, .endOfString:
        // If the character was incorrectly encoded, give up.
        return nil
      case .success(let CharValue) where CharValue == Unicode.Scalar(UInt8(ascii: #"""#)):
        // If we found a straight-quote, then we're done.  Just return the spot
        // to continue.
        return Body
      case .validated(let CharValue) where CharValue == Character(Unicode.Scalar(0x0000201D)!):
        // If we found an ending curly quote (common since this thing started with
        // an opening curly quote) diagnose it with a fixit and then return.
        //        if (EmitDiagnostics) {
        //          diagnose(CharStart, diag::lex_invalid_curly_quote)
        //              .fixItReplaceChars(getSourceLoc(CharStart), getSourceLoc(Body),
        //                                 "\"")
        //        }
        return Body
      default:
        continue
      }
    }
  }

  mutating func lexUnknown(_ start: Lexer.Cursor) -> Bool {
    var Tmp = start
    if Tmp.advance(if: { Unicode.Scalar($0).isValidIdentifierContinuationCodePoint }) {
      // If this is a valid identifier continuation, but not a valid identifier
      // start, attempt to recover by eating more continuation characters.
//      if (EmitDiagnosticsIfToken) {
//        diagnose(CurPtr - 1, diag::lex_invalid_identifier_start_character)
//      }
      while Tmp.advance(if: { Unicode.Scalar($0).isValidIdentifierContinuationCodePoint }) {

      }
      self = Tmp
      return true
    }

    // This character isn't allowed in Swift source.
    guard let Codepoint = Tmp.validateUTF8CharacterAndAdvance() else {
//      diagnose(CurPtr - 1, diag::lex_invalid_utf8)
//          .fixItReplaceChars(getSourceLoc(CurPtr - 1), getSourceLoc(Tmp), " ")
      self = Tmp
      return false; // Skip presumed whitespace.
    }
    if (Codepoint.value == 0x000000A0) {
        // Non-breaking whitespace (U+00A0)
      while (Tmp.peek(at: 0) == 0xC2 && Tmp.peek(at: 1) == 0xA0) {
        _ = Tmp.advance()
        _ = Tmp.advance()
      }

//      SmallString<8> Spaces
//      Spaces.assign((Tmp - CurPtr + 1) / 2, ' ')
//      diagnose(CurPtr - 1, diag::lex_nonbreaking_space)
//        .fixItReplaceChars(getSourceLoc(CurPtr - 1), getSourceLoc(Tmp),
//                           Spaces)
      self = Tmp
      return false
    } else if (Codepoint.value == 0x0000201D) {
      // If this is an end curly quote, just diagnose it with a fixit hint.
//      if (EmitDiagnosticsIfToken) {
//        diagnose(CurPtr - 1, diag::lex_invalid_curly_quote)
//            .fixItReplaceChars(getSourceLoc(CurPtr - 1), getSourceLoc(Tmp), "\"")
//      }
      self = Tmp
      return true
    } else if (Codepoint.value == 0x0000201C) {
      // If this is a start curly quote, do a fuzzy match of a string literal
      // to improve recovery.
      if let Tmp2 = Tmp.findEndOfCurlyQuoteStringLiteral() {
        Tmp = Tmp2
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
      self = Tmp
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

    self = Tmp
    return false; // Skip presumed whitespace.
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

    let kind = start.peek() == UInt8(ascii: "<") ? ConflictMarker.normal : .perforce
    guard let End = Self.findConflictEnd(start, kind) else {
      // No end of conflict marker found.
      return false
    }

    // Diagnose at the conflict marker, then jump ahead to the end.
//    diagnose(CurPtr, diag::lex_conflict_marker_in_file);
    self = End

    // Skip ahead to the end of the marker.
    if !self.isAtEndOfFile {
      _ = self.advanceToEndOfLine()
    }
    return true
  }

  /// Find the end of a version control conflict marker.
  static func findConflictEnd(_ CurPtr: Lexer.Cursor, _ CMK: ConflictMarker) -> Lexer.Cursor? {
    // Get a reference to the rest of the buffer minus the length of the start
    // of the conflict marker.
    let advanced = CurPtr.input.baseAddress?.advanced(by: CMK.introducer.utf8.count)
    var restOfBuffer = Lexer.Cursor(input: .init(start: advanced, count: CurPtr.input.count - CMK.introducer.utf8.count),
                                    previous: CurPtr.input[CMK.introducer.utf8.count-1])
    while !restOfBuffer.isAtEndOfFile {
      let terminatorStart = CMK.terminator.utf8.first!
      restOfBuffer.advance(while: { byte in
        byte != Unicode.Scalar(terminatorStart)
      })

      guard restOfBuffer.starts(with: CMK.terminator.utf8) else {
        _ = restOfBuffer.advance()
        continue
      }

      // Must occur at start of line.
      guard restOfBuffer.previous == UInt8(ascii: "\n") || restOfBuffer.previous == UInt8(ascii: "\r") else {
        continue
      }

      let advanced = restOfBuffer.input.baseAddress?.advanced(by: CMK.terminator.utf8.count)
      return Lexer.Cursor(input: .init(start: advanced, count: restOfBuffer.input.count - CMK.terminator.utf8.count),
                          previous: restOfBuffer.input[CMK.terminator.utf8.count-1])
    }
    return nil
  }
}

extension Lexer.Cursor {
  mutating func tryLexRegexLiteral(
    _ TokStart: Lexer.Cursor,
    _ ContentStart: Lexer.Cursor
  ) -> RawTokenKind? {
    guard !TokStart.isLeftBound(ContentStart) else {
      return nil
    }

    var Tmp = TokStart
    var poundCount = 0
    var parenCount = 0

    while Tmp.advance(matching: UInt8(ascii: "#")) != nil {
      poundCount += 1
    }

    guard Tmp.advance(matching: UInt8(ascii: "/")) != nil else {
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
    if poundCount == 0 && !Tmp.isAtEndOfFile &&
        (Tmp.peek() == UInt8(ascii: " ") || Tmp.peek() == UInt8(ascii: "\n") || Tmp.peek() == UInt8(ascii: "\t")) {
      return nil
    }

    var isMultiline = false
    while !Tmp.isAtEndOfFile {
      switch Tmp.peek() {
      case UInt8(ascii: " "), UInt8(ascii: "\t"):
        _ = Tmp.advance()
        continue
      case UInt8(ascii: "\n"), UInt8(ascii: "\r"):
        isMultiline = true
      default:
        break
      }
      break
    }

    var escaped = false
    DELIMITLOOP: while true {
      defer { escaped = false }

      let previousByte = Tmp.previous
      switch Tmp.advance() {
      case nil:
        return nil
      case UInt8(ascii: "/"):
        // If we're at the end of the literal, peek ahead to see if the closing
        // slash is actually the start of a comment.
        if !Tmp.isAtEndOfFile &&
            (Tmp.peek() == UInt8(ascii: "/") || Tmp.peek() == UInt8(ascii: "*")) {
          return nil
        }

        var EndLex = Tmp
        for _ in 0..<poundCount {
          guard EndLex.advance(matching: UInt8(ascii: "#")) != nil else {
            continue DELIMITLOOP
          }
        }

        // A regex literal may not end in a space or tab.
        if !isMultiline && poundCount == 0 &&
          (previousByte == UInt8(ascii: " ") ||
           previousByte == UInt8(ascii: "\t")) {
          return nil
        }

        Tmp = EndLex
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
        _ = Tmp.advance()
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
    self = Tmp
    return .regexLiteral
  }
}

extension Unicode.Scalar {
  var isValidIdentifierContinuationCodePoint: Bool {
    let c = self.value
    if c < 0x80 {
      return self.isAsciiIdentifierContinue || c == UInt32(UInt8(ascii: "$"))
    }

    // N1518: Recommendations for extended identifier characters for C and C++
    // Proposed Annex X.1: Ranges of characters allowed
    return c == 0x00A8 || c == 0x00AA || c == 0x00AD || c == 0x00AF
      || (c >= 0x00B2 && c <= 0x00B5) || (c >= 0x00B7 && c <= 0x00BA)
      || (c >= 0x00BC && c <= 0x00BE) || (c >= 0x00C0 && c <= 0x00D6)
      || (c >= 0x00D8 && c <= 0x00F6) || (c >= 0x00F8 && c <= 0x00FF)

      || (c >= 0x0100 && c <= 0x167F)
      || (c >= 0x1681 && c <= 0x180D)
      || (c >= 0x180F && c <= 0x1FFF)

      || (c >= 0x200B && c <= 0x200D)
      || (c >= 0x202A && c <= 0x202E)
      || (c >= 0x203F && c <= 0x2040)
      || c == 0x2054
      || (c >= 0x2060 && c <= 0x206F)

      || (c >= 0x2070 && c <= 0x218F)
      || (c >= 0x2460 && c <= 0x24FF)
      || (c >= 0x2776 && c <= 0x2793)
      || (c >= 0x2C00 && c <= 0x2DFF)
      || (c >= 0x2E80 && c <= 0x2FFF)

      || (c >= 0x3004 && c <= 0x3007)
      || (c >= 0x3021 && c <= 0x302F)
      || (c >= 0x3031 && c <= 0x303F)

      || (c >= 0x3040 && c <= 0xD7FF)

      || (c >= 0xF900 && c <= 0xFD3D)
      || (c >= 0xFD40 && c <= 0xFDCF)
      || (c >= 0xFDF0 && c <= 0xFE44)
      || (c >= 0xFE47 && c <= 0xFFF8)

      || (c >= 0x10000 && c <= 0x1FFFD)
      || (c >= 0x20000 && c <= 0x2FFFD)
      || (c >= 0x30000 && c <= 0x3FFFD)
      || (c >= 0x40000 && c <= 0x4FFFD)
      || (c >= 0x50000 && c <= 0x5FFFD)
      || (c >= 0x60000 && c <= 0x6FFFD)
      || (c >= 0x70000 && c <= 0x7FFFD)
      || (c >= 0x80000 && c <= 0x8FFFD)
      || (c >= 0x90000 && c <= 0x9FFFD)
      || (c >= 0xA0000 && c <= 0xAFFFD)
      || (c >= 0xB0000 && c <= 0xBFFFD)
      || (c >= 0xC0000 && c <= 0xCFFFD)
      || (c >= 0xD0000 && c <= 0xDFFFD)
      || (c >= 0xE0000 && c <= 0xEFFFD)
  }

  var isValidIdentifierStartCodePoint: Bool {
    guard self.isValidIdentifierContinuationCodePoint else {
      return false
    }

    let c = self.value
    if c < 0x80 && (self.isDigit || c == UInt8(ascii: "$")) {
      return false
    }

    // N1518: Recommendations for extended identifier characters for C and C++
    // Proposed Annex X.2: Ranges of characters disallowed initially
    if ((c >= 0x0300 && c <= 0x036F) ||
        (c >= 0x1DC0 && c <= 0x1DFF) ||
        (c >= 0x20D0 && c <= 0x20FF) ||
        (c >= 0xFE20 && c <= 0xFE2F)) {
      return false
    }

    return true
  }

  /// isOperatorStartCodePoint - Return true if the specified code point is a
  /// valid start of an operator.
  var isOperatorStartCodePoint: Bool {
    // ASCII operator chars.
    if self.value < 0x80 {
      switch UInt8(self.value) {
      case UInt8(ascii: "/"),
        UInt8(ascii: "="),
        UInt8(ascii: "-"),
        UInt8(ascii: "+"),
        UInt8(ascii: "*"),
        UInt8(ascii: "%"),
        UInt8(ascii: "<"),
        UInt8(ascii: ">"),
        UInt8(ascii: "!"),
        UInt8(ascii: "&"),
        UInt8(ascii: "|"),
        UInt8(ascii: "^"),
        UInt8(ascii: "~"),
        UInt8(ascii: "."),
        UInt8(ascii: "?"):
        return true
      default:
        return false
      }
    }

    // Unicode math, symbol, arrow, dingbat, and line/box drawing chars.
    let C = self.value
    return (C >= 0x00A1 && C <= 0x00A7)
        || C == 0x00A9 || C == 0x00AB || C == 0x00AC || C == 0x00AE
        || C == 0x00B0 || C == 0x00B1 || C == 0x00B6 || C == 0x00BB
        || C == 0x00BF || C == 0x00D7 || C == 0x00F7
        || C == 0x2016 || C == 0x2017 || (C >= 0x2020 && C <= 0x2027)
        || (C >= 0x2030 && C <= 0x203E) || (C >= 0x2041 && C <= 0x2053)
        || (C >= 0x2055 && C <= 0x205E) || (C >= 0x2190 && C <= 0x23FF)
        || (C >= 0x2500 && C <= 0x2775) || (C >= 0x2794 && C <= 0x2BFF)
        || (C >= 0x2E00 && C <= 0x2E7F) || (C >= 0x3001 && C <= 0x3003)
        || (C >= 0x3008 && C <= 0x3030)
  }

  /// isOperatorContinuationCodePoint - Return true if the specified code point
  /// is a valid operator code point.
  var isOperatorContinuationCodePoint: Bool {
    if self.isOperatorStartCodePoint {
      return true
    }

    // Unicode combining characters and variation selectors.
    let C = self.value
    return (C >= 0x0300 && C <= 0x036F)
        || (C >= 0x1DC0 && C <= 0x1DFF)
        || (C >= 0x20D0 && C <= 0x20FF)
        || (C >= 0xFE00 && C <= 0xFE0F)
        || (C >= 0xFE20 && C <= 0xFE2F)
        || (C >= 0xE0100 && C <= 0xE01EF)
  }
}

extension Unicode.Scalar {
  /// Whether this character represents a printable ASCII character,
  /// for the purposes of pattern parsing.
  public var isPrintableASCII: Bool {
    // Exclude non-printables before the space character U+20, and anything
    // including and above the DEL character U+7F.
    return self.value >= 0x20 && self.value < 0x7F
  }
}

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

      if self[idx] == UInt8(ascii: "#"), self[idx+1] == UInt8(ascii: ">") {
        return true
      }
    }
    return false
  }
}
