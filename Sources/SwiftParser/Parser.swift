//===----------------------------------------------------------------------===//
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

/// A parser for the Swift programming language.
///
/// `Parser` implements a recursive descent parser that produces a SwiftSyntax
/// tree. Its implementation is divided among a set of files named for the
/// class of syntax nodes they parse. For example, declaration parsing happens
/// in `Declaration.swift`, and expression parsing happens in `Expression.swift`.
///
/// Parsing Swift
/// =============
///
/// Broadly, the parser has a one-to-one correspondence between syntax nodes
/// and parsing functions. If a function consumes input from the token stream,
/// it must be marked `mutating` to do so. Thus, parsing functions that only
/// serve e.g. to read the current token and disambiguate the parse, or recover
/// from a bad parse should be left `nonmutating` to indicate that they do not
/// consume tokens.
///
/// Token consumption is generally conditional via ``TokenConsumer/consume(if:)``
/// or unconditional via `consumeAnyToken()`. During parsing, it is
/// also useful to assert that the current token matches some expected structure
/// via ``TokenConsumer/eat(_:)``, which acts like ``TokenConsumer/consume(if:)``,
/// but asserts if the parsed token did not match the expected kind.
///
/// It can also be useful to expect the presence of certain structural elements.
/// For example, a function that parses the content of code items might expect
/// an opening brace, its items, and also expect a closing brace:
///
///     let lbrace = self.eat(.leftBrace)
///     /*  */
///     let rbrace = self.expect(.rightBrace)
///
/// Unlike ``TokenConsumer/eat(_:)``, `expect(_:)` returns
/// a `missing` token of the given kind. This allows the tree to remain
/// well-formed even when the input text is not, all without affecting
/// source fidelity.
///
/// For compound syntactic structures, parsing loops are often required. The general
/// structure of a source-preserving loop is
///
///     var keepGoing: RawTokenSyntax? = nil
///     repeat {
///       // Parse an element
///       let element = self.parseElement()
///
///       // Consume the delimeter
///       keepGoing = self.consume(if: .delimiter)
///       elements.append(RawElementSyntax(element, ..., keepGoing))
///     } while keepGoing != nil
///
/// Such parsing loops are kept enclosed in `do` blocks to avoid having their
/// state leak into surrounding scopes.
///
/// Lookahead
/// =========
///
/// This parser provides at most one token worth of lookahead via
/// `peek()`. If more tokens are required to disambiguate a parse, a
/// ``Parser/Lookahead`` instance should be constructed instead with
/// ``Parser/lookahead()``.
///
/// Source Fidelity
/// ===============
///
/// The syntax trees produced by this parser are required to faithfully
/// represent the input source text. As such, there are no utilities that allow
/// for skipping tokens in the parser. In addition, consumed tokens must become
/// part of at  least one syntax node.
///
/// The exception to this is parser lookahead, which is allowed to skip as many
/// tokens as needed to disambiguate a parse. However, because lookahead
/// operates on a copy of the lexical stream, no input tokens are lost..
public struct Parser {
  @_spi(RawSyntax)
  public var arena: ParsingSyntaxArena
  /// A view of the sequence of lexemes in the input.
  var lexemes: Lexer.LexemeSequence
  /// The current token. If there was no input, this token will have a kind of `.eof`.
  @_spi(RawSyntax)
  public var currentToken: Lexer.Lexeme

  /// The current nesting level, i.e. the number of tokens that
  /// `startNestingLevel` minus the number of tokens that `endNestingLevel`
  /// which have been consumed so far.
  public var nestingLevel: Int = 0

  /// When this nesting level is exceeded, the parser should stop parsing.
  public let maximumNestingLevel: Int

  /// A default maximum nesting level that is used if the client didn't
  /// explicitly specify one. Debug builds of the parser comume a lot more stack
  /// space and thus have a lower default maximum nesting level.
  #if DEBUG
  public static let defaultMaximumNestingLevel = 25
  #else
  public static let defaultMaximumNestingLevel = 256
  #endif

