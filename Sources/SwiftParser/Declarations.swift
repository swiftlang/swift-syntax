//===----------------------- Declarations.swift ---------------------------===//
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

extension TokenConsumer {
  func atStartOfDeclaration(
    context: Parser.ItemContext? = nil,
    allowRecovery: Bool = false
  ) -> Bool {
    if self.at(anyIn: PoundDeclarationStart.self) != nil {
      return true
    }

    var subparser = self.lookahead()

    var hasAttribute = false
    var attributeProgress = LoopProgressCondition()
    while attributeProgress.evaluate(subparser.currentToken) && subparser.at(.atSign) {
      hasAttribute = true
      _ = subparser.consumeAttributeList()
    }

    if subparser.currentToken.isKeyword {
      var modifierProgress = LoopProgressCondition()
      while let (modifierKind, handle) = subparser.at(anyIn: DeclarationModifier.self),
              modifierKind != .classKeyword,
              modifierProgress.evaluate(subparser.currentToken) {
        subparser.eat(handle)
        if subparser.at(.leftParen) {
          subparser.consumeAnyToken()
          subparser.consume(to: .rightParen)
        }
      }
    }

    if hasAttribute {
      if subparser.at(.rightBrace) || subparser.at(.eof) || subparser.at(.poundEndifKeyword) {
        return true
      }
    }

    if subparser.at(.poundIfKeyword) {
      var attrLookahead = subparser.lookahead()
      return attrLookahead.consumeIfConfigOfAttributes()
    }

    let declStartKeyword: DeclarationStart?
    if allowRecovery {
      declStartKeyword = subparser.canRecoverTo(
        anyIn: DeclarationStart.self,
        recoveryPrecedence: context == .topLevel ? nil : .closingBrace
      )?.0
    } else {
      declStartKeyword = subparser.at(anyIn: DeclarationStart.self)?.0
    }
    switch declStartKeyword {
    case .actorContextualKeyword:
      // actor Foo {}
      if subparser.peek().tokenKind == .identifier {
        return true
      }
      // actor may be somewhere in the modifier list. Eat the tokens until we get
      // to something that isn't the start of a decl. If that is an identifier,
      // it's an actor declaration, otherwise, it isn't.
      var lookahead = subparser.lookahead()
      repeat {
        lookahead.consumeAnyToken()
      } while lookahead.atStartOfDeclaration()
      return lookahead.at(.identifier)
    case .caseKeyword:
      // When 'case' appears inside a function, it's probably a switch
      // case, not an enum case declaration.
      return false
    case nil:
      if subparser.at(anyIn: ContextualDeclKeyword.self)?.0 != nil {
        subparser.consumeAnyToken()
        return subparser.atStartOfDeclaration(
          context: context, allowRecovery: allowRecovery)
      }
      return false
    default: return true
    }
  }
}

extension Parser {
  @_spi(RawSyntax)
  public struct DeclAttributes {
    public var attributes: RawAttributeListSyntax?
    public var modifiers: RawModifierListSyntax?

    public init(attributes: RawAttributeListSyntax?, modifiers: RawModifierListSyntax?) {
      self.attributes = attributes
      self.modifiers = modifiers
    }
  }

  /// Parse a declaration.
  ///
  /// Grammar
  /// =======
  ///
  ///     declaration → import-declaration
  ///     declaration → constant-declaration
  ///     declaration → variable-declaration
  ///     declaration → typealias-declaration
  ///     declaration → function-declaration
  ///     declaration → enum-declaration
  ///     declaration → struct-declaration
  ///     declaration → class-declaration
  ///     declaration → actor-declaration
  ///     declaration → protocol-declaration
  ///     declaration → initializer-declaration
  ///     declaration → deinitializer-declaration
  ///     declaration → extension-declaration
  ///     declaration → subscript-declaration
  ///     declaration → operator-declaration
  ///     declaration → precedence-group-declaration
  ///
  ///     declarations → declaration declarations?
  @_spi(RawSyntax)
  public mutating func parseDeclaration() -> RawDeclSyntax {
    switch self.at(anyIn: PoundDeclarationStart.self) {
    case (.poundIfKeyword, _)?:
      return RawDeclSyntax(self.parsePoundIfDirective { parser in
        let parsedDecl = parser.parseDeclaration()
        let semicolon = parser.consume(if: .semicolon)
        return RawMemberDeclListItemSyntax(
          decl: parsedDecl,
          semicolon: semicolon,
          arena: parser.arena)
      }
                           syntax: { parser, elements in
        return RawSyntax(RawMemberDeclListSyntax(elements: elements, arena: parser.arena))
      })
    case (.poundWarningKeyword, _)?, (.poundErrorKeyword, _)?:
      return self.parsePoundDiagnosticDeclaration()
    case nil:
      break
    }

    let attrs = DeclAttributes(
      attributes: self.parseAttributeList(),
      modifiers: self.parseModifierList())
    switch self.canRecoverTo(anyIn: DeclarationStart.self) {
    case (.importKeyword, let handle)?:
      return RawDeclSyntax(self.parseImportDeclaration(attrs, handle))
    case (.classKeyword, let handle)?:
      return RawDeclSyntax(self.parseClassDeclaration(attrs, handle))
    case (.enumKeyword, let handle)?:
      return RawDeclSyntax(self.parseEnumDeclaration(attrs, handle))
    case (.caseKeyword, let handle)?:
      return RawDeclSyntax(self.parseEnumCaseDeclaration(attrs, handle))
    case (.structKeyword, let handle)?:
      return RawDeclSyntax(self.parseStructDeclaration(attrs, handle))
    case (.protocolKeyword, let handle)?:
      return RawDeclSyntax(self.parseProtocolDeclaration(attrs, handle))
    case (.associatedtypeKeyword, let handle)?:
      return RawDeclSyntax(self.parseAssociatedTypeDeclaration(attrs, handle))
    case (.typealiasKeyword, let handle)?:
      return RawDeclSyntax(self.parseTypealiasDeclaration(attrs, handle))
    case (.extensionKeyword, let handle)?:
      return RawDeclSyntax(self.parseExtensionDeclaration(attrs, handle))
    case (.funcKeyword, let handle)?:
      return RawDeclSyntax(self.parseFuncDeclaration(attrs, handle))
    case (.subscriptKeyword, let handle)?:
      return RawDeclSyntax(self.parseSubscriptDeclaration(attrs, handle))
    case (.letKeyword, let handle)?, (.varKeyword, let handle)?:
      return RawDeclSyntax(self.parseLetOrVarDeclaration(attrs, handle))
    case (.initKeyword, let handle)?:
      return RawDeclSyntax(self.parseInitializerDeclaration(attrs, handle))
    case (.deinitKeyword, let handle)?:
      return RawDeclSyntax(self.parseDeinitializerDeclaration(attrs, handle))
    case (.operatorKeyword, let handle)?:
      return RawDeclSyntax(self.parseOperatorDeclaration(attrs, handle))
    case (.precedencegroupKeyword, let handle)?:
      return RawDeclSyntax(self.parsePrecedenceGroupDeclaration(attrs, handle))
    case (.actorContextualKeyword, let handle)?:
      return RawDeclSyntax(self.parseActorDeclaration(attrs, handle))
    case nil:
      return RawDeclSyntax(RawMissingDeclSyntax(
        attributes: attrs.attributes,
        modifiers: attrs.modifiers,
        arena: self.arena))
    }
  }
}

extension Parser {
  /// Parse an import declaration.
  ///
  /// Grammar
  /// =======
  ///
  ///     import-declaration → attributes? 'import' import-kind? import-path
  ///     import-kind → 'typealias' | 'struct' | 'class' | 'enum' | 'protocol' | 'let' | 'var' | 'func'
  ///     import-path → identifier | identifier '.' import-path
  @_spi(RawSyntax)
  public mutating func parseImportDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawImportDeclSyntax {
    let (unexpectedBeforeImportKeyword, importKeyword) = self.eat(handle)
    let kind = self.parseImportKind()
    let path = self.parseImportAccessPath()
    return RawImportDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeImportKeyword,
      importTok: importKeyword,
      importKind: kind,
      path: path,
      arena: self.arena)
  }

  @_spi(RawSyntax)
  public mutating func parseImportKind() -> RawTokenSyntax? {
    return self.consume(ifAny: [.typealiasKeyword, .structKeyword, .classKeyword, .enumKeyword, .protocolKeyword, .varKeyword, .letKeyword, .funcKeyword])
  }

  @_spi(RawSyntax)
  public mutating func parseImportAccessPath() -> RawAccessPathSyntax {
    var elements = [RawAccessPathComponentSyntax]()
    var keepGoing: RawTokenSyntax? = nil
    var loopProgress = LoopProgressCondition()
    repeat {
      let name = self.parseAnyIdentifier()
      keepGoing = self.consume(if: .period)
      elements.append(RawAccessPathComponentSyntax(
        name: name, trailingDot: keepGoing, arena: self.arena))
    } while keepGoing != nil && loopProgress.evaluate(currentToken)
    return RawAccessPathSyntax(elements: elements, arena: self.arena)
  }
}

