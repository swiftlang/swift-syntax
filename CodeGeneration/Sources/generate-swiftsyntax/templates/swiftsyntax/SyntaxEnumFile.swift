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

let syntaxEnumFile = SourceFileSyntax(leadingTrivia: .docLineComment(generateCopyrightHeader(for: "generate-swiftsyntax"))) {
  EnumDeclSyntax("""
    /// Enum to exhaustively switch over all different syntax nodes.
    @frozen // FIXME: Not actually stable, works around a miscompile
    public enum SyntaxEnum
    """) {
    EnumCaseDeclSyntax("case token(TokenSyntax)")
    for node in NON_BASE_SYNTAX_NODES {
      EnumCaseDeclSyntax("case \(raw: node.swiftSyntaxKind)(\(raw: node.name))")
    }
  }
  
  ExtensionDeclSyntax("""
    public extension Syntax
    """) {
    FunctionDeclSyntax("""
      /// Get an enum that can be used to exhaustively switch over all syntax nodes.
      func `as`(_: SyntaxEnum.Type) -> SyntaxEnum
      """) {
      SwitchStmtSyntax(expression: ExprSyntax("raw.kind")) {
        SwitchCaseSyntax("case .token:") {
          ReturnStmtSyntax("return .token(TokenSyntax(self)!)")
        }
        
        for node in NON_BASE_SYNTAX_NODES {
          SwitchCaseSyntax("case .\(raw: node.swiftSyntaxKind):") {
            ReturnStmtSyntax("return .\(raw: node.swiftSyntaxKind)(\(raw: node.name)(self)!)")
          }
        }
      }
    }
  }
}
