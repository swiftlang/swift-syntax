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
public class TokenSpec {
  public let name: String
  public let kind: String
  public let serializationCode: Int
  public let nameForDiagnostics: String
  public let unprefixedKind: String
  public let text: String?
  public let classification: String
  public let isKeyword: Bool
  public let requiresLeadingSpace: Bool
  public let requiresTrailingSpace: Bool

  public var swiftKind: String {
    let name = lowercaseFirstWord(name: self.name)

    if isKeyword {
      return name + "Keyword"
    } else {
      return name
    }
  }

  init(
    name: String,
    kind: String,
    serializationCode: Int,
    nameForDiagnostics: String,
    unprefixedKind: String? = nil,
    text: String? = nil,
    classification: String = "None",
    isKeyword: Bool = false,
    requiresLeadingSpace: Bool = false,
    requiresTrailingSpace: Bool = false
  ) {
    self.name = name
    self.kind = kind
    self.serializationCode = serializationCode
    self.nameForDiagnostics = nameForDiagnostics
    if let unprefixedKind = unprefixedKind {
      self.unprefixedKind = unprefixedKind
    } else {
      self.unprefixedKind = kind
    }
    self.text = text
    self.classification = classification
    self.isKeyword = isKeyword
    self.requiresLeadingSpace = requiresLeadingSpace
    self.requiresTrailingSpace = requiresTrailingSpace
  }
}

/// Represents a keyword token.
public class KeywordSpec: TokenSpec {
  init(
    name: String,
    serializationCode: Int,
    text: String,
    classification: String = "Keyword",
    requiresLeadingSpace: Bool = false,
    requiresTrailingSpace: Bool = false
  ) {
    super.init(
      name: name,
      kind: "kw_\(text)",
      serializationCode: serializationCode,
      nameForDiagnostics: text,
      unprefixedKind: text,
      text: text,
      classification: classification,
      isKeyword: true,
      requiresLeadingSpace: requiresLeadingSpace,
      requiresTrailingSpace: requiresTrailingSpace
    )
  }
}

public class SwiftKeywordSpec: KeywordSpec { }

public class DeclKeywordSpec: SwiftKeywordSpec { }

public class StmtKeywordSpec: SwiftKeywordSpec { }

public class ExprKeywordSpec: SwiftKeywordSpec { }

public class PatternKeywordSpec: SwiftKeywordSpec { }

public class SilKeywordSpec: KeywordSpec { }

public class PoundKeywordSpec: TokenSpec {
  init(
    name: String,
    kind: String,
    serializationCode: Int,
    nameForDiagnostics: String? = nil,
    text: String,
    classification: String = "Keyword"
  ) {
    super.init(
      name: name,
      kind: "pound_\(kind)",
      serializationCode: serializationCode,
      nameForDiagnostics: nameForDiagnostics ?? text,
      unprefixedKind: kind,
      text: text,
      classification: classification,
      isKeyword: true,
      requiresTrailingSpace: true
    )
  }
}

public class PoundObjectLiteralSpec: PoundKeywordSpec {
  let `protocol`: String

  init(
    name: String,
    kind: String,
    serializationCode: Int,
    text: String,
    classification: String = "ObjectLiteral",
    nameForDiagnostics: String,
    `protocol`: String
  ) {
    self.`protocol` = `protocol`
    super.init(
      name: name,
      kind: kind,
      serializationCode: serializationCode,
      nameForDiagnostics: nameForDiagnostics,
      text: text,
      classification: classification
    )
  }
}

public class PoundConfigSpec: PoundKeywordSpec { }

public class PoundDirectiveKeywordSpec: PoundKeywordSpec {
  init(
    name: String,
    kind: String,
    serializationCode: Int,
    text: String,
    classification: String = "PoundDirectiveKeyword"
  ) {
    super.init(
      name: name,
      kind: kind,
      serializationCode: serializationCode,
      text: text,
      classification: classification
    )
  }
}

