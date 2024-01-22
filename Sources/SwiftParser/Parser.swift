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

#if swift(>=6)
@_spi(RawSyntax) public import SwiftSyntax
#else
@_spi(RawSyntax) import SwiftSyntax
#endif

/// A parser for the Swift programming language.
///
/// ``Parser`` implements a recursive descent parser that produces a SwiftSyntax
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
/// Token consumption is generally either unconditional via `TokenConsumer.consumeAnyToken()`
/// or conditional via a combination of `TokenConsumer/at(_:where:)`
/// and `TokenConsumer.eat(_:)`. When parsing conditionally, `at` returns a
/// handle that is passed to `eat`. This ensures that any structure that is
/// checked for is actually parsed by the parser at that position. If the parser
/// detects any unexpected structure, an assertion is raised. To perform
/// conditional consumption and validation in one step, use `consume(if:)` for
/// one kind of token, or `consume(ifAny:)` to consume many kinds of tokens.
///
/// It can also be useful to expect the presence of certain structural elements.
/// For example, a function that parses the content of code items might expect
/// an opening brace, its items, and also expect a closing brace:
///
///     let lbrace = self.eat(.leftBrace)
///     /*  */
///     let rbrace = self.expect(.rightBrace)
///
/// Unlike `TokenConsumer.eat(_:)`, `Parser.expect(_:remapping:)` returns
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
///       // Consume the delimiter
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
/// `Parser.Lookahead` instance should be constructed instead with
/// `Parser.lookahead()`.
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
  var arena: ParsingSyntaxArena

  /// A view of the sequence of lexemes in the input.
  var lexemes: Lexer.LexemeSequence

  /// The current token that should be consumed next.
  ///
  /// If the end of the source file is reached, this is `.endOfFile`.
  ///
  /// - Important: You should almost never need to access this token directly
  ///   in the parser. Instead, prefer using the `at` methods.
  var currentToken: Lexer.Lexeme

  /// The current nesting level, i.e. the number of tokens that
  /// `startNestingLevel` minus the number of tokens that `endNestingLevel`
  /// which have been consumed so far.
  var nestingLevel: Int = 0

  /// When this nesting level is exceeded, the parser should stop parsing.
  let maximumNestingLevel: Int

  /// See comments in ``IncrementalParseLookup``
  var parseLookup: IncrementalParseLookup?

  /// See comments in ``LookaheadRanges``
  public internal(set) var lookaheadRanges = LookaheadRanges()

  /// Parser should own a ``LookaheadTracker`` so that we can share one `furthestOffset` in a parse.
  let lookaheadTrackerOwner: LookaheadTrackerOwner

  /// The Swift version as which this source file should be parsed.
  let swiftVersion: SwiftVersion

  /// The experimental features that have been enabled.
  let experimentalFeatures: ExperimentalFeatures

  /// A default maximum nesting level that is used if the client didn't
  /// explicitly specify one. Debug builds of the parser consume a lot more stack
  /// space and thus have a lower default maximum nesting level.
  #if DEBUG
  static let defaultMaximumNestingLevel = 20
  #else
  static let defaultMaximumNestingLevel = 256
  #endif

  /// The Swift version as which source files should be parsed if no Swift version is explicitly specified in the parser.
  static let defaultSwiftVersion: SwiftVersion = .v6

  var _emptyRawMultipleTrailingClosureElementListSyntax: RawMultipleTrailingClosureElementListSyntax?

  /// Create an empty collection of the given type.
  ///
  /// These empty collections are only created once and the same node is returned
  /// on subsequent calls, reducing memory usage.
  mutating func emptyCollection(_: RawMultipleTrailingClosureElementListSyntax.Type) -> RawMultipleTrailingClosureElementListSyntax {
    if _emptyRawMultipleTrailingClosureElementListSyntax == nil {
      _emptyRawMultipleTrailingClosureElementListSyntax = RawMultipleTrailingClosureElementListSyntax(elements: [], arena: self.arena)
    }
    return _emptyRawMultipleTrailingClosureElementListSyntax!
  }

  var _emptyRawDeclModifierListSyntax: RawDeclModifierListSyntax?

  /// Create an empty collection of the given type.
  ///
  /// These empty collections are only created once and the same node is returned
  /// on subsequent calls, reducing memory usage.
  mutating func emptyCollection(_: RawDeclModifierListSyntax.Type) -> RawDeclModifierListSyntax {
    if _emptyRawDeclModifierListSyntax == nil {
      _emptyRawDeclModifierListSyntax = RawDeclModifierListSyntax(elements: [], arena: self.arena)
    }
    return _emptyRawDeclModifierListSyntax!
  }

  var _emptyRawAttributeListSyntax: RawAttributeListSyntax?

  /// Create an empty collection of the given type.
  ///
  /// These empty collections are only created once and the same node is returned
  /// on subsequent calls, reducing memory usage.
  mutating func emptyCollection(_: RawAttributeListSyntax.Type) -> RawAttributeListSyntax {
    if _emptyRawAttributeListSyntax == nil {
      _emptyRawAttributeListSyntax = RawAttributeListSyntax(elements: [], arena: self.arena)
    }
    return _emptyRawAttributeListSyntax!
  }

  var _emptyRawTypeSpecifierListSyntax: RawTypeSpecifierListSyntax?

  /// Create an empty collection of the given type.
  ///
  /// These empty collections are only created once and the same node is returned
  /// on subsequent calls, reducing memory usage.
  mutating func emptyCollection(_: RawTypeSpecifierListSyntax.Type) -> RawTypeSpecifierListSyntax {
    if _emptyRawTypeSpecifierListSyntax == nil {
      _emptyRawTypeSpecifierListSyntax = RawTypeSpecifierListSyntax(elements: [], arena: self.arena)
    }
    return _emptyRawTypeSpecifierListSyntax!
  }

  /// The delegated initializer for the parser.
  ///
  /// - Parameters
  ///   - input: An input buffer containing Swift source text. If a non-`nil`
  ///            arena is provided, the buffer must be present in it. Otherwise
  ///            the buffer is copied into a new arena and can thus be freed
  ///            after the initializer has been called.
  ///   - maximumNestingLevel: To avoid overflowing the stack, the parser will
  ///                          stop if a nesting level greater than this value
  ///                          is reached. The nesting level is increased
  ///                          whenever a bracketed expression like `(` or `{`
  ///                          is started. `defaultMaximumNestingLevel` is used
  ///                          if this is `nil`.
  ///   - parseTransition: The previously recorded state for an incremental
  ///                      parse, or `nil`.
  ///   - arena: Arena the parsing syntax are made into. If it's `nil`, a new
  ///            arena is created automatically, and `input` copied into the
  ///            arena. If non-`nil`, `input` must be within its registered
  ///            source buffer or allocator.
  ///  - swiftVersion: The version of Swift using which the file should be parsed.
  ///                  Defaults to the latest version.
  ///  - experimentalFeatures: The experimental features enabled for the parser.
  private init(
    buffer input: UnsafeBufferPointer<UInt8>,
    maximumNestingLevel: Int?,
    parseTransition: IncrementalParseTransition?,
    arena: ParsingSyntaxArena?,
    swiftVersion: SwiftVersion?,
    experimentalFeatures: ExperimentalFeatures
  ) {
    var input = input
    if let arena {
      self.arena = arena
      precondition(arena.contains(text: SyntaxText(baseAddress: input.baseAddress, count: input.count)))
    } else {
      self.arena = ParsingSyntaxArena(parseTriviaFunction: TriviaParser.parseTrivia)
      input = self.arena.internSourceBuffer(input)
    }

    self.maximumNestingLevel = maximumNestingLevel ?? Self.defaultMaximumNestingLevel
    self.swiftVersion = swiftVersion ?? Self.defaultSwiftVersion
    self.experimentalFeatures = experimentalFeatures
    self.lookaheadTrackerOwner = LookaheadTrackerOwner()

    self.lexemes = Lexer.tokenize(input, lookaheadTracker: lookaheadTrackerOwner.lookaheadTracker)
    self.currentToken = self.lexemes.advance()
    if let parseTransition {
      self.parseLookup = IncrementalParseLookup(transition: parseTransition)
    } else {
      self.parseLookup = nil
    }
  }

  /// Private initializer for creating a ``Parser`` from the given string.
  private init(
    string input: String,
    maximumNestingLevel: Int?,
    parseTransition: IncrementalParseTransition?,
    swiftVersion: SwiftVersion?,
    experimentalFeatures: ExperimentalFeatures
  ) {
    var input = input
    input.makeContiguousUTF8()
    self = input.withUTF8 { buffer in
      Parser(
        buffer: buffer,
        maximumNestingLevel: maximumNestingLevel,
        parseTransition: parseTransition,
        arena: nil,
        swiftVersion: swiftVersion,
        experimentalFeatures: experimentalFeatures
      )
    }
  }

  /// Initializes a ``Parser`` from the given string.
  public init(
    _ input: String,
    maximumNestingLevel: Int? = nil,
    parseTransition: IncrementalParseTransition? = nil,
    swiftVersion: SwiftVersion? = nil
  ) {
    // Chain to the private String initializer.
    self.init(
      string: input,
      maximumNestingLevel: maximumNestingLevel,
      parseTransition: parseTransition,
      swiftVersion: swiftVersion,
      experimentalFeatures: []
    )
  }

  /// Initializes a ``Parser`` from the given input buffer.
  ///
  /// - Parameters
  ///   - input: An input buffer containing Swift source text. If a non-`nil`
  ///            arena is provided, the buffer must be present in it. Otherwise
  ///            the buffer is copied into a new arena and can thus be freed
  ///            after the initializer has been called.
  ///   - maximumNestingLevel: To avoid overflowing the stack, the parser will
  ///                          stop if a nesting level greater than this value
  ///                          is reached. The nesting level is increased
  ///                          whenever a bracketed expression like `(` or `{`
  ///                          is started. `defaultMaximumNestingLevel` is used
  ///                          if this is `nil`.
  ///   - parseTransition: The previously recorded state for an incremental
  ///                      parse, or `nil`.
  ///   - arena: Arena the parsing syntax are made into. If it's `nil`, a new
  ///            arena is created automatically, and `input` copied into the
  ///            arena. If non-`nil`, `input` must be within its registered
  ///            source buffer or allocator.
  public init(
    _ input: UnsafeBufferPointer<UInt8>,
    maximumNestingLevel: Int? = nil,
    parseTransition: IncrementalParseTransition? = nil,
    arena: ParsingSyntaxArena? = nil,
    swiftVersion: SwiftVersion? = nil
  ) {
    // Chain to the private buffer initializer.
    self.init(
      buffer: input,
      maximumNestingLevel: maximumNestingLevel,
      parseTransition: parseTransition,
      arena: arena,
      swiftVersion: swiftVersion,
      experimentalFeatures: []
    )
  }

  /// Initializes a ``Parser`` from the given input string, with a given set
  /// of experimental language features.
  @_spi(ExperimentalLanguageFeatures)
  public init(
    _ input: String,
    maximumNestingLevel: Int? = nil,
    parseTransition: IncrementalParseTransition? = nil,
    swiftVersion: SwiftVersion? = nil,
    experimentalFeatures: ExperimentalFeatures
  ) {
    // Chain to the private String initializer.
    self.init(
      string: input,
      maximumNestingLevel: maximumNestingLevel,
      parseTransition: parseTransition,
      swiftVersion: swiftVersion,
      experimentalFeatures: experimentalFeatures
    )
  }

  /// Initializes a ``Parser`` from the given input buffer, with a given set
  /// of experimental language features.
  @_spi(ExperimentalLanguageFeatures)
  public init(
    _ input: UnsafeBufferPointer<UInt8>,
    maximumNestingLevel: Int? = nil,
    parseTransition: IncrementalParseTransition? = nil,
    arena: ParsingSyntaxArena? = nil,
    swiftVersion: SwiftVersion? = nil,
    experimentalFeatures: ExperimentalFeatures
  ) {
    // Chain to the private buffer initializer.
    self.init(
      buffer: input,
      maximumNestingLevel: maximumNestingLevel,
      parseTransition: parseTransition,
      arena: arena,
      swiftVersion: swiftVersion,
      experimentalFeatures: experimentalFeatures
    )
  }

  mutating func missingToken(_ kind: RawTokenKind, text: SyntaxText? = nil) -> RawTokenSyntax {
    adjustNestingLevel(for: kind)
    return RawTokenSyntax(missing: kind, text: text, arena: self.arena)
  }

  mutating func missingToken(_ keyword: Keyword) -> RawTokenSyntax {
    return missingToken(.keyword, text: keyword.defaultText)
  }

  /// Consumes the current token and advances the lexer to the next token.
  ///
  /// - Returns: The token that was consumed.
  mutating func consumeAnyToken() -> RawTokenSyntax {
    adjustNestingLevel(for: self.currentToken.rawTokenKind)
    return self.consumeAnyTokenWithoutAdjustingNestingLevel()
  }

  mutating func consumeAnyTokenWithoutAdjustingNestingLevel() -> RawTokenSyntax {
    let tok = self.currentToken
    self.currentToken = self.lexemes.advance()
    return RawTokenSyntax(
      kind: tok.rawTokenKind,
      wholeText: tok.wholeText,
      textRange: tok.textRange,
      presence: .present,
      tokenDiagnostic: tok.diagnostic,
      arena: arena
    )
  }

  private mutating func adjustNestingLevel(for tokenKind: RawTokenKind) {
    switch tokenKind {
    case .leftAngle, .leftBrace, .leftParen, .leftSquare, .poundIf:
      nestingLevel += 1
    case .rightAngle, .rightBrace, .rightParen, .rightSquare, .poundEndif:
      nestingLevel -= 1
    default:
      break
    }
  }

  #if SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION
  var shouldRecordAlternativeTokenChoices: Bool = false

  @_spi(AlternateTokenIntrospection)
  public mutating func enableAlternativeTokenChoices() {
    shouldRecordAlternativeTokenChoices = true
  }

  /// When compiled with `SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION`, and
  /// `shouldRecordAlternativeTokenChoices` is `true` the parser records which
  /// ``TokenSpec``s it checked for a token at a specific offset in the source
  /// file. The offsets are the location of the token text's start (excluding
  /// leading trivia).
  ///
  /// This information allows testing techniques to replace tokens by these
  /// alternate token choices to generate new, interesting test cases
  @_spi(AlternateTokenIntrospection)
  public var alternativeTokenChoices: [Int: [TokenSpec]] = [:]

  mutating func recordAlternativeTokenChoice(for lexeme: Lexer.Lexeme, choices: [TokenSpec]) {
    let offset = lexemes.offsetToStart(lexeme)
    alternativeTokenChoices[offset, default: []].append(contentsOf: choices)
  }
  #endif
}

