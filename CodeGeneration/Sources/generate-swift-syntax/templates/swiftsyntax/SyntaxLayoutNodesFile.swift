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

let syntaxLayoutNodesFile = try! SourceFileSyntax(leadingTrivia: copyrightHeader) {
  for node in NON_BASE_SYNTAX_NODES {
    if node.layoutNode != nil {
      try! ExtensionDeclSyntax(
        "extension \(node.kind.syntaxType)"
      ) {
        DeclSyntax(
          """
          /// The layout of this node type.
          @_alwaysEmitIntoClient
          public static var layout: SyntaxLayout<Self> {
            SyntaxLayout<Self>(syntaxKind: .\(node.enumCaseCallName))
          }
          """
        )
      }
    }
  }

  try ExtensionDeclSyntax("extension AnySyntaxProperty") {
    try VariableDeclSyntax(
      """
      /// The name of the child at this position, as the node type's property for it is
      /// named, or `nil` if the kind is not a layout node or the position is out of range.
      @_spi(RawSyntax)
      public var name: String?
      """
    ) {
      try SwitchExprSyntax("switch (self.syntaxKind, self.index.value)") {
        for node in NON_BASE_SYNTAX_NODES {
          if let layoutNode = node.layoutNode {
            for (index, child) in layoutNode.children.enumerated() {
              SwitchCaseSyntax("case (.\(node.enumCaseCallName), \(literal: index)):") {
                StmtSyntax("return \(literal: child.identifier.description)")
              }
            }
          }
        }
        SwitchCaseSyntax("default: return nil")
      }
    }
  }
}
