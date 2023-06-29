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
import SwiftBasicFormat
import SwiftSyntax

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

  // These overloads shouldn't be needed, but are currently required for the
  // Swift 5.5 compiler to handle non-trivial FixIt initializations using
  // leading-dot syntax.
  // TODO: These can be dropped once we require a minimum of Swift 5.6 to
  // compile the library.
  init(message: StaticParserFixIt, changes: MultiNodeChange) {
    self.init(message: message as FixItMessage, changes: changes.primitiveChanges)
  }
  init(message: StaticParserFixIt, changes: [MultiNodeChange]) {
    self.init(message: message as FixItMessage, changes: MultiNodeChange(combining: changes).primitiveChanges)
  }
  public init(message: StaticParserFixIt, changes: [Change]) {
    self.init(message: message as FixItMessage, changes: changes)
  }
}

// MARK: - Make missing

extension FixIt.MultiNodeChange {
  /// Replaced a present token with a missing node.
  /// If `transferTrivia` is `true`, the leading and trailing trivia of the
  /// removed node will be transferred to the trailing trivia of the previous token.
  static func makeMissing(_ token: TokenSyntax, transferTrivia: Bool = true) -> Self {
    return makeMissing([token], transferTrivia: transferTrivia)
  }

  /// Replace present tokens with missing tokens.
  /// If `transferTrivia` is `true`, the leading and trailing trivia of the
  /// removed node will be transferred to the trailing trivia of the previous token.
  static func makeMissing(_ tokens: [TokenSyntax], transferTrivia: Bool = true) -> Self {
    precondition(!tokens.isEmpty)
    precondition(tokens.allSatisfy({ $0.presence == .present }))
    var changes = tokens.map {
      FixIt.Change.replace(
        oldNode: Syntax($0),
        newNode: Syntax($0.with(\.presence, .missing))
      )
    }
    if transferTrivia {
      changes += FixIt.MultiNodeChange.transferTriviaAtSides(from: tokens).primitiveChanges
    }
    return FixIt.MultiNodeChange(primitiveChanges: changes)
  }

  /// If `transferTrivia` is `true`, the leading and trailing trivia of the
  /// removed node will be transferred to the trailing trivia of the previous token.
  static func makeMissing<SyntaxType: SyntaxProtocol>(_ node: SyntaxType?, transferTrivia: Bool = true) -> Self {
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
  private static func transferTriviaAtSides<SyntaxType: SyntaxProtocol>(from nodes: [SyntaxType]) -> Self {
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
}

// MARK: - Make present

class MissingNodesBasicFormatter: BasicFormat {
  override func isMutable(_ token: TokenSyntax) -> Bool {
    // Assume that all missing nodes will be made present by the Fix-It.
    return token.presence == .missing
  }
}

extension FixIt.MultiNodeChange {
  /// Make a node present. If `leadingTrivia` or `trailingTrivia` is specified,
  /// override the default leading/trailing trivia inferred from `BasicFormat`.
  static func makePresent<T: SyntaxProtocol>(
    _ node: T,
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil
  ) -> Self {
    var presentNode = MissingNodesBasicFormatter(viewMode: .fixedUp).rewrite(node, detach: true)
    presentNode = PresentMaker().rewrite(presentNode)

    if let leadingTrivia = leadingTrivia {
      presentNode = presentNode.with(\.leadingTrivia, leadingTrivia)
    }
    if let trailingTrivia = trailingTrivia {
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

    if let previousToken = node.previousToken(viewMode: .fixedUp),
      previousToken.presence == .present,
      let firstToken = node.firstToken(viewMode: .all),
      previousToken.trailingTrivia.allSatisfy({ $0.isWhitespace }),
      !BasicFormat().requiresWhitespace(between: previousToken, and: firstToken),
      !BasicFormat().requiresNewline(between: previousToken, and: firstToken)
    {
      // If the previous token and this node don't need to be separated, remove
      // the separation.
      changes.append(.replaceTrailingTrivia(token: previousToken, newTrivia: []))
    }

    changes.append(
      .replace(
        oldNode: Syntax(node),
        newNode: Syntax(presentNode)
      )
    )

    return FixIt.MultiNodeChange(primitiveChanges: changes)
  }
}
