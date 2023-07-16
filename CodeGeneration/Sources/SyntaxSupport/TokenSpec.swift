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
public struct TokenSpec {
  public let name: String
  public let nameForDiagnostics: String
  public let text: String?
  public let isPunctuation: Bool
  public let associatedValueClass: String?

  public var swiftKind: String {
    return lowercaseFirstWord(name: self.name)
  }

  private init(
    name: String,
    nameForDiagnostics: String,
    text: String? = nil,
    isPunctuation: Bool,
    associatedValueClass: String? = nil
  ) {
    self.name = name
    self.nameForDiagnostics = nameForDiagnostics
    self.text = text
    self.isPunctuation = isPunctuation
    self.associatedValueClass = associatedValueClass
  }

  static func punctuator(name: String, text: String) -> TokenSpec {
    return TokenSpec(
      name: name,
      nameForDiagnostics: text,
      text: text,
      isPunctuation: true,
      associatedValueClass: nil
    )
  }

  static func poundKeyword(name: String, text: String) -> TokenSpec {
    return TokenSpec(
      name: name,
      nameForDiagnostics: text,
      text: text,
      isPunctuation: false,
      associatedValueClass: nil
    )
  }

  static func other(name: String, nameForDiagnostics: String, text: String? = nil, associatedValueClass: String? = nil) -> TokenSpec {
    TokenSpec(
      name: name,
      nameForDiagnostics: nameForDiagnostics,
      text: text,
      isPunctuation: false,
      associatedValueClass: associatedValueClass
    )

  }
}

public let SYNTAX_TOKENS: [TokenSpec] = [
  .punctuator(name: "Arrow", text: "->"),
  .punctuator(name: "AtSign", text: "@"),
  .punctuator(name: "Backslash", text: "\\"),
  .punctuator(name: "Backtick", text: "`"),
  .other(name: "BinaryOperator", nameForDiagnostics: "binary operator"),
  .punctuator(name: "Colon", text: ":"),
  .punctuator(name: "Comma", text: ","),
  .other(name: "DollarIdentifier", nameForDiagnostics: "dollar identifier"),
  .punctuator(name: "Ellipsis", text: "..."),
  .other(name: "EndOfFile", nameForDiagnostics: "end of file", text: ""),
  .punctuator(name: "Equal", text: "="),
  .punctuator(name: "ExclamationMark", text: "!"),
  .other(name: "ExtendedRegexDelimiter", nameForDiagnostics: "extended delimiter"),
  .other(name: "FloatingLiteral", nameForDiagnostics: "floating literal"),
  .other(name: "Identifier", nameForDiagnostics: "identifier"),
  .punctuator(name: "InfixQuestionMark", text: "?"),
  .other(name: "IntegerLiteral", nameForDiagnostics: "integer literal"),
  .other(name: "Keyword", nameForDiagnostics: "keyword", associatedValueClass: "Keyword"),
  .punctuator(name: "LeftAngle", text: "<"),
  .punctuator(name: "LeftBrace", text: "{"),
  .punctuator(name: "LeftParen", text: "("),
  .punctuator(name: "LeftSquare", text: "["),
  .punctuator(name: "MultilineStringQuote", text: "\"\"\""),
  .punctuator(name: "Period", text: "."),
  .other(name: "PostfixOperator", nameForDiagnostics: "postfix operator"),
  .punctuator(name: "PostfixQuestionMark", text: "?"),
  .punctuator(name: "Pound", text: "#"),
  .poundKeyword(name: "PoundAvailable", text: "#available"),
  .poundKeyword(name: "PoundElse", text: "#else"),
  .poundKeyword(name: "PoundElseif", text: "#elseif"),
  .poundKeyword(name: "PoundEndif", text: "#endif"),
  .poundKeyword(name: "PoundIf", text: "#if"),
  .poundKeyword(name: "PoundSourceLocation", text: "#sourceLocation"),
  .poundKeyword(name: "PoundUnavailable", text: "#unavailable"),
  .punctuator(name: "PrefixAmpersand", text: "&"),
  .other(name: "PrefixOperator", nameForDiagnostics: "prefix operator"),
  .other(name: "RawStringDelimiter", nameForDiagnostics: "raw string delimiter"),
  .other(name: "RegexLiteralPattern", nameForDiagnostics: "regex pattern"),
  .punctuator(name: "RegexSlash", text: "/"),
  .punctuator(name: "RightAngle", text: ">"),
  .punctuator(name: "RightBrace", text: "}"),
  .punctuator(name: "RightParen", text: ")"),
  .punctuator(name: "RightSquare", text: "]"),
  .punctuator(name: "Semicolon", text: ";"),
  .punctuator(name: "SingleQuote", text: "\'"),
  .punctuator(name: "StringQuote", text: "\""),
  .other(name: "StringSegment", nameForDiagnostics: "string segment"),
  .other(name: "Unknown", nameForDiagnostics: "token"),
  .other(name: "Wildcard", nameForDiagnostics: "wildcard", text: "_"),
]

public let SYNTAX_TOKEN_MAP = Dictionary(
  uniqueKeysWithValues: SYNTAX_TOKENS.map { ("\($0.name)Token", $0) }
)
