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

/// Used to define
enum ResultExpectation {
  case fromScope(ScopeSyntax.Type, expectedNames: [String])
  case fromFileScope(expectedNames: [String], nameIntroductionStrategy: FileScopeNameIntroductionStrategy)

  var expectedNames: [String] {
    switch self {
    case .fromScope(_, let expectedNames):
      expectedNames
    case .fromFileScope(expectedNames: let expectedNames, nameIntroductionStrategy: _):
      expectedNames
    }
  }
}

/// `methodUnderTest` is called with the token at every position marker in the keys of `expected`.
/// It then asserts that the positions of the syntax nodes returned by `methodUnderTest` are the values in `expected`.
/// It also checks whether result types match rules specified in `expectedResultTypes`.
func assertLexicalScopeQuery(
  source: String,
  methodUnderTest: (String, TokenSyntax) -> ([SyntaxProtocol?]),
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
    for (actual, expected) in zip(result, zip(expectedMarkers, expectedPositions)) {
      if actual == nil && expected.1 == nil { continue }

      guard let actual else {
        XCTFail(
          "For marker \(marker), actual is nil while expected is \(sourceFileSyntax.token(at: expected.1!)?.description ?? "nil")"
        )
        continue
      }

      guard let expectedPosition = expected.1 else {
        XCTFail("For marker \(marker), actual is \(actual) while expected position is nil")
        continue
      }

      XCTAssert(
        actual.positionAfterSkippingLeadingTrivia == expectedPosition,
        "For marker \(marker), actual result: \(actual) doesn't match expected value: \(sourceFileSyntax.token(at: expected.1!)?.description ?? "nil")"
      )

      if let expectedMarker = expected.0 {
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
  config: [LookupConfig] = []
) {
  assertLexicalScopeQuery(
    source: source,
    methodUnderTest: { marker, argument in
      let result = argument.lookup(for: useNilAsTheParameter ? nil : argument.text, with: config)

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
        case (.fromFileScope(_, withNames: _, nameIntroductionStrategy: let nameIntroductionStrategy), .fromFileScope(expectedNames: _, nameIntroductionStrategy: let expectedNameIntroductionStrategy)):
          XCTAssert(
            nameIntroductionStrategy == expectedNameIntroductionStrategy,
            "For marker \(marker), actual file scope name introduction strategy \(nameIntroductionStrategy) doesn't match expected \(expectedNameIntroductionStrategy)"
          )
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
