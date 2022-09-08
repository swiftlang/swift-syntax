//===----------------------- Expressions.swift ----------------------------===//
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
  public enum ExprFlavor {
    case basic
    case trailingClosure
  }

  /// Parse an expression.
  ///
  /// Grammar
  /// =======
  ///
  ///     expression → try-operator? await-operator? prefix-expression infix-expressions?
  ///     expression-list → expression | expression ',' expression-list
  @_spi(RawSyntax)
  public mutating func parseExpression(_ flavor: ExprFlavor = .trailingClosure) -> RawExprSyntax {
    // If we are parsing a refutable pattern, check to see if this is the start
    // of a let/var/is pattern.  If so, parse it as an UnresolvedPatternExpr and
    // let pattern type checking determine its final form.
    //
    // Only do this if we're parsing a pattern, to improve QoI on malformed
    // expressions followed by (e.g.) let/var decls.
    if self.at(.varKeyword) || self.at(.letKeyword) || self.at(.isKeyword) {
      let pattern = self.parseMatchingPattern()
      return RawExprSyntax(RawUnresolvedPatternExprSyntax(pattern: pattern, arena: self.arena))
    }
    return RawExprSyntax(self.parseSequenceExpression(flavor))
  }
}

extension Parser {
  /// Parse a sequence of expressions.
  ///
  /// Grammar
  /// =======
  ///
  ///     infix-expression → infix-operator prefix-expression
  ///     infix-expression → assignment-operator try-operator? prefix-expression
  ///     infix-expression → conditional-operator try-operator? prefix-expression
  ///     infix-expression → type-casting-operator
  ///     infix-expressions → infix-expression infix-expressions?
  @_spi(RawSyntax)
  public mutating func parseSequenceExpression(
    _ flavor: ExprFlavor,
    forDirective: Bool = false,
    inVarOrLet: Bool = false
  ) -> RawExprSyntax {
    if forDirective && self.currentToken.isAtStartOfLine {
      return RawExprSyntax(RawMissingExprSyntax(arena: self.arena))
    }

    // Parsed sequence elements except 'lastElement'.
    var elements = [RawExprSyntax]()

    // The last element parsed. we don't eagarly append to 'elements' because we
    // don't want to populate the 'Array' unless the expression is actually
    // sequenced.
    var lastElement: RawExprSyntax

    lastElement = self.parseSequenceExpressionElement(flavor, forDirective: forDirective)

    var loopCondition = LoopProgressCondition()
    while loopCondition.evaluate(currentToken) {
      guard
        !lastElement.is(RawMissingExprSyntax.self),
        !(forDirective && self.currentToken.isAtStartOfLine)
      else {
        break
      }

      // Parse the operator.
      guard
        let (operatorExpr, rhsExpr) =
          self.parseSequenceExpressionOperator(flavor, inVarOrLet: inVarOrLet)
      else {
        // Not an operator. We're done.
        break
      }

      elements.append(lastElement)
      elements.append(operatorExpr)

      if let rhsExpr = rhsExpr {
        // Operator parsing returned the RHS.
        lastElement = rhsExpr
      } else if forDirective && self.currentToken.isAtStartOfLine {
        // Don't allow RHS at a newline for `#if` conditions.
        lastElement = RawExprSyntax(RawMissingExprSyntax(arena: self.arena))
        break
      } else {
        lastElement = self.parseSequenceExpressionElement(flavor, forDirective: forDirective)
      }
    }

    // There was no operators. Return the only element we parsed.
    if elements.isEmpty {
      return lastElement
    }

    assert(elements.count.isMultiple(of: 2),
           "elements must have a even number of elements")

    elements.append(lastElement)

    return RawExprSyntax(RawSequenceExprSyntax(
      elements: RawExprListSyntax(elements: elements, arena: self.arena),
      arena: self.arena))
  }

  /// Parse an expression sequence operators.
  ///
  /// Returns `nil` if the current token is not at an operator.
  /// Returns a tuple of an operator expression and a optional right operand
  /// expression. The right operand is only returned if it is not a common
  /// sequence element.
  ///
  /// Grammar
  /// =======
  ///
  ///     infix-operator → operator
  ///     assignment-operator → '='
  ///     conditional-operator → '?' expression ':'
  ///     type-casting-operator → 'is' type
  ///     type-casting-operator → 'as' type
  ///     type-casting-operator → 'as' '?' type
  ///     type-casting-operator → 'as' '!' type
  ///     arrow-operator -> 'async' '->'
  ///     arrow-operator -> 'throws' '->'
  ///     arrow-operator -> 'async' 'throws' '->'
  mutating func parseSequenceExpressionOperator(
    _ flavor: ExprFlavor, inVarOrLet: Bool
  ) -> (operator: RawExprSyntax, rhs: RawExprSyntax?)? {
    switch self.currentToken.tokenKind {
    case .spacedBinaryOperator, .unspacedBinaryOperator:
      // Parse the operator.
      let operatorToken = self.consumeAnyToken()
      let op = RawBinaryOperatorExprSyntax(operatorToken: operatorToken, arena: arena)
      return (RawExprSyntax(op), nil)

    case .infixQuestionMark:
      // Save the '?'.
      let question = self.eat(.infixQuestionMark)
      let firstChoice = self.parseSequenceExpression(flavor)
      // Make sure there's a matching ':' after the middle expr.
      let (unexpectedBeforeColon, colon) = self.expect(.colon)

      let op = RawUnresolvedTernaryExprSyntax(
        questionMark: question,
        firstChoice: firstChoice,
        unexpectedBeforeColon,
        colonMark: colon,
        arena: self.arena)

      let rhs: RawExprSyntax?
      if colon.isMissing {
        // If the colon is missing there's not much more structure we can
        // expect out of this expression sequence. Emit a missing expression
        // to end the parsing here.
        rhs = RawExprSyntax(RawMissingExprSyntax(arena: self.arena))
      } else {
        rhs = nil
      }
      return (RawExprSyntax(op), rhs)

    case .equal where !inVarOrLet:
      let eq = self.eat(.equal)
      let op = RawAssignmentExprSyntax(assignToken: eq, arena: self.arena)
      return (RawExprSyntax(op), nil)

    case .isKeyword:
      let isKeyword = self.eat(.isKeyword)
      let op = RawUnresolvedIsExprSyntax(isTok: isKeyword, arena: self.arena)

      // Parse the right type expression operand as part of the 'is' production.
      let type = self.parseType()
      let rhs = RawTypeExprSyntax(type: type, arena: self.arena)

      return (RawExprSyntax(op), RawExprSyntax(rhs))

    case .asKeyword:
      let asKeyword = self.eat(.asKeyword)
      let failable: RawTokenSyntax?
      if self.at(.postfixQuestionMark) || self.at(.exclamationMark) {
        failable = self.consumeAnyToken()
      } else {
        failable = nil
      }
      let op = RawUnresolvedAsExprSyntax(
        asTok: asKeyword, questionOrExclamationMark: failable, arena: self.arena)

      // Parse the right type expression operand as part of the 'as' production.
      let type = self.parseType()
      let rhs = RawTypeExprSyntax(type: type, arena: self.arena)

      return (RawExprSyntax(op), RawExprSyntax(rhs))

    case .identifier:
      guard
        self.currentToken.isContextualKeyword("async"),
        (self.peek().tokenKind == .arrow || self.peek().tokenKind == .throwsKeyword) else {
        return nil
      }
      fallthrough
    case .arrow, .throwsKeyword:
      let asyncKeyword: RawTokenSyntax?
      if self.currentToken.isContextualKeyword("async") {
        asyncKeyword = self.consume(remapping: .contextualKeyword)
      } else {
        asyncKeyword = nil
      }

      let throwsKeyword = self.consume(if: .throwsKeyword)
      let (unexpectedBeforeArrow, arrow) = self.expect(.arrow)

      let op = RawArrowExprSyntax(
        asyncKeyword: asyncKeyword,
        throwsToken: throwsKeyword,
        unexpectedBeforeArrow,
        arrowToken: arrow,
        arena: self.arena)

      return (RawExprSyntax(op), nil)

    default:
      // Not an operator.
      return nil
    }
  }

  /// Parse an expression sequence element.
  ///
  /// Grammar
  /// =======
  ///
  ///     expression → try-operator? await-operator? prefix-expression infix-expressions?
  ///     expression-list → expression | expression ',' expression-list
  @_spi(RawSyntax)
  public mutating func parseSequenceExpressionElement(
    _ flavor: ExprFlavor,
    forDirective: Bool = false
  ) -> RawExprSyntax {
    if self.currentToken.isContextualKeyword("await") {
      let awaitTok = self.consumeAnyToken()
      let sub = self.parseSequenceExpressionElement(flavor)
      return RawExprSyntax(RawAwaitExprSyntax(
        awaitKeyword: awaitTok, expression: sub,
        arena: self.arena))
    }

    // Try to parse '@' sign or 'inout' as a attributed typerepr.
    if self.at(.atSign) || self.at(.inoutKeyword) {
      var backtrack = self.lookahead()
      if backtrack.canParseType() {
        let type = self.parseType()
        return RawExprSyntax(RawTypeExprSyntax(type: type,
                                               arena: self.arena))
      }
    }

    guard self.at(.tryKeyword) else {
      return self.parseUnaryExpression(flavor, forDirective: forDirective)
    }

    let tryKeyword = self.eat(.tryKeyword)
    let mark: RawTokenSyntax?
    if self.at(.exclamationMark) || self.at(.postfixQuestionMark) {
      mark = self.consumeAnyToken()
    } else {
      mark = nil
    }

    let expression = self.parseSequenceExpressionElement(flavor)
    return RawExprSyntax(RawTryExprSyntax(
      tryKeyword: tryKeyword,
      questionOrExclamationMark: mark,
      expression: expression,
      arena: self.arena))
  }

