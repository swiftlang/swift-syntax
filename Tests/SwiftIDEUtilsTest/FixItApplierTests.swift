//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_spi(FixItApplier) import SwiftIDEUtils
import SwiftSyntax
import XCTest

private extension SourceEdit {
  init(range: Range<Int>, replacement: String) {
    self.init(
      range: AbsolutePosition(utf8Offset: range.lowerBound)..<AbsolutePosition(utf8Offset: range.upperBound),
      replacement: replacement
    )
  }
}

class FixItApplierApplyEditsTests: XCTestCase {
  func testNoEdits() {
    assertAppliedEdits(
      to: "var x = 1",
      edits: [],
      output: "var x = 1"
    )
  }

  func testSingleEdit() {
    assertAppliedEdits(
      to: "var  x = 1",
      edits: [
        .init(range: 0..<4, replacement: "let")
      ],
      output: "let x = 1"
    )
  }

  func testNonOverlappingInsertions() {
    assertAppliedEdits(
      to: "x = 1",
      edits: [
        .init(range: 0..<0, replacement: "var "),
        .init(range: 1..<1, replacement: "var "),
        .init(range: 2..<2, replacement: "var "),
      ],
      output: "var xvar  var = 1"
    )
  }

  func testAdjacentReplacements() {
    assertAppliedEdits(
      to: "let x = 1",
      edits: [
        .init(range: 0..<5, replacement: "_"),
        .init(range: 5..<8, replacement: " == "),
        .init(range: 8..<9, replacement: "2"),
      ],
      output: "_ == 2"
    )
  }

  func testNonOverlappingReplacementAndInsertion() {
    assertAppliedEdits(
      to: "var x = 1",
      edits: [
        .init(range: 0..<3, replacement: "let"),  // Replacement
        .init(range: 0..<0, replacement: "a"),  // Insertion
      ],
      output: "alet x = 1"
    )

    assertAppliedEdits(
      to: "var x = 1",
      edits: [
        .init(range: 0..<5, replacement: "a"),  // Replacement
        .init(range: 5..<5, replacement: "b"),  // Insertion
      ],
      output: "ab = 1"
    )
  }

  func testNonOverlappingEditsSingleLine() {
    assertAppliedEdits(
      to: "var x = foo(1, 2)",
      edits: [
        .init(range: 0..<5, replacement: "_"),  // Replacement
        .init(range: 6..<7, replacement: "="),  // Replacement
        .init(range: 12..<12, replacement: "331"),  // Insertion
        .init(range: 8..<11, replacement: ""),  // Deletion
        // Adjacent, not overlapping.
        .init(range: 16..<16, replacement: "33"),  // Insertion
        .init(range: 15..<16, replacement: "11"),  // Replacement
      ],
      output: "_ = (3311, 1133)"
    )
  }

  func testNonOverlappingEditsMultiline() {
    assertAppliedEdits(
      to: """
        var x = 1
        var y = 2
        var z = 3
        var w = foo(1, 2)
        """,
      edits: [
        .init(range: 0..<3, replacement: "let"),  // Replacement
        .init(range: 19..<19, replacement: "44"),  // Insertion
        .init(range: 20..<24, replacement: ""),  // Deletion
        .init(range: 38..<41, replacement: "fooo"),  // Replacement
        .init(range: 46..<46, replacement: "33"),  // Insertion
        .init(range: 30..<34, replacement: ""),  // Deletion
      ],
      output: """
        let x = 1
        var y = 244
        z = 3
        w = fooo(1, 233)
        """
    )
  }

  func testNonOverlappingEditsCrossLine() {
    assertAppliedEdits(
      to: """
        var x = 1
        let y = 2
        var w = 3
        let z = 4
        """,
      edits: [
        .init(range: 6..<17, replacement: ""),
        .init(range: 17..<28, replacement: "= 5"),
      ],
      output: """
        var x = 53
        let z = 4
        """
    )
  }

