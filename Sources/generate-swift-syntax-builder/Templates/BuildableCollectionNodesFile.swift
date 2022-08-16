//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder

let buildableCollectionNodesFile = SourceFile {
  ImportDecl(
    leadingTrivia: .docLineComment(copyrightHeader),
    path: "SwiftSyntax"
  )

  for node in SYNTAX_NODES where node.isSyntaxCollection {
    let type = node.type
    let elementType = node.collectionElementType
    let conformances = ["ExpressibleByArrayLiteral", "SyntaxBuildable", type.expressibleAsBaseName]
    
    // Generate collection node struct
    StructDecl(
      leadingTrivia: node.documentation.isEmpty
        ? []
        : .docLineComment("/// \(node.documentation)") + .newline,
      modifiers: [TokenSyntax.public],
      identifier: type.buildableBaseName,
      inheritanceClause: createTypeInheritanceClause(conformances: conformances)
    ) {
      VariableDecl(.let, name: "elements", type: ArrayType(elementType: elementType.buildable))

      // Generate initializers
      createArrayInitializer(node: node)
      createCombiningInitializer(node: node)
      createArrayLiteralInitializer(node: node)

      // Generate function declarations
      createBuildFunction(node: node)
      createBuildSyntaxFunction(node: node)
      createExpressibleAsCreateFunction(type: type)
      createDisambiguatingExpressibleAsCreateFunction(type: type, baseType: .init(syntaxKind: "Syntax"))
    }

    // For nodes without expressible-as conformances, conform Array to the corresponding expressible-as
    if type.generatedExpressibleAsConformances.isEmpty {
      ExtensionDecl(
        extendedType: "Array",
        inheritanceClause: TypeInheritanceClause {
          InheritedType(typeName: type.expressibleAs)
        },
        genericWhereClause: GenericWhereClause {
          GenericRequirement(body: SameTypeRequirement(
            leftTypeIdentifier: "Element",
            equalityToken: .spacedBinaryOperator("=="),
            rightTypeIdentifier: elementType.expressibleAs
          ))
        }
      ) {
        FunctionDecl(
          modifiers: [TokenSyntax.public],
          identifier: .identifier("create\(type.buildableBaseName)"),
          signature: FunctionSignature(
            input: ParameterClause(),
            output: type.buildable
          )
        ) {
          ReturnStmt(expression: FunctionCallExpr(type.buildableBaseName) {
            TupleExprElement(expression: "self")
          })
        }
      }
    }
  }
}

/// Generate an initializer taking an array of elements.
private func createArrayInitializer(node: Node) -> InitializerDecl {
  let type = node.type
  let elementType = node.collectionElementType
  return InitializerDecl(
    leadingTrivia: [
      "/// Creates a `\(type.buildableBaseName)` with the provided list of elements.",
      "/// - Parameters:",
      "///   - elements: A list of `\(elementType.expressibleAsBaseName)`",
    ].map { .docLineComment($0) + .newline }.reduce([], +),
    modifiers: [TokenSyntax.public],
    signature: FunctionSignature(
      input: ParameterClause {
        FunctionParameter(
          firstName: .wildcard,
          secondName: .identifier("elements"),
          colon: .colon,
          type: ArrayType(elementType: elementType.expressibleAs)
        )
      }
    )
  ) {
    SequenceExpr {
      MemberAccessExpr(base: "self", name: "elements")
      AssignmentExpr()
      if elementType.isToken {
        "elements"
      } else {
        FunctionCallExpr(MemberAccessExpr(base: "elements", name: "map"), trailingClosure: ClosureExpr {
          FunctionCallExpr(MemberAccessExpr(base: "$0", name: "create\(elementType.buildableBaseName)"))
        })
      }
    }
  }
}

/// Generate a flattening initializer taking an array of collections.
private func createCombiningInitializer(node: Node) -> InitializerDecl {
  let type = node.type
  return InitializerDecl(
    leadingTrivia: .docLineComment("/// Creates a new `\(type.buildableBaseName)` by flattening the elements in `lists`") + .newline,
    modifiers: [TokenSyntax.public],
    signature: FunctionSignature(
      input: ParameterClause {
        FunctionParameter(
          firstName: .identifier("combining").withTrailingTrivia(.space),
          secondName: .identifier("lists"),
          colon: .colon,
          type: ArrayType(elementType: type.expressibleAs)
        )
      }
    )
  ) {
    SequenceExpr {
      "elements"
      AssignmentExpr()
      FunctionCallExpr(MemberAccessExpr(base: "lists", name: "flatMap"), trailingClosure: ClosureExpr {
        MemberAccessExpr(
          base: FunctionCallExpr(MemberAccessExpr(base: "$0", name: "create\(type.buildableBaseName)")),
          name: "elements"
        )
      })
    }
  }
}

