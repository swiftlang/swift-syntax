

/// Enumerates the kinds of tokens in the Swift language.
@frozen // FIXME: Not actually stable, works around a miscompile
public enum TokenKind: Hashable {
  case eof
  
  case wildcard
  
  case leftParen
  
  case rightParen
  
  case leftBrace
  
  case rightBrace
  
  case leftSquareBracket
  
  case rightSquareBracket
  
  case leftAngle
  
  case rightAngle
  
  case period
  
  case comma
  
  case ellipsis
  
  case colon
  
  case semicolon
  
  case equal
  
  case atSign
  
  case pound
  
  case prefixAmpersand
  
  case arrow
  
  case backtick
  
  case backslash
  
  case exclamationMark
  
  case postfixQuestionMark
  
  case infixQuestionMark
  
  case stringQuote
  
  case singleQuote
  
  case multilineStringQuote
  
  case poundSourceLocationKeyword
  
  case poundIfKeyword
  
  case poundElseKeyword
  
  case poundElseifKeyword
  
  case poundEndifKeyword
  
  case poundAvailableKeyword
  
  case poundUnavailableKeyword
  
  case integerLiteral(String)
  
  case floatingLiteral(String)
  
  case regexLiteral(String)
  
  case unknown(String)
  
  case identifier(String)
  
  case binaryOperator(String)
  
  case postfixOperator(String)
  
  case prefixOperator(String)
  
  case dollarIdentifier(String)
  
  case keyword(Keyword)
  
  case rawStringDelimiter(String)
  
  case stringSegment(String)
  
  /// The textual representation of this token kind.
  @_spi(Testing)
  public var text: String {
    switch self {
    case .wildcard: 
      return #"_"#
    case .leftParen: 
      return #"("#
    case .rightParen: 
      return #")"#
    case .leftBrace: 
      return #"{"#
    case .rightBrace: 
      return #"}"#
    case .leftSquareBracket: 
      return #"["#
    case .rightSquareBracket: 
      return #"]"#
    case .leftAngle: 
      return #"<"#
    case .rightAngle: 
      return #">"#
    case .period: 
      return #"."#
    case .comma: 
      return #","#
    case .ellipsis: 
      return #"..."#
    case .colon: 
      return #":"#
    case .semicolon: 
      return #";"#
    case .equal: 
      return #"="#
    case .atSign: 
      return #"@"#
    case .pound: 
      return #"#"#
    case .prefixAmpersand: 
      return #"&"#
    case .arrow: 
      return #"->"#
    case .backtick: 
      return #"`"#
    case .backslash: 
      return #"\"#
    case .exclamationMark: 
      return #"!"#
    case .postfixQuestionMark: 
      return #"?"#
    case .infixQuestionMark: 
      return #"?"#
    case .stringQuote: 
      return #"""#
    case .singleQuote: 
      return #"'"#
    case .multilineStringQuote: 
      return #"""""#
    case .poundSourceLocationKeyword: 
      return #"#sourceLocation"#
    case .poundIfKeyword: 
      return #"#if"#
    case .poundElseKeyword: 
      return #"#else"#
    case .poundElseifKeyword: 
      return #"#elseif"#
    case .poundEndifKeyword: 
      return #"#endif"#
    case .poundAvailableKeyword: 
      return #"#available"#
    case .poundUnavailableKeyword: 
      return #"#unavailable"#
    case .integerLiteral(let text): 
      return text
    case .floatingLiteral(let text): 
      return text
    case .regexLiteral(let text): 
      return text
    case .unknown(let text): 
      return text
    case .identifier(let text): 
      return text
    case .binaryOperator(let text): 
      return text
    case .postfixOperator(let text): 
      return text
    case .prefixOperator(let text): 
      return text
    case .dollarIdentifier(let text): 
      return text
    case .keyword(let assoc): 
      return String(syntaxText: assoc.defaultText)
    case .rawStringDelimiter(let text): 
      return text
    case .stringSegment(let text): 
      return text
    case .eof: 
      return ""
    }
  }
  
