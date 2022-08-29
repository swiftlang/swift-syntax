import XCTest
import SwiftSyntax
import SwiftParser

public class ParserTests: XCTestCase {
  func testSelfParse() throws {
    // Allow skipping the self parse test in local development environments
    // because it takes very long compared to all the other tests.
    try XCTSkipIf(ProcessInfo.processInfo.environment["SKIP_SELF_PARSE"] == "1")
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
        let diagnostics = ParseDiagnosticsGenerator.diagnostics(for: parsed)
        if !diagnostics.isEmpty {
          var locationAndDiagnostics: [String] = []
          let locationConverter = SourceLocationConverter(file: fileURL.lastPathComponent, tree: parsed)
          for diag in diagnostics {
            let location = diag.location(converter: locationConverter)
            let message = diag.message
            locationAndDiagnostics.append("\(location): \(message)")
          }
          XCTFail("""
          Received the following diagnostics while parsing \(fileURL)
          \(locationAndDiagnostics.joined(separator: "\n"))
          """)
        }
      }())
    }
  }
}
