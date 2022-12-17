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

// This test file has been translated from swift/test/Parse/invalid.swift

import XCTest

final class InvalidTests: XCTestCase {
  func testInvalid1a() {
    // rdar://15946844
    AssertParse(
      """
      func test1(1️⃣inout var x : Int) {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 2: 'var' in this position is interpreted as an argument label, Fix-It replacements: 18 - 21 = '`var`'
        DiagnosticSpec(message: "'inout' before a parameter name is not allowed", fixIts: ["move 'inout' in front of type"])
      ],
      fixedSource: "func test1(var x : inout Int) {}"
    )
  }

  func testInvalid1b() {
    AssertParse(
      """
      func test2(1️⃣inout let x : Int) {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: 'let' in this position is interpreted as an argument label, Fix-It replacements: 18 - 21 = '`let`'
        DiagnosticSpec(message: "'inout' before a parameter name is not allowed")
      ]
    )
  }

  func testInvalid1c() {
    AssertParse(
      """
      func test3(f : (1️⃣inout _ x : Int) -> Void) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "'inout' before a parameter name is not allowed", fixIts: ["move 'inout' in front of type"])
      ],
      fixedSource: "func test3(f : (_ x : inout Int) -> Void) {}"
    )
  }

  func testInvalid2a() {
    AssertParse(
      """
      func test1s(1️⃣__shared var x : Int) {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: 'var' in this position is interpreted as an argument label, Fix-It replacements: 22 - 25 = '`var`'
        DiagnosticSpec(message: "'__shared' before a parameter name is not allowed")
      ]
    )
  }

  func testInvalid2b() {
    AssertParse(
      """
      func test2s(1️⃣__shared let x : Int) {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: 'let' in this position is interpreted as an argument label, Fix-It replacements: 22 - 25 = '`let`'
        DiagnosticSpec(message: "'__shared' before a parameter name is not allowed")
      ]
    )
  }

  func testInvalid3a() {
    AssertParse(
      """
      func test1o(1️⃣__owned var x : Int) {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: 'var' in this position is interpreted as an argument label, Fix-It replacements: 21 - 24 = '`var`'
        DiagnosticSpec(message: "'__owned' before a parameter name is not allowed")
      ]
    )
  }

  func testInvalid3b() {
    AssertParse(
      """
      func test2o(1️⃣__owned let x : Int) {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 2: 'let' in this position is interpreted as an argument label, Fix-It replacements: 21 - 24 = '`let`'
        DiagnosticSpec(message: "'__owned' before a parameter name is not allowed")
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
        DiagnosticSpec(message: "expected value and ')' to end function call")
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
        DiagnosticSpec(message: "expected ')' to end function call")
      ]
    )
  }

  func testInvalid7() {
    AssertParse(
      """
      super.init()
      """
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
        DiagnosticSpec(message: "all statements inside a switch must be covered by a 'case' or 'default' label")
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
        DiagnosticSpec(message: "all statements inside a switch must be covered by a 'case' or 'default' label")
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
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace in string literal"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '}' to end function"),
      ]
    )
  }

  func testInvalid11() {
    // rdar://problem/18507467
    AssertParse(
      """
      func d(_ b: 1️⃣String 2️⃣-> 3️⃣<T>() -> T4️⃣) {}
      """,
      diagnostics: [
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
      """
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
        DiagnosticSpec(message: "expected ':' and type in parameter")
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
        DiagnosticSpec(message: "expected value in function call")
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

  func testInvalid16a() {
    AssertParse(
      """
      func f1_43591(a : inout 1️⃣inout Int) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected 'inout' keyword in type")
      ]
    )
  }

  func testInvalid16b() {
    AssertParse(
      """
      func f2_43591(1️⃣inout inout b: Int) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "'inout inout' before a parameter name is not allowed", fixIts: ["move 'inout inout' in front of type"])
      ],
      fixedSource: "func f2_43591(b: inout Int) {}"
    )
  }

