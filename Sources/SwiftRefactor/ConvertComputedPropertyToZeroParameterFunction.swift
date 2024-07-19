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

public struct ConvertComputedPropertyToZeroParameterFunction: SyntaxRefactoringProvider {
  public static func refactor(syntax: VariableDeclSyntax, in context: Void) -> FunctionDeclSyntax? {
    guard syntax.bindings.count == 1,
      let binding = syntax.bindings.first,
      let identifierPattern = binding.pattern.as(IdentifierPatternSyntax.self)
    else { return nil }

    var statements: CodeBlockItemListSyntax

    guard let typeAnnotation = binding.typeAnnotation,
      var accessorBlock = binding.accessorBlock
    else { return nil }

    var effectSpecifiers: AccessorEffectSpecifiersSyntax?

    switch accessorBlock.accessors {
    case .accessors(let accessors):
      guard accessors.count == 1, let accessor = accessors.first,
        accessor.accessorSpecifier.tokenKind == .keyword(.get), let codeBlock = accessor.body
      else { return nil }
      effectSpecifiers = accessor.effectSpecifiers
      statements = codeBlock.statements
      let accessorSpecifier = accessor.accessorSpecifier
      statements.leadingTrivia =
        accessorSpecifier.leadingTrivia + accessorSpecifier.trailingTrivia.droppingLeadingWhitespace
        + codeBlock.leftBrace.leadingTrivia.droppingLeadingWhitespace
        + codeBlock.leftBrace.trailingTrivia.droppingLeadingWhitespace
        + statements.leadingTrivia
      statements.trailingTrivia += codeBlock.rightBrace.trivia.droppingLeadingWhitespace
      statements.trailingTrivia = statements.trailingTrivia.droppingTrailingWhitespace
    case .getter(let codeBlock):
      statements = codeBlock
    }

    let returnType = typeAnnotation.type

    var returnClause: ReturnClauseSyntax?
    let triviaAfterSignature: Trivia

    if !returnType.isVoid {
      triviaAfterSignature = .space
      returnClause = ReturnClauseSyntax(
        arrow: .arrowToken(
          leadingTrivia: typeAnnotation.colon.leadingTrivia,
          trailingTrivia: typeAnnotation.colon.trailingTrivia
        ),
        type: returnType
      )
    } else {
      triviaAfterSignature = typeAnnotation.colon.leadingTrivia + typeAnnotation.colon.trailingTrivia
    }

    accessorBlock.leftBrace.leadingTrivia = accessorBlock.leftBrace.leadingTrivia.droppingLeadingWhitespace
    accessorBlock.rightBrace.trailingTrivia = accessorBlock.rightBrace.trailingTrivia.droppingTrailingWhitespace

    let body = CodeBlockSyntax(
      leftBrace: accessorBlock.leftBrace,
      statements: statements,
      rightBrace: accessorBlock.rightBrace
    )

    var parameterClause = FunctionParameterClauseSyntax(parameters: [])
    parameterClause.trailingTrivia = identifierPattern.identifier.trailingTrivia + triviaAfterSignature

    let functionEffectSpecifiers = FunctionEffectSpecifiersSyntax(
      asyncSpecifier: effectSpecifiers?.asyncSpecifier,
      throwsClause: effectSpecifiers?.throwsClause
    )
    let functionSignature = FunctionSignatureSyntax(
      parameterClause: parameterClause,
      effectSpecifiers: functionEffectSpecifiers,
      returnClause: returnClause
    )

    return FunctionDeclSyntax(
      modifiers: syntax.modifiers,
      funcKeyword: .keyword(
        .func,
        leadingTrivia: syntax.bindingSpecifier.leadingTrivia,
        trailingTrivia: syntax.bindingSpecifier.trailingTrivia
      ),
      name: identifierPattern.identifier.with(\.trailingTrivia, []),
      signature: functionSignature,
      body: body
    )
  }
}
