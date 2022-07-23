//// Automatically Generated From TokenKind.swift.gyb.
//// Do Not Edit Directly!
//===----------------- TokenKind.swift - Token Kind Enum ------------------===//
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

/// Enumerates the kinds of tokens in the Swift language.
public enum TokenKind: UInt16 {
  case eof
  case associatedtypeKeyword
  case classKeyword
  case deinitKeyword
  case enumKeyword
  case extensionKeyword
  case funcKeyword
  case importKeyword
  case initKeyword
  case inoutKeyword
  case letKeyword
  case operatorKeyword
  case precedencegroupKeyword
  case protocolKeyword
  case structKeyword
  case subscriptKeyword
  case typealiasKeyword
  case varKeyword
  case fileprivateKeyword
  case internalKeyword
  case privateKeyword
  case publicKeyword
  case staticKeyword
  case deferKeyword
  case ifKeyword
  case guardKeyword
  case doKeyword
  case repeatKeyword
  case elseKeyword
  case forKeyword
  case inKeyword
  case whileKeyword
  case returnKeyword
  case breakKeyword
  case continueKeyword
  case fallthroughKeyword
  case switchKeyword
  case caseKeyword
  case defaultKeyword
  case whereKeyword
  case catchKeyword
  case throwKeyword
  case asKeyword
  case anyKeyword
  case falseKeyword
  case isKeyword
  case nilKeyword
  case rethrowsKeyword
  case superKeyword
  case selfKeyword
  case capitalSelfKeyword
  case trueKeyword
  case tryKeyword
  case throwsKeyword
  case __file__Keyword
  case __line__Keyword
  case __column__Keyword
  case __function__Keyword
  case __dso_handle__Keyword
  case wildcardKeyword
  case leftParen
  case rightParen
  case leftBrace
  case rightBrace
  case leftSquareBracket
  case rightSquareBracket
  case leftAngle
  case rightAngle
  case period
  case prefixPeriod
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
  case poundKeyPathKeyword
  case poundLineKeyword
  case poundSelectorKeyword
  case poundFileKeyword
  case poundFileIDKeyword
  case poundFilePathKeyword
  case poundColumnKeyword
  case poundFunctionKeyword
  case poundDsohandleKeyword
  case poundAssertKeyword
  case poundSourceLocationKeyword
  case poundWarningKeyword
  case poundErrorKeyword
  case poundIfKeyword
  case poundElseKeyword
  case poundElseifKeyword
  case poundEndifKeyword
  case poundAvailableKeyword
  case poundUnavailableKeyword
  case poundFileLiteralKeyword
  case poundImageLiteralKeyword
  case poundColorLiteralKeyword
  case integerLiteral
  case floatingLiteral
  case stringLiteral
  case regexLiteral
  case unknown
  case identifier
  case unspacedBinaryOperator
  case spacedBinaryOperator
  case postfixOperator
  case prefixOperator
  case dollarIdentifier
  case contextualKeyword
  case rawStringDelimiter
  case stringSegment
  case stringInterpolationAnchor
  case yield

