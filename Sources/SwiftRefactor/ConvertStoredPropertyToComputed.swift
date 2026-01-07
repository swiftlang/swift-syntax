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

public struct ConvertStoredPropertyToComputed: SyntaxRefactoringProvider {
  public static func refactor(syntax: VariableDeclSyntax, in context: ()) throws -> VariableDeclSyntax {
    guard syntax.bindings.count == 1, let binding = syntax.bindings.first, let initializer = binding.initializer else {
      throw RefactoringNotApplicableError("unsupported variable declaration")
    }

    var codeBlockSyntax: CodeBlockItemListSyntax

    if let functionExpression = initializer.value.as(FunctionCallExprSyntax.self),
      let closureExpression = functionExpression.calledExpression.as(ClosureExprSyntax.self)
    {
      guard functionExpression.arguments.isEmpty else {
        throw RefactoringNotApplicableError(
          "initializer is a closure that takes arguments"
        )
      }

      codeBlockSyntax = closureExpression.statements
      codeBlockSyntax.leadingTrivia =
        closureExpression.leftBrace.leadingTrivia + closureExpression.leftBrace.trailingTrivia
        + codeBlockSyntax.leadingTrivia
      codeBlockSyntax.trailingTrivia +=
        closureExpression.trailingTrivia + closureExpression.rightBrace.leadingTrivia
        + closureExpression.rightBrace.trailingTrivia + functionExpression.trailingTrivia
    } else {
      var body = CodeBlockItemListSyntax([
        CodeBlockItemSyntax(
          item: .expr(initializer.value)
        )
      ])
      body.trailingTrivia += .space
      body.leadingTrivia = initializer.equal.trailingTrivia + body.leadingTrivia
      codeBlockSyntax = body
    }

    var modifiers = syntax.modifiers
    var modifiersLeadingTrivia = Trivia()

    if let lazyKeyword = modifiers.first(where: { $0.name.tokenKind == .keyword(.lazy) }),
      let index = modifiers.index(of: lazyKeyword)
    {
      modifiers.remove(at: index)
      modifiersLeadingTrivia = lazyKeyword.leadingTrivia
    }

    let newBinding =
      binding
      .with(\.initializer, nil)
      .with(
        \.accessorBlock,
        AccessorBlockSyntax(
          accessors: .getter(codeBlockSyntax)
        )
      )

    var newBindingSpecifier =
      syntax.bindingSpecifier
      .with(\.tokenKind, .keyword(.var))

    if modifiers.isEmpty {
      newBindingSpecifier.leadingTrivia += modifiersLeadingTrivia
    } else {
      modifiers.leadingTrivia += modifiersLeadingTrivia
    }

    return
      syntax
      .with(\.modifiers, modifiers)
      .with(\.bindingSpecifier, newBindingSpecifier)
      .with(\.bindings, PatternBindingListSyntax([newBinding]))
  }
}
