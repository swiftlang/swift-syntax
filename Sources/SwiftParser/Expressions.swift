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

extension TokenConsumer {
  mutating func atStartOfExpression() -> Bool {
    switch self.at(anyIn: ExpressionStart.self) {
    case (.awaitTryMove, let handle)?:
      var lookahead = self.lookahead()
      lookahead.eat(handle)

      // These can be parsed as expressions with try/await.
      if lookahead.at(anyIn: SingleValueStatementExpression.self) != nil {
        return true
      }
      // Note we currently pass `preferExpr: false` to prefer diagnosing `try then`
      // as needing to be `then try`, rather than parsing `then` as an expression.
      if lookahead.atStartOfDeclaration() || lookahead.atStartOfStatement(preferExpr: false) {
        // If after the 'try' we are at a declaration or statement, it can't be a valid expression.
        // Decide how we want to consume the 'try':
        // If the declaration or statement starts at a new line, the user probably just forgot to write the expression after 'try' -> parse it as a TryExpr
        // If the declaration or statement starts at the same line, the user maybe tried to use 'try' as a modifier -> parse it as unexpected text in front of that decl or stmt.
        return lookahead.atStartOfLine
      } else {
        return true
      }
    case (.primaryExpressionStart(.atSign), _)?:
      break
    case (_, _)?:
      return true
    case nil:
      break
    }
    if self.at(.atSign) || self.at(.keyword(.inout)) {
      var lookahead = self.lookahead()
      if lookahead.canParseType() {
        return true
      }
    }

    // 'repeat' is the start of a pack expansion expression.
    if (self.at(.keyword(.repeat))) {
      // FIXME: 'repeat' followed by '{' could still be a pack
      // expansion, but we need to do more lookahead to figure out
      // whether the '{' is the start of a closure expression or a
      // brace statement for 'repeat { ... } while'
      let lookahead = self.lookahead()
      return lookahead.peek().rawTokenKind != .leftBrace
    }

    return false
  }
}

extension Parser {
  enum ExprFlavor {
    /// Parsing a normal expression, eg. inside a function calls.
    case basic

    /// Parsing the condition of a `if`/`guard`/`for`/... statement or something
    /// like the `where` clause after a `catch` clause.
    ///
    /// In these cases we need to disambiguate trailing closures from the
    /// statement's body.
    case stmtCondition

    /// Parsing the condition of a `#if` directive.
    ///
    /// We don't allow allow newlines here.
    case poundIfDirective

    /// Parsing an attribute's arguments, which can contain declaration
    /// references like `subscript` or `deinit`.
    case attributeArguments
  }

  enum PatternContext {
    /// There is no ambient pattern context.
    case none

    /// We're parsing a matching pattern that is not introduced via `let` or `var`.
    ///
    /// In this context, identifiers are references to the enclosing scopes, not a variable binding.
    ///
    /// ```
    /// case x.y <- 'x' must refer to some 'x' defined in another scope, it cannot be e.g. an enum type.
    /// ```
    case matching

    /// We're parsing a matching pattern that is introduced via `let`, `var`, or `inout`
    ///
    /// ```
    /// case let x.y <- 'x' must refer to the base of some member access, y must refer to some pattern-compatible identifier
    /// ```
    case bindingIntroducer

    var admitsBinding: Bool {
      switch self {
      case .bindingIntroducer:
        return true
      case .none, .matching:
        return false
      }
    }
  }

  /// Parse an expression.
  mutating func parseExpression(flavor: ExprFlavor, pattern: PatternContext) -> RawExprSyntax {
    // If we are parsing a refutable pattern, check to see if this is the start
    // of a let/var/is pattern.  If so, parse it as an UnresolvedPatternExpr and
    // let pattern type checking determine its final form.
    //
    // Only do this if we're parsing a pattern, to improve QoI on malformed
    // expressions followed by (e.g.) let/var decls.
    if pattern != .none {
      switch self.at(anyIn: MatchingPatternStart.self) {
      case (spec: .rhs(let bindingIntroducer), handle: _)? where self.withLookahead { $0.shouldParsePatternBinding(introducer: bindingIntroducer) }:
        fallthrough
      case (spec: .lhs(_), handle: _)?:
        let pattern = self.parseMatchingPattern(context: .matching)
        return RawExprSyntax(RawPatternExprSyntax(pattern: pattern, arena: self.arena))

      // If the token can't start a pattern, or contextually isn't parsed as a
      // binding introducer, handle as the start of a normal expression.
      case (spec: .rhs(_), handle: _)?,
        nil:
        // Not a pattern. Break out to parse as a normal expression below.
        break
      }
    }
    return RawExprSyntax(self.parseSequenceExpression(flavor: flavor, pattern: pattern))
  }
}

extension Parser {
  /// Parse a sequence of expressions.
  mutating func parseSequenceExpression(
    flavor: ExprFlavor,
    pattern: PatternContext = .none
  ) -> RawExprSyntax {
    if flavor == .poundIfDirective && self.atStartOfLine {
      return RawExprSyntax(RawMissingExprSyntax(arena: self.arena))
    }

    // Parsed sequence elements except 'lastElement'.
    var elements = [RawExprSyntax]()

    // The last element parsed. we don't eagerly append to 'elements' because we
    // don't want to populate the 'Array' unless the expression is actually
    // sequenced.
    var lastElement: RawExprSyntax

    lastElement = self.parseSequenceExpressionElement(
      flavor: flavor,
      pattern: pattern
    )

    var loopProgress = LoopProgressCondition()
    while self.hasProgressed(&loopProgress) {
      guard
        !lastElement.is(RawMissingExprSyntax.self),
        !(flavor == .poundIfDirective && self.atStartOfLine)
      else {
        break
      }

      // Parse the operator.
      guard
        let (operatorExpr, rhsExpr) =
          self.parseSequenceExpressionOperator(flavor: flavor, pattern: pattern)
      else {
        // Not an operator. We're done.
        break
      }

      elements.append(lastElement)
      elements.append(operatorExpr)

      if let rhsExpr {
        // Operator parsing returned the RHS.
        lastElement = rhsExpr
      } else if flavor == .poundIfDirective && self.atStartOfLine {
        // Don't allow RHS at a newline for `#if` conditions.
        lastElement = RawExprSyntax(RawMissingExprSyntax(arena: self.arena))
        break
      } else {
        lastElement = self.parseSequenceExpressionElement(
          flavor: flavor,
          pattern: pattern
        )
      }
    }

    // There was no operators. Return the only element we parsed.
    if elements.isEmpty {
      return lastElement
    }

    precondition(
      elements.count.isMultiple(of: 2),
      "elements must have an even number of elements"
    )

    elements.append(lastElement)

    return RawExprSyntax(
      RawSequenceExprSyntax(
        elements: RawExprListSyntax(elements: elements, arena: self.arena),
        arena: self.arena
      )
    )
  }

  /// Parse an unresolved 'as' expression.
  mutating func parseUnresolvedAsExpr(
    handle: TokenConsumptionHandle
  ) -> (operator: RawExprSyntax, rhs: RawExprSyntax) {
    let asKeyword = self.eat(handle)
    let failable = self.consume(if: .postfixQuestionMark, .exclamationMark)
    let op = RawUnresolvedAsExprSyntax(
      asKeyword: asKeyword,
      questionOrExclamationMark: failable,
      arena: self.arena
    )

    // Parse the right type expression operand as part of the 'as' production.
    let type = self.parseType()
    let rhs = RawTypeExprSyntax(type: type, arena: self.arena)

    return (RawExprSyntax(op), RawExprSyntax(rhs))
  }

  /// Parse an expression sequence operators.
  ///
  /// Returns `nil` if the current token is not at an operator.
  /// Returns a tuple of an operator expression and an optional right operand
  /// expression. The right operand is only returned if it is not a common
  /// sequence element.
  mutating func parseSequenceExpressionOperator(
    flavor: ExprFlavor,
    pattern: PatternContext
  ) -> (operator: RawExprSyntax, rhs: RawExprSyntax?)? {
    enum ExpectedTokenKind: TokenSpecSet {
      case binaryOperator
      case infixQuestionMark
      case equal
      case `is`
      case `as`
      case async
      case arrow
      case `throws`

      init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
        switch PrepareForKeywordMatch(lexeme) {
        case TokenSpec(.binaryOperator): self = .binaryOperator
        case TokenSpec(.infixQuestionMark): self = .infixQuestionMark
        case TokenSpec(.equal): self = .equal
        case TokenSpec(.is): self = .is
        case TokenSpec(.as): self = .as
        case TokenSpec(.async): self = .async
        case TokenSpec(.arrow): self = .arrow
        case TokenSpec(.throws): self = .throws
        default: return nil
        }
      }

      var spec: TokenSpec {
        switch self {
        case .binaryOperator: return .binaryOperator
        case .infixQuestionMark: return .infixQuestionMark
        case .equal: return .equal
        case .is: return .keyword(.is)
        case .as: return .keyword(.as)
        case .async: return .keyword(.async)
        case .arrow: return .arrow
        case .throws: return .keyword(.throws)
        }
      }
    }

