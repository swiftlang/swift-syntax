//===------------------------ Statements.swift ----------------------------===//
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

extension TokenConsumer {
  /// Returns `true` if the current token represents the start of a statement
  /// item.
  ///
  /// - Note: This function must be kept in sync with `parseStatement()`.
  /// - Seealso: ``Parser/parseStatement()``
  func atStartOfStatement(context: Parser.ItemContext? = nil) -> Bool {
    return self.lookahead().isStartOfStatement(context: context)
  }
}

extension Parser {
  /// Parse a statement.
  ///
  /// This function is meant to be invoked as part of parsing an item. As such
  /// it does not deal with parsing expressions, declarations, or consuming
  /// any trailing semicolons.
  ///
  /// Grammar
  /// =======
  ///
  ///     statement → loop-statement ';'?
  ///     statement → branch-statement ';'?
  ///     statement → labeled-statement ';'?
  ///     statement → control-transfer-statement ';'?
  ///     statement → defer-statement ';'?
  ///     statement → do-statement ';'?
  ///
  ///     loop-statement → for-in-statement
  ///     loop-statement → while-statement
  ///     loop-statement → repeat-while-statement
  ///
  ///     branch-statement → if-statement
  ///     branch-statement → guard-statement
  ///     branch-statement → switch-statement
  ///
  ///     labeled-statement → statement-label loop-statement
  ///     labeled-statement → statement-label if-statement
  ///     labeled-statement → statement-label switch-statement
  ///     labeled-statement → statement-label do-statement
  ///
  ///     control-transfer-statement → break-statement
  ///     control-transfer-statement → continue-statement
  ///     control-transfer-statement → fallthrough-statement
  ///     control-transfer-statement → return-statement
  ///     control-transfer-statement → throw-statement
  @_spi(RawSyntax)
  public mutating func parseStatement() -> RawStmtSyntax {
    // If this is a label on a loop/switch statement, consume it and pass it into
    // parsing logic below.
    func label<S: RawStmtSyntaxNodeProtocol>(_ stmt: S, with label: Parser.StatementLabel?) -> RawStmtSyntax {
      guard let label = label else {
        return RawStmtSyntax(stmt)
      }
      return RawStmtSyntax(RawLabeledStmtSyntax(
        labelName: label.label,
        labelColon: label.colon,
        statement: RawStmtSyntax(stmt),
        arena: self.arena
      ))
    }

    let optLabel = self.parseOptionalStatementLabel()
    switch self.at(anyIn: CanBeStatementStart.self) {
    case (.forKeyword, _)?:
      return label(self.parseForEachStatement(), with: optLabel)
    case (.whileKeyword, _)?:
      return label(self.parseWhileStatement(), with: optLabel)
    case (.repeatKeyword, _)?:
      return label(self.parseRepeatWhileStatement(), with: optLabel)

    case (.ifKeyword, _)?:
      return label(self.parseIfStatement(), with: optLabel)
    case (.guardKeyword, _)?:
      return label(self.parseGuardStatement(), with: optLabel)
    case (.switchKeyword, _)?:
      return label(self.parseSwitchStatement(), with: optLabel)

    case (.breakKeyword, _)?:
      return label(self.parseBreakStatement(), with: optLabel)
    case (.continueKeyword, _)?:
      return label(self.parseContinueStatement(), with: optLabel)
    case (.fallthroughKeyword, _)?:
      return label(self.parseFallthroughStatement(), with: optLabel)
    case (.returnKeyword, _)?:
      return label(self.parseReturnStatement(), with: optLabel)
    case (.throwKeyword, _)?:
      return label(self.parseThrowStatement(), with: optLabel)
    case (.deferKeyword, _)?:
      return label(self.parseDeferStatement(), with: optLabel)
    case (.doKeyword, _)?:
      return label(self.parseDoStatement(), with: optLabel)

    case (.poundAssertKeyword, _)?:
      return label(self.parsePoundAssertStatement(), with: optLabel)
    case (.yieldAsIdentifier, _)?,
         (.yield, _)?:
      return label(self.parseYieldStatement(), with: optLabel)
    case nil:
      let missingStmt = RawStmtSyntax(RawMissingStmtSyntax(arena: self.arena))
      return label(missingStmt, with: optLabel)
    }
  }
}

// MARK: Conditional Statements

