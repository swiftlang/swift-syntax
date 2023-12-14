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

extension Parser {
  mutating func parseDeclModifierList() -> RawDeclModifierListSyntax {
    var elements = [RawDeclModifierSyntax]()
    var modifierLoopProgress = LoopProgressCondition()
    MODIFIER_LOOP: while self.hasProgressed(&modifierLoopProgress) {
      switch self.canRecoverTo(anyIn: DeclarationStart.self) {
      case (.declarationModifier(.private), _)?,
        (.declarationModifier(.fileprivate), _)?,
        (.declarationModifier(.internal), _)?,
        (.declarationModifier(.public), _)?:
        elements.append(parseAccessLevelModifier())
      case (.declarationModifier(.package), _)?:
        elements.append(parsePackageAccessLevelModifier())
      case (.declarationModifier(.open), _)?:
        elements.append(parseOpenAccessLevelModifier())
      case (.declarationModifier(.static), let handle)?:
        let (unexpectedBeforeKeyword, staticKeyword) = self.eat(handle)
        elements.append(
          RawDeclModifierSyntax(
            unexpectedBeforeKeyword,
            name: staticKeyword,
            detail: nil,
            arena: self.arena
          )
        )
      case (.declarationModifier(.class), let handle)?:
        var lookahead = self.lookahead()
        lookahead.consume(to: .keyword(.class))
        // When followed by an 'override' or CC token inside a class,
        // treat 'class' as a modifier in the case of a following CC
        // token, we cannot be sure there is no intention to override
        // or witness something static.
        if lookahead.atStartOfDeclaration() || lookahead.at(.keyword(.override)) {
          let (unexpectedBeforeKeyword, classKeyword) = self.eat(handle)
          elements.append(
            RawDeclModifierSyntax(
              unexpectedBeforeKeyword,
              name: classKeyword,
              detail: nil,
              arena: self.arena
            )
          )
          continue
        } else {
          break MODIFIER_LOOP
        }
      case (.declarationModifier(.unowned), let handle)?:
        elements.append(self.parseUnownedModifier(handle))
      case (.declarationModifier(.nonisolated), let handle)?:
        elements.append(parseNonisolatedModifier(handle))
      case (.declarationModifier(.final), let handle)?,
        (.declarationModifier(.required), let handle)?,
        (.declarationModifier(.optional), let handle)?,
        (.declarationModifier(.lazy), let handle)?,
        (.declarationModifier(.dynamic), let handle)?,
        (.declarationModifier(.infix), let handle)?,
        (.declarationModifier(.prefix), let handle)?,
        (.declarationModifier(.postfix), let handle)?,
        (.declarationModifier(.__consuming), let handle)?,
        (.declarationModifier(.borrowing), let handle)?,
        (.declarationModifier(.consuming), let handle)?,
        (.declarationModifier(.mutating), let handle)?,
        (.declarationModifier(.nonmutating), let handle)?,
        (.declarationModifier(.convenience), let handle)?,
        (.declarationModifier(.override), let handle)?,
        (.declarationModifier(.weak), let handle)?,
        (.declarationModifier(.indirect), let handle)?,
        (.declarationModifier(.isolated), let handle)?,
        (.declarationModifier(.async), let handle)?,
        (.declarationModifier(.distributed), let handle)?,
        (.declarationModifier(._const), let handle)?,
        (.declarationModifier(._local), let handle)?,
        (.declarationModifier(.__setter_access), let handle)?,
        (.declarationModifier(.reasync), let handle)?,
        (.declarationModifier(._resultDependsOnSelf), let handle)? where experimentalFeatures.contains(.nonescapableTypes):
        let (unexpectedBeforeKeyword, keyword) = self.eat(handle)
        elements.append(RawDeclModifierSyntax(unexpectedBeforeKeyword, name: keyword, detail: nil, arena: self.arena))
      case (.declarationModifier(.rethrows), _)?:
        fallthrough
      default:
        break MODIFIER_LOOP
      }
    }
    return elements.isEmpty ? self.emptyCollection(RawDeclModifierListSyntax.self) : RawDeclModifierListSyntax(elements: elements, arena: arena)
  }
}