    switch self.at(anyIn: ExpectedTokenKind.self) {
    case (.binaryOperator, let handle)?:
      // Parse the operator.
      let operatorToken = self.eat(handle)
      let op = RawBinaryOperatorExprSyntax(operator: operatorToken, arena: arena)
      return (RawExprSyntax(op), nil)

    case (.infixQuestionMark, let handle)?:
      // Save the '?'.
      let question = self.eat(handle)
      let firstChoice = self.parseSequenceExpression(flavor: flavor, pattern: pattern)
      // Make sure there's a matching ':' after the middle expr.
      let (unexpectedBeforeColon, colon) = self.expect(.colon)

      let op = RawUnresolvedTernaryExprSyntax(
        questionMark: question,
        thenExpression: firstChoice,
        unexpectedBeforeColon,
        colon: colon,
        arena: self.arena
      )

      let rhs: RawExprSyntax?
      if colon.isMissing, self.atStartOfLine {
        rhs = RawExprSyntax(RawMissingExprSyntax(arena: self.arena))
      } else {
        rhs = nil
      }
      return (RawExprSyntax(op), rhs)

    case (.equal, let handle)?:
      switch pattern {
      case .matching, .bindingIntroducer:
        return nil
      case .none:
        let eq = self.eat(handle)
        let op = RawAssignmentExprSyntax(
          equal: eq,
          arena: self.arena
        )
        return (RawExprSyntax(op), nil)
      }

    case (.is, let handle)?:
      let isKeyword = self.eat(handle)
      let op = RawUnresolvedIsExprSyntax(
        isKeyword: isKeyword,
        arena: self.arena
      )

      // Parse the right type expression operand as part of the 'is' production.
      let type = self.parseType()
      let rhs = RawTypeExprSyntax(type: type, arena: self.arena)

      return (RawExprSyntax(op), RawExprSyntax(rhs))

    case (.as, let handle)?:
      return parseUnresolvedAsExpr(handle: handle)

    case (.async, _)?:
      if self.peek(isAt: .arrow, .keyword(.throws)) {
        fallthrough
      } else {
        return nil
      }
    case (.arrow, _)?, (.throws, _)?:
      var effectSpecifiers = self.parseTypeEffectSpecifiers()

      let (unexpectedBeforeArrow, arrow) = self.expect(.arrow)

      let unexpectedAfterArrow = self.parseMisplacedEffectSpecifiers(&effectSpecifiers)

      let op = RawArrowExprSyntax(
        effectSpecifiers: effectSpecifiers,
        unexpectedBeforeArrow,
        arrow: arrow,
        unexpectedAfterArrow,
        arena: self.arena
      )

      return (RawExprSyntax(op), nil)

    case nil:
      // Not an operator.
      return nil
    }
  }

  /// Whether the current token is a valid contextual exprssion modifier like
  /// `copy`, `consume`.
  ///
  /// `copy` etc. are only contextually a keyword if they are followed by an
  /// identifier or keyword on the same line. We do this to ensure that we do
  /// not break any copy functions defined by users.
  private mutating func atContextualExpressionModifier() -> Bool {
    return self.peek(
      isAt: TokenSpec(.identifier, allowAtStartOfLine: false),
      TokenSpec(.dollarIdentifier, allowAtStartOfLine: false),
      TokenSpec(.self, allowAtStartOfLine: false)
    )
  }

  /// Parse an expression sequence element.
  mutating func parseSequenceExpressionElement(
    flavor: ExprFlavor,
    pattern: PatternContext = .none
  ) -> RawExprSyntax {
    // Try to parse '@' sign or 'inout' as an attributed typerepr.
    if self.at(.atSign, .keyword(.inout)) {
      var lookahead = self.lookahead()
      if lookahead.canParseType() {
        let type = self.parseType()
        return RawExprSyntax(
          RawTypeExprSyntax(
            type: type,
            arena: self.arena
          )
        )
      }
    }

    EXPR_PREFIX: switch self.at(anyIn: ExpressionModifierKeyword.self) {
    case (.await, let handle)?:
      let awaitTok = self.eat(handle)
      let sub = self.parseSequenceExpressionElement(
        flavor: flavor,
        pattern: pattern
      )
      return RawExprSyntax(
        RawAwaitExprSyntax(
          awaitKeyword: awaitTok,
          expression: sub,
          arena: self.arena
        )
      )
    case (.try, let handle)?:
      let tryKeyword = self.eat(handle)
      let mark = self.consume(if: .exclamationMark, .postfixQuestionMark)

      let expression = self.parseSequenceExpressionElement(
        flavor: flavor,
        pattern: pattern
      )
      return RawExprSyntax(
        RawTryExprSyntax(
          tryKeyword: tryKeyword,
          questionOrExclamationMark: mark,
          expression: expression,
          arena: self.arena
        )
      )
    case (._move, let handle)?:
      let moveKeyword = self.eat(handle)
      let sub = self.parseSequenceExpressionElement(
        flavor: flavor,
        pattern: pattern
      )
      return RawExprSyntax(
        RawConsumeExprSyntax(
          consumeKeyword: moveKeyword,
          expression: sub,
          arena: self.arena
        )
      )
    case (._borrow, let handle)?:
      let borrowTok = self.eat(handle)
      let sub = self.parseSequenceExpressionElement(
        flavor: flavor,
        pattern: pattern
      )
      return RawExprSyntax(
        RawBorrowExprSyntax(
          borrowKeyword: borrowTok,
          expression: sub,
          arena: self.arena
        )
      )

    case (.copy, let handle)?:
      if !atContextualExpressionModifier() {
        break EXPR_PREFIX
      }

      let copyTok = self.eat(handle)
      let sub = self.parseSequenceExpressionElement(
        flavor: flavor,
        pattern: pattern
      )
      return RawExprSyntax(
        RawCopyExprSyntax(
          copyKeyword: copyTok,
          expression: sub,
          arena: self.arena
        )
      )

    case (.consume, let handle)?:
      if !atContextualExpressionModifier() {
        break EXPR_PREFIX
      }

      let consumeKeyword = self.eat(handle)
      let sub = self.parseSequenceExpressionElement(
        flavor: flavor,
        pattern: pattern
      )
      return RawExprSyntax(
        RawConsumeExprSyntax(
          consumeKeyword: consumeKeyword,
          expression: sub,
          arena: self.arena
        )
      )

    case (.repeat, let handle)?:
      // 'repeat' is the start of a pack expansion expression.
      return RawExprSyntax(parsePackExpansionExpr(repeatHandle: handle, flavor: flavor, pattern: pattern))

    case (.each, let handle)?:
      if !atContextualExpressionModifier() {
        break EXPR_PREFIX
      }

      let each = self.eat(handle)
      let pack = self.parseSequenceExpressionElement(flavor: flavor, pattern: pattern)
      return RawExprSyntax(
        RawPackElementExprSyntax(
          eachKeyword: each,
          pack: pack,
          arena: self.arena
        )
      )

    case (.any, _)?:
      if !atContextualExpressionModifier() {
        break EXPR_PREFIX
      }

      // 'any' is parsed as a part of 'type'.
      let type = self.parseType()
      return RawExprSyntax(RawTypeExprSyntax(type: type, arena: self.arena))

    case nil:
      break
    }
    return self.parseUnaryExpression(flavor: flavor, pattern: pattern)
  }

  /// Parse an optional prefix operator followed by an expression.
  mutating func parseUnaryExpression(
    flavor: ExprFlavor,
    pattern: PatternContext = .none
  ) -> RawExprSyntax {
    // Try parse a single value statement as an expression (e.g do/if/switch).
    // Note we do this here in parseUnaryExpression as we don't allow postfix
    // syntax to hang off such expressions to avoid ambiguities such as postfix
    // '.member', which can currently be parsed as a static dot member for a
    // result builder.
    switch self.at(anyIn: SingleValueStatementExpression.self) {
    case (.do, let handle)?:
      return RawExprSyntax(self.parseDoExpression(doHandle: .noRecovery(handle)))
    case (.if, let handle)?:
      return RawExprSyntax(self.parseIfExpression(ifHandle: .noRecovery(handle)))
    case (.switch, let handle)?:
      return RawExprSyntax(self.parseSwitchExpression(switchHandle: .noRecovery(handle)))
    default:
      break
    }

    switch self.at(anyIn: ExpressionPrefixOperator.self) {
    case (.prefixAmpersand, let handle)?:
      let amp = self.eat(handle)
      let expr = self.parseUnaryExpression(flavor: flavor, pattern: pattern)
      return RawExprSyntax(
        RawInOutExprSyntax(
          ampersand: amp,
          expression: RawExprSyntax(expr),
          arena: self.arena
        )
      )

    case (.backslash, _)?:
      return RawExprSyntax(self.parseKeyPathExpression(pattern: pattern))

    case (.prefixOperator, let handle)?:
      let op = self.eat(handle)
      let postfix = self.parseUnaryExpression(flavor: flavor, pattern: pattern)
      return RawExprSyntax(
        RawPrefixOperatorExprSyntax(
          operator: op,
          expression: postfix,
          arena: self.arena
        )
      )

    default:
      // If the next token is not an operator, just parse this as expr-postfix.
      return self.parsePostfixExpression(
        flavor: flavor,
        pattern: pattern
      )
    }
  }

  /// Parse a postfix expression applied to another expression.
  mutating func parsePostfixExpression(
    flavor: ExprFlavor,
    pattern: PatternContext
  ) -> RawExprSyntax {
    let head = self.parsePrimaryExpression(pattern: pattern, flavor: flavor)
    guard !head.is(RawMissingExprSyntax.self) else {
      return head
    }
    return self.parsePostfixExpressionSuffix(
      head,
      flavor: flavor,
      pattern: pattern
    )
  }

  mutating func parseDottedExpressionSuffix(previousNode: (some RawSyntaxNodeProtocol)?) -> (
    unexpectedPeriod: RawUnexpectedNodesSyntax?,
    period: RawTokenSyntax,
    declName: RawDeclReferenceExprSyntax,
    generics: RawGenericArgumentClauseSyntax?
  ) {
    precondition(self.at(.period))
    let (unexpectedPeriod, period, skipMemberName) = self.consumeMemberPeriod(previousNode: previousNode)
    if skipMemberName {
      let missingIdentifier = missingToken(.identifier)
      let declName = RawDeclReferenceExprSyntax(
        baseName: missingIdentifier,
        argumentNames: nil,
        arena: self.arena
      )
      return (unexpectedPeriod, period, declName, nil)
    }

    // Parse the name portion.
    let declName: RawDeclReferenceExprSyntax
    if let indexOrSelf = self.consume(if: .integerLiteral, .keyword(.self)) {
      // Handle "x.42" - a tuple index.
      declName = RawDeclReferenceExprSyntax(
        baseName: indexOrSelf,
        argumentNames: nil,
        arena: self.arena
      )
    } else {
      // Handle an arbitrary declaration name.
      declName = self.parseDeclReferenceExpr([.keywords, .compoundNames])
    }

    // Parse the generic arguments, if any.
    let generics: RawGenericArgumentClauseSyntax?
    if self.withLookahead({ $0.canParseAsGenericArgumentList() }) {
      generics = self.parseGenericArguments()
    } else {
      generics = nil
    }

    return (unexpectedPeriod, period, declName, generics)
  }

  mutating func parseDottedExpressionSuffix(_ start: RawExprSyntax?) -> RawExprSyntax {
    let (unexpectedPeriod, period, declName, generics) = parseDottedExpressionSuffix(previousNode: start)

    let memberAccess = RawMemberAccessExprSyntax(
      base: start,
      unexpectedPeriod,
      period: period,
      declName: declName,
      arena: self.arena
    )

    guard let generics = generics else {
      return RawExprSyntax(memberAccess)
    }

    return RawExprSyntax(
      RawGenericSpecializationExprSyntax(
        expression: RawExprSyntax(memberAccess),
        genericArgumentClause: generics,
        arena: self.arena
      )
    )
  }

  mutating func parseIfConfigExpressionSuffix(
    _ start: RawExprSyntax?,
    flavor: ExprFlavor
  ) -> RawExprSyntax {
    precondition(self.at(.poundIf))

    let config = self.parsePoundIfDirective { (parser, isFirstElement) -> RawExprSyntax? in
      if !isFirstElement {
        return nil
      }
      let head: RawExprSyntax
      if parser.at(.period) {
        head = parser.parseDottedExpressionSuffix(nil)
      } else if parser.at(.poundIf) {
        head = parser.parseIfConfigExpressionSuffix(nil, flavor: flavor)
      } else {
        // TODO: diagnose and skip.
        return nil
      }
      let result = parser.parsePostfixExpressionSuffix(
        head,
        flavor: flavor,
        pattern: .none
      )

      // TODO: diagnose and skip the remaining token in the current clause.
      return result
    } syntax: { (parser, elements) -> RawIfConfigClauseSyntax.Elements? in
      switch elements.count {
      case 0: return nil
      case 1: return .postfixExpression(elements.first!)
      default: fatalError("Postfix #if should only have one element")
      }
    }

    return RawExprSyntax(
      RawPostfixIfConfigExprSyntax(
        base: start,
        config: config,
        arena: self.arena
      )
    )
  }

  /// Parse the suffix of a postfix expression.
  mutating func parsePostfixExpressionSuffix(
    _ start: RawExprSyntax,
    flavor: ExprFlavor,
    pattern: PatternContext
  ) -> RawExprSyntax {
    // Handle suffix expressions.
    var leadingExpr = start
    var loopProgress = LoopProgressCondition()
    while self.hasProgressed(&loopProgress) {
      if flavor == .poundIfDirective && self.atStartOfLine {
        return leadingExpr
      }

      // Check for a .foo suffix.
      if self.at(.period) {
        leadingExpr = self.parseDottedExpressionSuffix(leadingExpr)
        continue
      }

      // If there is an expr-call-suffix, parse it and form a call.
      if let lparen = self.consume(if: TokenSpec(.leftParen, allowAtStartOfLine: false)) {
        let args = self.parseArgumentListElements(pattern: pattern, flavor: flavor.callArgumentFlavor)
        let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)

        // If we can parse trailing closures, do so.
        let trailingClosure: RawClosureExprSyntax?
        let additionalTrailingClosures: RawMultipleTrailingClosureElementListSyntax
        if case .basic = flavor, self.at(.leftBrace), self.withLookahead({ $0.atValidTrailingClosure(flavor: flavor) }) {
          (trailingClosure, additionalTrailingClosures) = self.parseTrailingClosures(flavor: flavor)
        } else {
          trailingClosure = nil
          additionalTrailingClosures = self.emptyCollection(RawMultipleTrailingClosureElementListSyntax.self)
        }

        leadingExpr = RawExprSyntax(
          RawFunctionCallExprSyntax(
            calledExpression: leadingExpr,
            leftParen: lparen,
            arguments: RawLabeledExprListSyntax(elements: args, arena: self.arena),
            unexpectedBeforeRParen,
            rightParen: rparen,
            trailingClosure: trailingClosure,
            additionalTrailingClosures: additionalTrailingClosures,
            arena: self.arena
          )
        )
        continue
      }

      // Check for a [expr] suffix.
      // Note that this cannot be the start of a new line.
      if let lsquare = self.consume(if: TokenSpec(.leftSquare, allowAtStartOfLine: false)) {
        let args: [RawLabeledExprSyntax]
        if self.at(.rightSquare) {
          args = []
        } else {
          args = self.parseArgumentListElements(pattern: pattern)
        }
        let (unexpectedBeforeRSquare, rsquare) = self.expect(.rightSquare)

        // If we can parse trailing closures, do so.
        let trailingClosure: RawClosureExprSyntax?
        let additionalTrailingClosures: RawMultipleTrailingClosureElementListSyntax
        if case .basic = flavor, self.at(.leftBrace), self.withLookahead({ $0.atValidTrailingClosure(flavor: flavor) }) {
          (trailingClosure, additionalTrailingClosures) = self.parseTrailingClosures(flavor: flavor)
        } else {
          trailingClosure = nil
          additionalTrailingClosures = self.emptyCollection(RawMultipleTrailingClosureElementListSyntax.self)
        }

        leadingExpr = RawExprSyntax(
          RawSubscriptCallExprSyntax(
            calledExpression: leadingExpr,
            leftSquare: lsquare,
            arguments: RawLabeledExprListSyntax(elements: args, arena: self.arena),
            unexpectedBeforeRSquare,
            rightSquare: rsquare,
            trailingClosure: trailingClosure,
            additionalTrailingClosures: additionalTrailingClosures,
            arena: self.arena
          )
        )
        continue
      }

      // Check for a trailing closure, if allowed.
      if self.at(.leftBrace) && !leadingExpr.raw.kind.isLiteral && self.withLookahead({ $0.atValidTrailingClosure(flavor: flavor) }) {
        // Add dummy blank argument list to the call expression syntax.
        let list = RawLabeledExprListSyntax(elements: [], arena: self.arena)
        let (first, rest) = self.parseTrailingClosures(flavor: flavor)

        leadingExpr = RawExprSyntax(
          RawFunctionCallExprSyntax(
            calledExpression: leadingExpr,
            leftParen: nil,
            arguments: list,
            rightParen: nil,
            trailingClosure: first,
            additionalTrailingClosures: rest,
            arena: self.arena
          )
        )

        // We only allow a single trailing closure on a call.  This could be
        // generalized in the future, but needs further design.
        if self.at(.leftBrace) {
          break
        }
        continue
      }

      // Check for a ? suffix.
      if let question = self.consume(if: .postfixQuestionMark) {
        leadingExpr = RawExprSyntax(
          RawOptionalChainingExprSyntax(
            expression: leadingExpr,
            questionMark: question,
            arena: self.arena
          )
        )
        continue
      }

      // Check for a ! suffix.
      if let exlaim = self.consume(if: .exclamationMark) {
        leadingExpr = RawExprSyntax(
          RawForceUnwrapExprSyntax(
            expression: leadingExpr,
            exclamationMark: exlaim,
            arena: self.arena
          )
        )
        continue
      }

      // Check for a postfix-operator suffix.
      if let op = self.consume(if: .postfixOperator) {
        leadingExpr = RawExprSyntax(
          RawPostfixOperatorExprSyntax(
            expression: leadingExpr,
            operator: op,
            arena: self.arena
          )
        )
        continue
      }

      if self.at(.poundIf) {
        // Check if the first '#if' body starts with '.' <identifier>, and parse
        // it as a "postfix ifconfig expression".
        do {
          var lookahead = self.lookahead()
          // Skip to the first body. We may need to skip multiple '#if' directives
          // since we support nested '#if's. e.g.
          //   baseExpr
          //   #if CONDITION_1
          //     #if CONDITION_2
          //       .someMember
          var loopProgress = LoopProgressCondition()
          repeat {
            lookahead.eat(.poundIf)
            while !lookahead.at(.endOfFile) && !lookahead.currentToken.isAtStartOfLine {
              lookahead.skipSingle()
            }
          } while lookahead.at(.poundIf) && lookahead.hasProgressed(&loopProgress)

          guard lookahead.atStartOfPostfixExprSuffix() else {
            break
          }
        }

        leadingExpr = self.parseIfConfigExpressionSuffix(
          leadingExpr,
          flavor: flavor
        )
        continue
      }

      // Otherwise, we don't know what this token is, it must end the expression.
      break
    }
    return leadingExpr
  }
}

