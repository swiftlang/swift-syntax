// This test file has been translated from swift/test/Parse/invalid.swift

import XCTest

final class InvalidTests: XCTestCase {
  func testInvalid1a() {
    AssertParse(
      """
      // rdar://15946844
      func test1(inout 1️⃣var x : Int2️⃣) {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 2: 'var' in this position is interpreted as an argument label, Fix-It replacements: 18 - 21 = '`var`'
        // TODO: Old parser expected error on line 2: 'inout' before a parameter name is not allowed, place it before the parameter type instead, Fix-It replacements: 12 - 17 = '', 26 - 26 = 'inout '
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected type in type"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous code ') {}' at top level"),
      ]
    )
  }

  func testInvalid1b() {
    AssertParse(
      """
      func test2(inout 1️⃣let x : Int2️⃣) {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: 'let' in this position is interpreted as an argument label, Fix-It replacements: 18 - 21 = '`let`'
        // TODO: Old parser expected error on line 1: 'inout' before a parameter name is not allowed, place it before the parameter type instead, Fix-It replacements: 12 - 17 = '', 26 - 26 = 'inout '
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected type in type"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous code ') {}' at top level"),
      ]
    )
  }

  func testInvalid1c() {
    AssertParse(
      """
      func test3(f : (inout _ 5️⃣x : Int) -> Void) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'inout' before a parameter name is not allowed, place it before the parameter type instead
        DiagnosticSpec(locationMarker: "5️⃣", message: "unexpected code 'x : Int' in function type"),
      ]
    )
  }

  func testInvalid2a() {
    AssertParse(
      """
      func test1s(__shared 1️⃣var x : Int2️⃣) {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: 'var' in this position is interpreted as an argument label, Fix-It replacements: 22 - 25 = '`var`'
        // TODO: Old parser expected error on line 1: '__shared' before a parameter name is not allowed, place it before the parameter type instead, Fix-It replacements: 13 - 21 = '', 30 - 30 = '__shared '
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected type in type"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous code ') {}' at top level"),
      ]
    )
  }

  func testInvalid2b() {
    AssertParse(
      """
      func test2s(__shared 1️⃣let x : Int2️⃣) {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: 'let' in this position is interpreted as an argument label, Fix-It replacements: 22 - 25 = '`let`'
        // TODO: Old parser expected error on line 1: '__shared' before a parameter name is not allowed, place it before the parameter type instead, Fix-It replacements: 13 - 21 = '', 30 - 30 = '__shared '
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected type in type"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous code ') {}' at top level"),
      ]
    )
  }

  func testInvalid3a() {
    AssertParse(
      """
      func test1o(__owned 1️⃣var x : Int2️⃣) {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: 'var' in this position is interpreted as an argument label, Fix-It replacements: 21 - 24 = '`var`'
        // TODO: Old parser expected error on line 1: '__owned' before a parameter name is not allowed, place it before the parameter type instead, Fix-It replacements: 13 - 20 = ''
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected type in type"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous code ') {}' at top level"),
      ]
    )
  }

  func testInvalid3b() {
    AssertParse(
      """
      func test2o(__owned 1️⃣let x : Int2️⃣) {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 2: 'let' in this position is interpreted as an argument label, Fix-It replacements: 21 - 24 = '`let`'
        // TODO: Old parser expected error on line 2: '__owned' before a parameter name is not allowed, place it before the parameter type instead, Fix-It replacements: 13 - 20 = ''
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected type in type"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous code ') {}' at top level"),
      ]
    )
  }

  func testInvalid4() {
    AssertParse(
      """
      func test3() {
        undeclared_func( 1️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected value and ')' to end function call"),
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
        runAction(SKAction.sequence()1️⃣
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
      switch state {
        1️⃣let duration : Int = 0
        case 1:
          break
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "all statements inside a switch must be covered by a 'case' or 'default' label"),
      ]
    )
  }

  func testInvalid9() {
    AssertParse(
      #"""
      func testNotCoveredCase(x: Int) {
        switch x {
          1️⃣let y = "foo"
          switch y {
            case "bar":
              blah blah // ignored
          }
        case "baz":
          break
        case 1:
          break
        default:
          break
        }
      }
      """#,
      diagnostics: [
        DiagnosticSpec(message: "all statements inside a switch must be covered by a 'case' or 'default' label"),
      ]
    )
  }

  func testInvalid10() {
    AssertParse(
      ##"""
      // rdar://18926814
      func test4() {
        let abc = 123
        _ = " >> \( abc 1️⃣} ) << "2️⃣
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 4: expected ',' separator, Fix-It replacements: 18 - 18 = ','
        // TODO: Old parser expected error on line 4: expected expression in list of expressions
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace in string literal"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '}' to end function"),
      ]
    )
  }

  func testInvalid11() {
    AssertParse(
      """
      // rdar://problem/18507467
      func d(_ b: 1️⃣String 2️⃣-> 3️⃣<T>() -> T4️⃣) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected type for function result
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '(' to start function type"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ')' in function type"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected type in function type"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "extraneous code ') {}' at top level"),
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
        func f(s Starfish1️⃣,
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
        f(1, b: 2,1️⃣)
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
      func f2_43591(inout inout b1️⃣: Int) {}
      func f3_43591(let let 2️⃣a: Int) {}
      func f4_43591(inout x3️⃣: inout String) {}
      func f5_43591(inout i4️⃣: inout Int) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: parameter must not have multiple '__owned', 'inout', or '__shared' specifiers, Fix-It replacements: 19 - 25 = ''
        // TODO: Old parser expected error on line 2: inout' before a parameter name is not allowed, place it before the parameter type instead, Fix-It replacements: 15 - 20 = '', 30 - 30 = 'inout '
        // TODO: Old parser expected error on line 2: parameter must not have multiple '__owned', 'inout', or '__shared' specifiers, Fix-It replacements: 21 - 27 = ''
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code ': Int' in parameter clause"),
        // TODO: Old parser expected warning on line 3: 'let' in this position is interpreted as an argument label, Fix-It replacements: 15 - 18 = '`let`'
        // TODO: Old parser expected error on line 3: expected ',' separator, Fix-It replacements: 22 - 22 = ','
        // TODO: Old parser expected error on line 3: expected ':' following argument label and parameter name
        // TODO: Old parser expected warning on line 3: extraneous duplicate parameter name; 'let' already has an argument label, Fix-It replacements: 15 - 19 = ''
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code 'a' in function parameter"),
        // TODO: Old parser expected error on line 4: parameter must not have multiple '__owned', 'inout', or '__shared' specifiers, Fix-It replacements: 15 - 20 = ''
        DiagnosticSpec(locationMarker: "3️⃣", message: "unexpected code ': inout String' in parameter clause"),
        // TODO: Old parser expected error on line 5: parameter must not have multiple '__owned', 'inout', or '__shared' specifiers, Fix-It replacements: 15 - 20 = ''
        DiagnosticSpec(locationMarker: "4️⃣", message: "unexpected code ': inout Int' in parameter clause"),
      ]
    )
  }

  func testInvalid17() {
    AssertParse(
      """
      func 1️⃣repeat() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "keyword 'repeat' cannot be used as an identifier here"),
      ]
    )
  }

  func testInvalid18() {
    AssertParse(
      """
      let 1️⃣for = 2
      """,
      diagnostics: [
        DiagnosticSpec(message: "keyword 'for' cannot be used as an identifier here"),
      ]
    )
  }

  func testInvalid19() {
    AssertParse(
      """
      func f4_43591(inout x1️⃣: inout String) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: parameter must not have multiple '__owned', 'inout', or '__shared' specifiers, Fix-It replacements: 15 - 20 = ''
        DiagnosticSpec(message: "unexpected code ': inout String' in parameter clause"),
      ]
    )
  }

  func testInvalid20() {
    AssertParse(
      """
      func f5_43591(inout i1️⃣: inout Int) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: parameter must not have multiple '__owned', 'inout', or '__shared' specifiers, Fix-It replacements: 15 - 20 = ''
        DiagnosticSpec(message: "unexpected code ': inout Int' in parameter clause"),
      ]
    )
  }

  func testInvalid21() {
    AssertParse(
      """
      func 1️⃣repeat() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "keyword 'repeat' cannot be used as an identifier here"),
      ]
    )
  }

  func testInvalid22() {
    AssertParse(
      """
      let 1️⃣for 2️⃣= 2
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: keyword 'for' cannot be used as an identifier here
        // TODO: Old parser expected note on line 1: if this name is unavoidable, use backticks to escape it, Fix-It replacements: 5 - 8 = '`for`'
        DiagnosticSpec(message: "keyword 'for' cannot be used as an identifier here"),
      ]
    )
  }

  func testInvalid23() {
    AssertParse(
      """
      func dog 1️⃣cow() {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: found an unexpected second identifier in function declaration; is there an accidental break?
        // TODO: Old parser expected note on line 1: join the identifiers together, Fix-It replacements: 6 - 13 = 'dogcow'
        // TODO: Old parser expected note on line 1: join the identifiers together with camel-case, Fix-It replacements: 6 - 13 = 'dogCow'
        DiagnosticSpec(message: "unexpected code 'cow' before parameter clause"),
      ]
    )
  }

  func testInvalid24() {
    AssertParse(
      """
      func cat 1️⃣Mouse() {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: found an unexpected second identifier in function declaration; is there an accidental break?
        // TODO: Old parser expected note on line 1: join the identifiers together, Fix-It replacements: 6 - 15 = 'catMouse'
        DiagnosticSpec(message: "unexpected code 'Mouse' before parameter clause"),
      ]
    )
  }

  func testInvalid25() {
    AssertParse(
      """
      func friend 1️⃣ship<T>(x: T) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: found an unexpected second identifier in function declaration; is there an accidental break?
        // TODO: Old parser expected note on line 1: join the identifiers together, Fix-It replacements: 6 - 17 = 'friendship'
        // TODO: Old parser expected note on line 1: join the identifiers together with camel-case, Fix-It replacements: 6 - 17 = 'friendShip'
        DiagnosticSpec(message: "unexpected code 'ship<T>' before parameter clause"),
      ]
    )
  }

  func testInvalid26() {
    AssertParse(
      """
      func were1️⃣
      wolf2️⃣() {}
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '(' to start parameter clause"),
        // TODO: Old parser expected error on line 2: found an unexpected second identifier in function declaration; is there an accidental break?
        // TODO: Old parser expected note on line 2: join the identifiers together, Fix-It replacements: 6 - 5 = 'werewolf'
        // TODO: Old parser expected note on line 2: join the identifiers together with camel-case, Fix-It replacements: 6 - 5 = 'wereWolf'
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ')' to end parameter clause"),
      ]
    )
  }

  func testInvalid27() {
    AssertParse(
      """
      func hammer1️⃣
      leavings<T>2️⃣(x: T) {}
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '(' to start parameter clause"),
        // TODO: Old parser expected error on line 2: found an unexpected second identifier in function declaration; is there an accidental break?
        // TODO: Old parser expected note on line 2: join the identifiers together, Fix-It replacements: 6 - 9 = 'hammerleavings'
        // TODO: Old parser expected note on line 2: join the identifiers together with camel-case, Fix-It replacements: 6 - 9 = 'hammerLeavings'
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ')' to end parameter clause"),
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
      struct Weak<T: 1️⃣class2️⃣> {
        weak let value: T
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'class' constraint can only appear on protocol declarations
        // TODO: Old parser expected note on line 1: did you mean to write an 'AnyObject' constraint?, Fix-It replacements: 16 - 21 = 'AnyObject'
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '>' to end generic parameter clause"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '{' in struct"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected identifier and member block in class"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '}' to end struct"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous code at top level"),
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
