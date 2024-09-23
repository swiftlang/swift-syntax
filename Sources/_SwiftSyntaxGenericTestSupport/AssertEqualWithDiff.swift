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

/// Defines the location at which the a test failure should be anchored. This is typically the location where the
/// assertion function is called.
public struct TestFailureLocation {
  public let fileID: StaticString
  public let filePath: StaticString
  public let line: UInt
  public let column: UInt

  public init(
    fileID: StaticString,
    filePath: StaticString,
    line: UInt,
    column: UInt
  ) {
    self.fileID = fileID
    self.filePath = filePath
    self.line = line
    self.column = column
  }
}

/// Defines the details of a test failure, consisting of a message and the location at which the test failure should be
/// shown.
public struct TestFailureSpec {
  public let message: String
  public let location: TestFailureLocation
}

/// Asserts that the two strings are equal, providing Unix `diff`-style output if they are not.
///
/// - Parameters:
///   - actual: The actual string.
///   - expected: The expected string.
///   - message: An optional description of the failure.
///   - additionalInfo: Additional information about the failed test case that will be printed after the diff
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///     which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///     function was called.
public func assertStringsEqualWithDiff(
  _ actual: String,
  _ expected: String,
  _ message: String = "",
  additionalInfo: @autoclosure () -> String? = nil,
  location: TestFailureLocation,
  failureHandler: (TestFailureSpec) -> Void
) {
  if actual == expected {
    return
  }
  failStringsEqualWithDiff(
    actual,
    expected,
    message,
    additionalInfo: additionalInfo(),
    location: location,
    failureHandler: failureHandler
  )
}

/// `XCTFail` with `diff`-style output.
public func failStringsEqualWithDiff(
  _ actual: String,
  _ expected: String,
  _ message: String = "",
  additionalInfo: @autoclosure () -> String? = nil,
  location: TestFailureLocation,
  failureHandler: (TestFailureSpec) -> Void
) {
  let stringComparison: String

  // Use `CollectionDifference` on supported platforms to get `diff`-like line-based output. On
  // older platforms, fall back to simple string comparison.
  let actualLines = actual.split(separator: "\n", omittingEmptySubsequences: false)
  let expectedLines = expected.split(separator: "\n", omittingEmptySubsequences: false)

  let difference = actualLines.difference(from: expectedLines)

  var result = ""

  var insertions = [Int: Substring]()
  var removals = [Int: Substring]()

  for change in difference {
    switch change {
    case .insert(let offset, let element, _):
      insertions[offset] = element
    case .remove(let offset, let element, _):
      removals[offset] = element
    }
  }

  var expectedLine = 0
  var actualLine = 0

  while expectedLine < expectedLines.count || actualLine < actualLines.count {
    if let removal = removals[expectedLine] {
      result += "–\(removal)\n"
      expectedLine += 1
    } else if let insertion = insertions[actualLine] {
      result += "+\(insertion)\n"
      actualLine += 1
    } else {
      result += " \(expectedLines[expectedLine])\n"
      expectedLine += 1
      actualLine += 1
    }
  }

  stringComparison = result

  var fullMessage = """
    \(message.isEmpty ? "Actual output does not match the expected" : message)
    \(stringComparison)
    """
  if let additional = additionalInfo() {
    fullMessage = """
      \(fullMessage)
      \(additional)
      """
  }
  failureHandler(TestFailureSpec(message: fullMessage, location: location))
}
