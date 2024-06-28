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

    var initializer: InitializerClauseSyntax?

    if body.count > 1 {
      let closure = ClosureExprSyntax(
        statements: body.with(\.trailingTrivia, .newline)
      )

      initializer = InitializerClauseSyntax(
        value: FunctionCallExprSyntax(
          leadingTrivia: .space,
          callee: closure
        )
      )
    } else if let item = body.first?.item.as(ExprSyntax.self) {
      initializer = InitializerClauseSyntax(
        value: item.with(\.leadingTrivia, .space).with(\.trailingTrivia, Trivia())
      )
    }

    guard let initializer else { return nil }

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
}

fileprivate extension FunctionCallExprSyntax {

  init(
    leadingTrivia: Trivia? = nil,
    callee: some ExprSyntaxProtocol,
    argumentList: () -> LabeledExprListSyntax = { [] },
    trailingTrivia: Trivia? = nil
  ) {
    let argumentList = argumentList()
    self.init(
      leadingTrivia: leadingTrivia,
      calledExpression: callee,
      leftParen: .leftParenToken(),
      arguments: argumentList,
      rightParen: .rightParenToken(),
      trailingTrivia: trailingTrivia
    )
  }
}
