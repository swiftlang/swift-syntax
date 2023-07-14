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
  /// Creates a single-line documentation string from indented
  /// documentation as written in `CodeGeneration`.
  public var flattened: String {
    self
      .replacingOccurrences(of: "\n", with: "")
      .trimmingCharacters(in: .whitespacesAndNewlines)
  }

  /// Removes all empty lines from a multi-line string.
  public var removingEmptyLines: String {
    return
      self
      .split(whereSeparator: \.isNewline)
      .filter { !$0.allSatisfy(\.isWhitespace) }
      .joined(separator: "\n")
  }
}
