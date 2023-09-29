//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_spi(RawSyntax) @_spi(BumpPtrAllocator) import SwiftSyntax

/// A separate lexer specifically for regex literals.
fileprivate struct RegexLiteralLexer {
  enum LexResult {
    /// Continue the lex, this is returned from `lexPatternCharacter` when
    /// it successfully lexed a character.
    case `continue`

    /// The lexing has finished successfully.
    case done

    /// This is not, in fact, a regex.
    case notARegex

    /// We have an unterminated regex.
    case unterminated
  }

  private var cursor: Lexer.Cursor
  private let mustBeRegex: Bool

  /// If this is a multi-line regex literal, the cursor position of the first
  /// newline.
  private var firstNewline: Lexer.Cursor?
  private var isMultiline: Bool { firstNewline != nil }

  /// Tracks the current group '(' depth, used to enforce the heuristic that a
  /// bare slash regex literal with an unbalanced ')' should be treated as an
  /// operator instead.
  private var groupDepth = 0

  /// Tracks the current '[' custom character class depth, used to ensure we
  /// don't count '(' and ')' characters in a custom character class as counting
  /// as group characters.
  private var customCharacterClassDepth = 0

  /// Tracks the last unescaped space or tab character, used to enforce that a
  /// regex literal may not end with a space or tab.
  private var lastUnespacedSpaceOrTab: Lexer.Cursor?

  /// Tracks the position after the last newline, used to enforce that a
  /// closing multi-line delimiter appears alone on a new line.
  private var lastNewlineEnd: Lexer.Cursor?

  /// Tracks a potential closing delimiter candidate, even if the number of
  /// delimiter pounds does not match. Used to recover better in unterminated
  /// cases.
  private var candidateCloseSlashEnd: Lexer.Cursor.Position?

  /// The lexeme builder.
  private var builder: RegexLiteralLexemes.Builder

  init(_ cursor: Lexer.Cursor, mustBeRegex: Bool) {
    self.cursor = cursor
    self.mustBeRegex = mustBeRegex
    self.builder = .init(startingAt: cursor.position)
  }

  /// Attempt to lex a character of the regex pattern.
  private mutating func lexPatternCharacter(escaped: Bool) -> LexResult {
    if cursor.isAtEndOfFile {
      // We've hit the end of the buffer. In multi-line mode, we don't want to
      // skip over what is likely otherwise valid Swift code, so resume from the
      // first newline.
      if let firstNewline = firstNewline {
        cursor = firstNewline
      }
      return .unterminated
    }
    let charCursor = cursor
    guard let char = cursor.advanceValidatingUTF8Character() else {
      builder.recordPatternError(.invalidUtf8, at: cursor)
      return .continue
    }
    switch char {
    case "\n", "\r":
      guard isMultiline else {
        // Bump back the cursor to the newline to ensure it doesn't
        // become part of the pattern token.
        cursor = charCursor
        return .unterminated
      }
      lastNewlineEnd = cursor
      break

    case "\\" where !escaped:
      // Advance again for an escape sequence.
      return lexPatternCharacter(escaped: true)

    case "(" where !escaped && customCharacterClassDepth == 0:
      groupDepth += 1

    case ")" where !escaped && customCharacterClassDepth == 0:
      guard groupDepth > 0 else {
        // If we have an unbalanced ')', and this may not be a regex, don't
        // lex as a regex.
        if !mustBeRegex {
          return .notARegex
        }
        break
      }
      groupDepth -= 1

    case "[" where !escaped:
      customCharacterClassDepth += 1

    case "]" where !escaped:
      if customCharacterClassDepth > 0 {
        customCharacterClassDepth -= 1
      }

    case "\0":
      builder.recordPatternError(.nulCharacter, at: charCursor)
      break

    case let char
    where char.isASCII && !char.isPrintableASCII && !(isMultiline && char == "\t"):
      // Diagnose unprintable ASCII.
      // Note that tabs are allowed in multi-line literals.
      // TODO: This matches the string literal behavior, but should we allow
      // tabs for single-line regex literals too?
      builder.recordPatternError(.unprintableAsciiCharacter, at: charCursor)
      break

    case " ", "\t":
      if !escaped {
        lastUnespacedSpaceOrTab = charCursor
      }
      break

    default:
      break
    }
    return .continue
  }

  /// Attempt to eat the closing delimiter.
  private mutating func tryEatEnding() -> LexResult? {
    let openPoundCount = builder.numOpenPounds
    let slashBegin = cursor
    var newCursor = cursor

    guard newCursor.advance(matching: "/") else { return nil }
    let slashEnd = newCursor
    candidateCloseSlashEnd = slashEnd.position

    // Try to eat closing pounds. Note we don't do this if we don't have any
    // opening pounds (for recovery), as the builder currently bases the maximum
    // token count off the presence of opening pounds, and it's not clear if
    // recovery in that case is useful anyway.
    var closePoundCount = 0
    if openPoundCount > 0 {
      while newCursor.advance(matching: "#") {
        closePoundCount += 1
      }
    }

    // Make sure we have sufficient closing pounds. Note we can consume extra
    // for better recovery.
    guard closePoundCount >= openPoundCount else { return nil }

    // If we have a multi-line literal, make sure the closing delimiter
    // appears alone on a newline.
    if let lastNewlineEnd {
      var delimScan = lastNewlineEnd
      while delimScan.pointer < slashBegin.pointer {
        if !delimScan.advance(matching: " ", "\t") {
          builder.recordPatternError(.multilineRegexClosingNotOnNewline, at: slashBegin)
          break
        }
      }
    }

    if closePoundCount == 0 {
      if let end = newCursor.peek() {
        // If we're lexing `/.../`, treat it as unterminated if we ended on the
        // opening of a comment. We prefer to lex the comment as it's more likely
        // than not that is what the user is expecting.
        switch UnicodeScalar(end) {
        case "*", "/":
          return .unterminated
        default:
          break
        }
      }

      // We also ban unespaced space and tab at the end of a regex literal if
      // this might not be a regex.
      if let lastUnespacedSpaceOrTab = lastUnespacedSpaceOrTab,
        lastUnespacedSpaceOrTab.position.advanced(by: 1).pointer == slashBegin.position.pointer
      {
        if mustBeRegex {
          // TODO: We ought to have a fix-it that suggests #/.../#. We could
          // suggest escaping, but that would be wrong if the user has written (?x).
          // TODO: Should we suggest #/.../# for space-as-first character too?
          builder.recordPatternError(.spaceAtEndOfRegexLiteral, at: lastUnespacedSpaceOrTab)
        } else {
          return .notARegex
        }
      }
    }

    builder.recordCloseSlash(endingAt: slashEnd.position)
    if closePoundCount > 0 {
      builder.recordClosePounds(count: closePoundCount)
    }
    cursor = newCursor
    return .done
  }

  private mutating func lexImpl() -> LexResult {
    // We can consume any number of pound signs.
    var poundCount = 0
    while cursor.advance(matching: "#") {
      poundCount += 1
    }
    if poundCount > 0 {
      builder.recordOpenPounds(count: poundCount)
    }

    // Try to lex the opening delimiter.
    let openSlash = cursor
    guard cursor.advance(matching: "/") else {
      return .notARegex
    }
    builder.recordOpenSlash()

    if !builder.hasPounds {
      if let next = cursor.peek() {
        switch UnicodeScalar(next) {
        case " ", "\t":
          // For `/.../` regex literals, we need to ban space and tab at the start
          // of a regex to avoid ambiguity with operator chains, e.g:
          //
          // Builder {
          //   0
          //   / 1 /
          //   2
          // }
          //
          if mustBeRegex {
            // TODO: We ought to have a fix-it that inserts a backslash to escape.
            builder.recordPatternError(.spaceAtStartOfRegexLiteral, at: cursor)
          } else {
            return .notARegex
          }
        case "*", "/":
          // Start of a comment, not a regex.
          return .notARegex
        default:
          break
        }
      }
      if openSlash.previous == UInt8(ascii: "*") {
        // End of block comment, not a regex.
        return .notARegex
      }
    }

    // If the delimiter allows multi-line, try skipping over any whitespace to a
    // newline character. If we can do that, we enter multi-line mode.
    if builder.hasPounds {
      var newlineScan = cursor
      while let next = newlineScan.peek() {
        switch UnicodeScalar(next) {
        case " ", "\t":
          _ = newlineScan.advance()
          continue
        case "\n", "\r":
          firstNewline = newlineScan
          cursor = newlineScan
        default:
          break
        }
        break
      }
    }

    while true {
      if let result = tryEatEnding() {
        return result
      }
      switch lexPatternCharacter(escaped: false) {
      case .continue:
        continue
      case let result:
        return result
      }
    }
  }

  mutating func lex() -> RegexLiteralLexemes? {
    switch lexImpl() {
    case .continue:
      preconditionFailure("Not a valid result")
    case .notARegex:
      return nil
    case .unterminated where !mustBeRegex:
      // If this may not be a regex, bail.
      return nil
    case .done, .unterminated:
      // In both cases we can just return the lexemes. We'll diagnose when
      // parsing.
      return builder.finish(
        at: cursor.position,
        candidateCloseSlashEnd: candidateCloseSlashEnd
      )
    }
  }
}