  /// Parse an optional prefix operator followed by an expression.
  ///
  /// Grammar
  /// =======
  ///
  ///     prefix-expression → prefix-operator? postfix-expression
  ///     prefix-expression → in-out-expression
  ///
  ///     in-out-expression → '&' identifier
  @_spi(RawSyntax)
  public mutating func parseUnaryExpression(
    _ flavor: ExprFlavor,
    forDirective: Bool = false
  ) -> RawExprSyntax {
    // First check to see if we have the start of a regex literal `/.../`.
    //    tryLexRegexLiteral(/*forUnappliedOperator*/ false)
    switch self.currentToken.tokenKind {
    case .prefixAmpersand:
      let amp = self.eat(.prefixAmpersand)
      let expr = self.parseUnaryExpression(flavor)
      return RawExprSyntax(RawInOutExprSyntax(
        ampersand: amp, expression: RawExprSyntax(expr),
        arena: self.arena))

    case .backslash:
      return RawExprSyntax(self.parseKeyPathExpression(forDirective: forDirective))

    case .prefixOperator:
      let op = self.eat(.prefixOperator)
      let postfix = self.parseUnaryExpression(flavor, forDirective: forDirective)
      return RawExprSyntax(RawPrefixOperatorExprSyntax(
        operatorToken: op, postfixExpression: postfix,
        arena: self.arena))

    default:
      // If the next token is not an operator, just parse this as expr-postfix.
      return self.parsePostfixExpression(flavor, forDirective: forDirective)
    }
  }

  /// Parse a postfix expression applied to another expression.
  ///
  /// Grammar
  /// =======
  ///
  ///     postfix-expression → primary-expression
  ///     postfix-expression → postfix-expression postfix-operator
  ///     postfix-expression → function-call-expression
  ///     postfix-expression → initializer-expression
  ///     postfix-expression → explicit-member-expression
  ///     postfix-expression → postfix-self-expression
  ///     postfix-expression → subscript-expression
  ///     postfix-expression → forced-value-expression
  ///     postfix-expression → optional-chaining-expression
  @_spi(RawSyntax)
  public mutating func parsePostfixExpression(
    _ flavor: ExprFlavor,
    forDirective: Bool
  ) -> RawExprSyntax {
    let head = self.parsePrimaryExpression()
    guard !head.is(RawMissingExprSyntax.self) else {
      return head
    }
    return self.parsePostfixExpressionSuffix(head, flavor, forDirective: forDirective)
  }

  @_spi(RawSyntax)
  public mutating func parseDottedExpressionSuffix(_ start: RawExprSyntax?) -> RawExprSyntax {
    assert(self.at(.period) || self.at(.prefixPeriod))

      // A key path is special, because it allows .[, unlike anywhere else. The
      // period itself should be left in the token stream. (.? and .! end up
      // being operators, and so aren't handled here.)
//        if (periodHasKeyPathBehavior && peekToken().is(tok::l_square)) {
//          break
//        }

    let period = self.consume(remapping: .period)
    // Handle "x.42" - a tuple index.
    if self.currentToken.tokenKind == .integerLiteral {
      let name = self.consumeAnyToken()
      return RawExprSyntax(RawMemberAccessExprSyntax(
        base: start, dot: period, name: name, declNameArguments: nil,
        arena: self.arena))
    }

    // Handle "x.self" expr.
    if self.at(.selfKeyword) {
      let selfKeyword = self.eat(.selfKeyword)
      return RawExprSyntax(RawMemberAccessExprSyntax(
        base: start, dot: period, name: selfKeyword, declNameArguments: nil,
        arena: self.arena))
    }

    let (ident, args) = self.parseDeclNameRef([ .keywords, .compoundNames ])
    let memberAccess = RawMemberAccessExprSyntax(
      base: start, dot: period, name: ident, declNameArguments: args,
      arena: self.arena)

    guard self.lookahead().canParseAsGenericArgumentList() else {
      return RawExprSyntax(memberAccess)
    }

    let generics = self.parseGenericArguments()
    return RawExprSyntax(RawSpecializeExprSyntax(
      expression: RawExprSyntax(memberAccess),
      genericArgumentClause: generics,
      arena: self.arena))
  }

  @_spi(RawSyntax)
  public mutating func parseIfConfigExpressionSuffix(
    _ start: RawExprSyntax?,
    _ flavor: ExprFlavor,
    forDirective: Bool
  ) -> RawExprSyntax {
    assert(self.at(.poundIfKeyword))

    let config = self.parsePoundIfDirective { parser -> RawExprSyntax? in
      let head: RawExprSyntax
      if parser.at(.period) || parser.at(.prefixPeriod) {
        head = parser.parseDottedExpressionSuffix(nil)
      } else if parser.at(.poundIfKeyword) {
        head = parser.parseIfConfigExpressionSuffix(nil, flavor, forDirective: forDirective)
      } else {
        // TODO: diagnose and skip.
        return nil
      }
      let result = parser.parsePostfixExpressionSuffix(head, flavor, forDirective: forDirective)

      // TODO: diagnose and skip the remaining token in the current clause.
      return result
    }
  syntax: { parser, elements in
      guard elements.count == 1 else {
        assert(elements.isEmpty)
        return RawSyntax(RawMissingExprSyntax(arena: parser.arena))
      }
      return RawSyntax(elements.first!)
    }

    return RawExprSyntax(RawPostfixIfConfigExprSyntax(
      base: start, config: config,
      arena: self.arena))
  }

  /// Parse the suffix of a postfix expression.
  ///
  /// Grammar
  /// =======
  ///
  ///     postfix-expression → postfix-expression postfix-operator
  ///     postfix-expression → function-call-expression
  ///     postfix-expression → initializer-expression
  ///     postfix-expression → explicit-member-expression
  ///     postfix-expression → postfix-self-expression
  ///     postfix-expression → subscript-expression
  ///     postfix-expression → forced-value-expression
  ///     postfix-expression → optional-chaining-expression
  @_spi(RawSyntax)
  public mutating func parsePostfixExpressionSuffix(
    _ start: RawExprSyntax,
    _ flavor: ExprFlavor,
    forDirective: Bool
  ) -> RawExprSyntax {
    // Handle suffix expressions.
    var leadingExpr = start
    var loopCondition = LoopProgressCondition()
    while loopCondition.evaluate(currentToken) {
      if forDirective && self.currentToken.isAtStartOfLine {
        return leadingExpr
      }

      // Check for a .foo suffix.
      if self.at(.period) || self.at(.prefixPeriod) {
        leadingExpr = self.parseDottedExpressionSuffix(leadingExpr)
        continue
      }

      // If there is an expr-call-suffix, parse it and form a call.
      if self.at(.leftParen) && !self.currentToken.isAtStartOfLine {
        // Parse the argument list.
        let lparen = self.eat(.leftParen)
        let args = self.parseArgumentListElements()
        let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)

        // If we can parse trailing closures, do so.
        let trailingClosure: RawClosureExprSyntax?
        let additionalTrailingClosures: RawMultipleTrailingClosureElementListSyntax?
        if case .trailingClosure = flavor, self.at(.leftBrace), self.lookahead().isValidTrailingClosure(flavor) {
          (trailingClosure, additionalTrailingClosures) = self.parseTrailingClosures(flavor)
        } else {
          trailingClosure = nil
          additionalTrailingClosures = nil
        }

        leadingExpr = RawExprSyntax(RawFunctionCallExprSyntax(
          calledExpression: leadingExpr,
          leftParen: lparen,
          argumentList: RawTupleExprElementListSyntax(elements: args, arena: self.arena),
          unexpectedBeforeRParen,
          rightParen: rparen,
          trailingClosure: trailingClosure,
          additionalTrailingClosures: additionalTrailingClosures,
          arena: self.arena))
        continue
      }

      // Check for a [expr] suffix.
      // Note that this cannot be the start of a new line.
      if self.at(.leftSquareBracket) && !self.currentToken.isAtStartOfLine {
        let lsquare = self.eat(.leftSquareBracket)
        let args = self.parseArgumentListElements()
        let (unexpectedBeforeRSquare, rsquare) = self.expect(.rightSquareBracket)

        // If we can parse trailing closures, do so.
        let trailingClosure: RawClosureExprSyntax?
        let additionalTrailingClosures: RawMultipleTrailingClosureElementListSyntax?
        if case .trailingClosure = flavor, self.at(.leftBrace), self.lookahead().isValidTrailingClosure(flavor) {
          (trailingClosure, additionalTrailingClosures) = self.parseTrailingClosures(flavor)
        } else {
          trailingClosure = nil
          additionalTrailingClosures = nil
        }

        leadingExpr = RawExprSyntax(RawSubscriptExprSyntax(
          calledExpression: leadingExpr,
          leftBracket: lsquare,
          argumentList: RawTupleExprElementListSyntax(elements: args, arena: self.arena),
          unexpectedBeforeRSquare,
          rightBracket: rsquare,
          trailingClosure: trailingClosure,
          additionalTrailingClosures: additionalTrailingClosures,
          arena: self.arena))
        continue
      }

      // Check for a trailing closure, if allowed.
      if self.at(.leftBrace) && self.lookahead().isValidTrailingClosure(flavor) {
        // FIXME: if Result has a trailing closure, break out.
        // Add dummy blank argument list to the call expression syntax.
        let list = RawTupleExprElementListSyntax(elements: [], arena: self.arena)
        let (first, rest) = self.parseTrailingClosures(flavor)

        leadingExpr = RawExprSyntax(RawFunctionCallExprSyntax(
          calledExpression: leadingExpr,
          leftParen: nil,
          argumentList: list,
          rightParen: nil,
          trailingClosure: first,
          additionalTrailingClosures: rest,
          arena: self.arena))

        // We only allow a single trailing closure on a call.  This could be
        // generalized in the future, but needs further design.
        if self.at(.leftBrace) {
          break
        }
        continue
      }

      // Check for a ? suffix.
      if let question = self.consume(if: .postfixQuestionMark) {
        leadingExpr = RawExprSyntax(RawOptionalChainingExprSyntax(
          expression: leadingExpr, questionMark: question,
          arena: self.arena))
        continue
      }

      // Check for a ! suffix.
      if let exlaim = self.consume(if: .exclamationMark) {
        leadingExpr = RawExprSyntax(RawForcedValueExprSyntax(
          expression: leadingExpr, exclamationMark: exlaim,
          arena: self.arena))
        continue
      }

      // Check for a postfix-operator suffix.
      if self.currentToken.tokenKind  == .postfixOperator {
        // KeyPaths are more restricted in what can go after a ., and so we treat
        // them specially.
        //        if (periodHasKeyPathBehavior && startsWithSymbol(Tok, '.'))
        //          break

        let op = self.eat(.postfixOperator)
        leadingExpr = RawExprSyntax(RawPostfixUnaryExprSyntax(
          expression: leadingExpr, operatorToken: op,
          arena: self.arena))
        continue
      }

      if self.at(.poundIfKeyword) {
        // Check if the first '#if' body starts with '.' <identifier>, and parse
        // it as a "postfix ifconfig expression".
        do {
          var backtrack = self.lookahead()
          // Skip to the first body. We may need to skip multiple '#if' directives
          // since we support nested '#if's. e.g.
          //   baseExpr
          //   #if CONDITION_1
          //     #if CONDITION_2
          //       .someMember
          repeat {
            backtrack.eat(.poundIfKeyword)
            while !backtrack.at(.eof) && !backtrack.currentToken.isAtStartOfLine {
              backtrack.skipSingle()
            }
          } while backtrack.at(.poundIfKeyword)

          guard backtrack.isAtStartOfPostfixExprSuffix() else {
            break
          }
        }

        leadingExpr = self.parseIfConfigExpressionSuffix(
          leadingExpr, flavor, forDirective: forDirective)
        continue
      }

      // Otherwise, we don't know what this token is, it must end the expression.
      break
    }
    return leadingExpr
  }
}

