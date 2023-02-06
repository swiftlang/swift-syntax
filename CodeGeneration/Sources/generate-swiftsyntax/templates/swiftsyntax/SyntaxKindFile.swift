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

let syntaxKindFile = SourceFileSyntax(leadingTrivia: .docLineComment(generateCopyrightHeader(for: "generate-swiftsyntax"))) {
  try! EnumDeclSyntax(
    """
    /// Enumerates the known kinds of Syntax represented in the Syntax tree.
    @frozen // FIXME: Not actually stable, works around a miscompile
    public enum SyntaxKind
    """
  ) {
    DeclSyntax("case token")
    for node in NON_BASE_SYNTAX_NODES {
      DeclSyntax("case \(raw: node.swiftSyntaxKind)")
    }

    try VariableDeclSyntax("public var isSyntaxCollection: Bool") {
      try SwitchExprSyntax("switch self") {
        for node in SYNTAX_NODES where node.baseKind == "SyntaxCollection" {
          SwitchCaseSyntax("case .\(raw: node.swiftSyntaxKind):") {
            StmtSyntax("return true")
          }
        }

        SwitchCaseSyntax("default:") {
          StmtSyntax("return false")
        }
      }
    }

    try VariableDeclSyntax("public var isMissing: Bool") {
      try SwitchExprSyntax("switch self") {
        for name in SYNTAX_BASE_KINDS where !["Syntax", "SyntaxCollection"].contains(name) {
          SwitchCaseSyntax("case .missing\(raw: name):") {
            StmtSyntax("return true")
          }
        }

        SwitchCaseSyntax("default:") {
          StmtSyntax("return false")
        }
      }
    }
  }
}