extension Parser {
  /// Parse an if statement.
  ///
  /// Grammar
  /// =======
  ///
  ///     if-statement → 'if' condition-list code-block else-clause?
  ///     else-clause  → 'else' code-block | else if-statement
  @_spi(RawSyntax)
  public mutating func parseIfStatement() -> RawIfStmtSyntax {
    let (unexpectedBeforeIfKeyword, ifKeyword) = self.expect(.ifKeyword)
    // A scope encloses the condition and true branch for any variables bound
    // by a conditional binding. The else branch does *not* see these variables.
    let conditions = self.parseConditionList()
    let body = self.parseCodeBlock()

    // The else branch, if any, is outside of the scope of the condition.
    let elseKeyword = self.consume(if: .elseKeyword)
    let elseBody: RawSyntax?
    if elseKeyword != nil {
      if self.at(.ifKeyword) {
        elseBody = RawSyntax(self.parseIfStatement())
      } else {
        elseBody = RawSyntax(self.parseCodeBlock())
      }
    } else {
      elseBody = nil
    }

    return RawIfStmtSyntax(
      unexpectedBeforeIfKeyword,
      ifKeyword: ifKeyword,
      conditions: conditions,
      body: body,
      elseKeyword: elseKeyword, elseBody: elseBody,
      arena: self.arena)
  }
}

extension Parser {
  /// Parse a guard statement.
  ///
  /// Grammar
  /// =======
  ///
  ///     guard-statement → 'guard' condition-list 'else' code-block
  @_spi(RawSyntax)
  public mutating func parseGuardStatement() -> RawGuardStmtSyntax {
    let (unexpectedBeforeGuardKeyword, guardKeyword) = self.expect(.guardKeyword)
    let conditions = self.parseConditionList()
    let (unexpectedBeforeElseKeyword, elseKeyword) = self.expect(.elseKeyword)
    let body = self.parseCodeBlock()
    return RawGuardStmtSyntax(
      unexpectedBeforeGuardKeyword,
      guardKeyword: guardKeyword,
      conditions: conditions,
      unexpectedBeforeElseKeyword,
      elseKeyword: elseKeyword,
      body: body,
      arena: self.arena)
  }
}


extension Parser {
  /// Parse a list of condition elements.
  ///
  /// Grammar
  /// =======
  ///
  ///     condition-list → condition | condition , condition-list
  @_spi(RawSyntax)
  public mutating func parseConditionList() -> RawConditionElementListSyntax {
    // We have a simple comma separated list of clauses, but also need to handle
    // a variety of common errors situations (including migrating from Swift 2
    // syntax).
    var elements = [RawConditionElementSyntax]()
    var keepGoing: RawTokenSyntax? = nil
    var loopProgress = LoopProgressCondition()
    repeat {
      let condition = self.parseConditionElement()
      keepGoing = self.consume(if: .comma)
      elements.append(RawConditionElementSyntax(
        condition: RawSyntax(condition), trailingComma: keepGoing,
        arena: self.arena))
    } while keepGoing != nil && loopProgress.evaluate(currentToken)

    return RawConditionElementListSyntax(elements: elements, arena: self.arena)
  }

  /// Parse a condition element.
  ///
  /// Grammar
  /// =======
  ///
  ///     condition → expression | availability-condition | case-condition | optional-binding-condition
  ///
  ///     case-condition → 'case' pattern initializer
  ///     optional-binding-condition → 'let' pattern initializer? | 'var' pattern initializer?
  @_spi(RawSyntax)
  public mutating func parseConditionElement() -> RawSyntax {
    // Parse a leading #available/#unavailable condition if present.
    if self.at(any: [.poundAvailableKeyword, .poundUnavailableKeyword]) {
      return self.parsePoundAvailableConditionElement()
    }
    
    // Parse a #_hasSymbol condition if present.
    if self.at(.poundHasSymbolKeyword) {
      return self.parsePoundHasSymbolConditionElement()
    }

    // Parse the basic expression case.  If we have a leading let/var/case
    // keyword or an assignment, then we know this is a binding.
    guard self.at(any: [.letKeyword, .varKeyword, .caseKeyword]) else {
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
      // lookahead + backtracking on simple if conditions that are obviously
      // boolean conditions.
      return RawSyntax(self.parseExpression(.basic))
    }

    // We're parsing a conditional binding.
    assert(self.at(any: [.letKeyword, .varKeyword, .caseKeyword]))
    enum BindingKind {
      case pattern(RawTokenSyntax, RawPatternSyntax)
      case optional(RawTokenSyntax, RawPatternSyntax)
    }

    let kind: BindingKind
    if let caseKeyword = self.consume(if: .caseKeyword) {
      let pattern = self.parseMatchingPattern(context: .matching)
      kind = .pattern(caseKeyword, pattern)
    } else {
      let letOrVar = self.consumeAnyToken()
      let pattern = self.parseMatchingPattern(context: .letOrVar)
      kind = .optional(letOrVar, pattern)
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
      let value = self.parseExpression(.basic)
      initializer = RawInitializerClauseSyntax(
        equal: eq,
        value: value,
        arena: self.arena
      )
    } else {
      initializer = nil
    }

    switch kind {
    case let .optional(letOrVar, pattern):
      return RawSyntax(RawOptionalBindingConditionSyntax(
        letOrVarKeyword: letOrVar,
        pattern: pattern,
        typeAnnotation: annotation,
        initializer: initializer,
        arena: self.arena))
    case let .pattern(caseKeyword, pattern):
      return RawSyntax(RawMatchingPatternConditionSyntax(
        caseKeyword: caseKeyword,
        pattern: pattern,
        typeAnnotation: annotation,
        initializer: initializer ?? RawInitializerClauseSyntax(
          equal: RawTokenSyntax(missing: .equal, arena: self.arena),
          value: RawExprSyntax(RawMissingExprSyntax(arena: self.arena)),
          arena: self.arena
        ),
        arena: self.arena))
    }
  }

