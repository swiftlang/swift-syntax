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

  func testNativeParsingPerformance() {
    measure {
      do {
        let source = try String(contentsOf: inputFile)
        _ = SwiftParser.Parser.parse(source: source)
      } catch {
        XCTFail(error.localizedDescription)
      }
    }
  }
}
