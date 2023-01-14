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

let syntaxVisitorFile = SourceFileSyntax {
  EnumDeclSyntax("""
    /// The enum describes how the SyntaxVistor should continue after visiting
    /// the current node.
    public enum SyntaxVisitorContinueKind {
      /// The visitor should visit the descendents of the current node.
      case visitChildren
      /// The visitor should avoid visiting the descendents of the current node.
      case skipChildren
    }
    """)
  
  ClassDeclSyntax("open class SyntaxVisitor") {
    VariableDeclSyntax("public let viewMode: SyntaxTreeViewMode")
    
    InitializerDeclSyntax("""
      @available(*, deprecated, message: "Use init(viewMode:) instead")
      public convenience init() {
        self.init(viewMode: .sourceAccurate)
      }
      """)

    InitializerDeclSyntax("""
      public init(viewMode: SyntaxTreeViewMode) {
        self.viewMode = viewMode
      }
      """)
    
    FunctionDeclSyntax("""
      /// Walk all nodes of the given syntax tree, calling the corresponding `visit`
      /// function for every node that is being visited.
      public func walk<SyntaxType: SyntaxProtocol>(_ node: SyntaxType) {
        visit(node.data)
      }
      """)

    for node in SYNTAX_NODES where node.isVisitable {
      FunctionDeclSyntax("""
        /// Visiting `\(raw: node.name)` specifically.
        ///   - Parameter node: the node we are visiting.
        ///   - Returns: how should we continue visiting.
        open func visit(_ node: \(raw: node.name)) -> SyntaxVisitorContinueKind {
          return .visitChildren
        }
        """)

      FunctionDeclSyntax("""
        /// The function called after visiting `\(raw: node.name)` and its descendents.
        ///   - node: the node we just finished visiting.
        open func visitPost(_ node: \(raw: node.name)) {}
        """)
    }

    FunctionDeclSyntax("""
      /// Visiting `TokenSyntax` specifically.
      ///   - Parameter node: the node we are visiting.
      ///   - Returns: how should we continue visiting.
      open func visit(_ token: TokenSyntax) -> SyntaxVisitorContinueKind {
        return .visitChildren
      }
      """)

    FunctionDeclSyntax("""
      /// The function called after visiting the node and its descendents.
      ///   - node: the node we just finished visiting.
      open func visitPost(_ node: TokenSyntax) {}
      """)

    for node in NON_BASE_SYNTAX_NODES {
      FunctionDeclSyntax("""
        /// Implementation detail of doVisit(_:_:). Do not call directly.
        private func visitImpl\(raw: node.name)(_ data: SyntaxData) {
          let node = \(raw: node.name)(data)
          let needsChildren = (visit(node) == .visitChildren)
          // Avoid calling into visitChildren if possible.
          if needsChildren && !node.raw.layoutView!.children.isEmpty {
            visitChildren(node)
          }
          visitPost(node)
        }
        """)
    }

    FunctionDeclSyntax("private func visit(_ data: SyntaxData)") {
      SwitchStmtSyntax(expression: ExprSyntax("data.raw.kind")) {
        SwitchCaseSyntax("case .token:") {
          VariableDeclSyntax("let node = TokenSyntax(data)")

          ExprSyntax("_ = visit(node)")
          FunctionCallExprSyntax("""
            // No children to visit.
            visitPost(node)
            // The implementation of every generated case goes into its own function. This
            // circumvents an issue where the compiler allocates stack space for every
            // case statement next to each other in debug builds, causing it to allocate
            // ~50KB per call to this function. rdar://55929175
            """)
        }
        for node in NON_BASE_SYNTAX_NODES {
          SwitchCaseSyntax("case .\(raw: node.swiftSyntaxKind):") {
            FunctionCallExprSyntax("visitImpl\(raw: node.name)(data)")
          }
        }
      }
    }

    FunctionDeclSyntax("""
      private func visitChildren<SyntaxType: SyntaxProtocol>(_ node: SyntaxType) {
        let syntaxNode = Syntax(node)
        for childRaw in NonNilRawSyntaxChildren(syntaxNode, viewMode: viewMode) {
          let childData = SyntaxData(childRaw, parent: syntaxNode)
          visit(childData)
        }
      }
      """)
  }
}
