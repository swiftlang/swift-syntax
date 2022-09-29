// This test file has been translated from swift/test/Parse/invalid.swift

import XCTest

final class InvalidTests: XCTestCase {
  func testInvalid1() {
    AssertParse(
      """
      // rdar://15946844
      func test1(inout #^DIAG_1^#var x : Int#^DIAG_2^#) {}  
      func test2(inout #^DIAG_3^#let x : Int#^DIAG_4^#) {}  
      func test3(f : (inout _ #^DIAG_5^#x : Int) -> Void) {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 2: 'var' in this position is interpreted as an argument label, Fix-It replacements: 18 - 21 = '`var`'
        // TODO: Old parser expected error on line 2: 'inout' before a parameter name is not allowed, place it before the parameter type instead, Fix-It replacements: 12 - 17 = '', 26 - 26 = 'inout '
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected type in type"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text ') {}' before function"),
        // TODO: Old parser expected warning on line 3: 'let' in this position is interpreted as an argument label, Fix-It replacements: 18 - 21 = '`let`'
        // TODO: Old parser expected error on line 3: 'inout' before a parameter name is not allowed, place it before the parameter type instead, Fix-It replacements: 12 - 17 = '', 26 - 26 = 'inout '
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected type in type"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "unexpected text ') {}' before function"),
        // TODO: Old parser expected error on line 4: 'inout' before a parameter name is not allowed, place it before the parameter type instead
        DiagnosticSpec(locationMarker: "DIAG_5", message: "unexpected text 'x : Int' in function type"),
      ]
    )
  }

  func testInvalid2() {
    AssertParse(
      """
      func test1s(__shared #^DIAG_1^#var x : Int#^DIAG_2^#) {}  
      func test2s(__shared #^DIAG_3^#let x : Int#^DIAG_4^#) {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: 'var' in this position is interpreted as an argument label, Fix-It replacements: 22 - 25 = '`var`'
        // TODO: Old parser expected error on line 1: '__shared' before a parameter name is not allowed, place it before the parameter type instead, Fix-It replacements: 13 - 21 = '', 30 - 30 = '__shared '
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected type in type"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text ') {}' before function"),
        // TODO: Old parser expected warning on line 2: 'let' in this position is interpreted as an argument label, Fix-It replacements: 22 - 25 = '`let`'
        // TODO: Old parser expected error on line 2: '__shared' before a parameter name is not allowed, place it before the parameter type instead, Fix-It replacements: 13 - 21 = '', 30 - 30 = '__shared '
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected type in type"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "extraneous ') {}' at top level"),
      ]
    )
  }

