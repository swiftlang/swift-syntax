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

extension DeclarationModifier {
  var canHaveParenthesizedArgument: Bool {
    switch self {
    case .__consuming, .__setter_access, ._const, ._local, .async,
      .borrowing, .class, .consuming, .convenience, .distributed, .dynamic,
      .final, .indirect, .infix, .isolated, .lazy, .mutating, .nonmutating,
      .optional, .override, .postfix, .prefix, .reasync, ._resultDependsOn, ._resultDependsOnSelf, .required,
      .rethrows, .static, .weak, .transferring:
      return false
    case .fileprivate, .internal, .nonisolated, .package, .open, .private,
      .public, .unowned:
      return true
    }
  }
}

extension TokenConsumer {
  mutating func atStartOfFreestandingMacroExpansion() -> Bool {
    // Check if "'#' <identifier>" where the identifier is on the sameline.
    if !self.at(.pound) {
      return false
    }
    if self.peek().isAtStartOfLine {
      return false
    }
    switch self.peek().rawTokenKind {
    case .identifier:
      return true
    case .keyword:
      // allow keywords right after '#' so we can diagnose it when parsing.
      return (self.currentToken.trailingTriviaByteLength == 0 && self.peek().leadingTriviaByteLength == 0)
    default:
      return false
    }
  }

  mutating func atStartOfDeclaration(
    isAtTopLevel: Bool = false,
    allowInitDecl: Bool = true,
    allowRecovery: Bool = false
  ) -> Bool {
    if self.at(.poundIf) {
      return true
    }

    var subparser = self.lookahead()

    var hasAttribute = false
    var attributeProgress = LoopProgressCondition()
    while subparser.hasProgressed(&attributeProgress) && subparser.at(.atSign) {
      hasAttribute = true
      _ = subparser.consumeAttributeList()
    }

    var hasModifier = false
    if subparser.currentToken.isLexerClassifiedKeyword || subparser.currentToken.rawTokenKind == .identifier {
      var modifierProgress = LoopProgressCondition()
      while let (modifierKind, handle) = subparser.at(anyIn: DeclarationModifier.self),
        modifierKind != .class,
        subparser.hasProgressed(&modifierProgress)
      {
        hasModifier = true
        subparser.eat(handle)
        if modifierKind != .open && subparser.at(.leftParen) && modifierKind.canHaveParenthesizedArgument {
          // When determining whether we are at a declaration, don't consume anything in parentheses after 'open'
          // so we don't consider a function call to open as a decl modifier. This matches the C++ parser.
          subparser.consumeAnyToken()
          subparser.consume(to: .rightParen)
        }
      }
    }

    if hasAttribute {
      if subparser.at(.rightBrace) || subparser.at(.endOfFile) || subparser.at(.poundEndif) {
        return true
      }
    }

    if subparser.at(.poundIf) {
      var attrLookahead = subparser.lookahead()
      return attrLookahead.consumeIfConfigOfAttributes()
    }

    let declStartKeyword: DeclarationKeyword?
    if allowRecovery {
      declStartKeyword =
        subparser.canRecoverTo(
          anyIn: DeclarationKeyword.self,
          overrideRecoveryPrecedence: isAtTopLevel ? nil : .closingBrace
        )?.0
    } else {
      declStartKeyword = subparser.at(anyIn: DeclarationKeyword.self)?.0
    }
    switch declStartKeyword {
    case .lhs(.actor):
      // actor Foo {}
      if subparser.peek().rawTokenKind == .identifier {
        return true
      }
      // actor may be somewhere in the modifier list. Eat the tokens until we get
      // to something that isn't the start of a decl. If that is an identifier,
      // it's an actor declaration, otherwise, it isn't.
      var lookahead = subparser.lookahead()
      repeat {
        lookahead.consumeAnyToken()
      } while lookahead.atStartOfDeclaration(isAtTopLevel: isAtTopLevel, allowInitDecl: allowInitDecl)
      return lookahead.at(.identifier)
    case .lhs(.case):
      // When 'case' appears inside a function, it's probably a switch
      // case, not an enum case declaration.
      return false
    case .lhs(.`init`):
      return allowInitDecl
    case .lhs(.macro):
      // macro Foo ...
      return subparser.peek().rawTokenKind == .identifier
    case .lhs(.pound):
      // Force parsing '#<identifier>' after attributes as a macro expansion decl.
      if hasAttribute || hasModifier {
        return true
      }

      // Otherwise, parse it as an expression.
      return false
    case .some(_):
      // All other decl start keywords unconditionally start a decl.
      return true
    case nil:
      if subparser.at(anyIn: ContextualDeclKeyword.self)?.0 != nil {
        subparser.consumeAnyToken()
        return subparser.atStartOfDeclaration(
          isAtTopLevel: isAtTopLevel,
          allowInitDecl: allowInitDecl,
          allowRecovery: allowRecovery
        )
      }
      return false
    }
  }
}

extension Parser {
  struct DeclAttributes {
    var attributes: RawAttributeListSyntax
    var modifiers: RawDeclModifierListSyntax

    init(attributes: RawAttributeListSyntax, modifiers: RawDeclModifierListSyntax) {
      self.attributes = attributes
      self.modifiers = modifiers
    }
  }

  /// Parse a declaration.
  ///
  /// If `inMemberDeclList` is `true`, we know that the next item must be a
  /// declaration and thus start with a keyword. This allows further recovery.
  mutating func parseDeclaration(inMemberDeclList: Bool = false) -> RawDeclSyntax {
    // If we are at a `#if` of attributes, the `#if` directive should be
    // parsed when we're parsing the attributes.
    if self.at(.poundIf) && !self.withLookahead({ $0.consumeIfConfigOfAttributes() }) {
      let directive = self.parsePoundIfDirective { (parser, _) in
        let parsedDecl = parser.parseDeclaration()
        let semicolon = parser.consume(if: .semicolon)
        return RawMemberBlockItemSyntax(
          decl: parsedDecl,
          semicolon: semicolon,
          arena: parser.arena
        )
      } addSemicolonIfNeeded: { lastElement, newItemAtStartOfLine, parser in
        if lastElement.semicolon == nil && !newItemAtStartOfLine {
          return RawMemberBlockItemSyntax(
            lastElement.unexpectedBeforeDecl,
            decl: lastElement.decl,
            lastElement.unexpectedBetweenDeclAndSemicolon,
            semicolon: parser.missingToken(.semicolon),
            lastElement.unexpectedAfterSemicolon,
            arena: parser.arena
          )
        } else {
          return nil
        }
      } syntax: { parser, elements in
        return .decls(RawMemberBlockItemListSyntax(elements: elements, arena: parser.arena))
      }
      return RawDeclSyntax(directive)
    }

    let attrs = DeclAttributes(
      attributes: self.parseAttributeList(),
      modifiers: self.parseDeclModifierList()
    )

    let recoveryResult: (match: DeclarationKeyword, handle: RecoveryConsumptionHandle)?
    if let atResult = self.at(anyIn: DeclarationKeyword.self) {
      // We are at a keyword that starts a declaration. Parse that declaration.
      recoveryResult = (atResult.spec, .noRecovery(atResult.handle))
    } else if atFunctionDeclarationWithoutFuncKeyword() {
      // We aren't at a declaration keyword and it looks like we are at a function
      // declaration. Parse a function declaration.
      recoveryResult = (.lhs(.func), .missing(.keyword(.func)))
    } else {
      // In all other cases, use standard token recovery to find the declaration
      // to parse.
      // If we are inside a memberDecl list, we don't want to eat closing braces (which most likely close the outer context)
      // while recovering to the declaration start.
      let recoveryPrecedence = inMemberDeclList ? TokenPrecedence.closingBrace : nil
      recoveryResult = self.canRecoverTo(anyIn: DeclarationKeyword.self, overrideRecoveryPrecedence: recoveryPrecedence)
    }

    switch recoveryResult {
    case (.lhs(.import), let handle)?:
      return RawDeclSyntax(self.parseImportDeclaration(attrs, handle))
    case (.lhs(.class), let handle)?:
      return RawDeclSyntax(self.parseNominalTypeDeclaration(for: RawClassDeclSyntax.self, attrs: attrs, introucerHandle: handle))
    case (.lhs(.enum), let handle)?:
      return RawDeclSyntax(self.parseNominalTypeDeclaration(for: RawEnumDeclSyntax.self, attrs: attrs, introucerHandle: handle))
    case (.lhs(.case), let handle)?:
      return RawDeclSyntax(self.parseEnumCaseDeclaration(attrs, handle))
    case (.lhs(.struct), let handle)?:
      return RawDeclSyntax(self.parseNominalTypeDeclaration(for: RawStructDeclSyntax.self, attrs: attrs, introucerHandle: handle))
    case (.lhs(.protocol), let handle)?:
      return RawDeclSyntax(self.parseNominalTypeDeclaration(for: RawProtocolDeclSyntax.self, attrs: attrs, introucerHandle: handle))
    case (.lhs(.associatedtype), let handle)?:
      return RawDeclSyntax(self.parseAssociatedTypeDeclaration(attrs, handle))
    case (.lhs(.typealias), let handle)?:
      return RawDeclSyntax(self.parseTypealiasDeclaration(attrs, handle))
    case (.lhs(.extension), let handle)?:
      return RawDeclSyntax(self.parseExtensionDeclaration(attrs, handle))
    case (.lhs(.func), let handle)?:
      return RawDeclSyntax(self.parseFuncDeclaration(attrs, handle))
    case (.lhs(.subscript), let handle)?:
      return RawDeclSyntax(self.parseSubscriptDeclaration(attrs, handle))
    case (.lhs(.`init`), let handle)?:
      return RawDeclSyntax(self.parseInitializerDeclaration(attrs, handle))
    case (.lhs(.deinit), let handle)?:
      return RawDeclSyntax(self.parseDeinitializerDeclaration(attrs, handle))
    case (.lhs(.operator), let handle)?:
      return RawDeclSyntax(self.parseOperatorDeclaration(attrs, handle))
    case (.lhs(.precedencegroup), let handle)?:
      return RawDeclSyntax(self.parsePrecedenceGroupDeclaration(attrs, handle))
    case (.lhs(.actor), let handle)?:
      return RawDeclSyntax(self.parseNominalTypeDeclaration(for: RawActorDeclSyntax.self, attrs: attrs, introucerHandle: handle))
    case (.lhs(.macro), let handle)?:
      return RawDeclSyntax(self.parseMacroDeclaration(attrs: attrs, introducerHandle: handle))
    case (.lhs(.pound), let handle)?:
      return RawDeclSyntax(self.parseMacroExpansionDeclaration(attrs, handle))
    case (.rhs, let handle)?:
      return RawDeclSyntax(self.parseBindingDeclaration(attrs, handle, inMemberDeclList: inMemberDeclList))
    case nil:
      break
    }

    if inMemberDeclList {
      let isProbablyVarDecl = self.at(.identifier, .wildcard) && self.peek(isAt: .colon, .equal, .comma)
      let isProbablyTupleDecl = self.at(.leftParen) && self.peek(isAt: .identifier, .wildcard)

      if isProbablyVarDecl || isProbablyTupleDecl {
        return RawDeclSyntax(self.parseBindingDeclaration(attrs, .missing(.keyword(.var))))
      }

      if self.currentToken.isEditorPlaceholder {
        let placeholder = self.parseAnyIdentifier()
        return RawDeclSyntax(
          RawMissingDeclSyntax(
            attributes: attrs.attributes,
            modifiers: attrs.modifiers,
            placeholder: placeholder,
            arena: self.arena
          )
        )
      }

      if atFunctionDeclarationWithoutFuncKeyword() {
        return RawDeclSyntax(self.parseFuncDeclaration(attrs, .missing(.keyword(.func))))
      }
    }
    return RawDeclSyntax(
      RawMissingDeclSyntax(
        attributes: attrs.attributes,
        modifiers: attrs.modifiers,
        arena: self.arena
      )
    )
  }

