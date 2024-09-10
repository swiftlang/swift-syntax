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
    where nodesStartingWith.contains(node.syntaxType.description.droppingLeadingUnderscores.first!) {
      // We are actually handling this node now
      try! StructDeclSyntax(
        """
        // MARK: - \(node.syntaxType)

        \(SwiftSyntax.Trivia(joining: [node.documentation, node.experimentalDocNote, node.grammar, node.containedIn]))\
        \(node.apiAttributes)\
        public struct \(node.syntaxType): \(node.baseKind.protocolType), SyntaxHashable, \(node.baseKind.leafProtocolType)
        """
      ) {
        for childNodeChoices in node.node.childrenNodeChoices() {
          childNodeChoices.enumDecl
        }

        // ==============
        // Initialization
        // ==============

        DeclSyntax("public let _syntaxNode: Syntax")

        DeclSyntax(
          """
          public init?(_ node: __shared some SyntaxProtocol) {
            guard node.raw.kind == .\(node.enumCaseCallName) else { return nil }
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
              ClosureParameterSyntax(firstName: child.varDeclName)
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
              let baseExpr = ExprSyntax("\(child.baseCallName)")
              ArrayElementSyntax(
                expression: MemberAccessExprSyntax(
                  base: child.isOptional ? "\(baseExpr)?" : baseExpr,
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
                DeclSyntax("let raw = RawSyntax.makeEmptyLayout(kind: SyntaxKind.\(node.memberCallName), arena: arena)")
              } else {
                DeclSyntax("let layout: [RawSyntax?] = \(layoutList)")
                DeclSyntax(
                  """
                  let raw = RawSyntax.makeLayout(
                    kind: SyntaxKind.\(node.memberCallName),
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

          try VariableDeclSyntax(
            """
            \(child.documentation)\
            \(child.apiAttributes)\
            public var \(child.varDeclName): \(child.actualType)
            """
          ) {
            AccessorDeclSyntax(accessorSpecifier: .keyword(.get)) {
              let optionalityMarker: TokenSyntax =
                child.isOptional ? .infixQuestionMarkToken() : .exclamationMarkToken()
              StmtSyntax(
                "return Syntax(self).child(at: \(raw: index))\(optionalityMarker).cast(\(child.syntaxType).self)"
              )
            }

            AccessorDeclSyntax(
              """
              set(value) {
                self = Syntax(self).replacingChild(at: \(raw: index), with: Syntax(value), arena: SyntaxArena()).cast(\(node.syntaxType).self)
              }
              """
            )
          }

          // ===============
          // Adding children
          // ===============
          // We don't currently support adding elements to a specific unexpected collection.
          // If needed, this could be added in the future, but for now withUnexpected should be sufficient.
          if let childNode = child.node?.collectionNode,
            !child.isUnexpectedNodes,
            case .collection(_, collectionElementName: let childElt, _, _) = child.kind
          {
            let childEltType = childNode.collectionElementType.syntaxType

            DeclSyntax(
              """
              /// Adds the provided `element` to the node's `\(child.identifier)`
              /// collection.
              ///
              /// - param element: The new `\(raw: childElt)` to add to the node's
              ///                  `\(child.identifier)` collection.
              /// - returns: A copy of the receiver with the provided `\(raw: childElt)`
              ///            appended to its `\(child.identifier)` collection.
              @available(*, deprecated, message: "Use node.\(child.identifier).append(newElement) instead")
              public func add\(raw: childElt)(_ element: \(childEltType)) -> \(node.syntaxType) {
                var collection: RawSyntax
                let arena = SyntaxArena()
                if let col = raw.layoutView!.children[\(raw: index)] {
                  collection = col.layoutView!.appending(element.raw, arena: arena)
                } else {
                  collection = RawSyntax.makeLayout(kind: SyntaxKind.\(childNode.memberCallName),
                                                    from: [element.raw], arena: arena)
                }
                return Syntax(self)
                  .replacingChild(at: \(raw: index), with: collection, rawNodeArena: arena, allocationArena: arena)
                  .cast(\(node.syntaxType).self)
              }
              """
            )
          }
        }

        let layout = ArrayExprSyntax {
          for child in node.children {
            ArrayElementSyntax(
              expression: ExprSyntax(#"\Self.\#(child.memberCallName)"#)
            )
          }
        }
        "public static let structure: SyntaxNodeStructure = .layout(\(layout))"
      }
    }
  }
}

extension ChildNodeChoices {
  var enumDecl: EnumDeclSyntax {
    try! EnumDeclSyntax("public enum \(self.name): SyntaxChildChoices, SyntaxHashable") {
      for choice in self.choices {
        choice.enumCaseDecl
      }

      self.syntaxGetter(propertyName: "_syntaxNode", propertyType: "Syntax")

      for choice in self.choices {
        choice.baseTypeInitDecl(hasArgumentName: false) ?? choice.concreteTypeInitDecl
      }

      self.syntaxInitDecl(inputType: "__shared some SyntaxProtocol")

      try! VariableDeclSyntax("public static var structure: SyntaxNodeStructure") {
        let choices = ArrayExprSyntax {
          for choice in self.choices {
            ArrayElementSyntax(
              expression: ExprSyntax(".node(\(choice.syntaxType).self)")
            )
          }
        }

        StmtSyntax("return .choices(\(choices))")
      }

      for choice in self.choices {
        choice.castingMethods
      }
    }
  }
}