extension Parser {
  /// Determine if this is a key path postfix operator like ".?!?".
  private func getNumOptionalKeyPathPostfixComponents(
    _ tokenText: SyntaxText
  ) -> Int? {
    // Make sure every character is ".", "!", or "?", without two "."s in a row.
    var numComponents = 0
    var lastWasDot = false
    for byte in tokenText {
      if byte == UInt8(ascii: ".") {
        if lastWasDot {
          return nil
        }

        lastWasDot = true
        continue
      }

      if byte == UInt8(ascii: "!") || byte == UInt8(ascii: "?") {
        lastWasDot = false
        numComponents += 1
        continue
      }

      return nil
    }

    return numComponents
  }

  /// Consume the optional key path postfix ino a set of key path components.
  private mutating func consumeOptionalKeyPathPostfix(
    numComponents: Int
  ) -> [RawKeyPathComponentSyntax] {
    var components: [RawKeyPathComponentSyntax] = []

    for _ in 0..<numComponents {
      // Consume a period, if there is one.
      let period = self.consume(ifPrefix: ".", as: .period)

      // Consume the '!' or '?'.
      let questionOrExclaim =
        self.consume(ifPrefix: "!", as: .exclamationMark)
        ?? self.expectWithoutRecovery(prefix: "?", as: .postfixQuestionMark)

      components.append(
        RawKeyPathComponentSyntax(
          period: period,
          component: .optional(
            RawKeyPathOptionalComponentSyntax(
              questionOrExclamationMark: questionOrExclaim,
              arena: self.arena
            )
          ),
          arena: self.arena
        )
      )
    }

    return components
  }

