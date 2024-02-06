//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2023 - 2024 Apple Inc. and the Swift project authors
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

let syntaxKindNameForDiagnosticFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  DeclSyntax("@_spi(ExperimentalLanguageFeatures) import SwiftSyntax")

  try! ExtensionDeclSyntax("extension SyntaxKind") {
    try VariableDeclSyntax("var nameForDiagnostics: String?") {
      try SwitchExprSyntax("switch self") {
        SwitchCaseSyntax("case .token:") {
          StmtSyntax(#"return "token""#)
        }

        for node in NON_BASE_SYNTAX_NODES {
          if let nameForDiagnostics = node.nameForDiagnostics {
            SwitchCaseSyntax("case .\(node.varOrCaseName):") {
              StmtSyntax("return \(literal: nameForDiagnostics)")
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
  }
}
