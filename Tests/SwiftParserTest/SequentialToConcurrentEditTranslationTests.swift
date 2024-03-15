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

import SwiftParser
import SwiftSyntax
import XCTest
import _SwiftSyntaxTestSupport

let longString = """
  1234567890abcdefghijklmnopqrstuvwxyz\
  1234567890abcdefghijklmnopqrstuvwxyz\
  1234567890abcdefghijklmnopqrstuvwxyz\
  1234567890abcdefghijklmnopqrstuvwxyz\
  1234567890abcdefghijklmnopqrstuvwxyz\
  1234567890abcdefghijklmnopqrstuvwxyz\
  1234567890abcdefghijklmnopqrstuvwxyz\
  1234567890abcdefghijklmnopqrstuvwxyz\
  1234567890abcdefghijklmnopqrstuvwxyz\
  1234567890abcdefghijklmnopqrstuvwzyz
  """

/// Verifies that
///  1. translation of the `sequential` edits results in the
///     `expectedConcurrent` edits
///  2. applying the `sequential` and concurrent edits to `testString` results
///     in the same post-edit string
func verifySequentialToConcurrentTranslation(
  _ sequential: [IncrementalEdit],
  _ expectedConcurrent: [IncrementalEdit],
  testString: String = longString,
  file: StaticString = #file,
  line: UInt = #line
) {
  let concurrent = ConcurrentEdits(fromSequential: sequential)
  XCTAssertEqual(concurrent.edits, expectedConcurrent, file: file, line: line)
  XCTAssertEqual(
    applyEdits(sequential, concurrent: false, to: testString),
    applyEdits(concurrent.edits, concurrent: true, to: testString),
    file: file,
    line: line
  )
}

fileprivate extension IncrementalEdit {
  init(offset: Int, length: Int, replacement: String) {
    self.init(offset: offset, length: length, replacement: Array(replacement.utf8))
  }
}

final class TranslateSequentialToConcurrentEditsTests: ParserTestCase {
  func testEmpty() {
    verifySequentialToConcurrentTranslation([], [])
  }

  func testCreatingConcurrentFailsIfEditsDoNotSatisfyConcurrentRequirements() {
    XCTAssertThrowsError(
      try {
        try ConcurrentEdits(concurrent: [
          IncrementalEdit(offset: 5, length: 1, replacement: ""),
          IncrementalEdit(offset: 5, length: 1, replacement: ""),
        ])
      }()
    )
  }

  func testSingleEdit1() {
    verifySequentialToConcurrentTranslation(
      [
        IncrementalEdit(offset: 5, length: 1, replacement: "")
      ],
      [
        IncrementalEdit(offset: 5, length: 1, replacement: "")
      ]
    )
  }

  func testSingleEdit2() {
    verifySequentialToConcurrentTranslation(
      [
        IncrementalEdit(offset: 5, length: 0, replacement: "1")
      ],
      [
        IncrementalEdit(offset: 5, length: 0, replacement: "1")
      ]
    )
  }

  func testTwoNonOverlappingDeletesInFrontToBackOrder() {
    verifySequentialToConcurrentTranslation(
      [
        IncrementalEdit(offset: 5, length: 1, replacement: ""),
        IncrementalEdit(offset: 10, length: 2, replacement: ""),
      ],
      [
        IncrementalEdit(offset: 5, length: 1, replacement: ""),
        IncrementalEdit(offset: 11, length: 2, replacement: ""),
      ]
    )
  }

  func testTwoNonOverlappingDeletesInBackToFrontOrder() {
    verifySequentialToConcurrentTranslation(
      [
        IncrementalEdit(offset: 10, length: 2, replacement: ""),
        IncrementalEdit(offset: 5, length: 1, replacement: ""),
      ],
      [
        IncrementalEdit(offset: 5, length: 1, replacement: ""),
        IncrementalEdit(offset: 10, length: 2, replacement: ""),
      ]
    )
  }

