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

@_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) import SwiftParser
@_spi(RawSyntax) import SwiftSyntax
import XCTest

final class TypeTests: ParserTestCase {
  func testMissingColonInType() {
    assertParse(
      """
      var foo 1️⃣Bar = 1
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ':' in type annotation", fixIts: ["insert ':'"])
      ],
      fixedSource: """
        var foo: Bar = 1
        """
    )
  }

  func testClosureParsing() {
    assertParse("let a: (a, b) -> c")

    assertParse("let a: @MainActor (a, b) async throws -> c")

    assertParse("() -> (\u{feff})")
  }

  func testGenericTypeWithTrivia() {
    // Whitespace is significant here.
    assertParse(
      """
      let a:
              Foo<Bar<
                  V, Baz<Quux>
              >>
      """
    )
  }

  func testFunctionTypes() {
    assertParse(
      "t as(1️⃣..)->2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected type in function type", fixIts: ["insert type"]),
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code '..' in function type"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected return type in function type", fixIts: ["insert return type"]),
      ],
      fixedSource: """
        t as(<#type#>..)-> <#type#>
        """
    )
  }

  func testClosureSignatures() {
    assertParse(
      """
      simple { [] str in
        print("closure with empty capture list")
      }
      """
    )

    assertParse(
      """
      { ()
      throws -> Void in }
      """
    )

    assertParse(
      """
      { [weak a, unowned(safe) self, b = 3] (a: Int, b: Int, _: Int) -> Int in }
      """
    )

    assertParse(
      "ℹ️{[1️⃣class]in2️⃣",
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected identifier in closure capture",
          fixIts: ["insert identifier"]
        ),
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected 'class' keyword in closure capture clause"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected '}' to end closure",
          notes: [NoteSpec(message: "to match this opening '{'")],
          fixIts: ["insert '}'"]
        ),
      ],
      fixedSource: """
        {[<#identifier#>class]in
        }
        """
    )

    assertParse(
      "{[n1️⃣`]in}",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '`' in closure capture clause")
      ]
    )

    assertParse(
      "{[weak1️⃣^]in}",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in closure capture", fixIts: ["insert identifier"]),
        DiagnosticSpec(message: "unexpected code '^' in closure capture clause"),
      ],
      fixedSource: """
        {[weak <#identifier#>^]in}
        """
    )
  }

  func testOpaqueReturnTypes() {
    assertParse(
      """
      public typealias Body = @_opaqueReturnTypeOf("$s6CatKit10pspspspspsV5cmereV6lilguyQrvp", 0) __
      """
    )
  }

  func testVariadics() {
    assertParse(
      #"""
      func takesVariadicFnWithGenericRet<T>(_ fn: (S...) -> T) {}
      let _: (S...) -> Int = \.i
      let _: (S...) -> Int = \Array.i1️⃣
      let _: (S...) -> Int = \S.i2️⃣
      """#
    )
  }

  func testConvention() {
    assertParse(
      #"""
      let _: @convention(thin) (@convention(thick) () -> (),
                                @convention(thin) () -> (),
                                @convention(c) () -> (),
                                @convention(c, cType: "intptr_t (*)(size_t)") (Int) -> Int,
                                @convention(block) () -> (),
                                @convention(method) () -> (),
                                @convention(objc_method) () -> (),
                                @convention(witness_method: Bendable) (Fork) -> ()) -> ()
      """#
    )
  }

  func testNamedOpaqueReturnTypes() {
    assertParse(
      """
      func f2() -> <T: SignedInteger, U: SignedInteger> Int {
      }

      dynamic func lazyMapCollection<C: Collection, T>(_ collection: C, body: @escaping (C.Element) -> T)
          -> <R: Collection where R.Element == T> R {
        return collection.lazy.map { body($0) }
      }

      struct Boom<T: P> {
        var prop1: Int = 5
        var prop2: <U, V> (U, V) = ("hello", 5)
      }
      """
    )
  }

  func testLowercaseSelf() {
    assertParse(
      "let a: 1️⃣self",
      diagnostics: [
        DiagnosticSpec(message: "expected type in type annotation", fixIts: ["insert type"]),
        DiagnosticSpec(message: "expected '=' in variable", fixIts: ["insert '='"]),
      ],
      fixedSource: "let a: <#type#> = self"
    )
  }

  func testUppercaseSelf() {
    assertParse(
      "let a: 1️⃣Self",
      substructure: Syntax(TokenSyntax.keyword(.Self)),
      substructureAfterMarker: "1️⃣"
    )
  }

  func testNestedLowercaseSelf() {
    assertParse(
      "let a: Foo.1️⃣self",
      substructure: Syntax(TokenSyntax.keyword(.`self`)),
      substructureAfterMarker: "1️⃣"
    )
  }

  func testNestedUppercaseSelf() {
    assertParse(
      "let a: Foo.1️⃣Self",
      substructure: Syntax(TokenSyntax.identifier("Self")),
      substructureAfterMarker: "1️⃣"
    )
  }

  func testTypeWithPlaceholder() {
    assertParse(
      "let a: 1️⃣<#T#> = x",
      substructure: VariableDeclSyntax(
        bindingSpecifier: .keyword(.let),
        bindings: [
          PatternBindingSyntax(
            pattern: IdentifierPatternSyntax(identifier: .identifier("a")),
            typeAnnotation: TypeAnnotationSyntax(
              type: IdentifierTypeSyntax(
                name: .identifier("<#T#>")
              )
            ),
            initializer: InitializerClauseSyntax(
              value: DeclReferenceExprSyntax(
                baseName: .identifier("x")
              )
            )
          )
        ]
      ),
      diagnostics: [
        DiagnosticSpec(message: "editor placeholder in source file")
      ]
    )

    assertParse(
      "let a: 1️⃣<#T#><Foo> = x",
      substructure: VariableDeclSyntax(
        bindingSpecifier: .keyword(.let),
        bindings: [
          PatternBindingSyntax(
            pattern: IdentifierPatternSyntax(identifier: .identifier("a")),
            typeAnnotation: TypeAnnotationSyntax(
              type: IdentifierTypeSyntax(
                name: .identifier("<#T#>"),
                genericArgumentClause: GenericArgumentClauseSyntax(
                  arguments: GenericArgumentListSyntax([
                    GenericArgumentSyntax(
                      argument: IdentifierTypeSyntax(
                        name: .identifier("Foo")
                      )
                    )
                  ])
                )
              )
            ),
            initializer: InitializerClauseSyntax(
              value: DeclReferenceExprSyntax(
                baseName: .identifier("x")
              )
            )
          )
        ]
      ),
      diagnostics: [
        DiagnosticSpec(message: "editor placeholder in source file")
      ]
    )

    assertParse(
      "let a: [1️⃣<#T#>] = x",
      substructure: VariableDeclSyntax(
        bindingSpecifier: .keyword(.let),
        bindings: [
          PatternBindingSyntax(
            pattern: IdentifierPatternSyntax(identifier: .identifier("a")),
            typeAnnotation: TypeAnnotationSyntax(
              type: ArrayTypeSyntax(
                element: IdentifierTypeSyntax(
                  name: .identifier("<#T#>")
                )
              )
            ),
            initializer: InitializerClauseSyntax(
              value: DeclReferenceExprSyntax(
                baseName: .identifier("x")
              )
            )
          )
        ]
      ),
      diagnostics: [
        DiagnosticSpec(message: "editor placeholder in source file")
      ]
    )
  }

  func testTypedThrows() {
    assertParse(
      """
      { () throws(PosixError) -> Void in }
      """
    )

    assertParse(
      "typealias T = () throws(PosixError) -> Void"
    )

    assertParse(
      "[() throws(PosixError) -> Void]()"
    )
  }
}
