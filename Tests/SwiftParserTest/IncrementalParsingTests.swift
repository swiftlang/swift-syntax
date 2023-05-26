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
    let source = "struct A⏩️⏸️A⏪️ { func f() {"
    let (concurrentEdits, originalSubString, editedSubString) = getEditsAndSources(source)

    let originalSource = String(originalSubString)
    let editedSource = String(editedSubString)

    var tree = Parser.parse(source: originalSource)

    let lookup = IncrementalParseTransition(previousTree: tree, edits: concurrentEdits)
    tree = Parser.parse(source: editedSource, parseTransition: lookup)
    XCTAssertEqual("\(tree)", editedSource)
  }

  public func testReusedNode() throws {
    try XCTSkipIf(true, "Swift parser does not handle node reuse yet")

    let source =
      """
      struct A⏩️⏸️A⏪️ {}
      struct B {}
      """

    let (concurrentEdits, originalSubString, editedSubString) = getEditsAndSources(source)

    let originalSource = String(originalSubString)
    let editedSource = String(editedSubString)

    let origTree = Parser.parse(source: originalSource)
    let reusedNodeCollector = IncrementalParseReusedNodeCollector()
    let transition = IncrementalParseTransition(previousTree: origTree, edits: concurrentEdits, reusedNodeDelegate: reusedNodeCollector)
    let newTree = Parser.parse(source: editedSource, parseTransition: transition)
    XCTAssertEqual("\(newTree)", editedSource)

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
