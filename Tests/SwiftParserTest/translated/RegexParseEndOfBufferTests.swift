//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// This test file has been translated from swift/test/StringProcessing/Parse/regex_parse_end_of_buffer.swift

import XCTest

final class RegexParseEndOfBufferTests: ParserTestCase {
  func testRegexParseEndOfBuffer1() {
    assertParse(
      "var unterminated = #/(xy1️⃣",
      diagnostics: [
        DiagnosticSpec(message: "expected '/#' to end regex literal", fixIts: ["insert '/#'"])
      ],
      fixedSource: """
        var unterminated = #/(xy/#
        """
    )
  }
}
