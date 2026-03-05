//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftParser
import SwiftRefactor
import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest
import _SwiftSyntaxTestSupport

final class MoveMembersToExtensionTests: XCTestCase {
  func testMoveFunctionFromClass() throws {
    try assertMoveMembersToExtension(
      """
      class Foo {1️⃣
        func foo() {
          print("Hello world!")
        }2️⃣

        func bar() {
          print("Hello world!")
        }
      }
      """,
      expected: """
        class Foo {

          func bar() {
            print("Hello world!")
          }
        }

        extension Foo {
          func foo() {
            print("Hello world!")
          }
        }
        """
    )
  }

  func testMoveFunctionFromClass2() throws {
    try assertMoveMembersToExtension(
      """
      class Foo {1️⃣
        func foo() {
          print("Hello world!")
        }2️⃣

        func bar() {
          print("Hello world!")
        }
      }

      struct Bar {
        func foo() {}
      }
      """,
      expected: """
        class Foo {

          func bar() {
            print("Hello world!")
          }
        }

        extension Foo {
          func foo() {
            print("Hello world!")
          }
        }

        struct Bar {
          func foo() {}
        }
        """
    )
  }

  func testMoveFunctionFromClassWithComment() throws {
    try assertMoveMembersToExtension(
      """
      class Foo {
        // Func foo prints "Hello world!"1️⃣
        func foo() {
          print("Hello world!")
        }2️⃣

        func bar() {
          print("Hello world!")
        }
      }

      struct Bar {
        func foo() {}
      }
      """,
      expected: """
        class Foo {

          func bar() {
            print("Hello world!")
          }
        }

        extension Foo {
          // Func foo prints "Hello world!"
          func foo() {
            print("Hello world!")
          }
        }

        struct Bar {
          func foo() {}
        }
        """
    )
  }

  func testMoveParticiallySelectedFunctionFromClass() throws {
    try assertMoveMembersToExtension(
      """
      class Foo {
        func foo() {
          1️⃣print("Hello world!")
        }2️⃣

        func bar() {
          print("Hello world!")
        }
      }

      struct Bar {
        func foo() {}
      }
      """,
      expected: """
        class Foo {

          func bar() {
            print("Hello world!")
          }
        }

        extension Foo {
          func foo() {
            print("Hello world!")
          }
        }

        struct Bar {
          func foo() {}
        }
        """
    )
  }

  func testMoveSelectedFromClass() throws {
    try assertMoveMembersToExtension(
      """
      class Foo {1️⃣
        func foo() {
          print("Hello world!")
        }

        deinit() {}

        func bar() {
          print("Hello world!")
        }2️⃣
      }

      struct Bar {
        func foo() {}
      }
      """,
      expected: """
        class Foo {

          deinit() {}
        }

        extension Foo {
          func foo() {
            print("Hello world!")
          }

          func bar() {
            print("Hello world!")
          }
        }

        struct Bar {
          func foo() {}
        }
        """
    )
  }

  func testMoveNestedFromStruct() throws {
    try assertMoveMembersToExtension(
      """
      struct Outer {1️⃣
        struct Inner {
          func moveThis() {}
        }2️⃣
      }
      """,
      expected: """
        struct Outer {
        }

        extension Outer {
          struct Inner {
            func moveThis() {}
          }
        }
        """
    )
  }

  func testMoveNestedFromStruct2() throws {
    try assertMoveMembersToExtension(
      """
      struct Outer<T> {1️⃣
        struct Inner {
          func moveThis() {}
        }2️⃣
      }
      """,
      expected: """
        struct Outer<T> {
        }

        extension Outer {
          struct Inner {
            func moveThis() {}
          }
        }
        """
    )
  }

  func testMoveMembersFromEnum() throws {
    try assertMoveMembersToExtension(
      """
      enum Foo {1️⃣
        func foo() {
          print("Hello world!")
        }2️⃣

        func bar() {
          print("Hello world!")
        }
      }

      struct Bar {
        func foo() {}
      }
      """,
      expected: """
        enum Foo {

          func bar() {
            print("Hello world!")
          }
        }

        extension Foo {
          func foo() {
            print("Hello world!")
          }
        }

        struct Bar {
          func foo() {}
        }
        """
    )
  }
}

private func assertMoveMembersToExtension(
  _ callDecl: String,
  expected: SourceFileSyntax,
  file: StaticString = #filePath,
  line: UInt = #line
) throws {

  let (markers, source) = extractMarkers(callDecl.description)
  let positions = markers.mapValues { AbsolutePosition(utf8Offset: $0) }
  var parser = Parser(source)
  let tree = SourceFileSyntax.parse(from: &parser)

  let context = MoveMembersToExtension.Context(range: positions["1️⃣"]!..<positions["2️⃣"]!)

  try assertRefactor(
    tree,
    context: context,
    provider: MoveMembersToExtension.self,
    expected: expected,
    file: file,
    line: line
  )
}
