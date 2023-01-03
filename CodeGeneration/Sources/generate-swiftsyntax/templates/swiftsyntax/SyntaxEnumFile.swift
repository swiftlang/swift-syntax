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

let syntaxEnumFile = SourceFile(leadingTrivia: .docLineComment(generateCopyrightHeader(for: "generate-swiftsyntax"))) {
  EnumDecl("""
    /// Enum to exhaustively switch over all different syntax nodes.
    @frozen // FIXME: Not actually stable, works around a miscompile
    public enum SyntaxEnum
    """) {
    EnumCaseDecl("case token(TokenSyntax)")
    for node in NON_BASE_SYNTAX_NODES {
      EnumCaseDecl("case \(raw: node.swiftSyntaxKind)(\(raw: node.name))")
    }
  }
  
  ExtensionDecl("""
    public extension Syntax
    """) {
    FunctionDecl("""
      /// Get an enum that can be used to exhaustively switch over all syntax nodes.
      func `as`(_: SyntaxEnum.Type) -> SyntaxEnum
      """) {
      SwitchStmt(expression: Expr("raw.kind")) {
        SwitchCase("case .token:") {
          ReturnStmt("return .token(TokenSyntax(self)!)")
        }
        
        for node in NON_BASE_SYNTAX_NODES {
          SwitchCase("case .\(raw: node.swiftSyntaxKind):") {
            ReturnStmt("return .\(raw: node.swiftSyntaxKind)(\(raw: node.name)(self)!)")
          }
        }
      }
    }
  }
}
