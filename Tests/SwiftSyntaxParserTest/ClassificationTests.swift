import XCTest
import SwiftSyntax
import SwiftSyntaxParser

public class ClassificationTests: XCTestCase {

  public func testClassification() {
    let source = "// blah.\nlet x/*yo*/ = 0"
    let tree = try! SyntaxParser.parse(source: source)
    do {
      let classif = Array(tree.classifications)
      XCTAssertEqual(classif.count, 8)
      guard classif.count == 8 else {
        return
      }
      XCTAssertEqual(classif[0].kind, .lineComment)
      XCTAssertEqual(classif[0].range, ByteSourceRange(offset: 0, length: 8))
      XCTAssertEqual(classif[1].kind, .none)
      XCTAssertEqual(classif[1].range, ByteSourceRange(offset: 8, length: 1))
      XCTAssertEqual(classif[2].kind, .keyword)
      XCTAssertEqual(classif[2].range, ByteSourceRange(offset: 9, length: 3))
      XCTAssertEqual(classif[3].kind, .none)
      XCTAssertEqual(classif[3].range, ByteSourceRange(offset: 12, length: 1))
      XCTAssertEqual(classif[4].kind, .identifier)
      XCTAssertEqual(classif[4].range, ByteSourceRange(offset: 13, length: 1))
      XCTAssertEqual(classif[5].kind, .blockComment)
      XCTAssertEqual(classif[5].range, ByteSourceRange(offset: 14, length: 6))
      XCTAssertEqual(classif[6].kind, .none)
      XCTAssertEqual(classif[6].range, ByteSourceRange(offset: 20, length: 3))
      XCTAssertEqual(classif[7].kind, .integerLiteral)
      XCTAssertEqual(classif[7].range, ByteSourceRange(offset: 23, length: 1))
    }
    do {
      let classif = Array(tree.classifications(in: ByteSourceRange(offset: 7, length: 8)))
      XCTAssertEqual(classif.count, 6)
      guard classif.count == 6 else {
        return
      }
      XCTAssertEqual(classif[0].kind, .lineComment)
      XCTAssertEqual(classif[0].range, ByteSourceRange(offset: 0, length: 8))
      XCTAssertEqual(classif[1].kind, .none)
      XCTAssertEqual(classif[1].range, ByteSourceRange(offset: 8, length: 1))
      XCTAssertEqual(classif[2].kind, .keyword)
      XCTAssertEqual(classif[2].range, ByteSourceRange(offset: 9, length: 3))
      XCTAssertEqual(classif[3].kind, .none)
      XCTAssertEqual(classif[3].range, ByteSourceRange(offset: 12, length: 1))
      XCTAssertEqual(classif[4].kind, .identifier)
      XCTAssertEqual(classif[4].range, ByteSourceRange(offset: 13, length: 1))
      XCTAssertEqual(classif[5].kind, .blockComment)
      XCTAssertEqual(classif[5].range, ByteSourceRange(offset: 14, length: 6))
    }
    do {
      let classif = Array(tree.classifications(in: ByteSourceRange(offset: 21, length: 1)))
      XCTAssertEqual(classif.count, 1)
      guard classif.count == 1 else {
        return
      }
      XCTAssertEqual(classif[0].kind, .none)
      XCTAssertEqual(classif[0].range, ByteSourceRange(offset: 20, length: 3))
    }
    do {
      let initializer = (tree.statements[0].item.as(VariableDeclSyntax.self)!).bindings[0].initializer!
      XCTAssertEqual(initializer.description, "/*yo*/ = 0")
      // Classify with a relative range inside this node.
      let classif = Array(initializer.classifications(in: ByteSourceRange(offset: 5, length: 2)))
      XCTAssertEqual(classif.count, 2)
      guard classif.count == 2 else {
        return
      }
      XCTAssertEqual(classif[0].kind, .blockComment)
      XCTAssertEqual(classif[0].range, ByteSourceRange(offset: 14, length: 6))
      XCTAssertEqual(classif[1].kind, .none)
      XCTAssertEqual(classif[1].range, ByteSourceRange(offset: 20, length: 3))

      do {
        let singleClassif = initializer.classification(at: 5)
        XCTAssertEqual(singleClassif, classif[0])
      }
      do {
        let singleClassif = initializer.classification(at: AbsolutePosition(utf8Offset: 19))
        XCTAssertEqual(singleClassif, classif[0])
      }
    }

    do {
      let source = "func foo() {}"
      let tree = try! SyntaxParser.parse(source: source)
      // For `classification(at:)` there's an initial walk to find the token that
      // the offset is contained in and the classified ranges are processed from that
      // token. That means that a `none` classified range would be restricted inside
      // the token range.
      let classif = tree.classification(at: 11)!
      XCTAssertEqual(classif.kind, .none)
      XCTAssertEqual(classif.range, ByteSourceRange(offset: 11, length: 1))
    }
  }

  public func testTokenClassification() {
    let source = "let x: Int"
    let tree = try! SyntaxParser.parse(source: source)
    do {
      let tokens = Array(tree.tokens(viewMode: .sourceAccurate))
      XCTAssertEqual(tokens.count, 4)
      guard tokens.count == 4 else {
        return
      }
      let classif = tokens.map { $0.tokenClassification }
      XCTAssertEqual(classif[0].kind, .keyword)
      XCTAssertEqual(classif[0].range, ByteSourceRange(offset: 0, length: 3))
      XCTAssertEqual(classif[1].kind, .identifier)
      XCTAssertEqual(classif[1].range, ByteSourceRange(offset: 4, length: 1))
      XCTAssertEqual(classif[2].kind, .none)
      XCTAssertEqual(classif[2].range, ByteSourceRange(offset: 5, length: 1))
      XCTAssertEqual(classif[3].kind, .typeIdentifier)
      XCTAssertEqual(classif[3].range, ByteSourceRange(offset: 7, length: 3))
    }
    do {
      let tok = tree.lastToken(viewMode: .sourceAccurate)!.previousToken(viewMode: .sourceAccurate)!
      XCTAssertEqual("\(tok)", "Int")
      let classif = Array(tok.classifications).first!
      XCTAssertEqual(classif.kind, .typeIdentifier)
    }
  }
}
