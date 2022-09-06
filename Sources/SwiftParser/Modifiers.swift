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
  enum DeclModifier: SyntaxText, ContextualKeywords {
    case unowned = "unowned"

    case final = "final"
    case required = "required"
    case optional = "optional"
    case lazy = "lazy"
    case dynamic = "dynamic"
    case infix = "infix"
    case prefix = "prefix"
    case postfix = "postfix"
    case compilerInitialized = "_compilerInitialized"
    case consuming = "__consuming"
    case mutating = "mutating"
    case nonmutating = "nonmutating"
    case convenience = "convenience"
    case override = "override"
    case open = "open"
    case weak = "weak"
    case indirect = "indirect"
    case isolated = "isolated"
    case async = "async"
    case nonisolated = "nonisolated"
    case distributed = "distributed"
    case const = "_const"
    case local = "_local"
  }

  @_spi(RawSyntax)
  public mutating func parseModifierList() -> RawModifierListSyntax? {
    var elements = [RawDeclModifierSyntax]()
    var modifierLoopCondition = LoopProgressCondition()
    MODIFIER_LOOP: while modifierLoopCondition.evaluate(currentToken) {
      switch self.at(anyIn: DeclarationModifier.self) {
      case (.privateKeyword, let handle)?,
          (.fileprivateKeyword, let handle)?,
          (.internalKeyword, let handle)?,
          (.publicKeyword, let handle)?:
        let name = self.eat(handle)
        let details: RawDeclModifierDetailSyntax?
        if let lparen = self.consume(if: .leftParen) {
          let (unexpectedBeforeDetail, detail) = self.expectContextualKeyword("set")
          let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
          details = RawDeclModifierDetailSyntax(
            leftParen: lparen,
            unexpectedBeforeDetail,
            detail: detail,
            unexpectedBeforeRParen,
            rightParen: rparen,
            arena: self.arena
          )
        } else {
          details = nil
        }

        elements.append(RawDeclModifierSyntax(
          name: name, detail: details, arena: self.arena))
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
        if lookahead.isStartOfDeclaration() || lookahead.atContextualKeyword("override") {
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
        (.compilerInitialized, _)?,
        (.consuming, _)?,
        (.mutating, _)?,
        (.nonmutating, _)?,
        (.convenience, _)?,
        (.override, _)?,
        (.open, _)?,
        (.weak, _)?,
        (.indirect, _)?,
        (.isolated, _)?,
        (.async, _)?,
        (.nonisolated, _)?,
        (.distributed, _)?,
        (.const, _)?,
        (.local, _)?:
        elements.append(self.parseSimpleModifier())

      default:
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
}
