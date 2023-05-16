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
import SwiftBasicFormat

let buildableCollectionNodesFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  DeclSyntax("import SwiftSyntax")

  for node in SYNTAX_NODES.compactMap(\.collectionNode) {
    let elementType = node.collectionElementType

    let docComment = node.documentation.isEmpty ? [.docLineComment("/// `\(node.kind.syntaxType)` represents a collection of `\(elementType.syntaxBaseName)`")] : node.documentation
    // Generate collection node struct
    try! ExtensionDeclSyntax(
      """
      \(raw: docComment)
      extension \(raw: node.type.syntaxBaseName): ExpressibleByArrayLiteral
      """
    ) {
      // Generate initializers
      if elementType.isBaseType && node.elementChoices.count == 1 {
        DeclSyntax(
          """
          public init(_ elements: \(ArrayTypeSyntax(elementType: elementType.parameterType))) {
            self = \(raw: node.type.syntaxBaseName)(elements.map {
              \(elementType.syntax)(fromProtocol: $0)
            })
          }
          """
        )

        DeclSyntax(
          """
          public init(arrayLiteral elements: \(elementType.parameterType)...) {
            self.init(elements)
          }
          """
        )
      } else {
        DeclSyntax(
          """
          public init(arrayLiteral elements: Element...) {
            self.init(elements)
          }
          """
        )
      }
    }
  }
}
