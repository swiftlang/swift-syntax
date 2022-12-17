//===-------------------------- Nominals.swift -----------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
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
    attributes: RawAttributeListSyntax?,
    modifiers: RawModifierListSyntax?,
    _ unexpectedBeforeIntroducerKeyword: RawUnexpectedNodesSyntax?,
    introducerKeyword: RawTokenSyntax,
    _ unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax?,
    identifier: RawTokenSyntax,
    primaryOrGenerics: PrimaryOrGenerics?,
    inheritanceClause: RawTypeInheritanceClauseSyntax?,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    members: RawMemberDeclBlockSyntax,
    arena: __shared SyntaxArena
  )

  static func parsePrimaryOrGenerics(_ parser: inout Parser) -> PrimaryOrGenerics?
}

extension RawProtocolDeclSyntax: NominalTypeDeclarationTrait {
  init(
    attributes: RawAttributeListSyntax?,
    modifiers: RawModifierListSyntax?,
    _ unexpectedBeforeIntroducerKeyword: RawUnexpectedNodesSyntax?,
    introducerKeyword: RawTokenSyntax,
    _ unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax?,
    identifier: RawTokenSyntax,
    primaryOrGenerics: RawPrimaryAssociatedTypeClauseSyntax?,
    inheritanceClause: RawTypeInheritanceClauseSyntax?,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    members: RawMemberDeclBlockSyntax,
    arena: __shared SyntaxArena
  ) {
    self.init(attributes: attributes, modifiers: modifiers, unexpectedBeforeIntroducerKeyword, protocolKeyword: introducerKeyword, unexpectedBeforeIdentifier, identifier: identifier, primaryAssociatedTypeClause: primaryOrGenerics, inheritanceClause: inheritanceClause, genericWhereClause: genericWhereClause, members: members, arena: arena)
  }

  static func parsePrimaryOrGenerics(_ parser: inout Parser) -> RawPrimaryAssociatedTypeClauseSyntax? {
    return parser.parsePrimaryAssociatedTypes()
  }
}

extension RawClassDeclSyntax: NominalTypeDeclarationTrait {
  init(
    attributes: RawAttributeListSyntax?,
    modifiers: RawModifierListSyntax?,
    _ unexpectedBeforeIntroducerKeyword: RawUnexpectedNodesSyntax?,
    introducerKeyword: RawTokenSyntax,
    _ unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax?,
    identifier: RawTokenSyntax,
    primaryOrGenerics: RawGenericParameterClauseSyntax?,
    inheritanceClause: RawTypeInheritanceClauseSyntax?,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    members: RawMemberDeclBlockSyntax,
    arena: __shared SyntaxArena
  ) {
    self.init(attributes: attributes, modifiers: modifiers, unexpectedBeforeIntroducerKeyword, classKeyword: introducerKeyword, unexpectedBeforeIdentifier, identifier: identifier, genericParameterClause: primaryOrGenerics, inheritanceClause: inheritanceClause, genericWhereClause: genericWhereClause, members: members, arena: arena)
  }

  static func parsePrimaryOrGenerics(_ parser: inout Parser) -> RawGenericParameterClauseSyntax? {
    return parser.parseGenericParameters()
  }
}

extension RawActorDeclSyntax: NominalTypeDeclarationTrait {
  init(
    attributes: RawAttributeListSyntax?,
    modifiers: RawModifierListSyntax?,
    _ unexpectedBeforeIntroducerKeyword: RawUnexpectedNodesSyntax?,
    introducerKeyword: RawTokenSyntax,
    _ unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax?,
    identifier: RawTokenSyntax,
    primaryOrGenerics: RawGenericParameterClauseSyntax?,
    inheritanceClause: RawTypeInheritanceClauseSyntax?,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    members: RawMemberDeclBlockSyntax,
    arena: __shared SyntaxArena
  ) {
    self.init(attributes: attributes, modifiers: modifiers, unexpectedBeforeIntroducerKeyword, actorKeyword: introducerKeyword, unexpectedBeforeIdentifier, identifier: identifier, genericParameterClause: primaryOrGenerics, inheritanceClause: inheritanceClause, genericWhereClause: genericWhereClause, members: members, arena: arena)
  }

  static func parsePrimaryOrGenerics(_ parser: inout Parser) -> RawGenericParameterClauseSyntax? {
    return parser.parseGenericParameters()
  }
}

extension RawStructDeclSyntax: NominalTypeDeclarationTrait {
  init(
    attributes: RawAttributeListSyntax?,
    modifiers: RawModifierListSyntax?,
    _ unexpectedBeforeIntroducerKeyword: RawUnexpectedNodesSyntax?,
    introducerKeyword: RawTokenSyntax,
    _ unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax?,
    identifier: RawTokenSyntax,
    primaryOrGenerics: RawGenericParameterClauseSyntax?,
    inheritanceClause: RawTypeInheritanceClauseSyntax?,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    members: RawMemberDeclBlockSyntax,
    arena: __shared SyntaxArena
  ) {
    self.init(attributes: attributes, modifiers: modifiers, unexpectedBeforeIntroducerKeyword, structKeyword: introducerKeyword, unexpectedBeforeIdentifier, identifier: identifier, genericParameterClause: primaryOrGenerics, inheritanceClause: inheritanceClause, genericWhereClause: genericWhereClause, members: members, arena: arena)
  }

