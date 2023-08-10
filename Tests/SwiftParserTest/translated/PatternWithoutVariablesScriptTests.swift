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

// This test file has been translated from swift/test/Parse/pattern_without_variables_script.swift

import XCTest

final class PatternWithoutVariablesScriptTests: ParserTestCase {
  func testPatternWithoutVariablesScript1() {
    assertParse(
      """
      _ = 1
      """
    )
  }

}
