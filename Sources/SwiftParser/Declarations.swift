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
  public mutating func parseDeclaration() -> RawDeclSyntax? {
    if self.at(.poundIfKeyword) {
      return RawDeclSyntax(self.parsePoundIfDirective { parser in
        guard let parsedDecl = parser.parseDeclaration() else {
          return nil
        }
        let semicolon = parser.consume(if: .semicolon)
        return RawMemberDeclListItemSyntax(
          decl: parsedDecl,
          semicolon: semicolon,
          arena: parser.arena)
      }
      syntax: { parser, elements in
        return RawSyntax(RawMemberDeclListSyntax(elements: elements, arena: parser.arena))
      })
    } else if self.at(.poundWarningKeyword) || self.at(.poundErrorKeyword) {
      return self.parsePoundDiagnosticDeclaration()
    }

    let attrs = DeclAttributes(
      attributes: self.parseAttributeList(),
      modifiers: self.parseModifierList())
    switch self.currentToken.tokenKind {
    case .importKeyword:
      return RawDeclSyntax(self.parseImportDeclaration(attrs))
    case .classKeyword:
      return RawDeclSyntax(self.parseClassDeclaration(attrs))
    case .enumKeyword:
      return RawDeclSyntax(self.parseEnumDeclaration(attrs))
    case .caseKeyword:
      return RawDeclSyntax(self.parseDeclEnumCase(attrs))
    case .structKeyword:
      return RawDeclSyntax(self.parseStructDeclaration(attrs))
    case .protocolKeyword:
      return RawDeclSyntax(self.parseProtocolDeclaration(attrs))
    case .associatedtypeKeyword:
      return RawDeclSyntax(self.parseAssociatedTypeDeclaration(attrs))
    case .typealiasKeyword:
      return RawDeclSyntax(self.parseTypealiasDeclaration(attrs))
    case .extensionKeyword:
      return RawDeclSyntax(self.parseExtensionDeclaration(attrs))
    case .funcKeyword:
      return RawDeclSyntax(self.parseFuncDeclaration(attrs))
    case .subscriptKeyword:
      return RawDeclSyntax(self.parseSubscriptDeclaration(attrs))
    case .letKeyword, .varKeyword:
      return RawDeclSyntax(self.parseLetOrVarDeclaration(attrs))
    case .initKeyword:
      return RawDeclSyntax(self.parseInitializerDeclaration(attrs))
    case .deinitKeyword:
      return RawDeclSyntax(self.parseDeinitializerDeclaration(attrs))
    case .operatorKeyword:
      return RawDeclSyntax(self.parseOperatorDeclaration(attrs))
    case .precedencegroupKeyword:
      return RawDeclSyntax(self.parsePrecedenceGroupDeclaration(attrs))
    case _ where self.currentToken.isContextualKeyword("actor"):
      return RawDeclSyntax(self.parseActorDeclaration(attrs))
    default:
      if attrs.attributes == nil && attrs.modifiers == nil {
        return nil
      } else {
        return RawDeclSyntax(RawMissingDeclSyntax(
          attributes: attrs.attributes,
          modifiers: attrs.modifiers,
          arena: self.arena))
      }
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
  public mutating func parseImportDeclaration(_ attrs: DeclAttributes) -> RawImportDeclSyntax {
    let importKeyword = self.eat(.importKeyword)
    let kind = self.parseImportKind()
    let path = self.parseImportAccessPath()
    return RawImportDeclSyntax(
      attributes: attrs.attributes, modifiers: attrs.modifiers,
      importTok: importKeyword,
      importKind: kind,
      path: path,
      arena: self.arena)
  }

  @_spi(RawSyntax)
  public mutating func parseImportKind() -> RawTokenSyntax? {
    guard self.currentToken.tokenKind.isKeyword else {
      return nil
    }

    switch self.currentToken.tokenKind {
    case .typealiasKeyword,
        .structKeyword,
        .classKeyword,
        .enumKeyword,
        .protocolKeyword,
        .varKeyword,
        .letKeyword,
        .funcKeyword:
      return self.consumeAnyToken()
    default:
      return nil
    }
  }

  @_spi(RawSyntax)
  public mutating func parseImportAccessPath() -> RawAccessPathSyntax {
    var elements = [RawAccessPathComponentSyntax]()
    var keepGoing: RawTokenSyntax? = nil
    repeat {
      let name = self.parseAnyIdentifier()
      keepGoing = self.consume(if: .period)
      elements.append(RawAccessPathComponentSyntax(
        name: name, trailingDot: keepGoing, arena: self.arena))
    } while keepGoing != nil
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
  public mutating func parseExtensionDeclaration(_ attrs: DeclAttributes) -> RawExtensionDeclSyntax {
    let extensionKeyword = self.eat(.extensionKeyword)
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
      attributes: attrs.attributes, modifiers: attrs.modifiers,
      extensionKeyword: extensionKeyword,
      extendedType: type.orMissing(arena: self.arena),
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

    let langle = self.consume(remapping: .leftAngle)
    var elements = [RawGenericParameterSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      repeat {
        let attributes = self.parseAttributeList()

        let name = self.consumeIdentifier()
        if name.isMissing && elements.isEmpty {
          break
        }

        // Parse the ':' followed by a type.
        let colon = self.consume(if: .colon)
        let inherited: RawTypeSyntax?
        if colon != nil {
          switch self.currentToken.tokenKind {
          case .identifier, .protocolKeyword, .anyKeyword:
            inherited = self.parseType()
          default:
            inherited = nil
          }
        } else {
          inherited = nil
        }
        keepGoing = self.consume(if: .comma)
        elements.append(RawGenericParameterSyntax(
          attributes: attributes,
          name: name,
          colon: colon,
          inheritedType: inherited,
          trailingComma: keepGoing,
          arena: self.arena))
      } while keepGoing != nil
    }

    let rangle: RawTokenSyntax
    if self.currentToken.starts(with: ">") {
      rangle = self.consume(remapping: .rightAngle)
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
      rightAngleBracket: rangle,
      arena: self.arena)
  }

  enum LayoutConstraint: SyntaxText {
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
    let whereKeyword = self.eat(.whereKeyword)

    var elements = [RawGenericRequirementSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      repeat {
        guard let firstType = self.parseType() else {
          keepGoing = self.consume(if: .comma)
          elements.append(RawGenericRequirementSyntax(
            body: RawSyntax(RawMissingSyntax(arena: self.arena)),
            trailingComma: keepGoing,
            arena: self.arena
          ))
          continue
        }

        let requirement: RawSyntax?
        if self.at(.colon) {
          // A conformance-requirement.
          let colon = self.eat(.colon)
          if self.currentToken.isIdentifier, let layoutConstraint = LayoutConstraint(rawValue: self.currentToken.tokenText) {
            // Parse a layout constraint.
            let constraint = self.consumeIdentifier()

            let unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax?
            let leftParen: RawTokenSyntax?
            let size: RawTokenSyntax?
            let comma: RawTokenSyntax?
            let alignment: RawTokenSyntax?
            let unexpectedBeforeRightParen: RawUnexpectedNodesSyntax?
            let rightParen: RawTokenSyntax?
            // Unlike the other layout constraints, _Trivial's argument list
            // is optional.
            if layoutConstraint.hasArguments && !(layoutConstraint == .trivialLayout && !self.at(.leftParen)) {
              (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
              size = self.consumeInteger()
              comma = self.consume(if: .comma)
              if comma != nil {
                alignment = self.consumeInteger()
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
              colon: colon, layoutConstraint: constraint,
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
              rightTypeIdentifier: secondType.orMissing(arena: self.arena),
              arena: self.arena))
          }
        } else if (self.currentToken.isAnyOperator && self.currentToken.tokenText == "==") || self.at(.equal) {
          let equal = self.consumeAnyToken()
          let secondType = self.parseType()
          requirement = RawSyntax(RawSameTypeRequirementSyntax(
            leftTypeIdentifier: firstType,
            equalityToken: equal,
            rightTypeIdentifier: secondType.orMissing(arena: self.arena),
            arena: self.arena))
        } else {
          requirement = nil
        }

        keepGoing = self.consume(if: .comma)
        if requirement != nil || keepGoing != nil {
          elements.append(RawGenericRequirementSyntax(
            body: requirement ?? RawSyntax(RawSameTypeRequirementSyntax(
              leftTypeIdentifier: RawTypeSyntax(RawMissingTypeSyntax(arena: self.arena)),
              equalityToken: RawTokenSyntax(missing: .equal, arena: self.arena),
              rightTypeIdentifier: RawTypeSyntax(RawMissingTypeSyntax(arena: self.arena)),
              arena: self.arena
            )),
            trailingComma: keepGoing,
            arena: self.arena
          ))
        }
      } while keepGoing != nil
    }

    return RawGenericWhereClauseSyntax(
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
      while !self.at(.eof) && !self.at(.rightBrace) {
        guard let decl = self.parseDeclaration() else {
          break
        }
        let semi = self.consume(if: .semicolon)
        elements.append(RawMemberDeclListItemSyntax(
          decl: decl, semicolon: semi, arena: self.arena))
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
  public mutating func parseClassDeclaration(_ attrs: DeclAttributes) -> RawClassDeclSyntax {
    let classKeyword = self.eat(.classKeyword)
    let name = self.consumeIdentifier()
    if name.isMissing {
      return RawClassDeclSyntax(
        attributes: attrs.attributes,
        modifiers: attrs.modifiers,
        classKeyword: classKeyword,
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
      classKeyword: classKeyword,
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
    let colon = self.eat(.colon)
    var elements = [RawInheritedTypeSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      repeat {
        let type: RawTypeSyntax?
        if self.at(.classKeyword) {
          let classKeyword = self.eat(.classKeyword)
          type = RawTypeSyntax(RawClassRestrictionTypeSyntax(
            classKeyword: classKeyword,
            arena: self.arena))
        } else {
          type = self.parseType()
        }

        keepGoing = self.consume(if: .comma)

        if type != nil || keepGoing != nil {
          elements.append(RawInheritedTypeSyntax(
            typeName: type.orMissing(arena: self.arena),
            trailingComma: keepGoing,
            arena: self.arena
          ))
        }
      } while keepGoing != nil
    }
    return RawTypeInheritanceClauseSyntax(
      colon: colon,
      inheritedTypeCollection: RawInheritedTypeListSyntax(elements: elements, arena: self.arena),
      arena: self.arena)
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
  public mutating func parseEnumDeclaration(_ attrs: DeclAttributes) -> RawEnumDeclSyntax {
    let enumKeyword = self.eat(.enumKeyword)
    let name = self.consumeIdentifier()
    if name.isMissing {
      return RawEnumDeclSyntax(
        attributes: attrs.attributes,
        modifiers: attrs.modifiers,
        enumKeyword: enumKeyword,
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
      enumKeyword: enumKeyword,
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
  public mutating func parseDeclEnumCase(_ attrs: DeclAttributes) -> RawEnumCaseDeclSyntax {
    let caseKeyword = self.eat(.caseKeyword)
    var elements = [RawEnumCaseElementSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      repeat {
        let name = self.consumeIdentifier()

        let associatedValue: RawParameterClauseSyntax?
        if self.at(.leftParen) && !self.currentToken.isAtStartOfLine {
          associatedValue = self.parseParameterClause()
        } else {
          associatedValue = nil
        }

        // See if there's a raw value expression.
        let rawValue: RawInitializerClauseSyntax?
        if self.at(.equal) {
          let eq = self.eat(.equal)
          let value = self.parseExpression()
          rawValue = RawInitializerClauseSyntax(
            equal: eq,
            value: value.orMissing(arena: self.arena),
            arena: self.arena
          )
        } else {
          rawValue = nil
        }

        // Continue through the comma-separated list.
        keepGoing = self.consume(if: .comma)
        elements.append(RawEnumCaseElementSyntax(
          identifier: name,
          associatedValue: associatedValue,
          rawValue: rawValue,
          trailingComma: keepGoing,
          arena: self.arena))
      } while keepGoing != nil
    }

    return RawEnumCaseDeclSyntax(
      attributes: attrs.attributes, modifiers: attrs.modifiers,
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
  public mutating func parseStructDeclaration(_ attrs: DeclAttributes) -> RawStructDeclSyntax {
    let structKeyword = self.eat(.structKeyword)
    let name = self.consumeIdentifier()
    if name.isMissing {
      return RawStructDeclSyntax(
        attributes: attrs.attributes,
        modifiers: attrs.modifiers,
        structKeyword: structKeyword,
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
      structKeyword: structKeyword,
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
    let langle = self.consume(remapping: .leftAngle)
    var associatedTypes = [RawPrimaryAssociatedTypeSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      repeat {
        // Parse the name of the parameter.
        let name = self.consumeIdentifier()
        keepGoing = self.consume(if: .comma)
        associatedTypes.append(RawPrimaryAssociatedTypeSyntax(
          name: name,
          trailingComma: keepGoing,
          arena: self.arena))
      } while keepGoing != nil
    }
    let rangle = self.consume(remapping: .rightAngle)
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
  public mutating func parseProtocolDeclaration(_ attrs: DeclAttributes) -> RawProtocolDeclSyntax {
    let protocolKeyword = self.eat(.protocolKeyword)
    let name = self.consumeIdentifier()
    if name.isMissing {
      return RawProtocolDeclSyntax(
        attributes: attrs.attributes,
        modifiers: attrs.modifiers,
        protocolKeyword: protocolKeyword,
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
      protocolKeyword: protocolKeyword,
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
  public mutating func parseAssociatedTypeDeclaration(_ attrs: DeclAttributes) -> RawAssociatedtypeDeclSyntax {
    let assocKeyword = self.eat(.associatedtypeKeyword)
    let name = self.consumeIdentifier()
    if name.isMissing {
      return RawAssociatedtypeDeclSyntax(
        attributes: attrs.attributes, modifiers: attrs.modifiers,
        associatedtypeKeyword: assocKeyword,
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
    if self.at(.equal) {
      let equal = self.eat(.equal)
      let type = self.parseType()
      defaultType = RawTypeInitializerClauseSyntax(
        equal: equal,
        value: type.orMissing(arena: self.arena),
        arena: self.arena)
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
      associatedtypeKeyword: assocKeyword,
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
  public mutating func parseActorDeclaration(_ attrs: DeclAttributes) -> RawActorDeclSyntax {
    assert(self.currentToken.isContextualKeyword("actor"))
    let actorKeyword = self.consumeIdentifier()
    let name = self.consumeIdentifier()

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
      actorKeyword: actorKeyword,
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
  public mutating func parseInitializerDeclaration(_ attrs: DeclAttributes) -> RawInitializerDeclSyntax {
    assert(self.at(.initKeyword))
    let initKeyword = self.eat(.initKeyword)

    // Parse the '!' or '?' for a failable initializer.
    let failable: RawTokenSyntax?
    if self.at(.exclamationMark)
        || (self.currentToken.isAnyOperator && self.currentToken.tokenText == "!")
        || self.at(.postfixQuestionMark) {
      failable = self.consumeAnyToken()
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
      attributes: attrs.attributes, modifiers: attrs.modifiers,
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
  public mutating func parseDeinitializerDeclaration(_ attrs: DeclAttributes) -> RawDeinitializerDeclSyntax {
    let deinitKeyword = self.eat(.deinitKeyword)
    let items = self.parseCodeBlock()
    return RawDeinitializerDeclSyntax(
      attributes: attrs.attributes, modifiers: attrs.modifiers,
      deinitKeyword: deinitKeyword, body: items,
      arena: self.arena)
  }
}

extension Parser {
  @_spi(RawSyntax)
  public mutating func parseParameterClause(isClosure: Bool = false) -> RawParameterClauseSyntax {
    let (unexpectedBeforeLParen, lparen) = self.expect(.leftParen)
    var elements = [RawFunctionParameterSyntax]()
    // If we are missing the left parenthesis and the next token doesn't appear to be an argument label, don't parse any parameters.
    let shouldSkipParameterParsing = lparen.isMissing && (!currentToken.canBeArgumentLabel || currentToken.isKeyword)
    if !shouldSkipParameterParsing {
      var keepGoing = true
      while !self.at(.eof) && !self.at(.rightParen) && keepGoing {
        // Attributes.
        let attrs = self.parseAttributeList()

        let firstName: RawTokenSyntax?
        let secondName: RawTokenSyntax?
        let unexpectedBeforeColon: RawUnexpectedNodesSyntax?
        let colon: RawTokenSyntax?
        let shouldParseType: Bool

        if self.lookahead().startsParameterName(isClosure) {
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
          if isClosure {
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
        if self.currentToken.isEllipsis {
          ellipsis = self.consume(remapping: .ellipsis)
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
    let arrow = self.eat(.arrow)
    var misplacedThrowsKeyword: RawTokenSyntax? = nil
    let unexpectedBeforeReturnType: RawUnexpectedNodesSyntax?
    if let throwsKeyword = self.consume(ifAny: .rethrowsKeyword, .throwsKeyword) {
      misplacedThrowsKeyword = throwsKeyword
      unexpectedBeforeReturnType = RawUnexpectedNodesSyntax(elements: [RawSyntax(throwsKeyword)], arena: self.arena)
    } else {
      unexpectedBeforeReturnType = nil
    }
    let result = self.parseType()
    let returnClause = RawReturnClauseSyntax(
      arrow: arrow,
      unexpectedBeforeReturnType,
      returnType: result.orMissing(arena: self.arena),
      arena: self.arena)
    return (returnClause, misplacedThrowsKeyword)
  }
}

extension Parser {
  @_spi(RawSyntax)
  public mutating func parseFuncDeclaration(_ attrs: DeclAttributes) -> RawFunctionDeclSyntax {
    let funcKeyword = self.eat(.funcKeyword)
    let identifier: RawTokenSyntax
    if self.currentToken.isAnyOperator || self.at(.exclamationMark) || self.at(.prefixAmpersand) {
      var name = self.currentToken.tokenText
      if name.count > 1 && name.hasSuffix("<") && self.peek().isIdentifier {
        name = SyntaxText(rebasing: name.dropLast())
      }
      identifier = self.consumePrefix(name, as: .spacedBinaryOperator)
    } else {
      identifier = self.consumeIdentifier()
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
      attributes: attrs.attributes, modifiers: attrs.modifiers,
      funcKeyword: funcKeyword,
      identifier: identifier,
      genericParameterClause: genericParams,
      signature: signature,
      genericWhereClause: generics,
      body: body,
      arena: self.arena)
  }

  @_spi(RawSyntax)
  public mutating func parseFunctionSignature() -> RawFunctionSignatureSyntax {
    let input = self.parseParameterClause()

    let async: RawTokenSyntax?
    if self.currentToken.isContextualKeyword("async") {
      async = self.consume(remapping: .contextualKeyword)
    } else {
      async = nil
    }

    var throwsKeyword: RawTokenSyntax?
    if self.at(.throwsKeyword) || self.at(.rethrowsKeyword) {
      throwsKeyword = self.consumeAnyToken()
    } else {
      throwsKeyword = nil
    }

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
  public mutating func parseSubscriptDeclaration(_ attrs: DeclAttributes) -> RawSubscriptDeclSyntax {
    let subscriptKeyword = self.eat(.subscriptKeyword)
    let genericParameterClause: RawGenericParameterClauseSyntax?
    if self.currentToken.starts(with: "<") {
      genericParameterClause = self.parseGenericParameters()
    } else {
      genericParameterClause = nil
    }

    let indices = self.parseParameterClause()

    let result: RawReturnClauseSyntax?
    if self.at(.arrow) {
      result = self.parseFunctionReturnClause().returnClause
    } else {
      result = nil
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
      attributes: attrs.attributes, modifiers: attrs.modifiers,
      subscriptKeyword: subscriptKeyword,
      genericParameterClause: genericParameterClause,
      indices: indices,
      result: result ?? RawReturnClauseSyntax(
        arrow: RawTokenSyntax(missing: .arrow, arena: self.arena),
        returnType: RawTypeSyntax(RawMissingTypeSyntax(arena: self.arena)),
        arena: self.arena
      ),
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
  public mutating func parseLetOrVarDeclaration(_ attrs: DeclAttributes) -> RawVariableDeclSyntax {
    let introducer: RawTokenSyntax
    if self.at(.letKeyword) {
      introducer = self.eat(.letKeyword)
    } else {
      assert(self.at(.varKeyword))
      introducer = self.eat(.varKeyword)
    }

    var elements = [RawPatternBindingSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      repeat {

        let (pattern, type) = self.parseTypedPattern()

        // Parse an initializer if present.
        let initializer: RawInitializerClauseSyntax?
        if self.at(.equal) {
          let equal = self.eat(.equal)
          let value = self.parseExpression()
          initializer = RawInitializerClauseSyntax(
            equal: equal,
            value: value.orMissing(arena: self.arena),
            arena: self.arena)
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
      } while keepGoing != nil
    }

    return RawVariableDeclSyntax(
      attributes: attrs.attributes, modifiers: attrs.modifiers,
      letOrVarKeyword: introducer,
      bindings: RawPatternBindingListSyntax(elements: elements, arena: self.arena),
      arena: self.arena)
  }

  enum AccessorKind: SyntaxText, Equatable {
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
  }

  struct AccessorIntroducer {
    var attributes: RawAttributeListSyntax?
    var modifier: RawDeclModifierSyntax?
    var introducer: (AccessorKind, RawTokenSyntax)?
  }

  mutating func parseAccessorIntroducer() -> AccessorIntroducer {
    let attrs = self.parseAttributeList()

    // Parse the contextual keywords for 'mutating' and 'nonmutating' before
    // get and set.
    let modifier: RawDeclModifierSyntax?
    if self.currentToken.isContextualKeyword("mutating") ||
        self.currentToken.isContextualKeyword("nonmutating") ||
        self.currentToken.isContextualKeyword("__consuming") {
      modifier = RawDeclModifierSyntax(
        name: self.consumeAnyToken(), detail: nil,
        arena: self.arena)
    } else {
      modifier = nil
    }

    guard
      self.currentToken.isIdentifier,
      let kind = AccessorKind(rawValue: self.currentToken.tokenText)
    else {
      return AccessorIntroducer(
        attributes: attrs, modifier: modifier, introducer: nil)
    }

    let introducer = self.consume(remapping: .contextualKeyword)
    return AccessorIntroducer(
      attributes: attrs, modifier: modifier, introducer: (kind, introducer))
  }

  @_spi(RawSyntax)
  public mutating func parseEffectsSpecifier() -> RawTokenSyntax? {
    // 'async'
    if self.currentToken.isContextualKeyword("async") {
      return self.consume(remapping: .contextualKeyword)
    }

    // 'reasync'
    if self.currentToken.isContextualKeyword("reasync") {
      return self.consume(remapping: .contextualKeyword)
    }

    // 'throws'/'rethrows'
    if self.at(.throwsKeyword) || self.at(.rethrowsKeyword) {
      return self.consumeAnyToken()
    }

    // diagnose 'throw'/'try'.
    if (self.at(.throwKeyword) || self.at(.tryKeyword))
        && !self.currentToken.isAtStartOfLine {
      return self.consumeAnyToken()
    }

    return nil
  }

  @_spi(RawSyntax)
  public mutating func parseEffectsSpecifiers() -> [RawTokenSyntax] {
    var specifiers = [RawTokenSyntax]()
    while let specifier = self.parseEffectsSpecifier() {
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
    let lbrace = self.eat(.leftBrace)
    // Collect all explicit accessors to a list.
    var elements = [RawAccessorDeclSyntax]()
    do {
      while !self.at(.eof) && !self.at(.rightBrace) {
        let introducer = self.parseAccessorIntroducer()
        guard let (kind, kindToken) = introducer.introducer else {
          // There can only be an implicit getter if no other accessors were
          // seen before this one.
          guard elements.isEmpty else {
            let (unexpectedBeforeRBrace, rbrace) = self.expect(.rightBrace)
            return RawSyntax(RawAccessorBlockSyntax(
              leftBrace: lbrace,
              accessors: RawAccessorListSyntax(elements: elements, arena: self.arena),
              unexpectedBeforeRBrace,
              rightBrace: rbrace,
              arena: self.arena))
          }

          var body = [RawCodeBlockItemSyntax]()
          while !self.at(.eof) && !self.at(.rightBrace) {
            if let newItem = self.parseCodeBlockItem() {
              body.append(newItem)
            } else {
              break
            }
          }
          let (unexpectedBeforeRBrace, rbrace) = self.expect(.rightBrace)
          return RawSyntax(RawCodeBlockSyntax(
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
        if self.at(.leftParen) && [ AccessorKind.set, .willSet, .didSet ].firstIndex(of: kind) != nil {
          let lparen = self.eat(.leftParen)
          let name = self.consumeIdentifier()
          let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
          parameter = RawAccessorParameterSyntax(
            leftParen: lparen,
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
        if self.currentToken.isEffectsSpecifier {
          asyncKeyword = self.parseEffectsSpecifier()
          throwsKeyword = self.parseEffectsSpecifier()
        } else {
          asyncKeyword = nil
          throwsKeyword = nil
        }

        let body = self.parseOptionalCodeBlock()

        elements.append(RawAccessorDeclSyntax(
          attributes: introducer.attributes,
          modifier: introducer.modifier,
          accessorKind: kindToken,
          parameter: parameter,
          asyncKeyword: asyncKeyword,
          throwsKeyword: throwsKeyword,
          body: body,
          arena: self.arena))
      }
    }

    let (unexpectedBeforeRBrace, rbrace) = self.expect(.rightBrace)
    return RawSyntax(RawAccessorBlockSyntax(
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
  public mutating func parseTypealiasDeclaration(_ attrs: DeclAttributes) -> RawTypealiasDeclSyntax {
    let typealiasKeyword = self.eat(.typealiasKeyword)
    let name = self.consumeIdentifier()

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
      value: value.orMissing(arena: self.arena),
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
      attributes: attrs.attributes, modifiers: attrs.modifiers,
      typealiasKeyword: typealiasKeyword,
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
  public mutating func parseOperatorDeclaration(_ attrs: DeclAttributes) -> RawOperatorDeclSyntax {
    let operatorKeyword = self.eat(.operatorKeyword)
    let identifier = self.consumeAnyToken()

    // Parse (or diagnose) a specified precedence group and/or
    // designated protocol. These both look like identifiers, so we
    // parse them both as identifiers here and sort it out in type
    // checking.
    let precedenceAndTypes: RawOperatorPrecedenceAndTypesSyntax?
    if self.at(.colon) {
      let colon = self.eat(.colon)
      let identifier = self.consumeIdentifier()
      precedenceAndTypes = RawOperatorPrecedenceAndTypesSyntax(
        colon: colon,
        precedenceGroupAndDesignatedTypes: RawIdentifierListSyntax(elements: [ identifier ], arena: self.arena),
        arena: self.arena)
    } else {
      precedenceAndTypes = nil
    }
    return RawOperatorDeclSyntax(
      attributes: attrs.attributes, modifiers: attrs.modifiers,
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
  public mutating func parsePrecedenceGroupDeclaration(_ attrs: DeclAttributes) -> RawPrecedenceGroupDeclSyntax {
    let group = self.eat(.precedencegroupKeyword)
    let identifier = self.consumeIdentifier()
    let (unexpectedBeforeLBrace, lbrace) = self.expect(.leftBrace)
    var elements = [RawSyntax]()
    do {
      LOOP: while !self.at(.eof) && !self.at(.rightBrace) {
        switch self.currentToken.tokenText {
        case "associativity":
          let associativity = self.consumeIdentifier()
          let (unexpectedBeforeColon, colon) = self.expect(.colon)
          let value = self.consumeIdentifier()
          elements.append(RawSyntax(RawPrecedenceGroupAssociativitySyntax(
            associativityKeyword: associativity,
            unexpectedBeforeColon,
            colon: colon,
            value: value,
            arena: self.arena
          )))
        case "assignment":
          let assignmentKeyword = self.consumeIdentifier()
          let (unexpectedBeforeColon, colon) = self.expect(.colon)
          let flag: RawTokenSyntax
          if self.at(.trueKeyword) {
            flag = self.eat(.trueKeyword)
          } else if self.at(.falseKeyword) {
            flag = self.eat(.falseKeyword)
          } else {
            flag = RawTokenSyntax(missing: .trueKeyword, arena: self.arena)
          }
          elements.append(RawSyntax(RawPrecedenceGroupAssignmentSyntax(
            assignmentKeyword: assignmentKeyword,
            unexpectedBeforeColon,
            colon: colon,
            flag: flag,
            arena: self.arena
          )))
        case "higherThan", "lowerThan":
          // "lowerThan" and "higherThan" are contextual keywords.
          let level = self.consume(remapping: .contextualKeyword)
          let (unexpectedBeforeColon, colon) = self.expect(.colon)
          var names = [RawPrecedenceGroupNameElementSyntax]()
          do {
            var keepGoing: RawTokenSyntax? = nil
            repeat {
              let name = self.consumeIdentifier()
              keepGoing = self.consume(if: .comma)
              names.append(RawPrecedenceGroupNameElementSyntax(
                name: name, trailingComma: keepGoing,
                arena: self.arena))
            } while keepGoing != nil
          }
          elements.append(RawSyntax(RawPrecedenceGroupRelationSyntax(
            higherThanOrLowerThan: level,
            unexpectedBeforeColon,
            colon: colon,
            otherNames: RawPrecedenceGroupNameListSyntax(elements: names, arena: self.arena),
            arena: self.arena)))
        default:
          break LOOP
        }
      }
    }
    let (unexpectedBeforeRBrace, rbrace) = self.expect(.rightBrace)
    return RawPrecedenceGroupDeclSyntax(
      attributes: attrs.attributes, modifiers: attrs.modifiers,
      precedencegroupKeyword: group,
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
    case error(RawTokenSyntax)
    case warning(RawTokenSyntax)
  }

  @_spi(RawSyntax)
  public mutating func parsePoundDiagnosticDeclaration() -> RawDeclSyntax {
    assert(self.at(.poundErrorKeyword) || self.at(.poundWarningKeyword))

    let directive: PoundDiagnosticKind
    if self.at(.poundErrorKeyword) {
      directive = .error(self.eat(.poundErrorKeyword))
    } else {
      directive = .error(self.eat(.poundWarningKeyword))
    }

    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
    let stringLiteral: RawStringLiteralExprSyntax
    if self.currentToken.tokenKind == .stringLiteral {
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
