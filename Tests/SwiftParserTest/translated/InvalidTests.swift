// This test file has been translated from swift/test/Parse/invalid.swift

import XCTest

final class InvalidTests: XCTestCase {
  func testInvalid1a() {
    AssertParse(
      """
      // rdar://15946844
      func test1(inout#^DIAG_1^# #^DIAG_2^#var x : Int#^DIAG_3^#) {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 2: 'var' in this position is interpreted as an argument label, Fix-It replacements: 18 - 21 = '`var`'
        // TODO: Old parser expected error on line 2: 'inout' before a parameter name is not allowed, place it before the parameter type instead, Fix-It replacements: 12 - 17 = '', 26 - 26 = 'inout '
        DiagnosticSpec(locationMarker: "DIAG_1", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected type in type"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "extraneous ') {}' at top level"),
      ]
    )
  }

  func testInvalid1b() {
    AssertParse(
      """
      func test2(inout#^DIAG_1^# #^DIAG_2^#let x : Int#^DIAG_3^#) {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: 'let' in this position is interpreted as an argument label, Fix-It replacements: 18 - 21 = '`let`'
        // TODO: Old parser expected error on line 1: 'inout' before a parameter name is not allowed, place it before the parameter type instead, Fix-It replacements: 12 - 17 = '', 26 - 26 = 'inout '
        DiagnosticSpec(locationMarker: "DIAG_1", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected type in type"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "extraneous ') {}' at top level"),
      ]
    )
  }

  func testInvalid1c() {
    AssertParse(
      """
      func test3(f : (inout _ #^DIAG_5^#x : Int) -> Void) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'inout' before a parameter name is not allowed, place it before the parameter type instead
        DiagnosticSpec(locationMarker: "DIAG_5", message: "unexpected text 'x : Int' in function type"),
      ]
    )
  }

  func testInvalid2a() {
    AssertParse(
      """
      func test1s(__shared#^DIAG_1^# #^DIAG_2^#var x : Int#^DIAG_3^#) {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: 'var' in this position is interpreted as an argument label, Fix-It replacements: 22 - 25 = '`var`'
        // TODO: Old parser expected error on line 1: '__shared' before a parameter name is not allowed, place it before the parameter type instead, Fix-It replacements: 13 - 21 = '', 30 - 30 = '__shared '
        DiagnosticSpec(locationMarker: "DIAG_1", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected type in type"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "extraneous ') {}' at top level"),
      ]
    )
  }

  func testInvalid2b() {
    AssertParse(
      """
      func test2s(__shared#^DIAG_1^# #^DIAG_2^#let x : Int#^DIAG_3^#) {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: 'let' in this position is interpreted as an argument label, Fix-It replacements: 22 - 25 = '`let`'
        // TODO: Old parser expected error on line 1: '__shared' before a parameter name is not allowed, place it before the parameter type instead, Fix-It replacements: 13 - 21 = '', 30 - 30 = '__shared '
        DiagnosticSpec(locationMarker: "DIAG_1", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected type in type"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "extraneous ') {}' at top level"),
      ]
    )
  }

  func testInvalid3a() {
    AssertParse(
      """
      func test1o(__owned#^DIAG_1^# #^DIAG_2^#var x : Int#^DIAG_3^#) {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: 'var' in this position is interpreted as an argument label, Fix-It replacements: 21 - 24 = '`var`'
        // TODO: Old parser expected error on line 1: '__owned' before a parameter name is not allowed, place it before the parameter type instead, Fix-It replacements: 13 - 20 = ''
        DiagnosticSpec(locationMarker: "DIAG_1", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected type in type"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "extraneous ') {}' at top level"),
      ]
    )
  }

  func testInvalid3b() {
    AssertParse(
      """
      func test2o(__owned#^DIAG_1^# #^DIAG_2^#let x : Int#^DIAG_3^#) {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 2: 'let' in this position is interpreted as an argument label, Fix-It replacements: 21 - 24 = '`let`'
        // TODO: Old parser expected error on line 2: '__owned' before a parameter name is not allowed, place it before the parameter type instead, Fix-It replacements: 13 - 20 = ''
        DiagnosticSpec(locationMarker: "DIAG_1", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected type in type"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "extraneous ') {}' at top level"),
      ]
    )
  }

  func testInvalid4() {
    AssertParse(
      """
      func test3() {
        undeclared_func( #^DIAG^#
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected value in function call"),
        DiagnosticSpec(message: "expected ')' to end function call"),
        // TODO: Old parser expected error on line 3: expected expression in list of expressions
      ]
    )
  }

  func testInvalid5() {
    AssertParse(
      """
      func runAction() {}
      """
    )
  }

  func testInvalid6() {
    AssertParse(
      """
      // rdar://16601779
      func foo() {
        runAction(SKAction.sequence()#^DIAG^#
          skview!
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: expected ',' separator, Fix-It replacements: 32 - 32 = ','
        DiagnosticSpec(message: "expected ')' to end function call"),
      ]
    )
  }

  func testInvalid7() {
    AssertParse(
      """
      super.init()
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'super' cannot be used outside of class members
      ]
    )
  }

  func testInvalid8() {
    AssertParse(
      """
      switch state { #^DIAG_1^#
        let duration : Int = 0
        #^DIAG_2^#case 1:
          break
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected '}' to end 'switch' statement"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "extraneous code at top level"),
      ]
    )
  }

  func testInvalid9() {
    AssertParse(
      #"""
      func testNotCoveredCase(x: Int) {
        switch x {#^DIAG_1^#
          let y = "foo"
          switch y {
            case "bar":
              blah blah // ignored
          }
        #^DIAG_2^#case "baz":
          break
        case 1:
          break
        default:
          break
        }
      #^DIAG_3^#}
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected '}' to end 'switch' statement"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text in function"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "extraneous '}' at top level"),
      ]
    )
  }

  func testInvalid10() {
    AssertParse(
      ##"""
      // rdar://18926814
      func test4() {
        let abc = 123
        _ = " >> \( abc #^DIAG_1^#} ) << "#^DIAG_2^#
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 4: expected ',' separator, Fix-It replacements: 18 - 18 = ','
        // TODO: Old parser expected error on line 4: expected expression in list of expressions
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text '}' in string literal"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected '}' to end function"),
      ]
    )
  }

  func testInvalid11() {
    AssertParse(
      """
      // rdar://problem/18507467
      func d(_ b: #^DIAG_1^#String #^DIAG_2^#->#^DIAG_3^# #^DIAG_4^#<T>() -> T#^DIAG_5^#) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected type for function result
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected '(' to start function type"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected ')' in function type"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected type in function type"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_5", message: "extraneous ') {}' at top level"),
      ]
    )
  }

  func testInvalid12() {
    AssertParse(
      """
      // <rdar://problem/22143680> QoI: terrible diagnostic when trying to form a generic protocol
      protocol Animal<Food> {
        func feed(_ food: Food)
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: an associated type named 'Food' must be declared in the protocol 'Animal' or a protocol it inherits
        // TODO: Old parser expected error on line 3: cannot find type 'Food' in scope
      ]
    )
  }

  func testInvalid13() {
    AssertParse(
      """
      // https://github.com/apple/swift/issues/43190
      // Crash with invalid parameter declaration
      do {
        class Starfish {}
        struct Salmon {}
        func f(s Starfish#^DIAG^#,
                  _ ss: Salmon) -> [Int] {}
        func g() { f(Starfish(), Salmon()) }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 6: expected ':' following argument label and parameter name
        DiagnosticSpec(message: "expected ':' and type in function parameter"),
      ]
    )
  }

  func testInvalid14() {
    AssertParse(
      """
      // https://github.com/apple/swift/issues/43313
      do {
        func f(_ a: Int, b: Int) {}
        f(1, b: 2,#^DIAG^#)
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: unexpected ',' separator
        DiagnosticSpec(message: "expected value in function call"),
      ]
    )
  }

  func testInvalid15() {
    AssertParse(
      """
      // https://github.com/apple/swift/issues/43591
      // Two inout crash compiler
      """
    )
  }

  func testInvalid16() {
    AssertParse(
      """
      func f1_43591(a : inout inout Int) {}
      func f2_43591(inout inout b#^DIAG_1^#: Int) {}
      func f3_43591(let let #^DIAG_2^#a: Int) {}
      func f4_43591(inout x#^DIAG_3^#: inout String) {}
      func f5_43591(inout i#^DIAG_4^#: inout Int) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: parameter must not have multiple '__owned', 'inout', or '__shared' specifiers, Fix-It replacements: 19 - 25 = ''
        // TODO: Old parser expected error on line 2: inout' before a parameter name is not allowed, place it before the parameter type instead, Fix-It replacements: 15 - 20 = '', 30 - 30 = 'inout '
        // TODO: Old parser expected error on line 2: parameter must not have multiple '__owned', 'inout', or '__shared' specifiers, Fix-It replacements: 21 - 27 = ''
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text ': Int' in parameter clause"),
        // TODO: Old parser expected warning on line 3: 'let' in this position is interpreted as an argument label, Fix-It replacements: 15 - 18 = '`let`'
        // TODO: Old parser expected error on line 3: expected ',' separator, Fix-It replacements: 22 - 22 = ','
        // TODO: Old parser expected error on line 3: expected ':' following argument label and parameter name
        // TODO: Old parser expected warning on line 3: extraneous duplicate parameter name; 'let' already has an argument label, Fix-It replacements: 15 - 19 = ''
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text 'a' in function parameter"),
        // TODO: Old parser expected error on line 4: parameter must not have multiple '__owned', 'inout', or '__shared' specifiers, Fix-It replacements: 15 - 20 = ''
        DiagnosticSpec(locationMarker: "DIAG_3", message: "unexpected text ': inout String' in parameter clause"),
        // TODO: Old parser expected error on line 5: parameter must not have multiple '__owned', 'inout', or '__shared' specifiers, Fix-It replacements: 15 - 20 = ''
        DiagnosticSpec(locationMarker: "DIAG_4", message: "unexpected text ': inout Int' in parameter clause"),
      ]
    )
  }

  func testInvalid17() {
    AssertParse(
      """
      func#^DIAG_1^# #^DIAG_2^#repeat#^DIAG_3^#() {}#^DIAG_4^#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: keyword 'repeat' cannot be used as an identifier here
        // TODO: Old parser expected note on line 1: if this name is unavoidable, use backticks to escape it, Fix-It replacements: 6 - 12 = '`repeat`'
        DiagnosticSpec(locationMarker: "DIAG_1", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected identifier in function"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected argument list in function declaration"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "unexpected text '()' in 'repeat' statement"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected 'while' and condition in 'repeat' statement"),
      ]
    )
  }

  func testInvalid18() {
    AssertParse(
      """
      let#^DIAG_1^# #^DIAG_2^#for #^DIAG_3^#= 2
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: keyword 'for' cannot be used as an identifier here
        // TODO: Old parser expected note on line 1: if this name is unavoidable, use backticks to escape it, Fix-It replacements: 5 - 8 = '`for`'
        DiagnosticSpec(locationMarker: "DIAG_1", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected pattern in variable"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected pattern, 'in' and expression in 'for' statement"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected code block in 'for' statement"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "extraneous '= 2' at top level"),
      ]
    )
  }

  func testInvalid19() {
    AssertParse(
      """
      func f4_43591(inout x#^DIAG^#: inout String) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: parameter must not have multiple '__owned', 'inout', or '__shared' specifiers, Fix-It replacements: 15 - 20 = ''
        DiagnosticSpec(message: "unexpected text ': inout String' in parameter clause"),
      ]
    )
  }

  func testInvalid20() {
    AssertParse(
      """
      func f5_43591(inout i#^DIAG^#: inout Int) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: parameter must not have multiple '__owned', 'inout', or '__shared' specifiers, Fix-It replacements: 15 - 20 = ''
        DiagnosticSpec(message: "unexpected text ': inout Int' in parameter clause"),
      ]
    )
  }

  func testInvalid21() {
    AssertParse(
      """
      func#^DIAG_1^# #^DIAG_2^#repeat#^DIAG_3^#() {}#^DIAG_4^#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: keyword 'repeat' cannot be used as an identifier here
        // TODO: Old parser expected note on line 1: if this name is unavoidable, use backticks to escape it, Fix-It replacements: 6 - 12 = '`repeat`'
        DiagnosticSpec(locationMarker: "DIAG_1", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected identifier in function"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected argument list in function declaration"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "unexpected text '()' in 'repeat' statement"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected 'while' and condition in 'repeat' statement"),
      ]
    )
  }

  func testInvalid22() {
    AssertParse(
      """
      let#^DIAG_1^# #^DIAG_2^#for #^DIAG_3^#= 2
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: keyword 'for' cannot be used as an identifier here
        // TODO: Old parser expected note on line 1: if this name is unavoidable, use backticks to escape it, Fix-It replacements: 5 - 8 = '`for`'
        DiagnosticSpec(locationMarker: "DIAG_1", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected pattern in variable"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected pattern, 'in' and expression in 'for' statement"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected code block in 'for' statement"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "extraneous '= 2' at top level"),
      ]
    )
  }

  func testInvalid23() {
    AssertParse(
      """
      func dog #^DIAG^#cow() {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: found an unexpected second identifier in function declaration; is there an accidental break?
        // TODO: Old parser expected note on line 1: join the identifiers together, Fix-It replacements: 6 - 13 = 'dogcow'
        // TODO: Old parser expected note on line 1: join the identifiers together with camel-case, Fix-It replacements: 6 - 13 = 'dogCow'
        DiagnosticSpec(message: "unexpected text 'cow' before parameter clause"),
      ]
    )
  }

  func testInvalid24() {
    AssertParse(
      """
      func cat #^DIAG^#Mouse() {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: found an unexpected second identifier in function declaration; is there an accidental break?
        // TODO: Old parser expected note on line 1: join the identifiers together, Fix-It replacements: 6 - 15 = 'catMouse'
        DiagnosticSpec(message: "unexpected text 'Mouse' before parameter clause"),
      ]
    )
  }

  func testInvalid25() {
    AssertParse(
      """
      func friend #^DIAG^#ship<T>(x: T) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: found an unexpected second identifier in function declaration; is there an accidental break?
        // TODO: Old parser expected note on line 1: join the identifiers together, Fix-It replacements: 6 - 17 = 'friendship'
        // TODO: Old parser expected note on line 1: join the identifiers together with camel-case, Fix-It replacements: 6 - 17 = 'friendShip'
        DiagnosticSpec(message: "unexpected text 'ship<T>' before parameter clause"),
      ]
    )
  }

