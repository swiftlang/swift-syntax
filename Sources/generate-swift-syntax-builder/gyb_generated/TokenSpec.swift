//// Automatically Generated From Tokens.swift.gyb.
//// Do Not Edit Directly!
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

/// Represents the specification for a Token in the TokenSyntax file.
class TokenSpec {
  let name: String
  let kind: String
  let serializationCode: Int
  let unprefixedKind: String
  let text: String?
  let classification: String
  let isKeyword: Bool

  var swiftKind: String {
    let name = lowercaseFirstWord(name: self.name)

    if isKeyword {
      return name + "Keyword"
    } else {
      return name
    }
  }

  init(name: String, kind: String, serializationCode: Int, unprefixedKind: String? = nil, text: String? = nil, classification: String = "None", isKeyword: Bool = false) {
    self.name = name
    self.kind = kind
    self.serializationCode = serializationCode
    if let unprefixedKind = unprefixedKind {
      self.unprefixedKind = unprefixedKind
    } else {
      self.unprefixedKind = kind
    }
    self.text = text
    self.classification = classification
    self.isKeyword = isKeyword
  }
}

/// Represents a keyword token.
class KeywordSpec: TokenSpec {
  init(name: String, serializationCode: Int, text: String, classification: String = "Keyword") {
    super.init(name: name, kind: "kw_\(text)", serializationCode: serializationCode, unprefixedKind: text, text: text, classification: classification, isKeyword: true)
  }
}

class SwiftKeywordSpec: KeywordSpec { }

class DeclKeywordSpec: SwiftKeywordSpec { }

class StmtKeywordSpec: SwiftKeywordSpec { }

class ExprKeywordSpec: SwiftKeywordSpec { }

class PatternKeywordSpec: SwiftKeywordSpec { }

class SilKeywordSpec: KeywordSpec { }

class PoundKeywordSpec: TokenSpec {
  init(name: String, kind: String, serializationCode: Int, text: String, classification: String = "Keyword") {
    super.init(name: name, kind: "pound_\(kind)", serializationCode: serializationCode, unprefixedKind: kind, text: text, classification: classification, isKeyword: true)
  }
}

class PoundObjectLiteralSpec: PoundKeywordSpec {
  let description: String
  let `protocol`: String

  init(name: String, kind: String, serializationCode: Int, text: String, classification: String = "ObjectLiteral", description: String, `protocol`: String) {
    self.description = `description`
    self.`protocol` = `protocol`
    super.init(name: name, kind: kind, serializationCode: serializationCode, text: text, classification: classification)
  }
}

class PoundConfigSpec: PoundKeywordSpec { }

class PoundDirectiveKeywordSpec: PoundKeywordSpec {
  override init(name: String, kind: String, serializationCode: Int, text: String, classification: String = "PoundDirectiveKeyword") {
    super.init(name: name, kind: kind, serializationCode: serializationCode, text: text, classification: classification)
  }
}

class PoundConditionalDirectiveKeywordSpec: PoundDirectiveKeywordSpec {
  override init(name: String, kind: String, serializationCode: Int, text: String, classification: String = "PoundDirectiveKeyword") {
    super.init(name: name, kind: kind, serializationCode: serializationCode, text: text, classification: classification)
  }
}

class PunctuatorSpec: TokenSpec { }

class LiteralSpec: TokenSpec { }

class MiscSpec: TokenSpec { }

