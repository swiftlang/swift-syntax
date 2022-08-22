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
    let eof = self.eat(.eof)
    return .init(statements: items, eofToken: eof, arena: self.arena)
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
    while !self.at(.eof) {
      elements.append(self.parseCodeBlockItem())
    }
    return .init(elements: elements, arena: self.arena)
  }

  /// The optional form of `parseCodeBlock` that checks to see if the parser has
  /// encountered a left brace before proceeding.
  ///
  /// This function is used when parsing places where function bodies are
  /// optional - like the function requirements in protocol declarations.
  mutating func parseOptionalCodeBlock() -> RawCodeBlockSyntax? {
    guard self.at(.leftBrace) else {
      return nil
    }
    return self.parseCodeBlock()
  }

  /// Parse a code block.
  ///
  /// Grammar
  /// =======
  ///
  ///     code-block → '{' statements? '}'
  mutating func parseCodeBlock() -> RawCodeBlockSyntax {
    let (unexpectedBeforeLBrace, lbrace) = self.expect(.leftBrace)
    var items = [RawCodeBlockItemSyntax]()
    while !self.at(.eof) && !self.at(.rightBrace) {
      items.append(self.parseCodeBlockItem())
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

  /// Parse an individual item - either in a code block or at the top level.
  ///
  /// This function performs the majority of recovery because it
  /// is both the first and last opportunity the parser has to examine the
  /// input stream before encountering a closing delimiter or the end of input.
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
  public mutating func parseCodeBlockItem() -> RawCodeBlockItemSyntax {
    // FIXME: It is unfortunate that the Swift book refers to these as
    // "statements" and not "items".
    if let recovery = self.recoverFromBadItem() {
      return recovery
    }

    let item = self.parseItem()
    let semi = self.consume(if: .semicolon)

    let errorTokens: RawSyntax?
    if item.is(RawMissingExprSyntax.self) || item.is(RawMissingStmtSyntax.self) {
      var elements = [RawTokenSyntax]()
      if self.at(.atSign) {
        // Recover from erroneously placed attribute.
        elements.append(self.eat(.atSign))
        if self.currentToken.isIdentifier {
          elements.append(self.consumeAnyToken())
        }
      }

      while
        !self.at(.eof),
        !self.at(.rightBrace),
        !self.at(.poundIfKeyword), !self.at(.poundElseKeyword),
        !self.at(.poundElseifKeyword),
        !self.lookahead().isStartOfStatement(),
        !self.lookahead().isStartOfDeclaration()
      {
        let tokens = self.recover()
        guard !tokens.isEmpty else {
          break
        }
        elements.append(contentsOf: tokens)
      }
      errorTokens = RawSyntax(RawNonEmptyTokenListSyntax(elements: elements, arena: self.arena))
    } else {
      errorTokens = nil
    }
    return .init(item: item, semicolon: semi, errorTokens: errorTokens, arena: self.arena)
  }

  private mutating func parseItem() -> RawSyntax {
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
    } else if self.lookahead().isStartOfDeclaration() {
      return RawSyntax(self.parseDeclaration())
    } else if self.lookahead().isStartOfStatement() {
      return RawSyntax(self.parseStatement())
    } else {
      return RawSyntax(self.parseExpression())
    }
  }
}
