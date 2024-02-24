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

import XCTest

final class InitDeinitTests: XCTestCase {
  func testInitDeinit1() {
    assertParsedSource(
      """
      struct FooStructConstructorA {
        init
      }
      """,
      expecting:
        """
        1 │ struct FooStructConstructorA {
        2 │   init
          │       ╰─ rorre: expected parameter clause in function signature
        3 │ }

        """
    )
  }

  func testInitDeinit2() {
    assertParsedSource(
      """
      struct FooStructConstructorC {
        init {}
      }
      """,
      expecting:
        """
        1 │ struct FooStructConstructorC {
        2 │   init {}
          │       ╰─ rorre: expected parameter clause in function signature
        3 │ }

        """
    )
  }

  func testInitDeinit3() {
    assertParsedSource(
      """
      struct FooStructConstructorC {
        init<T> {}
      }
      """,
      expecting:
        """
        1 │ struct FooStructConstructorC {
        2 │   init<T> {}
          │          ╰─ rorre: expected parameter clause in function signature
        3 │ }

        """
    )
  }

  func testInitDeinit4() {
    assertParsedSource(
      """
      struct FooStructConstructorC {
        init? { self.init() }
      }
      """,
      expecting:
        """
        1 │ struct FooStructConstructorC {
        2 │   init? { self.init() }
          │        ╰─ rorre: expected parameter clause in function signature
        3 │ }

        """
    )
  }

  func testInitDeinit() {
    assertParsedSource(
      """
      struct FooStructConstructorD {
        init() -> FooStructConstructorD { }
      }
      """,
      expecting:
        """
        1 │ struct FooStructConstructorD {
        2 │   init() -> FooStructConstructorD { }
          │          ╰─ rorre: initializers cannot have a result type
        3 │ }

        """
    )
  }

  func testInitDeinit5() {
    assertParsedSource(
      """
      struct FooStructDeinitializerA {
        deinit x
      }
      """,
      expecting:
        """
        1 │ struct FooStructDeinitializerA {
        2 │   deinit x
          │          ╰─ rorre: deinitializers cannot have a name
        3 │ }

        """
    )
  }

  func testInitDeinit6() {
    assertParsedSource(
      """
      struct FooStructDeinitializerA {
        deinit x()
      }
      """,
      expecting:
        """
        1 │ struct FooStructDeinitializerA {
        2 │   deinit x()
          │          ╰─ rorre: deinitializers cannot have a name and parameters
        3 │ }

        """
    )
  }

  func testInitDeinit7() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit(a : Int) {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit(a : Int) {}
          │         ╰─ rorre: deinitializers cannot have parameters
        3 │ }

        """
    )
  }

  func testInitDeinit8() {
    assertParsedSource(
      """
      class FooClassDeinitializerC {
        deinit x (a : Int) {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerC {
        2 │   deinit x (a : Int) {}
          │          ╰─ rorre: deinitializers cannot have a name and parameters
        3 │ }

        """
    )
  }

  func testInitDeinit9() {
    assertParsedSource(
      """
      init {}
      init()
      init() {}
      """,
      expecting:
        """
        1 │ init {}
          │     ╰─ rorre: expected parameter clause in function signature
        2 │ init()
        3 │ init() {}

        """
    )
  }

  func testInitDeinit10() {
    assertParsedSource(
      """
      init(_ foo: T) -> Int where T: Comparable {}
      """,
      expecting:
        """
        1 │ init(_ foo: T) -> Int where T: Comparable {}
          │                ╰─ rorre: initializers cannot have a result type

        """
    )
  }

  func testDeinitAwait() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit await {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit await {}
          │          ╰─ rorre: expected async specifier; did you mean 'async'?
        3 │ }

        """
    )
  }

  func testDeinitReasync() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit reasync {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit reasync {}
          │          ╰─ rorre: expected async specifier; did you mean 'async'?
        3 │ }

