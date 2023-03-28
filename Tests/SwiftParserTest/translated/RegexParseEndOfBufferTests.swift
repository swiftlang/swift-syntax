// This test file has been translated from swift/test/StringProcessing/Parse/regex_parse_end_of_buffer.swift

import XCTest

final class RegexParseEndOfBufferTests: XCTestCase {
  func testRegexParseEndOfBuffer1() {
    assertParse(
      "var unterminated = #/(xy1️⃣",
      diagnostics: [
        DiagnosticSpec(message: "expected '/#' to end regex literal")
      ]
    )
  }

}