let SYNTAX_TOKENS: [TokenSpec] = [
  DeclKeywordSpec(name: "Associatedtype", serializationCode: 1, text: "associatedtype"),
  DeclKeywordSpec(name: "Class", serializationCode: 2, text: "class"),
  DeclKeywordSpec(name: "Deinit", serializationCode: 3, text: "deinit"),
  DeclKeywordSpec(name: "Enum", serializationCode: 4, text: "enum"),
  DeclKeywordSpec(name: "Extension", serializationCode: 5, text: "extension"),
  DeclKeywordSpec(name: "Func", serializationCode: 6, text: "func"),
  DeclKeywordSpec(name: "Import", serializationCode: 7, text: "import"),
  DeclKeywordSpec(name: "Init", serializationCode: 8, text: "init"),
  DeclKeywordSpec(name: "Inout", serializationCode: 9, text: "inout"),
  DeclKeywordSpec(name: "Let", serializationCode: 10, text: "let"),
  DeclKeywordSpec(name: "Operator", serializationCode: 11, text: "operator"),
  DeclKeywordSpec(name: "Precedencegroup", serializationCode: 12, text: "precedencegroup"),
  DeclKeywordSpec(name: "Protocol", serializationCode: 13, text: "protocol"),
  DeclKeywordSpec(name: "Struct", serializationCode: 14, text: "struct"),
  DeclKeywordSpec(name: "Subscript", serializationCode: 15, text: "subscript"),
  DeclKeywordSpec(name: "Typealias", serializationCode: 16, text: "typealias"),
  DeclKeywordSpec(name: "Var", serializationCode: 17, text: "var"),
  DeclKeywordSpec(name: "Fileprivate", serializationCode: 18, text: "fileprivate"),
  DeclKeywordSpec(name: "Internal", serializationCode: 19, text: "internal"),
  DeclKeywordSpec(name: "Private", serializationCode: 20, text: "private"),
  DeclKeywordSpec(name: "Public", serializationCode: 21, text: "public"),
  DeclKeywordSpec(name: "Static", serializationCode: 22, text: "static"),
  StmtKeywordSpec(name: "Defer", serializationCode: 23, text: "defer"),
  StmtKeywordSpec(name: "If", serializationCode: 24, text: "if"),
  StmtKeywordSpec(name: "Guard", serializationCode: 25, text: "guard"),
  StmtKeywordSpec(name: "Do", serializationCode: 26, text: "do"),
  StmtKeywordSpec(name: "Repeat", serializationCode: 27, text: "repeat"),
  StmtKeywordSpec(name: "Else", serializationCode: 28, text: "else"),
  StmtKeywordSpec(name: "For", serializationCode: 29, text: "for"),
  StmtKeywordSpec(name: "In", serializationCode: 30, text: "in"),
  StmtKeywordSpec(name: "While", serializationCode: 31, text: "while"),
  StmtKeywordSpec(name: "Return", serializationCode: 32, text: "return"),
  StmtKeywordSpec(name: "Break", serializationCode: 33, text: "break"),
  StmtKeywordSpec(name: "Continue", serializationCode: 34, text: "continue"),
  StmtKeywordSpec(name: "Fallthrough", serializationCode: 35, text: "fallthrough"),
  StmtKeywordSpec(name: "Switch", serializationCode: 36, text: "switch"),
  StmtKeywordSpec(name: "Case", serializationCode: 37, text: "case"),
  StmtKeywordSpec(name: "Default", serializationCode: 38, text: "default"),
  StmtKeywordSpec(name: "Where", serializationCode: 39, text: "where"),
  StmtKeywordSpec(name: "Catch", serializationCode: 40, text: "catch"),
  StmtKeywordSpec(name: "Throw", serializationCode: 50, text: "throw"),
  ExprKeywordSpec(name: "As", serializationCode: 41, text: "as"),
  ExprKeywordSpec(name: "Any", serializationCode: 42, text: "Any"),
  ExprKeywordSpec(name: "False", serializationCode: 43, text: "false"),
  ExprKeywordSpec(name: "Is", serializationCode: 44, text: "is"),
  ExprKeywordSpec(name: "Nil", serializationCode: 45, text: "nil"),
  ExprKeywordSpec(name: "Rethrows", serializationCode: 46, text: "rethrows"),
  ExprKeywordSpec(name: "Super", serializationCode: 47, text: "super"),
  ExprKeywordSpec(name: "Self", serializationCode: 48, text: "self"),
  ExprKeywordSpec(name: "CapitalSelf", serializationCode: 49, text: "Self"),
  ExprKeywordSpec(name: "True", serializationCode: 51, text: "true"),
  ExprKeywordSpec(name: "Try", serializationCode: 52, text: "try"),
  ExprKeywordSpec(name: "Throws", serializationCode: 53, text: "throws"),
  KeywordSpec(name: "__FILE__", serializationCode: 54, text: "__FILE__"),
  KeywordSpec(name: "__LINE__", serializationCode: 55, text: "__LINE__"),
  KeywordSpec(name: "__COLUMN__", serializationCode: 56, text: "__COLUMN__"),
  KeywordSpec(name: "__FUNCTION__", serializationCode: 57, text: "__FUNCTION__"),
  KeywordSpec(name: "__DSO_HANDLE__", serializationCode: 58, text: "__DSO_HANDLE__"),
  PatternKeywordSpec(name: "Wildcard", serializationCode: 59, text: "_"),
  PunctuatorSpec(name: "LeftParen", kind: "l_paren", serializationCode: 88, text: "("),
  PunctuatorSpec(name: "RightParen", kind: "r_paren", serializationCode: 89, text: ")"),
  PunctuatorSpec(name: "LeftBrace", kind: "l_brace", serializationCode: 90, text: "{"),
  PunctuatorSpec(name: "RightBrace", kind: "r_brace", serializationCode: 91, text: "}"),
  PunctuatorSpec(name: "LeftSquareBracket", kind: "l_square", serializationCode: 92, text: "["),
  PunctuatorSpec(name: "RightSquareBracket", kind: "r_square", serializationCode: 93, text: "]"),
  PunctuatorSpec(name: "LeftAngle", kind: "l_angle", serializationCode: 94, text: "<"),
  PunctuatorSpec(name: "RightAngle", kind: "r_angle", serializationCode: 95, text: ">"),
  PunctuatorSpec(name: "Period", kind: "period", serializationCode: 85, text: "."),
  PunctuatorSpec(name: "PrefixPeriod", kind: "period_prefix", serializationCode: 87, text: "."),
  PunctuatorSpec(name: "Comma", kind: "comma", serializationCode: 84, text: ","),
  PunctuatorSpec(name: "Ellipsis", kind: "ellipsis", serializationCode: 118, text: "..."),
  PunctuatorSpec(name: "Colon", kind: "colon", serializationCode: 82, text: ":"),
  PunctuatorSpec(name: "Semicolon", kind: "semi", serializationCode: 83, text: ";"),
  PunctuatorSpec(name: "Equal", kind: "equal", serializationCode: 86, text: "="),
  PunctuatorSpec(name: "AtSign", kind: "at_sign", serializationCode: 80, text: "@"),
  PunctuatorSpec(name: "Pound", kind: "pound", serializationCode: 81, text: "#"),
  PunctuatorSpec(name: "PrefixAmpersand", kind: "amp_prefix", serializationCode: 96, text: "&"),
  PunctuatorSpec(name: "Arrow", kind: "arrow", serializationCode: 78, text: "->"),
  PunctuatorSpec(name: "Backtick", kind: "backtick", serializationCode: 79, text: "`"),
  PunctuatorSpec(name: "Backslash", kind: "backslash", serializationCode: 100, text: "\\"),
  PunctuatorSpec(name: "ExclamationMark", kind: "exclaim_postfix", serializationCode: 99, text: "!"),
  PunctuatorSpec(name: "PostfixQuestionMark", kind: "question_postfix", serializationCode: 97, text: "?"),
  PunctuatorSpec(name: "InfixQuestionMark", kind: "question_infix", serializationCode: 98, text: "?"),
  PunctuatorSpec(name: "StringQuote", kind: "string_quote", serializationCode: 102, text: "\""),
  PunctuatorSpec(name: "SingleQuote", kind: "single_quote", serializationCode: 120, text: "\'"),
  PunctuatorSpec(name: "MultilineStringQuote", kind: "multiline_string_quote", serializationCode: 103, text: "\"\"\""),
  PoundKeywordSpec(name: "PoundKeyPath", kind: "pound_keyPath", serializationCode: 74, text: "#keyPath"),
  PoundKeywordSpec(name: "PoundLine", kind: "pound_line", serializationCode: 69, text: "#line"),
  PoundKeywordSpec(name: "PoundSelector", kind: "pound_selector", serializationCode: 73, text: "#selector"),
  PoundKeywordSpec(name: "PoundFile", kind: "pound_file", serializationCode: 68, text: "#file"),
  PoundKeywordSpec(name: "PoundFileID", kind: "pound_fileID", serializationCode: 122, text: "#fileID"),
  PoundKeywordSpec(name: "PoundFilePath", kind: "pound_filePath", serializationCode: 121, text: "#filePath"),
  PoundKeywordSpec(name: "PoundColumn", kind: "pound_column", serializationCode: 70, text: "#column"),
  PoundKeywordSpec(name: "PoundFunction", kind: "pound_function", serializationCode: 72, text: "#function"),
  PoundKeywordSpec(name: "PoundDsohandle", kind: "pound_dsohandle", serializationCode: 71, text: "#dsohandle"),
  PoundKeywordSpec(name: "PoundAssert", kind: "pound_assert", serializationCode: 117, text: "#assert"),
  PoundDirectiveKeywordSpec(name: "PoundSourceLocation", kind: "pound_sourceLocation", serializationCode: 65, text: "#sourceLocation"),
  PoundDirectiveKeywordSpec(name: "PoundWarning", kind: "pound_warning", serializationCode: 66, text: "#warning"),
  PoundDirectiveKeywordSpec(name: "PoundError", kind: "pound_error", serializationCode: 67, text: "#error"),
  PoundConditionalDirectiveKeywordSpec(name: "PoundIf", kind: "pound_if", serializationCode: 64, text: "#if"),
  PoundConditionalDirectiveKeywordSpec(name: "PoundElse", kind: "pound_else", serializationCode: 62, text: "#else"),
  PoundConditionalDirectiveKeywordSpec(name: "PoundElseif", kind: "pound_elseif", serializationCode: 63, text: "#elseif"),
  PoundConditionalDirectiveKeywordSpec(name: "PoundEndif", kind: "pound_endif", serializationCode: 61, text: "#endif"),
  PoundConfigSpec(name: "PoundAvailable", kind: "pound_available", serializationCode: 60, text: "#available"),
  PoundConfigSpec(name: "PoundUnavailable", kind: "pound_unavailable", serializationCode: 123, text: "#unavailable"),
  PoundObjectLiteralSpec(name: "PoundFileLiteral", kind: "pound_fileLiteral", serializationCode: 76, text: "#fileLiteral", description: "file reference", protocol: "ExpressibleByFileReferenceLiteral"),
  PoundObjectLiteralSpec(name: "PoundImageLiteral", kind: "pound_imageLiteral", serializationCode: 77, text: "#imageLiteral", description: "image", protocol: "ExpressibleByImageLiteral"),
  PoundObjectLiteralSpec(name: "PoundColorLiteral", kind: "pound_colorLiteral", serializationCode: 75, text: "#colorLiteral", description: "color", protocol: "ExpressibleByColorLiteral"),
  LiteralSpec(name: "IntegerLiteral", kind: "integer_literal", serializationCode: 111),
  LiteralSpec(name: "FloatingLiteral", kind: "floating_literal", serializationCode: 112),
  LiteralSpec(name: "StringLiteral", kind: "string_literal", serializationCode: 113),
  LiteralSpec(name: "RegexLiteral", kind: "regex_literal", serializationCode: 124),
  MiscSpec(name: "Unknown", kind: "unknown", serializationCode: 115),
  MiscSpec(name: "Identifier", kind: "identifier", serializationCode: 105),
  MiscSpec(name: "UnspacedBinaryOperator", kind: "oper_binary_unspaced", serializationCode: 107),
  MiscSpec(name: "SpacedBinaryOperator", kind: "oper_binary_spaced", serializationCode: 108),
  MiscSpec(name: "PostfixOperator", kind: "oper_postfix", serializationCode: 110),
  MiscSpec(name: "PrefixOperator", kind: "oper_prefix", serializationCode: 109),
  MiscSpec(name: "DollarIdentifier", kind: "dollarident", serializationCode: 106),
  MiscSpec(name: "ContextualKeyword", kind: "contextual_keyword", serializationCode: 114),
  MiscSpec(name: "RawStringDelimiter", kind: "raw_string_delimiter", serializationCode: 119),
  MiscSpec(name: "StringSegment", kind: "string_segment", serializationCode: 104),
  MiscSpec(name: "StringInterpolationAnchor", kind: "string_interpolation_anchor", serializationCode: 101, text: ")"),
  MiscSpec(name: "Yield", kind: "kw_yield", serializationCode: 116, text: "yield"),
]

let SYNTAX_TOKEN_MAP = Dictionary(uniqueKeysWithValues: SYNTAX_TOKENS.map { ("\($0.name)Token", $0) })