  /// Initializes a `Parser` from the given string.
  public init(_ input: String, maximumNestingLevel: Int? = nil) {
    self.maximumNestingLevel = maximumNestingLevel ?? Self.defaultMaximumNestingLevel

    self.arena = ParsingSyntaxArena(
      parseTriviaFunction: TriviaParser.parseTrivia(_:position:)
    )

    var input = input
    input.makeContiguousUTF8()
    let interned = input.withUTF8 { [arena] buffer in
      return arena.internSourceBuffer(buffer)
    }

    self.lexemes = Lexer.tokenize(interned)
    self.currentToken = self.lexemes.advance()
  }

  /// Initializes a `Parser` from the given input buffer.
  ///
  /// - Parameters
  ///   - input: An input buffer containing Swift source text.
  ///   - maximumNestingLevel: To avoid overflowing the stack, the parser will
  ///                          stop if a nesting level greater than this value
  ///                          is reached. The nesting level is increased
  ///                          whenever a bracketed expression like `(` or `{`
  ///                          is started. `defaultMaximumNestingLevel` is used
  ///                          if this is `nil`.
  ///   - arena: Arena the parsing syntax are made into. If it's `nil`, a new
  ///            arena is created automatically, and `input` copied into the
  ///            arena. If non-`nil`, `input` must be within its registered
  ///            source buffer or allocator.
  public init(_ input: UnsafeBufferPointer<UInt8>, maximumNestingLevel: Int? = nil, arena: ParsingSyntaxArena? = nil) {
    self.maximumNestingLevel = maximumNestingLevel ?? Self.defaultMaximumNestingLevel

    var sourceBuffer: UnsafeBufferPointer<UInt8>
    if let arena = arena {
      self.arena = arena
      sourceBuffer = input
      assert(arena.contains(text: SyntaxText(baseAddress: input.baseAddress, count: input.count)))
    } else {
      self.arena = ParsingSyntaxArena(
        parseTriviaFunction: TriviaParser.parseTrivia(_:position:)
      )
      sourceBuffer = self.arena.internSourceBuffer(input)
    }

    self.lexemes = Lexer.tokenize(sourceBuffer)
    self.currentToken = self.lexemes.advance()
  }

  @_spi(RawSyntax)
  public mutating func missingToken(_ kind: RawTokenKind, text: SyntaxText? = nil) -> RawTokenSyntax {
    adjustNestingLevel(for: kind)
    return RawTokenSyntax(missing: kind, text: text, arena: self.arena)
  }

  /// Consumes the current token and advances the lexer to the next token.
  ///
  /// - Returns: The token that was consumed.
  @_spi(RawSyntax)
  public mutating func consumeAnyToken() -> RawTokenSyntax {
    adjustNestingLevel(for: self.currentToken.tokenKind)
    return self.consumeAnyTokenWithoutAdjustingNestingLevel()
  }

  @_spi(RawSyntax)
  public mutating func consumeAnyTokenWithoutAdjustingNestingLevel() -> RawTokenSyntax {
    let tok = self.currentToken
    self.currentToken = self.lexemes.advance()
    return RawTokenSyntax(
      kind: tok.tokenKind,
      wholeText: tok.wholeText,
      textRange: tok.textRange,
      presence: .present,
      hasLexerError: tok.flags.contains(.isErroneous),
      arena: arena
    )
  }

  private mutating func adjustNestingLevel(for tokenKind: RawTokenKind) {
    switch tokenKind {
    case .leftAngle, .leftBrace, .leftParen, .leftSquareBracket, .poundIfKeyword:
      nestingLevel += 1
    case .rightAngle, .rightBrace, .rightParen, .rightSquareBracket, .poundEndifKeyword:
      nestingLevel -= 1
    default:
      break
    }
  }
}

// MARK: Inspecting Tokens

extension Parser {
  /// Retrieves the token following the current token without consuming it.
  @_spi(RawSyntax)
  public func peek() -> Lexer.Lexeme {
    return self.lexemes.peek()
  }
}