  static func parsePrimaryOrGenerics(_ parser: inout Parser) -> RawGenericParameterClauseSyntax? {
    return parser.parseGenericParameters()
  }
}

extension RawEnumDeclSyntax: NominalTypeDeclarationTrait {
  init(
    attributes: RawAttributeListSyntax?,
    modifiers: RawModifierListSyntax?,
    _ unexpectedBeforeIntroducerKeyword: RawUnexpectedNodesSyntax?,
    introducerKeyword: RawTokenSyntax,
    _ unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax?,
    identifier: RawTokenSyntax,
    primaryOrGenerics: RawGenericParameterClauseSyntax?,
    inheritanceClause: RawTypeInheritanceClauseSyntax?,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    members: RawMemberDeclBlockSyntax,
    arena: __shared SyntaxArena
  ) {
    self.init(attributes: attributes, modifiers: modifiers, unexpectedBeforeIntroducerKeyword, enumKeyword: introducerKeyword, unexpectedBeforeIdentifier, identifier: identifier, genericParameters: primaryOrGenerics, inheritanceClause: inheritanceClause, genericWhereClause: genericWhereClause, members: members, arena: arena)
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
    if unexpectedBeforeName == nil && name.isMissing && self.currentToken.isAtStartOfLine {
      return T.init(
        attributes: attrs.attributes,
        modifiers: attrs.modifiers,
        unexpectedBeforeIntroducerKeyword,
        introducerKeyword: introducerKeyword,
        unexpectedBeforeName,
        identifier: name,
        primaryOrGenerics: nil,
        inheritanceClause: nil,
        genericWhereClause: nil,
        members: RawMemberDeclBlockSyntax(
          leftBrace: RawTokenSyntax(missing: .leftBrace, arena: self.arena),
          members: RawMemberDeclListSyntax(elements: [], arena: self.arena),
          rightBrace: RawTokenSyntax(missing: .rightBrace, arena: self.arena),
          arena: self.arena
        ),
        arena: self.arena
      )
    }

    let primaryOrGenerics: T.PrimaryOrGenerics?
    if self.currentToken.starts(with: "<") {
      primaryOrGenerics = T.parsePrimaryOrGenerics(&self)
    } else {
      primaryOrGenerics = nil
    }

    let inheritance: RawTypeInheritanceClauseSyntax?
    if self.at(.colon) {
      inheritance = self.parseInheritance()
    } else {
      inheritance = nil
    }

    // Parse a 'where' clause if present.
    let whereClause: RawGenericWhereClauseSyntax?
    if self.at(.whereKeyword) {
      whereClause = self.parseGenericWhereClause()
    } else {
      whereClause = nil
    }

    let members = self.parseMemberDeclList(introducer: introducerKeyword)
    return T.init(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeIntroducerKeyword,
      introducerKeyword: introducerKeyword,
      unexpectedBeforeName,
      identifier: name,
      primaryOrGenerics: primaryOrGenerics,
      inheritanceClause: inheritance,
      genericWhereClause: whereClause,
      members: members,
      arena: self.arena
    )
  }

  /// Parse an inheritance clause.
  @_spi(RawSyntax)
  public mutating func parseInheritance() -> RawTypeInheritanceClauseSyntax {
    let (unexpectedBeforeColon, colon) = self.expect(.colon)
    var elements = [RawInheritedTypeSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      var loopProgress = LoopProgressCondition()
      repeat {
        let type: RawTypeSyntax
        if let classKeyword = self.consume(if: .classKeyword) {
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
            typeName: type,
            trailingComma: keepGoing,
            arena: self.arena
          )
        )
      } while keepGoing != nil && loopProgress.evaluate(currentToken)
    }
    return RawTypeInheritanceClauseSyntax(
      unexpectedBeforeColon,
      colon: colon,
      inheritedTypeCollection: RawInheritedTypeListSyntax(elements: elements, arena: self.arena),
      arena: self.arena
    )
  }

  @_spi(RawSyntax)
  public mutating func parsePrimaryAssociatedTypes() -> RawPrimaryAssociatedTypeClauseSyntax {
    let langle = self.consumeAnyToken(remapping: .leftAngle)
    var associatedTypes = [RawPrimaryAssociatedTypeSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      var loopProgress = LoopProgressCondition()
      repeat {
        // Parse the name of the parameter.
        let (unexpectedBeforeName, name) = self.expectIdentifier()
        keepGoing = self.consume(if: .comma)
        associatedTypes.append(
          RawPrimaryAssociatedTypeSyntax(
            unexpectedBeforeName,
            name: name,
            trailingComma: keepGoing,
            arena: self.arena
          )
        )
      } while keepGoing != nil && loopProgress.evaluate(currentToken)
    }
    let unexpectedBeforeRangle: RawUnexpectedNodesSyntax?
    let rangle: RawTokenSyntax
    if self.currentToken.starts(with: ">") {
      unexpectedBeforeRangle = nil
      rangle = self.consumePrefix(">", as: .rightAngle)
    } else {
      (unexpectedBeforeRangle, rangle) = self.expect(.rightAngle)
    }
    return RawPrimaryAssociatedTypeClauseSyntax(
      leftAngleBracket: langle,
      primaryAssociatedTypeList: RawPrimaryAssociatedTypeListSyntax(elements: associatedTypes, arena: self.arena),
      unexpectedBeforeRangle,
      rightAngleBracket: rangle,
      arena: self.arena
    )
  }
}