  func testDuplicateReplacements() {
    assertAppliedEdits(
      to: "var x = 1",
      edits: [
        .init(range: 0..<3, replacement: "let"),
        .init(range: 0..<3, replacement: "let"),
        .init(range: 0..<3, replacement: "let"),
      ],
      output: "let x = 1"
    )
  }

  func testOverlappingEdits1() {
    assertAppliedEdits(
      to: "var foo = 1",
      edits: [
        .init(range: 0..<5, replacement: "ab"),
        .init(range: 3..<7, replacement: "cd"),
      ],
      // The second edit is skipped.
      outputs: [
        .init(oneOf: "aboo = 1", "varcd = 1")
      ]
    )
  }

  func testOverlappingEdits2() {
    assertAppliedEdits(
      to: "var x = 1",
      edits: [
        .init(range: 0..<5, replacement: "_"),
        .init(range: 0..<5, replacement: "_"),
        .init(range: 8..<8, replacement: "1"),
        .init(range: 0..<5, replacement: "_"),
        .init(range: 0..<3, replacement: "let"),
      ],
      outputs: [
        .init(oneOf: "_ = 11", "let x = 11")
      ]
    )
  }

  func testOverlappingInsertions() {
    assertAppliedEdits(
      to: "x = 1",
      edits: [
        .init(range: 1..<1, replacement: "y"),
        .init(range: 1..<1, replacement: "z"),
      ],
      outputs: [
        .init(oneOf: "xyz = 1", "xzy = 1")
      ]
    )

    assertAppliedEdits(
      to: "x = 1",
      edits: [
        .init(range: 0..<0, replacement: "var "),
        .init(range: 0..<0, replacement: "var "),
        .init(range: 4..<5, replacement: "2"),
        .init(range: 0..<0, replacement: "var "),
      ],
      outputs: [
        .init(deterministic: "var var var x = 2", allowDuplicateInsertions: true),
        .init(deterministic: "var x = 2", allowDuplicateInsertions: false),
      ]
    )
  }

  func testOverlappingReplacementAndInsertion() {
    assertAppliedEdits(
      to: "var x = 1",
      edits: [
        .init(range: 0..<5, replacement: "_"),  // Replacement
        .init(range: 2..<2, replacement: ""),  // Empty edit
      ],
      // Empty edit never overlaps with anything.
      output: "_ = 1"
    )

    assertAppliedEdits(
      to: "var x = 1",
      edits: [
        .init(range: 0..<5, replacement: "_"),  // Replacement
        .init(range: 2..<2, replacement: "a"),  // Insertion
      ],
      outputs: [
        .init(oneOf: "_ = 1", "vaar x = 1")
      ]
    )
  }
}

/// Represents an output expectation.
private struct OutputExpectation {
  var possibleOutputs: [String]
  var allowDuplicateInsertions: Bool?
  var line: UInt

  /// Create a deterministic output expectation for the given value of
  /// `allowDuplicateInsertions`. If `allowDuplicateInsertions` is `nil`,
  /// the expectation holds for both `true` and `false`.
  init(
    deterministic output: String,
    allowDuplicateInsertions: Bool? = nil,
    line: UInt = #line
  ) {
    self.possibleOutputs = [output]
    self.allowDuplicateInsertions = allowDuplicateInsertions
    self.line = line
  }

  /// Create a "one of the given possible outputs" expectation for the given
  /// value of `allowDuplicateInsertions`. If `allowDuplicateInsertions` is
  /// `nil`, the expectation holds for both `true` and `false`.
  init(
    oneOf possibleOutputs: String...,
    allowDuplicateInsertions: Bool? = nil,
    line: UInt = #line
  ) {
    self.possibleOutputs = possibleOutputs
    self.allowDuplicateInsertions = allowDuplicateInsertions
    self.line = line
  }
}

