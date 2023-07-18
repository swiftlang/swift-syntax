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
  public let nameForDiagnostics: String
  public let text: String?
  public let isKeyword: Bool
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
    nameForDiagnostics: String,
    text: String? = nil,
    isKeyword: Bool = false,
    associatedValueClass: String? = nil
  ) {
    self.name = name
    self.nameForDiagnostics = nameForDiagnostics
    self.text = text
    self.isKeyword = isKeyword
    self.associatedValueClass = associatedValueClass
  }
}

public class PoundKeywordSpec: TokenSpec {
  init(
    name: String,
    nameForDiagnostics: String? = nil,
    text: String
  ) {
    super.init(
      name: name,
      nameForDiagnostics: nameForDiagnostics ?? text,
      text: text,
      isKeyword: true
    )
  }
}

public class PoundObjectLiteralSpec: PoundKeywordSpec {
  let `protocol`: String

  init(
    name: String,
    text: String,
    nameForDiagnostics: String,
    `protocol`: String
  ) {
    self.`protocol` = `protocol`
    super.init(
      name: name,
      nameForDiagnostics: nameForDiagnostics,
      text: text
    )
  }
}

public class PoundConfigSpec: PoundKeywordSpec {}

public class PoundDirectiveKeywordSpec: PoundKeywordSpec {
  init(
    name: String,
    text: String
  ) {
    super.init(
      name: name,
      text: text
    )
  }
}

public class PoundConditionalDirectiveKeywordSpec: PoundDirectiveKeywordSpec {
  override init(
    name: String,
    text: String
  ) {
    super.init(
      name: name,
      text: text
    )
  }
}

public class PunctuatorSpec: TokenSpec {
  init(
    name: String,
    text: String
  ) {
    super.init(
      name: name,
      nameForDiagnostics: text,
      text: text,
      isKeyword: false
    )
  }
}

public class LiteralSpec: TokenSpec {}

public class MiscSpec: TokenSpec {}

public let SYNTAX_TOKENS: [TokenSpec] = [
  PunctuatorSpec(name: "Arrow", text: "->"),
  PunctuatorSpec(name: "AtSign", text: "@"),
  PunctuatorSpec(name: "Backslash", text: "\\"),
  PunctuatorSpec(name: "Backtick", text: "`"),
  MiscSpec(name: "BinaryOperator", nameForDiagnostics: "binary operator"),
  PunctuatorSpec(name: "Colon", text: ":"),
  PunctuatorSpec(name: "Comma", text: ","),
  MiscSpec(name: "DollarIdentifier", nameForDiagnostics: "dollar identifier"),
  PunctuatorSpec(name: "Ellipsis", text: "..."),
  MiscSpec(name: "EndOfFile", nameForDiagnostics: "end of file", text: ""),
  PunctuatorSpec(name: "Equal", text: "="),
  PunctuatorSpec(name: "ExclamationMark", text: "!"),
  MiscSpec(name: "ExtendedRegexDelimiter", nameForDiagnostics: "extended delimiter"),
  LiteralSpec(name: "FloatingLiteral", nameForDiagnostics: "floating literal"),
  MiscSpec(name: "Identifier", nameForDiagnostics: "identifier"),
  PunctuatorSpec(name: "InfixQuestionMark", text: "?"),
  LiteralSpec(name: "IntegerLiteral", nameForDiagnostics: "integer literal"),
  MiscSpec(name: "Keyword", nameForDiagnostics: "keyword", associatedValueClass: "Keyword"),
  PunctuatorSpec(name: "LeftAngle", text: "<"),
  PunctuatorSpec(name: "LeftBrace", text: "{"),
  PunctuatorSpec(name: "LeftParen", text: "("),
  PunctuatorSpec(name: "LeftSquare", text: "["),
  PunctuatorSpec(name: "MultilineStringQuote", text: "\"\"\""),
  PunctuatorSpec(name: "Period", text: "."),
  MiscSpec(name: "PostfixOperator", nameForDiagnostics: "postfix operator"),
  PunctuatorSpec(name: "PostfixQuestionMark", text: "?"),
  PunctuatorSpec(name: "Pound", text: "#"),
  PoundConfigSpec(name: "PoundAvailable", text: "#available"),
  PoundConditionalDirectiveKeywordSpec(name: "PoundElse", text: "#else"),
  PoundConditionalDirectiveKeywordSpec(name: "PoundElseif", text: "#elseif"),
  PoundConditionalDirectiveKeywordSpec(name: "PoundEndif", text: "#endif"),
  PoundConditionalDirectiveKeywordSpec(name: "PoundIf", text: "#if"),
  PoundDirectiveKeywordSpec(name: "PoundSourceLocation", text: "#sourceLocation"),
  PoundConfigSpec(name: "PoundUnavailable", text: "#unavailable"),
  PunctuatorSpec(name: "PrefixAmpersand", text: "&"),
  MiscSpec(name: "PrefixOperator", nameForDiagnostics: "prefix operator"),
  MiscSpec(name: "RawStringDelimiter", nameForDiagnostics: "raw string delimiter"),
  MiscSpec(name: "RegexLiteralPattern", nameForDiagnostics: "regex pattern"),
  PunctuatorSpec(name: "RegexSlash", text: "/"),
  PunctuatorSpec(name: "RightAngle", text: ">"),
  PunctuatorSpec(name: "RightBrace", text: "}"),
  PunctuatorSpec(name: "RightParen", text: ")"),
  PunctuatorSpec(name: "RightSquare", text: "]"),
  PunctuatorSpec(name: "Semicolon", text: ";"),
  PunctuatorSpec(name: "SingleQuote", text: "\'"),
  PunctuatorSpec(name: "StringQuote", text: "\""),
  MiscSpec(name: "StringSegment", nameForDiagnostics: "string segment"),
  MiscSpec(name: "Unknown", nameForDiagnostics: "token"),
  MiscSpec(name: "Wildcard", nameForDiagnostics: "wildcard", text: "_"),
]

public let SYNTAX_TOKEN_MAP = Dictionary(
  uniqueKeysWithValues: SYNTAX_TOKENS.map { ("\($0.name)Token", $0) }
)