  /// Returns `true` if it looks like the parser is positioned at a function declaration that’s missing the `func` keyword.
  fileprivate mutating func atFunctionDeclarationWithoutFuncKeyword() -> Bool {
    var nextTokenIsLeftParenOrLeftAngle: Bool {
      self.peek(isAt: .leftParen) || self.peek().tokenText.hasPrefix("<")
    }

    if self.at(.identifier) {
      return nextTokenIsLeftParenOrLeftAngle
    } else if self.at(anyIn: Operator.self) != nil {
      if self.currentToken.tokenText.hasSuffix("<") && self.peek(isAt: .identifier) {
        return true
      }
      return nextTokenIsLeftParenOrLeftAngle
    } else {
      return false
    }
  }
}

extension Parser {
  /// Parse an import declaration.
  mutating func parseImportDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawImportDeclSyntax {
    let (unexpectedBeforeImportKeyword, importKeyword) = self.eat(handle)
    let kind = self.parseImportKind()
    let path = self.parseImportPath()
    return RawImportDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeImportKeyword,
      importKeyword: importKeyword,
      importKindSpecifier: kind,
      path: path,
      arena: self.arena
    )
  }

  mutating func parseImportKind() -> RawTokenSyntax? {
    return self.consume(ifAnyIn: ImportDeclSyntax.ImportKindSpecifierOptions.self)
  }

  mutating func parseImportPath() -> RawImportPathComponentListSyntax {
    var elements = [RawImportPathComponentSyntax]()
    var keepGoing: RawTokenSyntax? = nil
    var loopProgress = LoopProgressCondition()
    repeat {
      let name = self.parseAnyIdentifier()
      keepGoing = self.consume(if: .period)
      elements.append(
        RawImportPathComponentSyntax(
          name: name,
          trailingPeriod: keepGoing,
          arena: self.arena
        )
      )
    } while keepGoing != nil && self.hasProgressed(&loopProgress)
    return RawImportPathComponentListSyntax(elements: elements, arena: self.arena)
  }
}

extension Parser {
  /// Parse an extension declaration.
  mutating func parseExtensionDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawExtensionDeclSyntax {
    let (unexpectedBeforeExtensionKeyword, extensionKeyword) = self.eat(handle)
    let type = self.parseType()

    let inheritance: RawInheritanceClauseSyntax?
    if self.at(.colon) {
      inheritance = self.parseInheritance()
    } else {
      inheritance = nil
    }

    let whereClause: RawGenericWhereClauseSyntax?
    if self.at(.keyword(.where)) {
      whereClause = self.parseGenericWhereClause()
    } else {
      whereClause = nil
    }
    let memberBlock = self.parseMemberBlock(introducer: extensionKeyword)
    return RawExtensionDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeExtensionKeyword,
      extensionKeyword: extensionKeyword,
      extendedType: type,
      inheritanceClause: inheritance,
      genericWhereClause: whereClause,
      memberBlock: memberBlock,
      arena: self.arena
    )
  }
}

extension Parser {
  mutating func parseGenericParameters() -> RawGenericParameterClauseSyntax {
    if let remainingTokens = remainingTokensIfMaximumNestingLevelReached() {
      return RawGenericParameterClauseSyntax(
        remainingTokens,
        leftAngle: missingToken(.leftAngle),
        parameters: RawGenericParameterListSyntax(elements: [], arena: self.arena),
        genericWhereClause: nil,
        rightAngle: missingToken(.rightAngle),
        arena: self.arena
      )
    }

    let langle = self.expectWithoutRecovery(prefix: "<", as: .leftAngle)
    var elements = [RawGenericParameterSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      var loopProgress = LoopProgressCondition()
      repeat {
        let attributes = self.parseAttributeList()

        // Parse the 'each' keyword for a type parameter pack 'each T'.
        var each = self.consume(if: .keyword(.each))

        let (unexpectedBetweenEachAndName, name) = self.expectIdentifier(allowSelfOrCapitalSelfAsIdentifier: true)
        if attributes.isEmpty && each == nil && unexpectedBetweenEachAndName == nil && name.isMissing && elements.isEmpty && !self.at(prefix: ">") {
          break
        }

        // Parse the unsupported ellipsis for a type parameter pack 'T...'.
        let unexpectedBetweenNameAndColon: RawUnexpectedNodesSyntax?
        if let ellipsis = self.consume(ifPrefix: "...", as: .ellipsis) {
          unexpectedBetweenNameAndColon = RawUnexpectedNodesSyntax([ellipsis], arena: self.arena)
          if each == nil {
            each = missingToken(.each)
          }
        } else {
          unexpectedBetweenNameAndColon = nil
        }

        // Parse the ':' followed by a type.
        let colon = self.consume(if: .colon)
        let unexpectedBeforeInherited: RawUnexpectedNodesSyntax?
        let inherited: RawTypeSyntax?
        if colon != nil {
          if self.at(.identifier, .keyword(.protocol), .keyword(.Any)) || self.atContextualPunctuator("~") {
            unexpectedBeforeInherited = nil
            inherited = self.parseType()
          } else if let classKeyword = self.consume(if: .keyword(.class)) {
            unexpectedBeforeInherited = RawUnexpectedNodesSyntax([classKeyword], arena: self.arena)
            inherited = RawTypeSyntax(
              RawIdentifierTypeSyntax(
                name: missingToken(.identifier, text: "AnyObject"),
                genericArgumentClause: nil,
                arena: self.arena
              )
            )
          } else {
            unexpectedBeforeInherited = nil
            inherited = RawTypeSyntax(RawMissingTypeSyntax(arena: self.arena))
          }
        } else {
          unexpectedBeforeInherited = nil
          inherited = nil
        }
        keepGoing = self.consume(if: .comma)
        elements.append(
          RawGenericParameterSyntax(
            attributes: attributes,
            eachKeyword: each,
            unexpectedBetweenEachAndName,
            name: name,
            unexpectedBetweenNameAndColon,
            colon: colon,
            unexpectedBeforeInherited,
            inheritedType: inherited,
            trailingComma: keepGoing,
            arena: self.arena
          )
        )
      } while keepGoing != nil && self.hasProgressed(&loopProgress)
    }

    let whereClause: RawGenericWhereClauseSyntax?
    if self.at(.keyword(.where)) {
      whereClause = self.parseGenericWhereClause()
    } else {
      whereClause = nil
    }

    let rangle = expectWithoutRecovery(prefix: ">", as: .rightAngle)

    let parameters: RawGenericParameterListSyntax
    if elements.isEmpty && rangle.isMissing {
      parameters = RawGenericParameterListSyntax(elements: [], arena: self.arena)
    } else {
      parameters = RawGenericParameterListSyntax(elements: elements, arena: self.arena)
    }
    return RawGenericParameterClauseSyntax(
      leftAngle: langle,
      parameters: parameters,
      genericWhereClause: whereClause,
      rightAngle: rangle,
      arena: self.arena
    )
  }

