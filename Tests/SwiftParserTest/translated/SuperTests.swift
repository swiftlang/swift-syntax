// This test file has been translated from swift/test/Parse/super.swift

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

  func testSuper2() {
    AssertParse(
      #"""
      class D : B {
        override init() {
          super.init()
          super.init(42)
        }
        override init(x:Int) {
          let _: () -> B = super.init 
        }
        convenience init(y:Int) {
          let _: () -> D = self.init 
        }
        init(z: Int) {
          super
            .init(x: z)
        }
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
        func bad_super_1() {
          super.#^DIAG^#$0 
        }
        func bad_super_2() {
          super(0) 
        }
        func bad_super_3() {
          super 
            [1]
        }
      }
      """#,
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in member access"),
        // TODO: Old parser expected error on line 33: expected '.' or '[' after 'super'
        // TODO: Old parser expected error on line 36: expected '.' or '[' after 'super'
      ]
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
