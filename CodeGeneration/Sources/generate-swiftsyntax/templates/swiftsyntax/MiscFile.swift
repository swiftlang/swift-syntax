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

let miscFile = SourceFileSyntax {
  try! ExtensionDeclSyntax(
    """
    \(raw: generateCopyrightHeader(for: "generate-swiftsyntax"))
    extension Syntax
    """
  ) {
    try VariableDeclSyntax("public static var structure: SyntaxNodeStructure") {
      let choices = ArrayExprSyntax {
        ArrayElementSyntax(
          leadingTrivia: .newline,
          expression: ExprSyntax(".node(TokenSyntax.self)")
        )

        for node in NON_BASE_SYNTAX_NODES {
          ArrayElementSyntax(
            leadingTrivia: .newline,
            expression: ExprSyntax(".node(\(raw: node.name).self)")
          )
        }
      }

      StmtSyntax("return .choices(\(choices))")
    }
  }

  try! ExtensionDeclSyntax("extension SyntaxKind") {
    try VariableDeclSyntax("public var syntaxNodeType: SyntaxProtocol.Type") {
      try SwitchExprSyntax("switch self") {
        SwitchCaseSyntax("case .token:") {
          StmtSyntax("return TokenSyntax.self")
        }

        for node in NON_BASE_SYNTAX_NODES {
          SwitchCaseSyntax("case .\(raw: node.swiftSyntaxKind):") {
            StmtSyntax("return \(raw: node.name).self")
          }
        }
      }
    }

    try VariableDeclSyntax("public var nameForDiagnostics: String?") {
      try SwitchExprSyntax("switch self") {
        SwitchCaseSyntax("case .token:") {
          StmtSyntax(#"return "token""#)
        }

        for node in NON_BASE_SYNTAX_NODES {
          SwitchCaseSyntax("case .\(raw: node.swiftSyntaxKind):") {
            if let nameForDiagnostics = node.nameForDiagnostics {
              StmtSyntax("return \"\(raw: nameForDiagnostics)\"")
            } else {
              StmtSyntax("return nil")
            }
          }
        }
      }
    }
  }
}
