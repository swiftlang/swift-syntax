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

@_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) import SwiftSyntax

extension TokenConsumer {
  /// Returns `true` if the current token represents the start of a statement
  /// item.
  ///
  /// - Parameters:
  ///   - allowRecovery: Whether to attempt to perform recovery.
  ///   - preferExpr: If either an expression or statement could be
  ///     parsed and this parameter is `true`, the function returns `false`
  ///     such that an expression can be parsed.
  ///
  /// - Note: This function must be kept in sync with `parseStatement()`.
  /// - Seealso: ``Parser/parseStatement()``
  func atStartOfStatement(allowRecovery: Bool = false, preferExpr: Bool) -> Bool {
    var lookahead = self.lookahead()
    if allowRecovery {
      // Attributes are not allowed on statements. But for recovery, skip over
      // misplaced attributes.
      _ = lookahead.consumeAttributeList()
    }
    return lookahead.atStartOfStatement(allowRecovery: allowRecovery, preferExpr: preferExpr)
  }
}

extension Parser.Lookahead {
  mutating func atStartOfSwitchCaseItem() -> Bool {
    while self.consume(if: .atSign) != nil {
      self.consume(if: .identifier)
    }

    return self.at(anyIn: SwitchCaseStart.self) != nil
  }
}

extension Parser {
  /// Parse a statement.
  ///
  /// This function is meant to be invoked as part of parsing an item. As such
  /// it does not deal with parsing expressions, declarations, or consuming
  /// any trailing semicolons.
  mutating func parseStatement() -> RawStmtSyntax {
    // If this is a label on a loop/switch statement, consume it and pass it into
    // parsing logic below.
    func label<S: RawStmtSyntaxNodeProtocol>(_ stmt: S, with label: Parser.StatementLabel?) -> RawStmtSyntax {
      guard let label = label else {
        return RawStmtSyntax(stmt)
      }
      return RawStmtSyntax(
        RawLabeledStmtSyntax(
          label: label.label,
          colon: label.colon,
          statement: RawStmtSyntax(stmt),
          arena: self.arena
        )
      )
    }

    let optLabel = self.parseOptionalStatementLabel()
    switch self.canRecoverTo(anyIn: CanBeStatementStart.self) {
    case (.for, let handle)?:
      return label(self.parseForStatement(forHandle: handle), with: optLabel)
    case (.while, let handle)?:
      return label(self.parseWhileStatement(whileHandle: handle), with: optLabel)
    case (.repeat, let handle)?:
      return label(self.parseRepeatStatement(repeatHandle: handle), with: optLabel)

    case (.do, let handle)?:
      // If we have 'do' expressions enabled, we parse a DoExprSyntax, and wrap
      // it in an ExpressionStmtSyntax.
      if self.experimentalFeatures.contains(.doExpressions) {
        let doExpr = self.parseDoExpression(doHandle: handle)
        let doStmt = RawExpressionStmtSyntax(
          expression: RawExprSyntax(doExpr),
          arena: self.arena
        )
        return label(doStmt, with: optLabel)
      }
      // Otherwise parse a regular DoStmtSyntax.
      return label(self.parseDoStatement(doHandle: handle), with: optLabel)
    case (.if, let handle)?:
      let ifExpr = self.parseIfExpression(ifHandle: handle)
      let ifStmt = RawExpressionStmtSyntax(
        expression: RawExprSyntax(ifExpr),
        arena: self.arena
      )
      return label(ifStmt, with: optLabel)
    case (.guard, let handle)?:
      return label(self.parseGuardStatement(guardHandle: handle), with: optLabel)
    case (.switch, let handle)?:
      let switchExpr = self.parseSwitchExpression(switchHandle: handle)
      let switchStmt = RawExpressionStmtSyntax(
        expression: RawExprSyntax(switchExpr),
        arena: self.arena
      )
      return label(switchStmt, with: optLabel)
    case (.break, let handle)?:
      return label(self.parseBreakStatement(breakHandle: handle), with: optLabel)
    case (.continue, let handle)?:
      return label(self.parseContinueStatement(continueHandle: handle), with: optLabel)
    case (.fallthrough, let handle)?:
      return label(self.parseFallThroughStatement(fallthroughHandle: handle), with: optLabel)
    case (.discard, let handle)?:
      return label(self.parseDiscardStatement(discardHandle: handle), with: optLabel)
    case (.return, let handle)?:
      return label(self.parseReturnStatement(returnHandle: handle), with: optLabel)
    case (.throw, let handle)?:
      return label(self.parseThrowStatement(throwHandle: handle), with: optLabel)
    case (.defer, let handle)?:
      return label(self.parseDeferStatement(deferHandle: handle), with: optLabel)
    case (.yield, let handle)?:
      return label(self.parseYieldStatement(yieldHandle: handle), with: optLabel)
    case (.then, let handle)? where experimentalFeatures.contains(.thenStatements):
      return label(self.parseThenStatement(handle: handle), with: optLabel)
    case nil, (.then, _)?:
      let missingStmt = RawStmtSyntax(RawMissingStmtSyntax(arena: self.arena))
      return label(missingStmt, with: optLabel)
    }
  }
}

