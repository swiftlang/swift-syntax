// This test file has been translated from swift/test/Parse/init_deinit.swift

import XCTest

final class InitDeinitTests: XCTestCase {
  func testInitDeinit1() {
    AssertParse(
      """
      struct FooStructConstructorA {
        init #^DIAG^#
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected '('
        // TODO: Old parser expected error on line 2: initializer requires a body
        DiagnosticSpec(message: "expected argument list in function declaration"),
      ]
    )
  }

  func testInitDeinit2() {
    AssertParse(
      """
      struct FooStructConstructorB {
        init() 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: initializer requires a body
      ]
    )
  }

  func testInitDeinit3() {
    AssertParse(
      """
      struct FooStructConstructorC {
        init #^DIAG_1^#{} 
        init<T> #^DIAG_2^#{} 
        init? #^DIAG_3^#{ self.init() } 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected '(', Fix-It replacements: 7 - 7 = '()'
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected argument list in function declaration"),
        // TODO: Old parser expected error on line 3: expected '(', Fix-It replacements: 10 - 10 = '()'
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected argument list in function declaration"),
        // TODO: Old parser expected error on line 4: expected '(', Fix-It replacements: 8 - 8 = '()'
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected argument list in function declaration"),
      ]
    )
  }

  func testInitDeinit4() {
    AssertParse(
      """
      struct FooStructConstructorD {
        init() -> FooStructConstructorD { }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: initializers cannot have a result type
      ]
    )
  }

  func testInitDeinit5() {
    AssertParse(
      """
      struct FooStructDeinitializerA {
        deinit 
        deinit #^DIAG_1^#x 
        deinit #^DIAG_2^#x() 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected '{' for deinitializer
        // TODO: Old parser expected error on line 3: deinitializers cannot have a name, Fix-It replacements: 10 - 12 = ''
        // TODO: Old parser expected error on line 3: expected '{' for deinitializer
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text 'x' before deinitializer"),
        // TODO: Old parser expected error on line 4: deinitializers cannot have a name, Fix-It replacements: 10 - 11 = ''
        // TODO: Old parser expected error on line 4: no parameter clause allowed on deinitializer, Fix-It replacements: 11 - 13 = ''
        // TODO: Old parser expected error on line 4: expected '{' for deinitializer
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected declaration in struct"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text 'x()' in struct"),
      ]
    )
  }

  func testInitDeinit6() {
    AssertParse(
      """
      struct FooStructDeinitializerB {
        deinit 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected '{' for deinitializer
      ]
    )
  }

  func testInitDeinit7() {
    AssertParse(
      """
      struct FooStructDeinitializerC {
        deinit {} 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: deinitializers may only be declared within a class or actor
      ]
    )
  }

  func testInitDeinit8() {
    AssertParse(
      """
      class FooClassDeinitializerA {
        deinit#^DIAG^#(a : Int) {} 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: no parameter clause allowed on deinitializer, Fix-It replacements: 9 - 18 = ''
        DiagnosticSpec(message: "expected declaration in class"),
        DiagnosticSpec(message: "unexpected text '(a : Int) {}' in class"),
      ]
    )
  }

  func testInitDeinit9() {
    AssertParse(
      """
      class FooClassDeinitializerB {
        deinit { }
      }
      """
    )
  }

  func testInitDeinit10() {
    AssertParse(
      """
      class FooClassDeinitializerC {
        deinit #^DIAG^#x (a : Int) {} 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: deinitializers cannot have a name, Fix-It replacements: 10 - 12 = ''
        // TODO: Old parser expected error on line 2: no parameter clause allowed on deinitializer, Fix-It replacements: 12 - 22 = ''
        DiagnosticSpec(message: "expected declaration in class"),
        DiagnosticSpec(message: "unexpected text 'x (a : Int) {}' in class"),
      ]
    )
  }

  func testInitDeinit11() {
    AssertParse(
      """
      init #^DIAG^#{} 
      init() 
      init() {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: initializers may only be declared within a type
        // TODO: Old parser expected error on line 1: expected '(', Fix-It replacements: 5 - 5 = '()'
        DiagnosticSpec(message: "expected argument list in function declaration"),
        // TODO: Old parser expected error on line 2: initializers may only be declared within a type
        // TODO: Old parser expected error on line 3: initializers may only be declared within a type
      ]
    )
  }

