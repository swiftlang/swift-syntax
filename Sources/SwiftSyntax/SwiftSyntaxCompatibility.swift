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
    .parameterClause(parameterClause)
  }
}

public extension DeclGroupSyntax {
  @available(*, deprecated, renamed: "memberBlock")
  var members: MemberDeclBlockSyntax {
    get {
      memberBlock
    }
    set(value) {
      memberBlock = value
    }
  }
}

public extension FreestandingMacroExpansionSyntax {
  @available(*, deprecated, renamed: "pound")
  var poundToken: TokenSyntax {
    get {
      pound
    }
    set {
      pound = newValue
    }
  }

  @available(*, deprecated, renamed: "macroName")
  var macro: TokenSyntax {
    get {
      macroName
    }
    set {
      macroName = newValue
    }
  }

  @available(*, deprecated, renamed: "genericArgumentClause")
  var genericArguments: GenericArgumentClauseSyntax? {
    get {
      genericArgumentClause
    }
    set {
      genericArgumentClause = newValue
    }
  }

  @available(*, deprecated, renamed: "arguments")
  var argumentList: LabeledExprListSyntax {
    get {
      arguments
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
      declName.baseName
    }
    set {
      declName.baseName = newValue
    }
  }

  @available(*, deprecated, renamed: "declName.argumentNames")
  public var declNameArguments: DeclNameArgumentsSyntax? {
    get {
      declName.argumentNames
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
      self.name
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
      declName.baseName
    }
    set {
      declName.baseName = newValue
    }
  }

  @available(*, deprecated, renamed: "declName.argumentNames")
  public var declNameArguments: DeclNameArgumentsSyntax? {
    get {
      declName.argumentNames
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
    detached
  }
}

public extension TokenKind {
  @available(*, deprecated, renamed: "regexPoundDelimiter")
  static func extendedRegexDelimiter(_ text: String) -> TokenKind {
    .regexPoundDelimiter(text)
  }

  @available(*, deprecated, renamed: "floatLiteral")
  static func floatingLiteral(_ text: String) -> TokenKind {
    .floatLiteral(text)
  }

  @available(*, deprecated, renamed: "leftSquare")
  static var leftSquareBracket: TokenKind {
    .leftSquare
  }

  @available(*, deprecated, renamed: "poundAvailable")
  static var poundAvailableKeyword: TokenKind {
    .poundAvailable
  }

  @available(*, deprecated, renamed: "poundElse")
  static var poundElseKeyword: TokenKind {
    .poundElse
  }

  @available(*, deprecated, renamed: "poundElseif")
  static var poundElseifKeyword: TokenKind {
    .poundElseif
  }

  @available(*, deprecated, renamed: "poundEndif")
  static var poundEndifKeyword: TokenKind {
    .poundEndif
  }

  @available(*, deprecated, renamed: "poundIf")
  static var poundIfKeyword: TokenKind {
    .poundIf
  }

  @available(*, deprecated, renamed: "poundSourceLocation")
  static var poundSourceLocationKeyword: TokenKind {
    .poundSourceLocation
  }

  @available(*, deprecated, renamed: "poundUnavailable")
  static var poundUnavailableKeyword: TokenKind {
    .poundUnavailable
  }

  @available(*, deprecated, renamed: "rawStringPoundDelimiter")
  static func rawStringDelimiter(_ text: String) -> TokenKind {
    .rawStringPoundDelimiter(text)
  }

  @available(*, deprecated, renamed: "rightSquare")
  static var rightSquareBracket: TokenKind {
    .rightSquare
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
    regexPoundDelimiter(
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
    floatLiteral(
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
    .leftSquareToken(
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
    poundAvailableToken(
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
    poundElseToken(
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
    poundElseifToken(
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
    poundEndifToken(
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
    poundIfToken(
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
    poundSourceLocationToken(
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
    poundUnavailableToken(
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
    rawStringPoundDelimiter(
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
    .rightSquareToken(
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
    .endOfFileToken(
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
}

//==========================================================================//
// IMPORTANT: If you are tempted to add a compatibility layer code here     //
// please insert it in alphabetical order above                             //
//==========================================================================//
