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
  public let associatedValueClass: String?

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
    requiresTrailingSpace: Bool = false,
    associatedValueClass: String? = nil
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
    self.associatedValueClass = associatedValueClass
  }
}

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

public class PoundConfigSpec: PoundKeywordSpec {}

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

public class LiteralSpec: TokenSpec {}

public class MiscSpec: TokenSpec {}

public let SYNTAX_TOKENS: [TokenSpec] = [
  PunctuatorSpec(name: "Arrow", kind: "arrow", text: "->", requiresLeadingSpace: true, requiresTrailingSpace: true),
  PunctuatorSpec(name: "AtSign", kind: "at_sign", text: "@", classification: "Attribute"),
  PunctuatorSpec(name: "Backslash", kind: "backslash", text: "\\"),
  PunctuatorSpec(name: "Backtick", kind: "backtick", text: "`"),
  MiscSpec(name: "BinaryOperator", kind: "oper_binary", nameForDiagnostics: "binary operator", classification: "OperatorIdentifier", requiresLeadingSpace: true, requiresTrailingSpace: true),
  PunctuatorSpec(name: "Colon", kind: "colon", text: ":", requiresTrailingSpace: true),
  PunctuatorSpec(name: "Comma", kind: "comma", text: ",", requiresTrailingSpace: true),
  MiscSpec(name: "DollarIdentifier", kind: "dollarident", nameForDiagnostics: "dollar identifier", classification: "DollarIdentifier"),
  PunctuatorSpec(name: "Ellipsis", kind: "ellipsis", text: "..."),
  PunctuatorSpec(name: "Equal", kind: "equal", text: "=", requiresLeadingSpace: true, requiresTrailingSpace: true),
  PunctuatorSpec(name: "ExclamationMark", kind: "exclaim_postfix", text: "!"),
  MiscSpec(name: "ExtendedRegexDelimiter", kind: "extended_regex_delimiter", nameForDiagnostics: "extended delimiter", classification: "RegexLiteral"),
  LiteralSpec(name: "FloatingLiteral", kind: "floating_literal", nameForDiagnostics: "floating literal", classification: "FloatingLiteral"),
  MiscSpec(name: "Identifier", kind: "identifier", nameForDiagnostics: "identifier", classification: "Identifier"),
  PunctuatorSpec(name: "InfixQuestionMark", kind: "question_infix", text: "?"),
  LiteralSpec(name: "IntegerLiteral", kind: "integer_literal", nameForDiagnostics: "integer literal", classification: "IntegerLiteral"),
  MiscSpec(name: "Keyword", kind: "keyword", nameForDiagnostics: "keyword", classification: "Keyword", associatedValueClass: "Keyword"),
  PunctuatorSpec(name: "LeftAngle", kind: "l_angle", text: "<"),
  PunctuatorSpec(name: "LeftBrace", kind: "l_brace", text: "{", requiresLeadingSpace: true),
  PunctuatorSpec(name: "LeftParen", kind: "l_paren", text: "("),
  PunctuatorSpec(name: "LeftSquareBracket", kind: "l_square", text: "["),
  PunctuatorSpec(name: "MultilineStringQuote", kind: "multiline_string_quote", text: "\"\"\"", classification: "StringLiteral"),
  PunctuatorSpec(name: "Period", kind: "period", text: "."),
  MiscSpec(name: "PostfixOperator", kind: "oper_postfix", nameForDiagnostics: "postfix operator", classification: "OperatorIdentifier"),
  PunctuatorSpec(name: "PostfixQuestionMark", kind: "question_postfix", text: "?"),
  PunctuatorSpec(name: "Pound", kind: "pound", text: "#"),
  PoundConfigSpec(name: "PoundAvailable", kind: "pound_available", text: "#available"),
  PoundConditionalDirectiveKeywordSpec(name: "PoundElse", kind: "pound_else", text: "#else"),
  PoundConditionalDirectiveKeywordSpec(name: "PoundElseif", kind: "pound_elseif", text: "#elseif"),
  PoundConditionalDirectiveKeywordSpec(name: "PoundEndif", kind: "pound_endif", text: "#endif"),
  PoundConditionalDirectiveKeywordSpec(name: "PoundIf", kind: "pound_if", text: "#if"),
  PoundDirectiveKeywordSpec(name: "PoundSourceLocation", kind: "pound_sourceLocation", text: "#sourceLocation"),
  PoundConfigSpec(name: "PoundUnavailable", kind: "pound_unavailable", text: "#unavailable"),
  PunctuatorSpec(name: "PrefixAmpersand", kind: "amp_prefix", text: "&"),
  MiscSpec(name: "PrefixOperator", kind: "oper_prefix", nameForDiagnostics: "prefix operator", classification: "OperatorIdentifier"),
  MiscSpec(name: "RawStringDelimiter", kind: "raw_string_delimiter", nameForDiagnostics: "raw string delimiter"),
  MiscSpec(name: "RegexLiteralPattern", kind: "regex_literal_pattern", nameForDiagnostics: "regex pattern", classification: "RegexLiteral"),
  PunctuatorSpec(name: "RegexSlash", kind: "regex_slash", text: "/", classification: "RegexLiteral"),
  PunctuatorSpec(name: "RightAngle", kind: "r_angle", text: ">"),
  PunctuatorSpec(name: "RightBrace", kind: "r_brace", text: "}"),
  PunctuatorSpec(name: "RightParen", kind: "r_paren", text: ")"),
  PunctuatorSpec(name: "RightSquareBracket", kind: "r_square", text: "]"),
  PunctuatorSpec(name: "Semicolon", kind: "semi", text: ";"),
  PunctuatorSpec(name: "SingleQuote", kind: "single_quote", text: "\'", classification: "StringLiteral"),
  PunctuatorSpec(name: "StringQuote", kind: "string_quote", text: "\"", classification: "StringLiteral"),
  MiscSpec(name: "StringSegment", kind: "string_segment", nameForDiagnostics: "string segment", classification: "StringLiteral"),
  MiscSpec(name: "Unknown", kind: "unknown", nameForDiagnostics: "token"),
  MiscSpec(name: "Wildcard", kind: "_", nameForDiagnostics: "wildcard", text: "_"),
]

public let SYNTAX_TOKEN_MAP = Dictionary(uniqueKeysWithValues: SYNTAX_TOKENS.map { ("\($0.name)Token", $0) })
