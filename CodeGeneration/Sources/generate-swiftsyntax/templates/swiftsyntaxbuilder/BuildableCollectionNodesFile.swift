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

  for node in SYNTAX_NODES where node.isSyntaxCollection {
    let elementType = node.collectionElementType

    let docComment = node.documentation.isEmpty ? "" : "/// \(node.documentation)\n"
    // Generate collection node struct
    try! ExtensionDeclSyntax("\(raw: docComment)extension \(raw: node.type.syntaxBaseName): ExpressibleByArrayLiteral") {
      // Generate initializers
      if elementType.isBaseType && node.collectionElementChoices?.isEmpty ?? true {
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
