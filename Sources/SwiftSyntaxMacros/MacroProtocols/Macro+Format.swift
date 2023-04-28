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

/// Describes the mode to use to format the result of an expansion.
public enum FormatMode {
  /// Perform a basic format of the expansion. This is primarily for inserting
  /// whitespace as required (eg. between two keywords), but also adds simple
  /// newline and indentation.
  case auto

  /// Disable automatically formatting the expanded macro. Trivia must be
  /// manually inserted where required (eg. adding spaces between keywords).
  case disabled
}

public extension Macro {
  static var formatMode: FormatMode {
    return .auto
  }
}
