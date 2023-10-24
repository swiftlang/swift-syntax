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

@_spi(RawSyntax) import SwiftSyntax

extension Parser {
  mutating func skippedBraceBody(unless: Lookahead.SkipBodyResult) -> RawSkippedDeclSyntax? {
    return self.withLookahead { lookahead in
      let result = lookahead.advanceUntilMatchingRightBrace()
      guard result.isDisjoint(with: unless) else {
        return nil
      }

      let wholeText = SyntaxText(
        baseAddress: self.currentToken.start,
        count: self.currentToken.start.distance(to: lookahead.currentToken.start)
      )

      // Advance the Lexer to skipped position.
      self.currentToken = lookahead.currentToken
      self.lexemes = lookahead.lexemes

      // Represent the skipped range with a single .unknown token.
      let tok =  RawTokenSyntax(
        kind: .unknown,
        wholeText: wholeText,
        textRange: wholeText.startIndex..<wholeText.endIndex,
        presence: .present,
        tokenDiagnostic: nil,
        arena: self.arena
      )
      return RawSkippedDeclSyntax(text: tok, arena: self.arena)
    }
  }
}

extension Parser.Lookahead {
  struct SkipBodyResult: OptionSet {
    let rawValue: UInt8

    static let hasPoundDirective = Self(rawValue: 1 << 0)
    static let hasOperatorDeclarations = Self(rawValue: 1 << 1)
    static let hasNestedClassDeclarations = Self(rawValue: 1 << 2)
    static let hasNestedTypeDeclarations = Self(rawValue: 1 << 3)
    static let hasPotentialRegexLiteral = Self(rawValue: 1 << 4)
  }

  mutating func advanceUntilMatchingRightBrace() -> SkipBodyResult {
    var openBraces = 0

    var lastTokenWasFunc = false

    var result = SkipBodyResult()

    while self.currentToken.rawTokenKind != .endOfFile {
      let token = self.currentToken
      if !result.contains(.hasPoundDirective) && (
        token.rawTokenKind == .poundIf ||
        token.rawTokenKind == .poundElseif ||
        token.rawTokenKind == .poundElse ||
        token.rawTokenKind == .poundEndif ||
        token.rawTokenKind == .poundSourceLocation
      ) {
        result.insert(.hasPoundDirective)
      }

      if lastTokenWasFunc && !result.contains(.hasOperatorDeclarations) && (
        token.rawTokenKind == .binaryOperator ||
        token.rawTokenKind == .prefixOperator ||
        token.rawTokenKind == .postfixOperator
      ) {
        result.insert(.hasOperatorDeclarations)
      }
      lastTokenWasFunc = token.rawTokenKind == .keyword && token.tokenText == "func"

      if !result.contains(.hasNestedClassDeclarations) && (
        token.rawTokenKind == .keyword &&
        token.tokenText == "class"
      ) {
        result.insert(.hasNestedClassDeclarations)
      }

      if !result.contains(.hasNestedClassDeclarations) && (
        token.rawTokenKind == .keyword && (
          token.tokenText == "class" ||
          token.tokenText == "enum" ||
          token.tokenText == "struct" ||
          token.tokenText == "actor"
        )
      ) {
        result.insert(.hasNestedTypeDeclarations)
      }

      if token.rawTokenKind == .leftBrace {
        openBraces += 1
      } else if token.rawTokenKind == .rightBrace {
        if openBraces == 0 {
          break
        } else {
          openBraces -= 1
        }
      }
      self.consumeAnyToken()
    }
    return result
  }
}
