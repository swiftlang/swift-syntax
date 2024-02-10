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

import SwiftBasicFormat
import SwiftDiagnostics
@_spi(RawSyntax) import SwiftSyntax

extension FixIt {
  /// A more complex set of changes that affects multiple syntax nodes and thus
  /// produces multiple `FixIt.Change`s. This allows us to e.g. mark a node as
  /// missing but keep the trivia by transferring it to the previous or next
  /// token.
  struct MultiNodeChange {
    var primitiveChanges: [Change]

    init(primitiveChanges: [Change]) {
      self.primitiveChanges = primitiveChanges
    }

    init(_ primitiveChanges: Change...) {
      self.init(primitiveChanges: primitiveChanges)
    }

    init(combining: [MultiNodeChange]) {
      self.init(primitiveChanges: combining.flatMap(\.primitiveChanges))
    }
  }

  init(message: FixItMessage, changes: [MultiNodeChange]) {
    self.init(message: message, changes: MultiNodeChange(combining: changes))
  }

  init(message: FixItMessage, changes: MultiNodeChange) {
    self.init(message: message, changes: changes.primitiveChanges)
  }
}

// MARK: - Make missing

extension FixIt.MultiNodeChange {
  /// Replaced a present token with a missing node.
  ///
  /// If `transferTrivia` is `true`, the leading and trailing trivia of the
  /// removed node will be transferred to the trailing trivia of the previous token.
  static func makeMissing(_ token: TokenSyntax, transferTrivia: Bool = true) -> Self {
    return makeMissing([token], transferTrivia: transferTrivia)
  }

  /// Replace present tokens with missing tokens.
  ///
  /// If `transferTrivia` is `true`, the leading trivia of the first token and
  /// the trailing trivia of the last token will be transferred to their adjecent
  /// tokens.
  static func makeMissing(_ tokens: [TokenSyntax], transferTrivia: Bool = true) -> Self {
    precondition(tokens.allSatisfy(\.isPresent))
    return .makeMissing(tokens.map(Syntax.init), transferTrivia: transferTrivia)
  }

  /// If `transferTrivia` is `true`, the leading and trailing trivia of the
  /// removed node will be transferred to the trailing trivia of the previous token.
  static func makeMissing(_ node: (some SyntaxProtocol)?, transferTrivia: Bool = true) -> Self {
    guard let node = node else {
      return FixIt.MultiNodeChange(primitiveChanges: [])
    }
    var changes = [FixIt.Change.replace(oldNode: Syntax(node), newNode: MissingMaker().rewrite(node, detach: true))]
    if transferTrivia {
      changes += FixIt.MultiNodeChange.transferTriviaAtSides(from: [node]).primitiveChanges
    }
    return FixIt.MultiNodeChange(primitiveChanges: changes)
  }

  /// Transfers the leading and trailing trivia of `nodes` to the previous token
  /// While doing this, it tries to be smart, merging trivia where it makes sense
  /// and refusing to add e.g. a space after punctuation, where it usually
  /// doesn't make sense.
  private static func transferTriviaAtSides(from nodes: [some SyntaxProtocol]) -> Self {
    let removedTriviaAtSides = (nodes.first?.leadingTrivia ?? []).merging(nodes.last?.trailingTrivia ?? [])
    if !removedTriviaAtSides.isEmpty, let previousToken = nodes.first?.previousToken(viewMode: .sourceAccurate) {
      let mergedTrivia = previousToken.trailingTrivia.merging(removedTriviaAtSides)
      if previousToken.tokenKind.isPunctuation, mergedTrivia.allSatisfy({ $0.isSpaceOrTab }) {
        // Punctuation is generally not followed by spaces in Swift.
        // If this action would only add spaces to the punctuation, drop it.
        // This generally yields better results.
        return FixIt.MultiNodeChange()
      }
      return FixIt.MultiNodeChange(.replaceTrailingTrivia(token: previousToken, newTrivia: mergedTrivia))
    } else {
      return FixIt.MultiNodeChange()
    }
  }

