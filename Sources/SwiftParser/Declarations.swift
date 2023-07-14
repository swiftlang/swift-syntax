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
      .final, .indirect, .infix, .isolated, .lazy, .mutating, .nonisolated,
      .nonmutating, .optional, .override, .postfix, .prefix, .reasync,
      .required, .rethrows, .static, .weak:
      return false
    case .fileprivate, .internal, .package, .open, .private,
      .public, .unowned:
      return true
    }
  }
}

extension TokenConsumer {
  mutating func atStartOfFreestandingMacroExpansion() -> Bool {
    if !self.at(.pound) {
      return false
    }
    if self.peek().rawTokenKind != .identifier && !self.peek().isLexerClassifiedKeyword {
      return false
    }
    if self.currentToken.trailingTriviaByteLength != 0 || self.peek().leadingTriviaByteLength != 0 {
      return false
    }
    return true
  }

  mutating func atStartOfDeclaration(
    isAtTopLevel: Bool = false,
    allowInitDecl: Bool = true,
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

    var hasModifier = false
    if subparser.currentToken.isLexerClassifiedKeyword || subparser.currentToken.rawTokenKind == .identifier {
      var modifierProgress = LoopProgressCondition()
      while let (modifierKind, handle) = subparser.at(anyIn: DeclarationModifier.self),
        modifierKind != .class,
        modifierProgress.evaluate(subparser.currentToken)
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
      declStartKeyword =
        subparser.canRecoverTo(
          anyIn: DeclarationStart.self,
          overrideRecoveryPrecedence: isAtTopLevel ? nil : .closingBrace
        )?.0
    } else {
      declStartKeyword = subparser.at(anyIn: DeclarationStart.self)?.0
    }
    switch declStartKeyword {
    case .actor:
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
    case .case:
      // When 'case' appears inside a function, it's probably a switch
      // case, not an enum case declaration.
      return false
    case .`init`:
      return allowInitDecl
    case .macro:
      // macro Foo ...
      return subparser.peek().rawTokenKind == .identifier
    case .pound:
      // Force parsing '#<identifier>' after attributes as a macro expansion decl.
      if hasAttribute || hasModifier {
        return true
      }

      // Otherwise, parse it as a expression.
      // FIXME: C++ parser returns true if this is a top-level non-"script" files.
      // But we don't have "is library" flag.
      return false
    case .some(_):
      // All other decl start keywords unconditonally start a decl.
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
    var attributes: RawAttributeListSyntax?
    var modifiers: RawModifierListSyntax?

    init(attributes: RawAttributeListSyntax?, modifiers: RawModifierListSyntax?) {
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
  ///     declaration → macro-declaration
  ///
  ///     declarations → declaration declarations?
  ///
  /// If `inMemberDeclList` is `true`, we know that the next item must be a
  /// declaration and thus start with a keyword. This allows futher recovery.
  mutating func parseDeclaration(inMemberDeclList: Bool = false) -> RawDeclSyntax {
    switch self.at(anyIn: PoundDeclarationStart.self) {
    case (.poundIfKeyword, _)?:
      if self.withLookahead({ $0.consumeIfConfigOfAttributes() }) {
        // If we are at a `#if` of attributes, the `#if` directive should be
        // parsed when we're parsing the attributes.
        break
      }
      let directive = self.parsePoundIfDirective { (parser, _) in
        let parsedDecl = parser.parseDeclaration()
        let semicolon = parser.consume(if: .semicolon)
        return RawMemberDeclListItemSyntax(
          decl: parsedDecl,
          semicolon: semicolon,
          arena: parser.arena
        )
      } addSemicolonIfNeeded: { lastElement, newItemAtStartOfLine, parser in
        if lastElement.semicolon == nil && !newItemAtStartOfLine {
          return RawMemberDeclListItemSyntax(
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
        return .decls(RawMemberDeclListSyntax(elements: elements, arena: parser.arena))
      }
      return RawDeclSyntax(directive)
    case nil:
      break
    }

    let attrs = DeclAttributes(
      attributes: self.parseAttributeList(),
      modifiers: self.parseModifierList()
    )

    // If we are inside a memberDecl list, we don't want to eat closing braces (which most likely close the outer context)
    // while recoverying to the declaration start.
    let recoveryPrecedence = inMemberDeclList ? TokenPrecedence.closingBrace : nil

    switch self.canRecoverTo(anyIn: DeclarationStart.self, overrideRecoveryPrecedence: recoveryPrecedence) {
    case (.import, let handle)?:
      return RawDeclSyntax(self.parseImportDeclaration(attrs, handle))
    case (.class, let handle)?:
      return RawDeclSyntax(self.parseNominalTypeDeclaration(for: RawClassDeclSyntax.self, attrs: attrs, introucerHandle: handle))
    case (.enum, let handle)?:
      return RawDeclSyntax(self.parseNominalTypeDeclaration(for: RawEnumDeclSyntax.self, attrs: attrs, introucerHandle: handle))
    case (.case, let handle)?:
      return RawDeclSyntax(self.parseEnumCaseDeclaration(attrs, handle))
    case (.struct, let handle)?:
      return RawDeclSyntax(self.parseNominalTypeDeclaration(for: RawStructDeclSyntax.self, attrs: attrs, introucerHandle: handle))
    case (.protocol, let handle)?:
      return RawDeclSyntax(self.parseNominalTypeDeclaration(for: RawProtocolDeclSyntax.self, attrs: attrs, introucerHandle: handle))
    case (.associatedtype, let handle)?:
      return RawDeclSyntax(self.parseAssociatedTypeDeclaration(attrs, handle))
    case (.typealias, let handle)?:
      return RawDeclSyntax(self.parseTypealiasDeclaration(attrs, handle))
    case (.extension, let handle)?:
      return RawDeclSyntax(self.parseExtensionDeclaration(attrs, handle))
    case (.func, let handle)?:
      return RawDeclSyntax(self.parseFuncDeclaration(attrs, handle))
    case (.subscript, let handle)?:
      return RawDeclSyntax(self.parseSubscriptDeclaration(attrs, handle))
    case (.let, let handle)?, (.var, let handle)?,
      (.inout, let handle)?:
      return RawDeclSyntax(self.parseBindingDeclaration(attrs, handle, inMemberDeclList: inMemberDeclList))
    case (.`init`, let handle)?:
      return RawDeclSyntax(self.parseInitializerDeclaration(attrs, handle))
    case (.deinit, let handle)?:
      return RawDeclSyntax(self.parseDeinitializerDeclaration(attrs, handle))
    case (.operator, let handle)?:
      return RawDeclSyntax(self.parseOperatorDeclaration(attrs, handle))
    case (.precedencegroup, let handle)?:
      return RawDeclSyntax(self.parsePrecedenceGroupDeclaration(attrs, handle))
    case (.actor, let handle)?:
      return RawDeclSyntax(self.parseNominalTypeDeclaration(for: RawActorDeclSyntax.self, attrs: attrs, introucerHandle: handle))
    case (.macro, let handle)?:
      return RawDeclSyntax(self.parseMacroDeclaration(attrs: attrs, introducerHandle: handle))
    case (.pound, let handle)?:
      return RawDeclSyntax(self.parseMacroExpansionDeclaration(attrs, handle))
    case nil:
      if inMemberDeclList {
        let isProbablyVarDecl = self.at(.identifier, .wildcard) && self.peek().rawTokenKind.is(.colon, .equal, .comma)
        let isProbablyTupleDecl = self.at(.leftParen) && self.peek().rawTokenKind.is(.identifier, .wildcard)

        if isProbablyVarDecl || isProbablyTupleDecl {
          return RawDeclSyntax(self.parseBindingDeclaration(attrs, .missing(.keyword(.var))))
        }

        if self.currentToken.isEditorPlaceholder {
          let placeholder = self.consumeAnyToken()
          return RawDeclSyntax(
            RawEditorPlaceholderDeclSyntax(
              attributes: attrs.attributes,
              modifiers: attrs.modifiers,
              placeholder: placeholder,
              arena: self.arena
            )
          )
        }

        let isProbablyFuncDecl = self.at(.identifier, .wildcard) || self.at(anyIn: Operator.self) != nil

        if isProbablyFuncDecl {
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
  mutating func parseImportDeclaration(
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
      arena: self.arena
    )
  }

  mutating func parseImportKind() -> RawTokenSyntax? {
    enum ImportKind: TokenSpecSet {
      case `typealias`
      case `struct`
      case `class`
      case `enum`
      case `protocol`
      case `var`
      case `let`
      case `func`
      case `inout`

      var spec: TokenSpec {
        switch self {
        case .typealias: return .keyword(.typealias)
        case .struct: return .keyword(.struct)
        case .class: return .keyword(.class)
        case .enum: return .keyword(.enum)
        case .protocol: return .keyword(.protocol)
        case .var: return .keyword(.var)
        case .let: return .keyword(.let)
        case .func: return .keyword(.func)
        case .inout: return .keyword(.inout)
        }
      }

      init?(lexeme: Lexer.Lexeme) {
        switch PrepareForKeywordMatch(lexeme) {
        case TokenSpec(.typealias): self = .typealias
        case TokenSpec(.struct): self = .struct
        case TokenSpec(.class): self = .class
        case TokenSpec(.enum): self = .enum
        case TokenSpec(.protocol): self = .protocol
        case TokenSpec(.var): self = .var
        case TokenSpec(.let): self = .let
        case TokenSpec(.func): self = .func
        case TokenSpec(.inout): self = .inout
        default: return nil
        }
      }
    }

    return self.consume(ifAnyIn: ImportKind.self)
  }

  mutating func parseImportAccessPath() -> RawAccessPathSyntax {
    var elements = [RawAccessPathComponentSyntax]()
    var keepGoing: RawTokenSyntax? = nil
    var loopProgress = LoopProgressCondition()
    repeat {
      let name = self.parseAnyIdentifier()
      keepGoing = self.consume(if: .period)
      elements.append(
        RawAccessPathComponentSyntax(
          name: name,
          trailingDot: keepGoing,
          arena: self.arena
        )
      )
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
  mutating func parseExtensionDeclaration(
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
    if self.at(.keyword(.where)) {
      whereClause = self.parseGenericWhereClause()
    } else {
      whereClause = nil
    }
    let memberBlock = self.parseMemberDeclList(introducer: extensionKeyword)
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
  /// Attempt to consume an ellipsis prefix, splitting the current token if
  /// necessary.
  mutating func tryConsumeEllipsisPrefix() -> RawTokenSyntax? {
    // It is not sufficient to check currentToken.isEllipsis here, as we may
    // have something like '...>'.
    // TODO: Recovery for different numbers of dots (which also needs to be
    // done for regular variadics).
    guard self.at(anyIn: Operator.self) != nil else { return nil }
    let text = self.currentToken.tokenText
    guard text.hasPrefix("...") else { return nil }
    return self.consumePrefix(
      SyntaxText(rebasing: text.prefix(3)),
      as: .ellipsis
    )
  }

  mutating func parseGenericParameters() -> RawGenericParameterClauseSyntax {
    if let remainingTokens = remainingTokensIfMaximumNestingLevelReached() {
      return RawGenericParameterClauseSyntax(
        remainingTokens,
        leftAngleBracket: missingToken(.leftAngle),
        genericParameterList: RawGenericParameterListSyntax(elements: [], arena: self.arena),
        genericWhereClause: nil,
        rightAngleBracket: missingToken(.rightAngle),
        arena: self.arena
      )
    }

    let langle: RawTokenSyntax
    if self.currentToken.starts(with: "<") {
      langle = self.consumePrefix("<", as: .leftAngle)
    } else {
      langle = missingToken(.leftAngle)
    }
    var elements = [RawGenericParameterSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      var loopProgress = LoopProgressCondition()
      repeat {
        let attributes = self.parseAttributeList()

        // Parse the 'each' keyword for a type parameter pack 'each T'.
        var each = self.consume(if: .keyword(.each))

        let (unexpectedBetweenEachAndName, name) = self.expectIdentifier(allowSelfOrCapitalSelfAsIdentifier: true)
        if attributes == nil && each == nil && unexpectedBetweenEachAndName == nil && name.isMissing && elements.isEmpty && !self.currentToken.starts(with: ">") {
          break
        }

        // Parse the unsupported ellipsis for a type parameter pack 'T...'.
        let unexpectedBetweenNameAndColon: RawUnexpectedNodesSyntax?
        if let ellipsis = tryConsumeEllipsisPrefix() {
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
              RawSimpleTypeIdentifierSyntax(
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
            each: each,
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
      } while keepGoing != nil && loopProgress.evaluate(currentToken)
    }

    let whereClause: RawGenericWhereClauseSyntax?
    if self.at(.keyword(.where)) {
      whereClause = self.parseGenericWhereClause()
    } else {
      whereClause = nil
    }

    let rangle: RawTokenSyntax
    if self.currentToken.starts(with: ">") {
      rangle = self.consumePrefix(">", as: .rightAngle)
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
      arena: self.arena
    )
  }

  enum LayoutConstraint: TokenSpecSet {
    case _Trivial
    case _TrivialAtMost
    case _UnknownLayout
    case _RefCountedObjectLayout
    case _NativeRefCountedObjectLayout
    case _Class
    case _NativeClass

    init?(lexeme: Lexer.Lexeme) {
      switch PrepareForKeywordMatch(lexeme) {
      case TokenSpec(._Trivial): self = ._Trivial
      case TokenSpec(._TrivialAtMost): self = ._TrivialAtMost
      case TokenSpec(._UnknownLayout): self = ._UnknownLayout
      case TokenSpec(._RefCountedObject): self = ._RefCountedObjectLayout
      case TokenSpec(._NativeRefCountedObject): self = ._NativeRefCountedObjectLayout
      case TokenSpec(._Class): self = ._Class
      case TokenSpec(._NativeClass): self = ._NativeClass
      default: return nil
      }
    }

    var spec: TokenSpec {
      switch self {
      case ._Trivial: return .keyword(._Trivial)
      case ._TrivialAtMost: return .keyword(._TrivialAtMost)
      case ._UnknownLayout: return .keyword(._UnknownLayout)
      case ._RefCountedObjectLayout: return .keyword(._RefCountedObject)
      case ._NativeRefCountedObjectLayout: return .keyword(._NativeRefCountedObject)
      case ._Class: return .keyword(._Class)
      case ._NativeClass: return .keyword(._NativeClass)
      }
    }

    var hasArguments: Bool {
      switch self {
      case ._Trivial,
        ._TrivialAtMost:
        return true

      case ._UnknownLayout,
        ._RefCountedObjectLayout,
        ._NativeRefCountedObjectLayout,
        ._Class,
        ._NativeClass:
        return false
      }
    }
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
              body: .sameTypeRequirement(
                RawSameTypeRequirementSyntax(
                  leftTypeIdentifier: RawTypeSyntax(RawMissingTypeSyntax(arena: self.arena)),
                  equalityToken: missingToken(.binaryOperator, text: "=="),
                  rightTypeIdentifier: RawTypeSyntax(RawMissingTypeSyntax(arena: self.arena)),
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

          init?(lexeme: Lexer.Lexeme) {
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

        let requirement: RawGenericRequirementSyntax.Body
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
            if layoutConstraint.hasArguments && (layoutConstraint != ._Trivial || self.at(.leftParen)) {
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
                arena: self.arena
              )
            )
          } else {
            // Parse the protocol or composition.
            let secondType = self.parseType()
            requirement = .conformanceRequirement(
              RawConformanceRequirementSyntax(
                leftTypeIdentifier: firstType,
                colon: colon,
                rightTypeIdentifier: secondType,
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
              leftTypeIdentifier: firstType,
              equalityToken: equal,
              rightTypeIdentifier: secondType,
              arena: self.arena
            )
          )
        case nil:
          requirement = .sameTypeRequirement(
            RawSameTypeRequirementSyntax(
              leftTypeIdentifier: firstType,
              equalityToken: RawTokenSyntax(missing: .binaryOperator, text: "==", arena: self.arena),
              rightTypeIdentifier: RawTypeSyntax(RawMissingTypeSyntax(arena: self.arena)),
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
            body: requirement,
            unexpectedBetweenBodyAndTrailingComma,
            trailingComma: keepGoing,
            arena: self.arena
          )
        )
      } while keepGoing != nil && loopProgress.evaluate(currentToken)
    }

    return RawGenericWhereClauseSyntax(
      unexpectedBeforeWhereKeyword,
      whereKeyword: whereKeyword,
      requirementList: RawGenericRequirementListSyntax(elements: elements, arena: self.arena),
      arena: self.arena
    )
  }
}

extension Parser {
  mutating func parseMemberDeclListItem() -> RawMemberDeclListItemSyntax? {
    if let remainingTokens = remainingTokensIfMaximumNestingLevelReached() {
      let item = RawMemberDeclListItemSyntax(
        remainingTokens,
        decl: RawDeclSyntax(RawMissingDeclSyntax(attributes: nil, modifiers: nil, arena: self.arena)),
        semicolon: nil,
        arena: self.arena
      )
      return item
    }

    let decl: RawDeclSyntax
    if self.at(.poundSourceLocationKeyword) {
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

    return RawMemberDeclListItemSyntax(
      decl: decl,
      semicolon: semi,
      RawUnexpectedNodesSyntax(trailingSemis, arena: self.arena),
      arena: self.arena
    )
  }

  /// `introducer` is the `struct`, `class`, ... keyword that is the cause that the member decl block is being parsed.
  /// If the left brace is missing, its indentation will be used to judge whether a following `}` was
  /// indented to close this code block or a surrounding context. See `expectRightBrace`.
  mutating func parseMemberDeclList(introducer: RawTokenSyntax? = nil) -> RawMemberDeclBlockSyntax {
    var elements = [RawMemberDeclListItemSyntax]()
    let (unexpectedBeforeLBrace, lbrace) = self.expect(.leftBrace)
    do {
      var loopProgress = LoopProgressCondition()
      while !self.at(.eof, .rightBrace) && loopProgress.evaluate(currentToken) {
        let newItemAtStartOfLine = self.currentToken.isAtStartOfLine
        guard let newElement = self.parseMemberDeclListItem() else {
          break
        }
        if let lastItem = elements.last, lastItem.semicolon == nil && !newItemAtStartOfLine {
          elements[elements.count - 1] = RawMemberDeclListItemSyntax(
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
    let (unexpectedBeforeRBrace, rbrace) = self.expectRightBrace(leftBrace: lbrace, introducer: introducer)
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
      arena: self.arena
    )
  }
}

extension Parser {
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

        let associatedValue: RawEnumCaseParameterClauseSyntax?
        if self.at(TokenSpec(.leftParen, allowAtStartOfLine: false)) {
          associatedValue = self.parseParameterClause(RawEnumCaseParameterClauseSyntax.self) { parser in
            parser.parseEnumCaseParameter()
          }
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
        elements.append(
          RawEnumCaseElementSyntax(
            RawUnexpectedNodesSyntax(combining: unexpectedPeriod, unexpectedBeforeName, arena: self.arena),
            identifier: name,
            associatedValue: associatedValue,
            rawValue: rawValue,
            trailingComma: keepGoing,
            arena: self.arena
          )
        )
      } while keepGoing != nil && loopProgress.evaluate(currentToken)
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
  ///
  /// Grammar
  /// =======
  ///
  ///     protocol-associated-type-declaration → attributes? access-level-modifier? 'associatedtype' typealias-name type-inheritance-clause? typealias-assignment? generic-where-clause?
  mutating func parseAssociatedTypeDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawAssociatedtypeDeclSyntax {
    let (unexpectedBeforeAssocKeyword, assocKeyword) = self.eat(handle)

    // Detect an attempt to use a type parameter pack.
    let eachKeyword = self.consume(if: .keyword(.each))

    var (unexpectedBeforeName, name) = self.expectIdentifier(keywordRecovery: true)
    if eachKeyword != nil {
      unexpectedBeforeName = RawUnexpectedNodesSyntax(combining: eachKeyword, unexpectedBeforeName, arena: self.arena)
    }

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
        arena: self.arena
      )
    }

    // Detect an attempt to use (early syntax) type parameter pack.
    let ellipsis = tryConsumeEllipsisPrefix()

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
    if self.at(.keyword(.where)) {
      whereClause = self.parseGenericWhereClause()
    } else {
      whereClause = nil
    }

    return RawAssociatedtypeDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeAssocKeyword,
      associatedtypeKeyword: assocKeyword,
      unexpectedBeforeName,
      identifier: name,
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
  mutating func parseInitializerDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawInitializerDeclSyntax {
    let (unexpectedBeforeInitKeyword, initKeyword) = self.eat(handle)

    // Parse the '!' or '?' for a failable initializer.
    let failable: RawTokenSyntax?
    if let parsedFailable = self.consume(if: .exclamationMark, .postfixQuestionMark, .infixQuestionMark) {
      failable = parsedFailable
    } else if let parsedFailable = self.consumeIfContextualPunctuator("!", remapping: .exclamationMark) {
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
  ///
  /// Grammar
  /// =======
  ///
  /// deinitializer-declaration → attributes? 'deinit' code-block
  mutating func parseDeinitializerDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawDeinitializerDeclSyntax {
    let (unexpectedBeforeDeinitKeyword, deinitKeyword) = self.eat(handle)
    var unexpectedNameAndSignature: [RawSyntax?] = []
    unexpectedNameAndSignature.append(self.consume(if: TokenSpec(.identifier, allowAtStartOfLine: false)).map(RawSyntax.init))
    if self.at(.leftParen) && !self.currentToken.isAtStartOfLine {
      unexpectedNameAndSignature.append(RawSyntax(parseFunctionSignature()))
    }
    let items = self.parseOptionalCodeBlock()
    return RawDeinitializerDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeDeinitKeyword,
      deinitKeyword: deinitKeyword,
      RawUnexpectedNodesSyntax(unexpectedNameAndSignature, arena: self.arena),
      body: items,
      arena: self.arena
    )
  }
}

extension Parser {
  /// If a `throws` keyword appears right in front of the `arrow`, it is returned as `misplacedThrowsKeyword` so it can be synthesized in front of the arrow.
  mutating func parseFunctionReturnClause<S: RawEffectSpecifiersTrait>(effectSpecifiers: inout S?, allowNamedOpaqueResultType: Bool) -> RawReturnClauseSyntax {
    let (unexpectedBeforeArrow, arrow) = self.expect(.arrow)
    let unexpectedBeforeReturnType = self.parseMisplacedEffectSpecifiers(&effectSpecifiers)
    let result: RawTypeSyntax
    if allowNamedOpaqueResultType {
      result = self.parseResultType()
    } else {
      result = self.parseType()
    }
    let unexpectedAfterReturnType = self.parseMisplacedEffectSpecifiers(&effectSpecifiers)
    let returnClause = RawReturnClauseSyntax(
      unexpectedBeforeArrow,
      arrow: arrow,
      unexpectedBeforeReturnType,
      returnType: result,
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
    let identifier: RawTokenSyntax
    if self.at(anyIn: Operator.self) != nil || self.at(.exclamationMark, .prefixAmpersand) {
      var name = self.currentToken.tokenText
      if name.count > 1 && name.hasSuffix("<") && self.peek().rawTokenKind == .identifier {
        name = SyntaxText(rebasing: name.dropLast())
      }
      unexpectedBeforeIdentifier = nil
      identifier = self.consumePrefix(name, as: .binaryOperator)
    } else {
      (unexpectedBeforeIdentifier, identifier) = self.expectIdentifier(keywordRecovery: true)
    }

    let genericParams: RawGenericParameterClauseSyntax?
    if self.currentToken.starts(with: "<") {
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
      identifier: identifier,
      genericParameterClause: genericParams,
      signature: signature,
      genericWhereClause: generics,
      body: body,
      arena: self.arena
    )
  }

  mutating func parseFunctionSignature(allowOutput: Bool = true) -> RawFunctionSignatureSyntax {
    let input = self.parseParameterClause(RawParameterClauseSyntax.self) { parser in
      parser.parseFunctionParameter()
    }

    var effectSpecifiers = self.parseFunctionEffectSpecifiers()

    var output: RawReturnClauseSyntax?

    /// Only allow recovery to the arrow with exprKeyword precedence so we only
    /// skip over misplaced identifiers and don't e.g. recover to an arrow in a 'where' clause.
    if self.at(.arrow) || self.canRecoverTo(TokenSpec(.arrow, recoveryPrecedence: .exprKeyword)) != nil {
      output = self.parseFunctionReturnClause(effectSpecifiers: &effectSpecifiers, allowNamedOpaqueResultType: true)
    } else {
      output = nil
    }

    var unexpectedAfterOutput: RawUnexpectedNodesSyntax?
    if !allowOutput,
      let unexpectedOutput = output
    {
      output = nil
      unexpectedAfterOutput = RawUnexpectedNodesSyntax([unexpectedOutput], arena: self.arena)
    }

    return RawFunctionSignatureSyntax(
      input: input,
      effectSpecifiers: effectSpecifiers,
      output: output,
      unexpectedAfterOutput,
      arena: self.arena
    )
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
  mutating func parseSubscriptDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawSubscriptDeclSyntax {
    let (unexpectedBeforeSubscriptKeyword, subscriptKeyword) = self.eat(handle)

    let unexpectedName: RawTokenSyntax?
    if self.at(.identifier) && self.peek().starts(with: "<") || self.peek().rawTokenKind == .leftParen {
      unexpectedName = self.consumeAnyToken()
    } else {
      unexpectedName = nil
    }

    let genericParameterClause: RawGenericParameterClauseSyntax?
    if self.currentToken.starts(with: "<") {
      genericParameterClause = self.parseGenericParameters()
    } else {
      genericParameterClause = nil
    }

    let indices = self.parseParameterClause(RawParameterClauseSyntax.self) { parser in
      parser.parseFunctionParameter()
    }

    var misplacedEffectSpecifiers: RawFunctionEffectSpecifiersSyntax?
    let result = self.parseFunctionReturnClause(effectSpecifiers: &misplacedEffectSpecifiers, allowNamedOpaqueResultType: true)

    // Parse a 'where' clause if present.
    let genericWhereClause: RawGenericWhereClauseSyntax?
    if self.at(.keyword(.where)) {
      genericWhereClause = self.parseGenericWhereClause()
    } else {
      genericWhereClause = nil
    }

    // Parse getter and setter.
    let accessor: RawSubscriptDeclSyntax.Accessor?
    if self.at(.leftBrace) || self.at(anyIn: AccessorKind.self) != nil {
      accessor = self.parseGetSet()
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
      indices: indices,
      result: result,
      genericWhereClause: genericWhereClause,
      accessor: accessor,
      arena: self.arena
    )
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
          var value = self.parseExpression()
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
        } else if self.at(.leftParen), !self.currentToken.isAtStartOfLine,
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
            .basic,
            forDirective: false,
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
        } else {
          initializer = nil
        }

        let accessor: RawPatternBindingSyntax.Accessor?
        if self.at(.leftBrace) || (inMemberDeclList && self.at(anyIn: AccessorKind.self) != nil && !self.at(.keyword(.`init`))) {
          switch self.parseGetSet() {
          case .accessors(let accessors):
            accessor = .accessors(accessors)
          case .getter(let getter):
            accessor = .getter(getter)
          }
        } else {
          accessor = nil
        }

        keepGoing = self.consume(if: .comma)
        elements.append(
          RawPatternBindingSyntax(
            pattern: pattern,
            typeAnnotation: typeAnnotation,
            initializer: initializer,
            accessor: accessor,
            trailingComma: keepGoing,
            arena: self.arena
          )
        )
      } while keepGoing != nil && loopProgress.evaluate(currentToken)
    }

    return RawVariableDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeIntroducer,
      bindingKeyword: introducer,
      bindings: RawPatternBindingListSyntax(elements: elements, arena: self.arena),
      arena: self.arena
    )
  }

  struct AccessorIntroducer {
    var attributes: RawAttributeListSyntax?
    var modifier: RawDeclModifierSyntax?
    var kind: AccessorKind
    var unexpectedBeforeToken: RawUnexpectedNodesSyntax?
    var token: RawTokenSyntax
  }

  mutating func parseAccessorIntroducer(
    forcedKind: (AccessorKind, TokenConsumptionHandle)? = nil
  ) -> AccessorIntroducer? {
    // Check there is an identifier before consuming
    var look = self.lookahead()
    let _ = look.consumeAttributeList()
    let hasModifier = look.consume(ifAnyIn: AccessorModifier.self) != nil
    guard let (kind, _) = look.at(anyIn: AccessorKind.self) ?? forcedKind else {
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
  ///
  /// Grammar
  /// =======
  ///
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
  private mutating func parseAccessorDecl(
    introducer: AccessorIntroducer
  ) -> RawAccessorDeclSyntax {
    // 'set' and 'willSet' can have an optional name.  This isn't valid in a
    // protocol, but we parse and then reject it for better QoI.
    //
    //     set-name    ::= '(' identifier ')'
    let parameter: RawAccessorParameterSyntax?
    if [AccessorKind.set, .willSet, .didSet, .`init`].contains(introducer.kind), let lparen = self.consume(if: .leftParen) {
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

    let effectSpecifiers = self.parseAccessorEffectSpecifiers()
    let initEffects = self.parseInitAccessorEffects()

    let body = self.parseOptionalCodeBlock()
    return RawAccessorDeclSyntax(
      attributes: introducer.attributes,
      modifier: introducer.modifier,
      introducer.unexpectedBeforeToken,
      accessorKind: introducer.token,
      parameter: parameter,
      effectSpecifiers: effectSpecifiers,
      initEffects: initEffects,
      body: body,
      arena: self.arena
    )
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
  mutating func parseGetSet() -> RawSubscriptDeclSyntax.Accessor {
    // Parse getter and setter.
    let unexpectedBeforeLBrace: RawUnexpectedNodesSyntax?
    let lbrace: RawTokenSyntax
    if self.at(anyIn: AccessorKind.self) != nil {
      unexpectedBeforeLBrace = nil
      lbrace = missingToken(.leftBrace)
    } else {
      (unexpectedBeforeLBrace, lbrace) = self.expect(.leftBrace)
    }
    // Collect all explicit accessors to a list.
    var elements = [RawAccessorDeclSyntax]()
    do {
      var loopProgress = LoopProgressCondition()
      while !self.at(.eof, .rightBrace) && loopProgress.evaluate(currentToken) {
        guard let introducer = self.parseAccessorIntroducer() else {
          // There can only be an implicit getter if no other accessors were
          // seen before this one.
          guard elements.isEmpty else {
            let (unexpectedBeforeRBrace, rbrace) = self.expect(.rightBrace)
            return .accessors(
              RawAccessorBlockSyntax(
                unexpectedBeforeLBrace,
                leftBrace: lbrace,
                accessors: RawAccessorListSyntax(elements: elements, arena: self.arena),
                unexpectedBeforeRBrace,
                rightBrace: rbrace,
                arena: self.arena
              )
            )
          }

          let body = parseCodeBlockItemList(until: { $0.at(.rightBrace) })

          let (unexpectedBeforeRBrace, rbrace) = self.expect(.rightBrace)
          return .getter(
            RawCodeBlockSyntax(
              unexpectedBeforeLBrace,
              leftBrace: lbrace,
              statements: body,
              unexpectedBeforeRBrace,
              rightBrace: rbrace,
              arena: self.arena
            )
          )
        }

        elements.append(parseAccessorDecl(introducer: introducer))
      }
    }

    let (unexpectedBeforeRBrace, rbrace) = self.expect(.rightBrace)
    return .accessors(
      RawAccessorBlockSyntax(
        unexpectedBeforeLBrace,
        leftBrace: lbrace,
        accessors: RawAccessorListSyntax(elements: elements, arena: self.arena),
        unexpectedBeforeRBrace,
        rightBrace: rbrace,
        arena: self.arena
      )
    )
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
  mutating func parseTypealiasDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawTypealiasDeclSyntax {
    let (unexpectedBeforeTypealiasKeyword, typealiasKeyword) = self.eat(handle)
    let (unexpectedBeforeName, name) = self.expectIdentifier(keywordRecovery: true)

    // Parse a generic parameter list if it is present.
    let generics: RawGenericParameterClauseSyntax?
    if self.currentToken.starts(with: "<") {
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
      arena: self.arena
    )
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
  mutating func parseOperatorDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawOperatorDeclSyntax {
    let (unexpectedBeforeOperatorKeyword, operatorKeyword) = self.eat(handle)
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
      !self.at(.colon, .leftBrace, .eof),
      loopProgress.evaluate(self.currentToken)
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
      var types = [RawDesignatedTypeElementSyntax]()
      while let comma = self.consume(if: .comma) {
        // FIXME: The compiler accepts... anything here. This is a bug.
        // let (unexpectedBeforeDesignatedType, designatedType) = self.expectIdentifier()
        let designatedType = self.consumeAnyToken()
        types.append(
          RawDesignatedTypeElementSyntax(
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
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeOperatorKeyword,
      operatorKeyword: operatorKeyword,
      unexpectedBeforeName,
      identifier: name,
      RawUnexpectedNodesSyntax(identifiersAfterOperatorName, arena: self.arena),
      operatorPrecedenceAndTypes: precedenceAndTypes,
      unexpectedAtEnd,
      arena: self.arena
    )
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
  mutating func parsePrecedenceGroupDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawPrecedenceGroupDeclSyntax {
    let (unexpectedBeforeGroup, group) = self.eat(handle)
    let (unexpectedBeforeIdentifier, identifier) = self.expectIdentifier(allowSelfOrCapitalSelfAsIdentifier: true)
    let (unexpectedBeforeLBrace, lbrace) = self.expect(.leftBrace)

    let groupAttributes = self.parsePrecedenceGroupAttributeListSyntax()

    let (unexpectedBeforeRBrace, rbrace) = self.expect(.rightBrace)
    return RawPrecedenceGroupDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforeGroup,
      precedencegroupKeyword: group,
      unexpectedBeforeIdentifier,
      identifier: identifier,
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

      init?(lexeme: Lexer.Lexeme) {
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
      LOOP: while !self.at(.eof, .rightBrace) && attributesProgress.evaluate(currentToken) {
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
                associativityKeyword: associativity,
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
          let (unexpectedBeforeFlag, flag) = self.expect(.keyword(.true), .keyword(.false), default: .keyword(.true))
          let unexpectedAfterFlag: RawUnexpectedNodesSyntax?
          if flag.isMissing, let unexpectedIdentifier = self.consume(if: TokenSpec(.identifier, allowAtStartOfLine: false)) {
            unexpectedAfterFlag = RawUnexpectedNodesSyntax([unexpectedIdentifier], arena: self.arena)
          } else {
            unexpectedAfterFlag = nil
          }
          elements.append(
            .precedenceGroupAssignment(
              RawPrecedenceGroupAssignmentSyntax(
                assignmentKeyword: assignmentKeyword,
                unexpectedBeforeColon,
                colon: colon,
                unexpectedBeforeFlag,
                flag: flag,
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
          var names = [RawPrecedenceGroupNameElementSyntax]()
          do {
            var keepGoing: RawTokenSyntax? = nil
            var namesProgress = LoopProgressCondition()
            repeat {
              let (unexpectedBeforeName, name) = self.expectIdentifier()
              keepGoing = self.consume(if: .comma)
              names.append(
                RawPrecedenceGroupNameElementSyntax(
                  unexpectedBeforeName,
                  name: name,
                  trailingComma: keepGoing,
                  arena: self.arena
                )
              )
            } while keepGoing != nil && namesProgress.evaluate(currentToken)
          }
          elements.append(
            .precedenceGroupRelation(
              RawPrecedenceGroupRelationSyntax(
                higherThanOrLowerThan: level,
                unexpectedBeforeColon,
                colon: colon,
                otherNames: RawPrecedenceGroupNameListSyntax(elements: names, arena: self.arena),
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
    if self.currentToken.starts(with: "<") {
      genericParams = self.parseGenericParameters()
    } else {
      genericParams = nil
    }

    // Macro signature, which is either value-like or function-like.
    let signature = self.parseFunctionSignature()

    // Initializer, if any.
    let definition: RawInitializerClauseSyntax?
    if let equal = self.consume(if: .equal) {
      let expr = self.parseExpression()
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
      identifier: name,
      genericParameterClause: genericParams,
      signature: signature,
      definition: definition,
      genericWhereClause: whereClause,
      arena: self.arena
    )
  }

  /// Parse a macro expansion as an declaration.
  ///
  ///
  /// Grammar
  /// =======
  ///
  /// macro-expansion-declaration → '#' identifier expr-call-suffix?
  mutating func parseMacroExpansionDeclaration(
    _ attrs: DeclAttributes,
    _ handle: RecoveryConsumptionHandle
  ) -> RawMacroExpansionDeclSyntax {

    let (unexpectedBeforePound, poundKeyword) = self.eat(handle)
    // Don't allow space between '#' and the macro name.
    if poundKeyword.trailingTriviaByteLength != 0 || self.currentToken.leadingTriviaByteLength != 0 {
      return RawMacroExpansionDeclSyntax(
        attributes: attrs.attributes,
        modifiers: attrs.modifiers,
        unexpectedBeforePound,
        poundToken: poundKeyword,
        macro: self.missingToken(.identifier),
        genericArguments: nil,
        leftParen: nil,
        argumentList: .init(elements: [], arena: self.arena),
        rightParen: nil,
        trailingClosure: nil,
        additionalTrailingClosures: nil,
        arena: self.arena
      )
    }
    let (unexpectedBeforeMacro, macro) = self.expectIdentifier(allowKeywordsAsIdentifier: true)

    // Parse the optional generic argument list.
    let generics: RawGenericArgumentClauseSyntax?
    if self.withLookahead({ $0.canParseAsGenericArgumentList() }) {
      generics = self.parseGenericArguments()
    } else {
      generics = nil
    }

    // Parse the optional parenthesized argument list.
    let leftParen = self.consume(if: TokenSpec(.leftParen, allowAtStartOfLine: false))
    let args: [RawTupleExprElementSyntax]
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
    let additionalTrailingClosures: RawMultipleTrailingClosureElementListSyntax?
    if self.at(.leftBrace),
      self.withLookahead({ $0.isValidTrailingClosure(.trailingClosure) })
    {
      (trailingClosure, additionalTrailingClosures) =
        self.parseTrailingClosures(.trailingClosure)
    } else {
      trailingClosure = nil
      additionalTrailingClosures = nil
    }

    return RawMacroExpansionDeclSyntax(
      attributes: attrs.attributes,
      modifiers: attrs.modifiers,
      unexpectedBeforePound,
      poundToken: poundKeyword,
      unexpectedBeforeMacro,
      macro: macro,
      genericArguments: generics,
      leftParen: leftParen,
      argumentList: RawTupleExprElementListSyntax(
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