  /// Parse a keypath expression.
  mutating func parseKeyPathExpression(pattern: PatternContext) -> RawKeyPathExprSyntax {
    // Consume '\'.
    let (unexpectedBeforeBackslash, backslash) = self.expect(.backslash)

    // For uniformity, \.foo is parsed as if it were MAGIC.foo, so we need to
    // make sure the . is there, but parsing the ? in \.? as .? doesn't make
    // sense. This is all made more complicated by .?. being considered an
    // operator token. Since keypath allows '.!' '.?' and '.[', consume '.'
    // the token is an operator starts with '.', or the following token is '['.
    let rootType: RawTypeSyntax?
    if !self.at(prefix: ".") {
      rootType = self.parseSimpleType(stopAtFirstPeriod: true)
    } else {
      rootType = nil
    }

    var components: [RawKeyPathComponentSyntax] = []
    var loopProgress = LoopProgressCondition()
    while self.hasProgressed(&loopProgress) {
      // Check for a [] or .[] suffix. The latter is only permitted when there
      // are no components.
      if self.at(TokenSpec(.leftSquare, allowAtStartOfLine: false))
        || (components.isEmpty && self.at(.period) && self.peek(isAt: .leftSquare))
      {
        // Consume the '.', if it's allowed here.
        let period: RawTokenSyntax?
        if !self.at(.leftSquare) {
          period = self.consumeAnyToken()
        } else {
          period = nil
        }

        precondition(self.at(.leftSquare))
        let lsquare = self.consumeAnyToken()
        let args: [RawLabeledExprSyntax]
        if self.at(.rightSquare) {
          args = []
        } else {
          args = self.parseArgumentListElements(pattern: pattern)
        }
        let (unexpectedBeforeRSquare, rsquare) = self.expect(.rightSquare)

        components.append(
          RawKeyPathComponentSyntax(
            period: period,
            component: .subscript(
              RawKeyPathSubscriptComponentSyntax(
                leftSquare: lsquare,
                arguments: RawLabeledExprListSyntax(
                  elements: args,
                  arena: self.arena
                ),
                unexpectedBeforeRSquare,
                rightSquare: rsquare,
                arena: self.arena
              )
            ),
            arena: self.arena
          )
        )
        continue
      }

      // Check for an operator starting with '.' that contains only
      // periods, '?'s, and '!'s. Expand that into key path components.
      if self.at(.prefixOperator, .binaryOperator, .postfixOperator) || self.at(.postfixQuestionMark, .exclamationMark),
        let numComponents = getNumOptionalKeyPathPostfixComponents(
          self.currentToken.tokenText
        )
      {
        components.append(
          contentsOf: self.consumeOptionalKeyPathPostfix(
            numComponents: numComponents
          )
        )
        continue
      }

      // Check for a .name or .1 suffix.
      if self.at(.period) {
        let (unexpectedPeriod, period, declName, generics) = parseDottedExpressionSuffix(
          previousNode: components.last?.raw ?? rootType?.raw ?? backslash.raw
        )
        components.append(
          RawKeyPathComponentSyntax(
            unexpectedPeriod,
            period: period,
            component: .property(
              RawKeyPathPropertyComponentSyntax(
                declName: declName,
                genericArgumentClause: generics,
                arena: self.arena
              )
            ),
            arena: self.arena
          )
        )
        continue
      }

      // No more postfix expressions.
      break
    }

    return RawKeyPathExprSyntax(
      unexpectedBeforeBackslash,
      backslash: backslash,
      root: rootType,
      components: RawKeyPathComponentListSyntax(
        elements: components,
        arena: self.arena
      ),
      arena: self.arena
    )
  }
}

extension Parser {
  /// Parse a "primary expression" - these are the most basic leaves of the
  /// Swift expression grammar.
  mutating func parsePrimaryExpression(
    pattern: PatternContext,
    flavor: ExprFlavor
  ) -> RawExprSyntax {
    if flavor == .poundIfDirective, let directiveExpr = self.parsePrimaryExprForDirective() {
      return RawExprSyntax(directiveExpr)
    }

    switch self.at(anyIn: PrimaryExpressionStart.self) {
    case (.integerLiteral, let handle)?:
      let literal = self.eat(handle)
      return RawExprSyntax(
        RawIntegerLiteralExprSyntax(
          literal: literal,
          arena: self.arena
        )
      )
    case (.floatLiteral, let handle)?:
      let literal = self.eat(handle)
      return RawExprSyntax(
        RawFloatLiteralExprSyntax(
          literal: literal,
          arena: self.arena
        )
      )
    case (.atSign, _)?:
      return RawExprSyntax(self.parseStringLiteral())
    case (.rawStringDelimiter, _)?, (.stringQuote, _)?, (.multilineStringQuote, _)?, (.singleQuote, _)?:
      return RawExprSyntax(self.parseStringLiteral())
    case (.extendedRegexDelimiter, _)?, (.regexSlash, _)?:
      return RawExprSyntax(self.parseRegexLiteral())
    case (.nil, let handle)?:
      let nilKeyword = self.eat(handle)
      return RawExprSyntax(
        RawNilLiteralExprSyntax(
          nilKeyword: nilKeyword,
          arena: self.arena
        )
      )
    case (.true, let handle)?,
      (.false, let handle)?:
      let literal = self.eat(handle)
      return RawExprSyntax(
        RawBooleanLiteralExprSyntax(
          literal: literal,
          arena: self.arena
        )
      )
    case (.identifier, let handle)?, (.self, let handle)?, (.`init`, let handle)?, (.`deinit`, let handle)?, (.`subscript`, let handle)?:
      // If we have "case let x" followed by ".", "(", "[", or a generic
      // argument list, we parse x as a normal name, not a binding, because it
      // is the start of an enum or expr pattern.
      if pattern.admitsBinding && self.lookahead().isInBindingPatternPosition() {
        let identifier = self.eat(handle)
        let pattern = RawPatternSyntax(
          RawIdentifierPatternSyntax(
            identifier: identifier,
            arena: self.arena
          )
        )
        return RawExprSyntax(RawPatternExprSyntax(pattern: pattern, arena: self.arena))
      }

      return RawExprSyntax(self.parseIdentifierExpression(flavor: flavor))
    case (.Self, _)?:  // Self
      return RawExprSyntax(self.parseIdentifierExpression(flavor: flavor))
    case (.Any, _)?:  // Any
      let anyType = RawTypeSyntax(self.parseAnyType())
      return RawExprSyntax(RawTypeExprSyntax(type: anyType, arena: self.arena))
    case (.dollarIdentifier, _)?:
      return RawExprSyntax(self.parseAnonymousClosureArgument())
    case (.wildcard, let handle)?:  // _
      let wild = self.eat(handle)
      return RawExprSyntax(
        RawDiscardAssignmentExprSyntax(
          wildcard: wild,
          arena: self.arena
        )
      )
    case (.pound, _)?:
      return RawExprSyntax(
        self.parseMacroExpansionExpr(pattern: pattern, flavor: flavor)
      )
    case (.poundAvailable, _)?, (.poundUnavailable, _)?:
      let poundAvailable = self.parsePoundAvailableConditionElement()
      return RawExprSyntax(
        RawDeclReferenceExprSyntax(
          RawUnexpectedNodesSyntax([poundAvailable], arena: self.arena),
          baseName: missingToken(.identifier),
          argumentNames: nil,
          arena: self.arena
        )
      )
    case (.leftBrace, _)?:  // expr-closure
      return RawExprSyntax(self.parseClosureExpression())
    case (.period, let handle)?:  // .foo
      let period = self.eat(handle)

      // Special case ".<integer_literal>" like ".4".  This isn't valid, but the
      // developer almost certainly meant to use "0.4".  Diagnose this, and
      // recover as if they wrote that.
      if let integerLiteral = self.consume(if: .integerLiteral) {
        let text = arena.intern("0" + String(syntaxText: period.tokenText) + String(syntaxText: integerLiteral.tokenText))
        return RawExprSyntax(
          RawFloatLiteralExprSyntax(
            literal: RawTokenSyntax(
              missing: .floatLiteral,
              text: text,
              arena: self.arena
            ),
            RawUnexpectedNodesSyntax(
              elements: [
                RawSyntax(period),
                RawSyntax(integerLiteral),
              ],
              arena: self.arena
            ),
            arena: self.arena
          )
        )
      }

      let declName = self.parseDeclReferenceExpr([.keywords, .compoundNames])
      return RawExprSyntax(
        RawMemberAccessExprSyntax(
          base: nil,
          period: period,
          declName: declName,
          arena: self.arena
        )
      )
    case (.super, _)?:  // 'super'
      return RawExprSyntax(self.parseSuperExpression())

    case (.leftParen, _)?:
      // Build a tuple expression syntax node.
      // AST differentiates paren and tuple expression where the former allows
      // only one element without label. However, libSyntax tree doesn't have this
      // differentiation. A tuple expression node in libSyntax can have a single
      // element without label.
      return RawExprSyntax(self.parseTupleExpression(pattern: pattern))

    case (.leftSquare, _)?:
      return self.parseCollectionLiteral()

    case nil:
      return RawExprSyntax(RawMissingExprSyntax(arena: self.arena))
    }
  }

  // try to parse a primary expression for a directive
  mutating func parsePrimaryExprForDirective() -> RawExprSyntax? {
    switch self.at(anyIn: CompilationCondition.self) {
    case (.canImport, let handle)?:
      return RawExprSyntax(self.parseCanImportExpression(handle))

    // TODO: add case `swift` and `compiler` here
    default:
      return nil
    }
  }
}

extension Parser {
  /// Parse an identifier as an expression.
  mutating func parseIdentifierExpression(flavor: ExprFlavor) -> RawExprSyntax {
    var options: DeclNameOptions = .compoundNames
    switch flavor {
    case .basic, .poundIfDirective, .stmtCondition: break
    case .attributeArguments: options.insert(.keywordsUsingSpecialNames)
    }

    let declName = self.parseDeclReferenceExpr(options)
    guard self.withLookahead({ $0.canParseAsGenericArgumentList() }) else {
      return RawExprSyntax(declName)
    }

    let generics = self.parseGenericArguments()
    return RawExprSyntax(
      RawGenericSpecializationExprSyntax(
        expression: RawExprSyntax(declName),
        genericArgumentClause: generics,
        arena: self.arena
      )
    )
  }
}