// MARK: Consuming Tokens

@_spi(RawSyntax)
extension Parser: TokenConsumer {}

extension Parser {
  /// Consumes the current token and sets its kind to the given `TokenKind`,
  /// then advances the lexer to the next token.
  ///
  /// - Parameter kind: The kind to reset the consumed token to.
  /// - Returns: The token that was consumed with its kind re-mapped to the
  ///            given `TokenKind`.
  @_spi(RawSyntax)
  public mutating func consumeAnyToken(remapping kind: RawTokenKind) -> RawTokenSyntax {
    self.currentToken.tokenKind = kind
    return self.consumeAnyToken()
  }

}

// MARK: Check if we can recover to a token

extension Parser {
  /// Checks if it can reach a token of the given `kind` by skipping unexpected
  /// tokens that have lower ``TokenPrecedence`` than expected token.
  @_spi(RawSyntax)
  public func canRecoverTo(_ kind: RawTokenKind) -> RecoveryConsumptionHandle? {
    if self.at(kind) {
      return RecoveryConsumptionHandle(
        unexpectedTokens: 0,
        tokenConsumptionHandle: TokenConsumptionHandle(tokenKind: kind)
      )
    }
    var lookahead = self.lookahead()
    return lookahead.canRecoverTo([kind])
  }

  /// Checks if it can reach a contextual keyword with the given `name` by
  /// skipping unexpected tokens that have lower ``TokenPrecedence`` than
  /// `precedence`.
  @_spi(RawSyntax)
  public func canRecoverToContextualKeyword(
    _ name: SyntaxText,
    precedence: TokenPrecedence = TokenPrecedence(.contextualKeyword)
  ) -> RecoveryConsumptionHandle? {
    if self.atContextualKeyword(name) {
      return RecoveryConsumptionHandle(
        unexpectedTokens: 0,
        tokenConsumptionHandle: TokenConsumptionHandle(
          tokenKind: self.currentToken.tokenKind,
          remappedKind: .contextualKeyword
        )
      )
    }
    var lookahead = self.lookahead()
    return lookahead.canRecoverTo(
      [],
      contextualKeywords: [name],
      recoveryPrecedence: precedence
    )
  }

  /// Checks if it can reach a token whose kind is in `kinds` by skipping
  /// unexpected tokens that have lower ``TokenPrecedence`` than `precedence`.
  @_spi(RawSyntax)
  public func canRecoverTo(
    any kinds: [RawTokenKind]
  ) -> RecoveryConsumptionHandle? {
    if self.at(any: kinds) {
      return RecoveryConsumptionHandle(
        unexpectedTokens: 0,
        tokenConsumptionHandle: TokenConsumptionHandle(tokenKind: self.currentToken.tokenKind)
      )
    }
    var lookahead = self.lookahead()
    return lookahead.canRecoverTo(kinds)
  }

  /// Checks if we can reach a token in `subset` by skipping tokens that have
  /// a precedence that have a lower ``TokenPrecedence`` than the minimum
  /// precedence of a token in that subset.
  /// If so, return the token that we can recover to and a handle that can be
  /// used to consume the unexpected tokens and the token we recovered to.
  func canRecoverTo<Subset: RawTokenKindSubset>(
    anyIn subset: Subset.Type,
    recoveryPrecedence: TokenPrecedence? = nil
  ) -> (Subset, RecoveryConsumptionHandle)? {
    if let (kind, handle) = self.at(anyIn: subset) {
      return (kind, RecoveryConsumptionHandle(unexpectedTokens: 0, tokenConsumptionHandle: handle))
    }
    var lookahead = self.lookahead()
    return lookahead.canRecoverTo(anyIn: subset, recoveryPrecedence: recoveryPrecedence)
  }

