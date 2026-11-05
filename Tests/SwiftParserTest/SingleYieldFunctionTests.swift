//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_spi(ExperimentalLanguageFeatures) import SwiftParser
@_spi(ExperimentalLanguageFeatures) import SwiftSyntax
import XCTest

final class SingleYieldFunctionTests: ParserTestCase {
  override var languageFeatures: Parser.LanguageFeatures {
    [.singleYieldFunctions]
  }

  func testOwnedYield() {
    assertParse(
      """
      func owned() -> yield Klass { yield Klass() }
      """,
      substructure: YieldTypeSyntax(
        type: IdentifierTypeSyntax(name: .identifier("Klass"))
      )
    )
  }

  func testBorrowYield() {
    assertParse(
      """
      func borrowed() -> yield borrow Klass { yield k }
      """,
      substructure: YieldTypeSyntax(
        specifier: .keyword(.borrow),
        type: IdentifierTypeSyntax(name: .identifier("Klass"))
      )
    )
  }

  func testInoutYield() {
    assertParse(
      """
      mutating func mutable() -> yield inout Klass { yield &k }
      """,
      substructure: YieldTypeSyntax(
        specifier: .keyword(.inout),
        type: IdentifierTypeSyntax(name: .identifier("Klass"))
      )
    )
  }

  func testEffectsBeforeYield() {
    assertParse(
      """
      func asyncThrowing() async throws -> yield Klass { yield Klass() }
      """,
      substructure: YieldTypeSyntax(
        type: IdentifierTypeSyntax(name: .identifier("Klass"))
      )
    )
  }

  func testYieldTypeName() {
    assertParse(
      """
      func returnsYieldType() -> yield { return yield() }
      """,
      substructure: ReturnClauseSyntax(
        type: IdentifierTypeSyntax(name: .identifier("yield"))
      )
    )
  }

  func testYieldTypeRequiresFeature() {
    assertParse(
      """
      func owned() -> yield 1️⃣Klass { yield Klass() }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Klass' in function")
      ],
      languageFeatures: []
    )
  }
}
