import XCTest
import SwiftSyntax

public class DecodeSyntaxTestCase: XCTestCase {
  public func testBasic() {
    XCTAssertNoThrow(try {
      let inputFile = getInput("visitor.swift")
      let source = try String(contentsOf: inputFile)
      let parsed = try SourceFileSyntax.parse(inputFile)
      XCTAssertEqual("\(parsed)", source)
    }())
  }
}