// MARK: Inspecting Tokens

extension Parser {
  /// Retrieves the token following the current token without consuming it.
  func peek() -> Lexer.Lexeme {
    return self.lexemes.peek()
  }
}

// MARK: Consuming Tokens

extension Parser: TokenConsumer {}

extension Parser {
  /// Consumes the current token and sets its kind to the given ``TokenKind``,
  /// then advances the lexer to the next token.
  ///
  /// - Parameter kind: The kind to reset the consumed token to.
  /// - Returns: The token that was consumed with its kind re-mapped to the
  ///            given ``TokenKind``.
  mutating func consumeAnyToken(remapping kind: RawTokenKind) -> RawTokenSyntax {
    self.currentToken.rawTokenKind = kind
    return self.consumeAnyToken()
  }

  /// Consumes remaining token on the line and returns a ``RawUnexpectedNodesSyntax``
  /// if there is any tokens consumed.
  mutating func consumeRemainingTokenOnLine() -> RawUnexpectedNodesSyntax? {
    guard !self.atStartOfLine else {
      return nil
    }

    var unexpectedTokens = [RawTokenSyntax]()
    var loopProgress = LoopProgressCondition()
    while !self.at(.endOfFile), !atStartOfLine, self.hasProgressed(&loopProgress) {
      unexpectedTokens += [self.consumeAnyToken()]
    }

    return RawUnexpectedNodesSyntax(unexpectedTokens, arena: self.arena)
  }

}

