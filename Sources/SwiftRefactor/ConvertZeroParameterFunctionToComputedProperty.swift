//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#if compiler(>=6)
import SwiftBasicFormat
public import SwiftSyntax
#else
import SwiftBasicFormat
import SwiftSyntax
#endif

/// Converts a non-generic, zero-parameter function with a body into a computed property.
///
/// Leading trivia, including documentation comments, is preserved on the
/// resulting property. Only attributes and modifiers that are valid on a
/// computed property are preserved; functions using function-only attributes
/// or modifiers are not converted. For example:
///
///     /// The answer.
///     func answer() -> Int {
///       42
///     }
///
/// becomes:
///
///     /// The answer.
///     var answer: Int {
///       42
///     }
///
/// Functions with generic parameters or requirements are not converted because
/// computed properties cannot declare them.
public struct ConvertZeroParameterFunctionToComputedProperty: SyntaxRefactoringProvider {
  public static func refactor(syntax: FunctionDeclSyntax, in context: ()) throws -> VariableDeclSyntax {
    guard syntax.genericParameterClause == nil,
      syntax.genericWhereClause == nil,
      syntax.signature.parameterClause.parameters.isEmpty,
      syntax.signature.effectSpecifiers?.throwsClause?.throwsSpecifier.tokenKind != .keyword(.rethrows),
      syntax.attributes.allSatisfy(isAttributeSupported),
      syntax.modifiers.allSatisfy(isModifierSupported),
      let body = syntax.body
    else {
      throw RefactoringNotApplicableError("not a non-generic zero parameter function with a body")
    }

    let variableName = PatternSyntax(
      IdentifierPatternSyntax(
        identifier: syntax.name
      )
    )

    let triviaFromParameters =
      (syntax.signature.parameterClause.leftParen.trivia + syntax.signature.parameterClause.rightParen.trivia)
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
    if let functionEffectSpecifiers = syntax.signature.effectSpecifiers {
      accessorEffectSpecifiers = AccessorEffectSpecifiersSyntax(
        asyncSpecifier: functionEffectSpecifiers.asyncSpecifier,
        throwsClause: functionEffectSpecifiers.throwsClause
      )
    } else {
      accessorEffectSpecifiers = nil
    }

    let accessorBlock: AccessorBlockSyntax
    if let accessorEffectSpecifiers {
      let indentation = BasicFormat.inferIndentation(of: syntax) ?? .spaces(2)
      var getterLeftBrace = body.leftBrace.detached
      getterLeftBrace.leadingTrivia = []
      var getterRightBrace = body.rightBrace.detached
      getterRightBrace.leadingTrivia = getterRightBrace.leadingTrivia.indented(
        by: indentation,
        indentFirstLine: false
      )
      getterRightBrace.trailingTrivia = []
      let getterBody = CodeBlockSyntax(
        leftBrace: getterLeftBrace,
        statements: body.statements.indented(by: indentation),
        rightBrace: getterRightBrace
      )
      let getter = AccessorDeclSyntax(
        accessorSpecifier: .keyword(.get, trailingTrivia: .space),
        effectSpecifiers: accessorEffectSpecifiers,
        body: getterBody
      ).with(\.leadingTrivia, indentation)
      let declarationIndentation = syntax.leadingTrivia.indentation(isOnNewline: true) ?? []
      accessorBlock = AccessorBlockSyntax(
        leftBrace: body.leftBrace.detached.with(\.trailingTrivia, .newline),
        accessors: .accessors(AccessorDeclListSyntax([getter])),
        rightBrace: body.rightBrace.detached.with(\.leadingTrivia, .newline + declarationIndentation)
      )
    } else {
      accessorBlock = AccessorBlockSyntax(
        leftBrace: body.leftBrace,
        accessors: .getter(body.statements),
        rightBrace: body.rightBrace
      )
    }

    let bindingSpecifier =
      syntax.funcKeyword.detached
      .with(\.tokenKind, .keyword(.var))
      .with(\.leadingTrivia, syntax.funcKeyword.leadingTrivia)
      .with(\.trailingTrivia, syntax.funcKeyword.trailingTrivia)

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

  /// Whether an attribute that is valid on a function can also be applied to a
  /// computed property without changing its meaning.
  private static func isAttributeSupported(_ element: AttributeListSyntax.Element) -> Bool {
    guard let attribute = element.as(AttributeSyntax.self) else {
      return false
    }

    switch attribute.attributeName.trimmedDescription {
    case "available", "backDeployed", "inlinable", "objc", "nonobjc", "preconcurrency", "usableFromInline":
      return true
    default:
      return false
    }
  }

  /// Whether a function modifier can be copied to a computed property.
  private static func isModifierSupported(_ modifier: DeclModifierSyntax) -> Bool {
    guard modifier.detail == nil else {
      return false
    }

    switch modifier.name.tokenKind {
    case .keyword(.class),
      .keyword(.dynamic),
      .keyword(.fileprivate),
      .keyword(.final),
      .keyword(.internal),
      .keyword(.nonisolated),
      .keyword(.open),
      .keyword(.override),
      .keyword(.package),
      .keyword(.private),
      .keyword(.public),
      .keyword(.static):
      return true
    default:
      return false
    }
  }
}

private extension Trivia {
  func indented(by indentation: Trivia, indentFirstLine: Bool) -> Trivia {
    var result: [TriviaPiece] = []
    var shouldIndent = indentFirstLine
    for piece in pieces {
      if shouldIndent {
        result.append(contentsOf: indentation)
        shouldIndent = false
      }
      result.append(piece)
      if piece.isNewline {
        shouldIndent = true
      }
    }
    if shouldIndent {
      result.append(contentsOf: indentation)
    }
    return Trivia(pieces: result)
  }
}
