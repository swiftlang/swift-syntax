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

extension CatchClause {
  /// A convenience initializer that calculates spacing around the `catch` keyword.
  public init(
    leadingTrivia: Trivia = [],
    _ catchItems: CatchItemList,
    @CodeBlockItemListBuilder bodyBuilder: () -> ExpressibleAsCodeBlockItemList
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      catchKeyword: .catch.withTrailingTrivia(catchItems.elements.isEmpty ? [] : .space),
      catchItems: catchItems,
      body: bodyBuilder()
    )
  }
}