extension Parser {
  /// Parse a macro expansion as an expression.
  mutating func parseMacroExpansionExpr(
    pattern: PatternContext,
    flavor: ExprFlavor
  ) -> RawMacroExpansionExprSyntax {
    var (unexpectedBeforePound, pound) = self.expect(.pound)
    if pound.trailingTriviaByteLength > 0 || currentToken.leadingTriviaByteLength > 0 {
      // If there are whitespaces after '#' diagnose.
      let diagnostic = TokenDiagnostic(
        .extraneousTrailingWhitespaceError,
        byteOffset: pound.leadingTriviaByteLength + pound.tokenText.count
      )
      pound = pound.tokenView.withTokenDiagnostic(tokenDiagnostic: diagnostic, arena: self.arena)
    }
    let unexpectedBeforeMacroName: RawUnexpectedNodesSyntax?
    let macroName: RawTokenSyntax
    if !self.atStartOfLine {
      (unexpectedBeforeMacroName, macroName) = self.expectIdentifier(allowKeywordsAsIdentifier: true)
    } else {
      unexpectedBeforeMacroName = nil
      macroName = self.missingToken(.identifier)
    }

    // Parse the optional generic argument list.
    let generics: RawGenericArgumentClauseSyntax?
    if self.withLookahead({ $0.canParseAsGenericArgumentList() }) {
      generics = self.parseGenericArguments()
    } else {
      generics = nil
    }

    // Parse the optional parenthesized argument list.
    let leftParen = self.consume(if: TokenSpec(.leftParen, allowAtStartOfLine: false))
    let args: [RawLabeledExprSyntax]
    let unexpectedBeforeRightParen: RawUnexpectedNodesSyntax?
    let rightParen: RawTokenSyntax?
    if leftParen != nil {
      args = parseArgumentListElements(pattern: pattern)
      (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
    } else {
      args = []
      unexpectedBeforeRightParen = nil
      rightParen = nil
    }

    // Parse the optional trailing closures.
    let trailingClosure: RawClosureExprSyntax?
    let additionalTrailingClosures: RawMultipleTrailingClosureElementListSyntax
    if case .basic = flavor, self.at(.leftBrace), self.withLookahead({ $0.atValidTrailingClosure(flavor: flavor) }) {
      (trailingClosure, additionalTrailingClosures) = self.parseTrailingClosures(flavor: flavor)
    } else {
      trailingClosure = nil
      additionalTrailingClosures = self.emptyCollection(RawMultipleTrailingClosureElementListSyntax.self)
    }

    return RawMacroExpansionExprSyntax(
      unexpectedBeforePound,
      pound: pound,
      unexpectedBeforeMacroName,
      macroName: macroName,
      genericArgumentClause: generics,
      leftParen: leftParen,
      arguments: RawLabeledExprListSyntax(
        elements: args,
        arena: self.arena
      ),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      trailingClosure: trailingClosure,
      additionalTrailingClosures: additionalTrailingClosures,
      arena: self.arena
    )
  }
}

extension Parser {
  /// Parse a pack expansion as an expression.
  mutating func parsePackExpansionExpr(
    repeatHandle: TokenConsumptionHandle,
    flavor: ExprFlavor,
    pattern: PatternContext
  ) -> RawPackExpansionExprSyntax {
    let repeatKeyword = self.eat(repeatHandle)
    let repetitionPattern = self.parseExpression(flavor: flavor, pattern: pattern)

    return RawPackExpansionExprSyntax(
      repeatKeyword: repeatKeyword,
      repetitionPattern: repetitionPattern,
      arena: self.arena
    )
  }
}

extension Parser {
  /// Parse a regular expression literal.
  ///
  /// The broad structure of the regular expression is validated by the lexer.
  mutating func parseRegexLiteral() -> RawRegexLiteralExprSyntax {
    // See if we have an opening set of pounds.
    let openingPounds = self.consume(if: .regexPoundDelimiter)

    // Parse the opening slash.
    let (unexpectedBeforeSlash, openingSlash) = self.expect(.regexSlash)

    // If we had opening pounds, there should be no trivia for the slash.
    if let openingPounds {
      precondition(openingPounds.trailingTriviaByteLength == 0 && openingSlash.leadingTriviaByteLength == 0)
    }

    // Parse the pattern and closing slash, avoiding recovery or leading trivia
    // as the lexer should provide the tokens exactly in order without trivia,
    // otherwise they should be treated as missing.
    let regex = self.expectWithoutRecoveryOrLeadingTrivia(.regexLiteralPattern)
    let closingSlash = self.expectWithoutRecoveryOrLeadingTrivia(.regexSlash)

    // Finally, parse a closing set of pounds.
    let (unexpectedBeforeClosePounds, closingPounds) = parsePoundDelimiter(.regexPoundDelimiter, matching: openingPounds)

    return RawRegexLiteralExprSyntax(
      openingPounds: openingPounds,
      unexpectedBeforeSlash,
      openingSlash: openingSlash,
      regex: regex,
      closingSlash: closingSlash,
      unexpectedBeforeClosePounds,
      closingPounds: closingPounds,
      arena: self.arena
    )
  }
}

extension Parser {
  /// Parse a 'super' reference to the superclass instance of a class.
  mutating func parseSuperExpression() -> RawSuperExprSyntax {
    // Parse the 'super' reference.
    let (unexpectedBeforeSuperKeyword, superKeyword) = self.expect(.keyword(.super))
    return RawSuperExprSyntax(
      unexpectedBeforeSuperKeyword,
      superKeyword: superKeyword,
      arena: self.arena
    )
  }
}

extension Parser {
  /// Parse a tuple expression.
  mutating func parseTupleExpression(pattern: PatternContext) -> RawTupleExprSyntax {
    let (unexpectedBeforeLParen, lparen) = self.expect(.leftParen)
    let elements = self.parseArgumentListElements(pattern: pattern)
    let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
    return RawTupleExprSyntax(
      unexpectedBeforeLParen,
      leftParen: lparen,
      elements: RawLabeledExprListSyntax(elements: elements, arena: self.arena),
      unexpectedBeforeRParen,
      rightParen: rparen,
      arena: self.arena
    )
  }
}

extension Parser {
  enum CollectionKind {
    case dictionary(key: RawExprSyntax, unexpectedBeforeColon: RawUnexpectedNodesSyntax?, colon: RawTokenSyntax, value: RawExprSyntax)
    case array(RawExprSyntax)
  }

  /// Parse an element of an array or dictionary literal.
  mutating func parseCollectionElement(_ existing: CollectionKind?) -> CollectionKind {
    let key = self.parseExpression(flavor: .basic, pattern: .none)
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
      let value = self.parseExpression(flavor: .basic, pattern: .none)
      return .dictionary(key: key, unexpectedBeforeColon: unexpectedBeforeColon, colon: colon, value: value)
    }
  }

  /// Parse an array or dictionary literal.
  mutating func parseCollectionLiteral() -> RawExprSyntax {
    if let remainingTokens = remainingTokensIfMaximumNestingLevelReached() {
      return RawExprSyntax(
        RawArrayExprSyntax(
          remainingTokens,
          leftSquare: missingToken(.leftSquare),
          elements: RawArrayElementListSyntax(elements: [], arena: self.arena),
          rightSquare: missingToken(.rightSquare),
          arena: self.arena
        )
      )
    }

    let (unexpectedBeforeLSquare, lsquare) = self.expect(.leftSquare)

    if let rsquare = self.consume(if: .rightSquare) {
      return RawExprSyntax(
        RawArrayExprSyntax(
          unexpectedBeforeLSquare,
          leftSquare: lsquare,
          elements: RawArrayElementListSyntax(elements: [], arena: self.arena),
          rightSquare: rsquare,
          arena: self.arena
        )
      )
    }

    if let (colon, rsquare) = self.consume(if: .colon, followedBy: .rightSquare) {
      return RawExprSyntax(
        RawDictionaryExprSyntax(
          unexpectedBeforeLSquare,
          leftSquare: lsquare,
          content: .colon(colon),
          rightSquare: rsquare,
          arena: self.arena
        )
      )
    }

    var elementKind: CollectionKind? = nil
    var elements = [RawSyntax]()
    do {
      var collectionProgress = LoopProgressCondition()
      var keepGoing: RawTokenSyntax?
      COLLECTION_LOOP: repeat {
        elementKind = self.parseCollectionElement(elementKind)

        /// Whether expression of an array element or the value of a dictionary
        /// element is missing. If this is the case, we shouldn't recover from
        /// a missing comma since most likely the closing `]` is missing.
        var elementIsMissingExpression: Bool {
          switch elementKind! {
          case .dictionary(_, _, _, let value):
            return value.is(RawMissingExprSyntax.self)
          case .array(let rawExprSyntax):
            return rawExprSyntax.is(RawMissingExprSyntax.self)
          }
        }

        // Parse the ',' if exists.
        if let token = self.consume(if: .comma) {
          keepGoing = token
        } else if !self.at(.rightSquare, .endOfFile) && !self.atStartOfLine && !elementIsMissingExpression && !self.atStartOfDeclaration()
          && !self.atStartOfStatement(preferExpr: false)
        {
          keepGoing = missingToken(.comma)
        } else {
          keepGoing = nil
        }

        switch elementKind! {
        case .array(let el):
          let element = RawArrayElementSyntax(
            expression: el,
            trailingComma: keepGoing,
            arena: self.arena
          )
          if element.isEmpty {
            break COLLECTION_LOOP
          } else {
            elements.append(RawSyntax(element))
          }
        case .dictionary(let key, let unexpectedBeforeColon, let colon, let value):
          let element = RawDictionaryElementSyntax(
            key: key,
            unexpectedBeforeColon,
            colon: colon,
            value: value,
            trailingComma: keepGoing,
            arena: self.arena
          )
          if element.isEmpty {
            break COLLECTION_LOOP
          } else {
            elements.append(RawSyntax(element))
          }
        }
      } while keepGoing != nil && self.hasProgressed(&collectionProgress)
    }

    let (unexpectedBeforeRSquare, rsquare) = self.expect(.rightSquare)
    switch elementKind! {
    case .dictionary:
      return RawExprSyntax(
        RawDictionaryExprSyntax(
          leftSquare: lsquare,
          content: .elements(
            RawDictionaryElementListSyntax(
              elements: elements.map {
                $0.as(RawDictionaryElementSyntax.self)!
              },
              arena: self.arena
            )
          ),
          unexpectedBeforeRSquare,
          rightSquare: rsquare,
          arena: self.arena
        )
      )
    case .array:
      return RawExprSyntax(
        RawArrayExprSyntax(
          leftSquare: lsquare,
          elements: RawArrayElementListSyntax(
            elements: elements.map {
              $0.as(RawArrayElementSyntax.self)!
            },
            arena: self.arena
          ),
          unexpectedBeforeRSquare,
          rightSquare: rsquare,
          arena: self.arena
        )
      )
    }
  }
}

extension Parser {
  mutating func parseDefaultArgument() -> RawInitializerClauseSyntax {
    let unexpectedBeforeEq: RawUnexpectedNodesSyntax?
    let eq: RawTokenSyntax
    if let comparison = self.consumeIfContextualPunctuator("==") {
      unexpectedBeforeEq = RawUnexpectedNodesSyntax(
        elements: [RawSyntax(comparison)],
        arena: self.arena
      )
      eq = missingToken(.equal)
    } else {
      (unexpectedBeforeEq, eq) = self.expect(.equal)
    }

    let expr = self.parseExpression(flavor: .basic, pattern: .none)
    return RawInitializerClauseSyntax(
      unexpectedBeforeEq,
      equal: eq,
      value: expr,
      arena: self.arena
    )
  }
}

extension Parser {
  mutating func parseAnonymousClosureArgument() -> RawDeclReferenceExprSyntax {
    let (unexpectedBeforeBaseName, baseName) = self.expect(.dollarIdentifier)
    return RawDeclReferenceExprSyntax(
      unexpectedBeforeBaseName,
      baseName: baseName,
      argumentNames: nil,
      arena: self.arena
    )
  }
}

