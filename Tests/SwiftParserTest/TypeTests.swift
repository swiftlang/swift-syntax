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
@_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) import SwiftSyntax
import XCTest

final class TypeTests: ParserTestCase {
  func testMissingColonInType() {
    assertParse(
      """
      var foo1️⃣ Bar = 1
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
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected return type in function type",
          fixIts: ["insert return type"]
        ),
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
          message: "expected closure capture in closure capture clause",
          fixIts: ["insert closure capture"]
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
                      argument: .type(
                        TypeSyntax(
                          IdentifierTypeSyntax(
                            name: .identifier("Foo")
                          )
                        )
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

  func testInverseTypes() {
    assertParse(
      "[~Copyable]()"
    )

    assertParse(
      "[any ~Copyable]()"
    )

    assertParse(
      "[any P & ~Copyable]()"
    )

    assertParse(
      "[P & ~Copyable]()"
    )

    assertParse(
      "X<~Copyable>()"
    )

    assertParse(
      "X<any ~Copyable>()"
    )

    assertParse(
      "X<P & ~Copyable>()"
    )

    assertParse(
      "X<any P & ~Copyable>()"
    )
  }

  func testInverseTypesAsExpr() {
    assertParse(
      "(~Copyable).self"
    )

    assertParse(
      "~Copyable.self"
    )

    assertParse(
      "(any ~Copyable).self"
    )
  }

  func testInverseTypesInParameter() {
    assertParse(
      "func f(_: borrowing ~Copyable) {}"
    )

    assertParse(
      "func f(_: consuming ~Copyable) {}"
    )

    assertParse(
      "func f(_: borrowing any ~Copyable) {}"
    )

    assertParse(
      "func f(_: consuming any ~Copyable) {}"
    )

    assertParse(
      "func f(_: ~Copyable) {}"
    )

    assertParse(
      "typealias T = (~Copyable) -> Void"
    )

    assertParse(
      "typealias T = (_ x: ~Copyable) -> Void"
    )

    assertParse(
      "typealias T = (borrowing ~Copyable) -> Void"
    )

    assertParse(
      "typealias T = (_ x: borrowing ~Copyable) -> Void"
    )

    assertParse(
      "typealias T = (borrowing any ~Copyable) -> Void"
    )

    assertParse(
      "typealias T = (_ x: borrowing any ~Copyable) -> Void"
    )

    assertParse(
      "func f(_: any borrowing 1️⃣~Copyable) {}",
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected code '~Copyable' in parameter clause"
        )
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

  func testMultipleTypeSpecifiers() {
    assertParse("func foo1(_ a: _const borrowing String) {}")
    assertParse("func foo2(_ a: borrowing _const String) {}")
  }

  func testLifetimeSpecifier() {
    assertParse("func foo() -> dependsOn(x) X", experimentalFeatures: [.nonescapableTypes])

    assertParse("func foo() -> dependsOn(x, y) X", experimentalFeatures: [.nonescapableTypes])

    assertParse(
      "func foo() -> dependsOn(1️⃣) X",
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected parameter reference in lifetime specifier",
          fixIts: ["insert parameter reference"]
        )
      ],
      fixedSource: "func foo() -> dependsOn(<#identifier#>) X",
      experimentalFeatures: [.nonescapableTypes]
    )

    assertParse(
      "func foo() -> dependsOn(x,1️⃣) X",
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected parameter reference in lifetime specifier",
          fixIts: ["insert parameter reference"]
        )
      ],
      fixedSource: "func foo() -> dependsOn(x, <#identifier#>) X",
      experimentalFeatures: [.nonescapableTypes]
    )

    assertParse("func foo() -> dependsOn(x) dependsOn(scoped y) X", experimentalFeatures: [.nonescapableTypes])

    assertParse("func foo() -> dependsOn(scoped x) X", experimentalFeatures: [.nonescapableTypes])

    assertParse(
      "func foo() -> dependsOn1️⃣ X",
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected '(', parameter reference, and ')' in lifetime specifier",
          fixIts: ["insert '(', parameter reference, and ')'"]
        )
      ],
      fixedSource: "func foo() -> dependsOn(<#identifier#>) X",
      experimentalFeatures: [.nonescapableTypes]
    )

    assertParse(
      "func foo() -> dependsOn(1️⃣*) X",
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected parameter reference in lifetime specifier",
          fixIts: ["insert parameter reference"]
        ),
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code '*' in lifetime specifier"),
      ],
      fixedSource: "func foo() -> dependsOn(<#identifier#>*) X",
      experimentalFeatures: [.nonescapableTypes]
    )

    assertParse("func foo() -> dependsOn(0) X", diagnostics: [], experimentalFeatures: [.nonescapableTypes])

    assertParse("func foo() -> dependsOn(self) X", experimentalFeatures: [.nonescapableTypes])

    assertParse(
      "func foo() -> dependsOn1️⃣(0)2️⃣ X",
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
      ],
      fixedSource: """
        func foo() -> dependsOn
        (0)
        X
        """
    )

    assertParse(
      "func foo() -> dependsOn(1️⃣-1) X",
      diagnostics: [
        DiagnosticSpec(
          message: "expected parameter reference in lifetime specifier",
          fixIts: ["insert parameter reference"]
        ),
        DiagnosticSpec(message: "unexpected code '-1' in lifetime specifier"),
      ],
      fixedSource: "func foo() -> dependsOn(<#identifier#>-1) X",
      experimentalFeatures: [.nonescapableTypes]
    )
  }

  func testNonisolatedSpecifier() {
    assertParse("let _: nonisolated(nonsending) () async -> Void = {}")
    assertParse("let _: [nonisolated(nonsending) () async -> Void]")
    assertParse("let _ = [String: (nonisolated(nonsending) () async -> Void)?].self")
    assertParse("let _ = Array<nonisolated(nonsending) () async -> Void>()")
    assertParse("func foo(test: nonisolated(nonsending) () async -> Void)")
    assertParse("func foo(test: nonisolated(nonsending) @escaping () async -> Void) {}")

    assertParse(
      "func foo(test: nonisolated(1️⃣) () async -> Void)",
      diagnostics: [
        DiagnosticSpec(
          message: "expected 'nonsending' in 'nonisolated' specifier",
          fixIts: ["insert 'nonsending'"]
        )
      ],
      fixedSource: "func foo(test: nonisolated(nonsending) () async -> Void)"
    )

    assertParse(
      "func foo(test: nonisolated(1️⃣hello) () async -> Void)",
      diagnostics: [
        DiagnosticSpec(
          message: "expected 'nonsending' in 'nonisolated' specifier",
          fixIts: ["insert 'nonsending'"]
        ),
        DiagnosticSpec(message: "unexpected code 'hello' in 'nonisolated' specifier"),
      ],
      fixedSource: "func foo(test: nonisolated(nonsendinghello) () async -> Void)"
    )
  }
}

final class InlineArrayTypeTests: ParserTestCase {
  override var experimentalFeatures: Parser.ExperimentalFeatures {
    [.inlineArrayTypeSugar]
  }

  func testBasic() {
    assertParse(
      "[3 x Int]",
      substructure: InlineArrayTypeSyntax(
        count: .init(argument: .expr("3")),
        separator: .keyword(.x),
        element: .init(argument: .type(TypeSyntax("Int")))
      )
    )
    assertParse(
      "[Int x _]",
      substructure: InlineArrayTypeSyntax(
        count: .init(argument: .type(TypeSyntax("Int"))),
        separator: .keyword(.x),
        element: .init(argument: .type(TypeSyntax("_")))
      )
    )
  }

  func testMultiline() {
    // We don't currently allow multi-line.
    assertParse(
      """
      S<[
          3
          1️⃣x
          Int
      ]>()
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code in array")
      ]
    )
    assertParse(
      """
      S<[3
         1️⃣x
         Int
      ]>()
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code in array")
      ]
    )
    assertParse(
      """
      S<[3
         1️⃣x Int]>()
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'x Int' in array")
      ]
    )
    // These are okay.
    assertParse(
      """
      S<[3 x
             Int]>()
      """
    )
    assertParse(
      """
      S<[
        3 x Int
      ]>()
      """
    )
  }

  func testDiagnostics() {
    assertParse(
      "2️⃣[3 x1️⃣",
      diagnostics: [
        DiagnosticSpec(
          message: "expected element type and ']' to end inline array type",
          fixIts: ["insert element type and ']'"]
        )
      ],
      fixedSource: "[3 x <#type#>]"
    )
    assertParse(
      "ℹ️[3 x Int1️⃣",
      diagnostics: [
        DiagnosticSpec(
          message: "expected ']' to end inline array type",
          notes: [NoteSpec(message: "to match this opening '['")],
          fixIts: ["insert ']'"]
        )
      ],
      fixedSource: "[3 x Int]"
    )
  }

  func testEllipsis() {
    // Make sure this isn't parsed as '<variadic-type> x <missing type>'
    assertParse("[x...x]")
  }
}
