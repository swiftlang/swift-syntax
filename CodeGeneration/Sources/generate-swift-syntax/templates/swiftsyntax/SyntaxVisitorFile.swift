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
      /// 'Syntax' object factory recycling 'Syntax.Info' instances.
      private let nodeFactory: SyntaxNodeFactory = SyntaxNodeFactory()
      """
    )

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
        dispatchVisit(Syntax(node))
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
      ///   - Parameter token: the token we are visiting.
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

    // NOTE: '@inline(never)' because perf tests showed the best results.
    // It keeps 'dispatchVisit(_:)' function small, and make all 'case' bodies exactly the same pattern.
    // Which enables some optimizations.
    DeclSyntax(
      """
      @inline(never)
      private func visitTokenSyntaxImpl(_ node: Syntax) {
        _ = visit(TokenSyntax(unsafeCasting: node))
        // No children to visit.
        visitPost(TokenSyntax(unsafeCasting: node))
      }
      """
    )

    for node in NON_BASE_SYNTAX_NODES {
      DeclSyntax(
        """
        @inline(never)
        private func visit\(node.kind.syntaxType)Impl(_ node: Syntax) {
          if visit(\(node.kind.syntaxType)(unsafeCasting: node)) == .visitChildren {
            visitChildren(node)
          }
          visitPost(\(node.kind.syntaxType)(unsafeCasting: node))
        }
        """
      )
    }

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
                private func visitationFunc(for node: Syntax) -> (Syntax) -> Void
                """
              ) {
                try SwitchExprSyntax("switch node.raw.kind") {
                  SwitchCaseSyntax("case .token:") {
                    StmtSyntax("return self.visitTokenSyntaxImpl(_:)")
                  }

                  for node in NON_BASE_SYNTAX_NODES {
                    SwitchCaseSyntax("case .\(node.enumCaseCallName):") {
                      StmtSyntax(
                        "return self.visit\(node.kind.syntaxType)Impl(_:)"
                      )
                    }
                  }
                }
              }

              DeclSyntax(
                """
                private func dispatchVisit(_ node: Syntax) {
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
              try! FunctionDeclSyntax(
                """
                private func dispatchVisit(_ node: Syntax)
                """
              ) {
                try SwitchExprSyntax("switch node.raw.kind") {
                  SwitchCaseSyntax("case .token:") {
                    ExprSyntax("self.visitTokenSyntaxImpl(node)")
                  }

                  for node in NON_BASE_SYNTAX_NODES {
                    SwitchCaseSyntax("case .\(node.enumCaseCallName):") {
                      ExprSyntax("self.visit\(node.kind.syntaxType)Impl(node)")
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
      private func visitChildren(_ node: Syntax) {
        for case let (child?, info) in RawSyntaxChildren(node) where viewMode.shouldTraverse(node: child) {
          var childNode = nodeFactory.create(parent: node, raw: child, absoluteInfo: info)
          dispatchVisit(childNode)
          nodeFactory.dispose(&childNode)
        }
      }
      """
    )
  }
}