extension Parser {
  /// Parse a closure expression.
  mutating func parseClosureExpression() -> RawClosureExprSyntax {
    // Parse the opening left brace.
    let (unexpectedBeforeLBrace, lbrace) = self.expect(.leftBrace)
    // Parse the closure-signature, if present.
    let signature = self.parseClosureSignatureIfPresent()

    // Parse the body.
    let elements = parseCodeBlockItemList(until: { $0.at(.rightBrace) })

    // Parse the closing '}'.
    let (unexpectedBeforeRBrace, rbrace) = self.expect(.rightBrace)
    return RawClosureExprSyntax(
      unexpectedBeforeLBrace,
      leftBrace: lbrace,
      signature: signature,
      statements: elements,
      unexpectedBeforeRBrace,
      rightBrace: rbrace,
      arena: self.arena
    )
  }
}

extension Parser {
  /// Parse the signature of a closure, if one is present.
  mutating func parseClosureSignatureIfPresent() -> RawClosureSignatureSyntax? {
    // If we have a leading token that may be part of the closure signature, do a
    // speculative parse to validate it and look for 'in'.
    guard self.at(.atSign, .leftParen, .leftSquare) || self.at(.wildcard, .identifier) else {
      // No closure signature.
      return nil
    }

    guard self.withLookahead({ $0.canParseClosureSignature() }) else {
      return nil
    }

    let attrs = self.parseAttributeList()

    let captures: RawClosureCaptureClauseSyntax?
    if let lsquare = self.consume(if: .leftSquare) {
      // At this point, we know we have a closure signature. Parse the capture list
      // and parameters.
      var elements = [RawClosureCaptureSyntax]()
      if !self.at(.rightSquare) {
        var keepGoing: RawTokenSyntax? = nil
        var loopProgress = LoopProgressCondition()
        repeat {
          // Parse any specifiers on the capture like `weak` or `unowned`
          let specifier = self.parseClosureCaptureSpecifiers()

          // The thing being capture specified is an identifier, or as an identifier
          // followed by an expression.
          let unexpectedBeforeName: RawUnexpectedNodesSyntax?
          let name: RawTokenSyntax?
          let unexpectedBeforeEqual: RawUnexpectedNodesSyntax?
          let equal: RawTokenSyntax?
          let expression: RawExprSyntax
          if self.peek(isAt: .equal) {
            // The name is a new declaration.
            (unexpectedBeforeName, name) = self.expect(.identifier, TokenSpec(.self, remapping: .identifier), default: .identifier)
            (unexpectedBeforeEqual, equal) = self.expect(.equal)
            expression = self.parseExpression(flavor: .basic, pattern: .none)
          } else {
            // This is the simple case - the identifier is both the name and
            // the expression to capture.
            unexpectedBeforeName = nil
            name = nil
            unexpectedBeforeEqual = nil
            equal = nil
            expression = RawExprSyntax(self.parseIdentifierExpression(flavor: .basic))
          }

          keepGoing = self.consume(if: .comma)
          elements.append(
            RawClosureCaptureSyntax(
              specifier: specifier,
              unexpectedBeforeName,
              name: name,
              unexpectedBeforeEqual,
              equal: equal,
              expression: expression,
              trailingComma: keepGoing,
              arena: self.arena
            )
          )
        } while keepGoing != nil && self.hasProgressed(&loopProgress)
      }
      // We were promised a right square bracket, so we're going to get it.
      var unexpectedNodes = [RawSyntax]()
      while !self.at(.endOfFile) && !self.at(.rightSquare) && !self.at(.keyword(.in)) {
        unexpectedNodes.append(RawSyntax(self.consumeAnyToken()))
      }
      let (unexpectedBeforeRSquare, rsquare) = self.expect(.rightSquare)
      unexpectedNodes.append(contentsOf: unexpectedBeforeRSquare?.elements ?? [])

      captures = RawClosureCaptureClauseSyntax(
        leftSquare: lsquare,
        items: RawClosureCaptureListSyntax(elements: elements, arena: self.arena),
        RawUnexpectedNodesSyntax(unexpectedNodes, arena: self.arena),
        rightSquare: rsquare,
        arena: self.arena
      )
    } else {
      captures = nil
    }

    var parameterClause: RawClosureSignatureSyntax.ParameterClause?
    var effectSpecifiers: RawTypeEffectSpecifiersSyntax?
    var returnClause: RawReturnClauseSyntax? = nil
    if !self.at(.keyword(.in)) {
      // If the next token is ':', then it looks like the code contained a non-shorthand closure parameter with a type annotation.
      // These need to be wrapped in parentheses.
      if self.at(.leftParen) || self.peek(isAt: .colon) {
        // Parse the closure arguments.
        let params = self.parseParameterClause(RawClosureParameterClauseSyntax.self) { parser in
          parser.parseClosureParameter()
        }
        parameterClause = .parameterClause(params)
      } else {
        var params = [RawClosureShorthandParameterSyntax]()
        var loopProgress = LoopProgressCondition()
        do {
          // Parse identifier (',' identifier)*
          var keepGoing: RawTokenSyntax? = nil
          repeat {
            let unexpected: RawUnexpectedNodesSyntax?
            let name: RawTokenSyntax
            if let identifier = self.consume(if: .identifier) {
              unexpected = nil
              name = identifier
            } else {
              (unexpected, name) = self.expect(.wildcard)
            }
            keepGoing = consume(if: .comma)
            params.append(
              RawClosureShorthandParameterSyntax(
                unexpected,
                name: name,
                trailingComma: keepGoing,
                arena: self.arena
              )
            )
          } while keepGoing != nil && self.hasProgressed(&loopProgress)
        }

        parameterClause = .simpleInput(RawClosureShorthandParameterListSyntax(elements: params, arena: self.arena))
      }

      effectSpecifiers = self.parseTypeEffectSpecifiers()

      if self.at(.arrow) {
        returnClause = self.parseFunctionReturnClause(effectSpecifiers: &effectSpecifiers, allowNamedOpaqueResultType: false)
      }
    }

    // Parse the 'in'.
    let (unexpectedBeforeInKeyword, inKeyword) = self.expect(.keyword(.in))
    return RawClosureSignatureSyntax(
      attributes: attrs,
      capture: captures,
      parameterClause: parameterClause,
      effectSpecifiers: effectSpecifiers,
      returnClause: returnClause,
      unexpectedBeforeInKeyword,
      inKeyword: inKeyword,
      arena: self.arena
    )
  }

  mutating func parseClosureCaptureSpecifiers() -> RawClosureCaptureSpecifierSyntax? {
    // Check for the strength specifier: "weak", "unowned", or
    // "unowned(safe/unsafe)".
    if let weakContextualKeyword = self.consume(if: .keyword(.weak)) {
      return RawClosureCaptureSpecifierSyntax(
        specifier: weakContextualKeyword,
        leftParen: nil,
        detail: nil,
        rightParen: nil,
        arena: self.arena
      )
    } else if let unownedContextualKeyword = self.consume(if: .keyword(.unowned)) {
      if let lparen = self.consume(if: .leftParen) {
        let (unexpectedBeforeDetail, detail) = self.expect(.keyword(.safe), .keyword(.unsafe), default: .keyword(.safe))
        let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
        return RawClosureCaptureSpecifierSyntax(
          specifier: unownedContextualKeyword,
          leftParen: lparen,
          unexpectedBeforeDetail,
          detail: detail,
          unexpectedBeforeRParen,
          rightParen: rparen,
          arena: self.arena
        )
      } else {
        return RawClosureCaptureSpecifierSyntax(
          specifier: unownedContextualKeyword,
          leftParen: nil,
          detail: nil,
          rightParen: nil,
          arena: self.arena
        )
      }
    } else {
      return nil
    }
  }
}

extension Parser {
  /// Parse the elements of an argument list.
  ///
  /// This is currently the same as parsing a tuple expression. In the future,
  /// this will be a dedicated argument list type.
  mutating func parseArgumentListElements(pattern: PatternContext, flavor: ExprFlavor = .basic) -> [RawLabeledExprSyntax] {
    if let remainingTokens = remainingTokensIfMaximumNestingLevelReached() {
      return [
        RawLabeledExprSyntax(
          remainingTokens,
          label: nil,
          colon: nil,
          expression: RawExprSyntax(RawMissingExprSyntax(arena: self.arena)),
          trailingComma: nil,
          arena: self.arena
        )
      ]
    }

    guard !self.at(.rightParen) else {
      return []
    }

    var result = [RawLabeledExprSyntax]()
    var keepGoing: RawTokenSyntax? = nil
    var loopProgress = LoopProgressCondition()
    repeat {
      let unexpectedBeforeLabel: RawUnexpectedNodesSyntax?
      let label: RawTokenSyntax?
      let colon: RawTokenSyntax?
      if self.atArgumentLabel(allowDollarIdentifier: true) && self.peek(isAt: .colon) {
        (unexpectedBeforeLabel, label) = parseArgumentLabel()
        colon = consumeAnyToken()
      } else if let _colon = self.consume(if: .colon) {
        unexpectedBeforeLabel = nil
        label = RawTokenSyntax(missing: .identifier, arena: self.arena)
        colon = _colon
      } else {
        unexpectedBeforeLabel = nil
        label = nil
        colon = nil
      }

      // See if we have an operator decl ref '(<op>)'. The operator token in
      // this case lexes as a binary operator because it neither leads nor
      // follows a proper subexpression.
      let expr: RawExprSyntax
      if self.at(.binaryOperator) && self.peek(isAt: .comma, .rightParen, .rightSquare) {
        expr = RawExprSyntax(self.parseDeclReferenceExpr(.operators))
      } else {
        expr = self.parseExpression(flavor: flavor, pattern: pattern)
      }
      keepGoing = self.consume(if: .comma)
      result.append(
        RawLabeledExprSyntax(
          unexpectedBeforeLabel,
          label: label,
          colon: colon,
          expression: expr,
          trailingComma: keepGoing,
          arena: self.arena
        )
      )
    } while keepGoing != nil && self.hasProgressed(&loopProgress)
    return result
  }
}

extension Parser {
  /// Parse the trailing closure(s) following a call expression.
  mutating func parseTrailingClosures(flavor: ExprFlavor) -> (RawClosureExprSyntax, RawMultipleTrailingClosureElementListSyntax) {
    // Parse the closure.
    let closure = self.parseClosureExpression()

    // Parse labeled trailing closures.
    var elements = [RawMultipleTrailingClosureElementSyntax]()
    var loopProgress = LoopProgressCondition()
    while self.withLookahead({ $0.atStartOfLabelledTrailingClosure() }) && self.hasProgressed(&loopProgress) {
      let (unexpectedBeforeLabel, label) = self.parseArgumentLabel()
      let (unexpectedBeforeColon, colon) = self.expect(.colon)
      let closure = self.parseClosureExpression()
      elements.append(
        RawMultipleTrailingClosureElementSyntax(
          unexpectedBeforeLabel,
          label: label,
          unexpectedBeforeColon,
          colon: colon,
          closure: closure,
          arena: self.arena
        )
      )
    }

    let trailing =
      elements.isEmpty
      ? self.emptyCollection(RawMultipleTrailingClosureElementListSyntax.self)
      : RawMultipleTrailingClosureElementListSyntax(elements: elements, arena: self.arena)
    return (closure, trailing)
  }
}

