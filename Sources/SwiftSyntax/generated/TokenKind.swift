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
// Automatically generated by generate-swift-syntax
// Do not edit directly!
// swift-format-ignore-file

/// Enumerates the kinds of tokens in the Swift language.
public enum TokenKind: Hashable, Sendable {
  case arrow
  case atSign
  case backslash
  case backtick
  case binaryOperator(String)
  case colon
  case comma
  case dollarIdentifier(String)
  case ellipsis
  case endOfFile
  case equal
  case exclamationMark
  case floatLiteral(String)
  case identifier(String)
  case infixQuestionMark
  case integerLiteral(String)
  case keyword(Keyword)
  case leadingBoxCorner
  case leadingBoxJunction
  case leftAngle
  case leftBrace
  case leftParen
  case leftSquare
  case multilineStringQuote
  case period
  case postfixOperator(String)
  case postfixQuestionMark
  case pound
  case poundAvailable
  case poundElse
  case poundElseif
  case poundEndif
  case poundIf
  case poundSourceLocation
  case poundUnavailable
  case prefixAmpersand
  case prefixOperator(String)
  case rawStringPoundDelimiter(String)
  case regexLiteralPattern(String)
  case regexPoundDelimiter(String)
  case regexSlash
  case rightAngle
  case rightBrace
  case rightParen
  case rightSquare
  case semicolon
  case shebang(String)
  case singleQuote
  case stringQuote
  case stringSegment(String)
  case trailingBoxCorner
  case trailingBoxJunction
  case unknown(String)
  case wildcard

  /// The textual representation of this token kind.
  @_spi(Testing)
  public var text: String {
    switch self {
    case .arrow:
      return "->"
    case .atSign:
      return "@"
    case .backslash:
      return #"\"#
    case .backtick:
      return "`"
    case .binaryOperator(let text):
      return text
    case .colon:
      return ":"
    case .comma:
      return ","
    case .dollarIdentifier(let text):
      return text
    case .ellipsis:
      return "..."
    case .endOfFile:
      return ""
    case .equal:
      return "="
    case .exclamationMark:
      return "!"
    case .floatLiteral(let text):
      return text
    case .identifier(let text):
      return text
    case .infixQuestionMark:
      return "?"
    case .integerLiteral(let text):
      return text
    case .keyword(let assoc):
      return String(syntaxText: assoc.defaultText)
    case .leadingBoxCorner:
      return "╗"
    case .leadingBoxJunction:
      return "╣"
    case .leftAngle:
      return "<"
    case .leftBrace:
      return "{"
    case .leftParen:
      return "("
    case .leftSquare:
      return "["
    case .multilineStringQuote:
      return #"""""#
    case .period:
      return "."
    case .postfixOperator(let text):
      return text
    case .postfixQuestionMark:
      return "?"
    case .pound:
      return "#"
    case .poundAvailable:
      return "#available"
    case .poundElse:
      return "#else"
    case .poundElseif:
      return "#elseif"
    case .poundEndif:
      return "#endif"
    case .poundIf:
      return "#if"
    case .poundSourceLocation:
      return "#sourceLocation"
    case .poundUnavailable:
      return "#unavailable"
    case .prefixAmpersand:
      return "&"
    case .prefixOperator(let text):
      return text
    case .rawStringPoundDelimiter(let text):
      return text
    case .regexLiteralPattern(let text):
      return text
    case .regexPoundDelimiter(let text):
      return text
    case .regexSlash:
      return "/"
    case .rightAngle:
      return ">"
    case .rightBrace:
      return "}"
    case .rightParen:
      return ")"
    case .rightSquare:
      return "]"
    case .semicolon:
      return ";"
    case .shebang(let text):
      return text
    case .singleQuote:
      return "'"
    case .stringQuote:
      return #"""#
    case .stringSegment(let text):
      return text
    case .trailingBoxCorner:
      return "╚"
    case .trailingBoxJunction:
      return "╠"
    case .unknown(let text):
      return text
    case .wildcard:
      return "_"
    }
  }

