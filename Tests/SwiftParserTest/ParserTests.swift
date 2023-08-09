//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import _SwiftSyntaxTestSupport
import Dispatch
import XCTest
import SwiftSyntax
import SwiftParser
import SwiftParserDiagnostics

public class ParserTests: ParserTestCase {
  /// Run a single parse test.
  func runParseTest(fileURL: URL, checkDiagnostics: Bool) throws {
    let fileContents = try Data(contentsOf: fileURL)
    let parsed = fileContents.withUnsafeBytes({ buffer in
      // Release builds are fine with the default maximum nesting level of 256.
      // Debug builds overflow with any stack size bigger than 20-ish.
      Parser.parse(source: buffer.bindMemory(to: UInt8.self), maximumNestingLevel: 20)
    })
    assertDataEqualWithDiff(
      Data(parsed.syntaxTextBytes),
      fileContents,
      additionalInfo: "Failed in file \(fileURL)"
    )

    if !checkDiagnostics {
      return
    }

    let diagnostics = ParseDiagnosticsGenerator.diagnostics(for: parsed)
    if !diagnostics.isEmpty {
      var locationAndDiagnostics: [String] = []
      let locationConverter = SourceLocationConverter(fileName: fileURL.lastPathComponent, tree: parsed)
      for diag in diagnostics {
        let location = diag.location(converter: locationConverter)
        let message = diag.message
        locationAndDiagnostics.append("\(location): \(message)")
      }
      XCTFail(
        """
        Received the following diagnostics while parsing \(fileURL)
        \(locationAndDiagnostics.joined(separator: "\n"))
        """
      )
    }
  }

  /// Run parser tests on all of the Swift files in the given path, recursively.
  func runParserTests(
    name: String,
    path: URL,
    checkDiagnostics: Bool,
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

  let packageDir = URL(fileURLWithPath: #file)
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .deletingLastPathComponent()

  func testSelfParse() throws {
    // Allow skipping the self parse test in local development environments
    // because it takes very long compared to all the other tests.
    try XCTSkipIf(ProcessInfo.processInfo.environment["SKIP_LONG_TESTS"] == "1")
    let currentDir =
      packageDir
      .appendingPathComponent("Sources")
    runParserTests(
      name: "Self-parse tests",
      path: currentDir,
      checkDiagnostics: true
    )
  }

  /// Test all of the files in the "test" directory of the main Swift compiler.
  /// This requires the Swift compiler to have been checked out into the "swift"
  /// directory alongside swift-syntax.
  func testSwiftTestsuite() throws {
    try XCTSkipIf(ProcessInfo.processInfo.environment["SKIP_LONG_TESTS"] == "1")
    let testDir =
      packageDir
      .deletingLastPathComponent()
      .appendingPathComponent("swift")
      .appendingPathComponent("test")
    runParserTests(
      name: "Swift tests",
      path: testDir,
      checkDiagnostics: false
    )
  }

  /// Test all of the files in the "validation-text" directory of the main
  /// Swift compiler. This requires the Swift compiler to have been checked
  /// out into the "swift" directory alongside swift-syntax.
  func testSwiftValidationTestsuite() throws {
    try XCTSkipIf(ProcessInfo.processInfo.environment["SKIP_LONG_TESTS"] == "1")
    let testDir =
      packageDir
      .deletingLastPathComponent()
      .appendingPathComponent("swift")
      .appendingPathComponent("validation-test")
    runParserTests(
      name: "Swift validation tests",
      path: testDir,
      checkDiagnostics: false
    )
  }

  func testSelfParsePerformance() throws {
    try XCTSkipUnless(ProcessInfo.processInfo.environment["ENABLE_SELF_PARSE_PERFORMANCE"] == "1")

    let sourceDir = packageDir.appendingPathComponent("Sources")
    let files = try FileManager.default
      .enumerator(at: sourceDir, includingPropertiesForKeys: nil)!
      .compactMap({ $0 as? URL })
      .filter { $0.pathExtension == "swift" }
      .map { try Data(contentsOf: $0) }

    measure {
      for _ in 0..<10 {
        for file in files {
          file.withUnsafeBytes { buf in
            _ = Parser.parse(source: buf.bindMemory(to: UInt8.self))
          }
        }
      }
    }
  }

  func testConcurrentSelfParsePerformance() throws {
    try XCTSkipUnless(ProcessInfo.processInfo.environment["ENABLE_SELF_PARSE_PERFORMANCE"] == "1")

    let sourceDir = packageDir.appendingPathComponent("Sources")
    let files = try FileManager.default
      .enumerator(at: sourceDir, includingPropertiesForKeys: nil)!
      .compactMap({ $0 as? URL })
      .filter { $0.pathExtension == "swift" }
      .map { try Data(contentsOf: $0) }

    measure {
      DispatchQueue.concurrentPerform(iterations: files.count * 50) { i in
        let file = files[i % files.count]
        file.withUnsafeBytes { buf in
          _ = Parser.parse(source: buf.bindMemory(to: UInt8.self))
        }
      }
    }
  }
}
