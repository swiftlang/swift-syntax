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

let syntaxAnyVisitorFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  try! ClassDeclSyntax(
    """
    /// A `SyntaxVisitor` that can visit the nodes as generic ``Syntax`` values.
    ///
    /// This subclass of `SyntaxVisitor` is slower than the type-specific visitation
    /// of `SyntaxVisitor`. Use `SyntaxAnyVisitor` if the `visitAny(_)` function
    /// would be useful to have, otherwise inherit from `SyntaxVisitor`.
    ///
    /// This works by overriding the type-specific visit function that delegate to
    /// `visitAny(_)`. A subclass that provides a custom type-specific visit
    /// function, should also call `visitAny(_)` in its implementation, if calling
    /// `visitAny` is needed:
    ///
    /// ```swift
    /// struct MyVisitor: SyntaxAnyVisitor {
    ///   func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
    ///     <code>
    ///   }
    ///
    ///   func visit(_ token: TokenSyntax) -> SyntaxVisitorContinueKind {
    ///     <code>
    ///     // Call this to pass tokens to `visitAny(_)` as well if needed
    ///     visitAny(token)
    ///   }
    /// }
    /// ```
    open class SyntaxAnyVisitor: SyntaxVisitor
    """
  ) {
    DeclSyntax(
      """
      open func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
        return .visitChildren
      }
      """
    )

    DeclSyntax(
      """
      /// The function called after visiting the node and its descendants.
      ///   - node: the node we just finished visiting.
      open func visitAnyPost(_ node: Syntax) {}
      """
    )

    DeclSyntax(
      """
      // MARK: Override type specific visit methods

      override open func visit(_ token: TokenSyntax) -> SyntaxVisitorContinueKind {
        return visitAny(token._syntaxNode)
      }
      """
    )

    DeclSyntax(
      """
      override open func visitPost(_ node: TokenSyntax) {
        visitAnyPost(node._syntaxNode)
      }
      """
    )

    for node in SYNTAX_NODES where !node.kind.isBase {
      DeclSyntax(
        """
        \(node.apiAttributes())\
        override open func visit(_ node: \(node.kind.syntaxType)) -> SyntaxVisitorContinueKind {
          return visitAny(node._syntaxNode)
        }
        """
      )

      DeclSyntax(
        """
        \(node.apiAttributes())\
        override open func visitPost(_ node: \(node.kind.syntaxType)) {
          visitAnyPost(node._syntaxNode)
        }
        """
      )
    }
  }
}
