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

let buildableBaseProtocolsFile = SourceFile {
  ImportDecl(
    leadingTrivia: .docLineComment(copyrightHeader),
    path: "SwiftSyntax"
  )

  // `SyntaxCollectionBuildable` and `ExpressibleAsSyntaxCollectionBuildable` don't exist because of the following reason:
  // Through `ExpressibleAs*` conformances, a syntax kind might conform to `ExpressibleAsSyntaxCollectionBuildable` via different paths, thus the implementation of `createSyntaxCollectionBuildable` is ambiguous.
  // We have the same issue for `ExpressibleAsSyntaxBuildable`, but in that case the solution is simple: Create a custom implementaiton of `createSyntaxBuildable` that doesn't perform any of the conversions via the `ExpressibleAs` protocols.
  // For `SyntaxCollection` we would need to perform at least one conversion to end up with a type that we can put inside a `SyntaxCollection`, so there is no single canonical implementation.
  // Since the types don't provide any value, we don't generate them for now.
  for kind in SYNTAX_BASE_KINDS.sorted() where kind != "SyntaxCollection" {
    let type = SyntaxBuildableType(syntaxKind: kind)
    let syntaxType = SyntaxBuildableType(syntaxKind: "Syntax")
    let isSyntax = type == syntaxType
    // Types that the `*Buildable` conforms to
    let buildableConformances: [String] = [type.expressibleAsBaseName, type.listBuildableBaseName] + (isSyntax ? [] : [syntaxType.buildableBaseName])
    let listConformances: [String] = isSyntax ? [] : [syntaxType.listBuildableBaseName]

    ProtocolDecl(
      modifiers: [TokenSyntax.public],
      identifier: type.listBuildableBaseName,
      inheritanceClause: createTypeInheritanceClause(conformances: listConformances)
    ) {
      FunctionDecl(
        leadingTrivia: [
          "/// Builds list of `\(type.syntaxBaseName)`s.",
          "/// - Parameter format: The `Format` to use.",
        ].map { .docLineComment($0) + .newline }.reduce([], +),
        identifier: .identifier("build\(type.baseName)List"),
        signature: FunctionSignature(
          input: createFormatParameters(),
          output: ArrayType(elementType: type.syntaxBaseName)
        ),
        body: nil
      )
    }

    ProtocolDecl(
      modifiers: [TokenSyntax.public],
      identifier: type.buildableBaseName,
      inheritanceClause: createTypeInheritanceClause(conformances: buildableConformances)
    ) {
      FunctionDecl(
        leadingTrivia: [
          "/// Builds list of `\(type.syntaxBaseName)`s.",
          "/// - Parameter format: The `Format` to use.",
        ].map { .docLineComment($0) + .newline }.reduce([], +),
        identifier: .identifier("build\(type.baseName)"),
        signature: FunctionSignature(
          input: createFormatParameters(),
          output: type.syntaxBaseName
        ),
        body: nil
      )
    }

    ExtensionDecl(
      modifiers: [TokenSyntax.public],
      extendedType: type.buildableBaseName
    ) {
      FunctionDecl(
        leadingTrivia: .docLineComment("/// Satisfies conformance to `\(type.expressibleAsBaseName)`.") + .newline,
        identifier: .identifier("create\(type.buildableBaseName)"),
        signature: FunctionSignature(
          input: ParameterClause(),
          output: type.buildableBaseName
        )
      ) {
        ReturnStmt(expression: "self")
      }

      FunctionDecl(
        leadingTrivia: [
          "/// Builds list of `\(type.syntaxBaseName)`s.",
          "/// - Parameter format: The `Format` to use.",
          "///",
          "/// Satisfies conformance to `\(type.listBuildable)`",
        ].map { .docLineComment($0) + .newline }.reduce([], +),
        identifier: .identifier("build\(type.baseName)List"),
        signature: FunctionSignature(
          input: createFormatParameters(),
          output: ArrayType(elementType: type.syntaxBaseName)
        )
      ) {
        ReturnStmt(expression: ArrayExpr {
          ArrayElement(expression: FunctionCallExpr("build\(type.baseName)") {
            TupleExprElement(label: "format", expression: "format")
          })
        })
      }

      if !isSyntax {
        FunctionDecl(
          leadingTrivia: [
          "/// Builds a `\(type.syntaxBaseName)`.",
          "/// - Parameter format: The `Format` to use.",
          "/// - Returns: A new `Syntax` with the built `\(type.syntaxBaseName)`.",
          "///",
          "/// Satisfies conformance to `SyntaxBuildable`.",
        ].map { .docLineComment($0) + .newline }.reduce([], +),
          identifier: .identifier("buildSyntax"),
          signature: FunctionSignature(
            input: createFormatParameters(),
            output: "Syntax"
          )
        ) {
          ReturnStmt(expression: FunctionCallExpr("Syntax") {
            TupleExprElement(expression: FunctionCallExpr("build\(type.baseName)") {
              TupleExprElement(label: "format", expression: "format")
            })
          })
        }
      }
    }
  }
}
