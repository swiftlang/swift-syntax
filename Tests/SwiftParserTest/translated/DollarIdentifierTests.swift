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

// This test file has been translated from swift/test/Parse/dollar_identifier.swift

import XCTest

final class DollarIdentifierTests: XCTestCase {
  func testDollarIdentifier1() {
    AssertParse(
      """
      // https://github.com/apple/swift/issues/44270
      // Dollar was accidentally allowed as an identifier in Swift 3.
      // SE-0144: Reject this behavior in the future.
      """
    )
  }

  func testDollarIdentifier2a() {
    AssertParse(
      """
      func dollarVar() {
        var 1️⃣$ : Int = 42
        $ += 1
        print($)
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "'$' is not a valid identifier")
      ]
    )
  }

  func testDollarIdentifier2b() {
    AssertParse(
      """
      func dollarLet() {
        let 1️⃣$ = 42
        print($)
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "'$' is not a valid identifier")
        // TODO: Old parser expected error on line 3: '$' is not an identifier; use backticks to escape it, Fix-It replacements: 9 - 10 = '`$`'
      ]
    )
  }

  func testDollarIdentifier2c() {
    AssertParse(
      """
      func dollarClass() {
        class 1️⃣$ {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "'$' is not a valid identifier", fixIts: ["if this name is unavoidable, use backticks to escape it"])
      ],
      fixedSource: """
        func dollarClass() {
          class `$` {}
        }
        """
    )
  }

  func testDollarIdentifier2d() {
    AssertParse(
      """
      func dollarEnum() {
        enum 1️⃣$ {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "'$' is not a valid identifier")
      ]
    )
  }

  func testDollarIdentifier2e() {
    AssertParse(
      """
      func dollarStruct() {
        struct 1️⃣$ {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "'$' is not a valid identifier")
      ]
    )
  }

  func testDollarIdentifier3a() {
    AssertParse(
      """
      func 1️⃣$(2️⃣$ dollarParam: Int) {}
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "'$' is not a valid identifier"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "'$' is not a valid identifier"),
      ],
      fixedSource: "func `$`(`$` dollarParam: Int) {}"
    )
  }

  func testDollarIdentifier3b() {
    AssertParse(
      """
      $(1️⃣$: 24)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: '$' is not an identifier; use backticks to escape it, Fix-It replacements: 3 - 4 = '`$`'
        DiagnosticSpec(message: "'$' is not a valid identifier")
      ]
    )
  }

  func testDollarIdentifier4() {
    AssertParse(
      """
      func escapedDollarVar() {
        var `$` : Int = 42 // no error
        `$` += 1
        print(`$`)
      }
      func escapedDollarLet() {
        let `$` = 42 // no error
        print(`$`)
      }
      func escapedDollarClass() {
        class `$` {} // no error
      }
      func escapedDollarEnum() {
        enum `$` {} // no error
      }
      func escapedDollarStruct() {
        struct `$` {} // no error
      }
      """
    )
  }

  func testDollarIdentifier5() {
    AssertParse(
      """
      func escapedDollarFunc() {
        func `$`(`$`: Int) {} // no error
        `$`(`$`: 25) // no error
      }
      """
    )
  }

  func testDollarIdentifier6() {
    AssertParse(
      """
      func escapedDollarAnd() {
        // FIXME: Bad diagnostics.
        1️⃣`$0` = 1 
        `$$` = 2
        `$abc` = 3
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: expected expression
        DiagnosticSpec(message: "unexpected code in function")
      ]
    )
  }

  func testDollarIdentifier7() {
    AssertParse(
      """
      // Test that we disallow user-defined $-prefixed identifiers. However, the error
      // should not be emitted on $-prefixed identifiers that are not considered
      // declarations.
      """
    )
  }

  func testDollarIdentifier8() {
    AssertParse(
      """
      func $declareWithDollar() { 
        var $foo: Int { 
          get { 0 }
          set($value) {} 
        }
        func $bar() { } 
        func wibble(
          $a: Int, 
          $b c: Int) { } 
        let _: (Int) -> Int = {
          [$capture = 0] 
          $a in 
          $capture
        }
        let ($a: _, _) = (0, 0) 
        $label: if true { 
          break $label
        }
        switch 0 {
        @$dollar case _: 
          break
        }
        if #available($Dummy 9999, *) {} 
        @_swift_native_objc_runtime_base($Dollar)
        class $Class {} 
        enum $Enum {} 
        struct $Struct { 
          @_projectedValueProperty($dummy)
          let property: Never
        }
      }
      protocol $Protocol {} 
      precedencegroup $Precedence { 
        higherThan: $Precedence 
      }
      infix operator **: $Precedence
      #$UnknownDirective()
      """
    )
  }

  func testDollarIdentifier9() {
    AssertParse(
      """
      // https://github.com/apple/swift/issues/55672
      """
    )
  }

  func testDollarIdentifier10() {
    AssertParse(
      """
      @propertyWrapper
      struct Wrapper {
        var wrappedValue: Int
        var projectedValue: String { String(wrappedValue) }
      }
      """
    )
  }

  func testDollarIdentifier11() {
    AssertParse(
      """
      struct S {
        @Wrapper var café = 42
      }
      """
    )
  }

  func testDollarIdentifier12() {
    AssertParse(
      """
      let _ = S().$café // Okay
      """
    )
  }

  func testDollarIdentifier13() {
    // https://github.com/apple/swift/issues/55538
    AssertParse(
      """
      infix operator 1️⃣$
      """,
      diagnostics: [
        DiagnosticSpec(message: "'$' is not allowed in operator names")
      ]
    )
  }

  func testDollarIdentifier14() {
    // https://github.com/apple/swift/issues/55538
    AssertParse(
      """
      infix operator 1️⃣`$`
      """,
      diagnostics: [
        DiagnosticSpec(message: "'`$`' is considered an identifier and must not appear within an operator name")
      ]
    )
  }

}