public class PoundConditionalDirectiveKeywordSpec: PoundDirectiveKeywordSpec {
  override init(
    name: String,
    kind: String,
    serializationCode: Int,
    text: String,
    classification: String = "PoundDirectiveKeyword"
  ) {
    super.init(
      name: name,
      kind: kind,
      serializationCode: serializationCode,
      text: text,
      classification: classification
    )
  }
}

public class PunctuatorSpec: TokenSpec {
  init(
    name: String,
    kind: String,
    serializationCode: Int,
    text: String,
    classification: String = "None",
    requiresLeadingSpace: Bool = false,
    requiresTrailingSpace: Bool = false
  ) {
    super.init(
      name: name,
      kind: kind,
      serializationCode: serializationCode,
      nameForDiagnostics: text,
      unprefixedKind: nil,
      text: text,
      classification: classification,
      isKeyword: false,
      requiresLeadingSpace: requiresLeadingSpace,
      requiresTrailingSpace: requiresTrailingSpace
    )
  }
}

public class LiteralSpec: TokenSpec { }

public class MiscSpec: TokenSpec { }

public let SYNTAX_TOKENS: [TokenSpec] = [
  DeclKeywordSpec(name: "Associatedtype", serializationCode: 1, text: "associatedtype", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Class", serializationCode: 2, text: "class", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Deinit", serializationCode: 3, text: "deinit", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Enum", serializationCode: 4, text: "enum", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Extension", serializationCode: 5, text: "extension", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Func", serializationCode: 6, text: "func", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Import", serializationCode: 7, text: "import", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Init", serializationCode: 8, text: "init", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Inout", serializationCode: 9, text: "inout", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Let", serializationCode: 10, text: "let", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Operator", serializationCode: 11, text: "operator", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Precedencegroup", serializationCode: 12, text: "precedencegroup", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Protocol", serializationCode: 13, text: "protocol", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Struct", serializationCode: 14, text: "struct", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Subscript", serializationCode: 15, text: "subscript", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Typealias", serializationCode: 16, text: "typealias", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Var", serializationCode: 17, text: "var", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Fileprivate", serializationCode: 18, text: "fileprivate", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Internal", serializationCode: 19, text: "internal", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Private", serializationCode: 20, text: "private", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Public", serializationCode: 21, text: "public", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Static", serializationCode: 22, text: "static", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "Defer", serializationCode: 23, text: "defer", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "If", serializationCode: 24, text: "if", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "Guard", serializationCode: 25, text: "guard", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "Do", serializationCode: 26, text: "do"),
  StmtKeywordSpec(name: "Repeat", serializationCode: 27, text: "repeat", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "Else", serializationCode: 28, text: "else", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "For", serializationCode: 29, text: "for", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "In", serializationCode: 30, text: "in", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "While", serializationCode: 31, text: "while", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "Return", serializationCode: 32, text: "return", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "Break", serializationCode: 33, text: "break", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "Continue", serializationCode: 34, text: "continue", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "Fallthrough", serializationCode: 35, text: "fallthrough", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "Switch", serializationCode: 36, text: "switch", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "Case", serializationCode: 37, text: "case", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "Default", serializationCode: 38, text: "default", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "Where", serializationCode: 39, text: "where", requiresLeadingSpace: true, requiresTrailingSpace: true),
  StmtKeywordSpec(name: "Catch", serializationCode: 40, text: "catch", requiresLeadingSpace: true),
  StmtKeywordSpec(name: "Throw", serializationCode: 50, text: "throw", requiresTrailingSpace: true),
  ExprKeywordSpec(name: "As", serializationCode: 41, text: "as", requiresTrailingSpace: true),
  ExprKeywordSpec(name: "Any", serializationCode: 42, text: "Any", requiresTrailingSpace: true),
  ExprKeywordSpec(name: "False", serializationCode: 43, text: "false"),
  ExprKeywordSpec(name: "Is", serializationCode: 44, text: "is", requiresTrailingSpace: true),
  ExprKeywordSpec(name: "Nil", serializationCode: 45, text: "nil"),
  ExprKeywordSpec(name: "Rethrows", serializationCode: 46, text: "rethrows", requiresTrailingSpace: true),
  ExprKeywordSpec(name: "Super", serializationCode: 47, text: "super"),
  ExprKeywordSpec(name: "Self", serializationCode: 48, text: "self"),
  ExprKeywordSpec(name: "CapitalSelf", serializationCode: 49, text: "Self"),
  ExprKeywordSpec(name: "True", serializationCode: 51, text: "true"),
  ExprKeywordSpec(name: "Try", serializationCode: 52, text: "try", requiresTrailingSpace: true),
  ExprKeywordSpec(name: "Throws", serializationCode: 53, text: "throws", requiresTrailingSpace: true),
  KeywordSpec(name: "__FILE__", serializationCode: 54, text: "__FILE__", requiresTrailingSpace: true),
  KeywordSpec(name: "__LINE__", serializationCode: 55, text: "__LINE__", requiresTrailingSpace: true),
  KeywordSpec(name: "__COLUMN__", serializationCode: 56, text: "__COLUMN__", requiresTrailingSpace: true),
  KeywordSpec(name: "__FUNCTION__", serializationCode: 57, text: "__FUNCTION__", requiresTrailingSpace: true),
  KeywordSpec(name: "__DSO_HANDLE__", serializationCode: 58, text: "__DSO_HANDLE__", requiresTrailingSpace: true),
  PatternKeywordSpec(name: "Wildcard", serializationCode: 59, text: "_", requiresTrailingSpace: true),
  PunctuatorSpec(name: "LeftParen", kind: "l_paren", serializationCode: 88, text: "("),
  PunctuatorSpec(name: "RightParen", kind: "r_paren", serializationCode: 89, text: ")"),
  PunctuatorSpec(name: "LeftBrace", kind: "l_brace", serializationCode: 90, text: "{", requiresLeadingSpace: true),
  PunctuatorSpec(name: "RightBrace", kind: "r_brace", serializationCode: 91, text: "}"),
  PunctuatorSpec(name: "LeftSquareBracket", kind: "l_square", serializationCode: 92, text: "["),
  PunctuatorSpec(name: "RightSquareBracket", kind: "r_square", serializationCode: 93, text: "]"),
  PunctuatorSpec(name: "LeftAngle", kind: "l_angle", serializationCode: 94, text: "<", requiresLeadingSpace: true, requiresTrailingSpace: true),
  PunctuatorSpec(name: "RightAngle", kind: "r_angle", serializationCode: 95, text: ">", requiresLeadingSpace: true, requiresTrailingSpace: true),
  PunctuatorSpec(name: "Period", kind: "period", serializationCode: 85, text: "."),
  PunctuatorSpec(name: "PrefixPeriod", kind: "period_prefix", serializationCode: 87, text: "."),
  PunctuatorSpec(name: "Comma", kind: "comma", serializationCode: 84, text: ",", requiresTrailingSpace: true),
  PunctuatorSpec(name: "Ellipsis", kind: "ellipsis", serializationCode: 118, text: "..."),
  PunctuatorSpec(name: "Colon", kind: "colon", serializationCode: 82, text: ":", requiresTrailingSpace: true),
  PunctuatorSpec(name: "Semicolon", kind: "semi", serializationCode: 83, text: ";"),
  PunctuatorSpec(name: "Equal", kind: "equal", serializationCode: 86, text: "=", requiresLeadingSpace: true, requiresTrailingSpace: true),
  PunctuatorSpec(name: "AtSign", kind: "at_sign", serializationCode: 80, text: "@"),
  PunctuatorSpec(name: "Pound", kind: "pound", serializationCode: 81, text: "#"),
  PunctuatorSpec(name: "PrefixAmpersand", kind: "amp_prefix", serializationCode: 96, text: "&", requiresLeadingSpace: true, requiresTrailingSpace: true),
  PunctuatorSpec(name: "Arrow", kind: "arrow", serializationCode: 78, text: "->", requiresLeadingSpace: true, requiresTrailingSpace: true),
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
  PoundObjectLiteralSpec(name: "PoundFileLiteral", kind: "pound_fileLiteral", serializationCode: 76, text: "#fileLiteral", nameForDiagnostics: "file reference", protocol: "ExpressibleByFileReferenceLiteral"),
  PoundObjectLiteralSpec(name: "PoundImageLiteral", kind: "pound_imageLiteral", serializationCode: 77, text: "#imageLiteral", nameForDiagnostics: "image", protocol: "ExpressibleByImageLiteral"),
  PoundObjectLiteralSpec(name: "PoundColorLiteral", kind: "pound_colorLiteral", serializationCode: 75, text: "#colorLiteral", nameForDiagnostics: "color", protocol: "ExpressibleByColorLiteral"),
  PoundConfigSpec(name: "PoundHasSymbol", kind: "pound__hasSymbol", serializationCode: 125, text: "#_hasSymbol"),
  LiteralSpec(name: "IntegerLiteral", kind: "integer_literal", serializationCode: 111, nameForDiagnostics: "integer literal"),
  LiteralSpec(name: "FloatingLiteral", kind: "floating_literal", serializationCode: 112, nameForDiagnostics: "floating literal"),
  LiteralSpec(name: "StringLiteral", kind: "string_literal", serializationCode: 113, nameForDiagnostics: "string literal"),
  LiteralSpec(name: "RegexLiteral", kind: "regex_literal", serializationCode: 124, nameForDiagnostics: "regex literal"),
  MiscSpec(name: "Unknown", kind: "unknown", serializationCode: 115, nameForDiagnostics: "token"),
  MiscSpec(name: "Identifier", kind: "identifier", serializationCode: 105, nameForDiagnostics: "identifier"),
  MiscSpec(name: "UnspacedBinaryOperator", kind: "oper_binary_unspaced", serializationCode: 107, nameForDiagnostics: "binary operator"),
  MiscSpec(name: "SpacedBinaryOperator", kind: "oper_binary_spaced", serializationCode: 108, nameForDiagnostics: "binary operator", requiresLeadingSpace: true, requiresTrailingSpace: true),
  MiscSpec(name: "PostfixOperator", kind: "oper_postfix", serializationCode: 110, nameForDiagnostics: "postfix operator"),
  MiscSpec(name: "PrefixOperator", kind: "oper_prefix", serializationCode: 109, nameForDiagnostics: "prefix operator"),
  MiscSpec(name: "DollarIdentifier", kind: "dollarident", serializationCode: 106, nameForDiagnostics: "dollar identifier"),
  MiscSpec(name: "ContextualKeyword", kind: "contextual_keyword", serializationCode: 114, nameForDiagnostics: "keyword"),
  MiscSpec(name: "RawStringDelimiter", kind: "raw_string_delimiter", serializationCode: 119, nameForDiagnostics: "raw string delimiter"),
  MiscSpec(name: "StringSegment", kind: "string_segment", serializationCode: 104, nameForDiagnostics: "string segment"),
  MiscSpec(name: "StringInterpolationAnchor", kind: "string_interpolation_anchor", serializationCode: 101, nameForDiagnostics: "string interpolation anchor", text: ")"),
  MiscSpec(name: "Yield", kind: "kw_yield", serializationCode: 116, nameForDiagnostics: "yield", text: "yield"),
]

public let SYNTAX_TOKEN_MAP = Dictionary(uniqueKeysWithValues: SYNTAX_TOKENS.map { ("\($0.name)Token", $0) })
