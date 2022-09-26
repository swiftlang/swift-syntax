import Dispatch
import XCTest
import SwiftSyntax
import SwiftParser

public class ParserTests: XCTestCase {
  /// Run a single parse test.
  func runParseTest(fileURL: URL, checkDiagnostics: Bool) throws {
    let fileContents = try Data(contentsOf: fileURL)
    let parsed = try fileContents.withUnsafeBytes({ buffer in
      try Parser.parse(source: buffer.bindMemory(to: UInt8.self))
    })
    AssertDataEqualWithDiff(Data(parsed.syntaxTextBytes), fileContents,
                            additionalInfo: "Failed in file \(fileURL)")

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

  /// Run parsr tests on all of the Swift files in the given path, recursively.
  func runParserTests(
    name: String, path: URL, checkDiagnostics: Bool,
    shouldExclude: (URL) -> Bool = { _ in false }
  ) {
    let fileURLs = FileManager.default
      .enumerator(at: path, includingPropertiesForKeys: nil)!
      .compactMap({ $0 as? URL })
      .filter {
        $0.pathExtension == "swift"
        || $0.pathExtension == "sil"
        || $0.pathExtension == "swiftinterface"
      }

    print("\(name) - processing \(fileURLs.count) source files")
    DispatchQueue.concurrentPerform(iterations: fileURLs.count) { fileURLIndex in
      let fileURL = fileURLs[fileURLIndex]
      if shouldExclude(fileURL) {
        return
      }

      do {
        try runParseTest(fileURL: fileURL, checkDiagnostics: checkDiagnostics)
      } catch {
        XCTFail("\(name): \(fileURL) failed due to \(error)")
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

  /// Test all of the files in the "test" directory of the main Swift compiler.
  /// This requires the Swift compiler to have been checked out into the "swift"
  /// directory alongside swift-syntax.
  func testSwiftTestsuite() throws {
    try XCTSkipIf(ProcessInfo.processInfo.environment["SKIP_SELF_PARSE"] == "1")
    let testDir = URL(fileURLWithPath: #file)
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .appendingPathComponent("swift")
      .appendingPathComponent("test")
    runParserTests(
      name: "Swift tests", path: testDir, checkDiagnostics: false,
      shouldExclude: { fileURL in
        false

        // These tests overflow the parser.
        || fileURL.absoluteString.contains("_overflow")
        || fileURL.absoluteString.contains("parser-cutoff.swift")
      }
    )
  }

  /// Test all of the files in the "validation-text" directory of the main
  /// Swift compiler. This requires the Swift compiler to have been checked
  /// out into the "swift" directory alongside swift-syntax.
  func testSwiftValidationTestsuite() throws {
    try XCTSkipIf(ProcessInfo.processInfo.environment["SKIP_SELF_PARSE"] == "1")
    let testDir = URL(fileURLWithPath: #file)
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .appendingPathComponent("swift")
      .appendingPathComponent("validation-test")
    runParserTests(
      name: "Swift validation tests", path: testDir, checkDiagnostics: false,
      shouldExclude: { fileURL in
        false

        // Crashes due to deep recursion in the parser.
        || fileURL.absoluteString.contains("swift-lexer-leximpl.swift")
        || fileURL.absoluteString.contains("swift-inflightdiagnostic.swift")
        || fileURL.absoluteString.contains("swift-lexer-kindofidentifier.swift")
        || fileURL.absoluteString.contains("swift-lexer-lexidentifier.swift")
        || fileURL.absoluteString.contains("swift-parser-skipsingle.swift")
        || fileURL.absoluteString.contains("swift-lexer-kindofidentifier.swift")
        || fileURL.absoluteString.contains("swift-lexer-lexstringliteral.swift")
        || fileURL.absoluteString.contains("swift-lexer-lexoperatoridentifier.swift")
        || fileURL.absoluteString.contains("26089-swift-constraints-constraintsystem-getconstraintlocator.swift")
        || fileURL.absoluteString.contains("28616-swift-parser-parseexprsequence-swift-diag-bool-bool.swift")
        || fileURL.absoluteString.contains("26205-swift-lexer-leximpl.swift")
        || fileURL.absoluteString.contains("28686-swift-typebase-getcanonicaltype.swift")
        || fileURL.absoluteString.contains(
          "28591-swift-constraints-constraintsystem-solvesimplified-llvm-smallvectorimpl-swift-co.swift")
        || fileURL.absoluteString.contains("28678-result-case-not-implemented.swift")
        || fileURL.absoluteString.contains("28685-unreachable-executed-at-swift-lib-ast-type-cpp-1344.swift")
        || fileURL.absoluteString.contains(
          "28651-swift-cleanupillformedexpressionraii-doit-swift-expr-swift-astcontext-cleanupill.swift")
        || fileURL.absoluteString.contains("28681-swift-typebase-getcanonicaltype.swift")
        || fileURL.absoluteString.contains(
          "28684-isactuallycanonicalornull-forming-a-cantype-out-of-a-non-canonical-type.swift")
        || fileURL.absoluteString.contains("26659-swift-genericsignature-getcanonicalmanglingsignature.swift")
        || fileURL.absoluteString.contains("26162-swift-constraints-constraintsystem-getconstraintlocator.swift")
        || fileURL.absoluteString.contains("26161-swift-patternbindingdecl-setpattern.swift")
        || fileURL.absoluteString.contains("26101-swift-parser-parsenewdeclattribute.swift")
        || fileURL.absoluteString.contains("26773-swift-diagnosticengine-diagnose.swift")
        || fileURL.absoluteString.contains("parser-cutoff.swift")
        || fileURL.absoluteString.contains("26233-swift-iterabledeclcontext-getmembers.swift")
      }
    )
  }
}
