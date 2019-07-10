//// Automatically Generated From TokenKind.swift.gyb.
//// Do Not Edit Directly!
//===----------------- TokenKind.swift - Token Kind Enum ------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

/// Enumerates the kinds of tokens in the Swift language.
public enum TokenKind {
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
  case poundFileLiteralKeyword
  case poundImageLiteralKeyword
  case poundColorLiteralKeyword
  case integerLiteral(String)
  case floatingLiteral(String)
  case stringLiteral(String)
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

  /// The textual representation of this token kind.
  var text: String {
    switch self {
    case .eof: return ""
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
    case .poundFileLiteralKeyword: return "#fileLiteral"
    case .poundImageLiteralKeyword: return "#imageLiteral"
    case .poundColorLiteralKeyword: return "#colorLiteral"
    case .integerLiteral(let text): return text
    case .floatingLiteral(let text): return text
    case .stringLiteral(let text): return text
    case .unknown(let text): return text
    case .identifier(let text): return text
    case .unspacedBinaryOperator(let text): return text
    case .spacedBinaryOperator(let text): return text
    case .postfixOperator(let text): return text
    case .prefixOperator(let text): return text
    case .dollarIdentifier(let text): return text
    case .contextualKeyword(let text): return text
    case .rawStringDelimiter(let text): return text
    case .stringSegment(let text): return text
    case .stringInterpolationAnchor: return ")"
    case .yield: return "yield"
    }
  }

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
    case .poundFileLiteralKeyword: return true
    case .poundImageLiteralKeyword: return true
    case .poundColorLiteralKeyword: return true
    case .integerLiteral: return false
    case .floatingLiteral: return false
    case .stringLiteral: return false
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
    case .poundFileLiteralKeyword: return "pound_fileLiteral"
    case .poundImageLiteralKeyword: return "pound_imageLiteral"
    case .poundColorLiteralKeyword: return "pound_colorLiteral"
    case .integerLiteral(_): return "integer_literal"
    case .floatingLiteral(_): return "floating_literal"
    case .stringLiteral(_): return "string_literal"
    case .unknown(_): return "unknown"
    case .identifier(_): return "identifier"
    case .unspacedBinaryOperator(_): return "oper_binary_unspaced"
    case .spacedBinaryOperator(_): return "oper_binary_spaced"
    case .postfixOperator(_): return "oper_postfix"
    case .prefixOperator(_): return "oper_prefix"
    case .dollarIdentifier(_): return "dollarident"
    case .contextualKeyword(_): return "contextual_keyword"
    case .rawStringDelimiter(_): return "raw_string_delimiter"
    case .stringSegment(_): return "string_segment"
    case .stringInterpolationAnchor: return "string_interpolation_anchor"
    case .yield: return "kw_yield"
    }
  }

  var sourceLength: SourceLength {
    switch self {
    case .eof: return .zero
    case .associatedtypeKeyword: return SourceLength(utf8Length: 14)
    case .classKeyword: return SourceLength(utf8Length: 5)
    case .deinitKeyword: return SourceLength(utf8Length: 6)
    case .enumKeyword: return SourceLength(utf8Length: 4)
    case .extensionKeyword: return SourceLength(utf8Length: 9)
    case .funcKeyword: return SourceLength(utf8Length: 4)
    case .importKeyword: return SourceLength(utf8Length: 6)
    case .initKeyword: return SourceLength(utf8Length: 4)
    case .inoutKeyword: return SourceLength(utf8Length: 5)
    case .letKeyword: return SourceLength(utf8Length: 3)
    case .operatorKeyword: return SourceLength(utf8Length: 8)
    case .precedencegroupKeyword: return SourceLength(utf8Length: 15)
    case .protocolKeyword: return SourceLength(utf8Length: 8)
    case .structKeyword: return SourceLength(utf8Length: 6)
    case .subscriptKeyword: return SourceLength(utf8Length: 9)
    case .typealiasKeyword: return SourceLength(utf8Length: 9)
    case .varKeyword: return SourceLength(utf8Length: 3)
    case .fileprivateKeyword: return SourceLength(utf8Length: 11)
    case .internalKeyword: return SourceLength(utf8Length: 8)
    case .privateKeyword: return SourceLength(utf8Length: 7)
    case .publicKeyword: return SourceLength(utf8Length: 6)
    case .staticKeyword: return SourceLength(utf8Length: 6)
    case .deferKeyword: return SourceLength(utf8Length: 5)
    case .ifKeyword: return SourceLength(utf8Length: 2)
    case .guardKeyword: return SourceLength(utf8Length: 5)
    case .doKeyword: return SourceLength(utf8Length: 2)
    case .repeatKeyword: return SourceLength(utf8Length: 6)
    case .elseKeyword: return SourceLength(utf8Length: 4)
    case .forKeyword: return SourceLength(utf8Length: 3)
    case .inKeyword: return SourceLength(utf8Length: 2)
    case .whileKeyword: return SourceLength(utf8Length: 5)
    case .returnKeyword: return SourceLength(utf8Length: 6)
    case .breakKeyword: return SourceLength(utf8Length: 5)
    case .continueKeyword: return SourceLength(utf8Length: 8)
    case .fallthroughKeyword: return SourceLength(utf8Length: 11)
    case .switchKeyword: return SourceLength(utf8Length: 6)
    case .caseKeyword: return SourceLength(utf8Length: 4)
    case .defaultKeyword: return SourceLength(utf8Length: 7)
    case .whereKeyword: return SourceLength(utf8Length: 5)
    case .catchKeyword: return SourceLength(utf8Length: 5)
    case .throwKeyword: return SourceLength(utf8Length: 5)
    case .asKeyword: return SourceLength(utf8Length: 2)
    case .anyKeyword: return SourceLength(utf8Length: 3)
    case .falseKeyword: return SourceLength(utf8Length: 5)
    case .isKeyword: return SourceLength(utf8Length: 2)
    case .nilKeyword: return SourceLength(utf8Length: 3)
    case .rethrowsKeyword: return SourceLength(utf8Length: 8)
    case .superKeyword: return SourceLength(utf8Length: 5)
    case .selfKeyword: return SourceLength(utf8Length: 4)
    case .capitalSelfKeyword: return SourceLength(utf8Length: 4)
    case .trueKeyword: return SourceLength(utf8Length: 4)
    case .tryKeyword: return SourceLength(utf8Length: 3)
    case .throwsKeyword: return SourceLength(utf8Length: 6)
    case .__file__Keyword: return SourceLength(utf8Length: 8)
    case .__line__Keyword: return SourceLength(utf8Length: 8)
    case .__column__Keyword: return SourceLength(utf8Length: 10)
    case .__function__Keyword: return SourceLength(utf8Length: 12)
    case .__dso_handle__Keyword: return SourceLength(utf8Length: 14)
    case .wildcardKeyword: return SourceLength(utf8Length: 1)
    case .leftParen: return SourceLength(utf8Length: 1)
    case .rightParen: return SourceLength(utf8Length: 1)
    case .leftBrace: return SourceLength(utf8Length: 1)
    case .rightBrace: return SourceLength(utf8Length: 1)
    case .leftSquareBracket: return SourceLength(utf8Length: 1)
    case .rightSquareBracket: return SourceLength(utf8Length: 1)
    case .leftAngle: return SourceLength(utf8Length: 1)
    case .rightAngle: return SourceLength(utf8Length: 1)
    case .period: return SourceLength(utf8Length: 1)
    case .prefixPeriod: return SourceLength(utf8Length: 1)
    case .comma: return SourceLength(utf8Length: 1)
    case .ellipsis: return SourceLength(utf8Length: 3)
    case .colon: return SourceLength(utf8Length: 1)
    case .semicolon: return SourceLength(utf8Length: 1)
    case .equal: return SourceLength(utf8Length: 1)
    case .atSign: return SourceLength(utf8Length: 1)
    case .pound: return SourceLength(utf8Length: 1)
    case .prefixAmpersand: return SourceLength(utf8Length: 1)
    case .arrow: return SourceLength(utf8Length: 2)
    case .backtick: return SourceLength(utf8Length: 1)
    case .backslash: return SourceLength(utf8Length: 1)
    case .exclamationMark: return SourceLength(utf8Length: 1)
    case .postfixQuestionMark: return SourceLength(utf8Length: 1)
    case .infixQuestionMark: return SourceLength(utf8Length: 1)
    case .stringQuote: return SourceLength(utf8Length: 1)
    case .singleQuote: return SourceLength(utf8Length: 1)
    case .multilineStringQuote: return SourceLength(utf8Length: 3)
    case .poundKeyPathKeyword: return SourceLength(utf8Length: 8)
    case .poundLineKeyword: return SourceLength(utf8Length: 5)
    case .poundSelectorKeyword: return SourceLength(utf8Length: 9)
    case .poundFileKeyword: return SourceLength(utf8Length: 5)
    case .poundColumnKeyword: return SourceLength(utf8Length: 7)
    case .poundFunctionKeyword: return SourceLength(utf8Length: 9)
    case .poundDsohandleKeyword: return SourceLength(utf8Length: 10)
    case .poundAssertKeyword: return SourceLength(utf8Length: 7)
    case .poundSourceLocationKeyword: return SourceLength(utf8Length: 15)
    case .poundWarningKeyword: return SourceLength(utf8Length: 8)
    case .poundErrorKeyword: return SourceLength(utf8Length: 6)
    case .poundIfKeyword: return SourceLength(utf8Length: 3)
    case .poundElseKeyword: return SourceLength(utf8Length: 5)
    case .poundElseifKeyword: return SourceLength(utf8Length: 7)
    case .poundEndifKeyword: return SourceLength(utf8Length: 6)
    case .poundAvailableKeyword: return SourceLength(utf8Length: 10)
    case .poundFileLiteralKeyword: return SourceLength(utf8Length: 12)
    case .poundImageLiteralKeyword: return SourceLength(utf8Length: 13)
    case .poundColorLiteralKeyword: return SourceLength(utf8Length: 13)
    case .integerLiteral(let text): return SourceLength(of: text)
    case .floatingLiteral(let text): return SourceLength(of: text)
    case .stringLiteral(let text): return SourceLength(of: text)
    case .unknown(let text): return SourceLength(of: text)
    case .identifier(let text): return SourceLength(of: text)
    case .unspacedBinaryOperator(let text): return SourceLength(of: text)
    case .spacedBinaryOperator(let text): return SourceLength(of: text)
    case .postfixOperator(let text): return SourceLength(of: text)
    case .prefixOperator(let text): return SourceLength(of: text)
    case .dollarIdentifier(let text): return SourceLength(of: text)
    case .contextualKeyword(let text): return SourceLength(of: text)
    case .rawStringDelimiter(let text): return SourceLength(of: text)
    case .stringSegment(let text): return SourceLength(of: text)
    case .stringInterpolationAnchor: return SourceLength(utf8Length: 1)
    case .yield: return SourceLength(utf8Length: 5)
    }
  }
}

