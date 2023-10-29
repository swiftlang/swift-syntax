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
  struct SkipBodyCondition: OptionSet {
    let rawValue: UInt8

    static let hasPoundDirective = Self(rawValue: 1 << 0)
    static let hasOperatorDeclarations = Self(rawValue: 1 << 1)
    static let hasNestedClassDeclarations = Self(rawValue: 1 << 2)
    static let hasNestedTypeDeclarations = Self(rawValue: 1 << 3)
    static let hasPotentialRegexLiteral = Self(rawValue: 1 << 4)
  }

  mutating func skippedBraceBody(unless: SkipBodyCondition) -> RawSkippedDeclSyntax? {
    return self.withLookahead { lookahead in
      guard lookahead.advanceUntilMatchingRightBrace(until: unless) == .skipped else {
        return nil
      }

      // Skipped region as a single SyntaxText.
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

fileprivate extension Parser.Lookahead {
  enum SkipBodyResult {
    case untilConditionMet
    case skipped
  }

  mutating func advanceUntilMatchingRightBrace(until: Parser.SkipBodyCondition) -> SkipBodyResult {
    var openBraces = 1

    var lastTokenWasFunc = false

    while self.currentToken.rawTokenKind != .endOfFile {
      let tokenKind = currentToken.rawTokenKind
      let tokenText = currentToken.tokenText

      if until.contains(.hasPoundDirective) && (
        tokenKind == .poundIf ||
        tokenKind == .poundSourceLocation
      ) {
        return .untilConditionMet
      }

      if until.contains(.hasNestedClassDeclarations) && (
        tokenKind == .keyword && tokenText == "class"
      ) {
        return .untilConditionMet
      }

      if until.contains(.hasNestedClassDeclarations) && (
        tokenKind == .keyword && (
          tokenText == "enum" ||
          tokenText == "struct" ||
          tokenText == "class" ||
          tokenText == "actor"
        )
      ) {
        return .untilConditionMet
      }

      if until.contains(.hasOperatorDeclarations) {
        if lastTokenWasFunc && (
          tokenKind == .binaryOperator ||
          tokenKind == .prefixOperator ||
          tokenKind == .postfixOperator
        ) {
          return .untilConditionMet
        }
        lastTokenWasFunc = tokenKind == .keyword && tokenText == "func"
      }

      if currentToken.rawTokenKind == .leftBrace {
        openBraces += 1
      } else if currentToken.rawTokenKind == .rightBrace {
        openBraces -= 1
        if openBraces == 0 {
          break
        }
      }
      self.consumeAnyToken()
    }

    return .skipped
  }
}
