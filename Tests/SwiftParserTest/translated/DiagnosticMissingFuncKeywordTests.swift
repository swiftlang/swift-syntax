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

final class DiagnosticMissingFuncKeywordTests: ParserTestCase {
  func testDiagnosticMissingFuncKeyword2a() {
    // https://github.com/apple/swift/issues/52877
    assertParse(
      """
      protocol Brew {
        1️⃣tripel() -> Int
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'func' in function", fixIts: ["insert 'func'"])
      ],
      fixedSource: """
        protocol Brew {
          func tripel() -> Int
        }
        """
    )
  }

  func testDiagnosticMissingFuncKeyword2b() {
    // https://github.com/apple/swift/issues/52877
    assertParse(
      """
      protocol Brew {
        1️⃣quadrupel: Int { get }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'var' in variable", fixIts: ["insert 'var'"])
      ],
      fixedSource: """
        protocol Brew {
          var quadrupel: Int { get }
        }
        """
    )
  }

  func testDiagnosticMissingFuncKeyword2c() {
    // https://github.com/apple/swift/issues/52877
    assertParse(
      """
      protocol Brew {
        static 1️⃣+ (lhs: Self, rhs: Self) -> Self
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'func' in function", fixIts: ["insert 'func'"])
      ],
      fixedSource: """
        protocol Brew {
          static func + (lhs: Self, rhs: Self) -> Self
        }
        """
    )
  }

  func testDiagnosticMissingFuncKeyword2d() {
    // https://github.com/apple/swift/issues/52877
    assertParse(
      """
      protocol Brew {
        1️⃣* (lhs: Self, rhs: Self) -> Self
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'func' in function", fixIts: ["insert 'func'"])
      ],
      fixedSource: """
        protocol Brew {
          func * (lhs: Self, rhs: Self) -> Self
        }
        """
    )
  }

  func testDiagnosticMissingFuncKeyword2e() {
    // https://github.com/apple/swift/issues/52877
    assertParse(
      """
      protocol Brew {
        1️⃣ipa: Int { get }; 2️⃣apa: Float { get }
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected 'var' in variable", fixIts: ["insert 'var'"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected 'var' in variable", fixIts: ["insert 'var'"]),
      ],
      fixedSource: """
        protocol Brew {
          var ipa: Int { get }; var apa: Float { get }
        }
        """
    )
  }

  func testDiagnosticMissingFuncKeyword2f() {
    // https://github.com/apple/swift/issues/52877
    assertParse(
      """
      protocol Brew {
        1️⃣stout: Int { get } 2️⃣porter: Float { get }
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected 'var' in variable", fixIts: ["insert 'var'"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected 'var' in variable", fixIts: ["insert 'var'"]),
      ],
      fixedSource: """
        protocol Brew {
          var stout: Int { get } var porter: Float { get }
        }
        """
    )
  }

  func testDiagnosticMissingFuncKeyword3() {
    assertParse(
      """
      infix operator %%
      """
    )
  }

  func testDiagnosticMissingFuncKeyword4a() {
    assertParse(
      """
      struct Bar {
        1️⃣fisr = 0x5F3759DF
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'var' in variable", fixIts: ["insert 'var'"])
      ],
      fixedSource: """
        struct Bar {
          var fisr = 0x5F3759DF
        }
        """
    )
  }

  func testDiagnosticMissingFuncKeyword4b() {
    assertParse(
      """
      struct Bar {
        1️⃣%%<T: Brew> (lhs: T, rhs: T) -> T {
          lhs + lhs + rhs + rhs
        }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'func' in function", fixIts: ["insert 'func'"])
      ],
      fixedSource: """
        struct Bar {
          func %%<T: Brew> (lhs: T, rhs: T) -> T {
            lhs + lhs + rhs + rhs
          }
        }
        """
    )
  }

  func testDiagnosticMissingFuncKeyword4c() {
    assertParse(
      """
      struct Bar {
        1️⃣_: Int = 42
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'var' in variable", fixIts: ["insert 'var'"])
      ],
      fixedSource: """
        struct Bar {
          var _: Int = 42
        }
        """
    )
  }

  func testDiagnosticMissingFuncKeyword4d() {
    assertParse(
      """
      struct Bar {
        1️⃣(light, dark) = (100, 200)
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'var' in variable", fixIts: ["insert 'var'"])
      ],
      fixedSource: """
        struct Bar {
          var (light, dark) = (100, 200)
        }
        """
    )
  }

  func testDiagnosticMissingFuncKeyword4e() {
    assertParse(
      """
      struct Bar {
        1️⃣a, b: Int
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'var' in variable", fixIts: ["insert 'var'"])
      ],
      fixedSource: """
        struct Bar {
          var a, b: Int
        }
        """
    )
  }

  func testDiagnosticMissingFuncKeyword5a() {
    assertParse(
      """
      class Baz {
        1️⃣instanceMethod() {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'func' in function", fixIts: ["insert 'func'"])
      ],
      fixedSource: """
        class Baz {
          func instanceMethod() {}
        }
        """
    )
  }

  func testDiagnosticMissingFuncKeyword5b() {
    assertParse(
      """
      class Baz {
        static 1️⃣staticMethod() {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'func' in function", fixIts: ["insert 'func'"])
      ],
      fixedSource: """
        class Baz {
          static func staticMethod() {}
        }
        """
    )
  }

  func testDiagnosticMissingFuncKeyword5c() {
    assertParse(
      """
      class Baz {
        1️⃣instanceProperty: Int { 0 }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'var' in variable", fixIts: ["insert 'var'"])
      ],
      fixedSource: """
        class Baz {
          var instanceProperty: Int { 0 }
        }
        """
    )
  }

  func testDiagnosticMissingFuncKeyword5d() {
    assertParse(
      """
      class Baz {
        static 1️⃣staticProperty: Int { 0 }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'var' in variable", fixIts: ["insert 'var'"])
      ],
      fixedSource: """
        class Baz {
          static var staticProperty: Int { 0 }
        }
        """
    )
  }

  func testDiagnosticMissingFuncKeyword6() {
    assertParse(
      """
      class C1 {
        class classMethod1️⃣() {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '()' in class")
      ]
    )
  }

  func testDiagnosticMissingFuncKeyword7() {
    assertParse(
      """
      class C2 {
        class classProperty: Int { 1️⃣0 }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '0' in class")
      ]
    )
  }

}
