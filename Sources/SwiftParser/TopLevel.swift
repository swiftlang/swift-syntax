//===------------------------- TopLevel.swift -----------------------------===//
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
    var extraneousTokens = [RawSyntax]()
    while !self.at(.eof) {
      extraneousTokens.append(RawSyntax(consumeAnyToken()))
    }
    let unexpectedBeforeEof = extraneousTokens.isEmpty ? nil : RawUnexpectedNodesSyntax(elements: extraneousTokens, arena: self.arena)
    let eof = self.consume(if: .eof)!
    return .init(statements: items, unexpectedBeforeEof, eofToken: eof, arena: self.arena)
  }
}

extension Parser {
  /// Parse the top level items in a source file.
  ///
  /// Grammar
  /// =======
  ///
  ///     top-level-declaration → statements?
  mutating func parseTopLevelCodeBlockItems() -> RawCodeBlockItemListSyntax {
    var elements = [RawCodeBlockItemSyntax]()
    var loopProgress = LoopProgressCondition()
    while
      let newElement = self.parseCodeBlockItem(context: .topLevel),
      loopProgress.evaluate(currentToken)
    {
      elements.append(newElement)
    }
    return .init(elements: elements, arena: self.arena)
  }

  /// The optional form of `parseCodeBlock` that checks to see if the parser has
  /// encountered a left brace before proceeding.
  ///
  /// This function is used when parsing places where function bodies are
  /// optional - like the function requirements in protocol declarations.
  mutating func parseOptionalCodeBlock(context: ItemContext? = nil) -> RawCodeBlockSyntax? {
    guard self.at(.leftBrace) else {
      return nil
    }
    return self.parseCodeBlock(context: context)
  }

  /// Parse a code block.
  ///
  /// Grammar
  /// =======
  ///
  ///     code-block → '{' statements? '}'
  mutating func parseCodeBlock(context: ItemContext? = nil) -> RawCodeBlockSyntax {
    let (unexpectedBeforeLBrace, lbrace) = self.expect(.leftBrace)
    var items = [RawCodeBlockItemSyntax]()
    var loopProgress = LoopProgressCondition()
    while
      !self.at(.rightBrace),
      let newItem = self.parseCodeBlockItem(context: context),
      loopProgress.evaluate(currentToken)
    {
      items.append(newItem)
    }
    let (unexpectedBeforeRBrace, rbrace) = self.expect(.rightBrace)

    let itemList: RawCodeBlockItemListSyntax
    if items.isEmpty && (lbrace.isMissing || rbrace.isMissing) {
      itemList = .init(elements: [], arena: self.arena)
    } else {
      itemList = .init(elements: items, arena: self.arena)
    }
    return .init(
      unexpectedBeforeLBrace,
      leftBrace: lbrace,
      statements: itemList,
      unexpectedBeforeRBrace,
      rightBrace: rbrace,
      arena: self.arena)
  }
}

extension Parser {
  public enum ItemContext {
    case topLevel
    // Enables the 'yield' contextual keyword in statement position.
    case coroutineAccessor
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
  public mutating func parseCodeBlockItem(context: ItemContext? = nil) -> RawCodeBlockItemSyntax? {
    // FIXME: It is unfortunate that the Swift book refers to these as
    // "statements" and not "items".
    let item = self.parseItem(context: context)
    let semi = self.consume(if: .semicolon)

    if item.isEmpty && semi == nil {
      return nil
    }
    return .init(item: item, semicolon: semi, errorTokens: nil, arena: self.arena)
  }

  /// `isAtTopLevel` determines whether this is trying to parse an item that's at
  /// the top level of the source file. If this is the case, we allow skipping
  /// closing braces while trying to recover to the next item.
  /// If we are not at the top level, such a closing brace should close the
  /// wrapping declaration instead of being consumed by lookeahead.
  private mutating func parseItem(context: ItemContext? = nil) -> RawSyntax {
    if self.at(.poundIfKeyword) {
      return RawSyntax(self.parsePoundIfDirective {
        $0.parseCodeBlockItem()
      } syntax: { parser, items  in
        return RawSyntax(RawCodeBlockItemListSyntax(elements: items, arena: parser.arena))
      })
    } else if self.at(.poundLineKeyword) {
      return RawSyntax(self.parsePoundLineDirective())
    } else if self.at(.poundSourceLocationKeyword) {
      return RawSyntax(self.parsePoundSourceLocationDirective())
    } else if self.atStartOfDeclaration() {
      return RawSyntax(self.parseDeclaration())
    } else if self.atStartOfStatement(context: context) {
      return RawSyntax(self.parseStatement())
    } else if self.atStartOfExpression() {
      return RawSyntax(self.parseExpression())
    } else if self.atStartOfDeclaration(context: context, allowRecovery: true) {
      return RawSyntax(self.parseDeclaration())
    } else {
      return RawSyntax(RawMissingExprSyntax(arena: self.arena))
    }
  }
}
