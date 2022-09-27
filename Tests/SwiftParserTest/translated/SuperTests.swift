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
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 4: found this candidate
        // TODO: Old parser expected note on line 5: found this candidate
      ]
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
        // TODO: Old parser expected error on line 4: missing argument label 'x:' in call
        // TODO: Old parser expected error on line 7: cannot reference 'super.init' initializer chain as function value
        // TODO: Old parser expected error on line 10: cannot reference 'self.init' initializer delegation as function value
        // TODO: Old parser expected warning on line 17: property is accessed but result is unused
        // TODO: Old parser expected error on line 18: value of type 'Int' has no member 'bar'
        // TODO: Old parser expected error on line 19: function is unused
        // TODO: Old parser expected error on line 22: no exact matches in reference to initializer
        // TODO: Old parser expected error on line 23: 'super.init' cannot be called outside of an initializer
        // TODO: Old parser expected error on line 24: missing argument label 'x:' in call
        // TODO: Old parser expected error on line 24: 'super.init' cannot be called outside of an initializer
        // TODO: Old parser expected warning on line 25: subscript is accessed but result is unused
        // TODO: Old parser expected error on line 30: expected identifier or 'init'
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: using 'super' in a closure where 'self' is explicitly captured is not yet supported
        // TODO: Old parser expected error on line 10: using 'super' in a closure where 'self' is explicitly captured is not yet supported
        // TODO: Old parser expected error on line 17: using 'super' in a closure where 'self' is explicitly captured is not yet supported
        // TODO: Old parser expected error on line 18: using 'super' in a closure where 'self' is explicitly captured is not yet supported
        // TODO: Old parser expected error on line 27: using 'super' in a closure where 'self' is explicitly captured is not yet supported
        // TODO: Old parser expected error on line 28: using 'super' in a closure where 'self' is explicitly captured is not yet supported
      ]
    )
  }

}