extension Parser {
  /// Parse a keypath expression.
  ///
  /// Grammar
  /// =======
  ///
  ///     key-path-expression → '\' type? '.' key-path-components
  ///
  ///     key-path-components → key-path-component | key-path-component '.' key-path-components
  ///     key-path-component → identifier key-path-postfixes? | key-path-postfixes
  ///
  ///     key-path-postfixes → key-path-postfix key-path-postfixes?
  ///     key-path-postfix → '?' | '!' | 'self' | '[' function-call-argument-list ']'
  @_spi(RawSyntax)
  public mutating func parseKeyPathExpression(forDirective: Bool) -> RawKeyPathExprSyntax {
    // Consume '\'.
    let backslash = self.eat(.backslash)

    // For uniformity, \.foo is parsed as if it were MAGIC.foo, so we need to
    // make sure the . is there, but parsing the ? in \.? as .? doesn't make
    // sense. This is all made more complicated by .?. being considered an
    // operator token. Since keypath allows '.!' '.?' and '.[', consume '.'
    // the token is a operator starts with '.', or the following token is '['.
    let root: RawExprSyntax?
    if !self.currentToken.starts(with: ".") {
      root = self.parsePostfixExpression(.basic, forDirective: forDirective)
    } else {
      root = nil
    }

    let expression: RawExprSyntax
    if (self.currentToken.isAnyOperator && self.currentToken.tokenText.count != 1) || self.peek().tokenKind == .leftSquareBracket {
      let dot = self.consumePrefix(".", as: .period)
      let base = RawExprSyntax(RawKeyPathBaseExprSyntax(period: dot, arena: self.arena))
      expression = self.parsePostfixExpressionSuffix(base, .basic, forDirective: forDirective)
    } else if self.at(.period) || self.at(.prefixPeriod) {
      // Inside a keypath's path, the period always behaves normally: the key path
      // behavior is only the separation between type and path.
      let base = self.parseDottedExpressionSuffix(nil)
      expression = self.parsePostfixExpressionSuffix(base, .basic, forDirective: forDirective)
    } else {
      expression = RawExprSyntax(RawMissingExprSyntax(arena: self.arena))
    }

    return RawKeyPathExprSyntax(
      backslash: backslash,
      rootExpr: root,
      expression: expression,
      arena: self.arena)
  }
}

extension Parser {
  /// Parse a "primary expression" - these are the most basic leaves of the
  /// Swift expression grammar.
  ///
  /// Grammar
  /// =======
  ///
  ///     primary-expression → identifier generic-argument-clause?
  ///     primary-expression → literal-expression
  ///     primary-expression → self-expression
  ///     primary-expression → superclass-expression
  ///     primary-expression → closure-expression
  ///     primary-expression → parenthesized-expression
  ///     primary-expression → tuple-expression
  ///     primary-expression → implicit-member-expression
  ///     primary-expression → wildcard-expression
  ///     primary-expression → key-path-expression
  ///     primary-expression → selector-expression
  ///     primary-expression → key-path-string-expression
  @_spi(RawSyntax)
  public mutating func parsePrimaryExpression() -> RawExprSyntax {
    switch self.currentToken.tokenKind {
    case .integerLiteral:
      let digits = self.eat(.integerLiteral)
      return RawExprSyntax(RawIntegerLiteralExprSyntax(digits: digits, arena: self.arena))
    case .floatingLiteral:
      let digits = self.eat(.floatingLiteral)
      return RawExprSyntax(RawFloatLiteralExprSyntax(floatingDigits: digits, arena: self.arena))
    case .stringLiteral:
      return RawExprSyntax(self.parseStringLiteral())
    case .regexLiteral:
      return RawExprSyntax(self.parseRegexLiteral())
    case .nilKeyword:
      let nilKeyword = self.eat(.nilKeyword)
      return RawExprSyntax(RawNilLiteralExprSyntax(nilKeyword: nilKeyword, arena: self.arena))
    case .trueKeyword, .falseKeyword:
      let tok = self.eat(self.currentToken.tokenKind)
      return RawExprSyntax(RawBooleanLiteralExprSyntax(booleanLiteral: tok, arena: self.arena))
    case .__file__Keyword:
      let tok = self.eat(.__file__Keyword)
      return RawExprSyntax(RawPoundFileExprSyntax(poundFile: tok, arena: self.arena))
    case .poundFileKeyword:
      let tok = self.eat(.poundFileKeyword)
      return RawExprSyntax(RawPoundFileExprSyntax(poundFile: tok, arena: self.arena))
    case .poundFilePathKeyword:
      let tok = self.eat(.poundFilePathKeyword)
      return RawExprSyntax(RawPoundFilePathExprSyntax(poundFilePath: tok, arena: self.arena))
    case .poundFunctionKeyword:
      let tok = self.eat(.poundFunctionKeyword)
      return RawExprSyntax(RawPoundFunctionExprSyntax(poundFunction: tok, arena: self.arena))
    case .__function__Keyword:
      let tok = self.eat(.__function__Keyword)
      return RawExprSyntax(RawPoundFunctionExprSyntax(poundFunction: tok, arena: self.arena))
    case .poundLineKeyword:
      let tok = self.eat(.poundLineKeyword)
      return RawExprSyntax(RawPoundLineExprSyntax(poundLine: tok, arena: self.arena))
    case .__line__Keyword:
      let tok = self.eat(.__line__Keyword)
      return RawExprSyntax(RawPoundLineExprSyntax(poundLine: tok, arena: self.arena))
    case .poundColumnKeyword:
      let tok = self.eat(.poundColumnKeyword)
      return RawExprSyntax(RawPoundColumnExprSyntax(poundColumn: tok, arena: self.arena))
    case .__column__Keyword:
      let tok = self.eat(.__column__Keyword)
      return RawExprSyntax(RawPoundColumnExprSyntax(poundColumn: tok, arena: self.arena))
    case .poundDsohandleKeyword:
      let tok = self.eat(.poundDsohandleKeyword)
      return RawExprSyntax(RawPoundDsohandleExprSyntax(poundDsohandle: tok, arena: self.arena))
    case .__dso_handle__Keyword:
      let tok = self.eat(.__dso_handle__Keyword)
      return RawExprSyntax(RawPoundDsohandleExprSyntax(poundDsohandle: tok, arena: self.arena))
    case .identifier, .selfKeyword:
      // 'any' followed by another identifier is an existential type.
      if self.currentToken.isContextualKeyword("any"),
         self.peek().tokenKind == .identifier,
         self.peek().isAtStartOfLine
      {
        let ty = self.parseType()
        return RawExprSyntax(RawTypeExprSyntax(type: ty, arena: self.arena))
      }

      return RawExprSyntax(self.parseIdentifierExpression())
    case .capitalSelfKeyword:     // Self
      return RawExprSyntax(self.parseIdentifierExpression())
    case .anyKeyword: // Any
      let anyType = RawTypeSyntax(self.parseAnyType())
      return RawExprSyntax(RawTypeExprSyntax(type: anyType, arena: self.arena))
    case .dollarIdentifier:
      return RawExprSyntax(self.parseAnonymousClosureArgument())
    case .wildcardKeyword: // _
      let wild = self.eat(.wildcardKeyword)
      return RawExprSyntax(RawDiscardAssignmentExprSyntax(
        wildcard: wild, arena: self.arena))
    case .poundSelectorKeyword:
      return RawExprSyntax(self.parseObjectiveCSelectorLiteral())
    case .poundKeyPathKeyword:
      return RawExprSyntax(self.parseObjectiveCKeyPathExpression())

    case .poundColorLiteralKeyword,
         .poundImageLiteralKeyword,
         .poundFileLiteralKeyword:
      return RawExprSyntax(self.parseObjectLiteralExpression())

    case .leftBrace:     // expr-closure
      return RawExprSyntax(self.parseClosureExpression())
    case .period,              //=.foo
         .prefixPeriod:      // .foo
      let dot = self.consume(remapping: .prefixPeriod)
      let (name, args) = self.parseDeclNameRef([ .keywords, .compoundNames ])
      return RawExprSyntax(RawMemberAccessExprSyntax(
        base: nil, dot: dot, name: name, declNameArguments: args,
        arena: self.arena))
    case .superKeyword: // 'super'
      return RawExprSyntax(self.parseSuperExpression())

    case .leftParen:
      // Build a tuple expression syntax node.
      // AST differentiates paren and tuple expression where the former allows
      // only one element without label. However, libSyntax tree doesn't have this
      // differentiation. A tuple expression node in libSyntax can have a single
      // element without label.
      return RawExprSyntax(self.parseTupleExpression())

    case .leftSquareBracket:
      return self.parseCollectionLiteral()

    default:
      return RawExprSyntax(RawMissingExprSyntax(arena: self.arena))
    }
  }
}

