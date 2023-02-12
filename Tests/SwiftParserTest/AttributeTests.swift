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

@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) import SwiftParser
import XCTest

final class AttributeTests: XCTestCase {
  func testMissingArgumentToAttribute() {
    AssertParse(
      """
      @_dynamicReplacement(1️⃣
      func 2️⃣test_dynamic_replacement_for2() {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected argument for '@_dynamicReplacement' attribute", fixIts: ["insert attribute argument"]),
        DiagnosticSpec(message: "expected ')' to end attribute", fixIts: ["insert ')'"]),
      ],
      fixedSource: """
        @_dynamicReplacement(for: <#identifier#>)
        func test_dynamic_replacement_for2() {
        }
        """
    )
  }

  func testMissingGenericTypeToAttribute() {
    AssertParse(
      """
      @differentiable(reverse wrt1️⃣,where T2️⃣
      func podcastPlaybackSpeed() {
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ':' and parameters in '@differentiable' argument", fixIts: ["insert ':' and parameters"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '=' and right-hand type in same type requirement", fixIts: ["insert '=' and right-hand type"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ')' to end attribute", fixIts: ["insert ')'"]),
      ],
      fixedSource: """
        @differentiable(reverse wrt: <#identifier#>,where T = <#type#>)
        func podcastPlaybackSpeed() {
        }
        """
    )
  }

  func testMissingClosingParenToAttribute() {
    AssertParse(
      """
      @_specialize(e1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ':' in attribute argument"),
        DiagnosticSpec(message: "expected ')' to end attribute"),
        DiagnosticSpec(message: "expected declaration after attribute"),
      ]
    )
  }

  func testMultipleInvalidSpecializeParams() {
    AssertParse(
      """
      @_specialize(e1️⃣, exported2️⃣)3️⃣
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ':' in attribute argument"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ': false' in attribute argument"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected declaration after attribute"),
      ]
    )
  }

  func testObjCAttribute() {
    AssertParse(
      """
      @objc(zeroArg)
      class A { }

      @objc(:::::)
      func f(_: Int, _: Int, _: Int, _: Int, _: Int) { }
      """
    )

    AssertParse(
      """
      @objc(_:)
      func f(_: Int)
      """
    )
  }

  func testRethrowsAttribute() {
    AssertParse(
      """
      @1️⃣rethrows
      protocol P { }
      """,
      substructure: Syntax(TokenSyntax.identifier("rethrows")),
      substructureAfterMarker: "1️⃣"
    )
  }

  func testAutoclosureAttribute() {
    AssertParse(
      """
      func f(in: @autoclosure () -> Int) { }
      func g(in: @autoclosure @escaping () -> Int) { }
      """
    )
  }

  func testDifferentiableAttribute() {
    AssertParse(
      """
      func f(in: @differentiable(reverse) (Int) -> Int) { }
      func f(in: @differentiable(reverse, wrt: a) (Int) -> Int) { }
      """
    )
  }

  func testQualifiedAttribute() {
    AssertParse(
      """
      @_Concurrency.MainActor(unsafe) public struct Image : SwiftUI.View {}
      """
    )
  }

  func testDerivativeAttribute() {
    AssertParse(
      """
      @inlinable
      @differentiable(reverse, wrt: self)
      public func differentiableMap<Result: Differentiable>(
        _ body: @differentiable(reverse) (Element) -> Result
      ) -> [Result] {
        map(body)
      }
      """
    )

    AssertParse(
      """
      @inlinable
      @differentiable(reverse, wrt: (self, initialResult))
      public func differentiableReduce<Result: Differentiable>(
        _ initialResult: Result,
        _ nextPartialResult: @differentiable(reverse) (Result, Element) -> Result
      ) -> Result {
        reduce(initialResult, nextPartialResult)
      }
      """
    )

    AssertParse(
      """
      @inlinable
      @derivative(of: differentiableReduce)
      internal func _vjpDifferentiableReduce<Result: Differentiable>(
        _ initialResult: Result,
        _ nextPartialResult: @differentiable(reverse) (Result, Element) -> Result
      ) -> (
        value: Result,
        pullback: (Result.TangentVector)
          -> (Array.TangentVector, Result.TangentVector)
      ) {}
      """
    )
  }

  func testTransposeAttribute() {
    AssertParse(
      """
      @transpose(of: S.instanceMethod, wrt: self)
      static func transposeInstanceMethodWrtSelf(_ other: S, t: S) -> S {
        other + t
      }
      """
    )
    AssertParse(
      """
      @transpose(of: +)
      func addTranspose(_ v: Float) -> (Float, Float) {
        return (v, v)
      }
      """
    )

    AssertParse(
      """
      @transpose(of: -, wrt: (0, 1))
      func subtractTranspose(_ v: Float) -> (Float, Float) {
        return (v, -v)
      }
      """
    )

    AssertParse(
      """
      @transpose(of: Float.-, wrt: (0, 1))
      func subtractTranspose(_ v: Float) -> (Float, Float) {
        return (v, -v)
      }
      """
    )
  }

  func testImplementsAttribute() {
    AssertParse(
      """
      @_implements(P, f0())
      func g0() -> Int {
        return 10
      }

      @_implements(P, f(x:y:))
      func g(x:Int, y:Int) -> Int {
        return 5
      }

      @_implements(Q, f(x:y:))
      func h(x:Int, y:Int) -> Int {
        return 6
      }

      @_implements(Equatable, ==(_:_:))
      public static func isEqual(_ lhs: S, _ rhs: S) -> Bool {
        return false
      }
      """
    )
  }

  func testSemanticsAttribute() {
    AssertParse(
      """
      @_semantics("constant_evaluable")
      func testRecursion(_ a: Int) -> Int {
        return a <= 0 ? 0 : testRecursion(a-1)
      }

      @_semantics("test_driver")
      internal func interpretRecursion() -> Int {
        return testRecursion(10)
      }
      """
    )
  }

  func testMissingDeclarationAfterAttributes() {
    AssertParse(
      "@resultBuilder1️⃣",
      diagnostics: [DiagnosticSpec(message: "expected declaration after attribute")],
      fixedSource: """
        @resultBuilder
        <#declaration#>
        """
    )
  }

  func testObjcImplementationAttribute() throws {
    AssertParse(
      """
      @_objcImplementation extension MyClass {
        func fn() {}
      }
      @_objcImplementation(Category) extension MyClass {
        func fn2() {}
      }
      """
    )
  }

  func testBackDeployed() {
    AssertParse(
      """
      @backDeployed(before: macOS 12.0)
      struct Foo {}
      """
    )

    AssertParse(
      """
      @backDeployed(before: macos 12.0, iOS 15.0)
      struct Foo {}
      """
    )

    AssertParse(
      """
      @available(macOS 11.0, *)
      @backDeployed(before: _macOS12_1)
      public func backDeployTopLevelFunc2() -> Int { return 48 }
      """
    )

    // Legacy spelling @_backDeploy(before:)
    AssertParse(
      """
      @_backDeploy(before: macOS 12.0)
      struct Foo {}
      """
    )

    AssertParse(
      """
      @_backDeploy(before: macos 12.0, iOS 15.0)
      struct Foo {}
      """
    )

    AssertParse(
      """
      @available(macOS 11.0, *)
      @_backDeploy(before: _macOS12_1)
      public func backDeployTopLevelFunc2() -> Int { return 48 }
      """
    )
  }
}
