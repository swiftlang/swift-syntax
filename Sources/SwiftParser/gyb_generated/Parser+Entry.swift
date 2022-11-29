//// Automatically Generated From Entry.swift.gyb.
//// Do Not Edit Directly!
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
  /// Parse the source code in the given string as Swift source file. See
  /// `Parser.init` for more details.
  public static func parse(
    source: String,
    parseTransition: IncrementalParseTransition? = nil
  ) -> SourceFileSyntax {
    var parser = Parser(source)
    return SourceFileSyntax.parse(from: &parser)
  }

  /// Parse the source code in the given string as Swift source file. See
  /// `Parser.init` for more details.
  public static func parse(
    source: UnsafeBufferPointer<UInt8>,
    maximumNestingLevel: Int? = nil,
    parseTransition: IncrementalParseTransition? = nil
  ) -> SourceFileSyntax {
    var parser = Parser(source, maximumNestingLevel: maximumNestingLevel)
    return SourceFileSyntax.parse(from: &parser)
  }
}

public protocol SyntaxParseable: SyntaxProtocol {
  static func parse(from parser: inout Parser) -> Self
}

extension DeclSyntax: SyntaxParseable {
  public static func parse(from parser: inout Parser) -> Self {
    let node = parser.parseDeclaration()
    return parser.parseRemainder(into: node).syntax
  }
}

extension ExprSyntax: SyntaxParseable {
  public static func parse(from parser: inout Parser) -> Self {
    let node = parser.parseExpression()
    return parser.parseRemainder(into: node).syntax
  }
}

extension StmtSyntax: SyntaxParseable {
  public static func parse(from parser: inout Parser) -> Self {
    let node = parser.parseStatement()
    return parser.parseRemainder(into: node).syntax
  }
}

extension TypeSyntax: SyntaxParseable {
  public static func parse(from parser: inout Parser) -> Self {
    let node = parser.parseType()
    return parser.parseRemainder(into: node).syntax
  }
}

extension PatternSyntax: SyntaxParseable {
  public static func parse(from parser: inout Parser) -> Self {
    let node = parser.parsePattern()
    return parser.parseRemainder(into: node).syntax
  }
}

extension MemberDeclBlockSyntax: SyntaxParseable {
  public static func parse(from parser: inout Parser) -> Self {
    let node = parser.parseMemberDeclList()
    return parser.parseRemainder(into: node).syntax
  }
}

extension SourceFileSyntax: SyntaxParseable {
  public static func parse(from parser: inout Parser) -> Self {
    let node = parser.parseSourceFile()
    return parser.parseRemainder(into: node).syntax
  }
}

extension SwitchCaseSyntax: SyntaxParseable {
  public static func parse(from parser: inout Parser) -> Self {
    let node = parser.parseSwitchCase()
    return parser.parseRemainder(into: node).syntax
  }
}

extension CatchClauseSyntax: SyntaxParseable {
  public static func parse(from parser: inout Parser) -> Self {
    let node = parser.parseCatchClause()
    return parser.parseRemainder(into: node).syntax
  }
}

extension GenericParameterClauseSyntax: SyntaxParseable {
  public static func parse(from parser: inout Parser) -> Self {
    let node = parser.parseGenericParameters()
    return parser.parseRemainder(into: node).syntax
  }
}

fileprivate extension Parser {
  mutating func parseRemainder<R: RawSyntaxNodeProtocol>(into: R) -> R {
    guard !into.raw.kind.isSyntaxCollection, let layout = into.raw.layoutView else {
      assertionFailure("Only support parsing of non-collection layout nodes")
      return into
    }

    let remainingTokens = self.consumeRemainingTokens()
    if remainingTokens.isEmpty {
      return into
    }

    let unexpected = RawUnexpectedNodesSyntax(elements: remainingTokens, arena: self.arena)
    let withUnexpected = layout.replacingChild(at: layout.children.count - 1, with: unexpected.raw, arena: self.arena)
    return R.init(withUnexpected)!
  }
}