extension TokenKind: Equatable {
  public static func ==(lhs: TokenKind, rhs: TokenKind) -> Bool {
    switch (lhs, rhs) {
    case (.eof, .eof): return true
    case (.associatedtypeKeyword, .associatedtypeKeyword): return true
    case (.classKeyword, .classKeyword): return true
    case (.deinitKeyword, .deinitKeyword): return true
    case (.enumKeyword, .enumKeyword): return true
    case (.extensionKeyword, .extensionKeyword): return true
    case (.funcKeyword, .funcKeyword): return true
    case (.importKeyword, .importKeyword): return true
    case (.initKeyword, .initKeyword): return true
    case (.inoutKeyword, .inoutKeyword): return true
    case (.letKeyword, .letKeyword): return true
    case (.operatorKeyword, .operatorKeyword): return true
    case (.precedencegroupKeyword, .precedencegroupKeyword): return true
    case (.protocolKeyword, .protocolKeyword): return true
    case (.structKeyword, .structKeyword): return true
    case (.subscriptKeyword, .subscriptKeyword): return true
    case (.typealiasKeyword, .typealiasKeyword): return true
    case (.varKeyword, .varKeyword): return true
    case (.fileprivateKeyword, .fileprivateKeyword): return true
    case (.internalKeyword, .internalKeyword): return true
    case (.privateKeyword, .privateKeyword): return true
    case (.publicKeyword, .publicKeyword): return true
    case (.staticKeyword, .staticKeyword): return true
    case (.deferKeyword, .deferKeyword): return true
    case (.ifKeyword, .ifKeyword): return true
    case (.guardKeyword, .guardKeyword): return true
    case (.doKeyword, .doKeyword): return true
    case (.repeatKeyword, .repeatKeyword): return true
    case (.elseKeyword, .elseKeyword): return true
    case (.forKeyword, .forKeyword): return true
    case (.inKeyword, .inKeyword): return true
    case (.whileKeyword, .whileKeyword): return true
    case (.returnKeyword, .returnKeyword): return true
    case (.breakKeyword, .breakKeyword): return true
    case (.continueKeyword, .continueKeyword): return true
    case (.fallthroughKeyword, .fallthroughKeyword): return true
    case (.switchKeyword, .switchKeyword): return true
    case (.caseKeyword, .caseKeyword): return true
    case (.defaultKeyword, .defaultKeyword): return true
    case (.whereKeyword, .whereKeyword): return true
    case (.catchKeyword, .catchKeyword): return true
    case (.throwKeyword, .throwKeyword): return true
    case (.asKeyword, .asKeyword): return true
    case (.anyKeyword, .anyKeyword): return true
    case (.falseKeyword, .falseKeyword): return true
    case (.isKeyword, .isKeyword): return true
    case (.nilKeyword, .nilKeyword): return true
    case (.rethrowsKeyword, .rethrowsKeyword): return true
    case (.superKeyword, .superKeyword): return true
    case (.selfKeyword, .selfKeyword): return true
    case (.capitalSelfKeyword, .capitalSelfKeyword): return true
    case (.trueKeyword, .trueKeyword): return true
    case (.tryKeyword, .tryKeyword): return true
    case (.throwsKeyword, .throwsKeyword): return true
    case (.__file__Keyword, .__file__Keyword): return true
    case (.__line__Keyword, .__line__Keyword): return true
    case (.__column__Keyword, .__column__Keyword): return true
    case (.__function__Keyword, .__function__Keyword): return true
    case (.__dso_handle__Keyword, .__dso_handle__Keyword): return true
    case (.wildcardKeyword, .wildcardKeyword): return true
    case (.leftParen, .leftParen): return true
    case (.rightParen, .rightParen): return true
    case (.leftBrace, .leftBrace): return true
    case (.rightBrace, .rightBrace): return true
    case (.leftSquareBracket, .leftSquareBracket): return true
    case (.rightSquareBracket, .rightSquareBracket): return true
    case (.leftAngle, .leftAngle): return true
    case (.rightAngle, .rightAngle): return true
    case (.period, .period): return true
    case (.prefixPeriod, .prefixPeriod): return true
    case (.comma, .comma): return true
    case (.ellipsis, .ellipsis): return true
    case (.colon, .colon): return true
    case (.semicolon, .semicolon): return true
    case (.equal, .equal): return true
    case (.atSign, .atSign): return true
    case (.pound, .pound): return true
    case (.prefixAmpersand, .prefixAmpersand): return true
    case (.arrow, .arrow): return true
    case (.backtick, .backtick): return true
    case (.backslash, .backslash): return true
    case (.exclamationMark, .exclamationMark): return true
    case (.postfixQuestionMark, .postfixQuestionMark): return true
    case (.infixQuestionMark, .infixQuestionMark): return true
    case (.stringQuote, .stringQuote): return true
    case (.singleQuote, .singleQuote): return true
    case (.multilineStringQuote, .multilineStringQuote): return true
    case (.poundKeyPathKeyword, .poundKeyPathKeyword): return true
    case (.poundLineKeyword, .poundLineKeyword): return true
    case (.poundSelectorKeyword, .poundSelectorKeyword): return true
    case (.poundFileKeyword, .poundFileKeyword): return true
    case (.poundColumnKeyword, .poundColumnKeyword): return true
    case (.poundFunctionKeyword, .poundFunctionKeyword): return true
    case (.poundDsohandleKeyword, .poundDsohandleKeyword): return true
    case (.poundAssertKeyword, .poundAssertKeyword): return true
    case (.poundSourceLocationKeyword, .poundSourceLocationKeyword): return true
    case (.poundWarningKeyword, .poundWarningKeyword): return true
    case (.poundErrorKeyword, .poundErrorKeyword): return true
    case (.poundIfKeyword, .poundIfKeyword): return true
    case (.poundElseKeyword, .poundElseKeyword): return true
    case (.poundElseifKeyword, .poundElseifKeyword): return true
    case (.poundEndifKeyword, .poundEndifKeyword): return true
    case (.poundAvailableKeyword, .poundAvailableKeyword): return true
    case (.poundFileLiteralKeyword, .poundFileLiteralKeyword): return true
    case (.poundImageLiteralKeyword, .poundImageLiteralKeyword): return true
    case (.poundColorLiteralKeyword, .poundColorLiteralKeyword): return true
    case (.integerLiteral(let lhsText), .integerLiteral(let rhsText)):
      return lhsText == rhsText
    case (.floatingLiteral(let lhsText), .floatingLiteral(let rhsText)):
      return lhsText == rhsText
    case (.stringLiteral(let lhsText), .stringLiteral(let rhsText)):
      return lhsText == rhsText
    case (.unknown(let lhsText), .unknown(let rhsText)):
      return lhsText == rhsText
    case (.identifier(let lhsText), .identifier(let rhsText)):
      return lhsText == rhsText
    case (.unspacedBinaryOperator(let lhsText), .unspacedBinaryOperator(let rhsText)):
      return lhsText == rhsText
    case (.spacedBinaryOperator(let lhsText), .spacedBinaryOperator(let rhsText)):
      return lhsText == rhsText
    case (.postfixOperator(let lhsText), .postfixOperator(let rhsText)):
      return lhsText == rhsText
    case (.prefixOperator(let lhsText), .prefixOperator(let rhsText)):
      return lhsText == rhsText
    case (.dollarIdentifier(let lhsText), .dollarIdentifier(let rhsText)):
      return lhsText == rhsText
    case (.contextualKeyword(let lhsText), .contextualKeyword(let rhsText)):
      return lhsText == rhsText
    case (.rawStringDelimiter(let lhsText), .rawStringDelimiter(let rhsText)):
      return lhsText == rhsText
    case (.stringSegment(let lhsText), .stringSegment(let rhsText)):
      return lhsText == rhsText
    case (.stringInterpolationAnchor, .stringInterpolationAnchor): return true
    case (.yield, .yield): return true
    default: return false
    }
  }
}