  /// If this token kind always has the same syntax text, that syntax text, otherwise `nil`.
  @_spi(RawSyntax)
  public var defaultText: SyntaxText? {
    switch self {
    case .arrow:
      return "->"
    case .atSign:
      return "@"
    case .backslash:
      return #"\"#
    case .backtick:
      return "`"
    case .colon:
      return ":"
    case .comma:
      return ","
    case .ellipsis:
      return "..."
    case .endOfFile:
      return ""
    case .equal:
      return "="
    case .exclamationMark:
      return "!"
    case .infixQuestionMark:
      return "?"
    case .keyword(let assoc):
      return assoc.defaultText
    case .leadingBoxCorner:
      return "╗"
    case .leadingBoxJunction:
      return "╣"
    case .leftAngle:
      return "<"
    case .leftBrace:
      return "{"
    case .leftParen:
      return "("
    case .leftSquare:
      return "["
    case .multilineStringQuote:
      return #"""""#
    case .period:
      return "."
    case .postfixQuestionMark:
      return "?"
    case .pound:
      return "#"
    case .poundAvailable:
      return "#available"
    case .poundElse:
      return "#else"
    case .poundElseif:
      return "#elseif"
    case .poundEndif:
      return "#endif"
    case .poundIf:
      return "#if"
    case .poundSourceLocation:
      return "#sourceLocation"
    case .poundUnavailable:
      return "#unavailable"
    case .prefixAmpersand:
      return "&"
    case .regexSlash:
      return "/"
    case .rightAngle:
      return ">"
    case .rightBrace:
      return "}"
    case .rightParen:
      return ")"
    case .rightSquare:
      return "]"
    case .semicolon:
      return ";"
    case .singleQuote:
      return "'"
    case .stringQuote:
      return #"""#
    case .trailingBoxCorner:
      return "╚"
    case .trailingBoxJunction:
      return "╠"
    case .wildcard:
      return "_"
    default:
      return ""
    }
  }

  /// Returns `true` if the token is a Swift punctuator.
  ///
  /// Punctuation tokens generally separate identifiers from each other. For
  /// example, the '<' and '>' characters in a generic parameter list, or the
  /// quote characters in a string literal.
  public var isPunctuation: Bool {
    switch self {
    case .arrow:
      return true
    case .atSign:
      return true
    case .backslash:
      return true
    case .backtick:
      return true
    case .binaryOperator:
      return false
    case .colon:
      return true
    case .comma:
      return true
    case .dollarIdentifier:
      return false
    case .ellipsis:
      return true
    case .endOfFile:
      return false
    case .equal:
      return true
    case .exclamationMark:
      return true
    case .floatLiteral:
      return false
    case .identifier:
      return false
    case .infixQuestionMark:
      return true
    case .integerLiteral:
      return false
    case .keyword:
      return false
    case .leadingBoxCorner:
      return true
    case .leadingBoxJunction:
      return true
    case .leftAngle:
      return true
    case .leftBrace:
      return true
    case .leftParen:
      return true
    case .leftSquare:
      return true
    case .multilineStringQuote:
      return true
    case .period:
      return true
    case .postfixOperator:
      return false
    case .postfixQuestionMark:
      return true
    case .pound:
      return true
    case .poundAvailable:
      return false
    case .poundElse:
      return false
    case .poundElseif:
      return false
    case .poundEndif:
      return false
    case .poundIf:
      return false
    case .poundSourceLocation:
      return false
    case .poundUnavailable:
      return false
    case .prefixAmpersand:
      return true
    case .prefixOperator:
      return false
    case .rawStringPoundDelimiter:
      return false
    case .regexLiteralPattern:
      return false
    case .regexPoundDelimiter:
      return false
    case .regexSlash:
      return true
    case .rightAngle:
      return true
    case .rightBrace:
      return true
    case .rightParen:
      return true
    case .rightSquare:
      return true
    case .semicolon:
      return true
    case .shebang:
      return false
    case .singleQuote:
      return true
    case .stringQuote:
      return true
    case .stringSegment:
      return false
    case .trailingBoxCorner:
      return true
    case .trailingBoxJunction:
      return true
    case .unknown:
      return false
    case .wildcard:
      return false
    }
  }
}

