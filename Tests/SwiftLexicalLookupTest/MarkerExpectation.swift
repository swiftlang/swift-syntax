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
import SwiftSyntax
import XCTest

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
  func assertMarkerType(marker: String, actual: SyntaxProtocol) {
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
