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

// MARK: - Traits

protocol RawParameterTrait: RawSyntaxNodeProtocol {
  var trailingComma: RawTokenSyntax? { get }
}

extension RawFunctionParameterSyntax: RawParameterTrait {}
extension RawClosureParameterSyntax: RawParameterTrait {}
extension RawEnumCaseParameterSyntax: RawParameterTrait {}

protocol RawParameterListTrait: RawSyntaxNodeProtocol {
  associatedtype ParameterSyntax: RawParameterTrait

  init(elements: [ParameterSyntax], arena: __shared SyntaxArena)
}

extension RawFunctionParameterListSyntax: RawParameterListTrait {}
extension RawClosureParameterListSyntax: RawParameterListTrait {}
extension RawEnumCaseParameterListSyntax: RawParameterListTrait {}

protocol RawParameterClauseTrait: RawSyntaxNodeProtocol {
  associatedtype Parameters: RawParameterListTrait

  init(
    _ unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax?,
    leftParen: RawTokenSyntax,
    _ unexpectedBetweenLeftParenAndParameterList: RawUnexpectedNodesSyntax?,
    parameters: Parameters,
    _ unexpectedBetweenParameterListAndRightParen: RawUnexpectedNodesSyntax?,
    rightParen: RawTokenSyntax,
    _ unexpectedAfterRightParen: RawUnexpectedNodesSyntax?,
    arena: __shared SyntaxArena
  )
}

extension RawFunctionParameterClauseSyntax: RawParameterClauseTrait {}
extension RawClosureParameterClauseSyntax: RawParameterClauseTrait {}
extension RawEnumCaseParameterClauseSyntax: RawParameterClauseTrait {}

// MARK: Parameter parsing

extension Parser {
  fileprivate struct ParameterNames {
    let unexpectedBeforeFirstName: RawUnexpectedNodesSyntax?
    let firstName: RawTokenSyntax?
    let unexpectedBeforeSecondName: RawUnexpectedNodesSyntax?
    let secondName: RawTokenSyntax?
  }

  fileprivate mutating func parseParameterNames() -> ParameterNames {
    let unexpectedBeforeFirstName: RawUnexpectedNodesSyntax?
    let firstName: RawTokenSyntax?
    if self.atArgumentLabel(allowDollarIdentifier: true) {
      (unexpectedBeforeFirstName, firstName) = self.parseArgumentLabel()
    } else {
      (unexpectedBeforeFirstName, firstName) = (nil, nil)
    }

    let unexpectedBeforeSecondName: RawUnexpectedNodesSyntax?
    let secondName: RawTokenSyntax?
    if self.atArgumentLabel(allowDollarIdentifier: true) {
      (unexpectedBeforeSecondName, secondName) = self.parseArgumentLabel()
    } else {
      (unexpectedBeforeSecondName, secondName) = (nil, nil)
    }

    return ParameterNames(
      unexpectedBeforeFirstName: unexpectedBeforeFirstName,
      firstName: firstName,
      unexpectedBeforeSecondName: unexpectedBeforeSecondName,
      secondName: secondName
    )
  }

