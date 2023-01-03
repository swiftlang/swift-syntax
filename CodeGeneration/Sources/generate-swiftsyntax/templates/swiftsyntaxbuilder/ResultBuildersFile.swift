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

import SwiftSyntax
import SyntaxSupport
import SwiftSyntaxBuilder
import Utils

let resultBuildersFile = SourceFile {
  ImportDecl(
    leadingTrivia: .docLineComment(generateCopyrightHeader(for: "generate-swiftsyntaxbuilder")),
    path: [AccessPathComponent(name: "SwiftSyntax")]
  )
  for node in SYNTAX_NODES where node.isSyntaxCollection {
    let type = SyntaxBuildableType(syntaxKind: node.syntaxKind)
    let elementType = node.collectionElementType
    let expressionType: Type = (node.collectionElementChoices?.isEmpty ?? true) ? elementType.parameterType : Type(MemberTypeIdentifier("\(type.buildable).Element"))

    StructDecl("""
      @resultBuilder
      public struct \(type.syntaxKind)Builder
      """) {
      TypealiasDecl(
          """
          /// The type of individual statement expressions in the transformed function,
          /// which defaults to Component if buildExpression() is not provided.
          public typealias Expression = \(expressionType)
          """
        )

        TypealiasDecl(
          """
          /// The type of a partial result, which will be carried through all of the
          /// build methods.
          public typealias Component = [Expression]
          """
        )

        TypealiasDecl(
          """
          /// The type of the final returned result, which defaults to Component if
          /// buildFinalResult() is not provided.
          public typealias FinalResult = \(type.buildable)
          """
        )

        FunctionDecl(
          """
          /// Required by every result builder to build combined results from
          /// statement blocks.
          public static func buildBlock(_ components: Self.Component...) -> Self.Component {
            return components.flatMap { $0 }
          }
          """
        )

        FunctionDecl(
          """
          /// If declared, provides contextual type information for statement
          /// expressions to translate them into partial results.
          public static func buildExpression(_ expression: Self.Expression) -> Self.Component {
            return [expression]
          }
          """
        )

        for elementChoice in node.collectionElementChoices ?? [] {
          FunctionDecl(
            """
            /// If declared, provides contextual type information for statement
            /// expressions to translate them into partial results.
            public static func buildExpression(_ expression: \(raw: elementChoice)) -> Self.Component {
              return buildExpression(.init(expression))
            }
            """
          )
        }
        
        FunctionDecl(
          """
          /// Add all the elements of `expression` to this result builder, effectively flattening them.
          public static func buildExpression(_ expression: Self.FinalResult) -> Self.Component {
            return expression.map { $0 }
          }
          """
        )

        FunctionDecl(
          """
          /// Enables support for `if` statements that do not have an `else`.
          public static func buildOptional(_ component: Self.Component?) -> Self.Component {
            return component ?? []
          }
          """
        )

        FunctionDecl(
          """
          /// With buildEither(second:), enables support for 'if-else' and 'switch'
          /// statements by folding conditional results into a single result.
          public static func buildEither(first component: Self.Component) -> Self.Component {
            return component
          }
          """
        )

        FunctionDecl(
          """
          /// With buildEither(first:), enables support for 'if-else' and 'switch'
          /// statements by folding conditional results into a single result.
          public static func buildEither(second component: Self.Component) -> Self.Component {
            return component
          }
          """
        )

        FunctionDecl(
          """
          /// Enables support for 'for..in' loops by combining the
          /// results of all iterations into a single result.
          public static func buildArray(_ components: [Self.Component]) -> Self.Component {
            return components.flatMap { $0 }
          }
          """
        )

        FunctionDecl(
          """
          /// If declared, this will be called on the partial result of an 'if'
          /// #available' block to allow the result builder to erase type
          /// information.
          public static func buildLimitedAvailability(_ component: Self.Component) -> Self.Component {
            return component
          }
          """
        )

        FunctionDecl("""
          
          /// If declared, this will be called on the partial result from the outermost
          /// block statement to produce the final returned result.
          public static func buildFinalResult(_ component: Component) -> FinalResult
          """) {
          if elementType.isToken {
            ReturnStmt("return .init(component)")
          } else if elementType.hasWithTrailingCommaTrait {
            VariableDecl("let lastIndex = component.count - 1")

            ReturnStmt("""
              return .init(component.enumerated().map { index, source in
                return index < lastIndex ? source.ensuringTrailingComma() : source
              })
              """)
          } else {
            ReturnStmt("return .init(component)")
          }
        }
      }
      
    ExtensionDecl(
      """
      public extension \(raw: type.shorthandName) {
        init(@\(raw: type.resultBuilderBaseName) itemsBuilder: () -> \(raw: type.shorthandName)) {
          self = itemsBuilder()
        }
      }
      """
    )
  }
}
