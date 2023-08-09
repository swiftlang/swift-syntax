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

let syntaxTransformFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  try! ProtocolDeclSyntax(
    """
    @_spi(SyntaxTransformVisitor)
    public protocol SyntaxTransformVisitor
    """
  ) {
    DeclSyntax("associatedtype ResultType = Void")

    DeclSyntax("func visitAny(_ node: Syntax) -> ResultType")

    DeclSyntax("func visit(_ token: TokenSyntax) -> ResultType")

    for node in SYNTAX_NODES where !node.kind.isBase {
      DeclSyntax(
        """
        /// Visiting ``\(node.kind.syntaxType)`` specifically.
        ///   - Parameter node: the node we are visiting.
        ///   - Returns: the sum of whatever the child visitors return.
        func visit(_ node: \(node.kind.syntaxType)) -> ResultType
        """
      )
    }
  }

  try! ExtensionDeclSyntax("extension SyntaxTransformVisitor") {
    DeclSyntax(
      """
      public func visit(_ token: TokenSyntax) -> ResultType {
        visitAny(Syntax(token))
      }
      """
    )

    for node in SYNTAX_NODES where !node.kind.isBase {
      DeclSyntax(
        """
        /// Visiting ``\(node.kind.syntaxType)`` specifically.
        ///   - Parameter node: the node we are visiting.
        ///   - Returns: nil by default.
        public func visit(_ node: \(node.kind.syntaxType)) -> ResultType {
          visitAny(Syntax(node))
        }
        """
      )
    }

    try FunctionDeclSyntax("public func visit(_ node: Syntax) -> ResultType") {
      try SwitchExprSyntax("switch node.as(SyntaxEnum.self)") {
        SwitchCaseSyntax("case .token(let node):") {
          StmtSyntax("return visit(node)")
        }
        for node in NON_BASE_SYNTAX_NODES {
          SwitchCaseSyntax("case .\(node.varOrCaseName)(let derived):") {
            StmtSyntax("return visit(derived)")
          }
        }
      }
    }

    DeclSyntax(
      """
      public func visit(_ node: ExprSyntax) -> ResultType {
        visit(Syntax(node))
      }
      """
    )

    DeclSyntax(
      """
      public func visit(_ node: PatternSyntax) -> ResultType {
        visit(Syntax(node))
      }
      """
    )

    DeclSyntax(
      """
      public func visit(_ node: TypeSyntax) -> ResultType {
        visit(Syntax(node))
      }
      """
    )

    DeclSyntax(
      """
      public func visit(_ node: some SyntaxChildChoices) -> ResultType {
        return visit(Syntax(node))
      }
      """
    )

    DeclSyntax(
      """
      public func visitChildren(_ node: some SyntaxProtocol) -> [ResultType] {
        let syntaxNode = Syntax(node)
        return NonNilRawSyntaxChildren(syntaxNode, viewMode: .sourceAccurate).map { rawChild in
          let child = Syntax(SyntaxData(rawChild, parent: syntaxNode))
          return visit(child)
        }
      }
      """
    )
  }
}