struct RegexLiteralLexemes {
  private let builder: Builder

  fileprivate init(from builder: Builder) {
    self.builder = builder
  }

  struct Element {
    var kind: Kind
    var end: Lexer.Cursor.Position
    var error: Lexer.Cursor.LexingDiagnostic?
  }
}

extension RegexLiteralLexemes {
  /// Allocate the lexemes on a given bump pointer allocator.
  func allocate(in allocator: BumpPtrAllocator) -> UnsafePointer<RegexLiteralLexemes> {
    let ptr = allocator.allocate(Self.self, count: 1).baseAddress!
    ptr.initialize(to: self)
    return UnsafePointer(ptr)
  }
}

extension RegexLiteralLexemes.Element {
  /// The regex literal token kind, the raw value of which indicates its index.
  enum Kind: UInt8 {
    case openingPounds
    case openingSlash
    case pattern
    case closingSlash
    case closingPounds
  }

  /// Retrieve the actual token kind.
  var tokenKind: RawTokenKind {
    switch kind {
    case .openingPounds, .closingPounds:
      return .regexPoundDelimiter
    case .openingSlash, .closingSlash:
      return .regexSlash
    case .pattern:
      return .regexLiteralPattern
    }
  }
}

extension RegexLiteralLexemes.Element.Kind {
  /// Construct the regex literal token kind from a given index, taking pounds
  /// into account.
  fileprivate init(at index: UInt8, hasPounds: Bool) {
    if hasPounds {
      // If we have pounds, we have 5 tokens maximum.
      precondition(index < 5)
      self.init(rawValue: index)!
    } else {
      // Otherwise, we have 3 tokens maximum, and start at the slash.
      precondition(index < 3)
      self.init(rawValue: index + 1)!
    }
  }
}

