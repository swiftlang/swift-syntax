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

protocol HasTrailingComma {
  var trailingComma: TokenSyntax? { get }

  /// Returns this node overriding presence of the trailing comma
  func withTrailingComma(_ withComma: Bool) -> Self
}

extension HasTrailingComma {
  func ensuringTrailingComma() -> Self {
    trailingComma == nil ? withTrailingComma(true) : self
  }
}