  func testInvalid3() {
    AssertParse(
      """
      func test1o(__owned #^DIAG_1^#var x : Int#^DIAG_2^#) {}  
      func test2o(__owned #^DIAG_3^#let x : Int#^DIAG_4^#) {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: 'var' in this position is interpreted as an argument label, Fix-It replacements: 21 - 24 = '`var`'
        // TODO: Old parser expected error on line 1: '__owned' before a parameter name is not allowed, place it before the parameter type instead, Fix-It replacements: 13 - 20 = ''
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected type in type"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text ') {}' before function"),
        // TODO: Old parser expected warning on line 2: 'let' in this position is interpreted as an argument label, Fix-It replacements: 21 - 24 = '`let`'
        // TODO: Old parser expected error on line 2: '__owned' before a parameter name is not allowed, place it before the parameter type instead, Fix-It replacements: 13 - 20 = ''
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected type in type"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "extraneous ') {}' at top level"),
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
      #^DIAG_1^#}
      // rdar://problem/18507467
      func d(_ b: #^DIAG_2^#String #^DIAG_3^#-> #^DIAG_4^#<T>() -> T#^DIAG_5^#) {} 
      // <rdar://problem/22143680> QoI: terrible diagnostic when trying to form a generic protocol
      protocol Animal<Food> {  
        func feed(_ food: Food) 
      }
      // https://github.com/apple/swift/issues/43190
      // Crash with invalid parameter declaration
      do {
        class Starfish {}
        struct Salmon {}
        func f(s Starfish#^DIAG_6^#,  
                  _ ss: Salmon) -> [Int] {}
        func g() { f(Starfish(), Salmon()) }
      }
      // https://github.com/apple/swift/issues/43313
      do {
        func f(_ a: Int, b: Int) {}
        f(1, b: 2,#^DIAG_7^#) 
      }
      // https://github.com/apple/swift/issues/43591
      // Two inout crash compiler
      func f1_43591(a : inout inout Int) {}  
      func f2_43591(inout inout b#^DIAG_8^#: Int) {} 
      func f3_43591(let let #^DIAG_9^#a: Int) {} 
      func f4_43591(inout x#^DIAG_10^#: inout String) {} 
      func f5_43591(inout i#^DIAG_11^#: inout Int) {} 
      func #^DIAG_12^#repeat#^DIAG_13^#() {}#^DIAG_14^#
      let #^DIAG_15^#for #^DIAG_16^#= 2
      func dog #^DIAG_17^#cow() {} 
      func cat #^DIAG_18^#Mouse() {} 
      func friend #^DIAG_19^#ship<T>(x: T) {} 
      func were#^DIAG_20^#
      wolf#^DIAG_21^#() {} 
      func hammer#^DIAG_22^#
      leavings<T>#^DIAG_23^#(x: T) {} 
      prefix operator %
      prefix func %<T>(x: T) -> T { return x } // No error expected - the < is considered an identifier but is peeled off by the parser.
      struct Weak<T: #^DIAG_24^#class#^DIAG_25^#> { 
        weak let value: T 
      }
      let x: () = ()
      !() 
      !(()) 
      !(x) 
      !x 
      // https://github.com/apple/swift/issues/50734
      func f1_50734(@NSApplicationMain x: Int) {} 
      func f2_50734(@available(iOS, deprecated: 0) x: Int) {} 
      func f3_50734(@discardableResult x: Int) {} 
      func f4_50734(@objcMembers x: String) {} 
      func f5_50734(@weak x: String) {} 
      class C_50734<@NSApplicationMain T: AnyObject> {} 
      func f6_50734<@discardableResult T>(x: T) {} 
      enum E_50734<@indirect T> {} 
      protocol P {
        @available(swift, introduced: 4.2) associatedtype Assoc 
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text '}' before function"),
        // TODO: Old parser expected error on line 3: expected type for function result
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected '(' to start function type"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected ')' in function type"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected type in function type"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_5", message: "unexpected text ') {}' before protocol"),
        // TODO: Old parser expected error on line 13: expected ':' following argument label and parameter name
        DiagnosticSpec(locationMarker: "DIAG_6", message: "expected ':' and type in function parameter"),
        // TODO: Old parser expected error on line 20: unexpected ',' separator
        DiagnosticSpec(locationMarker: "DIAG_7", message: "expected value in function call"),
        // TODO: Old parser expected error on line 24: parameter must not have multiple '__owned', 'inout', or '__shared' specifiers, Fix-It replacements: 19 - 25 = ''
        // TODO: Old parser expected error on line 25: inout' before a parameter name is not allowed, place it before the parameter type instead, Fix-It replacements: 15 - 20 = '', 30 - 30 = 'inout '
        // TODO: Old parser expected error on line 25: parameter must not have multiple '__owned', 'inout', or '__shared' specifiers, Fix-It replacements: 21 - 27 = ''
        DiagnosticSpec(locationMarker: "DIAG_8", message: "unexpected text ': Int' in parameter clause"),
        // TODO: Old parser expected warning on line 26: 'let' in this position is interpreted as an argument label, Fix-It replacements: 15 - 18 = '`let`'
        // TODO: Old parser expected error on line 26: expected ',' separator, Fix-It replacements: 22 - 22 = ','
        // TODO: Old parser expected error on line 26: expected ':' following argument label and parameter name
        // TODO: Old parser expected warning on line 26: extraneous duplicate parameter name; 'let' already has an argument label, Fix-It replacements: 15 - 19 = ''
        DiagnosticSpec(locationMarker: "DIAG_9", message: "unexpected text 'a' in function parameter"),
        // TODO: Old parser expected error on line 27: parameter must not have multiple '__owned', 'inout', or '__shared' specifiers, Fix-It replacements: 15 - 20 = ''
        DiagnosticSpec(locationMarker: "DIAG_10", message: "unexpected text ': inout String' in parameter clause"),
        // TODO: Old parser expected error on line 28: parameter must not have multiple '__owned', 'inout', or '__shared' specifiers, Fix-It replacements: 15 - 20 = ''
        DiagnosticSpec(locationMarker: "DIAG_11", message: "unexpected text ': inout Int' in parameter clause"),
        // TODO: Old parser expected error on line 29: keyword 'repeat' cannot be used as an identifier here
        // TODO: Old parser expected note on line 29: if this name is unavoidable, use backticks to escape it, Fix-It replacements: 6 - 12 = '`repeat`'
        DiagnosticSpec(locationMarker: "DIAG_12", message: "expected identifier in function"),
        DiagnosticSpec(locationMarker: "DIAG_12", message: "expected argument list in function declaration"),
        DiagnosticSpec(locationMarker: "DIAG_13", message: "unexpected text '()' in 'repeat' statement"),
        DiagnosticSpec(locationMarker: "DIAG_14", message: "expected 'while' and condition in 'repeat' statement"),
        // TODO: Old parser expected error on line 30: keyword 'for' cannot be used as an identifier here
        // TODO: Old parser expected note on line 30: if this name is unavoidable, use backticks to escape it, Fix-It replacements: 5 - 8 = '`for`'
        DiagnosticSpec(locationMarker: "DIAG_15", message: "expected pattern in variable"),
        DiagnosticSpec(locationMarker: "DIAG_16", message: "expected pattern, 'in' and expression in 'for' statement"),
        DiagnosticSpec(locationMarker: "DIAG_16", message: "expected '{' in 'for' statement"),
        DiagnosticSpec(locationMarker: "DIAG_16", message: "unexpected text '= 2' before function"),
        // TODO: Old parser expected error on line 31: found an unexpected second identifier in function declaration; is there an accidental break?
        // TODO: Old parser expected note on line 31: join the identifiers together, Fix-It replacements: 6 - 13 = 'dogcow'
        // TODO: Old parser expected note on line 31: join the identifiers together with camel-case, Fix-It replacements: 6 - 13 = 'dogCow'
        DiagnosticSpec(locationMarker: "DIAG_17", message: "unexpected text 'cow' before parameter clause"),
        // TODO: Old parser expected error on line 32: found an unexpected second identifier in function declaration; is there an accidental break?
        // TODO: Old parser expected note on line 32: join the identifiers together, Fix-It replacements: 6 - 15 = 'catMouse'
        DiagnosticSpec(locationMarker: "DIAG_18", message: "unexpected text 'Mouse' before parameter clause"),
        // TODO: Old parser expected error on line 33: found an unexpected second identifier in function declaration; is there an accidental break?
        // TODO: Old parser expected note on line 33: join the identifiers together, Fix-It replacements: 6 - 17 = 'friendship'
        // TODO: Old parser expected note on line 33: join the identifiers together with camel-case, Fix-It replacements: 6 - 17 = 'friendShip'
        DiagnosticSpec(locationMarker: "DIAG_19", message: "unexpected text 'ship<T>' before parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_20", message: "expected '(' to start parameter clause"),
        // TODO: Old parser expected error on line 35: found an unexpected second identifier in function declaration; is there an accidental break?
        // TODO: Old parser expected note on line 35: join the identifiers together, Fix-It replacements: 6 - 5 = 'werewolf'
        // TODO: Old parser expected note on line 35: join the identifiers together with camel-case, Fix-It replacements: 6 - 5 = 'wereWolf'
        DiagnosticSpec(locationMarker: "DIAG_21", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_22", message: "expected '(' to start parameter clause"),
        // TODO: Old parser expected error on line 37: found an unexpected second identifier in function declaration; is there an accidental break?
        // TODO: Old parser expected note on line 37: join the identifiers together, Fix-It replacements: 6 - 9 = 'hammerleavings'
        // TODO: Old parser expected note on line 37: join the identifiers together with camel-case, Fix-It replacements: 6 - 9 = 'hammerLeavings'
        DiagnosticSpec(locationMarker: "DIAG_23", message: "expected ')' to end parameter clause"),
        // TODO: Old parser expected error on line 40: 'class' constraint can only appear on protocol declarations
        // TODO: Old parser expected note on line 40: did you mean to write an 'AnyObject' constraint?, Fix-It replacements: 16 - 21 = 'AnyObject'
        DiagnosticSpec(locationMarker: "DIAG_24", message: "expected '>' to end generic parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_24", message: "expected '{' in struct"),
        DiagnosticSpec(locationMarker: "DIAG_25", message: "expected identifier in class"),
        DiagnosticSpec(locationMarker: "DIAG_25", message: "expected member block in class"),
        DiagnosticSpec(locationMarker: "DIAG_25", message: "expected declaration in struct"),
        DiagnosticSpec(locationMarker: "DIAG_25", message: "expected '}' to end struct"),
        DiagnosticSpec(locationMarker: "DIAG_25", message: "expected '}' to end 'for' statement"),
        DiagnosticSpec(locationMarker: "DIAG_25", message: "extraneous code at top level"),
        // TODO: Old parser expected error on line 41: 'weak' must be a mutable variable, because it may change at runtime
        // TODO: Old parser expected error on line 49: @NSApplicationMain may only be used on 'class' declarations
        // TODO: Old parser expected error on line 50: '@available' attribute cannot be applied to this declaration
        // TODO: Old parser expected error on line 51: '@discardableResult' attribute cannot be applied to this declaration
        // TODO: Old parser expected error on line 52: @objcMembers may only be used on 'class' declarations
        // TODO: Old parser expected error on line 53: 'weak' is a declaration modifier, not an attribute
        // TODO: Old parser expected error on line 53: 'weak' may only be used on 'var' declarations
        // TODO: Old parser expected error on line 54: @NSApplicationMain may only be used on 'class' declarations
        // TODO: Old parser expected error on line 55: '@discardableResult' attribute cannot be applied to this declaration
        // TODO: Old parser expected error on line 56: 'indirect' is a declaration modifier, not an attribute
        // TODO: Old parser expected error on line 56: 'indirect' modifier cannot be applied to this declaration
        // TODO: Old parser expected error on line 58: '@available' attribute cannot be applied to this declaration
      ]
    )
  }

}
