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

// This file provides compatibility aliases to keep dependents of SwiftSyntax building.
// All users of the declarations in this file should transition away from them ASAP.

extension AccessorEffectSpecifiersSyntax {
  @_disfavoredOverload
  @available(*, deprecated, message: "use throwsClause instead of throwsSpecifier")
  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAsyncSpecifier: UnexpectedNodesSyntax? = nil,
    asyncSpecifier: TokenSyntax? = nil,
    _ unexpectedBetweenAsyncSpecifierAndThrowsSpecifier: UnexpectedNodesSyntax? = nil,
    throwsSpecifier: TokenSyntax? = nil,
    _ unexpectedAfterThrowsSpecifier: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeAsyncSpecifier,
      asyncSpecifier: asyncSpecifier,
      unexpectedBetweenAsyncSpecifierAndThrowsSpecifier,
      throwsClause: throwsSpecifier.map { ThrowsClauseSyntax(throwsSpecifier: $0) },
      unexpectedAfterThrowsSpecifier,
      trailingTrivia: trailingTrivia
    )
  }
}

extension AttributedTypeSyntax {
  @available(*, deprecated, message: "Use initializer that takes a list of specifiers instead")
  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeSpecifier: UnexpectedNodesSyntax? = nil,
    specifier: TokenSyntax? = nil,
    _ unexpectedBetweenSpecifierAndAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax = [],
    _ unexpectedBetweenAttributesAndBaseType: UnexpectedNodesSyntax? = nil,
    baseType: some TypeSyntaxProtocol,
    _ unexpectedAfterBaseType: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let specifiers: TypeSpecifierListSyntax
    if let specifier {
      specifiers = [.simpleTypeSpecifier(SimpleTypeSpecifierSyntax(specifier: specifier))]
    } else {
      specifiers = []
    }
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeSpecifier,
      specifiers: specifiers,
      unexpectedBetweenSpecifierAndAttributes,
      attributes: attributes,
      unexpectedBetweenAttributesAndBaseType,
      baseType: baseType,
      unexpectedAfterBaseType,
      trailingTrivia: trailingTrivia
    )
  }

  @available(*, deprecated, renamed: "unexpectedBeforeSpecifiers")
  public var unexpectedBeforeSpecifier: UnexpectedNodesSyntax? {
    get {
      self.unexpectedBeforeSpecifiers
    }
    set {
      self.unexpectedBeforeSpecifiers = newValue
    }
  }

  @available(*, deprecated, message: "Access the specifiers list instead")
  public var specifier: TokenSyntax? {
    get {
      if case .simpleTypeSpecifier(let simpleSpecifier) = specifiers.first {
        return simpleSpecifier.specifier
      }
      return nil
    }
    set {
      if let newValue {
        specifiers = [.simpleTypeSpecifier(SimpleTypeSpecifierSyntax(specifier: newValue))]
      } else {
        specifiers = []
      }
    }
  }

  @available(*, deprecated, renamed: "unexpectedBetweenSpecifiersAndAttributes")
  public var unexpectedBetweenSpecifierAndAttributes: UnexpectedNodesSyntax? {
    get {
      self.unexpectedBetweenSpecifiersAndAttributes
    }
    set {
      self.unexpectedBetweenSpecifiersAndAttributes = newValue
    }
  }
}

extension AttributeSyntax {
  @available(*, deprecated, renamed: "Arguments")
  public typealias Argument = Arguments
}

@available(*, deprecated, renamed: "WithAttributesSyntax")
public typealias AttributedSyntax = WithAttributesSyntax

extension AvailabilityArgumentSyntax {
  @available(*, deprecated, renamed: "Argument")
  public typealias Entry = Argument
}

extension ClosureSignatureSyntax {
  @available(*, deprecated, renamed: "ParameterClause")
  public typealias Input = ParameterClause
}

extension ClosureSignatureSyntax.ParameterClause {
  @available(*, deprecated, renamed: "parameterClause")
  public static func input(_ parameterClause: ClosureParameterClauseSyntax) -> Self {
    return .parameterClause(parameterClause)
  }
}

extension DeclGroupSyntax {
  @available(*, deprecated, renamed: "memberBlock")
  public var members: MemberDeclBlockSyntax {
    get {
      return memberBlock
    }
    set(value) {
      memberBlock = value
    }
  }
}

