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

@_spi(RawSyntax) import SwiftParser
@_spi(RawSyntax) import SwiftSyntax
import XCTest

final class AttributeTests: ParserTestCase {
  func testMissingArgumentToAttribute() {
    assertParse(
      """
      @_dynamicReplacementℹ️(1️⃣
      func 2️⃣test_dynamic_replacement_for2() {
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected argument for '@_dynamicReplacement' attribute",
          fixIts: ["insert attribute argument"]
        ),
        DiagnosticSpec(
          message: "expected ')' to end attribute",
          notes: [NoteSpec(message: "to match this opening '('")],
          fixIts: ["insert ')'"]
        ),
      ],
      fixedSource: """
        @_dynamicReplacement(for: <#identifier#>)
        func test_dynamic_replacement_for2() {
        }
        """
    )
  }

  func testMissingGenericTypeToAttribute() {
    assertParse(
      """
      @differentiableℹ️(reverse wrt1️⃣,where T2️⃣
      func podcastPlaybackSpeed() {
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected ':' and arguments in '@differentiable' argument",
          fixIts: ["insert ':' and arguments"]
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ':' or '==' to indicate a conformance or same-type requirement"),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected ')' to end attribute",
          notes: [NoteSpec(message: "to match this opening '('")],
          fixIts: ["insert ')'"]
        ),
      ],
      fixedSource: """
        @differentiable(reverse wrt: <#identifier#>,where T)
        func podcastPlaybackSpeed() {
        }
        """
    )
  }

  func testSpecializeAttribute() {
    assertParse(
      """
      @_specialize(where @_noMetdata T : _BridgeObject)
      func foo(_ t: T) {}
      """
    )

    assertParse(
      """
      @_specialize(where @_noMetdata T : _TrivialStride(64))
      func foo(_ t: T) {}
      """
    )
  }

  func testMissingClosingParenToAttribute() {
    assertParse(
      """
      @_specializeℹ️(1️⃣e
      func foo() {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected argument for '@_specialize' attribute",
          fixIts: ["insert attribute argument"]
        ),
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected ')' to end attribute",
          notes: [NoteSpec(message: "to match this opening '('")],
          fixIts: ["insert ')'"]
        ),
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'e' in function"
        ),
      ],
      fixedSource: """
        @_specialize()e
        func foo() {}
        """
    )
  }

  func testMultipleInvalidSpecializeParams() {
    assertParse(
      """
      @_specialize(1️⃣e, exported)2️⃣
      func foo() {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected argument for '@_specialize' attribute",
          fixIts: ["insert attribute argument"]
        ),
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'e, exported' in attribute"
        ),
      ],
      fixedSource: """
        @_specialize(e, exported)
        func foo() {}
        """
    )
  }

  func testObjCAttribute() {
    assertParse(
      """
      @objc(zeroArg)
      class A { }

      @objc(:::::)
      func f(_: Int, _: Int, _: Int, _: Int, _: Int) { }
      """
    )

    assertParse(
      """
      @objc(_:)
      func f(_: Int)
      """
    )
  }

  func testRethrowsAttribute() {
    assertParse(
      """
      @1️⃣rethrows
      protocol P { }
      """,
      substructure: TokenSyntax.identifier("rethrows"),
      substructureAfterMarker: "1️⃣"
    )
  }

  func testAutoclosureAttribute() {
    assertParse(
      """
      func f(in: @autoclosure () -> Int) { }
      func g(in: @autoclosure @escaping () -> Int) { }
      """
    )
  }

  func testDifferentiableAttribute() {
    assertParse(
      """
      func f(in: @differentiable(reverse) (Int) -> Int) { }
      func f(in: @differentiable(reverse, wrt: a) (Int) -> Int) { }
      """
    )
  }

  func testQualifiedAttribute() {
    assertParse(
      """
      @_Concurrency.MainActor(unsafe) public struct Image : SwiftUI.View {}
      """
    )
  }

  func testDerivativeAttribute() {
    assertParse(
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

    assertParse(
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

    assertParse(
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

    assertParse(
      """
      @derivative(of: 1️⃣Self.other)
      func foo() {}
      """,
      substructure: Syntax(TokenSyntax.keyword(.Self)),
      substructureAfterMarker: "1️⃣"
    )

    assertParse(
      """
      @derivative(of: Foo.1️⃣Self.other)
      func foo() {}
      """,
      substructure: Syntax(TokenSyntax.identifier("Self")),
      substructureAfterMarker: "1️⃣"
    )
  }

  func testTransposeAttribute() {
    assertParse(
      """
      @transpose(of: S.instanceMethod, wrt: self)
      static func transposeInstanceMethodWrtSelf(_ other: S, t: S) -> S {
        other + t
      }
      """
    )

    assertParse(
      """
      @transpose(of: +)
      func addTranspose(_ v: Float) -> (Float, Float) {
        return (v, v)
      }
      """
    )

    assertParse(
      """
      @transpose(of: -, wrt: (0, 1))
      func subtractTranspose(_ v: Float) -> (Float, Float) {
        return (v, -v)
      }
      """
    )

    assertParse(
      """
      @transpose(of: Float.-, wrt: (0, 1))
      func subtractTranspose(_ v: Float) -> (Float, Float) {
        return (v, -v)
      }
      """
    )
  }

  func testImplementsAttribute() {
    assertParse(
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

  func testImplementsAttributeBaseType() {
    let cases: [UInt: String] = [
      // Identifiers and member types
      #line: "X<T>",
      #line: "X.Y",
      #line: "X.Y<T>",

      // Metatypes
      #line: "X.Type",
      #line: "X.Protocol",

      // Sugared optionals
      #line: "X?",
      #line: "X!",

      // Sugared collections
      #line: "[X]",
      #line: "[X : Y]",

      // Tuples and paren type
      #line: "()",
      #line: "(X)",
      #line: "(X, X)",

      // Keywords
      #line: "Any",
      #line: "Self",

      // Protocol compositions
      #line: "X & Y",
      #line: "any X & Y",

      // Functions
      #line: "(X) -> Y",
    ]

    for (line, baseType) in cases {
      var parser = Parser(baseType)

      assertParse(
        "@_implements(1️⃣\(baseType), f())",
        AttributeSyntax.parse,
        substructure: TypeSyntax.parse(from: &parser),
        substructureAfterMarker: "1️⃣",
        line: line
      )
    }
  }

  func testSemanticsAttribute() {
    assertParse(
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
    assertParse(
      "@resultBuilder1️⃣",
      diagnostics: [DiagnosticSpec(message: "expected declaration after attribute", fixIts: ["insert declaration"])],
      fixedSource: """
        @resultBuilder <#declaration#>
        """
    )
  }

  func testObjcImplementationAttribute() {
    assertParse(
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

  func testSpiAttributeWithoutParameter() {
    assertParse(
      "@_spi(1️⃣) class Foo {}",
      diagnostics: [
        DiagnosticSpec(message: "expected argument for '@_spi' attribute", fixIts: ["insert attribute argument"])
      ],
      fixedSource: "@_spi(<#identifier#>) class Foo {}"
    )
  }

  func testSpiAttributeWithUnderscore() {
    assertParse(
      "@_spi(_) class Foo {}"
    )
    assertParse(
      "@_spi(_) import Foo"
    )
  }

  func testSilgenName() {
    assertParse(
      """
      @_silgen_name("testExclusivityBogusPC")
      private static func _testExclusivityBogusPC()
      """
    )

    assertParse(
      """
      @_silgen_name("") func foo() {}
      """
    )

    assertParse(
      """
      @_silgen_name("foo") var global: Int
      """
    )

    assertParse(
      """
      @_silgen_name(raw: "foo") var global: Int
      """
    )
  }

  func testBackDeployed() {
    assertParse(
      """
      @backDeployed(before: macOS 12.0)
      struct Foo {}
      """
    )

    assertParse(
      """
      @backDeployed(before: macos 12.0, iOS 15.0)
      struct Foo {}
      """
    )

    assertParse(
      """
      @available(macOS 11.0, *)
      @backDeployed(before: _macOS12_1)
      public func backDeployTopLevelFunc2() -> Int { return 48 }
      """
    )

    // Legacy spelling @_backDeploy(before:)
    assertParse(
      """
      @_backDeploy(before: macOS 12.0)
      struct Foo {}
      """
    )

    assertParse(
      """
      @_backDeploy(before: macos 12.0, iOS 15.0)
      struct Foo {}
      """
    )

    assertParse(
      """
      @available(macOS 11.0, *)
      @_backDeploy(before: _macOS12_1)
      public func backDeployTopLevelFunc2() -> Int { return 48 }
      """
    )
  }

  func testExpose() {
    assertParse(
      """
      @_expose(Cxx) func foo() {}
      """
    )

    assertParse(
      """
      @_expose(Cplusplus) func foo() {}
      """
    )

    assertParse(
      """
      @_expose(Cxx, "baz") func foo() {}
      """
    )

    assertParse(
      """
      @_expose(Cxx, 1️⃣baz) func foo() {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: #"expected code 'baz' to be surrounded by '"'"#,
          fixIts: [#"insert '"' and '"'"#]
        )
      ],
      fixedSource: """
        @_expose(Cxx, "baz") func foo() {}
        """
    )
  }

  func testOriginallyDefinedIn() {
    assertParse(
      """
      @_originallyDefinedIn(module: "ToasterKit", macOS 10.15)
      struct Vehicle {}
      """
    )

    assertParse(
      """
      @_originallyDefinedIn(module: "ToasterKit", macOS 10.15, iOS 13)
      struct Vehicle {}
      """
    )

    assertParse(
      """
      @_originallyDefinedIn(module: "ToasterKit", _iOS13Aligned)
      struct Vehicle {}
      """
    )
  }

  func testUnavailableFromAsync() {
    assertParse(
      """
      @_unavailableFromAsync
      func foo() {}
      """
    )

    assertParse(
      """
      @_unavailableFromAsync(message: "abc")
      func foo() {}
      """
    )

    assertParse(
      """
      @_unavailableFromAsync(1️⃣nope: "abc")
      func foo() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'message' in @_unavailableFromAsync argument", fixIts: ["replace 'nope' with 'message'"])
      ],
      fixedSource: """
        @_unavailableFromAsync(message: "abc")
        func foo() {}
        """
    )

    assertParse(
      """
      @_unavailableFromAsync(message1️⃣= "abc")
      func foo() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ':' in @_unavailableFromAsync argument", fixIts: ["replace '=' with ':'"])
      ],
      fixedSource: """
        @_unavailableFromAsync(message: "abc")
        func foo() {}
        """
    )

    assertParse(
      """
      @_unavailableFromAsync(message: 1️⃣abc)
      func foo() {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: #"expected code 'abc' to be surrounded by '"'"#,
          fixIts: [#"insert '"' and '"'"#]
        )
      ],
      fixedSource: """
        @_unavailableFromAsync(message: "abc")
        func foo() {}
        """
    )
  }

  func testEffects() {
    assertParse(
      """
      @_effects(notEscaping self.value**)
      func foo() {}
      """
    )

    assertParse(
      """
      @_effects(escaping self.value**.class*.value** => return.value**)
      func foo() {}
      """
    )
  }

  func testEscapingOnClosureType() {
    assertParse(
      "func foo(closure: @escaping () -> Void) {}"
    )
  }

  func testNonSendable() {
    assertParse(
      """
      @_nonSendable
      class NonSendableType {
      }
      """
    )
  }

  func testDocumentationAttribute() {
    assertParse("@_documentation(visibility: internal) @_exported import A")
    assertParse("@_documentation(metadata: cool_stuff) public class SomeClass {}")
    assertParse(#"@_documentation(metadata: "this is a longer string") public class OtherClass {}"#)
    assertParse(#"@_documentation(visibility: internal, metadata: "this is a longer string") public class OtherClass {}"#)
  }

  func testSendable() {
    assertParse("func takeRepeater(_ f: @MainActor @Sendable @escaping () -> Int) {}")
    assertParse("takeRepesater { @MainActor @Sendable () -> Int in 0 }")
  }

  func testLexicalLifetimes() {
    assertParse(
      """
      @_lexicalLifetimes
      func lexy(_ c: C) {}
      """
    )
  }

  func testImportAttributes() {
    assertParse(
      """
      import A
      @_implementationOnly import B
      public import C
      package import D
      internal import E
      fileprivate import F
      private import G
      """
    )
  }

  func testAttachedExtensionAttribute() {
    assertParse(
      """
      @attached(extension)
      macro m()
      """
    )

    assertParse(
      """
      @attached(extension, names: named(test))
      macro m()
      """
    )
  }
}