extension Parser.Lookahead {
  mutating func atStartOfLabelledTrailingClosure() -> Bool {
    // Fast path: the next two tokens must be a label and a colon.
    // But 'default:' is ambiguous with switch cases and we disallow it
    // (unless escaped) even outside of switches.
    if !self.atArgumentLabel()
      || self.at(.keyword(.default))
      || self.peek().rawTokenKind != .colon
    {
      return false
    }

    // Do some tentative parsing to distinguish `label: { ... }` and
    // `label: switch x { ... }`.
    var lookahead = self.lookahead()
    lookahead.consumeAnyToken()
    if lookahead.peek().rawTokenKind == .leftBrace {
      return true
    }
    if lookahead.peek().isEditorPlaceholder {
      // Editor placeholder can represent entire closures
      return true
    }

    return false
  }

  /// Recover invalid uses of trailing closures in a situation
  /// where the parser requires an expr-basic (which does not allow them).  We
  /// handle this by doing some lookahead in common situations. And later, Sema
  /// will emit a diagnostic with a fixit to add wrapping parens.
  mutating func atValidTrailingClosure(flavor: Parser.ExprFlavor) -> Bool {
    precondition(self.at(.leftBrace), "Couldn't be a trailing closure")

    // If this is the start of a get/set accessor, then it isn't a trailing
    // closure.
    guard !self.withLookahead({ $0.atStartOfGetSetAccessor() }) else {
      return false
    }

    // If this is the start of a switch body, this isn't a trailing closure.
    if TokenSpec(.case) ~= self.peek() {
      return false
    }

    // If this is a normal expression (not an expr-basic) then trailing closures
    // are allowed, so this is obviously one.
    // TODO: We could handle try to disambiguate cases like:
    //   let x = foo
    //   {...}()
    // by looking ahead for the ()'s, but this has been replaced by do{}, so this
    // probably isn't worthwhile.
    guard case .stmtCondition = flavor else {
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
    var lookahead = self.lookahead()
    lookahead.eat(.leftBrace)
    var loopProgress = LoopProgressCondition()
    while !lookahead.at(.endOfFile, .rightBrace)
      && !lookahead.at(.poundEndif, .poundElse, .poundElseif)
      && lookahead.hasProgressed(&loopProgress)
    {
      lookahead.skipSingle()
    }

    guard lookahead.consume(if: .rightBrace) != nil else {
      return false
    }

    switch lookahead.currentToken {
    case TokenSpec(.leftBrace),
      TokenSpec(.where),
      TokenSpec(.comma):
      return true
    case TokenSpec(.leftSquare),
      TokenSpec(.leftParen),
      TokenSpec(.period),
      TokenSpec(.is),
      TokenSpec(.as),
      TokenSpec(.postfixQuestionMark),
      TokenSpec(.infixQuestionMark),
      TokenSpec(.exclamationMark),
      TokenSpec(.colon),
      TokenSpec(.equal),
      TokenSpec(.postfixOperator),
      TokenSpec(.binaryOperator):
      return !lookahead.atStartOfLine
    default:
      return false
    }
  }
}

// MARK: Do-Catch Expressions

extension Parser {
  /// Parse a do expression.
  mutating func parseDoExpression(doHandle: RecoveryConsumptionHandle) -> RawDoExprSyntax {
    precondition(experimentalFeatures.contains(.doExpressions))
    let (unexpectedBeforeDoKeyword, doKeyword) = self.eat(doHandle)
    let body = self.parseCodeBlock(introducer: doKeyword)

    // If the next token is 'catch', this is a 'do'/'catch'.
    var elements = [RawCatchClauseSyntax]()
    var loopProgress = LoopProgressCondition()
    while self.at(.keyword(.catch)) && self.hasProgressed(&loopProgress) {
      // Parse 'catch' clauses
      elements.append(self.parseCatchClause())
    }

    return RawDoExprSyntax(
      unexpectedBeforeDoKeyword,
      doKeyword: doKeyword,
      body: body,
      catchClauses: RawCatchClauseListSyntax(elements: elements, arena: self.arena),
      arena: self.arena
    )
  }
}

// MARK: Conditional Expressions

extension Parser {
  /// Parse an if statement/expression.
  mutating func parseIfExpression(
    ifHandle: RecoveryConsumptionHandle
  ) -> RawIfExprSyntax {
    let (unexpectedBeforeIfKeyword, ifKeyword) = self.eat(ifHandle)

    let conditions: RawConditionElementListSyntax

    if self.at(.leftBrace) {
      conditions = RawConditionElementListSyntax(
        elements: [
          RawConditionElementSyntax(
            condition: .expression(RawExprSyntax(RawMissingExprSyntax(arena: self.arena))),
            trailingComma: nil,
            arena: self.arena
          )
        ],
        arena: self.arena
      )
    } else {
      conditions = self.parseConditionList()
    }

    let body = self.parseCodeBlock(introducer: ifKeyword)

    // The else branch, if any, is outside of the scope of the condition.
    let elseKeyword = self.consume(if: .keyword(.else))
    let elseBody: RawIfExprSyntax.ElseBody?
    if elseKeyword != nil {
      if self.at(.keyword(.if)) {
        elseBody = .ifExpr(
          self.parseIfExpression(ifHandle: .constant(.keyword(.if)))
        )
      } else {
        elseBody = .codeBlock(self.parseCodeBlock(introducer: ifKeyword))
      }
    } else {
      elseBody = nil
    }

    return RawIfExprSyntax(
      unexpectedBeforeIfKeyword,
      ifKeyword: ifKeyword,
      conditions: conditions,
      body: body,
      elseKeyword: elseKeyword,
      elseBody: elseBody,
      arena: self.arena
    )
  }
}

// MARK: Switch Statements/Expressions

extension Parser {
  /// Parse a switch statement/expression.
  mutating func parseSwitchExpression(
    switchHandle: RecoveryConsumptionHandle
  ) -> RawSwitchExprSyntax {
    let (unexpectedBeforeSwitchKeyword, switchKeyword) = self.eat(switchHandle)

    // If there is no expression, like `switch { default: return false }` then left brace would parsed as
    // a ``RawClosureExprSyntax`` in the condition, which is most likely not what the user meant.
    // Create a missing condition instead and use the `{` for the start of the body.
    let subject: RawExprSyntax
    if self.at(.leftBrace) {
      subject = RawExprSyntax(RawMissingExprSyntax(arena: self.arena))
    } else {
      subject = self.parseExpression(flavor: .stmtCondition, pattern: .none)
    }

    let (unexpectedBeforeLBrace, lbrace) = self.expect(.leftBrace)

    let cases = self.parseSwitchCases(allowStandaloneStmtRecovery: !lbrace.isMissing)

    let (unexpectedBeforeRBrace, rbrace) = self.expectRightBrace(leftBrace: lbrace, introducer: switchKeyword)
    return RawSwitchExprSyntax(
      unexpectedBeforeSwitchKeyword,
      switchKeyword: switchKeyword,
      subject: subject,
      unexpectedBeforeLBrace,
      leftBrace: lbrace,
      cases: cases,
      unexpectedBeforeRBrace,
      rightBrace: rbrace,
      arena: self.arena
    )
  }

  /// Parse a list of switch case clauses.
  ///
  /// If `allowStandaloneStmtRecovery` is `true` and we discover a statement that
  /// isn't covered by a case, we assume that the developer forgot to wrote the
  /// `case` and synthesize it. If `allowStandaloneStmtOrDeclRecovery` is `false`,
  /// this recovery is disabled.
  mutating func parseSwitchCases(allowStandaloneStmtRecovery: Bool) -> RawSwitchCaseListSyntax {
    var elements = [RawSwitchCaseListSyntax.Element]()
    var elementsProgress = LoopProgressCondition()
    while !self.at(.endOfFile, .rightBrace) && !self.at(.poundEndif, .poundElseif, .poundElse)
      && self.hasProgressed(&elementsProgress)
    {
      if self.withLookahead({ $0.atStartOfSwitchCase(allowRecovery: false) }) {
        elements.append(.switchCase(self.parseSwitchCase()))
      } else if self.canRecoverTo(.poundIf) != nil {
        // '#if' in 'case' position can enclose zero or more 'case' or 'default'
        // clauses.
        elements.append(
          .ifConfigDecl(
            self.parsePoundIfDirective(
              { (parser, _) in parser.parseSwitchCases(allowStandaloneStmtRecovery: allowStandaloneStmtRecovery) },
              syntax: { parser, cases in
                guard cases.count == 1, let firstCase = cases.first else {
                  precondition(cases.isEmpty)
                  return .switchCases(RawSwitchCaseListSyntax(elements: [], arena: parser.arena))
                }
                return .switchCases(firstCase)
              }
            )
          )
        )
      } else if allowStandaloneStmtRecovery
        && (self.atStartOfExpression() || self.atStartOfStatement(preferExpr: false)
          || self.atStartOfDeclaration())
      {
        // Synthesize a label for the statement or declaration that isn't covered by a case right now.
        let statements = parseSwitchCaseBody()
        if statements.isEmpty {
          break
        }
        elements.append(
          .switchCase(
            RawSwitchCaseSyntax(
              attribute: nil,
              label: .case(
                RawSwitchCaseLabelSyntax(
                  caseKeyword: missingToken(.case),
                  caseItems: RawSwitchCaseItemListSyntax(
                    elements: [
                      RawSwitchCaseItemSyntax(
                        pattern: RawPatternSyntax(
                          RawIdentifierPatternSyntax(
                            identifier: missingToken(.identifier),
                            arena: self.arena
                          )
                        ),
                        whereClause: nil,
                        trailingComma: nil,
                        arena: self.arena
                      )
                    ],
                    arena: self.arena
                  ),
                  colon: missingToken(.colon),
                  arena: self.arena
                )
              ),
              statements: statements,
              arena: self.arena
            )
          )
        )
      } else if self.withLookahead({ $0.atStartOfSwitchCase(allowRecovery: true) }) {
        elements.append(.switchCase(self.parseSwitchCase()))
      } else {
        break
      }
    }
    return RawSwitchCaseListSyntax(elements: elements, arena: self.arena)
  }

