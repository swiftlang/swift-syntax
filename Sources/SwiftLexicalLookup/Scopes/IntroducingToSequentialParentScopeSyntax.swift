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

protocol IntroducingToSequentialParentScopeSyntax: ScopeSyntax {
  /// Returns all names introduced to parent.
  var namesIntroducedToSequentialParent: [LookupName] { get }

  /// Returns results matching lookup that should be
  /// interleaved with results of the sequential parent.
  func lookupFromSequentialParent(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult]
}