extension Parser {
  /// Parse an identifier as an expression.
  ///
  /// Grammar
  /// =======
  ///
  ///     primary-expression → identifier
  @_spi(RawSyntax)
  public mutating func parseIdentifierExpression() -> RawExprSyntax {
    let (name, args) = self.parseDeclNameRef(.compoundNames)
    let identifier = RawIdentifierExprSyntax(
      identifier: name, declNameArguments: args,
      arena: self.arena)

    guard self.lookahead().canParseAsGenericArgumentList() else {
      return RawExprSyntax(identifier)
    }

    let generics = self.parseGenericArguments()
    return RawExprSyntax(RawSpecializeExprSyntax(
      expression: RawExprSyntax(identifier), genericArgumentClause: generics,
      arena: self.arena))
  }
}

extension Parser {
  /// Parse an identifier as an expression.
  ///
  /// Grammar
  /// =======
  ///
  ///     playground-literal → '#colorLiteral' '(' red ':' expression , green ':' expression , blue ':' expression , alpha ':' expression )
  ///     playground-literal → '#fileLiteral' '(' resourceName ':' expression ')'
  ///     playground-literal → '#imageLiteral' '(' resourceName ':' expression ')'
  @_spi(RawSyntax)
  public mutating func parseObjectLiteralExpression() -> RawObjectLiteralExprSyntax {
    let poundKeyword = self.consumeAnyToken()
    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
    let arguments = self.parseArgumentListElements()
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
    return RawObjectLiteralExprSyntax(
      identifier: poundKeyword,
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      arguments: RawTupleExprElementListSyntax(elements: arguments, arena: self.arena),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      arena: self.arena)
  }
}

extension Parser {
  /// Parse a string literal expression.
  ///
  /// Grammar
  /// =======
  ///
  ///     string-literal → static-string-literal | interpolated-string-literal
  ///
  ///     string-literal-opening-delimiter → extended-string-literal-delimiter? '"'
  ///     string-literal-closing-delimiter → '"' extended-string-literal-delimiter?
  ///
  ///     static-string-literal → string-literal-opening-delimiter quoted-text? string-literal-closing-delimiter
  ///     static-string-literal → multiline-string-literal-opening-delimiter multiline-quoted-text? multiline-string-literal-closing-delimiter
  ///
  ///     multiline-string-literal-opening-delimiter → extended-string-literal-delimiter? '"""'
  ///     multiline-string-literal-closing-delimiter → '"""' extended-string-literal-delimiter?
  ///     extended-string-literal-delimiter → '#' extended-string-literal-delimiter?
  ///
  ///     quoted-text → quoted-text-item quoted-text?
  ///     quoted-text-item → escaped-character
  ///     quoted-text-item → `Any Unicode scalar value except ", \, U+000A, or U+000D`
  ///
  ///     multiline-quoted-text → multiline-quoted-text-item multiline-quoted-text?
  ///     multiline-quoted-text-item → escaped-character
  ///     multiline-quoted-text-item → `Any Unicode scalar value except \`
  ///     multiline-quoted-text-item → escaped-newline
  ///
  ///     interpolated-string-literal → string-literal-opening-delimiter interpolated-text? string-literal-closing-delimiter
  ///     interpolated-string-literal → multiline-string-literal-opening-delimiter multiline-interpolated-text? multiline-string-literal-closing-delimiter
  ///     interpolated-text → interpolated-text-item interpolated-text?
  ///     interpolated-text-item → '\(' expression ')' | quoted-text-item
  ///
  ///     multiline-interpolated-text → multiline-interpolated-text-item multiline-interpolated-text?
  ///     multiline-interpolated-text-item → '\(' expression ')' | multiline-quoted-text-item
  ///     escape-sequence → \ extended-string-literal-delimiter
  ///     escaped-character → escape-sequence '0' | escape-sequence '\' | escape-sequence 't' | escape-sequence 'n' | escape-sequence 'r' | escape-sequence '"' | escape-sequence '''
  ///
  ///     escaped-character → escape-sequence 'u' '{' unicode-scalar-digits '}'
  ///     unicode-scalar-digits → Between one and eight hexadecimal digits
  ///
  ///     escaped-newline → escape-sequence inline-spaces? line-break
  @_spi(RawSyntax)
  public mutating func parseStringLiteral() -> RawStringLiteralExprSyntax {
    var text = self.currentToken.wholeText[self.currentToken.textRange]

    /// Parse opening raw string delimiter if exist.
    let openDelimiter = self.parseStringLiteralDelimiter(at: .leading, text: text)
    if let openDelimiter = openDelimiter {
      text = text.dropFirst(openDelimiter.tokenText.count)
    }

    /// Parse open quote.
    let openQuote = self.parseStringLiteralQuote(
      at: openDelimiter != nil ? .leadingRaw : .leading,
      text: text
    ) ?? RawTokenSyntax(missing: .stringQuote, arena: arena)
    if !openQuote.isMissing {
      text = text.dropFirst(openQuote.tokenText.count)
    }

    /// Parse segments.
    let (segments, closeStart) = self.parseStringLiteralSegments(
      text, openQuote, openDelimiter?.tokenText ?? "")
    text = text[closeStart...]

    /// Parse close quote.
    let closeQuote = self.parseStringLiteralQuote(
      at: openDelimiter != nil ? .trailingRaw : .trailing,
      text: text
    ) ?? RawTokenSyntax(missing: openQuote.tokenKind, arena: arena)
    if !closeQuote.isMissing {
      text = text.dropFirst(closeQuote.tokenText.count)
    }
    /// Parse closing raw string delimiter if exist.
    let closeDelimiter: RawTokenSyntax?
    if let delimiter = self.parseStringLiteralDelimiter(
      at: .trailing,
      text: text
    ) {
      closeDelimiter = delimiter
    } else if let openDelimiter = openDelimiter {
      closeDelimiter = RawTokenSyntax(
        missing: .rawStringDelimiter,
        text: openDelimiter.tokenText,
        arena: arena
      )
    } else {
      closeDelimiter = nil
    }
    assert((openDelimiter == nil) == (closeDelimiter == nil),
           "existence of open/close delimiter should match")
    if let closeDelimiter = closeDelimiter, !closeDelimiter.isMissing {
      text = text.dropFirst(closeDelimiter.byteLength)
    }

    assert(text.isEmpty,
           "string literal parsing should consume all the literal text")

    /// Discard the raw string literal token and create the structed string
    /// literal expression.
    /// FIXME: We should not instantiate `RawTokenSyntax` and discard it here.
    _ = self.consumeAnyToken()

    /// Construct the literal expression.
    return RawStringLiteralExprSyntax(
      openDelimiter: openDelimiter,
      openQuote: openQuote,
      segments: segments,
      closeQuote: closeQuote,
      closeDelimiter: closeDelimiter,
      arena: self.arena)
  }

  // Enumerates the positions that a quote can appear in a string literal.
  enum QuotePosition {
    /// The quote appears in leading position.
    ///
    /// ```swift
    /// "Hello World"
    /// ^
    /// ##"Hello World"##
    /// ^
    /// ```
    case leading

    /// The quote appears in trailing position.
    ///
    /// ```swift
    /// "Hello World"
    ///             ^
    /// ##"Hello World"##
    ///                ^
    /// ```
    case trailing
    /// The quote appears in at the start of a raw string literal.
    ///
    /// ```swift
    /// ##"Hello World"##
    ///   ^
    /// ```
    case leadingRaw
    /// The quote appears in at the end of a raw string literal.
    ///
    /// ```swift
    /// ##"Hello World"##
    ///               ^
    /// ```
    case trailingRaw
  }

