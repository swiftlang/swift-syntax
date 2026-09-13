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

let syntaxKindFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  try! EnumDeclSyntax(
    """
    /// Enumerates the known kinds of Syntax represented in the Syntax tree.
    public enum SyntaxKind: Sendable
    """
  ) {
    DeclSyntax("case token")
    for node in NON_BASE_SYNTAX_NODES {
      DeclSyntax(
        """
        \(node.apiAttributes())\
        case \(node.enumCaseDeclName)
        """
      )
    }

    try VariableDeclSyntax("public var isSyntaxCollection: Bool") {
      try SwitchExprSyntax("switch self") {
        for node in SYNTAX_NODES where node.base == .syntaxCollection {
          SwitchCaseSyntax("case .\(node.enumCaseCallName):") {
            StmtSyntax("return true")
          }
        }

        SwitchCaseSyntax("default:") {
          StmtSyntax("return false")
        }
      }
    }

    try VariableDeclSyntax(
      """
      /// Whether a node of this kind lays its children out with an `unexpected`
      /// slot before the first, between every pair and after the last, so that
      /// its layout holds `2 * n + 1` slots for `n` children.
      ///
      /// False for collections, whose children are all elements, and for the
      /// few layout nodes that opt out of interleaving.
      @_spi(RawSyntax)
      public var interleavesUnexpectedChildren: Bool
      """
    ) {
      try SwitchExprSyntax("switch self") {
        for node in NON_BASE_SYNTAX_NODES where node.interleavesUnexpectedChildren {
          SwitchCaseSyntax("case .\(node.enumCaseCallName):") {
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
        for name in SyntaxNodeKind.allCases where name.isMissing {
          SwitchCaseSyntax("case .\(name.enumCaseCallName):") {
            StmtSyntax("return true")
          }
        }

        SwitchCaseSyntax("default:") {
          StmtSyntax("return false")
        }
      }
    }

    try VariableDeclSyntax("public var syntaxNodeType: SyntaxProtocol.Type") {
      try SwitchExprSyntax("switch self") {
        SwitchCaseSyntax("case .token:") {
          StmtSyntax("return TokenSyntax.self")
        }

        for node in NON_BASE_SYNTAX_NODES {
          SwitchCaseSyntax("case .\(node.enumCaseCallName):") {
            StmtSyntax("return \(node.kind.syntaxType).self")
          }
        }
      }
    }
  }
}
