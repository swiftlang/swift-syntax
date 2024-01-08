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
  mutating func parseAvailabilitySpecList() -> RawAvailabilityArgumentListSyntax {
    var elements = [RawAvailabilityArgumentSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      var availabilityArgumentProgress = LoopProgressCondition()
      repeat {
        let argument: RawAvailabilityArgumentSyntax.Argument
        if self.at(.identifier) {
          argument = .availabilityVersionRestriction(self.parsePlatformVersion())
        } else {
          argument = self.parseAvailabilitySpec()
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
            argument: argument,
            unexpectedBeforeKeepGoing,
            trailingComma: keepGoing,
            arena: self.arena
          )
        )
      } while keepGoing != nil && self.hasProgressed(&availabilityArgumentProgress)
    }

    return RawAvailabilityArgumentListSyntax(elements: elements, arena: self.arena)
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

    init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
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

  mutating func parseAvailabilityArgumentSpecList() -> RawAvailabilityArgumentListSyntax {
    var elements = [RawAvailabilityArgumentSyntax]()
    var keepGoing: RawTokenSyntax? = nil

    var loopProgress = LoopProgressCondition()
    LOOP: repeat {
      let entry: RawAvailabilityArgumentSyntax.Argument
      switch self.at(anyIn: AvailabilityArgumentKind.self) {
      case (.message, let handle)?,
        (.renamed, let handle)?:
        let argumentLabel = self.eat(handle)
        let (unexpectedBeforeColon, colon) = self.expect(.colon)
        let stringValue = self.parseSimpleString()

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
        let version = self.parseVersionTuple(maxComponentCount: 3)
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
          let version = self.parseVersionTuple(maxComponentCount: 3)
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
        entry = .token(argument)
      case (.star, _)?:
        entry = self.parseAvailabilitySpec()
      case (.identifier, let handle)?:
        if self.peek(isAt: .comma) {
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
          argument: entry,
          trailingComma: keepGoing,
          arena: self.arena
        )
      )
    } while keepGoing != nil && self.hasProgressed(&loopProgress)
    return RawAvailabilityArgumentListSyntax(elements: elements, arena: self.arena)
  }

  /// Parse an availability argument.
  mutating func parseAvailabilitySpec() -> RawAvailabilityArgumentSyntax.Argument {
    if let star = self.consumeIfContextualPunctuator("*") {
      return .token(star)
    }

    return .availabilityVersionRestriction(self.parsePlatformVersion())
  }

  /// Parse an availability macro.
  ///
  /// Availability macros are not an official part of the Swift language.
  ///
  /// If `allowStarAsVersionNumber` is `true`, versions like `* 13.0` are accepted.
  /// This is to match the behavior of `@_originallyDefinedIn` in the old parser that accepted such versions
  mutating func parsePlatformVersion(allowStarAsVersionNumber: Bool = false) -> RawPlatformVersionSyntax {
    let unexpectedBeforePlatform: RawUnexpectedNodesSyntax?
    let platform: RawTokenSyntax
    if allowStarAsVersionNumber, self.atContextualPunctuator("*") {
      unexpectedBeforePlatform = nil
      platform = self.consumeAnyToken(remapping: .identifier)
    } else {
      (unexpectedBeforePlatform, platform) = self.expect(.identifier)
    }

    let unexpectedComparison: RawUnexpectedNodesSyntax?
    if let greaterThanOrEqualTo = self.consumeIfContextualPunctuator(">=") {
      unexpectedComparison = RawUnexpectedNodesSyntax([greaterThanOrEqualTo], arena: self.arena)
    } else {
      unexpectedComparison = nil
    }

    let version: RawVersionTupleSyntax?
    if self.at(.integerLiteral, .floatLiteral) {
      version = self.parseVersionTuple(maxComponentCount: 3)
    } else {
      version = nil
    }

    return RawPlatformVersionSyntax(
      unexpectedBeforePlatform,
      platform: platform,
      unexpectedComparison,
      version: version,
      arena: self.arena
    )
  }

  /// If the next token is an integer literal only consisting of the digits 0-9
  /// consume and return it, otherwise return a missing integer token.
  private mutating func expectDecimalIntegerWithoutRecovery() -> RawTokenSyntax {
    guard self.at(.integerLiteral) else {
      return missingToken(.integerLiteral, text: nil)
    }
    guard self.currentToken.tokenText.allSatisfy({ Unicode.Scalar($0).isDigit }) else {
      return missingToken(.integerLiteral, text: nil)
    }
    return self.consumeAnyToken()
  }

  /// Consume the unexpected version token(e.g. integerLiteral, floatLiteral, identifier) until the period no longer appears.
  private mutating func parseUnexpectedVersionTokens() -> RawUnexpectedNodesSyntax? {
    var unexpectedTokens: [RawTokenSyntax] = []
    var keepGoing: RawTokenSyntax? = nil
    var loopProgress = LoopProgressCondition()
    repeat {
      if let keepGoing {
        unexpectedTokens.append(keepGoing)
      }
      if let unexpectedVersion = self.consume(if: .integerLiteral, .floatLiteral, .identifier) {
        unexpectedTokens.append(unexpectedVersion)
      }
      keepGoing = self.consume(if: .period)
    } while keepGoing != nil && self.hasProgressed(&loopProgress)
    return RawUnexpectedNodesSyntax(unexpectedTokens, arena: self.arena)
  }

  /// Parse a dot-separated list of version numbers.
  mutating func parseVersionTuple(maxComponentCount: Int) -> RawVersionTupleSyntax {
    if self.at(.floatLiteral),
      let periodIndex = self.currentToken.tokenText.firstIndex(of: UInt8(ascii: ".")),
      self.currentToken.tokenText[0..<periodIndex].allSatisfy({ Unicode.Scalar($0).isDigit })
    {
      // The lexer generates a float literal '1.2' for the major and minor version.
      // Split it into two integers if possible
      let major = self.consumePrefix(SyntaxText(rebasing: self.currentToken.tokenText[0..<periodIndex]), as: .integerLiteral)

      var components: [RawVersionComponentSyntax] = []
      var trailingComponents: [RawVersionComponentSyntax] = []

      for i in 1... {
        guard let period = self.consume(if: .period) else {
          break
        }
        let version = self.expectDecimalIntegerWithoutRecovery()

        let versionComponent = RawVersionComponentSyntax(period: period, number: version, arena: self.arena)

        if i < maxComponentCount {
          components.append(versionComponent)
        } else {
          trailingComponents.append(versionComponent)
        }

        if version.isMissing {
          break
        }
      }

      let unexpectedTrailingComponents = RawUnexpectedNodesSyntax(trailingComponents, arena: self.arena)
      let unexpectedAfterComponents = self.parseUnexpectedVersionTokens()
      return RawVersionTupleSyntax(
        major: major,
        components: RawVersionComponentListSyntax(elements: components, arena: self.arena),
        RawUnexpectedNodesSyntax(combining: unexpectedTrailingComponents, unexpectedAfterComponents, arena: self.arena),
        arena: self.arena
      )
    } else {
      let major = self.expectDecimalIntegerWithoutRecovery()
      let unexpectedAfterComponents = self.parseUnexpectedVersionTokens()
      return RawVersionTupleSyntax(
        major: major,
        components: RawVersionComponentListSyntax(elements: [], arena: self.arena),
        unexpectedAfterComponents,
        arena: self.arena
      )
    }
  }
}
