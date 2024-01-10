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

import SwiftDiagnostics
@_spi(Diagnostics) import SwiftParser
@_spi(RawSyntax) import SwiftSyntax

extension ParseDiagnosticsGenerator {
  func handleMissingToken(_ missingToken: TokenSyntax) {
    guard let invalidToken = missingToken.previousToken(viewMode: .all),
      invalidToken.presence == .present,
      let invalidTokenContainer = invalidToken.parent?.as(UnexpectedNodesSyntax.self),
      invalidTokenContainer.count == 1
    else {
      _ = handleMissingSyntax(missingToken)
      return
    }

    // The previous token is unexpected, assume that it was intended to be
    // this token.

    let handled: Bool
    switch (missingToken.tokenView.rawKind, invalidToken.tokenView.rawKind) {
    case (.identifier, _):
      handled = handleInvalidIdentifier(invalidToken: invalidToken, missingToken: missingToken, invalidTokenContainer: invalidTokenContainer)
    case (.multilineStringQuote, .multilineStringQuote):
      handled = handleInvalidMultilineStringQuote(invalidToken: invalidToken, missingToken: missingToken, invalidTokenContainer: invalidTokenContainer)
    case (.period, .period):
      handled = handleInvalidPeriod(invalidToken: invalidToken, missingToken: missingToken, invalidTokenContainer: invalidTokenContainer)
    case (.rawStringPoundDelimiter, .rawStringPoundDelimiter), (.regexPoundDelimiter, .regexPoundDelimiter):
      handled = handleInvalidPoundDelimiter(invalidToken: invalidToken, missingToken: missingToken, invalidTokenContainer: invalidTokenContainer)
    default:
      handled = false
    }
    if !handled {
      _ = handleMissingSyntax(missingToken)
    }
  }

  private func handleInvalidIdentifier(invalidToken: TokenSyntax, missingToken: TokenSyntax, invalidTokenContainer: UnexpectedNodesSyntax) -> Bool {
    let fixIts: [FixIt]
    if invalidToken.tokenKind.isLexerClassifiedKeyword || invalidToken.tokenKind.isDollarIdentifier {
      fixIts = [
        FixIt(
          message: .wrapInBackticks,
          changes: [
            .replace(
              oldNode: Syntax(invalidToken),
              newNode: Syntax(
                TokenSyntax.identifier("`\(invalidToken.text)`", leadingTrivia: invalidToken.leadingTrivia, trailingTrivia: invalidToken.trailingTrivia)
              )
            )
          ]
        )
      ]
    } else {
      fixIts = []
    }
    addDiagnostic(
      invalidToken,
      InvalidIdentifierError(invalidIdentifier: invalidToken, missingIdentifier: missingToken),
      fixIts: fixIts,
      handledNodes: [invalidTokenContainer.id]
    )
    return true
  }

  private func handleInvalidMultilineStringQuote(invalidToken: TokenSyntax, missingToken: TokenSyntax, invalidTokenContainer: UnexpectedNodesSyntax) -> Bool {
    if invalidToken.trailingTrivia.isEmpty && !missingToken.trailingTrivia.isEmpty {
      addDiagnostic(
        invalidToken,
        position: invalidToken.endPositionBeforeTrailingTrivia,
        .multiLineStringLiteralMustBeginOnNewLine,
        fixIts: [FixIt(message: .insertNewline, changes: [.replaceTrailingTrivia(token: invalidToken, newTrivia: missingToken.trailingTrivia)])],
        handledNodes: [invalidTokenContainer.id]
      )
      return true
    } else if invalidToken.leadingTrivia.isEmpty && !missingToken.leadingTrivia.isEmpty {
      addDiagnostic(
        invalidToken,
        .multiLineStringLiteralMustHaveClosingDelimiterOnNewLine,
        fixIts: [FixIt(message: .insertNewline, changes: [.replaceLeadingTrivia(token: invalidToken, newTrivia: missingToken.leadingTrivia)])],
        handledNodes: [invalidTokenContainer.id]
      )
      return true
    }

    return false
  }

  private func handleInvalidPeriod(invalidToken: TokenSyntax, missingToken: TokenSyntax, invalidTokenContainer: UnexpectedNodesSyntax) -> Bool {
    // Trailing trivia is the cause of this diagnostic, don't transfer it.
    let changes: [FixIt.MultiNodeChange] = [
      .makeMissing(invalidToken, transferTrivia: false),
      .makePresent(missingToken),
    ]

    if let identifier = missingToken.nextToken(viewMode: .all),
      identifier.tokenView.rawKind == .identifier,
      identifier.isMissing
    {
      // The extraneous whitespace caused a missing identifier, output a
      // diagnostic inserting it instead of a diagnostic to fix the trivia
      // around the period.
      let fixIt = FixIt(
        message: InsertTokenFixIt(missingNodes: [Syntax(identifier)]),
        changes: changes + [.makePresent(identifier, trailingTrivia: invalidToken.trailingTrivia)]
      )
      addDiagnostic(
        identifier,
        position: invalidToken.endPositionBeforeTrailingTrivia,
        MissingNodesError(missingNodes: [Syntax(identifier)]),
        fixIts: [fixIt],
        handledNodes: [invalidTokenContainer.id, identifier.id]
      )
    } else {
      let fixIt = FixIt(message: .removeExtraneousWhitespace, changes: changes)
      addDiagnostic(invalidToken, ExtraneousWhitespace(tokenWithWhitespace: invalidToken), fixIts: [fixIt], handledNodes: [invalidTokenContainer.id])
    }
    return true
  }

  private func handleInvalidPoundDelimiter(
    invalidToken: TokenSyntax,
    missingToken: TokenSyntax,
    invalidTokenContainer: UnexpectedNodesSyntax
  ) -> Bool {
    let isTooMany = invalidToken.trimmedLength > missingToken.trimmedLength
    let message: DiagnosticMessage
    if missingToken.parent?.is(ExpressionSegmentSyntax.self) == true {
      message = .tooManyRawStringDelimitersToStartInterpolation
    } else {
      let parent = missingToken.parent!
      precondition(
        parent.is(StringLiteralExprSyntax.self) || parent.is(RegexLiteralExprSyntax.self),
        "Raw string delimiters should only occur in string interpolation and at the end of a string or regex literal"
      )
      message = isTooMany ? StaticParserError.tooManyClosingPoundDelimiters : .tooFewClosingPoundDelimiters
    }
    let fixIt = FixIt(
      message: isTooMany ? .removeExtraneousDelimiters : .insertExtraClosingPounds,
      changes: [
        .makeMissing(invalidToken),
        .makePresent(missingToken),
      ]
    )
    addDiagnostic(
      invalidToken,
      position: invalidToken.positionAfterSkippingLeadingTrivia.advanced(by: missingToken.trimmedLength.utf8Length),
      message,
      fixIts: [fixIt],
      handledNodes: [invalidTokenContainer.id]
    )
    return true
  }
}
