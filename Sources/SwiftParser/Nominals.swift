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

@_spi(RawSyntax) import SwiftSyntax

protocol NominalTypeDeclarationTrait {
  associatedtype PrimaryOrGenerics

  init(
    attributes: RawAttributeListSyntax,
    modifiers: RawDeclModifierListSyntax,
    _ unexpectedBeforeIntroducerKeyword: RawUnexpectedNodesSyntax?,
    introducerKeyword: RawTokenSyntax,
    _ unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax?,
    name: RawTokenSyntax,
    primaryOrGenerics: PrimaryOrGenerics?,
    inheritanceClause: RawInheritanceClauseSyntax?,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    memberBlock: RawMemberBlockSyntax,
    arena: __shared SyntaxArena
  )

  static func parsePrimaryOrGenerics(_ parser: inout Parser) -> PrimaryOrGenerics?
}

extension RawProtocolDeclSyntax: NominalTypeDeclarationTrait {
  init(
    attributes: RawAttributeListSyntax,
    modifiers: RawDeclModifierListSyntax,
    _ unexpectedBeforeIntroducerKeyword: RawUnexpectedNodesSyntax?,
    introducerKeyword: RawTokenSyntax,
    _ unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax?,
    name: RawTokenSyntax,
    primaryOrGenerics: RawPrimaryAssociatedTypeClauseSyntax?,
    inheritanceClause: RawInheritanceClauseSyntax?,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    memberBlock: RawMemberBlockSyntax,
    arena: __shared SyntaxArena
  ) {
    self.init(
      attributes: attributes,
      modifiers: modifiers,
      unexpectedBeforeIntroducerKeyword,
      protocolKeyword: introducerKeyword,
      unexpectedBeforeIdentifier,
      name: name,
      primaryAssociatedTypeClause: primaryOrGenerics,
      inheritanceClause: inheritanceClause,
      genericWhereClause: genericWhereClause,
      memberBlock: memberBlock,
      arena: arena
    )
  }

  static func parsePrimaryOrGenerics(_ parser: inout Parser) -> RawPrimaryAssociatedTypeClauseSyntax? {
    return parser.parsePrimaryAssociatedTypes()
  }
}

extension RawClassDeclSyntax: NominalTypeDeclarationTrait {
  init(
    attributes: RawAttributeListSyntax,
    modifiers: RawDeclModifierListSyntax,
    _ unexpectedBeforeIntroducerKeyword: RawUnexpectedNodesSyntax?,
    introducerKeyword: RawTokenSyntax,
    _ unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax?,
    name: RawTokenSyntax,
    primaryOrGenerics: RawGenericParameterClauseSyntax?,
    inheritanceClause: RawInheritanceClauseSyntax?,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    memberBlock: RawMemberBlockSyntax,
    arena: __shared SyntaxArena
  ) {
    self.init(
      attributes: attributes,
      modifiers: modifiers,
      unexpectedBeforeIntroducerKeyword,
      classKeyword: introducerKeyword,
      unexpectedBeforeIdentifier,
      name: name,
      genericParameterClause: primaryOrGenerics,
      inheritanceClause: inheritanceClause,
      genericWhereClause: genericWhereClause,
      memberBlock: memberBlock,
      arena: arena
    )
  }

  static func parsePrimaryOrGenerics(_ parser: inout Parser) -> RawGenericParameterClauseSyntax? {
    return parser.parseGenericParameters()
  }
}

extension RawActorDeclSyntax: NominalTypeDeclarationTrait {
  init(
    attributes: RawAttributeListSyntax,
    modifiers: RawDeclModifierListSyntax,
    _ unexpectedBeforeIntroducerKeyword: RawUnexpectedNodesSyntax?,
    introducerKeyword: RawTokenSyntax,
    _ unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax?,
    name: RawTokenSyntax,
    primaryOrGenerics: RawGenericParameterClauseSyntax?,
    inheritanceClause: RawInheritanceClauseSyntax?,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    memberBlock: RawMemberBlockSyntax,
    arena: __shared SyntaxArena
  ) {
    self.init(
      attributes: attributes,
      modifiers: modifiers,
      unexpectedBeforeIntroducerKeyword,
      actorKeyword: introducerKeyword,
      unexpectedBeforeIdentifier,
      name: name,
      genericParameterClause: primaryOrGenerics,
      inheritanceClause: inheritanceClause,
      genericWhereClause: genericWhereClause,
      memberBlock: memberBlock,
      arena: arena
    )
  }

