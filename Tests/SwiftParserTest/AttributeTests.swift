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

@_spi(ExperimentalLanguageFeatures) @_spi(RawSyntax) import SwiftParser
@_spi(ExperimentalLanguageFeatures) @_spi(RawSyntax) import SwiftSyntax
import XCTest

final class AttributeTests: ParserTestCase {
  func testMissingArgumentToAttribute() {
    assertParse(
      """
      @_specializeℹ️(1️⃣
      func 2️⃣foo() {
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected argument for '@_specialize' attribute",
          fixIts: ["insert attribute argument"]
        ),
        DiagnosticSpec(
          message: "expected ')' to end attribute",
          notes: [NoteSpec(message: "to match this opening '('")],
          fixIts: ["insert ')'"]
        ),
      ],
      fixedSource: """
        @_specialize()
        func foo() {
        }
        """
    )

    assertParse(
      """
      @specializedℹ️(1️⃣
      func 2️⃣foo() {
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected argument for '@specialized' attribute",
          fixIts: ["insert attribute argument"]
        ),
        DiagnosticSpec(
          message: "expected ')' to end attribute",
          notes: [NoteSpec(message: "to match this opening '('")],
          fixIts: ["insert ')'"]
        ),
      ],
      fixedSource: """
        @specialized(where <#type#> == <#type#>)
        func foo() {
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
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected ':' or '==' to indicate a conformance or same-type requirement"
        ),
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
    assertParse(
      """
      @specialized(where T : Int)
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

  func testSpecializeWithAvailability() {
    assertParse(
      """
      @_specialize(exported: true, kind: full, availability: iOS, introduced: 15.4; where T == Swift.Int)
      public func specializeWithAvailability<T>(_ t: T) { }
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
        { AttributeSyntax.parse(from: &$0) },
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
      "@_spi() class Foo {}"
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
      @_unavailableFromAsync(nope: "abc")
      func foo() {}
      """
    )

    assertParse(
      """
      @_unavailableFromAsync(message1️⃣= "abc")
      func foo() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "'=' must have consistent whitespace on both sides", fixIts: ["insert whitespace"])
      ],
      fixedSource: """
        @_unavailableFromAsync(message = "abc")
        func foo() {}
        """
    )

    assertParse(
      """
      @_unavailableFromAsync(message: abc)
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
    assertParse("@_documentation(visibility: package) @objc final public class Klass {}")
    assertParse("@_documentation(metadata: cool_stuff) public class SomeClass {}")
    assertParse(#"@_documentation(metadata: "this is a longer string") public class OtherClass {}"#)
    assertParse(
      #"@_documentation(visibility: internal, metadata: "this is a longer string") public class OtherClass {}"#
    )
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

  func testMacroRoleNames() {
    assertParse(
      """
      @attached(member, names: named(1️⃣deinit))
      macro m()
      """,
      substructure: DeclReferenceExprSyntax(baseName: .keyword(.`deinit`)),
      substructureAfterMarker: "1️⃣"
    )

    assertParse(
      """
      @attached(member, names: named(1️⃣init))
      macro m()
      """,
      substructure: DeclReferenceExprSyntax(baseName: .keyword(.`init`)),
      substructureAfterMarker: "1️⃣"
    )

    assertParse(
      """
      @attached(member, names: named(1️⃣init(a:b:)))
      macro m()
      """,
      substructure: DeclReferenceExprSyntax(
        baseName: .keyword(.`init`),
        argumentNames: DeclNameArgumentsSyntax(
          arguments: [
            DeclNameArgumentSyntax(name: .identifier("a")),
            DeclNameArgumentSyntax(name: .identifier("b")),
          ]
        )
      ),
      substructureAfterMarker: "1️⃣"
    )

    assertParse(
      """
      @attached(member, names: named(1️⃣subscript))
      macro m()
      """,
      substructure: DeclReferenceExprSyntax(baseName: .keyword(.`subscript`)),
      substructureAfterMarker: "1️⃣"
    )

    assertParse(
      """
      @attached(declaration, names: named(1️⃣subscript(a:b:)))
      macro m()
      """,
      substructure: DeclReferenceExprSyntax(
        baseName: .keyword(.`subscript`),
        argumentNames: DeclNameArgumentsSyntax(
          arguments: [
            DeclNameArgumentSyntax(name: .identifier("a")),
            DeclNameArgumentSyntax(name: .identifier("b")),
          ]
        )
      ),
      substructureAfterMarker: "1️⃣"
    )

    assertParse(
      """
      @freestanding(declaration, names: named(1️⃣deinit))
      macro m()
      """,
      substructure: DeclReferenceExprSyntax(baseName: .keyword(.`deinit`)),
      substructureAfterMarker: "1️⃣"
    )

    assertParse(
      """
      @freestanding(declaration, names: named(1️⃣init))
      macro m()
      """,
      substructure: DeclReferenceExprSyntax(baseName: .keyword(.`init`)),
      substructureAfterMarker: "1️⃣"
    )

    assertParse(
      """
      @freestanding(declaration, names: named(1️⃣init(a:b:)))
      macro m()
      """,
      substructure: DeclReferenceExprSyntax(
        baseName: .keyword(.`init`),
        argumentNames: DeclNameArgumentsSyntax(
          arguments: [
            DeclNameArgumentSyntax(name: .identifier("a")),
            DeclNameArgumentSyntax(name: .identifier("b")),
          ]
        )
      ),
      substructureAfterMarker: "1️⃣"
    )

    assertParse(
      """
      @freestanding(member, names: named(1️⃣subscript))
      macro m()
      """,
      substructure: DeclReferenceExprSyntax(baseName: .keyword(.`subscript`)),
      substructureAfterMarker: "1️⃣"
    )

    assertParse(
      """
      @freestanding(member, names: named(1️⃣subscript(a:b:)))
      macro m()
      """,
      substructure: DeclReferenceExprSyntax(
        baseName: .keyword(.`subscript`),
        argumentNames: DeclNameArgumentsSyntax(
          arguments: [
            DeclNameArgumentSyntax(name: .identifier("a")),
            DeclNameArgumentSyntax(name: .identifier("b")),
          ]
        )
      ),
      substructureAfterMarker: "1️⃣"
    )

    assertParse(
      """
      @attached(member, names: named(1️⃣`class`))
      macro m()
      """,
      substructure: DeclReferenceExprSyntax(baseName: .identifier("`class`")),
      substructureAfterMarker: "1️⃣"
    )

    assertParse(
      """
      @attached4️⃣(member, names: named(1️⃣class2️⃣))
      macro m()3️⃣
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected value and ')' to end function call",
          fixIts: ["insert value and ')'"]
        ),
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected ')' to end attribute",
          notes: [
            NoteSpec(
              locationMarker: "4️⃣",
              message: "to match this opening '('"
            )
          ],
          fixIts: ["insert ')'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected identifier in class",
          fixIts: ["insert identifier"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected '{' in class",
          fixIts: ["insert '{'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "unexpected code '))' before macro"
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "expected '}' to end class",
          fixIts: ["insert '}'"]
        ),
      ],
      fixedSource: """
        @attached(member, names: named(<#expression#>)) class <#identifier#> {))
        macro m()
        }
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

  func testConventionAttributeInArrayType() {
    assertParse(
      """
      _ = [@convention(c, cType: "int (*)(int)") (Int32) -> Int32]()
      """,
      substructure: LabeledExprListSyntax([
        LabeledExprSyntax(
          expression: DeclReferenceExprSyntax(baseName: .identifier("c")),
          trailingComma: .commaToken()
        ),
        LabeledExprSyntax(label: "cType", expression: StringLiteralExprSyntax(content: "int (*)(int)")),
      ])
    )
  }

  func testIsolatedTypeAttribute() {
    assertParse(
      """
      var fn: @isolated(any) () -> ()
      """
    )

    // We don't validate the kind in the parser
    assertParse(
      """
      var fn: @isolated(sdfhsdfi) () -> ()
      """
    )

    // Check that this combines correctly with other attributs.
    // This is not a valid combination, but we don't validate that here.
    assertParse(
      """
      var fn: @isolated(any) @convention(swift) () -> ()
      """
    )
    assertParse(
      """
      var fn: @convention(swift) @isolated(any) () -> ()
      """
    )

    // Test that lookahead correctly skips the argument clause.
    assertParse(
      """
      var array = [@isolated(any) @convention(swift) () -> ()]()
      """
    )
    assertParse(
      """
      var array = [@convention(swift) @isolated(any) () -> ()]()
      """
    )
  }

  func testABIAttribute() {
    func abiAttr(_ provider: ABIAttributeArgumentsSyntax.Provider) -> AttributeListSyntax.Element {
      return .attribute(
        AttributeSyntax(
          attributeName: TypeSyntax("abi"),
          leftParen: .leftParenToken(),
          arguments: .abiArguments(
            ABIAttributeArgumentsSyntax(
              provider: provider
            )
          ),
          rightParen: .rightParenToken()
        )
      )
    }

    assertParse(
      """
      @abi(func fn() -> Int)
      func fn1() -> Int { }
      """,
      substructure: FunctionDeclSyntax(
        attributes: [
          abiAttr(
            .function(
              FunctionDeclSyntax(
                name: "fn",
                signature: FunctionSignatureSyntax(
                  parameterClause: FunctionParameterClauseSyntax {},
                  returnClause: ReturnClauseSyntax(type: TypeSyntax("Int"))
                ),
                body: nil
              )
            )
          )
        ],
        name: "fn1",
        signature: FunctionSignatureSyntax(
          parameterClause: FunctionParameterClauseSyntax {},
          returnClause: ReturnClauseSyntax(type: TypeSyntax("Int"))
        )
      ) {}
    )

    assertParse(
      """
      @abi(associatedtype AssocTy)
      associatedtype AssocTy
      """
    )
    assertParse(
      """
      @abi(deinit)
      deinit {}
      """
    )
    assertParse(
      """
      enum EnumCaseDeclNotParsedAtTopLevel {
        @abi(case someCase)
        case someCase
      }
      """
    )
    assertParse(
      """
      @abi(func fn())
      func fn()
      """
    )
    assertParse(
      """
      @abi(init())
      init() {}
      """
    )
    assertParse(
      """
      @abi(subscript(i: Int) -> Element)
      subscript(i: Int) -> Element {}
      """
    )
    assertParse(
      """
      @abi(typealias Typealias = @escaping () -> Void)
      typealias Typealias = () -> Void
      """
    )
    assertParse(
      """
      @abi(let c1, c2)
      let c1, c2
      """
    )
    assertParse(
      """
      @abi(var v1, v2)
      var v1, v2
      """
    )

    assertParse(
      """
      @abi(1️⃣<#fnord#>)
      func placeholder() {}
      """,
      substructure: abiAttr(
        .missing(
          MissingDeclSyntax(placeholder: .identifier("<#fnord#>"))
        )
      ),
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "editor placeholder in source file")
      ]
    )

    assertParse(
      """
      @abi(1️⃣import Fnord)
      func invalidDecl() {}
      """,
      substructure: abiAttr(
        .missing(
          MissingDeclSyntax(
            [
              Syntax(
                ImportDeclSyntax(
                  path: [ImportPathComponentSyntax(name: "Fnord")]
                )
              )
            ],
            placeholder: .identifier("<#declaration#>", presence: .missing)
          )
        )
      ),
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "import is not permitted as ABI-providing declaration")
      ]
    )

    //
    // Invalid, but diagnosed in the compiler
    //

    assertParse(
      """
      @abi(associatedtype AssocTy = T)
      associatedtype AssocTy
      """
    )
    assertParse(
      """
      @abi(deinit {})
      deinit {}
      """
    )
    assertParse(
      """
      enum EnumCaseDeclNotParsedAtTopLevel {
        @abi(case someCase = 42)
        case someCase
      }
      """
    )
    assertParse(
      """
      @abi(func fn() {})
      func fn()
      """
    )
    assertParse(
      """
      @abi(init() {})
      init() {}
      """
    )
    assertParse(
      """
      @abi(subscript(i: Int) -> Element { get {} set {} })
      subscript(i: Int) -> Element {}
      """
    )
    assertParse(
      """
      @abi(let c1 = 1, c2 = 2)
      let c1, c2
      """
    )
    assertParse(
      """
      @abi(var v1 = 1, v2 = 2)
      var v1, v2
      """
    )
    assertParse(
      """
      @abi(var v3 { get {} set {} })
      var v3
      """
    )

    //
    // Invalid and diagnosed here
    //

    assertParse(
      """
      @abi(var 1️⃣)
      var v1
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected pattern in variable",
          fixIts: ["insert pattern"]
        )
      ],
      fixedSource: """
        @abi(var <#pattern#>)
        var v1
        """
    )
    assertParse(
      """
      @abi3️⃣(var v22️⃣
      var v2
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected ')' to end attribute",
          notes: [
            NoteSpec(
              locationMarker: "3️⃣",
              message: "to match this opening '('"
            )
          ],
          fixIts: ["insert ')'"]
        )
      ],
      fixedSource: """
        @abi(var v2)
        var v2
        """
    )
    assertParse(
      """
      @abi(4️⃣)
      func fn2() {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "4️⃣",
          message: "expected argument for '@abi' attribute",
          fixIts: ["insert attribute argument"]
        )
      ],
      // It'd be better to have a custom fix-it with a copy of the declaration it's attached to.
      fixedSource: """
        @abi(<#declaration#>)
        func fn2() {}
        """
    )
    assertParse(
      """
      @abi5️⃣
      func fn3() {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "5️⃣",
          message: "expected '(', ABI-providing declaration, and ')' in attribute",
          fixIts: ["insert '(', ABI-providing declaration, and ')'"]
        )
      ],
      fixedSource: """
        @abi(<#declaration#>)
        func fn3() {}
        """
    )
    assertParse(
      """
      @abi6️⃣ func fn4_abi()7️⃣)
      func fn4() {}
      """,
      diagnostics: [
        // Suboptimal diagnostics, but we'd need to be able to scan past an entire decl in lookahead to do better.
        DiagnosticSpec(
          locationMarker: "6️⃣",
          message: "expected '(', ABI-providing declaration, and ')' in attribute",
          fixIts: ["insert '(', ABI-providing declaration, and ')'"]
        ),
        DiagnosticSpec(
          locationMarker: "7️⃣",
          message: "unexpected code ')' before function"
        ),
      ],
      fixedSource: """
        @abi(<#declaration#>) func fn4_abi())
        func fn4() {}
        """
    )

    // `#if` is banned inside an `@abi` attribute.
    // The code that generates feature checks in module interfaces could easily fail in ways that would generate this
    // syntax, so we want to make sure we give a good diagnostic.

    assertParse(
      """
      @abi(
        1️⃣#if $TypedThrows
        func _fn<E: Error>() throws(E)
        #endif
      )
      func fn<E: Error>() throws(E) {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "conditional compilation not permitted in ABI-providing declaration",
          highlight: """

              #if $TypedThrows
              #endif
            """,
          fixIts: ["remove '#if $TypedThrows' and '#endif'"]
        )
      ],
      fixedSource: """
        @abi(
          func _fn<E: Error>() throws(E)
        )
        func fn<E: Error>() throws(E) {}
        """
    )
  }

  func testSpaceBetweenAtAndAttribute() {
    assertParse(
      "@1️⃣ custom func foo() {}",
      diagnostics: [
        DiagnosticSpec(message: "extraneous whitespace after '@' is not permitted", fixIts: ["remove whitespace"])
      ],
      fixedSource: "@custom func foo() {}"
    )

    assertParse(
      "@1️⃣ custom func foo() {}",
      diagnostics: [
        DiagnosticSpec(
          message: "extraneous whitespace after '@' is not permitted; this is an error in Swift 6",
          severity: .warning,
          fixIts: ["remove whitespace"]
        )
      ],
      fixedSource: "@custom func foo() {}",
      swiftVersion: .v5
    )

    assertParse(
      """
      @1️⃣
      custom func foo() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous whitespace after '@' is not permitted", fixIts: ["remove whitespace"])
      ],
      fixedSource: "@custom func foo() {}"
    )
  }

  func testSpaceBetweenAttributeNameAndLeftParen() {
    assertParse(
      "@custom1️⃣ (1) func foo() {}",
      diagnostics: [
        DiagnosticSpec(message: "extraneous whitespace before '(' is not permitted", fixIts: ["remove whitespace"])
      ],
      fixedSource: "@custom(1) func foo() {}"
    )

    assertParse(
      "@custom1️⃣ (1) func foo() {}",
      diagnostics: [
        DiagnosticSpec(
          message: "extraneous whitespace before '(' is not permitted; this is an error in Swift 6",
          severity: .warning,
          fixIts: ["remove whitespace"]
        )
      ],
      fixedSource: "@custom(1) func foo() {}",
      swiftVersion: .v5
    )

    assertParse(
      """
      @custom
      1️⃣(1) func foo() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '(1)' in function")
      ]
    )
  }

  func testMisplacedAttributeInVariableDecl() {
    assertParse(
      """
      struct A {
        var 1️⃣@State name: String
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "misplaced attribute in variable declaration",
          fixIts: ["move attributes in front of 'var'"]
        )
      ],
      fixedSource:
        """
        struct A {
          @State var name: String
        }
        """
    )
  }

  func testLifetimeAttribute() {
    assertParse(
      """
      struct NE: ~Escapable {}

      @lifetime(ne)
      func derive1(ne: NE) -> NE { ne }

      @lifetime(borrow ne)
      func derive2(ne: borrowing NE) -> NE { ne }

      @lifetime(ne1, n2)
      func derive3(ne1: NE, ne2: NE) -> NE { ne1 }

      @lifetime(borrow ne1, n2)
      func derive4(ne1: NE, ne2: NE) -> NE { ne1 }

      @lifetime(neOut: ne)
      func derive5(ne: NE, neOut: inout NE) -> NE { neOut = ne }

      @lifetime(neOut: borrow ne)
      func derive6(ne: borrowing NE, neOut: inout NE) -> NE { neOut = ne }
      """
    )
  }

  func testAttributeParsable() {
    let source = """
      #if true
      @discardableResult
      #endif
      """
    var parser = Parser(source)
    let attr = AttributeSyntax.parse(from: &parser)

    XCTAssertTrue(attr.description == source)
    XCTAssertTrue(attr.tokens(viewMode: .fixedUp).allSatisfy({ $0.presence == .missing }))
  }
}
