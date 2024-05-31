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

import SwiftIDEUtils
import SwiftParser
import SwiftSyntax
import XCTest
import _SwiftSyntaxTestSupport

/// Parse `source` and checks its `classifications` is the same as `expected`.
///
/// The `expected` classifications should only contain classifications that are not `none`. All uncovered ranges are expected to have no classification.
///
/// - Parameters:
///   - range: An optional parameter to specify the ``ByteSourceRange`` in `source` that we want to test the `classifications` in.
///   - expected: The element order should respect to the order of  `ClassificationSpec.source` in `source`.
func assertClassification(
  _ source: String,
  in range: Range<AbsolutePosition>? = nil,
  expected: [ClassificationSpec],
  file: StaticString = #filePath,
  line: UInt = #line
) {
  let tree = Parser.parse(source: source)

  var classifications: Array<SyntaxClassifiedRange>
  if let range {
    classifications = Array(tree.classifications(in: range))
  } else {
    classifications = Array(tree.classifications)
  }
  classifications = classifications.filter { $0.kind != .none }

  if expected.count != classifications.count {
    XCTFail(
      "Expected \(expected.count) classifications \(classifications.count): \(classifications)",
      file: file,
      line: line
    )
  }

  var lastRangeUpperBound = source.startIndex
  for (classification, spec) in zip(classifications, expected) {
    guard let range = positionRange(of: spec.source, in: source, after: lastRangeUpperBound) else {
      XCTFail("Fail to find string in original source,", file: spec.file, line: spec.line)
      continue
    }

    XCTAssertEqual(
      range,
      classification.range,
      """
      Expected \(range) but received \(classification.range)
      """,
      file: spec.file,
      line: spec.line
    )

    XCTAssertEqual(
      spec.kind,
      classification.kind,
      """
      Expected \(spec.kind) syntax classification kind but received \(classification.kind)
      """,
      file: spec.file,
      line: spec.line
    )

    lastRangeUpperBound = source.utf8.index(source.utf8.startIndex, offsetBy: range.upperBound.utf8Offset)
  }
}

/// An abstract data structure to describe a source code snippet and its ``SyntaxClassification``.
struct ClassificationSpec {
  /// Source code  without any ``Trivia``
  let source: String
  /// The ``SyntaxClassification`` of the source code,
  let kind: SyntaxClassification
  /// The file and line at which this ``ClassificationSpec`` was created, so that assertion failures can be reported at its location.
  let file: StaticString
  let line: UInt

  init(
    source: String,
    kind: SyntaxClassification,
    file: StaticString = #filePath,
    line: UInt = #line
  ) {
    self.source = source
    self.kind = kind
    self.file = file
    self.line = line
  }
}