extension ClosureCaptureSyntax {
  @available(*, deprecated, renamed: "unexpectedBetweenNameAndInitializer")
  public var unexpectedBetweenNameAndAssignToken: UnexpectedNodesSyntax? {
    get {
      return unexpectedBetweenNameAndInitializer
    }
    set {
      unexpectedBetweenNameAndInitializer = newValue
    }
  }

  @available(*, deprecated, renamed: "initializer.equal")
  public var assignToken: TokenSyntax? {
    get {
      return initializer?.equal
    }
    set {
      initializer?.equal = newValue ?? .equalToken(presence: .missing)
    }
  }

  @available(*, deprecated, renamed: "initializer.unexpectedBetweenEqualAndValue")
  public var unexpectedBetweenAssignTokenAndExpression: UnexpectedNodesSyntax? {
    get {
      return initializer?.unexpectedBetweenEqualAndValue
    }
    set {
      initializer?.unexpectedBetweenEqualAndValue = newValue
    }
  }

  /// Creates a ``ClosureCaptureSyntax`` with a `name`, and automatically adds an `equal` token to it since the name is non-optional.
  ///
  /// - SeeAlso: ``ClosureCaptureSyntax/init(leadingTrivia:_:specifier:_:name:_:initializer:_:trailingComma:_:trailingTrivia:)``.
  ///
  @available(
    *,
    deprecated,
    message: "Use 'init(leadingTrivia:_:specifier:_:name:_:initializer:_:trailingComma:_:trailingTrivia:)' instead"
  )
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
      name: name,
      initializer: InitializerClauseSyntax(equal: equal, value: expression),
      trailingComma: trailingComma,
      trailingTrivia: trailingTrivia
    )
  }

  @available(*, deprecated, renamed: "unexpectedBetweenNameAndInitializer")
  public var unexpectedBetweenNameAndEqual: UnexpectedNodesSyntax? {
    get {
      return unexpectedBetweenNameAndInitializer
    }
    set {
      unexpectedBetweenNameAndInitializer = newValue
    }
  }

  @available(*, deprecated, renamed: "initializer.equal")
  public var equal: TokenSyntax? {
    get {
      return initializer?.equal
    }
    set {
      initializer?.equal = newValue ?? .equalToken(presence: .missing)
    }
  }

  @available(*, deprecated, renamed: "initializer.unexpectedBetweenEqualAndValue")
  public var unexpectedBetweenEqualAndExpression: UnexpectedNodesSyntax? {
    get {
      return initializer?.unexpectedBetweenEqualAndValue
    }
    set {
      initializer?.unexpectedBetweenEqualAndValue = newValue
    }
  }

  @available(*, deprecated, renamed: "initializer.value")
  public var expression: ExprSyntax {
    get {
      return initializer?.value ?? ExprSyntax(MissingExprSyntax())
    }
    set(value) {
      initializer?.value = value
    }
  }

  @available(*, deprecated, renamed: "unexpectedBetweenInitializerAndTrailingComma")
  public var unexpectedBetweenExpressionAndTrailingComma: UnexpectedNodesSyntax? {
    get {
      return unexpectedBetweenInitializerAndTrailingComma
    }
    set(value) {
      unexpectedBetweenInitializerAndTrailingComma = value
    }
  }

  @available(
    *,
    deprecated,
    renamed: "ClosureCaptureSyntax(leadingTrivia:_:specifier:_:name:_:initializer:_:trailingComma:_:trailingTrivia:)"
  )
  @_disfavoredOverload
  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeSpecifier: UnexpectedNodesSyntax? = nil,
    specifier: ClosureCaptureSpecifierSyntax? = nil,
    _ unexpectedBetweenSpecifierAndName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax? = nil,
    _ unexpectedBetweenNameAndEqual: UnexpectedNodesSyntax? = nil,
    equal: TokenSyntax? = nil,
    _ unexpectedBetweenEqualAndExpression: UnexpectedNodesSyntax? = nil,
    expression: some ExprSyntaxProtocol,
    _ unexpectedBetweenExpressionAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeSpecifier,
      specifier: specifier,
      unexpectedBetweenSpecifierAndName,
      name: name ?? .identifier("", presence: .missing),
      unexpectedBetweenNameAndEqual,
      initializer: InitializerClauseSyntax(
        equal: equal ?? .equalToken(presence: .missing),
        unexpectedBetweenEqualAndExpression,
        value: expression
      ),
      unexpectedBetweenExpressionAndTrailingComma,
      trailingComma: trailingComma,
      unexpectedAfterTrailingComma,
      trailingTrivia: trailingTrivia
    )
  }
}