extension RegexLiteralLexemes {
  /// A builder type for the regex literal lexer.
  ///
  /// NOTE: This is stored for the regex literal lexer state, so should be kept
  /// as small as possible. Additionally, it is allocated using a bump pointer
  /// allocator, so must remain a POD type (i.e no classes).
  fileprivate struct Builder {
    private(set) var numOpenPounds: Int = 0
    private(set) var patternByteLength: Int = 0
    private(set) var numClosePounds: Int = 0

    // The start position is split into its component input buffer and
    // previous char to allow for a more optimized layout.
    private let _startInput: UnsafeBufferPointer<UInt8>

    // The pattern diagnostic is split for a more optimized layout.
    private var _patternErrorOffset: Int?
    private var _patternErrorKind: TokenDiagnostic.Kind?

    private let _startPrevious: UInt8

    /// The number of lexemes. This is a UInt8 as there can only be a maximum
    /// of 5 lexemes for a regex literal (open pounds, open slash, pattern,
    /// closing slash, closing pounds).
    private(set) var lexemeCount: UInt8 = 0

    init(startingAt start: Lexer.Cursor.Position) {
      self._startInput = start.input
      self._startPrevious = start.previous
    }
    var start: Lexer.Cursor.Position {
      .init(input: _startInput, previous: _startPrevious)
    }

    private(set) var patternError: Lexer.Cursor.LexingDiagnostic? {
      get {
        guard let _patternErrorKind = _patternErrorKind else { return nil }
        let pos = start.advanced(by: _patternErrorOffset!)
        return .init(_patternErrorKind, position: pos)
      }
      set {
        guard let newValue = newValue else {
          _patternErrorKind = nil
          _patternErrorOffset = nil
          return
        }
        _patternErrorKind = newValue.kind
        _patternErrorOffset = start.distance(to: newValue.position)
      }
    }

    var hasPounds: Bool { numOpenPounds > 0 }
  }
}