extension TokenKind {
  static func fromRawValue(kind: CTokenKind,
                           textBuffer: UnsafeBufferPointer<UInt8>) -> TokenKind {
    switch kind {
    case 0: return .eof
    case 1:
      return .associatedtypeKeyword
    case 2:
      return .classKeyword
    case 3:
      return .deinitKeyword
    case 4:
      return .enumKeyword
    case 5:
      return .extensionKeyword
    case 6:
      return .funcKeyword
    case 7:
      return .importKeyword
    case 8:
      return .initKeyword
    case 9:
      return .inoutKeyword
    case 10:
      return .letKeyword
    case 11:
      return .operatorKeyword
    case 12:
      return .precedencegroupKeyword
    case 13:
      return .protocolKeyword
    case 14:
      return .structKeyword
    case 15:
      return .subscriptKeyword
    case 16:
      return .typealiasKeyword
    case 17:
      return .varKeyword
    case 18:
      return .fileprivateKeyword
    case 19:
      return .internalKeyword
    case 20:
      return .privateKeyword
    case 21:
      return .publicKeyword
    case 22:
      return .staticKeyword
    case 23:
      return .deferKeyword
    case 24:
      return .ifKeyword
    case 25:
      return .guardKeyword
    case 26:
      return .doKeyword
    case 27:
      return .repeatKeyword
    case 28:
      return .elseKeyword
    case 29:
      return .forKeyword
    case 30:
      return .inKeyword
    case 31:
      return .whileKeyword
    case 32:
      return .returnKeyword
    case 33:
      return .breakKeyword
    case 34:
      return .continueKeyword
    case 35:
      return .fallthroughKeyword
    case 36:
      return .switchKeyword
    case 37:
      return .caseKeyword
    case 38:
      return .defaultKeyword
    case 39:
      return .whereKeyword
    case 40:
      return .catchKeyword
    case 50:
      return .throwKeyword
    case 41:
      return .asKeyword
    case 42:
      return .anyKeyword
    case 43:
      return .falseKeyword
    case 44:
      return .isKeyword
    case 45:
      return .nilKeyword
    case 46:
      return .rethrowsKeyword
    case 47:
      return .superKeyword
    case 48:
      return .selfKeyword
    case 49:
      return .capitalSelfKeyword
    case 51:
      return .trueKeyword
    case 52:
      return .tryKeyword
    case 53:
      return .throwsKeyword
    case 54:
      return .__file__Keyword
    case 55:
      return .__line__Keyword
    case 56:
      return .__column__Keyword
    case 57:
      return .__function__Keyword
    case 58:
      return .__dso_handle__Keyword
    case 59:
      return .wildcardKeyword
    case 88:
      return .leftParen
    case 89:
      return .rightParen
    case 90:
      return .leftBrace
    case 91:
      return .rightBrace
    case 92:
      return .leftSquareBracket
    case 93:
      return .rightSquareBracket
    case 94:
      return .leftAngle
    case 95:
      return .rightAngle
    case 85:
      return .period
    case 87:
      return .prefixPeriod
    case 84:
      return .comma
    case 118:
      return .ellipsis
    case 82:
      return .colon
    case 83:
      return .semicolon
    case 86:
      return .equal
    case 80:
      return .atSign
    case 81:
      return .pound
    case 96:
      return .prefixAmpersand
    case 78:
      return .arrow
    case 79:
      return .backtick
    case 100:
      return .backslash
    case 99:
      return .exclamationMark
    case 97:
      return .postfixQuestionMark
    case 98:
      return .infixQuestionMark
    case 102:
      return .stringQuote
    case 120:
      return .singleQuote
    case 103:
      return .multilineStringQuote
    case 74:
      return .poundKeyPathKeyword
    case 69:
      return .poundLineKeyword
    case 73:
      return .poundSelectorKeyword
    case 68:
      return .poundFileKeyword
    case 70:
      return .poundColumnKeyword
    case 72:
      return .poundFunctionKeyword
    case 71:
      return .poundDsohandleKeyword
    case 117:
      return .poundAssertKeyword
    case 65:
      return .poundSourceLocationKeyword
    case 66:
      return .poundWarningKeyword
    case 67:
      return .poundErrorKeyword
    case 64:
      return .poundIfKeyword
    case 62:
      return .poundElseKeyword
    case 63:
      return .poundElseifKeyword
    case 61:
      return .poundEndifKeyword
    case 60:
      return .poundAvailableKeyword
    case 76:
      return .poundFileLiteralKeyword
    case 77:
      return .poundImageLiteralKeyword
    case 75:
      return .poundColorLiteralKeyword
    case 111:
      return .integerLiteral(.fromBuffer(textBuffer))
    case 112:
      return .floatingLiteral(.fromBuffer(textBuffer))
    case 113:
      return .stringLiteral(.fromBuffer(textBuffer))
    case 115:
      return .unknown(.fromBuffer(textBuffer))
    case 105:
      return .identifier(.fromBuffer(textBuffer))
    case 107:
      return .unspacedBinaryOperator(.fromBuffer(textBuffer))
    case 108:
      return .spacedBinaryOperator(.fromBuffer(textBuffer))
    case 110:
      return .postfixOperator(.fromBuffer(textBuffer))
    case 109:
      return .prefixOperator(.fromBuffer(textBuffer))
    case 106:
      return .dollarIdentifier(.fromBuffer(textBuffer))
    case 114:
      return .contextualKeyword(.fromBuffer(textBuffer))
    case 119:
      return .rawStringDelimiter(.fromBuffer(textBuffer))
    case 104:
      return .stringSegment(.fromBuffer(textBuffer))
    case 101:
      return .stringInterpolationAnchor
    case 116:
      return .yield
    default:
      if !textBuffer.isEmpty {
        // Default to an unknown token with the passed text if we don't know
        // its kind.
        return .unknown(.fromBuffer(textBuffer))
      } else {
        // If we were not passed the token's text, we cannot recover since we
        // would lose roundtripness.
        fatalError("unexpected token kind \(kind)")
      }
    }
  }