// MARK: Check if we can recover to a token

extension Parser {
  /// Checks if it can reach a token of the given `spec` by skipping unexpected
  /// tokens that have lower ``TokenPrecedence`` than specified by `spec`.
  @inline(__always)
  mutating func canRecoverTo(_ spec: TokenSpec) -> RecoveryConsumptionHandle? {
    if self.at(spec) {
      return .constant(spec)
    }
    var lookahead = self.lookahead()
    return lookahead.canRecoverTo(spec)
  }

  /// Checks if we can reach a token in `subset` by skipping tokens that have
  /// a precedence that have a lower ``TokenPrecedence`` than the minimum
  /// precedence of a token in that subset.
  /// If so, return the token that we can recover to and a handle that can be
  /// used to consume the unexpected tokens and the token we recovered to.
  @inline(__always)
  mutating func canRecoverTo<SpecSet: TokenSpecSet>(
    anyIn specSet: SpecSet.Type,
    overrideRecoveryPrecedence: TokenPrecedence? = nil
  ) -> (match: SpecSet, handle: RecoveryConsumptionHandle)? {
    if let (kind, handle) = self.at(anyIn: specSet) {
      return (kind, .noRecovery(handle))
    }
    var lookahead = self.lookahead()
    return lookahead.canRecoverTo(anyIn: specSet, overrideRecoveryPrecedence: overrideRecoveryPrecedence)
  }