  /// If this token kind always has the same syntax text, that syntax text, otherwise `nil`.
  @_spi(RawSyntax)
  public var defaultText: SyntaxText? {
    switch self {
    case .wildcard: 
      return #"_"#
    case .leftParen: 
      return #"("#
    case .rightParen: 
      return #")"#
    case .leftBrace: 
      return #"{"#
    case .rightBrace: 
      return #"}"#
    case .leftSquareBracket: 
      return #"["#
    case .rightSquareBracket: 
      return #"]"#
    case .leftAngle: 
      return #"<"#
    case .rightAngle: 
      return #">"#
    case .period: 
      return #"."#
    case .comma: 
      return #","#
    case .ellipsis: 
      return #"..."#
    case .colon: 
      return #":"#
    case .semicolon: 
      return #";"#
    case .equal: 
      return #"="#
    case .atSign: 
      return #"@"#
    case .pound: 
      return #"#"#
    case .prefixAmpersand: 
      return #"&"#
    case .arrow: 
      return #"->"#
    case .backtick: 
      return #"`"#
    case .backslash: 
      return #"\"#
    case .exclamationMark: 
      return #"!"#
    case .postfixQuestionMark: 
      return #"?"#
    case .infixQuestionMark: 
      return #"?"#
    case .stringQuote: 
      return #"""#
    case .singleQuote: 
      return #"'"#
    case .multilineStringQuote: 
      return #"""""#
    case .poundSourceLocationKeyword: 
      return #"#sourceLocation"#
    case .poundIfKeyword: 
      return #"#if"#
    case .poundElseKeyword: 
      return #"#else"#
    case .poundElseifKeyword: 
      return #"#elseif"#
    case .poundEndifKeyword: 
      return #"#endif"#
    case .poundAvailableKeyword: 
      return #"#available"#
    case .poundUnavailableKeyword: 
      return #"#unavailable"#
    case .keyword(let assoc): 
      return assoc.defaultText
    case .eof: 
      return ""
    default: 
      return ""
    }
  }
  
  public var nameForDiagnostics: String {
    switch self {
    case .eof: 
      return "end of file"
    case .wildcard: 
      return #"wildcard"#
    case .leftParen: 
      return #"("#
    case .rightParen: 
      return #")"#
    case .leftBrace: 
      return #"{"#
    case .rightBrace: 
      return #"}"#
    case .leftSquareBracket: 
      return #"["#
    case .rightSquareBracket: 
      return #"]"#
    case .leftAngle: 
      return #"<"#
    case .rightAngle: 
      return #">"#
    case .period: 
      return #"."#
    case .comma: 
      return #","#
    case .ellipsis: 
      return #"..."#
    case .colon: 
      return #":"#
    case .semicolon: 
      return #";"#
    case .equal: 
      return #"="#
    case .atSign: 
      return #"@"#
    case .pound: 
      return #"#"#
    case .prefixAmpersand: 
      return #"&"#
    case .arrow: 
      return #"->"#
    case .backtick: 
      return #"`"#
    case .backslash: 
      return #"\"#
    case .exclamationMark: 
      return #"!"#
    case .postfixQuestionMark: 
      return #"?"#
    case .infixQuestionMark: 
      return #"?"#
    case .stringQuote: 
      return #"""#
    case .singleQuote: 
      return #"'"#
    case .multilineStringQuote: 
      return #"""""#
    case .poundSourceLocationKeyword: 
      return #"#sourceLocation"#
    case .poundIfKeyword: 
      return #"#if"#
    case .poundElseKeyword: 
      return #"#else"#
    case .poundElseifKeyword: 
      return #"#elseif"#
    case .poundEndifKeyword: 
      return #"#endif"#
    case .poundAvailableKeyword: 
      return #"#available"#
    case .poundUnavailableKeyword: 
      return #"#unavailable"#
    case .integerLiteral: 
      return #"integer literal"#
    case .floatingLiteral: 
      return #"floating literal"#
    case .regexLiteral: 
      return #"regex literal"#
    case .unknown: 
      return #"token"#
    case .identifier: 
      return #"identifier"#
    case .binaryOperator: 
      return #"binary operator"#
    case .postfixOperator: 
      return #"postfix operator"#
    case .prefixOperator: 
      return #"prefix operator"#
    case .dollarIdentifier: 
      return #"dollar identifier"#
    case .rawStringDelimiter: 
      return #"raw string delimiter"#
    case .stringSegment: 
      return #"string segment"#
    case .keyword(let keyword): 
      return String(syntaxText: keyword.defaultText)
    }
  }
  
