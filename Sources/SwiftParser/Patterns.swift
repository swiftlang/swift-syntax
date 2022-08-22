//===------------------------- Patterns.swift -----------------------------===//
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

@_spi(RawSyntax) import SwiftSyntax

extension Parser {
  /// Parse a pattern.
  ///
  /// Grammar
  /// =======
  ///
  ///     pattern → wildcard-pattern type-annotation?
  ///     pattern → identifier-pattern type-annotation?
  ///     pattern → value-binding-pattern
  ///     pattern → tuple-pattern type-annotation?
  ///     pattern → enum-case-pattern
  ///     pattern → optional-pattern
  ///     pattern → type-casting-pattern
  ///     pattern → expression-pattern
  ///
  ///     wildcard-pattern → _
  ///
  ///     identifier-pattern → identifier
  ///
  ///     value-binding-pattern → 'var' pattern | 'let' pattern
  ///
  ///     tuple-pattern → ( tuple-pattern-element-list opt )
  ///
  ///     enum-case-pattern → type-identifier? '.' enum-case-name tuple-pattern?
  ///
  ///     optional-pattern → identifier-pattern '?'
  ///
  ///     type-casting-pattern → is-pattern | as-pattern
  ///     is-pattern → 'is' type
  ///     as-pattern → pattern 'as' type
  ///
  ///     expression-pattern → expression
  mutating func parsePattern() -> RawPatternSyntax {
    switch self.currentToken.tokenKind {
    case .leftParen:
      let lparen = self.eat(.leftParen)
      let elements = self.parsePatternTupleElements()
      let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
      return RawPatternSyntax(RawTuplePatternSyntax(
        leftParen: lparen,
        elements: elements,
        unexpectedBeforeRParen,
        rightParen: rparen,
        arena: self.arena
      ))
    case .wildcardKeyword:
      let wildcard = self.eat(.wildcardKeyword)
      return RawPatternSyntax(RawWildcardPatternSyntax(
        wildcard: wildcard, typeAnnotation: nil, arena: self.arena))
    case .identifier:
      let identifier = self.eat(self.currentToken.tokenKind)
      return RawPatternSyntax(RawIdentifierPatternSyntax(
        identifier: identifier, arena: self.arena))
    case .letKeyword, .varKeyword:
      let letOrVar: RawTokenSyntax
      if self.at(.letKeyword) {
        letOrVar = self.eat(.letKeyword)
      } else {
        assert(self.at(.varKeyword))
        letOrVar = self.eat(.varKeyword)
      }
      let value = self.parsePattern()
      return RawPatternSyntax(RawValueBindingPatternSyntax(
        letOrVarKeyword: letOrVar, valuePattern: value, arena: self.arena))
    default:
      return RawPatternSyntax(RawMissingPatternSyntax(arena: self.arena))
    }
  }

  /// Parse a typed pattern.
  ///
  /// Grammar
  /// =======
  ///
  ///     typed-pattern → pattern ':' attributes? inout? type
  mutating func parseTypedPattern() -> (RawPatternSyntax, RawTypeAnnotationSyntax?) {
    let pattern = self.parsePattern()

    // Now parse an optional type annotation.
    guard self.at(.colon) else {
      return (pattern, nil)
    }

    let colon = self.eat(.colon)
    let result = self.parseType()
    let type = RawTypeAnnotationSyntax(
      colon: colon, type: result, arena: self.arena)
    return (pattern, type)
  }

  /// Parse the elements of a tuple pattern.
  ///
  /// Grammar
  /// =======
  ///
  ///     tuple-pattern-element-list → tuple-pattern-element | tuple-pattern-element ',' tuple-pattern-element-list
  ///     tuple-pattern-element → pattern | identifier ':' pattern
  mutating func parsePatternTupleElements() -> RawTuplePatternElementListSyntax {
    var elements = [RawTuplePatternElementSyntax]()
    do {
      var keepGoing = true
      while !self.at(.eof) && !self.at(.rightParen) && keepGoing {
        // If the tuple element has a label, parse it.
        let label: RawTokenSyntax?
        let colon: RawTokenSyntax?
        if self.currentToken.tokenKind == .identifier, self.peek().tokenKind == .colon {
          label = self.consumeAnyToken()
          colon = self.eat(.colon)
        } else {
          label = nil
          colon = nil
        }
        let pattern = self.parsePattern()
        let trailingComma = self.consume(if: .comma)
        keepGoing = trailingComma != nil
        elements.append(RawTuplePatternElementSyntax(
          labelName: label,
          labelColon: colon,
          pattern: pattern,
          trailingComma: trailingComma,
          arena: self.arena))
      }
    }
    return RawTuplePatternElementListSyntax(elements: elements, arena: self.arena)
  }
}

