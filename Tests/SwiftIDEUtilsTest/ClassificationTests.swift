//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import XCTest
import SwiftIDEUtils
import SwiftSyntax
import SwiftParser
import _SwiftSyntaxTestSupport

public class ClassificationTests: XCTestCase {

  public func testClassification() {
    let source = """
      // blah.
      let x/*yo*/ = 0
      """
    let tree = Parser.parse(source: source)
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
      XCTAssertEqual(classif[0].range, ByteSourceRange(offset: 21, length: 2))
    }
    do {
      let pattern = (tree.statements[0].item.as(VariableDeclSyntax.self)!).bindings[0].pattern
      XCTAssertEqual(pattern.description, "x/*yo*/ ")
      // Classify with a relative range inside this node.
      let classif = Array(pattern.classifications(in: ByteSourceRange(offset: 5, length: 2)))
      XCTAssertEqual(classif.count, 2)
      guard classif.count == 2 else {
        return
      }
      XCTAssertEqual(classif[0].kind, .blockComment)
      XCTAssertEqual(classif[0].range, ByteSourceRange(offset: 14, length: 6))
      XCTAssertEqual(classif[1].kind, .none)
      XCTAssertEqual(classif[1].range, ByteSourceRange(offset: 20, length: 1))

      do {
        let singleClassif = pattern.classification(at: 5)
        XCTAssertEqual(singleClassif, classif[0])
      }
      do {
        let singleClassif = pattern.classification(at: AbsolutePosition(utf8Offset: 19))
        XCTAssertEqual(singleClassif, classif[0])
      }
    }

    do {
      let source = "func foo() {}"
      let tree = Parser.parse(source: source)
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
    let tree = Parser.parse(source: source)
    do {
      let tokens = Array(tree.tokens(viewMode: .sourceAccurate))
      XCTAssertEqual(tokens.count, 5)
      guard tokens.count == 5 else {
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
      XCTAssertEqual(classif[4].kind, .none)
      XCTAssertEqual(classif[4].range, ByteSourceRange(offset: 10, length: 0))
    }
    do {
      let tok = tree.lastToken(viewMode: .sourceAccurate)!.previousToken(viewMode: .sourceAccurate)!
      XCTAssertEqual("\(tok)", "Int")
      let classif = Array(tok.classifications).first!
      XCTAssertEqual(classif.kind, .typeIdentifier)
    }
  }

  public func testOperatorTokenClassification() {
    do {
      let source = "let x: Int = 4 + 5 / 6"
      let tree = Parser.parse(source: source)

      let tokens = Array(tree.tokens(viewMode: .sourceAccurate))
      XCTAssertEqual(tokens.count, 11)
      guard tokens.count == 11 else {
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
      XCTAssertEqual(classif[4].kind, .none)
      XCTAssertEqual(classif[4].range, ByteSourceRange(offset: 11, length: 1))
      XCTAssertEqual(classif[5].kind, .integerLiteral)
      XCTAssertEqual(classif[5].range, ByteSourceRange(offset: 13, length: 1))
      XCTAssertEqual(classif[6].kind, .operatorIdentifier)
      XCTAssertEqual(classif[6].range, ByteSourceRange(offset: 15, length: 1))
      XCTAssertEqual(classif[7].kind, .integerLiteral)
      XCTAssertEqual(classif[7].range, ByteSourceRange(offset: 17, length: 1))
      XCTAssertEqual(classif[8].kind, .operatorIdentifier)
      XCTAssertEqual(classif[8].range, ByteSourceRange(offset: 19, length: 1))
      XCTAssertEqual(classif[9].kind, .integerLiteral)
      XCTAssertEqual(classif[9].range, ByteSourceRange(offset: 21, length: 1))
      XCTAssertEqual(classif[10].kind, .none)
      XCTAssertEqual(classif[10].range, ByteSourceRange(offset: 22, length: 0))
    }

    do {
      let source = "infix operator *--*"
      let tree = Parser.parse(source: source)

      let tokens = Array(tree.tokens(viewMode: .sourceAccurate))
      XCTAssertEqual(tokens.count, 4)
      guard tokens.count == 4 else {
        return
      }
      let classif = tokens.map { $0.tokenClassification }
      XCTAssertEqual(classif[0].kind, .keyword)
      XCTAssertEqual(classif[0].range, ByteSourceRange(offset: 0, length: 5))
      XCTAssertEqual(classif[1].kind, .keyword)
      XCTAssertEqual(classif[1].range, ByteSourceRange(offset: 6, length: 8))
      XCTAssertEqual(classif[2].kind, .operatorIdentifier)
      XCTAssertEqual(classif[2].range, ByteSourceRange(offset: 15, length: 4))
      XCTAssertEqual(classif[3].kind, .none)
      XCTAssertEqual(classif[3].range, ByteSourceRange(offset: 19, length: 0))
    }
  }
}