  static func hasText(kind: CTokenKind) -> Bool {
    switch kind {
    case 0: return false
    case 1:
      return false
    case 2:
      return false
    case 3:
      return false
    case 4:
      return false
    case 5:
      return false
    case 6:
      return false
    case 7:
      return false
    case 8:
      return false
    case 9:
      return false
    case 10:
      return false
    case 11:
      return false
    case 12:
      return false
    case 13:
      return false
    case 14:
      return false
    case 15:
      return false
    case 16:
      return false
    case 17:
      return false
    case 18:
      return false
    case 19:
      return false
    case 20:
      return false
    case 21:
      return false
    case 22:
      return false
    case 23:
      return false
    case 24:
      return false
    case 25:
      return false
    case 26:
      return false
    case 27:
      return false
    case 28:
      return false
    case 29:
      return false
    case 30:
      return false
    case 31:
      return false
    case 32:
      return false
    case 33:
      return false
    case 34:
      return false
    case 35:
      return false
    case 36:
      return false
    case 37:
      return false
    case 38:
      return false
    case 39:
      return false
    case 40:
      return false
    case 50:
      return false
    case 41:
      return false
    case 42:
      return false
    case 43:
      return false
    case 44:
      return false
    case 45:
      return false
    case 46:
      return false
    case 47:
      return false
    case 48:
      return false
    case 49:
      return false
    case 51:
      return false
    case 52:
      return false
    case 53:
      return false
    case 54:
      return false
    case 55:
      return false
    case 56:
      return false
    case 57:
      return false
    case 58:
      return false
    case 59:
      return false
    case 88:
      return false
    case 89:
      return false
    case 90:
      return false
    case 91:
      return false
    case 92:
      return false
    case 93:
      return false
    case 94:
      return false
    case 95:
      return false
    case 85:
      return false
    case 87:
      return false
    case 84:
      return false
    case 118:
      return false
    case 82:
      return false
    case 83:
      return false
    case 86:
      return false
    case 80:
      return false
    case 81:
      return false
    case 96:
      return false
    case 78:
      return false
    case 79:
      return false
    case 100:
      return false
    case 99:
      return false
    case 97:
      return false
    case 98:
      return false
    case 102:
      return false
    case 120:
      return false
    case 103:
      return false
    case 74:
      return false
    case 69:
      return false
    case 73:
      return false
    case 68:
      return false
    case 70:
      return false
    case 72:
      return false
    case 71:
      return false
    case 117:
      return false
    case 65:
      return false
    case 66:
      return false
    case 67:
      return false
    case 64:
      return false
    case 62:
      return false
    case 63:
      return false
    case 61:
      return false
    case 60:
      return false
    case 76:
      return false
    case 77:
      return false
    case 75:
      return false
    case 111:
      return true
    case 112:
      return true
    case 113:
      return true
    case 115:
      return true
    case 105:
      return true
    case 107:
      return true
    case 108:
      return true
    case 110:
      return true
    case 109:
      return true
    case 106:
      return true
    case 114:
      return true
    case 119:
      return true
    case 104:
      return true
    case 101:
      return false
    case 116:
      return false
    default:
      fatalError("unexpected token kind \(kind)")
    }
  }
}