  /// Returns `true` if the token is a Swift keyword.
  ///
  /// Keywords are reserved unconditionally for use by Swift and may not
  /// appear as identifiers in any position without being escaped. For example,
  /// `class`, `func`, or `import`.
  public var isLexerClassifiedKeyword: Bool {
    switch self {
    case .eof: 
      return false
    case .wildcard: 
      return false
    case .leftParen: 
      return false
    case .rightParen: 
      return false
    case .leftBrace: 
      return false
    case .rightBrace: 
      return false
    case .leftSquareBracket: 
      return false
    case .rightSquareBracket: 
      return false
    case .leftAngle: 
      return false
    case .rightAngle: 
      return false
    case .period: 
      return false
    case .comma: 
      return false
    case .ellipsis: 
      return false
    case .colon: 
      return false
    case .semicolon: 
      return false
    case .equal: 
      return false
    case .atSign: 
      return false
    case .pound: 
      return false
    case .prefixAmpersand: 
      return false
    case .arrow: 
      return false
    case .backtick: 
      return false
    case .backslash: 
      return false
    case .exclamationMark: 
      return false
    case .postfixQuestionMark: 
      return false
    case .infixQuestionMark: 
      return false
    case .stringQuote: 
      return false
    case .singleQuote: 
      return false
    case .multilineStringQuote: 
      return false
    case .poundSourceLocationKeyword: 
      return true
    case .poundIfKeyword: 
      return true
    case .poundElseKeyword: 
      return true
    case .poundElseifKeyword: 
      return true
    case .poundEndifKeyword: 
      return true
    case .poundAvailableKeyword: 
      return true
    case .poundUnavailableKeyword: 
      return true
    case .integerLiteral: 
      return false
    case .floatingLiteral: 
      return false
    case .regexLiteral: 
      return false
    case .unknown: 
      return false
    case .identifier: 
      return false
    case .binaryOperator: 
      return false
    case .postfixOperator: 
      return false
    case .prefixOperator: 
      return false
    case .dollarIdentifier: 
      return false
    case .rawStringDelimiter: 
      return false
    case .stringSegment: 
      return false
    case .keyword(let keyword): 
      return keyword.isLexerClassified
    }
  }
  
  /// Returns `true` if the token is a Swift punctuator.
  ///
  /// Punctuation tokens generally separate identifiers from each other. For
  /// example, the '<' and '>' characters in a generic parameter list, or the
  /// quote characters in a string literal.
  public var isPunctuation: Bool {
    switch self {
    case .eof: 
      return false
    case .wildcard: 
      return false
    case .leftParen: 
      return true
    case .rightParen: 
      return true
    case .leftBrace: 
      return true
    case .rightBrace: 
      return true
    case .leftSquareBracket: 
      return true
    case .rightSquareBracket: 
      return true
    case .leftAngle: 
      return true
    case .rightAngle: 
      return true
    case .period: 
      return true
    case .comma: 
      return true
    case .ellipsis: 
      return true
    case .colon: 
      return true
    case .semicolon: 
      return true
    case .equal: 
      return true
    case .atSign: 
      return true
    case .pound: 
      return true
    case .prefixAmpersand: 
      return true
    case .arrow: 
      return true
    case .backtick: 
      return true
    case .backslash: 
      return true
    case .exclamationMark: 
      return true
    case .postfixQuestionMark: 
      return true
    case .infixQuestionMark: 
      return true
    case .stringQuote: 
      return true
    case .singleQuote: 
      return true
    case .multilineStringQuote: 
      return true
    case .poundSourceLocationKeyword: 
      return false
    case .poundIfKeyword: 
      return false
    case .poundElseKeyword: 
      return false
    case .poundElseifKeyword: 
      return false
    case .poundEndifKeyword: 
      return false
    case .poundAvailableKeyword: 
      return false
    case .poundUnavailableKeyword: 
      return false
    case .integerLiteral: 
      return false
    case .floatingLiteral: 
      return false
    case .regexLiteral: 
      return false
    case .unknown: 
      return false
    case .identifier: 
      return false
    case .binaryOperator: 
      return false
    case .postfixOperator: 
      return false
    case .prefixOperator: 
      return false
    case .dollarIdentifier: 
      return false
    case .keyword: 
      return false
    case .rawStringDelimiter: 
      return false
    case .stringSegment: 
      return false
    }
  }
}