// MARK: Conditional Statements

extension Parser {
  /// Parse a guard statement.
  mutating func parseGuardStatement(guardHandle: RecoveryConsumptionHandle) -> RawGuardStmtSyntax {
    let (unexpectedBeforeGuardKeyword, guardKeyword) = self.eat(guardHandle)
    let conditions = self.parseConditionList()
    let (unexpectedBeforeElseKeyword, elseKeyword) = self.expect(.keyword(.else))
    let body = self.parseCodeBlock(introducer: guardKeyword)
    return RawGuardStmtSyntax(
      unexpectedBeforeGuardKeyword,
      guardKeyword: guardKeyword,
      conditions: conditions,
      unexpectedBeforeElseKeyword,
      elseKeyword: elseKeyword,
      body: body,
      arena: self.arena
    )
  }
}

extension Parser {
  /// Parse a list of condition elements.
  mutating func parseConditionList() -> RawConditionElementListSyntax {
    // We have a simple comma separated list of clauses, but also need to handle
    // a variety of common errors situations (including migrating from Swift 2
    // syntax).
    var elements = [RawConditionElementSyntax]()
    var keepGoing: RawTokenSyntax? = nil
    var loopProgress = LoopProgressCondition()
    repeat {
      let condition = self.parseConditionElement(lastBindingKind: elements.last?.condition.as(RawOptionalBindingConditionSyntax.self)?.bindingSpecifier)
      var unexpectedBeforeKeepGoing: RawUnexpectedNodesSyntax? = nil
      keepGoing = self.consume(if: .comma)
      if keepGoing == nil, let token = self.consumeIfContextualPunctuator("&&") ?? self.consume(if: .keyword(.where)) {
        unexpectedBeforeKeepGoing = RawUnexpectedNodesSyntax(combining: unexpectedBeforeKeepGoing, token, arena: self.arena)
        keepGoing = missingToken(.comma)
      }
      elements.append(
        RawConditionElementSyntax(
          condition: condition,
          unexpectedBeforeKeepGoing,
          trailingComma: keepGoing,
          arena: self.arena
        )
      )
    } while keepGoing != nil && self.hasProgressed(&loopProgress)

    return RawConditionElementListSyntax(elements: elements, arena: self.arena)
  }

