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

@_spi(Experimental) import SwiftLexicalLookup
import SwiftParser
import SwiftSyntax
import XCTest
import _SwiftSyntaxTestSupport

/// Used to define result type expectectations for given markers.
enum MarkerExpectation {
  /// Specifies a separate type for each result marker.
  case distinct([String: SyntaxProtocol.Type])
  /// Specifies a common type for all results
  /// apart from the ones defined explicitly in `except`.
  case all(SyntaxProtocol.Type, except: [String: SyntaxProtocol.Type] = [:])
  /// Does not assert result types.
  case none

  /// Assert `actual` result labeled with `marker`
  /// according to the rules represented by this expectation.
  fileprivate func assertMarkerType(marker: String, actual: SyntaxProtocol) {
    switch self {
    case .all(let expectedType, except: let dictionary):
      assertMarkerType(marker: marker, actual: actual, expectedType: dictionary[marker] ?? expectedType)
    case .distinct(let dictionary):
      if let expectedType = dictionary[marker] {
        assertMarkerType(marker: marker, actual: actual, expectedType: expectedType)
      } else {
        XCTFail("For result \(marker), could not find type expectation")
      }
    case .none:
      break
    }
  }

  /// Assert whether `actual` type matches `expectedType`.
  private func assertMarkerType(marker: String, actual: SyntaxProtocol, expectedType: SyntaxProtocol.Type) {
    XCTAssert(
      actual.is(expectedType),
      "For result \(marker), expected type \(expectedType) doesn't match the actual type \(actual.syntaxNodeType)"
    )
  }
}

/// Used to define result assertion.
enum ResultExpectation {
  case fromScope(ScopeSyntax.Type, expectedNames: [String])
  case fromFileScope(expectedNames: [String])

  var expectedNames: [String] {
    switch self {
    case .fromScope(_, let expectedNames):
      return expectedNames
    case .fromFileScope(expectedNames: let expectedNames):
      return expectedNames
    }
  }
}

/// `methodUnderTest` is called with the token at every position marker in the keys of `expected`.
/// It then asserts that the positions of the syntax nodes returned by `methodUnderTest` are the values in `expected`.
/// It also checks whether result types match rules specified in `expectedResultTypes`.
func assertLexicalScopeQuery(
  source: String,
  methodUnderTest: (_ marker: String, _ tokenAtMarker: TokenSyntax) -> ([SyntaxProtocol?]),
  expected: [String: [String?]],
  expectedResultTypes: MarkerExpectation = .none
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
    let result = methodUnderTest(marker, testArgument)

    // Extract the expected results for the test argument
    let expectedPositions: [AbsolutePosition?] = expectedMarkers.map { expectedMarker in
      guard let expectedMarker else { return nil }

      guard let expectedPosition = markerDict[expectedMarker]
      else {
        XCTFail("Could not find position for \(marker)")
        return nil
      }

      return AbsolutePosition(utf8Offset: expectedPosition)
    }

    // Compare number of actual results to the number of expected results
    if result.count != expectedPositions.count {
      XCTFail(
        "For marker \(marker), actual number of elements: \(result.count) doesn't match the expected: \(expectedPositions.count)"
      )
    }

    // Assert validity of the output
    for (actual, (expectedMarker, expectedPosition)) in zip(result, zip(expectedMarkers, expectedPositions)) {
      guard let actual, let expectedPosition else { continue }

      XCTAssert(
        actual.positionAfterSkippingLeadingTrivia == expectedPosition,
        "For marker \(marker), actual result: \(actual) doesn't match expected value: \(sourceFileSyntax.token(at: expectedPosition)?.description ?? "nil")"
      )

      if let expectedMarker {
        expectedResultTypes.assertMarkerType(marker: expectedMarker, actual: actual)
      }
    }
  }
}

/// Name lookup is called with the token at every position marker in the keys of `expected`.
/// It then asserts that the positions of the syntax nodes returned by the lookup are the values in `expected`.
/// It also checks whether result types match rules specified in `expectedResultTypes`.
func assertLexicalNameLookup(
  source: String,
  references: [String: [ResultExpectation]],
  expectedResultTypes: MarkerExpectation = .none,
  useNilAsTheParameter: Bool = false,
  config: LookupConfig = LookupConfig()
) {
  assertLexicalScopeQuery(
    source: source,
    methodUnderTest: { marker, tokenAtMarker in
      let result = tokenAtMarker.lookup(for: useNilAsTheParameter ? nil : tokenAtMarker.text, with: config)

      guard let expectedValues = references[marker] else {
        XCTFail("For marker \(marker), couldn't find result expectation")
        return []
      }

      for (actual, expected) in zip(result, expectedValues) {
        switch (actual, expected) {
        case (.fromScope(let scope, withNames: _), .fromScope(let expectedType, expectedNames: _)):
          XCTAssert(
            scope.syntaxNodeType == expectedType,
            "For marker \(marker), scope result type of \(scope.syntaxNodeType) doesn't match expected \(expectedType)"
          )
        case (.fromFileScope, .fromFileScope):
          break
        default:
          XCTFail("For marker \(marker), result actual result kind \(actual) doesn't match expected \(expected)")
        }
      }

      return result.flatMap { lookUpResult in
        lookUpResult.names.map { lookupName in
          lookupName.syntax
        }
      }
    },
    expected: references.mapValues { expectations in
      expectations.flatMap { expectation in
        expectation.expectedNames
      }
    },
    expectedResultTypes: expectedResultTypes
  )
}