  /// Eat a token that we know we are currently positioned at, based on `canRecoverTo(anyIn:)`.
  @inline(__always)
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

// MARK: Expecting Tokens without Recovery

extension Parser {
  /// If the current token matches the given `spec`, consume it.
  /// Otherwise, synthesize a missing token of with the `kind` of `spec`.
  ///
  /// This method does not try to eat unexpected until it finds the token that
  /// matches `spec`.
  /// In the parser, `expect` should be preferred.
  @inline(__always)
  mutating func expectWithoutRecovery(_ spec: TokenSpec) -> Token {
    if let token = self.consume(if: spec) {
      return token
    } else {
      return missingToken(spec)
    }
  }

  /// Same as `expectWithoutRecovery`, but also enforces that the token does
  /// not have any leading trivia. Otherwise, a missing token is synthesized.
  @inline(__always)
  mutating func expectWithoutRecoveryOrLeadingTrivia(_ spec: TokenSpec) -> Token {
    guard self.at(spec), currentToken.leadingTriviaText.isEmpty else {
      return missingToken(spec)
    }
    return self.eat(spec)
  }
}

// MARK: Expecting Tokens with Recovery

extension Parser {
  /// Implements the paradigm shared across all `expect` methods.
  @inline(__always)
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

  /// Attempts to consume a token that matches the given `spec`.
  /// If it cannot be found, the parser tries
  ///  1. To eat unexpected tokens that have lower ``TokenPrecedence`` than
  ///     specified by `spec` and see if the token occurs after that unexpected.
  ///  2. If the token couldn't be found after skipping unexpected, it synthesizes
  ///     a missing token of the requested kind.
  @inline(__always)
  mutating func expect(
    _ spec: TokenSpec
  ) -> (unexpected: RawUnexpectedNodesSyntax?, token: RawTokenSyntax) {
    return expectImpl(
      consume: { $0.consume(if: spec) },
      canRecoverTo: { $0.canRecoverTo(spec) },
      makeMissing: { $0.missingToken(spec) }
    )
  }

