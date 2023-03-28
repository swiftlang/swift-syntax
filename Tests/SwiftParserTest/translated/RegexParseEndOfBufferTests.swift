// This test file has been translated from swift/test/StringProcessing/Parse/regex_parse_end_of_buffer.swift

import XCTest

final class RegexParseEndOfBufferTests: XCTestCase {
  func testRegexParseEndOfBuffer1() {
    AssertParse(
      """
      // Note there is purposefully no trailing newline here.
      var unterminated = 1️⃣#/(xy2️⃣
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "use of unknown directive '#'"),
        // TODO: Old parser expected error on line 2: unterminated regex literal
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ')' to end tuple"),
        // TODO: Old parser expected error on line 2: cannot parse regular expression: expected ')'
      ]
    )
  }

}
