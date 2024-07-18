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

@_spi(Experimental) public protocol IntroducingToSequentialParentScopeSyntax: ScopeSyntax {
  /// Returns names matching lookup that should be
  /// handled by it's parent sequential scope.
  func introducesToSequentialParent(
    for name: String?,
    at syntax: SyntaxProtocol,
    with config: LookupConfig
  ) -> [LookupResult]
}