  mutating func parseGenericWhereClause() -> RawGenericWhereClauseSyntax {
    let (unexpectedBeforeWhereKeyword, whereKeyword) = self.expect(.keyword(.where))

    var elements = [RawGenericRequirementSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      var loopProgress = LoopProgressCondition()
      repeat {
        let firstType = self.parseType()
        guard !firstType.is(RawMissingTypeSyntax.self) else {
          keepGoing = self.consume(if: .comma)
          elements.append(
            RawGenericRequirementSyntax(
              requirement: .sameTypeRequirement(
                RawSameTypeRequirementSyntax(
                  leftType: RawTypeSyntax(RawMissingTypeSyntax(arena: self.arena)),
                  equal: missingToken(.binaryOperator, text: "=="),
                  rightType: RawTypeSyntax(RawMissingTypeSyntax(arena: self.arena)),
                  arena: self.arena
                )
              ),
              trailingComma: keepGoing,
              arena: self.arena
            )
          )
          continue
        }

        enum ExpectedTokenKind: TokenSpecSet {
          case colon
          case binaryOperator
          case postfixOperator
          case prefixOperator

          init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
            switch (lexeme.rawTokenKind, lexeme.tokenText) {
            case (.colon, _): self = .colon
            case (.binaryOperator, "=="): self = .binaryOperator
            case (.postfixOperator, "=="): self = .postfixOperator
            case (.prefixOperator, "=="): self = .prefixOperator
            default: return nil
            }
          }

          var spec: TokenSpec {
            switch self {
            case .colon: return .colon
            case .binaryOperator: return .binaryOperator
            case .postfixOperator: return .postfixOperator
            case .prefixOperator: return .prefixOperator
            }
          }
        }

        let requirement: RawGenericRequirementSyntax.Requirement
        switch self.at(anyIn: ExpectedTokenKind.self) {
        case (.colon, let handle)?:
          let colon = self.eat(handle)
          // A conformance-requirement.
          if let (layoutSpecifier, handle) = self.at(anyIn: LayoutRequirementSyntax.LayoutSpecifierOptions.self) {
            // Parse a layout constraint.
            let specifier = self.eat(handle)

            let unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax?
            let leftParen: RawTokenSyntax?
            let size: RawTokenSyntax?
            let comma: RawTokenSyntax?
            let alignment: RawTokenSyntax?
            let unexpectedBeforeRightParen: RawUnexpectedNodesSyntax?
            let rightParen: RawTokenSyntax?

            var hasArguments: Bool {
              switch layoutSpecifier {
              case ._Trivial,
                ._TrivialAtMost,
                ._TrivialStride:
                return true

              case ._UnknownLayout,
                ._RefCountedObject,
                ._NativeRefCountedObject,
                ._Class,
                ._NativeClass,
                ._BridgeObject:
                return false
              }
            }

            // Unlike the other layout constraints, _Trivial's argument list
            // is optional.
            if hasArguments && (layoutSpecifier != ._Trivial || self.at(.leftParen)) {
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

            requirement = .layoutRequirement(
              RawLayoutRequirementSyntax(
                type: firstType,
                colon: colon,
                layoutSpecifier: specifier,
                unexpectedBeforeLeftParen,
                leftParen: leftParen,
                size: size,
                comma: comma,
                alignment: alignment,
                unexpectedBeforeRightParen,
                rightParen: rightParen,
                arena: self.arena
              )
            )
          } else {
            // Parse the protocol or composition.
            let secondType = self.parseType()
            requirement = .conformanceRequirement(
              RawConformanceRequirementSyntax(
                leftType: firstType,
                colon: colon,
                rightType: secondType,
                arena: self.arena
              )
            )
          }
        case (.binaryOperator, let handle)?,
          (.postfixOperator, let handle)?,
          (.prefixOperator, let handle)?:
          let equal = self.eat(handle)
          let secondType = self.parseType()
          requirement = .sameTypeRequirement(
            RawSameTypeRequirementSyntax(
              leftType: firstType,
              equal: equal,
              rightType: secondType,
              arena: self.arena
            )
          )
        case nil:
          requirement = .sameTypeRequirement(
            RawSameTypeRequirementSyntax(
              leftType: firstType,
              equal: RawTokenSyntax(missing: .binaryOperator, text: "==", arena: self.arena),
              rightType: RawTypeSyntax(RawMissingTypeSyntax(arena: self.arena)),
              arena: self.arena
            )
          )
        }

        keepGoing = self.consume(if: .comma)
        let unexpectedBetweenBodyAndTrailingComma: RawUnexpectedNodesSyntax?

        // If there's a comma, keep parsing the list.
        // If there's a "&&", diagnose replace with a comma and keep parsing
        if let token = self.consumeIfContextualPunctuator("&&") {
          keepGoing = self.missingToken(.comma)
          unexpectedBetweenBodyAndTrailingComma = RawUnexpectedNodesSyntax([token], arena: self.arena)
        } else {
          unexpectedBetweenBodyAndTrailingComma = nil
        }

        elements.append(
          RawGenericRequirementSyntax(
            requirement: requirement,
            unexpectedBetweenBodyAndTrailingComma,
            trailingComma: keepGoing,
            arena: self.arena
          )
        )
      } while keepGoing != nil && self.hasProgressed(&loopProgress)
    }

    return RawGenericWhereClauseSyntax(
      unexpectedBeforeWhereKeyword,
      whereKeyword: whereKeyword,
      requirements: RawGenericRequirementListSyntax(elements: elements, arena: self.arena),
      arena: self.arena
    )
  }
}

extension Parser {
  mutating func parseMemberBlockItem() -> RawMemberBlockItemSyntax? {
    let startToken = self.currentToken
    if let syntax = self.loadCurrentSyntaxNodeFromCache(for: .memberDeclListItem) {
      self.registerNodeForIncrementalParse(node: syntax.raw, startToken: startToken)
      return RawMemberBlockItemSyntax(syntax.raw)
    }
    if let remainingTokens = remainingTokensIfMaximumNestingLevelReached() {
      let item = RawMemberBlockItemSyntax(
        remainingTokens,
        decl: RawDeclSyntax(
          RawMissingDeclSyntax(
            attributes: self.emptyCollection(RawAttributeListSyntax.self),
            modifiers: self.emptyCollection(RawDeclModifierListSyntax.self),
            arena: self.arena
          )
        ),
        semicolon: nil,
        arena: self.arena
      )
      return item
    }

    let decl: RawDeclSyntax
    if self.at(.poundSourceLocation) {
      decl = RawDeclSyntax(self.parsePoundSourceLocationDirective())
    } else {
      decl = self.parseDeclaration(inMemberDeclList: true)
    }

    let semi = self.consume(if: .semicolon)
    var trailingSemis: [RawTokenSyntax] = []
    while let trailingSemi = self.consume(if: .semicolon) {
      trailingSemis.append(trailingSemi)
    }

    if decl.isEmpty && semi == nil && trailingSemis.isEmpty {
      return nil
    }

    let result = RawMemberBlockItemSyntax(
      decl: decl,
      semicolon: semi,
      RawUnexpectedNodesSyntax(trailingSemis, arena: self.arena),
      arena: self.arena
    )

    self.registerNodeForIncrementalParse(node: result.raw, startToken: startToken)

    return result
  }