  /// Attempts to consume a token that matches `spec1` or `spec2`.
  /// If it cannot be found, the parser tries
  ///  1. To eat unexpected tokens that have lower ``TokenPrecedence`` than the
  ///     lowest precedence of the spec and see if a token of the requested
  ///     kinds occurs after the unexpected.
  ///  2. If the token couldn't be found after skipping unexpected, it synthesizes
  ///     a missing token of `defaultKind`.
  @inline(__always)
  mutating func expect(
    _ spec1: TokenSpec,
    _ spec2: TokenSpec,
    default defaultKind: TokenSpec
  ) -> (unexpected: RawUnexpectedNodesSyntax?, token: RawTokenSyntax) {
    return expectImpl(
      consume: { $0.consume(if: spec1, spec2) },
      canRecoverTo: { $0.canRecoverTo(spec1, spec2) },
      makeMissing: { $0.missingToken(defaultKind) }
    )
  }

  /// Attempts to consume a token that matches `spec1` or `spec2`.
  /// If it cannot be found, the parser tries
  ///  1. To eat unexpected tokens that have lower ``TokenPrecedence`` than the
  ///     lowest precedence of the spec and see if a token of the requested
  ///     kinds occurs after the unexpected.
  ///  2. If the token couldn't be found after skipping unexpected, it synthesizes
  ///     a missing token of `defaultKind`.
  @inline(__always)
  mutating func expect(
    _ spec1: TokenSpec,
    _ spec2: TokenSpec,
    _ spec3: TokenSpec,
    default defaultKind: TokenSpec
  ) -> (unexpected: RawUnexpectedNodesSyntax?, token: RawTokenSyntax) {
    return expectImpl(
      consume: { $0.consume(if: spec1, spec2, spec3) },
      canRecoverTo: { $0.canRecoverTo(spec1, spec2, spec3) },
      makeMissing: { $0.missingToken(defaultKind) }
    )
  }

