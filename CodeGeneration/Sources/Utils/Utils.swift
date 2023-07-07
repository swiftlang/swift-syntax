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

/// Trims leading and trailing whitespace from each line.
public func dedented<Lines: Sequence>(lines: Lines) -> [String] where Lines.Element: StringProtocol {
  lines.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
}

/// Trims leading and trailing whitespace from each line.
public func dedented(string: String) -> String {
  dedented(lines: string.split(separator: "\n"))
    .joined(separator: "\n")
}

/// Creates a single-line documentation string from indented
/// documentation as written in `CodeGeneration`.
public func flattened(indentedDocumentation: String) -> String {
  dedented(string: indentedDocumentation)
    .replacingOccurrences(of: "\n", with: "")
    .trimmingCharacters(in: .whitespacesAndNewlines)
}

/// Removes all empty lines from a multi-line string.
public func removedEmptyLines(string: String) -> String {
  string.split(whereSeparator: \.isNewline)
    .filter { !$0.allSatisfy(\.isWhitespace) }
    .joined(separator: "\n")
}

public extension Collection {
  /// If the collection contains a single element, return it, otherwise `nil`.
  var only: Element? {
    if !isEmpty && index(after: startIndex) == endIndex {
      return self.first!
    } else {
      return nil
    }
  }
}