extension Parser {
  /// Parse an extension declaration.
  ///
  /// Grammar
  /// =======
  ///
  ///     extension-declaration → attributes? access-level-modifier? 'extension' type-identifier type-inheritance-clause? generic-where-clause?t extension-body
  ///     extension-body → '{' extension-members? '}'
  ///     extension-members → extension-member extension-members?
  ///     extension-member → declaration | compiler-control-statement
  @_spi(RawSyntax)
  public mutating func parseExtensionDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawExtensionDeclSyntax {
    let (unexpectedBeforeExtensionKeyword, extensionKeyword) = self.eat(handle)
    let type = self.parseType()

    let inheritance: RawTypeInheritanceClauseSyntax?
    if self.at(.colon) {
      inheritance = self.parseInheritance()
    } else {
      inheritance = nil
    }

    let whereClause: RawGenericWhereClauseSyntax?
    if self.at(.whereKeyword) {
      whereClause = self.parseGenericWhereClause()
    } else {
      whereClause = nil
    }
    let members = self.parseMemberDeclList()
    return RawExtensionDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeExtensionKeyword,
      extensionKeyword: extensionKeyword,
      extendedType: type,
      inheritanceClause: inheritance,
      genericWhereClause: whereClause,
      members: members,
      arena: self.arena)
  }
}

extension Parser {
  @_spi(RawSyntax)
  public mutating func parseGenericParameters() -> RawGenericParameterClauseSyntax {
    assert(self.currentToken.starts(with: "<"))

    let langle = self.consumeAnyToken(remapping: .leftAngle)
    var elements = [RawGenericParameterSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      var loopProgress = LoopProgressCondition()
      repeat {
        let attributes = self.parseAttributeList()

        let (unexpectedBeforeName, name) = self.expectIdentifier()
        if attributes == nil && unexpectedBeforeName == nil && name.isMissing && elements.isEmpty {
          break
        }

        // Parse the ':' followed by a type.
        let colon = self.consume(if: .colon)
        let inherited: RawTypeSyntax?
        if colon != nil {
          if self.at(any: [.identifier, .protocolKeyword, .anyKeyword]) {
            inherited = self.parseType()
          } else {
            inherited = nil
          }
        } else {
          inherited = nil
        }
        keepGoing = self.consume(if: .comma)
        elements.append(RawGenericParameterSyntax(
          attributes: attributes,
          unexpectedBeforeName,
          name: name,
          colon: colon,
          inheritedType: inherited,
          trailingComma: keepGoing,
          arena: self.arena))
      } while keepGoing != nil && loopProgress.evaluate(currentToken)
    }

    let whereClause: RawGenericWhereClauseSyntax?
    if self.at(.whereKeyword) {
      whereClause = self.parseGenericWhereClause()
    } else {
      whereClause = nil
    }

    let rangle: RawTokenSyntax
    if self.currentToken.starts(with: ">") {
      rangle = self.consumeAnyToken(remapping: .rightAngle)
    } else {
      rangle = RawTokenSyntax(missing: .rightAngle, arena: self.arena)
    }

    let parameters: RawGenericParameterListSyntax
    if elements.isEmpty && rangle.isMissing {
      parameters = RawGenericParameterListSyntax(elements: [], arena: self.arena)
    } else {
      parameters = RawGenericParameterListSyntax(elements: elements, arena: self.arena)
    }
    return RawGenericParameterClauseSyntax(
      leftAngleBracket: langle,
      genericParameterList: parameters,
      genericWhereClause: whereClause,
      rightAngleBracket: rangle,
      arena: self.arena)
  }

  enum LayoutConstraint: SyntaxText, ContextualKeywords {
    case trivialLayout = "_Trivial"
    case trivialAtMostLayout = "_TrivialAtMost"
    case unknownLayout = "_UnknownLayout"
    case refCountedObjectLayout = "_RefCountedObject"
    case nativeRefCountedObjectLayout = "_NativeRefCountedObject"
    case classLayout = "_Class"
    case nativeClassLayout = "_NativeClass"

    var hasArguments: Bool {
      switch self {
      case .trivialLayout,
           .trivialAtMostLayout:
        return true

      case .unknownLayout,
           .refCountedObjectLayout,
           .nativeRefCountedObjectLayout,
           .classLayout,
           .nativeClassLayout:
        return false
      }
    }
  }

  @_spi(RawSyntax)
  public mutating func parseGenericWhereClause() -> RawGenericWhereClauseSyntax {
    let (unexpectedBeforeWhereKeyword, whereKeyword) = self.expect(.whereKeyword)

    var elements = [RawGenericRequirementSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      var loopProgress = LoopProgressCondition()
      repeat {
        let firstType = self.parseType()
        guard !firstType.is(RawMissingTypeSyntax.self) else {
          keepGoing = self.consume(if: .comma)
          elements.append(RawGenericRequirementSyntax(
            body: RawSyntax(RawMissingSyntax(arena: self.arena)),
            trailingComma: keepGoing,
            arena: self.arena
          ))
          continue
        }

        enum ExpectedTokenKind: RawTokenKindSubset {
          case colon
          case spacedBinaryOperator
          case unspacedBinaryOperator
          case postfixOperator
          case prefixOperator

          init?(lexeme: Lexer.Lexeme) {
            switch (lexeme.tokenKind, lexeme.tokenText) {
            case (.colon, _): self = .colon
            case (.spacedBinaryOperator, "=="): self = .spacedBinaryOperator
            case (.unspacedBinaryOperator, "=="): self = .unspacedBinaryOperator
            case (.postfixOperator, "=="): self = .postfixOperator
            case (.prefixOperator, "=="): self = .prefixOperator
            default: return nil
            }
          }

          var rawTokenKind: RawTokenKind {
            switch self {
            case .colon: return .colon
            case .spacedBinaryOperator: return .spacedBinaryOperator
            case .unspacedBinaryOperator: return .unspacedBinaryOperator
            case .postfixOperator: return .postfixOperator
            case .prefixOperator: return .prefixOperator
            }
          }
        }

        let requirement: RawSyntax
        switch self.at(anyIn: ExpectedTokenKind.self) {
        case (.colon, let handle)?:
          let colon = self.eat(handle)
          // A conformance-requirement.
          if let (layoutConstraint, handle) = self.at(anyIn: LayoutConstraint.self) {
            // Parse a layout constraint.
            let constraint = self.eat(handle)

            let unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax?
            let leftParen: RawTokenSyntax?
            let size: RawTokenSyntax?
            let comma: RawTokenSyntax?
            let alignment: RawTokenSyntax?
            let unexpectedBeforeRightParen: RawUnexpectedNodesSyntax?
            let rightParen: RawTokenSyntax?
            // Unlike the other layout constraints, _Trivial's argument list
            // is optional.
            if layoutConstraint.hasArguments && (layoutConstraint != .trivialLayout || self.at(.leftParen)) {
              (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
              size = self.expectWithoutRecovery(.integerLiteral)
              comma = self.consume(if: .comma)
              if comma != nil {
                alignment = self.expectWithoutRecovery(.integerLiteral)
              } else {
                alignment = nil
              }
              (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
            } else {
              unexpectedBeforeLeftParen = nil
              leftParen = nil
              size = nil
              comma = nil
              alignment = nil
              unexpectedBeforeRightParen = nil
              rightParen = nil
            }

            requirement = RawSyntax(RawLayoutRequirementSyntax(
              typeIdentifier: firstType,
              colon: colon,
              layoutConstraint: constraint,
              unexpectedBeforeLeftParen,
              leftParen: leftParen,
              size: size,
              comma: comma,
              alignment: alignment,
              unexpectedBeforeRightParen,
              rightParen: rightParen,
              arena: self.arena))
          } else {
            // Parse the protocol or composition.
            let secondType = self.parseType()
            requirement = RawSyntax(RawConformanceRequirementSyntax(
              leftTypeIdentifier: firstType,
              colon: colon,
              rightTypeIdentifier: secondType,
              arena: self.arena))
          }
        case (.spacedBinaryOperator, let handle)?,
          (.unspacedBinaryOperator, let handle)?,
          (.postfixOperator, let handle)?,
          (.prefixOperator, let handle)?:
          let equal = self.eat(handle)
          let secondType = self.parseType()
          requirement = RawSyntax(RawSameTypeRequirementSyntax(
            leftTypeIdentifier: firstType,
            equalityToken: equal,
            rightTypeIdentifier: secondType,
            arena: self.arena))
        case nil:
          requirement = RawSyntax(RawSameTypeRequirementSyntax(
            leftTypeIdentifier: firstType,
            equalityToken: RawTokenSyntax(missing: .equal, arena: self.arena),
            rightTypeIdentifier: RawTypeSyntax(RawMissingTypeSyntax(arena: self.arena)),
            arena: self.arena
          ))
        }

        keepGoing = self.consume(if: .comma)
        elements.append(RawGenericRequirementSyntax(
          body: requirement, trailingComma: keepGoing, arena: self.arena))
      } while keepGoing != nil && loopProgress.evaluate(currentToken)
    }

    return RawGenericWhereClauseSyntax(
      unexpectedBeforeWhereKeyword,
      whereKeyword: whereKeyword,
      requirementList: RawGenericRequirementListSyntax(elements: elements, arena: self.arena),
      arena: self.arena)
  }
}

extension Parser {
  @_spi(RawSyntax)
  public mutating func parseMemberDeclList() -> RawMemberDeclBlockSyntax {
    var elements = [RawMemberDeclListItemSyntax]()
    let (unexpectedBeforeLBrace, lbrace) = self.expect(.leftBrace)
    do {
      var loopProgress = LoopProgressCondition()
      while !self.at(any: [.eof, .rightBrace]) && loopProgress.evaluate(currentToken) {
        let decl: RawDeclSyntax
        if self.at(.poundSourceLocationKeyword) {
          decl = RawDeclSyntax(self.parsePoundSourceLocationDirective())
        } else {
          decl = self.parseDeclaration()
        }

        let semi = self.consume(if: .semicolon)
        elements.append(RawMemberDeclListItemSyntax(
          decl: decl, semicolon: semi, arena: self.arena))
        if decl.is(RawMissingDeclSyntax.self) {
          break
        }
      }
    }
    let (unexpectedBeforeRBrace, rbrace) = self.expect(.rightBrace)
    let members: RawMemberDeclListSyntax
    if elements.isEmpty && (lbrace.isMissing || rbrace.isMissing) {
      members = RawMemberDeclListSyntax(elements: [], arena: self.arena)
    } else {
      members = RawMemberDeclListSyntax(elements: elements, arena: self.arena)
    }

    return RawMemberDeclBlockSyntax(
      unexpectedBeforeLBrace,
      leftBrace: lbrace,
      members: members,
      unexpectedBeforeRBrace,
      rightBrace: rbrace,
      arena: self.arena)
  }
}

extension Parser {
  /// Parse a class declaration.
  ///
  /// Grammar
  /// =======
  ///
  ///     class-declaration → attributes? access-level-modifier? final? 'class' class-name generic-parameter-clause? type-inheritance-clause? generic-where-clause? class-body
  ///     class-declaration → attributes? final access-level-modifier? 'class' class-name generic-parameter-clause? type-inheritance-clause? generic-where-clause? class-body
  ///
  ///     class-name → identifier
  ///
  ///     class-body → '{' class-members? '}'
  ///
  ///     class-members → class-member class-members?
  ///     class-member → declaration | compiler-control-statement
  @_spi(RawSyntax)
  public mutating func parseClassDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawClassDeclSyntax {
    let (unexpectedBeforeClassKeyword, classKeyword) = self.eat(handle)
    let (unexpectedBeforeName, name) = self.expectIdentifier()
    if unexpectedBeforeName == nil && name.isMissing {
      return RawClassDeclSyntax(
        attributes: attrs.attributes,
        modifiers: attrs.modifiers,
        unexpectedBeforeClassKeyword,
        classKeyword: classKeyword,
        unexpectedBeforeName,
        identifier: name,
        genericParameterClause: nil,
        inheritanceClause: nil,
        genericWhereClause: nil,
        members: RawMemberDeclBlockSyntax(
          leftBrace: RawTokenSyntax(missing: .leftBrace, arena: self.arena),
          members: RawMemberDeclListSyntax(elements: [], arena: self.arena),
          rightBrace: RawTokenSyntax(missing: .rightBrace, arena: self.arena),
          arena: self.arena
        ),
        arena: self.arena)
    }

    let generics: RawGenericParameterClauseSyntax?
    if self.currentToken.starts(with: "<") {
      generics = self.parseGenericParameters()
    } else {
      generics = nil
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

    let members = self.parseMemberDeclList()
    return RawClassDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeClassKeyword,
      classKeyword: classKeyword,
      unexpectedBeforeName,
      identifier: name,
      genericParameterClause: generics,
      inheritanceClause: inheritance,
      genericWhereClause: whereClause,
      members: members,
      arena: self.arena)
  }

  /// Parse a class declaration.
  ///
  /// Grammar
  /// =======
  ///
  ///     type-inheritance-clause → ':' type-inheritance-list
  ///     type-inheritance-list → attributes? type-identifier | attributes? type-identifier ',' type-inheritance-list
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
          type = RawTypeSyntax(RawClassRestrictionTypeSyntax(
            classKeyword: classKeyword,
            arena: self.arena
          ))
        } else {
          type = self.parseType()
        }

        keepGoing = self.consume(if: .comma)
        elements.append(RawInheritedTypeSyntax(
          typeName: type, trailingComma: keepGoing, arena: self.arena))
      } while keepGoing != nil && loopProgress.evaluate(currentToken)
    }
    return RawTypeInheritanceClauseSyntax(
      unexpectedBeforeColon,
      colon: colon,
      inheritedTypeCollection: RawInheritedTypeListSyntax(elements: elements, arena: self.arena),
      arena: self.arena
    )
  }
}

