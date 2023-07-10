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
  /// Consumes and returns all remaining tokens in the source file.
  mutating func consumeRemainingTokens() -> [RawSyntax] {
    var extraneousTokens = [RawSyntax]()
    while !self.at(.eof) {
      extraneousTokens.append(RawSyntax(consumeAnyToken()))
    }
    return extraneousTokens
  }

  /// If the maximum nesting level has been reached, return the remaining tokens in the source file
  /// as unexpected nodes that have the `isMaximumNestingLevelOverflow` bit set.
  /// Check this in places that are likely to cause deep recursion and if this returns non-nil, abort parsing.
  mutating func remainingTokensIfMaximumNestingLevelReached() -> RawUnexpectedNodesSyntax? {
    if nestingLevel > self.maximumNestingLevel && self.currentToken.rawTokenKind != .eof {
      let remainingTokens = self.consumeRemainingTokens()
      return RawUnexpectedNodesSyntax(elements: remainingTokens, isMaximumNestingLevelOverflow: true, arena: self.arena)
    } else {
      return nil
    }
  }

  /// Parse the top level items in a file into a source file.
  ///
  /// This function is the true parsing entrypoint that the high-level
  /// ``Parser/parse(source:parseTransition:filenameForDiagnostics:languageVersion:enableBareSlashRegexLiteral:)-7tndx``
  /// API calls.
  ///
  /// Grammar
  /// =======
  ///
  ///     source-file → top-level-declaration?
  mutating func parseSourceFile() -> RawSourceFileSyntax {
    let items = self.parseTopLevelCodeBlockItems()
    let unexpectedBeforeEof = consumeRemainingTokens()
    let eof = self.consume(if: .eof)!
    return .init(
      statements: items,
      RawUnexpectedNodesSyntax(unexpectedBeforeEof, arena: self.arena),
      eofToken: eof,
      arena: self.arena
    )
  }
}

extension Parser {
  mutating func parseCodeBlockItemList(
    isAtTopLevel: Bool = false,
    allowInitDecl: Bool = true,
    until stopCondition: (inout Parser) -> Bool
  ) -> RawCodeBlockItemListSyntax {
    var elements = [RawCodeBlockItemSyntax]()
    var loopProgress = LoopProgressCondition()
    while !stopCondition(&self), loopProgress.evaluate(currentToken) {
      let newItemAtStartOfLine = self.currentToken.isAtStartOfLine
      guard let newElement = self.parseCodeBlockItem(isAtTopLevel: isAtTopLevel, allowInitDecl: allowInitDecl) else {
        break
      }
      if let lastItem = elements.last, lastItem.semicolon == nil && !newItemAtStartOfLine {
        elements[elements.count - 1] = RawCodeBlockItemSyntax(
          lastItem.unexpectedBeforeItem,
          item: .init(lastItem.item)!,
          lastItem.unexpectedBetweenItemAndSemicolon,
          semicolon: self.missingToken(.semicolon),
          lastItem.unexpectedAfterSemicolon,
          arena: self.arena
        )
      }
      elements.append(newElement)
    }
    return .init(elements: elements, arena: self.arena)
  }

  /// Parse the top level items in a source file.
  ///
  /// Grammar
  /// =======
  ///
  ///     top-level-declaration → statements?
  mutating func parseTopLevelCodeBlockItems() -> RawCodeBlockItemListSyntax {
    return parseCodeBlockItemList(isAtTopLevel: true, until: { _ in false })
  }

  /// The optional form of `parseCodeBlock` that checks to see if the parser has
  /// encountered a left brace before proceeding.
  ///
  /// This function is used when parsing places where function bodies are
  /// optional - like the function requirements in protocol declarations.
  mutating func parseOptionalCodeBlock(allowInitDecl: Bool = true) -> RawCodeBlockSyntax? {
    guard self.at(.leftBrace) || self.canRecoverTo(TokenSpec(.leftBrace, allowAtStartOfLine: false)) != nil else {
      return nil
    }
    return self.parseCodeBlock(allowInitDecl: allowInitDecl)
  }

  /// Parse a code block.
  ///
  /// Grammar
  /// =======
  ///
  ///     code-block → '{' statements? '}'
  ///
  /// `introducer` is the `while`, `if`, ... keyword that is the cause that the code block is being parsed.
  /// If the left brace is missing, its indentation will be used to judge whether a following `}` was
  /// indented to close this code block or a surrounding context. See `expectRightBrace`.
  mutating func parseCodeBlock(introducer: RawTokenSyntax? = nil, allowInitDecl: Bool = true) -> RawCodeBlockSyntax {
    let (unexpectedBeforeLBrace, lbrace) = self.expect(.leftBrace)
    let itemList = parseCodeBlockItemList(allowInitDecl: allowInitDecl, until: { $0.at(.rightBrace) })
    let (unexpectedBeforeRBrace, rbrace) = self.expectRightBrace(leftBrace: lbrace, introducer: introducer)

    return .init(
      unexpectedBeforeLBrace,
      leftBrace: lbrace,
      statements: itemList,
      unexpectedBeforeRBrace,
      rightBrace: rbrace,
      arena: self.arena
    )
  }