/// Generate the initializer for the `ExpressibleByArrayLiteral` conformance.
private func createArrayLiteralInitializer(node: Node) -> InitializerDecl {
  let elementType = node.collectionElementType
  return InitializerDecl(
    modifiers: [TokenSyntax.public],
    signature: FunctionSignature(
      input: ParameterClause {
        FunctionParameter(
          firstName: .identifier("arrayLiteral").withTrailingTrivia(.space),
          secondName: .identifier("elements"),
          colon: .colon,
          type: elementType.expressibleAs,
          ellipsis: .ellipsis
        )
      }
    )
  ) {
    FunctionCallExpr(MemberAccessExpr(base: "self", name: "init")) {
      TupleExprElement(expression: "elements")
    }
  }
}

/// Generate the function building the collection syntax.
private func createBuildFunction(node: Node) -> FunctionDecl {
  let type = node.type
  let elementType = node.collectionElementType
  return FunctionDecl(
    modifiers: [TokenSyntax.public],
    identifier: .identifier("build\(type.baseName)"),
    signature: FunctionSignature(
      input: createFormatLeadingTriviaParameters(withDefaultTrivia: true),
      output: type.syntax
    )
  ) {
    VariableDecl(
      .let,
      name: "result",
      initializer: FunctionCallExpr("\(type.syntaxBaseName)") {
        if elementType.isToken {
          TupleExprElement(expression: "elements")
        } else {
          TupleExprElement(
            expression: FunctionCallExpr(MemberAccessExpr(base: "elements", name: "map"), trailingClosure: ClosureExpr {
              FunctionCallExpr(MemberAccessExpr(base: "$0", name: "build\(elementType.baseName)")) {
                TupleExprElement(label: "format", expression: "format")
                TupleExprElement(
                  label: "leadingTrivia",
                  expression: node.elementsSeparatedByNewline
                    ? SequenceExpr {
                        MemberAccessExpr(base: "Trivia", name: "newline")
                        BinaryOperatorExpr("+")
                        FunctionCallExpr(MemberAccessExpr(base: "format", name: "_makeIndent"))
                      }
                    : NilLiteralExpr()
                )
              }
            })
          )
        }
      }
    )
    IfStmt(
      conditions: OptionalBindingCondition(
        letOrVarKeyword: .let,
        pattern: "leadingTrivia",
        initializer: "leadingTrivia"
      )
    ) {
      ReturnStmt(expression: FunctionCallExpr(MemberAccessExpr(base: "result", name: "withLeadingTrivia")) {
        TupleExprElement(expression: FunctionCallExpr(MemberAccessExpr(
          base: TupleExpr {
            SequenceExpr {
              "leadingTrivia"
              BinaryOperatorExpr("+")
              TupleExpr {
                SequenceExpr {
                  MemberAccessExpr(base: "result", name: "leadingTrivia")
                  BinaryOperatorExpr("??")
                  ArrayExpr {}
                }
              }
            }
          },
          name: "addingSpacingAfterNewlinesIfNeeded"
        )))
      })
    } elseBody: {
      ReturnStmt(expression: "result")
    }
  }
}

/// Generate the function building the syntax.
private func createBuildSyntaxFunction(node: Node) -> FunctionDecl {
  let type = node.type
  return FunctionDecl(
    modifiers: [TokenSyntax.public],
    identifier: .identifier("buildSyntax"),
    signature: FunctionSignature(
      input: createFormatLeadingTriviaParameters(withDefaultTrivia: true),
      output: "Syntax"
    )
  ) {
    ReturnStmt(expression: FunctionCallExpr("Syntax") {
      TupleExprElement(expression: FunctionCallExpr("build\(type.baseName)") {
        TupleExprElement(label: "format", expression: "format")
        TupleExprElement(label: "leadingTrivia", expression: "leadingTrivia")
      })
    })
  }
}
