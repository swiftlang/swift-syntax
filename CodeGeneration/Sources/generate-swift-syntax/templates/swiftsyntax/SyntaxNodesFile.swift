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

        DeclSyntax(
          """
          @_transparent
          init(unsafeCasting node: Syntax) {
            self._syntaxNode = node
          }
          """
        )

        let initSignature = InitSignature(node)

        try! InitializerDeclSyntax(
          """
          \(initSignature.generateInitializerDocComment())\
          \(initSignature.generateInitializerDeclHeader())
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
              ArrayElementSyntax(
                expression: MemberAccessExprSyntax(
                  base: child.buildableType.optionalChained(
                    expr: ExprSyntax("\(child.baseCallName)")
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
              LabeledExprSyntax(expression: ExprSyntax("(RawSyntaxArena(), (\(parameters)))"))
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

          let childType: TypeSyntax =
            child.kind.isNodeChoicesEmpty ? child.syntaxNodeKind.syntaxType : child.syntaxChoicesType
          let type = child.isOptional ? TypeSyntax("\(childType)?") : TypeSyntax("\(childType)")

          try! VariableDeclSyntax(
            """
            \(child.documentation)\
            \(child.apiAttributes)public var \(child.varDeclName): \(type)
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
                self = Syntax(self).replacingChild(at: \(raw: index), with: Syntax(value), rawAllocationArena: RawSyntaxArena()).cast(\(node.kind.syntaxType).self)
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
