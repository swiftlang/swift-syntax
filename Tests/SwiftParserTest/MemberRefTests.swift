//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax
import SwiftParser
import XCTest

final class MemberTypeTests: XCTestCase {
  func testKeyword() {
    AssertParse(
      "MyType.class",
      { TypeSyntax.parse(from: &$0) },
      substructure: Syntax(
        MemberTypeIdentifierSyntax(
          baseType: SimpleTypeIdentifierSyntax(
            name: .identifier("MyType")
          ),
          period: .period,
          name: .identifier("class")
        )
      )
    )
  }

  func testMissing() {
    AssertParse(
      "MyType.1️⃣",
      { TypeSyntax.parse(from: &$0) },
      substructure: Syntax(
        MemberTypeIdentifierSyntax(
          baseType: SimpleTypeIdentifierSyntax(
            name: .identifier("MyType")
          ),
          period: .periodToken(),
          name: .identifier("", presence: .missing)
        )
      ),
      diagnostics: [DiagnosticSpec(message: "expected name in member type")]
    )
  }

  func testValidWhitespace() {
    let expected = Syntax(
      MemberTypeIdentifierSyntax(
        baseType: SimpleTypeIdentifierSyntax(
          name: .identifier("MyType")
        ),
        period: .periodToken(),
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
      AssertParse(
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
      AssertParse(
        source,
        { TypeSyntax.parse(from: &$0) },
        diagnostics: [DiagnosticSpec(message: "extraneous whitespace after '.' is not permitted")],
        fixedSource: expected,
        line: line
      )
    }
  }
}

final class MetatypeTests: XCTestCase {
  func testType() {
    AssertParse(
      "MyType.Type",
      { TypeSyntax.parse(from: &$0) },
      substructure: Syntax(
        MetatypeTypeSyntax(
          baseType: SimpleTypeIdentifierSyntax(
            name: .identifier("MyType")
          ),
          period: .period,
          typeOrProtocol: .contextualKeyword("Type")
        )
      )
    )
  }

  func testProtocol() {
    AssertParse(
      "MyType.Protocol",
      { TypeSyntax.parse(from: &$0) },
      substructure: Syntax(
        MetatypeTypeSyntax(
          baseType: SimpleTypeIdentifierSyntax(
            name: .identifier("MyType")
          ),
          period: .period,
          typeOrProtocol: .contextualKeyword("Protocol")
        )
      )
    )
  }

  func testNested() {
    AssertParse(
      "MyType.Type.Type",
      { TypeSyntax.parse(from: &$0) },
      substructure: Syntax(
        MetatypeTypeSyntax(
          baseType: MetatypeTypeSyntax(
            baseType: SimpleTypeIdentifierSyntax(
              name: .identifier("MyType")
            ),
            period: .period,
            typeOrProtocol: .contextualKeyword("Type")
          ),
          period: .period,
          typeOrProtocol: .contextualKeyword("Type")
        )
      )
    )
  }

  func testNestedMember() {
    AssertParse(
      "MyType.Type.OtherType",
      { TypeSyntax.parse(from: &$0) },
      substructure: Syntax(
        MemberTypeIdentifierSyntax(
          baseType: MetatypeTypeSyntax(
            baseType: SimpleTypeIdentifierSyntax(
              name: .identifier("MyType")
            ),
            period: .period,
            typeOrProtocol: .contextualKeyword("Type")
          ),
          period: .period,
          name: .identifier("OtherType")
        )
      )
    )
  }

  func testTupleType() {
    AssertParse(
      "(MyType).Type",
      { TypeSyntax.parse(from: &$0) },
      substructure: Syntax(
        MetatypeTypeSyntax(
          baseType: TupleTypeSyntax(
            leftParen: .leftParen,
            elements: TupleTypeElementListSyntax([
              TupleTypeElementSyntax(
                type: SimpleTypeIdentifierSyntax(
                  name: .identifier("MyType")
                )
              )
            ]),
            rightParen: .rightParen
          ),
          period: .period,
          typeOrProtocol: .contextualKeyword("Type")
        )
      )
    )
  }

  func testOptionalType() {
    AssertParse(
      "MyType?.Type",
      { TypeSyntax.parse(from: &$0) },
      substructure: Syntax(
        MetatypeTypeSyntax(
          baseType: OptionalTypeSyntax(
            wrappedType: SimpleTypeIdentifierSyntax(
              name: .identifier("MyType")
            ),
            questionMark: .postfixQuestionMark
          ),
          period: .period,
          typeOrProtocol: .contextualKeyword("Type")
        )
      )
    )
  }

  func testAny() {
    AssertParse(
      "Any.Type",
      { TypeSyntax.parse(from: &$0) },
      substructure: Syntax(
        MetatypeTypeSyntax(
          baseType: SimpleTypeIdentifierSyntax(
            name: .anyKeyword()
          ),
          period: .period,
          typeOrProtocol: .contextualKeyword("Type")
        )
      )
    )
  }

  func testSelf() {
    AssertParse(
      "Self.Type",
      { TypeSyntax.parse(from: &$0) },
      substructure: Syntax(
        MetatypeTypeSyntax(
          baseType: SimpleTypeIdentifierSyntax(
            name: .capitalSelfKeyword()
          ),
          period: .period,
          typeOrProtocol: .contextualKeyword("Type")
        )
      )
    )
  }
}

final class MemberExprTests: XCTestCase {
  func testMissing() {
    let cases: [UInt: String] = [
      #line: "",
      #line: "\nmember",
      #line: "  \nmember",
      #line: "/*foo*/\nmember",
      #line: "\n  member",
    ]
    for (line, trailing) in cases {
      AssertParse(
        "someVar.1️⃣\(trailing)",
        diagnostics: [DiagnosticSpec(message: "expected name in member access")],
        fixedSource: "someVar.<#identifier#>\(trailing)",
        line: line
      )
    }
  }
}