extension TokenKind: Equatable {
  public static func == (lhs: TokenKind, rhs: TokenKind) -> Bool {
    switch (lhs, rhs) {
    case (.eof, .eof): 
      return true
    case (.wildcard, .wildcard): 
      return true
    case (.leftParen, .leftParen): 
      return true
    case (.rightParen, .rightParen): 
      return true
    case (.leftBrace, .leftBrace): 
      return true
    case (.rightBrace, .rightBrace): 
      return true
    case (.leftSquareBracket, .leftSquareBracket): 
      return true
    case (.rightSquareBracket, .rightSquareBracket): 
      return true
    case (.leftAngle, .leftAngle): 
      return true
    case (.rightAngle, .rightAngle): 
      return true
    case (.period, .period): 
      return true
    case (.comma, .comma): 
      return true
    case (.ellipsis, .ellipsis): 
      return true
    case (.colon, .colon): 
      return true
    case (.semicolon, .semicolon): 
      return true
    case (.equal, .equal): 
      return true
    case (.atSign, .atSign): 
      return true
    case (.pound, .pound): 
      return true
    case (.prefixAmpersand, .prefixAmpersand): 
      return true
    case (.arrow, .arrow): 
      return true
    case (.backtick, .backtick): 
      return true
    case (.backslash, .backslash): 
      return true
    case (.exclamationMark, .exclamationMark): 
      return true
    case (.postfixQuestionMark, .postfixQuestionMark): 
      return true
    case (.infixQuestionMark, .infixQuestionMark): 
      return true
    case (.stringQuote, .stringQuote): 
      return true
    case (.singleQuote, .singleQuote): 
      return true
    case (.multilineStringQuote, .multilineStringQuote): 
      return true
    case (.poundSourceLocationKeyword, .poundSourceLocationKeyword): 
      return true
    case (.poundIfKeyword, .poundIfKeyword): 
      return true
    case (.poundElseKeyword, .poundElseKeyword): 
      return true
    case (.poundElseifKeyword, .poundElseifKeyword): 
      return true
    case (.poundEndifKeyword, .poundEndifKeyword): 
      return true
    case (.poundAvailableKeyword, .poundAvailableKeyword): 
      return true
    case (.poundUnavailableKeyword, .poundUnavailableKeyword): 
      return true
    case (.integerLiteral(let lhsText), .integerLiteral(let rhsText)): 
      return lhsText == rhsText
    case (.floatingLiteral(let lhsText), .floatingLiteral(let rhsText)): 
      return lhsText == rhsText
    case (.regexLiteral(let lhsText), .regexLiteral(let rhsText)): 
      return lhsText == rhsText
    case (.unknown(let lhsText), .unknown(let rhsText)): 
      return lhsText == rhsText
    case (.identifier(let lhsText), .identifier(let rhsText)): 
      return lhsText == rhsText
    case (.binaryOperator(let lhsText), .binaryOperator(let rhsText)): 
      return lhsText == rhsText
    case (.postfixOperator(let lhsText), .postfixOperator(let rhsText)): 
      return lhsText == rhsText
    case (.prefixOperator(let lhsText), .prefixOperator(let rhsText)): 
      return lhsText == rhsText
    case (.dollarIdentifier(let lhsText), .dollarIdentifier(let rhsText)): 
      return lhsText == rhsText
    case (.keyword(let lhsText), .keyword(let rhsText)): 
      return lhsText == rhsText
    case (.rawStringDelimiter(let lhsText), .rawStringDelimiter(let rhsText)): 
      return lhsText == rhsText
    case (.stringSegment(let lhsText), .stringSegment(let rhsText)): 
      return lhsText == rhsText
    default: 
      return false
    }
  }
}

// Note: It's important that this enum is marked as having a raw base kind
// because it significantly improves performance when comparing two
// `RawTokenBaseKind` for equality. With the raw value, it compiles down to
// a primitive integer compare, without, it calls into `__derived_enum_equals`.
@frozen // FIXME: Not actually stable, works around a miscompile
public enum RawTokenBaseKind: UInt8, Equatable, Hashable {
  case eof
  
  case wildcard
  
  case leftParen
  
  case rightParen
  
  case leftBrace
  
  case rightBrace
  
  case leftSquareBracket
  
  case rightSquareBracket
  
  case leftAngle
  
  case rightAngle
  
  case period
  
  case comma
  
  case ellipsis
  
  case colon
  
  case semicolon
  
  case equal
  
  case atSign
  
  case pound
  
  case prefixAmpersand
  
  case arrow
  
  case backtick
  
  case backslash
  
  case exclamationMark
  
  case postfixQuestionMark
  
  case infixQuestionMark
  
  case stringQuote
  
  case singleQuote
  
  case multilineStringQuote
  
  case poundSourceLocationKeyword
  
  case poundIfKeyword
  
  case poundElseKeyword
  
  case poundElseifKeyword
  
  case poundEndifKeyword
  
  case poundAvailableKeyword
  
  case poundUnavailableKeyword
  
  case integerLiteral
  
  case floatingLiteral
  
  case regexLiteral
  
  case unknown
  
  case identifier
  
  case binaryOperator
  
  case postfixOperator
  
  case prefixOperator
  
  case dollarIdentifier
  
  case keyword
  