/// Plain token kind value, without an associated `String` value.
internal enum RawTokenKind: CTokenKind {
  case eof = 0
  case associatedtypeKeyword = 1
  case classKeyword = 2
  case deinitKeyword = 3
  case enumKeyword = 4
  case extensionKeyword = 5
  case funcKeyword = 6
  case importKeyword = 7
  case initKeyword = 8
  case inoutKeyword = 9
  case letKeyword = 10
  case operatorKeyword = 11
  case precedencegroupKeyword = 12
  case protocolKeyword = 13
  case structKeyword = 14
  case subscriptKeyword = 15
  case typealiasKeyword = 16
  case varKeyword = 17
  case fileprivateKeyword = 18
  case internalKeyword = 19
  case privateKeyword = 20
  case publicKeyword = 21
  case staticKeyword = 22
  case deferKeyword = 23
  case ifKeyword = 24
  case guardKeyword = 25
  case doKeyword = 26
  case repeatKeyword = 27
  case elseKeyword = 28
  case forKeyword = 29
  case inKeyword = 30
  case whileKeyword = 31
  case returnKeyword = 32
  case breakKeyword = 33
  case continueKeyword = 34
  case fallthroughKeyword = 35
  case switchKeyword = 36
  case caseKeyword = 37
  case defaultKeyword = 38
  case whereKeyword = 39
  case catchKeyword = 40
  case throwKeyword = 50
  case asKeyword = 41
  case anyKeyword = 42
  case falseKeyword = 43
  case isKeyword = 44
  case nilKeyword = 45
  case rethrowsKeyword = 46
  case superKeyword = 47
  case selfKeyword = 48
  case capitalSelfKeyword = 49
  case trueKeyword = 51
  case tryKeyword = 52
  case throwsKeyword = 53
  case __file__Keyword = 54
  case __line__Keyword = 55
  case __column__Keyword = 56
  case __function__Keyword = 57
  case __dso_handle__Keyword = 58
  case wildcardKeyword = 59
  case leftParen = 88
  case rightParen = 89
  case leftBrace = 90
  case rightBrace = 91
  case leftSquareBracket = 92
  case rightSquareBracket = 93
  case leftAngle = 94
  case rightAngle = 95
  case period = 85
  case prefixPeriod = 87
  case comma = 84
  case ellipsis = 118
  case colon = 82
  case semicolon = 83
  case equal = 86
  case atSign = 80
  case pound = 81
  case prefixAmpersand = 96
  case arrow = 78
  case backtick = 79
  case backslash = 100
  case exclamationMark = 99
  case postfixQuestionMark = 97
  case infixQuestionMark = 98
  case stringQuote = 102
  case singleQuote = 120
  case multilineStringQuote = 103
  case poundKeyPathKeyword = 74
  case poundLineKeyword = 69
  case poundSelectorKeyword = 73
  case poundFileKeyword = 68
  case poundColumnKeyword = 70
  case poundFunctionKeyword = 72
  case poundDsohandleKeyword = 71
  case poundAssertKeyword = 117
  case poundSourceLocationKeyword = 65
  case poundWarningKeyword = 66
  case poundErrorKeyword = 67
  case poundIfKeyword = 64
  case poundElseKeyword = 62
  case poundElseifKeyword = 63
  case poundEndifKeyword = 61
  case poundAvailableKeyword = 60
  case poundFileLiteralKeyword = 76
  case poundImageLiteralKeyword = 77
  case poundColorLiteralKeyword = 75
  case integerLiteral = 111
  case floatingLiteral = 112
  case stringLiteral = 113
  case unknown = 115
  case identifier = 105
  case unspacedBinaryOperator = 107
  case spacedBinaryOperator = 108
  case postfixOperator = 110
  case prefixOperator = 109
  case dollarIdentifier = 106
  case contextualKeyword = 114
  case rawStringDelimiter = 119
  case stringSegment = 104
  case stringInterpolationAnchor = 101
  case yield = 116

