import XCTest
import SwiftSyntax

public class ParsingPerformanceTests: XCTestCase {

  var inputFile: URL {
    return URL(fileURLWithPath: #file)
      .deletingLastPathComponent()
      .appendingPathComponent("Inputs")
      .appendingPathComponent("MinimalCollections.swift.input")
  }

  func testParsingPerformance() {
    measure {
      do {
        _ = try SyntaxParser.parse(inputFile)
      } catch {
        XCTFail(error.localizedDescription)
      }
    }
  }
}
