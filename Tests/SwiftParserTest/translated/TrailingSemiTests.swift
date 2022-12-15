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

// This test file has been translated from swift/test/Parse/trailing-semi.swift

import XCTest

final class TrailingSemiTests: XCTestCase {
  func testTrailingSemi1() {
    AssertParse(
      """
      struct S {
        var a : Int ;
        func b () {};
        static func c () {};
      }
      """
    )
  }

  func testTrailingSemi2() {
    AssertParse(
      """
      struct SpuriousSemi {
        1️⃣;
        var a : Int ; 2️⃣;
        func b () {};
        3️⃣; static func c () {};
        4️⃣;;
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected ';' separator", fixIts: ["remove ';'"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected ';' separator", fixIts: ["remove ';'"]),
        DiagnosticSpec(locationMarker: "3️⃣", message: "unexpected ';' separator", fixIts: ["remove ';'"]),
        DiagnosticSpec(locationMarker: "4️⃣", message: "unexpected ';' separator", fixIts: ["remove ';;'"]),
      ]
    )
  }

  func testTrailingSemi3() {
    AssertParse(
      """
      class C {
        var a : Int = 101️⃣ func aa() {};
      #if FLAG1
        var aaa: Int = 422️⃣ func aaaa() {};
      #elseif FLAG2
        var aaa: Int = 423️⃣ func aaaa() {}
      #else
        var aaa: Int = 424️⃣ func aaaa() {}
      #endif
        func b () {};
        class func c () {};
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive declarations on a line must be separated by ';'", fixIts: ["insert ';'"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive declarations on a line must be separated by ';'", fixIts: ["insert ';'"]),
        DiagnosticSpec(locationMarker: "3️⃣", message: "consecutive declarations on a line must be separated by ';'", fixIts: ["insert ';'"]),
        DiagnosticSpec(locationMarker: "4️⃣", message: "consecutive declarations on a line must be separated by ';'", fixIts: ["insert ';'"]),
      ]
    )
  }

  func testTrailingSemi4() {
    AssertParse(
      """
      extension S {
        //var a : Int ;
        func bb () {};
        static func cc () {};
        func dd() {}1️⃣ subscript(i: Int) -> Int { return 1 }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "consecutive declarations on a line must be separated by ';'")
      ]
    )
  }

  func testTrailingSemi5() {
    AssertParse(
      """
      protocol P {
        var a : Int { get };
        func b ();
        static func c ();
      }
      """
    )
  }

  func testSingleTrailingSemiInStmt() {
    AssertParse(
      """
      let x = 5;1️⃣;
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected ';' separator")
      ],
      fixedSource: "let x = 5;"
    )
  }

  func testDoubleTrailingSemiInStmt() {
    AssertParse(
      """
      let x = 5;1️⃣;;
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected ';' separator", fixIts: ["remove ';;'"])
      ],
      fixedSource: "let x = 5;"
    )
  }

  func testDoubleTrailingSemiInDecl() {
    AssertParse(
      """
      struct X {
        func foo() {};1️⃣;;
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected ';' separator", fixIts: ["remove ';;'"])
      ],
      fixedSource: """
        struct X {
          func foo() {};
        }
        """
    )
  }

  func testMissingSemiInIfConfigOfDecls() {
    AssertParse(
      """
      struct X {
      #if FLAG1
        func foo() {}1️⃣ func bar() {}
      #endif
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "consecutive declarations on a line must be separated by ';'")
      ],
      fixedSource: """
        struct X {
        #if FLAG1
          func foo() {}; func bar() {}
        #endif
        }
        """
    )
  }

  func testMissingSemiInIfConfigOfStmts() {
    AssertParse(
      """
      func foo() {
      #if FLAG1
        let a = 11️⃣ let b = 2
      #endif
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "consecutive statements on a line must be separated by ';'")
      ],
      fixedSource: """
        func foo() {
        #if FLAG1
          let a = 1; let b = 2
        #endif
        }
        """
    )
  }
}
