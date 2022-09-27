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

  func testDollarIdentifier2() {
    AssertParse(
      """
      func dollarVar() {
        var #^DIAG_1^#$ #^DIAG_2^#: Int = 42 
        $ += 1 
        print($) 
      }
      func dollarLet() {
        let #^DIAG_3^#$ = 42 
        print($) 
      }
      func dollarClass() {
        class #^DIAG_4^#$ {} 
      }
      func dollarEnum() {
        enum #^DIAG_5^#$ {} 
      }
      func dollarStruct() {
        struct #^DIAG_6^#$ {} 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: '$' is not an identifier; use backticks to escape it, Fix-It replacements: 7 - 8 = '`$`'
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected pattern in variable"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text in function"),
        // TODO: Old parser expected error on line 3: '$' is not an identifier; use backticks to escape it, Fix-It replacements: 3 - 4 = '`$`'
        // TODO: Old parser expected error on line 4: '$' is not an identifier; use backticks to escape it, Fix-It replacements: 9 - 10 = '`$`'
        // TODO: Old parser expected error on line 7: '$' is not an identifier; use backticks to escape it, Fix-It replacements: 7 - 8 = '`$`'
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected pattern in variable"),
        // TODO: Old parser expected error on line 8: '$' is not an identifier; use backticks to escape it, Fix-It replacements: 9 - 10 = '`$`'
        // TODO: Old parser expected error on line 11: '$' is not an identifier; use backticks to escape it, Fix-It replacements: 9 - 10 = '`$`'
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected identifier in class"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected member block in class"),
        // TODO: Old parser expected error on line 14: '$' is not an identifier; use backticks to escape it, Fix-It replacements: 8 - 9 = '`$`'
        DiagnosticSpec(locationMarker: "DIAG_5", message: "expected identifier in enum"),
        DiagnosticSpec(locationMarker: "DIAG_5", message: "expected member block in enum"),
        // TODO: Old parser expected error on line 17: '$' is not an identifier; use backticks to escape it, Fix-It replacements: 10 - 11 = '`$`'
        DiagnosticSpec(locationMarker: "DIAG_6", message: "expected identifier in struct"),
        DiagnosticSpec(locationMarker: "DIAG_6", message: "expected member block in struct"),
      ]
    )
  }

  func testDollarIdentifier3() {
    AssertParse(
      """
      func dollarFunc() {
        func #^DIAG_1^#$(#^DIAG_2^#$ dollarParam: Int) {}
        $($#^DIAG_3^#: 24)
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: '$' is not an identifier; use backticks to escape it, Fix-It replacements: 8 - 9 = '`$`'
        // TODO: Old parser expected error on line 2: '$' is not an identifier; use backticks to escape it, Fix-It replacements: 10 - 11 = '`$`'
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected identifier in function"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text '$' before parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected type in function parameter"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text '$ dollarParam: Int' in parameter clause"),
        // TODO: Old parser expected error on line 3: '$' is not an identifier; use backticks to escape it, Fix-It replacements: 3 - 4 = '`$`'
        // TODO: Old parser expected error on line 3: '$' is not an identifier; use backticks to escape it, Fix-It replacements: 5 - 6 = '`$`'
        DiagnosticSpec(locationMarker: "DIAG_3", message: "unexpected text ': 24' in function call"),
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
        #^DIAG^#`$0` = 1 
        `$$` = 2
        `$abc` = 3
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: expected expression
        DiagnosticSpec(message: "unexpected text in function"),
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
      #^DIAG^##$UnknownDirective()
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot declare entity named '$declareWithDollar'
        // TODO: Old parser expected error on line 2: cannot declare entity named '$foo'
        // TODO: Old parser expected error on line 4: cannot declare entity named '$value'
        // TODO: Old parser expected error on line 6: cannot declare entity named '$bar'
        // TODO: Old parser expected error on line 8: cannot declare entity named '$a'
        // TODO: Old parser expected error on line 9: cannot declare entity named '$b'
        // TODO: Old parser expected error on line 11: cannot declare entity named '$capture'
        // TODO: Old parser expected error on line 12: inferred projection type 'Int' is not a property wrapper
        // TODO: Old parser expected error on line 15: cannot declare entity named '$a'
        // TODO: Old parser expected error on line 16: cannot declare entity named '$label'
        // TODO: Old parser expected error on line 20: unknown attribute '$dollar'
        // TODO: Old parser expected warning on line 23: unrecognized platform name '$Dummy'
        // TODO: Old parser expected error on line 25: cannot declare entity named '$Class'; the '$' prefix is reserved
        // TODO: Old parser expected error on line 26: cannot declare entity named '$Enum'; the '$' prefix is reserved
        // TODO: Old parser expected error on line 27: cannot declare entity named '$Struct'; the '$' prefix is reserved
        // TODO: Old parser expected error on line 32: cannot declare entity named '$Protocol'; the '$' prefix is reserved
        // TODO: Old parser expected error on line 33: cannot declare entity named '$Precedence'; the '$' prefix is reserved
        // TODO: Old parser expected error on line 37: use of unknown directive '#$UnknownDirective'
        DiagnosticSpec(message: "extraneous '#$UnknownDirective()' at top level"),
      ]
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
    AssertParse(
      """
      // https://github.com/apple/swift/issues/55538
      infix operator $ 
      infix operator `$`
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: '$' is considered an identifier and must not appear within an operator name
        // TODO: Old parser expected error on line 3: '$' is considered an identifier and must not appear within an operator name
      ]
    )
  }

}
