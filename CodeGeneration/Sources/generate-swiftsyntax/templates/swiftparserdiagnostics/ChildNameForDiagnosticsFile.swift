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

let childNameForDiagnosticFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  DeclSyntax("import SwiftSyntax")

  try! FunctionDeclSyntax(
    "private func childNameForDiagnostics(_ keyPath: AnyKeyPath) -> String?"
  ) {
    try! SwitchExprSyntax("switch keyPath") {
      for node in NON_BASE_SYNTAX_NODES where !node.isSyntaxCollection {
        for child in node.children {
          if let nameForDiagnostics = child.nameForDiagnostics {
            SwitchCaseSyntax("case \\\(raw: node.type.syntaxBaseName).\(raw: child.swiftName):") {
              StmtSyntax(#"return "\#(raw: nameForDiagnostics)""#)
            }
          }
        }
      }
      SwitchCaseSyntax(
        """
        default:
          return nil
        """
      )
    }
  }

  DeclSyntax(
    """
    private func getKeyPath<T: SyntaxProtocol>(_ node: T) -> AnyKeyPath? {
      guard let parent = node.parent else {
        return nil
      }
      guard case .layout(let childrenKeyPaths) = parent.kind.syntaxNodeType.structure else {
        return nil
      }
      return childrenKeyPaths[node.indexInParent]
    }
    """
  )

  DeclSyntax(
    """
    extension SyntaxProtocol {
      var childNameInParent: String? {
        guard let keyPath = getKeyPath(self) else {
          return nil
        }
        return childNameForDiagnostics(keyPath)
      }
    }
    """
  )

}
