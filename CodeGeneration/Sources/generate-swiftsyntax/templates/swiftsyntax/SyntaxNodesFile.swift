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

extension Child {
  public var docComment: SwiftSyntax.Trivia {
    guard let description = documentation else {
      return []
    }
    let dedented = dedented(string: description)
    let lines = dedented.split(separator: "\n", omittingEmptySubsequences: false)
    let pieces = lines.map { SwiftSyntax.TriviaPiece.docLineComment("/// \($0)") }
    return Trivia(pieces: pieces)
  }
}

/// This file generates the syntax nodes for SwiftSyntax. To keep the generated
/// files at a managable file size, it is to be invoked multiple times with the
/// variable `emitKind` set to a base kind listed in
/// It then only emits those syntax nodes whose base kind are that specified kind.
func syntaxNode(emitKind: SyntaxNodeKind) -> SourceFileSyntax {
  SourceFileSyntax(leadingTrivia: copyrightHeader) {
    for node in SYNTAX_NODES.compactMap(\.layoutNode) where node.base == emitKind {
      // We are actually handling this node now
      try! StructDeclSyntax(
        """
        // MARK: - \(raw: node.kind.syntaxType)

        \(raw: node.documentation)
        \(raw: node.documentation.isEmpty ? "" : "///")
        \(raw: node.grammar)
        public struct \(raw: node.kind.syntaxType): \(raw: node.baseType.syntaxBaseName)Protocol, SyntaxHashable
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
          public init?(_ node: some SyntaxProtocol) {
            guard node.raw.kind == .\(raw: node.varOrCaseName) else { return nil }
            self._syntaxNode = node._syntaxNode
          }
          """
        )

        DeclSyntax(
          """
          /// Creates a ``\(node.kind.syntaxType)`` node from the given ``SyntaxData``. This assumes
          /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
          /// is undefined.
          internal init(_ data: SyntaxData) {
            precondition(data.raw.kind == .\(raw: node.varOrCaseName))
            self._syntaxNode = Syntax(data)
          }
          """
        )

        try! InitializerDeclSyntax("\(node.generateInitializerDeclHeader())") {
          let parameters = ClosureParameterListSyntax {
            for child in node.children {
              ClosureParameterSyntax(firstName: .identifier(child.varName.backtickedIfNeeded))
            }
          }

          let closureSignature = ClosureSignatureSyntax(
            input: .input(
              ClosureParameterClauseSyntax(
                parameterList: ClosureParameterListSyntax {
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
                  base: child.type.optionalChained(expr: ExprSyntax("\(raw: child.varName.backtickedIfNeeded)")),
                  dot: .periodToken(),
                  name: "raw"
                )
              )
            }
          }

          let initializer = FunctionCallExprSyntax(
            calledExpression: ExprSyntax("withExtendedLifetime"),
            leftParen: .leftParenToken(),
            argumentList: TupleExprElementListSyntax {
              TupleExprElementSyntax(expression: ExprSyntax("(SyntaxArena(), (\(parameters)))"))
            },
            rightParen: .rightParenToken(),
            trailingClosure: ClosureExprSyntax(signature: closureSignature) {
              if node.children.isEmpty {
                DeclSyntax("let raw = RawSyntax.makeEmptyLayout(kind: SyntaxKind.\(raw: node.varOrCaseName), arena: arena)")
              } else {
                DeclSyntax("let layout: [RawSyntax?] = \(layoutList)")
                DeclSyntax(
                  """
                  let raw = RawSyntax.makeLayout(
                    kind: SyntaxKind.\(raw: node.varOrCaseName),
                    from: layout,
                    arena: arena,
                    leadingTrivia: leadingTrivia,
                    trailingTrivia: trailingTrivia
                  )
                  """
                )
              }
              StmtSyntax("return SyntaxData.forRoot(raw, rawNodeArena: arena)")
            }
          )

          VariableDeclSyntax(
            leadingTrivia: """
              // Extend the lifetime of all parameters so their arenas don't get destroyed
              // before they can be added as children of the new arena.

              """,
            .let,
            name: PatternSyntax("data"),
            type: TypeAnnotationSyntax(type: TypeSyntax("SyntaxData")),
            initializer: InitializerClauseSyntax(value: initializer)
          )

          ExprSyntax("self.init(data)")
        }

        for (index, child) in node.children.enumerated() {
          // ===================
          // Children properties
          // ===================

          let childType: TypeSyntax = child.kind.isNodeChoicesEmpty ? child.syntaxNodeKind.syntaxType : "\(raw: child.name)"
          let type = child.isOptional ? TypeSyntax("\(raw: childType)?") : TypeSyntax("\(raw: childType)")

          try! VariableDeclSyntax(
            """
            \(raw: child.docComment)
            public var \(raw: child.varName.backtickedIfNeeded): \(type)
            """
          ) {
            AccessorDeclSyntax(accessorKind: .keyword(.get)) {
              if child.isOptional {
                StmtSyntax("return data.child(at: \(raw: index), parent: Syntax(self)).map(\(raw: childType).init)")
              } else {
                StmtSyntax("return \(raw: childType)(data.child(at: \(raw: index), parent: Syntax(self))!)")
              }
            }

            AccessorDeclSyntax(
              """
              set(value) {
                self = \(node.kind.syntaxType)(data.replacingChild(at: \(raw: index), with: value\(raw: child.isOptional ? "?" : "").data, arena: SyntaxArena()))
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
            case .collection(_, let childElt, _) = child.kind
          {
            let childEltType = childNode.collectionElementType.syntaxBaseName

            DeclSyntax(
              """
              /// Adds the provided `element` to the node's `\(raw: child.varName)`
              /// collection.
              /// - param element: The new `\(raw: childElt)` to add to the node's
              ///                  `\(raw: child.varName)` collection.
              /// - returns: A copy of the receiver with the provided `\(raw: childElt)`
              ///            appended to its `\(raw: child.varName)` collection.
              public func add\(raw: childElt)(_ element: \(raw: childEltType)) -> \(node.kind.syntaxType) {
                var collection: RawSyntax
                let arena = SyntaxArena()
                if let col = raw.layoutView!.children[\(raw: index)] {
                  collection = col.layoutView!.appending(element.raw, arena: arena)
                } else {
                  collection = RawSyntax.makeLayout(kind: SyntaxKind.\(raw: childNode.varOrCaseName),
                                                    from: [element.raw], arena: arena)
                }
                let newData = data.replacingChild(at: \(raw: index), with: collection, rawNodeArena: arena, allocationArena: arena)
                return \(node.kind.syntaxType)(newData)
              }
              """
            )
          }
        }

        try! VariableDeclSyntax("public static var structure: SyntaxNodeStructure") {
          let layout = ArrayExprSyntax {
            for child in node.children {
              ArrayElementSyntax(
                expression: ExprSyntax(#"\Self.\#(raw: child.varName)"#)
              )
            }
          }

          StmtSyntax("return .layout(\(layout))")
        }
      }
    }
  }
}

private func generateSyntaxChildChoices(for child: Child) throws -> EnumDeclSyntax? {
  guard case .nodeChoices(let choices) = child.kind else {
    return nil
  }

  return try! EnumDeclSyntax("public enum \(raw: child.name): SyntaxChildChoices") {
    for choice in choices {
      DeclSyntax("case `\(raw: choice.varName)`(\(raw: choice.syntaxNodeKind.syntaxType))")
    }

    try! VariableDeclSyntax("public var _syntaxNode: Syntax") {
      try! SwitchExprSyntax("switch self") {
        for choice in choices {
          SwitchCaseSyntax("case .\(raw: choice.varName)(let node):") {
            StmtSyntax("return node._syntaxNode")
          }
        }
      }
    }

    DeclSyntax("init(_ data: SyntaxData) { self.init(Syntax(data))! }")

    for choice in choices {
      if let choiceNode = SYNTAX_NODE_MAP[choice.syntaxNodeKind], choiceNode.kind.isBase {
        DeclSyntax(
          """
          public init(_ node: some \(choiceNode.kind.protocolType)) {
            self = .\(raw: choice.varName)(\(choiceNode.kind.syntaxType)(node))
          }
          """
        )

      } else {
        DeclSyntax(
          """
          public init(_ node: \(choice.syntaxNodeKind.syntaxType)) {
            self = .\(raw: choice.varName)(node)
          }
          """
        )
      }
    }

    try! InitializerDeclSyntax("public init?(_ node: some SyntaxProtocol)") {
      for choice in choices {
        StmtSyntax(
          """
          if let node = node.as(\(choice.syntaxNodeKind.syntaxType).self) {
            self = .\(raw: choice.varName)(node)
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
  }
}