  mutating func parseMemberDeclList() -> RawMemberBlockItemListSyntax {
    var elements = [RawMemberBlockItemSyntax]()
    do {
      var loopProgress = LoopProgressCondition()
      while !self.at(.endOfFile, .rightBrace) && self.hasProgressed(&loopProgress) {
        let newItemAtStartOfLine = self.atStartOfLine
        guard let newElement = self.parseMemberBlockItem() else {
          break
        }
        if let lastItem = elements.last, lastItem.semicolon == nil && !newItemAtStartOfLine {
          elements[elements.count - 1] = RawMemberBlockItemSyntax(
            lastItem.unexpectedBeforeDecl,
            decl: lastItem.decl,
            lastItem.unexpectedBetweenDeclAndSemicolon,
            semicolon: self.missingToken(.semicolon),
            lastItem.unexpectedAfterSemicolon,
            arena: self.arena
          )

        }
        elements.append(newElement)
      }
    }
    return RawMemberBlockItemListSyntax(elements: elements, arena: self.arena)
  }

  /// `introducer` is the `struct`, `class`, ... keyword that is the cause that the member decl block is being parsed.
  /// If the left brace is missing, its indentation will be used to judge whether a following `}` was
  /// indented to close this code block or a surrounding context. See `expectRightBrace`.
  mutating func parseMemberBlock(introducer: RawTokenSyntax? = nil) -> RawMemberBlockSyntax {
    let (unexpectedBeforeLBrace, lbrace) = self.expect(.leftBrace)
    let members = parseMemberDeclList()
    let (unexpectedBeforeRBrace, rbrace) = self.expectRightBrace(leftBrace: lbrace, introducer: introducer)

    return RawMemberBlockSyntax(
      unexpectedBeforeLBrace,
      leftBrace: lbrace,
      members: members,
      unexpectedBeforeRBrace,
      rightBrace: rbrace,
      arena: self.arena
    )
  }
}

extension Parser {
  /// Parse an enum 'case' declaration.
  mutating func parseEnumCaseDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawEnumCaseDeclSyntax {
    let (unexpectedBeforeCaseKeyword, caseKeyword) = self.eat(handle)
    var elements = [RawEnumCaseElementSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      var loopProgress = LoopProgressCondition()
      repeat {
        let unexpectedPeriod = self.consume(if: .period)
        let (unexpectedBeforeName, name) = self.expectIdentifier(keywordRecovery: true)

        let unexpectedGenericParameters: RawUnexpectedNodesSyntax?
        if self.at(prefix: "<") {
          let genericParameters = self.parseGenericParameters()
          unexpectedGenericParameters = RawUnexpectedNodesSyntax([genericParameters], arena: self.arena)
        } else {
          unexpectedGenericParameters = nil
        }

        let parameterClause: RawEnumCaseParameterClauseSyntax?
        if self.at(TokenSpec(.leftParen)) {
          parameterClause = self.parseParameterClause(RawEnumCaseParameterClauseSyntax.self) { parser in
            parser.parseEnumCaseParameter()
          }
        } else {
          parameterClause = nil
        }

        // See if there's a raw value expression.
        let rawValue: RawInitializerClauseSyntax?
        if let eq = self.consume(if: .equal) {
          let value = self.parseExpression(flavor: .basic, pattern: .none)
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
        elements.append(
          RawEnumCaseElementSyntax(
            RawUnexpectedNodesSyntax(combining: unexpectedPeriod, unexpectedBeforeName, arena: self.arena),
            name: name,
            unexpectedGenericParameters,
            parameterClause: parameterClause,
            rawValue: rawValue,
            trailingComma: keepGoing,
            arena: self.arena
          )
        )
      } while keepGoing != nil && self.hasProgressed(&loopProgress)
    }

    return RawEnumCaseDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeCaseKeyword,
      caseKeyword: caseKeyword,
      elements: RawEnumCaseElementListSyntax(elements: elements, arena: self.arena),
      arena: self.arena
    )
  }

  /// Parse an associated type declaration.
  mutating func parseAssociatedTypeDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawAssociatedTypeDeclSyntax {
    let (unexpectedBeforeAssocKeyword, assocKeyword) = self.eat(handle)

    // Detect an attempt to use a type parameter pack.
    let eachKeyword = self.consume(if: .keyword(.each))

    var (unexpectedBeforeName, name) = self.expectIdentifier(keywordRecovery: true)
    if eachKeyword != nil {
      unexpectedBeforeName = RawUnexpectedNodesSyntax(combining: eachKeyword, unexpectedBeforeName, arena: self.arena)
    }

    if unexpectedBeforeName == nil && name.isMissing {
      return RawAssociatedTypeDeclSyntax(
        attributes: attrs.attributes,
        modifiers: attrs.modifiers,
        unexpectedBeforeAssocKeyword,
        associatedtypeKeyword: assocKeyword,
        unexpectedBeforeName,
        name: name,
        inheritanceClause: nil,
        initializer: nil,
        genericWhereClause: nil,
        arena: self.arena
      )
    }

    // Detect an attempt to use (early syntax) type parameter pack.
    let ellipsis = self.consume(ifPrefix: "...", as: .ellipsis)

    // Parse optional inheritance clause.
    let inheritance: RawInheritanceClauseSyntax?
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
    if self.at(.keyword(.where)) {
      whereClause = self.parseGenericWhereClause()
    } else {
      whereClause = nil
    }

    return RawAssociatedTypeDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeAssocKeyword,
      associatedtypeKeyword: assocKeyword,
      unexpectedBeforeName,
      name: name,
      RawUnexpectedNodesSyntax([ellipsis], arena: self.arena),
      inheritanceClause: inheritance,
      initializer: defaultType,
      genericWhereClause: whereClause,
      arena: self.arena
    )
  }
}

extension Parser {
  /// Parse an initializer declaration.
  mutating func parseInitializerDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawInitializerDeclSyntax {
    let (unexpectedBeforeInitKeyword, initKeyword) = self.eat(handle)

    // Parse the '!' or '?' for a failable initializer.
    let failable: RawTokenSyntax?
    if let parsedFailable = self.consume(if: .exclamationMark, .postfixQuestionMark, TokenSpec(.infixQuestionMark, remapping: .postfixQuestionMark)) {
      failable = parsedFailable
    } else if let parsedFailable = self.consumeIfContextualPunctuator("!", remapping: .exclamationMark) {
      failable = parsedFailable
    } else {
      failable = nil
    }

    let generics: RawGenericParameterClauseSyntax?
    if self.at(prefix: "<") {
      generics = self.parseGenericParameters()
    } else {
      generics = nil
    }

    // Parse the signature.
    let signature = self.parseFunctionSignature(allowOutput: false)

    let whereClause: RawGenericWhereClauseSyntax?
    if self.at(.keyword(.where)) {
      whereClause = self.parseGenericWhereClause()
    } else {
      whereClause = nil
    }

    let items = self.parseOptionalCodeBlock(allowInitDecl: false)

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
      arena: self.arena
    )
  }

  /// Parse a deinitializer declaration.
  mutating func parseDeinitializerDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawDeinitializerDeclSyntax {
    let (unexpectedBeforeDeinitKeyword, deinitKeyword) = self.eat(handle)

    var unexpectedNameAndSignature: [RawSyntax?] = []

    // async is a contextual keyword
    // must be parsed before attempting to parse identifier
    var effectSpecifiers = parseDeinitEffectSpecifiers()

    if effectSpecifiers == nil {
      if let identifier = self.consume(if: TokenSpec(.identifier, allowAtStartOfLine: false)).map(RawSyntax.init) {
        unexpectedNameAndSignature.append(identifier)
      }
      effectSpecifiers = parseDeinitEffectSpecifiers()
    }
    if effectSpecifiers == nil && self.at(TokenSpec(.leftParen, allowAtStartOfLine: false)) {
      let input = parseParameterClause(RawFunctionParameterClauseSyntax.self) { parser in
        parser.parseFunctionParameter()
      }
      unexpectedNameAndSignature.append(RawSyntax(input))

      effectSpecifiers = parseDeinitEffectSpecifiers()
    }

    var unexpectedAfterAsync: [RawSyntax?] = []
    /// Only allow recovery to the arrow with exprKeyword precedence so we only
    /// skip over misplaced identifiers and don't e.g. recover to an arrow in a 'where' clause.
    if self.canRecoverTo(TokenSpec(.arrow, recoveryPrecedence: .exprKeyword)) != nil {
      let output = self.parseFunctionReturnClause(effectSpecifiers: &effectSpecifiers, allowNamedOpaqueResultType: true)
      unexpectedAfterAsync.append(RawSyntax(output))
    }

    let items = self.parseOptionalCodeBlock()
    return RawDeinitializerDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeDeinitKeyword,
      deinitKeyword: deinitKeyword,
      RawUnexpectedNodesSyntax(unexpectedNameAndSignature, arena: self.arena),
      effectSpecifiers: effectSpecifiers,
      RawUnexpectedNodesSyntax(unexpectedAfterAsync, arena: arena),
      body: items,
      arena: self.arena
    )
  }
}

