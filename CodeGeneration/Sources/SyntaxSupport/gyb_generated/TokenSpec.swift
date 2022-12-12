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
  public let nameForDiagnostics: String
  public let unprefixedKind: String
  public let text: String?
  public let classification: SyntaxClassification?
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
    self.nameForDiagnostics = nameForDiagnostics
    if let unprefixedKind = unprefixedKind {
      self.unprefixedKind = unprefixedKind
    } else {
      self.unprefixedKind = kind
    }
    self.text = text
    self.classification = classificationByName(classification)
    self.isKeyword = isKeyword
    self.requiresLeadingSpace = requiresLeadingSpace
    self.requiresTrailingSpace = requiresTrailingSpace
  }
}

/// Represents a keyword token.
public class KeywordSpec: TokenSpec {
  init(
    name: String,
    text: String,
    classification: String = "Keyword",
    requiresLeadingSpace: Bool = false,
    requiresTrailingSpace: Bool = false
  ) {
    super.init(
      name: name,
      kind: "kw_\(text)",
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
    nameForDiagnostics: String? = nil,
    text: String,
    classification: String = "Keyword"
  ) {
    super.init(
      name: name,
      kind: "pound_\(kind)",
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
    text: String,
    classification: String = "ObjectLiteral",
    nameForDiagnostics: String,
    `protocol`: String
  ) {
    self.`protocol` = `protocol`
    super.init(
      name: name,
      kind: kind,
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
    text: String,
    classification: String = "PoundDirectiveKeyword"
  ) {
    super.init(
      name: name,
      kind: kind,
      text: text,
      classification: classification
    )
  }
}

public class PoundConditionalDirectiveKeywordSpec: PoundDirectiveKeywordSpec {
  override init(
    name: String,
    kind: String,
    text: String,
    classification: String = "PoundDirectiveKeyword"
  ) {
    super.init(
      name: name,
      kind: kind,
      text: text,
      classification: classification
    )
  }
}

public class PunctuatorSpec: TokenSpec {
  init(
    name: String,
    kind: String,
    text: String,
    classification: String = "None",
    requiresLeadingSpace: Bool = false,
    requiresTrailingSpace: Bool = false
  ) {
    super.init(
      name: name,
      kind: kind,
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
  DeclKeywordSpec(name: "Associatedtype", text: "associatedtype", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Class", text: "class", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Deinit", text: "deinit", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Enum", text: "enum", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Extension", text: "extension", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Func", text: "func", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Import", text: "import", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Init", text: "init", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Inout", text: "inout", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Let", text: "let", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Operator", text: "operator", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Precedencegroup", text: "precedencegroup", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Protocol", text: "protocol", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Struct", text: "struct", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Subscript", text: "subscript", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Typealias", text: "typealias", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Var", text: "var", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Fileprivate", text: "fileprivate", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Internal", text: "internal", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Private", text: "private", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Public", text: "public", requiresTrailingSpace: true),
  DeclKeywordSpec(name: "Static", text: "static", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "Defer", text: "defer", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "If", text: "if", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "Guard", text: "guard", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "Do", text: "do"),
  StmtKeywordSpec(name: "Repeat", text: "repeat", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "Else", text: "else", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "For", text: "for", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "In", text: "in", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "While", text: "while", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "Return", text: "return", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "Break", text: "break", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "Continue", text: "continue", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "Fallthrough", text: "fallthrough", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "Switch", text: "switch", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "Case", text: "case", requiresTrailingSpace: true),
  StmtKeywordSpec(name: "Default", text: "default"),
  StmtKeywordSpec(name: "Where", text: "where", requiresLeadingSpace: true, requiresTrailingSpace: true),
  StmtKeywordSpec(name: "Catch", text: "catch", requiresLeadingSpace: true),
  StmtKeywordSpec(name: "Throw", text: "throw", requiresTrailingSpace: true),
  ExprKeywordSpec(name: "As", text: "as", requiresTrailingSpace: true),
  ExprKeywordSpec(name: "Any", text: "Any", requiresTrailingSpace: true),
  ExprKeywordSpec(name: "False", text: "false"),
  ExprKeywordSpec(name: "Is", text: "is", requiresTrailingSpace: true),
  ExprKeywordSpec(name: "Nil", text: "nil"),
  ExprKeywordSpec(name: "Rethrows", text: "rethrows", requiresTrailingSpace: true),
  ExprKeywordSpec(name: "Super", text: "super"),
  ExprKeywordSpec(name: "Self", text: "self"),
  ExprKeywordSpec(name: "CapitalSelf", text: "Self"),
  ExprKeywordSpec(name: "True", text: "true"),
  ExprKeywordSpec(name: "Try", text: "try", requiresTrailingSpace: true),
  ExprKeywordSpec(name: "Throws", text: "throws", requiresTrailingSpace: true),
  PatternKeywordSpec(name: "Wildcard", text: "_", requiresTrailingSpace: true),
  PunctuatorSpec(name: "LeftParen", kind: "l_paren", text: "("),
  PunctuatorSpec(name: "RightParen", kind: "r_paren", text: ")"),
  PunctuatorSpec(name: "LeftBrace", kind: "l_brace", text: "{", requiresLeadingSpace: true),
  PunctuatorSpec(name: "RightBrace", kind: "r_brace", text: "}"),
  PunctuatorSpec(name: "LeftSquareBracket", kind: "l_square", text: "["),
  PunctuatorSpec(name: "RightSquareBracket", kind: "r_square", text: "]"),
  PunctuatorSpec(name: "LeftAngle", kind: "l_angle", text: "<", requiresLeadingSpace: true, requiresTrailingSpace: true),
  PunctuatorSpec(name: "RightAngle", kind: "r_angle", text: ">", requiresLeadingSpace: true, requiresTrailingSpace: true),
  PunctuatorSpec(name: "Period", kind: "period", text: "."),
  PunctuatorSpec(name: "PrefixPeriod", kind: "period_prefix", text: "."),
  PunctuatorSpec(name: "Comma", kind: "comma", text: ",", requiresTrailingSpace: true),
  PunctuatorSpec(name: "Ellipsis", kind: "ellipsis", text: "..."),
  PunctuatorSpec(name: "Colon", kind: "colon", text: ":", requiresTrailingSpace: true),
  PunctuatorSpec(name: "Semicolon", kind: "semi", text: ";"),
  PunctuatorSpec(name: "Equal", kind: "equal", text: "=", requiresLeadingSpace: true, requiresTrailingSpace: true),
  PunctuatorSpec(name: "AtSign", kind: "at_sign", text: "@", classification: "Attribute"),
  PunctuatorSpec(name: "Pound", kind: "pound", text: "#"),
  PunctuatorSpec(name: "PrefixAmpersand", kind: "amp_prefix", text: "&"),
  PunctuatorSpec(name: "Arrow", kind: "arrow", text: "->", requiresLeadingSpace: true, requiresTrailingSpace: true),
  PunctuatorSpec(name: "Backtick", kind: "backtick", text: "`"),
  PunctuatorSpec(name: "Backslash", kind: "backslash", text: "\\"),
  PunctuatorSpec(name: "ExclamationMark", kind: "exclaim_postfix", text: "!"),
  PunctuatorSpec(name: "PostfixQuestionMark", kind: "question_postfix", text: "?"),
  PunctuatorSpec(name: "InfixQuestionMark", kind: "question_infix", text: "?"),
  PunctuatorSpec(name: "StringQuote", kind: "string_quote", text: "\"", classification: "StringLiteral"),
  PunctuatorSpec(name: "SingleQuote", kind: "single_quote", text: "\'", classification: "StringLiteral"),
  PunctuatorSpec(name: "MultilineStringQuote", kind: "multiline_string_quote", text: "\"\"\"", classification: "StringLiteral"),
  PoundKeywordSpec(name: "PoundKeyPath", kind: "pound_keyPath", text: "#keyPath"),
  PoundKeywordSpec(name: "PoundLine", kind: "pound_line", text: "#line"),
  PoundKeywordSpec(name: "PoundSelector", kind: "pound_selector", text: "#selector"),
  PoundKeywordSpec(name: "PoundFile", kind: "pound_file", text: "#file"),
  PoundKeywordSpec(name: "PoundFileID", kind: "pound_fileID", text: "#fileID"),
  PoundKeywordSpec(name: "PoundFilePath", kind: "pound_filePath", text: "#filePath"),
  PoundKeywordSpec(name: "PoundColumn", kind: "pound_column", text: "#column"),
  PoundKeywordSpec(name: "PoundFunction", kind: "pound_function", text: "#function"),
  PoundKeywordSpec(name: "PoundDsohandle", kind: "pound_dsohandle", text: "#dsohandle"),
  PoundKeywordSpec(name: "PoundAssert", kind: "pound_assert", text: "#assert"),
  PoundDirectiveKeywordSpec(name: "PoundSourceLocation", kind: "pound_sourceLocation", text: "#sourceLocation"),
  PoundDirectiveKeywordSpec(name: "PoundWarning", kind: "pound_warning", text: "#warning"),
  PoundDirectiveKeywordSpec(name: "PoundError", kind: "pound_error", text: "#error"),
  PoundConditionalDirectiveKeywordSpec(name: "PoundIf", kind: "pound_if", text: "#if"),
  PoundConditionalDirectiveKeywordSpec(name: "PoundElse", kind: "pound_else", text: "#else"),
  PoundConditionalDirectiveKeywordSpec(name: "PoundElseif", kind: "pound_elseif", text: "#elseif"),
  PoundConditionalDirectiveKeywordSpec(name: "PoundEndif", kind: "pound_endif", text: "#endif"),
  PoundConfigSpec(name: "PoundAvailable", kind: "pound_available", text: "#available"),
  PoundConfigSpec(name: "PoundUnavailable", kind: "pound_unavailable", text: "#unavailable"),
  PoundObjectLiteralSpec(name: "PoundFileLiteral", kind: "pound_fileLiteral", text: "#fileLiteral", nameForDiagnostics: "file reference", protocol: "ExpressibleByFileReferenceLiteral"),
  PoundObjectLiteralSpec(name: "PoundImageLiteral", kind: "pound_imageLiteral", text: "#imageLiteral", nameForDiagnostics: "image", protocol: "ExpressibleByImageLiteral"),
  PoundObjectLiteralSpec(name: "PoundColorLiteral", kind: "pound_colorLiteral", text: "#colorLiteral", nameForDiagnostics: "color", protocol: "ExpressibleByColorLiteral"),
  PoundConfigSpec(name: "PoundHasSymbol", kind: "pound__hasSymbol", text: "#_hasSymbol"),
  LiteralSpec(name: "IntegerLiteral", kind: "integer_literal", nameForDiagnostics: "integer literal", classification: "IntegerLiteral"),
  LiteralSpec(name: "FloatingLiteral", kind: "floating_literal", nameForDiagnostics: "floating literal", classification: "FloatingLiteral"),
  LiteralSpec(name: "StringLiteral", kind: "string_literal", nameForDiagnostics: "string literal", classification: "StringLiteral"),
  LiteralSpec(name: "RegexLiteral", kind: "regex_literal", nameForDiagnostics: "regex literal"),
  MiscSpec(name: "Unknown", kind: "unknown", nameForDiagnostics: "token"),
  MiscSpec(name: "Identifier", kind: "identifier", nameForDiagnostics: "identifier", classification: "Identifier"),
  MiscSpec(name: "UnspacedBinaryOperator", kind: "oper_binary_unspaced", nameForDiagnostics: "binary operator", classification: "OperatorIdentifier"),
  MiscSpec(name: "SpacedBinaryOperator", kind: "oper_binary_spaced", nameForDiagnostics: "binary operator", classification: "OperatorIdentifier", requiresLeadingSpace: true, requiresTrailingSpace: true),
  MiscSpec(name: "PostfixOperator", kind: "oper_postfix", nameForDiagnostics: "postfix operator", classification: "OperatorIdentifier"),
  MiscSpec(name: "PrefixOperator", kind: "oper_prefix", nameForDiagnostics: "prefix operator", classification: "OperatorIdentifier"),
  MiscSpec(name: "DollarIdentifier", kind: "dollarident", nameForDiagnostics: "dollar identifier", classification: "DollarIdentifier"),
  MiscSpec(name: "ContextualKeyword", kind: "contextual_keyword", nameForDiagnostics: "keyword", classification: "Keyword"),
  MiscSpec(name: "RawStringDelimiter", kind: "raw_string_delimiter", nameForDiagnostics: "raw string delimiter"),
  MiscSpec(name: "StringSegment", kind: "string_segment", nameForDiagnostics: "string segment", classification: "StringLiteral"),
  MiscSpec(name: "StringInterpolationAnchor", kind: "string_interpolation_anchor", nameForDiagnostics: "string interpolation anchor", text: ")", classification: "StringInterpolationAnchor"),
  MiscSpec(name: "Yield", kind: "kw_yield", nameForDiagnostics: "yield", text: "yield"),
]

public let SYNTAX_TOKEN_MAP = Dictionary(uniqueKeysWithValues: SYNTAX_TOKENS.map { ("\($0.name)Token", $0) })
