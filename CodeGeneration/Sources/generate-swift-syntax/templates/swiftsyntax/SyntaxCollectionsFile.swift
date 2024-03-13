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

let syntaxCollectionsFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  for node in SYNTAX_NODES.compactMap(\.collectionNode) {
    let documentation = SwiftSyntax.Trivia(joining: [
      node.documentation,
      node.experimentalDocNote,
      node.grammar,
      node.containedIn,
    ])

    try! StructDeclSyntax(
      """
      \(documentation)\
      \(node.node.apiAttributes())\
      public struct \(node.kind.syntaxType): SyntaxCollection, SyntaxHashable
      """
    ) {
      if let onlyElement = node.elementChoices.only {
        DeclSyntax("public typealias Element = \(onlyElement.syntaxType)")
      } else {
        try EnumDeclSyntax(
          """
          public enum Element: SyntaxChildChoices, SyntaxHashable
          """
        ) {
          for choiceName in node.elementChoices {
            let choice = SYNTAX_NODE_MAP[choiceName]!
            DeclSyntax(
              """
              \(choice.apiAttributes())\
              case `\(choice.varOrCaseName)`(\(choice.kind.syntaxType))
              """
            )
          }

          try VariableDeclSyntax("public var _syntaxNode: Syntax") {
            SwitchExprSyntax(switchKeyword: .keyword(.switch), subject: ExprSyntax("self")) {
              for choiceName in node.elementChoices {
                let choice = SYNTAX_NODE_MAP[choiceName]!
                SwitchCaseSyntax("case .\(choice.varOrCaseName)(let node):") {
                  StmtSyntax("return node._syntaxNode")
                }
              }
            }
          }

          for choiceName in node.elementChoices {
            let choiceNode = SYNTAX_NODE_MAP[choiceName]!
            if choiceNode.kind.isBase {
              DeclSyntax(
                """
                \(choiceNode.apiAttributes())\
                public init(_ node: some \(choiceNode.kind.protocolType)) {
                  self = .\(choiceNode.varOrCaseName)(\(choiceNode.kind.syntaxType)(node))
                }
                """
              )

            } else {
              DeclSyntax(
                """
                \(choiceNode.apiAttributes())\
                public init(_ node: \(choiceNode.kind.syntaxType)) {
                  self = .\(choiceNode.varOrCaseName)(node)
                }
                """
              )
            }
          }

          try InitializerDeclSyntax("public init?(_ node: some SyntaxProtocol)") {
            for choiceName in node.elementChoices {
              let choiceNode = SYNTAX_NODE_MAP[choiceName]!
              StmtSyntax(
                """
                if let node = node.as(\(choiceNode.kind.syntaxType).self) {
                  self = .\(choiceNode.varOrCaseName)(node)
                  return
                }
                """
              )
            }

            StmtSyntax("return nil")
          }

          try VariableDeclSyntax("public static var structure: SyntaxNodeStructure") {
            let choices = ArrayExprSyntax {
              for choiceName in node.elementChoices {
                let choice = SYNTAX_NODE_MAP[choiceName]!
                ArrayElementSyntax(
                  leadingTrivia: .newline,
                  expression: ExprSyntax(".node(\(choice.kind.syntaxType).self)")
                )
              }
            }

            StmtSyntax("return .choices(\(choices))")
          }

          for choiceNodeName in node.elementChoices {
            let choiceNode = SYNTAX_NODE_MAP[choiceNodeName]!
            choiceNodeCastingMethods(for: choiceNode.kind)
          }
        }
      }

      DeclSyntax("public let _syntaxNode: Syntax")

      DeclSyntax(
        """
        public init?(_ node: some SyntaxProtocol) {
          guard node.raw.kind == .\(node.varOrCaseName) else { return nil }
          self._syntaxNode = node._syntaxNode
        }
        """
      )

      DeclSyntax("public static let syntaxKind = SyntaxKind.\(node.varOrCaseName)")
    }
  }
}
