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

let syntaxCollectionsFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  for node in SYNTAX_NODES.compactMap(\.collectionNode) {
    let documentation = SwiftSyntax.Trivia(joining: [
      node.documentation,
      node.experimentalDocNote,
      node.grammar,
      node.containedIn,
    ])

    try! StructDeclSyntax(
      """
      \(documentation)\
      \(node.node.apiAttributes())\
      public struct \(node.kind.syntaxType): SyntaxCollection, SyntaxHashable
      """
    ) {
      if let onlyElement = node.elementChoices.only {
        DeclSyntax("public typealias Element = \(onlyElement.syntaxType)")
      } else {
        for childNodeChoices in node.node.childrenNodeChoices() {
          childNodeChoices.enumDecl
        }
      }

      DeclSyntax("public let _syntaxNode: Syntax")

      DeclSyntax(
        """
        public init?(_ node: some SyntaxProtocol) {
          guard node.raw.kind == .\(node.memberCallName) else { return nil }
          self._syntaxNode = node._syntaxNode
        }
        """
      )

      DeclSyntax(
        """
        @_transparent
        init(unsafeCasting node: Syntax) {
          self._syntaxNode = node
        }
        """
      )

      DeclSyntax("public static var syntaxKind: SyntaxKind { .\(node.enumCaseCallName) }")
    }
  }
}
