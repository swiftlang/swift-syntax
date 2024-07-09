//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#if swift(>=6)
public import SwiftSyntax
#else
import SwiftSyntax
#endif

public struct ConvertZeroParameterFunctionToComputedProperty: SyntaxRefactoringProvider {
  public static func refactor(syntax: FunctionDeclSyntax, in context: ()) -> VariableDeclSyntax? {
    guard syntax.signature.parameterClause.parameters.isEmpty,
      let body = syntax.body
    else { return nil }

    let variableName = PatternSyntax(
      IdentifierPatternSyntax(
        leadingTrivia: syntax.funcKeyword.trailingTrivia,
        identifier: syntax.name
      )
    )

    let triviaFromParameters =
      (syntax.signature.parameterClause.leftParen.trivia + syntax.signature.parameterClause.rightParen.trivia)
      .droppingTrailingWhitespace

    var variableType: TypeAnnotationSyntax?

    if let returnClause = syntax.signature.returnClause {
      variableType = TypeAnnotationSyntax(
        colon: .colonToken(
          leadingTrivia: triviaFromParameters + returnClause.arrow.leadingTrivia,
          trailingTrivia: returnClause.arrow.trailingTrivia
        ),
        type: returnClause.type
      )
    } else {
      variableType = TypeAnnotationSyntax(
        colon: .colonToken(
          leadingTrivia: triviaFromParameters,
          trailingTrivia: .space
        ),
        type: TypeSyntax("Void").with(\.trailingTrivia, .space)
      )
    }

    let accessorBlock = AccessorBlockSyntax(
      leftBrace: body.leftBrace,
      accessors: .getter(body.statements),
      rightBrace: body.rightBrace
    )

    return VariableDeclSyntax(
      modifiers: syntax.modifiers,
      .var,
      name: variableName,
      type: variableType,
      accessorBlock: accessorBlock
    )
  }
}
