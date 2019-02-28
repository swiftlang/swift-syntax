import XCTest
import SwiftSyntax


public class CustomReflectableTests: XCTestCase {
  public static let allTests = [
    ("testConformanceToCustomReflectable", testConformanceToCustomReflectable),
  ]


  public func testConformanceToCustomReflectable() {
    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(getInput("near-empty.swift"))
      XCTAssertEqual(collectSyntaxNotConformedCustomReflectable(from: parsed), [])
    }())
    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(getInput("closure.swift"))
      XCTAssertEqual(collectSyntaxNotConformedCustomReflectable(from: parsed), [])
    }())
    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(getInput("nested-blocks.swift"))
      XCTAssertEqual(collectSyntaxNotConformedCustomReflectable(from: parsed), [])
    }())
    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(getInput("visitor.swift"))
      XCTAssertEqual(collectSyntaxNotConformedCustomReflectable(from: parsed), [])
    }())
  }


  public func collectSyntaxNotConformedCustomReflectable<S: Any>(from object: S) -> [String] {
    var paths = [String]()
    collectSyntaxNotConformedCustomReflectable(from: object, ancestors: ["root"], foundPaths: &paths)
    return paths
  }


  public func collectSyntaxNotConformedCustomReflectable<S: Any>(from object: S, ancestors: [String], foundPaths: inout [String]) {
    Mirror(reflecting: object).children.forEach { child in
      let (label: label, value: value) = child

      var currentPathComponents = ancestors
      currentPathComponents.append(label ?? "(nil)")

      if let syntax = value as? Syntax, !(syntax is CustomReflectable) {
        foundPaths.append("\(currentPathComponents.joined(separator: ".")): \(type(of: value as Any))")
      }

      collectSyntaxNotConformedCustomReflectable(from: value, ancestors: currentPathComponents, foundPaths: &foundPaths)
    }
  }
}