extension Parser {
  /// Parse a pattern that appears immediately under syntax for conditionals like
  /// for-in loops and guard clauses.
  mutating func parseMatchingPattern() -> RawPatternSyntax {
    // Parse productions that can only be patterns.
    if self.at(.varKeyword) || self.at(.letKeyword) {
      let letOrVar = self.consumeAnyToken()
      let value = self.parseMatchingPattern()
      return RawPatternSyntax(RawValueBindingPatternSyntax(
        letOrVarKeyword: letOrVar, valuePattern: value, arena: self.arena))
    } else if self.at(.isKeyword) {
      // matching-pattern ::= 'is' type
      let isKeyword = self.eat(.isKeyword)
      let type = self.parseType()
      return RawPatternSyntax(RawIsTypePatternSyntax(
        isKeyword: isKeyword, type: type, arena: self.arena))
    } else {
      // matching-pattern ::= expr
      // Fall back to expression parsing for ambiguous forms. Name lookup will
      // disambiguate.
      let expr = RawExprSyntax(self.parseSequenceExpression(.basic, inVarOrLet: true))
      return RawPatternSyntax(RawExpressionPatternSyntax(expression: expr, arena: self.arena))
    }
  }
}

// MARK: Lookahead

extension Parser.Lookahead {
  ///   pattern ::= identifier
  ///   pattern ::= '_'
  ///   pattern ::= pattern-tuple
  ///   pattern ::= 'var' pattern
  ///   pattern ::= 'let' pattern
  mutating func canParsePattern() -> Bool {
    switch self.currentToken.tokenKind {
    case .identifier, .wildcardKeyword:
      self.consumeAnyToken()
      return true
    case .letKeyword, .varKeyword:
      self.consumeAnyToken()
      return self.canParsePattern()
    case .leftParen:
      return self.canParsePatternTuple()
    default:
      return false
    }
  }

  private mutating func canParsePatternTuple() -> Bool {
    guard self.consume(if: .leftParen) != nil else {
      return false
    }

    if !self.at(.rightParen) {
      repeat {
        guard self.canParsePattern() else {
          return false
        }
      } while self.consume(if: .comma) != nil
    }

    return self.consume(if: .rightParen) != nil
  }

  ///  typed-pattern ::= pattern (':' type)?
  mutating func canParseTypedPattern() -> Bool {
    guard self.canParsePattern() else {
      return false
    }

    if self.consume(if: .colon) != nil {
      return self.canParseType()
    }
    return true
  }

  /// Determine whether we are at the start of a parameter name when
  /// parsing a parameter.
  func startsParameterName(_ isClosure: Bool) -> Bool {
    // To have a parameter name here, we need a name.
    guard self.currentToken.canBeArgumentLabel else {
      return false
    }

    // If the next token is ':', this is a name.
    let nextTok = self.peek()
    if nextTok.tokenKind == .colon {
      return true
    }

    // If the next token can be an argument label, we might have a name.
    if nextTok.canBeArgumentLabel {
      // If the first name wasn't "isolated", we're done.
      if !self.currentToken.isContextualKeyword("isolated") &&
          !self.currentToken.isContextualKeyword("some") &&
          !self.currentToken.isContextualKeyword("any") {
        return true
      }

      // "isolated" can be an argument label, but it's also a contextual keyword,
      // so look ahead one more token (two total) see if we have a ':' that would
      // indicate that this is an argument label.
      do {
        var backtrack = self.lookahead()
        if backtrack.at(.colon) {
          return true // isolated :
        }
        backtrack.consumeAnyToken()
        backtrack.consumeAnyToken()
        return backtrack.currentToken.canBeArgumentLabel && nextTok.tokenKind == .colon
      }
    }

    if nextTok.isOptionalToken || nextTok.isImplicitlyUnwrappedOptionalToken {
      return false
    }

    // The identifier could be a name or it could be a type. In a closure, we
    // assume it's a name, because the type can be inferred. Elsewhere, we
    // assume it's a type.
    return isClosure
  }
}
