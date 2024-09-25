//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

protocol CanInterleaveResultsLaterScopeSyntax: ScopeSyntax {
  /// Perform lookup in this scope and later introduce results
  /// passed as `resultsToInterleave`.
  /// The exact behavior depends on a specific scope.
  func lookupWithInterleavedResults(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig,
    resultsToInterleave: [LookupResult]
  ) -> [LookupResult]
}