  /// Parse an individual item - either in a code block or at the top level.
  ///
  /// Returns `nil` if the parser did not consume any tokens while trying to
  /// parse the code block item.
  ///
  /// Grammar
  /// =======
  ///
  ///     statement → expression ';'?
  ///     statement → declaration ';'?
  ///     statement → loop-statement ';'?
  ///     statement → branch-statement ';'?
  ///     statement → labeled-statement ';'?
  ///     statement → control-transfer-statement ';'?
  ///     statement → defer-statement ';'?
  ///     statement → do-statement ';'?
  ///     statement → compiler-control-statement
  ///     statements → statement statements?
  mutating func parseCodeBlockItem(isAtTopLevel: Bool, allowInitDecl: Bool) -> RawCodeBlockItemSyntax? {
    let startToken = self.currentToken
    if let syntax = self.loadCurrentSyntaxNodeFromCache(for: .codeBlockItem) {
      self.registerNodeForIncrementalParse(node: syntax.raw, startToken: startToken)
      return RawCodeBlockItemSyntax(syntax.raw)
    }

    if let remainingTokens = remainingTokensIfMaximumNestingLevelReached() {
      return RawCodeBlockItemSyntax(
        remainingTokens,
        item: .expr(RawExprSyntax(RawMissingExprSyntax(arena: self.arena))),
        semicolon: nil,
        arena: self.arena
      )
    }
    if self.at(.keyword(.case), .keyword(.default)) {
      // 'case' and 'default' are invalid in code block items.
      // Parse them and put them in their own CodeBlockItem but as an unexpected node.
      let switchCase = self.parseSwitchCase()
      return RawCodeBlockItemSyntax(
        RawUnexpectedNodesSyntax(elements: [RawSyntax(switchCase)], arena: self.arena),
        item: .expr(RawExprSyntax(RawMissingExprSyntax(arena: self.arena))),
        semicolon: nil,
        arena: self.arena
      )
    }

    // FIXME: It is unfortunate that the Swift book refers to these as
    // "statements" and not "items".
    let item = self.parseItem(isAtTopLevel: isAtTopLevel, allowInitDecl: allowInitDecl)
    let semi = self.consume(if: .semicolon)
    var trailingSemis: [RawTokenSyntax] = []
    while let trailingSemi = self.consume(if: .semicolon) {
      trailingSemis.append(trailingSemi)
    }

    if item.raw.isEmpty && semi == nil && trailingSemis.isEmpty {
      return nil
    }

    let result = RawCodeBlockItemSyntax(
      item: item,
      semicolon: semi,
      RawUnexpectedNodesSyntax(trailingSemis, arena: self.arena),
      arena: self.arena
    )

    self.registerNodeForIncrementalParse(node: result.raw, startToken: startToken)

    return result
  }

  private mutating func parseStatementItem() -> RawCodeBlockItemSyntax.Item {
    let stmt = self.parseStatement()

    // Special case: An 'if' or 'switch' statement followed by an 'as' must
    // be an if/switch expression in a coercion.
    // We could also achieve this by more eagerly attempting to parse an 'if'
    // or 'switch' as an expression when in statement position, but that
    // could result in less useful recovery behavior.
    if at(.keyword(.as)),
      let expr = stmt.as(RawExpressionStmtSyntax.self)?.expression
    {
      if expr.is(RawIfExprSyntax.self) || expr.is(RawSwitchExprSyntax.self) {
        let (op, rhs) = parseUnresolvedAsExpr(
          handle: .init(spec: .keyword(.as))
        )
        let sequence = RawExprSyntax(
          RawSequenceExprSyntax(
            elements: RawExprListSyntax(
              elements: [expr, op, rhs],
              arena: self.arena
            ),
            arena: self.arena
          )
        )
        return .expr(sequence)
      }
    }
    return .stmt(stmt)
  }

  /// `isAtTopLevel` determines whether this is trying to parse an item that's at
  /// the top level of the source file. If this is the case, we allow skipping
  /// closing braces while trying to recover to the next item.
  /// If we are not at the top level, such a closing brace should close the
  /// wrapping declaration instead of being consumed by lookeahead.
  private mutating func parseItem(isAtTopLevel: Bool = false, allowInitDecl: Bool = true) -> RawCodeBlockItemSyntax.Item {
    if self.at(.poundIfKeyword) && !self.withLookahead({ $0.consumeIfConfigOfAttributes() }) {
      // If config of attributes is parsed as part of declaration parsing as it
      // doesn't constitute its own code block item.
      let directive = self.parsePoundIfDirective { (parser, _) in
        parser.parseCodeBlockItem(isAtTopLevel: isAtTopLevel, allowInitDecl: allowInitDecl)
      } addSemicolonIfNeeded: { lastElement, newItemAtStartOfLine, parser in
        if lastElement.semicolon == nil && !newItemAtStartOfLine {
          return RawCodeBlockItemSyntax(
            lastElement.unexpectedBeforeItem,
            item: .init(lastElement.item)!,
            lastElement.unexpectedBetweenItemAndSemicolon,
            semicolon: parser.missingToken(.semicolon),
            lastElement.unexpectedAfterSemicolon,
            arena: parser.arena
          )
        } else {
          return nil
        }
      } syntax: { parser, items in
        return .statements(RawCodeBlockItemListSyntax(elements: items, arena: parser.arena))
      }
      return .decl(RawDeclSyntax(directive))
    } else if self.at(.poundSourceLocationKeyword) {
      return .decl(RawDeclSyntax(self.parsePoundSourceLocationDirective()))
    } else if self.atStartOfDeclaration(isAtTopLevel: isAtTopLevel, allowInitDecl: allowInitDecl) {
      return .decl(self.parseDeclaration())
    } else if self.atStartOfStatement() {
      return self.parseStatementItem()
    } else if self.atStartOfExpression() {
      return .expr(self.parseExpression())
    } else if self.atStartOfDeclaration(isAtTopLevel: isAtTopLevel, allowInitDecl: allowInitDecl, allowRecovery: true) {
      return .decl(self.parseDeclaration())
    } else if self.atStartOfStatement(allowRecovery: true) {
      return self.parseStatementItem()
    } else {
      return .expr(RawExprSyntax(RawMissingExprSyntax(arena: self.arena)))
    }
  }
}