  /// Parse an availability condition.
  ///
  /// Grammar
  /// =======
  ///
  ///     availability-condition → '#available' '(' availability-arguments ')'
  ///     availability-condition → '#unavailable' '(' availability-arguments ')'
  @_spi(RawSyntax)
  public mutating func parsePoundAvailableConditionElement() -> RawSyntax {
    assert(self.at(any: [.poundAvailableKeyword, .poundUnavailableKeyword]))
    let kind: AvailabilitySpecSource = self.at(.poundAvailableKeyword) ? .available : .unavailable
    let keyword = self.consumeAnyToken()
    let (unexpectedBeforeLParen, lparen) = self.expect(.leftParen)
    let spec = self.parseAvailabilitySpecList(from: kind)
    let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
    switch kind {
    case .available:
      return RawSyntax(RawAvailabilityConditionSyntax(
        poundAvailableKeyword: keyword,
        unexpectedBeforeLParen,
        leftParen: lparen,
        availabilitySpec: spec,
        unexpectedBeforeRParen,
        rightParen: rparen,
        arena: self.arena))
    case .unavailable:
      return RawSyntax(RawUnavailabilityConditionSyntax(
        poundUnavailableKeyword: keyword,
        unexpectedBeforeLParen,
        leftParen: lparen,
        availabilitySpec: spec,
        unexpectedBeforeRParen,
        rightParen: rparen,
        arena: self.arena))
    case .macro:
      fatalError("Macros are not allowed in this position!")
    }
  }
  
  /// Parse a `#_hasSymbol` condition.
  ///
  /// Grammar
  /// =======
  ///
  ///     has-symbol-condition → '#_hasSymbol' '(' expr ')'
  @_spi(RawSyntax)
  public mutating func parsePoundHasSymbolConditionElement() -> RawSyntax {
    let (unexpectedBeforeKeyword, keyword) = self.expect(.poundHasSymbolKeyword)
    let (unexpectedBeforeLParen, lparen) = self.expect(.leftParen)
    let expr = self.parseExpression()
    let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
    return RawSyntax(RawHasSymbolConditionSyntax(
      unexpectedBeforeKeyword,
      hasSymbolKeyword: keyword,
      unexpectedBeforeLParen,
      leftParen: lparen,
      expression: expr,
      unexpectedBeforeRParen,
      rightParen: rparen,
      arena: self.arena)
    )
  }
}

// MARK: Throw Statements

extension Parser {
  /// Parse a throw statement.
  ///
  /// Grammar
  /// =======
  ///
  ///     throw-statement → 'throw' expression
  @_spi(RawSyntax)
  public mutating func parseThrowStatement() -> RawThrowStmtSyntax {
    let (unexpectedBeforeThrowKeyword, throwKeyword) = self.expect(.throwKeyword)
    let expr = self.parseExpression()
    return RawThrowStmtSyntax(
      unexpectedBeforeThrowKeyword,
      throwKeyword: throwKeyword,
      expression: expr,
      arena: self.arena
    )
  }
}

// MARK: Defer Statements