  mutating func parseSwitchCaseBody() -> RawCodeBlockItemListSyntax {
    parseCodeBlockItemList(until: {
      $0.at(.rightBrace) || $0.at(.poundEndif, .poundElseif, .poundElse) || $0.withLookahead({ $0.atStartOfConditionalSwitchCases() })
    })
  }

  /// Parse a single switch case clause.
  mutating func parseSwitchCase() -> RawSwitchCaseSyntax {
    var unknownAttr: RawAttributeSyntax?
    if let at = self.consume(if: .atSign) {
      let (unexpectedBeforeIdent, ident) = self.expectIdentifier()

      unknownAttr = RawAttributeSyntax(
        atSign: at,
        unexpectedBeforeIdent,
        attributeName: RawTypeSyntax(RawIdentifierTypeSyntax(name: ident, genericArgumentClause: nil, arena: self.arena)),
        leftParen: nil,
        arguments: nil,
        rightParen: nil,
        arena: self.arena
      )
    } else {
      unknownAttr = nil
    }

    let label: RawSwitchCaseSyntax.Label
    switch self.canRecoverTo(anyIn: SwitchCaseStart.self) {
    case (.case, let handle)?:
      label = .case(self.parseSwitchCaseLabel(handle))
    case (.default, let handle)?:
      label = .default(self.parseSwitchDefaultLabel(handle))
    case nil:
      label = .case(
        RawSwitchCaseLabelSyntax(
          caseKeyword: missingToken(.keyword(.case)),
          caseItems: RawSwitchCaseItemListSyntax(
            elements: [
              RawSwitchCaseItemSyntax(
                pattern: RawPatternSyntax(RawIdentifierPatternSyntax(identifier: missingToken(.identifier), arena: self.arena)),
                whereClause: nil,
                trailingComma: nil,
                arena: self.arena
              )
            ],
            arena: self.arena
          ),
          colon: missingToken(.colon),
          arena: self.arena
        )
      )
    }

    // Parse the body.
    let statements = parseSwitchCaseBody()

    return RawSwitchCaseSyntax(
      attribute: unknownAttr,
      label: label,
      statements: statements,
      arena: self.arena
    )
  }

  /// Parse a switch case with a 'case' label.
  mutating func parseSwitchCaseLabel(
    _ handle: RecoveryConsumptionHandle
  ) -> RawSwitchCaseLabelSyntax {
    let (unexpectedBeforeCaseKeyword, caseKeyword) = self.eat(handle)
    var caseItems = [RawSwitchCaseItemSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      var loopProgress = LoopProgressCondition()
      repeat {
        let (pattern, whereClause) = self.parseGuardedCasePattern()
        keepGoing = self.consume(if: .comma)
        caseItems.append(
          RawSwitchCaseItemSyntax(
            pattern: pattern,
            whereClause: whereClause,
            trailingComma: keepGoing,
            arena: self.arena
          )
        )
      } while keepGoing != nil && self.hasProgressed(&loopProgress)
    }
    let (unexpectedBeforeColon, colon) = self.expect(.colon)
    return RawSwitchCaseLabelSyntax(
      unexpectedBeforeCaseKeyword,
      caseKeyword: caseKeyword,
      caseItems: RawSwitchCaseItemListSyntax(elements: caseItems, arena: self.arena),
      unexpectedBeforeColon,
      colon: colon,
      arena: self.arena
    )
  }

  /// Parse a switch case with a 'default' label.
  mutating func parseSwitchDefaultLabel(
    _ handle: RecoveryConsumptionHandle
  ) -> RawSwitchDefaultLabelSyntax {
    let (unexpectedBeforeDefaultKeyword, defaultKeyword) = self.eat(handle)
    let (unexpectedBeforeColon, colon) = self.expect(.colon)
    return RawSwitchDefaultLabelSyntax(
      unexpectedBeforeDefaultKeyword,
      defaultKeyword: defaultKeyword,
      unexpectedBeforeColon,
      colon: colon,
      arena: self.arena
    )
  }

  /// Parse a pattern-matching clause for a case statement,
  /// including the guard expression.
  mutating func parseGuardedCasePattern() -> (RawPatternSyntax, RawWhereClauseSyntax?) {
    let pattern = self.parseMatchingPattern(context: .matching)

    // Parse the optional 'where' guard, with this particular pattern's bound
    // vars in scope.
    let whereClause: RawWhereClauseSyntax?
    if let whereKeyword = self.consume(if: .keyword(.where)) {
      let condition = self.parseExpression(flavor: .basic, pattern: .none)
      whereClause = RawWhereClauseSyntax(
        whereKeyword: whereKeyword,
        condition: condition,
        arena: self.arena
      )
    } else {
      whereClause = nil
    }
    return (pattern, whereClause)
  }
}

// MARK: Platform Condition
extension Parser {
  mutating func parseCanImportExpression(_ handle: TokenConsumptionHandle) -> RawExprSyntax {
    let canImportKeyword = self.eat(handle)

    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)

    let (unexpectedBeforeImportPath, importPath) = self.expect(.identifier)

    var versionInfo: RawCanImportVersionInfoSyntax?

    if let comma = self.consume(if: .comma) {
      let (unexpectedBeforeLabel, label) = self.expect(anyIn: CanImportVersionInfoSyntax.LabelOptions.self, default: ._version)
      let (unexpectedBeforeColon, colon) = self.expect(.colon)

      let version = self.parseVersionTuple(maxComponentCount: 4)

      versionInfo = RawCanImportVersionInfoSyntax(
        comma: comma,
        unexpectedBeforeLabel,
        label: label,
        unexpectedBeforeColon,
        colon: colon,
        version: version,
        arena: self.arena
      )
    }

    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)

    return RawExprSyntax(
      RawCanImportExprSyntax(
        canImportKeyword: canImportKeyword,
        unexpectedBeforeLeftParen,
        leftParen: leftParen,
        unexpectedBeforeImportPath,
        importPath: importPath,
        versionInfo: versionInfo,
        unexpectedBeforeRightParen,
        rightParen: rightParen,
        arena: self.arena
      )
    )
  }
}

// MARK: Lookahead

extension Parser.Lookahead {
  // Consume 'async', 'throws', and 'rethrows', but in any order.
  mutating func consumeEffectsSpecifiers() {
    var loopProgress = LoopProgressCondition()
    while let (_, handle) = self.at(anyIn: EffectSpecifier.self),
      self.hasProgressed(&loopProgress)
    {
      self.eat(handle)
    }
  }

  mutating func canParseClosureSignature() -> Bool {
    // Consume attributes.
    var lookahead = self.lookahead()
    var attributesProgress = LoopProgressCondition()
    while let _ = lookahead.consume(if: .atSign), lookahead.hasProgressed(&attributesProgress) {
      guard lookahead.at(.identifier) else {
        break
      }
      _ = lookahead.canParseCustomAttribute()
    }

    // Skip by a closure capture list if present.
    if lookahead.consume(if: .leftSquare) != nil {
      lookahead.skipUntil(.rightSquare, .rightSquare)
      if lookahead.consume(if: .rightSquare) == nil {
        return false
      }
    }

    // Parse pattern-tuple func-signature-result? 'in'.
    if lookahead.at(.leftParen) {  // Consume the '('.
      // While we don't have '->' or ')', eat balanced tokens.
      var skipProgress = LoopProgressCondition()
      while !lookahead.at(.endOfFile, .rightBrace, .keyword(.in)) && !lookahead.at(.arrow) && lookahead.hasProgressed(&skipProgress) {
        lookahead.skipSingle()
      }
    } else if lookahead.at(.identifier) || lookahead.at(.wildcard) {
      // Parse identifier (',' identifier)*
      lookahead.consumeAnyToken()

      /// If the next token is a colon, interpret is as a type annotation and consume a type after it.
      /// While type annotations aren’t allowed in shorthand closure parameters, we consume them to improve recovery.
      func consumeOptionalTypeAnnotation() -> Bool {
        if lookahead.consume(if: .colon) != nil {
          return lookahead.canParseType()
        } else {
          return true
        }
      }

      var parametersProgress = LoopProgressCondition()
      while consumeOptionalTypeAnnotation() && lookahead.consume(if: .comma) != nil && lookahead.hasProgressed(&parametersProgress) {
        if lookahead.at(.identifier) || lookahead.at(.wildcard) {
          lookahead.consumeAnyToken()
          continue
        }

        return false
      }
    }

    // Consume the ')', if it's there.
    lookahead.consume(if: .rightParen)

    lookahead.consumeEffectsSpecifiers()

    // Parse the func-signature-result, if present.
    if lookahead.consume(if: .arrow) != nil {
      guard lookahead.canParseType() else {
        return false
      }

      lookahead.consumeEffectsSpecifiers()
    }

    // Parse the 'in' at the end.
    guard lookahead.at(.keyword(.in)) else {
      return false
    }
    // Okay, we have a closure signature.
    return true
  }
}

extension Parser.Lookahead {
  // Helper function to see if we can parse member reference like suffixes
  // inside '#if'.
  fileprivate mutating func atStartOfPostfixExprSuffix() -> Bool {
    guard self.at(.period) else {
      return false
    }

    if self.at(.integerLiteral) {
      return true
    }

    return self.peek().isLexerClassifiedKeyword || TokenSpec(.identifier) ~= self.peek()
  }

  fileprivate func isInBindingPatternPosition() -> Bool {
    // Cannot form a binding pattern if a generic argument list follows, this
    // is something like 'case let E<Int>.foo(x)'.
    if self.peek().isContextualPunctuator("<") {
      var lookahead = self.lookahead()
      lookahead.consumeAnyToken()
      return !lookahead.canParseAsGenericArgumentList()
    }
    switch self.peek().rawTokenKind {
    // A '.' indicates a member access, '(' and '[' indicate a function call or
    // subscript. We can't form a binding pattern as the base of these.
    case .period, .leftParen, .leftSquare:
      return false
    default:
      return true
    }
  }
}

extension SyntaxKind {
  fileprivate var isLiteral: Bool {
    switch self {
    case .arrayExpr, .booleanLiteralExpr, .dictionaryExpr, .floatLiteralExpr, .integerLiteralExpr, .nilLiteralExpr, .regexLiteralExpr, .stringLiteralExpr:
      return true
    default:
      return false
    }
  }
}

private extension Parser.ExprFlavor {
  /// The expression flavor used for the argument of a call that occurs
  /// within a particularly-flavored expression.
  var callArgumentFlavor: Parser.ExprFlavor {
    switch self {
    case .basic, .poundIfDirective, .stmtCondition: return .basic
    case .attributeArguments: return .attributeArguments
    }
  }
}
