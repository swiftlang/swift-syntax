//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// This test file has been translated from swift/test/Parse/multiline_pound_diagnostic_arg_rdar_41154797.swift

import XCTest

final class MultilinePoundDiagnosticArgRdar41154797Tests: XCTestCase {
  func testMultilinePoundDiagnosticArgRdar411547971() {
    AssertParse(
      ##"""
      #error("""1️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(message: #"expected '"""' to end string literal"#),
        DiagnosticSpec(message: "expected ')' to end '#error' directive"),
      ]
    )
  }

}