  case rawStringDelimiter
  
  case stringSegment
}

fileprivate extension Keyword {
  static var rawValueZero: Keyword {
    return Keyword(rawValue: 0)!
  }
}

/// Similar to `TokenKind` but without a `String` associated value.
/// Technically, this should be an enum like
/// ```
/// enum RawTokenKind {
///   case eof
///   case associatedtypeKeyword
///   // remaining case from `RawTokenBaseKind`...
///   case keyword(Keyword)
/// }
/// ```
///
/// But modelling it this way has significant performance implications since
/// comparing two `RawTokenKind` calls into `__derived_enum_equals`. It's more
/// effient to model the base kind as an enum with a raw value and store the
/// keyword separately.
///
/// Whenever `base` is not `keyword`, `keyword` should have a raw value
/// of `0`.
@frozen // FIXME: Not actually stable, works around a miscompile
public struct RawTokenKind: Equatable, Hashable {
  public let base: RawTokenBaseKind
  
  public let keyword: Keyword
  
  public init(base: RawTokenBaseKind, keyword: Keyword) {
    assert(base == .keyword || keyword.rawValue == 0)
    self.base = base
    self.keyword = keyword
  }
  
  public static var eof: RawTokenKind {
    return RawTokenKind(base: .eof, keyword: .rawValueZero)
  }
  
  public static var wildcard: RawTokenKind {
    return RawTokenKind(base: .wildcard, keyword: .rawValueZero)
  }
  
  public static var leftParen: RawTokenKind {
    return RawTokenKind(base: .leftParen, keyword: .rawValueZero)
  }
  
  public static var rightParen: RawTokenKind {
    return RawTokenKind(base: .rightParen, keyword: .rawValueZero)
  }
  
  public static var leftBrace: RawTokenKind {
    return RawTokenKind(base: .leftBrace, keyword: .rawValueZero)
  }
  
  public static var rightBrace: RawTokenKind {
    return RawTokenKind(base: .rightBrace, keyword: .rawValueZero)
  }
  
  public static var leftSquareBracket: RawTokenKind {
    return RawTokenKind(base: .leftSquareBracket, keyword: .rawValueZero)
  }
  
  public static var rightSquareBracket: RawTokenKind {
    return RawTokenKind(base: .rightSquareBracket, keyword: .rawValueZero)
  }
  
  public static var leftAngle: RawTokenKind {
    return RawTokenKind(base: .leftAngle, keyword: .rawValueZero)
  }
  
  public static var rightAngle: RawTokenKind {
    return RawTokenKind(base: .rightAngle, keyword: .rawValueZero)
  }
  
  public static var period: RawTokenKind {
    return RawTokenKind(base: .period, keyword: .rawValueZero)
  }
  
  public static var comma: RawTokenKind {
    return RawTokenKind(base: .comma, keyword: .rawValueZero)
  }
  
  public static var ellipsis: RawTokenKind {
    return RawTokenKind(base: .ellipsis, keyword: .rawValueZero)
  }
  
  public static var colon: RawTokenKind {
    return RawTokenKind(base: .colon, keyword: .rawValueZero)
  }
  
  public static var semicolon: RawTokenKind {
    return RawTokenKind(base: .semicolon, keyword: .rawValueZero)
  }
  
  public static var equal: RawTokenKind {
    return RawTokenKind(base: .equal, keyword: .rawValueZero)
  }
  
  public static var atSign: RawTokenKind {
    return RawTokenKind(base: .atSign, keyword: .rawValueZero)
  }
  
  public static var pound: RawTokenKind {
    return RawTokenKind(base: .pound, keyword: .rawValueZero)
  }
  
  public static var prefixAmpersand: RawTokenKind {
    return RawTokenKind(base: .prefixAmpersand, keyword: .rawValueZero)
  }
  
  public static var arrow: RawTokenKind {
    return RawTokenKind(base: .arrow, keyword: .rawValueZero)
  }
  
  public static var backtick: RawTokenKind {
    return RawTokenKind(base: .backtick, keyword: .rawValueZero)
  }
  
  public static var backslash: RawTokenKind {
    return RawTokenKind(base: .backslash, keyword: .rawValueZero)
  }
  
  public static var exclamationMark: RawTokenKind {
    return RawTokenKind(base: .exclamationMark, keyword: .rawValueZero)
  }
  
  public static var postfixQuestionMark: RawTokenKind {
    return RawTokenKind(base: .postfixQuestionMark, keyword: .rawValueZero)
  }
  
