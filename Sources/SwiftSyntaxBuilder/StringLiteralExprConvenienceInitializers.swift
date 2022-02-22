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

import SwiftSyntax

extension StringLiteralExpr {
  public init(_ value: String, openQuote: TokenSyntax = .stringQuote, closeQuote: TokenSyntax = .stringQuote) {
    let content = SyntaxFactory.makeToken(.stringSegment(value), presence: .present)
    let segment = StringSegment(content: content)
    let segments = StringLiteralSegments([segment])

    self.init(openQuote: openQuote,
              segments: segments,
              closeQuote: closeQuote)
  }
}
