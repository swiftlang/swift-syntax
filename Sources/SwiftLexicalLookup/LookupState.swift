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

/// Represents internal state for lookup.
/// It shouldn't be used by clients.
@_spi(Experimental) public struct LookupState {
  /// Specifies scopes that introduce names to their parent and
  /// should be skipped during lookup in sequential scopes.
  var skipSequentialIntroductionFrom: IntroducingToSequentialParentScopeSyntax?

  init() {}
}
