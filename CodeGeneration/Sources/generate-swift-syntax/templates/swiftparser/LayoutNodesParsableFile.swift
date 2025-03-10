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

import SwiftSyntax
import SwiftSyntaxBuilder
import SyntaxSupport
import Utils

let layoutNodesParsableFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  importSwiftSyntax(accessLevel: .public)

  DeclSyntax(
    """
    public protocol SyntaxParseable: SyntaxProtocol {
      static func parse(from parser: inout Parser) -> Self
    }
    """
  )
  DeclSyntax(
    """
    extension SyntaxParseable {
      fileprivate static func parse(
        from parser: inout Parser,
        parse: (_ parser: inout Parser) -> some RawSyntaxNodeProtocol
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
        let raw = RawSyntax(parser.parseRemainder(into: node))
        return Syntax(raw: raw, rawNodeArena: raw.arena).cast(Self.self)
      }
    }
    """
  )

  for node in SYNTAX_NODES {
    if let parserFunction = node.parserFunction {
      DeclSyntax(
        """
        extension \(node.kind.syntaxType): SyntaxParseable {
          public static func parse(from parser: inout Parser) -> Self {
            parse(from: &parser) { $0.\(parserFunction)() }
          }
        }
        """
      )
    }
  }

  try! ExtensionDeclSyntax("fileprivate extension Parser") {
    DeclSyntax(
      """
      mutating func parseNonOptionalCodeBlockItem() -> RawCodeBlockItemSyntax {
        guard let node = self.parseCodeBlockItem(isAtTopLevel: false, allowInitDecl: true) else {
          // The missing item is not necessary to be a declaration,
          // which is just a placeholder here
          return RawCodeBlockItemSyntax(
            item: .init(
              decl: RawMissingDeclSyntax(
                attributes: self.emptyCollection(RawAttributeListSyntax.self),
                modifiers: self.emptyCollection(RawDeclModifierListSyntax.self),
                arena: self.arena
              )
            ),
            semicolon: nil,
            arena: self.arena
          )
        }
        return node
      }
      """
    )

    DeclSyntax(
      """
      mutating func parseExpression() -> RawExprSyntax {
        return self.parseExpression(flavor: .basic, pattern: .none)
      }
      """
    )
  }
}
