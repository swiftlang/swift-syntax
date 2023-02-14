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
  /// Parse a list of availability arguments.
  ///
  /// Grammar
  /// =======
  ///
  ///     availability-arguments → availability-argument | availability-argument , availability-arguments
  mutating func parseAvailabilitySpecList() -> RawAvailabilitySpecListSyntax {
    var elements = [RawAvailabilityArgumentSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      var availablityArgumentProgress = LoopProgressCondition()
      repeat {
        let entry: RawAvailabilityArgumentSyntax.Entry
        if self.at(.identifier) {
          entry = .availabilityVersionRestriction(self.parseAvailabilityMacro())
        } else {
          entry = self.parseAvailabilitySpec()
        }

        let unexpectedBeforeKeepGoing: RawUnexpectedNodesSyntax?
        keepGoing = self.consume(if: .comma)
        if keepGoing == nil, let orOperator = self.consumeIfContextualPunctuator("||") {
          unexpectedBeforeKeepGoing = RawUnexpectedNodesSyntax([orOperator], arena: self.arena)
          keepGoing = missingToken(.comma)
        } else {
          unexpectedBeforeKeepGoing = nil
        }
        elements.append(
          RawAvailabilityArgumentSyntax(
            entry: entry,
            unexpectedBeforeKeepGoing,
            trailingComma: keepGoing,
            arena: self.arena
          )
        )
      } while keepGoing != nil && availablityArgumentProgress.evaluate(currentToken)
    }

    return RawAvailabilitySpecListSyntax(elements: elements, arena: self.arena)
  }

  enum AvailabilityArgumentKind: TokenSpecSet {
    case message
    case renamed
    case introduced
    case deprecated
    case obsoleted
    case unavailable
    case noasync
    case star
    case identifier

    init?(lexeme: Lexer.Lexeme) {
      switch PrepareForKeywordMatch(lexeme) {
      case TokenSpec(.message): self = .message
      case TokenSpec(.renamed): self = .renamed
      case TokenSpec(.introduced): self = .introduced
      case TokenSpec(.deprecated): self = .deprecated
      case TokenSpec(.obsoleted): self = .obsoleted
      case TokenSpec(.unavailable): self = .unavailable
      case TokenSpec(.noasync): self = .noasync
      case TokenSpec(.binaryOperator) where lexeme.tokenText == "*": self = .star
      case TokenSpec(.identifier): self = .identifier
      default: return nil
      }
    }

    var spec: TokenSpec {
      switch self {
      case .message: return .keyword(.message)
      case .renamed: return .keyword(.renamed)
      case .introduced: return .keyword(.introduced)
      case .deprecated: return .keyword(.deprecated)
      case .obsoleted: return .keyword(.obsoleted)
      case .unavailable: return .keyword(.unavailable)
      case .noasync: return .keyword(.noasync)
      case .star: return .binaryOperator
      case .identifier: return .identifier
      }
    }
  }

  mutating func parseAvailabilityArgumentSpecList() -> RawAvailabilitySpecListSyntax {
    var elements = [RawAvailabilityArgumentSyntax]()
    var keepGoing: RawTokenSyntax? = nil

    var loopProgressCondition = LoopProgressCondition()
    LOOP: repeat {
      let entry: RawAvailabilityArgumentSyntax.Entry
      switch self.at(anyIn: AvailabilityArgumentKind.self) {
      case (.message, let handle)?,
        (.renamed, let handle)?:
        let argumentLabel = self.eat(handle)
        let (unexpectedBeforeColon, colon) = self.expect(.colon)
        // FIXME: Make sure this is a string literal with no interpolation.
        let stringValue = self.parseStringLiteral()

        entry = .availabilityLabeledArgument(
          RawAvailabilityLabeledArgumentSyntax(
            label: argumentLabel,
            unexpectedBeforeColon,
            colon: colon,
            value: .string(stringValue),
            arena: self.arena
          )
        )
      case (.introduced, let handle)?,
        (.obsoleted, let handle)?:
        let argumentLabel = self.eat(handle)
        let (unexpectedBeforeColon, colon) = self.expect(.colon)
        let version = self.parseVersionTuple()
        entry = .availabilityLabeledArgument(
          RawAvailabilityLabeledArgumentSyntax(
            label: argumentLabel,
            unexpectedBeforeColon,
            colon: colon,
            value: .version(version),
            arena: self.arena
          )
        )
      case (.deprecated, let handle)?:
        let argumentLabel = self.eat(handle)
        if let colon = self.consume(if: .colon) {
          let version = self.parseVersionTuple()
          entry = .availabilityLabeledArgument(
            RawAvailabilityLabeledArgumentSyntax(
              label: argumentLabel,
              colon: colon,
              value: .version(version),
              arena: self.arena
            )
          )
        } else {
          entry = .token(argumentLabel)
        }
      case (.unavailable, let handle)?,
        (.noasync, let handle)?:
        let argument = self.eat(handle)
        // FIXME: Can we model this in SwiftSyntax by making the
        // 'labeled' argument part optional?
        entry = .token(argument)
      case (.star, _)?:
        entry = self.parseAvailabilitySpec()
      case (.identifier, let handle)?:
        if self.peek().rawTokenKind == .comma {
          // An argument like `_iOS13Aligned` that isn't followed by a version.
          let version = self.eat(handle)
          entry = .token(version)
        } else {
          entry = self.parseAvailabilitySpec()
        }
      case nil:
        break LOOP
      }

      keepGoing = self.consume(if: .comma)
      elements.append(
        RawAvailabilityArgumentSyntax(
          entry: entry,
          trailingComma: keepGoing,
          arena: self.arena
        )
      )
    } while keepGoing != nil && loopProgressCondition.evaluate(currentToken)
    return RawAvailabilitySpecListSyntax(elements: elements, arena: self.arena)
  }

  /// Parse an availability argument.
  ///
  /// Grammar
  /// =======
  ///
  ///     availability-argument → platform-name platform-version
  ///     availability-argument → *
  mutating func parseAvailabilitySpec() -> RawAvailabilityArgumentSyntax.Entry {
    if let star = self.consumeIfContextualPunctuator("*") {
      // FIXME: Use makeAvailabilityVersionRestriction here - but swift-format
      // doesn't expect it.
      return .token(star)
    }

    return .availabilityVersionRestriction(self.parseAvailabilityMacro())
  }

  /// Parse an availability macro.
  ///
  /// Availability macros are not an official part of the Swift language.
  ///
  /// Grammar
  /// =======
  ///
  ///     availability-argument → macro-name platform-version
  ///
  /// If `allowStarAsVersionNumber` is `true`, versions like `* 13.0` are accepted.
  /// This is to match the behavior of `@_originallyDefinedIn` in the old parser that accepted such versions
  mutating func parseAvailabilityMacro(allowStarAsVersionNumber: Bool = false) -> RawAvailabilityVersionRestrictionSyntax {
    let unexpectedBeforePlatform: RawUnexpectedNodesSyntax?
    let platform: RawTokenSyntax
    if allowStarAsVersionNumber, self.atContextualPunctuator("*") {
      unexpectedBeforePlatform = nil
      platform = self.consumeAnyToken(remapping: .identifier)
    } else {
      (unexpectedBeforePlatform, platform) = self.expect(.identifier)
    }

    let version: RawVersionTupleSyntax?
    if self.at(.integerLiteral, .floatingLiteral) {
      version = self.parseVersionTuple()
    } else {
      version = nil
    }

    return RawAvailabilityVersionRestrictionSyntax(
      unexpectedBeforePlatform,
      platform: platform,
      version: version,
      arena: self.arena
    )
  }

  /// Parse a dot-separated list of version numbers.
  ///
  /// Grammar
  /// =======
  ///
  ///     platform-version → decimal-digits
  ///     platform-version → decimal-digits '.' decimal-digits
  ///     platform-version → decimal-digits '.' decimal-digits '.' decimal-digits
  mutating func parseVersionTuple() -> RawVersionTupleSyntax {
    let (unexpectedBeforeMajorMinor, majorMinor) = self.expect(.integerLiteral, .floatingLiteral, default: .integerLiteral)
    let patchPeriod: RawTokenSyntax?
    let unexpectedBeforePatch: RawUnexpectedNodesSyntax?
    let patch: RawTokenSyntax?
    if majorMinor.tokenKind == .floatingLiteral {
      patchPeriod = self.consume(if: .period)
      if patchPeriod != nil {
        (unexpectedBeforePatch, patch) = self.expect(.integerLiteral)
      } else {
        unexpectedBeforePatch = nil
        patch = nil
      }
    } else {
      patchPeriod = nil
      unexpectedBeforePatch = nil
      patch = nil
    }

    return RawVersionTupleSyntax(
      unexpectedBeforeMajorMinor,
      majorMinor: majorMinor,
      patchPeriod: patchPeriod,
      unexpectedBeforePatch,
      patchVersion: patch,
      arena: self.arena
    )
  }
}