extension Parser {
  /// If a `throws` keyword appears right in front of the `arrow`, it is returned as `misplacedThrowsKeyword` so it can be synthesized in front of the arrow.
  mutating func parseFunctionReturnClause(effectSpecifiers: inout (some RawMisplacedEffectSpecifiersTrait)?, allowNamedOpaqueResultType: Bool)
    -> RawReturnClauseSyntax
  {
    let (unexpectedBeforeArrow, arrow) = self.expect(.arrow)
    let unexpectedBeforeReturnType = self.parseMisplacedEffectSpecifiers(&effectSpecifiers)
    let type: RawTypeSyntax
    if allowNamedOpaqueResultType {
      type = self.parseResultType()
    } else {
      type = self.parseType()
    }
    let unexpectedAfterReturnType = self.parseMisplacedEffectSpecifiers(&effectSpecifiers)
    let returnClause = RawReturnClauseSyntax(
      unexpectedBeforeArrow,
      arrow: arrow,
      unexpectedBeforeReturnType,
      type: type,
      unexpectedAfterReturnType,
      arena: self.arena
    )
    return returnClause
  }
}

extension Parser {
  mutating func parseFuncDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawFunctionDeclSyntax {
    let (unexpectedBeforeFuncKeyword, funcKeyword) = self.eat(handle)
    let unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax?
    let unexpectedAfterIdentifier: RawUnexpectedNodesSyntax?
    let identifier: RawTokenSyntax
    if self.at(anyIn: Operator.self) != nil || self.at(.exclamationMark, .prefixAmpersand) {
      var name = self.currentToken.tokenText
      if !currentToken.isEditorPlaceholder && name.hasSuffix("<") && self.peek(isAt: .identifier) {
        name = SyntaxText(rebasing: name.dropLast())
      }
      unexpectedBeforeIdentifier = nil
      identifier = self.consumePrefix(name, as: .binaryOperator)
      unexpectedAfterIdentifier = nil
    } else {
      (unexpectedBeforeIdentifier, identifier) = self.expectIdentifier(keywordRecovery: true)

      if currentToken.isEditorPlaceholder {
        let editorPlaceholder = self.parseAnyIdentifier()
        unexpectedAfterIdentifier = RawUnexpectedNodesSyntax([editorPlaceholder], arena: self.arena)
      } else {
        unexpectedAfterIdentifier = nil
      }
    }

    let genericParams: RawGenericParameterClauseSyntax?
    if self.at(prefix: "<") {
      genericParams = self.parseGenericParameters()
    } else {
      genericParams = nil
    }

    let signature = self.parseFunctionSignature()

    let generics: RawGenericWhereClauseSyntax?
    if self.at(.keyword(.where)) {
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
      name: identifier,
      unexpectedAfterIdentifier,
      genericParameterClause: genericParams,
      signature: signature,
      genericWhereClause: generics,
      body: body,
      arena: self.arena
    )
  }

  mutating func parseFunctionSignature(allowOutput: Bool = true) -> RawFunctionSignatureSyntax {
    let parameterClause = self.parseParameterClause(RawFunctionParameterClauseSyntax.self) { parser in
      parser.parseFunctionParameter()
    }

    var effectSpecifiers = self.parseFunctionEffectSpecifiers()

    var returnClause: RawReturnClauseSyntax?

    /// Only allow recovery to the arrow with exprKeyword precedence so we only
    /// skip over misplaced identifiers and don't e.g. recover to an arrow in a 'where' clause.
    if self.canRecoverTo(TokenSpec(.arrow, recoveryPrecedence: .exprKeyword)) != nil {
      returnClause = self.parseFunctionReturnClause(effectSpecifiers: &effectSpecifiers, allowNamedOpaqueResultType: true)
    } else {
      returnClause = nil
    }

    var unexpectedAfterReturnClause: RawUnexpectedNodesSyntax?
    if !allowOutput,
      let unexpectedOutput = returnClause
    {
      returnClause = nil
      unexpectedAfterReturnClause = RawUnexpectedNodesSyntax([unexpectedOutput], arena: self.arena)
    }

    return RawFunctionSignatureSyntax(
      parameterClause: parameterClause,
      effectSpecifiers: effectSpecifiers,
      returnClause: returnClause,
      unexpectedAfterReturnClause,
      arena: self.arena
    )
  }
}

extension Parser {
  /// Parse a subscript declaration.
  mutating func parseSubscriptDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawSubscriptDeclSyntax {
    let (unexpectedBeforeSubscriptKeyword, subscriptKeyword) = self.eat(handle)

    let unexpectedName: RawTokenSyntax?
    if self.at(.identifier) && self.peek().tokenText.hasPrefix("<") || self.peek(isAt: .leftParen) {
      unexpectedName = self.consumeAnyToken()
    } else {
      unexpectedName = nil
    }

    let genericParameterClause: RawGenericParameterClauseSyntax?
    if self.at(prefix: "<") {
      genericParameterClause = self.parseGenericParameters()
    } else {
      genericParameterClause = nil
    }

    let parameterClause = self.parseParameterClause(RawFunctionParameterClauseSyntax.self) { parser in
      parser.parseFunctionParameter()
    }

    var misplacedEffectSpecifiers: RawFunctionEffectSpecifiersSyntax?
    let returnClause = self.parseFunctionReturnClause(effectSpecifiers: &misplacedEffectSpecifiers, allowNamedOpaqueResultType: true)

    // Parse a 'where' clause if present.
    let genericWhereClause: RawGenericWhereClauseSyntax?
    if self.at(.keyword(.where)) {
      genericWhereClause = self.parseGenericWhereClause()
    } else {
      genericWhereClause = nil
    }

    // Parse getter and setter.
    let accessor: RawAccessorBlockSyntax?
    if self.at(.leftBrace) || self.at(anyIn: AccessorDeclSyntax.AccessorSpecifierOptions.self) != nil {
      accessor = self.parseAccessorBlock()
    } else {
      accessor = nil
    }

    return RawSubscriptDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeSubscriptKeyword,
      subscriptKeyword: subscriptKeyword,
      RawUnexpectedNodesSyntax([unexpectedName], arena: self.arena),
      genericParameterClause: genericParameterClause,
      parameterClause: parameterClause,
      returnClause: returnClause,
      genericWhereClause: genericWhereClause,
      accessorBlock: accessor,
      arena: self.arena
    )
  }
}

