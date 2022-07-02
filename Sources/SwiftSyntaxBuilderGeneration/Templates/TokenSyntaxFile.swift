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

let tokenSyntaxFile = SourceFile {
  ImportDecl(
    leadingTrivia: .docLineComment(copyrightHeader),
    path: "SwiftSyntax"
  )

  let tokenType = SyntaxBuildableType(syntaxKind: "Token")
  let conformances = tokenType.generatedExpressibleAsConformances

  ExtensionDecl(
    extendedType: "TokenSyntax",
    inheritanceClause: TypeInheritanceClause {
      for conformance in conformances {
        InheritedType(typeName: conformance.expressibleAs)
      }
    }
  ) {
    for conformance in tokenType.elementInCollections {
      FunctionDecl(
        leadingTrivia: .docLineComment("/// Conformance to \(conformance.expressibleAs)") + .newline,
        modifiers: [TokenSyntax.public],
        identifier: .identifier("create\(conformance.buildableBaseName)"),
        signature: FunctionSignature(
          input: ParameterClause(),
          output: conformance.buildable
        )
      ) {
        ReturnStmt(expression: FunctionCallExpr(conformance.buildable) {
          TupleExprElement(expression: ArrayExpr {
            ArrayElement(expression: "self")
          })
        })
      }
    }
    for conformance in tokenType.convertibleToTypes {
      let param = Node.from(type: conformance).singleNonDefaultedChild
      FunctionDecl(
        leadingTrivia: .docLineComment("/// Conformance to \(conformance.expressibleAs)") + .newline,
        modifiers: [TokenSyntax.public],
        identifier: .identifier("create\(conformance.buildableBaseName)"),
        signature: FunctionSignature(
          input: ParameterClause(),
          output: conformance.buildable
        )
      ) {
        ReturnStmt(expression: FunctionCallExpr(conformance.buildable) {
          TupleExprElement(label: param.swiftName, expression: "self")
        })
      }
    }
  }

  ExtensionDecl(
    leadingTrivia: .newline + .docLineComment("/// `TokenSyntax` conforms to `SyntaxBuildable` and `ExprBuildable` via different paths, so we need to pick one default conversion path to create an `ExprSyntax` (and `Syntax`) from a `String`. We choose `IdentifierExpr`.") + .newline,
    extendedType: "TokenSyntax"
  ) {
    for buildable in ["SyntaxBuildable", "ExprBuildable"] {
      FunctionDecl(
        modifiers: [TokenSyntax.public],
        identifier: .identifier("create\(buildable)"),
        signature: FunctionSignature(
          input: ParameterClause(),
          output: buildable
        )
      ) {
        ReturnStmt(expression: FunctionCallExpr("createIdentifierExpr"))
      }
    }
  }
}