  /// Create string literal delimiter/quote token syntax for `position`.
  ///
  /// `text` will the token text of the token. The `text.base` must be the whole
  /// text of the original `.stringLiteral` token including trivia.
  private func makeStringLiteralQuoteToken(
    _ kind: RawTokenKind,
    text: Slice<SyntaxText>,
    at position: QuotePosition
  ) -> RawTokenSyntax {
    let wholeText: SyntaxText
    let textRange: Range<SyntaxText.Index>
    switch position {
    case .leadingRaw, .trailingRaw:
      wholeText = SyntaxText(rebasing: text)
      textRange = wholeText.startIndex ..< wholeText.endIndex
    case .leading:
      wholeText = SyntaxText(rebasing: text.base[..<text.endIndex])
      textRange = text.startIndex ..< text.endIndex
    case .trailing:
      wholeText = SyntaxText(rebasing: text.base[text.startIndex...])
      textRange = wholeText.startIndex ..< wholeText.startIndex + text.count
    }
    return RawTokenSyntax(
      kind: kind,
      wholeText: wholeText,
      textRange: textRange,
      presence: .present,
      arena: self.arena
    )
  }

  mutating func parseStringLiteralDelimiter(
    at position: QuotePosition,
    text: Slice<SyntaxText>
  ) -> RawTokenSyntax? {
    assert(position != .leadingRaw && position != .trailingRaw)
    var index = text.startIndex
    while index < text.endIndex && text[index] == UInt8(ascii: "#") {
      index = text.index(after: index)
    }
    guard index > text.startIndex else {
      return nil
    }
    return makeStringLiteralQuoteToken(
      .rawStringDelimiter, text: text[..<index], at: position)
  }

  mutating func parseStringLiteralQuote(
    at position: QuotePosition,
    text: Slice<SyntaxText>
  ) -> RawTokenSyntax? {
    // Single quote. We only support single line literal.
    if let first = text.first, first == UInt8(ascii: "'") {
      let index = text.index(after: text.startIndex)
      return makeStringLiteralQuoteToken(
        .singleQuote, text: text[..<index], at: position)
    }

    var index = text.startIndex
    var quoteCount = 0
    while index < text.endIndex && text[index] == UInt8(ascii: "\"") {
      quoteCount += 1
      index = text.index(after: index)
    }

    // Empty single line string. Return only the first quote.
    switch quoteCount {
    case 0, 1:
      break
    case 2:
      quoteCount = 1
      index = text.index(text.startIndex, offsetBy: quoteCount)
    case 3:
      // position == .leadingRaw implies that we saw a `#` before the quote.
      // A multiline string literal must always start its contents on a new line.
      // Thus we are parsing something like #"""#, which is not a multiline string literal but a raw literal containing a single quote.
      if position == .leadingRaw,
         index < text.endIndex,
         text[index] == UInt8(ascii: "#")
      {
        quoteCount = 1
        index = text.index(text.startIndex, offsetBy: quoteCount)
      }
    default:
      // Similar two the above, we are parsing something like #"""""#, which is not a multiline string literal but a raw literal containing three quote.
      if position == .leadingRaw {
        quoteCount = 1
        index = text.index(text.startIndex, offsetBy: quoteCount)
      } else if position == .leading {
        quoteCount = 3
        index = text.index(text.startIndex, offsetBy: quoteCount)
      }
    }

    // Single line string literal.
    if quoteCount == 1 {
      return makeStringLiteralQuoteToken(
        .stringQuote, text: text[..<index], at: position)
    }
    // Multi line string literal.
    if quoteCount == 3 {
      return makeStringLiteralQuoteToken(
        .multilineStringQuote, text: text[..<index], at: position)
    }
    // Otherwise, this is not a literal quote.
    return nil
  }

  /// Foo.
  ///
  /// Parameters:
  ///   - text: slice from after the quote to the end of the literal.
  ///   - closer: opening quote token.
  ///   - delimiter: opening custom string delimiter or empty string.
  mutating func parseStringLiteralSegments(
    _ text: Slice<SyntaxText>,
    _ closer: RawTokenSyntax,
    _ delimiter: SyntaxText
  ) -> (RawStringLiteralSegmentsSyntax, SyntaxText.Index) {
    let allowsMultiline = closer.tokenKind == .multilineStringQuote

    var segments = [RawSyntax]()
    var segment = text
    var stringLiteralSegmentStart = segment.startIndex
    while let slashIndex = segment.firstIndex(of: UInt8(ascii: "\\")), stringLiteralSegmentStart < segment.endIndex {
      let delimiterStart = text.index(after: slashIndex)
      guard (delimiterStart < segment.endIndex &&
             SyntaxText(rebasing: text[delimiterStart...]).hasPrefix(delimiter)) else {
        // If `\` is not followed by the custom delimiter, it's not a segment delimiter.
        // Restart after the `\`.
        segment = text[text.index(after: delimiterStart)...]
        continue
      }

      let contentStart = text.index(delimiterStart, offsetBy: delimiter.count)
      guard (contentStart < segment.endIndex &&
             text[contentStart] == UInt8(ascii: "(")) else {
        // If `\` (or `\#`) is not followed by `(`, it's not a segment delimiter.
        // Restart after the `(`.
        segment = text[text.index(after: contentStart)...]
        continue
      }

      // Collect ".stringSegment" before `\`.
      let segmentToken = RawTokenSyntax(
        kind: .stringSegment,
        text: SyntaxText(rebasing: text[stringLiteralSegmentStart..<slashIndex]),
        leadingTriviaPieces: [], trailingTriviaPieces: [],
        presence: .present,
        arena: self.arena)
      segments.append(RawSyntax(RawStringSegmentSyntax(content: segmentToken, arena: self.arena)))

      let content = SyntaxText(rebasing: text[contentStart...])
      let contentSize = content.withBuffer { buf in
        Lexer.lexToEndOfInterpolatedExpression(buf, allowsMultiline)
      }
      let contentEnd = text.index(contentStart, offsetBy: contentSize)

      do {
        // `\`
        let slashToken = RawTokenSyntax(
          kind: .backslash,
          text: SyntaxText(rebasing: text[slashIndex..<text.index(after: slashIndex)]),
          leadingTriviaPieces: [], trailingTriviaPieces: [],
          presence: .present,
          arena: self.arena)

        // `###`
        let delim: RawTokenSyntax?
        if !delimiter.isEmpty {
          delim = RawTokenSyntax(
            kind: .rawStringDelimiter,
            text: SyntaxText(rebasing: text[delimiterStart..<contentStart]),
            leadingTriviaPieces: [], trailingTriviaPieces: [],
            presence: .present,
            arena: self.arena)
        } else {
          delim = nil
        }

        // `(...)`.
        let expressionContent = SyntaxText(rebasing: text[contentStart...contentEnd])
        expressionContent.withBuffer { buf in
          var subparser = Parser(buf, arena: self.arena)
          let (lunexpected, lparen) = subparser.expect(.leftParen)
          let args = subparser.parseArgumentListElements()
          // If we stopped parsing the expression before the expression segment is
          // over, eat the remaining tokens into a token list.
          var runexpectedTokens = [RawSyntax]()
          let runexpected: RawUnexpectedNodesSyntax?
          while !subparser.at(.eof) && !subparser.at(.rightParen) {
            runexpectedTokens.append(RawSyntax(subparser.consumeAnyToken()))
          }
          if !runexpectedTokens.isEmpty {
            runexpected = RawUnexpectedNodesSyntax(elements: runexpectedTokens, arena: self.arena)
          } else {
            runexpected = nil
          }
          let rparen = subparser.expectWithoutLookahead(.rightParen)

          segments.append(RawSyntax(RawExpressionSegmentSyntax(
            backslash: slashToken,
            delimiter: delim,
            lunexpected,
            leftParen: lparen,
            expressions: RawTupleExprElementListSyntax(elements: args, arena: self.arena),
            runexpected,
            rightParen: rparen,
            arena: self.arena)))
        }
      }

      segment = text[text.index(after: contentEnd)...]
      stringLiteralSegmentStart = segment.startIndex
    }

    /// We still have the last "literal" segment.
    /// Trim the end delimiter. i.e. `"##`.
    segment = text[stringLiteralSegmentStart...]
    if (SyntaxText(rebasing: segment).hasSuffix(delimiter)) {
      // trim `##`.
      segment = text[stringLiteralSegmentStart..<text.index(segment.endIndex, offsetBy: -delimiter.count)]

      if (SyntaxText(rebasing: segment).hasSuffix(closer.tokenText)) {
        // trim `"`.
        segment = text[stringLiteralSegmentStart..<text.index(segment.endIndex, offsetBy: -closer.tokenText.count)]
      } else {
        // If `"` is not found, eat the rest.
        segment = text[stringLiteralSegmentStart...]
      }
    }


    assert(segments.count % 2 == 0)
    assert(segments.isEmpty ||
           segments.last!.is(RawExpressionSegmentSyntax.self))
    let segmentToken = RawTokenSyntax(
      kind: .stringSegment,
      text: SyntaxText(rebasing: segment),
      leadingTriviaPieces: [], trailingTriviaPieces: [],
      presence: .present,
      arena: self.arena)
    segments.append(RawSyntax(RawStringSegmentSyntax(content: segmentToken,
                                                     arena: self.arena)))

    return (RawStringLiteralSegmentsSyntax(elements: segments, arena: arena), segment.endIndex)
  }
}