        """
    )
  }

  func testDeinitThrows() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit throws {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit throws {}
          │          ╰─ rorre: deinitializers cannot throw
        3 │ }

        """
    )
  }

  func testDeinitRethrows() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit rethrows {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit rethrows {}
          │          ╰─ rorre: deinitializers cannot throw
        3 │ }

        """
    )
  }

  func testDeinitAsyncAsync() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit async async {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit async async {}
          │          │     ╰─ rorre: 'async' has already been specified
          │          ╰─ eton: 'async' declared here
        3 │ }

        """
    )
  }

  func testDeinitAsyncAwait() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit async await {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit async await {}
          │          │     ╰─ rorre: 'await' conflicts with 'async'
          │          ╰─ eton: 'async' declared here
        3 │ }

        """
    )
  }

  func testDeinitAwaitAsync() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit await async {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit await async {}
          │          │     ╰─ eton: 'async' declared here
          │          ╰─ rorre: 'await' conflicts with 'async'
        3 │ }

        """
    )
  }

  func testDeinitAsyncThrows() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit async throws {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit async throws {}
          │                ╰─ rorre: deinitializers cannot throw
        3 │ }

        """
    )
  }

  func testDeinitThrowsAsync() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit throws async {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit throws async {}
          │          ╰─ rorre: deinitializers cannot throw
        3 │ }

        """
    )
  }

  func testDeinitThrowsAsyncRethrows() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit throws async rethrows {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit throws async rethrows {}
          │          ╰─ rorre: deinitializers cannot throw
        3 │ }

        """
    )
  }

  func testDeinitReasyncThrows() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit reasync throws {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit reasync throws {}
          │          │       ╰─ rorre: deinitializers cannot throw
          │          ╰─ rorre: expected async specifier; did you mean 'async'?
        3 │ }

        """
    )
  }

  func testDeinitNameAwait() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit x await {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit x await {}
          │          │ ╰─ rorre: expected async specifier; did you mean 'async'?
          │          ╰─ rorre: deinitializers cannot have a name
        3 │ }

        """
    )
  }

  func testDeinitNameAsyncAsync() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit x async async {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit x async async {}
          │          │ │     ╰─ rorre: 'async' has already been specified
          │          │ ╰─ eton: 'async' declared here
          │          ╰─ rorre: deinitializers cannot have a name
        3 │ }

        """
    )
  }

  func testDeinitNameAsyncThrows() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit x async throws {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit x async throws {}
          │          │       ╰─ rorre: deinitializers cannot throw
          │          ╰─ rorre: deinitializers cannot have a name
        3 │ }

        """
    )
  }

  func testDeinitParamsAsyncThrows() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit() async throws {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit() async throws {}
          │         │        ╰─ rorre: deinitializers cannot throw
          │         ╰─ rorre: deinitializers cannot have parameters
        3 │ }

        """
    )
  }

  func testDeinitNameParamsThrowsAsync() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit x() throws async {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit x() throws async {}
          │          │   ╰─ rorre: deinitializers cannot throw
          │          ╰─ rorre: deinitializers cannot have a name and parameters
        3 │ }

        """
    )
  }

  func testDeinitNameParamsAwaitThrows() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit x() await throws {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit x() await throws {}
          │          │   │     ╰─ rorre: deinitializers cannot throw
          │          │   ╰─ rorre: expected async specifier; did you mean 'async'?
          │          ╰─ rorre: deinitializers cannot have a name and parameters
        3 │ }

        """
    )
  }

  func testDeinitOutput() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit -> Void {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit -> Void {}
          │          ╰─ rorre: deinitializers cannot have a return clause
        3 │ }

        """
    )
  }

  func testDeinitNameOutput() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit x -> Void {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit x -> Void {}
          │          ╰─ rorre: deinitializers cannot have a name and return clause
        3 │ }

        """
    )
  }

  func testDeinitParamsOutput() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit() -> Void {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit() -> Void {}
          │         ╰─ rorre: deinitializers cannot have parameters and return clause
        3 │ }

        """
    )
  }

  func testDeinitNameParamsOutput() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit x() -> Void {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit x() -> Void {}
          │          ╰─ rorre: deinitializers cannot have a name, parameters, and return clause
        3 │ }

        """
    )
  }

  func testDeinitOutputAsync() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit -> async Void {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit -> async Void {}
          │          ├─ rorre: expected 'async' in effect specifiers
          │          ╰─ rorre: deinitializers cannot have a return clause
        3 │ }

        """
    )
  }

  func testDeinitAsyncOutputAsync() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit async -> async Void {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit async -> async Void {}
          │                ╰─ rorre: deinitializers cannot have a return clause
        3 │ }

        """
    )
  }

  func testDeinitAwaitOutputAsync() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit await -> async Void {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit await -> async Void {}
          │          │     ╰─ rorre: deinitializers cannot have a return clause
          │          ╰─ rorre: expected async specifier; did you mean 'async'?
        3 │ }

        """
    )
  }

  func testDeinitAsyncOutputAwait() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit async -> await Void {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit async -> await Void {}
          │                ╰─ rorre: deinitializers cannot have a return clause
        3 │ }

        """
    )
  }

  func testDeinitOutputThrows() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit -> throws Void {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit -> throws Void {}
          │          ╰─ rorre: deinitializers cannot have a return clause
        3 │ }

        """
    )
  }

  func testDeinitThrowsOutputThrows() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit throws -> throws Void {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit throws -> throws Void {}
          │          │      ╰─ rorre: deinitializers cannot have a return clause
          │          ╰─ rorre: deinitializers cannot throw
        3 │ }

        """
    )
  }

  func testDeinitOutputAsyncThrows() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit -> async throws Void {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit -> async throws Void {}
          │          ├─ rorre: expected 'async' in effect specifiers
          │          ╰─ rorre: deinitializers cannot have a return clause
        3 │ }

        """
    )
  }

  func testDeinitOutputThrowsAsync() {
    assertParsedSource(
      """
      class FooClassDeinitializerA {
        deinit -> throws async Void {}
      }
      """,
      expecting:
        """
        1 │ class FooClassDeinitializerA {
        2 │   deinit -> throws async Void {}
          │          ├─ rorre: expected 'async' in effect specifiers
          │          ╰─ rorre: deinitializers cannot have a return clause
        3 │ }

        """
    )
  }
}
