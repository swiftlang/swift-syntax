import XCTest
import SwiftSyntax
import SwiftParser

public class ParserTests: XCTestCase {
  func testSelfParse() throws {
    let currentDir = URL(fileURLWithPath: #file)
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .appendingPathComponent("Sources")
    let fileURLs = FileManager.default
      .enumerator(at: currentDir, includingPropertiesForKeys: nil)!
      .compactMap({ $0 as? URL })
      .filter({$0.pathExtension == "swift"})
    for fileURL in fileURLs {
      XCTAssertNoThrow(try {
        let fileContents = try String(contentsOf: fileURL)
        let parsed = try Parser.parse(source: fileContents)
        AssertStringsEqualWithDiff("\(parsed)", fileContents)
      }())
    }
  }
}
