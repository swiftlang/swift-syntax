//===------------------------ Modifiers.swift -----------------------------===//
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
  public mutating func parseModifierList() -> RawModifierListSyntax? {
    var elements = [RawDeclModifierSyntax]()
    var modifierLoopCondition = LoopProgressCondition()
    MODIFIER_LOOP: while modifierLoopCondition.evaluate(currentToken) {
      switch self.at(anyIn: DeclarationModifier.self) {
      case (.privateKeyword, _)?,
          (.fileprivateKeyword, _)?,
          (.internalKeyword, _)?,
          (.publicKeyword, _)?:
        elements.append(parseAccessLevelModifier())
      case (.open, _)?:
        elements.append(parseOpenAccessLevelModifier())
      case (.staticKeyword, let handle)?:
        let staticKeyword = self.eat(handle)
        elements.append(RawDeclModifierSyntax(
          name: staticKeyword,
          detail: nil,
          arena: self.arena
        ))
      case (.classKeyword, let handle)?:
        var lookahead = self.lookahead()
        lookahead.eat(.classKeyword)
        // When followed by an 'override' or CC token inside a class,
        // treat 'class' as a modifier in the case of a following CC
        // token, we cannot be sure there is no intention to override
        // or witness something static.
        if lookahead.atStartOfDeclaration() || lookahead.atContextualKeyword("override") {
          let classKeyword = self.eat(handle)
          elements.append(RawDeclModifierSyntax(
            name: classKeyword,
            detail: nil,
            arena: self.arena
          ))
          continue
        } else {
          break MODIFIER_LOOP
        }
      case (.unowned, _)?:
        elements.append(self.parseUnownedModifier())
      case (.final, _)?,
        (.required, _)?,
        (.optional, _)?,
        (.lazy, _)?,
        (.dynamic, _)?,
        (.infix, _)?,
        (.prefix, _)?,
        (.postfix, _)?,
        (.__consuming, _)?,
        (.mutating, _)?,
        (.nonmutating, _)?,
        (.convenience, _)?,
        (.override, _)?,
        (.weak, _)?,
        (.indirect, _)?,
        (.isolated, _)?,
        (.async, _)?,
        (.nonisolated, _)?,
        (.distributed, _)?,
        (._const, _)?,
        (._local, _)?,
        (.__setter_access, _)?,
        (.reasync, _)?:
        elements.append(self.parseSimpleModifier())
      case (.rethrows, _)?:
        fallthrough
      case nil:
        break MODIFIER_LOOP
      }
    }
    return elements.isEmpty ? nil : RawModifierListSyntax(elements: elements, arena: arena)
  }
}

extension Parser {
  mutating func parseSimpleModifier() -> RawDeclModifierSyntax {
    let keyword = self.consumeAnyToken(remapping: .contextualKeyword)
    return RawDeclModifierSyntax(name: keyword, detail: nil, arena: self.arena)
  }

  mutating func parseModifierDetail() -> RawDeclModifierDetailSyntax {
    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
    let detailToken = self.consumeAnyToken()
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
    return RawDeclModifierDetailSyntax(
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      detail: detailToken,
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      arena: self.arena
    )
  }

  mutating func parseSingleArgumentModifier() -> RawDeclModifierSyntax {
    let keyword = self.consumeAnyToken(remapping: .contextualKeyword)
    let detail = self.parseModifierDetail()
    return RawDeclModifierSyntax(name: keyword, detail: detail, arena: self.arena)
  }

  mutating func parseUnownedModifier() -> RawDeclModifierSyntax {
    let (unexpectedBeforeKeyword, keyword) = self.expectContextualKeyword("unowned")

    let detail: RawDeclModifierDetailSyntax?
    if self.at(.leftParen) {
      detail = self.parseModifierDetail()
    } else {
      detail = nil
    }

    return RawDeclModifierSyntax(
      unexpectedBeforeKeyword,
      name: keyword,
      detail: detail,
      arena: self.arena
    )
  }

  mutating func parseOpenAccessLevelModifier() -> RawDeclModifierSyntax {
    let (unexpectedBeforeName, name) = self.expectContextualKeyword("open")
    let details = self.parseAccessModifierDetails()
    return RawDeclModifierSyntax(
      unexpectedBeforeName,
      name: name,
      detail: details,
      arena: self.arena)
  }

  mutating func parseAccessLevelModifier() -> RawDeclModifierSyntax {
    let (unexpectedBeforeName, name) = expectAny(
      [.privateKeyword, .fileprivateKeyword, .internalKeyword, .publicKeyword],
      default: .internalKeyword
    )
    let details = self.parseAccessModifierDetails()
    return RawDeclModifierSyntax(
      unexpectedBeforeName,
      name: name,
      detail: details,
      arena: self.arena)
  }

  mutating func parseAccessModifierDetails() -> RawDeclModifierDetailSyntax? {
    guard let leftParen = consume(if: .leftParen) else {
      return nil
    }

    let unexpectedBeforeDetail: RawUnexpectedNodesSyntax?
    let detail: RawTokenSyntax
    if let setHandle = canRecoverToContextualKeyword("set", precedence: .weakBracketClose) {
      (unexpectedBeforeDetail, detail) = eat(setHandle)
    } else {
      unexpectedBeforeDetail = nil
      detail = RawTokenSyntax(
        missing: .contextualKeyword,
        text: "set",
        arena: arena
      )
    }
    let (unexpectedBeforeRightParen, rightParen) = expect(.rightParen)

    return RawDeclModifierDetailSyntax(
      leftParen: leftParen,
      unexpectedBeforeDetail,
      detail: detail,
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      arena: self.arena)
  }
}
