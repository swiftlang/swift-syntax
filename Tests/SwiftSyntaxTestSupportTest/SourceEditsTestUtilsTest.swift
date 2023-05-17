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
  public func testDiffOfTwoStringsSimple() throws {
    let s1 = "struct A { func f() {"
    let s2 = "struct AA { func f() {"

    let diffs = getConcurrentEdits(from: s1, to: s2)
    XCTAssertEqual(diffs.edits.count, 1)

    let firstDiff = try XCTUnwrap(diffs.edits.first)
    XCTAssertEqual(firstDiff, SourceEdit(offset: 8, length: 0, replacementLength: 1))
  }

  public func testDiffOfTwoSameStrings() {
    let s1 = "0123456"

    let diffs = getConcurrentEdits(from: s1, to: s1)
    XCTAssert(diffs.edits.isEmpty)
  }

  public func testDiffOfTwoStrings() {
    let s1 = "0123456"
    let s2 = "x12456yz"

    let diffs = getConcurrentEdits(from: s1, to: s2)

    let expectedDiffs: [SourceEdit] = [
      SourceEdit(offset: 0, length: 1, replacementLength: 1),
      SourceEdit(offset: 3, length: 1, replacementLength: 0),
      SourceEdit(offset: 7, length: 0, replacementLength: 2),
    ]

    XCTAssertEqual(diffs.edits, expectedDiffs)

    let s3 = applyEdits(expectedDiffs, concurrent: true, to: s1)

    XCTAssertEqual(s3, "?12456??")
  }
}
