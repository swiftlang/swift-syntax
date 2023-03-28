// This test file has been translated from swift/test/StringProcessing/Parse/regex_parse_end_of_buffer.swift

import XCTest

final class RegexParseEndOfBufferTests: XCTestCase {
  func testRegexParseEndOfBuffer1() {
    assertParse(
      """
      // Note there is purposefully no trailing newline here.
      var unterminated = 1️⃣#/(xy
      """,
      diagnostics: [
        DiagnosticSpec(message: "unterminated regex literal")
      ]
    )
  }

}
