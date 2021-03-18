import XCTest
import SwiftSyntax
import SwiftSyntaxParser

public class SyntaxClassifierPerformanceTests: XCTestCase {

  var inputFile: URL {
    return URL(fileURLWithPath: #file)
      .deletingLastPathComponent()
      .appendingPathComponent("Inputs")
      .appendingPathComponent("MinimalCollections.swift.input")
  }

  func testParsingPerformance() {
    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(inputFile)

      measure {
        for _ in 0..<10 {
          for _ in parsed.classifications {}
        }
      }
    }())
  }
}
