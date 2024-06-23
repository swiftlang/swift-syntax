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
import SwiftLexicalScopes
import SwiftParser
import SwiftSyntax
import XCTest
import _SwiftSyntaxTestSupport

/// Parse `source` and check if the method passed as `methodUnderTest` produces the same results as indicated in `expected`.
///
/// The `methodUnderTest` provides test inputs taken from the `expected` dictionary. The closure should return result produced by the tested method as an array with the same ordering.
///
/// - Parameters:
///   - methodUnderTest: Closure with the tested method. Provides test argument from `expected` to the tested function. Should return method result as an array.
///   - expected: A dictionary with parameter markers as keys and expected results as marker arrays ordered as returned by the test method.
func assertLexicalScopeQuery(
  source: String,
  methodUnderTest: (SyntaxProtocol) -> ([SyntaxProtocol?]),
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
    let expectedValues: [SyntaxProtocol?] = expectedMarkers.map { expectedMarker in
      guard let expectedMarker else { return nil }

      guard let expectedPosition = markerDict[expectedMarker],
        let expectedToken = sourceFileSyntax.token(at: AbsolutePosition(utf8Offset: expectedPosition))
      else {
        XCTFail("Could not find token at location \(marker)")
        return nil
      }

      return expectedToken
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

      XCTAssert(
        actual?.firstToken(viewMode: .sourceAccurate)?.id == expected?.id,
        "For marker \(marker), actual result: \(actual?.firstToken(viewMode: .sourceAccurate) ?? "nil") doesn't match expected value: \(expected?.firstToken(viewMode: .sourceAccurate) ?? "nil")"
      )
    }
  }
}

/// Parse `source` and check if the lexical name lookup matches results passed as `expected`.
///
/// - Parameters:
///   - expected: A dictionary of markers with reference location as keys and expected declaration as values.
func assertLexicalNameLookup(
  source: String,
  references: [String: String?]
) {
  assertLexicalScopeQuery(
    source: source,
    methodUnderTest: { argument in
      // Extract reference name and use it for lookup
      guard let name = argument.firstToken(viewMode: .sourceAccurate)?.text else {
        XCTFail("Couldn't find a token at \(argument)")
        return []
      }
      return [LexicalScopes.lookupDeclarationFor(name: name, at: argument)]
    },
    expected: references.mapValues({ [$0] })
  )
}
