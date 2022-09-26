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