/// Asserts that the given outputs match the result of applying an array of
/// edits to `input`, for all permutations of `edits`.
private func assertAppliedEdits(
  to tree: SourceFileSyntax,
  edits: [SourceEdit],
  outputs: [OutputExpectation]
) {
  precondition(!outputs.isEmpty)

  NEXT_OUTPUT: for output in outputs {
    let allowDuplicateInsertionsValues =
      if let value = output.allowDuplicateInsertions {
        [value]
      } else {
        [true, false]
      }

    let possibleOutputs = output.possibleOutputs

    // Check this output against all permutations of edits.
    var indices = Array(edits.indices)
    while true {
      let editsPermutation = indices.map { edits[$0] }

      for allowDuplicateInsertionsValue in allowDuplicateInsertionsValues {
        let actualOutput = FixItApplier.apply(
          edits: editsPermutation,
          to: tree,
          allowDuplicateInsertions: allowDuplicateInsertionsValue
        )

        guard possibleOutputs.contains(actualOutput) else {
          XCTFail(
            """
            Actual output \"\(actualOutput)\" does not match one of \(possibleOutputs)
            Edits:
              \(editsPermutation)
            allowDuplicateInsertions:
              \(allowDuplicateInsertionsValue)
            """,
            line: output.line
          )

          // Fail once for all permutations to avoid excessive logging.
          continue NEXT_OUTPUT
        }
      }

      let keepGoing = indices.nextPermutation()
      guard keepGoing else {
        break
      }
    }
  }
}

/// Asserts that `output` matches the result of applying an array of edits to
/// `input`, for all permutations of `edits` and for `allowDuplicateInsertions`
/// both `true` and `false`.
private func assertAppliedEdits(
  to tree: SourceFileSyntax,
  edits: [SourceEdit],
  output: String,
  line: UInt = #line
) {
  assertAppliedEdits(
    to: tree,
    edits: edits,
    outputs: [
      .init(deterministic: output, allowDuplicateInsertions: nil, line: line)
    ]
  )
}

// Grabbed from https://github.com/apple/swift-algorithms/blob/main/Sources/Algorithms/Permutations.swift

private extension MutableCollection where Self: BidirectionalCollection {
  mutating func reverse(subrange: Range<Index>) {
    if subrange.isEmpty { return }
    var lower = subrange.lowerBound
    var upper = subrange.upperBound
    while lower < upper {
      formIndex(before: &upper)
      swapAt(lower, upper)
      formIndex(after: &lower)
    }
  }
}

private extension MutableCollection where Self: BidirectionalCollection, Element: Comparable {
  /// Permutes this collection's elements through all the lexical orderings.
  ///
  /// Call `nextPermutation()` repeatedly starting with the collection in sorted
  /// order. When the full cycle of all permutations has been completed, the
  /// collection will be back in sorted order and this method will return
  /// `false`.
  ///
  /// - Returns: A Boolean value indicating whether the collection still has
  ///   remaining permutations. When this method returns `false`, the collection
  ///   is in ascending order according to `areInIncreasingOrder`.
  ///
  /// - Complexity: O(*n*), where *n* is the length of the collection.
  mutating func nextPermutation(upperBound: Index? = nil) -> Bool {
    // Ensure we have > 1 element in the collection.
    guard !isEmpty else { return false }
    var i = index(before: endIndex)
    if i == startIndex { return false }

    let upperBound = upperBound ?? endIndex

    while true {
      let ip1 = i
      formIndex(before: &i)

      // Find the last ascending pair (ie. ..., a, b, ... where a < b)
      if self[i] < self[ip1] {
        // Find the last element greater than self[i]
        // swift-format-ignore: NeverForceUnwrap
        // This is _always_ at most `ip1` due to if statement above
        let j = lastIndex(where: { self[i] < $0 })!

        // At this point we have something like this:
        //    0, 1, 4, 3, 2
        //       ^        ^
        //       i        j
        swapAt(i, j)
        self.reverse(subrange: ip1..<endIndex)

        // Only return if we've made a change within ..<upperBound region
        if i < upperBound {
          return true
        } else {
          i = index(before: endIndex)
          continue
        }
      }

      if i == startIndex {
        self.reverse()
        return false
      }
    }
  }
}