extension EffectSpecifiersSyntax {
  @available(*, deprecated, renamed: "unexpectedBetweenAsyncSpecifierAndThrowsClause")
  public var unexpectedBetweenAsyncSpecifierAndThrowsSpecifier: UnexpectedNodesSyntax? {
    get { unexpectedBetweenAsyncSpecifierAndThrowsClause }
    set { unexpectedBetweenAsyncSpecifierAndThrowsClause = newValue }
  }

  @available(*, deprecated, message: "use throwsClause.throwsSpecifier")
  public var throwsSpecifier: TokenSyntax? {
    get { throwsClause?.throwsSpecifier }

    set {
      guard let newSpecifier = newValue else {
        throwsClause = nil
        return
      }

      if let throwsClause {
        self.throwsClause = throwsClause.with(\.throwsSpecifier, newSpecifier)
      } else {
        self.throwsClause = ThrowsClauseSyntax(throwsSpecifier: newSpecifier)
      }
    }
  }

  @available(*, deprecated, renamed: "unexpectedAfterThrowsClause")
  public var unexpectedAfterThrowsSpecifier: UnexpectedNodesSyntax? {
    get { unexpectedAfterThrowsClause }
    set { unexpectedAfterThrowsClause = newValue }
  }
}

extension GenericArgumentSyntax {
  @_disfavoredOverload
  @available(*, deprecated, message: "use GenericArgumentSyntax.Argument for 'argument'")
  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeArgument: UnexpectedNodesSyntax? = nil,
    argument: some TypeSyntaxProtocol,
    _ unexpectedBetweenArgumentAndTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeArgument,
      argument: .type(TypeSyntax(argument)),
      unexpectedBetweenArgumentAndTrailingComma,
      trailingComma: trailingComma,
      unexpectedAfterTrailingComma,
      trailingTrivia: trailingTrivia
    )
  }
}

