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

let syntaxPropertyFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  DeclSyntax(
    """
    extension SyntaxProperty {
      fileprivate init(index: UInt32) {
        self.index = .init(index)
      }
    }
    """
  )

  for node in NON_BASE_SYNTAX_NODES {
    if let layoutNode = node.layoutNode {
      // One extension per child type, so that `Value` is known from the node type and the
      // property name.
      let children = layoutNode.children.enumerated().map { (index, child) in
        let childType: TypeSyntax =
          child.kind.isNodeChoicesEmpty
          ? child.syntaxNodeKind.syntaxType
          : "\(node.kind.syntaxType).\(child.syntaxChoicesType)"
        let type = child.isOptional ? TypeSyntax("\(childType)?") : TypeSyntax("\(childType)")
        return (index: index, child: child, type: type, key: "\(child.apiAttributes)\(type)")
      }
      let keys = children.map(\.key).reduce(into: [String]()) { keys, key in
        if !keys.contains(key) { keys.append(key) }
      }
      for key in keys {
        let group = children.filter { $0.key == key }
        try! ExtensionDeclSyntax(
          "\(node.apiAttributes())\(group[0].child.apiAttributes)extension SyntaxProperty<\(node.kind.syntaxType), \(group[0].type)>"
        ) {
          for entry in group {
            DeclSyntax(
              """
              public static var \(entry.child.varDeclName): Self {
                .init(index: \(raw: entry.index))
              }
              """
            )
          }
        }
      }
    }
  }
}
