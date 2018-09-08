import XCTest
import SwiftSyntax

public class DecodeSyntaxTestCase: XCTestCase {

  public static let allTests = [
    ("testBasic", testBasic),
  ]

  public func testBasic() {
    XCTAssertNoThrow(try {
      let inputFile = getInput("visitor.swift")
      let source = try String(contentsOf: inputFile)
      let parsed = try SyntaxTreeParser.parse(inputFile)
      XCTAssertEqual("\(parsed)", source)
    }())
  }
}
