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
  DeclSyntax(
    """
    #if swift(>=6)
    @_spi(ExperimentalLanguageFeatures) internal import SwiftSyntax
    #else
    @_spi(ExperimentalLanguageFeatures) import SwiftSyntax
    #endif
    """
  )

  try! FunctionDeclSyntax(
    "private func childNameForDiagnostics(_ keyPath: AnyKeyPath) -> String?"
  ) {
    try! SwitchExprSyntax("switch keyPath") {
      for node in NON_BASE_SYNTAX_NODES.compactMap(\.layoutNode) {
        for child in node.children {
          if let nameForDiagnostics = child.nameForDiagnostics {
            SwitchCaseSyntax("case \\\(node.type.syntaxBaseName).\(child.varOrCaseName):") {
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
    extension SyntaxProtocol {
      var childNameInParent: String? {
        guard let keyPath = self.keyPathInParent else {
          return nil
        }
        return childNameForDiagnostics(keyPath)
      }
    }
    """
  )

}
