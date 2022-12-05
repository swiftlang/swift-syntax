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
import SwiftBasicFormat

let buildableCollectionNodesFile = SourceFile {
  ImportDecl(
    leadingTrivia: .docLineComment(generateCopyrightHeader(for: "generate-swiftsyntaxbuilder")),
    path: [AccessPathComponent(name: "SwiftSyntax")]
  )

  for node in SYNTAX_NODES where node.isSyntaxCollection {
    let elementType = node.collectionElementType

    let docComment = node.documentation.isEmpty ? "" : "/// \(node.documentation)\n"
    // Generate collection node struct
    ExtensionDecl("\(docComment)extension \(node.type.shorthandName): ExpressibleByArrayLiteral") {
      // Generate initializers
      if elementType.isBaseType && node.collectionElementChoices?.isEmpty ?? true {
        InitializerDecl(
          """
          public init(_ elements: \(ArrayType(elementType: elementType.parameterType))) {
            self = \(raw: node.type.syntaxBaseName)(elements.map { \(elementType.syntax)(fromProtocol: $0) })
          }
          """
        )

        InitializerDecl(
          """
          public init(arrayLiteral elements: \(elementType.parameterType)...) {
            self.init(elements)
          }
          """
        )
      } else {
        InitializerDecl(
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
