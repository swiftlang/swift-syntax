//===--- TokenPrecedence.swift --------------------------------------------===//
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

import SwiftSyntax

/// Describes how distinctive a token is for parser recovery. When expecting a
/// token, tokens with a lower token precedence may be skipped and considered
/// unexpected.
public enum TokenPrecedence: Comparable {
  /// Tokens that can be used similar to variable names or literals
  case identifierLike
  /// Keywords and operators that can occur in the middle of an expression
  case exprKeyword
  /// A token that starts a bracketet expression which typically occurs inside
  /// a statement.
  /// `closingDelimiter` must have precedence `weakPunctuator` or `weakBracketed`
  case weakBracketed(closingDelimiter: RawTokenKind)
  /// A punctuator that can occur inside a statement
  case weakPunctuator
  /// Keywords that start a new statement.
  case stmtKeyword
  /// A punctuator that is a strong indicator that it separates two distinct parts of the source code, like two statements
  case strongPunctuator
  /// The '{' token because it typically marks the body of a declaration.
  /// `closingDelimiter` must have type `strongPunctuator`
  case strongBracketet(closingDelimiter: RawTokenKind)
  /// Tokens that start a new declaration
  case declKeyword

  /// If the precedence is `weakBracketed` or `strongBracketed`, the closing delimeter of the bracketed group.
  var closingTokenKind: RawTokenKind? {
    switch self {
    case .weakBracketed(closingDelimiter: let closingDelimiter):
      return closingDelimiter
    case .strongBracketet(closingDelimiter: let closingDelimiter):
      return closingDelimiter
    default:
      return nil
    }
  }

  public static func < (lhs: TokenPrecedence, rhs: TokenPrecedence) -> Bool {
    func precedence(_ precedence: TokenPrecedence) -> Int {
      /// Should match the order of the cases in the enum.
      switch precedence {
      case .identifierLike:
        return 0
      case .exprKeyword:
        return 1
      case .weakBracketed:
        return 2
      case .weakPunctuator:
        return 3
      case .stmtKeyword:
        return 4
      case .strongPunctuator:
        return 5
      case .strongBracketet:
        return 6
      case .declKeyword:
        return 7
      }
    }

    return precedence(lhs) < precedence(rhs)
  }

  /// When expecting a token with `stmtKeyword` precedence or highter, newlines may be skipped to find that token.
  /// For lower precedence groups, we consider newlines the end of the lookahead scope.
  var shouldSkipOverNewlines: Bool {
    return self >= .stmtKeyword
  }

