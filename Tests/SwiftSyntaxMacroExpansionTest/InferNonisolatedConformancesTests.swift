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

import SwiftSyntax
@_spi(Testing) import SwiftSyntaxMacroExpansion
import XCTest
import _SwiftSyntaxTestSupport

final class InferNonisolatedConformancesTests: XCTestCase {
  func testAddNonisolatedSimple() {
    assertInferNonisolatedConformances(
      """
      struct MyStruct: P, Q {
        nonisolated func f() { }
      }
      """,
      """
      struct MyStruct: nonisolated P, nonisolated Q {
        nonisolated func f() { }
      }
      """
    )
  }

  func testAddNonisolatedNested() {
    assertInferNonisolatedConformances(
      """
      extension MyStruct: P, Q {
        nonisolated func f() { }

        actor Inner: nonisolated R {
          nonisolated var value: Int { 0 }
        }
      }
      """,
      """
      extension MyStruct: nonisolated P, nonisolated Q {
        nonisolated func f() { }

        actor Inner: nonisolated R {
          nonisolated var value: Int { 0 }
        }
      }
      """
    )
  }

  func testNoAddWhenNoNonIsolated() {
    assertInferNonisolatedConformances(
      """
      struct MyStruct: P, Q {
        func f() { }
      }
      """,
      """
      struct MyStruct: P, Q {
        func f() { }
      }
      """
    )
  }

  func testNoAddWhenExplicit() {
    assertInferNonisolatedConformances(
      """
      struct MyStruct: P, nonisolated Q, @MainActor R, S {
        nonisolated func f() { }
      }
      """,
      """
      struct MyStruct: nonisolated P, nonisolated Q, @MainActor R, nonisolated S {
        nonisolated func f() { }
      }
      """
    )
  }

  func testNoAddHeuristics() {
    assertInferNonisolatedConformances(
      """
      class MyClass: P, Q {
        nonisolated func f() { }
      }
      """,
      """
      class MyClass: P, nonisolated Q {
        nonisolated func f() { }
      }
      """
    )
  }

  func testNoAddRawType() {
    assertInferNonisolatedConformances(
      """
      enum MyEnum: Int, Q {
        nonisolated func f() { }
      }
      """,
      """
      enum MyEnum: Int, nonisolated Q {
        nonisolated func f() { }
      }
      """
    )

    assertInferNonisolatedConformances(
      """
      enum MyEnum: P, Q {
        nonisolated func f() { }
      }
      """,
      """
      enum MyEnum: nonisolated P, nonisolated Q {
        nonisolated func f() { }
      }
      """
    )
  }

  func testNoAddProtocol() {
    assertInferNonisolatedConformances(
      """
      protocol MyProtocol: P, Q {
        nonisolated func f() { }
      }
      """,
      """
      protocol MyProtocol: P, Q {
        nonisolated func f() { }
      }
      """
    )
  }
}

public func assertInferNonisolatedConformances(
  _ original: DeclSyntax,
  _ expected: DeclSyntax,
  additionalInfo: @autoclosure () -> String? = nil,
  file: StaticString = #filePath,
  line: UInt = #line
) {
  let result = original.inferNonisolatedConformances()

  assertStringsEqualWithDiff(
    result.description,
    expected.description,
    file: file,
    line: line
  )
}