extension Parser {
  /// Parse an enum declaration.
  ///
  /// Grammar
  /// =======
  ///
  ///     enum-declaration → attributes? access-level-modifier? union-style-enum
  ///     enum-declaration → attributes? access-level-modifier? raw-value-style-enum
  ///
  ///     union-style-enum → 'indirect'? 'enum' enum-name generic-parameter-clause? type-inheritance-clause? generic-where-clause?' '{' union-style-enum-members? '}'
  ///     union-style-enum-members → union-style-enum-member union-style-enum-members?
  ///     union-style-enum-member → declaration | union-style-enum-case-clause | compiler-control-statement
  ///
  ///     enum-name → identifier
  ///     enum-case-name → identifier
  ///
  ///     raw-value-style-enum → 'enum' enum-name generic-parameter-clause? type-inheritance-clause generic-where-clause? '{' raw-value-style-enum-members '}'
  ///     raw-value-style-enum-members → raw-value-style-enum-member raw-value-style-enum-members?
  ///     raw-value-style-enum-member → declaration | raw-value-style-enum-case-clause | compiler-control-statement
  @_spi(RawSyntax)
  public mutating func parseEnumDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawEnumDeclSyntax {
    let (unexpectedBeforeEnumKeyword, enumKeyword) = self.eat(handle)
    let (unexpectedBeforeName, name) = self.expectIdentifier()
    if unexpectedBeforeName == nil, name.isMissing {
      return RawEnumDeclSyntax(
        attributes: attrs.attributes,
        modifiers: attrs.modifiers,
        unexpectedBeforeEnumKeyword,
        enumKeyword: enumKeyword,
        unexpectedBeforeName,
        identifier: name,
        genericParameters: nil,
        inheritanceClause: nil,
        genericWhereClause: nil,
        members: RawMemberDeclBlockSyntax(
          leftBrace: RawTokenSyntax(missing: .leftBrace, arena: self.arena),
          members: RawMemberDeclListSyntax(elements: [], arena: self.arena),
          rightBrace: RawTokenSyntax(missing: .rightBrace, arena: self.arena),
          arena: self.arena
        ),
        arena: self.arena)
    }

    let generics: RawGenericParameterClauseSyntax?
    if self.currentToken.starts(with: "<") {
      generics = self.parseGenericParameters()
    } else {
      generics = nil
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

    let members = self.parseMemberDeclList()
    return RawEnumDeclSyntax(
      attributes: attrs.attributes, modifiers: attrs.modifiers,
      unexpectedBeforeEnumKeyword,
      enumKeyword: enumKeyword,
      unexpectedBeforeName,
      identifier: name,
      genericParameters: generics,
      inheritanceClause: inheritance,
      genericWhereClause: whereClause,
      members: members,
      arena: self.arena)
  }

  /// Parse an enum 'case' declaration.
  ///
  /// Grammar
  /// =======
  ///
  ///     union-style-enum-case-clause → attributes? 'indirect'? 'case' union-style-enum-case-list
  ///     union-style-enum-case-list → union-style-enum-case | union-style-enum-case ',' union-style-enum-case-list
  ///     union-style-enum-case → enum-case-name tuple-type?
  ///
  ///     raw-value-style-enum-case-clause → attributes? 'case' raw-value-style-enum-case-list
  ///     raw-value-style-enum-case-list → raw-value-style-enum-case | raw-value-style-enum-case ',' raw-value-style-enum-case-list
  ///     raw-value-style-enum-case → enum-case-name raw-value-assignment?
  ///     raw-value-assignment → = raw-value-literal
  ///     raw-value-literal → numeric-literal | static-string-literal | boolean-literal
  @_spi(RawSyntax)
  public mutating func parseEnumCaseDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawEnumCaseDeclSyntax {
    let (unexpectedBeforeCaseKeyword, caseKeyword) = self.eat(handle)
    var elements = [RawEnumCaseElementSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      var loopProgress = LoopProgressCondition()
      repeat {
        let (unexpectedBeforeName, name) = self.expectIdentifier()

        let associatedValue: RawParameterClauseSyntax?
        if self.at(.leftParen, where: { !$0.isAtStartOfLine }) {
          associatedValue = self.parseParameterClause(for: .enumCase)
        } else {
          associatedValue = nil
        }

        // See if there's a raw value expression.
        let rawValue: RawInitializerClauseSyntax?
        if let eq = self.consume(if: .equal) {
          let value = self.parseExpression()
          rawValue = RawInitializerClauseSyntax(
            equal: eq,
            value: value,
            arena: self.arena
          )
        } else {
          rawValue = nil
        }

        // Continue through the comma-separated list.
        keepGoing = self.consume(if: .comma)
        elements.append(RawEnumCaseElementSyntax(
          unexpectedBeforeName,
          identifier: name,
          associatedValue: associatedValue,
          rawValue: rawValue,
          trailingComma: keepGoing,
          arena: self.arena))
      } while keepGoing != nil && loopProgress.evaluate(currentToken)
    }

    return RawEnumCaseDeclSyntax(
      attributes: attrs.attributes, modifiers: attrs.modifiers,
      unexpectedBeforeCaseKeyword,
      caseKeyword: caseKeyword,
      elements: RawEnumCaseElementListSyntax(elements: elements, arena: self.arena),
      arena: self.arena)
  }
}

extension Parser {
  /// Parse a struct declaration.
  ///
  /// Grammar
  /// =======
  ///
  ///     struct-declaration → attributes? access-level-modifier? struct struct-name generic-parameter-clause? type-inheritance-clause? generic-where-clause? struct-body
  ///
  ///     struct-name → identifier
  ///
  ///     struct-body → '{' struct-members? '}'
  ///
  ///     struct-members → struct-member struct-members?
  ///     struct-member → declaration | compiler-control-statement
  @_spi(RawSyntax)
  public mutating func parseStructDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawStructDeclSyntax {
    let (unexpectedBeforeStructKeyword, structKeyword) = self.eat(handle)
    let (unexpectedBeforeName, name) = self.expectIdentifier()
    if unexpectedBeforeName == nil && name.isMissing {
      return RawStructDeclSyntax(
        attributes: attrs.attributes,
        modifiers: attrs.modifiers,
        unexpectedBeforeStructKeyword,
        structKeyword: structKeyword,
        unexpectedBeforeName,
        identifier: name,
        genericParameterClause: nil,
        inheritanceClause: nil,
        genericWhereClause: nil,
        members: RawMemberDeclBlockSyntax(
          leftBrace: RawTokenSyntax(missing: .leftBrace, arena: self.arena),
          members: RawMemberDeclListSyntax(elements: [], arena: self.arena),
          rightBrace: RawTokenSyntax(missing: .rightBrace, arena: self.arena),
          arena: self.arena
        ),
        arena: self.arena)
    }

    let generics: RawGenericParameterClauseSyntax?
    if self.currentToken.starts(with: "<") {
      generics = self.parseGenericParameters()
    } else {
      generics = nil
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

    let members = self.parseMemberDeclList()
    return RawStructDeclSyntax(
      attributes: attrs.attributes, modifiers: attrs.modifiers,
      unexpectedBeforeStructKeyword,
      structKeyword: structKeyword,
      unexpectedBeforeName,
      identifier: name,
      genericParameterClause: generics,
      inheritanceClause: inheritance,
      genericWhereClause: whereClause,
      members: members,
      arena: self.arena)
  }
}

extension Parser {
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
        associatedTypes.append(RawPrimaryAssociatedTypeSyntax(
          unexpectedBeforeName,
          name: name,
          trailingComma: keepGoing,
          arena: self.arena))
      } while keepGoing != nil && loopProgress.evaluate(currentToken)
    }
    let rangle = self.consumeAnyToken(remapping: .rightAngle)
    return RawPrimaryAssociatedTypeClauseSyntax(
      leftAngleBracket: langle,
      primaryAssociatedTypeList: RawPrimaryAssociatedTypeListSyntax(elements: associatedTypes, arena: self.arena),
      rightAngleBracket: rangle,
      arena: self.arena)
  }

  /// Parse a protocol declaration.
  ///
  /// Grammar
  /// =======
  ///
  ///     protocol-declaration → attributes? access-level-modifier? 'protocol' protocol-name type-inheritance-clause? generic-where-clause? protocol-body
  ///
  ///     protocol-name → identifier
  ///     protocol-body → '{' protocol-members? '}'
  ///
  ///     protocol-members → protocol-member protocol-members?
  ///     protocol-member → protocol-member-declaration | compiler-control-statement
  ///
  ///     protocol-member-declaration → protocol-property-declaration
  ///     protocol-member-declaration → protocol-method-declaration
  ///     protocol-member-declaration → protocol-initializer-declaration
  ///     protocol-member-declaration → protocol-subscript-declaration
  ///     protocol-member-declaration → protocol-associated-type-declaration
  ///     protocol-member-declaration → typealias-declaration
  @_spi(RawSyntax)
  public mutating func parseProtocolDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawProtocolDeclSyntax {
    let (unexpectedBeforeProtocolKeyword, protocolKeyword) = self.eat(handle)
    let (unexpectedBeforeName, name) = self.expectIdentifier()
    if unexpectedBeforeName == nil && name.isMissing {
      return RawProtocolDeclSyntax(
        attributes: attrs.attributes,
        modifiers: attrs.modifiers,
        unexpectedBeforeProtocolKeyword,
        protocolKeyword: protocolKeyword,
        unexpectedBeforeName,
        identifier: name,
        primaryAssociatedTypeClause: nil,
        inheritanceClause: nil,
        genericWhereClause: nil,
        members: RawMemberDeclBlockSyntax(
          leftBrace: RawTokenSyntax(missing: .leftBrace, arena: self.arena),
          members: RawMemberDeclListSyntax(elements: [], arena: self.arena),
          rightBrace: RawTokenSyntax(missing: .rightBrace, arena: self.arena),
          arena: self.arena
        ),
        arena: self.arena)
    }

    let primaries: RawPrimaryAssociatedTypeClauseSyntax?
    if self.currentToken.starts(with: "<") {
      primaries = self.parsePrimaryAssociatedTypes()
    } else {
      primaries = nil
    }


    // Parse optional inheritance clause.
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

    let members = self.parseMemberDeclList()

    return RawProtocolDeclSyntax(
      attributes: attrs.attributes, modifiers: attrs.modifiers,
      unexpectedBeforeProtocolKeyword,
      protocolKeyword: protocolKeyword,
      unexpectedBeforeName,
      identifier: name,
      primaryAssociatedTypeClause: primaries,
      inheritanceClause: inheritance,
      genericWhereClause: whereClause,
      members: members,
      arena: self.arena)
  }
}

