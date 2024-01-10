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

/// A diagnostic that `MultiLineStringLiteralIndentationDiagnosticsGenerator` is building.
/// As indentation errors are found on more lines, this diagnostic is modified
/// to include more fixIts.
private struct InProgressDiagnostic {
  let anchor: TokenSyntax
  let position: AbsolutePosition
  let kind: InvalidIndentationInMultiLineStringLiteralError.Kind
  var lines: Int
  var changes: [FixIt.Change]
  var handledNodes: [SyntaxIdentifier]
}

final class MultiLineStringLiteralIndentationDiagnosticsGenerator: SyntaxVisitor {

  // MARK: Entry

  public static func diagnose(_ node: StringLiteralExprSyntax) -> [(diagnostic: Diagnostic, handledNodes: [SyntaxIdentifier])] {
    let visitor = MultiLineStringLiteralIndentationDiagnosticsGenerator(closeQuote: node.closingQuote)
    visitor.walk(node)
    visitor.finishInProgressDiagnostic()
    return visitor.finishedDiagnostics
  }

  // MARK: Implementation

  private let closeQuote: TokenSyntax

  /// Diagnostics that we have finished because their incorrect indentation was followed by correct indentation
  private var finishedDiagnostics: [(diagnostic: Diagnostic, handledNodes: [SyntaxIdentifier])] = []

  /// The diagnostic we are currently building up
  private var inProgressDiagnostic: InProgressDiagnostic?

  private init(closeQuote: TokenSyntax) {
    self.closeQuote = closeQuote
    super.init(viewMode: .sourceAccurate)
  }

  private func addIncorrectlyIndentedToken(token: TokenSyntax) {
    // Determine kind and position of the diagnostic
    var kind: InvalidIndentationInMultiLineStringLiteralError.Kind = .insufficientIndentation
    var position = token.positionAfterSkippingLeadingTrivia

    let tokenLeadingTrivia = token.leadingTrivia

    let indentationStartIndex = tokenLeadingTrivia.pieces.lastIndex(where: { $0.isNewline })?.advanced(by: 1) ?? tokenLeadingTrivia.startIndex
    let preIndentationTrivia = Trivia(pieces: tokenLeadingTrivia[0..<indentationStartIndex])
    let indentationTrivia = Trivia(pieces: tokenLeadingTrivia[indentationStartIndex...])
    var positionOffset = preIndentationTrivia.sourceLength.utf8Length

    for (invalidTriviaPiece, missingTriviaPiece) in zip(indentationTrivia.decomposed, closeQuote.leadingTrivia.decomposed) {
      if invalidTriviaPiece == missingTriviaPiece {
        positionOffset += invalidTriviaPiece.sourceLength.utf8Length
        continue
      }
      switch invalidTriviaPiece {
      case .tabs: kind = .unexpectedTab
      case .spaces: kind = .unexpectedSpace
      default: break
      }
      position = token.position.advanced(by: positionOffset)
      break
    }

    // If the diagnostic we are currently building has a different kind, we
    // cannot merge them. Commit the current diagnostic so we can create a new one.
    if inProgressDiagnostic?.kind != kind {
      finishInProgressDiagnostic()
    }

    // Append the inProgressDiagnostic or create a new one.
    let changes = [FixIt.Change.replaceLeadingTrivia(token: token, newTrivia: preIndentationTrivia + closeQuote.leadingTrivia)]
    let handledNodes = [token.id]
    if self.inProgressDiagnostic != nil {
      self.inProgressDiagnostic!.lines += 1
      self.inProgressDiagnostic!.changes += changes
      self.inProgressDiagnostic!.handledNodes += handledNodes
    } else {
      self.inProgressDiagnostic = InProgressDiagnostic(
        anchor: token,
        position: position,
        kind: kind,
        lines: 1,
        changes: changes,
        handledNodes: handledNodes
      )
    }
  }

  // Finish the diagnostic that's currently in progress so any new indentation
  // issue that's found will start a new diagnostic.
  private func finishInProgressDiagnostic() {
    guard let currentDiagnostic = self.inProgressDiagnostic else {
      return
    }

    let diagnostic = Diagnostic(
      node: Syntax(currentDiagnostic.anchor),
      position: currentDiagnostic.position,
      message: InvalidIndentationInMultiLineStringLiteralError(kind: currentDiagnostic.kind, lines: currentDiagnostic.lines),
      highlights: [],
      notes: [Note(node: Syntax(closeQuote), message: .shouldMatchIndentationOfClosingQuote)],
      fixIts: [FixIt(message: .changeIndentationToMatchClosingDelimiter, changes: currentDiagnostic.changes)]
    )

    finishedDiagnostics.append((diagnostic, currentDiagnostic.handledNodes))
    self.inProgressDiagnostic = nil
  }

  private func isOnNewline(_ token: TokenSyntax) -> Bool {
    if token.leadingTrivia.contains(where: { $0.isNewline }) {
      return true
    }
    guard let previousToken = token.previousToken(viewMode: .sourceAccurate) else {
      return false
    }
    switch previousToken.tokenKind {
    case .stringSegment(let stringSegment):
      return stringSegment.last?.isNewline ?? false
    default:
      return previousToken.trailingTrivia.contains(where: { $0.isNewline })
    }
  }

  override func visit(_ token: TokenSyntax) -> SyntaxVisitorContinueKind {
    guard isOnNewline(token) else {
      // We are only interested in tokens at the start of a line
      return .visitChildren
    }

    if token.tokenDiagnostic?.kind == .insufficientIndentationInMultilineStringLiteral {
      addIncorrectlyIndentedToken(token: token)
    } else {
      finishInProgressDiagnostic()
    }
    return .visitChildren
  }
}