  /// Eat a token that we know we are currently positioned at, based on `canRecoverTo(anyIn:)`.
  mutating func eat(_ handle: RecoveryConsumptionHandle) -> (RawUnexpectedNodesSyntax?, Token) {
    let unexpectedNodes: RawUnexpectedNodesSyntax?
    if handle.unexpectedTokens > 0 {
      var unexpectedTokens = [RawSyntax]()
      for _ in 0..<handle.unexpectedTokens {
        unexpectedTokens.append(RawSyntax(self.consumeAnyTokenWithoutAdjustingNestingLevel()))
      }
      unexpectedNodes = RawUnexpectedNodesSyntax(elements: unexpectedTokens, arena: self.arena)
    } else {
      unexpectedNodes = nil
    }
    let token = self.eat(handle.tokenConsumptionHandle)
    return (unexpectedNodes, token)
  }
}

// MARK: Expecting Tokens with Recovery

extension Parser {
  /// Implements the paradigm shared across all `expect` methods.
  private mutating func expectImpl(
    consume: (inout Parser) -> RawTokenSyntax?,
    canRecoverTo: (inout Lookahead) -> RecoveryConsumptionHandle?,
    makeMissing: (inout Parser) -> RawTokenSyntax
  ) -> (unexpected: RawUnexpectedNodesSyntax?, token: RawTokenSyntax) {
    if let tok = consume(&self) {
      return (nil, tok)
    }
    var lookahead = self.lookahead()
    if let handle = canRecoverTo(&lookahead) {
      let (unexpectedTokens, token) = self.eat(handle)
      return (unexpectedTokens, token)
    }
    return (nil, makeMissing(&self))
  }

  /// Attempts to consume a token of the given kind.
  /// If it cannot be found, the parser tries
  ///  1. To eat unexpected tokens that have lower ``TokenPrecedence`` than the
  ///     expected token and see if the token occurs after that unexpected.
  ///  2. If the token couldn't be found after skipping unexpected, it synthesizes
  ///     a missing token of the requested kind.
  @_spi(RawSyntax)
  public mutating func expect(
    _ kind: RawTokenKind,
    remapping: RawTokenKind? = nil
  ) -> (unexpected: RawUnexpectedNodesSyntax?, token: RawTokenSyntax) {
    return expectImpl(
      consume: { $0.consume(if: kind, remapping: remapping) },
      canRecoverTo: { $0.canRecoverTo([kind]) },
      makeMissing: {
        if let remapping = remapping {
          return $0.missingToken(remapping, text: kind.defaultText)
        } else {
          return $0.missingToken(kind)
        }
      }
    )
  }

  /// Attempts to consume a contextual keyword whose text is `name`.
  /// If it cannot be found, the parser tries
  ///  1. To eat unexpected tokens that have lower ``TokenPrecedence`` than `precedence`.
  ///  2. If the token couldn't be found after skipping unexpected, it synthesizes
  ///     a missing token of the requested kind.
  @_spi(RawSyntax)
  public mutating func expectContextualKeyword(
    _ name: SyntaxText,
    precedence: TokenPrecedence = TokenPrecedence(.contextualKeyword)
  ) -> (unexpected: RawUnexpectedNodesSyntax?, token: RawTokenSyntax) {
    return expectImpl(
      consume: { $0.consumeIfContextualKeyword(name) },
      canRecoverTo: { $0.canRecoverTo([], contextualKeywords: [name], recoveryPrecedence: precedence) },
      makeMissing: { $0.missingToken(.contextualKeyword, text: name) }
    )
  }

  /// Attempts to consume a token whose kind is in `kinds`.
  /// If it cannot be found, the parser tries
  ///  1. To eat unexpected tokens that have lower ``TokenPrecedence`` than the
  ///     lowest precedence of the expected token kinds and see if a token of
  ///     the requested kinds occurs after the unexpected.
  ///  2. If the token couldn't be found after skipping unexpected, it synthesizes
  ///     a missing token of `defaultKind`.
  @_spi(RawSyntax)
  public mutating func expectAny(
    _ kinds: [RawTokenKind],
    contextualKeywords: [SyntaxText] = [],
    default defaultKind: RawTokenKind
  ) -> (unexpected: RawUnexpectedNodesSyntax?, token: RawTokenSyntax) {
    return expectImpl(
      consume: { $0.consume(ifAny: kinds, contextualKeywords: contextualKeywords) },
      canRecoverTo: { $0.canRecoverTo(kinds, contextualKeywords: contextualKeywords) },
      makeMissing: { $0.missingToken(defaultKind) }
    )
  }