  /// Initializes a keyword token kind from its string representation. If the
  /// given string is not a keyword, this function returns `nil`.
  public init?(keyword: StringRef) {
    switch keyword {
    case "associatedtype": self = .associatedtypeKeyword
    case "class": self = .classKeyword
    case "deinit": self = .deinitKeyword
    case "enum": self = .enumKeyword
    case "extension": self = .extensionKeyword
    case "func": self = .funcKeyword
    case "import": self = .importKeyword
    case "init": self = .initKeyword
    case "inout": self = .inoutKeyword
    case "let": self = .letKeyword
    case "operator": self = .operatorKeyword
    case "precedencegroup": self = .precedencegroupKeyword
    case "protocol": self = .protocolKeyword
    case "struct": self = .structKeyword
    case "subscript": self = .subscriptKeyword
    case "typealias": self = .typealiasKeyword
    case "var": self = .varKeyword
    case "fileprivate": self = .fileprivateKeyword
    case "internal": self = .internalKeyword
    case "private": self = .privateKeyword
    case "public": self = .publicKeyword
    case "static": self = .staticKeyword
    case "defer": self = .deferKeyword
    case "if": self = .ifKeyword
    case "guard": self = .guardKeyword
    case "do": self = .doKeyword
    case "repeat": self = .repeatKeyword
    case "else": self = .elseKeyword
    case "for": self = .forKeyword
    case "in": self = .inKeyword
    case "while": self = .whileKeyword
    case "return": self = .returnKeyword
    case "break": self = .breakKeyword
    case "continue": self = .continueKeyword
    case "fallthrough": self = .fallthroughKeyword
    case "switch": self = .switchKeyword
    case "case": self = .caseKeyword
    case "default": self = .defaultKeyword
    case "where": self = .whereKeyword
    case "catch": self = .catchKeyword
    case "throw": self = .throwKeyword
    case "as": self = .asKeyword
    case "Any": self = .anyKeyword
    case "false": self = .falseKeyword
    case "is": self = .isKeyword
    case "nil": self = .nilKeyword
    case "rethrows": self = .rethrowsKeyword
    case "super": self = .superKeyword
    case "self": self = .selfKeyword
    case "Self": self = .capitalSelfKeyword
    case "true": self = .trueKeyword
    case "try": self = .tryKeyword
    case "throws": self = .throwsKeyword
    case "__FILE__": self = .__file__Keyword
    case "__LINE__": self = .__line__Keyword
    case "__COLUMN__": self = .__column__Keyword
    case "__FUNCTION__": self = .__function__Keyword
    case "__DSO_HANDLE__": self = .__dso_handle__Keyword
    case "_": self = .wildcardKeyword
    case "#keyPath": self = .poundKeyPathKeyword
    case "#line": self = .poundLineKeyword
    case "#selector": self = .poundSelectorKeyword
    case "#file": self = .poundFileKeyword
    case "#fileID": self = .poundFileIDKeyword
    case "#filePath": self = .poundFilePathKeyword
    case "#column": self = .poundColumnKeyword
    case "#function": self = .poundFunctionKeyword
    case "#dsohandle": self = .poundDsohandleKeyword
    case "#assert": self = .poundAssertKeyword
    case "#sourceLocation": self = .poundSourceLocationKeyword
    case "#warning": self = .poundWarningKeyword
    case "#error": self = .poundErrorKeyword
    case "#if": self = .poundIfKeyword
    case "#else": self = .poundElseKeyword
    case "#elseif": self = .poundElseifKeyword
    case "#endif": self = .poundEndifKeyword
    case "#available": self = .poundAvailableKeyword
    case "#unavailable": self = .poundUnavailableKeyword
    case "#fileLiteral": self = .poundFileLiteralKeyword
    case "#imageLiteral": self = .poundImageLiteralKeyword
    case "#colorLiteral": self = .poundColorLiteralKeyword
    default:
      return nil
    }
  }

  /// Returns `true` if the token is a Swift keyword.
  ///
  /// Keywords are reserved unconditionally for use by Swift and may not
  /// appear as identifiers in any position without being escaped. For example,
  /// `class`, `func`, or `import`.
  public var isKeyword: Bool {
    switch self {
    case .eof: return false
    case .associatedtypeKeyword: return true
    case .classKeyword: return true
    case .deinitKeyword: return true
    case .enumKeyword: return true
    case .extensionKeyword: return true
    case .funcKeyword: return true
    case .importKeyword: return true
    case .initKeyword: return true
    case .inoutKeyword: return true
    case .letKeyword: return true
    case .operatorKeyword: return true
    case .precedencegroupKeyword: return true
    case .protocolKeyword: return true
    case .structKeyword: return true
    case .subscriptKeyword: return true
    case .typealiasKeyword: return true
    case .varKeyword: return true
    case .fileprivateKeyword: return true
    case .internalKeyword: return true
    case .privateKeyword: return true
    case .publicKeyword: return true
    case .staticKeyword: return true
    case .deferKeyword: return true
    case .ifKeyword: return true
    case .guardKeyword: return true
    case .doKeyword: return true
    case .repeatKeyword: return true
    case .elseKeyword: return true
    case .forKeyword: return true
    case .inKeyword: return true
    case .whileKeyword: return true
    case .returnKeyword: return true
    case .breakKeyword: return true
    case .continueKeyword: return true
    case .fallthroughKeyword: return true
    case .switchKeyword: return true
    case .caseKeyword: return true
    case .defaultKeyword: return true
    case .whereKeyword: return true
    case .catchKeyword: return true
    case .throwKeyword: return true
    case .asKeyword: return true
    case .anyKeyword: return true
    case .falseKeyword: return true
    case .isKeyword: return true
    case .nilKeyword: return true
    case .rethrowsKeyword: return true
    case .superKeyword: return true
    case .selfKeyword: return true
    case .capitalSelfKeyword: return true
    case .trueKeyword: return true
    case .tryKeyword: return true
    case .throwsKeyword: return true
    case .__file__Keyword: return true
    case .__line__Keyword: return true
    case .__column__Keyword: return true
    case .__function__Keyword: return true
    case .__dso_handle__Keyword: return true
    case .wildcardKeyword: return true
    case .leftParen: return false
    case .rightParen: return false
    case .leftBrace: return false
    case .rightBrace: return false
    case .leftSquareBracket: return false
    case .rightSquareBracket: return false
    case .leftAngle: return false
    case .rightAngle: return false
    case .period: return false
    case .prefixPeriod: return false
    case .comma: return false
    case .ellipsis: return false
    case .colon: return false
    case .semicolon: return false
    case .equal: return false
    case .atSign: return false
    case .pound: return false
    case .prefixAmpersand: return false
    case .arrow: return false
    case .backtick: return false
    case .backslash: return false
    case .exclamationMark: return false
    case .postfixQuestionMark: return false
    case .infixQuestionMark: return false
    case .stringQuote: return false
    case .singleQuote: return false
    case .multilineStringQuote: return false
    case .poundKeyPathKeyword: return true
    case .poundLineKeyword: return true
    case .poundSelectorKeyword: return true
    case .poundFileKeyword: return true
    case .poundFileIDKeyword: return true
    case .poundFilePathKeyword: return true
    case .poundColumnKeyword: return true
    case .poundFunctionKeyword: return true
    case .poundDsohandleKeyword: return true
    case .poundAssertKeyword: return true
    case .poundSourceLocationKeyword: return true
    case .poundWarningKeyword: return true
    case .poundErrorKeyword: return true
    case .poundIfKeyword: return true
    case .poundElseKeyword: return true
    case .poundElseifKeyword: return true
    case .poundEndifKeyword: return true
    case .poundAvailableKeyword: return true
    case .poundUnavailableKeyword: return true
    case .poundFileLiteralKeyword: return true
    case .poundImageLiteralKeyword: return true
    case .poundColorLiteralKeyword: return true
    case .integerLiteral: return false
    case .floatingLiteral: return false
    case .stringLiteral: return false
    case .regexLiteral: return false
    case .unknown: return false
    case .identifier: return false
    case .unspacedBinaryOperator: return false
    case .spacedBinaryOperator: return false
    case .postfixOperator: return false
    case .prefixOperator: return false
    case .dollarIdentifier: return false
    case .contextualKeyword: return false
    case .rawStringDelimiter: return false
    case .stringSegment: return false
    case .stringInterpolationAnchor: return false
    case .yield: return false
    }
  }

