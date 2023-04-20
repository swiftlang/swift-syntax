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
/// files at a managable file size, it is to be invoked multiple times with the
/// variable `emitKind` set to a base kind listed in
/// It then only emits those syntax nodes whose base kind are that specified kind.
func syntaxNode(emitKind: String) -> SourceFileSyntax {
  SourceFileSyntax(leadingTrivia: copyrightHeader) {
    for node in SYNTAX_NODES where !node.isBase && node.collectionElement.isEmpty && node.baseKind == emitKind {
      // We are actually handling this node now
      let nodeDoc = node.description?.split(separator: "\n", omittingEmptySubsequences: false).map { "/// \($0)" }.joined(separator: "\n")
      try! StructDeclSyntax(
        """
        // MARK: - \(raw: node.name)

        \(raw: nodeDoc ?? "")
        public struct \(raw: node.name): \(raw: node.baseType.syntaxBaseName)Protocol, SyntaxHashable
        """
      ) {
        for child in node.children {
          if let childChoiceDecl = try generateSyntaxChildChoices(for: child) {
            childChoiceDecl
          }
        }

        // ==============
        // Initialization
        // ==============

        DeclSyntax("public let _syntaxNode: Syntax")

        DeclSyntax(
          """
          public init?<S: SyntaxProtocol>(_ node: S) {
            guard node.raw.kind == .\(raw: node.swiftSyntaxKind) else { return nil }
            self._syntaxNode = node._syntaxNode
          }
          """
        )

        DeclSyntax(
          """
          /// Creates a `\(raw: node.name)` node from the given `SyntaxData`. This assumes
          /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
          /// is undefined.
          internal init(_ data: SyntaxData) {
            precondition(data.raw.kind == .\(raw: node.swiftSyntaxKind))
            self._syntaxNode = Syntax(data)
          }
          """
        )

        try! InitializerDeclSyntax("\(node.generateInitializerDeclHeader(optionalBaseAsMissing: false))") {
          let parameters = ClosureParameterListSyntax {
            for child in node.children {
              ClosureParameterSyntax(firstName: .identifier(child.swiftName))
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
                  base: child.type.optionalChained(expr: ExprSyntax("\(raw: child.swiftName)")),
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
                DeclSyntax("let raw = RawSyntax.makeEmptyLayout(kind: SyntaxKind.\(raw: node.swiftSyntaxKind), arena: arena)")
              } else {
                DeclSyntax("let layout: [RawSyntax?] = \(layoutList)")
                DeclSyntax(
                  """
                  let raw = RawSyntax.makeLayout(
                    kind: SyntaxKind.\(raw: node.swiftSyntaxKind),
                    from: layout,
                    arena: arena,
                    leadingTrivia: leadingTrivia,
                    trailingTrivia: trailingTrivia
                  )
                  """
                )
              }
              StmtSyntax("return SyntaxData.forRoot(raw)")
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

        if node.hasOptionalBaseTypeChild {
          // TODO: Remove when we no longer support compiling in Swift 5.6. Change the
          // above constructor to use `Optional<BaseType>.none` instead.
          try InitializerDeclSyntax(
            """
            /// This initializer exists solely because Swift 5.6 does not support
            /// `Optional<ConcreteType>.none` as a default value of a generic parameter.
            /// The above initializer thus defaults to `nil` instead, but that means it
            /// is not actually callable when either not passing the defaulted parameter,
            /// or passing `nil`.
            ///
            /// Hack around that limitation using this initializer, which takes a
            /// `Missing*` syntax node instead. `Missing*` is used over the base type as
            /// the base type would allow implicit conversion from a string literal,
            /// which the above initializer doesn't support.
            \(node.generateInitializerDeclHeader(optionalBaseAsMissing: true))
            """
          ) {
            FunctionCallExprSyntax(callee: ExprSyntax("self.init")) {
              TupleExprElementSyntax(label: "leadingTrivia", expression: ExprSyntax("leadingTrivia"))
              for child in node.children {
                if child.hasOptionalBaseType {
                  TupleExprElementSyntax(
                    leadingTrivia: .newline,
                    label: .identifier(child.swiftName),
                    colon: .colonToken(),
                    expression: ExprSyntax("Optional<\(raw: child.typeName)>.none")
                  )
                } else if child.isUnexpectedNodes {
                  TupleExprElementSyntax(
                    leadingTrivia: .newline,
                    expression: ExprSyntax("\(raw: child.swiftName)")
                  )
                } else {
                  TupleExprElementSyntax(
                    leadingTrivia: .newline,
                    label: .identifier(child.swiftName),
                    colon: .colonToken(),
                    expression: ExprSyntax("\(raw: child.swiftName)")
                  )
                }
              }
              TupleExprElementSyntax(label: "trailingTrivia", expression: ExprSyntax("trailingTrivia"))
            }
          }
        }

        for (index, child) in node.children.enumerated() {
          // ===================
          // Children properties
          // ===================

          let childType: String = child.kind.isNodeChoicesEmpty ? child.typeName : child.name
          let type = child.isOptional ? TypeSyntax("\(raw: childType)?") : TypeSyntax("\(raw: childType)")
          let childDoc = child.description.map { dedented(string: $0) }.map { Trivia.docLineComment("/// \($0)") }

          try VariableDeclSyntax(
            """
            \(raw: childDoc ?? [])
            public var \(raw: child.swiftName): \(type)
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
                self = \(raw: node.name)(data.replacingChild(at: \(raw: index), with: value\(raw: child.isOptional ? "?" : "").raw, arena: SyntaxArena()))
              }
              """
            )
          }

          // ===============
          // Adding children
          // ===============
          // We don't currently support adding elements to a specific unexpected collection.
          // If needed, this could be added in the future, but for now withUnexpected should be sufficient.
          if let childNode = SYNTAX_NODE_MAP[child.syntaxKind],
            childNode.isSyntaxCollection,
            !child.isUnexpectedNodes,
            case .collection(_, let childElt) = child.kind
          {
            let childEltType = childNode.collectionElementType.syntaxBaseName

            DeclSyntax(
              """
              /// Adds the provided `\(raw: childElt)` to the node's `\(raw: child.swiftName)`
              /// collection.
              /// - param element: The new `\(raw: childElt)` to add to the node's
              ///                  `\(raw: child.swiftName)` collection.
              /// - returns: A copy of the receiver with the provided `\(raw: childElt)`
              ///            appended to its `\(raw: child.swiftName)` collection.
              public func add\(raw: childElt)(_ element: \(raw: childEltType)) -> \(raw: node.name) {
                var collection: RawSyntax
                let arena = SyntaxArena()
                if let col = raw.layoutView!.children[\(raw: index)] {
                  collection = col.layoutView!.appending(element.raw, arena: arena)
                } else {
                  collection = RawSyntax.makeLayout(kind: SyntaxKind.\(raw: childNode.swiftSyntaxKind),
                                                    from: [element.raw], arena: arena)
                }
                let newData = data.replacingChild(at: \(raw: index), with: collection, arena: arena)
                return \(raw: node.name)(newData)
              }
              """
            )
          }
        }

        try! VariableDeclSyntax("public static var structure: SyntaxNodeStructure") {
          let layout = ArrayExprSyntax {
            for child in node.children {
              ArrayElementSyntax(
                expression: ExprSyntax(#"\Self.\#(raw: child.swiftName)"#)
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

  return try EnumDeclSyntax("public enum \(raw: child.name): SyntaxChildChoices") {
    for choice in choices {
      DeclSyntax("case `\(raw: choice.swiftName)`(\(raw: choice.typeName))")
    }

    try! VariableDeclSyntax("public var _syntaxNode: Syntax") {
      try! SwitchExprSyntax("switch self") {
        for choice in choices {
          SwitchCaseSyntax("case .\(raw: choice.swiftName)(let node):") {
            StmtSyntax("return node._syntaxNode")
          }
        }
      }
    }

    DeclSyntax("init(_ data: SyntaxData) { self.init(Syntax(data))! }")

    for choice in choices {
      if let choiceNode = SYNTAX_NODE_MAP[choice.syntaxKind], choiceNode.isBase {
        DeclSyntax(
          """
          public init<Node: \(raw: choiceNode.name)Protocol>(_ node: Node) {
            self = .\(raw: choice.swiftName)(\(raw: choiceNode.name)(node))
          }
          """
        )

      } else {
        DeclSyntax(
          """
          public init(_ node: \(raw: choice.typeName)) {
            self = .\(raw: choice.swiftName)(node)
          }
          """
        )
      }
    }

    try! InitializerDeclSyntax("public init?<S: SyntaxProtocol>(_ node: S)") {
      for choice in choices {
        StmtSyntax(
          """
          if let node = node.as(\(raw: choice.typeName).self) {
            self = .\(raw: choice.swiftName)(node)
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
            expression: ExprSyntax(".node(\(raw: choice.typeName).self)")
          )
        }
      }

      StmtSyntax("return .choices(\(choices))")
    }
  }
}

fileprivate extension Node {
  func generateInitializerDeclHeader(optionalBaseAsMissing: Bool) -> PartialSyntaxNodeString {
    if children.isEmpty {
      return "public init()"
    }

    var genericParamNames: [String: Int] = [:]
    var genericParams: [String] = []

    func createFunctionParameterSyntax(for child: Child) -> FunctionParameterSyntax {
      var paramType: String
      if !child.kind.isNodeChoicesEmpty {
        paramType = child.name
      } else if child.hasBaseType {
        if optionalBaseAsMissing {
          paramType = "Missing\(child.typeName)"
        } else {
          // If we have a base type, make the initializer generic over its
          // protocol instead.
          let index = child.swiftName.index(child.swiftName.startIndex, offsetBy: 1)
          paramType = child.swiftName[..<index].uppercased()

          let paramCount = (genericParamNames[paramType] ?? 0) + 1
          genericParamNames[paramType] = paramCount

          if paramCount > 1 {
            paramType += "\(paramCount)"
          }
          genericParams.append("\(paramType): \(child.typeName)Protocol")
        }
      } else {
        paramType = child.typeName
      }

      if child.isOptional {
        paramType += "?"
      }

      return FunctionParameterSyntax(
        leadingTrivia: .newline,
        firstName: child.isUnexpectedNodes ? .wildcardToken(trailingTrivia: .space) : .identifier(child.swiftName),
        secondName: child.isUnexpectedNodes ? .identifier(child.swiftName) : nil,
        colon: .colonToken(),
        type: TypeSyntax(stringLiteral: paramType),
        defaultArgument: child.defaultInitialization
      )
    }

    let params = FunctionParameterListSyntax {
      FunctionParameterSyntax("leadingTrivia: Trivia? = nil")

      for child in children {
        createFunctionParameterSyntax(for: child)
      }

      FunctionParameterSyntax("trailingTrivia: Trivia? = nil")
        .with(\.leadingTrivia, .newline)
    }

    if genericParams.isEmpty {
      return """
        public init(
        \(params)
        )
        """
    } else {
      let generics = GenericParameterClauseSyntax(
        genericParameterList: GenericParameterListSyntax {
          for param in genericParams {
            GenericParameterSyntax(name: .identifier(param))
          }
        }
      )

      return """
        public init\(generics)(
        \(params)
        )
        """
    }
  }
}
