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
import SyntaxSupport
import Utils
import SwiftBasicFormat

let buildableCollectionNodesFile = SourceFile {
  ImportDecl(
    leadingTrivia: .docLineComment(copyrightHeader),
    path: "SwiftSyntax"
  )
  ImportDecl(
    trailingTrivia: .newline,
    path: "SwiftBasicFormat"
  )

  let triviaSides = ["leading", "trailing"]
  let trivias = triviaSides.map { "\($0)Trivia" }

  for node in SYNTAX_NODES where node.isSyntaxCollection {
    let type = node.type
    let elementType = node.collectionElementType
    let conformances = ["ExpressibleByArrayLiteral", "SyntaxBuildable", type.expressibleAsBaseName]
    
    // Generate collection node struct
    StructDecl(
      leadingTrivia: node.documentation.isEmpty
        ? []
        : .docLineComment("/// \(node.documentation)") + .newline,
      modifiers: [Token.public],
      identifier: type.buildableBaseName,
      inheritanceClause: createTypeInheritanceClause(conformances: conformances)
    ) {
      for (side, trivia) in zip(triviaSides, trivias) {
        VariableDecl(
          """
          /// The \(side) trivia attached to this syntax node once built.
          var \(trivia): Trivia = []
          """
        )
      }

      VariableDecl(.let, name: "elements", type: ArrayType(elementType: elementType.buildable))

      // Generate initializers
      createArrayInitializer(node: node)
      createCombiningInitializer(node: node)
      createArrayLiteralInitializer(node: node)

      // Generate function declarations
      createBuildFunction(node: node, trivias: trivias)
      createBuildSyntaxFunction(node: node)
      createExpressibleAsCreateFunction(type: type)
      createDisambiguatingExpressibleAsCreateFunction(type: type, baseType: .init(syntaxKind: "Syntax"))

      for trivia in trivias {
        createWithTriviaFunction(trivia: trivia)
      }
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
          """
          public func create\(type.buildableBaseName)() -> \(type.buildable) {
            return \(type.buildableBaseName)(self)
          }
          """
        )
      }
    }
  }
}

/// Generate an initializer taking an array of elements.
private func createArrayInitializer(node: Node) -> InitializerDecl {
  let type = node.type
  let elementType = node.collectionElementType
  var elementsInit: ExprBuildable = IdentifierExpr("elements")
  if !elementType.isToken {
    elementsInit = FunctionCallExpr(
      calledExpression: MemberAccessExpr(base: elementsInit, name: "map"),
      trailingClosure: ClosureExpr(" { $0.create\(elementType.buildableBaseName)() }")
    )
  }
  return InitializerDecl(
    """
    /// Creates a `\(type.buildableBaseName)` with the provided list of elements.
    /// - Parameters:
    ///   - elements: A list of `\(elementType.expressibleAsBaseName)`
    public init(_ elements: \(ArrayType(elementType: elementType.expressibleAs))) {
      self.elements = \(elementsInit)
    }
    """
  )
}

/// Generate a flattening initializer taking an array of collections.
private func createCombiningInitializer(node: Node) -> InitializerDecl {
  let type = node.type
  return InitializerDecl(
    """
    /// Creates a new `\(type.buildableBaseName)` by flattening the elements in `lists`
    public init(combining lists: \(ArrayType(elementType: type.expressibleAs))) {
      elements = lists.flatMap { $0.create\(type.buildableBaseName)().elements }
    }
    """
  )
}

/// Generate the initializer for the `ExpressibleByArrayLiteral` conformance.
private func createArrayLiteralInitializer(node: Node) -> InitializerDecl {
  let elementType = node.collectionElementType
  return InitializerDecl(
    """
    public init(arrayLiteral elements: \(elementType.expressibleAs)...) {
      self.init(elements)
    }
    """
  )
}

/// Generate the function building the collection syntax.
private func createBuildFunction(node: Node, trivias: [String]) -> FunctionDecl {
  let type = node.type
  let elementType = node.collectionElementType
  let buildCall = elementType.isToken ? "buildToken" : "build\(elementType.baseName)"

  let body = CodeBlockItemList {
    VariableDecl("var result = \(type.syntaxBaseName)(elements.map { $0.\(buildCall)(format: format) })")
    for trivia in trivias {
      createTriviaAttachment(varName: IdentifierExpr("result"), triviaVarName: IdentifierExpr(trivia), trivia: trivia)
    }
    ReturnStmt("return format.format(syntax: result)")
  }.buildSyntax(format: Format(indentWidth: 2))

  return FunctionDecl(
    """
    public func build\(type.baseName)(format: Format) -> \(type.syntax) {
      \(body)
    }
    """)
}

/// Generate the function building the syntax.
private func createBuildSyntaxFunction(node: Node) -> FunctionDecl {
  let type = node.type
  return FunctionDecl(
    """
    public func buildSyntax(format: Format) -> Syntax {
      return Syntax(build\(type.baseName)(format: format))
    }
    """
  )
}
