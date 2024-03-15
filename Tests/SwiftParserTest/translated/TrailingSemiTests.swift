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

// This test file has been translated from swift/test/Parse/trailing-semi.swift

import XCTest

final class TrailingSemiTests: ParserTestCase {
  func testTrailingSemi1() {
    assertParse(
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
    assertParse(
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
      ],
      fixedSource: """
        struct SpuriousSemi {

          var a : Int ;
          func b () {};
          static func c () {};

        }
        """
    )
  }

  func testTrailingSemi3a() {
    assertParse(
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
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "consecutive declarations on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "consecutive declarations on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "consecutive declarations on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "4️⃣",
          message: "consecutive declarations on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
      ],
      applyFixIts: ["insert ';'"],
      fixedSource: """
        class C {
          var a : Int = 10; func aa() {};
        #if FLAG1
          var aaa: Int = 42; func aaaa() {};
        #elseif FLAG2
          var aaa: Int = 42; func aaaa() {}
        #else
          var aaa: Int = 42; func aaaa() {}
        #endif
          func b () {};
          class func c () {};
        }
        """
    )
  }

  func testTrailingSemi3b() {
    assertParse(
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
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "consecutive declarations on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "consecutive declarations on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "consecutive declarations on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "4️⃣",
          message: "consecutive declarations on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
      ],
      applyFixIts: ["insert newline"],
      fixedSource: """
        class C {
          var a : Int = 10
          func aa() {};
        #if FLAG1
          var aaa: Int = 42
          func aaaa() {};
        #elseif FLAG2
          var aaa: Int = 42
          func aaaa() {}
        #else
          var aaa: Int = 42
          func aaaa() {}
        #endif
          func b () {};
          class func c () {};
        }
        """
    )
  }

  func testTrailingSemi4a() {
    assertParse(
      """
      extension S {
        //var a : Int ;
        func bb () {};
        static func cc () {};
        func dd() {}1️⃣ subscript(i: Int) -> Int { return 1 }
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive declarations on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        )
      ],
      applyFixIts: ["insert ';'"],
      fixedSource: """
        extension S {
          //var a : Int ;
          func bb () {};
          static func cc () {};
          func dd() {}; subscript(i: Int) -> Int { return 1 }
        }
        """
    )
  }

  func testTrailingSemi4b() {
    assertParse(
      """
      extension S {
        //var a : Int ;
        func bb () {};
        static func cc () {};
        func dd() {}1️⃣ subscript(i: Int) -> Int { return 1 }
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive declarations on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        )
      ],
      applyFixIts: ["insert newline"],
      fixedSource: """
        extension S {
          //var a : Int ;
          func bb () {};
          static func cc () {};
          func dd() {}
          subscript(i: Int) -> Int { return 1 }
        }
        """
    )
  }

  func testTrailingSemi5() {
    assertParse(
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
    assertParse(
      """
      let x = 5;1️⃣;
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected ';' separator", fixIts: ["remove ';'"])
      ],
      fixedSource: "let x = 5;"
    )
  }

  func testDoubleTrailingSemiInStmt() {
    assertParse(
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
    assertParse(
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
    assertParse(
      """
      struct X {
      #if FLAG1
        func foo() {}1️⃣ func bar() {}
      #endif
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive declarations on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        )
      ],
      applyFixIts: ["insert ';'"],
      fixedSource: """
        struct X {
        #if FLAG1
          func foo() {}; func bar() {}
        #endif
        }
        """
    )
  }

  func testMissingNewlineInIfConfigOfDecls() {
    assertParse(
      """
      struct X {
      #if FLAG1
        func foo() {}1️⃣ func bar() {}
      #endif
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive declarations on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        )
      ],
      applyFixIts: ["insert newline"],
      fixedSource: """
        struct X {
        #if FLAG1
          func foo() {}
          func bar() {}
        #endif
        }
        """
    )
  }

  func testMissingSemiInIfConfigOfStmts1() {
    assertParse(
      """
      func foo() {
      #if FLAG1
        let a = 11️⃣ let b = 2
      #endif
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        )
      ],
      applyFixIts: ["insert newline"],
      fixedSource: """
        func foo() {
        #if FLAG1
          let a = 1
          let b = 2
        #endif
        }
        """
    )
  }

  func testMissingSemiInIfConfigOfStmts2() {
    assertParse(
      """
      func foo() {
      #if FLAG1
        let a = 11️⃣ let b = 2
      #endif
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        )
      ],
      applyFixIts: ["insert ';'"],
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