extension Parser {
  /// Parse an associated type declaration.
  ///
  /// Grammar
  /// =======
  ///
  ///     protocol-associated-type-declaration → attributes? access-level-modifier? 'associatedtype' typealias-name type-inheritance-clause? typealias-assignment? generic-where-clause?
  @_spi(RawSyntax)
  public mutating func parseAssociatedTypeDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawAssociatedtypeDeclSyntax {
    let (unexpectedBeforeAssocKeyword, assocKeyword) = self.eat(handle)
    let (unexpectedBeforeName, name) = self.expectIdentifier()
    if unexpectedBeforeName == nil && name.isMissing {
      return RawAssociatedtypeDeclSyntax(
        attributes: attrs.attributes,
        modifiers: attrs.modifiers,
        unexpectedBeforeAssocKeyword,
        associatedtypeKeyword: assocKeyword,
        unexpectedBeforeName,
        identifier: name,
        inheritanceClause: nil,
        initializer: nil,
        genericWhereClause: nil,
        arena: self.arena)
    }

    // Parse optional inheritance clause.
    let inheritance: RawTypeInheritanceClauseSyntax?
    if self.at(.colon) {
      inheritance = self.parseInheritance()
    } else {
      inheritance = nil
    }

    // Parse default type, if any.
    let defaultType: RawTypeInitializerClauseSyntax?
    if let equal = self.consume(if: .equal) {
      let type = self.parseType()
      defaultType = RawTypeInitializerClauseSyntax(
        equal: equal,
        value: type,
        arena: self.arena
      )
    } else {
      defaultType = nil
    }

    // Parse a 'where' clause if present.
    let whereClause: RawGenericWhereClauseSyntax?
    if self.at(.whereKeyword) {
      whereClause = self.parseGenericWhereClause()
    } else {
      whereClause = nil
    }

    return RawAssociatedtypeDeclSyntax(
      attributes: attrs.attributes, modifiers: attrs.modifiers,
      unexpectedBeforeAssocKeyword,
      associatedtypeKeyword: assocKeyword,
      unexpectedBeforeName,
      identifier: name,
      inheritanceClause: inheritance,
      initializer: defaultType,
      genericWhereClause: whereClause,
      arena: self.arena)
  }
}

