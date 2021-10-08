//===---------------------- SwiftSyntaxAssert.swift -----------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2021 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Foundation

fileprivate let forceEnableAssertions: Bool = {
	ProcessInfo.processInfo.environment["SWIFT_SYNTAX_FORCE_ENABLE_ASSERTIONS"] != nil
}()

/// A wrapper around `Swift.assert` that not only traps in `-Onone` builds but
/// also if the `SWIFT_SYNTAX_FORCE_ENABLE_ASSERTIONS` environment variable
/// is set.
func swiftSyntaxAssert(
  _ condition: @autoclosure () -> Bool,
  _ message: @autoclosure () -> String = String(),
  file: StaticString = #file,
  line: UInt = #line
) {
  if forceEnableAssertions {
    if !condition() {
      fatalError(message(), file: file, line: line)
    }
  } else {
    assert(condition(), message(), file: file, line: line)
  }
}