  init(_ tokenKind: RawTokenKind) {
    switch tokenKind {
      // MARK: Identifier like
    case
      // Literals
        .capitalSelfKeyword, .falseKeyword, .floatingLiteral, .integerLiteral, .nilKeyword, .regexLiteral, .selfKeyword, .stringLiteral, .superKeyword, .trueKeyword,
      // Legacy literals
        .__column__Keyword, .__dso_handle__Keyword, .__file__Keyword, .__function__Keyword, .__line__Keyword,
      // Pound literals
        .poundAssertKeyword, .poundAvailableKeyword, .poundColorLiteralKeyword, .poundColumnKeyword, .poundDsohandleKeyword, .poundFileIDKeyword, .poundFileKeyword, .poundFileLiteralKeyword, .poundFilePathKeyword, .poundFunctionKeyword, .poundImageLiteralKeyword, .poundKeyPathKeyword, .poundLineKeyword, .poundSelectorKeyword, .poundSourceLocationKeyword, .poundUnavailableKeyword,
      // Identifiers
        .dollarIdentifier, .identifier,
      // '_' can occur in types to replace a type identifier
        .wildcardKeyword,
      // String segment, string interpolation anchor and pound don't really fit anywhere else
        .pound, .stringInterpolationAnchor, .stringSegment,
      // Give unknown tokens the lowest priority to eat it as unexpected if necessary
        .unknown:
      self = .identifierLike

      // MARK: Expr keyword
    case
      // Keywords
        .asKeyword, .isKeyword, .tryKeyword,
      // We don't know much about which contextual keyword it is, be conservative an allow considering it as unexpected.
        .contextualKeyword,
      // Keywords in function types (we should be allowed to skip them inside parenthesis)
        .rethrowsKeyword, .throwsKeyword,
      // Operators can occur inside expressions
        .postfixOperator, .prefixOperator, .spacedBinaryOperator, .unspacedBinaryOperator,
      // Consider 'any' and 'inout' like a prefix operator to a type and a type is expression-like.
        .anyKeyword, .inoutKeyword,
      // 'where' can only occur in the signature of declarations. Consider the signature expression-like.
        .whereKeyword,
      // 'in' occurs in closure input/output definitions and for loops. Consider both constructs expression-like.
        .inKeyword:
      self = .exprKeyword

      // MARK: Weak bracketet
    case .leftParen:
      self = .weakBracketed(closingDelimiter: .rightParen)
    case .leftSquareBracket:
      self = .weakBracketed(closingDelimiter: .rightSquareBracket)
    case .leftAngle:
      self = .weakBracketed(closingDelimiter: .rightAngle)
    case .multilineStringQuote, .rawStringDelimiter, .singleQuote, .stringQuote:
      self = .weakBracketed(closingDelimiter: tokenKind)
    case
      // Chaining punctuators
        .infixQuestionMark, .period, .postfixQuestionMark, .prefixPeriod,.exclamationMark,
      // Misc
        .backslash, .backtick, .colon, .comma, .ellipsis, .equal, .prefixAmpersand,
      // Weak brackets
        .rightAngle, .rightParen, .rightSquareBracket:
      self = .weakPunctuator

      // MARK: Statement keyword punctuator
    case
      // Control-flow constructs
        .deferKeyword, .doKeyword, .forKeyword, .guardKeyword, .ifKeyword, .repeatKeyword, .switchKeyword, .whileKeyword,
      // Secondary parts of control-flow constructs
        .caseKeyword, .catchKeyword, .defaultKeyword, .elseKeyword,
      // Return-like statements
        .breakKeyword, .continueKeyword, .fallthroughKeyword, .returnKeyword, .throwKeyword, .yield,
      // Misc
        .importKeyword,
      // #error and #warning are statement-like
        .poundErrorKeyword, .poundWarningKeyword:
      self = .stmtKeyword

      // MARK: Strong bracketet
    case .leftBrace:
      self = .strongBracketet(closingDelimiter: .rightBrace)
    case .poundElseifKeyword, .poundElseKeyword, .poundIfKeyword:
      self = .strongBracketet(closingDelimiter: .poundEndifKeyword)

      // MARK: Strong punctuator
    case
      // Semicolon separates two statements
        .semicolon,
      // Arrow is a strong indicator in a function type that we are now in the return type
        .arrow,
      // '@' typically occurs at the start of declarations
        .atSign,
      // Match the '}' and '#endif' as strongBracketet
        .poundEndifKeyword, .rightBrace,
      // EOF is here because it is a very stong marker and doesn't belong anywhere else
        .eof:
      self = .strongPunctuator

      // MARK: Decl keywords
    case
      // Types
        .associatedtypeKeyword, .classKeyword, .enumKeyword, .extensionKeyword, .protocolKeyword, .structKeyword, .typealiasKeyword,
      // Access modifiers
        .fileprivateKeyword, .internalKeyword, .privateKeyword, .publicKeyword, .staticKeyword,
      // Functions
        .deinitKeyword, .funcKeyword, .initKeyword, .subscriptKeyword,
      // Variables
        .letKeyword, .varKeyword,
      // Operator stuff
        .operatorKeyword, .precedencegroupKeyword:
      self = .declKeyword
    }
  }
}
