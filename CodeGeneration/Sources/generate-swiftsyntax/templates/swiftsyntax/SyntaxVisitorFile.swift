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
        visit(node.data)
      }
      """
    )

    for node in SYNTAX_NODES where !node.kind.isBase {
      DeclSyntax(
        """
        /// Visiting ``\(node.kind.syntaxType)`` specifically.
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
        /// The function called after visiting ``\(node.kind.syntaxType)`` and its descendants.
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

    for node in NON_BASE_SYNTAX_NODES {
      DeclSyntax(
        """
        /// Implementation detail of doVisit(_:_:). Do not call directly.
        private func visitImpl\(node.kind.syntaxType)(_ data: SyntaxData) {
          let node = \(node.kind.syntaxType)(data)
          let needsChildren = (visit(node) == .visitChildren)
          // Avoid calling into visitChildren if possible.
          if needsChildren && !node.raw.layoutView!.children.isEmpty {
            visitChildren(node)
          }
          visitPost(node)
        }
        """
      )
    }

    try FunctionDeclSyntax("private func visit(_ data: SyntaxData)") {
      try SwitchExprSyntax("switch data.raw.kind") {
        SwitchCaseSyntax("case .token:") {
          DeclSyntax("let node = TokenSyntax(data)")

          ExprSyntax("_ = visit(node)")
          ExprSyntax(
            """
            // No children to visit.
            visitPost(node)
            // The implementation of every generated case goes into its own function. This
            // circumvents an issue where the compiler allocates stack space for every
            // case statement next to each other in debug builds, causing it to allocate
            // ~50KB per call to this function. rdar://55929175
            """
          )
        }

        for node in NON_BASE_SYNTAX_NODES {
          SwitchCaseSyntax("case .\(node.varOrCaseName):") {
            ExprSyntax("visitImpl\(node.kind.syntaxType)(data)")
          }
        }
      }
    }

    DeclSyntax(
      """
      private func visitChildren(_ node: some SyntaxProtocol) {
        let syntaxNode = Syntax(node)
        for childRaw in NonNilRawSyntaxChildren(syntaxNode, viewMode: viewMode) {
          let childData = SyntaxData(childRaw, parent: syntaxNode)
          visit(childData)
        }
      }
      """
    )
  }
}
