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

// This test file has been translated from swift/test/Parse/super.swift

import SwiftSyntax
import XCTest

final class SuperTests: ParserTestCase {
  func testSuper1() {
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
      #"""
      class D : B {
        func super_calls() {
          super.foo
          super.foo.bar
          super.bar
          super.bar()
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
    assertParse(
      #"""
      class D : B {
        func bad_super_1() {
          super.1️⃣$0
        }
      }
      """#,
      diagnostics: [
        DiagnosticSpec(message: "expected name in member access", fixIts: ["insert name"])
      ],
      fixedSource: #"""
        class D : B {
          func bad_super_1() {
            super.<#identifier#>$0
          }
        }
        """#
    )
  }

  func testSuper2g() {
    assertParse(
      #"""
      class D : B {
        func bad_super_2() {
          super(0)
        }
      }
      """#,
      substructure: FunctionCallExprSyntax(
        calledExpression: SuperExprSyntax(superKeyword: .keyword(.super)),
        leftParen: .leftParenToken(),
        arguments: LabeledExprListSyntax([
          LabeledExprSyntax(
            expression: IntegerLiteralExprSyntax(literal: .integerLiteral("0"))
          )
        ]),
        rightParen: .rightParenToken()
      )
    )
  }

  func testSuper2h() {
    assertParse(
      #"""
      class D : B {
        func bad_super_3() {
          super
            [1]
        }
      }
      """#,
      substructure: ArrayExprSyntax(
        leftSquare: .leftSquareToken(),
        elements: ArrayElementListSyntax([
          ArrayElementSyntax(
            expression: IntegerLiteralExprSyntax(literal: .integerLiteral("1"))
          )
        ]),
        rightSquare: .rightSquareToken()
      )
    )
  }

  func testSuper3() {
    assertParse(
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