extension Parser {
  /// Parse a defer statement.
  ///
  /// Grammar
  /// =======
  ///
  ///     defer-statement → 'defer' code-block
  @_spi(RawSyntax)
  public mutating func parseDeferStatement() -> RawDeferStmtSyntax {
    let (unexpectedBeforeDeferKeyword, deferKeyword) = self.expect(.deferKeyword)
    let items = self.parseCodeBlock()
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
  ///
  /// Grammar
  /// =======
  ///
  ///     do-statement → 'do' code-block catch-clauses?
  @_spi(RawSyntax)
  public mutating func parseDoStatement() -> RawDoStmtSyntax {
    let (unexpectedBeforeDoKeyword, doKeyword) = self.expect(.doKeyword)
    let body = self.parseCodeBlock()

    // If the next token is 'catch', this is a 'do'/'catch' statement.
    var elements = [RawCatchClauseSyntax]()
    var loopProgress = LoopProgressCondition()
    while self.at(.catchKeyword) && loopProgress.evaluate(self.currentToken) {
      // Parse 'catch' clauses
      elements.append(self.parseCatchClause())
    }

    return RawDoStmtSyntax(
      unexpectedBeforeDoKeyword,
      doKeyword: doKeyword,
      body: body,
      catchClauses: elements.isEmpty ? nil : RawCatchClauseListSyntax(elements: elements, arena: self.arena),
      arena: self.arena)
  }

  /// Parse a catch statement.
  ///
  /// - Note: This is not a "first class" statement it can only appear
  /// following a 'do' statement.
  ///
  /// Grammar
  /// =======
  ///
  ///     catch-clauses → catch-clause catch-clauses?
  ///     catch-clause → catch catch-pattern-list? code-block
  ///     catch-pattern-list → catch-pattern | catch-pattern ',' catch-pattern-list
  @_spi(RawSyntax)
  public mutating func parseCatchClause() -> RawCatchClauseSyntax {
    let (unexpectedBeforeCatchKeyword, catchKeyword) = self.expect(.catchKeyword)
    var catchItems = [RawCatchItemSyntax]()
    if !self.at(.leftBrace) {
      var keepGoing: RawTokenSyntax? = nil
      var loopProgress = LoopProgressCondition()
      repeat {
        let (pattern, whereClause) = self.parseGuardedPattern(.catch)
        keepGoing = self.consume(if: .comma)
        catchItems.append(RawCatchItemSyntax(
          pattern: pattern, whereClause: whereClause, trailingComma: keepGoing,
          arena: self.arena))
      } while keepGoing != nil && loopProgress.evaluate(currentToken)
    }
    let body = self.parseCodeBlock()
    return RawCatchClauseSyntax(
      unexpectedBeforeCatchKeyword,
      catchKeyword: catchKeyword,
      catchItems: catchItems.isEmpty ? nil : RawCatchItemListSyntax(elements: catchItems, arena:  self.arena),
      body: body,
      arena: self.arena)
  }
}

// MARK: Iteration Statements

extension Parser {
  /// Parse a while statement.
  ///
  /// Grammar
  /// =======
  ///
  ///     while-statement → 'while' condition-list code-block
  @_spi(RawSyntax)
  public mutating func parseWhileStatement() -> RawWhileStmtSyntax {
    let (unexpectedBeforeWhileKeyword, whileKeyword) = self.expect(.whileKeyword)
    let conditions = self.parseConditionList()
    let body = self.parseCodeBlock()
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
  ///
  /// Grammar
  /// =======
  ///
  ///     repeat-while-statement → 'repeat' code-block 'while' expression
  @_spi(RawSyntax)
  public mutating func parseRepeatWhileStatement() -> RawRepeatWhileStmtSyntax {
    let (unexpectedBeforeRepeatKeyword, repeatKeyword) = self.expect(.repeatKeyword)
    let body = self.parseCodeBlock()
    let (unexpectedBeforeWhileKeyword, whileKeyword) = self.expect(.whileKeyword)
    let condition = self.parseExpression()
    return RawRepeatWhileStmtSyntax(
      unexpectedBeforeRepeatKeyword,
      repeatKeyword: repeatKeyword,
      body: body,
      unexpectedBeforeWhileKeyword,
      whileKeyword: whileKeyword,
      condition: condition,
      arena: self.arena)
  }
}

// MARK: For-Each Statements

extension Parser {
  /// Parse a for-in statement.
  ///
  /// Grammar
  /// =======
  ///
  ///     for-in-statement → 'for' 'case'? pattern 'in' expression where-clause? code-block
  @_spi(RawSyntax)
  public mutating func parseForEachStatement() -> RawForInStmtSyntax {
    let (unexpectedBeforeForKeyword, forKeyword) = self.expect(.forKeyword)
    let tryKeyword = self.consume(if: .tryKeyword)

    let awaitKeyword = self.consumeIfContextualKeyword("await")

    // Parse the pattern.  This is either 'case <refutable pattern>' or just a
    // normal pattern.
    let caseKeyword = self.consume(if: .caseKeyword)
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
      (pattern, type) = self.parseTypedPattern()
    }

    let (unexpectedBeforeInKeyword, inKeyword) = self.expect(.inKeyword)

    let expr = self.parseExpression(.basic)

    // Parse the 'where' expression if present.
    let whereClause: RawWhereClauseSyntax?
    if let whereKeyword = self.consume(if: .whereKeyword) {
      let guardExpr = self.parseExpression(.basic)
      whereClause = RawWhereClauseSyntax(
        whereKeyword: whereKeyword,
        guardResult: guardExpr,
        arena: self.arena
      )
    } else {
      whereClause = nil
    }

