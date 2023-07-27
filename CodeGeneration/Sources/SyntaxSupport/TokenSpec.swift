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

import SwiftSyntax

/// Represents the specification for a Token in the TokenSyntax file.
public struct TokenSpec {
  public enum Kind {
    case punctuation
    /// The `keyword` TokenKind that contains the actual keyword as an associated value
    case keyword
    case other
  }

  public let varOrCaseName: TokenSyntax
  public let nameForDiagnostics: String
  public let text: String?
  public let kind: Kind

  fileprivate init(
    name: String,
    nameForDiagnostics: String,
    text: String? = nil,
    kind: Kind
  ) {
    self.varOrCaseName = .identifier(name)
    self.nameForDiagnostics = nameForDiagnostics
    self.text = text
    self.kind = kind
  }

  static func punctuator(name: String, text: String) -> TokenSpec {
    return TokenSpec(
      name: name,
      nameForDiagnostics: text,
      text: text,
      kind: .punctuation
    )
  }

  static func poundKeyword(name: String, text: String) -> TokenSpec {
    return TokenSpec(
      name: name,
      nameForDiagnostics: text,
      text: text,
      kind: .other
    )
  }

  static func other(name: String, nameForDiagnostics: String, text: String? = nil) -> TokenSpec {
    TokenSpec(
      name: name,
      nameForDiagnostics: nameForDiagnostics,
      text: text,
      kind: .other
    )
  }
}

public let SYNTAX_TOKENS: [TokenSpec] = [
  .punctuator(name: "arrow", text: "->"),
  .punctuator(name: "atSign", text: "@"),
  .punctuator(name: "backslash", text: "\\"),
  .punctuator(name: "backtick", text: "`"),
  .other(name: "binaryOperator", nameForDiagnostics: "binary operator"),
  .punctuator(name: "colon", text: ":"),
  .punctuator(name: "comma", text: ","),
  .other(name: "dollarIdentifier", nameForDiagnostics: "dollar identifier"),
  .punctuator(name: "ellipsis", text: "..."),
  .other(name: "endOfFile", nameForDiagnostics: "end of file", text: ""),
  .punctuator(name: "equal", text: "="),
  .punctuator(name: "exclamationMark", text: "!"),
  .other(name: "floatingLiteral", nameForDiagnostics: "floating literal"),
  .other(name: "identifier", nameForDiagnostics: "identifier"),
  .punctuator(name: "infixQuestionMark", text: "?"),
  .other(name: "integerLiteral", nameForDiagnostics: "integer literal"),
  TokenSpec(name: "keyword", nameForDiagnostics: "keyword", text: nil, kind: .keyword),
  .punctuator(name: "leftAngle", text: "<"),
  .punctuator(name: "leftBrace", text: "{"),
  .punctuator(name: "leftParen", text: "("),
  .punctuator(name: "leftSquare", text: "["),
  .punctuator(name: "multilineStringQuote", text: "\"\"\""),
  .punctuator(name: "period", text: "."),
  .other(name: "postfixOperator", nameForDiagnostics: "postfix operator"),
  .punctuator(name: "postfixQuestionMark", text: "?"),
  .punctuator(name: "pound", text: "#"),
  .poundKeyword(name: "poundAvailable", text: "#available"),
  .poundKeyword(name: "poundElse", text: "#else"),
  .poundKeyword(name: "poundElseif", text: "#elseif"),
  .poundKeyword(name: "poundEndif", text: "#endif"),
  .poundKeyword(name: "poundIf", text: "#if"),
  .poundKeyword(name: "poundSourceLocation", text: "#sourceLocation"),
  .poundKeyword(name: "poundUnavailable", text: "#unavailable"),
  .punctuator(name: "prefixAmpersand", text: "&"),
  .other(name: "prefixOperator", nameForDiagnostics: "prefix operator"),
  .other(name: "rawStringPoundDelimiter", nameForDiagnostics: "raw string delimiter"),
  .other(name: "regexLiteralPattern", nameForDiagnostics: "regex pattern"),
  .other(name: "regexPoundDelimiter", nameForDiagnostics: "extended delimiter"),
  .punctuator(name: "regexSlash", text: "/"),
  .punctuator(name: "rightAngle", text: ">"),
  .punctuator(name: "rightBrace", text: "}"),
  .punctuator(name: "rightParen", text: ")"),
  .punctuator(name: "rightSquare", text: "]"),
  .punctuator(name: "semicolon", text: ";"),
  .punctuator(name: "singleQuote", text: "\'"),
  .punctuator(name: "stringQuote", text: "\""),
  .other(name: "stringSegment", nameForDiagnostics: "string segment"),
  .other(name: "unknown", nameForDiagnostics: "token"),
  .other(name: "wildcard", nameForDiagnostics: "wildcard", text: "_"),
]

public let SYNTAX_TOKEN_MAP = Dictionary(
  uniqueKeysWithValues: SYNTAX_TOKENS.map { ("\($0.varOrCaseName.description.withFirstCharacterUppercased)Token", $0) }
)