extension Parser {
  mutating func parseModifierDetail() -> RawDeclModifierDetailSyntax {
    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
    let (unexpectedBeforeDetailToken, detailToken) = self.expect(.identifier, TokenSpec(.set, remapping: .identifier), default: .identifier)
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
    return RawDeclModifierDetailSyntax(
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      unexpectedBeforeDetailToken,
      detail: detailToken,
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      arena: self.arena
    )
  }

  mutating func parseUnownedModifier(_ handle: RecoveryConsumptionHandle) -> RawDeclModifierSyntax {
    let (unexpectedBeforeKeyword, keyword) = self.eat(handle)

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

  mutating func parsePackageAccessLevelModifier() -> RawDeclModifierSyntax {
    let (unexpectedBeforeName, name) = self.expect(.keyword(.package))
    let details = self.parseAccessModifierDetails()
    return RawDeclModifierSyntax(
      unexpectedBeforeName,
      name: name,
      detail: details,
      arena: self.arena
    )
  }

  mutating func parseOpenAccessLevelModifier() -> RawDeclModifierSyntax {
    let (unexpectedBeforeName, name) = self.expect(.keyword(.open))
    let details = self.parseAccessModifierDetails()
    return RawDeclModifierSyntax(
      unexpectedBeforeName,
      name: name,
      detail: details,
      arena: self.arena
    )
  }

  mutating func parseAccessLevelModifier() -> RawDeclModifierSyntax {
    enum AccessLevelModifier: TokenSpecSet {
      case `private`
      case `fileprivate`
      case `internal`
      case `public`

      var spec: TokenSpec {
        switch self {
        case .private: return .keyword(.private)
        case .fileprivate: return .keyword(.fileprivate)
        case .internal: return .keyword(.internal)
        case .public: return .keyword(.public)
        }
      }

      init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
        switch PrepareForKeywordMatch(lexeme) {
        case TokenSpec(.private): self = .private
        case TokenSpec(.fileprivate): self = .fileprivate
        case TokenSpec(.internal): self = .internal
        case TokenSpec(.public): self = .public
        default: return nil
        }
      }
    }

    let (unexpectedBeforeName, name) = expect(
      anyIn: AccessLevelModifier.self,
      default: .internal
    )
    let details = self.parseAccessModifierDetails()
    return RawDeclModifierSyntax(
      unexpectedBeforeName,
      name: name,
      detail: details,
      arena: self.arena
    )
  }

  mutating func parseAccessModifierDetails() -> RawDeclModifierDetailSyntax? {
    guard let leftParen = consume(if: .leftParen) else {
      return nil
    }

    let unexpectedBeforeDetail: RawUnexpectedNodesSyntax?
    let detail: RawTokenSyntax
    if let setHandle = canRecoverTo(TokenSpec(.set, remapping: .identifier, recoveryPrecedence: .weakBracketClose)) {
      (unexpectedBeforeDetail, detail) = eat(setHandle)
    } else {
      unexpectedBeforeDetail = nil
      detail = missingToken(.identifier, text: "set")
    }
    let (unexpectedBeforeRightParen, rightParen) = expect(.rightParen)

    return RawDeclModifierDetailSyntax(
      leftParen: leftParen,
      unexpectedBeforeDetail,
      detail: detail,
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      arena: self.arena
    )
  }

  mutating func parseNonisolatedModifier(_ handle: RecoveryConsumptionHandle) -> RawDeclModifierSyntax {
    let (unexpectedBeforeKeyword, keyword) = self.eat(handle)

    let detail: RawDeclModifierDetailSyntax?
    if self.at(.leftParen) {
      let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
      let (unexpectedBeforeDetailToken, detailToken) = self.expect(TokenSpec(.unsafe, remapping: .identifier))
      let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
      detail = RawDeclModifierDetailSyntax(
        unexpectedBeforeLeftParen,
        leftParen: leftParen,
        unexpectedBeforeDetailToken,
        detail: detailToken,
        unexpectedBeforeRightParen,
        rightParen: rightParen,
        arena: self.arena
      )
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
