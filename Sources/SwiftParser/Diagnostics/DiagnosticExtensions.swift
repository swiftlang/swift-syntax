//===--- DiagnosticExtensions.swift ---------------------------------------===//
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

import SwiftDiagnostics
import SwiftSyntax

extension FixIt {
  public init(message: FixItMessage, changes: [Changes]) {
    self.init(message: message, changes: FixIt.Changes(combining: changes))
  }

  // These overloads shouldn't be needed, but are currently required for the
  // Swift 5.5 compiler to handle non-trivial FixIt initializations using
  // leading-dot syntax.
  // TODO: These can be dropped once we require a minimum of Swift 5.6 to
  // compile the library.
  init(message: StaticParserFixIt, changes: Changes) {
    self.init(message: message as FixItMessage, changes: changes)
  }
  init(message: StaticParserFixIt, changes: [Changes]) {
    self.init(message: message as FixItMessage, changes: FixIt.Changes(combining: changes))
  }
}

extension FixIt.Changes {
  /// Replaced a present token with a missing node
  static func makeMissing(_ token: TokenSyntax) -> Self {
    return makeMissing([token])
  }

  /// Replace present tokens with missing tokens
  static func makeMissing(_ tokens: [TokenSyntax]) -> Self {
    assert(!tokens.isEmpty)
    assert(tokens.allSatisfy({ $0.presence == .present }))
    var changes = tokens.map {
      FixIt.Change.replace(
        oldNode: Syntax($0),
        newNode: Syntax(TokenSyntax($0.tokenKind, leadingTrivia: [], trailingTrivia: [], presence: .missing))
      )
    }
    if let firstToken = tokens.first,
       firstToken.leadingTrivia.isEmpty == false,
       let nextToken = tokens.last?.nextToken(viewMode: .sourceAccurate),
       !nextToken.leadingTrivia.contains(where: { $0.isNewline }) {
      changes.append(.replaceLeadingTrivia(token: nextToken, newTrivia: firstToken.leadingTrivia))
    }
    return FixIt.Changes(changes: changes)
  }

  static func makeMissing<SyntaxType: SyntaxProtocol>(_ node: SyntaxType) -> Self {
    return FixIt.Changes(changes: [
      .replace(oldNode: Syntax(node), newNode: MissingMaker().visit(Syntax(node)))
    ])
  }

  /// Make a node present. If `leadingTrivia` or `trailingTrivia` is specified,
  /// override the default leading/trailing trivia inferred from `BasicFormat`.
  static func makePresent<T: SyntaxProtocol>(
    _ node: T,
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil
  ) -> Self {
    var presentNode = PresentMaker().visit(Syntax(node))
    if let leadingTrivia = leadingTrivia {
      presentNode = presentNode.withLeadingTrivia(leadingTrivia)
    }
    if let trailingTrivia = trailingTrivia {
      presentNode = presentNode.withTrailingTrivia(trailingTrivia)
    }
    if node.shouldBeInsertedAfterNextTokenTrivia,
       let nextToken = node.nextToken(viewMode: .sourceAccurate),
       leadingTrivia == nil {
      return [
        .replace(
          oldNode: Syntax(node),
          newNode: Syntax(presentNode).withLeadingTrivia(nextToken.leadingTrivia)
        ),
        .replaceLeadingTrivia(token: nextToken, newTrivia: [])
      ]
    } else {
      return [.replace(
        oldNode: Syntax(node),
        newNode: Syntax(presentNode)
      )]
    }
  }

  /// Makes the `token` present, moving it in front of the previous token's trivia.
  static func makePresentBeforeTrivia(_ token: TokenSyntax) -> Self {
    if let previousToken = token.previousToken(viewMode: .sourceAccurate) {
      var presentToken = PresentMaker().visit(token).as(TokenSyntax.self)!
      if !previousToken.trailingTrivia.isEmpty {
        presentToken = presentToken.withTrailingTrivia(previousToken.trailingTrivia)
      }
      return [
        .replaceTrailingTrivia(token: previousToken, newTrivia: []),
        .replace(oldNode: Syntax(token), newNode: Syntax(presentToken)),
      ]
    } else {
      return .makePresent(token)
    }
  }
}
