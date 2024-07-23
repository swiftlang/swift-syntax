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

public struct ConvertStoredPropertyToComputed: SyntaxRefactoringProvider {
  public static func refactor(syntax: VariableDeclSyntax, in context: ()) -> VariableDeclSyntax? {
    guard syntax.bindings.count == 1, let binding = syntax.bindings.first, let initializer = binding.initializer else {
      return nil
    }

    var codeBlockSyntax: CodeBlockItemListSyntax

    if let functionExpression = initializer.value.as(FunctionCallExprSyntax.self),
      let closureExpression = functionExpression.calledExpression.as(ClosureExprSyntax.self)
    {
      guard functionExpression.arguments.isEmpty else { return nil }

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
      body.leadingTrivia = initializer.equal.trailingTrivia + body.leadingTrivia
      body.trailingTrivia += .space
      codeBlockSyntax = body
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

    let newBindingSpecifier =
      syntax.bindingSpecifier
      .with(\.tokenKind, .keyword(.var))

    return
      syntax
      .with(\.bindingSpecifier, newBindingSpecifier)
      .with(\.bindings, PatternBindingListSyntax([newBinding]))
  }
}
