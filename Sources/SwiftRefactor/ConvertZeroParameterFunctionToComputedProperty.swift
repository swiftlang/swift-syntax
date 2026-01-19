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

#if compiler(>=6)
public import SwiftSyntax
#else
import SwiftSyntax
#endif

public struct ConvertZeroParameterFunctionToComputedProperty: SyntaxRefactoringProvider {
  public static func refactor(
    syntax: FunctionDeclSyntax,
    in context: ()
  ) throws -> VariableDeclSyntax {

    guard
      syntax.signature.parameterClause.parameters.isEmpty,
      let body = syntax.body
    else {
      throw RefactoringNotApplicableError("not a zero parameter function")
    }

    // MARK: - Pattern

    let variableName = PatternSyntax(
      IdentifierPatternSyntax(identifier: syntax.name)
    )

    // MARK: - Type annotation

    let triviaFromParameters =
      (syntax.signature.parameterClause.leftParen.trivia +
       syntax.signature.parameterClause.rightParen.trivia)
      .droppingTrailingWhitespace

    let variableType: TypeAnnotationSyntax

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

    let accessorEffectSpecifiers: AccessorEffectSpecifiersSyntax?
    if let fnEffectSpecifiers = syntax.signature.effectSpecifiers {
      accessorEffectSpecifiers = AccessorEffectSpecifiersSyntax(
        asyncSpecifier: fnEffectSpecifiers.asyncSpecifier,
        throwsClause: fnEffectSpecifiers.throwsClause
      )
    } else {
      accessorEffectSpecifiers = nil
    }

    let accessorBlock: AccessorBlockSyntax

    if let accessorEffectSpecifiers {
      let indentedStatements = body.statements.map { $0.with(\.leadingTrivia, .spaces(4)) }
      let getterBody = CodeBlockSyntax(
        leftBrace: .leftBraceToken(trailingTrivia: .newline),
        statements: CodeBlockItemListSyntax(indentedStatements),
        rightBrace: .rightBraceToken(leadingTrivia: .newline + .spaces(2))
      )

      let getAccessor = AccessorDeclSyntax(
        accessorSpecifier: .keyword(.get, trailingTrivia: .space),
        effectSpecifiers: accessorEffectSpecifiers,
        body: getterBody
      ).with(\.leadingTrivia, .spaces(2))

      accessorBlock = AccessorBlockSyntax(
        leftBrace: .leftBraceToken(trailingTrivia: .newline),
        accessors: .accessors(
          AccessorDeclListSyntax([getAccessor])
        ),
        rightBrace: .rightBraceToken(leadingTrivia: .newline)
      )
    } else {
      accessorBlock = AccessorBlockSyntax(
        leftBrace: body.leftBrace,
        accessors: .getter(body.statements),
        rightBrace: body.rightBrace
      )
    }

    let bindingSpecifier = syntax.funcKeyword.detached.with(\.tokenKind, .keyword(.var))

    let patternBinding = PatternBindingSyntax(
      pattern: variableName,
      typeAnnotation: variableType,
      accessorBlock: accessorBlock
    )

    return VariableDeclSyntax(
      attributes: syntax.attributes,
      modifiers: syntax.modifiers,
      bindingSpecifier: bindingSpecifier,
      bindings: PatternBindingListSyntax([patternBinding])
    )
  }
}
