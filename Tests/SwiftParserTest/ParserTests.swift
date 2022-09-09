import Dispatch
import XCTest
import SwiftSyntax
import SwiftParser

public class ParserTests: XCTestCase {
  /// Run a single parse test.
  func runParseTest(fileURL: URL, checkDiagnostics: Bool) throws {
    let fileContents = try String(contentsOf: fileURL)
    let parsed = try Parser.parse(source: fileContents)
    AssertStringsEqualWithDiff("\(parsed)", fileContents)

    if !checkDiagnostics {
      return
    }

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
  }

  /// Run parsr tests on all of the Swift files in the
  func runParserTests(name: String, path: URL, checkDiagnostics: Bool) {
    let fileURLs = FileManager.default
      .enumerator(at: path, includingPropertiesForKeys: nil)!
      .compactMap({ $0 as? URL })
      .filter({$0.pathExtension == "swift"})

    DispatchQueue.concurrentPerform(iterations: fileURLs.count) { fileURLIndex in
      let fileURL = fileURLs[fileURLIndex]
      do {
        try runParseTest(fileURL: fileURL, checkDiagnostics: checkDiagnostics)
      } catch {
        XCTFail("Test of \(fileURL) failed due to \(error)")
      }
    }
  }

  func testSelfParse() throws {
    // Allow skipping the self parse test in local development environments
    // because it takes very long compared to all the other tests.
    try XCTSkipIf(ProcessInfo.processInfo.environment["SKIP_SELF_PARSE"] == "1")
    let currentDir = URL(fileURLWithPath: #file)
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .appendingPathComponent("Sources")
    runParserTests(
      name: "Self-parse tests", path: currentDir, checkDiagnostics: true
    )
  }
}
