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

  /// The name of the token, suitable for use in variable or enum case names.
  public let varOrCaseName: TokenSyntax

  /// The experimental feature the token is part of, or `nil` if this isn't
  /// for an experimental feature.
  public let experimentalFeature: ExperimentalFeature?

  /// The name of the token that can be shown in diagnostics.
  public let nameForDiagnostics: String

  /// The actual text of the token, if available.
  public let text: String?

  /// The kind of the token.
  public let kind: Kind

  /// Indicates if the token is part of an experimental language feature.
  ///
  /// If `true`, this keyword is for an experimental language feature, and any public
  /// API generated should be marked as SPI
  public var isExperimental: Bool { experimentalFeature != nil }

  /// The attributes that should be printed on any API for the generated keyword.
  ///
  /// This is typically used to mark APIs as SPI when the keyword is part of an experimental language feature.
  public var apiAttributes: AttributeListSyntax {
    guard isExperimental else { return "" }
    return AttributeListSyntax("@_spi(ExperimentalLanguageFeatures)").with(\.trailingTrivia, .newline)
  }

  /// Initializes a new `TokenSpec` instance.
  ///
  /// - Parameters:
  ///   - name: A name of the token.
  ///   - experimentalFeature: The experimental feature the token is part of, or `nil` if this isn't for an experimental feature.
  ///   - nameForDiagnostics: A name of the token that can be shown in diagnostics.
  ///   - text: An actual text of the token, if available.
  ///   - kind: A kind of the token.
  fileprivate init(
    name: String,
    experimentalFeature: ExperimentalFeature? = nil,
    nameForDiagnostics: String,
    text: String? = nil,
    kind: Kind
  ) {
    self.varOrCaseName = .identifier(name)
    self.experimentalFeature = experimentalFeature
    self.nameForDiagnostics = nameForDiagnostics
    self.text = text
    self.kind = kind
  }

  /// Creates a new `TokenSpec` instance representing a punctuation token.
  ///
  /// - Parameters:
  ///   - name: A name of the token.
  ///   - text: An actual text of the punctuation token.
  static func punctuator(name: String, text: String) -> TokenSpec {
    return TokenSpec(
      name: name,
      nameForDiagnostics: text,
      text: text,
      kind: .punctuation
    )
  }

  /// Creates a new `TokenSpec` instance representing a pound keyword token.
  ///
  /// - Parameters:
  ///   - name: A name of the token.
  ///   - text: An actual text of the pound keyword token.
  static func poundKeyword(name: String, text: String) -> TokenSpec {
    return TokenSpec(
      name: name,
      nameForDiagnostics: text,
      text: text,
      kind: .other
    )
  }

  /// Creates a new `TokenSpec` instance representing an other token.
  ///
  /// - Parameters:
  ///   - name: A name of the token.
  ///   - nameForDiagnostics: A name of the token that can be shown in diagnostics.
  ///   - text: An actual text of the token, if available.
  static func other(name: String, nameForDiagnostics: String, text: String? = nil) -> TokenSpec {
    return TokenSpec(
      name: name,
      nameForDiagnostics: nameForDiagnostics,
      text: text,
      kind: .other
    )
  }
}

public enum Token: CaseIterable {
  // Please keep this list sorted alphabetically

  case arrow
  case atSign
  case backslash
  case backtick
  case binaryOperator
  case colon
  case comma
  case dollarIdentifier
  case ellipsis
  case endOfFile
  case equal
  case exclamationMark
  case floatLiteral
  case identifier
  case infixQuestionMark
  case integerLiteral
  case keyword
  case leftAngle
  case leftBrace
  case leftParen
  case leftSquare
  case multilineStringQuote
  case period
  case postfixOperator
  case postfixQuestionMark
  case pound
  case poundAvailable
  case poundElse
  case poundElseif
  case poundEndif
  case poundIf
  case poundSourceLocation
  case poundUnavailable
  case prefixAmpersand
  case prefixOperator
  case rawStringPoundDelimiter
  case regexLiteralPattern
  case regexPoundDelimiter
  case regexSlash
  case rightAngle
  case rightBrace
  case rightParen
  case rightSquare
  case semicolon
  case shebang
  case singleQuote
  case stringQuote
  case stringSegment
  case unknown
  case wildcard