  static func fromRawValue(_ rawValue: CTokenKind) -> RawTokenKind {
    return RawTokenKind(rawValue: rawValue)!
  }
}

extension TokenKind {
  internal func withUnsafeTokenText<Result>(
    _ body: (UnsafeTokenText) -> Result
  ) -> Result {
    switch self {
    case .eof:
      return body(.init(kind: .eof, length: 0))
    case .associatedtypeKeyword:
      let length = 14
      return body(.init(kind: .associatedtypeKeyword, length: length))
    case .classKeyword:
      let length = 5
      return body(.init(kind: .classKeyword, length: length))
    case .deinitKeyword:
      let length = 6
      return body(.init(kind: .deinitKeyword, length: length))
    case .enumKeyword:
      let length = 4
      return body(.init(kind: .enumKeyword, length: length))
    case .extensionKeyword:
      let length = 9
      return body(.init(kind: .extensionKeyword, length: length))
    case .funcKeyword:
      let length = 4
      return body(.init(kind: .funcKeyword, length: length))
    case .importKeyword:
      let length = 6
      return body(.init(kind: .importKeyword, length: length))
    case .initKeyword:
      let length = 4
      return body(.init(kind: .initKeyword, length: length))
    case .inoutKeyword:
      let length = 5
      return body(.init(kind: .inoutKeyword, length: length))
    case .letKeyword:
      let length = 3
      return body(.init(kind: .letKeyword, length: length))
    case .operatorKeyword:
      let length = 8
      return body(.init(kind: .operatorKeyword, length: length))
    case .precedencegroupKeyword:
      let length = 15
      return body(.init(kind: .precedencegroupKeyword, length: length))
    case .protocolKeyword:
      let length = 8
      return body(.init(kind: .protocolKeyword, length: length))
    case .structKeyword:
      let length = 6
      return body(.init(kind: .structKeyword, length: length))
    case .subscriptKeyword:
      let length = 9
      return body(.init(kind: .subscriptKeyword, length: length))
    case .typealiasKeyword:
      let length = 9
      return body(.init(kind: .typealiasKeyword, length: length))
    case .varKeyword:
      let length = 3
      return body(.init(kind: .varKeyword, length: length))
    case .fileprivateKeyword:
      let length = 11
      return body(.init(kind: .fileprivateKeyword, length: length))
    case .internalKeyword:
      let length = 8
      return body(.init(kind: .internalKeyword, length: length))
    case .privateKeyword:
      let length = 7
      return body(.init(kind: .privateKeyword, length: length))
    case .publicKeyword:
      let length = 6
      return body(.init(kind: .publicKeyword, length: length))
    case .staticKeyword:
      let length = 6
      return body(.init(kind: .staticKeyword, length: length))
    case .deferKeyword:
      let length = 5
      return body(.init(kind: .deferKeyword, length: length))
    case .ifKeyword:
      let length = 2
      return body(.init(kind: .ifKeyword, length: length))
    case .guardKeyword:
      let length = 5
      return body(.init(kind: .guardKeyword, length: length))
    case .doKeyword:
      let length = 2
      return body(.init(kind: .doKeyword, length: length))
    case .repeatKeyword:
      let length = 6
      return body(.init(kind: .repeatKeyword, length: length))
    case .elseKeyword:
      let length = 4
      return body(.init(kind: .elseKeyword, length: length))
    case .forKeyword:
      let length = 3
      return body(.init(kind: .forKeyword, length: length))
    case .inKeyword:
      let length = 2
      return body(.init(kind: .inKeyword, length: length))
    case .whileKeyword:
      let length = 5
      return body(.init(kind: .whileKeyword, length: length))
    case .returnKeyword:
      let length = 6
      return body(.init(kind: .returnKeyword, length: length))
    case .breakKeyword:
      let length = 5
      return body(.init(kind: .breakKeyword, length: length))
    case .continueKeyword:
      let length = 8
      return body(.init(kind: .continueKeyword, length: length))
    case .fallthroughKeyword:
      let length = 11
      return body(.init(kind: .fallthroughKeyword, length: length))
    case .switchKeyword:
      let length = 6
      return body(.init(kind: .switchKeyword, length: length))
    case .caseKeyword:
      let length = 4
      return body(.init(kind: .caseKeyword, length: length))
    case .defaultKeyword:
      let length = 7
      return body(.init(kind: .defaultKeyword, length: length))
    case .whereKeyword:
      let length = 5
      return body(.init(kind: .whereKeyword, length: length))
    case .catchKeyword:
      let length = 5
      return body(.init(kind: .catchKeyword, length: length))
    case .throwKeyword:
      let length = 5
      return body(.init(kind: .throwKeyword, length: length))
    case .asKeyword:
      let length = 2
      return body(.init(kind: .asKeyword, length: length))
    case .anyKeyword:
      let length = 3
      return body(.init(kind: .anyKeyword, length: length))
    case .falseKeyword:
      let length = 5
      return body(.init(kind: .falseKeyword, length: length))
    case .isKeyword:
      let length = 2
      return body(.init(kind: .isKeyword, length: length))
    case .nilKeyword:
      let length = 3
      return body(.init(kind: .nilKeyword, length: length))
    case .rethrowsKeyword:
      let length = 8
      return body(.init(kind: .rethrowsKeyword, length: length))
    case .superKeyword:
      let length = 5
      return body(.init(kind: .superKeyword, length: length))
    case .selfKeyword:
      let length = 4
      return body(.init(kind: .selfKeyword, length: length))
    case .capitalSelfKeyword:
      let length = 4
      return body(.init(kind: .capitalSelfKeyword, length: length))
    case .trueKeyword:
      let length = 4
      return body(.init(kind: .trueKeyword, length: length))
    case .tryKeyword:
      let length = 3
      return body(.init(kind: .tryKeyword, length: length))
    case .throwsKeyword:
      let length = 6
      return body(.init(kind: .throwsKeyword, length: length))
    case .__file__Keyword:
      let length = 8
      return body(.init(kind: .__file__Keyword, length: length))
    case .__line__Keyword:
      let length = 8
      return body(.init(kind: .__line__Keyword, length: length))
    case .__column__Keyword:
      let length = 10
      return body(.init(kind: .__column__Keyword, length: length))
    case .__function__Keyword:
      let length = 12
      return body(.init(kind: .__function__Keyword, length: length))
    case .__dso_handle__Keyword:
      let length = 14
      return body(.init(kind: .__dso_handle__Keyword, length: length))
    case .wildcardKeyword:
      let length = 1
      return body(.init(kind: .wildcardKeyword, length: length))
    case .leftParen:
      let length = 1
      return body(.init(kind: .leftParen, length: length))
    case .rightParen:
      let length = 1
      return body(.init(kind: .rightParen, length: length))
    case .leftBrace:
      let length = 1
      return body(.init(kind: .leftBrace, length: length))
    case .rightBrace:
      let length = 1
      return body(.init(kind: .rightBrace, length: length))
    case .leftSquareBracket:
      let length = 1
      return body(.init(kind: .leftSquareBracket, length: length))
    case .rightSquareBracket:
      let length = 1
      return body(.init(kind: .rightSquareBracket, length: length))
    case .leftAngle:
      let length = 1
      return body(.init(kind: .leftAngle, length: length))
    case .rightAngle:
      let length = 1
      return body(.init(kind: .rightAngle, length: length))
    case .period:
      let length = 1
      return body(.init(kind: .period, length: length))
    case .prefixPeriod:
      let length = 1
      return body(.init(kind: .prefixPeriod, length: length))
    case .comma:
      let length = 1
      return body(.init(kind: .comma, length: length))
    case .ellipsis:
      let length = 3
      return body(.init(kind: .ellipsis, length: length))
    case .colon:
      let length = 1
      return body(.init(kind: .colon, length: length))
    case .semicolon:
      let length = 1
      return body(.init(kind: .semicolon, length: length))
    case .equal:
      let length = 1
      return body(.init(kind: .equal, length: length))
    case .atSign:
      let length = 1
      return body(.init(kind: .atSign, length: length))
    case .pound:
      let length = 1
      return body(.init(kind: .pound, length: length))
    case .prefixAmpersand:
      let length = 1
      return body(.init(kind: .prefixAmpersand, length: length))
    case .arrow:
      let length = 2
      return body(.init(kind: .arrow, length: length))
    case .backtick:
      let length = 1
      return body(.init(kind: .backtick, length: length))
    case .backslash:
      let length = 1
      return body(.init(kind: .backslash, length: length))
    case .exclamationMark:
      let length = 1
      return body(.init(kind: .exclamationMark, length: length))
    case .postfixQuestionMark:
      let length = 1
      return body(.init(kind: .postfixQuestionMark, length: length))
    case .infixQuestionMark:
      let length = 1
      return body(.init(kind: .infixQuestionMark, length: length))
    case .stringQuote:
      let length = 1
      return body(.init(kind: .stringQuote, length: length))
    case .singleQuote:
      let length = 1
      return body(.init(kind: .singleQuote, length: length))
    case .multilineStringQuote:
      let length = 3
      return body(.init(kind: .multilineStringQuote, length: length))
    case .poundKeyPathKeyword:
      let length = 8
      return body(.init(kind: .poundKeyPathKeyword, length: length))
    case .poundLineKeyword:
      let length = 5
      return body(.init(kind: .poundLineKeyword, length: length))
    case .poundSelectorKeyword:
      let length = 9
      return body(.init(kind: .poundSelectorKeyword, length: length))
    case .poundFileKeyword:
      let length = 5
      return body(.init(kind: .poundFileKeyword, length: length))
    case .poundColumnKeyword:
      let length = 7
      return body(.init(kind: .poundColumnKeyword, length: length))
    case .poundFunctionKeyword:
      let length = 9
      return body(.init(kind: .poundFunctionKeyword, length: length))
    case .poundDsohandleKeyword:
      let length = 10
      return body(.init(kind: .poundDsohandleKeyword, length: length))
    case .poundAssertKeyword:
      let length = 7
      return body(.init(kind: .poundAssertKeyword, length: length))
    case .poundSourceLocationKeyword:
      let length = 15
      return body(.init(kind: .poundSourceLocationKeyword, length: length))
    case .poundWarningKeyword:
      let length = 8
      return body(.init(kind: .poundWarningKeyword, length: length))
    case .poundErrorKeyword:
      let length = 6
      return body(.init(kind: .poundErrorKeyword, length: length))
    case .poundIfKeyword:
      let length = 3
      return body(.init(kind: .poundIfKeyword, length: length))
    case .poundElseKeyword:
      let length = 5
      return body(.init(kind: .poundElseKeyword, length: length))
    case .poundElseifKeyword:
      let length = 7
      return body(.init(kind: .poundElseifKeyword, length: length))
    case .poundEndifKeyword:
      let length = 6
      return body(.init(kind: .poundEndifKeyword, length: length))
    case .poundAvailableKeyword:
      let length = 10
      return body(.init(kind: .poundAvailableKeyword, length: length))
    case .poundFileLiteralKeyword:
      let length = 12
      return body(.init(kind: .poundFileLiteralKeyword, length: length))
    case .poundImageLiteralKeyword:
      let length = 13
      return body(.init(kind: .poundImageLiteralKeyword, length: length))
    case .poundColorLiteralKeyword:
      let length = 13
      return body(.init(kind: .poundColorLiteralKeyword, length: length))
    case .integerLiteral(var text):
      text.makeNativeUTF8IfNeeded()
      let length = text.utf8.count
      return text.utf8.withContiguousStorageIfAvailable({ (buf: UnsafeBufferPointer<UInt8>) in
        return body(.init(kind: .integerLiteral, length: length, customText: buf))
      })!
    case .floatingLiteral(var text):
      text.makeNativeUTF8IfNeeded()
      let length = text.utf8.count
      return text.utf8.withContiguousStorageIfAvailable({ (buf: UnsafeBufferPointer<UInt8>) in
        return body(.init(kind: .floatingLiteral, length: length, customText: buf))
      })!
    case .stringLiteral(var text):
      text.makeNativeUTF8IfNeeded()
      let length = text.utf8.count
      return text.utf8.withContiguousStorageIfAvailable({ (buf: UnsafeBufferPointer<UInt8>) in
        return body(.init(kind: .stringLiteral, length: length, customText: buf))
      })!
    case .unknown(var text):
      text.makeNativeUTF8IfNeeded()
      let length = text.utf8.count
      return text.utf8.withContiguousStorageIfAvailable({ (buf: UnsafeBufferPointer<UInt8>) in
        return body(.init(kind: .unknown, length: length, customText: buf))
      })!
    case .identifier(var text):
      text.makeNativeUTF8IfNeeded()
      let length = text.utf8.count
      return text.utf8.withContiguousStorageIfAvailable({ (buf: UnsafeBufferPointer<UInt8>) in
        return body(.init(kind: .identifier, length: length, customText: buf))
      })!
    case .unspacedBinaryOperator(var text):
      text.makeNativeUTF8IfNeeded()
      let length = text.utf8.count
      return text.utf8.withContiguousStorageIfAvailable({ (buf: UnsafeBufferPointer<UInt8>) in
        return body(.init(kind: .unspacedBinaryOperator, length: length, customText: buf))
      })!
    case .spacedBinaryOperator(var text):
      text.makeNativeUTF8IfNeeded()
      let length = text.utf8.count
      return text.utf8.withContiguousStorageIfAvailable({ (buf: UnsafeBufferPointer<UInt8>) in
        return body(.init(kind: .spacedBinaryOperator, length: length, customText: buf))
      })!
    case .postfixOperator(var text):
      text.makeNativeUTF8IfNeeded()
      let length = text.utf8.count
      return text.utf8.withContiguousStorageIfAvailable({ (buf: UnsafeBufferPointer<UInt8>) in
        return body(.init(kind: .postfixOperator, length: length, customText: buf))
      })!
    case .prefixOperator(var text):
      text.makeNativeUTF8IfNeeded()
      let length = text.utf8.count
      return text.utf8.withContiguousStorageIfAvailable({ (buf: UnsafeBufferPointer<UInt8>) in
        return body(.init(kind: .prefixOperator, length: length, customText: buf))
      })!
    case .dollarIdentifier(var text):
      text.makeNativeUTF8IfNeeded()
      let length = text.utf8.count
      return text.utf8.withContiguousStorageIfAvailable({ (buf: UnsafeBufferPointer<UInt8>) in
        return body(.init(kind: .dollarIdentifier, length: length, customText: buf))
      })!
    case .contextualKeyword(var text):
      text.makeNativeUTF8IfNeeded()
      let length = text.utf8.count
      return text.utf8.withContiguousStorageIfAvailable({ (buf: UnsafeBufferPointer<UInt8>) in
        return body(.init(kind: .contextualKeyword, length: length, customText: buf))
      })!
    case .rawStringDelimiter(var text):
      text.makeNativeUTF8IfNeeded()
      let length = text.utf8.count
      return text.utf8.withContiguousStorageIfAvailable({ (buf: UnsafeBufferPointer<UInt8>) in
        return body(.init(kind: .rawStringDelimiter, length: length, customText: buf))
      })!
    case .stringSegment(var text):
      text.makeNativeUTF8IfNeeded()
      let length = text.utf8.count
      return text.utf8.withContiguousStorageIfAvailable({ (buf: UnsafeBufferPointer<UInt8>) in
        return body(.init(kind: .stringSegment, length: length, customText: buf))
      })!
    case .stringInterpolationAnchor:
      let length = 1
      return body(.init(kind: .stringInterpolationAnchor, length: length))
    case .yield:
      let length = 5
      return body(.init(kind: .yield, length: length))
    }
  }
}
