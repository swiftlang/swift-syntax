//===----------------------------------------------------------------------===//
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
    if nestingLevel > self.maximumNestingLevel && self.currentToken.tokenKind != .eof {
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
  @_spi(RawSyntax)
  public mutating func parseSourceFile() -> RawSourceFileSyntax {
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
  mutating func parseCodeBlockItemList(isAtTopLevel: Bool, allowInitDecl: Bool = true, stopCondition: (inout Parser) -> Bool) -> RawCodeBlockItemListSyntax {
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
          semicolon: self.missingToken(.semicolon, text: nil),
          lastItem.unexpectedBetweenSemicolonAndErrorTokens,
          errorTokens: lastItem.errorTokens,
          lastItem.unexpectedAfterErrorTokens,
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
    return parseCodeBlockItemList(isAtTopLevel: true, stopCondition: { _ in false })
  }

  /// The optional form of `parseCodeBlock` that checks to see if the parser has
  /// encountered a left brace before proceeding.
  ///
  /// This function is used when parsing places where function bodies are
  /// optional - like the function requirements in protocol declarations.
  mutating func parseOptionalCodeBlock(allowInitDecl: Bool = true) -> RawCodeBlockSyntax? {
    guard self.at(.leftBrace) else {
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
    let itemList = parseCodeBlockItemList(isAtTopLevel: false, allowInitDecl: allowInitDecl, stopCondition: { $0.at(.rightBrace) })
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
  @_spi(RawSyntax)
  public mutating func parseCodeBlockItem(isAtTopLevel: Bool = false, allowInitDecl: Bool = true) -> RawCodeBlockItemSyntax? {
    if let remainingTokens = remainingTokensIfMaximumNestingLevelReached() {
      return RawCodeBlockItemSyntax(
        remainingTokens,
        item: .expr(RawExprSyntax(RawMissingExprSyntax(arena: self.arena))),
        semicolon: nil,
        errorTokens: nil,
        arena: self.arena
      )
    }
    if self.at(any: [.caseKeyword, .defaultKeyword]) {
      // 'case' and 'default' are invalid in code block items.
      // Parse them and put them in their own CodeBlockItem but as an unexpected node.
      let switchCase = self.parseSwitchCase()
      return RawCodeBlockItemSyntax(
        RawUnexpectedNodesSyntax(elements: [RawSyntax(switchCase)], arena: self.arena),
        item: .expr(RawExprSyntax(RawMissingExprSyntax(arena: self.arena))),
        semicolon: nil,
        errorTokens: nil,
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
    return RawCodeBlockItemSyntax(
      item: item,
      semicolon: semi,
      RawUnexpectedNodesSyntax(trailingSemis, arena: self.arena),
      errorTokens: nil,
      arena: self.arena
    )
  }

  /// `isAtTopLevel` determines whether this is trying to parse an item that's at
  /// the top level of the source file. If this is the case, we allow skipping
  /// closing braces while trying to recover to the next item.
  /// If we are not at the top level, such a closing brace should close the
  /// wrapping declaration instead of being consumed by lookeahead.
  private mutating func parseItem(isAtTopLevel: Bool = false, allowInitDecl: Bool = true) -> RawCodeBlockItemSyntax.Item {
    if self.at(.poundIfKeyword) {
      let directive = self.parsePoundIfDirective { (parser, _) in
        parser.parseCodeBlockItem()
      } addSemicolonIfNeeded: { lastElement, newItemAtStartOfLine, parser in
        if lastElement.semicolon == nil && !newItemAtStartOfLine {
          return RawCodeBlockItemSyntax(
            lastElement.unexpectedBeforeItem,
            item: .init(lastElement.item)!,
            lastElement.unexpectedBetweenItemAndSemicolon,
            semicolon: parser.missingToken(.semicolon, text: nil),
            lastElement.unexpectedBetweenSemicolonAndErrorTokens,
            errorTokens: lastElement.errorTokens,
            lastElement.unexpectedAfterErrorTokens,
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
    } else if self.atStartOfDeclaration(allowInitDecl: allowInitDecl) {
      return .decl(self.parseDeclaration())
    } else if self.atStartOfStatement() {
      return .stmt(self.parseStatement())
    } else if self.atStartOfExpression() {
      return .expr(self.parseExpression())
    } else if self.atStartOfDeclaration(isAtTopLevel: isAtTopLevel, allowInitDecl: allowInitDecl, allowRecovery: true) {
      return .decl(self.parseDeclaration())
    } else if self.atStartOfStatement(allowRecovery: true) {
      return .stmt(self.parseStatement())
    } else {
      return .expr(RawExprSyntax(RawMissingExprSyntax(arena: self.arena)))
    }
  }
}