extension TokenKind: Equatable {
  public static func == (lhs: TokenKind, rhs: TokenKind) -> Bool {
    switch (lhs, rhs) {
    case (.arrow, .arrow):
      return true
    case (.atSign, .atSign):
      return true
    case (.backslash, .backslash):
      return true
    case (.backtick, .backtick):
      return true
    case (.binaryOperator(let lhsText), .binaryOperator(let rhsText)):
      return lhsText == rhsText
    case (.colon, .colon):
      return true
    case (.comma, .comma):
      return true
    case (.dollarIdentifier(let lhsText), .dollarIdentifier(let rhsText)):
      return lhsText == rhsText
    case (.ellipsis, .ellipsis):
      return true
    case (.endOfFile, .endOfFile):
      return true
    case (.equal, .equal):
      return true
    case (.exclamationMark, .exclamationMark):
      return true
    case (.floatLiteral(let lhsText), .floatLiteral(let rhsText)):
      return lhsText == rhsText
    case (.identifier(let lhsText), .identifier(let rhsText)):
      return lhsText == rhsText
    case (.infixQuestionMark, .infixQuestionMark):
      return true
    case (.integerLiteral(let lhsText), .integerLiteral(let rhsText)):
      return lhsText == rhsText
    case (.keyword(let lhsText), .keyword(let rhsText)):
      return lhsText == rhsText
    case (.leadingBoxCorner, .leadingBoxCorner):
      return true
    case (.leadingBoxJunction, .leadingBoxJunction):
      return true
    case (.leftAngle, .leftAngle):
      return true
    case (.leftBrace, .leftBrace):
      return true
    case (.leftParen, .leftParen):
      return true
    case (.leftSquare, .leftSquare):
      return true
    case (.multilineStringQuote, .multilineStringQuote):
      return true
    case (.period, .period):
      return true
    case (.postfixOperator(let lhsText), .postfixOperator(let rhsText)):
      return lhsText == rhsText
    case (.postfixQuestionMark, .postfixQuestionMark):
      return true
    case (.pound, .pound):
      return true
    case (.poundAvailable, .poundAvailable):
      return true
    case (.poundElse, .poundElse):
      return true
    case (.poundElseif, .poundElseif):
      return true
    case (.poundEndif, .poundEndif):
      return true
    case (.poundIf, .poundIf):
      return true
    case (.poundSourceLocation, .poundSourceLocation):
      return true
    case (.poundUnavailable, .poundUnavailable):
      return true
    case (.prefixAmpersand, .prefixAmpersand):
      return true
    case (.prefixOperator(let lhsText), .prefixOperator(let rhsText)):
      return lhsText == rhsText
    case (.rawStringPoundDelimiter(let lhsText), .rawStringPoundDelimiter(let rhsText)):
      return lhsText == rhsText
    case (.regexLiteralPattern(let lhsText), .regexLiteralPattern(let rhsText)):
      return lhsText == rhsText
    case (.regexPoundDelimiter(let lhsText), .regexPoundDelimiter(let rhsText)):
      return lhsText == rhsText
    case (.regexSlash, .regexSlash):
      return true
    case (.rightAngle, .rightAngle):
      return true
    case (.rightBrace, .rightBrace):
      return true
    case (.rightParen, .rightParen):
      return true
    case (.rightSquare, .rightSquare):
      return true
    case (.semicolon, .semicolon):
      return true
    case (.shebang(let lhsText), .shebang(let rhsText)):
      return lhsText == rhsText
    case (.singleQuote, .singleQuote):
      return true
    case (.stringQuote, .stringQuote):
      return true
    case (.stringSegment(let lhsText), .stringSegment(let rhsText)):
      return lhsText == rhsText
    case (.trailingBoxCorner, .trailingBoxCorner):
      return true
    case (.trailingBoxJunction, .trailingBoxJunction):
      return true
    case (.unknown(let lhsText), .unknown(let rhsText)):
      return lhsText == rhsText
    case (.wildcard, .wildcard):
      return true
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
@_spi(RawSyntax)
public enum RawTokenKind: UInt8, Equatable, Hashable {
  case arrow
  case atSign
  case backslash
  case backtick
  case binaryOperator
  case colon
  case comma
  case dollarIdentifier
  case ellipsis
  case endOfFile
  case equal
  case exclamationMark
  case floatLiteral
  case identifier
  case infixQuestionMark
  case integerLiteral
  case keyword
  case leadingBoxCorner
  case leadingBoxJunction
  case leftAngle
  case leftBrace
  case leftParen
  case leftSquare
  case multilineStringQuote
  case period
  case postfixOperator
  case postfixQuestionMark
  case pound
  case poundAvailable
  case poundElse
  case poundElseif
  case poundEndif
  case poundIf
  case poundSourceLocation
  case poundUnavailable
  case prefixAmpersand
  case prefixOperator
  case rawStringPoundDelimiter
  case regexLiteralPattern
  case regexPoundDelimiter
  case regexSlash
  case rightAngle
  case rightBrace
  case rightParen
  case rightSquare
  case semicolon
  case shebang
  case singleQuote
  case stringQuote
  case stringSegment
  case trailingBoxCorner
  case trailingBoxJunction
  case unknown
  case wildcard

  @_spi(RawSyntax)
  public var defaultText: SyntaxText? {
    switch self {
    case .arrow:
      return "->"
    case .atSign:
      return "@"
    case .backslash:
      return #"\"#
    case .backtick:
      return "`"
    case .colon:
      return ":"
    case .comma:
      return ","
    case .ellipsis:
      return "..."
    case .endOfFile:
      return ""
    case .equal:
      return "="
    case .exclamationMark:
      return "!"
    case .infixQuestionMark:
      return "?"
    case .leadingBoxCorner:
      return "╗"
    case .leadingBoxJunction:
      return "╣"
    case .leftAngle:
      return "<"
    case .leftBrace:
      return "{"
    case .leftParen:
      return "("
    case .leftSquare:
      return "["
    case .multilineStringQuote:
      return #"""""#
    case .period:
      return "."
    case .postfixQuestionMark:
      return "?"
    case .pound:
      return "#"
    case .poundAvailable:
      return "#available"
    case .poundElse:
      return "#else"
    case .poundElseif:
      return "#elseif"
    case .poundEndif:
      return "#endif"
    case .poundIf:
      return "#if"
    case .poundSourceLocation:
      return "#sourceLocation"
    case .poundUnavailable:
      return "#unavailable"
    case .prefixAmpersand:
      return "&"
    case .regexSlash:
      return "/"
    case .rightAngle:
      return ">"
    case .rightBrace:
      return "}"
    case .rightParen:
      return ")"
    case .rightSquare:
      return "]"
    case .semicolon:
      return ";"
    case .singleQuote:
      return "'"
    case .stringQuote:
      return #"""#
    case .trailingBoxCorner:
      return "╚"
    case .trailingBoxJunction:
      return "╠"
    case .wildcard:
      return "_"
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
    switch self {
    case .arrow:
      return true
    case .atSign:
      return true
    case .backslash:
      return true
    case .backtick:
      return true
    case .binaryOperator:
      return false
    case .colon:
      return true
    case .comma:
      return true
    case .dollarIdentifier:
      return false
    case .ellipsis:
      return true
    case .endOfFile:
      return false
    case .equal:
      return true
    case .exclamationMark:
      return true
    case .floatLiteral:
      return false
    case .identifier:
      return false
    case .infixQuestionMark:
      return true
    case .integerLiteral:
      return false
    case .keyword:
      return false
    case .leadingBoxCorner:
      return true
    case .leadingBoxJunction:
      return true
    case .leftAngle:
      return true
    case .leftBrace:
      return true
    case .leftParen:
      return true
    case .leftSquare:
      return true
    case .multilineStringQuote:
      return true
    case .period:
      return true
    case .postfixOperator:
      return false
    case .postfixQuestionMark:
      return true
    case .pound:
      return true
    case .poundAvailable:
      return false
    case .poundElse:
      return false
    case .poundElseif:
      return false
    case .poundEndif:
      return false
    case .poundIf:
      return false
    case .poundSourceLocation:
      return false
    case .poundUnavailable:
      return false
    case .prefixAmpersand:
      return true
    case .prefixOperator:
      return false
    case .rawStringPoundDelimiter:
      return false
    case .regexLiteralPattern:
      return false
    case .regexPoundDelimiter:
      return false
    case .regexSlash:
      return true
    case .rightAngle:
      return true
    case .rightBrace:
      return true
    case .rightParen:
      return true
    case .rightSquare:
      return true
    case .semicolon:
      return true
    case .shebang:
      return false
    case .singleQuote:
      return true
    case .stringQuote:
      return true
    case .stringSegment:
      return false
    case .trailingBoxCorner:
      return true
    case .trailingBoxJunction:
      return true
    case .unknown:
      return false
    case .wildcard:
      return false
    }
  }
}

extension TokenKind {
  /// If the `rawKind` has a `defaultText`, `text` can be empty.
  @_spi(RawSyntax)
  public static func fromRaw(kind rawKind: RawTokenKind, text: String) -> TokenKind {
    switch rawKind {
    case .arrow:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .arrow
    case .atSign:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .atSign
    case .backslash:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .backslash
    case .backtick:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .backtick
    case .binaryOperator:
      return .binaryOperator(text)
    case .colon:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .colon
    case .comma:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .comma
    case .dollarIdentifier:
      return .dollarIdentifier(text)
    case .ellipsis:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .ellipsis
    case .endOfFile:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .endOfFile
    case .equal:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .equal
    case .exclamationMark:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .exclamationMark
    case .floatLiteral:
      return .floatLiteral(text)
    case .identifier:
      return .identifier(text)
    case .infixQuestionMark:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .infixQuestionMark
    case .integerLiteral:
      return .integerLiteral(text)
    case .keyword:
      var text = text
      return text.withSyntaxText { text in
        return .keyword(Keyword(text)!)
      }
    case .leadingBoxCorner:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .leadingBoxCorner
    case .leadingBoxJunction:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .leadingBoxJunction
    case .leftAngle:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .leftAngle
    case .leftBrace:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .leftBrace
    case .leftParen:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .leftParen
    case .leftSquare:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .leftSquare
    case .multilineStringQuote:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .multilineStringQuote
    case .period:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .period
    case .postfixOperator:
      return .postfixOperator(text)
    case .postfixQuestionMark:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .postfixQuestionMark
    case .pound:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .pound
    case .poundAvailable:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .poundAvailable
    case .poundElse:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .poundElse
    case .poundElseif:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .poundElseif
    case .poundEndif:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .poundEndif
    case .poundIf:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .poundIf
    case .poundSourceLocation:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .poundSourceLocation
    case .poundUnavailable:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .poundUnavailable
    case .prefixAmpersand:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .prefixAmpersand
    case .prefixOperator:
      return .prefixOperator(text)
    case .rawStringPoundDelimiter:
      return .rawStringPoundDelimiter(text)
    case .regexLiteralPattern:
      return .regexLiteralPattern(text)
    case .regexPoundDelimiter:
      return .regexPoundDelimiter(text)
    case .regexSlash:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .regexSlash
    case .rightAngle:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .rightAngle
    case .rightBrace:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .rightBrace
    case .rightParen:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .rightParen
    case .rightSquare:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .rightSquare
    case .semicolon:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .semicolon
    case .shebang:
      return .shebang(text)
    case .singleQuote:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .singleQuote
    case .stringQuote:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .stringQuote
    case .stringSegment:
      return .stringSegment(text)
    case .trailingBoxCorner:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .trailingBoxCorner
    case .trailingBoxJunction:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .trailingBoxJunction
    case .unknown:
      return .unknown(text)
    case .wildcard:
      precondition(text.isEmpty || rawKind.defaultText.map(String.init) == text)
      return .wildcard
    }
  }

  /// Returns the ``RawTokenKind`` of this ``TokenKind`` and, if this ``TokenKind``
  /// has associated text, the associated text, otherwise `nil`.
  @_spi(RawSyntax)
  public func decomposeToRaw() -> (rawKind: RawTokenKind, string: String?) {
    switch self {
    case .arrow:
      return (.arrow, nil)
    case .atSign:
      return (.atSign, nil)
    case .backslash:
      return (.backslash, nil)
    case .backtick:
      return (.backtick, nil)
    case .binaryOperator(let str):
      return (.binaryOperator, str)
    case .colon:
      return (.colon, nil)
    case .comma:
      return (.comma, nil)
    case .dollarIdentifier(let str):
      return (.dollarIdentifier, str)
    case .ellipsis:
      return (.ellipsis, nil)
    case .endOfFile:
      return (.endOfFile, nil)
    case .equal:
      return (.equal, nil)
    case .exclamationMark:
      return (.exclamationMark, nil)
    case .floatLiteral(let str):
      return (.floatLiteral, str)
    case .identifier(let str):
      return (.identifier, str)
    case .infixQuestionMark:
      return (.infixQuestionMark, nil)
    case .integerLiteral(let str):
      return (.integerLiteral, str)
    case .keyword(let keyword):
      return (.keyword, String(syntaxText: keyword.defaultText))
    case .leadingBoxCorner:
      return (.leadingBoxCorner, nil)
    case .leadingBoxJunction:
      return (.leadingBoxJunction, nil)
    case .leftAngle:
      return (.leftAngle, nil)
    case .leftBrace:
      return (.leftBrace, nil)
    case .leftParen:
      return (.leftParen, nil)
    case .leftSquare:
      return (.leftSquare, nil)
    case .multilineStringQuote:
      return (.multilineStringQuote, nil)
    case .period:
      return (.period, nil)
    case .postfixOperator(let str):
      return (.postfixOperator, str)
    case .postfixQuestionMark:
      return (.postfixQuestionMark, nil)
    case .pound:
      return (.pound, nil)
    case .poundAvailable:
      return (.poundAvailable, nil)
    case .poundElse:
      return (.poundElse, nil)
    case .poundElseif:
      return (.poundElseif, nil)
    case .poundEndif:
      return (.poundEndif, nil)
    case .poundIf:
      return (.poundIf, nil)
    case .poundSourceLocation:
      return (.poundSourceLocation, nil)
    case .poundUnavailable:
      return (.poundUnavailable, nil)
    case .prefixAmpersand:
      return (.prefixAmpersand, nil)
    case .prefixOperator(let str):
      return (.prefixOperator, str)
    case .rawStringPoundDelimiter(let str):
      return (.rawStringPoundDelimiter, str)
    case .regexLiteralPattern(let str):
      return (.regexLiteralPattern, str)
    case .regexPoundDelimiter(let str):
      return (.regexPoundDelimiter, str)
    case .regexSlash:
      return (.regexSlash, nil)
    case .rightAngle:
      return (.rightAngle, nil)
    case .rightBrace:
      return (.rightBrace, nil)
    case .rightParen:
      return (.rightParen, nil)
    case .rightSquare:
      return (.rightSquare, nil)
    case .semicolon:
      return (.semicolon, nil)
    case .shebang(let str):
      return (.shebang, str)
    case .singleQuote:
      return (.singleQuote, nil)
    case .stringQuote:
      return (.stringQuote, nil)
    case .stringSegment(let str):
      return (.stringSegment, str)
    case .trailingBoxCorner:
      return (.trailingBoxCorner, nil)
    case .trailingBoxJunction:
      return (.trailingBoxJunction, nil)
    case .unknown(let str):
      return (.unknown, str)
    case .wildcard:
      return (.wildcard, nil)
    }
  }
}
