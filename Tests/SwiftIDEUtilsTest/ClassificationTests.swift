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
    assertClassification(
      """
      // blah.
      let x/*yo*/ = 0
      """,
      expected: [
        ClassificationSpec(source: "// blah.", kind: .lineComment),
        ClassificationSpec(source: "let", kind: .keyword),
        ClassificationSpec(source: "x", kind: .identifier),
        ClassificationSpec(source: "/*yo*/", kind: .blockComment),
        ClassificationSpec(source: "0", kind: .integerLiteral),
      ]
    )

    assertClassification(
      "x/*yo*/ ",
      in: ByteSourceRange(offset: 1, length: 6),
      expected: [
        ClassificationSpec(source: "x", kind: .identifier),
        ClassificationSpec(source: "/*yo*/", kind: .blockComment),
      ]
    )
  }

  public func testClassificationInCertainRange() {
    assertClassification(
      """
      // blah.
      let x/*yo*/ = 0
      """,
      in: ByteSourceRange(offset: 7, length: 8),
      expected: [
        ClassificationSpec(source: "// blah.", kind: .lineComment),
        ClassificationSpec(source: "let", kind: .keyword),
        ClassificationSpec(source: "x", kind: .identifier),
        ClassificationSpec(source: "/*yo*/", kind: .blockComment),
      ]
    )
  }

  public func testClassificationInEmptyRange() {
    assertClassification(
      """
      // blah.
      let x/*yo*/ = 0
      """,
      in: ByteSourceRange(offset: 21, length: 2),
      expected: []
    )
  }

  public func testClassificationAt() throws {
    let tree = Parser.parse(source: "func foo() {}")
    let keyword = try XCTUnwrap(tree.classification(at: 3))
    let identifier = try XCTUnwrap(tree.classification(at: AbsolutePosition(utf8Offset: 6)))

    XCTAssertEqual(keyword.kind, .keyword)
    XCTAssertEqual(keyword.range, ByteSourceRange(offset: 0, length: 4))

    XCTAssertEqual(identifier.kind, .identifier)
    XCTAssertEqual(identifier.range, ByteSourceRange(offset: 5, length: 3))
  }

  public func testTokenClassification() {
    assertClassification(
      """
      let x: Int
      """,
      expected: [
        ClassificationSpec(source: "let", kind: .keyword),
        ClassificationSpec(source: "x", kind: .identifier),
        ClassificationSpec(source: "Int", kind: .typeIdentifier),
      ]
    )
  }

  public func testOperatorTokenClassification() {
    assertClassification(
      """
        let x: Int = 4 + 5 / 6
      """,
      expected: [
        ClassificationSpec(source: "let", kind: .keyword),
        ClassificationSpec(source: "x", kind: .identifier),
        ClassificationSpec(source: "Int", kind: .typeIdentifier),
        ClassificationSpec(source: "4", kind: .integerLiteral),
        ClassificationSpec(source: "+", kind: .operatorIdentifier),
        ClassificationSpec(source: "5", kind: .integerLiteral),
        ClassificationSpec(source: "/", kind: .operatorIdentifier),
        ClassificationSpec(source: "6", kind: .integerLiteral),
      ]
    )

    assertClassification(
      "infix operator *--*",
      expected: [
        ClassificationSpec(source: "infix", kind: .keyword),
        ClassificationSpec(source: "operator", kind: .keyword),
        ClassificationSpec(source: "*--*", kind: .operatorIdentifier),
      ]
    )
  }
}
