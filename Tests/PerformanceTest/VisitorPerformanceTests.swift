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

    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(inputFile)

      let emptyVisitor = EmptyVisitor(viewMode: .sourceAccurate)

      measure {
        emptyVisitor.walk(parsed)
      }
    }())
  }

  func testEmptyRewriterPerformance() {
    class EmptyRewriter: SyntaxRewriter {}

    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(inputFile)

      let emptyRewriter = EmptyRewriter()

      measure {
        _ = emptyRewriter.visit(parsed)
      }
    }())
  }

  func testEmptyAnyVistorPerformance() {
    class EmptyAnyVisitor: SyntaxAnyVisitor {}

    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(inputFile)

      let emptyVisitor = EmptyAnyVisitor(viewMode: .sourceAccurate)

      measure {
        emptyVisitor.walk(parsed)
      }
    }())
  }
}
