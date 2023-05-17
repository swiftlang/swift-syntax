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
  mutating func parseModifierList() -> RawModifierListSyntax? {
    var elements = [RawDeclModifierSyntax]()
    var modifierLoopCondition = LoopProgressCondition()
    MODIFIER_LOOP: while modifierLoopCondition.evaluate(currentToken) {
      switch self.at(anyIn: DeclarationModifier.self) {
      case (.private, _)?,
        (.fileprivate, _)?,
        (.internal, _)?,
        (.public, _)?:
        elements.append(parseAccessLevelModifier())
      case (.package, _)?:
        elements.append(parsePackageAccessLevelModifier())
      case (.open, _)?:
        elements.append(parseOpenAccessLevelModifier())
      case (.static, let handle)?:
        let staticKeyword = self.eat(handle)
        elements.append(
          RawDeclModifierSyntax(
            name: staticKeyword,
            detail: nil,
            arena: self.arena
          )
        )
      case (.class, let handle)?:
        var lookahead = self.lookahead()
        lookahead.eat(.keyword(.class))
        // When followed by an 'override' or CC token inside a class,
        // treat 'class' as a modifier in the case of a following CC
        // token, we cannot be sure there is no intention to override
        // or witness something static.
        if lookahead.atStartOfDeclaration() || lookahead.at(.keyword(.override)) {
          let classKeyword = self.eat(handle)
          elements.append(
            RawDeclModifierSyntax(
              name: classKeyword,
              detail: nil,
              arena: self.arena
            )
          )
          continue
        } else {
          break MODIFIER_LOOP
        }
      case (.unowned, _)?:
        elements.append(self.parseUnownedModifier())
      case (.final, let handle)?,
        (.required, let handle)?,
        (.optional, let handle)?,
        (.lazy, let handle)?,
        (.dynamic, let handle)?,
        (.infix, let handle)?,
        (.prefix, let handle)?,
        (.postfix, let handle)?,
        (.__consuming, let handle)?,
        (.borrowing, let handle)?,
        (.consuming, let handle)?,
        (.mutating, let handle)?,
        (.nonmutating, let handle)?,
        (.convenience, let handle)?,
        (.override, let handle)?,
        (.weak, let handle)?,
        (.indirect, let handle)?,
        (.isolated, let handle)?,
        (.async, let handle)?,
        (.nonisolated, let handle)?,
        (.distributed, let handle)?,
        (._const, let handle)?,
        (._local, let handle)?,
        (.__setter_access, let handle)?,
        (.reasync, let handle)?:
        let keyword = self.eat(handle)
        elements.append(RawDeclModifierSyntax(name: keyword, detail: nil, arena: self.arena))
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

  mutating func parseUnownedModifier() -> RawDeclModifierSyntax {
    let (unexpectedBeforeKeyword, keyword) = self.expect(.keyword(.unowned))

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

      init?(lexeme: Lexer.Lexeme) {
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
}
