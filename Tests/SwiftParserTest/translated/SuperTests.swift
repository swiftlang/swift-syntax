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

// This test file has been translated from swift/test/Parse/super.swift

import SwiftSyntax
import XCTest

final class SuperTests: XCTestCase {
  func testSuper1() {
    AssertParse(
      """
      class B {
        var foo: Int
        func bar() {}
        init() {} 
        init(x: Int) {} 
        subscript(x: Int) -> Int {
          get {}
          set {}
        }
      }
      """
    )
  }

  func testSuper2a() {
    AssertParse(
      #"""
      class D : B {
        override init() {
          super.init()
          super.init(42)
        }
      }
      """#
    )
  }

  func testSuper2b() {
    AssertParse(
      #"""
      class D : B {
        override init(x:Int) {
          let _: () -> B = super.init
        }
      }
      """#
    )
  }

  func testSuper2c() {
    AssertParse(
      #"""
      class D : B {
        convenience init(y:Int) {
          let _: () -> D = self.init
        }
      }
      """#
    )
  }

  func testSuper2d() {
    AssertParse(
      #"""
      class D : B {
        init(z: Int) {
          super
            .init(x: z)
        }
      }
      """#
    )
  }

  func testSuper2e() {
    AssertParse(
      #"""
      class D : B {
        func super_calls() {
          super.foo
          super.foo.bar
          super.bar
          super.bar()
          // FIXME: should also say "'super.init' cannot be referenced outside of an initializer"
          super.init
          super.init()
          super.init(0)
          super[0]
          super
            .bar()
        }
      }
      """#
    )
  }

  func testSuper2f() {
    AssertParse(
      #"""
      class D : B {
        func bad_super_1() {
          super.1️⃣$0
        }
      }
      """#,
      diagnostics: [
        DiagnosticSpec(message: "expected name in member access")
      ]
    )
  }

  func testSuper2g() {
    AssertParse(
      #"""
      class D : B {
        func bad_super_2() {
          super(0)
        }
      }
      """#,
      substructure: Syntax(
        FunctionCallExprSyntax(
          calledExpression: SuperRefExprSyntax(superKeyword: .superKeyword()),
          leftParen: .leftParenToken(),
          argumentList: TupleExprElementListSyntax([
            TupleExprElementSyntax(
              expression: IntegerLiteralExprSyntax(digits: .integerLiteral("0"))
            )
          ]),
          rightParen: .rightParenToken()
        )
      )
    )
  }

  func testSuper2h() {
    AssertParse(
      #"""
      class D : B {
        func bad_super_3() {
          super
            [1]
        }
      }
      """#,
      substructure: Syntax(
        ArrayExprSyntax(
          leftSquare: .leftSquareBracketToken(),
          elements: ArrayElementListSyntax([
            ArrayElementSyntax(
              expression: IntegerLiteralExprSyntax(digits: .integerLiteral("1"))
            )
          ]),
          rightSquare: .rightSquareBracketToken()
        )
      )
    )
  }

  func testSuper3() {
    AssertParse(
      """
      class Closures : B {
        func captureWeak() {
          let g = { [weak self] () -> Void in // expected-note * {{'self' explicitly captured here}}
            super.foo() 
          }
          g()
        }
        func captureUnowned() {
          let g = { [unowned self] () -> Void in // expected-note * {{'self' explicitly captured here}}
            super.foo() 
          }
          g()
        }
        func nestedInner() {
          let g = { () -> Void in
            let h = { [weak self] () -> Void in // expected-note * {{'self' explicitly captured here}}
              super.foo() 
              nil ?? super.foo() 
            }
            h()
          }
          g()
        }
        func nestedOuter() {
          let g = { [weak self] () -> Void in // expected-note * {{'self' explicitly captured here}}
            let h = { () -> Void in
              super.foo() 
              nil ?? super.foo() 
            }
            h()
          }
          g()
        }
      }
      """
    )
  }

}