  public static var infixQuestionMark: RawTokenKind {
    return RawTokenKind(base: .infixQuestionMark, keyword: .rawValueZero)
  }
  
  public static var stringQuote: RawTokenKind {
    return RawTokenKind(base: .stringQuote, keyword: .rawValueZero)
  }
  
  public static var singleQuote: RawTokenKind {
    return RawTokenKind(base: .singleQuote, keyword: .rawValueZero)
  }
  
  public static var multilineStringQuote: RawTokenKind {
    return RawTokenKind(base: .multilineStringQuote, keyword: .rawValueZero)
  }
  
  public static var poundSourceLocationKeyword: RawTokenKind {
    return RawTokenKind(base: .poundSourceLocationKeyword, keyword: .rawValueZero)
  }
  
  public static var poundIfKeyword: RawTokenKind {
    return RawTokenKind(base: .poundIfKeyword, keyword: .rawValueZero)
  }
  
  public static var poundElseKeyword: RawTokenKind {
    return RawTokenKind(base: .poundElseKeyword, keyword: .rawValueZero)
  }
  
  public static var poundElseifKeyword: RawTokenKind {
    return RawTokenKind(base: .poundElseifKeyword, keyword: .rawValueZero)
  }
  
  public static var poundEndifKeyword: RawTokenKind {
    return RawTokenKind(base: .poundEndifKeyword, keyword: .rawValueZero)
  }
  
  public static var poundAvailableKeyword: RawTokenKind {
    return RawTokenKind(base: .poundAvailableKeyword, keyword: .rawValueZero)
  }
  
  public static var poundUnavailableKeyword: RawTokenKind {
    return RawTokenKind(base: .poundUnavailableKeyword, keyword: .rawValueZero)
  }
  
  public static var integerLiteral: RawTokenKind {
    return RawTokenKind(base: .integerLiteral, keyword: .rawValueZero)
  }
  
  public static var floatingLiteral: RawTokenKind {
    return RawTokenKind(base: .floatingLiteral, keyword: .rawValueZero)
  }
  
  public static var regexLiteral: RawTokenKind {
    return RawTokenKind(base: .regexLiteral, keyword: .rawValueZero)
  }
  
  public static var unknown: RawTokenKind {
    return RawTokenKind(base: .unknown, keyword: .rawValueZero)
  }
  
  public static var identifier: RawTokenKind {
    return RawTokenKind(base: .identifier, keyword: .rawValueZero)
  }
  
  public static var binaryOperator: RawTokenKind {
    return RawTokenKind(base: .binaryOperator, keyword: .rawValueZero)
  }
  
  public static var postfixOperator: RawTokenKind {
    return RawTokenKind(base: .postfixOperator, keyword: .rawValueZero)
  }
  
  public static var prefixOperator: RawTokenKind {
    return RawTokenKind(base: .prefixOperator, keyword: .rawValueZero)
  }
  
  public static var dollarIdentifier: RawTokenKind {
    return RawTokenKind(base: .dollarIdentifier, keyword: .rawValueZero)
  }
  
  public static var rawStringDelimiter: RawTokenKind {
    return RawTokenKind(base: .rawStringDelimiter, keyword: .rawValueZero)
  }
  
  public static var stringSegment: RawTokenKind {
    return RawTokenKind(base: .stringSegment, keyword: .rawValueZero)
  }
  
  public static func keyword(_ keyword: Keyword) -> RawTokenKind {
    return RawTokenKind(base: .keyword, keyword: keyword)
  }
  
  @_spi(RawSyntax)
  public var defaultText: SyntaxText? {
    switch self.base {
    case .eof: 
      return ""
    case .wildcard: 
      return #"_"#
    case .leftParen: 
      return #"("#
    case .rightParen: 
      return #")"#
    case .leftBrace: 
      return #"{"#
    case .rightBrace: 
      return #"}"#
    case .leftSquareBracket: 
      return #"["#
    case .rightSquareBracket: 
      return #"]"#
    case .leftAngle: 
      return #"<"#
    case .rightAngle: 
      return #">"#
    case .period: 
      return #"."#
    case .comma: 
      return #","#
    case .ellipsis: 
      return #"..."#
    case .colon: 
      return #":"#
    case .semicolon: 
      return #";"#
    case .equal: 
      return #"="#
    case .atSign: 
      return #"@"#
    case .pound: 
      return #"#"#
    case .prefixAmpersand: 
      return #"&"#
    case .arrow: 
      return #"->"#
    case .backtick: 
      return #"`"#
    case .backslash: 
      return #"\"#
    case .exclamationMark: 
      return #"!"#
    case .postfixQuestionMark: 
      return #"?"#
    case .infixQuestionMark: 
      return #"?"#
    case .stringQuote: 
      return #"""#
    case .singleQuote: 
      return #"'"#
    case .multilineStringQuote: 
      return #"""""#
    case .poundSourceLocationKeyword: 
      return #"#sourceLocation"#
    case .poundIfKeyword: 
      return #"#if"#
    case .poundElseKeyword: 
      return #"#else"#
    case .poundElseifKeyword: 
      return #"#elseif"#
    case .poundEndifKeyword: 
      return #"#endif"#
    case .poundAvailableKeyword: 
      return #"#available"#
    case .poundUnavailableKeyword: 
      return #"#unavailable"#
    case .keyword: 
      return self.keyword.defaultText
    default: 
      return nil
    }
  }
  
