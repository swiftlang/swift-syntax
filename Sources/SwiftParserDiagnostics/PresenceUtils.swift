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
@_spi(RawSyntax) import SwiftSyntax

/// Walks a tree and checks whether the tree contained any present tokens.
class PresentNodeChecker: SyntaxAnyVisitor {
  var hasPresentToken: Bool = false

  override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
    if hasPresentToken {
      // If we already saw a present token, we don't need to continue.
      return .skipChildren
    } else {
      return .visitChildren
    }
  }

  override func visit(_ node: TokenSyntax) -> SyntaxVisitorContinueKind {
    if node.isPresent {
      hasPresentToken = true
    }
    return .visitChildren
  }
}

extension SyntaxProtocol {
  /// Returns `true` if all tokens nodes in this tree are missing.
  var isMissingAllTokens: Bool {
    let checker = PresentNodeChecker(viewMode: .all)
    checker.walk(Syntax(self))
    return !checker.hasPresentToken
  }
}

/// Transforms a syntax tree by making all present tokens missing.
class MissingMaker: SyntaxRewriter {
  init() {
    super.init(viewMode: .sourceAccurate)
  }

  override func visit(_ node: TokenSyntax) -> TokenSyntax {
    guard node.isPresent else {
      return node
    }
    return TokenSyntax(node.tokenKind, presence: .missing)
  }
}