  public var spec: TokenSpec {
    switch self {
    case .arrow:
      return .punctuator(name: "arrow", text: "->")
    case .atSign:
      return .punctuator(name: "atSign", text: "@")
    case .backslash:
      return .punctuator(name: "backslash", text: "\\")
    case .backtick:
      return .punctuator(name: "backtick", text: "`")
    case .binaryOperator:
      return .other(name: "binaryOperator", nameForDiagnostics: "binary operator")
    case .colon:
      return .punctuator(name: "colon", text: ":")
    case .comma:
      return .punctuator(name: "comma", text: ",")
    case .dollarIdentifier:
      return .other(name: "dollarIdentifier", nameForDiagnostics: "dollar identifier")
    case .ellipsis:
      return .punctuator(name: "ellipsis", text: "...")
    case .endOfFile:
      return .other(name: "endOfFile", nameForDiagnostics: "end of file", text: "")
    case .equal:
      return .punctuator(name: "equal", text: "=")
    case .exclamationMark:
      return .punctuator(name: "exclamationMark", text: "!")
    case .floatLiteral:
      return .other(name: "floatLiteral", nameForDiagnostics: "float literal")
    case .identifier:
      return .other(name: "identifier", nameForDiagnostics: "identifier")
    case .infixQuestionMark:
      return .punctuator(name: "infixQuestionMark", text: "?")
    case .integerLiteral:
      return .other(name: "integerLiteral", nameForDiagnostics: "integer literal")
    case .keyword:
      return TokenSpec(name: "keyword", nameForDiagnostics: "keyword", text: nil, kind: .keyword)
    case .leftAngle:
      return .punctuator(name: "leftAngle", text: "<")
    case .leftBrace:
      return .punctuator(name: "leftBrace", text: "{")
    case .leftParen:
      return .punctuator(name: "leftParen", text: "(")
    case .leftSquare:
      return .punctuator(name: "leftSquare", text: "[")
    case .multilineStringQuote:
      return .punctuator(name: "multilineStringQuote", text: "\"\"\"")
    case .period:
      return .punctuator(name: "period", text: ".")
    case .postfixOperator:
      return .other(name: "postfixOperator", nameForDiagnostics: "postfix operator")
    case .postfixQuestionMark:
      return .punctuator(name: "postfixQuestionMark", text: "?")
    case .pound:
      return .punctuator(name: "pound", text: "#")
    case .poundAvailable:
      return .poundKeyword(name: "poundAvailable", text: "#available")
    case .poundElse:
      return .poundKeyword(name: "poundElse", text: "#else")
    case .poundElseif:
      return .poundKeyword(name: "poundElseif", text: "#elseif")
    case .poundEndif:
      return .poundKeyword(name: "poundEndif", text: "#endif")
    case .poundIf:
      return .poundKeyword(name: "poundIf", text: "#if")
    case .poundSourceLocation:
      return .poundKeyword(name: "poundSourceLocation", text: "#sourceLocation")
    case .poundUnavailable:
      return .poundKeyword(name: "poundUnavailable", text: "#unavailable")
    case .prefixAmpersand:
      return .punctuator(name: "prefixAmpersand", text: "&")
    case .prefixOperator:
      return .other(name: "prefixOperator", nameForDiagnostics: "prefix operator")
    case .rawStringPoundDelimiter:
      return .other(name: "rawStringPoundDelimiter", nameForDiagnostics: "raw string delimiter")
    case .regexLiteralPattern:
      return .other(name: "regexLiteralPattern", nameForDiagnostics: "regex pattern")
    case .regexPoundDelimiter:
      return .other(name: "regexPoundDelimiter", nameForDiagnostics: "extended delimiter")
    case .regexSlash:
      return .punctuator(name: "regexSlash", text: "/")
    case .rightAngle:
      return .punctuator(name: "rightAngle", text: ">")
    case .rightBrace:
      return .punctuator(name: "rightBrace", text: "}")
    case .rightParen:
      return .punctuator(name: "rightParen", text: ")")
    case .rightSquare:
      return .punctuator(name: "rightSquare", text: "]")
    case .semicolon:
      return .punctuator(name: "semicolon", text: ";")
    case .shebang:
      return .other(name: "shebang", nameForDiagnostics: "shebang")
    case .singleQuote:
      return .punctuator(name: "singleQuote", text: "\'")
    case .stringQuote:
      return .punctuator(name: "stringQuote", text: "\"")
    case .stringSegment:
      return .other(name: "stringSegment", nameForDiagnostics: "string segment")
    case .unknown:
      return .other(name: "unknown", nameForDiagnostics: "token")
    case .wildcard:
      return .other(name: "wildcard", nameForDiagnostics: "wildcard", text: "_")
    }
  }
}
