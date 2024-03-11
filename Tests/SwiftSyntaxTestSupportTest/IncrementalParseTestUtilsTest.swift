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

class IncrementalParseUtilTest: XCTestCase {
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
        IncrementalEdit(offset: 0, length: 5, replacement: "struct"),
        IncrementalEdit(offset: 27, length: 0, replacement: "let bar = 10"),
        IncrementalEdit(offset: 35, length: 13, replacement: ""),
      ]
    )

    let expectedSource =
      """
      struct foo {
        init() {
          let bar = 10
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
        IncrementalEdit(offset: 0, length: 25, replacement: "🎉")
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
        IncrementalEdit(offset: 0, length: 1, replacement: "👨‍👩‍👧‍👦")
      ]
    )
  }
}
