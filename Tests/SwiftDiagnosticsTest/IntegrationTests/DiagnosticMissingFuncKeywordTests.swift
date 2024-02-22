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

// This test file has been translated from swift/test/Parse/diagnostic_missing_func_keyword.swift

import XCTest

final class DiagnosticMissingFuncKeywordTests: XCTestCase {
  func testDiagnosticMissingFuncKeyword1() {
    // https://github.com/apple/swift/issues/52877
    assertParsedSource(
      """
      protocol Brew {
        tripel() -> Int
      }
      """,
      expecting:
        """
        1 │ protocol Brew {
        2 │   tripel() -> Int
          │   ╰─ error: expected 'func' in function
        3 │ }

        """
    )
  }

  func testDiagnosticMissingFuncKeyword2() {
    // https://github.com/apple/swift/issues/52877
    assertParsedSource(
      """
      protocol Brew {
        quadrupel: Int { get }
      }
      """,
      expecting:
        """
        1 │ protocol Brew {
        2 │   quadrupel: Int { get }
          │   ╰─ error: expected 'var' in variable
        3 │ }

        """
    )
  }

  func testDiagnosticMissingFuncKeyword3() {
    // https://github.com/apple/swift/issues/52877
    assertParsedSource(
      """
      protocol Brew {
        static + (lhs: Self, rhs: Self) -> Self
      }
      """,
      expecting:
        """
        1 │ protocol Brew {
        2 │   static + (lhs: Self, rhs: Self) -> Self
          │          ╰─ error: expected 'func' in function
        3 │ }

        """
    )
  }

  func testDiagnosticMissingFuncKeyword4() {
    // https://github.com/apple/swift/issues/52877
    assertParsedSource(
      """
      protocol Brew {
        * (lhs: Self, rhs: Self) -> Self
      }
      """,
      expecting:
        """
        1 │ protocol Brew {
        2 │   * (lhs: Self, rhs: Self) -> Self
          │   ╰─ error: expected 'func' in function
        3 │ }

        """
    )
  }

  func testDiagnosticMissingFuncKeyword5() {
    // https://github.com/apple/swift/issues/52877
    assertParsedSource(
      """
      protocol Brew {
        ipa: Int { get }; apa: Float { get }
      }
      """,
      expecting:
        """
        1 │ protocol Brew {
        2 │   ipa: Int { get }; apa: Float { get }
          │   │                 ╰─ error: expected 'var' in variable
          │   ╰─ error: expected 'var' in variable
        3 │ }

        """
    )
  }

  func testDiagnosticMissingFuncKeyword6() {
    // https://github.com/apple/swift/issues/52877
    assertParsedSource(
      """
      protocol Brew {
        stout: Int { get } porter: Float { get }
      }
      """,
      expecting:
        """
        1 │ protocol Brew {
        2 │   stout: Int { get } porter: Float { get }
          │   │                  ╰─ error: expected 'var' in variable
          │   ╰─ error: expected 'var' in variable
        3 │ }

        """
    )
  }

  func testDiagnosticMissingFuncKeyword7() {
    assertParsedSource(
      """
      struct Bar {
        fisr = 0x5F3759DF
      }
      """,
      expecting:
        """
        1 │ struct Bar {
        2 │   fisr = 0x5F3759DF
          │   ╰─ error: expected 'var' in variable
        3 │ }

        """
    )
  }

  func testDiagnosticMissingFuncKeyword8() {
    assertParsedSource(
      """
      struct Bar {
        %%<T: Brew> (lhs: T, rhs: T) -> T {
          lhs + lhs + rhs + rhs
        }
      }
      """,
      expecting:
        """
        1 │ struct Bar {
        2 │   %%<T: Brew> (lhs: T, rhs: T) -> T {
          │   ╰─ error: expected 'func' in function
        3 │     lhs + lhs + rhs + rhs
        4 │   }

        """
    )
  }

  func testDiagnosticMissingFuncKeyword9() {
    assertParsedSource(
      """
      struct Bar {
        _: Int = 42
      }
      """,
      expecting:
        """
        1 │ struct Bar {
        2 │   _: Int = 42
          │   ╰─ error: expected 'var' in variable
        3 │ }

        """
    )
  }

  func testDiagnosticMissingFuncKeyword10() {
    assertParsedSource(
      """
      struct Bar {
        (light, dark) = (100, 200)
      }
      """,
      expecting:
        """
        1 │ struct Bar {
        2 │   (light, dark) = (100, 200)
          │   ╰─ error: expected 'var' in variable
        3 │ }

        """
    )
  }

  func testDiagnosticMissingFuncKeyword11() {
    assertParsedSource(
      """
      struct Bar {
        a, b: Int
      }
      """,
      expecting:
        """
        1 │ struct Bar {
        2 │   a, b: Int
          │   ╰─ error: expected 'var' in variable
        3 │ }

        """
    )
  }

  func testDiagnosticMissingFuncKeyword12() {
    assertParsedSource(
      """
      class Baz {
        instanceMethod() {}
      }
      """,
      expecting:
        """
        1 │ class Baz {
        2 │   instanceMethod() {}
          │   ╰─ error: expected 'func' in function
        3 │ }

        """
    )
  }

  func testDiagnosticMissingFuncKeyword13() {
    assertParsedSource(
      """
      class Baz {
        static staticMethod() {}
      }
      """,
      expecting:
        """
        1 │ class Baz {
        2 │   static staticMethod() {}
          │          ╰─ error: expected 'func' in function
        3 │ }

        """
    )
  }

  func testDiagnosticMissingFuncKeyword14() {
    assertParsedSource(
      """
      class Baz {
        instanceProperty: Int { 0 }
      }
      """,
      expecting:
        """
        1 │ class Baz {
        2 │   instanceProperty: Int { 0 }
          │   ╰─ error: expected 'var' in variable
        3 │ }

        """
    )
  }

  func testDiagnosticMissingFuncKeyword15() {
    assertParsedSource(
      """
      class Baz {
        static staticProperty: Int { 0 }
      }
      """,
      expecting:
        """
        1 │ class Baz {
        2 │   static staticProperty: Int { 0 }
          │          ╰─ error: expected 'var' in variable
        3 │ }

        """
    )
  }

  func testDiagnosticMissingFuncKeyword16() {
    assertParsedSource(
      """
      class C1 {
        class classMethod() {}
      }
      """,
      expecting:
        """
        1 │ class C1 {
        2 │   class classMethod() {}
          │                    ╰─ error: unexpected code '()' in class
        3 │ }

        """
    )
  }

  func testDiagnosticMissingFuncKeyword17() {
    assertParsedSource(
      """
      class C2 {
        class classProperty: Int { 0 }
      }
      """,
      expecting:
        """
        1 │ class C2 {
        2 │   class classProperty: Int { 0 }
          │                              ╰─ error: unexpected code '0' in class
        3 │ }

        """
    )
  }
}
