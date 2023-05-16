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

/// Describes how distinctive a token is for parser recovery. When expecting a
/// token, tokens with a lower token precedence may be skipped and considered
/// unexpected.
enum TokenPrecedence: Comparable {
  /// An unknown token. This is known garbage and should always be allowed to be skipped.
  case unknownToken
  /// Tokens that can be used similar to variable names or literals
  case identifierLike
  /// Keywords and operators that can occur in the middle of an expression
  case exprKeyword
  /// A token that starts a bracketet expression which typically occurs inside
  /// a statement.
  case weakBracketed(closingDelimiter: RawTokenKind)
  /// A punctuator that can occur inside a statement
  case weakPunctuator
  /// The closing delimiter of `weakBracketed`
  case weakBracketClose
  /// Keywords that start a new statement.
  case stmtKeyword
  /// The '{' token because it typically marks the body of a declaration.
  /// `closingDelimiter` must have type `strongPunctuator`
  case openingBrace(closingDelimiter: RawTokenKind)
  /// A punctuator that is a strong indicator that it separates two distinct parts of the source code, like two statements
  case strongPunctuator
  /// The closing delimiter of `strongBracketed`
  case closingBrace
  /// Tokens that start a new declaration
  case declKeyword
  case openingPoundIf
  case closingPoundIf

  /// If the precedence is `weakBracketed` or `strongBracketed`, the closing delimeter of the bracketed group.
  var closingTokenKind: RawTokenKind? {
    switch self {
    case .weakBracketed(closingDelimiter: let closingDelimiter):
      return closingDelimiter
    case .openingBrace(closingDelimiter: let closingDelimiter):
      return closingDelimiter
    case .openingPoundIf:
      return .poundEndifKeyword
    default:
      return nil
    }
  }

  static func < (lhs: TokenPrecedence, rhs: TokenPrecedence) -> Bool {
    func precedence(_ precedence: TokenPrecedence) -> Int {
      /// Should match the order of the cases in the enum.
      switch precedence {
      case .unknownToken:
        return 0
      case .identifierLike:
        return 1
      case .exprKeyword:
        return 2
      case .weakBracketed:
        return 3
      case .weakPunctuator:
        return 4
      case .weakBracketClose:
        return 5
      case .stmtKeyword:
        return 6
      case .strongPunctuator:
        return 7
      case .openingBrace:
        return 8
      case .closingBrace:
        return 9
      case .declKeyword:
        return 10
      case .openingPoundIf:
        return 11
      case .closingPoundIf:
        return 12
      }
    }

    return precedence(lhs) < precedence(rhs)
  }

  /// When expecting a token with `stmtKeyword` precedence or highter, newlines may be skipped to find that token.
  /// For lower precedence groups, we consider newlines the end of the lookahead scope.
  var shouldSkipOverNewlines: Bool {
    return self >= .stmtKeyword
  }

  init(_ lexeme: Lexer.Lexeme) {
    if lexeme.rawTokenKind == .keyword {
      self.init(Keyword(lexeme.tokenText)!)
    } else {
      self.init(nonKeyword: lexeme.rawTokenKind)
    }
  }