  func testInvalid16c() {
    AssertParse(
      """
      func f3_43591(let let 1️⃣a: Int) {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 3: 'let' in this position is interpreted as an argument label, Fix-It replacements: 15 - 18 = '`let`'
        DiagnosticSpec(message: "unexpected code 'a' in parameter")
      ]
    )
  }

  func testInvalid16d() {
    AssertParse(
      """
      func f4_43591(1️⃣inout x: inout String) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "'inout' before a parameter name is not allowed")
      ]
    )
  }

  func testInvalid16e() {
    AssertParse(
      """
      func f5_43591(1️⃣inout i: inout Int) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "'inout' before a parameter name is not allowed")
      ]
    )
  }

  func testInvalid17() {
    AssertParse(
      """
      func 1️⃣repeat() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "keyword 'repeat' cannot be used as an identifier here")
      ]
    )
  }

  func testInvalid18() {
    AssertParse(
      """
      let 1️⃣for = 2
      """,
      diagnostics: [
        DiagnosticSpec(message: "keyword 'for' cannot be used as an identifier here")
      ]
    )
  }

  func testInvalid19() {
    AssertParse(
      """
      func f4_43591(1️⃣inout x: inout String) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "'inout' before a parameter name is not allowed")
      ]
    )
  }

  func testInvalid20() {
    AssertParse(
      """
      func f5_43591(1️⃣inout i: inout Int) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "'inout' before a parameter name is not allowed", fixIts: ["remove redundant 'inout'"])
      ],
      fixedSource: "func f5_43591(i: inout Int) {}"
    )
  }

  func testInvalid21() {
    AssertParse(
      """
      func 1️⃣repeat() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "keyword 'repeat' cannot be used as an identifier here")
      ]
    )
  }

  func testInvalid22() {
    AssertParse(
      """
      let 1️⃣for = 2
      """,
      diagnostics: [
        DiagnosticSpec(message: "keyword 'for' cannot be used as an identifier here")
      ]
    )
  }

  func testInvalid23a() {
    AssertParse(
      """
      func dog 1️⃣cow() {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "found an unexpected second identifier in function",
          fixIts: [
            "join the identifiers together",
            "join the identifiers together with camel-case",
          ]
        )
      ],
      applyFixIts: ["join the identifiers together"],
      fixedSource: "func dogcow() {}"
    )
  }

  func testInvalid23b() {
    AssertParse(
      """
      func dog 1️⃣cow() {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "found an unexpected second identifier in function",
          fixIts: [
            "join the identifiers together",
            "join the identifiers together with camel-case",
          ]
        )
      ],
      applyFixIts: ["join the identifiers together with camel-case"],
      fixedSource: "func dogCow() {}"
    )
  }

  func testThreeIdentifersForFunctionName() {
    AssertParse(
      """
      func dog 1️⃣cow sheep() {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "found an unexpected second identifier in function",
          fixIts: [
            "join the identifiers together",
            "join the identifiers together with camel-case",
          ]
        )
      ],
      applyFixIts: ["join the identifiers together with camel-case"],
      fixedSource: "func dogCowSheep() {}"
    )
  }

  func testInvalid24() {
    AssertParse(
      """
      func cat 1️⃣Mouse() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "found an unexpected second identifier in function", fixIts: ["join the identifiers together"])
      ],
      fixedSource: "func catMouse() {}"
    )
  }

  func testInvalid25() {
    AssertParse(
      """
      func friend 1️⃣ship<T>(x: T) {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "found an unexpected second identifier in function",
          fixIts: [
            "join the identifiers together",
            "join the identifiers together with camel-case",
          ]
        )
      ],
      applyFixIts: ["join the identifiers together with camel-case"],
      fixedSource: "func friendShip<T>(x: T) {}"
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
      struct Weak<T: 1️⃣class> {
        weak let value: T
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "'class' constraint can only appear on protocol declarations", fixIts: ["replace 'class' by 'AnyObject'"])
      ],
      fixedSource: """
        struct Weak<T: AnyObject> {
          weak let value: T
        }
        """
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
      """
    )
  }

  func testInvalid32() {
    // https://github.com/apple/swift/issues/50734
    AssertParse(
      """
      func f1_50734(@NSApplicationMain x: Int) {}
      """
    )
  }

  func testInvalid33() {
    AssertParse(
      """
      func f2_50734(@available(iOS, deprecated: 0) x: Int) {}
      """
    )
  }

  func testInvalid34() {
    AssertParse(
      """
      func f3_50734(@discardableResult x: Int) {}
      """
    )
  }

  func testInvalid35() {
    AssertParse(
      """
      func f4_50734(@objcMembers x: String) {}
      """
    )
  }

  func testInvalid36() {
    AssertParse(
      """
      func f5_50734(@weak x: String) {}
      """
    )
  }

  func testInvalid37() {
    AssertParse(
      """
      class C_50734<@NSApplicationMain T: AnyObject> {}
      """
    )
  }

  func testInvalid38() {
    AssertParse(
      """
      func f6_50734<@discardableResult T>(x: T) {}
      """
    )
  }

  func testInvalid39() {
    AssertParse(
      """
      enum E_50734<@indirect T> {}
      """
    )
  }

  func testInvalid40() {
    AssertParse(
      """
      protocol P {
        @available(swift, introduced: 4.2) associatedtype Assoc
      }
      """
    )
  }

}
