//===------------------------ Directives.swift ----------------------------===//
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
  /// Parse a conditional compilation block.
  ///
  /// This function should be used to parse conditional compilation statements,
  /// declarations, and expressions. It is generic over the particular kind of
  /// parse that must occur for these elements, and allows a context-specific
  /// syntax kind to be emitted to collect the results. For example, declaration
  /// parsing parses items and collects the items into a `MemberDeclListSyntax`
  /// node.
  ///
  /// Grammar
  /// =======
  ///
  ///     conditional-compilation-block → if-directive-clause elseif-directive-clauses? else-directive-clause? endif-directive
  ///
  ///     if-directive-clause → if-directive compilation-condition statements?
  ///     elseif-directive-clauses → elseif-directive-clause elseif-directive-clauses?
  ///     elseif-directive-clause → elseif-directive compilation-condition statements?
  ///     else-directive-clause → else-directive statements?
  ///     if-directive → '#if'
  ///     elseif-directive → '#elseif'
  ///     else-directive → '#else'
  ///     endif-directive → '#endif'
  ///
  ///     compilation-condition → platform-condition
  ///     compilation-condition → identifier
  ///     compilation-condition → boolean-literal
  ///     compilation-condition → '(' compilation-condition ')'
  ///     compilation-condition → '!' compilation-condition
  ///     compilation-condition → compilation-condition '&&' compilation-condition
  ///     compilation-condition → compilation-condition '||' compilation-condition
  ///
  ///     platform-condition → 'os' '(' operating-system ')'
  ///     platform-condition → 'arch' '(' architecture ')'
  ///     platform-condition → 'swift' '(' '>=' swift-version ')' | 'swift' ( < swift-version )
  ///     platform-condition → 'compiler' '(' '>=' swift-version ')' | 'compiler' ( < swift-version )
  ///     platform-condition → 'canImport' '(' import-path ')'
  ///     platform-condition → 'targetEnvironment' '(' environment ')'
  ///
  ///     operating-system → 'macOS' | 'iOS' | 'watchOS' | 'tvOS' | 'Linux' | 'Windows'
  ///     architecture → 'i386' | 'x86_64' | 'arm' | 'arm64'
  ///     swift-version → decimal-digits swift-version-continuation?
  ///     swift-version-continuation → '.' decimal-digits swift-version-continuation?
  ///     environment → 'simulator' | 'macCatalyst'
  ///
  /// - Parameters:
  ///   - parseElement: Parse an element of the conditional compilation block.
  ///   - syntax: A function that aggregates the parsed conditional elements
  ///             into a syntax collection.
  @_spi(RawSyntax)
  public mutating func parsePoundIfDirective<Element>(
    _ parseElement: (inout Parser) -> Element?,
    syntax: (inout Parser, [Element]) -> RawSyntax
  ) -> RawIfConfigDeclSyntax {
    var clauses = [RawIfConfigClauseSyntax]()
    do {
      var (unexpectedBeforePoundIf, poundIf) = self.expect(.poundIfKeyword)
      var loopProgress = LoopProgressCondition()
      repeat {
        // Parse the condition.
        let condition: RawExprSyntax?
        if self.at(.poundElseKeyword) {
          unexpectedBeforePoundIf = nil
          poundIf = self.consumeAnyToken()
          condition = nil
        } else if self.at(.poundElseifKeyword)  {
          unexpectedBeforePoundIf = nil
          poundIf = self.consumeAnyToken()
          condition = RawExprSyntax(self.parseSequenceExpression(.basic, forDirective: true))
        } else {
          assert(poundIf.tokenKind == .poundIfKeyword)
          condition = RawExprSyntax(self.parseSequenceExpression(.basic, forDirective: true))
        }

        var elements = [Element]()
        do {
          var elementsProgress = LoopProgressCondition()
          while !self.at(any: [.eof, .poundElseKeyword, .poundElseifKeyword, .poundEndifKeyword])
                  && elementsProgress.evaluate(currentToken) {
            guard let element = parseElement(&self) else {
              break
            }
            elements.append(element)
          }
        }

        clauses.append(RawIfConfigClauseSyntax(
          unexpectedBeforePoundIf,
          poundKeyword: poundIf,
          condition: condition,
          elements: syntax(&self, elements),
          arena: self.arena))
      } while self.at(any: [.poundElseifKeyword, .poundElseKeyword]) && loopProgress.evaluate(currentToken)
    }

    let (unexpectedBeforePoundEndIf, poundEndIf) = self.expect(.poundEndifKeyword)
    return RawIfConfigDeclSyntax(
      clauses: RawIfConfigClauseListSyntax(elements: clauses, arena: self.arena),
      unexpectedBeforePoundEndIf,
      poundEndif: poundEndIf,
      arena: self.arena)
  }
}

extension Parser {
  /// Parse a #line literal.
  ///
  /// Grammar
  /// =======
  ///
  ///     literal-expression → '#line'
  @_spi(RawSyntax)
  public mutating func parsePoundLineDirective() -> RawPoundLineExprSyntax {
    let (unexpectedBeforeToken, token) = self.expect(.poundLineKeyword)
    return RawPoundLineExprSyntax(
      unexpectedBeforeToken,
      poundLine: token,
      arena: self.arena
    )
  }

  /// Parse a line control directive.
  ///
  /// Grammar
  /// =======
  ///
  ///     line-control-statement → '#sourceLocation' '(' 'file' ':' file-path ',' 'line' ':' line-number ')'
  ///     line-control-statement → '#sourceLocation' '(' ')'
  ///     line-number → `A decimal integer greater than zero`
  ///     file-path → static-string-literal
  @_spi(RawSyntax)
  public mutating func parsePoundSourceLocationDirective() -> RawPoundSourceLocationSyntax {
    let line = self.consumeAnyToken()
    let (unexpectedBeforeLParen, lparen) = self.expect(.leftParen)
    let args: RawPoundSourceLocationArgsSyntax?
    if !self.at(.rightParen) {
      let file = self.expectIdentifierWithoutRecovery()
      let (unexpectedBeforeFileColon, fileColon) = self.expect(.colon)
      let (unexpectedBeforeFileName, fileName) = self.expect(.stringLiteral)
      let (unexpectedBeforeComma, comma) = self.expect(.comma)

      let line = self.expectIdentifierWithoutRecovery()
      let (unexpectedBeforeLineColon, lineColon) = self.expect(.colon)
      let lineNumber = self.expectWithoutRecovery(.integerLiteral)

      args = RawPoundSourceLocationArgsSyntax(
        fileArgLabel: file,
        unexpectedBeforeFileColon,
        fileArgColon: fileColon,
        unexpectedBeforeFileName,
        fileName: fileName,
        unexpectedBeforeComma,
        comma: comma,
        lineArgLabel: line,
        unexpectedBeforeLineColon,
        lineArgColon: lineColon,
        lineNumber: lineNumber,
        arena: self.arena
      )
    } else {
      args = nil
    }
    let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
    return RawPoundSourceLocationSyntax(
      poundSourceLocation: line,
      unexpectedBeforeLParen,
      leftParen: lparen,
      args: args,
      unexpectedBeforeRParen,
      rightParen: rparen,
      arena: self.arena
    )
  }
}
