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

let syntaxTransformFile = SourceFileSyntax(leadingTrivia: .docLineComment(generateCopyrightHeader(for: "generate-swiftsyntax"))) {
  ProtocolDeclSyntax("public protocol SyntaxTransformVisitor") {
    AssociatedtypeDeclSyntax("associatedtype ResultType = Void")
    
    FunctionDeclSyntax("func visitAny(_ node: Syntax) -> ResultType")
    
    FunctionDeclSyntax("func visit(_ token: TokenSyntax) -> ResultType")
    
    for node in SYNTAX_NODES where node.isVisitable {
      FunctionDeclSyntax("""
        /// Visiting `\(raw: node.name)` specifically.
        ///   - Parameter node: the node we are visiting.
        ///   - Returns: the sum of whatever the child visitors return.
        func visit(_ node: \(raw: node.name)) -> ResultType
        """)
    }
  }
  
  ExtensionDeclSyntax("extension SyntaxTransformVisitor") {
    FunctionDeclSyntax("""
    public func visit(_ token: TokenSyntax) -> ResultType {
      visitAny(Syntax(token))
    }
    """)
    
    for node in SYNTAX_NODES where node.isVisitable {
      FunctionDeclSyntax("""
        /// Visiting `\(raw: node.name)` specifically.
        ///   - Parameter node: the node we are visiting.
        ///   - Returns: nil by default.
        public func visit(_ node: \(raw: node.name)) -> ResultType {
          visitAny(Syntax(node))
        }
        """)
    }
    
    FunctionDeclSyntax("public func visit(_ node: Syntax) -> ResultType") {
      SwitchStmtSyntax(expression: ExprSyntax("node.as(SyntaxEnum.self)")) {
        SwitchCaseSyntax("case .token(let node):") {
          ReturnStmtSyntax("return visit(node)")
        }
        for node in NON_BASE_SYNTAX_NODES {
          SwitchCaseSyntax("case .\(raw: node.swiftSyntaxKind)(let derived):") {
            ReturnStmtSyntax("return visit(derived)")
          }
        }
      }
    }
    
    FunctionDeclSyntax("""
      public func visit(_ node: ExprSyntax) -> ResultType {
        visit(Syntax(node))
      }
      """)
    
    FunctionDeclSyntax("""
      public func visit(_ node: PatternSyntax) -> ResultType {
        visit(Syntax(node))
      }
      """)
    
    FunctionDeclSyntax("""
      public func visit(_ node: TypeSyntax) -> ResultType {
        visit(Syntax(node))
      }
      """)
    
    FunctionDeclSyntax("""
      public func visit<T: SyntaxChildChoices>(_ node: T) -> ResultType {
        return visit(Syntax(node))
      }
      """)
    
    FunctionDeclSyntax("""
      public func visitChildren<SyntaxType: SyntaxProtocol>(_ node: SyntaxType) -> [ResultType] {
        let syntaxNode = Syntax(node)
        return NonNilRawSyntaxChildren(syntaxNode, viewMode: .sourceAccurate).map { rawChild in
          let child = Syntax(SyntaxData(rawChild, parent: syntaxNode))
          return visit(child)
        }
      }
      """)
    
  }
}