    // stmt-brace
    let body = self.parseCodeBlock()
    return RawForInStmtSyntax(
      unexpectedBeforeForKeyword,
      forKeyword: forKeyword,
      tryKeyword: tryKeyword,
      awaitKeyword: awaitKeyword,
      caseKeyword: caseKeyword,
      pattern: pattern,
      typeAnnotation: type,
      unexpectedBeforeInKeyword,
      inKeyword: inKeyword,
      sequenceExpr: expr,
      whereClause: whereClause,
      body: body,
      arena: self.arena
    )
  }
}

// MARK: Switch Statements

extension Parser {
  /// Parse a switch statement.
  ///
  /// Grammar
  /// =======
  ///
  ///     switch-statement → 'switch' expression '{' switch-cases? '}'
  ///     switch-cases → switch-case switch-cases?
  @_spi(RawSyntax)
  public mutating func parseSwitchStatement() -> RawSwitchStmtSyntax {
    let (unexpectedBeforeSwitchKeyword, switchKeyword) = self.expect(.switchKeyword)

    let subject = self.parseExpression(.basic)
    let (unexpectedBeforeLBrace, lbrace) = self.expect(.leftBrace)

    let cases = self.parseSwitchCases()

    let (unexpectedBeforeRBrace, rbrace) = self.expect(.rightBrace)
    return RawSwitchStmtSyntax(
      unexpectedBeforeSwitchKeyword,
      switchKeyword: switchKeyword,
      expression: subject,
      unexpectedBeforeLBrace,
      leftBrace: lbrace,
      cases: cases,
      unexpectedBeforeRBrace,
      rightBrace: rbrace,
      arena: self.arena)
  }

  /// Parse a list of switch case clauses.
  ///
  /// Grammar
  /// =======
  ///
  ///     switch-cases → switch-case switch-cases?
  @_spi(RawSyntax)
  public mutating func parseSwitchCases() -> RawSwitchCaseListSyntax {
    var elements = [RawSyntax]()
    var elementsProgress = LoopProgressCondition()
    while !self.at(any: [.eof, .rightBrace, .poundEndifKeyword, .poundElseifKeyword, .poundElseKeyword])
            && elementsProgress.evaluate(currentToken) {
      if self.lookahead().isAtStartOfSwitchCase(allowRecovery: true) {
        elements.append(RawSyntax(self.parseSwitchCase()))
      } else if self.canRecoverTo(.poundIfKeyword) != nil {
        // '#if' in 'case' position can enclose zero or more 'case' or 'default'
        // clauses.
        elements.append(RawSyntax(self.parsePoundIfDirective(
          { $0.parseSwitchCases() },
          syntax: { parser, cases in
            guard cases.count == 1, let firstCase = cases.first else {
              assert(cases.isEmpty)
              return RawSyntax(RawSwitchCaseListSyntax(elements: [], arena: parser.arena))
            }
            return RawSyntax(firstCase)
          })))
      } else {
        break
      }
    }
    return RawSwitchCaseListSyntax(elements: elements, arena: self.arena)
  }

  /// Parse a single switch case clause.
  ///
  /// Grammar
  /// =======
  ///
  ///     switch-case → case-label statements
  ///     switch-case → default-label statements
  ///     switch-case → conditional-switch-case
  @_spi(RawSyntax)
  public mutating func parseSwitchCase() -> RawSwitchCaseSyntax {
    var unknownAttr: RawAttributeSyntax?
    if let at = self.consume(if: .atSign) {
      let (unexpectedBeforeIdent, ident) = self.expectIdentifier()

      var tokenList = [RawTokenSyntax]()
      var loopProgress = LoopProgressCondition()
      while let atSign = self.consume(if: .atSign), loopProgress.evaluate(currentToken) {
        tokenList.append(atSign)
        tokenList.append(self.expectIdentifierWithoutRecovery())
      }

      unknownAttr = RawAttributeSyntax(
        atSignToken: at,
        unexpectedBeforeIdent,
        attributeName: ident,
        leftParen: nil,
        argument: nil,
        rightParen: nil,
        tokenList: tokenList.isEmpty ? nil : RawTokenListSyntax(elements: tokenList, arena: self.arena),
        arena: self.arena
      )
    } else {
      unknownAttr = nil
    }

    let label: RawSyntax
    switch self.canRecoverTo(anyIn: SwitchCaseStart.self) {
    case (.caseKeyword, let handle)?:
      label = RawSyntax(self.parseSwitchCaseLabel(handle))
    case (.defaultKeyword, let handle)?:
      label = RawSyntax(self.parseSwitchDefaultLabel(handle))
    case nil:
      label = RawSyntax(RawMissingSyntax(arena: self.arena))
    }


    // Parse the body.
    let statements: RawCodeBlockItemListSyntax
    do {
      var items = [RawCodeBlockItemSyntax]()
      var loopProgress = LoopProgressCondition()
      while !self.at(any: [.rightBrace, .poundEndifKeyword, .poundElseifKeyword, .poundElseKeyword])
              && !self.lookahead().isStartOfConditionalSwitchCases(),
            let newItem = self.parseCodeBlockItem(),
            loopProgress.evaluate(currentToken) {
        items.append(newItem)
      }
      statements = RawCodeBlockItemListSyntax(elements: items, arena: self.arena)
    }

    return RawSwitchCaseSyntax(
      unknownAttr: unknownAttr, label: label, statements: statements,
      arena: self.arena)
  }

