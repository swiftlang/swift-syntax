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

let syntaxRewriterFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  try! ClassDeclSyntax(
    """
    //
    // This file defines the SyntaxRewriter, a class that performs a standard walk
    // and tree-rebuilding pattern.
    //
    // Subclassers of this class can override the walking behavior for any syntax
    // node and transform nodes however they like.
    //
    //===----------------------------------------------------------------------===//

    open class SyntaxRewriter
    """
  ) {
    DeclSyntax("public let viewMode: SyntaxTreeViewMode")

    DeclSyntax(
      """
      public init(viewMode: SyntaxTreeViewMode = .sourceAccurate) {
        self.viewMode = viewMode
      }
      """
    )

    DeclSyntax(
      """
      /// Rewrite `node`, keeping its parent unless `detach` is `true`.
      public func rewrite(_ node: some SyntaxProtocol, detach: Bool = false) -> Syntax {
        let rewritten = self.visit(node.data)
        if detach {
          return rewritten
        }

        return withExtendedLifetime(rewritten) {
          return Syntax(node.data.replacingSelf(rewritten.raw, rawNodeArena: rewritten.raw.arena, allocationArena: SyntaxArena()))
        }
      }
      """
    )

    DeclSyntax(
      """
      /// Visit a ``TokenSyntax``.
      ///   - Parameter node: the node that is being visited
      ///   - Returns: the rewritten node
      open func visit(_ token: TokenSyntax) -> TokenSyntax {
        return token
      }
      """
    )

    DeclSyntax(
      """
      /// The function called before visiting the node and its descendants.
      ///   - node: the node we are about to visit.
      open func visitPre(_ node: Syntax) {}
      """
    )

    DeclSyntax(
      """
      /// Override point to choose custom visitation dispatch instead of the
      /// specialized `visit(_:)` methods. Use this instead of those methods if
      /// you intend to dynamically dispatch rewriting behavior.
      /// - note: If this method returns a non-nil result, the specialized
      ///         `visit(_:)` methods will not be called for this node and the
      ///         visited node will be replaced by the returned node in the
      ///         rewritten tree.
      open func visitAny(_ node: Syntax) -> Syntax? {
        return nil
      }
      """
    )

    DeclSyntax(
      """
      /// The function called after visiting the node and its descendants.
      ///   - node: the node we just finished visiting.
      open func visitPost(_ node: Syntax) {}
      """
    )

    DeclSyntax(
      """
      /// Visit any Syntax node.
      ///   - Parameter node: the node that is being visited
      ///   - Returns: the rewritten node
      @available(*, deprecated, renamed: "rewrite(_:detach:)")
      public func visit(_ node: Syntax) -> Syntax {
        return visit(node.data)
      }
      """
    )

    DeclSyntax(
      """
      public func visit<T: SyntaxChildChoices>(_ node: T) -> T {
        return visit(node.data).cast(T.self)
      }
      """
    )

    for node in SYNTAX_NODES where !node.kind.isBase {
      if (node.base == .syntax || node.base == .syntaxCollection) && node.kind != .missing {
        DeclSyntax(
          """
          /// Visit a ``\(node.kind.syntaxType)``.
          ///   - Parameter node: the node that is being visited
          ///   - Returns: the rewritten node
          \(node.apiAttributes())\
          open func visit(_ node: \(node.kind.syntaxType)) -> \(node.kind.syntaxType) {
            return Syntax(visitChildren(node)).cast(\(node.kind.syntaxType).self)
          }
          """
        )
      } else {
        DeclSyntax(
          """
          /// Visit a ``\(node.kind.syntaxType)``.
          ///   - Parameter node: the node that is being visited
          ///   - Returns: the rewritten node
          \(node.apiAttributes())\
          open func visit(_ node: \(node.kind.syntaxType)) -> \(raw: node.baseType.syntaxBaseName) {
            return \(raw: node.baseType.syntaxBaseName)(visitChildren(node))
          }
          """
        )
      }
    }

    for baseNode in SYNTAX_NODES where baseNode.kind.isBase && baseNode.kind != .syntax && baseNode.kind != .syntaxCollection {
      let baseKind = baseNode.kind
      DeclSyntax(
        """
        /// Visit any \(raw: baseKind.syntaxType) node.
        ///   - Parameter node: the node that is being visited
        ///   - Returns: the rewritten node
        \(baseNode.apiAttributes())\
        public func visit(_ node: \(raw: baseKind.syntaxType)) -> \(raw: baseKind.syntaxType) {
          return visit(node.data).cast(\(raw: baseKind.syntaxType).self)
        }
        """
      )
    }

    for node in NON_BASE_SYNTAX_NODES {
      DeclSyntax(
        """
        /// Implementation detail of visit(_:). Do not call directly.
        private func visitImpl\(node.kind.syntaxType)(_ data: SyntaxData) -> Syntax {
          let node = \(node.kind.syntaxType)(data)
          // Accessing _syntaxNode directly is faster than calling Syntax(node)
          visitPre(node._syntaxNode)
          defer { visitPost(node._syntaxNode) }
          if let newNode = visitAny(node._syntaxNode) { return newNode }
          return Syntax(visit(node))
        }
        """
      )
    }

    DeclSyntax(
      """
      /// Implementation detail of visit(_:). Do not call directly.
      private func visitImplTokenSyntax(_ data: SyntaxData) -> Syntax {
        let node = TokenSyntax(data)
        // Accessing _syntaxNode directly is faster than calling Syntax(node)
        visitPre(node._syntaxNode)
        defer { visitPost(node._syntaxNode) }
        if let newNode = visitAny(node._syntaxNode) { return newNode }
        return Syntax(visit(node))
      }
      """
    )

    try IfConfigDeclSyntax(
      leadingTrivia:
        """
        // SwiftSyntax requires a lot of stack space in debug builds for syntax tree
        // rewriting. In scenarios with reduced stack space (in particular dispatch
        // queues), this easily results in a stack overflow. To work around this issue,
        // use a less performant but also less stack-hungry version of SwiftSyntax's
        // SyntaxRewriter in debug builds.

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
                /// requires allocates about 15KB of stack space. In scenarios with reduced
                /// stack size (in particular dispatch queues), this often results in a stack
                /// overflow during syntax tree rewriting.
                ///
                /// To circumvent this problem, make calling the specific visitation function
                /// a two-step process: First determine the function to call in this function
                /// and return a reference to it, then call it. This way, the stack frame
                /// that determines the correct visitation function will be popped of the
                /// stack before the function is being called, making the switch's stack
                /// space transient instead of having it linger in the call stack.
                private func visitationFunc(for data: SyntaxData) -> ((SyntaxData) -> Syntax)
                """
              ) {
                try SwitchExprSyntax("switch data.raw.kind") {
                  SwitchCaseSyntax("case .token:") {
                    StmtSyntax("return visitImplTokenSyntax")
                  }

                  for node in NON_BASE_SYNTAX_NODES {
                    SwitchCaseSyntax("case .\(node.varOrCaseName):") {
                      StmtSyntax("return visitImpl\(node.kind.syntaxType)")
                    }
                  }
                }
              }

              DeclSyntax(
                """
                private func visit(_ data: SyntaxData) -> Syntax {
                  return visitationFunc(for: data)(data)
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
              try! FunctionDeclSyntax("private func visit(_ data: SyntaxData) -> Syntax") {
                try SwitchExprSyntax("switch data.raw.kind") {
                  SwitchCaseSyntax("case .token:") {
                    StmtSyntax("return visitImplTokenSyntax(data)")
                  }

                  for node in NON_BASE_SYNTAX_NODES {
                    SwitchCaseSyntax("case .\(node.varOrCaseName):") {
                      StmtSyntax("return visitImpl\(node.kind.syntaxType)(data)")
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
      private func visitChildren<SyntaxType: SyntaxProtocol>(
        _ node: SyntaxType
      ) -> SyntaxType {
        // Walk over all children of this node and rewrite them. Don't store any
        // rewritten nodes until the first non-`nil` value is encountered. When this
        // happens, retrieve all previous syntax nodes from the parent node to
        // initialize the new layout. Once we know that we have to rewrite the
        // layout, we need to collect all further children, regardless of whether
        // they are rewritten or not.

        // newLayout is nil until the first child node is rewritten and rewritten
        // nodes are being collected.
        var newLayout: ContiguousArray<RawSyntax?>?

        // Rewritten children just to keep their 'SyntaxArena' alive until they are
        // wrapped with 'Syntax'
        var rewrittens: ContiguousArray<Syntax> = []

        let syntaxNode = node._syntaxNode

        // Incrementing i manually is faster than using .enumerated()
        var childIndex = 0
        for (raw, info) in RawSyntaxChildren(syntaxNode) {
          defer { childIndex += 1 }

          guard let child = raw, viewMode.shouldTraverse(node: child) else {
            // Node does not exist or should not be visited. If we are collecting
            // rewritten nodes, we need to collect this one as well, otherwise we
            // can ignore it.
            if newLayout != nil {
              newLayout!.append(raw)
            }
            continue
          }

          // Build the Syntax node to rewrite
          let absoluteRaw = AbsoluteRawSyntax(raw: child, info: info)
          let data = SyntaxData(absoluteRaw, parent: syntaxNode)

          let rewritten = visit(data)
          if rewritten.data.nodeId != info.nodeId {
            // The node was rewritten, let's handle it
            if newLayout == nil {
              // We have not yet collected any previous rewritten nodes. Initialize
              // the new layout with the previous nodes of the parent. This is
              // possible, since we know they were not rewritten.

              // The below implementation is based on Collection.map but directly
              // reserves enough capacity for the entire layout.
              newLayout = ContiguousArray<RawSyntax?>()
              newLayout!.reserveCapacity(node.raw.layoutView!.children.count)
              for j in 0..<childIndex {
                newLayout!.append(node.raw.layoutView!.children[j])
              }
            }

            // Now that we know we have a new layout in which we collect rewritten
            // nodes, add it.
            rewrittens.append(rewritten)
            newLayout!.append(rewritten.raw)
          } else {
            // The node was not changed by the rewriter. Only store it if a previous
            // node has been rewritten and we are collecting a rewritten layout.
            if newLayout != nil {
              newLayout!.append(raw)
            }
          }
        }

        if let newLayout {
          // A child node was rewritten. Build the updated node.

          // Sanity check, ensure the new children are the same length.
          precondition(newLayout.count == node.raw.layoutView!.children.count)

          let arena = SyntaxArena()
          let newRaw = node.raw.layoutView!.replacingLayout(with: Array(newLayout), arena: arena)
          // 'withExtendedLifetime' to keep 'SyntaxArena's of them alive until here.
          return withExtendedLifetime(rewrittens) {
            Syntax(raw: newRaw, rawNodeArena: arena).cast(SyntaxType.self)
          }
        } else {
          // No child node was rewritten. So no need to change this node as well.
          return node
        }
      }
      """
    )
  }
}
