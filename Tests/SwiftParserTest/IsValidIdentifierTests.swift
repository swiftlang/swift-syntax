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

import SwiftParser
import XCTest

/// Defines whether a name is expected to be a valid identifier in the given contexts.
private struct ValidIdentifierSpec: ExpressibleByBooleanLiteral {
  let variableName: Bool
  let memberAccess: Bool

  init(variableName: Bool, memberAccess: Bool) {
    self.variableName = variableName
    self.memberAccess = memberAccess
  }

  init(booleanLiteral value: BooleanLiteralType) {
    self.init(variableName: value, memberAccess: value)
  }
}

private func assertValidIdentifier(
  _ name: String,
  _ spec: ValidIdentifierSpec,
  file: StaticString = #file,
  line: UInt = #line
) {
  XCTAssertEqual(name.isValidSwiftIdentifier(for: .variableName), spec.variableName, "Checking identifier for variableName context", file: file, line: line)
  XCTAssertEqual(name.isValidSwiftIdentifier(for: .memberAccess), spec.memberAccess, "Checking identifier for memberAccess context", file: file, line: line)
}

class IsValidIdentifierTests: XCTestCase {
  func testIsValidIdentifier() {
    assertValidIdentifier("test", true)
    assertValidIdentifier("class", ValidIdentifierSpec(variableName: false, memberAccess: true))
    assertValidIdentifier("`class`", true)
    assertValidIdentifier("self", false)
    assertValidIdentifier("`self`", true)
    assertValidIdentifier("let", ValidIdentifierSpec(variableName: false, memberAccess: true))
    assertValidIdentifier("`let`", true)
    assertValidIdentifier("", false)
    assertValidIdentifier("test: Int", false)
    assertValidIdentifier("test ", false)
    assertValidIdentifier(" test", false)
    assertValidIdentifier("te st", false)
    assertValidIdentifier("test\0", false)
    assertValidIdentifier("test\0test", false)
    assertValidIdentifier("test(x:)", false)
    assertValidIdentifier("👩‍👩‍👧‍👧", true)
  }
}
