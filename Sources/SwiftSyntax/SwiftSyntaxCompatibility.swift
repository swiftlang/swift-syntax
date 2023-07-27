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

public extension FreestandingMacroExpansionSyntax {
  @available(*, deprecated, renamed: "genericArgumentClause")
  var genericArguments: GenericArgumentClauseSyntax? {
    get {
      return genericArgumentClause
    }
    set {
      genericArgumentClause = newValue
    }
  }
}

extension GenericRequirementSyntax {
  @available(*, deprecated, renamed: "Requirement")
  public typealias Body = Requirement
}

@available(*, deprecated, renamed: "NamedDecl")
public typealias IdentifiedDeclSyntax = NamedDeclSyntax

@available(*, deprecated, renamed: "NamedDecl")
extension IdentifiedDeclSyntax where Self: NamedDeclSyntax {
  public var identifier: TokenSyntax {
    get {
      return self.name
    }
    set {
      self.name = newValue
    }
  }
}

extension PatternBindingSyntax {
  @available(*, deprecated, renamed: "Accessors")
  public typealias Accessor = Accessors
}

extension SubscriptDeclSyntax {
  @available(*, deprecated, renamed: "Accessors")
  public typealias Accessor = Accessors
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
  static func poundElseIfKeyword(
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

//==========================================================================//
// IMPORTANT: If you are tempted to add a compatibility layer code here     //
// please insert it in alphabetical order above                             //
//==========================================================================//
