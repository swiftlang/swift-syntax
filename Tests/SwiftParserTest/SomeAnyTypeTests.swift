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

@_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) import SwiftParser
@_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) import SwiftSyntax
import XCTest

final class SomeAnyTypeTests: ParserTestCase {
  func testSomeType() {
    // Basic some P
    assertParse(
      "let x: some P",
      substructure: SomeOrAnyTypeSyntax(
        someOrAnySpecifier: .keyword(.some),
        constraint: IdentifierTypeSyntax(name: .identifier("P"))
      )
    )

    // Basic any P
    assertParse(
      "let x: any P",
      substructure: SomeOrAnyTypeSyntax(
        someOrAnySpecifier: .keyword(.any),
        constraint: IdentifierTypeSyntax(name: .identifier("P"))
      )
    )
  }

  func testSomeOptionalHoisting() {
    // some P? -> (some P)?
    assertParse(
      "let x: some P?",
      substructure: OptionalTypeSyntax(
        wrappedType: SomeOrAnyTypeSyntax(
          someOrAnySpecifier: .keyword(.some),
          constraint: IdentifierTypeSyntax(name: .identifier("P"))
        )
      )
    )

    // any P? -> (any P)?
    assertParse(
      "let x: any P?",
      substructure: OptionalTypeSyntax(
        wrappedType: SomeOrAnyTypeSyntax(
          someOrAnySpecifier: .keyword(.any),
          constraint: IdentifierTypeSyntax(name: .identifier("P"))
        )
      )
    )

    // some P! -> (some P)!
    assertParse(
      "let x: some P!",
      substructure: ImplicitlyUnwrappedOptionalTypeSyntax(
        wrappedType: SomeOrAnyTypeSyntax(
          someOrAnySpecifier: .keyword(.some),
          constraint: IdentifierTypeSyntax(name: .identifier("P"))
        )
      )
    )
  }

  func testSomeComposition() {
    // some P & Q -> some (P & Q)
    assertParse(
      "let x: some P & Q",
      substructure: SomeOrAnyTypeSyntax(
        someOrAnySpecifier: .keyword(.some),
        constraint: CompositionTypeSyntax(
          elements: .init([
            CompositionTypeElementSyntax(
              type: IdentifierTypeSyntax(name: .identifier("P")),
              ampersand: .binaryOperator("&")
            ),
            CompositionTypeElementSyntax(type: IdentifierTypeSyntax(name: .identifier("Q"))),
          ])
        )
      )
    )

    // some P? & Q -> (some P)? & Q
    assertParse(
      "let x: some P? & Q",
      substructure: CompositionTypeSyntax(
        elements: .init([
          CompositionTypeElementSyntax(
            type: OptionalTypeSyntax(
              wrappedType: SomeOrAnyTypeSyntax(
                someOrAnySpecifier: .keyword(.some),
                constraint: IdentifierTypeSyntax(name: .identifier("P"))
              )
            ),
            ampersand: .binaryOperator("&")
          ),
          CompositionTypeElementSyntax(type: IdentifierTypeSyntax(name: .identifier("Q"))),
        ])
      )
    )
  }

  func testOptionalSomeCompositionDiagnosed() {
    // some P & Q? -> (some (P & Q))? (diagnosed)
    assertParse(
      "let x: some P & Q1️⃣?",
      substructure: OptionalTypeSyntax(
        wrappedType: SomeOrAnyTypeSyntax(
          someOrAnySpecifier: .keyword(.some),
          constraint: CompositionTypeSyntax(
            elements: .init([
              CompositionTypeElementSyntax(
                type: IdentifierTypeSyntax(name: .identifier("P")),
                ampersand: .binaryOperator("&")
              ),
              CompositionTypeElementSyntax(
                type: IdentifierTypeSyntax(name: .identifier("Q"))
              ),
            ])
          )
        )
      ),
      diagnostics: [
        DiagnosticSpec(
          message:
            "confusing use of optional after a 'some' or 'any' composition; use parentheses to clarify precedence",
          fixIts: ["parenthesize composition"]
        )
      ],
      fixedSource: "let x: some (P & Q)?"
    )
  }

  func testSomeMemberAccess() {
    // some P?.Q -> some (P?.Q)
    assertParse(
      "let x: some P?.Q",
      substructure: SomeOrAnyTypeSyntax(
        someOrAnySpecifier: .keyword(.some),
        constraint: MemberTypeSyntax(
          baseType: OptionalTypeSyntax(wrappedType: IdentifierTypeSyntax(name: .identifier("P"))),
          period: .periodToken(),
          name: .identifier("Q")
        )
      )
    )

    // some P?.Q? -> (some (P?.Q))?
    assertParse(
      "let x: some P?.Q?",
      substructure: OptionalTypeSyntax(
        wrappedType: SomeOrAnyTypeSyntax(
          someOrAnySpecifier: .keyword(.some),
          constraint: MemberTypeSyntax(
            baseType: OptionalTypeSyntax(wrappedType: IdentifierTypeSyntax(name: .identifier("P"))),
            period: .periodToken(),
            name: .identifier("Q")
          )
        )
      )
    )
  }
}