  /// Returns `true` if the token is a Swift punctuator.
  ///
  /// Punctuation tokens generally separate identifiers from each other. For
  /// example, the '<' and '>' characters in a generic parameter list, or the
  /// quote characters in a string literal.
  public var isPunctuation: Bool {
    switch self {
    case .eof: return false
    case .associatedtypeKeyword: return false
    case .classKeyword: return false
    case .deinitKeyword: return false
    case .enumKeyword: return false
    case .extensionKeyword: return false
    case .funcKeyword: return false
    case .importKeyword: return false
    case .initKeyword: return false
    case .inoutKeyword: return false
    case .letKeyword: return false
    case .operatorKeyword: return false
    case .precedencegroupKeyword: return false
    case .protocolKeyword: return false
    case .structKeyword: return false
    case .subscriptKeyword: return false
    case .typealiasKeyword: return false
    case .varKeyword: return false
    case .fileprivateKeyword: return false
    case .internalKeyword: return false
    case .privateKeyword: return false
    case .publicKeyword: return false
    case .staticKeyword: return false
    case .deferKeyword: return false
    case .ifKeyword: return false
    case .guardKeyword: return false
    case .doKeyword: return false
    case .repeatKeyword: return false
    case .elseKeyword: return false
    case .forKeyword: return false
    case .inKeyword: return false
    case .whileKeyword: return false
    case .returnKeyword: return false
    case .breakKeyword: return false
    case .continueKeyword: return false
    case .fallthroughKeyword: return false
    case .switchKeyword: return false
    case .caseKeyword: return false
    case .defaultKeyword: return false
    case .whereKeyword: return false
    case .catchKeyword: return false
    case .throwKeyword: return false
    case .asKeyword: return false
    case .anyKeyword: return false
    case .falseKeyword: return false
    case .isKeyword: return false
    case .nilKeyword: return false
    case .rethrowsKeyword: return false
    case .superKeyword: return false
    case .selfKeyword: return false
    case .capitalSelfKeyword: return false
    case .trueKeyword: return false
    case .tryKeyword: return false
    case .throwsKeyword: return false
    case .__file__Keyword: return false
    case .__line__Keyword: return false
    case .__column__Keyword: return false
    case .__function__Keyword: return false
    case .__dso_handle__Keyword: return false
    case .wildcardKeyword: return false
    case .leftParen: return true
    case .rightParen: return true
    case .leftBrace: return true
    case .rightBrace: return true
    case .leftSquareBracket: return true
    case .rightSquareBracket: return true
    case .leftAngle: return true
    case .rightAngle: return true
    case .period: return true
    case .prefixPeriod: return true
    case .comma: return true
    case .ellipsis: return true
    case .colon: return true
    case .semicolon: return true
    case .equal: return true
    case .atSign: return true
    case .pound: return true
    case .prefixAmpersand: return true
    case .arrow: return true
    case .backtick: return true
    case .backslash: return true
    case .exclamationMark: return true
    case .postfixQuestionMark: return true
    case .infixQuestionMark: return true
    case .stringQuote: return true
    case .singleQuote: return true
    case .multilineStringQuote: return true
    case .poundKeyPathKeyword: return false
    case .poundLineKeyword: return false
    case .poundSelectorKeyword: return false
    case .poundFileKeyword: return false
    case .poundFileIDKeyword: return false
    case .poundFilePathKeyword: return false
    case .poundColumnKeyword: return false
    case .poundFunctionKeyword: return false
    case .poundDsohandleKeyword: return false
    case .poundAssertKeyword: return false
    case .poundSourceLocationKeyword: return false
    case .poundWarningKeyword: return false
    case .poundErrorKeyword: return false
    case .poundIfKeyword: return false
    case .poundElseKeyword: return false
    case .poundElseifKeyword: return false
    case .poundEndifKeyword: return false
    case .poundAvailableKeyword: return false
    case .poundUnavailableKeyword: return false
    case .poundFileLiteralKeyword: return false
    case .poundImageLiteralKeyword: return false
    case .poundColorLiteralKeyword: return false
    case .integerLiteral: return false
    case .floatingLiteral: return false
    case .stringLiteral: return false
    case .regexLiteral: return false
    case .unknown: return false
    case .identifier: return false
    case .unspacedBinaryOperator: return false
    case .spacedBinaryOperator: return false
    case .postfixOperator: return false
    case .prefixOperator: return false
    case .dollarIdentifier: return false
    case .contextualKeyword: return false
    case .rawStringDelimiter: return false
    case .stringSegment: return false
    case .stringInterpolationAnchor: return false
    case .yield: return false
    }
  }

