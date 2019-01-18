import XCTest
import SwiftSyntax

public class IncrementalParsingTestCase: XCTestCase {

  public static let allTests = [
    ("testIncrementalInvalid", testIncrementalInvalid),
  ]

  public func testIncrementalInvalid() {
    let original = "struct A { func f() {"
    let step: (String, (Int, Int, String)) =
      ("struct AA { func f() {", (8, 0, "A"))

    var tree = try! SyntaxParser.parse(source: original)
    let sourceEdit = SourceEdit(range: ByteSourceRange(offset: step.1.0, length: step.1.1), replacementLength: step.1.2.utf8.count)
    let lookup = IncrementalEditTransition(previousTree: tree, edits: [sourceEdit])
    tree = try! SyntaxParser.parse(source: step.0, parseLookup: lookup)
    XCTAssertEqual("\(tree)", step.0)
  }
}