  /// Parse a condition element.
  ///
  /// `lastBindingKind` will be used to get a correct fall back, when there is missing `var` or `let` in a `if` statement etc.
  mutating func parseConditionElement(lastBindingKind: RawTokenSyntax?) -> RawConditionElementSyntax.Condition {
    // Parse a leading #available/#unavailable condition if present.
    if self.at(.poundAvailable, .poundUnavailable) {
      return self.parsePoundAvailableConditionElement()
    }

    // Parse the basic expression case.  If we have a leading let, var, inout,
    // borrow, case keyword or an assignment, then we know this is a binding.
    guard
      self.at(.keyword(.let), .keyword(.var), .keyword(.case))
        || self.at(.keyword(.inout))
        || (lastBindingKind != nil && self.peek(isAt: .equal))
    else {
      // If we lack it, then this is theoretically a boolean condition.
      // However, we also need to handle migrating from Swift 2 syntax, in
      // which a comma followed by an expression could actually be a pattern
      // clause followed by a binding.  Determine what we have by checking for a
      // syntactically valid pattern followed by an '=', which can never be a
      // boolean condition.
      //
      // However, if this is the first clause, and we see "x = y", then this is
      // almost certainly a typo for '==' and definitely not a continuation of
      // another clause, so parse it as an expression.  This also avoids
      // lookahead on simple if conditions that are obviously boolean conditions.
      return .expression(self.parseExpression(flavor: .stmtCondition, pattern: .none))
    }

    // We're parsing a conditional binding.
    enum BindingKind {
      case pattern(RawTokenSyntax, RawPatternSyntax)
      case optional(RawUnexpectedNodesSyntax?, RawTokenSyntax, RawPatternSyntax)
    }

    let kind: BindingKind
    if let caseKeyword = self.consume(if: .keyword(.case)) {
      let pattern = self.parseMatchingPattern(context: .matching)
      kind = .pattern(caseKeyword, pattern)
    } else {
      let unexpectedBeforeBindingKeyword: RawUnexpectedNodesSyntax?
      let letOrVar: RawTokenSyntax

      if self.at(.identifier), let lastBindingKind = lastBindingKind {
        (unexpectedBeforeBindingKeyword, letOrVar) = self.expect(.keyword(.let), .keyword(.var), default: .keyword(Keyword(lastBindingKind.tokenText) ?? .let))
      } else {
        letOrVar = self.consume(if: TokenSpec.keyword(.let), .keyword(.var)) ?? self.missingToken(.let)
        unexpectedBeforeBindingKeyword = nil
      }

      let pattern = self.parseMatchingPattern(context: .bindingIntroducer)
      kind = .optional(unexpectedBeforeBindingKeyword, letOrVar, pattern)
    }

    // Now parse an optional type annotation.
    let annotation: RawTypeAnnotationSyntax?
    if let colon = self.consume(if: .colon) {
      let type = self.parseType()
      annotation = RawTypeAnnotationSyntax(
        colon: colon,
        type: type,
        arena: self.arena
      )
    } else {
      annotation = nil
    }

    // Conditional bindings can have the format:
    //  `let newBinding = <expr>`, or
    //  `let newBinding`, which is shorthand for `let newBinding = newBinding`
    let initializer: RawInitializerClauseSyntax?
    if let eq = self.consume(if: .equal) {
      let value = self.parseExpression(flavor: .stmtCondition, pattern: .none)
      initializer = RawInitializerClauseSyntax(
        equal: eq,
        value: value,
        arena: self.arena
      )
    } else {
      initializer = nil
    }

    switch kind {
    case let .optional(unexpectedBeforeBindingKeyword, bindingSpecifier, pattern):
      return .optionalBinding(
        RawOptionalBindingConditionSyntax(
          unexpectedBeforeBindingKeyword,
          bindingSpecifier: bindingSpecifier,
          pattern: pattern,
          typeAnnotation: annotation,
          initializer: initializer,
          arena: self.arena
        )
      )
    case let .pattern(caseKeyword, pattern):
      return .matchingPattern(
        RawMatchingPatternConditionSyntax(
          caseKeyword: caseKeyword,
          pattern: pattern,
          typeAnnotation: annotation,
          initializer: initializer
            ?? RawInitializerClauseSyntax(
              equal: RawTokenSyntax(missing: .equal, arena: self.arena),
              value: RawExprSyntax(RawMissingExprSyntax(arena: self.arena)),
              arena: self.arena
            ),
          arena: self.arena
        )
      )
    }
  }

  /// Parse an availability condition.
  mutating func parsePoundAvailableConditionElement() -> RawConditionElementSyntax.Condition {
    precondition(self.at(.poundAvailable, .poundUnavailable))
    let keyword = self.consumeAnyToken()
    let (unexpectedBeforeLParen, lparen) = self.expect(.leftParen)
    let arguments = self.parseAvailabilitySpecList()
    let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
    let unexpectedAfterRParen: RawUnexpectedNodesSyntax?
    if let (equalOperator, falseKeyword) = self.consume(if: { $0.isContextualPunctuator("==") }, followedBy: { TokenSpec.keyword(.false) ~= $0 }) {
      unexpectedAfterRParen = RawUnexpectedNodesSyntax([equalOperator, falseKeyword], arena: self.arena)
    } else {
      unexpectedAfterRParen = nil
    }
    return .availability(
      RawAvailabilityConditionSyntax(
        availabilityKeyword: keyword,
        unexpectedBeforeLParen,
        leftParen: lparen,
        availabilityArguments: arguments,
        unexpectedBeforeRParen,
        rightParen: rparen,
        unexpectedAfterRParen,
        arena: self.arena
      )
    )
  }
}

// MARK: Throw Statements

extension Parser {
  /// Parse a throw statement.
  mutating func parseThrowStatement(throwHandle: RecoveryConsumptionHandle) -> RawThrowStmtSyntax {
    let (unexpectedBeforeThrowKeyword, throwKeyword) = self.eat(throwHandle)
    let hasMisplacedTry = unexpectedBeforeThrowKeyword?.containsToken(where: { TokenSpec(.try) ~= $0 }) ?? false
    var expr = self.parseExpression(flavor: .basic, pattern: .none)
    if hasMisplacedTry && !expr.is(RawTryExprSyntax.self) {
      expr = RawExprSyntax(
        RawTryExprSyntax(
          tryKeyword: missingToken(.try),
          questionOrExclamationMark: nil,
          expression: expr,
          arena: self.arena
        )
      )
    }
    return RawThrowStmtSyntax(
      unexpectedBeforeThrowKeyword,
      throwKeyword: throwKeyword,
      expression: expr,
      arena: self.arena
    )
  }
}

