//===----------------------------------------------------------------------===//
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
  enum AvailabilitySpecSource {
    case available
    case unavailable
    case macro
  }

  /// Parse a list of availability arguments.
  ///
  /// Grammar
  /// =======
  ///
  ///     availability-arguments → availability-argument | availability-argument , availability-arguments
  mutating func parseAvailabilitySpecList(
    from source: AvailabilitySpecSource
  ) -> RawAvailabilitySpecListSyntax {
    var elements = [RawAvailabilityArgumentSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      var availablityArgumentProgress = LoopProgressCondition()
      repeat {
        let entry: RawAvailabilityArgumentSyntax.Entry
        switch source {
        case .available where self.at(.identifier),
          .unavailable where self.at(.identifier):
          entry = .availabilityVersionRestriction(self.parseAvailabilityMacro())
        default:
          entry = self.parseAvailabilitySpec()
        }

        keepGoing = self.consume(if: .comma)
        elements.append(
          RawAvailabilityArgumentSyntax(
            entry: entry,
            trailingComma: keepGoing,
            arena: self.arena
          )
        )

        // Before continuing to parse the next specification, we check that it's
        // also in the shorthand syntax and recover from it.
        if keepGoing != nil,
          let (_, handle) = self.at(anyIn: AvailabilityArgumentKind.self)
        {
          var tokens = [RawTokenSyntax]()
          tokens.append(self.eat(handle))
          var recoveryProgress = LoopProgressCondition()
          while !self.at(any: [.eof, .comma, .rightParen]) && recoveryProgress.evaluate(currentToken) {
            tokens.append(self.consumeAnyToken())
          }
          let syntax = RawTokenListSyntax(elements: tokens, arena: self.arena)
          keepGoing = self.consume(if: .comma)
          elements.append(
            RawAvailabilityArgumentSyntax(
              entry: .tokenList(syntax),
              trailingComma: keepGoing,
              arena: self.arena
            )
          )
        }
      } while keepGoing != nil && availablityArgumentProgress.evaluate(currentToken)
    }

    return RawAvailabilitySpecListSyntax(elements: elements, arena: self.arena)
  }

  enum AvailabilityArgumentKind: SyntaxText, ContextualKeywords {
    case message
    case renamed
    case introduced
    case deprecated
    case obsoleted
    case unavailable
    case noasync
  }

  mutating func parseExtendedAvailabilitySpecList() -> RawAvailabilitySpecListSyntax {
    var elements = [RawAvailabilityArgumentSyntax]()

    // Parse the platform from the first element.
    let platform = self.consumeAnyToken()
    var keepGoing: RawTokenSyntax? = self.consume(if: .comma)
    elements.append(
      RawAvailabilityArgumentSyntax(
        entry: .token(platform),
        trailingComma: keepGoing,
        arena: self.arena
      )
    )

    do {
      var loopProgressCondition = LoopProgressCondition()
      while keepGoing != nil && loopProgressCondition.evaluate(currentToken) {
        let entry: RawAvailabilityArgumentSyntax.Entry
        switch self.at(anyIn: AvailabilityArgumentKind.self) {
        case (.message, let handle)?,
          (.renamed, let handle)?:
          let argumentLabel = self.eat(handle)
          let (unexpectedBeforeColon, colon) = self.expect(.colon)
          // FIXME: Make sure this is a string literal with no interpolation.
          let stringValue = self.consumeAnyToken()

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
        case nil:
          // Not sure what this label is but, let's just eat it and
          // keep going.
          var tokens = [RawTokenSyntax]()
          while !self.at(any: [.eof, .comma, .rightParen]) {
            tokens.append(self.consumeAnyToken())
          }
          entry = .tokenList(RawTokenListSyntax(elements: tokens, arena: self.arena))
        }

        keepGoing = self.consume(if: .comma)
        elements.append(
          RawAvailabilityArgumentSyntax(
            entry: entry,
            trailingComma: keepGoing,
            arena: self.arena
          )
        )
      }
    }
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

    if self.at(any: [.identifier, .wildcardKeyword]) {
      if self.atContextualKeyword("swift") || self.atContextualKeyword("_PackageDescription") {
        return .availabilityVersionRestriction(self.parsePlatformAgnosticVersionConstraintSpec())
      }
    }

    return .availabilityVersionRestriction(self.parsePlatformVersionConstraintSpec())
  }

  mutating func parsePlatformAgnosticVersionConstraintSpec() -> RawAvailabilityVersionRestrictionSyntax {
    let (unexpectedBeforePlatform, platform) = self.expectAny([.identifier, .wildcardKeyword], default: .identifier)
    let version = self.parseVersionTuple()
    return RawAvailabilityVersionRestrictionSyntax(
      unexpectedBeforePlatform,
      platform: platform,
      version: version,
      arena: self.arena
    )
  }

  /// Parse a platform-specific version constraint.
  ///
  /// The grammar calls out Apple-specific names, even though the Swift compiler
  /// will accept any identifier here. The compiler will diagnose usages of platforms it
  /// doesn't know about later.
  ///
  /// Grammar
  /// =======
  ///
  ///     platform-name → iOS | iOSApplicationExtension
  ///     platform-name → macOS | macOSApplicationExtension
  ///     platform-name → macCatalyst | macCatalystApplicationExtension
  ///     platform-name → watchOS
  ///     platform-name → tvOS
  mutating func parsePlatformVersionConstraintSpec() -> RawAvailabilityVersionRestrictionSyntax {
    // Register the platform name as a keyword token.
    let plaform = self.consumeAnyToken(remapping: .contextualKeyword)
    let version = self.parseVersionTuple()
    return RawAvailabilityVersionRestrictionSyntax(
      platform: plaform,
      version: version,
      arena: self.arena
    )
  }

  /// Parse an availability macro.
  ///
  /// Availability macros are not an official part of the Swift language.
  ///
  /// Grammar
  /// =======
  ///
  ///     availability-argument → macro-name platform-version
  mutating func parseAvailabilityMacro() -> RawAvailabilityVersionRestrictionSyntax {
    let platform = self.consumeAnyToken()

    let version: RawVersionTupleSyntax?
    if self.at(.integerLiteral) {
      version = self.parseVersionTuple()
    } else if self.at(.floatingLiteral) {
      version = self.parseVersionTuple()
    } else {
      version = nil
    }

    return RawAvailabilityVersionRestrictionSyntax(
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
    if let major = self.consume(if: .integerLiteral) {
      return RawVersionTupleSyntax(
        majorMinor: major,
        patchPeriod: nil,
        patchVersion: nil,
        arena: self.arena
      )
    }

    let majorMinor = self.consumeAnyToken()
    let period = self.consume(if: .period)

    let patch: RawTokenSyntax?
    if period != nil {
      patch = self.consumeAnyToken()
    } else {
      patch = nil
    }

    return RawVersionTupleSyntax(
      majorMinor: majorMinor,
      patchPeriod: period,
      patchVersion: patch,
      arena: self.arena
    )
  }
}
