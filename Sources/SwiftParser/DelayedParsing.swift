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
  mutating func skippedFunctionBody() -> RawSkippedDeclSyntax? {
    return self.skippedBraceBody(while: { tokenKind, tokenText in
      // If the function body contains a type decl, don't skip.
      if tokenKind == .keyword && (
        tokenText == "enum" ||
        tokenText == "struct" ||
        tokenText == "class" ||
        tokenText == "actor"
      ) {
        return false
      }
      return true
    })
  }

  mutating func skippedMemberBody() -> RawSkippedDeclSyntax? {
    var lastTokenWasFunc: Bool = false
    return self.skippedBraceBody(while: { tokenKind, tokenText in

      // '#' directives.
      if tokenKind == .poundIf || tokenKind == .poundSourceLocation {
        return false
      }

      // Nested class. Because?
      if tokenKind == .keyword && tokenText == "class" {
        return false
      }

      // Operator functions. Because they're visible from top-level.
      if lastTokenWasFunc && (
        tokenKind == .binaryOperator || tokenKind == .prefixOperator || tokenKind == .postfixOperator
      ) {
        return false
      }
      lastTokenWasFunc = tokenKind == .keyword && tokenText == "func"

      return true
    })
  }

  fileprivate mutating func skippedBraceBody(while condition: (_ tokenKind: RawTokenKind, _ tokenText: SyntaxText) -> Bool) -> RawSkippedDeclSyntax? {
    return self.withLookahead { lookahead in
      guard lookahead.advanceUntilMatchingRightBrace(while: condition) == .reachedToEnd else {
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
    case aborted
    case reachedToEnd
  }

  mutating func advanceUntilMatchingRightBrace(while condition: (_ tokenKind: RawTokenKind, _ tokenText: SyntaxText) -> Bool) -> SkipBodyResult {
    var openBraces = 1

    while self.currentToken.rawTokenKind != .endOfFile {
      let tokenKind = currentToken.rawTokenKind
      let tokenText = currentToken.tokenText

      guard condition(tokenKind, tokenText) else {
        return .aborted
      }

      if tokenKind == .leftBrace {
        openBraces += 1
      } else if tokenKind == .rightBrace {
        openBraces -= 1
        if openBraces == 0 {
          break
        }
      }
      self.consumeAnyToken()
    }

    return .reachedToEnd
  }
}