  static func parsePrimaryOrGenerics(_ parser: inout Parser) -> RawGenericParameterClauseSyntax? {
    return parser.parseGenericParameters()
  }
}

extension RawStructDeclSyntax: NominalTypeDeclarationTrait {
  init(
    attributes: RawAttributeListSyntax,
    modifiers: RawDeclModifierListSyntax,
    _ unexpectedBeforeIntroducerKeyword: RawUnexpectedNodesSyntax?,
    introducerKeyword: RawTokenSyntax,
    _ unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax?,
    name: RawTokenSyntax,
    primaryOrGenerics: RawGenericParameterClauseSyntax?,
    inheritanceClause: RawInheritanceClauseSyntax?,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    memberBlock: RawMemberBlockSyntax,
    arena: __shared SyntaxArena
  ) {
    self.init(
      attributes: attributes,
      modifiers: modifiers,
      unexpectedBeforeIntroducerKeyword,
      structKeyword: introducerKeyword,
      unexpectedBeforeIdentifier,
      name: name,
      genericParameterClause: primaryOrGenerics,
      inheritanceClause: inheritanceClause,
      genericWhereClause: genericWhereClause,
      memberBlock: memberBlock,
      arena: arena
    )
  }

  static func parsePrimaryOrGenerics(_ parser: inout Parser) -> RawGenericParameterClauseSyntax? {
    return parser.parseGenericParameters()
  }
}

extension RawEnumDeclSyntax: NominalTypeDeclarationTrait {
  init(
    attributes: RawAttributeListSyntax,
    modifiers: RawDeclModifierListSyntax,
    _ unexpectedBeforeIntroducerKeyword: RawUnexpectedNodesSyntax?,
    introducerKeyword: RawTokenSyntax,
    _ unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax?,
    name: RawTokenSyntax,
    primaryOrGenerics: RawGenericParameterClauseSyntax?,
    inheritanceClause: RawInheritanceClauseSyntax?,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    memberBlock: RawMemberBlockSyntax,
    arena: __shared SyntaxArena
  ) {
    self.init(
      attributes: attributes,
      modifiers: modifiers,
      unexpectedBeforeIntroducerKeyword,
      enumKeyword: introducerKeyword,
      unexpectedBeforeIdentifier,
      name: name,
      genericParameterClause: primaryOrGenerics,
      inheritanceClause: inheritanceClause,
      genericWhereClause: genericWhereClause,
      memberBlock: memberBlock,
      arena: arena
    )
  }

  static func parsePrimaryOrGenerics(_ parser: inout Parser) -> RawGenericParameterClauseSyntax? {
    return parser.parseGenericParameters()
  }
}

extension Parser {
  /// Parse a nominal type decl declaration - class, struct, enum, or actor.
  mutating func parseNominalTypeDeclaration<T>(
    for T: T.Type,
    attrs: DeclAttributes,
    introucerHandle: RecoveryConsumptionHandle
  ) -> T where T: NominalTypeDeclarationTrait {
    let (unexpectedBeforeIntroducerKeyword, introducerKeyword) = self.eat(introucerHandle)
    let (unexpectedBeforeName, name) = self.expectIdentifier(keywordRecovery: true)
    if unexpectedBeforeName == nil && name.isMissing && self.atStartOfLine {
      return T.init(
        attributes: attrs.attributes,
        modifiers: attrs.modifiers,
        unexpectedBeforeIntroducerKeyword,
        introducerKeyword: introducerKeyword,
        unexpectedBeforeName,
        name: name,
        primaryOrGenerics: nil,
        inheritanceClause: nil,
        genericWhereClause: nil,
        memberBlock: RawMemberBlockSyntax(
          leftBrace: missingToken(.leftBrace),
          members: RawMemberBlockItemListSyntax(elements: [], arena: self.arena),
          rightBrace: missingToken(.rightBrace),
          arena: self.arena
        ),
        arena: self.arena
      )
    }

    let primaryOrGenerics: T.PrimaryOrGenerics?
    if self.at(prefix: "<") {
      primaryOrGenerics = T.parsePrimaryOrGenerics(&self)
    } else {
      primaryOrGenerics = nil
    }

    let inheritance: RawInheritanceClauseSyntax?
    if self.at(.colon) || self.atPythonStyleInheritanceClause() {
      inheritance = self.parseInheritance()
    } else {
      inheritance = nil
    }

    // Parse a 'where' clause if present.
    let whereClause: RawGenericWhereClauseSyntax?
    if self.at(.keyword(.where)) {
      whereClause = self.parseGenericWhereClause()
    } else {
      whereClause = nil
    }

    let memberBlock = self.parseMemberBlock(introducer: introducerKeyword)
    return T.init(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeIntroducerKeyword,
      introducerKeyword: introducerKeyword,
      unexpectedBeforeName,
      name: name,
      primaryOrGenerics: primaryOrGenerics,
      inheritanceClause: inheritance,
      genericWhereClause: whereClause,
      memberBlock: memberBlock,
      arena: self.arena
    )
  }