  func testTwoNonOverlappingInsertionsInFrontToBackOrder() {
    verifySequentialToConcurrentTranslation(
      [
        IncrementalEdit(offset: 5, length: 0, replacement: "12"),
        IncrementalEdit(offset: 10, length: 0, replacement: "345"),
      ],
      [
        IncrementalEdit(offset: 5, length: 0, replacement: "12"),
        IncrementalEdit(offset: 8, length: 0, replacement: "345"),
      ]
    )
  }

  func testTwoNonOverlappingInsertionsInBackToFrontOrder() {
    verifySequentialToConcurrentTranslation(
      [
        IncrementalEdit(offset: 10, length: 0, replacement: "123"),
        IncrementalEdit(offset: 5, length: 0, replacement: "45"),
      ],
      [
        IncrementalEdit(offset: 5, length: 0, replacement: "45"),
        IncrementalEdit(offset: 10, length: 0, replacement: "123"),
      ]
    )
  }

  func testTwoNonOverlappingReplacementsInFrontToBackOrder() {
    verifySequentialToConcurrentTranslation(
      [
        IncrementalEdit(offset: 5, length: 4, replacement: "12"),
        IncrementalEdit(offset: 20, length: 5, replacement: "345"),
      ],
      [
        IncrementalEdit(offset: 5, length: 4, replacement: "12"),
        IncrementalEdit(offset: 22, length: 5, replacement: "345"),
      ]
    )
  }

  func testTwoNonOverlappingReplacementsInBackToFrontOrder() {
    verifySequentialToConcurrentTranslation(
      [
        IncrementalEdit(offset: 20, length: 5, replacement: "123"),
        IncrementalEdit(offset: 5, length: 4, replacement: "45"),
      ],
      [
        IncrementalEdit(offset: 5, length: 4, replacement: "45"),
        IncrementalEdit(offset: 20, length: 5, replacement: "123"),
      ]
    )
  }

  func testMultipleNonOverlappingEdits() {
    verifySequentialToConcurrentTranslation(
      [
        IncrementalEdit(offset: 0, length: 6, replacement: ""),
        IncrementalEdit(offset: 15, length: 7, replacement: "123456789"),
        IncrementalEdit(offset: 10, length: 0, replacement: "abc"),
        IncrementalEdit(offset: 30, length: 2, replacement: "AB"),
      ],
      [
        IncrementalEdit(offset: 0, length: 6, replacement: ""),
        IncrementalEdit(offset: 16, length: 0, replacement: "abc"),
        IncrementalEdit(offset: 21, length: 7, replacement: "123456789"),
        IncrementalEdit(offset: 31, length: 2, replacement: "AB"),
      ]
    )
  }

  func testTwoAdjacentEditsInBackToFrontOrder() {
    //                 [--- edit1 ----]
    // [--- edit2 ----]
    verifySequentialToConcurrentTranslation(
      [
        IncrementalEdit(offset: 10, length: 1, replacement: "xyz"),
        IncrementalEdit(offset: 5, length: 5, replacement: "a"),
      ],
      [
        IncrementalEdit(offset: 5, length: 6, replacement: "axyz")
      ]
    )
  }

  func testAdjacentReplaceAndDeleteInBackToFrontOrder() {
    //                 [--- edit1 ----]
    // [--- edit2 ----]
    verifySequentialToConcurrentTranslation(
      [
        IncrementalEdit(offset: 10, length: 1, replacement: "xyz"),
        IncrementalEdit(offset: 5, length: 5, replacement: ""),
      ],
      [
        IncrementalEdit(offset: 5, length: 6, replacement: "xyz")
      ]
    )
  }

  func testOverlappingBefore() {
    //            [--- edit1 ----]
    // [--- edit2 ----]
    verifySequentialToConcurrentTranslation(
      [
        IncrementalEdit(offset: 5, length: 3, replacement: "a"),
        IncrementalEdit(offset: 4, length: 2, replacement: "xy"),
      ],
      [
        IncrementalEdit(offset: 4, length: 4, replacement: "xy")
      ]
    )
  }