  init(nonKeyword tokenKind: RawTokenKind) {
    switch tokenKind {
    case .unknown:
      self = .unknownToken
    // MARK: Identifier like
    case  // Literals
    .floatingLiteral, .integerLiteral,
      // Pound literals
      .poundAvailableKeyword, .poundSourceLocationKeyword, .poundUnavailableKeyword,
      // Identifiers
      .dollarIdentifier, .identifier,
      // '_' can occur in types to replace a type identifier
      .wildcard,
      // String segment, string interpolation anchor, pound, and regex pattern don't really fit anywhere else
      .pound, .stringSegment, .regexLiteralPattern:
      self = .identifierLike

    // MARK: Expr keyword
    case  // Operators can occur inside expressions
    .postfixOperator, .prefixOperator, .binaryOperator:
      // Consider 'any' and 'inout' like a prefix operator to a type and a type is expression-like.
      self = .exprKeyword

    // MARK: Weak bracketet
    case .leftParen:
      self = .weakBracketed(closingDelimiter: .rightParen)
    case .leftSquareBracket:
      self = .weakBracketed(closingDelimiter: .rightSquareBracket)
    case .leftAngle:
      self = .weakBracketed(closingDelimiter: .rightAngle)
    case .multilineStringQuote, .rawStringDelimiter, .singleQuote, .stringQuote,
      .regexSlash, .extendedRegexDelimiter:
      self = .weakBracketed(closingDelimiter: tokenKind)
    case  // Chaining punctuators
    .infixQuestionMark, .period, .postfixQuestionMark, .exclamationMark,
      // Misc
      .atSign, .backslash, .backtick, .colon, .comma, .ellipsis, .equal, .prefixAmpersand:
      self = .weakPunctuator

    // MARK: Weak bracket close
    case  // Weak brackets
    .rightAngle, .rightParen, .rightSquareBracket:
      self = .weakBracketClose

    // MARK: Strong bracketet
    case .leftBrace:
      self = .openingBrace(closingDelimiter: .rightBrace)
    case .poundElseifKeyword, .poundElseKeyword, .poundIfKeyword:
      self = .openingPoundIf

    // MARK: Strong punctuator
    case  // Semicolon separates two statements
    .semicolon,
      // Arrow is a strong indicator in a function type that we are now in the return type
      .arrow,
      // EOF is here because it is a very stong marker and doesn't belong anywhere else
      .eof:
      self = .strongPunctuator

    // MARK: Strong bracket close
    case .rightBrace:
      self = .closingBrace
    case .poundEndifKeyword:
      self = .closingPoundIf
    case .keyword:
      preconditionFailure("RawTokenKind passed to init(nonKeyword:) must not be a keyword")
    }
  }

  init(_ keyword: Keyword) {
    switch keyword {
    // MARK: Identifier like
    case  // Literals
    .Self, .false, .nil, .`self`, .super, .true:
      self = .identifierLike
    // MARK: Expr keyword
    case  // Keywords
    .as, .is, .try,
      // We don't know much about which contextual keyword it is, be conservative an allow considering it as unexpected.
      // Keywords in function types (we should be allowed to skip them inside parenthesis)
      .rethrows, .throws,
      // Consider 'any' and 'inout' like a prefix operator to a type and a type is expression-like.
      //
      // NOTE: We reuse this for inout bindings and choose the higher precedence level of expr keywords
      // so we do not break anything.
      .inout,
      // Consider 'any' and 'inout' like a prefix operator to a type and a type is expression-like.
      .Any,
      // 'where' can only occur in the signature of declarations. Consider the signature expression-like.
      .where,
      // 'in' occurs in closure input/output definitions and for loops. Consider both constructs expression-like.
      .in:
      self = .exprKeyword
    case  // Control-flow constructs
    .defer, .do, .for, .guard, .if, .repeat, .switch, .while,
      // Secondary parts of control-flow constructs
      .case, .catch, .default, .else,
      // Return-like statements
      .break, .continue, .fallthrough, .return, .throw, .yield:
      self = .stmtKeyword
    // MARK: Decl keywords
    case  // Types
    .associatedtype, .class, .enum, .extension, .protocol, .struct, .typealias,
      // Access modifiers
      .fileprivate, .internal, .private, .public, .static,
      // Functions
      .deinit, .func, .`init`, .subscript,
      // Variables
      .let, .var,
      // Operator stuff
      .operator, .precedencegroup,
      // Misc
      .import:
      self = .declKeyword
    default:
      // Treat all keywords that weren't handled above as expression keywords as a fallback option.
      // FIXME: We should assign a token precedence to all keywords
      self = .exprKeyword
    }
  }
}