  @inline(__always)
  mutating func expect<SpecSet: TokenSpecSet>(
    anyIn specSet: SpecSet.Type,
    default defaultKind: SpecSet
  ) -> (unexpected: RawUnexpectedNodesSyntax?, token: RawTokenSyntax) {
    return expectImpl(
      consume: { $0.consume(ifAnyIn: specSet) },
      canRecoverTo: { $0.canRecoverTo(anyIn: specSet)?.1 },
      makeMissing: { $0.missingToken(defaultKind.spec) }
    )
  }

  /// If the current token starts with the given prefix, consume the prefis as the given token kind.
  ///
  /// Otherwise, synthesize a missing token of the given kind.
  mutating func expectWithoutRecovery(prefix: SyntaxText, as tokenKind: RawTokenKind) -> Token {
    if self.at(prefix: prefix) {
      return consumePrefix(prefix, as: tokenKind)
    } else {
      return missingToken(tokenKind)
    }
  }

  /// - Parameters:
  ///   - keywordRecovery: If set to `true` and the parser is currently
  ///     positioned at a keyword instead of an identifier, this method recovers
  ///     by eating the keyword in place of an identifier, recovering if the
  ///     developer incorrectly used a keyword as an identifier. This should be
  ///     set if keywords aren't strong recovery marker at this position, e.g.
  ///     because the parser expects a punctuator next
  ///   - allowSelfOrCapitalSelfAsIdentifier: If set to `true`, then `self` and
  ///     `Self` are also accepted and remapped to identifiers. This is
  ///     exclusively used to maintain compatibility with the C++ parser. No new
  ///     uses of this should be introduced.
  ///   - allowKeywordsAsIdentifier: If set to `true` and the parser is
  ///     currently positioned at a keyword, consume that keyword and remap it
  ///     to and identifier.
  /// - Returns: The consumed token and any unexpected tokens that were skipped.
  ///   The token is always guaranteed to be of `TokenKind.identifier`
  mutating func expectIdentifier(
    keywordRecovery: Bool = false,
    allowSelfOrCapitalSelfAsIdentifier: Bool = false,
    allowKeywordsAsIdentifier: Bool = false
  ) -> (RawUnexpectedNodesSyntax?, RawTokenSyntax) {
    if let identifier = self.consume(if: .identifier) {
      return (nil, identifier)
    }
    if allowKeywordsAsIdentifier, self.currentToken.isLexerClassifiedKeyword {
      return (nil, self.consumeAnyToken(remapping: .identifier))
    }
    if allowSelfOrCapitalSelfAsIdentifier,
      let selfOrCapitalSelf = self.consume(if: TokenSpec(.self, remapping: .identifier), TokenSpec(.Self, remapping: .identifier))
    {
      return (nil, selfOrCapitalSelf)
    }
    if let unknown = self.consume(if: .unknown) {
      return (
        RawUnexpectedNodesSyntax(elements: [RawSyntax(unknown)], arena: self.arena),
        self.missingToken(.identifier)
      )
    }
    if let number = self.consume(if: .integerLiteral, .floatLiteral, .dollarIdentifier) {
      return (
        RawUnexpectedNodesSyntax(elements: [RawSyntax(number)], arena: self.arena),
        self.missingToken(.identifier)
      )
    } else if keywordRecovery,
      (self.currentToken.isLexerClassifiedKeyword || self.at(.wildcard)),
      !self.atStartOfLine
    {
      let keyword = self.consumeAnyToken()
      return (
        RawUnexpectedNodesSyntax(elements: [RawSyntax(keyword)], arena: self.arena),
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
    guard let recoveryHandle = lookahead.canRecoverTo(.rightBrace) else {
      // We can't recover to '}'. Synthesize it.
      return (nil, self.missingToken(.rightBrace))
    }

    // We can recover to a '}'. Decide whether we want to eat it based on its indentation.
    let rightBraceTrivia = self.arena.parseTrivia(source: lookahead.currentToken.leadingTriviaText, position: .leading)
    switch (indentation(introducer.leadingTriviaPieces), indentation(rightBraceTrivia)) {
    // Catch cases where the brace has known indentation that is less than that of `introducer`, in which case we don't want to consume it.
    case (.spaces(let introducerSpaces), .spaces(let rightBraceSpaces)) where rightBraceSpaces < introducerSpaces:
      return (nil, self.missingToken(.rightBrace))
    case (.tabs(let introducerTabs), .tabs(let rightBraceTabs)) where rightBraceTabs < introducerTabs:
      return (nil, self.missingToken(.rightBrace))
    case (.spaces, .tabs(0)):
      return (nil, self.missingToken(.rightBrace))
    case (.tabs, .spaces(0)):
      return (nil, self.missingToken(.rightBrace))
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
    precondition(
      tokenKind.defaultText == nil || prefix == tokenKind.defaultText!,
      "If tokenKind has a defaultText, the prefix needs to match it"
    )
    let current = self.currentToken
    // Current token can be either one-character token we want to consume...
    let tokenText = current.tokenText

    if tokenText == prefix {
      return self.consumeAnyToken(remapping: tokenKind)
    }
    precondition(tokenText.hasPrefix(prefix))

    let endIndex = current.textRange.lowerBound.advanced(by: prefix.count)
    var tokenDiagnostic = current.diagnostic
    if let error = tokenDiagnostic, error.byteOffset > prefix.count + current.leadingTriviaByteLength {
      // The lexer error isn't in the prefix. Drop it.
      tokenDiagnostic = nil
    }

    let tok = RawTokenSyntax(
      kind: tokenKind,
      wholeText: SyntaxText(rebasing: current.wholeText[..<endIndex]),
      textRange: current.textRange.lowerBound..<endIndex,
      presence: .present,
      tokenDiagnostic: tokenDiagnostic,
      arena: self.arena
    )

    self.adjustNestingLevel(for: tokenKind)

    self.currentToken = self.lexemes.resetForSplit(
      splitToken: self.currentToken,
      consumedPrefix: self.currentToken.leadingTriviaByteLength + prefix.count
    )
    return tok
  }
}

extension SyntaxText {
  func withBuffer<Result>(_ body: (UnsafeBufferPointer<UInt8>) throws -> Result) rethrows -> Result {
    try body(UnsafeBufferPointer<UInt8>(start: self.baseAddress, count: self.count))
  }
}

extension Parser {
  /// Consume a period as part of a member expression/type while handling
  /// extraneous whitespace. Consider the following cases -
  ///   - `<no whitespace>.<no whitespace>`: return the consumed period
  ///   - `<whitespace>.<any>`: return the consumed period
  ///   - `<no whitespace>.<whitespace>`: if no newlines, return both an
  ///     unexpected period (with the extraneous whitespace) and a missing
  ///     period. If there is a newline also set `skipMember` to inform
  ///     callers to not parse any further member names.
  mutating func consumeMemberPeriod(
    previousNode: (some RawSyntaxNodeProtocol)?
  ) -> (unexpected: RawUnexpectedNodesSyntax?, period: RawTokenSyntax, skipMemberName: Bool) {
    precondition(self.at(.period))

    let beforePeriodWhitespace = previousNode?.raw.trailingTriviaByteLength ?? 0 > 0 || self.currentToken.leadingTriviaByteLength > 0
    let afterPeriodWhitespace = self.currentToken.trailingTriviaByteLength > 0 || self.peek().leadingTriviaByteLength > 0
    let afterContainsAnyNewline = self.peek().isAtStartOfLine

    let period = self.consumeAnyToken()

    if beforePeriodWhitespace || !afterPeriodWhitespace {
      // Valid, parse as-is
      return (nil, period, false)
    }

    // Invalid, extraneous whitespace. Have callers synthesize a missing
    // member if there's a newline after the period.
    return (
      RawUnexpectedNodesSyntax(elements: [period.raw], arena: arena),
      RawTokenSyntax(missing: .period, arena: arena),
      afterContainsAnyNewline
    )
  }
}

/// Record the furthest offset to `sourceBufferStart` that is reached by  `LexemeSequence.advance()` or `LexemeSequence.peek()`.
public struct LookaheadTracker {
  private(set) var furthestOffset: Int = 0

  public init() {}

  mutating func recordFurthestOffset(_ furthestOffset: Int) {
    /// We could lookahead multi-times to find different valid part of a node, so we should take the maximum of the lookahead offset as the possible affect range of a node.
    self.furthestOffset = max(furthestOffset, self.furthestOffset)
  }
}

/// Owns a ``LookaheadTracker``.
///
/// Once the `LookeaheadTrackerOwner` is deinitialized, the ``LookaheadTracker`` is also destroyed.
class LookaheadTrackerOwner {
  var lookaheadTracker: UnsafeMutablePointer<LookaheadTracker>

  init() {
    self.lookaheadTracker = .allocate(capacity: 1)
    self.lookaheadTracker.initialize(to: LookaheadTracker())
  }

  deinit {
    self.lookaheadTracker.deallocate()
  }
}

/// Record the lookahead ranges for syntax nodes.
public struct LookaheadRanges: Sendable {
  /// For each node that is recorded for re-use, the number of UTF-8 bytes that the parser looked ahead to parse the node, measured from the start of the node’s leading trivia.
  ///
  /// This information can be used to determine whether a node can be reused in incremental parse. A node can only be re-used if no byte in its looked range has changed.
  var lookaheadRanges: [RawSyntax.ID: Int] = [:]

  public init() {}

  mutating func registerNodeForIncrementalParse(node: RawSyntax, lookaheadLength: Int) {
    self.lookaheadRanges[node.id] = lookaheadLength
  }
}
