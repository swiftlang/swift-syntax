import XCTest
import SwiftSyntax

public class ClassificationTests: XCTestCase {
  public static let allTests = [
    ("testClassification", testClassification),
  ]

  public func testClassification() {
    let source = "// blah.\nlet x/*yo*/ = 0"
    let tree = try! SyntaxParser.parse(source: source)
    do {
      let classif = Array(tree.classifications)
      XCTAssertEqual(classif.count, 4)
      guard classif.count == 4 else {
        return
      }
      XCTAssertEqual(classif[0].kind, .lineComment)
      XCTAssertEqual(classif[0].range, ByteSourceRange(offset: 0, length: 8))
      XCTAssertEqual(classif[1].kind, .keyword)
      XCTAssertEqual(classif[1].range, ByteSourceRange(offset: 9, length: 3))
      XCTAssertEqual(classif[2].kind, .blockComment)
      XCTAssertEqual(classif[2].range, ByteSourceRange(offset: 14, length: 6))
      XCTAssertEqual(classif[3].kind, .integerLiteral)
      XCTAssertEqual(classif[3].range, ByteSourceRange(offset: 23, length: 1))
    }
    do {
      let classif = Array(tree.classifications(in: ByteSourceRange(offset: 7, length: 8)))
      XCTAssertEqual(classif.count, 3)
      guard classif.count == 3 else {
        return
      }
      XCTAssertEqual(classif[0].kind, .lineComment)
      XCTAssertEqual(classif[0].range, ByteSourceRange(offset: 0, length: 8))
      XCTAssertEqual(classif[1].kind, .keyword)
      XCTAssertEqual(classif[1].range, ByteSourceRange(offset: 9, length: 3))
      XCTAssertEqual(classif[2].kind, .blockComment)
      XCTAssertEqual(classif[2].range, ByteSourceRange(offset: 14, length: 6))
    }
    do {
      let classif = Array(tree.classifications(in: ByteSourceRange(offset: 21, length: 1)))
      XCTAssertEqual(classif.count, 0)
    }
    do {
      let initializer = (tree.statements[0].item as! VariableDeclSyntax).bindings[0].initializer!
      XCTAssertEqual(initializer.description, "/*yo*/ = 0")
      // Classify with a relative range inside this node.
      let classif = Array(initializer.classifications(in: ByteSourceRange(offset: 5, length: 2)))
      XCTAssertEqual(classif.count, 1)
      guard classif.count == 1 else {
        return
      }
      XCTAssertEqual(classif[0].kind, .blockComment)
      XCTAssertEqual(classif[0].range, ByteSourceRange(offset: 14, length: 6))
    }
  }
}
