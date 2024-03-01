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

public extension AccessorEffectSpecifiersSyntax {
  @_disfavoredOverload
  @available(*, deprecated, message: "use throwsClause instead of throwsSpecifier")
  init(
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

public extension DeclGroupSyntax {
  @available(*, deprecated, renamed: "memberBlock")
  var members: MemberDeclBlockSyntax {
    get {
      return memberBlock
    }
    set(value) {
      memberBlock = value
    }
  }
}

public extension EffectSpecifiersSyntax {
  @available(*, deprecated, renamed: "unexpectedBetweenAsyncSpecifierAndThrowsClause")
  var unexpectedBetweenAsyncSpecifierAndThrowsSpecifier: UnexpectedNodesSyntax? {
    get { unexpectedBetweenAsyncSpecifierAndThrowsClause }
    set { unexpectedBetweenAsyncSpecifierAndThrowsClause = newValue }
  }

  @available(*, deprecated, message: "use throwsClause.throwsSpecifier")
  var throwsSpecifier: TokenSyntax? {
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
  var unexpectedAfterThrowsSpecifier: UnexpectedNodesSyntax? {
    get { unexpectedAfterThrowsClause }
    set { unexpectedAfterThrowsClause = newValue }
  }
}

public extension FunctionEffectSpecifiersSyntax {
  @_disfavoredOverload
  @available(*, deprecated, message: "use throwsClause instead of throwsSpecifier")
  init(
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

public extension FreestandingMacroExpansionSyntax {
  @available(*, deprecated, renamed: "pound")
  var poundToken: TokenSyntax {
    get {
      return pound
    }
    set {
      pound = newValue
    }
  }

  @available(*, deprecated, renamed: "macroName")
  var macro: TokenSyntax {
    get {
      return macroName
    }
    set {
      macroName = newValue
    }
  }

  @available(*, deprecated, renamed: "genericArgumentClause")
  var genericArguments: GenericArgumentClauseSyntax? {
    get {
      return genericArgumentClause
    }
    set {
      genericArgumentClause = newValue
    }
  }

  @available(*, deprecated, renamed: "arguments")
  var argumentList: LabeledExprListSyntax {
    get {
      return arguments
    }
    set {
      arguments = newValue
    }
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

public extension SyntaxProtocol {
  @available(*, deprecated, message: "Use detached computed property instead.")
  func detach() -> Self {
    return detached
  }
}

public extension TokenKind {
  @available(*, deprecated, renamed: "regexPoundDelimiter")
  static func extendedRegexDelimiter(_ text: String) -> TokenKind {
    return .regexPoundDelimiter(text)
  }

  @available(*, deprecated, renamed: "floatLiteral")
  static func floatingLiteral(_ text: String) -> TokenKind {
    return .floatLiteral(text)
  }

  @available(*, deprecated, renamed: "leftSquare")
  static var leftSquareBracket: TokenKind {
    return .leftSquare
  }

  @available(*, deprecated, renamed: "poundAvailable")
  static var poundAvailableKeyword: TokenKind {
    return .poundAvailable
  }

  @available(*, deprecated, renamed: "poundElse")
  static var poundElseKeyword: TokenKind {
    return .poundElse
  }

  @available(*, deprecated, renamed: "poundElseif")
  static var poundElseifKeyword: TokenKind {
    return .poundElseif
  }

  @available(*, deprecated, renamed: "poundEndif")
  static var poundEndifKeyword: TokenKind {
    return .poundEndif
  }

  @available(*, deprecated, renamed: "poundIf")
  static var poundIfKeyword: TokenKind {
    return .poundIf
  }

  @available(*, deprecated, renamed: "poundSourceLocation")
  static var poundSourceLocationKeyword: TokenKind {
    return .poundSourceLocation
  }

  @available(*, deprecated, renamed: "poundUnavailable")
  static var poundUnavailableKeyword: TokenKind {
    return .poundUnavailable
  }

  @available(*, deprecated, renamed: "rawStringPoundDelimiter")
  static func rawStringDelimiter(_ text: String) -> TokenKind {
    return .rawStringPoundDelimiter(text)
  }

  @available(*, deprecated, renamed: "rightSquare")
  static var rightSquareBracket: TokenKind {
    return .rightSquare
  }

  @available(*, deprecated, renamed: "endOfFile")
  static var eof: TokenKind { .endOfFile }
}

public extension TokenSyntax {
  @available(*, deprecated, renamed: "regexPoundDelimiter")
  static func extendedRegexDelimiter(
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
  static func floatingLiteral(
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
  static func leftSquareBracketToken(
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
  static func poundAvailableKeyword(
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
  static func poundElseKeyword(
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
  static func poundElseifKeyword(
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
  static func poundEndifKeyword(
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
  static func poundIfKeyword(
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
  static func poundSourceLocationKeyword(
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
  static func poundUnavailableKeyword(
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
  static func rawStringDelimiter(
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
  static func rightSquareBracketToken(
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
  static func eof(
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

public extension TypeEffectSpecifiersSyntax {
  @available(*, deprecated, message: "use throwsClause instead of throwsSpecifier")
  init(
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

public extension WildcardPatternSyntax {
  @available(*, deprecated, message: "remove 'typeAnnotation'")
  init(
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
    );
  }

  @available(*, deprecated, message: "'unexpectedBetweenWildcardAndTypeAnnotation' was removed")
  var unexpectedBetweenWildcardAndTypeAnnotation: UnexpectedNodesSyntax? {
    get { nil }
    set {}
  }

  @available(*, deprecated, message: "'typeAnnotation' was removed")
  var typeAnnotation: TypeAnnotationSyntax? {
    get { nil }
    set {}
  }

  @available(*, deprecated, renamed: "unexpectedAfterWildcard")
  var unexpectedAfterTypeAnnotation: UnexpectedNodesSyntax? {
    get { unexpectedAfterWildcard }
    set { unexpectedAfterWildcard = newValue }
  }
}

//==========================================================================//
// IMPORTANT: If you are tempted to add a compatibility layer code here     //
// please insert it in alphabetical order above                             //
//==========================================================================//
