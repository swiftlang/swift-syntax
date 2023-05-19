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
import _SwiftSyntaxTestSupport

public class SourceEditsUtilTest: XCTestCase {
  public func testStringDifferenceReturnSequentialEdits() {
    let base = "0123"
    let new = "a0123bc"

    let diffs = getConcurrentEdits(from: base, to: new)
    XCTAssertEqual(
      diffs.edits,
      [
        SourceEdit(offset: 0, length: 0, replacementLength: 1),
        SourceEdit(offset: 4, length: 0, replacementLength: 2),
      ]
    )

    let appliedDiffsBase = applyEdits(diffs.edits, concurrent: true, to: base)

    XCTAssertEqual(appliedDiffsBase, "?0123??")
  }

  public func testDiffOfTwoStringsSimple() throws {
    let base = "struct A { func f() {"
    let new = "struct AA { func f() {"

    let diffs = getConcurrentEdits(from: base, to: new)
    XCTAssertEqual(diffs.edits.count, 1)

    let firstDiff = try XCTUnwrap(diffs.edits.first)
    XCTAssertEqual(firstDiff, SourceEdit(offset: 8, length: 0, replacementLength: 1))
  }

  public func testDiffOfTwoSameStrings() {
    let base = "0123456"

    let diffs = getConcurrentEdits(from: base, to: base)
    XCTAssert(diffs.edits.isEmpty)
  }

  public func testDiffOfTwoStrings() {
    let base = "0123456"
    let new = "x12456yz"

    let diffs = getConcurrentEdits(from: base, to: new)

    let expectedDiffs: [SourceEdit] = [
      SourceEdit(offset: 0, length: 1, replacementLength: 1),
      SourceEdit(offset: 3, length: 1, replacementLength: 0),
      SourceEdit(offset: 7, length: 0, replacementLength: 2),
    ]

    XCTAssertEqual(diffs.edits, expectedDiffs)

    let appliedDiffsBase = applyEdits(expectedDiffs, concurrent: true, to: base)

    XCTAssertEqual(appliedDiffsBase, "?12456??")
  }
}