  func testEnclosing() {
    //      [--- edit1 ----]
    // [------- edit2 --------]
    verifySequentialToConcurrentTranslation(
      [
        IncrementalEdit(offset: 5, length: 3, replacement: "a"),
        IncrementalEdit(offset: 4, length: 4, replacement: "xy"),
      ],
      [
        IncrementalEdit(offset: 4, length: 6, replacement: "xy")
      ]
    )
  }

  func testTwoInsertionsAtSameLocation() {
    // [--- edit1 (length 0) ----]
    // [--- edit2 (length 0) ----]
    verifySequentialToConcurrentTranslation(
      [
        IncrementalEdit(offset: 5, length: 0, replacement: "a"),
        IncrementalEdit(offset: 5, length: 0, replacement: "xy"),
      ],
      [
        IncrementalEdit(offset: 5, length: 0, replacement: "xya")
      ]
    )
  }

  func testTwoReplacementsAtSameLocation() {
    // [--- edit1 ----]
    // [--- edit2 ----]
    verifySequentialToConcurrentTranslation(
      [
        IncrementalEdit(offset: 5, length: 1, replacement: "ab"),
        IncrementalEdit(offset: 5, length: 1, replacement: "xyz"),
      ],
      [
        IncrementalEdit(offset: 5, length: 1, replacement: "xyzb")
      ]
    )
  }

  func testTwoInsertionsAtSameLocationDifferentLength() {
    // [----- edit1 ------]
    // [--- edit2 ----]
    verifySequentialToConcurrentTranslation(
      [
        IncrementalEdit(offset: 5, length: 2, replacement: "ab"),
        IncrementalEdit(offset: 5, length: 1, replacement: "xyz"),
      ],
      [
        IncrementalEdit(offset: 5, length: 2, replacement: "xyzb")
      ]
    )
  }

  func testEnclosed() {
    // [-------- edit1 --------]
    //        [--- edit2 ----]
    verifySequentialToConcurrentTranslation(
      [
        IncrementalEdit(offset: 5, length: 5, replacement: "ab"),
        IncrementalEdit(offset: 6, length: 1, replacement: ""),
      ],
      [
        IncrementalEdit(offset: 5, length: 5, replacement: "a")
      ]
    )
  }

  func testOverlappingAfter() {
    // [---- edit1 ----]
    //        [--- edit2 ----]
    verifySequentialToConcurrentTranslation(
      [
        IncrementalEdit(offset: 3, length: 3, replacement: "ab"),
        IncrementalEdit(offset: 4, length: 3, replacement: "xy"),
      ],
      [
        IncrementalEdit(offset: 3, length: 5, replacement: "axy")
      ]
    )
  }

  func testTwoOverlappingInsertions() {
    verifySequentialToConcurrentTranslation(
      [
        IncrementalEdit(offset: 5, length: 0, replacement: "abc"),
        IncrementalEdit(offset: 6, length: 0, replacement: "xy"),
      ],
      [
        IncrementalEdit(offset: 5, length: 0, replacement: "axybc")
      ]
    )
  }

  /// Enable and run this test to randomly generate edit arrays and verify that
  /// translating them to sequential edits results in the same post-edit string.
  func disabledTestFuzz() {
    var i = 0
    while true {
      i += 1
      var edits: [IncrementalEdit] = []
      let numEdits = Int.random(in: 1..<10)
      for _ in 0..<numEdits {
        let replacementLength = Int.random(in: 0..<32)
        let replacementBytes = (0..<replacementLength).map { _ in
          (UInt8(ascii: "a")..<UInt8(ascii: "z")).randomElement()!
        }
        edits.append(
          IncrementalEdit(
            offset: Int.random(in: 0..<32),
            length: Int.random(in: 0..<32),
            replacement: replacementBytes
          )
        )
      }
      print(edits)
      let normalizedEdits = ConcurrentEdits(fromSequential: edits)
      if applyEdits(edits, concurrent: false, to: longString)
        != applyEdits(normalizedEdits.edits, concurrent: true, to: longString)
      {
        print("failed \(i)")
        fatalError()
      } else {
        print("passed \(i)")
      }
    }
  }
}
