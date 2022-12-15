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

public class VisitorPerformanceTests: XCTestCase {

  var inputFile: URL {
    return URL(fileURLWithPath: #file)
      .deletingLastPathComponent()
      .appendingPathComponent("Inputs")
      .appendingPathComponent("MinimalCollections.swift.input")
  }

  func testEmptyVisitorPerformance() {
    class EmptyVisitor: SyntaxVisitor {}

    XCTAssertNoThrow(
      try {
        let parsed = try SyntaxParser.parse(inputFile)

        let emptyVisitor = EmptyVisitor(viewMode: .sourceAccurate)

        measure {
          emptyVisitor.walk(parsed)
        }
      }()
    )
  }

  func testEmptyRewriterPerformance() {
    class EmptyRewriter: SyntaxRewriter {}

    XCTAssertNoThrow(
      try {
        let parsed = try SyntaxParser.parse(inputFile)

        let emptyRewriter = EmptyRewriter()

        measure {
          _ = emptyRewriter.visit(parsed)
        }
      }()
    )
  }

  func testEmptyAnyVistorPerformance() {
    class EmptyAnyVisitor: SyntaxAnyVisitor {}

    XCTAssertNoThrow(
      try {
        let parsed = try SyntaxParser.parse(inputFile)

        let emptyVisitor = EmptyAnyVisitor(viewMode: .sourceAccurate)

        measure {
          emptyVisitor.walk(parsed)
        }
      }()
    )
  }
}
