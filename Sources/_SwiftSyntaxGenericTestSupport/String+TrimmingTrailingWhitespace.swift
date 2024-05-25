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

extension String {
  public func trimmingTrailingWhitespace() -> String {
    return
      self
      .split(separator: "\n", omittingEmptySubsequences: false)
      .map { $0.droppingLast(while: \.isWhitespace) }
      .joined(separator: "\n")
  }
}

public extension StringProtocol {
  func droppingLast(while predicate: (Character) -> Bool) -> String {
    return String(self.reversed().drop(while: predicate).reversed())
  }
}
