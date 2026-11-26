//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2026 Apple Inc. and the Swift project authors
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

/// Generates, for every layout node, a `RawSyntax.make<Kind>(...)` factory
/// that builds the node's ``RawSyntax`` from its children.
///
/// The factories live in SwiftSyntax so that building a node can inline
/// `RawSyntax.makeLayout`, whose storage mode and child count are constants at
/// each call site. The parser's typed raw nodes only unwrap their children and
/// call these.
func rawSyntaxFactoriesFile(nodesStartingWith: [Character]) -> SourceFileSyntax {
  return SourceFileSyntax(leadingTrivia: copyrightHeader) {
    try! ExtensionDeclSyntax("extension RawSyntax") {
      for node in SYNTAX_NODES.compactMap(\.layoutNode)
      where nodesStartingWith.contains(node.kind.syntaxType.description.droppingLeadingUnderscores.first!) {
        let params = FunctionParameterListSyntax {
          for child in node.children {
            FunctionParameterSyntax(
              firstName: child.isUnexpectedNodes ? .wildcardToken(trailingTrivia: .space) : child.labelDeclName,
              secondName: child.isUnexpectedNodes ? child.labelDeclName : nil,
              colon: .colonToken(),
              type: child.isOptional ? TypeSyntax("RawSyntax?") : TypeSyntax("RawSyntax")
            )
          }

          FunctionParameterSyntax("arena: __shared RawSyntaxArena")
        }

        try FunctionDeclSyntax(
          """
          \(node.node.apiAttributes(forRaw: true))\
          public static func \(node.kind.rawFactoryName)(\(params)) -> RawSyntax
          """
        ) {
          // A node that interleaves keeps its real children and its
          // `unexpected` slots in separate regions, real ones first, so that
          // the slots can be left out of a node that has nothing to put in
          // them. A node that does not interleave has only real children.
          let interleaves = node.interleavesUnexpectedChildren
          let realChildren = interleaves ? node.children.filter { !$0.isUnexpectedNodes } : node.children
          let unexpectedChildren = interleaves ? node.children.filter { $0.isUnexpectedNodes } : []

          let list = try CodeBlockItemListSyntax {
            for (index, child) in realChildren.enumerated() {
              ExprSyntax("layout.initializeElement(at: \(raw: index), to: \(child.baseCallName))")
            }
            if !unexpectedChildren.isEmpty {
              try IfExprSyntax("if hasUnexpected") {
                for (offset, child) in unexpectedChildren.enumerated() {
                  ExprSyntax(
                    "layout.initializeElement(at: \(raw: realChildren.count + offset), to: \(child.baseCallName))"
                  )
                }
              }
            }
          }

          // A kind interleaves `unexpected` slots exactly when its layout has any,
          // which is known here; whether one of them is occupied is not, so only an
          // interleaving node works that out.
          if !unexpectedChildren.isEmpty {
            let occupied = unexpectedChildren.map { "\($0.baseCallName) != nil" }.joined(separator: " || ")
            DeclSyntax("let hasUnexpected = \(raw: occupied)")
          }
          let storage =
            unexpectedChildren.isEmpty
            ? ".flat"
            : "hasUnexpected ? .layoutWithUnexpected : .layout"
          StmtSyntax(
            """
            return RawSyntax.makeLayout(
              kind: .\(node.memberCallName), childCount: \(raw: realChildren.count), storage: \(raw: storage), arena: arena) { layout in
              \(list)
            }
            """
          )
        }
      }
    }
  }
}

extension SyntaxNodeKind {
  /// The name of the `RawSyntax` factory that builds a node of this kind, e.g.
  /// `makeFunctionDecl` for `FunctionDeclSyntax`.
  var rawFactoryName: TokenSyntax {
    let typeName = syntaxType.description.droppingLeadingUnderscores
    precondition(typeName.hasSuffix("Syntax"))
    return .identifier("make\(typeName.dropLast("Syntax".count))")
  }
}
