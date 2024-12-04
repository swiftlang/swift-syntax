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

import Dispatch
import SwiftParser
import SwiftParserDiagnostics
import SwiftSyntax
import XCTest
import _SwiftSyntaxTestSupport

class ParserTests: ParserTestCase {
  /// Run a single parse test.
  static func runParseTest(fileURL: URL, checkDiagnostics: Bool) throws {
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
    shouldExclude: @Sendable (URL) -> Bool = { _ in false }
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
        try Self.runParseTest(fileURL: fileURL, checkDiagnostics: checkDiagnostics)
      } catch {
        XCTFail("\(name): \(fileURL) failed due to \(error)")
      }
    }
  }

  let packageDir = URL(fileURLWithPath: #filePath)
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .deletingLastPathComponent()

  func testSelfParse() throws {
    // Allow skipping the self parse test in local development environments
    // because it takes very long compared to all the other tests.
    try XCTSkipIf(longTestsDisabled)
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
    try XCTSkipIf(longTestsDisabled)
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
    try XCTSkipIf(longTestsDisabled)
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
}
