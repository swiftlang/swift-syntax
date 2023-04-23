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

// This test file has been translated from swift/test/Parse/invalid.swift

import XCTest

final class InvalidTests: XCTestCase {
  func testInvalid1a() {
    // rdar://15946844
    assertParse(
      """
      func test1(1️⃣inout var x : Int) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "'inout' before a parameter name is not allowed", fixIts: ["move 'inout' in front of type"])
      ],
      fixedSource: "func test1(var x : inout Int) {}"
    )
  }

  func testInvalid1b() {
    assertParse(
      """
      func test2(1️⃣inout let x : Int) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "'inout' before a parameter name is not allowed", fixIts: ["move 'inout' in front of type"])
      ]
    )
  }

  func testInvalid1c() {
    assertParse(
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
    assertParse(
      """
      func test1s(1️⃣__shared var x : Int) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "'__shared' before a parameter name is not allowed", fixIts: ["move '__shared' in front of type"])
      ]
    )
  }

  func testInvalid2b() {
    assertParse(
      """
      func test2s(1️⃣__shared let x : Int) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "'__shared' before a parameter name is not allowed", fixIts: ["move '__shared' in front of type"])
      ]
    )
  }

  func testInvalid3a() {
    assertParse(
      """
      func test1o(1️⃣__owned var x : Int) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "'__owned' before a parameter name is not allowed", fixIts: ["move '__owned' in front of type"])
      ]
    )
  }

  func testInvalid3b() {
    assertParse(
      """
      func test2o(1️⃣__owned let x : Int) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "'__owned' before a parameter name is not allowed", fixIts: ["move '__owned' in front of type"])
      ]
    )
  }

  func testInvalid4() {
    assertParse(
      """
      func test3() {
        undeclared_func( 1️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected value and ')' to end function call", fixIts: ["insert value and ')'"])
      ]
    )
  }

  func testInvalid5() {
    assertParse(
      """
      func runAction() {}
      """
    )
  }

  func testInvalid6() {
    assertParse(
      """
      // rdar://16601779
      func foo() {
        runAction(SKAction.sequence()1️⃣
          skview!
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ')' to end function call", fixIts: ["insert ')'"])
      ]
    )
  }

  func testInvalid7() {
    assertParse(
      """
      super.init()
      """
    )
  }

  func testInvalid8() {
    assertParse(
      """
      switch state {
        1️⃣let duration : Int = 0
        case 1:
          break
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "all statements inside a switch must be covered by a 'case' or 'default' label", fixIts: ["insert label"])
      ]
    )
  }

  func testInvalid9() {
    assertParse(
      #"""
      func testNotCoveredCase(x: Int) {
        switch x {
          1️⃣let y = "foo"
          switch y {
            case "bar":
              blah2️⃣ blah // ignored
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
        DiagnosticSpec(locationMarker: "1️⃣", message: "all statements inside a switch must be covered by a 'case' or 'default' label", fixIts: ["insert label"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive statements on a line must be separated by ';'", fixIts: ["insert ';'"]),
      ]
    )
  }

  func testInvalid10() {
    assertParse(
      ##"""
      // rdar://18926814
      func test4() {
        let abc = 123
        _ = " >> \( abc 1️⃣} ) << "2️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace in string literal"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '}' to end function", fixIts: ["insert '}'"]),
      ]
    )
  }

  func testInvalid11() {
    // rdar://problem/18507467
    assertParse(
      """
      func d(_ b: 1️⃣String 2️⃣-> 3️⃣<T>() -> T4️⃣) {}
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '(' to start function type", fixIts: ["insert '('"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ')' in function type", fixIts: ["insert ')'"]),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected return type in function type", fixIts: ["insert return type"]),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected ')' to end parameter clause", fixIts: ["insert ')'"]),
        DiagnosticSpec(locationMarker: "3️⃣", message: "unexpected code '<T>() -> T)' in function"),
      ]
    )
  }

  func testInvalid12() {
    assertParse(
      """
      // <rdar://problem/22143680> QoI: terrible diagnostic when trying to form a generic protocol
      protocol Animal<Food> {
        func feed(_ food: Food)
      }
      """
    )
  }

  func testInvalid13() {
    assertParse(
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
        DiagnosticSpec(message: "expected ':' and type in parameter", fixIts: ["insert ':' and type"])
      ]
    )
  }

  func testInvalid14() {
    assertParse(
      """
      // https://github.com/apple/swift/issues/43313
      do {
        func f(_ a: Int, b: Int) {}
        f(1, b: 2,1️⃣)
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected value in function call", fixIts: ["insert value"])
      ]
    )
  }

  func testInvalid15() {
    assertParse(
      """
      // https://github.com/apple/swift/issues/43591
      // Two inout crash compiler
      """
    )
  }

  func testInvalid16a() {
    assertParse(
      """
      func f1_43591(a : inout 1️⃣inout Int) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected 'inout' keyword in type")
      ]
    )
  }

  func testInvalid16b() {
    assertParse(
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
    assertParse(
      """
      func f3_43591(let let 1️⃣a: Int) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'a' in parameter")
      ]
    )
  }

  func testInvalid16d() {
    assertParse(
      """
      func f4_43591(1️⃣inout x: inout String) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "'inout' before a parameter name is not allowed", fixIts: ["remove redundant 'inout'"])
      ]
    )
  }

  func testInvalid16e() {
    assertParse(
      """
      func f5_43591(1️⃣inout i: inout Int) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "'inout' before a parameter name is not allowed", fixIts: ["remove redundant 'inout'"])
      ]
    )
  }

  func testInvalid17() {
    assertParse(
      """
      func 1️⃣repeat() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "keyword 'repeat' cannot be used as an identifier here", fixIts: ["if this name is unavoidable, use backticks to escape it"])
      ]
    )
  }

  func testInvalid18() {
    assertParse(
      """
      let 1️⃣for = 2
      """,
      diagnostics: [
        DiagnosticSpec(message: "keyword 'for' cannot be used as an identifier here", fixIts: ["if this name is unavoidable, use backticks to escape it"])
      ]
    )
  }

  func testInvalid19() {
    assertParse(
      """
      func f4_43591(1️⃣inout x: inout String) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "'inout' before a parameter name is not allowed", fixIts: ["remove redundant 'inout'"])
      ]
    )
  }

  func testInvalid20() {
    assertParse(
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
    assertParse(
      """
      func 1️⃣repeat() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "keyword 'repeat' cannot be used as an identifier here", fixIts: ["if this name is unavoidable, use backticks to escape it"])
      ]
    )
  }

  func testInvalid22() {
    assertParse(
      """
      let 1️⃣for = 2
      """,
      diagnostics: [
        DiagnosticSpec(message: "keyword 'for' cannot be used as an identifier here", fixIts: ["if this name is unavoidable, use backticks to escape it"])
      ]
    )
  }

  func testInvalid23() {
    let testCases: [UInt: (fixIt: String, fixedSource: String)] = [
      #line: ("join the identifiers together", "func dogcow() {}"),
      #line: ("join the identifiers together with camel-case", "func dogCow() {}"),
    ]

    for (line, testCase) in testCases {
      assertParse(
        """
        func dog 1️⃣cow() {}
        """,
        diagnostics: [
          DiagnosticSpec(
            message: "found an unexpected second identifier in function; is there an accidental break?",
            fixIts: [
              "join the identifiers together",
              "join the identifiers together with camel-case",
            ]
          )
        ],
        applyFixIts: [testCase.fixIt],
        fixedSource: testCase.fixedSource,
        line: line
      )
    }
  }

  func testThreeIdentifersForFunctionName() {
    let testCases: [UInt: (fixIt: String, fixedSource: String)] = [
      #line: ("join the identifiers together", "func dogcowsheep() {}"),
      #line: ("join the identifiers together with camel-case", "func dogCowSheep() {}"),
    ]

    for (line, testCase) in testCases {
      assertParse(
        """
        func dog 1️⃣cow sheep() {}
        """,
        diagnostics: [
          DiagnosticSpec(
            message: "found an unexpected second identifier in function; is there an accidental break?",
            fixIts: [
              "join the identifiers together",
              "join the identifiers together with camel-case",
            ]
          )
        ],
        applyFixIts: [testCase.fixIt],
        fixedSource: testCase.fixedSource,
        line: line
      )
    }
  }

  func testInvalid25() {
    let testCases: [UInt: (fixIt: String, fixedSource: String)] = [
      #line: ("join the identifiers together", "func friendship<T>(x: T) {}"),
      #line: ("join the identifiers together with camel-case", "func friendShip<T>(x: T) {}"),
    ]

    for (line, testCase) in testCases {
      assertParse(
        """
        func friend 1️⃣ship<T>(x: T) {}
        """,
        diagnostics: [
          DiagnosticSpec(
            message: "found an unexpected second identifier in function; is there an accidental break?",
            fixIts: [
              "join the identifiers together",
              "join the identifiers together with camel-case",
            ]
          )
        ],
        applyFixIts: [testCase.fixIt],
        fixedSource: testCase.fixedSource,
        line: line
      )
    }
  }

  func testInvalid26() {
    assertParse(
      """
      func were1️⃣
      wolf2️⃣() 3️⃣{}
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '(' to start parameter clause", fixIts: ["insert '('"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ':' in parameter", fixIts: ["insert ':'"]),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected ')' to end parameter clause", fixIts: ["insert ')'"]),
      ],
      fixedSource: """
        func were(
        wolf: ()) {}
        """
    )
  }

  func testInvalid27() {
    assertParse(
      """
      func hammer1️⃣
      leavings2️⃣<T>(x: T) {}
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '(' to start parameter clause", fixIts: ["insert '('"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ':' and type in parameter", fixIts: ["insert ':' and type"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ')' to end parameter clause", fixIts: ["insert ')'"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code '<T>(x: T)' in function"),
      ]
    )
  }

  func testInvalid28() {
    assertParse(
      """
      prefix operator %
      prefix func %<T>(x: T) -> T { return x } // No error expected - the < is considered an identifier but is peeled off by the parser.
      """
    )
  }

  func testInvalid29() {
    assertParse(
      """
      struct Weak<T: 1️⃣class> {
        weak let value: T
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "'class' constraint can only appear on protocol declarations", fixIts: ["replace 'class' with 'AnyObject'"])
      ],
      fixedSource: """
        struct Weak<T: AnyObject> {
          weak let value: T
        }
        """
    )
  }

  func testInvalid30() {
    assertParse(
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
    assertParse(
      """
      func f1_50734(@NSApplicationMain x: Int) {}
      """
    )
  }

  func testInvalid33() {
    assertParse(
      """
      func f2_50734(@available(iOS, deprecated: 0) x: Int) {}
      """
    )
  }

  func testInvalid34() {
    assertParse(
      """
      func f3_50734(@discardableResult x: Int) {}
      """
    )
  }

  func testInvalid35() {
    assertParse(
      """
      func f4_50734(@objcMembers x: String) {}
      """
    )
  }

  func testInvalid36() {
    assertParse(
      """
      func f5_50734(@weak x: String) {}
      """
    )
  }

  func testInvalid37() {
    assertParse(
      """
      class C_50734<@NSApplicationMain T: AnyObject> {}
      """
    )
  }

  func testInvalid38() {
    assertParse(
      """
      func f6_50734<@discardableResult T>(x: T) {}
      """
    )
  }

  func testInvalid39() {
    assertParse(
      """
      enum E_50734<@indirect T> {}
      """
    )
  }

  func testInvalid40() {
    assertParse(
      """
      protocol P {
        @available(swift, introduced: 4.2) associatedtype Assoc
      }
      """
    )
  }

}
