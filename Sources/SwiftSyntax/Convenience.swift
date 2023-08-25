//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

extension MemberAccessExprSyntax {
  /// Creates a new ``MemberAccessExprSyntax`` where the accessed member is represented by
  /// an identifier without specifying argument labels.
  ///
  /// A member access can specify function argument labels, which is required
  /// when the name would be ambiguous otherwise. For example, given multiple overloads
  /// ```swift
  /// struct Person {
  ///   func consume(drink: Drink) {}
  ///   func consume(food: Food) {}
  /// }
  /// ```
  ///
  /// `consume(drink:)` is required to explicitly reference the consume function
  /// that takes a drink.
  ///
  /// Given how common it is to not need the argument names, this initializer is
  /// provided as a convenience to avoid having to create a ``DeclReferenceExprSyntax``
  /// for the member name.
  public init(
    leadingTrivia: Trivia? = nil,
    base: (some ExprSyntaxProtocol)? = ExprSyntax?.none,
    period: TokenSyntax = .periodToken(),
    name: TokenSyntax,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      base: base,
      period: period,
      declName: DeclReferenceExprSyntax(baseName: name),
      trailingTrivia: trailingTrivia
    )
  }
}