extension FunctionCallExprSyntax {
  @_disfavoredOverload
  @available(
    *,
    deprecated,
    message: "Use the initializer that does not provide default values for leftParen and rightParen."
  )
  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeCalledExasdfpression: UnexpectedNodesSyntax? = nil,
    calledExpression: some ExprSyntaxProtocol,
    _ unexpectedBetweenCalledExpressionAndLeftParen: UnexpectedNodesSyntax? = nil,
    _ unexpectedBetweenLeftParenAndArguments: UnexpectedNodesSyntax? = nil,
    arguments: LabeledExprListSyntax,
    _ unexpectedBetweenArgumentsAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax?,
    _ unexpectedBetweenRightParenAndTrailingClosure: UnexpectedNodesSyntax? = nil,
    trailingClosure: ClosureExprSyntax? = nil,
    _ unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    additionalTrailingClosures: MultipleTrailingClosureElementListSyntax = [],
    _ unexpectedAfterAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeCalledExasdfpression,
      calledExpression: calledExpression,
      leftParen: nil,
      unexpectedBetweenLeftParenAndArguments,
      arguments: arguments,
      unexpectedBetweenArgumentsAndRightParen,
      rightParen: rightParen,
      unexpectedBetweenRightParenAndTrailingClosure,
      trailingClosure: trailingClosure,
      unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures,
      additionalTrailingClosures: additionalTrailingClosures,
      unexpectedAfterAdditionalTrailingClosures,
      trailingTrivia: trailingTrivia
    )
  }

  @_disfavoredOverload
  @available(
    *,
    deprecated,
    message: "Use the initializer that does not provide default values for leftParen and rightParen."
  )
  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeCalledExasdfpression: UnexpectedNodesSyntax? = nil,
    calledExpression: some ExprSyntaxProtocol,
    _ unexpectedBetweenCalledExpressionAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax?,
    _ unexpectedBetweenLeftParenAndArguments: UnexpectedNodesSyntax? = nil,
    arguments: LabeledExprListSyntax,
    _ unexpectedBetweenArgumentsAndRightParen: UnexpectedNodesSyntax? = nil,
    _ unexpectedBetweenRightParenAndTrailingClosure: UnexpectedNodesSyntax? = nil,
    trailingClosure: ClosureExprSyntax? = nil,
    _ unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    additionalTrailingClosures: MultipleTrailingClosureElementListSyntax = [],
    _ unexpectedAfterAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeCalledExasdfpression,
      calledExpression: calledExpression,
      leftParen: leftParen,
      unexpectedBetweenLeftParenAndArguments,
      arguments: arguments,
      unexpectedBetweenArgumentsAndRightParen,
      rightParen: nil,
      unexpectedBetweenRightParenAndTrailingClosure,
      trailingClosure: trailingClosure,
      unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures,
      additionalTrailingClosures: additionalTrailingClosures,
      unexpectedAfterAdditionalTrailingClosures,
      trailingTrivia: trailingTrivia
    )
  }

  @_disfavoredOverload
  @available(
    *,
    deprecated,
    message: "Use the initializer that does not provide default values for leftParen and rightParen."
  )
  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeCalledExasdfpression: UnexpectedNodesSyntax? = nil,
    calledExpression: some ExprSyntaxProtocol,
    _ unexpectedBetweenCalledExpressionAndLeftParen: UnexpectedNodesSyntax? = nil,
    _ unexpectedBetweenLeftParenAndArguments: UnexpectedNodesSyntax? = nil,
    arguments: LabeledExprListSyntax,
    _ unexpectedBetweenArgumentsAndRightParen: UnexpectedNodesSyntax? = nil,
    _ unexpectedBetweenRightParenAndTrailingClosure: UnexpectedNodesSyntax? = nil,
    trailingClosure: ClosureExprSyntax? = nil,
    _ unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    additionalTrailingClosures: MultipleTrailingClosureElementListSyntax = [],
    _ unexpectedAfterAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeCalledExasdfpression,
      calledExpression: calledExpression,
      leftParen: nil,
      unexpectedBetweenLeftParenAndArguments,
      arguments: arguments,
      unexpectedBetweenArgumentsAndRightParen,
      rightParen: nil,
      unexpectedBetweenRightParenAndTrailingClosure,
      trailingClosure: trailingClosure,
      unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures,
      additionalTrailingClosures: additionalTrailingClosures,
      unexpectedAfterAdditionalTrailingClosures,
      trailingTrivia: trailingTrivia
    )
  }

  @_disfavoredOverload
  @available(
    *,
    deprecated,
    renamed:
      "init(leadingTrivia:_:calledExpression:_:leftParen:_:arguments:_:rightParen:_:trailingClosure:_:additionalTrailingClosures:_:trailingTrivia:)"
  )
  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeCalledExpression: UnexpectedNodesSyntax? = nil,
    calledExpression: some ExprSyntaxProtocol,
    _ unexpectedBetweenCalledExpressionAndLeftParen: UnexpectedNodesSyntax? = nil,
    _ unexpectedBetweenLeftParenAndArgumentList: UnexpectedNodesSyntax? = nil,
    argumentList: LabeledExprListSyntax,
    _ unexpectedBetweenArgumentListAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax?,
    _ unexpectedBetweenRightParenAndTrailingClosure: UnexpectedNodesSyntax? = nil,
    trailingClosure: ClosureExprSyntax? = nil,
    _ unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    additionalTrailingClosures: MultipleTrailingClosureElementListSyntax = [],
    _ unexpectedAfterAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeCalledExpression,
      calledExpression: calledExpression,
      unexpectedBetweenCalledExpressionAndLeftParen,
      leftParen: nil,
      unexpectedBetweenLeftParenAndArgumentList,
      arguments: argumentList,
      unexpectedBetweenArgumentListAndRightParen,
      rightParen: rightParen,
      unexpectedBetweenRightParenAndTrailingClosure,
      trailingClosure: trailingClosure,
      unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures,
      additionalTrailingClosures: additionalTrailingClosures,
      unexpectedAfterAdditionalTrailingClosures,
      trailingTrivia: trailingTrivia
    )
  }

  @_disfavoredOverload
  @available(
    *,
    deprecated,
    renamed:
      "init(leadingTrivia:_:calledExpression:_:leftParen:_:arguments:_:rightParen:_:trailingClosure:_:additionalTrailingClosures:_:trailingTrivia:)"
  )
  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeCalledExpression: UnexpectedNodesSyntax? = nil,
    calledExpression: some ExprSyntaxProtocol,
    _ unexpectedBetweenCalledExpressionAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax?,
    _ unexpectedBetweenLeftParenAndArgumentList: UnexpectedNodesSyntax? = nil,
    argumentList: LabeledExprListSyntax,
    _ unexpectedBetweenArgumentListAndRightParen: UnexpectedNodesSyntax? = nil,
    _ unexpectedBetweenRightParenAndTrailingClosure: UnexpectedNodesSyntax? = nil,
    trailingClosure: ClosureExprSyntax? = nil,
    _ unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    additionalTrailingClosures: MultipleTrailingClosureElementListSyntax = [],
    _ unexpectedAfterAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeCalledExpression,
      calledExpression: calledExpression,
      unexpectedBetweenCalledExpressionAndLeftParen,
      leftParen: leftParen,
      unexpectedBetweenLeftParenAndArgumentList,
      arguments: argumentList,
      unexpectedBetweenArgumentListAndRightParen,
      rightParen: nil,
      unexpectedBetweenRightParenAndTrailingClosure,
      trailingClosure: trailingClosure,
      unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures,
      additionalTrailingClosures: additionalTrailingClosures,
      unexpectedAfterAdditionalTrailingClosures,
      trailingTrivia: trailingTrivia
    )
  }

  @_disfavoredOverload
  @available(
    *,
    deprecated,
    renamed:
      "init(leadingTrivia:_:calledExpression:_:leftParen:_:arguments:_:rightParen:_:trailingClosure:_:additionalTrailingClosures:_:trailingTrivia:)"
  )
  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeCalledExpression: UnexpectedNodesSyntax? = nil,
    calledExpression: some ExprSyntaxProtocol,
    _ unexpectedBetweenCalledExpressionAndLeftParen: UnexpectedNodesSyntax? = nil,
    _ unexpectedBetweenLeftParenAndArgumentList: UnexpectedNodesSyntax? = nil,
    argumentList: LabeledExprListSyntax,
    _ unexpectedBetweenArgumentListAndRightParen: UnexpectedNodesSyntax? = nil,
    _ unexpectedBetweenRightParenAndTrailingClosure: UnexpectedNodesSyntax? = nil,
    trailingClosure: ClosureExprSyntax? = nil,
    _ unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    additionalTrailingClosures: MultipleTrailingClosureElementListSyntax = [],
    _ unexpectedAfterAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeCalledExpression,
      calledExpression: calledExpression,
      unexpectedBetweenCalledExpressionAndLeftParen,
      leftParen: nil,
      unexpectedBetweenLeftParenAndArgumentList,
      arguments: argumentList,
      unexpectedBetweenArgumentListAndRightParen,
      rightParen: nil,
      unexpectedBetweenRightParenAndTrailingClosure,
      trailingClosure: trailingClosure,
      unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures,
      additionalTrailingClosures: additionalTrailingClosures,
      unexpectedAfterAdditionalTrailingClosures,
      trailingTrivia: trailingTrivia
    )
  }
}

