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
  enum DeclModifier: SyntaxText {
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
    enum ExpectedTokenKind: RawTokenKindSubset {
      case privateKeyword
      case fileprivateKeyword
      case internalKeyword
      case publicKeyword
      case staticKeyword
      case classKeyword
      case identifier

      var rawTokenKind: RawTokenKind {
        switch self {
        case .privateKeyword: return .privateKeyword
        case .fileprivateKeyword: return .fileprivateKeyword
        case .internalKeyword: return .internalKeyword
        case .publicKeyword: return .publicKeyword
        case .staticKeyword: return .staticKeyword
        case .classKeyword: return .classKeyword
        case .identifier: return .identifier
        }
      }

      func accepts(lexeme: Lexer.Lexeme, parser: Parser) -> Bool {
        switch self {
        case .classKeyword:
          // If 'class' is a modifier on another decl kind, like var or func,
          // then treat it as a modifier.
          var lookahead = parser.lookahead()
          lookahead.eat(.classKeyword)
          // When followed by an 'override' or CC token inside a class,
          // treat 'class' as a modifier in the case of a following CC
          // token, we cannot be sure there is no intention to override
          // or witness something static.
          return lookahead.isStartOfDeclaration() || lookahead.atContextualKeyword("override")
        default:
          return true
        }
      }
    }

    var elements = [RawDeclModifierSyntax]()
    var modifierLoopCondition = LoopProgressCondition()
    MODIFIER_LOOP: while modifierLoopCondition.evaluate(currentToken) {
      switch self.at(anyIn: ExpectedTokenKind.self) {
      case (.privateKeyword, let handle)?,
          (.fileprivateKeyword, let handle)?,
          (.internalKeyword, let handle)?,
          (.publicKeyword, let handle)?:
        let name = self.eat(handle)
        let details: RawDeclModifierDetailSyntax?
        if let lparen = self.consume(if: .leftParen) {
          assert(self.atContextualKeyword("set"))
          let detail = self.expectIdentifier()
          let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
          details = RawDeclModifierDetailSyntax(
            leftParen: lparen,
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
        let classKeyword = self.eat(handle)
        elements.append(RawDeclModifierSyntax(
          name: classKeyword,
          detail: nil,
          arena: self.arena
        ))
        continue
      case (.identifier, _)?:
        // Context sensitive keywords.
        // FIXME: Sink this into the GYB
        switch DeclModifier(rawValue: self.currentToken.tokenText) {
        case .unowned:
          elements.append(self.parseUnownedModifier())
        case .final,
            .required,
            .optional,
            .lazy,
            .dynamic,
            .infix,
            .prefix,
            .postfix,
            .compilerInitialized,
            .consuming,
            .mutating,
            .nonmutating,
            .convenience,
            .override,
            .open,
            .weak,
            .indirect,
            .isolated,
            .async,
            .nonisolated,
            .distributed,
            .const,
            .local:
          elements.append(self.parseSimpleModifier())
        default:
          break MODIFIER_LOOP
        }

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
    assert(self.currentToken.tokenText == "unowned")
    let keyword = self.consumeAnyToken(remapping: .contextualKeyword)

    let detail: RawDeclModifierDetailSyntax?
    if self.at(.leftParen) {
      detail = self.parseModifierDetail()
    } else {
      detail = nil
    }

    return RawDeclModifierSyntax(name: keyword, detail: detail, arena: self.arena)
  }
}