// MARK: Discard Statements

extension Parser {
  /// Parse a discard statement.
  mutating func parseDiscardStatement(discardHandle: RecoveryConsumptionHandle) -> RawDiscardStmtSyntax {
    let (unexpectedBeforeDiscardKeyword, discardKeyword) = self.eat(discardHandle)
    let expr = self.parseExpression(flavor: .basic, pattern: .none)
    return RawDiscardStmtSyntax(
      unexpectedBeforeDiscardKeyword,
      discardKeyword: discardKeyword,
      expression: expr,
      arena: self.arena
    )
  }
}

// MARK: Defer Statements

extension Parser {
  /// Parse a defer statement.
  mutating func parseDeferStatement(deferHandle: RecoveryConsumptionHandle) -> RawDeferStmtSyntax {
    let (unexpectedBeforeDeferKeyword, deferKeyword) = self.eat(deferHandle)
    let items = self.parseCodeBlock(introducer: deferKeyword)
    return RawDeferStmtSyntax(
      unexpectedBeforeDeferKeyword,
      deferKeyword: deferKeyword,
      body: items,
      arena: self.arena
    )
  }
}

// MARK: Do-Catch Statements

extension Parser {
  /// Parse a do statement.
  mutating func parseDoStatement(doHandle: RecoveryConsumptionHandle) -> RawDoStmtSyntax {
    let (unexpectedBeforeDoKeyword, doKeyword) = self.eat(doHandle)

    // Parse the optional throws clause.
    let throwsClause: RawThrowsClauseSyntax?
    if let throwsSpecifier = self.consume(if: .keyword(.throws)) {
      throwsClause = parseThrowsClause(after: throwsSpecifier)
    } else {
      throwsClause = nil
    }

    let body = self.parseCodeBlock(introducer: doKeyword)

    // If the next token is 'catch', this is a 'do'/'catch' statement.
    var elements = [RawCatchClauseSyntax]()
    var loopProgress = LoopProgressCondition()
    while self.at(.keyword(.catch)) && self.hasProgressed(&loopProgress) {
      // Parse 'catch' clauses
      elements.append(self.parseCatchClause())
    }

    return RawDoStmtSyntax(
      unexpectedBeforeDoKeyword,
      doKeyword: doKeyword,
      throwsClause: throwsClause,
      body: body,
      catchClauses: RawCatchClauseListSyntax(elements: elements, arena: self.arena),
      arena: self.arena
    )
  }

  /// Parse a catch statement.
  ///
  /// - Note: This is not a "first class" statement it can only appear
  /// following a 'do' statement.
  mutating func parseCatchClause() -> RawCatchClauseSyntax {
    let (unexpectedBeforeCatchKeyword, catchKeyword) = self.expect(.keyword(.catch))
    var catchItems = [RawCatchItemSyntax]()
    if !self.at(.leftBrace) {
      var keepGoing: RawTokenSyntax? = nil
      var loopProgress = LoopProgressCondition()
      repeat {
        let (pattern, whereClause) = self.parseGuardedCatchPattern()
        keepGoing = self.consume(if: .comma)
        catchItems.append(
          RawCatchItemSyntax(
            pattern: pattern,
            whereClause: whereClause,
            trailingComma: keepGoing,
            arena: self.arena
          )
        )
      } while keepGoing != nil && self.hasProgressed(&loopProgress)
    }
    let body = self.parseCodeBlock(introducer: catchKeyword)
    return RawCatchClauseSyntax(
      unexpectedBeforeCatchKeyword,
      catchKeyword: catchKeyword,
      catchItems: RawCatchItemListSyntax(elements: catchItems, arena: self.arena),
      body: body,
      arena: self.arena
    )
  }