extension FunctionEffectSpecifiersSyntax {
  @_disfavoredOverload
  @available(*, deprecated, message: "use throwsClause instead of throwsSpecifier")
  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAsyncSpecifier: UnexpectedNodesSyntax? = nil,
    asyncSpecifier: TokenSyntax? = nil,
    _ unexpectedBetweenAsyncSpecifierAndThrowsSpecifier: UnexpectedNodesSyntax? = nil,
    throwsSpecifier: TokenSyntax? = nil,
    _ unexpectedAfterThrowsSpecifier: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeAsyncSpecifier,
      asyncSpecifier: asyncSpecifier,
      unexpectedBetweenAsyncSpecifierAndThrowsSpecifier,
      throwsClause: throwsSpecifier.map { ThrowsClauseSyntax(throwsSpecifier: $0) },
      unexpectedAfterThrowsSpecifier,
      trailingTrivia: trailingTrivia
    )
  }
}

extension GenericRequirementSyntax {
  @available(*, deprecated, renamed: "Requirement")
  public typealias Body = Requirement
}

@available(*, deprecated, renamed: "NamedDeclSyntax")
public typealias IdentifiedDeclSyntax = NamedDeclSyntax

extension KeyPathPropertyComponentSyntax {
  @available(*, deprecated, renamed: "declName.baseName")
  public var identifier: TokenSyntax {
    get {
      return declName.baseName
    }
    set {
      declName.baseName = newValue
    }
  }