  /// Returns `true` if the token is a Swift punctuator.
  ///
  /// Punctuation tokens generally separate identifiers from each other. For
  /// example, the '<' and '>' characters in a generic parameter list, or the
  /// quote characters in a string literal.
  public var isPunctuation: Bool {
    switch self.base {
    case .eof: 
      return false
    case .wildcard: 
      return false
    case .leftParen: 
      return true
    case .rightParen: 
      return true
    case .leftBrace: 
      return true
    case .rightBrace: 
      return true
    case .leftSquareBracket: 
      return true
    case .rightSquareBracket: 
      return true
    case .leftAngle: 
      return true
    case .rightAngle: 
      return true
    case .period: 
      return true
    case .comma: 
      return true
    case .ellipsis: 
      return true
    case .colon: 
      return true
    case .semicolon: 
      return true
    case .equal: 
      return true
    case .atSign: 
      return true
    case .pound: 
      return true
    case .prefixAmpersand: 
      return true
    case .arrow: 
      return true
    case .backtick: 
      return true
    case .backslash: 
      return true
    case .exclamationMark: 
      return true
    case .postfixQuestionMark: 
      return true
    case .infixQuestionMark: 
      return true
    case .stringQuote: 
      return true
    case .singleQuote: 
      return true
    case .multilineStringQuote: 
      return true
    case .poundSourceLocationKeyword: 
      return false
    case .poundIfKeyword: 
      return false
    case .poundElseKeyword: 
      return false
    case .poundElseifKeyword: 
      return false
    case .poundEndifKeyword: 
      return false
    case .poundAvailableKeyword: 
      return false
    case .poundUnavailableKeyword: 
      return false
    case .integerLiteral: 
      return false
    case .floatingLiteral: 
      return false
    case .regexLiteral: 
      return false
    case .unknown: 
      return false
    case .identifier: 
      return false
    case .binaryOperator: 
      return false
    case .postfixOperator: 
      return false
    case .prefixOperator: 
      return false
    case .dollarIdentifier: 
      return false
    case .keyword: 
      return false
    case .rawStringDelimiter: 
      return false
    case .stringSegment: 
      return false
    }
  }
}

extension TokenKind {
  /// If the `rawKind` has a `defaultText`, `text` can be empty.
  @_spi(RawSyntax)
  public static func fromRaw(kind rawKind: RawTokenKind, text: String) -> TokenKind {
    switch rawKind.base {
    case .eof: 
      return .eof
    case .wildcard: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .wildcard
    case .leftParen: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .leftParen
    case .rightParen: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .rightParen
    case .leftBrace: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .leftBrace
    case .rightBrace: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .rightBrace
    case .leftSquareBracket: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .leftSquareBracket
    case .rightSquareBracket: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .rightSquareBracket
    case .leftAngle: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .leftAngle
    case .rightAngle: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .rightAngle
    case .period: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .period
    case .comma: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .comma
    case .ellipsis: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .ellipsis
    case .colon: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .colon
    case .semicolon: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .semicolon
    case .equal: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .equal
    case .atSign: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .atSign
    case .pound: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .pound
    case .prefixAmpersand: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .prefixAmpersand
    case .arrow: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .arrow
    case .backtick: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .backtick
    case .backslash: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .backslash
    case .exclamationMark: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .exclamationMark
    case .postfixQuestionMark: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .postfixQuestionMark
    case .infixQuestionMark: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .infixQuestionMark
    case .stringQuote: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .stringQuote
    case .singleQuote: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .singleQuote
    case .multilineStringQuote: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .multilineStringQuote
    case .poundSourceLocationKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .poundSourceLocationKeyword
    case .poundIfKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .poundIfKeyword
    case .poundElseKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .poundElseKeyword
    case .poundElseifKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .poundElseifKeyword
    case .poundEndifKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .poundEndifKeyword
    case .poundAvailableKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .poundAvailableKeyword
    case .poundUnavailableKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .poundUnavailableKeyword
    case .integerLiteral: 
      return .integerLiteral(text)
    case .floatingLiteral: 
      return .floatingLiteral(text)
    case .regexLiteral: 
      return .regexLiteral(text)
    case .unknown: 
      return .unknown(text)
    case .identifier: 
      return .identifier(text)
    case .binaryOperator: 
      return .binaryOperator(text)
    case .postfixOperator: 
      return .postfixOperator(text)
    case .prefixOperator: 
      return .prefixOperator(text)
    case .dollarIdentifier: 
      return .dollarIdentifier(text)
    case .keyword: 
      assert(text.isEmpty || String(syntaxText: rawKind.keyword.defaultText) == text)
      return .keyword(rawKind.keyword)
    case .rawStringDelimiter: 
      return .rawStringDelimiter(text)
    case .stringSegment: 
      return .stringSegment(text)
    }
  }
  
