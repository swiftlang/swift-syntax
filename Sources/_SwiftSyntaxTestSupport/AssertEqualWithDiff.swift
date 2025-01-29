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

#if compiler(>=6)
public import Foundation
private import XCTest
private import _SwiftSyntaxGenericTestSupport
#else
import Foundation
import XCTest
import _SwiftSyntaxGenericTestSupport
#endif

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
  file: StaticString = #filePath,
  line: UInt = #line
) {
  let location = TestFailureLocation(
    fileID: "",  // Not used in the failure handler
    filePath: file,
    line: line,
    column: 0  // Not used in the failure handler
  )
  return _SwiftSyntaxGenericTestSupport.assertStringsEqualWithDiff(
    actual,
    expected,
    message,
    additionalInfo: additionalInfo(),
    location: location,
    failureHandler: {
      XCTFail($0.message, file: $0.location.filePath, line: $0.location.line)
    }
  )
}

/// Asserts that the two data are equal, providing Unix `diff`-style output if they are not.
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
public func assertDataEqualWithDiff(
  _ actual: Data,
  _ expected: Data,
  _ message: String = "",
  additionalInfo: @autoclosure () -> String? = nil,
  file: StaticString = #filePath,
  line: UInt = #line
) {
  if actual == expected {
    return
  }

  let actualString = String(decoding: actual, as: UTF8.self)
  let expectedString = String(decoding: expected, as: UTF8.self)

  if actualString == expectedString {
    XCTFail("Actual differs from expected data but underlying strings are equivalent", file: file, line: line)
  }

  assertStringsEqualWithDiff(
    actualString,
    expectedString,
    message,
    additionalInfo: additionalInfo(),
    file: file,
    line: line
  )
}