extension Parser {
  /// Parse a variable declaration starting with a leading 'let' or 'var' keyword.
  ///
  /// If `inMemberDeclList` is `true`, we know that the next item needs to be a
  /// declaration that is started by a keyword. Thus, we in the following case
  /// we know that `set` can't start a new declaration and we can thus recover
  /// by synthesizing a missing `{` in front of `set`.
  /// ```
  /// var x: Int
  ///   set {
  ///   }
  /// }
  /// ```
  mutating func parseBindingDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle,
    inMemberDeclList: Bool = false
  ) -> RawVariableDeclSyntax {
    let (unexpectedBeforeIntroducer, introducer) = self.eat(handle)
    let hasTryBeforeIntroducer = unexpectedBeforeIntroducer?.containsToken(where: { TokenSpec(.try) ~= $0 }) ?? false

    var elements = [RawPatternBindingSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      var loopProgress = LoopProgressCondition()
      repeat {

        var (pattern, typeAnnotation) = self.parseTypedPattern()

        // Parse an initializer if present.
        let initializer: RawInitializerClauseSyntax?
        if let equal = self.consume(if: .equal) {
          var value = self.parseExpression(flavor: .basic, pattern: .none)
          if hasTryBeforeIntroducer && !value.is(RawTryExprSyntax.self) {
            value = RawExprSyntax(
              RawTryExprSyntax(
                tryKeyword: missingToken(.try),
                questionOrExclamationMark: nil,
                expression: value,
                arena: self.arena
              )
            )
          }
          initializer = RawInitializerClauseSyntax(
            equal: equal,
            value: value,
            arena: self.arena
          )
        } else if self.at(TokenSpec(.leftParen, allowAtStartOfLine: false)),
          let typeAnnotationUnwrapped = typeAnnotation
        {
          // If we have a '(' after the type in the annotation, the type annotation
          // is probably a constructor call. Rewrite the nodes to remove the type
          // annotation and form an initializer clause from it instead.
          typeAnnotation = nil
          let initExpr = parsePostfixExpressionSuffix(
            RawExprSyntax(
              RawTypeExprSyntax(
                type: typeAnnotationUnwrapped.type,
                typeAnnotation?.unexpectedAfterType,
                arena: self.arena
              )
            ),
            flavor: .basic,
            pattern: .none
          )
          initializer = RawInitializerClauseSyntax(
            RawUnexpectedNodesSyntax(
              combining:
                typeAnnotationUnwrapped.unexpectedBeforeColon,
              typeAnnotationUnwrapped.colon,
              typeAnnotationUnwrapped.unexpectedBetweenColonAndType,
              arena: self.arena
            ),
            equal: missingToken(.equal),
            value: initExpr,
            arena: self.arena
          )
        } else if self.atStartOfExpression(), !self.at(.leftBrace), !self.atStartOfLine {
          let missingEqual = RawTokenSyntax(missing: .equal, arena: self.arena)
          let expr = self.parseExpression(flavor: .basic, pattern: .none)
          initializer = RawInitializerClauseSyntax(
            equal: missingEqual,
            value: expr,
            arena: self.arena
          )
        } else {
          initializer = nil
        }

        let accessors: RawAccessorBlockSyntax?
        if self.at(.leftBrace) || (inMemberDeclList && self.at(anyIn: AccessorDeclSyntax.AccessorSpecifierOptions.self) != nil && !self.at(.keyword(.`init`))) {
          accessors = self.parseAccessorBlock()
        } else {
          accessors = nil
        }

        keepGoing = self.consume(if: .comma)
        elements.append(
          RawPatternBindingSyntax(
            pattern: pattern,
            typeAnnotation: typeAnnotation,
            initializer: initializer,
            accessorBlock: accessors,
            trailingComma: keepGoing,
            arena: self.arena
          )
        )
      } while keepGoing != nil && self.hasProgressed(&loopProgress)
    }

    return RawVariableDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeIntroducer,
      bindingSpecifier: introducer,
      bindings: RawPatternBindingListSyntax(elements: elements, arena: self.arena),
      arena: self.arena
    )
  }

  struct AccessorIntroducer {
    var attributes: RawAttributeListSyntax
    var modifier: RawDeclModifierSyntax?
    var kind: AccessorDeclSyntax.AccessorSpecifierOptions
    var unexpectedBeforeToken: RawUnexpectedNodesSyntax?
    var token: RawTokenSyntax
  }

  mutating func parseAccessorIntroducer(
    forcedKind: (AccessorDeclSyntax.AccessorSpecifierOptions, TokenConsumptionHandle)? = nil
  ) -> AccessorIntroducer? {
    // Check there is an identifier before consuming
    var look = self.lookahead()
    let _ = look.consumeAttributeList()
    let hasModifier = look.consume(ifAnyIn: AccessorModifier.self) != nil
    guard let (kind, _) = look.at(anyIn: AccessorDeclSyntax.AccessorSpecifierOptions.self) ?? forcedKind else {
      return nil
    }

    let attrs = self.parseAttributeList()

    // Parse the contextual keywords for 'mutating' and 'nonmutating' before
    // get and set.
    let modifier: RawDeclModifierSyntax?
    if hasModifier {
      let (unexpectedBeforeName, name) = self.expect(anyIn: AccessorModifier.self, default: .mutating)
      modifier = RawDeclModifierSyntax(
        unexpectedBeforeName,
        name: name,
        detail: nil,
        arena: self.arena
      )
    } else {
      modifier = nil
    }

    let (unexpectedBeforeIntroducer, introducer) = self.expect(kind.spec)
    return AccessorIntroducer(
      attributes: attrs,
      modifier: modifier,
      kind: kind,
      unexpectedBeforeToken: unexpectedBeforeIntroducer,
      token: introducer
    )
  }

  /// Parse an accessor.
  mutating func parseAccessorDecl() -> RawAccessorDeclSyntax {
    let forcedHandle = TokenConsumptionHandle(spec: .keyword(.get), tokenIsMissing: true)
    let introducer = parseAccessorIntroducer(forcedKind: (.get, forcedHandle))!
    return parseAccessorDecl(introducer: introducer)
  }

  /// Parse an accessor once we know we have an introducer
  mutating func parseAccessorDecl(
    introducer: AccessorIntroducer
  ) -> RawAccessorDeclSyntax {
    // 'set' and 'willSet' can have an optional name.  This isn't valid in a
    // protocol, but we parse and then reject it for better QoI.
    let parameters: RawAccessorParametersSyntax?
    if [AccessorDeclSyntax.AccessorSpecifierOptions.set, .willSet, .didSet, .`init`].contains(introducer.kind), let lparen = self.consume(if: .leftParen) {
      let (unexpectedBeforeName, name) = self.expectIdentifier()
      let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
      parameters = RawAccessorParametersSyntax(
        leftParen: lparen,
        unexpectedBeforeName,
        name: name,
        unexpectedBeforeRParen,
        rightParen: rparen,
        arena: self.arena
      )
    } else {
      parameters = nil
    }

    let effectSpecifiers = self.parseAccessorEffectSpecifiers()

    let body = self.parseOptionalCodeBlock()
    return RawAccessorDeclSyntax(
      attributes: introducer.attributes,
      modifier: introducer.modifier,
      introducer.unexpectedBeforeToken,
      accessorSpecifier: introducer.token,
      parameters: parameters,
      effectSpecifiers: effectSpecifiers,
      body: body,
      arena: self.arena
    )
  }

  mutating func parseAccessorList() -> RawAccessorDeclListSyntax? {
    // Collect all explicit accessors to a list.
    var elements = [RawAccessorDeclSyntax]()
    do {
      var loopProgress = LoopProgressCondition()
      while !self.at(.endOfFile, .rightBrace) && self.hasProgressed(&loopProgress) {
        guard let introducer = self.parseAccessorIntroducer() else {
          break
        }

        elements.append(parseAccessorDecl(introducer: introducer))
      }
    }
    if elements.isEmpty {
      return nil
    } else {
      return RawAccessorDeclListSyntax(elements: elements, arena: self.arena)
    }
  }

  /// Parse the body of a variable declaration. This can include explicit
  /// getters, setters, and observers, or the body of a computed property.
  mutating func parseAccessorBlock() -> RawAccessorBlockSyntax {
    // Parse getter and setter.
    let unexpectedBeforeLBrace: RawUnexpectedNodesSyntax?
    let lbrace: RawTokenSyntax
    if self.at(anyIn: AccessorDeclSyntax.AccessorSpecifierOptions.self) != nil {
      unexpectedBeforeLBrace = nil
      lbrace = missingToken(.leftBrace)
    } else {
      (unexpectedBeforeLBrace, lbrace) = self.expect(.leftBrace)
    }

    let accessorList = parseAccessorList()

    // There can only be an implicit getter if no other accessors were
    // seen before this one.
    guard let accessorList else {
      let body = parseCodeBlockItemList(until: { $0.at(.rightBrace) })

      let (unexpectedBeforeRBrace, rbrace) = self.expect(.rightBrace)
      return RawAccessorBlockSyntax(
        unexpectedBeforeLBrace,
        leftBrace: lbrace,
        accessors: .getter(body),
        unexpectedBeforeRBrace,
        rightBrace: rbrace,
        arena: self.arena
      )
    }

    let (unexpectedBeforeRBrace, rbrace) = self.expect(.rightBrace)
    return RawAccessorBlockSyntax(
      unexpectedBeforeLBrace,
      leftBrace: lbrace,
      accessors: .accessors(accessorList),
      unexpectedBeforeRBrace,
      rightBrace: rbrace,
      arena: self.arena
    )
  }
}

