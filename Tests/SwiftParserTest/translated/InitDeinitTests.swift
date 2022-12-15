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

// This test file has been translated from swift/test/Parse/init_deinit.swift

import SwiftSyntax

import XCTest

final class InitDeinitTests: XCTestCase {
  func testInitDeinit1() {
    AssertParse(
      """
      struct FooStructConstructorA {
        init 1️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected parameter clause in function signature")
      ]
    )
  }

  func testInitDeinit2() {
    AssertParse(
      """
      struct FooStructConstructorB {
        init() 
      }
      """
    )
  }

  func testInitDeinit3a() {
    AssertParse(
      """
      struct FooStructConstructorC {
        init 1️⃣{} 
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected parameter clause in function signature")
      ]
    )
  }

  func testInitDeinit3b() {
    AssertParse(
      """
      struct FooStructConstructorC {
        init<T> 1️⃣{}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected parameter clause in function signature")
      ]
    )
  }

  func testInitDeinit3c() {
    AssertParse(
      """
      struct FooStructConstructorC {
        init? 1️⃣{ self.init() }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected parameter clause in function signature")
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

  func testInitDeinit5a() {
    AssertParse(
      """
      struct FooStructDeinitializerA {
        deinit
      }
      """
    )
  }

  func testInitDeinit5b() {
    AssertParse(
      """
      struct FooStructDeinitializerA {
        deinit 1️⃣x
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "deinitializers cannot have a name", fixIts: ["remove 'x'"])
      ],
      fixedSource: """
        struct FooStructDeinitializerA {
          deinit
        }
        """
    )
  }

  func testInitDeinit5c() {
    AssertParse(
      """
      struct FooStructDeinitializerA {
        deinit 1️⃣x2️⃣()
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "deinitializers cannot have a name", fixIts: ["remove 'x'"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "deinitializers cannot have parameters", fixIts: ["remove function signature"]),
      ],
      fixedSource: """
        struct FooStructDeinitializerA {
          deinit
        }
        """
    )
  }

  func testInitDeinit6() {
    AssertParse(
      """
      struct FooStructDeinitializerB {
        deinit 
      }
      """
    )
  }

  func testInitDeinit7() {
    AssertParse(
      """
      struct FooStructDeinitializerC {
        deinit {} 
      }
      """
    )
  }

  func testInitDeinit8() {
    AssertParse(
      """
      class FooClassDeinitializerA {
        deinit1️⃣(a : Int) {} 
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "deinitializers cannot have parameters", fixIts: ["remove function signature"])
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit {}
        }
        """
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
        deinit 1️⃣x 2️⃣(a : Int) {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "deinitializers cannot have a name"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "deinitializers cannot have parameters"),
      ],
      fixedSource: """
        class FooClassDeinitializerC {
          deinit {}
        }
        """
    )
  }

  func testInitDeinit11() {
    AssertParse(
      """
      init 1️⃣{} 
      init() 
      init() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected parameter clause in function signature")
      ]
    )
  }

  func testInitDeinit12() {
    AssertParse(
      """
      deinit {} 
      deinit 
      deinit {}
      """
    )
  }

  func testInitDeinit13() {
    AssertParse(
      """
      struct BarStruct {
        init() {}
        deinit {} 
      }
      """
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
      """
    )
  }

  func testInitDeinit15() {
    AssertParse(
      """
      enum BarUnion {
        init() {}
        deinit {} 
      }
      """
    )
  }

  func testInitDeinit16() {
    AssertParse(
      """
      extension BarUnion {
        init(x : Int) {}
        deinit {} 
      }
      """
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
      """
    )
  }

  func testInitDeinit19() {
    AssertParse(
      """
      protocol BarProtocol {
        init() {} 
        deinit {} 
      }
      """
    )
  }

  func testInitDeinit20() {
    AssertParse(
      """
      extension BarProtocol {
        init(x : Int) {}
        deinit {} 
      }
      """
    )
  }

  func testInitDeinit21() {
    AssertParse(
      """
      func fooFunc() {
        init() {} 
        deinit {} 
      }
      """
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
      """
    )
  }

  func testInitDeinit24() {
    // https://github.com/apple/swift/issues/43464
    AssertParse(
      """
      class Aaron {
        convenience init() { init(x: 1) }
      }
      """
    )
  }

  func testInitDeinit25() {
    AssertParse(
      """
      class Theodosia: Aaron {
        init() {
          init(x: 2)
        }
      }
      """
    )
  }

  func testInitDeinit26() {
    AssertParse(
      """
      struct AaronStruct {
        init(x: Int) {}
        init() { init(x: 1) }
      }
      """
    )
  }

  func testInitDeinit27() {
    AssertParse(
      """
      enum AaronEnum: Int {
        case A = 1
        init(x: Int) { init(rawValue: x)! }
      }
      """
    )
  }

  func testDeinitInSwiftinterfaceIsFollowedByFinalFunc() {
    AssertParse(
      """
      class Foo {
        deinit
        final func foo()
      }
      """,
      substructure: Syntax(DeinitializerDeclSyntax())
    )
  }
}