extension RegexLiteralLexemes.Builder {
  typealias Element = RegexLiteralLexemes.Element

  /// The lexeme kind for the last lexed token, or `nil` if no token has been
  /// lexed yet.
  var lastLexemeKind: Element.Kind? {
    if lexemeCount == 0 { return nil }
    return .init(at: lexemeCount - 1, hasPounds: hasPounds)
  }

  /// The end byte offset for a given regex token kind.
  func endByteOffset(for kind: Element.Kind) -> Int {
    switch kind {
    case .openingPounds:
      return numOpenPounds
    case .openingSlash:
      return numOpenPounds + 1
    case .pattern:
      return numOpenPounds + 1 + patternByteLength
    case .closingSlash:
      return numOpenPounds + 1 + patternByteLength + 1
    case .closingPounds:
      return numOpenPounds + 1 + patternByteLength + 1 + numClosePounds
    }
  }

  /// Retrieve the end cursor position for a given regex token kind.
  func endCursorPosition(for kind: Element.Kind) -> Lexer.Cursor.Position {
    start.advanced(by: endByteOffset(for: kind))
  }

  mutating func recordOpenPounds(count: Int) {
    precondition(lastLexemeKind == nil)
    numOpenPounds = count
    lexemeCount += 1
  }

  mutating func recordOpenSlash() {
    precondition(lastLexemeKind == nil || lastLexemeKind == .openingPounds)
    lexemeCount += 1
  }

  private mutating func recordRegexPattern(byteLength: Int) {
    precondition(lastLexemeKind == .openingSlash)
    patternByteLength = byteLength
    lexemeCount += 1
  }

  mutating func recordCloseSlash(endingAt closeSlashEnd: Lexer.Cursor.Position) {
    precondition(lastLexemeKind == .openingSlash)

    // We use the close slash to compute the pattern length.
    let patternStart = endCursorPosition(for: .openingSlash)
    recordRegexPattern(byteLength: patternStart.distance(to: closeSlashEnd) - 1)
    lexemeCount += 1
  }

  mutating func recordClosePounds(count: Int) {
    precondition(lastLexemeKind == .closingSlash)
    numClosePounds = count
    lexemeCount += 1
  }

  mutating func recordPatternError(
    _ kind: TokenDiagnostic.Kind,
    at cursor: Lexer.Cursor
  ) {
    precondition(lastLexemeKind == .openingSlash)

    // Only record if we don't already have a pattern error, we want to prefer
    // the first error we encounter.
    if patternError == nil {
      patternError = .init(kind, position: cursor)
    }
  }

