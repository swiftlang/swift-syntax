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

let concreteSyntaxPropertyFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  DeclSyntax(
    """
    extension ConcreteSyntaxProperty {
      fileprivate init(index: UInt32) {
        self.index = .init(index)
      }
    }
    """
  )

  for node in NON_BASE_SYNTAX_NODES {
    if let layoutNode = node.layoutNode {
      try! ExtensionDeclSyntax(
        "\(node.apiAttributes())extension ConcreteSyntaxProperty where Base == \(node.kind.syntaxType)"
      ) {
        for (index, child) in layoutNode.children.enumerated() {
          let childType: TypeSyntax =
            child.kind.isNodeChoicesEmpty
            ? child.syntaxNodeKind.syntaxType
            : "\(node.kind.syntaxType).\(child.syntaxChoicesType)"
          let type = child.isOptional ? TypeSyntax("\(childType)?") : TypeSyntax("\(childType)")
          DeclSyntax(
            """
            public static var \(child.varDeclName): ConcreteSyntaxProperty<\(node.kind.syntaxType), \(type)> {
              .init(index: \(raw: index))
            }
            """
          )
        }
      }
    }
  }
}