  /// Returns the `RawTokenKind` of this `TokenKind` and, if this `TokenKind`
  /// has associated text, the associated text, otherwise `nil`.
  @_spi(RawSyntax)
  public func decomposeToRaw() -> (rawKind: RawTokenKind, string: String?) {
    switch self {
    case .eof: 
      return (.eof, nil)
    case .wildcard: 
      return (.wildcard, nil)
    case .leftParen: 
      return (.leftParen, nil)
    case .rightParen: 
      return (.rightParen, nil)
    case .leftBrace: 
      return (.leftBrace, nil)
    case .rightBrace: 
      return (.rightBrace, nil)
    case .leftSquareBracket: 
      return (.leftSquareBracket, nil)
    case .rightSquareBracket: 
      return (.rightSquareBracket, nil)
    case .leftAngle: 
      return (.leftAngle, nil)
    case .rightAngle: 
      return (.rightAngle, nil)
    case .period: 
      return (.period, nil)
    case .comma: 
      return (.comma, nil)
    case .ellipsis: 
      return (.ellipsis, nil)
    case .colon: 
      return (.colon, nil)
    case .semicolon: 
      return (.semicolon, nil)
    case .equal: 
      return (.equal, nil)
    case .atSign: 
      return (.atSign, nil)
    case .pound: 
      return (.pound, nil)
    case .prefixAmpersand: 
      return (.prefixAmpersand, nil)
    case .arrow: 
      return (.arrow, nil)
    case .backtick: 
      return (.backtick, nil)
    case .backslash: 
      return (.backslash, nil)
    case .exclamationMark: 
      return (.exclamationMark, nil)
    case .postfixQuestionMark: 
      return (.postfixQuestionMark, nil)
    case .infixQuestionMark: 
      return (.infixQuestionMark, nil)
    case .stringQuote: 
      return (.stringQuote, nil)
    case .singleQuote: 
      return (.singleQuote, nil)
    case .multilineStringQuote: 
      return (.multilineStringQuote, nil)
    case .poundSourceLocationKeyword: 
      return (.poundSourceLocationKeyword, nil)
    case .poundIfKeyword: 
      return (.poundIfKeyword, nil)
    case .poundElseKeyword: 
      return (.poundElseKeyword, nil)
    case .poundElseifKeyword: 
      return (.poundElseifKeyword, nil)
    case .poundEndifKeyword: 
      return (.poundEndifKeyword, nil)
    case .poundAvailableKeyword: 
      return (.poundAvailableKeyword, nil)
    case .poundUnavailableKeyword: 
      return (.poundUnavailableKeyword, nil)
    case .integerLiteral(let str): 
      return (.integerLiteral, str)
    case .floatingLiteral(let str): 
      return (.floatingLiteral, str)
    case .regexLiteral(let str): 
      return (.regexLiteral, str)
    case .unknown(let str): 
      return (.unknown, str)
    case .identifier(let str): 
      return (.identifier, str)
    case .binaryOperator(let str): 
      return (.binaryOperator, str)
    case .postfixOperator(let str): 
      return (.postfixOperator, str)
    case .prefixOperator(let str): 
      return (.prefixOperator, str)
    case .dollarIdentifier(let str): 
      return (.dollarIdentifier, str)
    case .keyword(let keyword): 
      return (.keyword(keyword), nil)
    case .rawStringDelimiter(let str): 
      return (.rawStringDelimiter, str)
    case .stringSegment(let str): 
      return (.stringSegment, str)
    }
  }
}