  @available(*, deprecated, renamed: "declName.argumentNames")
  public var declNameArguments: DeclNameArgumentsSyntax? {
    get {
      return declName.argumentNames
    }
    set {
      declName.argumentNames = newValue
    }
  }
}

extension NamedDeclSyntax {
  @available(*, deprecated, renamed: "name")
  public var identifier: TokenSyntax {
    get {
      return self.name
    }
    set {
      self.name = newValue
    }
  }
}

extension MemberAccessExprSyntax {
  @available(*, deprecated, renamed: "declName.baseName")
  public var name: TokenSyntax {
    get {
      return declName.baseName
    }
    set {
      declName.baseName = newValue
    }
  }

  @available(*, deprecated, renamed: "declName.argumentNames")
  public var declNameArguments: DeclNameArgumentsSyntax? {
    get {
      return declName.argumentNames
    }
    set {
      declName.argumentNames = newValue
    }
  }

  @available(*, deprecated, message: "Use initializer taking `DeclReferenceExprSyntax` instead")
  @_disfavoredOverload
  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeBase: UnexpectedNodesSyntax? = nil,
    base: (some ExprSyntaxProtocol)? = ExprSyntax?.none,
    _ unexpectedBetweenBaseAndPeriod: UnexpectedNodesSyntax? = nil,
    dot: TokenSyntax = .periodToken(),
    _ unexpectedBetweenPeriodAndName: UnexpectedNodesSyntax? = nil,
    name: TokenSyntax,
    _ unexpectedBetweenNameAndDeclNameArguments: UnexpectedNodesSyntax? = nil,
    declNameArguments: DeclNameArgumentsSyntax? = nil,
    _ unexpectedAfterDeclNameArguments: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    let declName = DeclReferenceExprSyntax(
      baseName: name,
      unexpectedBetweenNameAndDeclNameArguments,
      argumentNames: declNameArguments
    )
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeBase,
      base: base,
      unexpectedBetweenBaseAndPeriod,
      period: dot,
      unexpectedBetweenPeriodAndName,
      declName: declName,
      unexpectedAfterDeclNameArguments,
      trailingTrivia: trailingTrivia
    )
  }
}

extension SyntaxProtocol {
  @available(*, deprecated, message: "Use detached computed property instead.")
  public func detach() -> Self {
    return detached
  }
}

extension TokenKind {
  @available(*, deprecated, renamed: "regexPoundDelimiter")
  public static func extendedRegexDelimiter(_ text: String) -> TokenKind {
    return .regexPoundDelimiter(text)
  }

  @available(*, deprecated, renamed: "floatLiteral")
  public static func floatingLiteral(_ text: String) -> TokenKind {
    return .floatLiteral(text)
  }

  @available(*, deprecated, renamed: "leftSquare")
  public static var leftSquareBracket: TokenKind {
    return .leftSquare
  }

  @available(*, deprecated, renamed: "poundAvailable")
  public static var poundAvailableKeyword: TokenKind {
    return .poundAvailable
  }

  @available(*, deprecated, renamed: "poundElse")
  public static var poundElseKeyword: TokenKind {
    return .poundElse
  }

  @available(*, deprecated, renamed: "poundElseif")
  public static var poundElseifKeyword: TokenKind {
    return .poundElseif
  }

  @available(*, deprecated, renamed: "poundEndif")
  public static var poundEndifKeyword: TokenKind {
    return .poundEndif
  }

  @available(*, deprecated, renamed: "poundIf")
  public static var poundIfKeyword: TokenKind {
    return .poundIf
  }

  @available(*, deprecated, renamed: "poundSourceLocation")
  public static var poundSourceLocationKeyword: TokenKind {
    return .poundSourceLocation
  }

  @available(*, deprecated, renamed: "poundUnavailable")
  public static var poundUnavailableKeyword: TokenKind {
    return .poundUnavailable
  }

  @available(*, deprecated, renamed: "rawStringPoundDelimiter")
  public static func rawStringDelimiter(_ text: String) -> TokenKind {
    return .rawStringPoundDelimiter(text)
  }

  @available(*, deprecated, renamed: "rightSquare")
  public static var rightSquareBracket: TokenKind {
    return .rightSquare
  }

