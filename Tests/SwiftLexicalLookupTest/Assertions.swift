//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Foundation
@_spi(Experimental) import SwiftLexicalLookup
import SwiftParser
import SwiftSyntax
import XCTest
import _SwiftSyntaxTestSupport

/// `methodUnderTest` is called with the token at every position marker in the keys of `expected`. It then asserts that the positions of the syntax nodes returned by `methodUnderTest` are the values in `expected`.
func assertLexicalScopeQuery(
  source: String,
  methodUnderTest: (TokenSyntax) -> ([SyntaxProtocol?]),
  expected: [String: [String?]]
) {
  // Extract markers
  let (markerDict, textWithoutMarkers) = extractMarkers(source)

  // Parse the test source
  var parser = Parser(textWithoutMarkers)
  let sourceFileSyntax = SourceFileSyntax.parse(from: &parser)

  // Iterate through the expected results
  for (marker, expectedMarkers) in expected {
    // Extract a test argument
    guard let position = markerDict[marker],
      let testArgument = sourceFileSyntax.token(at: AbsolutePosition(utf8Offset: position))
    else {
      XCTFail("Could not find token at location \(marker)")
      continue
    }

    // Execute the tested method
    let result = methodUnderTest(testArgument)

    // Extract the expected results for the test argument
    let expectedValues: [AbsolutePosition?] = expectedMarkers.map { expectedMarker in
      guard let expectedMarker else { return nil }

      guard let expectedPosition = markerDict[expectedMarker]
      else {
        XCTFail("Could not find token at location \(marker)")
        return nil
      }

      return AbsolutePosition(utf8Offset: expectedPosition)
    }

    // Compare number of actual results to the number of expected results
    if result.count != expectedValues.count {
      XCTFail(
        "For marker \(marker), actual number of elements: \(result.count) doesn't match the expected: \(expectedValues.count)"
      )
    }

    // Assert validity of the output
    for (actual, expected) in zip(result, expectedValues) {
      if actual == nil && expected == nil { continue }

      guard let actual, let expected else {
        XCTFail(
          "For marker \(marker), actual result: \(actual?.description ?? "nil"), expected position: \(expected.debugDescription)"
        )
        continue
      }

      XCTAssert(
        actual.positionAfterSkippingLeadingTrivia == expected,
        "For marker \(marker), actual result: \(actual.description) doesn't match expected value: \(sourceFileSyntax.token(at: expected) ?? "nil")"
      )
    }
  }
}