  var kind: String {
    switch self {
    case .eof: return "eof"
    case .associatedtypeKeyword: return "kw_associatedtype"
    case .classKeyword: return "kw_class"
    case .deinitKeyword: return "kw_deinit"
    case .enumKeyword: return "kw_enum"
    case .extensionKeyword: return "kw_extension"
    case .funcKeyword: return "kw_func"
    case .importKeyword: return "kw_import"
    case .initKeyword: return "kw_init"
    case .inoutKeyword: return "kw_inout"
    case .letKeyword: return "kw_let"
    case .operatorKeyword: return "kw_operator"
    case .precedencegroupKeyword: return "kw_precedencegroup"
    case .protocolKeyword: return "kw_protocol"
    case .structKeyword: return "kw_struct"
    case .subscriptKeyword: return "kw_subscript"
    case .typealiasKeyword: return "kw_typealias"
    case .varKeyword: return "kw_var"
    case .fileprivateKeyword: return "kw_fileprivate"
    case .internalKeyword: return "kw_internal"
    case .privateKeyword: return "kw_private"
    case .publicKeyword: return "kw_public"
    case .staticKeyword: return "kw_static"
    case .deferKeyword: return "kw_defer"
    case .ifKeyword: return "kw_if"
    case .guardKeyword: return "kw_guard"
    case .doKeyword: return "kw_do"
    case .repeatKeyword: return "kw_repeat"
    case .elseKeyword: return "kw_else"
    case .forKeyword: return "kw_for"
    case .inKeyword: return "kw_in"
    case .whileKeyword: return "kw_while"
    case .returnKeyword: return "kw_return"
    case .breakKeyword: return "kw_break"
    case .continueKeyword: return "kw_continue"
    case .fallthroughKeyword: return "kw_fallthrough"
    case .switchKeyword: return "kw_switch"
    case .caseKeyword: return "kw_case"
    case .defaultKeyword: return "kw_default"
    case .whereKeyword: return "kw_where"
    case .catchKeyword: return "kw_catch"
    case .throwKeyword: return "kw_throw"
    case .asKeyword: return "kw_as"
    case .anyKeyword: return "kw_Any"
    case .falseKeyword: return "kw_false"
    case .isKeyword: return "kw_is"
    case .nilKeyword: return "kw_nil"
    case .rethrowsKeyword: return "kw_rethrows"
    case .superKeyword: return "kw_super"
    case .selfKeyword: return "kw_self"
    case .capitalSelfKeyword: return "kw_Self"
    case .trueKeyword: return "kw_true"
    case .tryKeyword: return "kw_try"
    case .throwsKeyword: return "kw_throws"
    case .__file__Keyword: return "kw___FILE__"
    case .__line__Keyword: return "kw___LINE__"
    case .__column__Keyword: return "kw___COLUMN__"
    case .__function__Keyword: return "kw___FUNCTION__"
    case .__dso_handle__Keyword: return "kw___DSO_HANDLE__"
    case .wildcardKeyword: return "kw__"
    case .leftParen: return "l_paren"
    case .rightParen: return "r_paren"
    case .leftBrace: return "l_brace"
    case .rightBrace: return "r_brace"
    case .leftSquareBracket: return "l_square"
    case .rightSquareBracket: return "r_square"
    case .leftAngle: return "l_angle"
    case .rightAngle: return "r_angle"
    case .period: return "period"
    case .prefixPeriod: return "period_prefix"
    case .comma: return "comma"
    case .ellipsis: return "ellipsis"
    case .colon: return "colon"
    case .semicolon: return "semi"
    case .equal: return "equal"
    case .atSign: return "at_sign"
    case .pound: return "pound"
    case .prefixAmpersand: return "amp_prefix"
    case .arrow: return "arrow"
    case .backtick: return "backtick"
    case .backslash: return "backslash"
    case .exclamationMark: return "exclaim_postfix"
    case .postfixQuestionMark: return "question_postfix"
    case .infixQuestionMark: return "question_infix"
    case .stringQuote: return "string_quote"
    case .singleQuote: return "single_quote"
    case .multilineStringQuote: return "multiline_string_quote"
    case .poundKeyPathKeyword: return "pound_keyPath"
    case .poundLineKeyword: return "pound_line"
    case .poundSelectorKeyword: return "pound_selector"
    case .poundFileKeyword: return "pound_file"
    case .poundFileIDKeyword: return "pound_fileID"
    case .poundFilePathKeyword: return "pound_filePath"
    case .poundColumnKeyword: return "pound_column"
    case .poundFunctionKeyword: return "pound_function"
    case .poundDsohandleKeyword: return "pound_dsohandle"
    case .poundAssertKeyword: return "pound_assert"
    case .poundSourceLocationKeyword: return "pound_sourceLocation"
    case .poundWarningKeyword: return "pound_warning"
    case .poundErrorKeyword: return "pound_error"
    case .poundIfKeyword: return "pound_if"
    case .poundElseKeyword: return "pound_else"
    case .poundElseifKeyword: return "pound_elseif"
    case .poundEndifKeyword: return "pound_endif"
    case .poundAvailableKeyword: return "pound_available"
    case .poundUnavailableKeyword: return "pound_unavailable"
    case .poundFileLiteralKeyword: return "pound_fileLiteral"
    case .poundImageLiteralKeyword: return "pound_imageLiteral"
    case .poundColorLiteralKeyword: return "pound_colorLiteral"
    case .integerLiteral: return "integer_literal"
    case .floatingLiteral: return "floating_literal"
    case .stringLiteral: return "string_literal"
    case .regexLiteral: return "regex_literal"
    case .unknown: return "unknown"
    case .identifier: return "identifier"
    case .unspacedBinaryOperator: return "oper_binary_unspaced"
    case .spacedBinaryOperator: return "oper_binary_spaced"
    case .postfixOperator: return "oper_postfix"
    case .prefixOperator: return "oper_prefix"
    case .dollarIdentifier: return "dollarident"
    case .contextualKeyword: return "contextual_keyword"
    case .rawStringDelimiter: return "raw_string_delimiter"
    case .stringSegment: return "string_segment"
    case .stringInterpolationAnchor: return "string_interpolation_anchor"
    case .yield: return "kw_yield"
    }
  }

