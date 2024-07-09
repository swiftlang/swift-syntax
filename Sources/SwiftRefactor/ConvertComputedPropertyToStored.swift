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

public struct ConvertComputedPropertyToStored: SyntaxRefactoringProvider {
  public static func refactor(syntax: VariableDeclSyntax, in context: ()) -> VariableDeclSyntax? {
    guard syntax.bindings.count == 1, let binding = syntax.bindings.first,
      let accessorBlock = binding.accessorBlock, case let .getter(body) = accessorBlock.accessors, !body.isEmpty
    else {
      return nil
    }

    let refactored = { (initializer: InitializerClauseSyntax) -> VariableDeclSyntax in
      let newBinding =
        binding
        .with(\.initializer, initializer)
        .with(\.accessorBlock, nil)

      let bindingSpecifier = syntax.bindingSpecifier
        .with(\.tokenKind, .keyword(.let))

      return
        syntax
        .with(\.bindingSpecifier, bindingSpecifier)
        .with(\.bindings, PatternBindingListSyntax([newBinding]))
    }

    guard body.count == 1 else {
      let closure = ClosureExprSyntax(
        leftBrace: accessorBlock.leftBrace,
        statements: body,
        rightBrace: accessorBlock.rightBrace
      )

      return refactored(
        InitializerClauseSyntax(
          equal: .equalToken(trailingTrivia: .space),
          value: FunctionCallExprSyntax(callee: closure)
        )
      )
    }

    guard body.count == 1, let item = body.first?.item else {
      return nil
    }

    if let item = item.as(ReturnStmtSyntax.self), let expression = item.expression {
      let trailingTrivia: Trivia = expression.leadingTrivia.isEmpty ? .space : []
      return refactored(
        InitializerClauseSyntax(
          leadingTrivia: accessorBlock.leftBrace.trivia,
          equal: .equalToken(trailingTrivia: trailingTrivia),
          value: expression,
          trailingTrivia: accessorBlock.rightBrace.trivia.droppingTrailingWhitespace
        )
      )
    } else if var item = item.as(ExprSyntax.self) {
      item.trailingTrivia = item.trailingTrivia.droppingTrailingWhitespace
      return refactored(
        InitializerClauseSyntax(
          equal: .equalToken(trailingTrivia: .space),
          value: item,
          trailingTrivia: accessorBlock.trailingTrivia
        )
      )
    }

    return nil
  }
}