  /// Replace present nodes with their missing equivalents.
  ///
  /// If `transferTrivia` is `true`, the leading trivia of the first node and
  /// the trailing trivia of the last node will be transferred to their adjecent
  /// tokens.
  static func makeMissing(_ nodes: [Syntax], transferTrivia: Bool = true) -> Self {
    precondition(!nodes.isEmpty)
    var changes = nodes.map {
      FixIt.Change.replace(
        oldNode: $0,
        newNode: MissingMaker().rewrite($0, detach: true)
      )
    }
    if transferTrivia {
      changes += FixIt.MultiNodeChange.transferTriviaAtSides(from: nodes).primitiveChanges
    }
    return FixIt.MultiNodeChange(primitiveChanges: changes)
  }
}

// MARK: - Make present

class PresentMakingFormatter: BasicFormat {
  init() {
    super.init(viewMode: .fixedUp)
  }

  override func isMutable(_ token: TokenSyntax) -> Bool {
    // Assume that all missing nodes will be made present by the Fix-It.
    return token.isMissing
  }

  /// Change the text of all missing tokens to a placeholder with their
  /// name for diagnostics.
  override func transformTokenText(_ token: TokenSyntax) -> String? {
    guard token.isMissing else {
      return nil
    }

    let (rawKind, text) = token.tokenKind.decomposeToRaw()

    guard let text = text else {
      // The token has a default text that we cannot change.
      return nil
    }

    if text.isEmpty && rawKind != .stringSegment {
      // String segments are allowed to have empty text. Replace all other empty
      // tokens (e.g. missing identifiers) by a placeholder.
      return "<#\(token.tokenKind.nameForDiagnostics)#>"
    }

    return nil
  }

  /// Make all tokens present.
  override func transformTokenPresence(_ token: TokenSyntax) -> SourcePresence? {
    guard token.isMissing else {
      return nil
    }
    return .present
  }
}

extension FixIt.MultiNodeChange {
  /// Make a node present. If `leadingTrivia` or `trailingTrivia` is specified,
  /// override the default leading/trailing trivia inferred from `BasicFormat`.
  static func makePresent(
    _ node: some SyntaxProtocol,
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil
  ) -> Self {
    var presentNode = PresentMakingFormatter().rewrite(node, detach: true)

    if let leadingTrivia {
      presentNode = presentNode.with(\.leadingTrivia, leadingTrivia)
    }
    if let trailingTrivia {
      presentNode = presentNode.with(\.trailingTrivia, trailingTrivia)
    }

    var changes: [FixIt.Change] = []

    if node.shouldBeInsertedAfterNextTokenTrivia,
      let nextToken = node.nextToken(viewMode: .sourceAccurate),
      leadingTrivia == nil
    {
      // Move the next token's leading trivia to this node's leading trivia.
      changes.append(.replaceLeadingTrivia(token: nextToken, newTrivia: []))
      presentNode = presentNode.with(\.leadingTrivia, nextToken.leadingTrivia)

      // If this node and the next token need to be separated, insert a space.
      if let lastToken = node.lastToken(viewMode: .all),
        lastToken.trailingTrivia.isEmpty,
        BasicFormat().requiresWhitespace(between: lastToken, and: nextToken)
      {
        presentNode = presentNode.with(\.trailingTrivia, .space)
      }
    }

    if node.shouldBeInsertedBeforePreviousTokenTrivia,
      let previousToken = node.previousToken(viewMode: .fixedUp)
    {
      // If the previous token and this node don't need to be separated, remove
      // the separation.
      changes.append(.replaceTrailingTrivia(token: previousToken, newTrivia: []))
    }

    changes.append(
      .replace(
        oldNode: Syntax(node),
        newNode: presentNode
      )
    )

    return FixIt.MultiNodeChange(primitiveChanges: changes)
  }
}
