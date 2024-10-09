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

/// Used to define lookup name assertion.
protocol ExpectedName {
  var marker: String { get }
}

extension String: ExpectedName {
  var marker: String {
    self
  }
}

enum ImplicitNameExpectation {
  case `self`(String)
  case `Self`(String)
  case error(String)
  case newValue(String)
  case oldValue(String)

  func assertExpectation(marker: String, for name: ImplicitDecl) {
    switch (name, self) {
    case (.self, .self): break
    case (.Self, .Self): break
    case (.error, .error): break
    case (.newValue, .newValue): break
    case (.oldValue, .oldValue): break
    default:
      XCTFail("For marker \(marker), actual name kind \(name) doesn't match expected \(self)")
    }
  }

  var marker: String {
    switch self {
    case .self(let marker),
      .Self(let marker),
      .error(let marker),
      .newValue(let marker),
      .oldValue(let marker):
      return marker
    }
  }
}

/// Can be used to optionally assert
/// exact lookup name kind.
enum NameExpectation: ExpectedName {
  case identifier(String)
  case declaration(String)
  case implicit(ImplicitNameExpectation)
  case dollarIdentifier(String, String)

  var marker: String {
    switch self {
    case .identifier(let marker),
      .declaration(let marker),
      .dollarIdentifier(let marker, _):
      return marker
    case .implicit(let implicitName):
      return implicitName.marker
    }
  }

  private func assertExpectation(marker: String, for name: LookupName) {
    switch (name, self) {
    case (.identifier, .identifier): break
    case (.declaration, .declaration): break
    case (.implicit(let implicitName), .implicit(let implicitNameExpectation)):
      implicitNameExpectation.assertExpectation(marker: marker, for: implicitName)
    case (.dollarIdentifier(_, let acutalStr), .dollarIdentifier(_, let expectedStr)):
      XCTAssert(
        acutalStr == expectedStr,
        "For marker \(marker), actual identifier \(acutalStr) doesn't match expected \(expectedStr)"
      )
    default:
      XCTFail("For marker \(marker), actual name kind \(name) doesn't match expected \(self)")
    }
  }

  static func assertNames(marker: String, acutalNames: [LookupName], expectedNames: [ExpectedName]) {
    for (actualName, expectedName) in zip(acutalNames, expectedNames) {
      guard let nameExpectation = expectedName as? NameExpectation else { continue }

      nameExpectation.assertExpectation(marker: marker, for: actualName)
    }
  }
}