  func testInvalid26() {
    AssertParse(
      """
      func were#^DIAG_1^#
      wolf#^DIAG_2^#() {}
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected '(' to start parameter clause"),
        // TODO: Old parser expected error on line 2: found an unexpected second identifier in function declaration; is there an accidental break?
        // TODO: Old parser expected note on line 2: join the identifiers together, Fix-It replacements: 6 - 5 = 'werewolf'
        // TODO: Old parser expected note on line 2: join the identifiers together with camel-case, Fix-It replacements: 6 - 5 = 'wereWolf'
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "consecutive statements on a line must be separated by ';'"),
      ]
    )
  }

  func testInvalid27() {
    AssertParse(
      """
      func hammer#^DIAG_1^#
      leavings<T>#^DIAG_2^#(x: T) {}
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected '(' to start parameter clause"),
        // TODO: Old parser expected error on line 2: found an unexpected second identifier in function declaration; is there an accidental break?
        // TODO: Old parser expected note on line 2: join the identifiers together, Fix-It replacements: 6 - 9 = 'hammerleavings'
        // TODO: Old parser expected note on line 2: join the identifiers together with camel-case, Fix-It replacements: 6 - 9 = 'hammerLeavings'
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "consecutive statements on a line must be separated by ';'"),
      ]
    )
  }

  func testInvalid28() {
    AssertParse(
      """
      prefix operator %
      prefix func %<T>(x: T) -> T { return x } // No error expected - the < is considered an identifier but is peeled off by the parser.
      """
    )
  }

  func testInvalid29() {
    AssertParse(
      """
      struct Weak<T: #^DIAG_1^#class#^DIAG_2^#> {
        weak let value: T
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'class' constraint can only appear on protocol declarations
        // TODO: Old parser expected note on line 1: did you mean to write an 'AnyObject' constraint?, Fix-It replacements: 16 - 21 = 'AnyObject'
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected '>' to end generic parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected '{' in struct"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected identifier in class"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected member block in class"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected declaration in struct"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected '}' to end struct"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "extraneous code at top level"),
        // TODO: Old parser expected error on line 2: 'weak' must be a mutable variable, because it may change at runtime
        // TODO: Old parser expected error on line 2: 'weak' variable should have optional type 'T?'
        // TODO: Old parser expected error on line 2: 'weak' must not be applied to non-class-bound 'T'; consider adding a protocol conformance that has a class bound
      ]
    )
  }

  func testInvalid30() {
    AssertParse(
      """
      let x: () = ()
      !()
      !(())
      !(x)
      !x
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: cannot convert value of type '()' to expected argument type 'Bool'
        // TODO: Old parser expected error on line 3: cannot convert value of type '()' to expected argument type 'Bool'
        // TODO: Old parser expected error on line 4: cannot convert value of type '()' to expected argument type 'Bool'
        // TODO: Old parser expected error on line 5: cannot convert value of type '()' to expected argument type 'Bool'
      ]
    )
  }

  func testInvalid31() {
    AssertParse(
      """
      // https://github.com/apple/swift/issues/50734
      """
    )
  }

  func testInvalid32() {
    AssertParse(
      """
      func f1_50734(@NSApplicationMain x: Int) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: @NSApplicationMain may only be used on 'class' declarations
      ]
    )
  }

  func testInvalid33() {
    AssertParse(
      """
      func f2_50734(@available(iOS, deprecated: 0) x: Int) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '@available' attribute cannot be applied to this declaration
      ]
    )
  }

  func testInvalid34() {
    AssertParse(
      """
      func f3_50734(@discardableResult x: Int) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '@discardableResult' attribute cannot be applied to this declaration
      ]
    )
  }

  func testInvalid35() {
    AssertParse(
      """
      func f4_50734(@objcMembers x: String) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: @objcMembers may only be used on 'class' declarations
      ]
    )
  }

  func testInvalid36() {
    AssertParse(
      """
      func f5_50734(@weak x: String) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'weak' is a declaration modifier, not an attribute
        // TODO: Old parser expected error on line 1: 'weak' may only be used on 'var' declarations
      ]
    )
  }

  func testInvalid37() {
    AssertParse(
      """
      class C_50734<@NSApplicationMain T: AnyObject> {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: @NSApplicationMain may only be used on 'class' declarations
      ]
    )
  }

  func testInvalid38() {
    AssertParse(
      """
      func f6_50734<@discardableResult T>(x: T) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '@discardableResult' attribute cannot be applied to this declaration
      ]
    )
  }

  func testInvalid39() {
    AssertParse(
      """
      enum E_50734<@indirect T> {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'indirect' is a declaration modifier, not an attribute
        // TODO: Old parser expected error on line 1: 'indirect' modifier cannot be applied to this declaration
      ]
    )
  }

  func testInvalid40() {
    AssertParse(
      """
      protocol P {
        @available(swift, introduced: 4.2) associatedtype Assoc
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: '@available' attribute cannot be applied to this declaration
      ]
    )
  }

}