  var defaultText: StringRef? {
    switch self {
    case .associatedtypeKeyword: return "associatedtype"
    case .classKeyword: return "class"
    case .deinitKeyword: return "deinit"
    case .enumKeyword: return "enum"
    case .extensionKeyword: return "extension"
    case .funcKeyword: return "func"
    case .importKeyword: return "import"
    case .initKeyword: return "init"
    case .inoutKeyword: return "inout"
    case .letKeyword: return "let"
    case .operatorKeyword: return "operator"
    case .precedencegroupKeyword: return "precedencegroup"
    case .protocolKeyword: return "protocol"
    case .structKeyword: return "struct"
    case .subscriptKeyword: return "subscript"
    case .typealiasKeyword: return "typealias"
    case .varKeyword: return "var"
    case .fileprivateKeyword: return "fileprivate"
    case .internalKeyword: return "internal"
    case .privateKeyword: return "private"
    case .publicKeyword: return "public"
    case .staticKeyword: return "static"
    case .deferKeyword: return "defer"
    case .ifKeyword: return "if"
    case .guardKeyword: return "guard"
    case .doKeyword: return "do"
    case .repeatKeyword: return "repeat"
    case .elseKeyword: return "else"
    case .forKeyword: return "for"
    case .inKeyword: return "in"
    case .whileKeyword: return "while"
    case .returnKeyword: return "return"
    case .breakKeyword: return "break"
    case .continueKeyword: return "continue"
    case .fallthroughKeyword: return "fallthrough"
    case .switchKeyword: return "switch"
    case .caseKeyword: return "case"
    case .defaultKeyword: return "default"
    case .whereKeyword: return "where"
    case .catchKeyword: return "catch"
    case .throwKeyword: return "throw"
    case .asKeyword: return "as"
    case .anyKeyword: return "Any"
    case .falseKeyword: return "false"
    case .isKeyword: return "is"
    case .nilKeyword: return "nil"
    case .rethrowsKeyword: return "rethrows"
    case .superKeyword: return "super"
    case .selfKeyword: return "self"
    case .capitalSelfKeyword: return "Self"
    case .trueKeyword: return "true"
    case .tryKeyword: return "try"
    case .throwsKeyword: return "throws"
    case .__file__Keyword: return "__FILE__"
    case .__line__Keyword: return "__LINE__"
    case .__column__Keyword: return "__COLUMN__"
    case .__function__Keyword: return "__FUNCTION__"
    case .__dso_handle__Keyword: return "__DSO_HANDLE__"
    case .wildcardKeyword: return "_"
    case .leftParen: return "("
    case .rightParen: return ")"
    case .leftBrace: return "{"
    case .rightBrace: return "}"
    case .leftSquareBracket: return "["
    case .rightSquareBracket: return "]"
    case .leftAngle: return "<"
    case .rightAngle: return ">"
    case .period: return "."
    case .prefixPeriod: return "."
    case .comma: return ","
    case .ellipsis: return "..."
    case .colon: return ":"
    case .semicolon: return ";"
    case .equal: return "="
    case .atSign: return "@"
    case .pound: return "#"
    case .prefixAmpersand: return "&"
    case .arrow: return "->"
    case .backtick: return "`"
    case .backslash: return "\\"
    case .exclamationMark: return "!"
    case .postfixQuestionMark: return "?"
    case .infixQuestionMark: return "?"
    case .stringQuote: return "\""
    case .singleQuote: return "\'"
    case .multilineStringQuote: return "\"\"\""
    case .poundKeyPathKeyword: return "#keyPath"
    case .poundLineKeyword: return "#line"
    case .poundSelectorKeyword: return "#selector"
    case .poundFileKeyword: return "#file"
    case .poundFileIDKeyword: return "#fileID"
    case .poundFilePathKeyword: return "#filePath"
    case .poundColumnKeyword: return "#column"
    case .poundFunctionKeyword: return "#function"
    case .poundDsohandleKeyword: return "#dsohandle"
    case .poundAssertKeyword: return "#assert"
    case .poundSourceLocationKeyword: return "#sourceLocation"
    case .poundWarningKeyword: return "#warning"
    case .poundErrorKeyword: return "#error"
    case .poundIfKeyword: return "#if"
    case .poundElseKeyword: return "#else"
    case .poundElseifKeyword: return "#elseif"
    case .poundEndifKeyword: return "#endif"
    case .poundAvailableKeyword: return "#available"
    case .poundUnavailableKeyword: return "#unavailable"
    case .poundFileLiteralKeyword: return "#fileLiteral"
    case .poundImageLiteralKeyword: return "#imageLiteral"
    case .poundColorLiteralKeyword: return "#colorLiteral"
    case .stringInterpolationAnchor: return ")"
    case .yield: return "yield"
    default: return nil
    }
  }
}

