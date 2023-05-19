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
import SwiftSyntax
import SwiftParser
import _SwiftSyntaxTestSupport

public class IncrementalParsingTests: XCTestCase {
  public func testIncrementalInvalid() {
    let original = "struct A { func f() {"
    let newSource = "struct AA { func f() {"

    let concurrentEdits = getConcurrentEdits(from: original, to: newSource)

    let oldTree = Parser.parse(source: original)
    let lookup = IncrementalParseTransition(previousTree: oldTree, edits: concurrentEdits)
    let newTree = Parser.parse(source: newSource, parseTransition: lookup)

    XCTAssertEqual("\(newTree)", newSource)
  }

  public func testReusedNode() throws {
    try XCTSkipIf(true, "Swift parser does not handle node reuse yet")

    let original =
      """
      struct A {}
      struct B {}
      """

    let newSource =
      """
      struct AA {}
      struct B {}
      """

    let origTree = Parser.parse(source: original)
    let concurrentEdits = getConcurrentEdits(from: original, to: newSource)
    let reusedNodeCollector = IncrementalParseReusedNodeCollector()
    let transition = IncrementalParseTransition(previousTree: origTree, edits: concurrentEdits, reusedNodeDelegate: reusedNodeCollector)
    let newTree = Parser.parse(source: newSource, parseTransition: transition)
    XCTAssertEqual("\(newTree)", newSource)

    let origStructB = origTree.statements[1]
    let newStructB = newTree.statements[1]
    XCTAssertEqual("\(origStructB)", "\nstruct B {}")
    XCTAssertEqual("\(newStructB)", "\nstruct B {}")
    XCTAssertNotEqual(origStructB, newStructB)

    XCTAssertEqual(reusedNodeCollector.rangeAndNodes.count, 1)
    if reusedNodeCollector.rangeAndNodes.count != 1 { return }
    let (reusedRange, reusedNode) = reusedNodeCollector.rangeAndNodes[0]
    XCTAssertEqual("\(reusedNode)", "\nstruct B {}")

    XCTAssertEqual(newStructB.byteRange, reusedRange)
    XCTAssertEqual(origStructB.id, reusedNode.id)
    XCTAssertEqual(origStructB, reusedNode.as(CodeBlockItemSyntax.self))
    XCTAssertTrue(reusedNode.is(CodeBlockItemSyntax.self))
    XCTAssertEqual(origStructB, reusedNode.as(CodeBlockItemSyntax.self)!)
    XCTAssertEqual(origStructB.parent!.id, reusedNode.parent!.id)
  }
}