  func testInitDeinit12() {
    AssertParse(
      """
      deinit {} 
      deinit 
      deinit {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: deinitializers may only be declared within a class or actor
        // TODO: Old parser expected error on line 2: expected '{' for deinitializer
        // TODO: Old parser expected error on line 3: deinitializers may only be declared within a class or actor
      ]
    )
  }

  func testInitDeinit13() {
    AssertParse(
      """
      struct BarStruct {
        init() {}
        deinit {} 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: deinitializers may only be declared within a class or actor
      ]
    )
  }

  func testInitDeinit14() {
    AssertParse(
      """
      extension BarStruct {
        init(x : Int) {}
        // When/if we allow 'var' in extensions, then we should also allow dtors
        deinit {} 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: deinitializers may only be declared within a class or actor
      ]
    )
  }

  func testInitDeinit15() {
    AssertParse(
      """
      enum BarUnion {
        init() {}
        deinit {} 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: deinitializers may only be declared within a class or actor
      ]
    )
  }

  func testInitDeinit16() {
    AssertParse(
      """
      extension BarUnion {
        init(x : Int) {}
        deinit {} 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: deinitializers may only be declared within a class or actor
      ]
    )
  }

  func testInitDeinit17() {
    AssertParse(
      """
      class BarClass {
        init() {}
        deinit {}
      }
      """
    )
  }

  func testInitDeinit18() {
    AssertParse(
      """
      extension BarClass {
        convenience init(x : Int) { self.init() }
        deinit {} 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: deinitializers may only be declared within a class or actor
      ]
    )
  }

  func testInitDeinit19() {
    AssertParse(
      """
      protocol BarProtocol {
        init() {} 
        deinit {} 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: protocol initializers must not have bodies
        // TODO: Old parser expected error on line 3: deinitializers may only be declared within a class or actor
      ]
    )
  }

  func testInitDeinit20() {
    AssertParse(
      """
      extension BarProtocol {
        init(x : Int) {}
        deinit {} 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: deinitializers may only be declared within a class or actor
      ]
    )
  }

  func testInitDeinit21() {
    AssertParse(
      """
      func fooFunc() {
        init() {} 
        deinit {} 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: initializers may only be declared within a type
        // TODO: Old parser expected error on line 3: deinitializers may only be declared within a class or actor
      ]
    )
  }

  func testInitDeinit22() {
    AssertParse(
      """
      func barFunc() {
        var x : () = { () -> () in
          init() {} 
          return
        } ()
        var y : () = { () -> () in
          deinit {} 
          return
        } ()
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: initializers may only be declared within a type
        // TODO: Old parser expected error on line 7: deinitializers may only be declared within a class or actor
      ]
    )
  }

  func testInitDeinit23() {
    AssertParse(
      """
      // https://github.com/apple/swift/issues/43464
      """
    )
  }

  func testInitDeinit24() {
    AssertParse(
      """
      class Aaron {
        init(x: Int) {}
        convenience init() { init(x: #^DIAG^#1) } 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: missing 'self.' at initializer invocation, Fix-It replacements: 24 - 24 = 'self.'
        DiagnosticSpec(message: "expected type in function parameter"),
        DiagnosticSpec(message: "unexpected text '1' in parameter clause"),
      ]
    )
  }

  func testInitDeinit25() {
    AssertParse(
      """
      class Theodosia: Aaron {
        init() {
          init(x: #^DIAG^#2) 
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: missing 'super.' at initializer invocation, Fix-It replacements: 5 - 5 = 'super.'
        DiagnosticSpec(message: "expected type in function parameter"),
        DiagnosticSpec(message: "unexpected text '2' in parameter clause"),
      ]
    )
  }

  func testInitDeinit26() {
    AssertParse(
      """
      struct AaronStruct {
        init(x: Int) {}
        init() { init(x: #^DIAG^#1) } 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: missing 'self.' at initializer invocation, Fix-It replacements: 12 - 12 = 'self.'
        DiagnosticSpec(message: "expected type in function parameter"),
        DiagnosticSpec(message: "unexpected text '1' in parameter clause"),
      ]
    )
  }

  func testInitDeinit27() {
    AssertParse(
      """
      enum AaronEnum: Int {
        case A = 1
        init(x: Int) { init(rawValue: x)#^DIAG^#! } 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: missing 'self.' at initializer invocation, Fix-It replacements: 18 - 18 = 'self.'
        DiagnosticSpec(message: "unexpected text '!' in initializer"),
      ]
    )
  }

}
