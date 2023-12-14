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

import SwiftSyntax

extension Range<AbsolutePosition> {
  /// Shift the range `utf8Offset` bytes to the right, ie. add `utf8Offset` to the upper and lower bound.
  func advanced(by utf8Offset: Int) -> Range<AbsolutePosition> {
    return self.lowerBound.advanced(by: utf8Offset)..<self.upperBound.advanced(by: utf8Offset)
  }
}
