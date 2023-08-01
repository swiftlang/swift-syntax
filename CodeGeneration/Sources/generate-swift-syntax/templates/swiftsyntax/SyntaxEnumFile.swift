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

let syntaxEnumFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  try! EnumDeclSyntax(
    """
    /// Enum to exhaustively switch over all different syntax nodes.
    public enum SyntaxEnum
    """
  ) {
    DeclSyntax("case token(TokenSyntax)")
    for node in NON_BASE_SYNTAX_NODES {
      DeclSyntax(
        """
        \(node.apiAttributes())\
        case \(node.varOrCaseName)(\(node.kind.syntaxType))
        """
      )
    }
  }

  try! ExtensionDeclSyntax(
    """
    public extension Syntax
    """
  ) {
    try FunctionDeclSyntax(
      """
      /// Get an enum that can be used to exhaustively switch over all syntax nodes.
      func `as`(_: SyntaxEnum.Type) -> SyntaxEnum
      """
    ) {
      try SwitchExprSyntax("switch raw.kind") {
        SwitchCaseSyntax("case .token:") {
          StmtSyntax("return .token(TokenSyntax(self)!)")
        }

        for node in NON_BASE_SYNTAX_NODES {
          SwitchCaseSyntax("case .\(node.varOrCaseName):") {
            StmtSyntax("return .\(node.varOrCaseName)(\(node.kind.syntaxType)(self)!)")
          }
        }
      }
    }
  }
}