  /// Parse a switch case with a 'case' label.
  ///
  /// Grammar
  /// =======
  ///
  ///     case-label → attributes? case case-item-list ':'
  ///     case-item-list → pattern where-clause? | pattern where-clause? ',' case-item-list
  @_spi(RawSyntax)
  public mutating func parseSwitchCaseLabel(
    _ handle: RecoveryConsumptionHandle
  ) -> RawSwitchCaseLabelSyntax {
    let (unexpectedBeforeCaseKeyword, caseKeyword) = self.eat(handle)
    var caseItems = [RawCaseItemSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      var loopProgress = LoopProgressCondition()
      repeat {
        let (pattern, whereClause) = self.parseGuardedPattern(.case)
        keepGoing = self.consume(if: .comma)
        caseItems.append(RawCaseItemSyntax(
          pattern: pattern, whereClause: whereClause, trailingComma: keepGoing,
          arena: self.arena))
      } while keepGoing != nil && loopProgress.evaluate(currentToken)
    }
    let (unexpectedBeforeColon, colon) = self.expect(.colon)
    return RawSwitchCaseLabelSyntax(
      unexpectedBeforeCaseKeyword,
      caseKeyword: caseKeyword,
      caseItems: RawCaseItemListSyntax(elements: caseItems, arena: self.arena),
      unexpectedBeforeColon,
      colon: colon,
      arena: self.arena)
  }

