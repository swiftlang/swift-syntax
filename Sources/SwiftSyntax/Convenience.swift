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

extension ClosureCaptureSyntax {

  /// Creates a ``ClosureCaptureSyntax`` with a `name`, and automatically adds an `equal` token to it since the name is non-optional.
  ///
  /// - SeeAlso: ``ClosureCaptureSyntax/init(leadingTrivia:_:specifier:_:name:_:equal:_:expression:_:trailingComma:_:trailingTrivia:)``.
  ///
  public init(
    leadingTrivia: Trivia? = nil,
    specifier: ClosureCaptureSpecifierSyntax? = nil,
    name: TokenSyntax,
    equal: TokenSyntax = TokenSyntax.equalToken(),
    expression: some ExprSyntaxProtocol,
    trailingComma: TokenSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      specifier: specifier,
      name: name as TokenSyntax?,
      equal: equal,
      expression: expression,
      trailingComma: trailingComma,
      trailingTrivia: trailingTrivia
    )
  }
}

extension EnumCaseParameterSyntax {

  /// Creates an ``EnumCaseParameterSyntax`` with a `firstName`, and automatically adds a `colon` to it.
  ///
  ///  - SeeAlso: For more information on the arguments, see ``EnumCaseParameterSyntax/init(leadingTrivia:_:modifiers:_:firstName:_:secondName:_:colon:_:type:_:defaultArgument:_:trailingComma:_:trailingTrivia:)``
  ///
  public init(
    leadingTrivia: Trivia? = nil,
    modifiers: DeclModifierListSyntax = [],
    firstName: TokenSyntax,
    secondName: TokenSyntax? = nil,
    colon: TokenSyntax = TokenSyntax.colonToken(),
    type: some TypeSyntaxProtocol,
    defaultValue: InitializerClauseSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      modifiers: modifiers,
      firstName: firstName as TokenSyntax?,
      secondName: secondName,
      colon: colon,
      type: type,
      defaultValue: defaultValue,
      trailingComma: trailingComma,
      trailingTrivia: trailingTrivia
    )
  }
}

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

//==========================================================================//
// IMPORTANT: If you are tempted to add an extension here, please insert    //
// it in alphabetical order above                                           //
//==========================================================================//
