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

#if swift(>=6)
@_spi(RawSyntax) public import SwiftSyntax
#else
@_spi(RawSyntax) import SwiftSyntax
#endif

fileprivate extension SyntaxCollection {
  static func parse(
    from parser: inout Parser,
    parse: (_ parser: inout Parser) -> some RawSyntaxNodeProtocol,
    makeMissing: (_ remainingTokens: [RawSyntax], _ arena: SyntaxArena) -> some RawSyntaxNodeProtocol
  ) -> Self {
    // Keep the parser alive so that the arena in which `raw` is allocated
    // doesn’t get deallocated before we have a chance to create a syntax node
    // from it. We can’t use `parser.arena` as the parameter to
    // `Syntax(raw:arena:)` because the node might have been re-used during an
    // incremental parse and would then live in a different arena than
    // `parser.arena`.
    defer {
      withExtendedLifetime(parser) {
      }
    }
    let node = parse(&parser)

    if parser.at(.endOfFile) {
      return Syntax(raw: node.raw, rawNodeArena: parser.arena).cast(Self.self)
    }

    let layoutView = node.raw.layoutView!

    if layoutView.children.isEmpty {
      let remainingTokens = parser.consumeRemainingTokens()
      assert(!remainingTokens.isEmpty)
      let missing = makeMissing(remainingTokens, parser.arena)
      let raw = layoutView.insertingChild(missing.raw, at: node.raw.layoutView!.children.count, arena: parser.arena)
      return Syntax(raw: raw, rawNodeArena: parser.arena).cast(Self.self)
    } else {
      // First unwrap: We know that children.last exists because children is not empty
      // Second unwrap: This is a collection and collections never have optional children. Thus the last child can’t be nil.
      let lastWithRemainder = parser.parseRemainder(into: layoutView.children[layoutView.children.count - 1]!)
      let raw = layoutView.replacingChild(at: layoutView.children.count - 1, with: lastWithRemainder, arena: parser.arena)
      return Syntax(raw: raw, rawNodeArena: parser.arena).cast(Self.self)
    }
  }
}

extension AccessorDeclListSyntax: SyntaxParseable {
  public static func parse(from parser: inout Parser) -> Self {
    return parse(from: &parser) { parser in
      return parser.parseAccessorList() ?? RawAccessorDeclListSyntax(elements: [], arena: parser.arena)
    } makeMissing: { remainingTokens, arena in
      return RawAccessorDeclSyntax(
        attributes: RawAttributeListSyntax(elements: [], arena: arena),
        modifier: nil,
        accessorSpecifier: RawTokenSyntax(missing: .keyword, text: "get", arena: arena),
        parameters: nil,
        effectSpecifiers: nil,
        body: nil,
        arena: arena
      )
    }
  }
}

extension AttributeListSyntax: SyntaxParseable {
  public static func parse(from parser: inout Parser) -> Self {
    return parse(from: &parser) { parser in
      return RawSyntax(parser.parseAttributeList())
    } makeMissing: { remainingTokens, arena in
      return RawAttributeSyntax(
        atSign: RawTokenSyntax(missing: .atSign, arena: arena),
        attributeName: RawTypeSyntax(RawMissingTypeSyntax(arena: arena)),
        leftParen: nil,
        arguments: nil,
        rightParen: nil,
        arena: arena
      )
    }
  }
}

extension CodeBlockItemListSyntax: SyntaxParseable {
  public static func parse(from parser: inout Parser) -> Self {
    return parse(from: &parser) { parser in
      let node = parser.parseCodeBlockItemList(until: { _ in false })
      return RawSyntax(node)
    } makeMissing: { remainingTokens, arena in
      let missingExpr = RawMissingExprSyntax(arena: arena)
      return RawCodeBlockItemSyntax(item: .expr(RawExprSyntax(missingExpr)), semicolon: nil, arena: arena)
    }
  }
}

extension MemberBlockItemListSyntax: SyntaxParseable {
  public static func parse(from parser: inout Parser) -> Self {
    return parse(from: &parser) { parser in
      return RawSyntax(parser.parseMemberDeclList())
    } makeMissing: { remainingTokens, arena in
      let missingDecl = RawMissingDeclSyntax(
        attributes: RawAttributeListSyntax(elements: [], arena: arena),
        modifiers: RawDeclModifierListSyntax(elements: [], arena: arena),
        placeholder: RawTokenSyntax(missing: .identifier, text: "<#declaration#>", arena: arena),
        RawUnexpectedNodesSyntax(remainingTokens, arena: arena),
        arena: arena
      )
      return RawMemberBlockItemSyntax(decl: RawDeclSyntax(missingDecl), semicolon: nil, arena: arena)
    }
  }
}

//==========================================================================//
// IMPORTANT: When adding a new conformance, also add a corrsponding        //
// conformance to SyntaxExpressibleByStringInterpolation in                 //
// SyntaxExpressibleByStringInterpolationConformances.swift                 //
//==========================================================================//

//==========================================================================//
// IMPORTANT: If you are tempted to add a new conformances here please      //
// insert in in alphabetical order above                                    //
//==========================================================================//
