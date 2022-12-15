//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import XCTest
import IDEUtils
import SwiftSyntax
import SwiftSyntaxParser

public class SyntaxClassifierPerformanceTests: XCTestCase {

  var inputFile: URL {
    return URL(fileURLWithPath: #file)
      .deletingLastPathComponent()
      .appendingPathComponent("Inputs")
      .appendingPathComponent("MinimalCollections.swift.input")
  }

  func testParsingPerformance() {
    XCTAssertNoThrow(
      try {
        let parsed = try SyntaxParser.parse(inputFile)

        measure {
          for _ in 0..<10 {
            for _ in parsed.classifications {}
          }
        }
      }()
    )
  }
}