extension Parser {
  /// Parse a typealias declaration.
  mutating func parseTypealiasDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawTypeAliasDeclSyntax {
    let (unexpectedBeforeTypealiasKeyword, typealiasKeyword) = self.eat(handle)
    let (unexpectedBeforeName, name) = self.expectIdentifier(keywordRecovery: true)

    // Parse a generic parameter list if it is present.
    let generics: RawGenericParameterClauseSyntax?
    if self.at(prefix: "<") {
      generics = self.parseGenericParameters()
    } else {
      generics = nil
    }

    // Parse the binding alias.
    let unexpectedBeforeEqual: RawUnexpectedNodesSyntax?
    let equal: RawTokenSyntax
    if let colon = self.consume(if: .colon) {
      unexpectedBeforeEqual = RawUnexpectedNodesSyntax(elements: [RawSyntax(colon)], arena: self.arena)
      equal = missingToken(.equal)
    } else {
      (unexpectedBeforeEqual, equal) = self.expect(.equal)
    }
    let value = self.parseType()
    let initializer = RawTypeInitializerClauseSyntax(
      unexpectedBeforeEqual,
      equal: equal,
      value: value,
      arena: self.arena
    )

    // Parse a 'where' clause if present.
    let genericWhereClause: RawGenericWhereClauseSyntax?
    if self.at(.keyword(.where)) {
      genericWhereClause = self.parseGenericWhereClause()
    } else {
      genericWhereClause = nil
    }

    return RawTypeAliasDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeTypealiasKeyword,
      typealiasKeyword: typealiasKeyword,
      unexpectedBeforeName,
      name: name,
      genericParameterClause: generics,
      initializer: initializer,
      genericWhereClause: genericWhereClause,
      arena: self.arena
    )
  }
}

extension Parser {
  struct OperatorDeclIntroducer {
    var unexpectedBeforeFixity: RawUnexpectedNodesSyntax?
    var fixity: RawTokenSyntax
    var unexpectedBeforeOperatorKeyword: RawUnexpectedNodesSyntax?
    var operatorKeyword: RawTokenSyntax
  }

  /// Parse an operator declaration.
  mutating func parseOperatorDeclIntroducer(_ attrs: DeclAttributes, _ handle: RecoveryConsumptionHandle) -> OperatorDeclIntroducer {
    func isFixity(_ modifier: RawDeclModifierSyntax) -> Bool {
      switch modifier.name {
      case .keyword(.prefix),
        .keyword(.infix),
        .keyword(.postfix):
        return true
      default:
        return false
      }
    }

    var unexpectedBeforeFixity = RawUnexpectedNodesSyntax(attrs.attributes.elements, arena: self.arena)

    var fixity: RawTokenSyntax?
    var unexpectedAfterFixity: RawUnexpectedNodesSyntax?

    let modifiers = attrs.modifiers.elements
    if let firstFixityIndex = modifiers.firstIndex(where: { isFixity($0) }) {
      let fixityModifier = modifiers[firstFixityIndex]
      fixity = fixityModifier.name

      unexpectedBeforeFixity = RawUnexpectedNodesSyntax(
        combining: unexpectedBeforeFixity,
        RawUnexpectedNodesSyntax(Array(modifiers[0..<firstFixityIndex]), arena: self.arena),
        fixityModifier.unexpectedBeforeName,
        arena: self.arena
      )

      unexpectedAfterFixity = RawUnexpectedNodesSyntax(
        combining: fixityModifier.unexpectedBetweenNameAndDetail,
        RawUnexpectedNodesSyntax([fixityModifier.detail], arena: self.arena),
        fixityModifier.unexpectedAfterDetail,
        RawUnexpectedNodesSyntax(Array(modifiers[modifiers.index(after: firstFixityIndex)...]), arena: self.arena),
        arena: self.arena
      )

    } else {
      unexpectedBeforeFixity = RawUnexpectedNodesSyntax(
        combining: unexpectedBeforeFixity,
        RawUnexpectedNodesSyntax(modifiers, arena: self.arena),
        arena: self.arena
      )
    }

    var (unexpectedBeforeOperatorKeyword, operatorKeyword) = self.expect(.keyword(.operator))

    unexpectedBeforeOperatorKeyword = RawUnexpectedNodesSyntax(combining: unexpectedAfterFixity, unexpectedBeforeOperatorKeyword, arena: self.arena)

    return OperatorDeclIntroducer(
      unexpectedBeforeFixity: unexpectedBeforeFixity,
      fixity: fixity ?? self.missingToken(.prefix),
      unexpectedBeforeOperatorKeyword: unexpectedBeforeOperatorKeyword,
      operatorKeyword: operatorKeyword
    )
  }

  mutating func parseOperatorDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawOperatorDeclSyntax {
    let introducer = parseOperatorDeclIntroducer(attrs, handle)

    let unexpectedBeforeName: RawUnexpectedNodesSyntax?
    let name: RawTokenSyntax
    switch self.canRecoverTo(anyIn: OperatorLike.self) {
    case (_, let handle)?:
      (unexpectedBeforeName, name) = self.eat(handle)
    default:
      if let identifier = self.consume(if: TokenSpec(.identifier, allowAtStartOfLine: false), TokenSpec(.dollarIdentifier, allowAtStartOfLine: false)) {
        // Recover if the developer tried to use an identifier as the operator name
        unexpectedBeforeName = RawUnexpectedNodesSyntax([identifier], arena: self.arena)
      } else {
        unexpectedBeforeName = nil
      }
      name = missingToken(.binaryOperator)
    }

    // Eat any subsequent tokens that are not separated to the operator by trivia.
    // The developer most likely intended these to be part of the operator name.
    var identifiersAfterOperatorName: [RawTokenSyntax] = []
    var loopProgress = LoopProgressCondition()
    while (identifiersAfterOperatorName.last ?? name).trailingTriviaByteLength == 0,
      self.currentToken.leadingTriviaByteLength == 0,
      !self.at(.colon, .leftBrace, .endOfFile),
      self.hasProgressed(&loopProgress)
    {
      identifiersAfterOperatorName.append(consumeAnyToken())
    }

    // Parse (or diagnose) a specified precedence group and/or
    // designated protocol. These both look like identifiers, so we
    // parse them both as identifiers here and sort it out in type
    // checking.
    let precedenceAndTypes: RawOperatorPrecedenceAndTypesSyntax?
    if let colon = self.consume(if: .colon) {
      let (unexpectedBeforeIdentifier, identifier) = self.expectIdentifier(allowSelfOrCapitalSelfAsIdentifier: true)
      var types = [RawDesignatedTypeSyntax]()
      while let comma = self.consume(if: .comma) {
        // Technically, we should only accept identifiers for the designated
        // types but the C++ parser accepted anything, which we mimick.
        // It's not worth fixing since designated types are no longer allowed
        // anyway.
        let designatedType = self.consumeAnyToken()
        types.append(
          RawDesignatedTypeSyntax(
            leadingComma: comma,
            name: designatedType,
            arena: self.arena
          )
        )
      }
      precedenceAndTypes = RawOperatorPrecedenceAndTypesSyntax(
        colon: colon,
        unexpectedBeforeIdentifier,
        precedenceGroup: identifier,
        designatedTypes: RawDesignatedTypeListSyntax(
          elements: types,
          arena: self.arena
        ),
        arena: self.arena
      )
    } else {
      precedenceAndTypes = nil
    }
    let unexpectedAtEnd: RawUnexpectedNodesSyntax?
    if let leftBrace = self.consume(if: .leftBrace) {
      let attributeList = self.parsePrecedenceGroupAttributeListSyntax()
      let rightBrace = self.consume(if: .rightBrace)
      unexpectedAtEnd = RawUnexpectedNodesSyntax(
        elements: [
          RawSyntax(leftBrace),
          RawSyntax(attributeList),
          rightBrace.map(RawSyntax.init),
        ].compactMap({ $0 }),
        arena: self.arena
      )
    } else {
      unexpectedAtEnd = nil
    }
    return RawOperatorDeclSyntax(
      introducer.unexpectedBeforeFixity,
      fixitySpecifier: introducer.fixity,
      introducer.unexpectedBeforeOperatorKeyword,
      operatorKeyword: introducer.operatorKeyword,
      unexpectedBeforeName,
      name: name,
      RawUnexpectedNodesSyntax(identifiersAfterOperatorName, arena: self.arena),
      operatorPrecedenceAndTypes: precedenceAndTypes,
      unexpectedAtEnd,
      arena: self.arena
    )
  }

