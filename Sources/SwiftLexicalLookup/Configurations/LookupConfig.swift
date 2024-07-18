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

import Foundation

@_spi(Experimental) public struct LookupConfig {
  /// Specifies behaviour of file scope.
  /// `memberBlockUpToLastDecl` by default.
  public var fileScopeHandling: FileScopeHandlingConfig

  /// Specifies scopes that introduce names to their parent and
  /// should be skipped during lookup in sequential scopes.
  public var ignoreChildrenToSequentialParentIntroductionsFrom: [IntroducingToSequentialParentScopeSyntax]

  public init(
    fileScopeHandling: FileScopeHandlingConfig = .memberBlockUpToLastDecl,
    ignoreChildrenToSequentialParentIntroductionsFrom: [IntroducingToSequentialParentScopeSyntax] = []
  ) {
    self.fileScopeHandling = fileScopeHandling
    self.ignoreChildrenToSequentialParentIntroductionsFrom = ignoreChildrenToSequentialParentIntroductionsFrom
  }
}
