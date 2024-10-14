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

/// Used to define lookup result assertion.
enum ResultExpectation {
  case fromScope(ScopeSyntax.Type, expectedNames: [ExpectedName])
  case fromFileScope(expectedNames: [ExpectedName])
  case lookInMembers(LookInMembersScopeSyntax.Type)
  case lookInGenericParametersOfExtendedType
  case mightIntroduceDollarIdentifiers

  var expectedNames: [ExpectedName] {
    switch self {
    case .fromScope(_, let expectedNames):
      return expectedNames
    case .fromFileScope(expectedNames: let expectedNames):
      return expectedNames
    case .lookInMembers,
      .lookInGenericParametersOfExtendedType,
      .mightIntroduceDollarIdentifiers:
      return []
    }
  }

  var debugDescription: String {
    switch self {
    case .fromScope:
      return "fromScope"
    case .fromFileScope:
      return "fromFileScope"
    case .lookInMembers:
      return "lookInMembers"
    case .lookInGenericParametersOfExtendedType:
      return "lookInGenericParametersOfExtendedType"
    case .mightIntroduceDollarIdentifiers:
      return "mightIntroduceDollarIdentifiers"
    }
  }

  static func assertResult(marker: String, result: [LookupResult], expectedValues: [ResultExpectation]) {
    XCTAssert(
      result.count == expectedValues.count,
      "For marker \(marker), actual result count \(result.count) doesn't match expected \(expectedValues.count)"
    )

    for (actual, expected) in zip(result, expectedValues) {
      switch (actual, expected) {
      case (
        .fromScope(let scope, withNames: let actualNames),
        .fromScope(let expectedType, expectedNames: let expectedNames)
      ):
        XCTAssert(
          scope.syntaxNodeType == expectedType,
          "For marker \(marker), scope result type of \(scope.syntaxNodeType) doesn't match expected \(expectedType)"
        )

        NameExpectation.assertNames(marker: marker, acutalNames: actualNames, expectedNames: expectedNames)
      case (.fromFileScope(_, let actualNames), .fromFileScope(let expectedNames)):
        NameExpectation.assertNames(marker: marker, acutalNames: actualNames, expectedNames: expectedNames)
      case (.lookInMembers(let scope), .lookInMembers(let expectedType)):
        XCTAssert(
          scope.syntaxNodeType == expectedType,
          "For marker \(marker), scope result type of \(scope.syntaxNodeType) doesn't match expected \(expectedType)"
        )
      case (.lookInGenericParametersOfExtendedType, .lookInGenericParametersOfExtendedType):
        break
      case (.mightIntroduceDollarIdentifiers, .mightIntroduceDollarIdentifiers):
        break
      default:
        XCTFail(
          "For marker \(marker), actual result kind \(actual.debugDescription) doesn't match expected \(expected.debugDescription)"
        )
      }
    }
  }
}
