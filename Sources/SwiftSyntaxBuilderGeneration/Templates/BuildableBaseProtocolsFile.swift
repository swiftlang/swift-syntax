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
    var buildableConformances: [String] = [type.expressibleAs, type.listBuildable] + (isSyntax ? [] : [syntaxType.buildable])
    var listConformances: [String] = isSyntax ? [] : [syntaxType.listBuildable]

    ProtocolDecl(
      modifiers: [TokenSyntax.public],
      identifier: type.listBuildable,
      inheritanceClause: listConformances.isEmpty ? nil : TypeInheritanceClause {
        for conformance in listConformances {
          InheritedType(typeName: conformance)
        }
      }
    ) {
      FunctionDecl(
        leadingTrivia: [
          "/// Builds list of `\(type.syntax)`s.",
          "/// - Parameter format: The `Format` to use.",
          "/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.",
        ].map { .docLineComment($0) + .newline }.reduce([], +),
        identifier: .identifier("build\(type.baseName)List"),
        signature: FunctionSignature(
          input: formatLeadingTriviaParameters(),
          output: ArrayType(elementType: type.syntax)
        ),
        body: nil
      )
    }

    ProtocolDecl(
      modifiers: [TokenSyntax.public],
      identifier: type.buildable,
      inheritanceClause: buildableConformances.isEmpty ? nil : TypeInheritanceClause {
        for conformance in buildableConformances {
          InheritedType(typeName: conformance)
        }
      }
    ) {
      FunctionDecl(
        leadingTrivia: [
          "/// Builds list of `\(type.syntax)`s.",
          "/// - Parameter format: The `Format` to use.",
          "/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.",
        ].map { .docLineComment($0) + .newline }.reduce([], +),
        identifier: .identifier("build\(type.baseName)"),
        signature: FunctionSignature(
          input: formatLeadingTriviaParameters(),
          output: type.syntax
        ),
        body: nil
      )
    }

    ExtensionDecl(
      modifiers: [TokenSyntax.public],
      extendedType: type.buildable
    ) {
      FunctionDecl(
        leadingTrivia: .docLineComment("/// Satisfies conformance to `\(type.expressibleAs)`.") + .newline,
        identifier: .identifier("create\(type.buildableBaseName)"),
        signature: FunctionSignature(
          input: ParameterClause(),
          output: type.buildable
        )
      ) {
        ReturnStmt(expression: "self")
      }

      FunctionDecl(
        leadingTrivia: [
          "/// Builds list of `\(type.syntax)`s.",
          "/// - Parameter format: The `Format` to use.",
          "/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.",
          "///",
          "/// Satisfies conformance to `\(type.listBuildable)`",
        ].map { .docLineComment($0) + .newline }.reduce([], +),
        identifier: .identifier("build\(type.baseName)List"),
        signature: FunctionSignature(
          input: formatLeadingTriviaParameters(withDefaultTrivia: true),
          output: ArrayType(elementType: type.syntax)
        )
      ) {
        ReturnStmt(expression: ArrayExpr {
          ArrayElement(expression: FunctionCallExpr("build\(type.baseName)") {
            TupleExprElement(label: "format", expression: "format")
            TupleExprElement(label: "leadingTrivia", expression: "leadingTrivia")
          })
        })
      }

      if !isSyntax {
        FunctionDecl(
          leadingTrivia: [
          "/// Builds a `\(type.syntax)`.",
          "/// - Parameter format: The `Format` to use.",
          "/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.",
          "/// - Returns: A new `Syntax` with the built `\(type.syntax)`.",
          "///",
          "/// Satisfies conformance to `SyntaxBuildable`.",
        ].map { .docLineComment($0) + .newline }.reduce([], +),
          identifier: .identifier("buildSyntax"),
          signature: FunctionSignature(
            input: formatLeadingTriviaParameters(withDefaultTrivia: true),
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
    }
  }
}

// Generate a (format: Format, leadingTrivia: Trivia?) parameter clause
// to avoid duplication among the protocols above.
private func formatLeadingTriviaParameters(withDefaultTrivia: Bool = false) -> ParameterClause {
  ParameterClause(
    parameterList: [
      FunctionParameter(
        firstName: .identifier("format"),
        colon: .colon,
        type: "Format",
        trailingComma: .comma
      ),
      FunctionParameter(
        firstName: .identifier("leadingTrivia"),
        colon: .colon,
        type: OptionalType(wrappedType: "Trivia"),
        defaultArgument: withDefaultTrivia ? InitializerClause(value: "nil") : nil
      ),
    ]
  )
}
