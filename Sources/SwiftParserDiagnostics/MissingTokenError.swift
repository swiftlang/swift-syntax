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
@_spi(RawSyntax) import SwiftSyntax

extension ParseDiagnosticsGenerator {
  func handleMissingToken(_ missingToken: TokenSyntax) {
    guard let invalidToken = missingToken.previousToken(viewMode: .all),
      let invalidTokenContainer = invalidToken.parent?.as(UnexpectedNodesSyntax.self),
      invalidTokenContainer.count == 1
    else {
      _ = handleMissingSyntax(missingToken)
      return
    }

    // The previous token is unexpected, assume that it was intended to be
    // this token.

    switch (missingToken.rawTokenKind, invalidToken.rawTokenKind) {
    case (.identifier, _):
      handleInvalidIdentifier(invalidToken: invalidToken, missingToken: missingToken, invalidTokenContainer: invalidTokenContainer)
    case (.period, .period):
      handleInvalidPeriod(invalidToken: invalidToken, missingToken: missingToken, invalidTokenContainer: invalidTokenContainer)
    case (.rawStringDelimiter, .rawStringDelimiter):
      handleInvalidRawStringDelimiter(invalidToken: invalidToken, missingToken: missingToken, invalidTokenContainer: invalidTokenContainer)
    default:
      _ = handleMissingSyntax(missingToken)
    }
  }

  private func handleInvalidIdentifier(invalidToken: TokenSyntax, missingToken: TokenSyntax, invalidTokenContainer: UnexpectedNodesSyntax) {
    let fixIts: [FixIt]
    if invalidToken.tokenKind.isLexerClassifiedKeyword || invalidToken.tokenKind.isDollarIdentifier {
      // TODO: Should the parser add the text with backticks to the missing
      // node? Then this could just make missing/present.
      fixIts = [
        FixIt(
          message: .wrapInBackticks,
          changes: [
            .replace(
              oldNode: Syntax(invalidToken),
              newNode: Syntax(TokenSyntax.identifier("`\(invalidToken.text)`", leadingTrivia: invalidToken.leadingTrivia, trailingTrivia: invalidToken.trailingTrivia))
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
  }

  private func handleInvalidPeriod(invalidToken: TokenSyntax, missingToken: TokenSyntax, invalidTokenContainer: UnexpectedNodesSyntax) {
    // Trailing trivia is the cause of this diagnostic, don't transfer it.
    let changes: [FixIt.Changes] = [
      .makeMissing(invalidToken, transferTrivia: false),
      .makePresent(missingToken),
    ]

    if let identifier = missingToken.nextToken(viewMode: .all),
      identifier.rawTokenKind == .identifier,
      identifier.presence == .missing
    {
      // The extraneous whitespace caused a missing identifier, output a
      // diagnostic inserting it instead of a diagnostic to fix the trivia
      // around the period.
      _ = handleMissingSyntax(
        identifier,
        overridePosition: invalidToken.endPositionBeforeTrailingTrivia,
        additionalChanges: changes,
        additionalHandledNodes: [invalidTokenContainer.id]
      )
    } else {
      let fixIt = FixIt(message: .removeExtraneousWhitespace, changes: changes)
      addDiagnostic(invalidToken, .invalidWhitespaceAfterPeriod, fixIts: [fixIt], handledNodes: [invalidTokenContainer.id])
    }
  }

  private func handleInvalidRawStringDelimiter(invalidToken: TokenSyntax, missingToken: TokenSyntax, invalidTokenContainer: UnexpectedNodesSyntax) {
    let message: DiagnosticMessage
    if missingToken.parent?.is(ExpressionSegmentSyntax.self) == true {
      message = .tooManyRawStringDelimitersToStartInterpolation
    } else {
      assert(
        missingToken.parent?.is(StringLiteralExprSyntax.self) == true,
        "Raw string delimiters should only occur in string interpolation and at the end of a string literal"
      )
      message = .tooManyClosingRawStringDelimiters
    }
    let fixIt = FixIt(
      message: .removeExtraneousDelimiters,
      changes: [
        .makeMissing(invalidToken),
        .makePresentBeforeTrivia(missingToken),
      ]
    )
    addDiagnostic(
      invalidToken,
      position: invalidToken.positionAfterSkippingLeadingTrivia.advanced(by: missingToken.contentLength.utf8Length),
      message,
      fixIts: [fixIt],
      handledNodes: [invalidTokenContainer.id]
    )
  }
}
