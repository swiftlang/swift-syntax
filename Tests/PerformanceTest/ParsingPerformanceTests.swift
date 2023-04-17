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
import SwiftSyntax
import SwiftParser

public class ParsingPerformanceTests: XCTestCase {

  var inputFile: URL {
    return URL(fileURLWithPath: #file)
      .deletingLastPathComponent()
      .appendingPathComponent("Inputs")
      .appendingPathComponent("MinimalCollections.swift.input")
  }

  func testNativeParsingPerformance() throws {
    try XCTSkipIf(ProcessInfo.processInfo.environment["SKIP_LONG_TESTS"] == "1")
    measure {
      do {
        let source = try String(contentsOf: inputFile)
        _ = Parser.parse(source: source)
      } catch {
        XCTFail(error.localizedDescription)
      }
    }
  }
}