extension Parser {
  /// Parse an actor declaration.
  ///
  /// Grammar
  /// =======
  ///
  ///     actor-declaration → attributes? access-level-modifier? 'actor' actor-name generic-parameter-clause? type-inheritance-clause? generic-where-clause? actor-body
  ///     actor-name → identifier
  ///     actor-body → '{' actor-members? '}'
  ///     actor-members → actor-member actor-members?
  ///     actor-member → declaration | compiler-control-statement
  @_spi(RawSyntax)
  public mutating func parseActorDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawActorDeclSyntax {
    let (unexpectedBeforeActorKeyword, actorKeyword) = self.eat(handle)
    let (unexpectedBeforeName, name) = self.expectIdentifier()

    let generics: RawGenericParameterClauseSyntax?
    if self.currentToken.starts(with: "<") {
      generics = self.parseGenericParameters()
    } else {
      generics = nil
    }

    // Parse optional inheritance clause.
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

    let members = self.parseMemberDeclList()
    return RawActorDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeActorKeyword,
      actorKeyword: actorKeyword,
      unexpectedBeforeName,
      identifier: name,
      genericParameterClause: generics,
      inheritanceClause: inheritance,
      genericWhereClause: whereClause,
      members: members,
      arena: self.arena)
  }
}

extension Parser {
  /// Parse an initializer declaration.
  ///
  /// Grammar
  /// =======
  ///
  ///     initializer-declaration → initializer-head generic-parameter-clause? parameter-clause 'async'? 'throws'? generic-where-clause? initializer-body
  ///     initializer-declaration → initializer-head generic-parameter-clause? parameter-clause 'async'? 'rethrows' generic-where-clause? initializer-body
  ///
  ///     initializer-head → attributes? declaration-modifiers? 'init'
  ///     initializer-head → attributes? declaration-modifiers? 'init' '?'
  ///     initializer-head → attributes? declaration-modifiers? 'init' '!'
  ///     initializer-body → code-block
  @_spi(RawSyntax)
  public mutating func parseInitializerDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawInitializerDeclSyntax {
    let (unexpectedBeforeInitKeyword, initKeyword) = self.eat(handle)

    // Parse the '!' or '?' for a failable initializer.
    let failable: RawTokenSyntax?
    if let parsedFailable = self.consume(ifAny: [.exclamationMark, .postfixQuestionMark, .infixQuestionMark]) {
      failable = parsedFailable
    } else if let parsedFailable = self.consumeIfContextualPunctuator("!") {
      failable = parsedFailable
    } else {
      failable = nil
    }

    let generics: RawGenericParameterClauseSyntax?
    if self.currentToken.starts(with: "<") {
      generics = self.parseGenericParameters()
    } else {
      generics = nil
    }

    // Parse the signature.
    let signature = self.parseFunctionSignature()

    let whereClause: RawGenericWhereClauseSyntax?
    if self.at(.whereKeyword) {
      whereClause = self.parseGenericWhereClause()
    } else {
      whereClause = nil
    }

    let items = self.parseOptionalCodeBlock()

    return RawInitializerDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeInitKeyword,
      initKeyword: initKeyword,
      optionalMark: failable,
      genericParameterClause: generics,
      signature: signature,
      genericWhereClause: whereClause,
      body: items,
      arena: self.arena)
  }

  /// Parse a deinitializer declaration.
  ///
  /// Grammar
  /// =======
  ///
  /// deinitializer-declaration → attributes? 'deinit' code-block
  @_spi(RawSyntax)
  public mutating func parseDeinitializerDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawDeinitializerDeclSyntax {
    let (unexpectedBeforeDeinitKeyword, deinitKeyword) = self.eat(handle)
    let items = self.parseOptionalCodeBlock()
    return RawDeinitializerDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeDeinitKeyword,
      deinitKeyword: deinitKeyword,
      body: items,
      arena: self.arena
    )
  }
}

extension Parser {
  @_spi(RawSyntax)
  public enum ParameterSubject {
    case closure
    case enumCase
    case functionParameters
    case indices

    var isClosure: Bool {
      switch self {
      case .closure: return true
      case .enumCase: return false
      case .functionParameters: return false
      case .indices: return false
      }
    }
  }

  mutating func parseParameterModifiers(for subject: ParameterSubject) -> RawModifierListSyntax? {
    var elements = [RawDeclModifierSyntax]()
    var loopCondition = LoopProgressCondition()
    MODIFIER_LOOP: while loopCondition.evaluate(currentToken) {
      switch self.at(anyIn: ParameterModifier.self) {
      case (._const, let handle)?:
        elements.append(RawDeclModifierSyntax(name: self.eat(handle), detail: nil, arena: self.arena))
      case (.isolated, let handle)? where !self.lookahead().startsParameterName(subject.isClosure):
        elements.append(RawDeclModifierSyntax(name: self.eat(handle), detail: nil, arena: self.arena))
      default:
        break MODIFIER_LOOP
      }
    }
    if elements.isEmpty {
      return nil
    } else {
      return RawModifierListSyntax(elements: elements, arena: self.arena)
    }
  }

  @_spi(RawSyntax)
  public mutating func parseParameterClause(for subject: ParameterSubject) -> RawParameterClauseSyntax {
    let (unexpectedBeforeLParen, lparen) = self.expect(.leftParen)
    var elements = [RawFunctionParameterSyntax]()
    // If we are missing the left parenthesis and the next token doesn't appear
    // to be an argument label, don't parse any parameters.
    let shouldSkipParameterParsing = lparen.isMissing && (!currentToken.canBeArgumentLabel || currentToken.isKeyword)
    if !shouldSkipParameterParsing {
      var keepGoing = true
      var loopProgress = LoopProgressCondition()
      while !self.at(any: [.eof, .rightParen])
              && keepGoing
              && loopProgress.evaluate(currentToken) {
        // Parse any declaration attributes. The exception here is enum cases
        // which only allow types, so we do not consume attributes to allow the
        // type attribute grammar a chance to examine them.
        let attrs: RawAttributeListSyntax?
        if case .enumCase = subject {
          attrs = nil
        } else {
          attrs = self.parseAttributeList()
        }

        let modifiers = parseParameterModifiers(for: subject)

        let firstName: RawTokenSyntax?
        let secondName: RawTokenSyntax?
        let unexpectedBeforeColon: RawUnexpectedNodesSyntax?
        let colon: RawTokenSyntax?
        let shouldParseType: Bool

        if self.lookahead().startsParameterName(subject.isClosure) {
          if self.currentToken.canBeArgumentLabel {
            firstName = self.parseArgumentLabel()
          } else {
            firstName = nil
          }

          if self.currentToken.canBeArgumentLabel {
            secondName = self.parseArgumentLabel()
          } else {
            secondName = nil
          }
          if subject.isClosure {
            unexpectedBeforeColon = nil
            colon = self.consume(if: .colon)
            shouldParseType = (colon != nil)
          } else {
            (unexpectedBeforeColon, colon) = self.expect(.colon)
            shouldParseType = true
          }
        } else {
          firstName = nil
          secondName = nil
          unexpectedBeforeColon = nil
          colon = nil
          shouldParseType = true
        }

        let type: RawTypeSyntax?
        if shouldParseType {
          type = self.parseType()
        } else {
          type = nil
        }

        let ellipsis: RawTokenSyntax?
        if self.atContextualPunctuator("...") {
          ellipsis = self.consumeAnyToken(remapping: .ellipsis)
        } else {
          ellipsis = nil
        }

        let defaultArgument: RawInitializerClauseSyntax?
        if self.at(.equal) {
          defaultArgument = self.parseDefaultArgument()
        } else {
          defaultArgument = nil
        }

        let trailingComma = self.consume(if: .comma)
        keepGoing = trailingComma != nil
        elements.append(RawFunctionParameterSyntax(
          attributes: attrs,
          modifiers: modifiers,
          firstName: firstName,
          secondName: secondName,
          unexpectedBeforeColon,
          colon: colon,
          type: type,
          ellipsis: ellipsis,
          defaultArgument: defaultArgument,
          trailingComma: trailingComma,
          arena: self.arena))
      }
    }
    let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)

    let parameters: RawFunctionParameterListSyntax
    if elements.isEmpty && (lparen.isMissing || rparen.isMissing) {
      parameters = RawFunctionParameterListSyntax(elements: [], arena: self.arena)
    } else {
      parameters = RawFunctionParameterListSyntax(elements: elements, arena: self.arena)
    }

    return RawParameterClauseSyntax(
      unexpectedBeforeLParen,
      leftParen: lparen,
      parameterList: parameters,
      unexpectedBeforeRParen,
      rightParen: rparen,
      arena: self.arena)
  }

  /// If a `throws` keyword appears right in front of the `arrow`, it is returned as `misplacedThrowsKeyword` so it can be synthesized in front of the arrow.
  @_spi(RawSyntax)
  public mutating func parseFunctionReturnClause() -> (returnClause: RawReturnClauseSyntax, misplacedThrowsKeyword: RawTokenSyntax?) {
    let (unexpectedBeforeArrow, arrow) = self.expect(.arrow)
    var misplacedThrowsKeyword: RawTokenSyntax? = nil
    let unexpectedBeforeReturnType: RawUnexpectedNodesSyntax?
    if let throwsKeyword = self.consume(ifAny: [.rethrowsKeyword, .throwsKeyword]) {
      misplacedThrowsKeyword = throwsKeyword
      unexpectedBeforeReturnType = RawUnexpectedNodesSyntax(elements: [RawSyntax(throwsKeyword)], arena: self.arena)
    } else {
      unexpectedBeforeReturnType = nil
    }
    let result = self.parseResultType()
    let returnClause = RawReturnClauseSyntax(
      unexpectedBeforeArrow,
      arrow: arrow,
      unexpectedBeforeReturnType,
      returnType: result,
      arena: self.arena)
    return (returnClause, misplacedThrowsKeyword)
  }
}