  /// Finish regex literal lexing.
  mutating func finish(
    at end: Lexer.Cursor.Position,
    candidateCloseSlashEnd: Lexer.Cursor.Position?
  ) -> RegexLiteralLexemes {
    // If we ended up in the middle of a pattern, we have an unterminated
    // literal. Make sure to record the pattern, and do some recovery for
    // better diagnostics.
    if lastLexemeKind == .openingSlash {
      let patternStart = endCursorPosition(for: .openingSlash)
      let byteLength = patternStart.distance(to: end)

      // If have an extended literal, we can do some recovery for unterminated
      // cases by seeing if we have something that looks like the ending
      // delimiter at the end of the pattern, and treating it as such. The
      // parser will diagnose if it doesn't end up matching.
      func inferClosingDelimiter() -> (slashEnd: Lexer.Cursor.Position, numPounds: Int)? {
        guard hasPounds && byteLength > 0 else { return nil }

        // If the last characeter is '/', we can use that.
        if UnicodeScalar(end.previous) == "/" {
          return (end, numPounds: 0)
        }
        // If the last character is '#', scan from the candidate last slash to
        // see if we only have '#' characters until the end. In such a case,
        // we can claim those characters as part of the delimiter.
        if UnicodeScalar(end.previous) == "#",
          let candidateCloseSlashEnd = candidateCloseSlashEnd
        {
          var poundScan = candidateCloseSlashEnd
          var numClosingPounds = 0
          while poundScan.pointer < end.pointer,
            UnicodeScalar(poundScan.advance()!) == "#"
          {
            numClosingPounds += 1
          }
          precondition(numClosingPounds < numOpenPounds, "Should have lexed this?")

          // Should be at the end now, otherwise this is something bogus in
          // the middle of the pattern.
          if poundScan.pointer == end.pointer {
            return (candidateCloseSlashEnd, numClosingPounds)
          }
        }
        return nil
      }
      if let (closeSlashEnd, numClosingPounds) = inferClosingDelimiter() {
        recordCloseSlash(endingAt: closeSlashEnd)
        if numClosingPounds > 0 {
          recordClosePounds(count: numClosingPounds)
        }
      } else {
        recordRegexPattern(byteLength: byteLength)
      }
    }
    return .init(from: self)
  }
}

extension RegexLiteralLexemes: RandomAccessCollection {
  typealias Index = UInt8

  var startIndex: UInt8 { 0 }
  var endIndex: UInt8 { builder.lexemeCount }

  /// Retrieve the token at the given index.
  subscript(index: UInt8) -> Element {
    let kind = Element.Kind(at: index, hasPounds: builder.hasPounds)
    return .init(
      kind: kind,
      end: builder.endCursorPosition(for: kind),
      error: kind == .pattern ? builder.patternError : nil
    )
  }
}

