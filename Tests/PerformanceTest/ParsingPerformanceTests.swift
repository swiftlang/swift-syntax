import XCTest
import SwiftSyntax
import SwiftSyntaxParser
import SwiftParser

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

  func testNativeParsingPerformance() throws {
    measure {
      do {
        let source = try String(contentsOf: inputFile)
        _ = try SwiftParser.Parser.parse(source: source)
      } catch {
        XCTFail(error.localizedDescription)
      }
    }
  }
}
