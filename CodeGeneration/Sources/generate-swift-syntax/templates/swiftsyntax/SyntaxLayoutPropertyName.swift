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

let syntaxLayoutPropertyNameFile = try! SourceFileSyntax(leadingTrivia: copyrightHeader) {
  try ExtensionDeclSyntax("extension SyntaxLayoutProperty") {
    try VariableDeclSyntax(
      """
      /// Property name if this is a valid property.
      /// 'nil' if the `syntaxKind` is not a layout syntax, or the index is out of range.
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
