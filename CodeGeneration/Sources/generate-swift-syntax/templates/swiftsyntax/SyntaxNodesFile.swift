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

/// This file generates the syntax nodes for SwiftSyntax. To keep the generated
/// files at a manageable file size, it is to be invoked multiple times with the
/// variable `emitKind` set to a base kind listed in
/// It then only emits those syntax nodes whose base kind are that specified kind.
func syntaxNode(nodesStartingWith: [Character]) -> SourceFileSyntax {
  SourceFileSyntax(leadingTrivia: copyrightHeader) {
    for node in SYNTAX_NODES.compactMap(\.layoutNode)
    where nodesStartingWith.contains(node.kind.syntaxType.description.droppingLeadingUnderscores.first!) {
      // We are actually handling this node now
      try! StructDeclSyntax(
        """
        // MARK: - \(node.kind.syntaxType)

        \(SwiftSyntax.Trivia(joining: [node.documentation, node.experimentalDocNote, node.grammar, node.containedIn]))\
        \(node.node.apiAttributes())\
        public struct \(node.kind.syntaxType): \(node.baseType.syntaxBaseName)Protocol, SyntaxHashable, \(node.base.leafProtocolType)
        """
      ) {
        for child in node.children {
          if let childChoiceDecl = try! generateSyntaxChildChoices(for: child) {
            childChoiceDecl
          }
        }

        // ==============
        // Initialization
        // ==============

        DeclSyntax("public let _syntaxNode: Syntax")

        DeclSyntax(
          """
          public init?(_ node: __shared some SyntaxProtocol) {
            guard node.raw.kind == .\(node.varOrCaseName) else { return nil }
            self._syntaxNode = node._syntaxNode
          }
          """
        )

        try! InitializerDeclSyntax(
          """
          \(node.generateInitializerDocComment())\
          \(node.generateInitializerDeclHeader())
          """
        ) {
          let parameters = ClosureParameterListSyntax {
            for child in node.children {
              ClosureParameterSyntax(firstName: child.varOrCaseName.backtickedIfNeeded)
            }
          }

          let closureSignature = ClosureSignatureSyntax(
            parameterClause: .parameterClause(
              ClosureParameterClauseSyntax(
                parameters: ClosureParameterListSyntax {
                  ClosureParameterSyntax(firstName: .identifier("arena"))
                  ClosureParameterSyntax(firstName: .wildcardToken())
                }
              )
            )
          )
          let layoutList = ArrayExprSyntax {
            for child in node.children {
              ArrayElementSyntax(
                expression: MemberAccessExprSyntax(
                  base: child.buildableType.optionalChained(
                    expr: ExprSyntax("\(child.varOrCaseName.backtickedIfNeeded)")
                  ),
                  period: .periodToken(),
                  name: "raw"
                )
              )
            }
          }

          let initializer = FunctionCallExprSyntax(
            calledExpression: ExprSyntax("withExtendedLifetime"),
            leftParen: .leftParenToken(),
            arguments: LabeledExprListSyntax {
              LabeledExprSyntax(expression: ExprSyntax("(SyntaxArena(), (\(parameters)))"))
            },
            rightParen: .rightParenToken(),
            trailingClosure: ClosureExprSyntax(signature: closureSignature) {
              if node.children.isEmpty {
                DeclSyntax("let raw = RawSyntax.makeEmptyLayout(kind: SyntaxKind.\(node.varOrCaseName), arena: arena)")
              } else {
                DeclSyntax("let layout: [RawSyntax?] = \(layoutList)")
                DeclSyntax(
                  """
                  let raw = RawSyntax.makeLayout(
                    kind: SyntaxKind.\(node.varOrCaseName),
                    from: layout,
                    arena: arena,
                    leadingTrivia: leadingTrivia,
                    trailingTrivia: trailingTrivia
                  )
                  """
                )
              }
              StmtSyntax("return Syntax.forRoot(raw, rawNodeArena: arena).cast(Self.self)")
            }
          )

          InfixOperatorExprSyntax(
            leadingTrivia: """
              // Extend the lifetime of all parameters so their arenas don't get destroyed
              // before they can be added as children of the new arena.

              """,
            leftOperand: ExprSyntax("self"),
            operator: ExprSyntax(AssignmentExprSyntax()),
            rightOperand: initializer
          )
        }

        for (index, child) in node.children.enumerated() {
          // ===================
          // Children properties
          // ===================

          let childType: TypeSyntax =
            child.kind.isNodeChoicesEmpty ? child.syntaxNodeKind.syntaxType : child.syntaxChoicesType
          let type = child.isOptional ? TypeSyntax("\(childType)?") : TypeSyntax("\(childType)")

          try! VariableDeclSyntax(
            """
            \(child.documentation)\
            \(child.apiAttributes)public var \(child.varOrCaseName.backtickedIfNeeded): \(type)
            """
          ) {
            AccessorDeclSyntax(accessorSpecifier: .keyword(.get)) {
              let optionalityMarker: TokenSyntax =
                child.isOptional ? .infixQuestionMarkToken() : .exclamationMarkToken()
              StmtSyntax("return Syntax(self).child(at: \(raw: index))\(optionalityMarker).cast(\(childType).self)")
            }

            AccessorDeclSyntax(
              """
              set(value) {
                self = Syntax(self).replacingChild(at: \(raw: index), with: Syntax(value), arena: SyntaxArena()).cast(\(node.kind.syntaxType).self)
              }
              """
            )
          }

          // ===============
          // Adding children
          // ===============
          // We don't currently support adding elements to a specific unexpected collection.
          // If needed, this could be added in the future, but for now withUnexpected should be sufficient.
          if let childNode = SYNTAX_NODE_MAP[child.syntaxNodeKind]?.collectionNode,
            !child.isUnexpectedNodes,
            case .collection(_, collectionElementName: let childElt, _, _) = child.kind
          {
            let childEltType = childNode.collectionElementType.syntaxBaseName

            DeclSyntax(
              """
              /// Adds the provided `element` to the node's `\(child.varOrCaseName)`
              /// collection.
              ///
              /// - param element: The new `\(raw: childElt)` to add to the node's
              ///                  `\(child.varOrCaseName)` collection.
              /// - returns: A copy of the receiver with the provided `\(raw: childElt)`
              ///            appended to its `\(child.varOrCaseName)` collection.
              @available(*, deprecated, message: "Use node.\(child.varOrCaseName).append(newElement) instead")
              public func add\(raw: childElt)(_ element: \(childEltType)) -> \(node.kind.syntaxType) {
                var collection: RawSyntax
                let arena = SyntaxArena()
                if let col = raw.layoutView!.children[\(raw: index)] {
                  collection = col.layoutView!.appending(element.raw, arena: arena)
                } else {
                  collection = RawSyntax.makeLayout(kind: SyntaxKind.\(childNode.varOrCaseName),
                                                    from: [element.raw], arena: arena)
                }
                return Syntax(self)
                  .replacingChild(at: \(raw: index), with: collection, rawNodeArena: arena, allocationArena: arena)
                  .cast(\(node.kind.syntaxType).self)
              }
              """
            )
          }
        }

        let layout = ArrayExprSyntax {
          for child in node.children {
            ArrayElementSyntax(
              expression: ExprSyntax(#"\Self.\#(child.varOrCaseName)"#)
            )
          }
        }
        "public static let structure: SyntaxNodeStructure = .layout(\(layout))"
      }
    }
  }
}

private func generateSyntaxChildChoices(for child: Child) throws -> EnumDeclSyntax? {
  guard case .nodeChoices(let choices) = child.kind else {
    return nil
  }

  return try! EnumDeclSyntax("public enum \(child.syntaxChoicesType): SyntaxChildChoices, SyntaxHashable") {
    for choice in choices {
      DeclSyntax("case `\(choice.varOrCaseName)`(\(choice.syntaxNodeKind.syntaxType))")
    }

    try! VariableDeclSyntax("public var _syntaxNode: Syntax") {
      try! SwitchExprSyntax("switch self") {
        for choice in choices {
          SwitchCaseSyntax("case .\(choice.varOrCaseName)(let node):") {
            StmtSyntax("return node._syntaxNode")
          }
        }
      }
    }

    for choice in choices {
      if let choiceNode = SYNTAX_NODE_MAP[choice.syntaxNodeKind], choiceNode.kind.isBase {
        DeclSyntax(
          """
          public init(_ node: some \(choiceNode.kind.protocolType)) {
            self = .\(choice.varOrCaseName)(\(choiceNode.kind.syntaxType)(node))
          }
          """
        )

      } else {
        DeclSyntax(
          """
          public init(_ node: \(choice.syntaxNodeKind.syntaxType)) {
            self = .\(choice.varOrCaseName)(node)
          }
          """
        )
      }
    }

    try! InitializerDeclSyntax("public init?(_ node: __shared some SyntaxProtocol)") {
      for choice in choices {
        StmtSyntax(
          """
          if let node = node.as(\(choice.syntaxNodeKind.syntaxType).self) {
            self = .\(choice.varOrCaseName)(node)
            return
          }
          """
        )
      }

      StmtSyntax("return nil")
    }

    try! VariableDeclSyntax("public static var structure: SyntaxNodeStructure") {
      let choices = ArrayExprSyntax {
        for choice in choices {
          ArrayElementSyntax(
            expression: ExprSyntax(".node(\(choice.syntaxNodeKind.syntaxType).self)")
          )
        }
      }

      StmtSyntax("return .choices(\(choices))")
    }

    for choiceNode in choices {
      choiceNodeCastingMethods(for: choiceNode.syntaxNodeKind)
    }
  }
}