  /// Parse an inheritance clause.
  mutating func parseInheritance() -> RawInheritanceClauseSyntax {
    let unexpectedBeforeColon: RawUnexpectedNodesSyntax?
    let colon: RawTokenSyntax

    let isPythonStyleInheritanceClause: Bool
    // Parse python style inheritance clause and replace parentheses with a colon
    if let leftParen = self.consume(if: .leftParen) {
      unexpectedBeforeColon = RawUnexpectedNodesSyntax([leftParen], arena: self.arena)
      colon = missingToken(.colon)
      isPythonStyleInheritanceClause = true
    } else {
      (unexpectedBeforeColon, colon) = self.expect(.colon)
      isPythonStyleInheritanceClause = false
    }

    var elements = [RawInheritedTypeSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      var loopProgress = LoopProgressCondition()
      repeat {
        let type: RawTypeSyntax
        if let classKeyword = self.consume(if: .keyword(.class)) {
          type = RawTypeSyntax(
            RawClassRestrictionTypeSyntax(
              classKeyword: classKeyword,
              arena: self.arena
            )
          )
        } else {
          type = self.parseType()
        }

        keepGoing = self.consume(if: .comma)
        elements.append(
          RawInheritedTypeSyntax(
            type: type,
            trailingComma: keepGoing,
            arena: self.arena
          )
        )
      } while keepGoing != nil && self.hasProgressed(&loopProgress)
    }

    let unexpectedAfterInheritedTypeCollection: RawUnexpectedNodesSyntax?

    // If it is a Python style inheritance clause, then consume a right paren if there is one.
    if isPythonStyleInheritanceClause, let rightParen = self.consume(if: .rightParen) {
      unexpectedAfterInheritedTypeCollection = RawUnexpectedNodesSyntax(elements: [RawSyntax(rightParen)], arena: self.arena)
    } else {
      unexpectedAfterInheritedTypeCollection = nil
    }

    return RawInheritanceClauseSyntax(
      unexpectedBeforeColon,
      colon: colon,
      inheritedTypes: RawInheritedTypeListSyntax(elements: elements, arena: self.arena),
      unexpectedAfterInheritedTypeCollection,
      arena: self.arena
    )
  }

  mutating func parsePrimaryAssociatedTypes() -> RawPrimaryAssociatedTypeClauseSyntax {
    let langle = self.consumePrefix("<", as: .leftAngle)
    var associatedTypes = [RawPrimaryAssociatedTypeSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      var loopProgress = LoopProgressCondition()
      repeat {
        // Parse the name of the parameter.
        let (unexpectedBeforeName, name) = self.expectIdentifier(allowSelfOrCapitalSelfAsIdentifier: true)
        keepGoing = self.consume(if: .comma)
        associatedTypes.append(
          RawPrimaryAssociatedTypeSyntax(
            unexpectedBeforeName,
            name: name,
            trailingComma: keepGoing,
            arena: self.arena
          )
        )
      } while keepGoing != nil && self.hasProgressed(&loopProgress)
    }
    let rangle = self.expectWithoutRecovery(prefix: ">", as: .rightAngle)
    return RawPrimaryAssociatedTypeClauseSyntax(
      leftAngle: langle,
      primaryAssociatedTypes: RawPrimaryAssociatedTypeListSyntax(elements: associatedTypes, arena: self.arena),
      rightAngle: rangle,
      arena: self.arena
    )
  }
}

extension Parser {
  private mutating func atPythonStyleInheritanceClause() -> Bool {
    guard self.at(.leftParen) else { return false }
    return self.withLookahead {
      $0.consume(if: .leftParen)
      guard $0.canParseType() else { return false }
      return $0.at(.rightParen, .keyword(.where), .leftBrace) || $0.at(.endOfFile)
    }
  }
}
