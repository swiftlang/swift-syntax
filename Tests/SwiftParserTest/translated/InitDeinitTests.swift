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

final class InitDeinitTests: ParserTestCase {
  func testInitDeinit1() {
    assertParse(
      """
      struct FooStructConstructorA {
        init1️⃣ 
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected parameter clause in function signature", fixIts: ["insert parameter clause"])
      ],
      fixedSource: """
        struct FooStructConstructorA {
          init()
        }
        """
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
        init1️⃣ {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected parameter clause in function signature", fixIts: ["insert parameter clause"])
      ],
      fixedSource: """
        struct FooStructConstructorC {
          init() {}
        }
        """
    )
  }

  func testInitDeinit3b() {
    assertParse(
      """
      struct FooStructConstructorC {
        init<T>1️⃣ {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected parameter clause in function signature", fixIts: ["insert parameter clause"])
      ],
      fixedSource: """
        struct FooStructConstructorC {
          init<T>() {}
        }
        """
    )
  }

  func testInitDeinit3c() {
    assertParse(
      """
      struct FooStructConstructorC {
        init?1️⃣ { self.init() }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected parameter clause in function signature", fixIts: ["insert parameter clause"])
      ],
      fixedSource: """
        struct FooStructConstructorC {
          init?() { self.init() }
        }
        """
    )
  }

  func testInitDeinit4() {
    assertParse(
      """
      struct FooStructConstructorD {
        init() 1️⃣-> FooStructConstructorD { }
      }
      """
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
        deinit 1️⃣x()
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "deinitializers cannot have a name and parameters",
          highlight: "x()",
          fixIts: ["remove 'x' and parameter clause"]
        )
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
        DiagnosticSpec(message: "deinitializers cannot have parameters", fixIts: ["remove parameter clause"])
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
        deinit 1️⃣x (a : Int) {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "deinitializers cannot have a name and parameters",
          highlight: "x (a : Int)",
          fixIts: ["remove 'x' and parameter clause"]
        )
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
      init1️⃣ {}
      init()
      init() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected parameter clause in function signature", fixIts: ["insert parameter clause"])
      ],
      fixedSource: """
        init() {}
        init()
        init() {}
        """
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
      """
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
      substructure: DeinitializerDeclSyntax()
    )
  }

  func testDeinitAsync() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit async {}
      }
      """
    )
  }

  func testDeinitAwait() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit 1️⃣await {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected async specifier; did you mean 'async'?",
          fixIts: ["replace 'await' with 'async'"]
        )
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit async {}
        }
        """
    )
  }

  func testDeinitReasync() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit 1️⃣reasync {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected async specifier; did you mean 'async'?",
          fixIts: ["replace 'reasync' with 'async'"]
        )
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit async {}
        }
        """
    )
  }

  func testDeinitThrows() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit 1️⃣throws {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "deinitializers cannot throw", fixIts: ["remove 'throws'"])
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit {}
        }
        """
    )
  }

  func testDeinitRethrows() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit 1️⃣rethrows {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "deinitializers cannot throw", fixIts: ["remove 'rethrows'"])
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit {}
        }
        """
    )
  }

  func testDeinitAsyncAsync() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit ℹ️async 1️⃣async {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "'async' has already been specified",
          notes: [NoteSpec(message: "'async' declared here")],
          fixIts: ["remove redundant 'async'"]
        )
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit async {}
        }
        """
    )
  }

  func testDeinitAsyncAwait() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit ℹ️async 1️⃣await {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "'await' conflicts with 'async'",
          notes: [NoteSpec(message: "'async' declared here")],
          fixIts: ["remove redundant 'await'"]
        )
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit async {}
        }
        """
    )
  }

  func testDeinitAwaitAsync() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit 1️⃣await ℹ️async {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "'await' conflicts with 'async'",
          notes: [NoteSpec(message: "'async' declared here")],
          fixIts: ["remove redundant 'await'"]
        )
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit async {}
        }
        """
    )
  }

  func testDeinitAsyncThrows() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit async 1️⃣throws {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "deinitializers cannot throw", fixIts: ["remove 'throws'"])
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit async {}
        }
        """
    )
  }

  func testDeinitThrowsAsync() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit 1️⃣throws async {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "deinitializers cannot throw", fixIts: ["remove 'throws'"])
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit async {}
        }
        """
    )
  }

  func testDeinitThrowsAsyncRethrows() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit 1️⃣throws async rethrows {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "deinitializers cannot throw", fixIts: ["remove 'throws' and 'rethrows'"])
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit async {}
        }
        """
    )
  }

  func testDeinitReasyncThrows() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit 1️⃣reasync 2️⃣throws {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected async specifier; did you mean 'async'?",
          fixIts: ["replace 'reasync' with 'async'"]
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: "deinitializers cannot throw", fixIts: ["remove 'throws'"]),
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit async {}
        }
        """
    )
  }

  func testDeinitNameAwait() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit 1️⃣x 2️⃣await {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "deinitializers cannot have a name", fixIts: ["remove 'x'"]),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected async specifier; did you mean 'async'?",
          fixIts: ["replace 'await' with 'async'"]
        ),
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit async {}
        }
        """
    )
  }

  func testDeinitNameAsyncAsync() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit 1️⃣x ℹ️async 2️⃣async {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "deinitializers cannot have a name", fixIts: ["remove 'x'"]),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "'async' has already been specified",
          notes: [NoteSpec(message: "'async' declared here")],
          fixIts: ["remove redundant 'async'"]
        ),
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit async {}
        }
        """
    )
  }

  func testDeinitNameAsyncThrows() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit 1️⃣x async 2️⃣throws {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "deinitializers cannot have a name", fixIts: ["remove 'x'"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "deinitializers cannot throw", fixIts: ["remove 'throws'"]),
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit async {}
        }
        """
    )
  }

  func testDeinitParamsAsyncThrows() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit1️⃣() async 2️⃣throws {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "deinitializers cannot have parameters",
          fixIts: ["remove parameter clause"]
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: "deinitializers cannot throw", fixIts: ["remove 'throws'"]),
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit async {}
        }
        """
    )
  }

  func testDeinitNameParamsThrowsAsync() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit 1️⃣x() 2️⃣throws async {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "deinitializers cannot have a name and parameters",
          highlight: "x()",
          fixIts: ["remove 'x' and parameter clause"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "deinitializers cannot throw",
          fixIts: ["remove 'throws'"]
        ),
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit async {}
        }
        """
    )
  }

  func testDeinitNameParamsAwaitThrows() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit 1️⃣x() 2️⃣await 3️⃣throws {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "deinitializers cannot have a name and parameters",
          highlight: "x()",
          fixIts: ["remove 'x' and parameter clause"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected async specifier; did you mean 'async'?",
          fixIts: ["replace 'await' with 'async'"]
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "deinitializers cannot throw",
          fixIts: ["remove 'throws'"]
        ),
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit async {}
        }
        """
    )
  }

  func testDeinitOutput() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit 1️⃣-> Void {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "deinitializers cannot have a return clause", fixIts: ["remove '->' and return type"])
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit {}
        }
        """
    )
  }

  func testDeinitNameOutput() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit 1️⃣x -> Void {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "deinitializers cannot have a name and return clause",
          highlight: "x -> Void",
          fixIts: ["remove 'x', '->', and return type"]
        )
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit {}
        }
        """
    )
  }

  func testDeinitParamsOutput() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit1️⃣() -> Void {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "deinitializers cannot have parameters and return clause",
          highlight: "() -> Void",
          fixIts: ["remove parameter clause, '->', and return type"]
        )
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit {}
        }
        """
    )
  }

  func testDeinitNameParamsOutput() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit 1️⃣x() -> Void {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "deinitializers cannot have a name, parameters, and return clause",
          highlight: "x() -> Void",
          fixIts: ["remove 'x', parameter clause, '->', and return type"]
        )
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit {}
        }
        """
    )
  }

  func testDeinitOutputAsync() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit 1️⃣-> async Void {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'async' in effect specifiers", fixIts: ["insert 'async'"]),
        DiagnosticSpec(
          message: "deinitializers cannot have a return clause",
          fixIts: ["remove '->', 'async', and return type"]
        ),
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit async {}
        }
        """
    )
  }

  func testDeinitAsyncOutputAsync() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit async 1️⃣-> async Void {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "deinitializers cannot have a return clause",
          fixIts: ["remove '->', 'async', and return type"]
        )
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit async {}
        }
        """
    )
  }

  func testDeinitAwaitOutputAsync() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit 1️⃣await 2️⃣-> async Void {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected async specifier; did you mean 'async'?",
          fixIts: ["replace 'await' with 'async'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "deinitializers cannot have a return clause",
          fixIts: ["remove '->', 'async', and return type"]
        ),
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit async {}
        }
        """
    )
  }

  func testDeinitAsyncOutputAwait() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit async 1️⃣-> await Void {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "deinitializers cannot have a return clause",
          fixIts: ["remove '->', 'await', and return type"]
        )
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit async {}
        }
        """
    )
  }

  func testDeinitOutputThrows() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit 1️⃣-> throws Void {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "deinitializers cannot have a return clause",
          fixIts: ["remove '->', 'throws', and return type"]
        )
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit {}
        }
        """
    )
  }

  func testDeinitThrowsOutputThrows() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit 1️⃣throws 2️⃣-> throws Void {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "deinitializers cannot throw", fixIts: ["remove 'throws'"]),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "deinitializers cannot have a return clause",
          fixIts: ["remove '->', 'throws', and return type"]
        ),
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit {}
        }
        """
    )
  }

  func testDeinitOutputAsyncThrows() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit 1️⃣-> async throws Void {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'async' in effect specifiers", fixIts: ["insert 'async'"]),
        DiagnosticSpec(
          message: "deinitializers cannot have a return clause",
          fixIts: ["remove '->', 'async throws', and return type"]
        ),
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit async {}
        }
        """
    )
  }

  func testDeinitOutputThrowsAsync() {
    assertParse(
      """
      class FooClassDeinitializerA {
        deinit 1️⃣-> throws async Void {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'async' in effect specifiers", fixIts: ["insert 'async'"]),
        DiagnosticSpec(
          message: "deinitializers cannot have a return clause",
          fixIts: ["remove '->', 'throws async', and return type"]
        ),
      ],
      fixedSource: """
        class FooClassDeinitializerA {
          deinit async {}
        }
        """
    )
  }

  func testAsyncDeinit() {
    // This is expected for now.
    // `async` is parsed as a modifier like `public` because you can have an `async var x: Int`.
    assertParse(
      """
      class FooClassDeinitializerA {
        async deinit {}
      }
      """
    )
  }
}