  /// Parse a precedence group declaration.
  mutating func parsePrecedenceGroupDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawPrecedenceGroupDeclSyntax {
    let (unexpectedBeforeGroup, group) = self.eat(handle)
    let (unexpectedBeforeName, name) = self.expectIdentifier(allowSelfOrCapitalSelfAsIdentifier: true)
    let (unexpectedBeforeLBrace, lbrace) = self.expect(.leftBrace)

    let groupAttributes = self.parsePrecedenceGroupAttributeListSyntax()

    let (unexpectedBeforeRBrace, rbrace) = self.expect(.rightBrace)
    return RawPrecedenceGroupDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeGroup,
      precedencegroupKeyword: group,
      unexpectedBeforeName,
      name: name,
      unexpectedBeforeLBrace,
      leftBrace: lbrace,
      groupAttributes: groupAttributes,
      unexpectedBeforeRBrace,
      rightBrace: rbrace,
      arena: self.arena
    )
  }

  mutating func parsePrecedenceGroupAttributeListSyntax() -> RawPrecedenceGroupAttributeListSyntax {
    enum LabelText: TokenSpecSet {
      case associativity
      case assignment
      case higherThan
      case lowerThan

      init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
        switch PrepareForKeywordMatch(lexeme) {
        case TokenSpec(.associativity): self = .associativity
        case TokenSpec(.assignment): self = .assignment
        case TokenSpec(.higherThan): self = .higherThan
        case TokenSpec(.lowerThan): self = .lowerThan
        default: return nil
        }
      }

      var spec: TokenSpec {
        switch self {
        case .associativity: return .keyword(.associativity)
        case .assignment: return .keyword(.assignment)
        case .higherThan: return .keyword(.higherThan)
        case .lowerThan: return .keyword(.lowerThan)
        }
      }
    }

    var elements = [RawPrecedenceGroupAttributeListSyntax.Element]()
    do {
      var attributesProgress = LoopProgressCondition()
      LOOP: while !self.at(.endOfFile, .rightBrace) && self.hasProgressed(&attributesProgress) {
        switch self.at(anyIn: LabelText.self) {
        case (.associativity, let handle)?:
          let associativity = self.eat(handle)
          let (unexpectedBeforeColon, colon) = self.expect(.colon)
          var (unexpectedBeforeValue, value) = self.expect(.keyword(.left), .keyword(.right), .keyword(.none), default: .keyword(.none))
          if value.isMissing, let identifier = self.consume(if: .identifier) {
            unexpectedBeforeValue = RawUnexpectedNodesSyntax(combining: unexpectedBeforeValue, identifier, arena: self.arena)
          }
          elements.append(
            .precedenceGroupAssociativity(
              RawPrecedenceGroupAssociativitySyntax(
                associativityLabel: associativity,
                unexpectedBeforeColon,
                colon: colon,
                unexpectedBeforeValue,
                value: value,
                arena: self.arena
              )
            )
          )
        case (.assignment, let handle)?:
          let assignmentKeyword = self.eat(handle)
          let (unexpectedBeforeColon, colon) = self.expect(.colon)
          let (unexpectedBeforeValue, value) = self.expect(anyIn: PrecedenceGroupAssignmentSyntax.ValueOptions.self, default: .true)
          let unexpectedAfterFlag: RawUnexpectedNodesSyntax?
          if value.isMissing, let unexpectedIdentifier = self.consume(if: TokenSpec(.identifier, allowAtStartOfLine: false)) {
            unexpectedAfterFlag = RawUnexpectedNodesSyntax([unexpectedIdentifier], arena: self.arena)
          } else {
            unexpectedAfterFlag = nil
          }
          elements.append(
            .precedenceGroupAssignment(
              RawPrecedenceGroupAssignmentSyntax(
                assignmentLabel: assignmentKeyword,
                unexpectedBeforeColon,
                colon: colon,
                unexpectedBeforeValue,
                value: value,
                unexpectedAfterFlag,
                arena: self.arena
              )
            )
          )
        case (.higherThan, let handle)?,
          (.lowerThan, let handle)?:
          // "lowerThan" and "higherThan" are contextual keywords.
          let level = self.eat(handle)
          let (unexpectedBeforeColon, colon) = self.expect(.colon)
          var names = [RawPrecedenceGroupNameSyntax]()
          do {
            var keepGoing: RawTokenSyntax? = nil
            var namesProgress = LoopProgressCondition()
            repeat {
              let (unexpectedBeforeName, name) = self.expectIdentifier()
              keepGoing = self.consume(if: .comma)
              names.append(
                RawPrecedenceGroupNameSyntax(
                  unexpectedBeforeName,
                  name: name,
                  trailingComma: keepGoing,
                  arena: self.arena
                )
              )
            } while keepGoing != nil && self.hasProgressed(&namesProgress)
          }
          elements.append(
            .precedenceGroupRelation(
              RawPrecedenceGroupRelationSyntax(
                higherThanOrLowerThanLabel: level,
                unexpectedBeforeColon,
                colon: colon,
                precedenceGroups: RawPrecedenceGroupNameListSyntax(elements: names, arena: self.arena),
                arena: self.arena
              )
            )
          )
        case nil:
          break LOOP
        }
      }
    }
    return RawPrecedenceGroupAttributeListSyntax(elements: elements, arena: self.arena)
  }
}

extension Parser {
  /// Parse a macro declaration.
  mutating func parseMacroDeclaration(
    attrs: DeclAttributes,
    introducerHandle: RecoveryConsumptionHandle
  ) -> RawMacroDeclSyntax {
    let (unexpectedBeforeIntroducerKeyword, introducerKeyword) = self.eat(introducerHandle)
    let (unexpectedBeforeName, name) = self.expectIdentifier(keywordRecovery: true)

    // Optional generic parameters.
    let genericParams: RawGenericParameterClauseSyntax?
    if self.at(prefix: "<") {
      genericParams = self.parseGenericParameters()
    } else {
      genericParams = nil
    }

    // Macro signature, which is either value-like or function-like.
    let signature = self.parseFunctionSignature()

    // Initializer, if any.
    let definition: RawInitializerClauseSyntax?
    if let equal = self.consume(if: .equal) {
      let expr = self.parseExpression(flavor: .basic, pattern: .none)
      definition = RawInitializerClauseSyntax(
        equal: equal,
        value: expr,
        arena: self.arena
      )
    } else {
      definition = nil
    }

    // Parse a 'where' clause if present.
    let whereClause: RawGenericWhereClauseSyntax?
    if self.at(.keyword(.where)) {
      whereClause = self.parseGenericWhereClause()
    } else {
      whereClause = nil
    }

    return RawMacroDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeIntroducerKeyword,
      macroKeyword: introducerKeyword,
      unexpectedBeforeName,
      name: name,
      genericParameterClause: genericParams,
      signature: signature,
      definition: definition,
      genericWhereClause: whereClause,
      arena: self.arena
    )
  }

  /// Parse a macro expansion as a declaration.
  mutating func parseMacroExpansionDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawMacroExpansionDeclSyntax {

    var (unexpectedBeforePound, pound) = self.eat(handle)
    if pound.trailingTriviaByteLength > 0 || currentToken.leadingTriviaByteLength > 0 {
      // If there are whitespaces after '#' diagnose.
      let diagnostic = TokenDiagnostic(
        .extraneousTrailingWhitespaceError,
        byteOffset: pound.leadingTriviaByteLength + pound.tokenText.count
      )
      pound = pound.tokenView.withTokenDiagnostic(tokenDiagnostic: diagnostic, arena: self.arena)
    }
    let unexpectedBeforeMacro: RawUnexpectedNodesSyntax?
    let macro: RawTokenSyntax
    if !self.atStartOfLine {
      (unexpectedBeforeMacro, macro) = self.expectIdentifier(allowKeywordsAsIdentifier: true)
    } else {
      unexpectedBeforeMacro = nil
      macro = self.missingToken(.identifier)
    }

    // Parse the optional generic argument list.
    let generics: RawGenericArgumentClauseSyntax?
    if self.withLookahead({ $0.canParseAsGenericArgumentList() }) {
      generics = self.parseGenericArguments()
    } else {
      generics = nil
    }

    // Parse the optional parenthesized argument list.
    let leftParen = self.consume(if: TokenSpec(.leftParen, allowAtStartOfLine: false))
    let args: [RawLabeledExprSyntax]
    let unexpectedBeforeRightParen: RawUnexpectedNodesSyntax?
    let rightParen: RawTokenSyntax?
    if leftParen != nil {
      args = parseArgumentListElements(pattern: .none)
      (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
    } else {
      args = []
      unexpectedBeforeRightParen = nil
      rightParen = nil
    }

    // Parse the optional trailing closures.
    let trailingClosure: RawClosureExprSyntax?
    let additionalTrailingClosures: RawMultipleTrailingClosureElementListSyntax
    if self.at(.leftBrace),
      self.withLookahead({ $0.atValidTrailingClosure(flavor: .basic) })
    {
      (trailingClosure, additionalTrailingClosures) =
        self.parseTrailingClosures(flavor: .basic)
    } else {
      trailingClosure = nil
      additionalTrailingClosures = self.emptyCollection(RawMultipleTrailingClosureElementListSyntax.self)
    }

    return RawMacroExpansionDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforePound,
      pound: pound,
      unexpectedBeforeMacro,
      macroName: macro,
      genericArgumentClause: generics,
      leftParen: leftParen,
      arguments: RawLabeledExprListSyntax(
        elements: args,
        arena: self.arena
      ),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      trailingClosure: trailingClosure,
      additionalTrailingClosures: additionalTrailingClosures,
      arena: self.arena
    )
  }
}