extension Lexer.Cursor {
  /// A heuristic that determines whether the cursor is currently in a regex
  /// literal position by looking at the previous token to determine if we're
  /// expecting an expression, or a binary operator.
  fileprivate func isInRegexLiteralPosition() -> Bool {
    switch previousTokenKind {
    // Can lex a regex literal at the start of the buffer.
    case nil:
      return true

    // Cannot lex at the end of the buffer.
    case .endOfFile:
      return false

    // Prefix grammar that appears before an expression.
    case .leftAngle, .leftBrace, .leftParen, .leftSquare, .prefixOperator, .prefixAmpersand:
      return true

    // Binary operators sequence expressions.
    case .binaryOperator, .equal:
      return true

    // Infix punctuation that generally separates expressions.
    case .semicolon, .comma, .colon, .infixQuestionMark:
      return true

    // Postfix grammar would expect a binary operator next.
    case .postfixOperator, .exclamationMark, .postfixQuestionMark, .rightAngle, .rightBrace, .rightParen, .rightSquare:
      return false

    // Punctuation that does not sequence expressions.
    case .arrow, .ellipsis, .period, .atSign, .pound, .backtick, .backslash:
      return false

    // Shebang does not sequence expressions.
    case .shebang:
      return false

    case .keyword:
      // There are a handful of keywords that are expressions, handle them.
      // Otherwise, a regex literal can generally be parsed after a keyword.
      switch previousKeyword! {
      case .true, .false, .Any, .nil, .`self`, .`Self`, .super:
        return false
      default:
        return true
      }

    // Identifiers do not sequence expressions.
    case .identifier, .dollarIdentifier, .wildcard:
      return false

    // Literals are themselves expressions and therefore don't sequence expressions.
    case .floatLiteral, .integerLiteral:
      return false

    // Pound keywords that do not generally sequence expressions.
    case .poundAvailable, .poundSourceLocation, .poundUnavailable:
      return false

    // Pound keywords that generally do sequence expressions.
    case .poundIf, .poundElse, .poundElseif, .poundEndif:
      return true

    // Bits of string/regex grammar, we can't start lexing a regex literal here.
    case .regexPoundDelimiter, .regexSlash, .regexLiteralPattern, .rawStringPoundDelimiter, .stringQuote, .stringSegment, .multilineStringQuote, .singleQuote:
      return false

    // Allow unknown for better recovery.
    case .unknown:
      return true
    }
  }
}

extension Lexer.Cursor {
  /// Scan for a regex literal, without advancing the cursor. Returns the regex
  /// literal tokens scanned, or `nil` if there is no regex literal.
  fileprivate func scanRegexLiteral(mustBeRegex: Bool) -> RegexLiteralLexemes? {
    var lexer = RegexLiteralLexer(self, mustBeRegex: mustBeRegex)
    return lexer.lex()
  }

  /// Attempt to scan for a regex literal starting from within an operator we've
  /// lexed.
  fileprivate func tryScanOperatorAsRegexLiteral(
    operatorStart: Lexer.Cursor,
    operatorEnd: Lexer.Cursor,
    sourceBufferStart: Lexer.Cursor,
    preferRegexOverBinaryOperator: Bool
  ) -> RegexLiteralLexemes? {
    precondition(self.pointer >= operatorStart.pointer, "lexing before the operator?")

    let isLeftBound = operatorStart.isLeftBound(sourceBufferStart: sourceBufferStart)
    let isRightBound = operatorEnd.isRightBound(isLeftBound: isLeftBound)

    // Must not be left bound, we should lex a postfix '/' instead.
    guard !isLeftBound else { return nil }

    // If the previous token was 'func' or 'operator', the next token must
    // be an operator, not a regex. This is needed to correctly handle cases
    // like:
    //
    // operator /^/
    // postfix func /(lhs: Int) { 5/ }
    //
    // Re-lexing isn't a viable strategy as there could be unbalanced curly
    // braces in the regex, which interferes with the lexical structure (e.g
    // anything relying on the lexed tokens to correctly balance curly braces).
    switch self.previousKeyword {
    case .func, .operator:
      return nil
    default:
      break
    }

    // Handle cases where the '/' is part of what looks like a binary operator.
    var mustBeRegex = false
    if isLeftBound == isRightBound {
      // The `preferRegexOverBinaryOperator` flag is set if we previously had a
      // 'try?' or 'try!'. In that case, the previous token is a postfix
      // operator, which would usually indicate that we're not in regex literal
      // position (as we would typically expect a binary operator to follow a
      // postfix operator, not an expression). However 'try' is special because
      // it cannot appear on the LHS of a binary operator, so we know we must
      // have a regex.
      //
      // This is needed to handle cases like `try? /^ x/`, which should be lexed
      // as a regex. This can occur for cases like `try? /^ x/.wholeMatch(...)`.
      if preferRegexOverBinaryOperator {
        mustBeRegex = true
      }
      // If we are not in a regex literal position, and are not certain, then
      // prefer lexing as a binary operator instead.
      if !mustBeRegex && !operatorStart.isInRegexLiteralPosition() {
        return nil
      }
      // For better recovery, we can confidently lex a regex literal if we're in
      // regex literal position, and the '/' is part of what looks like a binary
      // operator. This would otherwise be illegal code, as binary operators
      // cannot appear in expression position. The only exception to this is if
      // the previous token indicates we're in an argument list, in which case
      // an unapplied operator is legal, and we should prefer to lex as that
      // instead.
      switch previousTokenKind {
      case .leftParen, .leftSquare, .comma, .colon:
        break
      default:
        mustBeRegex = true
      }
    }
    return scanRegexLiteral(mustBeRegex: mustBeRegex)
  }
}

