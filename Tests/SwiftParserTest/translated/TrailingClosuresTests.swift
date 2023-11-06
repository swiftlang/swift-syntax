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

// This test file has been translated from swift/test/Parse/trailing_closures.swift

import SwiftSyntax
import XCTest

final class TrailingClosuresTests: ParserTestCase {
  func testTrailingClosures1() {
    assertParse(
      """
      func foo<T, U>(a: () -> T, b: () -> U) {}
      """
    )
  }

  func testTrailingClosures2() {
    assertParse(
      #"""
      foo { 42 }
      b: { "" }
      """#
    )
  }

  func testTrailingClosures3() {
    assertParse(
      #"""
      foo { 42 } b: { "" }
      """#
    )
  }

  func testTrailingClosures4() {
    assertParse(
      """
      func when<T>(_ condition: @autoclosure () -> Bool,
                   `then` trueBranch: () -> T,
                   `else` falseBranch: () -> T) -> T {
        return condition() ? trueBranch() : falseBranch()
      }
      """
    )
  }

  func testTrailingClosures5() {
    assertParse(
      """
      let _ = when (2 < 3) { 3 } else: { 4 }
      """
    )
  }

  func testTrailingClosures6() {
    assertParse(
      """
      struct S {
        static func foo(a: Int = 42, b: (inout Int) -> Void) -> S {
          return S()
        }
        static func foo(a: Int = 42, ab: () -> Void, b: (inout Int) -> Void) -> S {
          return S()
        }
        subscript(v v: () -> Int) -> Int {
          get { return v() }
        }
        subscript(u u: () -> Int, v v: () -> Int) -> Int {
          get { return u() + v() }
        }
        subscript(cond: Bool, v v: () -> Int) -> Int {
          get { return cond ? 0 : v() }
        }
        subscript(cond: Bool, u u: () -> Int, v v: () -> Int) -> Int {
          get { return cond ? u() : v() }
        }
      }
      """
    )
  }

  func testTrailingClosures7() {
    assertParse(
      """
      let _: S = .foo {
        $0 = $0 + 1
      }
      """
    )
  }

  func testTrailingClosures8() {
    assertParse(
      """
      let _: S = .foo {} b: { $0 = $0 + 1 }
      """
    )
  }

  func testTrailingClosures9() {
    assertParse(
      """
      func bar(_ s: S) {
        _ = s[] {
          42
        }
        _ = s[] {
          21
        } v: {
          42
        }
        _ = s[true] {
          42
        }
        _ = s[true] {
          21
        } v: {
          42
        }
      }
      """
    )
  }

  func testTrailingClosures10() {
    assertParse(
      """
      func multiple_trailing_with_defaults(
        duration: Int,
        animations: (() -> Void)? = nil,
        completion: (() -> Void)? = nil) {}
      """
    )
  }

  func testTrailingClosures11() {
    assertParse(
      """
      multiple_trailing_with_defaults(duration: 42) {}
      """
    )
  }

  func testTrailingClosures12() {
    assertParse(
      """
      multiple_trailing_with_defaults(duration: 42) {} completion: {}
      """
    )
  }

  func testTrailingClosures13a() {
    assertParse(
      """
      fn {} g: {}
      fn {} _: {}
      multiple {} _: { }
      mixed_args_1 {} _: {}
      mixed_args_1 {} a: {}  //  {{none}}
      mixed_args_2 {} a: {} _: {}
      mixed_args_2 {} _: {} //  {{none}}
      mixed_args_2 {} _: {} _: {} //  {{none}}
      """
    )
  }

  func testTrailingClosures13b() {
    assertParse(
      """
      fn {} g: 1️⃣<#T##() -> Void#>
      """,
      substructure: MultipleTrailingClosureElementSyntax(
        label: .identifier("g"),
        colon: .colonToken(trailingTrivia: .space),
        closure: ClosureExprSyntax(
          leftBrace: .leftBraceToken(presence: .missing),
          statements: CodeBlockItemListSyntax([
            CodeBlockItemSyntax(
              item: .init(DeclReferenceExprSyntax(baseName: .identifier("<#T##() -> Void#>")))
            )
          ]),
          rightBrace: .rightBraceToken(presence: .missing)
        )
      ),
      diagnostics: [
        DiagnosticSpec(message: "editor placeholder in source file")
      ]
    )
  }

  func testTrailingClosures14a() {
    // TODO: The diagnostics here are perhaps a little overboard.
    assertParse(
      """
      func produce(fn: () -> Int?, default d: () -> Int) -> Int {
        return fn() ?? d()
      }
      _ = produce { 0 }1️⃣ 2️⃣default: { 1 }
      _ = produce { 2 } `default`: { 3 }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: "'default' label can only appear inside a 'switch' statement"),
      ],
      applyFixIts: ["insert newline"],
      fixedSource: """
        func produce(fn: () -> Int?, default d: () -> Int) -> Int {
          return fn() ?? d()
        }
        _ = produce { 0 }
        default: { 1 }
        _ = produce { 2 } `default`: { 3 }
        """
    )
  }

  func testTrailingClosures14b() {
    // TODO: The diagnostics here are perhaps a little overboard.
    assertParse(
      """
      func produce(fn: () -> Int?, default d: () -> Int) -> Int {
        return fn() ?? d()
      }
      _ = produce { 0 }1️⃣ 2️⃣default: { 1 }
      _ = produce { 2 } `default`: { 3 }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: "'default' label can only appear inside a 'switch' statement"),
      ],
      applyFixIts: ["insert ';'"],
      fixedSource: """
        func produce(fn: () -> Int?, default d: () -> Int) -> Int {
          return fn() ?? d()
        }
        _ = produce { 0 }; default: { 1 }
        _ = produce { 2 } `default`: { 3 }
        """
    )
  }

  func testTrailingClosures15() {
    assertParse(
      """
      func f() -> Int { 42 }
      """
    )
  }

  func testTrailingClosures16() {
    assertParse(
      """
      // This should be interpreted as a trailing closure, instead of being
      // interpreted as a computed property with undesired initial value.
      struct TrickyTest {
          var x : Int = f () {
              3
          }
      }
      """
    )
  }

}
