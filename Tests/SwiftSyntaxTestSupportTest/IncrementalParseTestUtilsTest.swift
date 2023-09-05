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

import SwiftSyntax
import XCTest
import _SwiftSyntaxTestSupport

public class IncrementalParseUtilTest: XCTestCase {
  public func testGetConcurrentEdits() {
    let source =
      """
      ⏩️class⏸️struct⏪️ foo {
        init() {
          ⏩️⏸️let bar = 10⏪️
        }

        ⏩️func bar() {}⏸️⏪️
      }
      """

    let (concurrentEdits, originalSource, _) = extractEditsAndSources(from: source)

    XCTAssertEqual(
      concurrentEdits.edits,
      [
        IncrementalEdit(offset: 0, length: 5, replacementLength: 6),
        IncrementalEdit(offset: 27, length: 0, replacementLength: 12),
        IncrementalEdit(offset: 35, length: 13, replacementLength: 0),
      ]
    )

    let expectedSource =
      """
      ?????? foo {
        init() {
          ????????????
        }

        
      }
      """

    let sourceAppliedEdits = applyEdits(concurrentEdits.edits, concurrent: true, to: String(originalSource))

    XCTAssertEqual(sourceAppliedEdits, expectedSource)
  }

  public func testReplaceMultiByteCharWithShorter() {
    let source = "⏩️👨‍👩‍👧‍👦⏸️🎉⏪️"

    let (concurrentEdits, originalSource, editedSource) = extractEditsAndSources(from: source)

    XCTAssertEqual(String(originalSource), "👨‍👩‍👧‍👦")
    XCTAssertEqual(String(editedSource), "🎉")
    XCTAssertEqual(
      concurrentEdits.edits,
      [
        IncrementalEdit(offset: 0, length: 25, replacementLength: 4)
      ]
    )
  }

  public func testReplaceWithMultiByteChar() {
    let source = "⏩️a⏸️👨‍👩‍👧‍👦⏪️"

    let (concurrentEdits, originalSource, editedSource) = extractEditsAndSources(from: source)

    XCTAssertEqual(String(originalSource), "a")
    XCTAssertEqual(String(editedSource), "👨‍👩‍👧‍👦")
    XCTAssertEqual(
      concurrentEdits.edits,
      [
        IncrementalEdit(offset: 0, length: 1, replacementLength: 25)
      ]
    )
  }
}