extension Parser {
  /// Parse a regular expression literal.
  ///
  /// The broad structure of the regular expression is validated by the lexer.
  ///
  /// Grammar
  /// =======
  ///
  ///     regular-expression-literal → '\' `Any valid regular expression characters` '\'
  @_spi(RawSyntax)
  public mutating func parseRegexLiteral() -> RawRegexLiteralExprSyntax {
    let literal = self.eat(.regexLiteral)
    return RawRegexLiteralExprSyntax(regex: literal, arena: self.arena)
  }
}

extension Parser {
  /// Parse an Objective-C #keypath literal.
  ///
  /// Grammar
  /// =======
  ///
  ///     key-path-string-expression → '#keyPath' '(' expression ')'
  @_spi(RawSyntax)
  public mutating func parseObjectiveCKeyPathExpression() -> RawObjcKeyPathExprSyntax {
    let keyword = self.eat(.poundKeyPathKeyword)
    // Parse the leading '('.
    let (unexpectedBeforeLParen, lparen) = self.expect(.leftParen)

    // Parse the sequence of unqualified-names.
    var elements = [RawObjcNamePieceSyntax]()
    do {
      var flags: DeclNameOptions = []
      var keepGoing: RawTokenSyntax? = nil
      repeat {
        // Parse the next name.
        let (name, args) = self.parseDeclNameRef(flags)
        assert(args == nil, "Found arguments but did not pass argument flag?")

        // After the first component, we can start parsing keywords.
        flags.formUnion(.keywords)

        // Parse the next period to continue the path.
        keepGoing = self.consume(if: .period)
        elements.append(RawObjcNamePieceSyntax(
          name: name, dot: keepGoing, arena: self.arena))
      } while keepGoing != nil
    }

    // Parse the closing ')'.
    let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
    return RawObjcKeyPathExprSyntax(
      keyPath: keyword,
      unexpectedBeforeLParen,
      leftParen: lparen,
      name: RawObjcNameSyntax(elements: elements, arena: self.arena),
      unexpectedBeforeRParen,
      rightParen: rparen, arena: self.arena)
  }
}

extension Parser {
  /// Parse a 'super' reference to the superclass instance of a class.
  ///
  /// Grammar
  /// =======
  ///
  ///     primary-expression → 'super'
  @_spi(RawSyntax)
  public mutating func parseSuperExpression() -> RawSuperRefExprSyntax {
    // Parse the 'super' reference.
    let superKeyword = self.eat(.superKeyword)
    return RawSuperRefExprSyntax(superKeyword: superKeyword, arena: self.arena)
  }
}

extension Parser {
  /// Parse a tuple expression.
  ///
  /// Grammar
  /// =======
  ///
  ///     tuple-expression → '(' ')' | '(' tuple-element ',' tuple-element-list ')'
  ///     tuple-element-list → tuple-element | tuple-element ',' tuple-element-list
  @_spi(RawSyntax)
  public mutating func parseTupleExpression() -> RawTupleExprSyntax {
    let lparen = self.eat(.leftParen)
    let elements = self.parseArgumentListElements()
    let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
    return RawTupleExprSyntax(
      leftParen: lparen,
      elementList: RawTupleExprElementListSyntax(elements: elements, arena: self.arena),
      unexpectedBeforeRParen,
      rightParen: rparen,
      arena: self.arena)
  }
}

extension Parser {
  enum CollectionKind {
    case dictionary(key: RawExprSyntax, unexpectedBeforeColon: RawUnexpectedNodesSyntax?, colon: RawTokenSyntax, value: RawExprSyntax)
    case array(RawExprSyntax)
  }

  /// Parse an element of an array or dictionary literal.
  ///
  /// Grammar
  /// =======
  ///
  ///     array-literal-item → expression
  ///
  ///     dictionary-literal-item → expression ':' expression
  mutating func parseCollectionElement(_ existing: CollectionKind?) -> CollectionKind {
    let key = self.parseExpression()
    switch existing {
    case .array(_):
      return .array(key)
    case nil:
      guard self.at(.colon) else {
        return .array(key)
      }
      fallthrough
    case .dictionary:
      let (unexpectedBeforeColon, colon) = self.expect(.colon)
      let value = self.parseExpression()
      return .dictionary(key: key, unexpectedBeforeColon: unexpectedBeforeColon, colon: colon, value: value)
    }
  }

  /// Parse an array or dictionary literal.
  ///
  /// Grammar
  /// =======
  ///
  ///     array-literal → '[' array-literal-items? ']'
  ///     array-literal-items → array-literal-item ','? | array-literal-item ',' array-literal-items
  ///
  ///     dictionary-literal → '[' dictionary-literal-items ']' | '[' ':' ']'
  ///     dictionary-literal-items → dictionary-literal-item ','? | dictionary-literal-item ',' dictionary-literal-items
  @_spi(RawSyntax)
  public mutating func parseCollectionLiteral() -> RawExprSyntax {
    let lsquare = self.eat(.leftSquareBracket)

    if self.at(.rightSquareBracket) {
      let rsquare = self.eat(.rightSquareBracket)
      return RawExprSyntax(RawArrayExprSyntax(
        leftSquare: lsquare,
        elements: RawArrayElementListSyntax(elements: [], arena: self.arena),
        rightSquare: rsquare,
        arena: self.arena))
    }

    if self.at(.colon) && self.peek().tokenKind == .rightSquareBracket {
      let colon = self.eat(.colon)
      let rsquare = self.eat(.rightSquareBracket)
      // FIXME: We probably want a separate node for the empty case.
      return RawExprSyntax(RawDictionaryExprSyntax(
          leftSquare: lsquare,
          content: RawSyntax(colon),
          rightSquare: rsquare, arena: self.arena))
    }

    var elementKind: CollectionKind? = nil
    var elements = [RawSyntax]()
    do {
      var collectionLoopCondition = LoopProgressCondition()
      COLLECTION_LOOP: while collectionLoopCondition.evaluate(currentToken) {
        elementKind = self.parseCollectionElement(elementKind)

        // Parse the ',' if exists.
        let comma = self.consume(if: .comma)

        switch elementKind! {
        case .array(let el):
          elements.append(RawSyntax(RawArrayElementSyntax(
            expression: el, trailingComma: comma, arena: self.arena)))
          if el.is(RawMissingExprSyntax.self) {
            break COLLECTION_LOOP
          }
        case .dictionary(let key, let unexpectedBeforeColon, let colon, let value):
          elements.append(RawSyntax(RawDictionaryElementSyntax(
            keyExpression: key,
            unexpectedBeforeColon,
            colon: colon,
            valueExpression: value,
            trailingComma: comma,
            arena: self.arena)))
          if key.is(RawMissingExprSyntax.self), colon.isMissing, value.is(RawMissingExprSyntax.self) {
            break COLLECTION_LOOP
          }
        }

        // If we found EOF or the closing square bracket, bailout.
        if self.at(.rightSquareBracket) || self.at(.eof) {
          break
        }

        // If The next token is at the beginning of a new line and can never start
        // an element, break.
        if self.currentToken.isAtStartOfLine
            && (self.at(.rightBrace) || self.at(.poundEndifKeyword) || self.lookahead().isStartOfDeclaration() || self.lookahead().isStartOfStatement()) {
          break
        }
      }
    }

    let (unexpectedBeforeRSquare, rsquare) = self.expect(.rightSquareBracket)
    switch elementKind! {
    case .dictionary:
      return RawExprSyntax(RawDictionaryExprSyntax(
        leftSquare: lsquare,
        content: RawSyntax(RawDictionaryElementListSyntax(elements: elements.map {
          $0.as(RawDictionaryElementSyntax.self)!
        }, arena: self.arena)),
        unexpectedBeforeRSquare,
        rightSquare: rsquare,
        arena: self.arena))
    case .array:
      return RawExprSyntax(RawArrayExprSyntax(
        leftSquare: lsquare,
        elements: RawArrayElementListSyntax(elements: elements.map {
          $0.as(RawArrayElementSyntax.self)!
        }, arena: self.arena),
        unexpectedBeforeRSquare,
        rightSquare: rsquare,
        arena: self.arena))
    }
  }
}

extension Parser {
  @_spi(RawSyntax)
  public mutating func parseDefaultArgument() -> RawInitializerClauseSyntax {
    let eq = self.eat(.equal)
    let expr = self.parseExpression()
    return RawInitializerClauseSyntax(
      equal: eq, value: expr, arena: self.arena)
  }
}

extension Parser {
  @_spi(RawSyntax)
  public mutating func parseAnonymousClosureArgument() -> RawIdentifierExprSyntax {
    guard self.currentToken.tokenKind == .dollarIdentifier else {
      fatalError("Production invoked with non-dollar token!")
    }
    let ident = self.consumeAnyToken()
    return RawIdentifierExprSyntax(
      identifier: ident, declNameArguments: nil, arena: self.arena)
  }
}