  /// If `keywordRecovery` is set to `true` and the parser is currently
  /// positioned at a keyword instead of an identifier, this method recovers by
  /// eating the keyword in place of an identifier, recovering if the developer
  /// incorrectly used a keyword as an identifier.
  /// This should be set if keywords aren't strong recovery marker at this
  /// position, e.g. because the parser expects a punctuator next.
  @_spi(RawSyntax)
  public mutating func expectIdentifier(allowIdentifierLikeKeywords: Bool = true, keywordRecovery: Bool = false) -> (RawUnexpectedNodesSyntax?, RawTokenSyntax) {
    if allowIdentifierLikeKeywords {
      if let (_, handle) = self.canRecoverTo(anyIn: IdentifierTokens.self) {
        return self.eat(handle)
      }
    } else {
      if let identifier = self.consume(if: .identifier) {
        return (nil, identifier)
      }
    }
    if let unknown = self.consume(if: .unknown) {
      return (
        RawUnexpectedNodesSyntax(elements: [RawSyntax(unknown)], arena: self.arena),
        self.missingToken(.identifier)
      )
    }
    if let number = self.consume(ifAny: [.integerLiteral, .floatingLiteral, .dollarIdentifier]) {
      return (
        RawUnexpectedNodesSyntax(elements: [RawSyntax(number)], arena: self.arena),
        self.missingToken(.identifier, text: nil)
      )
    } else if keywordRecovery, self.currentToken.tokenKind.isKeyword, !self.currentToken.isAtStartOfLine {
      let keyword = self.consumeAnyToken()
      return (
        RawUnexpectedNodesSyntax(elements: [RawSyntax(keyword)], arena: self.arena),
        self.missingToken(.identifier, text: nil)
      )
    }
    return (
      nil,
      self.missingToken(.identifier)
    )
  }

  @_spi(RawSyntax)
  public mutating func expectIdentifierOrRethrows() -> (RawUnexpectedNodesSyntax?, RawTokenSyntax) {
    if let (_, handle) = self.canRecoverTo(anyIn: IdentifierOrRethrowsTokens.self) {
      return self.eat(handle)
    }
    if let unknown = self.consume(if: .unknown) {
      return (
        RawUnexpectedNodesSyntax(elements: [RawSyntax(unknown)], arena: self.arena),
        self.missingToken(.identifier)
      )
    }
    return (
      nil,
      self.missingToken(.identifier)
    )
  }

