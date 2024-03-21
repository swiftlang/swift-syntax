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

import SwiftParser
import SwiftSyntax
import XCTest

final class TypeMemberTests: ParserTestCase {
  func testKeyword() {
    assertParse(
      "MyType.class",
      { TypeSyntax.parse(from: &$0) },
      substructure: MemberTypeSyntax(
        baseType: IdentifierTypeSyntax(
          name: .identifier("MyType")
        ),
        name: .identifier("class")
      )
    )
  }

  func testMissing() {
    assertParse(
      "MyType.1️⃣",
      { TypeSyntax.parse(from: &$0) },
      substructure: MemberTypeSyntax(
        baseType: IdentifierTypeSyntax(
          name: .identifier("MyType")
        ),
        name: .identifier("", presence: .missing)
      ),
      diagnostics: [
        DiagnosticSpec(message: "expected name in member type", fixIts: ["insert name"])
      ],
      fixedSource: """
        MyType.<#identifier#>
        """
    )
  }

  func testValidWhitespace() {
    let expected = Syntax(
      MemberTypeSyntax(
        baseType: IdentifierTypeSyntax(
          name: .identifier("MyType")
        ),
        name: .identifier("Nested")
      )
    )

    let cases: [UInt: String] = [
      #line: "MyType .Nested",
      #line: "MyType/*foo*/.Nested",
      #line: "MyType\n.Nested",
      #line: "MyType . Nested",
      #line: "MyType/*foo*/./*bar*/Nested",
      #line: "MyType\n.  Nested",
      #line: "MyType\n.\nNested",
    ]
    for (line, source) in cases {
      assertParse(
        source,
        { TypeSyntax.parse(from: &$0) },
        substructure: expected,
        line: line
      )
    }
  }

  func testInvalidWhitespace() {
    let expected = "MyType.Nested"

    let cases: [UInt: String] = [
      #line: "MyType1️⃣. Nested",
      #line: "MyType1️⃣./*bar*/Nested",
    ]
    for (line, source) in cases {
      assertParse(
        source,
        { TypeSyntax.parse(from: &$0) },
        diagnostics: [
          DiagnosticSpec(message: "extraneous whitespace after '.' is not permitted", fixIts: ["remove whitespace"])
        ],
        fixedSource: expected,
        line: line
      )
    }
  }

  func testBaseType() {
    let cases: [UInt: String] = [
      // Identifiers and member types
      #line: "X",
      #line: "X<T>",
      #line: "X.Y",
      #line: "X.Y<T>",
      #line: "X<T>.Y",
      #line: "X<T>.Y<T>",

      // Metatypes
      #line: "X.Type",
      #line: "X.Protocol",

      // Sugared optionals
      #line: "X?",
      #line: "X!",

      // Sugared collections
      #line: "[X]",
      #line: "[X : Y]",

      // Tuples and paren type
      #line: "()",
      #line: "(X)",
      #line: "(X, X)",

      // Keywords
      #line: "Any",
      #line: "Self",
    ]

    for (line, baseType) in cases {
      var parser = Parser(baseType)

      let expectedSyntax = MemberTypeSyntax(
        baseType: TypeSyntax.parse(from: &parser),
        name: .identifier("Z")
      )

      assertParse(
        "\(baseType).Z",
        { TypeSyntax.parse(from: &$0) },
        substructure: expectedSyntax,
        line: line
      )

      assertParse(
        "\(baseType).Z<W>",
        { TypeSyntax.parse(from: &$0) },
        substructure: expectedSyntax.with(
          \.genericArgumentClause,
          GenericArgumentClauseSyntax(
            arguments: .init([
              GenericArgumentSyntax(argument: IdentifierTypeSyntax(name: .identifier("W")))
            ])
          )
        ),
        line: line
      )
    }
  }
}