extension Parser {
  /// Parse a #selector expression.
  ///
  /// Grammar
  /// =======
  ///
  ///     selector-expression → '#selector' '(' expression )
  ///     selector-expression → '#selector' '(' 'getter' ':' expression ')'
  ///     selector-expression → '#selector' '(' 'setter' ':' expression ')'
  @_spi(RawSyntax)
  public mutating func parseObjectiveCSelectorLiteral() -> RawObjcSelectorExprSyntax {
    // Consume '#selector'.
    let selector = self.eat(.poundSelectorKeyword)
    // Parse the leading '('.
    let (unexpectedBeforeLParen, lparen) = self.expect(.leftParen)

    // Parse possible 'getter:' or 'setter:' modifiers, and determine
    // the kind of selector we're working with.
    let kind: RawTokenSyntax?
    let colon: RawTokenSyntax?
    if
      self.peek().tokenKind == .colon,
      self.currentToken.isContextualKeyword("getter") || self.currentToken.isContextualKeyword("setter")
    {
      // Parse the modifier.
      kind = self.consume(remapping: .contextualKeyword)
      colon = self.eat(.colon)
    } else {
      kind = nil
      colon = nil
    }

    // Parse the subexpression.
    let subexpr = self.parseExpression()
    // Parse the closing ')'.
    let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
    return RawObjcSelectorExprSyntax(
      poundSelector: selector,
      unexpectedBeforeLParen,
      leftParen: lparen,
      kind: kind,
      colon: colon,
      name: subexpr,
      unexpectedBeforeRParen,
      rightParen: rparen,
      arena: self.arena)
  }
}

extension Parser {
  /// Parse a closure expression.
  ///
  /// Grammar
  /// =======
  ///
  ///     closure-expression → '{' attributes? closure-signature? statements? '}'
  @_spi(RawSyntax)
  public mutating func parseClosureExpression() -> RawClosureExprSyntax {
    // Parse the opening left brace.
    let lbrace = self.eat(.leftBrace)
    // Parse the closure-signature, if present.
    let signature = self.parseClosureSignatureIfPresent()

    // Parse the body.
    var elements = [RawCodeBlockItemSyntax]()
    do {
      while !self.at(.rightBrace), let newItem = self.parseCodeBlockItem() {
        elements.append(newItem)
      }
    }

    // Parse the closing '}'.
    let (unexpectedBeforeRBrace, rbrace) = self.expect(.rightBrace)
    return RawClosureExprSyntax(
      leftBrace: lbrace,
      signature: signature,
      statements: RawCodeBlockItemListSyntax(elements: elements, arena: arena),
      unexpectedBeforeRBrace,
      rightBrace: rbrace,
      arena: self.arena)
  }
}

extension Parser {
  /// Parse the signature of a closure, if one is present.
  ///
  /// Grammar
  /// =======
  ///
  ///     closure-signature → capture-list? closure-parameter-clause 'async'? 'throws'? function-result? 'in'
  ///     closure-signature → capture-list 'in'
  ///
  ///     closure-parameter-clause → '(' ')' | '(' closure-parameter-list ')' | identifier-list
  ///
  ///     closure-parameter-list → closure-parameter | closure-parameter , closure-parameter-list
  ///     closure-parameter → closure-parameter-name type-annotation?
  ///     closure-parameter → closure-parameter-name type-annotation '...'
  ///     closure-parameter-name → identifier
  ///
  ///     capture-list → '[' capture-list-items ']'
  ///     capture-list-items → capture-list-item | capture-list-item , capture-list-items
  ///     capture-list-item → capture-specifier? identifier
  ///     capture-list-item → capture-specifier? identifier '=' expression
  ///     capture-list-item → capture-specifier? self-expression
  ///
  ///     capture-specifier → 'weak' | 'unowned' | 'unowned(safe)' | 'unowned(unsafe)'
  @_spi(RawSyntax)
  public mutating func parseClosureSignatureIfPresent() -> RawClosureSignatureSyntax? {
    // If we have a leading token that may be part of the closure signature, do a
    // speculative parse to validate it and look for 'in'.
    guard self.at(.atSign) || self.at(.leftParen) || self.at(.leftSquareBracket)
            || self.currentToken.isIdentifier || self.at(.wildcardKeyword) else {
      // No closure signature.
      return nil
    }

    guard self.lookahead().canParseClosureSignature() else {
      return nil
    }

    let attrs = self.parseAttributeList()

    let captures: RawClosureCaptureSignatureSyntax?
    if self.at(.leftSquareBracket) {
      let lsquare = self.eat(.leftSquareBracket)
      // At this point, we know we have a closure signature. Parse the capture list
      // and parameters.
      var elements = [RawClosureCaptureItemSyntax]()
      do {
        var keepGoing: RawTokenSyntax? = nil
        repeat {
          // Parse any specifiers on the capture like `weak` or `unowned`
          let specifier = self.parseClosureCaptureSpecifiers()

          // The thing being capture specified is an identifier, or as an identifier
          // followed by an expression.
          let name: RawTokenSyntax?
          let assignToken: RawTokenSyntax?
          let expression: RawExprSyntax
          if self.peek().tokenKind == .equal {
            // The name is a new declaration.
            name = self.consumeIdentifier()
            assignToken = self.eat(.equal)
            expression = self.parseExpression()
          } else {
            // This is the simple case - the identifier is both the name and
            // the expression to capture.
            name = nil
            assignToken = nil
            expression = RawExprSyntax(self.parseIdentifierExpression())
          }

          keepGoing = self.consume(if: .comma)
          elements.append(RawClosureCaptureItemSyntax(
            specifier: specifier,
            name: name,
            assignToken: assignToken,
            expression: expression,
            trailingComma: keepGoing,
            arena: self.arena))
        } while keepGoing != nil
      }
      let (unexpectedBeforeRSquare, rsquare) = self.expect(.rightSquareBracket)

      captures = RawClosureCaptureSignatureSyntax(
        leftSquare: lsquare,
        items: elements.isEmpty ? nil : RawClosureCaptureItemListSyntax(elements: elements, arena: self.arena),
        unexpectedBeforeRSquare,
        rightSquare: rsquare, arena: self.arena)
    } else {
      captures = nil
    }

    var input: RawSyntax?
    var asyncKeyword: RawTokenSyntax? = nil
    var throwsTok: RawTokenSyntax? = nil
    var output: RawReturnClauseSyntax? = nil
    if !self.at(.inKeyword) {
      if self.at(.leftParen) {
        // Parse the closure arguments.
        input = RawSyntax(self.parseParameterClause(isClosure: true))
      } else {
        var params = [RawClosureParamSyntax]()
        do {
          // Parse identifier (',' identifier)*
          var keepGoing: RawTokenSyntax? = nil
          repeat {
            let name: RawTokenSyntax
            if self.currentToken.isIdentifier {
              name = self.consumeIdentifier()
            } else {
              name = self.eat(.wildcardKeyword)
            }
            keepGoing = consume(if: .comma)
            params.append(RawClosureParamSyntax(
              name: name, trailingComma: keepGoing, arena: self.arena))
          } while keepGoing != nil
        }

        input = RawSyntax(RawClosureParamListSyntax(elements: params, arena: self.arena))
      }

      asyncKeyword = self.parseEffectsSpecifier()
      throwsTok = self.parseEffectsSpecifier()

      // Parse the optional explicit return type.
      if self.at(.arrow) {
        // Consume the '->'.
        let arrow = self.eat(.arrow)

        // Parse the type.
        let returnTy = self.parseType()

        output = RawReturnClauseSyntax(
          arrow: arrow, returnType: returnTy, arena: self.arena)
      }
    }

    // Parse the 'in'.
    let (unexpectedBeforeInTok, inTok) = self.expect(.inKeyword)
    return RawClosureSignatureSyntax(
      attributes: attrs,
      capture: captures,
      input: input,
      asyncKeyword: asyncKeyword,
      throwsTok: throwsTok,
      output: output,
      unexpectedBeforeInTok,
      inTok: inTok,
      arena: self.arena)
  }

  @_spi(RawSyntax)
  public mutating func parseClosureCaptureSpecifiers() -> RawTokenListSyntax? {
    var specifiers = [RawTokenSyntax]()
    do {
      // Check for the strength specifier: "weak", "unowned", or
      // "unowned(safe/unsafe)".
      if self.currentToken.isContextualKeyword("weak") {
        specifiers.append(self.consumeIdentifier())
      } else if self.currentToken.isContextualKeyword("unowned") {
        specifiers.append(self.consumeIdentifier())
        if let lparen = self.consume(if: .leftParen) {
          specifiers.append(lparen)
          specifiers.append(self.expectWithoutLookahead(.identifier, "unsafe"))
          specifiers.append(self.expectWithoutLookahead(.rightParen))
        }
      } else if (self.currentToken.isIdentifier || self.at(.selfKeyword)) {
        let next = self.peek()
        // "x = 42", "x," and "x]" are all strong captures of x.
        guard next.tokenKind == .equal || next.tokenKind == .comma
            || next.tokenKind == .rightSquareBracket || next.tokenKind == .period
        else {
          return nil
        }
      } else {
        return nil
      }

      guard self.currentToken.isIdentifier || self.at(.selfKeyword) else {
        return nil
      }
    }
    // Squash all tokens, if any, as the specifier of the captured item.
    return RawTokenListSyntax(elements: specifiers, arena: self.arena)
  }
}

