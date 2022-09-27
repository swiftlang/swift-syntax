// This test file has been translated from swift/test/Parse/diagnostic_missing_func_keyword.swift

import XCTest

final class DiagnosticMissingFuncKeywordTests: XCTestCase {
  func testDiagnosticMissingFuncKeyword1() {
    AssertParse(
      """
      // https://github.com/apple/swift/issues/52877
      """
    )
  }

  func testDiagnosticMissingFuncKeyword2() {
    AssertParse(
      """
      protocol Brew { #^DIAG_1^#
        tripel() -> Int 
        quadrupel#^DIAG_2^#: Int { get } 
        static + (lhs: Self, rhs: Self) -> Self 
        * (lhs: Self, rhs: Self) -> Self 
        ipa: Int { get }; apa: Float { get }
        stout: Int { get } porter: Float { get }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 1: in declaration of 'Brew'
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected declaration in protocol"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected '}' to end protocol"),
        // TODO: Old parser expected error on line 2: expected 'func' keyword in instance method declaration, Fix-It replacements: 3 - 3 = 'func '
        // TODO: Old parser expected error on line 3: expected 'var' keyword in property declaration, Fix-It replacements: 3 - 3 = 'var '
        DiagnosticSpec(locationMarker: "DIAG_2", message: "extraneous code at top level"),
        // TODO: Old parser expected error on line 4: expected 'func' keyword in operator function declaration, Fix-It replacements: 10 - 10 = 'func '
        // TODO: Old parser expected error on line 5: expected 'func' keyword in operator function declaration, Fix-It replacements: 3 - 3 = 'func '
        // TODO: Old parser expected error on line 5: operator '*' declared in protocol must be 'static', Fix-It replacements: 3 - 3 = 'static '
        // TODO: Old parser expected error on line 6: expected 'var' keyword in property declaration, Fix-It replacements: 3 - 3 = 'var '
        // TODO: Old parser expected error on line 6: expected 'var' keyword in property declaration, Fix-It replacements: 21 - 21 = 'var '
        // TODO: Old parser expected error on line 7: expected 'var' keyword in property declaration, Fix-It replacements: 3 - 3 = 'var '
        // TODO: Old parser expected error on line 7: expected declaration
        // TODO: Old parser expected error on line 7: consecutive declarations on a line must be separated by ';'
      ]
    )
  }

  func testDiagnosticMissingFuncKeyword3() {
    AssertParse(
      """
      infix operator %%
      """
    )
  }

  func testDiagnosticMissingFuncKeyword4() {
    AssertParse(
      """
      struct Bar {#^DIAG_1^#
        #^DIAG_2^#fisr = 0x5F3759DF 
        %%<T: Brew> (lhs: T, rhs: T) -> T { 
          lhs + lhs + rhs + rhs
        }
        _: Int = 42 
        (light, dark) = (100, 200)
        a, b: Int 
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected declaration in struct"),
        // TODO: Old parser expected error on line 2: expected 'var' keyword in property declaration, Fix-It replacements: 3 - 3 = 'var '
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text in struct"),
        // TODO: Old parser expected error on line 3: expected 'func' keyword in operator function declaration, Fix-It replacements: 3 - 3 = 'func '
        // TODO: Old parser expected error on line 6: expected 'var' keyword in property declaration, Fix-It replacements: 3 - 3 = 'var '
        // TODO: Old parser expected error on line 7: expected 'var' keyword in property declaration, Fix-It replacements: 3 - 3 = 'var '
        // TODO: Old parser expected error on line 8: expected 'var' keyword in property declaration, Fix-It replacements: 3 - 3 = 'var '
      ]
    )
  }

  func testDiagnosticMissingFuncKeyword5() {
    AssertParse(
      """
      class Baz {#^DIAG_1^#
        instanceMethod() {} 
        #^DIAG_2^#static staticMethod() {} 
        instanceProperty: Int { 0 } 
        static staticProperty: Int { 0 } 
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected declaration in class"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected '}' to end class"),
        // TODO: Old parser expected error on line 2: expected 'func' keyword in instance method declaration, Fix-It replacements: 3 - 3 = 'func '
        // TODO: Old parser expected error on line 3: expected 'func' keyword in static method declaration, Fix-It replacements: 10 - 10 = 'func '
        DiagnosticSpec(locationMarker: "DIAG_2", message: "extraneous code at top level"),
        // TODO: Old parser expected error on line 4: expected 'var' keyword in property declaration, Fix-It replacements: 3 - 3 = 'var '
        // TODO: Old parser expected error on line 5: expected 'var' keyword in static property declaration, Fix-It replacements: 10 - 10 = 'var '
      ]
    )
  }

  func testDiagnosticMissingFuncKeyword6() {
    AssertParse(
      """
      class C1 {
        class classMethod#^DIAG^#() {} 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected '{' in class
        DiagnosticSpec(message: "unexpected text '()' in class"),
      ]
    )
  }

  func testDiagnosticMissingFuncKeyword7() {
    AssertParse(
      """
      class C2 {
        class classProperty: Int { #^DIAG^#0 } 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected declaration
        DiagnosticSpec(message: "expected declaration in class"),
        DiagnosticSpec(message: "unexpected text '0' in class"),
      ]
    )
  }

}
