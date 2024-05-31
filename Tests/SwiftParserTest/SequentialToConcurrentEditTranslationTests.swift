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
  _ sequential: [SourceEdit],
  _ expectedConcurrent: [SourceEdit],
  testString: String = longString,
  file: StaticString = #filePath,
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

final class TranslateSequentialToConcurrentEditsTests: ParserTestCase {
  func testEmpty() {
    verifySequentialToConcurrentTranslation([], [])
  }

  func testCreatingConcurrentFailsIfEditsDoNotSatisfyConcurrentRequirements() {
    XCTAssertThrowsError(
      try {
        try ConcurrentEdits(concurrent: [
          SourceEdit(
            range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 1)),
            replacement: ""
          ),
          SourceEdit(
            range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 1)),
            replacement: ""
          ),
        ])
      }()
    )
  }

  func testSingleEdit1() {
    verifySequentialToConcurrentTranslation(
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 1)),
          replacement: ""
        )
      ],
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 1)),
          replacement: ""
        )
      ]
    )
  }

  func testSingleEdit2() {
    verifySequentialToConcurrentTranslation(
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 1)),
          replacement: "1"
        )
      ],
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 1)),
          replacement: "1"
        )
      ]
    )
  }

  func testTwoNonOverlappingDeletesInFrontToBackOrder() {
    verifySequentialToConcurrentTranslation(
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 1)),
          replacement: ""
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 10), length: SourceLength(utf8Length: 2)),
          replacement: ""
        ),
      ],
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 1)),
          replacement: ""
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 11), length: SourceLength(utf8Length: 2)),
          replacement: ""
        ),
      ]
    )
  }

  func testTwoNonOverlappingDeletesInBackToFrontOrder() {
    verifySequentialToConcurrentTranslation(
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 10), length: SourceLength(utf8Length: 2)),
          replacement: ""
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 1)),
          replacement: ""
        ),
      ],
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 1)),
          replacement: ""
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 10), length: SourceLength(utf8Length: 2)),
          replacement: ""
        ),
      ]
    )
  }

  func testTwoNonOverlappingInsertionsInFrontToBackOrder() {
    verifySequentialToConcurrentTranslation(
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 0)),
          replacement: "12"
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 10), length: SourceLength(utf8Length: 0)),
          replacement: "345"
        ),
      ],
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 0)),
          replacement: "12"
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 8), length: SourceLength(utf8Length: 0)),
          replacement: "345"
        ),
      ]
    )
  }

  func testTwoNonOverlappingInsertionsInBackToFrontOrder() {
    verifySequentialToConcurrentTranslation(
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 10), length: SourceLength(utf8Length: 0)),
          replacement: "123"
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 0)),
          replacement: "45"
        ),
      ],
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 0)),
          replacement: "45"
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 10), length: SourceLength(utf8Length: 0)),
          replacement: "123"
        ),
      ]
    )
  }

  func testTwoNonOverlappingReplacementsInFrontToBackOrder() {
    verifySequentialToConcurrentTranslation(
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 4)),
          replacement: "12"
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 20), length: SourceLength(utf8Length: 5)),
          replacement: "345"
        ),
      ],
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 4)),
          replacement: "12"
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 22), length: SourceLength(utf8Length: 5)),
          replacement: "345"
        ),
      ]
    )
  }

  func testTwoNonOverlappingReplacementsInBackToFrontOrder() {
    verifySequentialToConcurrentTranslation(
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 20), length: SourceLength(utf8Length: 5)),
          replacement: "123"
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 4)),
          replacement: "45"
        ),
      ],
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 4)),
          replacement: "45"
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 20), length: SourceLength(utf8Length: 5)),
          replacement: "123"
        ),
      ]
    )
  }

  func testMultipleNonOverlappingEdits() {
    verifySequentialToConcurrentTranslation(
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 0), length: SourceLength(utf8Length: 6)),
          replacement: ""
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 15), length: SourceLength(utf8Length: 7)),
          replacement: "123456789"
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 10), length: SourceLength(utf8Length: 0)),
          replacement: "abc"
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 30), length: SourceLength(utf8Length: 2)),
          replacement: "AB"
        ),
      ],
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 0), length: SourceLength(utf8Length: 6)),
          replacement: ""
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 16), length: SourceLength(utf8Length: 0)),
          replacement: "abc"
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 21), length: SourceLength(utf8Length: 7)),
          replacement: "123456789"
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 31), length: SourceLength(utf8Length: 2)),
          replacement: "AB"
        ),
      ]
    )
  }

  func testTwoAdjacentEditsInBackToFrontOrder() {
    //                 [--- edit1 ----]
    // [--- edit2 ----]
    verifySequentialToConcurrentTranslation(
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 10), length: SourceLength(utf8Length: 1)),
          replacement: "xyz"
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 5)),
          replacement: "a"
        ),
      ],
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 6)),
          replacement: "axyz"
        )
      ]
    )
  }

  func testAdjacentReplaceAndDeleteInBackToFrontOrder() {
    //                 [--- edit1 ----]
    // [--- edit2 ----]
    verifySequentialToConcurrentTranslation(
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 10), length: SourceLength(utf8Length: 1)),
          replacement: "xyz"
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 5)),
          replacement: ""
        ),
      ],
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 6)),
          replacement: "xyz"
        )
      ]
    )
  }

  func testOverlappingBefore() {
    //            [--- edit1 ----]
    // [--- edit2 ----]
    verifySequentialToConcurrentTranslation(
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 3)),
          replacement: "a"
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 4), length: SourceLength(utf8Length: 2)),
          replacement: "xy"
        ),
      ],
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 4), length: SourceLength(utf8Length: 4)),
          replacement: "xy"
        )
      ]
    )
  }

  func testEnclosing() {
    //      [--- edit1 ----]
    // [------- edit2 --------]
    verifySequentialToConcurrentTranslation(
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 3)),
          replacement: "a"
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 4), length: SourceLength(utf8Length: 4)),
          replacement: "xy"
        ),
      ],
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 4), length: SourceLength(utf8Length: 6)),
          replacement: "xy"
        )
      ]
    )
  }

  func testTwoInsertionsAtSameLocation() {
    // [--- edit1 (length 0) ----]
    // [--- edit2 (length 0) ----]
    verifySequentialToConcurrentTranslation(
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 0)),
          replacement: "a"
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 0)),
          replacement: "xy"
        ),
      ],
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 0)),
          replacement: "xya"
        )
      ]
    )
  }

  func testTwoReplacementsAtSameLocation() {
    // [--- edit1 ----]
    // [--- edit2 ----]
    verifySequentialToConcurrentTranslation(
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 1)),
          replacement: "ab"
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 1)),
          replacement: "xyz"
        ),
      ],
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 1)),
          replacement: "xyzb"
        )
      ]
    )
  }

  func testTwoInsertionsAtSameLocationDifferentLength() {
    // [----- edit1 ------]
    // [--- edit2 ----]
    verifySequentialToConcurrentTranslation(
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 2)),
          replacement: "ab"
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 1)),
          replacement: "xyz"
        ),
      ],
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 2)),
          replacement: "xyzb"
        )
      ]
    )
  }

  func testEnclosed() {
    // [-------- edit1 --------]
    //        [--- edit2 ----]
    verifySequentialToConcurrentTranslation(
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 5)),
          replacement: "ab"
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 6), length: SourceLength(utf8Length: 1)),
          replacement: ""
        ),
      ],
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 5)),
          replacement: "a"
        )
      ]
    )
  }

  func testOverlappingAfter() {
    // [---- edit1 ----]
    //        [--- edit2 ----]
    verifySequentialToConcurrentTranslation(
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 3), length: SourceLength(utf8Length: 3)),
          replacement: "ab"
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 4), length: SourceLength(utf8Length: 3)),
          replacement: "xy"
        ),
      ],
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 3), length: SourceLength(utf8Length: 5)),
          replacement: "axy"
        )
      ]
    )
  }

  func testTwoOverlappingInsertions() {
    verifySequentialToConcurrentTranslation(
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 0)),
          replacement: "abc"
        ),
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 6), length: SourceLength(utf8Length: 0)),
          replacement: "xy"
        ),
      ],
      [
        SourceEdit(
          range: Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 0)),
          replacement: "axybc"
        )
      ]
    )
  }

  /// Enable and run this test to randomly generate edit arrays and verify that
  /// translating them to sequential edits results in the same post-edit string.
  func disabledTestFuzz() {
    var i = 0
    while true {
      i += 1
      var edits: [SourceEdit] = []
      let numEdits = Int.random(in: 1..<10)
      for _ in 0..<numEdits {
        let replacementLength = Int.random(in: 0..<32)
        let replacementBytes = (0..<replacementLength).map { _ in
          (UInt8(ascii: "a")..<UInt8(ascii: "z")).randomElement()!
        }
        edits.append(
          SourceEdit(
            range: AbsolutePosition(
              utf8Offset: Int.random(in: 0..<32)
            )..<AbsolutePosition(utf8Offset: Int.random(in: 0..<32)),
            replacement: String(data: Data(replacementBytes), encoding: .ascii)!
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