  mutating func parseFunctionParameter() -> RawFunctionParameterSyntax {
    let attrs = self.parseAttributeList()

    let modifiers = parseParameterModifiers(isClosure: false)
    let misplacedSpecifiers = parseMisplacedSpecifiers()

    var names = self.parseParameterNames()
    let (unexpectedBeforeColon, colon) = self.expect(.colon)

    let type: RawTypeSyntax

    if colon.presence == .missing,
      let secondName = names.secondName,
      secondName.tokenKind == .identifier,
      secondName.tokenText.isStartingWithUppercase
    {
      // Synthesize the secondName parameter as a type node.
      type = RawTypeSyntax(
        RawIdentifierTypeSyntax(
          name: secondName,
          genericArgumentClause: nil,
          arena: self.arena
        )
      )
      names = ParameterNames(
        unexpectedBeforeFirstName: names.unexpectedBeforeFirstName,
        firstName: names.firstName,
        unexpectedBeforeSecondName: nil,
        secondName: nil
      )
    } else {
      // Parse the type node as we would normally do.
      type = self.parseType(misplacedSpecifiers: misplacedSpecifiers)
    }

    let ellipsis = self.consumeIfContextualPunctuator("...", remapping: .ellipsis)

    let defaultValue: RawInitializerClauseSyntax?
    if self.at(.equal) || self.atContextualPunctuator("==") {
      defaultValue = self.parseDefaultArgument()
    } else {
      defaultValue = nil
    }

    let trailingComma = self.consume(if: .comma)

    return RawFunctionParameterSyntax(
      attributes: attrs,
      modifiers: modifiers,
      RawUnexpectedNodesSyntax(combining: misplacedSpecifiers, names.unexpectedBeforeFirstName, arena: self.arena),
      firstName: names.firstName ?? missingToken(.identifier),
      names.unexpectedBeforeSecondName,
      secondName: names.secondName,
      unexpectedBeforeColon,
      colon: colon,
      type: type,
      ellipsis: ellipsis,
      defaultValue: defaultValue,
      trailingComma: trailingComma,
      arena: self.arena
    )
  }

  mutating func parseClosureParameter() -> RawClosureParameterSyntax {
    let attributes = self.parseAttributeList()

    let modifiers = parseParameterModifiers(isClosure: true)
    let misplacedSpecifiers = parseMisplacedSpecifiers()

    let names = self.parseParameterNames()
    let colon = self.consume(if: .colon)
    let type: RawTypeSyntax?
    if colon != nil {
      type = self.parseType(misplacedSpecifiers: misplacedSpecifiers)
    } else {
      type = nil
    }

    let ellipsis = self.consumeIfContextualPunctuator("...", remapping: .ellipsis)

    let trailingComma = self.consume(if: .comma)

    return RawClosureParameterSyntax(
      attributes: attributes,
      modifiers: modifiers,
      RawUnexpectedNodesSyntax(combining: misplacedSpecifiers, names.unexpectedBeforeFirstName, arena: self.arena),
      firstName: names.firstName ?? missingToken(.identifier),
      names.unexpectedBeforeSecondName,
      secondName: names.secondName,
      colon: colon,
      type: type,
      ellipsis: ellipsis,
      trailingComma: trailingComma,
      arena: self.arena
    )
  }

  mutating func parseEnumCaseParameter() -> RawEnumCaseParameterSyntax {
    let modifiers = parseParameterModifiers(isClosure: false)
    let misplacedSpecifiers = parseMisplacedSpecifiers()

    let names: ParameterNames
    let unexpectedBeforeColon: RawUnexpectedNodesSyntax?
    let colon: RawTokenSyntax?
    let type: RawTypeSyntax

    if self.withLookahead({ $0.startsParameterName(isClosure: false, allowMisplacedSpecifierRecovery: false) }) {
      names = self.parseParameterNames()

      (unexpectedBeforeColon, colon) = self.expect(.colon)
      if colon!.isMissing {
        // If there was no colon, don't try to parse a type either so we are not
        // skipping over unrelated tokens trying to find a type during recvoery.
        type = RawTypeSyntax(RawMissingTypeSyntax(arena: self.arena))
      } else {
        type = self.parseType(misplacedSpecifiers: misplacedSpecifiers)
      }
    } else {
      names = ParameterNames(unexpectedBeforeFirstName: nil, firstName: nil, unexpectedBeforeSecondName: nil, secondName: nil)
      unexpectedBeforeColon = nil
      colon = nil
      type = self.parseType(misplacedSpecifiers: misplacedSpecifiers)
    }

    let defaultValue: RawInitializerClauseSyntax?
    if self.at(.equal) || self.atContextualPunctuator("==") {
      defaultValue = self.parseDefaultArgument()
    } else {
      defaultValue = nil
    }

    let trailingComma = self.consume(if: .comma)

    return RawEnumCaseParameterSyntax(
      modifiers: modifiers,
      RawUnexpectedNodesSyntax(combining: misplacedSpecifiers, names.unexpectedBeforeFirstName, arena: self.arena),
      firstName: names.firstName,
      names.unexpectedBeforeSecondName,
      secondName: names.secondName,
      unexpectedBeforeColon,
      colon: colon,
      type: type,
      defaultValue: defaultValue,
      trailingComma: trailingComma,
      arena: self.arena
    )
  }
}

