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

let syntaxTransformFile = SourceFile {
  ProtocolDecl("public protocol SyntaxTransformVisitor") {
    AssociatedtypeDecl("associatedtype ResultType = Void")
    
    FunctionDecl("func visitAny(_ node: Syntax) -> ResultType")
    
    FunctionDecl("func visit(_ token: TokenSyntax) -> ResultType")
    
    for node in SYNTAX_NODES where node.isVisitable {
      FunctionDecl("""
        /// Visiting `\(raw: node.name)` specifically.
        ///   - Parameter node: the node we are visiting.
        ///   - Returns: the sum of whatever the child visitors return.
        func visit(_ node: \(raw: node.name)) -> ResultType
        """)
    }
  }
  
  ExtensionDecl("extension SyntaxTransformVisitor") {
    FunctionDecl("""
    public func visit(_ token: TokenSyntax) -> ResultType {
      visitAny(Syntax(token))
    }
    """)
    
    for node in SYNTAX_NODES where node.isVisitable {
      FunctionDecl("""
        /// Visiting `\(raw: node.name)` specifically.
        ///   - Parameter node: the node we are visiting.
        ///   - Returns: nil by default.
        public func visit(_ node: \(raw: node.name)) -> ResultType {
          visitAny(Syntax(node))
        }
        """)
    }
    
    FunctionDecl("public func visit(_ node: Syntax) -> ResultType") {
      SwitchStmt(expression: Expr("node.as(SyntaxEnum.self)")) {
        SwitchCase("case .token(let node):") {
          ReturnStmt("return visit(node)")
        }
        for node in NON_BASE_SYNTAX_NODES {
          SwitchCase("case .\(raw: node.swiftSyntaxKind)(let derived):") {
            ReturnStmt("return visit(derived)")
          }
        }
      }
    }
    
    FunctionDecl("""
      public func visit(_ node: ExprSyntax) -> ResultType {
        visit(Syntax(node))
      }
      """)
    
    FunctionDecl("""
      public func visit(_ node: PatternSyntax) -> ResultType {
        visit(Syntax(node))
      }
      """)
    
    FunctionDecl("""
      public func visit(_ node: TypeSyntax) -> ResultType {
        visit(Syntax(node))
      }
      """)
    
    FunctionDecl("""
      public func visit<T: SyntaxChildChoices>(_ node: T) -> ResultType {
        return visit(Syntax(node))
      }
      """)
    
    FunctionDecl("""
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
