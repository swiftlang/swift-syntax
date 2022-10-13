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

import SwiftSyntax
import SwiftSyntaxBuilder
import SyntaxSupport
import Utils

let parserEntryFile = SourceFile {
  ImportDecl(
    """
    \(raw: generateCopyrightHeader(for: "generate-swiftparser"))
    @_spi(RawSyntax) import SwiftSyntax
    
    """
  )
  
  ExtensionDecl("extension Parser") {
    FunctionDecl("""
    /// Parse the source code in the given string as Swift source file. See
    /// `Parser.init` for more details.
    public static func parse(
      source: String,
      parseTransition: IncrementalParseTransition? = nil
    ) -> SourceFileSyntax {
      var parser = Parser(source)
      return SourceFileSyntax.parse(from: &parser)
    }
    """)
    
    FunctionDecl("""
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
    """)
  }
  
  ProtocolDecl("""
    public protocol SyntaxParseable: SyntaxProtocol {
      static func parse(from parser: inout Parser) -> Self
    }
    """)
  


  for node in SYNTAX_NODES {
    if let parserFunction = node.parserFunction {
      ExtensionDecl("""
        extension \(raw: node.name): SyntaxParseable {
          public static func parse(from parser: inout Parser) -> Self {
            let node = parser.\(raw: parserFunction)()
            let raw = RawSyntax(parser.parseRemainder(into: node))
            return Syntax(raw: raw).cast(Self.self)
          }
        }
        """)
    }
  }

  ExtensionDecl("fileprivate extension Parser") {
    FunctionDecl("""
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
      """)
  }
}