extension Parser {
  /// Are we at a regular expression literal that could act as an operator?
  private func atRegexLiteralThatCouldBeAnOperator() -> Bool {
    guard self.at(.regexLiteral) else {
      return false
    }

    /// Try to re-lex at regex literal as an operator. If it succeeds and
    /// consumes the entire regex literal, we're done.
    return self.currentToken.tokenText.withBuffer {
        (buffer: UnsafeBufferPointer<UInt8>) -> Bool in
      var cursor = Lexer.Cursor(input: buffer, previous: 0)
      guard buffer[0] == UInt8(ascii: "/") else { return false }

      switch (cursor.lexOperatorIdentifier(cursor, cursor)) {
      case (.unknown, _):
        return false

      default:
        return cursor.input.isEmpty
      }
    }
  }

  @_spi(RawSyntax)
  public mutating func parseFuncDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawFunctionDeclSyntax {
    let (unexpectedBeforeFuncKeyword, funcKeyword) = self.eat(handle)
    let unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax?
    let identifier: RawTokenSyntax
    if self.at(anyIn: Operator.self) != nil ||
        self.at(any: [.exclamationMark, .prefixAmpersand]) ||
        self.atRegexLiteralThatCouldBeAnOperator()
    {
      var name = self.currentToken.tokenText
      if name.count > 1 && name.hasSuffix("<") && self.peek().tokenKind == .identifier {
        name = SyntaxText(rebasing: name.dropLast())
      }
      unexpectedBeforeIdentifier = nil
      identifier = self.consumePrefix(name, as: .spacedBinaryOperator)
    } else {
      (unexpectedBeforeIdentifier, identifier) = self.expectIdentifier()
    }

    let genericParams: RawGenericParameterClauseSyntax?
    if self.currentToken.starts(with: "<") {
      genericParams = self.parseGenericParameters()
    } else {
      genericParams = nil
    }

    let signature = self.parseFunctionSignature()

    let generics: RawGenericWhereClauseSyntax?
    if self.at(.whereKeyword) {
      generics = self.parseGenericWhereClause()
    } else {
      generics = nil
    }

    let body = self.parseOptionalCodeBlock()
    return RawFunctionDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeFuncKeyword,
      funcKeyword: funcKeyword,
      unexpectedBeforeIdentifier,
      identifier: identifier,
      genericParameterClause: genericParams,
      signature: signature,
      genericWhereClause: generics,
      body: body,
      arena: self.arena)
  }

  @_spi(RawSyntax)
  public mutating func parseFunctionSignature() -> RawFunctionSignatureSyntax {
    let input = self.parseParameterClause(for: .functionParameters)

    let async: RawTokenSyntax?
    if let asyncTok = self.consumeIfContextualKeyword("async") {
      async = asyncTok
    } else if let reasync = self.consumeIfContextualKeyword("reasync") {
      async = reasync
    } else {
      async = nil
    }

    var throwsKeyword = self.consume(ifAny: [.throwsKeyword, .rethrowsKeyword])

    let output: RawReturnClauseSyntax?
    if self.at(.arrow) {
      let result = self.parseFunctionReturnClause()
      output = result.returnClause
      if let misplacedThrowsKeyword = result.misplacedThrowsKeyword, throwsKeyword == nil {
        throwsKeyword = RawTokenSyntax(missing: misplacedThrowsKeyword.tokenKind, arena: self.arena)
      }
    } else {
      output = nil
    }

    return RawFunctionSignatureSyntax(
      input: input,
      asyncOrReasyncKeyword: async,
      throwsOrRethrowsKeyword: throwsKeyword,
      output: output,
      arena: self.arena)
  }
}

extension Parser {
  /// Parse a subscript declaration.
  ///
  /// Grammar
  /// =======
  ///
  ///     subscript-declaration → subscript-head subscript-result generic-where-clause? code-block
  ///     subscript-declaration → subscript-head subscript-result generic-where-clause? getter-setter-block
  ///     subscript-declaration → subscript-head subscript-result generic-where-clause? getter-setter-keyword-block
  ///     subscript-head → attributes? declaration-modifiers? 'subscript' generic-parameter-clause? parameter-clause
  ///     subscript-result → '->' attributes? type
  @_spi(RawSyntax)
  public mutating func parseSubscriptDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawSubscriptDeclSyntax {
    let (unexpectedBeforeSubscriptKeyword, subscriptKeyword) = self.eat(handle)
    let genericParameterClause: RawGenericParameterClauseSyntax?
    if self.currentToken.starts(with: "<") {
      genericParameterClause = self.parseGenericParameters()
    } else {
      genericParameterClause = nil
    }

    let indices = self.parseParameterClause(for: .indices)

    let result: RawReturnClauseSyntax
    if self.at(.arrow) {
      result = self.parseFunctionReturnClause().returnClause
    } else {
      result = RawReturnClauseSyntax(
        arrow: RawTokenSyntax(missing: .arrow, arena: self.arena),
        returnType: RawTypeSyntax(RawMissingTypeSyntax(arena: self.arena)),
        arena: self.arena
      )
    }

    // Parse a 'where' clause if present.
    let genericWhereClause: RawGenericWhereClauseSyntax?
    if self.at(.whereKeyword) {
      genericWhereClause = self.parseGenericWhereClause()
    } else {
      genericWhereClause = nil
    }

    // Parse getter and setter.
    let accessor: RawSyntax?
    if self.at(.leftBrace) {
      accessor = self.parseGetSet()
    } else {
      accessor = nil
    }
    
    return RawSubscriptDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeSubscriptKeyword,
      subscriptKeyword: subscriptKeyword,
      genericParameterClause: genericParameterClause,
      indices: indices,
      result: result,
      genericWhereClause: genericWhereClause,
      accessor: accessor,
      arena: self.arena)
  }
}

