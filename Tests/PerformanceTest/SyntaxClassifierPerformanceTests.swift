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

import XCTest
import SwiftIDEUtils
import SwiftSyntax
import SwiftParser

public class SyntaxClassifierPerformanceTests: XCTestCase {

  var inputFile: URL {
    return URL(fileURLWithPath: #file)
      .deletingLastPathComponent()
      .appendingPathComponent("Inputs")
      .appendingPathComponent("MinimalCollections.swift.input")
  }

  func testClassifierPerformance() throws {
    try XCTSkipIf(ProcessInfo.processInfo.environment["SKIP_LONG_TESTS"] == "1")
    XCTAssertNoThrow(
      try {
        let source = try String(contentsOf: inputFile)
        let parsed = Parser.parse(source: source)

        measure {
          for _ in 0..<10 {
            for _ in parsed.classifications {}
          }
        }
      }()
    )
  }
}
