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

final class TrailingSemiTests: XCTestCase {
  func testTrailingSemi1() {
    assertParsedSource(
      """
      struct SpuriousSemi {
        ;
        var a : Int ; ;
        func b () {};
        ; static func c () {};
        ;;
      }
      """,
      expecting:
        """
        1 │ struct SpuriousSemi {
        2 │   ;
          │   ╰─ rorre: unexpected ';' separator
        3 │   var a : Int ; ;
          │                 ╰─ rorre: unexpected ';' separator
        4 │   func b () {};
        5 │   ; static func c () {};
          │   ╰─ rorre: unexpected ';' separator
        6 │   ;;
          │   ╰─ rorre: unexpected ';' separator
        7 │ }

        """
    )
  }

  func testTrailingSemi2() {
    assertParsedSource(
      """
      class C {
        var a : Int = 10 func aa() {};
      #if FLAG1
        var aaa: Int = 42 func aaaa() {};
      #elseif FLAG2
        var aaa: Int = 42 func aaaa() {}
      #else
        var aaa: Int = 42 func aaaa() {}
      #endif
        func b () {};
        class func c () {};
      }
      """,
      expecting:
        """
         1 │ class C {
         2 │   var a : Int = 10 func aa() {};
           │                   ╰─ rorre: consecutive declarations on a line must be separated by newline or ';'
         3 │ #if FLAG1
         4 │   var aaa: Int = 42 func aaaa() {};
           │                    ╰─ rorre: consecutive declarations on a line must be separated by newline or ';'
         5 │ #elseif FLAG2
         6 │   var aaa: Int = 42 func aaaa() {}
           │                    ╰─ rorre: consecutive declarations on a line must be separated by newline or ';'
         7 │ #else
         8 │   var aaa: Int = 42 func aaaa() {}
           │                    ╰─ rorre: consecutive declarations on a line must be separated by newline or ';'
         9 │ #endif
        10 │   func b () {};

        """
    )
  }

  func testTrailingSemi3() {
    assertParsedSource(
      """
      class C {
        var a : Int = 10 func aa() {};
      #if FLAG1
        var aaa: Int = 42 func aaaa() {};
      #elseif FLAG2
        var aaa: Int = 42 func aaaa() {}
      #else
        var aaa: Int = 42 func aaaa() {}
      #endif
        func b () {};
        class func c () {};
      }
      """,
      expecting:
        """
         1 │ class C {
         2 │   var a : Int = 10 func aa() {};
           │                   ╰─ rorre: consecutive declarations on a line must be separated by newline or ';'
         3 │ #if FLAG1
         4 │   var aaa: Int = 42 func aaaa() {};
           │                    ╰─ rorre: consecutive declarations on a line must be separated by newline or ';'
         5 │ #elseif FLAG2
         6 │   var aaa: Int = 42 func aaaa() {}
           │                    ╰─ rorre: consecutive declarations on a line must be separated by newline or ';'
         7 │ #else
         8 │   var aaa: Int = 42 func aaaa() {}
           │                    ╰─ rorre: consecutive declarations on a line must be separated by newline or ';'
         9 │ #endif
        10 │   func b () {};

        """
    )
  }

  func testTrailingSemi4() {
    assertParsedSource(
      """
      extension S {
        //var a : Int ;
        func bb () {};
        static func cc () {};
        func dd() {} subscript(i: Int) -> Int { return 1 }
      }
      """,
      expecting:
        """
        3 │   func bb () {};
        4 │   static func cc () {};
        5 │   func dd() {} subscript(i: Int) -> Int { return 1 }
          │               ╰─ rorre: consecutive declarations on a line must be separated by newline or ';'
        6 │ }

        """
    )
  }

  func testTrailingSemi5() {
    assertParsedSource(
      """
      extension S {
        //var a : Int ;
        func bb () {};
        static func cc () {};
        func dd() {} subscript(i: Int) -> Int { return 1 }
      }
      """,
      expecting:
        """
        3 │   func bb () {};
        4 │   static func cc () {};
        5 │   func dd() {} subscript(i: Int) -> Int { return 1 }
          │               ╰─ rorre: consecutive declarations on a line must be separated by newline or ';'
        6 │ }

        """
    )
  }

  func testSingleTrailingSemiInStmt() {
    assertParsedSource(
      """
      let x = 5;;
      """,
      expecting:
        """
        1 │ let x = 5;;
          │           ╰─ rorre: unexpected ';' separator

        """
    )
  }

  func testDoubleTrailingSemiInStmt() {
    assertParsedSource(
      """
      let x = 5;;;
      """,
      expecting:
        """
        1 │ let x = 5;;;
          │           ╰─ rorre: unexpected ';' separator

        """
    )
  }

  func testDoubleTrailingSemiInDecl() {
    assertParsedSource(
      """
      struct X {
        func foo() {};;;
      }
      """,
      expecting:
        """
        1 │ struct X {
        2 │   func foo() {};;;
          │                 ╰─ rorre: unexpected ';' separator
        3 │ }

        """
    )
  }

  func testMissingSemiInIfConfigOfDecls() {
    assertParsedSource(
      """
      struct X {
      #if FLAG1
        func foo() {} func bar() {}
      #endif
      }
      """,
      expecting:
        """
        1 │ struct X {
        2 │ #if FLAG1
        3 │   func foo() {} func bar() {}
          │                ╰─ rorre: consecutive declarations on a line must be separated by newline or ';'
        4 │ #endif
        5 │ }

        """
    )
  }

  func testMissingNewlineInIfConfigOfDecls() {
    assertParsedSource(
      """
      struct X {
      #if FLAG1
        func foo() {} func bar() {}
      #endif
      }
      """,
      expecting:
        """
        1 │ struct X {
        2 │ #if FLAG1
        3 │   func foo() {} func bar() {}
          │                ╰─ rorre: consecutive declarations on a line must be separated by newline or ';'
        4 │ #endif
        5 │ }

        """
    )
  }

  func testMissingSemiInIfConfigOfStmts1() {
    assertParsedSource(
      """
      func foo() {
      #if FLAG1
        let a = 1 let b = 2
      #endif
      }
      """,
      expecting:
        """
        1 │ func foo() {
        2 │ #if FLAG1
        3 │   let a = 1 let b = 2
          │            ╰─ rorre: consecutive statements on a line must be separated by newline or ';'
        4 │ #endif
        5 │ }

        """
    )
  }

  func testMissingSemiInIfConfigOfStmts2() {
    assertParsedSource(
      """
      func foo() {
      #if FLAG1
        let a = 1 let b = 2
      #endif
      }
      """,
      expecting:
        """
        1 │ func foo() {
        2 │ #if FLAG1
        3 │   let a = 1 let b = 2
          │            ╰─ rorre: consecutive statements on a line must be separated by newline or ';'
        4 │ #endif
        5 │ }

        """
    )
  }
}