@available(*, deprecated, message: "Use plain TokenKind")
public enum LegacyTokenKind {
  case eof
  case associatedtypeKeyword
  case classKeyword
  case deinitKeyword
  case enumKeyword
  case extensionKeyword
  case funcKeyword
  case importKeyword
  case initKeyword
  case inoutKeyword
  case letKeyword
  case operatorKeyword
  case precedencegroupKeyword
  case protocolKeyword
  case structKeyword
  case subscriptKeyword
  case typealiasKeyword
  case varKeyword
  case fileprivateKeyword
  case internalKeyword
  case privateKeyword
  case publicKeyword
  case staticKeyword
  case deferKeyword
  case ifKeyword
  case guardKeyword
  case doKeyword
  case repeatKeyword
  case elseKeyword
  case forKeyword
  case inKeyword
  case whileKeyword
  case returnKeyword
  case breakKeyword
  case continueKeyword
  case fallthroughKeyword
  case switchKeyword
  case caseKeyword
  case defaultKeyword
  case whereKeyword
  case catchKeyword
  case throwKeyword
  case asKeyword
  case anyKeyword
  case falseKeyword
  case isKeyword
  case nilKeyword
  case rethrowsKeyword
  case superKeyword
  case selfKeyword
  case capitalSelfKeyword
  case trueKeyword
  case tryKeyword
  case throwsKeyword
  case __file__Keyword
  case __line__Keyword
  case __column__Keyword
  case __function__Keyword
  case __dso_handle__Keyword
  case wildcardKeyword
  case leftParen
  case rightParen
  case leftBrace
  case rightBrace
  case leftSquareBracket
  case rightSquareBracket
  case leftAngle
  case rightAngle
  case period
  case prefixPeriod
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
  case poundKeyPathKeyword
  case poundLineKeyword
  case poundSelectorKeyword
  case poundFileKeyword
  case poundFileIDKeyword
  case poundFilePathKeyword
  case poundColumnKeyword
  case poundFunctionKeyword
  case poundDsohandleKeyword
  case poundAssertKeyword
  case poundSourceLocationKeyword
  case poundWarningKeyword
  case poundErrorKeyword
  case poundIfKeyword
  case poundElseKeyword
  case poundElseifKeyword
  case poundEndifKeyword
  case poundAvailableKeyword
  case poundUnavailableKeyword
  case poundFileLiteralKeyword
  case poundImageLiteralKeyword
  case poundColorLiteralKeyword
  case integerLiteral(String)
  case floatingLiteral(String)
  case stringLiteral(String)
  case regexLiteral(String)
  case unknown(String)
  case identifier(String)
  case unspacedBinaryOperator(String)
  case spacedBinaryOperator(String)
  case postfixOperator(String)
  case prefixOperator(String)
  case dollarIdentifier(String)
  case contextualKeyword(String)
  case rawStringDelimiter(String)
  case stringSegment(String)
  case stringInterpolationAnchor
  case yield
  var plain: (TokenKind, String) {
    switch self {
    case .eof: return (.eof, "")
    case .associatedtypeKeyword: return (.associatedtypeKeyword, "associatedtype")
    case .classKeyword: return (.classKeyword, "class")
    case .deinitKeyword: return (.deinitKeyword, "deinit")
    case .enumKeyword: return (.enumKeyword, "enum")
    case .extensionKeyword: return (.extensionKeyword, "extension")
    case .funcKeyword: return (.funcKeyword, "func")
    case .importKeyword: return (.importKeyword, "import")
    case .initKeyword: return (.initKeyword, "init")
    case .inoutKeyword: return (.inoutKeyword, "inout")
    case .letKeyword: return (.letKeyword, "let")
    case .operatorKeyword: return (.operatorKeyword, "operator")
    case .precedencegroupKeyword: return (.precedencegroupKeyword, "precedencegroup")
    case .protocolKeyword: return (.protocolKeyword, "protocol")
    case .structKeyword: return (.structKeyword, "struct")
    case .subscriptKeyword: return (.subscriptKeyword, "subscript")
    case .typealiasKeyword: return (.typealiasKeyword, "typealias")
    case .varKeyword: return (.varKeyword, "var")
    case .fileprivateKeyword: return (.fileprivateKeyword, "fileprivate")
    case .internalKeyword: return (.internalKeyword, "internal")
    case .privateKeyword: return (.privateKeyword, "private")
    case .publicKeyword: return (.publicKeyword, "public")
    case .staticKeyword: return (.staticKeyword, "static")
    case .deferKeyword: return (.deferKeyword, "defer")
    case .ifKeyword: return (.ifKeyword, "if")
    case .guardKeyword: return (.guardKeyword, "guard")
    case .doKeyword: return (.doKeyword, "do")
    case .repeatKeyword: return (.repeatKeyword, "repeat")
    case .elseKeyword: return (.elseKeyword, "else")
    case .forKeyword: return (.forKeyword, "for")
    case .inKeyword: return (.inKeyword, "in")
    case .whileKeyword: return (.whileKeyword, "while")
    case .returnKeyword: return (.returnKeyword, "return")
    case .breakKeyword: return (.breakKeyword, "break")
    case .continueKeyword: return (.continueKeyword, "continue")
    case .fallthroughKeyword: return (.fallthroughKeyword, "fallthrough")
    case .switchKeyword: return (.switchKeyword, "switch")
    case .caseKeyword: return (.caseKeyword, "case")
    case .defaultKeyword: return (.defaultKeyword, "default")
    case .whereKeyword: return (.whereKeyword, "where")
    case .catchKeyword: return (.catchKeyword, "catch")
    case .throwKeyword: return (.throwKeyword, "throw")
    case .asKeyword: return (.asKeyword, "as")
    case .anyKeyword: return (.anyKeyword, "Any")
    case .falseKeyword: return (.falseKeyword, "false")
    case .isKeyword: return (.isKeyword, "is")
    case .nilKeyword: return (.nilKeyword, "nil")
    case .rethrowsKeyword: return (.rethrowsKeyword, "rethrows")
    case .superKeyword: return (.superKeyword, "super")
    case .selfKeyword: return (.selfKeyword, "self")
    case .capitalSelfKeyword: return (.capitalSelfKeyword, "Self")
    case .trueKeyword: return (.trueKeyword, "true")
    case .tryKeyword: return (.tryKeyword, "try")
    case .throwsKeyword: return (.throwsKeyword, "throws")
    case .__file__Keyword: return (.__file__Keyword, "__FILE__")
    case .__line__Keyword: return (.__line__Keyword, "__LINE__")
    case .__column__Keyword: return (.__column__Keyword, "__COLUMN__")
    case .__function__Keyword: return (.__function__Keyword, "__FUNCTION__")
    case .__dso_handle__Keyword: return (.__dso_handle__Keyword, "__DSO_HANDLE__")
    case .wildcardKeyword: return (.wildcardKeyword, "_")
    case .leftParen: return (.leftParen, "(")
    case .rightParen: return (.rightParen, ")")
    case .leftBrace: return (.leftBrace, "{")
    case .rightBrace: return (.rightBrace, "}")
    case .leftSquareBracket: return (.leftSquareBracket, "[")
    case .rightSquareBracket: return (.rightSquareBracket, "]")
    case .leftAngle: return (.leftAngle, "<")
    case .rightAngle: return (.rightAngle, ">")
    case .period: return (.period, ".")
    case .prefixPeriod: return (.prefixPeriod, ".")
    case .comma: return (.comma, ",")
    case .ellipsis: return (.ellipsis, "...")
    case .colon: return (.colon, ":")
    case .semicolon: return (.semicolon, ";")
    case .equal: return (.equal, "=")
    case .atSign: return (.atSign, "@")
    case .pound: return (.pound, "#")
    case .prefixAmpersand: return (.prefixAmpersand, "&")
    case .arrow: return (.arrow, "->")
    case .backtick: return (.backtick, "`")
    case .backslash: return (.backslash, "\\")
    case .exclamationMark: return (.exclamationMark, "!")
    case .postfixQuestionMark: return (.postfixQuestionMark, "?")
    case .infixQuestionMark: return (.infixQuestionMark, "?")
    case .stringQuote: return (.stringQuote, "\"")
    case .singleQuote: return (.singleQuote, "\'")
    case .multilineStringQuote: return (.multilineStringQuote, "\"\"\"")
    case .poundKeyPathKeyword: return (.poundKeyPathKeyword, "#keyPath")
    case .poundLineKeyword: return (.poundLineKeyword, "#line")
    case .poundSelectorKeyword: return (.poundSelectorKeyword, "#selector")
    case .poundFileKeyword: return (.poundFileKeyword, "#file")
    case .poundFileIDKeyword: return (.poundFileIDKeyword, "#fileID")
    case .poundFilePathKeyword: return (.poundFilePathKeyword, "#filePath")
    case .poundColumnKeyword: return (.poundColumnKeyword, "#column")
    case .poundFunctionKeyword: return (.poundFunctionKeyword, "#function")
    case .poundDsohandleKeyword: return (.poundDsohandleKeyword, "#dsohandle")
    case .poundAssertKeyword: return (.poundAssertKeyword, "#assert")
    case .poundSourceLocationKeyword: return (.poundSourceLocationKeyword, "#sourceLocation")
    case .poundWarningKeyword: return (.poundWarningKeyword, "#warning")
    case .poundErrorKeyword: return (.poundErrorKeyword, "#error")
    case .poundIfKeyword: return (.poundIfKeyword, "#if")
    case .poundElseKeyword: return (.poundElseKeyword, "#else")
    case .poundElseifKeyword: return (.poundElseifKeyword, "#elseif")
    case .poundEndifKeyword: return (.poundEndifKeyword, "#endif")
    case .poundAvailableKeyword: return (.poundAvailableKeyword, "#available")
    case .poundUnavailableKeyword: return (.poundUnavailableKeyword, "#unavailable")
    case .poundFileLiteralKeyword: return (.poundFileLiteralKeyword, "#fileLiteral")
    case .poundImageLiteralKeyword: return (.poundImageLiteralKeyword, "#imageLiteral")
    case .poundColorLiteralKeyword: return (.poundColorLiteralKeyword, "#colorLiteral")
    case .integerLiteral(let text): return (.integerLiteral, text)
    case .floatingLiteral(let text): return (.floatingLiteral, text)
    case .stringLiteral(let text): return (.stringLiteral, text)
    case .regexLiteral(let text): return (.regexLiteral, text)
    case .unknown(let text): return (.unknown, text)
    case .identifier(let text): return (.identifier, text)
    case .unspacedBinaryOperator(let text): return (.unspacedBinaryOperator, text)
    case .spacedBinaryOperator(let text): return (.spacedBinaryOperator, text)
    case .postfixOperator(let text): return (.postfixOperator, text)
    case .prefixOperator(let text): return (.prefixOperator, text)
    case .dollarIdentifier(let text): return (.dollarIdentifier, text)
    case .contextualKeyword(let text): return (.contextualKeyword, text)
    case .rawStringDelimiter(let text): return (.rawStringDelimiter, text)
    case .stringSegment(let text): return (.stringSegment, text)
    case .stringInterpolationAnchor: return (.stringInterpolationAnchor, ")")
    case .yield: return (.yield, "yield")
    }
  }
}