// MARK: - Parameter Modifiers

extension Parser {
  mutating func parseParameterModifiers(isClosure: Bool) -> RawDeclModifierListSyntax {
    var elements = [RawDeclModifierSyntax]()
    var loopProgress = LoopProgressCondition()
    MODIFIER_LOOP: while self.hasProgressed(&loopProgress) {
      switch self.at(anyIn: ParameterModifier.self) {
      case (._const, let handle)?:
        elements.append(RawDeclModifierSyntax(name: self.eat(handle), detail: nil, arena: self.arena))
      case (.isolated, let handle)? where self.withLookahead({ !$0.startsParameterName(isClosure: isClosure, allowMisplacedSpecifierRecovery: false) }):
        elements.append(RawDeclModifierSyntax(name: self.eat(handle), detail: nil, arena: self.arena))
      default:
        break MODIFIER_LOOP
      }
    }
    if elements.isEmpty {
      return self.emptyCollection(RawDeclModifierListSyntax.self)
    } else {
      return RawDeclModifierListSyntax(elements: elements, arena: self.arena)
    }
  }

  mutating func parseMisplacedSpecifiers() -> [RawTokenSyntax] {
    var misplacedSpecifiers: [RawTokenSyntax] = []
    if self.withLookahead({ !$0.startsParameterName(isClosure: false, allowMisplacedSpecifierRecovery: false) }) {
      while canHaveParameterSpecifier, let specifier = self.consume(ifAnyIn: SimpleTypeSpecifierSyntax.SpecifierOptions.self) {
        misplacedSpecifiers.append(specifier)
      }
    }
    return misplacedSpecifiers
  }
}

// MARK: - Parsing parameter clauses

extension Parser {
  mutating func parseParameterClause<
    ParameterClause: RawParameterClauseTrait
  >(
    _ parameterClauseType: ParameterClause.Type,
    parseParameter: (inout Parser) -> ParameterClause.Parameters.ParameterSyntax
  ) -> ParameterClause {
    let (unexpectedBeforeLParen, lparen) = self.expect(.leftParen)
    var elements = [ParameterClause.Parameters.ParameterSyntax]()
    // If we are missing the left parenthesis and the next token doesn't appear
    // to be an argument label, don't parse any parameters.
    let shouldSkipParameterParsing =
      lparen.isMissing
      && (!self.atArgumentLabel(allowDollarIdentifier: true) || currentToken.isLexerClassifiedKeyword)
    if !shouldSkipParameterParsing {
      var keepGoing = true
      var loopProgress = LoopProgressCondition()
      while !self.at(.endOfFile, .rightParen)
        && keepGoing
        && self.hasProgressed(&loopProgress)
      {
        let parameter = parseParameter(&self)
        if parameter.isEmpty {
          keepGoing = false
        } else {
          keepGoing = parameter.trailingComma != nil
          elements.append(parameter)
        }
      }
    }
    let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)

    let parameters: ParameterClause.Parameters
    if elements.isEmpty && (lparen.isMissing || rparen.isMissing) {
      parameters = ParameterClause.Parameters(elements: [], arena: self.arena)
    } else {
      parameters = ParameterClause.Parameters(elements: elements, arena: self.arena)
    }

    return ParameterClause(
      unexpectedBeforeLParen,
      leftParen: lparen,
      nil,
      parameters: parameters,
      unexpectedBeforeRParen,
      rightParen: rparen,
      nil,
      arena: self.arena
    )
  }
}