extension Lexer.Cursor {
  /// Attempt to lex a regex literal. Note this lexes confidently, without
  /// applying various heuristics to avoid lexing a regex literal in ambiguous
  /// cases.
  mutating func lexRegexLiteral() -> Lexer.Result? {
    guard let lexemes = scanRegexLiteral(mustBeRegex: true) else { return nil }
    return lexInRegexLiteral(lexemes[...], existingPtr: nil)
  }

  /// Attempt to lex an operator as a regex literal, returning the result,
  /// or `nil` if a regex literal could not be lexed.
  mutating func tryLexOperatorAsRegexLiteral(
    at regexStart: Lexer.Cursor,
    operatorStart: Lexer.Cursor,
    operatorEnd: Lexer.Cursor,
    sourceBufferStart: Lexer.Cursor,
    preferRegexOverBinaryOperator: Bool
  ) -> Lexer.Result? {
    guard
      let lexemes = regexStart.tryScanOperatorAsRegexLiteral(
        operatorStart: operatorStart,
        operatorEnd: operatorEnd,
        sourceBufferStart: sourceBufferStart,
        preferRegexOverBinaryOperator: preferRegexOverBinaryOperator
      )
    else { return nil }

    if regexStart.pointer > operatorStart.pointer {
      // If we started lexing in the middle of an operator, split off the prefix
      // operator, and move the cursor to where the regex literal starts.
      self.position = regexStart.position
      let (kind, error) = Self.classifyOperatorToken(
        operStart: operatorStart,
        operEnd: regexStart,
        sourceBufferStart: sourceBufferStart
      )
      return Lexer.Result(
        kind,
        error: error,
        stateTransition: .pushRegexLexemes(index: 0, lexemes: lexemes)
      )
    } else {
      // Otherwise we just have a regex literal. We can call into
      // `lexInRegexLiteral` to pop the first token and push the state.
      return lexInRegexLiteral(lexemes[...], existingPtr: nil)
    }
  }

  /// Lex an already-lexed regex literal. If `existingPtr` is non-nil, this is
  /// for an existing regex literal state on the lexer state stack.
  mutating func lexInRegexLiteral(
    _ lexemes: Slice<RegexLiteralLexemes>,
    existingPtr: UnsafePointer<RegexLiteralLexemes>?
  ) -> Lexer.Result {
    // Given we have already lexed the regex literal, this is as simple as
    // popping off the next token and moving the lexer up to its end position.
    var lexemes = lexemes
    let lexeme = lexemes.removeFirst()

    self.position = lexeme.end

    // The new index is now given by the slice start index (as we've removed
    // the first element).
    let index = lexemes.startIndex

    // Compute the new transition.
    let transition: Lexer.StateTransition?
    if let existingPtr {
      transition = lexemes.isEmpty ? .pop : .replace(newState: .inRegexLiteral(index: index, lexemes: existingPtr))
    } else {
      transition = lexemes.isEmpty ? nil : .pushRegexLexemes(index: index, lexemes: lexemes.base)
    }
    return .init(lexeme.tokenKind, error: lexeme.error, stateTransition: transition)
  }
}
