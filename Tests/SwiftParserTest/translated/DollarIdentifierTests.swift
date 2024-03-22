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

// This test file has been translated from swift/test/Parse/dollar_identifier.swift

import XCTest

final class DollarIdentifierTests: ParserTestCase {
  func testDollarIdentifier1() {
    assertParse(
      """
      // https://github.com/apple/swift/issues/44270
      // Dollar was accidentally allowed as an identifier in Swift 3.
      // SE-0144: Reject this behavior in the future.
      """
    )
  }

  func testDollarIdentifier2a() {
    assertParse(
      """
      func dollarVar() {
        var 1️⃣$ : Int = 42
        $ += 1
        print($)
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "'$' is not a valid identifier",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        func dollarVar() {
          var `$` : Int = 42
          $ += 1
          print($)
        }
        """
    )
  }

  func testDollarIdentifier2b() {
    assertParse(
      """
      func dollarLet() {
        let 1️⃣$ = 42
        print($)
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "'$' is not a valid identifier",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        func dollarLet() {
          let `$` = 42
          print($)
        }
        """
    )
  }

  func testDollarIdentifier2c() {
    assertParse(
      """
      func dollarClass() {
        class 1️⃣$ {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "'$' is not a valid identifier",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        func dollarClass() {
          class `$` {}
        }
        """
    )
  }

  func testDollarIdentifier2d() {
    assertParse(
      """
      func dollarEnum() {
        enum 1️⃣$ {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "'$' is not a valid identifier",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        func dollarEnum() {
          enum `$` {}
        }
        """
    )
  }

  func testDollarIdentifier2e() {
    assertParse(
      """
      func dollarStruct() {
        struct 1️⃣$ {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "'$' is not a valid identifier",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        func dollarStruct() {
          struct `$` {}
        }
        """
    )
  }

  func testDollarIdentifier3a() {
    assertParse(
      """
      func 1️⃣$(2️⃣$ dollarParam: Int) {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "'$' is not a valid identifier",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "'$' is not a valid identifier",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        ),
      ],
      fixedSource: "func `$`(`$` dollarParam: Int) {}"
    )
  }

  func testDollarIdentifier3b() {
    assertParse(
      """
      $(1️⃣$: 24)
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "'$' is not a valid identifier",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        $(`$`: 24)
        """
    )
  }

  func testDollarIdentifier4() {
    assertParse(
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
    assertParse(
      """
      func escapedDollarFunc() {
        func `$`(`$`: Int) {} // no error
        `$`(`$`: 25) // no error
      }
      """
    )
  }

  func testDollarIdentifier6() {
    assertParse(
      """
      func escapedDollarAnd() {
        1️⃣`$0` = 1
        `$$` = 2
        `$abc` = 3
      }
      """,
      diagnostics: [
        // FIXME: Bad diagnostic
        DiagnosticSpec(message: "unexpected code in function")
      ]
    )
  }

  func testDollarIdentifier7() {
    assertParse(
      """
      // Test that we disallow user-defined $-prefixed identifiers. However, the error
      // should not be emitted on $-prefixed identifiers that are not considered
      // declarations.
      """
    )
  }

  func testDollarIdentifier8() {
    assertParse(
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
    assertParse(
      """
      // https://github.com/apple/swift/issues/55672
      """
    )
  }

  func testDollarIdentifier10() {
    assertParse(
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
    assertParse(
      """
      struct S {
        @Wrapper var café = 42
      }
      """
    )
  }

  func testDollarIdentifier12() {
    assertParse(
      """
      let _ = S().$café // Okay
      """
    )
  }

  func testDollarIdentifier13() {
    // https://github.com/apple/swift/issues/55538
    assertParse(
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
    assertParse(
      """
      infix operator 1️⃣`$`
      """,
      diagnostics: [
        DiagnosticSpec(message: "'`$`' is considered an identifier and must not appear within an operator name")
      ]
    )
  }

}
