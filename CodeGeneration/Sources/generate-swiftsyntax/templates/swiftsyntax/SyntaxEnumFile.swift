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
    @frozen // FIXME: Not actually stable, works around a miscompile
    public enum SyntaxEnum
    """
  ) {
    DeclSyntax("case token(TokenSyntax)")
    for node in NON_BASE_SYNTAX_NODES {
      DeclSyntax("case \(raw: node.swiftSyntaxKind)(\(raw: node.name))")
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
          SwitchCaseSyntax("case .\(raw: node.swiftSyntaxKind):") {
            StmtSyntax("return .\(raw: node.swiftSyntaxKind)(\(raw: node.name)(self)!)")
          }
        }
      }
    }
  }
}
