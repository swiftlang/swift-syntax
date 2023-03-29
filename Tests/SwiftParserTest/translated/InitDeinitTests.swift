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

// This test file has been translated from swift/test/Parse/init_deinit.swift

import SwiftSyntax

import XCTest

final class InitDeinitTests: XCTestCase {
  func testInitDeinit1() {
    assertParse(
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
    assertParse(
      """
      struct FooStructConstructorB {
        init()
      }
      """
    )
  }

  func testInitDeinit3a() {
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
      """
      struct FooStructConstructorD {
        init() 1️⃣-> FooStructConstructorD { }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "initializers cannot have a result type")
      ]
    )
  }

  func testInitDeinit5a() {
    assertParse(
      """
      struct FooStructDeinitializerA {
        deinit
      }
      """
    )
  }

  func testInitDeinit5b() {
    assertParse(
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
    assertParse(
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
    assertParse(
      """
      struct FooStructDeinitializerB {
        deinit
      }
      """
    )
  }

  func testInitDeinit7() {
    assertParse(
      """
      struct FooStructDeinitializerC {
        deinit {}
      }
      """
    )
  }

  func testInitDeinit8() {
    assertParse(
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
    assertParse(
      """
      class FooClassDeinitializerB {
        deinit { }
      }
      """
    )
  }

  func testInitDeinit10() {
    assertParse(
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
    assertParse(
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
    assertParse(
      """
      deinit {}
      deinit
      deinit {}
      """
    )
  }

  func testInitDeinit13() {
    assertParse(
      """
      struct BarStruct {
        init() {}
        deinit {}
      }
      """
    )
  }

  func testInitDeinit14() {
    assertParse(
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
    assertParse(
      """
      enum BarUnion {
        init() {}
        deinit {}
      }
      """
    )
  }

  func testInitDeinit16() {
    assertParse(
      """
      extension BarUnion {
        init(x : Int) {}
        deinit {}
      }
      """
    )
  }

  func testInitDeinit17() {
    assertParse(
      """
      class BarClass {
        init() {}
        deinit {}
      }
      """
    )
  }

  func testInitDeinit18() {
    assertParse(
      """
      extension BarClass {
        convenience init(x : Int) { self.init() }
        deinit {}
      }
      """
    )
  }

  func testInitDeinit19() {
    assertParse(
      """
      protocol BarProtocol {
        init() {}
        deinit {}
      }
      """
    )
  }

  func testInitDeinit20() {
    assertParse(
      """
      extension BarProtocol {
        init(x : Int) {}
        deinit {}
      }
      """
    )
  }

  func testInitDeinit21() {
    assertParse(
      """
      func fooFunc() {
        init() {}
        deinit {}
      }
      """
    )
  }

  func testInitDeinit22() {
    assertParse(
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
    assertParse(
      """
      class Aaron {
        convenience init() { init(x: 1) }
      }
      """
    )
  }

  func testInitDeinit25() {
    assertParse(
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
    assertParse(
      """
      struct AaronStruct {
        init(x: Int) {}
        init() { init(x: 1) }
      }
      """
    )
  }

  func testInitDeinit27() {
    assertParse(
      """
      enum AaronEnum: Int {
        case A = 1
        init(x: Int) { init(rawValue: x)! }
      }
      """
    )
  }

  func testInitDeinit28() {
    assertParse(
      """
      init(_ foo: T) 1️⃣-> Int where T: Comparable {} 
      """,
      diagnostics: [
        DiagnosticSpec(message: "initializers cannot have a result type")
      ]
    )
  }

  func testDeinitInSwiftinterfaceIsFollowedByFinalFunc() {
    assertParse(
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
