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

// This test file has been translated from swift/test/Parse/escaped_identifiers.swift

import XCTest

final class EscapedIdentifiersTests: ParserTestCase {
  func testEscapedIdentifiers1() {
    assertParse(
      """
      func `protocol`() {}
      """
    )
  }

  func testEscapedIdentifiers2() {
    assertParse(
      """
      `protocol`()
      """
    )
  }

  func testEscapedIdentifiers3() {
    assertParse(
      """
      class `Type` {}
      """
    )
  }

  func testEscapedIdentifiers4() {
    assertParse(
      """
      var `class` = `Type`.self
      """
    )
  }

  func testEscapedIdentifiers5() {
    assertParse(
      """
      func foo() {}
      """
    )
  }

  func testEscapedIdentifiers6() {
    assertParse(
      """
      `foo`()
      """
    )
  }

  func testEscapedIdentifiers7() {
    assertParse(
      """
      // Escaping suppresses identifier contextualization.
      var get: (() -> ()) -> () = { $0() }
      """
    )
  }

  func testEscapedIdentifiers8() {
    assertParse(
      """
      var applyGet: Int {
        `get` { }
        return 0
      }
      """
    )
  }

  func testEscapedIdentifiers9() {
    assertParse(
      """
      enum `switch` {}
      """
    )
  }

  func testEscapedIdentifiers10() {
    assertParse(
      """
      typealias `Self` = Int
      """
    )
  }

  func testEscapedIdentifiers11() {
    assertParse(
      """
      func `method with space and .:/`() {}
      `method with space and .:/`()

      class `Class with space and .:/` {}
      var `var with space and .:/` = `Class with space and .:/`.self

      enum `Enum with space and .:/` {
        case `space cases`
        case `case with payload`(`some label`: `Class with space and .:/`)
      }
      let `enum value`: `Enum with space and .:/` =
        .`case with payload`(`some label`: `var with space and .:/`)

      struct `Escaped Type` {}
      func `escaped function`(`escaped label` `escaped arg`: `Escaped Type`) {}
      `escaped function`(`escaped label`: `Escaped Type`())
      let `escaped reference` = `escaped function`(`escaped label`:)
      `escaped reference`(`Escaped Type`())
      """
    )
  }

  func testEscapedIdentifiers12() {
    assertParse(
      """
      func `+ start with operator`() {}
      func `end with operator +`() {}
      func ` + `() {}
      """
    )
  }

  func testEscapedIdentifiers13() {
    assertParse(
      """
      func `// not a comment`() {}
      func `/* also not a comment */`() {}
      func `func dontDoThis() {}`() {}
      """
    )
  }

  func testEscapedIdentifiers14() {
    assertParse(
      """
      let `@atSign` = 0
      let `#octothorpe` = 0
      """
    )
  }

  func testEscapedIdentifiers15() {
    assertParse(
      """
      @propertyWrapper
      struct `@PoorlyNamedWrapper`<`The Value`> {
        var wrappedValue: `The Value`
      }
      struct WithWrappedProperty {
        @`@PoorlyNamedWrapper` var x: Int
      }
      """
    )
  }

  func testEscapedIdentifiers16() {
    assertParse(
      """
      let 1️⃣`+` = 0
      let 2️⃣`^*^` = 0
      let 3️⃣`.` = 0
      let 4️⃣`?` = 0
      func 5️⃣`+`(lhs: Int, rhs: Int) -> Int
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "a raw identifier cannot contain only operator characters"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "a raw identifier cannot contain only operator characters"
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "a raw identifier cannot contain only operator characters"
        ),
        DiagnosticSpec(
          locationMarker: "4️⃣",
          message: "a raw identifier cannot contain only operator characters"
        ),
        DiagnosticSpec(
          locationMarker: "5️⃣",
          message: "a raw identifier cannot contain only operator characters"
        ),
      ]
    )
  }

  func testEscapedIdentifiers17() {
    assertParse(
      """
      1️⃣`multiline is
      not allowed` = 5
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "extraneous code at top level"
        )
      ]
    )
  }

  func testEscapedIdentifiers18() {
    assertParse(
      """
      `null1️⃣\u{0000}is not allowed` = 5
      `unprintable ascii2️⃣\u{007f}is not allowed` = 10
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unprintable ASCII character found in source file"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "unprintable ASCII character found in source file"
        ),
      ]
    )
  }

  func testEscapedIdentifiers19() {
    assertParse(
      """
      1️⃣`` = 5
      2️⃣` ` = 5
      3️⃣`   ` = 5
      4️⃣`\u{200E} \u{200F}` = 5
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "a raw identifier cannot be empty"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "a raw identifier cannot contain only whitespace characters"
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "a raw identifier cannot contain only whitespace characters"
        ),
        DiagnosticSpec(
          locationMarker: "4️⃣",
          message: "a raw identifier cannot contain only whitespace characters"
        ),
      ]
    )
  }

  func testEscapedIdentifiers20() {
    assertParse(
      """
      `this space is ok but this1️⃣\u{00a0}one is not` = 5
      `neither is this2️⃣\u{2029}one` = 5
      `whitespace diagnostic3️⃣\u{0009}has precedence over nonprintable ASCII` = 5
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "invalid whitespace found in raw identifier"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "invalid whitespace found in raw identifier"
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "invalid whitespace found in raw identifier"
        ),
      ]
    )
  }

  func testEscapedIdentifiers21() {
    assertParse(
      """
      `1️⃣\\starting` = 5
      `mid2️⃣\\dle` = 5
      `end3️⃣\\` = 5
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "a raw identifier cannot contain a backslash"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "a raw identifier cannot contain a backslash"
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "a raw identifier cannot contain a backslash"
        ),
      ]
    )
  }
}