extension Parser {
  /// Parse a variable declaration starting with a leading 'let' or 'var' keyword.
  ///
  /// Grammar
  /// =======
  ///
  ///     constant-declaration → attributes? declaration-modifiers? 'let' pattern-initializer-list
  ///     pattern-initializer-list → pattern-initializer | pattern-initializer ',' pattern-initializer-list
  ///     pattern-initializer → pattern initializer?
  ///     initializer → = expression
  @_spi(RawSyntax)
  public mutating func parseLetOrVarDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawVariableDeclSyntax {
    let (unexpectedBeforeIntroducer, introducer) = self.eat(handle)
    
    var elements = [RawPatternBindingSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      var loopProgress = LoopProgressCondition()
      repeat {

        let (pattern, type) = self.parseTypedPattern()

        // Parse an initializer if present.
        let initializer: RawInitializerClauseSyntax?
        if let equal = self.consume(if: .equal) {
          let value = self.parseExpression()
          initializer = RawInitializerClauseSyntax(
            equal: equal,
            value: value,
            arena: self.arena
          )
        } else {
          initializer = nil
        }

        let accessor: RawSyntax?
        if self.at(.leftBrace) {
          accessor = self.parseGetSet()
        } else {
          accessor = nil
        }

        keepGoing = self.consume(if: .comma)
        elements.append(RawPatternBindingSyntax(
          pattern: pattern,
          typeAnnotation: type,
          initializer: initializer,
          accessor: accessor,
          trailingComma: keepGoing,
          arena: self.arena))
      } while keepGoing != nil && loopProgress.evaluate(currentToken)
    }

    return RawVariableDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeIntroducer,
      letOrVarKeyword: introducer,
      bindings: RawPatternBindingListSyntax(elements: elements, arena: self.arena),
      arena: self.arena)
  }

  enum AccessorKind: SyntaxText, ContextualKeywords, Equatable {
    case `get` = "get"
    case `set` = "set"
    case `didSet` = "didSet"
    case `willSet` = "willSet"
    case unsafeAddress = "unsafeAddress"
    case addressWithOwner = "addressWithOwner"
    case addressWithNativeOwner = "addressWithNativeOwner"
    case unsafeMutableAddress = "unsafeMutableAddress"
    case mutableAddressWithOwner = "mutableAddressWithOwner"
    case mutableAddressWithNativeOwner = "mutableAddressWithNativeOwner"
    case _read = "_read"
    case _modify = "_modify"

    var isCoroutineAccessor: Bool {
      switch self {
      case ._read,
           ._modify:
        return true
      case .`get`,
          .`set`,
          .`didSet`,
          .`willSet`,
          .unsafeAddress,
          .addressWithOwner,
          .addressWithNativeOwner,
          .unsafeMutableAddress,
          .mutableAddressWithOwner,
          .mutableAddressWithNativeOwner:
        return false
      }
    }
  }

  struct AccessorIntroducer {
    var attributes: RawAttributeListSyntax?
    var modifier: RawDeclModifierSyntax?
    var kind: AccessorKind
    var token: RawTokenSyntax
  }

  mutating func parseAccessorIntroducer() -> AccessorIntroducer? {
    // Check there is an identifier before consuming
    var look = self.lookahead()
    let _ = look.consumeAttributeList()
    let hasModifier = look.consume(ifAny: [], contextualKeywords: ["mutating", "nonmutating", "__consuming"]) != nil
    guard let (kind, handle) = look.at(anyIn: AccessorKind.self) else {
      return nil
    }
    
    let attrs = self.parseAttributeList()

    // Parse the contextual keywords for 'mutating' and 'nonmutating' before
    // get and set.
    let modifier: RawDeclModifierSyntax?
    if hasModifier {
      modifier = RawDeclModifierSyntax(
        name: self.consumeAnyToken(),
        detail: nil,
        arena: self.arena
      )
    } else {
      modifier = nil
    }

    let introducer = self.eat(handle)
    return AccessorIntroducer(
      attributes: attrs, modifier: modifier, kind: kind, token: introducer)
  }

  @_spi(RawSyntax)
  public mutating func parseEffectsSpecifier() -> RawTokenSyntax? {
    // 'async'
    if let async = self.consumeIfContextualKeyword("async") {
      return async
    }

    // 'reasync'
    if let reasync = self.consumeIfContextualKeyword("reasync") {
      return reasync
    }

    // 'throws'/'rethrows'
    if let throwsRethrows = self.consume(ifAny: [.throwsKeyword, .rethrowsKeyword]) {
      return throwsRethrows
    }

    // diagnose 'throw'/'try'.
    if let throwTry = self.consume(ifAny: [.throwKeyword, .tryKeyword], where: { !$0.isAtStartOfLine }) {
      return throwTry
    }

    return nil
  }

  @_spi(RawSyntax)
  public mutating func parseEffectsSpecifiers() -> [RawTokenSyntax] {
    var specifiers = [RawTokenSyntax]()
    var loopProgress = LoopProgressCondition()
    while let specifier = self.parseEffectsSpecifier(), loopProgress.evaluate(currentToken) {
      specifiers.append(specifier)
    }
    return specifiers
  }

  /// Parse the body of a variable declaration. This can include explicit
  /// getters, setters, and observers, or the body of a computed property.
  ///
  /// Grammar
  /// =======
  ///
  ///     getter-setter-block → code-block
  ///     getter-setter-block → { getter-clause setter-clause opt }
  ///     getter-setter-block → { setter-clause getter-clause }
  ///     getter-clause → attributes opt mutation-modifier opt get code-block
  ///     setter-clause → attributes opt mutation-modifier opt set setter-name opt code-block
  ///     setter-name → ( identifier )
  ///     getter-setter-keyword-block → { getter-keyword-clause setter-keyword-clause opt }
  ///     getter-setter-keyword-block → { setter-keyword-clause getter-keyword-clause }
  ///     getter-keyword-clause → attributes opt mutation-modifier opt get
  ///     setter-keyword-clause → attributes opt mutation-modifier opt set
  ///     willSet-didSet-block → { willSet-clause didSet-clause opt }
  ///     willSet-didSet-block → { didSet-clause willSet-clause opt }
  ///     willSet-clause → attributes opt willSet setter-name opt code-block
  ///     didSet-clause → attributes opt didSet setter-name opt code-block
  @_spi(RawSyntax)
  public mutating func parseGetSet() -> RawSyntax {
    // Parse getter and setter.
    let (unexpectedBeforeLBrace, lbrace) = self.expect(.leftBrace)
    // Collect all explicit accessors to a list.
    var elements = [RawAccessorDeclSyntax]()
    do {
      var loopProgress = LoopProgressCondition()
      while !self.at(any: [.eof, .rightBrace]) && loopProgress.evaluate(currentToken) {
        guard let introducer = self.parseAccessorIntroducer() else {
          // There can only be an implicit getter if no other accessors were
          // seen before this one.
          guard elements.isEmpty else {
            let (unexpectedBeforeRBrace, rbrace) = self.expect(.rightBrace)
            return RawSyntax(RawAccessorBlockSyntax(
              unexpectedBeforeLBrace,
              leftBrace: lbrace,
              accessors: RawAccessorListSyntax(elements: elements, arena: self.arena),
              unexpectedBeforeRBrace,
              rightBrace: rbrace,
              arena: self.arena))
          }

          var body = [RawCodeBlockItemSyntax]()
          var codeBlockProgress = LoopProgressCondition()
          while !self.at(.rightBrace),
                let newItem = self.parseCodeBlockItem(),
                codeBlockProgress.evaluate(currentToken) {
            body.append(newItem)
          }
          let (unexpectedBeforeRBrace, rbrace) = self.expect(.rightBrace)
          return RawSyntax(RawCodeBlockSyntax(
            unexpectedBeforeLBrace,
            leftBrace: lbrace,
            statements: RawCodeBlockItemListSyntax(elements: body, arena: self.arena),
            unexpectedBeforeRBrace,
            rightBrace: rbrace,
            arena: self.arena))
        }

        // 'set' and 'willSet' can have an optional name.  This isn't valid in a
        // protocol, but we parse and then reject it for better QoI.
        //
        //     set-name    ::= '(' identifier ')'
        let parameter: RawAccessorParameterSyntax?
        if [ AccessorKind.set, .willSet, .didSet ].contains(introducer.kind), let lparen = self.consume(if: .leftParen) {
          let (unexpectedBeforeName, name) = self.expectIdentifier()
          let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
          parameter = RawAccessorParameterSyntax(
            leftParen: lparen,
            unexpectedBeforeName,
            name: name,
            unexpectedBeforeRParen,
            rightParen: rparen,
            arena: self.arena
          )
        } else {
          parameter = nil
        }

        // Next, parse effects specifiers. While it's only valid to have them
        // on 'get' accessors, we also emit diagnostics if they show up on others.
        let asyncKeyword: RawTokenSyntax?
        let throwsKeyword: RawTokenSyntax?
        if self.at(anyIn: EffectsSpecifier.self) != nil {
          asyncKeyword = self.parseEffectsSpecifier()
          throwsKeyword = self.parseEffectsSpecifier()
        } else {
          asyncKeyword = nil
          throwsKeyword = nil
        }

        let context: ItemContext? = introducer.kind.isCoroutineAccessor
                                  ? .coroutineAccessor
                                  : nil
        let body = self.parseOptionalCodeBlock(context: context)

        elements.append(RawAccessorDeclSyntax(
          attributes: introducer.attributes,
          modifier: introducer.modifier,
          accessorKind: introducer.token,
          parameter: parameter,
          asyncKeyword: asyncKeyword,
          throwsKeyword: throwsKeyword,
          body: body,
          arena: self.arena))
      }
    }

    let (unexpectedBeforeRBrace, rbrace) = self.expect(.rightBrace)
    return RawSyntax(RawAccessorBlockSyntax(
      unexpectedBeforeLBrace,
      leftBrace: lbrace,
      accessors: RawAccessorListSyntax(elements: elements, arena: self.arena),
      unexpectedBeforeRBrace,
      rightBrace: rbrace,
      arena: self.arena))
  }
}

extension Parser {
  /// Parse a typealias declaration.
  ///
  /// Grammar
  /// =======
  ///
  ///     typealias-declaration → attributes? access-level-modifier? 'typealias' typealias-name generic-parameter-clause? typealias-assignment
  ///     typealias-name → identifier
  ///     typealias-assignment → '=' type
  @_spi(RawSyntax)
  public mutating func parseTypealiasDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawTypealiasDeclSyntax {
    let (unexpectedBeforeTypealiasKeyword, typealiasKeyword) = self.eat(handle)
    let (unexpectedBeforeName, name) = self.expectIdentifier()

    // Parse a generic parameter list if it is present.
    let generics: RawGenericParameterClauseSyntax?
    if self.currentToken.starts(with: "<") {
      generics = self.parseGenericParameters()
    } else {
      generics = nil
    }

    // Parse the binding alias.
    let (unexpectedBeforeEqual, equal) = self.expect(.equal)
    let value = self.parseType()
    let initializer = RawTypeInitializerClauseSyntax(
      unexpectedBeforeEqual,
      equal: equal,
      value: value,
      arena: self.arena
    )

    // Parse a 'where' clause if present.
    let genericWhereClause: RawGenericWhereClauseSyntax?
    if self.at(.whereKeyword) {
      genericWhereClause = self.parseGenericWhereClause()
    } else {
      genericWhereClause = nil
    }

    return RawTypealiasDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeTypealiasKeyword,
      typealiasKeyword: typealiasKeyword,
      unexpectedBeforeName,
      identifier: name,
      genericParameterClause: generics,
      initializer: initializer,
      genericWhereClause: genericWhereClause,
      arena: self.arena)
  }
}

