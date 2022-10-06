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
  init(message: StaticParserFixIt, changes: [Change]) {
    self.init(message: message as FixItMessage, changes: changes)
  }
}

extension FixIt.Change {
  /// Replaced a present node with a missing node
  static func makeMissing(node: TokenSyntax) -> FixIt.Change {
    assert(node.presence == .present)
    return .replace(
      oldNode: Syntax(node),
      newNode: Syntax(TokenSyntax(node.tokenKind, leadingTrivia: [], trailingTrivia: [], presence: .missing))
    )
  }

  static func makePresent<T: SyntaxProtocol>(node: T) -> FixIt.Change {
    return .replace(
      oldNode: Syntax(node),
      newNode: PresentMaker().visit(Syntax(node))
    )
  }
}

extension Array where Element == FixIt.Change {
  /// Makes the `token` present, moving it in front of the previous token's trivia.
  static func makePresentBeforeTrivia(token: TokenSyntax) -> [FixIt.Change] {
    if let previousToken = token.previousToken(viewMode: .sourceAccurate) {
      let presentToken = PresentMaker().visit(token).withTrailingTrivia(previousToken.trailingTrivia)
      return [
        .removeTrailingTrivia(previousToken),
        .replace(oldNode: Syntax(token), newNode: presentToken),
      ]
    } else {
      return [
        .makePresent(node: token)
      ]
    }
  }
}