  /// Parse a switch case with a 'default' label.
  ///
  /// Grammar
  /// =======
  ///
  ///     default-label → attributes? 'default' ':'
  @_spi(RawSyntax)
  public mutating func parseSwitchDefaultLabel(
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

  enum GuardedPatternContext {
    case `case`
    case `catch`
  }

  /// Parse a pattern-matching clause for a case or catch statement,
  /// including the guard expression.
  ///
  /// Grammar
  /// =======
  ///
  ///     case-item     → pattern where-clause?
  ///     catch-pattern → pattern where-clause?
  mutating func parseGuardedPattern(
    _ context: GuardedPatternContext
  ) -> (RawPatternSyntax, RawWhereClauseSyntax?) {
    let flavor: ExprFlavor
    switch context {
    // 'case' is terminated with a colon and so allows a trailing closure.
    case .`case`:
      flavor = .trailingClosure
    // 'catch' is terminated with a brace and so cannot.
    case .`catch`:
      flavor = .basic
    }

    let pattern = self.parseMatchingPattern(context: .matching)

    // Parse the optional 'where' guard, with this particular pattern's bound
    // vars in scope.
    let whereClause: RawWhereClauseSyntax?
    if let whereKeyword = self.consume(if: .whereKeyword) {
      let guardExpr = self.parseExpression(flavor)
      whereClause = RawWhereClauseSyntax(
        whereKeyword: whereKeyword,
        guardResult: guardExpr,
        arena: self.arena
      )
    } else {
      whereClause = nil
    }
    return (pattern, whereClause)
  }
}

// MARK: Control Transfer Statements

extension Parser {
  /// Parse a return statement
  ///
  /// Grammar
  /// =======
  ///
  ///     return-statement → 'return' expression?
  @_spi(RawSyntax)
  public mutating func parseReturnStatement() -> RawReturnStmtSyntax {
    let (unexpectedBeforeRet, ret) = self.expect(.returnKeyword)

    // Handle the ambiguity between consuming the expression and allowing the
    // enclosing stmt-brace to get it by eagerly eating it unless the return is
    // followed by a '}', '', statement or decl start keyword sequence.
    let expr: RawExprSyntax?
    if
      !self.at(any: [
        .rightBrace, .caseKeyword, .defaultKeyword, .semicolon, .eof,
        .poundIfKeyword, .poundErrorKeyword, .poundWarningKeyword,
        .poundEndifKeyword, .poundElseKeyword, .poundElseifKeyword
      ])
        && !self.atStartOfStatement() && !self.atStartOfDeclaration() {
      expr = self.parseExpression()
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
  ///
  /// Grammar
  /// =======
  ///
  ///     yield-statement → 'yield' '('? expr-list? ')'?
  @_spi(RawSyntax)
  public mutating func parseYieldStatement() -> RawYieldStmtSyntax {
    let (unexpectedBeforeYield, yield) = self.expectContextualKeyword("yield")

    let yields: RawSyntax
    if let lparen = self.consume(if: .leftParen) {
      let exprList: RawYieldExprListSyntax
      do {
        var keepGoing = true
        var elementList = [RawYieldExprListElementSyntax]()
        var loopProgress = LoopProgressCondition()
        while !self.at(any: [.eof, .rightParen]) && keepGoing && loopProgress.evaluate(currentToken) {
          let expr = self.parseExpression()
          let comma = self.consume(if: .comma)
          elementList.append(RawYieldExprListElementSyntax(
            expression: expr,
            comma: comma,
            arena: self.arena))

          keepGoing = (comma != nil)
        }
        exprList = RawYieldExprListSyntax(elements: elementList, arena: self.arena)
      }
      let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
      yields = RawSyntax(RawYieldListSyntax(
        leftParen: lparen,
        elementList: exprList,
        unexpectedBeforeRParen,
        rightParen: rparen,
        arena: self.arena))
    } else {
      yields = RawSyntax(self.parseExpression())
    }

    return RawYieldStmtSyntax(
      unexpectedBeforeYield,
      yieldKeyword: yield,
      yields: yields,
      arena: self.arena
    )
  }
}

extension Parser {
  @_spi(RawSyntax)
  public struct StatementLabel {
    public var label: RawTokenSyntax
    public var colon: RawTokenSyntax

    public init(
      label: RawTokenSyntax,
      colon: RawTokenSyntax
    ) {
      self.label = label
      self.colon = colon
    }
  }

  /// Parse an optional label that defines a named control flow point.
  ///
  /// Grammar
  /// =======
  ///
  ///     statement-label → label-name ':'
  ///     label-name → identifier
  @_spi(RawSyntax)
  public mutating func parseOptionalStatementLabel() -> StatementLabel? {
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
  ///
  /// Grammar
  /// =======
  ///
  ///     break-statement → 'break' label-name?
  @_spi(RawSyntax)
  public mutating func parseBreakStatement() -> RawBreakStmtSyntax {
    let (unexpectedBeforeBreakKeyword, breakKeyword) = self.expect(.breakKeyword)
    let label = self.parseOptionalControlTransferTarget()
    return RawBreakStmtSyntax(
      unexpectedBeforeBreakKeyword,
      breakKeyword: breakKeyword,
      label: label,
      arena: self.arena
    )
  }

  /// Parse a continue statement.
  ///
  /// Grammar
  /// =======
  ///
  ///     continue-statement → 'continue' label-name?
  @_spi(RawSyntax)
  public mutating func parseContinueStatement() -> RawContinueStmtSyntax {
    let (unexpectedBeforeContinueKeyword, continueKeyword) = self.expect(.continueKeyword)
    let label = self.parseOptionalControlTransferTarget()
    return RawContinueStmtSyntax(
      unexpectedBeforeContinueKeyword,
      continueKeyword: continueKeyword,
      label: label,
      arena: self.arena
    )
  }

  /// Parse a fallthrough statement.
  ///
  /// Grammar
  /// =======
  ///
  ///     fallthrough-statement → 'fallthrough'
  @_spi(RawSyntax)
  public mutating func parseFallthroughStatement() -> RawFallthroughStmtSyntax {
    let (unexpectedBeforeFallthroughKeyword, fallthroughKeyword) = self.expect(.fallthroughKeyword)
    return RawFallthroughStmtSyntax(
      unexpectedBeforeFallthroughKeyword,
      fallthroughKeyword: fallthroughKeyword,
      arena: self.arena
    )
  }

  // label-name → identifier
  @_spi(RawSyntax)
  public mutating func parseOptionalControlTransferTarget() -> RawTokenSyntax? {
    guard !self.currentToken.isAtStartOfLine else {
      return nil
    }

    guard
      self.at(.identifier) &&
        !self.atStartOfStatement() &&
        !self.atStartOfDeclaration()
    else {
      return nil
    }

    return self.expectIdentifierWithoutRecovery()
  }
}

extension Parser {
  @_spi(RawSyntax)
  public mutating func parsePoundAssertStatement() -> RawPoundAssertStmtSyntax {
    let (unexpectedBeforePoundAssert, poundAssert) = self.expect(.poundAssertKeyword)
    let (unexpectedBeforeLParen, lparen) = self.expect(.leftParen)
    let condition = self.parseExpression()
    let comma = self.consume(if: .comma)
    let message: RawTokenSyntax?
    if comma != nil {
      message = self.consumeAnyToken()
    } else {
      message = nil
    }
    let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
    return RawPoundAssertStmtSyntax(
      unexpectedBeforePoundAssert,
      poundAssert: poundAssert,
      unexpectedBeforeLParen,
      leftParen: lparen,
      condition: condition,
      comma: comma,
      message: message,
      unexpectedBeforeRParen,
      rightParen: rparen,
      arena: self.arena)
  }
}

// MARK: Lookahead

extension Parser.Lookahead {
  /// Returns `true` if the current token represents the start of a statement
  /// item.
  ///
  /// - Note: This function must be kept in sync with `parseStatement()`.
  /// - Seealso: ``Parser/parseStatement()``
  public func isStartOfStatement(context: Parser.ItemContext?) -> Bool {
    switch self.currentToken.tokenKind {
    case .returnKeyword,
        .throwKeyword,
        .deferKeyword,
        .ifKeyword,
        .guardKeyword,
        .whileKeyword,
        .doKeyword,
        .repeatKeyword,
        .forKeyword,
        .breakKeyword,
        .continueKeyword,
        .fallthroughKeyword,
        .switchKeyword,
        .caseKeyword,
        .defaultKeyword,
        .yield,
        .poundAssertKeyword,
        .poundIfKeyword,
        .poundWarningKeyword,
        .poundErrorKeyword,
        .poundSourceLocationKeyword:
      return true

    case .poundLineKeyword:
      // #line at the start of a line is a directive, when within, it is an expr.
      return self.currentToken.isAtStartOfLine

    case .identifier:
      // "identifier ':' for/while/do/switch" is a label on a loop/switch.
      guard self.peek().tokenKind == .colon else {
        // "yield" in the right context begins a yield statement.
        if context == .coroutineAccessor, self.atContextualKeyword("yield") {
          return true
        }
        return false
      }

      // To disambiguate other cases of "identifier :", which might be part of a
      // question colon expression or something else, we look ahead to the second
      // token.
      var backtrack = self.lookahead()
      backtrack.expectIdentifierWithoutRecovery()
      backtrack.eat(.colon)

      // We treating IDENTIFIER: { as start of statement to provide missed 'do'
      // diagnostics. This case will be handled in `parseStatement()`.
      if self.at(.leftBrace) {
        return true
      }
      // For better recovery, we just accept a label on any statement.  We reject
      // putting a label on something inappropriate in `parseStatement()`.
      return backtrack.isStartOfStatement(context: context)

    case .atSign:
      // Might be a statement or case attribute. The only one of these we have
      // right now is `@unknown default`, so hardcode a check for an attribute
      // without any parens.
      guard self.peek().tokenKind == .identifier else {
        return false
      }
      var backtrack = self.lookahead()
      backtrack.eat(.atSign)
      backtrack.expectIdentifierWithoutRecovery()
      return backtrack.isStartOfStatement(context: context)
    default:
      return false
    }
  }

  func isBooleanExpr() -> Bool {
    var lookahead = self.lookahead()
    return !lookahead.canParseTypedPattern() || !lookahead.at(.equal)
  }

  /// Returns whether the parser's current position is the start of a switch case,
  /// given that we're in the middle of a switch already.
  func isAtStartOfSwitchCase(allowRecovery: Bool = false) -> Bool {
    // Check for and consume attributes. The only valid attribute is `@unknown`
    // but that's a semantic restriction.
    var lookahead = self.lookahead()
    var loopProgress = LoopProgressCondition()
    while lookahead.at(.atSign) && loopProgress.evaluate(lookahead.currentToken) {
      guard lookahead.peek().tokenKind == .identifier else {
        return false
      }

      lookahead.eat(.atSign)
      lookahead.eat(.identifier)
    }

    if allowRecovery {
      return lookahead.canRecoverTo(anyIn: SwitchCaseStart.self) != nil
    } else {
      return lookahead.at(anyIn: SwitchCaseStart.self) != nil
    }
  }

  func isStartOfConditionalSwitchCases() -> Bool {
    guard self.at(.poundIfKeyword) else {
      return self.isAtStartOfSwitchCase()
    }

    var lookahead = self.lookahead()
    var loopProgress = LoopProgressCondition()
    repeat {
      lookahead.consumeAnyToken()
      // just find the end of the line
      lookahead.skipUntilEndOfLine()
    } while lookahead.at(any: [.poundIfKeyword, .poundElseifKeyword, .poundElseKeyword]) && loopProgress.evaluate(lookahead.currentToken)
    return lookahead.isAtStartOfSwitchCase()
  }
}