  @available(*, deprecated, renamed: "endOfFile")
  public static var eof: TokenKind { .endOfFile }
}

extension TokenSyntax {
  @available(*, deprecated, renamed: "regexPoundDelimiter")
  public static func extendedRegexDelimiter(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return regexPoundDelimiter(
      text,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }

  @available(*, deprecated, renamed: "floatLiteral")
  public static func floatingLiteral(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return floatLiteral(
      text,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }

  @available(*, deprecated, renamed: "leftSquareToken")
  public static func leftSquareBracketToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return .leftSquareToken(
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }

  @available(*, deprecated, renamed: "poundAvailableToken")
  public static func poundAvailableKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return poundAvailableToken(
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }

  @available(*, deprecated, renamed: "poundElseToken")
  public static func poundElseKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return poundElseToken(
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }

  @available(*, deprecated, renamed: "poundElseifToken")
  public static func poundElseifKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return poundElseifToken(
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }

  @available(*, deprecated, renamed: "poundEndifToken")
  public static func poundEndifKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return poundEndifToken(
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }

  @available(*, deprecated, renamed: "poundIfToken")
  public static func poundIfKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return poundIfToken(
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }

  @available(*, deprecated, renamed: "poundSourceLocationToken")
  public static func poundSourceLocationKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return poundSourceLocationToken(
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }

  @available(*, deprecated, renamed: "poundUnavailableToken")
  public static func poundUnavailableKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return poundUnavailableToken(
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }

  @available(*, deprecated, renamed: "rawStringPoundDelimiter")
  public static func rawStringDelimiter(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return rawStringPoundDelimiter(
      text,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }

  @available(*, deprecated, renamed: "rightSquareToken")
  public static func rightSquareBracketToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return .rightSquareToken(
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }

  @available(*, deprecated, renamed: "endOfFileToken")
  public static func eof(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return .endOfFileToken(
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
}

extension TypeEffectSpecifiersSyntax {
  @available(*, deprecated, message: "use throwsClause instead of throwsSpecifier")
  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAsyncSpecifier: UnexpectedNodesSyntax? = nil,
    asyncSpecifier: TokenSyntax? = nil,
    _ unexpectedBetweenAsyncSpecifierAndThrowsSpecifier: UnexpectedNodesSyntax? = nil,
    throwsSpecifier: TokenSyntax? = nil,
    _ unexpectedAfterThrowsSpecifier: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeAsyncSpecifier,
      asyncSpecifier: asyncSpecifier,
      unexpectedBetweenAsyncSpecifierAndThrowsSpecifier,
      throwsClause: throwsSpecifier.map { ThrowsClauseSyntax(throwsSpecifier: $0) },
      unexpectedAfterThrowsSpecifier,
      trailingTrivia: trailingTrivia
    )
  }
}

extension WildcardPatternSyntax {
  @available(*, deprecated, message: "remove 'typeAnnotation'")
  public init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeWildcard: UnexpectedNodesSyntax? = nil,
    wildcard: TokenSyntax = .wildcardToken(),
    _ unexpectedBetweenWildcardAndTypeAnnotation: UnexpectedNodesSyntax? = nil,
    typeAnnotation: TypeAnnotationSyntax? = nil,
    _ unexpectedAfterTypeAnnotation: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeWildcard,
      wildcard: wildcard,
      unexpectedAfterTypeAnnotation,
      trailingTrivia: trailingTrivia
    )
  }

  @available(*, deprecated, message: "'unexpectedBetweenWildcardAndTypeAnnotation' was removed")
  public var unexpectedBetweenWildcardAndTypeAnnotation: UnexpectedNodesSyntax? {
    get { nil }
    set {}
  }

  @available(*, deprecated, message: "'typeAnnotation' was removed")
  public var typeAnnotation: TypeAnnotationSyntax? {
    get { nil }
    set {}
  }

  @available(*, deprecated, renamed: "unexpectedAfterWildcard")
  public var unexpectedAfterTypeAnnotation: UnexpectedNodesSyntax? {
    get { unexpectedAfterWildcard }
    set { unexpectedAfterWildcard = newValue }
  }
}

//==========================================================================//
// IMPORTANT: If you are tempted to add a compatibility layer code here     //
// please insert it in alphabetical order above                             //
//==========================================================================//
