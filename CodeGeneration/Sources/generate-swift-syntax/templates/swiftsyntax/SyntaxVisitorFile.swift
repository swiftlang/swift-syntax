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

let syntaxVisitorFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  DeclSyntax(
    """
    /// The enum describes how the ``SyntaxVisitor`` should continue after visiting
    /// the current node.
    public enum SyntaxVisitorContinueKind {
      /// The visitor should visit the descendants of the current node.
      case visitChildren
      /// The visitor should avoid visiting the descendants of the current node.
      case skipChildren
    }
    """
  )

  try! ClassDeclSyntax("open class SyntaxVisitor") {
    DeclSyntax("public let viewMode: SyntaxTreeViewMode")

    DeclSyntax(
      """
      public init(viewMode: SyntaxTreeViewMode) {
        self.viewMode = viewMode
      }
      """
    )

    DeclSyntax(
      """
      /// Walk all nodes of the given syntax tree, calling the corresponding `visit`
      /// function for every node that is being visited.
      public func walk(_ node: some SyntaxProtocol) {
        visit(Syntax(node))
      }
      """
    )

    for node in SYNTAX_NODES where !node.kind.isBase {
      DeclSyntax(
        """
        /// Visiting \(raw: node.kind.doccLink) specifically.
        ///   - Parameter node: the node we are visiting.
        ///   - Returns: how should we continue visiting.
        \(node.apiAttributes())\
        open func visit(_ node: \(node.kind.syntaxType)) -> SyntaxVisitorContinueKind {
          return .visitChildren
        }
        """
      )

      DeclSyntax(
        """
        /// The function called after visiting \(raw: node.kind.doccLink) and its descendants.
        ///   - node: the node we just finished visiting.
        \(node.apiAttributes())\
        open func visitPost(_ node: \(node.kind.syntaxType)) {}
        """
      )
    }

    DeclSyntax(
      """
      /// Visiting ``TokenSyntax`` specifically.
      ///   - Parameter node: the node we are visiting.
      ///   - Returns: how should we continue visiting.
      open func visit(_ token: TokenSyntax) -> SyntaxVisitorContinueKind {
        return .visitChildren
      }
      """
    )

    DeclSyntax(
      """
      /// The function called after visiting the node and its descendants.
      ///   - node: the node we just finished visiting.
      open func visitPost(_ node: TokenSyntax) {}
      """
    )

    DeclSyntax(
      """
      /// Interpret `data` as a node of type `nodeType`, visit it, calling
      /// the `visit` and `visitPost` functions during visitation.
      private func visitImpl<NodeType: SyntaxProtocol>(
        _ node: Syntax,
        _ nodeType: NodeType.Type,
        _ visit: (NodeType) -> SyntaxVisitorContinueKind,
        _ visitPost: (NodeType) -> Void
      ) {
        let node = node.cast(NodeType.self)
        let needsChildren = (visit(node) == .visitChildren)
        // Avoid calling into visitChildren if possible.
        if needsChildren && !node.raw.layoutView!.children.isEmpty {
          visitChildren(node)
        }
        visitPost(node)
      }
      """
    )

    try IfConfigDeclSyntax(
      leadingTrivia:
        """
        // SwiftSyntax requires a lot of stack space in debug builds for syntax tree
        // visitation. In scenarios with reduced stack space (in particular dispatch
        // queues), this easily results in a stack overflow. To work around this issue,
        // use a less performant but also less stack-hungry version of SwiftSyntax's
        // SyntaxVisitor in debug builds.

        """,
      clauses: IfConfigClauseListSyntax {
        IfConfigClauseSyntax(
          poundKeyword: .poundIfToken(),
          condition: ExprSyntax("DEBUG"),
          elements: .statements(
            try CodeBlockItemListSyntax {
              try FunctionDeclSyntax(
                """
                /// Implementation detail of visit(_:). Do not call directly.
                ///
                /// Returns the function that shall be called to visit a specific syntax node.
                ///
                /// To determine the correct specific visitation function for a syntax node,
                /// we need to switch through a huge switch statement that covers all syntax
                /// types. In debug builds, the cases of this switch statement do not share
                /// stack space (rdar://55929175). Because of this, the switch statement
                /// requires about 15KB of stack space. In scenarios with reduced
                /// stack size (in particular dispatch queues), this often results in a stack
                /// overflow during syntax tree rewriting.
                ///
                /// To circumvent this problem, make calling the specific visitation function
                /// a two-step process: First determine the function to call in this function
                /// and return a reference to it, then call it. This way, the stack frame
                /// that determines the correct visitation function will be popped of the
                /// stack before the function is being called, making the switch's stack
                /// space transient instead of having it linger in the call stack.
                private func visitationFunc(for node: Syntax) -> ((Syntax) -> Void)
                """
              ) {
                try SwitchExprSyntax("switch node.raw.kind") {
                  SwitchCaseSyntax("case .token:") {
                    StmtSyntax(
                      """
                      return {
                        let node = $0.cast(TokenSyntax.self)
                        _ = self.visit(node)
                        // No children to visit.
                        self.visitPost(node)
                      }
                      """
                    )
                  }

                  for node in NON_BASE_SYNTAX_NODES {
                    SwitchCaseSyntax("case .\(node.varOrCaseName):") {
                      StmtSyntax("return { self.visitImpl($0, \(node.kind.syntaxType).self, self.visit, self.visitPost) }")
                    }
                  }
                }
              }

              DeclSyntax(
                """
                private func visit(_ node: Syntax) {
                  return visitationFunc(for: node)(node)
                }
                """
              )
            }
          )
        )
        IfConfigClauseSyntax(
          poundKeyword: .poundElseToken(),
          elements: .statements(
            CodeBlockItemListSyntax {
              try! FunctionDeclSyntax("private func visit(_ node: Syntax)") {
                try SwitchExprSyntax("switch node.raw.kind") {
                  SwitchCaseSyntax("case .token:") {
                    DeclSyntax("let node = node.cast(TokenSyntax.self)")
                    ExprSyntax("_ = visit(node)")
                    ExprSyntax(
                      """
                      // No children to visit.
                      visitPost(node)
                      """
                    )
                  }

                  for node in NON_BASE_SYNTAX_NODES {
                    SwitchCaseSyntax("case .\(node.varOrCaseName):") {
                      ExprSyntax("visitImpl(node, \(node.kind.syntaxType).self, visit, visitPost)")
                    }
                  }
                }
              }

            }
          )
        )
      }
    )

    DeclSyntax(
      """
      private func visitChildren(_ node: some SyntaxProtocol) {
        let syntaxNode = Syntax(node)
        for childRaw in NonNilRawSyntaxChildren(syntaxNode, viewMode: viewMode) {
          visit(Syntax(childRaw, parent: syntaxNode))
        }
      }
      """
    )
  }
}