extension Parser {
  /// Parse an operator declaration.
  ///
  /// Grammar
  /// =======
  ///
  ///     operator-declaration → prefix-operator-declaration | postfix-operator-declaration | infix-operator-declaration
  ///     prefix-operator-declaration → 'prefix' 'operator' operator
  ///     postfix-operator-declaration → 'postfix' 'operator' operator
  ///     infix-operator-declaration → 'infix' 'operator' operator infix-operator-group?
  ///     infix-operator-group → ':' precedence-group-name
  @_spi(RawSyntax)
  public mutating func parseOperatorDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawOperatorDeclSyntax {
    let (unexpectedBeforeOperatorKeyword, operatorKeyword) = self.eat(handle)
    let identifier = self.consumeAnyToken()

    // Parse (or diagnose) a specified precedence group and/or
    // designated protocol. These both look like identifiers, so we
    // parse them both as identifiers here and sort it out in type
    // checking.
    let precedenceAndTypes: RawOperatorPrecedenceAndTypesSyntax?
    if let colon = self.consume(if: .colon) {
      let (unexpectedBeforeIdentifier, identifier) = self.expectIdentifier()
      var types = [RawDesignatedTypeElementSyntax]()
      while let comma = self.consume(if: .comma) {
        // FIXME: The compiler accepts... anything here. This is a bug.
        // let (unexpectedBeforeDesignatedType, designatedType) = self.expectIdentifier()
        let designatedType = self.consumeAnyToken()
        types.append(RawDesignatedTypeElementSyntax(
          leadingComma: comma,
          name: designatedType,
          arena: self.arena))
      }
      precedenceAndTypes = RawOperatorPrecedenceAndTypesSyntax(
        colon: colon,
        unexpectedBeforeIdentifier,
        precedenceGroup: identifier,
        designatedTypes: RawDesignatedTypeListSyntax(
          elements: types, arena: self.arena),
        arena: self.arena)
    } else {
      precedenceAndTypes = nil
    }
    return RawOperatorDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeOperatorKeyword,
      operatorKeyword: operatorKeyword,
      identifier: identifier,
      operatorPrecedenceAndTypes: precedenceAndTypes,
      arena: self.arena)
  }


  /// Parse a precedence group declaration.
  ///
  /// Grammar
  /// =======
  ///
  ///     precedence-group-declaration → precedencegroup precedence-group-name '{' precedence-group-attributes? '}'
  ///
  ///     precedence-group-attributes → precedence-group-attribute precedence-group-attributes?
  ///     precedence-group-attribute → precedence-group-relation
  ///     precedence-group-attribute → precedence-group-assignment
  ///     precedence-group-attribute → precedence-group-associativity
  ///
  ///     precedence-group-relation → 'higherThan' ':' precedence-group-names
  ///     precedence-group-relation → 'lowerThan' ':' precedence-group-names
  ///
  ///     precedence-group-assignment → 'assignment' ':' boolean-literal
  ///
  ///     precedence-group-associativity → 'associativity' ':' 'left'
  ///     precedence-group-associativity → 'associativity' ':' 'right'
  ///     precedence-group-associativity → 'associativity' ':' 'none'
  ///
  ///     precedence-group-names → precedence-group-name | precedence-group-name ',' precedence-group-names
  ///     precedence-group-name → identifier
  @_spi(RawSyntax)
  public mutating func parsePrecedenceGroupDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawPrecedenceGroupDeclSyntax {
    let (unexpectedBeforeGroup, group) = self.eat(handle)
    let (unexpectedBeforeIdentifier, identifier) = self.expectIdentifier()
    let (unexpectedBeforeLBrace, lbrace) = self.expect(.leftBrace)
    var elements = [RawSyntax]()

    enum LabelText: SyntaxText, ContextualKeywords {
      case associativity = "associativity"
      case assignment = "assignment"
      case higherThan = "higherThan"
      case lowerThan = "lowerThan"
    }

    do {
      var attributesProgress = LoopProgressCondition()
      LOOP: while !self.at(any: [.eof, .rightBrace]) && attributesProgress.evaluate(currentToken) {
        switch self.at(anyIn: LabelText.self) {
        case (.associativity, let handle)?:
          let associativity = self.eat(handle)
          let (unexpectedBeforeColon, colon) = self.expect(.colon)
          let (unexpectedBeforeValue, value) = self.expectIdentifier()
          elements.append(RawSyntax(RawPrecedenceGroupAssociativitySyntax(
            associativityKeyword: associativity,
            unexpectedBeforeColon,
            colon: colon,
            unexpectedBeforeValue,
            value: value,
            arena: self.arena
          )))
        case (.assignment, let handle)?:
          let assignmentKeyword = self.eat(handle)
          let (unexpectedBeforeColon, colon) = self.expect(.colon)
          let (unexpectedBeforeFlag, flag) = self.expectAny([.trueKeyword, .falseKeyword], default: .trueKeyword)
          elements.append(RawSyntax(RawPrecedenceGroupAssignmentSyntax(
            assignmentKeyword: assignmentKeyword,
            unexpectedBeforeColon,
            colon: colon,
            unexpectedBeforeFlag,
            flag: flag,
            arena: self.arena
          )))
        case (.higherThan, let handle)?,
          (.lowerThan, let handle)?:
          // "lowerThan" and "higherThan" are contextual keywords.
          let level = self.eat(handle)
          let (unexpectedBeforeColon, colon) = self.expect(.colon)
          var names = [RawPrecedenceGroupNameElementSyntax]()
          do {
            var keepGoing: RawTokenSyntax? = nil
            var namesProgress = LoopProgressCondition()
            repeat {
              let (unexpectedBeforeName, name) = self.expectIdentifier()
              keepGoing = self.consume(if: .comma)
              names.append(RawPrecedenceGroupNameElementSyntax(
                unexpectedBeforeName,
                name: name,
                trailingComma: keepGoing,
                arena: self.arena
              ))
            } while keepGoing != nil && namesProgress.evaluate(currentToken)
          }
          elements.append(RawSyntax(RawPrecedenceGroupRelationSyntax(
            higherThanOrLowerThan: level,
            unexpectedBeforeColon,
            colon: colon,
            otherNames: RawPrecedenceGroupNameListSyntax(elements: names, arena: self.arena),
            arena: self.arena)))
        case nil:
          break LOOP
        }
      }
    }
    let (unexpectedBeforeRBrace, rbrace) = self.expect(.rightBrace)
    return RawPrecedenceGroupDeclSyntax(
      attributes: attrs.attributes, modifiers: attrs.modifiers,
      unexpectedBeforeGroup,
      precedencegroupKeyword: group,
      unexpectedBeforeIdentifier,
      identifier: identifier,
      unexpectedBeforeLBrace,
      leftBrace: lbrace,
      groupAttributes: RawPrecedenceGroupAttributeListSyntax(elements: elements, arena: self.arena),
      unexpectedBeforeRBrace,
      rightBrace: rbrace,
      arena: self.arena)
  }
}

extension Parser {
  enum PoundDiagnosticKind {
    case error(poundError: RawTokenSyntax)
    case warning(poundWarning: RawTokenSyntax)
  }

  @_spi(RawSyntax)
  public mutating func parsePoundDiagnosticDeclaration() -> RawDeclSyntax {
    enum ExpectedTokenKind: RawTokenKindSubset {
      case poundErrorKeyword
      case poundWarningKeyword

      init?(lexeme: Lexer.Lexeme) {
        switch lexeme.tokenKind {
        case .poundErrorKeyword: self = .poundErrorKeyword
        case .poundWarningKeyword: self = .poundWarningKeyword
        default: return nil
        }
      }

      var rawTokenKind: RawTokenKind {
        switch self {
        case .poundErrorKeyword: return .poundErrorKeyword
        case .poundWarningKeyword: return .poundWarningKeyword
        }
      }
    }


    let directive: PoundDiagnosticKind

    switch self.at(anyIn: ExpectedTokenKind.self) {
    case (.poundErrorKeyword, let handle)?:
      directive = .error(poundError: self.eat(handle))
    case (.poundWarningKeyword, let handle)?:
      directive = .warning(poundWarning: self.eat(handle))
    case nil:
      directive = .error(poundError: RawTokenSyntax(missing: .poundErrorKeyword, arena: self.arena))
    }
    
    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
    let stringLiteral: RawStringLiteralExprSyntax
    if self.at(.stringLiteral) {
      stringLiteral = self.parseStringLiteral()
    } else {
      stringLiteral = RawStringLiteralExprSyntax(
        openDelimiter: nil,
        openQuote: RawTokenSyntax(missing: .stringQuote, arena: self.arena),
        segments: RawStringLiteralSegmentsSyntax(elements: [], arena: self.arena),
        closeQuote: RawTokenSyntax(missing: .stringQuote, arena: self.arena),
        closeDelimiter: nil,
        arena: self.arena
      )
    }
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)

    switch directive {
    case .error(let tok):
      return RawDeclSyntax(RawPoundErrorDeclSyntax(
        poundError: tok,
        unexpectedBeforeLeftParen,
        leftParen: leftParen,
        message: stringLiteral,
        unexpectedBeforeRightParen,
        rightParen: rightParen,
        arena: self.arena))
    case .warning(let tok):
      return RawDeclSyntax(RawPoundWarningDeclSyntax(
        poundWarning: tok,
        unexpectedBeforeLeftParen,
        leftParen: leftParen,
        message: stringLiteral,
        unexpectedBeforeRightParen,
        rightParen: rightParen,
        arena: self.arena))
    }
  }
}