  /// Parse a pattern-matching clause for a catch statement,
  /// including the guard expression.
  private mutating func parseGuardedCatchPattern() -> (RawPatternSyntax?, RawWhereClauseSyntax?) {
    // If this is a 'catch' clause and we have "catch {" or "catch where...",
    // then we get an implicit "let error" pattern.
    let pattern: RawPatternSyntax?
    if self.at(.leftBrace, .keyword(.where)) {
      pattern = nil
    } else {
      pattern = self.parseMatchingPattern(context: .matching)
    }

    // Parse the optional 'where' guard.
    let whereClause: RawWhereClauseSyntax?
    if let whereKeyword = self.consume(if: .keyword(.where)) {
      let condition = self.parseExpression(flavor: .stmtCondition, pattern: .none)
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

// MARK: Iteration Statements

extension Parser {
  /// Parse a while statement.
  mutating func parseWhileStatement(whileHandle: RecoveryConsumptionHandle) -> RawWhileStmtSyntax {
    let (unexpectedBeforeWhileKeyword, whileKeyword) = self.eat(whileHandle)
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
    let body = self.parseCodeBlock(introducer: whileKeyword)
    return RawWhileStmtSyntax(
      unexpectedBeforeWhileKeyword,
      whileKeyword: whileKeyword,
      conditions: conditions,
      body: body,
      arena: self.arena
    )
  }
}

extension Parser {
  /// Parse a repeat-while statement.
  mutating func parseRepeatStatement(repeatHandle: RecoveryConsumptionHandle) -> RawRepeatStmtSyntax {
    let (unexpectedBeforeRepeatKeyword, repeatKeyword) = self.eat(repeatHandle)
    let body = self.parseCodeBlock(introducer: repeatKeyword)
    let (unexpectedBeforeWhileKeyword, whileKeyword) = self.expect(.keyword(.while))
    let condition = self.parseExpression(flavor: .basic, pattern: .none)
    return RawRepeatStmtSyntax(
      unexpectedBeforeRepeatKeyword,
      repeatKeyword: repeatKeyword,
      body: body,
      unexpectedBeforeWhileKeyword,
      whileKeyword: whileKeyword,
      condition: condition,
      arena: self.arena
    )
  }
}

// MARK: For-Each Statements

extension Parser {
  /// Parse a for-in statement.
  mutating func parseForStatement(forHandle: RecoveryConsumptionHandle) -> RawForStmtSyntax {
    let (unexpectedBeforeForKeyword, forKeyword) = self.eat(forHandle)
    let tryKeyword = self.consume(if: .keyword(.try))
    let awaitKeyword = self.consume(if: .keyword(.await))

    // Parse the pattern.  This is either 'case <refutable pattern>' or just a
    // normal pattern.
    let caseKeyword = self.consume(if: .keyword(.case))
    let pattern: RawPatternSyntax
    let type: RawTypeAnnotationSyntax?
    if caseKeyword != nil {
      pattern = self.parseMatchingPattern(context: .matching)
      // Now parse an optional type annotation.
      if let colon = self.consume(if: .colon) {
        let resultType = self.parseType()
        type = RawTypeAnnotationSyntax(
          colon: colon,
          type: resultType,
          arena: self.arena
        )
      } else {
        type = nil
      }
    } else {
      (pattern, type) = self.parseTypedPattern(allowRecoveryFromMissingColon: false)
    }

    let (unexpectedBeforeInKeyword, inKeyword) = self.expect(.keyword(.in))

    // If there is no expression, like `switch { default: return false }` then left brace would parsed as
    // a `RawClosureExprSyntax` in the condition, which is most likely not what the user meant.
    // Create a missing condition instead and use the `{` for the start of the body.
    let expr: RawExprSyntax
    if self.at(.leftBrace) {
      expr = RawExprSyntax(RawMissingExprSyntax(arena: self.arena))
    } else {
      expr = self.parseExpression(flavor: .stmtCondition, pattern: .none)
    }

    // Parse the 'where' expression if present.
    let whereClause: RawWhereClauseSyntax?
    if let whereKeyword = self.consume(if: .keyword(.where)) {
      let condition = self.parseExpression(flavor: .stmtCondition, pattern: .none)
      whereClause = RawWhereClauseSyntax(
        whereKeyword: whereKeyword,
        condition: condition,
        arena: self.arena
      )
    } else {
      whereClause = nil
    }

    // stmt-brace
    let body = self.parseCodeBlock(introducer: forKeyword)
    return RawForStmtSyntax(
      unexpectedBeforeForKeyword,
      forKeyword: forKeyword,
      tryKeyword: tryKeyword,
      awaitKeyword: awaitKeyword,
      caseKeyword: caseKeyword,
      pattern: pattern,
      typeAnnotation: type,
      unexpectedBeforeInKeyword,
      inKeyword: inKeyword,
      sequence: expr,
      whereClause: whereClause,
      body: body,
      arena: self.arena
    )
  }
}

// MARK: Control Transfer Statements

extension Parser {
  private mutating func isStartOfReturnExpr() -> Bool {
    enum NotReturnExprStart: TokenSpecSet {
      case rightBrace
      case `case`
      case `default`
      case semicolon
      case poundIf
      case poundEndif
      case poundElse
      case poundElseif
      case endOfFile

      init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
        switch PrepareForKeywordMatch(lexeme) {
        case TokenSpec(.rightBrace): self = .rightBrace
        case TokenSpec(.case): self = .case
        case TokenSpec(.default): self = .default
        case TokenSpec(.semicolon): self = .semicolon
        case TokenSpec(.poundIf): self = .poundIf
        case TokenSpec(.poundEndif): self = .poundEndif
        case TokenSpec(.poundElse): self = .poundElse
        case TokenSpec(.poundElseif): self = .poundElseif
        case TokenSpec(.endOfFile): self = .endOfFile
        default: return nil
        }
      }

      var spec: TokenSpec {
        switch self {
        case .rightBrace: return .rightBrace
        case .case: return .keyword(.case)
        case .default: return .keyword(.default)
        case .semicolon: return .semicolon
        case .poundIf: return .poundIf
        case .poundEndif: return .poundEndif
        case .poundElse: return .poundElse
        case .poundElseif: return .poundElseif
        case .endOfFile: return .endOfFile
        }
      }
    }

    if self.at(anyIn: NotReturnExprStart.self) != nil {
      return false
    }
    // Allowed for single value statement expressions, e.g do/if/switch.
    if self.at(anyIn: SingleValueStatementExpression.self) != nil {
      return true
    }
    if self.atStartOfStatement(preferExpr: true) || self.atStartOfDeclaration() {
      return false
    }
    return true
  }

  /// Parse a return statement
  mutating func parseReturnStatement(returnHandle: RecoveryConsumptionHandle) -> RawReturnStmtSyntax {
    let (unexpectedBeforeRet, ret) = self.eat(returnHandle)
    let hasMisplacedTry = unexpectedBeforeRet?.containsToken(where: { TokenSpec(.try) ~= $0 }) ?? false

    // Handle the ambiguity between consuming the expression and allowing the
    // enclosing stmt-brace to get it by eagerly eating it unless the return is
    // followed by a '}', '', statement or decl start keyword sequence.
    let expr: RawExprSyntax?
    if isStartOfReturnExpr() {
      let parsedExpr = self.parseExpression(flavor: .basic, pattern: .none)
      if hasMisplacedTry && !parsedExpr.is(RawTryExprSyntax.self) {
        expr = RawExprSyntax(
          RawTryExprSyntax(
            tryKeyword: missingToken(.try),
            questionOrExclamationMark: nil,
            expression: parsedExpr,
            arena: self.arena
          )
        )
      } else {
        expr = parsedExpr
      }
    } else {
      expr = nil
    }
    return RawReturnStmtSyntax(
      unexpectedBeforeRet,
      returnKeyword: ret,
      expression: expr,
      arena: self.arena
    )
  }
}

extension Parser {
  /// Parse a yield statement.
  ///
  /// Yield statements are not formally a part of the Swift language yet.
  mutating func parseYieldStatement(yieldHandle: RecoveryConsumptionHandle) -> RawYieldStmtSyntax {
    let (unexpectedBeforeYield, yield) = self.eat(yieldHandle)

    let yieldedExpressions: RawYieldStmtSyntax.YieldedExpressions
    if let lparen = self.consume(if: .leftParen) {
      let exprList: RawYieldedExpressionListSyntax
      do {
        var keepGoing = true
        var elementList = [RawYieldedExpressionSyntax]()
        var loopProgress = LoopProgressCondition()
        while !self.at(.endOfFile, .rightParen) && keepGoing && self.hasProgressed(&loopProgress) {
          let expr = self.parseExpression(flavor: .basic, pattern: .none)
          let comma = self.consume(if: .comma)
          elementList.append(
            RawYieldedExpressionSyntax(
              expression: expr,
              comma: comma,
              arena: self.arena
            )
          )

          keepGoing = (comma != nil)
        }
        exprList = RawYieldedExpressionListSyntax(elements: elementList, arena: self.arena)
      }
      let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
      yieldedExpressions = .multiple(
        RawYieldedExpressionsClauseSyntax(
          leftParen: lparen,
          elements: exprList,
          unexpectedBeforeRParen,
          rightParen: rparen,
          arena: self.arena
        )
      )
    } else {
      yieldedExpressions = .single(self.parseExpression(flavor: .basic, pattern: .none))
    }

    return RawYieldStmtSyntax(
      unexpectedBeforeYield,
      yieldKeyword: yield,
      yieldedExpressions: yieldedExpressions,
      arena: self.arena
    )
  }
}

extension Parser {
  /// Parse a `then` statement.
  mutating func parseThenStatement(handle: RecoveryConsumptionHandle) -> RawStmtSyntax {
    assert(experimentalFeatures.contains(.thenStatements))

    let (unexpectedBeforeThen, then) = self.eat(handle)
    let hasMisplacedTry = unexpectedBeforeThen?.containsToken(where: { TokenSpec(.try) ~= $0 }) ?? false

    var expr = self.parseExpression(flavor: .basic, pattern: .none)
    if hasMisplacedTry && !expr.is(RawTryExprSyntax.self) {
      expr = RawExprSyntax(
        RawTryExprSyntax(
          tryKeyword: missingToken(.try),
          questionOrExclamationMark: nil,
          expression: expr,
          arena: self.arena
        )
      )
    }
    return RawStmtSyntax(
      RawThenStmtSyntax(
        unexpectedBeforeThen,
        thenKeyword: then,
        expression: expr,
        arena: self.arena
      )
    )
  }
}

extension Parser {
  struct StatementLabel {
    var label: RawTokenSyntax
    var colon: RawTokenSyntax

    init(
      label: RawTokenSyntax,
      colon: RawTokenSyntax
    ) {
      self.label = label
      self.colon = colon
    }
  }

  /// Parse an optional label that defines a named control flow point.
  mutating func parseOptionalStatementLabel() -> StatementLabel? {
    if let (label, colon) = self.consume(if: .identifier, followedBy: .colon) {
      return StatementLabel(
        label: label,
        colon: colon
      )
    } else {
      return nil
    }
  }
}

extension Parser {
  /// Parse a break statement.
  mutating func parseBreakStatement(breakHandle: RecoveryConsumptionHandle) -> RawBreakStmtSyntax {
    let (unexpectedBeforeBreakKeyword, breakKeyword) = self.eat(breakHandle)
    let label = self.parseOptionalControlTransferTarget()
    return RawBreakStmtSyntax(
      unexpectedBeforeBreakKeyword,
      breakKeyword: breakKeyword,
      label: label,
      arena: self.arena
    )
  }

  /// Parse a continue statement.
  mutating func parseContinueStatement(continueHandle: RecoveryConsumptionHandle) -> RawContinueStmtSyntax {
    let (unexpectedBeforeContinueKeyword, continueKeyword) = self.eat(continueHandle)
    let label = self.parseOptionalControlTransferTarget()
    return RawContinueStmtSyntax(
      unexpectedBeforeContinueKeyword,
      continueKeyword: continueKeyword,
      label: label,
      arena: self.arena
    )
  }

  /// Parse a fallthrough statement.
  mutating func parseFallThroughStatement(fallthroughHandle: RecoveryConsumptionHandle) -> RawFallThroughStmtSyntax {
    let (unexpectedBeforeFallthroughKeyword, fallthroughKeyword) = self.eat(fallthroughHandle)
    return RawFallThroughStmtSyntax(
      unexpectedBeforeFallthroughKeyword,
      fallthroughKeyword: fallthroughKeyword,
      arena: self.arena
    )
  }

  mutating func parseOptionalControlTransferTarget() -> RawTokenSyntax? {
    guard !self.atStartOfLine else {
      return nil
    }

    guard
      self.at(.identifier) && !self.atStartOfStatement(preferExpr: true) && !self.atStartOfDeclaration()
    else {
      return nil
    }

    return self.expectWithoutRecovery(.identifier)
  }
}

// MARK: Lookahead

extension Parser.Lookahead {
  /// Returns `true` if the current token represents the start of a statement
  /// item.
  ///
  /// - Parameters:
  ///   - allowRecovery: Whether to attempt to perform recovery.
  ///   - preferExpr: If either an expression or statement could be
  ///     parsed and this parameter is `true`, the function returns `false`
  ///     such that an expression can be parsed.
  ///
  /// - Note: This function must be kept in sync with `parseStatement()`.
  /// - Seealso: ``Parser/parseStatement()``
  mutating func atStartOfStatement(allowRecovery: Bool = false, preferExpr: Bool) -> Bool {
    if (self.at(anyIn: SwitchCaseStart.self) != nil || self.at(.atSign)) && withLookahead({ $0.atStartOfSwitchCaseItem() }) {
      // We consider SwitchCaseItems statements so we don't parse the start of a new case item as trailing parts of an expression.
      return true
    }

    _ = self.consume(if: .identifier, followedBy: .colon)
    let switchSubject: CanBeStatementStart?
    if allowRecovery {
      switchSubject = self.canRecoverTo(anyIn: CanBeStatementStart.self)?.0
    } else {
      switchSubject = self.at(anyIn: CanBeStatementStart.self)?.0
    }
    switch switchSubject {
    case .return?,
      .throw?,
      .defer?,
      .if?,
      .guard?,
      .while?,
      .do?,
      .for?,
      .break?,
      .continue?,
      .fallthrough?,
      .switch?:
      return true
    case .repeat?:
      // 'repeat' followed by anything other than a brace stmt
      // is a pack expansion expression.
      // FIXME: 'repeat' followed by '{' could be a pack expansion
      // with a closure pattern.
      return self.peek().rawTokenKind == .leftBrace
    case .yield?:
      switch self.peek().rawTokenKind {
      case .prefixAmpersand:
        // "yield &" always denotes a yield statement.
        return true
      case .leftParen:
        // "yield (", by contrast, must be disambiguated with additional
        // context. We always consider it an apply expression of a function
        // called `yield` for the purposes of the parse.
        return false
      case .binaryOperator:
        // 'yield &= x' treats yield as an identifier.
        return false
      default:
        // "yield" followed immediately by any other token is likely a
        // yield statement of some singular expression.
        return !self.peek().isAtStartOfLine
      }
    case .discard?:
      let next = peek()
      // The thing to be discarded must be on the same line as `discard`.
      if next.isAtStartOfLine {
        return false
      }
      switch next.rawTokenKind {
      case .identifier, .keyword:
        // Since some identifiers like "self" are classified as keywords,
        // we want to recognize those too, to handle "discard self". We also
        // accept any identifier since we want to emit a nice error message
        // later on during type checking.
        return true
      default:
        // any other token following "discard" means it's not the statement.
        // For example, could be the function call "discard()".
        return false
      }

    case .then where experimentalFeatures.contains(.thenStatements):
      return atStartOfThenStatement(preferExpr: preferExpr)

    case nil, .then:
      return false
    }
  }

  /// Whether we're currently at a `then` token that should be parsed as a
  /// `then` statement.
  mutating func atStartOfThenStatement(preferExpr: Bool) -> Bool {
    guard self.at(.keyword(.then)) else {
      return false
    }

    // If we prefer an expr and aren't at the start of a newline, then don't
    // parse a ThenStmt.
    if preferExpr && !self.atStartOfLine {
      return false
    }

    // If 'then' is followed by a binary or postfix operator, prefer to parse as
    // an expr.
    if peek(isAtAnyIn: BinaryOperatorLike.self) != nil || peek(isAtAnyIn: PostfixOperatorLike.self) != nil {
      return false
    }

    switch PrepareForKeywordMatch(peek()) {
    case TokenSpec(.is), TokenSpec(.as):
      // Treat 'is' and 'as' like the binary operator case, and parse as an
      // expr.
      return false

    case .leftBrace:
      // This is a trailing closure.
      return false

    case .leftParen, .leftSquare, .period:
      // These are handled based on whether there is trivia between the 'then'
      // and the token. If so, it's a 'then' statement. Otherwise it should
      // be treated as an expression, e.g `then(...)`, `then[...]`, `then.foo`.
      return !self.currentToken.trailingTriviaText.isEmpty || !peek().leadingTriviaText.isEmpty
    default:
      break
    }
    return true
  }

  /// Returns whether the parser's current position is the start of a switch case,
  /// given that we're in the middle of a switch already.
  mutating func atStartOfSwitchCase(allowRecovery: Bool = false) -> Bool {
    // Check for and consume attributes. The only valid attribute is `@unknown`
    // but that's a semantic restriction.
    var lookahead = self.lookahead()
    var loopProgress = LoopProgressCondition()
    var hasAttribute = false
    while lookahead.at(.atSign) && lookahead.hasProgressed(&loopProgress) {
      guard lookahead.peek().rawTokenKind == .identifier else {
        return false
      }

      lookahead.eat(.atSign)
      lookahead.eat(.identifier)
      hasAttribute = true
    }

    if hasAttribute && lookahead.at(.rightBrace) {
      // If we are at an attribute that's the last token in the SwitchCase, parse
      // that as an attribute to a missing 'case'. That way, if the developer writes
      // @unknown at the end of a switch but forgot to write 'default', we'll emit
      // a diagnostic about a missing label instead of a missing declaration after
      // the attribute.
      return true
    }

    if allowRecovery {
      return lookahead.canRecoverTo(anyIn: SwitchCaseStart.self) != nil
    } else {
      return lookahead.at(anyIn: SwitchCaseStart.self) != nil
    }
  }

  mutating func atStartOfConditionalSwitchCases() -> Bool {
    guard self.at(.poundIf) else {
      return self.atStartOfSwitchCase()
    }

    var lookahead = self.lookahead()
    var loopProgress = LoopProgressCondition()
    repeat {
      lookahead.consumeAnyToken()
      // just find the end of the line
      lookahead.skipUntilEndOfLine()
    } while lookahead.at(.poundIf, .poundElseif, .poundElse) && lookahead.hasProgressed(&loopProgress)
    return lookahead.atStartOfSwitchCase()
  }
}