extension Parser {
  /// Parse the elements of an argument list.
  ///
  /// This is currently the same as parsing a tuple expression. In the future,
  /// this will be a dedicated argument list type.
  ///
  /// Grammar
  /// =======
  ///
  ///     tuple-element → expression | identifier ':' expression
  @_spi(RawSyntax)
  public mutating func parseArgumentListElements() -> [RawTupleExprElementSyntax] {
    guard !self.at(.rightParen) else {
      return []
    }

    var result = [RawTupleExprElementSyntax]()
    var keepGoing: RawTokenSyntax? = nil
    repeat {
      let label: RawTokenSyntax?
      let colon: RawTokenSyntax?
      if self.currentToken.canBeArgumentLabel && self.peek().tokenKind == .colon {
        label = self.consumeAnyToken()
        colon = self.eat(.colon)
      } else {
        label = nil
        colon = nil
      }

      // See if we have an operator decl ref '(<op>)'. The operator token in
      // this case lexes as a binary operator because it neither leads nor
      // follows a proper subexpression.
      let expr: RawExprSyntax
      if self.currentToken.isBinaryOperator
          && (self.peek().tokenKind == .comma || self.peek().tokenKind == .rightParen || self.peek().tokenKind == .rightSquareBracket) {
        let (ident, args) = self.parseDeclNameRef(.operators)
        expr = RawExprSyntax(RawIdentifierExprSyntax(
          identifier: ident, declNameArguments: args, arena: self.arena))
      } else {
        expr = self.parseExpression()
      }
      keepGoing = self.consume(if: .comma)
      result.append(RawTupleExprElementSyntax(
        label: label, colon: colon, expression: expr, trailingComma: keepGoing, arena: self.arena))
    } while keepGoing != nil
    return result
  }

  /// Parse an argument list.
  ///
  /// This is currently the same as parsing a tuple expression. In the future,
  /// this will be a dedicated argument list type.
  ///
  /// Grammar
  /// =======
  ///
  ///     tuple-expression → '(' ')' | '(' tuple-element ',' tuple-element-list ')'
  ///     tuple-element-list → tuple-element | tuple-element ',' tuple-element-list
  @_spi(RawSyntax)
  public mutating func parseArgumentList(_ flavor: ExprFlavor) -> RawTupleExprSyntax {
    let lparen = self.eat(.leftParen)
    let args = self.parseArgumentListElements()
    let (unexpectedBeforeRightParen, rparen) = self.expect(.rightParen)

    // FIXME: Introduce new SyntaxKind for ArgumentList (rdar://81786229)
    return RawTupleExprSyntax(
      leftParen: lparen,
      elementList: RawTupleExprElementListSyntax(elements: args, arena: self.arena),
      unexpectedBeforeRightParen,
      rightParen: rparen,
      arena: self.arena)
  }
}

extension Parser {
  /// Parse the trailing closure(s) following a call expression.
  ///
  /// Grammar
  /// =======
  ///
  ///     trailing-closures → closure-expression labeled-trailing-closures?
  ///     labeled-trailing-closures → labeled-trailing-closure labeled-trailing-closures?
  ///     labeled-trailing-closure → identifier ':' closure-expression
  @_spi(RawSyntax)
  public mutating func parseTrailingClosures(_ flavor: ExprFlavor) -> (RawClosureExprSyntax, RawMultipleTrailingClosureElementListSyntax?) {
    // Parse the closure.
    let closure = self.parseClosureExpression()

    // Parse labeled trailing closures.
    var elements = [RawMultipleTrailingClosureElementSyntax]()
    while self.lookahead().isStartOfLabelledTrailingClosure() {
      let label = self.parseArgumentLabel()
      let (unexpectedBeforeColon, colon) = self.expect(.colon)
      let closure = self.parseClosureExpression()
      elements.append(RawMultipleTrailingClosureElementSyntax(
        label: label,
        unexpectedBeforeColon,
        colon: colon,
        closure: closure,
        arena: self.arena
      ))
    }

    let trailing = elements.isEmpty ? nil : RawMultipleTrailingClosureElementListSyntax(elements: elements, arena: self.arena)
    return (closure, trailing)
  }
}

extension Parser.Lookahead {
  func isStartOfLabelledTrailingClosure() -> Bool {
    // Fast path: the next two tokens must be a label and a colon.
    // But 'default:' is ambiguous with switch cases and we disallow it
    // (unless escaped) even outside of switches.
    if !self.currentToken.canBeArgumentLabel
        || self.at(.defaultKeyword)
        || self.peek().tokenKind != .colon {
      return false
    }

    // Do some tentative parsing to distinguish `label: { ... }` and
    // `label: switch x { ... }`.
    var backtrack = self.lookahead()
    backtrack.consumeAnyToken()
    if backtrack.peek().tokenKind == .leftBrace {
      return true
    }

    return false
  }

  /// Recover invalid uses of trailing closures in a situation
  /// where the parser requires an expr-basic (which does not allow them).  We
  /// handle this by doing some lookahead in common situations. And later, Sema
  /// will emit a diagnostic with a fixit to add wrapping parens.
  func isValidTrailingClosure(_ flavor: Parser.ExprFlavor) -> Bool {
    assert(self.at(.leftBrace), "Couldn't be a trailing closure")

    // If this is the start of a get/set accessor, then it isn't a trailing
    // closure.
    guard !self.lookahead().isStartOfGetSetAccessor() else {
      return false
    }

    // If this is a normal expression (not an expr-basic) then trailing closures
    // are allowed, so this is obviously one.
    // TODO: We could handle try to disambiguate cases like:
    //   let x = foo
    //   {...}()
    // by looking ahead for the ()'s, but this has been replaced by do{}, so this
    // probably isn't worthwhile.
    //
    guard case .basic = flavor else {
      return true
    }

    // If this is an expr-basic, then a trailing closure is not allowed.  However,
    // it is very common for someone to write something like:
    //
    //    for _ in numbers.filter {$0 > 4} {
    //
    // and we want to recover from this very well.   We need to perform arbitrary
    // look-ahead to disambiguate this case, so we only do this in the case where
    // the token after the { is on the same line as the {.
    guard !self.peek().isAtStartOfLine else {
      return false
    }

    // Determine if the {} goes with the expression by eating it, and looking
    // to see if it is immediately followed by a token which indicates we should
    // consider it part of the preceding expression
    var backtrack = self.lookahead()
    backtrack.eat(.leftBrace)
    while !backtrack.at(.eof) && !backtrack.at(.rightBrace) {
      backtrack.consumeAnyToken()
    }

    guard backtrack.consume(if: .rightBrace) != nil else {
      return false
    }

    switch backtrack.currentToken.tokenKind {
    case .leftBrace,
        .whereKeyword,
        .comma:
      return true
    case .leftSquareBracket,
        .leftParen,
        .period,
        .prefixPeriod,
        .isKeyword,
        .asKeyword,
        .postfixQuestionMark,
        .infixQuestionMark,
        .exclamationMark,
        .colon,
        .equal,
        .postfixOperator,
        .spacedBinaryOperator,
        .unspacedBinaryOperator:
      return !backtrack.currentToken.isAtStartOfLine
    default:
      return false
    }
  }
}

// MARK: Lookahead

extension Parser.Lookahead {
  // Consume 'async', 'throws', and 'rethrows', but in any order.
  mutating func consumeEffectsSpecifiers() {
    while self.currentToken.isEffectsSpecifier && !self.currentToken.isAtStartOfLine {
      self.consumeAnyToken()
    }
  }

  func canParseClosureSignature() -> Bool {
    // Consume attributes.
    var lookahead = self.lookahead()
    while lookahead.at(.atSign) {
      lookahead.eat(.atSign)
      guard lookahead.currentToken.isIdentifier else {
        break
      }
      _ = lookahead.canParseCustomAttribute()
    }

    // Skip by a closure capture list if present.
    if lookahead.consume(if: .leftSquareBracket) != nil {
      while !lookahead.at(.eof) && !lookahead.at(.rightSquareBracket) {
        lookahead.consumeAnyToken()
      }

      if lookahead.consume(if: .rightSquareBracket) == nil {
        return false
      }
    }

    // Parse pattern-tuple func-signature-result? 'in'.
    if lookahead.consume(if: .leftParen) != nil {      // Consume the ')'.

      // While we don't have '->' or ')', eat balanced tokens.
      while !lookahead.at(.eof) && !lookahead.at(.rightParen) {
        lookahead.skipSingle()
      }

      // Consume the ')', if it's there.
      if lookahead.consume(if: .rightParen) != nil {
        lookahead.consumeEffectsSpecifiers()

        // Parse the func-signature-result, if present.
        if lookahead.consume(if: .arrow) != nil {
          guard lookahead.canParseType() else {
            return false
          }

          lookahead.consumeEffectsSpecifiers()
        }
      }
      // Okay, we have a closure signature.
    } else if lookahead.currentToken.isIdentifier || lookahead.at(.wildcardKeyword) {
      // Parse identifier (',' identifier)*
      lookahead.consumeAnyToken()
      while lookahead.consume(if: .comma) != nil {
        if lookahead.currentToken.isIdentifier || lookahead.at(.wildcardKeyword) {
          lookahead.consumeAnyToken()
          continue
        }

        return false
      }

      lookahead.consumeEffectsSpecifiers()

      // Parse the func-signature-result, if present.
      if lookahead.consume(if: .arrow) != nil {
        guard lookahead.canParseType() else {
          return false
        }

        lookahead.consumeEffectsSpecifiers()
      }
    }

    // Parse the 'in' at the end.
    guard lookahead.at(.inKeyword) else {
      return false
    }
    // Okay, we have a closure signature.
    return true
  }
}

extension Parser.Lookahead {
  // Helper function to see if we can parse member reference like suffixes
  // inside '#if'.
  fileprivate func isAtStartOfPostfixExprSuffix() -> Bool {
    guard self.at(.period) || self.at(.prefixPeriod) else {
      return false
    }

    if case .integerLiteral = self.currentToken.tokenKind {
      return true
    }

    if !self.peek().isIdentifier,
        self.peek().tokenKind != .capitalSelfKeyword,
        self.peek().tokenKind != .selfKeyword,
       !self.peek().tokenKind.isKeyword {
      return false
    }
    return true
  }
}
