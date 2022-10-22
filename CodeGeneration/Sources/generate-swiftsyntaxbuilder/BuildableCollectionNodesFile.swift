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

import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder
import SyntaxSupport
import Utils
import SwiftBasicFormat

let buildableCollectionNodesFile = SourceFile {
  ImportDecl(
    leadingTrivia: .docLineComment(copyrightHeader),
    path: "SwiftSyntax"
  )

  for node in SYNTAX_NODES where node.isSyntaxCollection {
    let elementType = node.collectionElementType

    // Generate collection node struct
    ExtensionDecl(
      leadingTrivia: node.documentation.isEmpty
        ? []
        : .docLineComment("/// \(node.documentation)") + .newline,
      extendedType: node.type.shorthandName,
      inheritanceClause: TypeInheritanceClause { InheritedType(typeName: "ExpressibleByArrayLiteral") }
    ) {
      // Generate initializers
      if elementType.isBaseType {
        InitializerDecl(
          """
          /// Creates a `\(node.type.shorthandName)` with the provided list of elements.
          /// - Parameters:
          ///   - elements: A list of `\(elementType.parameterType)`
          public init(_ elements: \(ArrayType(elementType: elementType.parameterType))) {
            self = \(node.type.syntaxBaseName)(elements.map { \(elementType.syntax)(fromProtocol: $0) })
          }
          """
        )
      }
      InitializerDecl(
        """
        public init(arrayLiteral elements: \(elementType.parameterType)...) {
          self.init(elements)
        }
        """
      )
    }
  }
}
