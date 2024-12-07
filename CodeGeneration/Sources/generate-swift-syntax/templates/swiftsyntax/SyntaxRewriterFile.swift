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

let syntaxRewriterFile = makeSyntaxRewriterFile()

func makeSyntaxRewriterFile(
  className: String = "SyntaxRewriter",
  functionEffectSpecifiers: String? = nil,
  functionCallOperators: String? = nil,
  spiName: String? = nil
) -> SourceFileSyntax {
  let functionEffectSpecifiers =
    if let functionEffectSpecifiers {
      " ".appending(functionEffectSpecifiers)
    } else {
      String()
    }
  let functionCallOperators = functionCallOperators?.appending(" ") ?? String()
  let spiAttribute =
    if let spiName {
      "\n@_spi(\(spiName))"
    } else {
      String()
    }

  return SourceFileSyntax(leadingTrivia: copyrightHeader) {
    try! ClassDeclSyntax(
      """
      //
      // This file defines the \(raw: className), a class that performs a standard walk
      // and tree-rebuilding pattern.
      //
      // Subclassers of this class can override the walking behavior for any syntax
      // node and transform nodes however they like.
      //
      //===----------------------------------------------------------------------===//
      \(raw: spiAttribute)
      open class \(raw: className)
      """
    ) {
      DeclSyntax("public let viewMode: SyntaxTreeViewMode")
      DeclSyntax(
        """
        /// The arena in which the parents of rewritten nodes should be allocated.
        /// 
        /// The `\(raw: className)` subclass is responsible for generating the rewritten nodes. To incorporate them into the
        /// tree, all of the rewritten node's parents also need to be re-created. This is the arena in which those 
        /// intermediate nodes should be allocated.
        private let arena: SyntaxArena?
        """
      )

      DeclSyntax(
        """
        /// 'Syntax' object factory recycling 'Syntax.Info' instances.
        private let nodeFactory: SyntaxNodeFactory = SyntaxNodeFactory()
        """
      )

      DeclSyntax(
        """
        public init(viewMode: SyntaxTreeViewMode = .sourceAccurate) {
          self.viewMode = viewMode
          self.arena = nil
        }
        """
      )

      DeclSyntax(
        """
        @_spi(RawSyntax)
        public init(viewMode: SyntaxTreeViewMode = .sourceAccurate, arena: SyntaxArena? = nil) {
          self.viewMode = viewMode
          self.arena = arena
        }
        """
      )

      DeclSyntax(
        """
        /// Rewrite `node`, keeping its parent unless `detach` is `true`.
        public func rewrite(_ node: some SyntaxProtocol, detach: Bool = false)\(raw: functionEffectSpecifiers) -> Syntax {
          var rewritten = Syntax(node)
          \(raw: functionCallOperators)self.dispatchVisit(&rewritten)
          if detach {
            return rewritten
          }

          return withExtendedLifetime(rewritten) {
            return Syntax(node).replacingSelf(rewritten.raw, rawNodeArena: rewritten.raw.arenaReference.retained, allocationArena: SyntaxArena())
          }
        }
        """
      )

      DeclSyntax(
        """
        /// Visit a ``TokenSyntax``.
        ///   - Parameter token: the token that is being visited
        ///   - Returns: the rewritten node
        open func visit(_ token: TokenSyntax)\(raw: functionEffectSpecifiers) -> TokenSyntax {
          return token
        }
        """
      )

      DeclSyntax(
        """
        /// The function called before visiting the node and its descendants.
        ///   - node: the node we are about to visit.
        open func visitPre(_ node: Syntax)\(raw: functionEffectSpecifiers) {}
        """
      )

      DeclSyntax(
        """
        /// Override point to choose custom visitation dispatch instead of the
        /// specialized `visit(_:)` methods. Use this instead of those methods if
        /// you intend to dynamically dispatch rewriting behavior.
        /// - note: If this method returns a non-nil result, the subsequent
        ///         `visitAny(_:)` methods and the specialized `visit(_:)`
        ///         methods will not be called for this node and the
        ///         visited node will be replaced by the returned node in the
        ///         rewritten tree.
        ///         You can call the ``\(raw: className)/rewrite(_:detach:)``
        ///         method recursively when returning a non-nil result
        ///         if you want to visit the node's children anyway.
        open func visitAny(_ node: Syntax)\(raw: functionEffectSpecifiers) -> Syntax? {
          return nil
        }
        """
      )

      DeclSyntax(
        """
        /// The function called after visiting the node and its descendants.
        ///   - node: the node we just finished visiting.
        open func visitPost(_ node: Syntax)\(raw: functionEffectSpecifiers) {}
        """
      )

      DeclSyntax(
        """
        /// Visit any Syntax node.
        ///   - Parameter node: the node that is being visited
        ///   - Returns: the rewritten node
        @available(*, deprecated, renamed: "rewrite(_:detach:)")
        public func visit(_ node: Syntax)\(raw: functionEffectSpecifiers) -> Syntax {
          var rewritten = node
          \(raw: functionCallOperators)dispatchVisit(&rewritten)
          return rewritten
        }
        """
      )

      DeclSyntax(
        """
        public func visit<T: SyntaxChildChoices>(_ node: T)\(raw: functionEffectSpecifiers) -> T {
          var rewritten = Syntax(node)
          \(raw: functionCallOperators)dispatchVisit(&rewritten)
          return rewritten.cast(T.self)
        }
        """
      )

      for node in SYNTAX_NODES where !node.kind.isBase {
        if (node.base == .syntax || node.base == .syntaxCollection) && node.kind != .missing {
          DeclSyntax(
            """
            /// Visit a \(raw: node.kind.doccLink).
            ///   - Parameter node: the node that is being visited
            ///   - Returns: the rewritten node
            \(node.apiAttributes())\
            open func visit(_ node: \(node.kind.syntaxType))\(raw: functionEffectSpecifiers) -> \(node.kind.syntaxType) {
              return \(raw: functionCallOperators)visitChildren(node._syntaxNode).cast(\(node.kind.syntaxType).self)
            }
            """
          )
        } else {
          DeclSyntax(
            """
            /// Visit a \(raw: node.kind.doccLink).
            ///   - Parameter node: the node that is being visited
            ///   - Returns: the rewritten node
            \(node.apiAttributes())\
            open func visit(_ node: \(node.kind.syntaxType))\(raw: functionEffectSpecifiers) -> \(node.baseType.syntaxBaseName) {
              return \(node.baseType.syntaxBaseName)(\(raw: functionCallOperators)visitChildren(node._syntaxNode).cast(\(node.kind.syntaxType).self))
            }
            """
          )
        }
      }

      for baseNode in SYNTAX_NODES
      where baseNode.kind.isBase && baseNode.kind != .syntax && baseNode.kind != .syntaxCollection {
        let baseKind = baseNode.kind
        DeclSyntax(
          """
          /// Visit any \(baseKind.syntaxType) node.
          ///   - Parameter node: the node that is being visited
          ///   - Returns: the rewritten node
          \(baseNode.apiAttributes())\
          public func visit(_ node: \(baseKind.syntaxType))\(raw: functionEffectSpecifiers) -> \(baseKind.syntaxType) {
            var node: Syntax = Syntax(node)
            \(raw: functionCallOperators)dispatchVisit(&node)
            return node.cast(\(baseKind.syntaxType).self)
          }
          """
        )
      }

      DeclSyntax(
        """
        /// Interpret `node` as a node of type `nodeType`, visit it, calling
        /// the `visit` to transform the node.
        @inline(__always)
        private func visitImpl<NodeType: SyntaxProtocol>(
          _ node: inout Syntax,
          _ nodeType: NodeType.Type,
          _ visit: (NodeType)\(raw: functionEffectSpecifiers) -> some SyntaxProtocol
        )\(raw: functionEffectSpecifiers) {
          let origNode = node
          \(raw: functionCallOperators)visitPre(origNode)
          node =
            if let newNode = \(raw: functionCallOperators)visitAny(origNode) {
              newNode
            } else {
              Syntax(\(raw: functionCallOperators)visit(origNode.cast(NodeType.self)))
            }
          \(raw: functionCallOperators)visitPost(origNode)
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
          // \(className) in debug builds.

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
                  private func visitationFunc(for node: Syntax)\(raw: functionEffectSpecifiers) -> ((inout Syntax)\(raw: functionEffectSpecifiers) -> Void)
                  """
                ) {
                  try SwitchExprSyntax("switch node.raw.kind") {
                    SwitchCaseSyntax("case .token:") {
                      StmtSyntax(
                        "return { \(raw: functionCallOperators)self.visitImpl(&$0, TokenSyntax.self, self.visit) }"
                      )
                    }

                    for node in NON_BASE_SYNTAX_NODES {
                      SwitchCaseSyntax("case .\(node.enumCaseCallName):") {
                        StmtSyntax(
                          "return { \(raw: functionCallOperators)self.visitImpl(&$0, \(node.kind.syntaxType).self, self.visit) }"
                        )
                      }
                    }
                  }
                }

                DeclSyntax(
                  """
                  private func dispatchVisit(_ node: inout Syntax)\(raw: functionEffectSpecifiers) {
                    \(raw: functionCallOperators)visitationFunc(for: node)(&node)
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
                  "private func dispatchVisit(_ node: inout Syntax)\(raw: functionEffectSpecifiers)"
                ) {
                  try SwitchExprSyntax("switch node.raw.kind") {
                    SwitchCaseSyntax("case .token:") {
                      StmtSyntax("return \(raw: functionCallOperators)visitImpl(&node, TokenSyntax.self, visit)")
                    }

                    for node in NON_BASE_SYNTAX_NODES {
                      SwitchCaseSyntax("case .\(node.enumCaseCallName):") {
                        StmtSyntax(
                          "return \(raw: functionCallOperators)visitImpl(&node, \(node.kind.syntaxType).self, visit)"
                        )
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
        private func visitChildren(_ node: Syntax)\(raw: functionEffectSpecifiers) -> Syntax {
          // Walk over all children of this node and rewrite them. Don't store any
          // rewritten nodes until the first non-`nil` value is encountered. When this
          // happens, retrieve all previous syntax nodes from the parent node to
          // initialize the new layout. Once we know that we have to rewrite the
          // layout, we need to collect all further children, regardless of whether
          // they are rewritten or not.

          // newLayout is nil until the first child node is rewritten and rewritten
          // nodes are being collected.
          var newLayout: UnsafeMutableBufferPointer<RawSyntax?> = .init(start: nil, count: 0)

          // Keep 'SyntaxArena' of rewritten nodes alive until they are wrapped
          // with 'Syntax'
          var rewrittens: ContiguousArray<RetainedSyntaxArena> = []

          for case let (child?, info) in RawSyntaxChildren(node) where viewMode.shouldTraverse(node: child) {

            // Build the Syntax node to rewrite
            var childNode = nodeFactory.create(parent: node, raw: child, absoluteInfo: info)

            \(raw: functionCallOperators)dispatchVisit(&childNode)
            if childNode.raw.id != child.id {
              // The node was rewritten, let's handle it

              if newLayout.baseAddress == nil {
                // We have not yet collected any previous rewritten nodes. Initialize
                // the new layout with the previous nodes of the parent.
                newLayout = .allocate(capacity: node.raw.layoutView!.children.count)
                _ = newLayout.initialize(fromContentsOf: node.raw.layoutView!.children)
              }

              // Update the rewritten child.
              newLayout[Int(info.indexInParent)] = childNode.raw
              // Retain the syntax arena of the new node until it's wrapped with Syntax node.
              rewrittens.append(childNode.raw.arenaReference.retained)
            }

            // Recycle 'childNode.info'
            nodeFactory.dispose(&childNode)
          }

          if newLayout.baseAddress != nil {
            // A child node was rewritten. Build the updated node.

            let arena = self.arena ?? SyntaxArena()
            let newRaw = node.raw.layoutView!.replacingLayout(with: newLayout, arena: arena)
            newLayout.deinitialize()
            newLayout.deallocate()
            // 'withExtendedLifetime' to keep 'SyntaxArena's of them alive until here.
            return withExtendedLifetime(rewrittens) {
              Syntax(raw: newRaw, rawNodeArena: arena)
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
}