  /// Expect a right brace but with a little smart recovery logic:
  /// If `leftBrace` is missing, we only recover to a `}` whose indentation is greater or equal to that of `introducer`.
  /// That way, if the developer forgot to to type `{`, we won't eat `}` that were most likely intended to close an outer scope.
  ///
  /// If `leftBrace` is present or `introducer` is `nil`, this is equivalent to `self.expect(.rightBrace)`.
  mutating func expectRightBrace(leftBrace: RawTokenSyntax, introducer: RawTokenSyntax?) -> (unexpected: RawUnexpectedNodesSyntax?, token: RawTokenSyntax) {
    func indentation(_ pieces: [RawTriviaPiece]) -> RawTriviaPiece? {
      if pieces.last?.isNewline == true {
        return .spaces(0)
      }
      guard pieces.count >= 2 else {
        return nil
      }
      guard pieces[pieces.count - 2].isNewline else {
        return nil
      }
      switch pieces[pieces.count - 1] {
      case .spaces, .tabs:
        return pieces[pieces.count - 1]
      default:
        return nil
      }
    }

    guard leftBrace.isMissing, let introducer = introducer else {
      // Fast path for correct parses: If leftBrace is not missing, just `expect`.
      return self.expect(.rightBrace)
    }

    var lookahead = self.lookahead()
    guard let recoveryHandle = lookahead.canRecoverTo([.rightBrace]) else {
      // We can't recover to '}'. Synthesize it.
      return (nil, self.missingToken(.rightBrace, text: nil))
    }

    // We can recover to a '}'. Decide whether we want to eat it based on its indentation.
    let rightBraceTrivia = self.arena.parseTrivia(source: lookahead.currentToken.leadingTriviaText, position: .leading)
    switch (indentation(introducer.leadingTriviaPieces), indentation(rightBraceTrivia)) {
    // Catch cases where the brace has known indentation that is less than that of `introducer`, in which case we don't want to consume it.
    case (.spaces(let introducerSpaces), .spaces(let rightBraceSpaces)) where rightBraceSpaces < introducerSpaces:
      return (nil, self.missingToken(.rightBrace, text: nil))
    case (.tabs(let introducerTabs), .tabs(let rightBraceTabs)) where rightBraceTabs < introducerTabs:
      return (nil, self.missingToken(.rightBrace, text: nil))
    case (.spaces, .tabs(0)):
      return (nil, self.missingToken(.rightBrace, text: nil))
    case (.tabs, .spaces(0)):
      return (nil, self.missingToken(.rightBrace, text: nil))
    default:
      return self.eat(recoveryHandle)
    }
  }
}

// MARK: Splitting Tokens

extension Parser {
  /// Consumes a given token, or splits the current token into a leading token
  /// matching the given `prefix` and a trailing token and consumes the leading
  /// token.
  ///
  ///     <TOKEN> ... -> consume(<TOK>, as: kind) -> [ <TOK> ] <EN> ...
  mutating func consumePrefix(
    _ prefix: SyntaxText,
    as tokenKind: RawTokenKind
  ) -> RawTokenSyntax {
    let current = self.currentToken
    // Current token can be either one-character token we want to consume...
    let tokenText = current.tokenText

    if tokenText == prefix {
      return self.consumeAnyToken(remapping: tokenKind)
    }
    assert(tokenText.hasPrefix(prefix))

    let endIndex = current.textRange.lowerBound.advanced(by: prefix.count)
    let tok = RawTokenSyntax(
      kind: tokenKind,
      wholeText: SyntaxText(rebasing: current.wholeText[..<endIndex]),
      textRange: current.textRange.lowerBound..<endIndex,
      presence: .present,
      hasLexerError: current.flags.contains(.isErroneous),
      arena: self.arena
    )

    self.adjustNestingLevel(for: tokenKind)

    // ... or a multi-character token with the first N characters being the one
    // that we want to consume as a separate token.
    // Careful: We need to reset the lexer to a point just before it saw the
    // current token, plus the split point. That means we need to take trailing
    // trivia into account for the current token, but we only need to take the
    // number of UTF-8 bytes of the text of the split - no trivia necessary.
    //
    // <TOKEN<trailing trivia>> <NEXT TOKEN> ... -> <T> <OKEN<trailing trivia>> <NEXT TOKEN>
    //
    // The current calculation is:
    //
    //        <<leading trivia>TOKEN<trailing trivia>>
    //                                        CURSOR ^
    // + trailing trivia length
    //
    //        <<leading trivia>TOKEN<trailing trivia>>
    //                       CURSOR ^
    // + content length
    //
    //        <<leading trivia>TOKEN<trailing trivia>>
    //                  CURSOR ^
    // - split point length
    //
    //        <<leading trivia>TOKEN<trailing trivia>>
    //                   CURSOR ^
    let offset =
      (self.currentToken.trailingTriviaByteLength
        + tokenText.count
        - prefix.count)
    self.currentToken = self.lexemes.resetForSplit(of: offset)
    return tok
  }
}

extension SyntaxText {
  func withBuffer<Result>(_ body: (UnsafeBufferPointer<UInt8>) throws -> Result) rethrows -> Result {
    try body(UnsafeBufferPointer<UInt8>(start: self.baseAddress, count: self.count))
  }
}
