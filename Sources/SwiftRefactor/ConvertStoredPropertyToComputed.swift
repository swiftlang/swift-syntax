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

    let body = CodeBlockItemSyntax(
      item: .expr(initializer.value)
    )

    let newBinding =
      binding
      .with(\.initializer, nil)
      .with(
        \.accessorBlock,
        AccessorBlockSyntax(
          leftBrace: .leftBraceToken(trailingTrivia: .space),
          accessors: .getter(CodeBlockItemListSyntax([body])),
          rightBrace: .rightBraceToken(leadingTrivia: .space)
        )
      )

    return
      syntax
      .with(\.bindingSpecifier, .keyword(.var, trailingTrivia: .space))
      .with(\.bindings, PatternBindingListSyntax([newBinding]))
  }
}
