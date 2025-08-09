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

import SwiftBasicFormat
@_spi(Testing) @_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) import SwiftParser
@_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest

final class DeclarationTests: ParserTestCase {
  func testImports() {
    assertParse("import Foundation")

    assertParse("@_spi(Private) import SwiftUI")

    assertParse("@_exported import class Foundation.Thread")

    assertParse(#"@_private(sourceFile: "YetAnotherFile.swift") import Foundation"#)
  }

  func testStructParsing() {
    assertParse("struct Foo {}")
  }

  func testFuncParsing() {
    assertParse("func foo() {}")

    assertParse("func foo() -> Slice<MinimalMutableCollection<T>> {}")

    assertParse(
      """
      func onEscapingAutoclosure(_ fn: @Sendable @autoclosure @escaping () -> Int) { }
      func onEscapingAutoclosure2(_ fn: @escaping @autoclosure @Sendable () -> Int) { }
      func bar(_ : String) async -> [[String]: Array<String>] {}
      func tupleMembersFunc() -> (Type.Inner, Type2.Inner2) {}
      func myFun<S: T & U>(var1: S) {
        // do stuff
      }
      """
    )

    assertParse(
      """
      func 1️⃣where2️⃣
      r3️⃣
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "keyword 'where' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '(' to start parameter clause", fixIts: ["insert '('"]),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "expected ':' and type in parameter",
          fixIts: ["insert ':' and type"]
        ),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected ')' to end parameter clause", fixIts: ["insert ')'"]),
      ],
      fixedSource: """
        func `where`(
        r: <#type#>)
        """
    )

    assertParse("func /^/ (lhs: Int, rhs: Int) -> Int { 1 / 2 }")

    assertParse(
      "func /^1️⃣notoperator^/ (lhs: Int, rhs: Int) -> Int { 1 / 2 }",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'notoperator^/' before parameter clause")
      ]
    )

    assertParse("func /^ (lhs: Int, rhs: Int) -> Int { 1 / 2 }")

    assertParse(
      """
      func name(_ default: Int) {}
      """,
      substructure: FunctionParameterSyntax(
        firstName: .wildcardToken(),
        secondName: .identifier("default"),
        colon: .colonToken(),
        type: IdentifierTypeSyntax(name: .identifier("Int"))
      )
    )

    assertParse(
      """
      class MyClass {
        1️⃣foo()
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected 'func' in function",
          fixIts: ["insert 'func'"]
        )
      ],
      fixedSource: """
        class MyClass {
          func foo()
        }
        """
    )

    assertParse(
      """
      class MyClass {
        1️⃣foo<Int>2️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected 'func' in function",
          fixIts: ["insert 'func'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected parameter clause in function signature",
          fixIts: ["insert parameter clause"]
        ),
      ],
      fixedSource: """
        class MyClass {
          func foo<Int>()
        }
        """
    )

    assertParse(
      """
      class MyClass {
        1️⃣foo
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'foo' in class"
        )
      ]
    )
  }

  func testFuncAfterUnbalancedClosingBrace() {
    assertParse(
      """
      1️⃣}
      func foo() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected brace before function")
      ]
    )
  }

  func testClassParsing() {
    assertParse("class Foo {}")

    assertParse(
      """
      @dynamicMemberLookup @available(swift 4.0)
      public class MyClass {
        let A: Int
        let B: Double
      }
      """
    )

    assertParse("struct A<@NSApplicationMain T: AnyObject> {}")

    assertParse(
      "class T where t1️⃣",
      diagnostics: [
        DiagnosticSpec(message: "expected ':' or '==' to indicate a conformance or same-type requirement"),
        DiagnosticSpec(message: "expected member block in class", fixIts: ["insert member block"]),
      ],
      fixedSource: """
        class T where t{
        }
        """
    )
    assertParse(
      "class Bℹ️<where g1️⃣",
      diagnostics: [
        DiagnosticSpec(
          message: "expected ':' or '==' to indicate a conformance or same-type requirement"
        ),
        DiagnosticSpec(
          message: "expected '>' to end generic parameter clause",
          notes: [NoteSpec(message: "to match this opening '<'")],
          fixIts: ["insert '>'"]
        ),
        DiagnosticSpec(
          message: "expected member block in class",
          fixIts: ["insert member block"]
        ),
      ],
      fixedSource: """
        class B<where g> {
        }
        """
    )
  }

  func testActorParsing() {
    assertParse("actor Foo {}")

    assertParse(
      """
      actor Foo {
        nonisolated init?() {
          for (x, y, z) in self.triples {
            precondition(isSafe)
          }
        }
        subscript(_ param: String) -> Int {
          return 42
        }
      }
      """
    )
  }

  func testActorAfterUnbalancedClosingBrace() {
    assertParse(
      """
      1️⃣}
      actor Foo {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected brace before actor")
      ]
    )
  }

  func testNonisolatedUnsafeParsing() {
    assertParse(
      """
      nonisolated(unsafe) let a = 0

      struct A {
        nonisolated(unsafe) let b = 0
        nonisolated(unsafe) var c: Int { 0 }
        nonisolated(1️⃣safe) let d = 0
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected identifier in modifier",
          fixIts: ["replace 'safe' with identifier"]
        )
      ],
      fixedSource: """
        nonisolated(unsafe) let a = 0

        struct A {
          nonisolated(unsafe) let b = 0
          nonisolated(unsafe) var c: Int { 0 }
          nonisolated(<#identifier#>) let d = 0
        }
        """
    )
  }

  func testNonisolatedNonSendingParsing() {
    assertParse(
      """
      nonisolated(nonsending) let a = 0

      struct A {
        nonisolated(nonsending) let b = 0
        nonisolated(nonsending) var c: Int { 0 }
        nonisolated(1️⃣sending) let d = 0
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected identifier in modifier",
          fixIts: ["replace 'sending' with identifier"]
        )
      ],
      fixedSource: """
        nonisolated(nonsending) let a = 0

        struct A {
          nonisolated(nonsending) let b = 0
          nonisolated(nonsending) var c: Int { 0 }
          nonisolated(<#identifier#>) let d = 0
        }
        """
    )
  }

  func testProtocolParsing() {
    assertParse("protocol Foo {}")

    assertParse("protocol P { init() }")

    assertParse(
      """
      protocol P {
        associatedtype Foo: Bar where X.Y == Z.W.W.Self

        var foo: Bool { get set }
        subscript<R>(index: Int) -> R
      }
      """
    )

    assertParse(
      "protocol Pℹ️{1️⃣{}case2️⃣",
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code '{}' before enum case"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected identifier in enum case",
          fixIts: ["insert identifier"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected '}' to end protocol",
          notes: [NoteSpec(message: "to match this opening '{'")],
          fixIts: ["insert '}'"]
        ),
      ],
      fixedSource: """
        protocol P{{}case <#identifier#>
        }
        """
    )
  }

  func testVariableDeclarations() {
    assertParse(
      """
      z

      var x: Double = z
      """
    )

    assertParse(
      """
      async let a = fetch("1.jpg")
      async let b: Image = fetch("2.jpg")
      async let secondPhotoToFetch = fetch("3.jpg")
      async let theVeryLastPhotoWeWant = fetch("4.jpg")
      """
    )

    assertParse("private unowned(unsafe) var foo: Int")
    assertParse("unowned(unsafe) let unmanagedVar: Class = c")

    assertParse("_ = foo?.description")

    assertParse(
      "_ = foo/* */?.description1️⃣",
      diagnostics: [
        DiagnosticSpec(
          message: "expected ':' and expression after '? ...' in ternary expression",
          fixIts: ["insert ':' and expression"]
        )
      ],
      fixedSource: """
        _ = foo/* */?.description : <#expression#>
        """
    )

    assertParse("var a = Array<Int>?(from: decoder)")

    assertParse("@Wrapper var café = 42")

    assertParse(
      """
      var x: T {
        get async {
          foo()
          bar()
        }
      }
      """
    )

    assertParse(
      """
      var foo: Int {
        _read {
          yield 1234567890
        }
        _modify {
          var someLongVariable = 0
          yield &someLongVariable
        }
      }
      """
    )

    assertParse(
      """
      var foo: Int {
        @available(swift 5.0)
        func myFun() -> Int {
          return 42
        }
        return myFun()
      }
      """
    )

    assertParse(
      """
      var foo: Int {
        mutating set {
          test += 1
        }
      }
      """
    )
  }

  func testAccessLevelModifier() {
    assertParse(
      """
      open1️⃣ open(set)2️⃣ var openProp = 0
      public public(set) var publicProp = 0
      package package(set) var packageProp = 0
      internal internal(set) var internalProp = 0
      fileprivate fileprivate(set) var fileprivateProp = 0
      private private(set) var privateProp = 0
      internal(set) var defaultProp = 0
      """,
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
      applyFixIts: ["insert newline"],
      fixedSource: """
        open
        open(set)
        var openProp = 0
        public public(set) var publicProp = 0
        package package(set) var packageProp = 0
        internal internal(set) var internalProp = 0
        fileprivate fileprivate(set) var fileprivateProp = 0
        private private(set) var privateProp = 0
        internal(set) var defaultProp = 0
        """
    )

    assertParse(
      """
      open1️⃣ open(set)2️⃣ var openProp = 0
      public public(set) var publicProp = 0
      package package(set) var packageProp = 0
      internal internal(set) var internalProp = 0
      fileprivate fileprivate(set) var fileprivateProp = 0
      private private(set) var privateProp = 0
      internal(set) var defaultProp = 0
      """,
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
      applyFixIts: ["insert ';'"],
      fixedSource: """
        open; open(set); var openProp = 0
        public public(set) var publicProp = 0
        package package(set) var packageProp = 0
        internal internal(set) var internalProp = 0
        fileprivate fileprivate(set) var fileprivateProp = 0
        private private(set) var privateProp = 0
        internal(set) var defaultProp = 0
        """
    )

    assertParse(
      """
      private(1️⃣get) var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'set' in modifier", fixIts: ["replace 'get' with 'set'"])
      ],
      fixedSource: """
        private(set) var a = 0
        """
    )

    assertParse(
      """
      private(1️⃣+
        set
      ) var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'set' in modifier", fixIts: ["remove '+'"])
      ],
      fixedSource: """
        private(
          set
        ) var a = 0
        """
    )

    assertParse(
      """
      private(1️⃣get, set) var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected 'set' in modifier",
          fixIts: ["remove 'get,'"]
        )
      ],
      fixedSource: """
        private(set) var a = 0
        """
    )

    assertParse(
      """
      private(1️⃣get: set) var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected 'set' in modifier",
          fixIts: ["remove 'get:'"]
        )
      ],
      fixedSource: """
        private(set) var a = 0
        """
    )

    assertParse(
      """
      private(1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'set)' to end modifier", fixIts: ["insert 'set)'"]),
        DiagnosticSpec(message: "expected declaration after 'private' modifier", fixIts: ["insert declaration"]),
      ],
      fixedSource: """
        private(set) <#declaration#>
        """
    )

    assertParse(
      """
      private(1️⃣var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'set)' to end modifier", fixIts: ["insert 'set)'"])
      ],
      fixedSource: """
        private(set) var a = 0
        """
    )

    assertParse(
      """
      private(1️⃣get, set, didSet) var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected 'set' in modifier",
          fixIts: ["remove 'get,' and ', didSet'"]
        )
      ],
      fixedSource: """
        private(set) var a = 0
        """
    )

    assertParse(
      """
      private(1️⃣get, didSet var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'set)' to end modifier", fixIts: ["insert 'set)'"]),
        DiagnosticSpec(message: "unexpected code 'get, didSet' in variable"),
      ],
      fixedSource: """
        private(set) get, didSet var a = 0
        """
    )
  }

  func testTypealias() {
    assertParse("typealias Foo = Int")

    assertParse("typealias MyAlias = (_ a: Int, _ b: Double, _ c: Bool, _ d: String) -> Bool")

    assertParse("typealias A = @attr1 @attr2(hello) (Int) -> Void")
  }

  func testPrecedenceGroup() {
    assertParse(
      """
      precedencegroup FooGroup {
        higherThan: Group1, Group2
        lowerThan: Group3, Group4
        associativity: left
        assignment: false
      }
      """
    )

    assertParse(
      """
      precedencegroup FunnyPrecedence {
       associativity: left
       higherThan: MultiplicationPrecedence
      }
      """
    )
  }

  func testOperators() {
    assertParse("infix operator *-* : FunnyPrecedence")

    assertParse(
      """
      infix operator  <*<<< : MediumPrecedence, &
      prefix operator ^^ : PrefixMagicOperatorProtocol
      infix operator  <*< : MediumPrecedence, InfixMagicOperatorProtocol
      postfix operator ^^ : PostfixMagicOperatorProtocol
      infix operator ^^ : PostfixMagicOperatorProtocol, Class, Struct
      """
    )
  }

  func testObjCAttribute() {
    assertParse(
      """
      @objc(
        thisMethodHasAVeryLongName:
        foo:
        bar:
      )
      func f() {}
      """
    )
  }

  func testDifferentiableAttribute() {
    assertParse(
      """
      @differentiable(wrt: x where T: D)
      func foo<T>(_ x: T) -> T {}

      @differentiable(wrt: x where T: Differentiable)
      func foo<T>(_ x: T) -> T {}

      @differentiable(wrt: theVariableNamedX where T: Differentiable)
      func foo<T>(_ theVariableNamedX: T) -> T {}

      @differentiable(wrt: (x, y))
      func foo<T>(_ x: T) -> T {}
      """
    )
  }

  func testParsePoundError() {
    assertParse(#"#error("Unsupported platform")"#)
  }

  func testParsePoundWarning() {
    assertParse(#"#warning("Unsupported platform")"#)
  }

  func testParseSpecializeAttribute() {
    assertParse(
      #"""
      @_specialize(where T == Int, U == Float)
      mutating func exchangeSecond<U>(_ u: U, _ t: T) -> (U, T) {
        x = t
        return (u, x)
      }

      @_specialize(exported: true, kind: full, where K == Int, V == Int)
      @_specialize(exported: false, kind: partial, where K: _Trivial64)
      func dictFunction<K, V>(dict: Dictionary<K, V>) {
      }

      @_specialize(where T == Int)
      public func play() {
        for _ in 0...100_000_000 { t = t.ping() }
      }

      @_specialize(exported: true,
                   spi: SwiftSpecialization,
                   target: copy(),
                   where Key == AnyHashable, Value == Any)
      @_specialize(exported: true,
                   spi: SwiftSpecialization,
                   target: copy(),
                   where Key == AnyHashable, Value == String)
      @_specialize(exported: true,
                   spi: SwiftSpecialization,
                   target: copy(),
                   where Key == String, Value == Any)
      @_specialize(exported: true,
                   spi: SwiftSpecialization,
                   target: copy(),
                   where Key == String, Value == AnyHashable)
      @_specialize(exported: true,
                   spi: SwiftSpecialization,
                   target: copy(),
                   where Key == String, Value == String)
      @available(SwiftStdlib 5.5, *)
      @usableFromInline
      mutating func __specialize_copy() { Builtin.unreachable() }

      @_specializeExtension
      extension Sequence {
        @_specialize(exported: true,
                     spi: SwiftSpecialization,
                     target: _copyContents(initializing:),
                     where Self == [String])
        @_specialize(exported: true,
                     spi: SwiftSpecialization,
                     target: _copyContents(initializing:),
                     where Self == Set<String>)
        @available(SwiftStdlib 5.5, *)
        @usableFromInline
        __consuming func __specialize__copyContents(initializing: Swift.UnsafeMutableBufferPointer<Element>)  -> (Iterator, Int) { Builtin.unreachable() }
      }
      """#
    )

    assertParse(
      """
      @_specialize(where T: _Trivial(32), T: _Trivial(64), T: _Trivial, T: _RefCountedObject)
      @_specialize(where T: _Trivial, T: _Trivial(64))
      @_specialize(where T: _RefCountedObject, T: _NativeRefCountedObject)
      @_specialize(where Array<T> == Int)
      @_specialize(where T.Element == Int)
      public func funcWithComplexSpecializeRequirements<T: ProtocolWithDep>(t: T) -> Int {
        return 55555
      }
      """
    )
    assertParse(
      """
      @specialized(where Array<T> == Int)
      @specialized(where T.Element == Int)
      public func funcWithComplexSpecializeRequirements<T: ProtocolWithDep>(t: T) -> Int {
        return 55555
      }
      """
    )
  }

  func testParseRetroactiveExtension() {
    assertParse(
      """
      extension Int: @retroactive Identifiable {}
      """
    )
  }

  func testParsePreconcurrency() {
    assertParse(
      """
      struct MyValue: @preconcurrency P {}
      """
    )

    assertParse(
      """
      extension MyValue: @preconcurrency P {}
      """
    )
  }

  func testParseIsolatedConformances() {
    assertParse(
      """
      extension Int: nonisolated Q {}
      """
    )

    assertParse(
      """
      extension Int: @MainActor P {}
      """
    )

    assertParse(
      """
      extension Int: @preconcurrency nonisolated Q {}
      """
    )

    assertParse(
      """
      extension Int: @unsafe nonisolated Q {}
      """
    )
  }

  func testParseDynamicReplacement() {
    assertParse(
      """
      @_dynamicReplacement(for: dynamic_replaceable())
      func replacement() {
        dynamic_replaceable()
      }
      """
    )

    assertParse(
      """
      @_dynamicReplacement(for: subscript(_:))
      subscript(x y: Int) -> Int {
        get {
          return self[y]
        }
        set {
          self[y] = newValue
        }
      }
      """
    )

    assertParse(
      """
      @_dynamicReplacement(for: dynamic_replaceable_var)
      var r : Int {
        return 0
      }
      """
    )

    assertParse(
      """
      @_dynamicReplacement(for: init(x:))
      init(y: Int) {
        self.init(x: y + 1)
      }
      """
    )
  }

  func testEnumParsing() {
    assertParse(
      """
      enum Foo {
        @preconcurrency case custom(@Sendable () throws -> Void)
      }
      """
    )

    assertParse(
      """
      enum Content {
        case keyPath(KeyPath<FocusedValues, Value?>)
        case keyPath(KeyPath<FocusedValues, Binding<Value>?>)
        case value(Value?)
      }
      """
    )
  }

  func testStandaloneModifier() {
    assertParse(
      """
      struct a {
        public1️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected declaration after 'public' modifier", fixIts: ["insert declaration"])
      ],
      fixedSource: """
        struct a {
          public <#declaration#>
        }
        """
    )
  }

  func testEditorPlaceholderWithModifier() {
    assertParse(
      """
      struct a {
        public1️⃣<#declaration#>
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "editor placeholder in source file")
      ]
    )
  }

  func testMissingColonInFunctionSignature() {
    assertParse(
      "func test(first second1️⃣ Int)",
      diagnostics: [
        DiagnosticSpec(message: "expected ':' in parameter", fixIts: ["insert ':'"])
      ],
      fixedSource: """
        func test(first second: Int)
        """
    )
  }

  func testExtraArgumentLabelsInFunctionSignature() {
    assertParse(
      "func test(first second 1️⃣third fourth: Int)",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'third fourth' in parameter")
      ]
    )
  }

  func testMissingClosingParenInFunctionSignature() {
    assertParse(
      "func testℹ️(first second: Int1️⃣",
      diagnostics: [
        DiagnosticSpec(
          message: "expected ')' to end parameter clause",
          notes: [NoteSpec(message: "to match this opening '('")],
          fixIts: ["insert ')'"]
        )
      ],
      fixedSource: """
        func test(first second: Int)
        """
    )
  }

  func testMissingOpeningParenInFunctionSignature() {
    assertParse(
      "func test1️⃣ first second: Int)",
      diagnostics: [
        DiagnosticSpec(message: "expected '(' to start parameter clause", fixIts: ["insert '('"])
      ],
      fixedSource: """
        func test(first second: Int)
        """
    )
  }

  func testNoParamsForFunction() {
    assertParse(
      """
      class MyClass {
        func withoutParameters1️⃣

        func withParameters() {}
      }
      """,
      substructure: FunctionDeclSyntax(
        funcKeyword: .keyword(.func),
        name: .identifier("withoutParameters"),
        signature: FunctionSignatureSyntax(
          parameterClause: FunctionParameterClauseSyntax(
            leftParen: .leftParenToken(presence: .missing),
            parameters: FunctionParameterListSyntax([]),
            rightParen: .rightParenToken(presence: .missing)
          )
        )
      ),
      diagnostics: [
        DiagnosticSpec(message: "expected parameter clause in function signature", fixIts: ["insert parameter clause"])
      ],
      fixedSource: """
        class MyClass {
          func withoutParameters()

          func withParameters() {}
        }
        """
    )
  }

  func testThrowsInWrongLocation() {
    assertParse(
      "func test() -> 1️⃣throws Int",
      diagnostics: [
        DiagnosticSpec(message: "'throws' must precede '->'", fixIts: ["move 'throws' in front of '->'"])
      ],
      fixedSource: "func test() throws -> Int"
    )
  }

  func testTypedThrowsPlacedAfterArrow() {
    assertParse(
      "func test() -> 1️⃣throws(any Error) Int",
      diagnostics: [
        DiagnosticSpec(
          message: "'throws(any Error)' must precede '->'",
          fixIts: ["move 'throws(any Error)' in front of '->'"]
        )
      ],
      fixedSource: "func test() throws(any Error) ->  Int"
    )

    assertParse(
      "func test() -> 1️⃣throws(any Error Int",
      diagnostics: [
        DiagnosticSpec(
          message: "'throws(any Error' must precede '->'",
          fixIts: ["move 'throws(any Error' in front of '->'"]
        )
      ],
      fixedSource: "func test() throws(any Error -> Int"
    )

    assertParse(
      "func test() -> 1️⃣throws (Int, Int)",
      diagnostics: [
        DiagnosticSpec(
          message: "'throws' must precede '->'",
          fixIts: ["move 'throws' in front of '->'"]
        )
      ],
      fixedSource: "func test() throws -> (Int, Int)"
    )

    assertParse(
      "func test() -> 1️⃣throws (any Error) Int",
      diagnostics: [
        DiagnosticSpec(
          message: "'throws' must precede '->'",
          fixIts: ["move 'throws' in front of '->'"]
        )
      ],
      fixedSource: "func test() throws -> (any Error) Int"
    )
  }

  func testTypedThrows() {
    assertParse(
      "func test() throws(any Error) -> Int { }"
    )

    assertParse(
      """
      struct X {
        init() throws(any Error) { }
      }
      """
    )

    assertParse(
      "func test() throws(MyError) 1️⃣async {}",
      diagnostics: [
        DiagnosticSpec(message: "'async' must precede 'throws'", fixIts: ["move 'async' in front of 'throws'"])
      ],
      fixedSource: "func test() async throws(MyError) {}"
    )

    assertParse(
      "func test() throws 1️⃣async2️⃣(MyError) {}",
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "'async' must precede 'throws'",
          fixIts: ["move 'async' in front of 'throws'"]
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code '(MyError)' in function"),
      ],
      fixedSource: "func test() async throws (MyError) {}"
    )

    assertParse(
      "func test() 1️⃣try2️⃣(MyError) async {}",
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected throwing specifier; did you mean 'throws'?",
          fixIts: ["replace 'try' with 'throws'"]
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code '(MyError) async' in function"),
      ],
      fixedSource: "func test() throws (MyError) async {}"
    )

    assertParse(
      "func test() 1️⃣try 2️⃣async3️⃣(MyError) {}",
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected throwing specifier; did you mean 'throws'?",
          fixIts: ["replace 'try' with 'throws'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "'async' must precede 'throws'",
          fixIts: ["move 'async' in front of 'throws'"]
        ),
        DiagnosticSpec(locationMarker: "3️⃣", message: "unexpected code '(MyError)' in function"),
      ],
      fixedSource: "func test() async throws (MyError) {}"
    )

    assertParse(
      "func test() throws(MyError) 1️⃣await {}",
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "'await' must precede 'throws'",
          fixIts: ["move 'await' in front of 'throws'"]
        )
      ],
      fixedSource: "func test() async throws(MyError) {}"
    )

    assertParse(
      "func test() throws 1️⃣await2️⃣(MyError) {}",
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "'await' must precede 'throws'",
          fixIts: ["move 'await' in front of 'throws'"]
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code '(MyError)' in function"),
      ],
      fixedSource: "func test() async throws (MyError) {}"
    )

    assertParse(
      "func test() 1️⃣try2️⃣(MyError) await {}",
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected throwing specifier; did you mean 'throws'?",
          fixIts: ["replace 'try' with 'throws'"]
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code '(MyError) await' in function"),
      ],
      fixedSource: "func test() throws (MyError) await {}"
    )

    assertParse(
      "func test() 1️⃣try await2️⃣(MyError) {}",
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected throwing specifier; did you mean 'throws'?",
          fixIts: ["replace 'try' with 'throws'"]
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code '(MyError)' in function"),
      ],
      fixedSource: "func test() awaitthrows (MyError) {}"  // FIXME: spacing
    )

    assertParse(
      "func test() async1️⃣(MyError) {}",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '(MyError)' in function")
      ]
    )

    assertParse(
      "func test() 1️⃣await2️⃣(MyError) {}",
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected async specifier; did you mean 'async'?",
          fixIts: ["replace 'await' with 'async'"]
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code '(MyError)' in function"),
      ],
      fixedSource: "func test() async (MyError) {}"
    )

    assertParse(
      "func test() 1️⃣try2️⃣(MyError) {}",
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected throwing specifier; did you mean 'throws'?",
          fixIts: ["replace 'try' with 'throws'"]
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code '(MyError)' in function"),
      ],
      fixedSource: "func test() throws (MyError) {}"
    )

    assertParse(
      "func test() throws(MyError) {}"
    )

    assertParse(
      "func test() throws(MyError)1️⃣async {}",  // no space between closing parenthesis and `async`
      diagnostics: [
        DiagnosticSpec(message: "'async' must precede 'throws'", fixIts: ["move 'async' in front of 'throws'"])
      ],
      fixedSource: "func test() async throws(MyError){}"
    )

    assertParse(
      """
      struct S<Element, Failure: Error> {
        init(produce: @escaping () async throws(Failure) -> Element?) {
        }
      }
      """
    )
  }

  func testExtraneousRightBraceRecovery() {
    assertParse(
      """
      class ABC {
        let def = ghi(jkl: mno)
      }
      1️⃣}
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous brace at top level")
      ]
    )
  }

  func testMissingSubscriptReturnClause() {
    assertParse(
      """
      struct Foo {
        subscript(x: String) 1️⃣{}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '->' and return type in subscript", fixIts: ["insert '->' and return type"])
      ],
      fixedSource: """
        struct Foo {
          subscript(x: String) -> <#type#> {}
        }
        """
    )
  }

  func testClassWithLeadingNumber() {
    assertParse(
      """
      class 1️⃣23class {
        func 2️⃣24method() {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "identifier can only start with a letter or underscore, not a number"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "identifier can only start with a letter or underscore, not a number"
        ),
      ]
    )
  }

  func testAccessors() {
    assertParse(
      """
      var bad1 : Int {
        _read async { 0 }
      }
      """
    )

    assertParse(
      """
      var bad2 : Int {
        get 1️⃣reasync { 0 }
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected async specifier; did you mean 'async'?",
          fixIts: ["replace 'reasync' with 'async'"]
        )
      ],
      fixedSource: """
        var bad2 : Int {
          get async { 0 }
        }
        """
    )
  }

  func testInitAccessor() {
    assertParse(
      """
      struct S {
        var value: Int {
          init {}
          get {}
          set {}
        }
      }
      """
    )

    assertParse(
      """
      struct S {
        let _value: Int

        init() {
        }
      }
      """
    )

    assertParse(
      """
      struct S {
        var value: Int {
          init(newValue) {}
          get {}
          set(newValue) {}
        }
      }
      """
    )

    assertParse(
      """
      struct S {
        var value: Int {
          init(newValue) {}
          get {}
          set(newValue) {}
        }
      }
      """
    )
  }

  func testExpressionMember() {
    assertParse(
      """
      struct S {
        1️⃣/ ###line 25 "line-directive.swift"
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: #"unexpected code '/ ###line 25 "line-directive.swift"' in struct"#)
      ]
    )
  }

  func testBogusProtocolRequirements() {
    assertParse(
      """
      protocol P {
        var prop : Int { get 1️⃣bogus rethrows set }
      }
      """,
      substructure: AccessorBlockSyntax(
        accessors: .accessors(
          AccessorDeclListSyntax([
            AccessorDeclSyntax(
              accessorSpecifier: .keyword(.get)
            )
          ])
        ),
        UnexpectedNodesSyntax([
          TokenSyntax.identifier("bogus"),
          TokenSyntax.keyword(.rethrows),
          TokenSyntax.identifier("set"),
        ])
      ),
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'bogus rethrows set' in variable")
      ]
    )
  }

  func testTextRecovery1() {
    assertParse(
      """
      Lorem1️⃣ ipsum2️⃣ dolor3️⃣ sit4️⃣ amet5️⃣, consectetur adipiscing elit
      """,
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
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "4️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(locationMarker: "5️⃣", message: "extraneous code ', consectetur adipiscing elit' at top level"),
      ],
      applyFixIts: ["insert newline"],
      fixedSource: """
        Lorem
        ipsum
        dolor
        sit
        amet, consectetur adipiscing elit
        """
    )
  }

  func testTextRecovery2() {
    assertParse(
      """
      Lorem1️⃣ ipsum2️⃣ dolor3️⃣ sit4️⃣ amet5️⃣, consectetur adipiscing elit
      """,
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
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "4️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(locationMarker: "5️⃣", message: "extraneous code ', consectetur adipiscing elit' at top level"),
      ],
      applyFixIts: ["insert ';'"],
      fixedSource: """
        Lorem; ipsum; dolor; sit; amet, consectetur adipiscing elit
        """
    )
  }

  func testRecoverOneExtraLabel() {
    assertParse(
      "func test(first second 1️⃣third: Int)",
      substructure: FunctionParameterSyntax(
        firstName: .identifier("first"),
        secondName: .identifier("second"),
        UnexpectedNodesSyntax([TokenSyntax.identifier("third")]),
        colon: .colonToken(),
        type: IdentifierTypeSyntax(name: .identifier("Int"))
      ),
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'third' in parameter")
      ]
    )
  }

  func testRecoverTwoExtraLabels() {
    assertParse(
      "func test(first second 1️⃣third fourth: Int)",
      substructure: FunctionParameterSyntax(
        firstName: .identifier("first"),
        secondName: .identifier("second"),
        UnexpectedNodesSyntax([
          TokenSyntax.identifier("third"),
          TokenSyntax.identifier("fourth"),
        ]),
        colon: .colonToken(),
        type: IdentifierTypeSyntax(name: .identifier("Int"))
      ),
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'third fourth' in parameter")
      ]
    )
  }

  func testDontRecoverFromDeclKeyword() {
    assertParse(
      "func fooℹ️(first second1️⃣ third2️⃣ struct3️⃣: Int4️⃣) {}",
      substructure: FunctionParameterSyntax(
        firstName: .identifier("first"),
        secondName: .identifier("second"),
        colon: .colonToken(presence: .missing),
        type: IdentifierTypeSyntax(name: .identifier("third"))
      ),
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected ':' in parameter",
          fixIts: ["insert ':'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected ')' to end parameter clause",
          notes: [NoteSpec(message: "to match this opening '('")],
          fixIts: ["insert ')'"]
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "expected identifier in struct",
          fixIts: ["insert identifier"]
        ),
        DiagnosticSpec(
          locationMarker: "4️⃣",
          message: "unexpected code ')' in struct"
        ),
      ],
      fixedSource: """
        func foo(first second: third)struct <#identifier#>: Int) {}
        """
    )
  }

  func testRecoverFromParens() {
    assertParse(
      "func test(first second 1️⃣[third fourth]: Int)",
      substructure: FunctionParameterSyntax(
        firstName: .identifier("first"),
        secondName: .identifier("second"),
        UnexpectedNodesSyntax([
          TokenSyntax.leftSquareToken(),
          TokenSyntax.identifier("third"),
          TokenSyntax.identifier("fourth"),
          TokenSyntax.rightSquareToken(),
        ]),
        colon: .colonToken(),
        type: IdentifierTypeSyntax(name: .identifier("Int"))
      ),
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '[third fourth]' in parameter")
      ]
    )
  }

  func testDontRecoverFromUnbalancedParens() {
    assertParse(
      "func foo(first second1️⃣ 2️⃣[third3️⃣ 4️⃣fourth: Int) {}",
      substructure: FunctionParameterSyntax(
        firstName: .identifier("first"),
        secondName: .identifier("second"),
        colon: .colonToken(presence: .missing),
        type: ArrayTypeSyntax(
          leftSquare: .leftSquareToken(),
          element: IdentifierTypeSyntax(name: .identifier("third")),
          rightSquare: .rightSquareToken(presence: .missing)
        ),
        trailingComma: .commaToken(presence: .missing)
      ),
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected ':' in parameter",
          fixIts: ["insert ':'"]
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "expected ']' to end array type",
          notes: [NoteSpec(locationMarker: "2️⃣", message: "to match this opening '['")],
          fixIts: ["insert ']'"]
        ),
        DiagnosticSpec(
          locationMarker: "4️⃣",
          message: "expected ',' in parameter",
          fixIts: ["insert ','"]
        ),
      ],
      fixedSource: """
        func foo(first second: [third], fourth: Int) {}
        """
    )
  }

  func testDontRecoverIfNewlineIsBeforeColon() {
    assertParse(
      """
      func fooℹ️(first second1️⃣ third2️⃣
      3️⃣: Int) {}
      """,
      substructure: FunctionParameterSyntax(
        firstName: .identifier("first"),
        secondName: .identifier("second"),
        colon: .colonToken(presence: .missing),
        type: IdentifierTypeSyntax(name: .identifier("third"))
      ),
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected ':' in parameter",
          fixIts: ["insert ':'"]
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "unexpected code ': Int' in parameter clause"
        ),
      ],
      fixedSource: """
        func foo(first second: third
        : Int) {}
        """
    )
  }

  func testMalforedStruct() {
    assertParse(
      """
      struct n1️⃣
      #if2️⃣
      @3️⃣
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '{' in struct", fixIts: ["insert '{'"]),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected condition in conditional compilation clause",
          fixIts: ["insert condition"]
        ),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected name in attribute", fixIts: ["insert name"]),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "expected declaration after attribute",
          fixIts: ["insert declaration"]
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "expected '#endif' in conditional compilation block",
          fixIts: ["insert '#endif'"]
        ),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected '}' to end struct", fixIts: ["insert '}'"]),
      ],
      fixedSource: """
        struct n {
        #if <#expression#>
        @<#type#> <#declaration#>
        #endif
        }
        """
    )
  }

  func testInitializers() {
    assertParse(
      """
      struct S0 {
        init!(int: Int) { }
        init! (uint: UInt) { }
        init !(float: Float) { }

        init?(string: String) { }
        init ?(double: Double) { }
        init ? (char: Character) { }
      }
      """
    )
  }

  func testDeinitializers() {
    assertParse("deinit {}")
    assertParse("deinit")
  }

  func testAttributedMember() {
    assertParse(
      #"""
      struct Foo {
        @Argument(help: "xxx")
        var generatedPath: String
      }
      """#
    )
  }

  func testAnyAsParameterLabel() {
    assertParse(
      "func at(any kinds: [RawTokenKind]) {}"
    )
  }

  func testPublicClass() {
    assertParse("public class Foo: Superclass {}")
  }

  func testReturnVariableNamedAsync() {
    assertParse(
      ##"""
      if let async = self.consume(if: .keyword(.async)) {
        return async
      }

      if let reasync = self.consume(if: .keyword(.reasync)) {
        return reasync
      }
      """##
    )
  }

  func testLeadingUnexpectedTokens() {
    assertParse(
      "1️⃣}class C2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace before class"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected member block in class", fixIts: ["insert member block"]),
      ],
      fixedSource: """
        }class C {
        }
        """
    )
    assertParse(
      "1️⃣}enum C2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace before enum"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected member block in enum", fixIts: ["insert member block"]),
      ],
      fixedSource: """
        }enum C {
        }
        """
    )
    assertParse(
      "1️⃣}protocol C2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace before protocol"),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected member block in protocol",
          fixIts: ["insert member block"]
        ),
      ],
      fixedSource: """
        }protocol C {
        }
        """
    )
    assertParse(
      "1️⃣}actor C2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace before actor"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected member block in actor", fixIts: ["insert member block"]),
      ],
      fixedSource: """
        }actor C {
        }
        """
    )
    assertParse(
      "1️⃣}struct C2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace before struct"),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected member block in struct",
          fixIts: ["insert member block"]
        ),
      ],
      fixedSource: """
        }struct C {
        }
        """
    )
    assertParse(
      "1️⃣}func C2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace before function"),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected parameter clause in function signature",
          fixIts: ["insert parameter clause"]
        ),
      ],
      fixedSource: """
        }func C()
        """
    )
    assertParse(
      "1️⃣}init2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace before initializer"),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected parameter clause in function signature",
          fixIts: ["insert parameter clause"]
        ),
      ],
      fixedSource: """
        }init()
        """
    )
    assertParse(
      "1️⃣}subscript2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace before subscript"),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected parameter clause in subscript",
          fixIts: ["insert parameter clause"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected '->' and return type in subscript",
          fixIts: ["insert '->' and return type"]
        ),
      ],
      fixedSource: """
        }subscript() -> <#type#>
        """
    )
  }

  func testBogusTypeDeclName() {
    assertParse(
      "associatedtype 1️⃣5s",
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
      ]
    )
  }

  func testModifiedParameter() {
    assertParse(
      """
      func const(_const _ map: String) {}
      """
    )

    assertParse(
      """
      func isolated(isolated _ 1️⃣map: String) {}
      """
    )

    assertParse(
      """
      func isolatedConst(isolated _const _ 1️⃣map: String) {}
      """
    )

    assertParse(
      """
      func nonEphemeralIsolatedConst(@_nonEmphemeral isolated _const _ 1️⃣map: String) {}
      """
    )

    assertParse(
      """
      func const(_const map: String) {}
      """
    )

    assertParse(
      """
      func isolated(isolated map: String) {}
      """
    )

    assertParse(
      """
      func isolatedConst(isolated _const map1️⃣: String) {}
      """
    )

    assertParse(
      """
      func const(_const x: String) {}
      func isolated(isolated: String) {}
      func isolatedConst(isolated _const: String) {}
      """
    )
  }

  func testReasyncFunctions() {
    assertParse(
      """
      class MyType {
        init(_ f: () async -> Void) reasync {
          await f()
        }

        func foo(index: Int) reasync rethrows -> String {
          await f()
        }
      }
      """
    )
  }

  func testStandaloneAtSignInGenericParameter() {
    assertParse(
      """
      struct U1️⃣<@2️⃣
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected name in attribute",
          fixIts: ["insert name"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected name in generic parameter",
          fixIts: ["insert name"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected '>' to end generic parameter clause",
          notes: [NoteSpec(locationMarker: "1️⃣", message: "to match this opening '<'")],
          fixIts: ["insert '>'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected member block in struct",
          fixIts: ["insert member block"]
        ),
      ],
      fixedSource: """
        struct U<@<#type#> <#identifier#>> {
        }
        """
    )
  }

  func testMatchBracesBasedOnSpaces() {
    assertParse(
      """
      struct Foo {
        struct Bar 1️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected member block in struct", fixIts: ["insert member block"])
      ],
      fixedSource: """
        struct Foo {
          struct Bar {
        }
        }
        """
    )
  }

  func testFunctionWithoutNameOrArguments() {
    assertParse(
      "func 1️⃣{}",
      diagnostics: [
        DiagnosticSpec(
          message: "expected identifier and function signature in function",
          fixIts: ["insert identifier and function signature"]
        )
      ],
      fixedSource: """
        func <#identifier#>() {}
        """
    )
  }

  func testMacroExpansionDeclaration() {
    assertParse(
      """
      struct X {
        #memberwiseInit(access: .public)
      }
      """
    )
    assertParse(
      """
      #expand
      """,
      substructure: SourceFileSyntax(
        CodeBlockItemListSyntax {
          MacroExpansionDeclSyntax(macroName: "expand") {}
        }
      )
    )
  }

  func testMacroExpansionDeclarationWithKeywordName() {
    assertParse(
      """
      struct X {
        #case
      }
      """,
      substructure: MacroExpansionDeclSyntax(
        pound: .poundToken(),
        macroName: .identifier("case"),
        arguments: LabeledExprListSyntax([])
      )
    )
  }

  func testAttributedMacroExpansionDeclaration() {
    assertParse(
      """
      @attribute #topLevelWithAttr
      """,
      substructure: MacroExpansionDeclSyntax(
        attributes: [.attribute(AttributeSyntax(attributeName: TypeSyntax("attribute")))],
        macroName: "topLevelWithAttr",
        arguments: []
      )
    )

    assertParse(
      """
      public #topLevelWithModifier
      """,
      substructure: MacroExpansionDeclSyntax(
        modifiers: [DeclModifierSyntax(name: .keyword(.public))],
        macroName: "topLevelWithModifier",
        arguments: []
      )
    )

    assertParse(
      """
      #topLevelBare
      """,
      substructure: MacroExpansionExprSyntax(
        macroName: "topLevelBare",
        arguments: []
      )
    )

    assertParse(
      """
      struct S {
        @attribute #memberWithAttr
      }
      """,
      substructure: MacroExpansionDeclSyntax(
        attributes: [.attribute(AttributeSyntax(attributeName: TypeSyntax("attribute")))],
        macroName: "memberWithAttr",
        arguments: []
      )
    )

    assertParse(
      """
      struct S {
        public #memberWithModifier
      }
      """,
      substructure: MacroExpansionDeclSyntax(
        modifiers: [DeclModifierSyntax(name: .keyword(.public))],
        macroName: "memberWithModifier",
        arguments: []
      )
    )

    assertParse(
      """
      struct S {
        #memberBare
      }
      """,
      substructure: MacroExpansionDeclSyntax(
        macroName: "memberBare",
        arguments: []
      )
    )

    assertParse(
      """
      func test() {
        @attribute #bodyWithAttr
      }
      """,
      substructure: MacroExpansionDeclSyntax(
        attributes: [.attribute(AttributeSyntax(attributeName: TypeSyntax("attribute")))],
        macroName: "bodyWithAttr",
        arguments: []
      )
    )

    assertParse(
      """
      func test() {
        public #bodyWithModifier
      }
      """,
      substructure: MacroExpansionDeclSyntax(
        modifiers: [DeclModifierSyntax(name: .keyword(.public))],
        macroName: "bodyWithModifier",
        arguments: []

      )
    )

    assertParse(
      """
      func test() {
        #bodyBare
      }
      """,
      substructure: MacroExpansionExprSyntax(
        macroName: "bodyBare",
        arguments: []
      )
    )

    assertParse(
      """
      func test() {
        @attrib1
        @attrib2
        public
        #declMacro
      }
      """,
      substructure: MacroExpansionDeclSyntax(
        attributes: [
          .attribute(AttributeSyntax(attributeName: TypeSyntax("attrib1"))),
          .attribute(AttributeSyntax(attributeName: TypeSyntax("attrib2"))),
        ],
        modifiers: [DeclModifierSyntax(name: .keyword(.public))],
        macroName: "declMacro",
        arguments: []
      )
    )

    assertParse(
      """
      struct S {
        @attrib #class
      }
      """,
      substructure: MacroExpansionDeclSyntax(
        attributes: [.attribute(AttributeSyntax(attributeName: TypeSyntax("attrib")))],
        pound: .poundToken(),
        macroName: .identifier("class"),
        arguments: []
      )
    )

    assertParse(
      """
      struct S {
        #struct
      }
      """,
      substructure: MacroExpansionDeclSyntax(
        pound: .poundToken(),
        macroName: .identifier("struct"),
        arguments: []
      )
    )
  }

  func testWhitespaceBetweenPoundAndMacroName() {
    assertParse(
      """
      #1️⃣ myMacroName
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous whitespace after '#' is not permitted", fixIts: ["remove whitespace"])
      ],
      fixedSource: """
        #myMacroName
        """
    )

    assertParse(
      """
      #1️⃣ /*comment*/ myMacroName
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous whitespace after '#' is not permitted", fixIts: ["remove whitespace"])
      ],
      fixedSource: """
        #myMacroName
        """
    )

    assertParse(
      """
      #1️⃣
      myMacroName
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in macro expansion", fixIts: ["insert identifier"])
      ],
      fixedSource: """
        #<#identifier#>
        myMacroName
        """
    )

    assertParse(
      """
      struct Foo {
        #1️⃣ myMacroName
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous whitespace after '#' is not permitted", fixIts: ["remove whitespace"])
      ],
      fixedSource: """
        struct Foo {
          #myMacroName
        }
        """
    )

    assertParse(
      """
      struct Foo {
        #1️⃣
        2️⃣myMacroName
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected identifier in macro expansion",
          fixIts: ["insert identifier"]
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code 'myMacroName' in struct"),
      ],
      fixedSource: """
        struct Foo {
          #<#identifier#>
          myMacroName
        }
        """
    )
  }

  func testVariableDeclWithGetSetButNoBrace() {
    assertParse(
      """
      struct Foo {
        var x: Int 1️⃣
          get {
            4
          }
          set {
            x = newValue
          }
        }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '{' in variable", fixIts: ["insert '{'"])
      ],
      fixedSource: """
        struct Foo {
          var x: Int {
            get {
              4
            }
            set {
              x = newValue
            }
          }
        }
        """
    )
  }

  func testVariableDeclWithSetGetButNoBrace() {
    assertParse(
      """
      struct Foo {
        var x: Int 1️⃣
          set {
            x = newValue
          }
          get {
            4
          }
        }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '{' in variable", fixIts: ["insert '{'"])
      ],
      fixedSource: """
        struct Foo {
          var x: Int {
            set {
              x = newValue
            }
            get {
              4
            }
          }
        }
        """
    )
  }

  func testVariableGetSetNextLine() {
    assertParse(
      """
      struct X {
        var x: Int
        { 17 }
      }
      """
    )
  }

  func testVariableFollowedByReferenceToSet() {
    assertParse(
      """
      func bar() {
          let a = b
          set.c
      }
      """
    )
  }

  func testNominalDeclarationRecovery() {
    assertParse(
      "protocol 1️⃣{}",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in protocol", fixIts: ["insert identifier"])
      ],
      fixedSource: """
        protocol <#identifier#> {}
        """
    )
    assertParse(
      "class 1️⃣{}",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in class", fixIts: ["insert identifier"])
      ],
      fixedSource: """
        class <#identifier#> {}
        """
    )
    assertParse(
      "struct 1️⃣{}",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in struct", fixIts: ["insert identifier"])
      ],
      fixedSource: """
        struct <#identifier#> {}
        """
    )
    assertParse(
      "enum 1️⃣{}",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in enum", fixIts: ["insert identifier"])
      ],
      fixedSource: """
        enum <#identifier#> {}
        """
    )
    // `actor` cannot recover from a missing identifier since it's contextual
    // based on the presence of the identifier.
  }

  func testDontNestClassesIfTheyContainUnexpectedTokens() {
    // There used to be a bug where `class B` was parsed as a nested class of A
    // because recovery to the `class` keyword of B consumed the closing brace.
    assertParse(
      """
      class A {
        1️⃣^
      }
      class B {
      }
      """,
      substructure: CodeBlockItemListSyntax([
        CodeBlockItemSyntax(
          item: .init(
            ClassDeclSyntax(
              classKeyword: .keyword(.class),
              name: .identifier("A"),
              memberBlock: MemberBlockSyntax(
                leftBrace: .leftBraceToken(),
                members: MemberBlockItemListSyntax(),
                UnexpectedNodesSyntax([TokenSyntax.binaryOperator("^")]),
                rightBrace: .rightBraceToken()
              )
            )
          )
        ),
        CodeBlockItemSyntax(
          item: .init(
            ClassDeclSyntax(
              classKeyword: .keyword(.class),
              name: .identifier("B"),
              memberBlock: MemberBlockSyntax(
                leftBrace: .leftBraceToken(),
                members: MemberBlockItemListSyntax(),
                rightBrace: .rightBraceToken()
              )
            )
          )
        ),
      ]
      ),
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code '^' in class")
      ]
    )
  }

  func testIssue1025() {
    assertParse(
      """
      struct Math {
        public static let pi = 3.14
        @available(*, unavailable) init() {}
      }
      """
    )

    assertParse("func foo(body: (isolated String) -> Int) {}")
  }

  func testMacroDecl() {
    assertParse(
      """
      macro m11️⃣: Int = A.M1
      macro m2(_: Int) = A.M2
      macro m3(a b: Int) -> Int = A.M3
      macro m4<T>2️⃣: T = A.M4 where T.Assoc: P
      macro m5<T: P>(_: T)
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected parameter clause in function signature",
          fixIts: ["insert parameter clause"]
        ),
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code ': Int = A.M1' before macro"),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected parameter clause in function signature",
          fixIts: ["insert parameter clause"]
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code ': T = A.M4 where T.Assoc: P' before macro"),
      ],
      fixedSource: """
        macro m1(): Int = A.M1
        macro m2(_: Int) = A.M2
        macro m3(a b: Int) -> Int = A.M3
        macro m4<T>(): T = A.M4 where T.Assoc: P
        macro m5<T: P>(_: T)
        """
    )

    assertParse(
      """
      macro m11️⃣ = A
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected parameter clause in function signature",
          fixIts: ["insert parameter clause"]
        )
      ],
      fixedSource: """
        macro m1() = A
        """
    )
  }

  func testPrimaryAssociatedTypeNotTerminatedWithAngleBracket() {
    assertParse(
      "protocol1️⃣<2️⃣:3️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected identifier in protocol", fixIts: ["insert identifier"]),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected name and '>' to end primary associated type clause",
          fixIts: ["insert name and '>'"]
        ),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected type in inherited type", fixIts: ["insert type"]),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "expected member block in protocol",
          fixIts: ["insert member block"]
        ),
      ],
      fixedSource: """
        protocol <#identifier#><<#identifier#>>: <#type#> {
        }
        """
    )
  }

  func testClassWithPrivateSet() {
    assertParse(
      """
      struct Properties {
        class private(set) var privateSetterCustomNames: Bool
      }
      """
    )
  }

  func testEditorPlaceholderInMemberDeclList() {
    assertParse(
      """
      class Foo {
        1️⃣<#code#>
      }
      """,
      substructure: MemberBlockItemSyntax(decl: MissingDeclSyntax(placeholder: .identifier("<#code#>"))),
      diagnostics: [
        DiagnosticSpec(message: "editor placeholder in source file")
      ]
    )
  }

  func testAttributeInPoundIf() {
    assertParse(
      """
      #if hasAttribute(foo)
      @foo
      #endif
      struct MyStruct {}
      """
    )
  }

  func testMissingExpressionInVariableAssignment() {
    assertParse(
      """
      let a =1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression in variable", fixIts: ["insert expression"])
      ],
      fixedSource: """
        let a = <#expression#>
        """
    )
  }

  func testCallToOpenThatLooksLikeDeclarationModifier() {
    assertParse(
      """
      func test() {
        open(set)
        var foo = 2
      }
      """,
      substructure: FunctionCallExprSyntax(
        calledExpression: DeclReferenceExprSyntax(baseName: .identifier("open")),
        leftParen: .leftParenToken(),
        arguments: LabeledExprListSyntax([
          LabeledExprSyntax(
            expression: DeclReferenceExprSyntax(baseName: .identifier("set"))
          )
        ]),
        rightParen: .rightParenToken()
      )
    )
  }

  func testReferenceToOpenThatLooksLikeDeclarationModifier() {
    // Ideally, this should be parsed as an identifier expression to 'open',
    // followed by a variable declaration but the current behavior matches the C++ parser.
    assertParse(
      """
      func test() {
        open
        var foo = 2
      }
      """,
      substructure: VariableDeclSyntax(
        modifiers: DeclModifierListSyntax([
          DeclModifierSyntax(name: .keyword(.open))
        ]),
        bindingSpecifier: .keyword(.var),
        bindings: PatternBindingListSyntax([
          PatternBindingSyntax(
            pattern: IdentifierPatternSyntax(identifier: .identifier("foo")),
            initializer: InitializerClauseSyntax(
              value: IntegerLiteralExprSyntax(literal: .integerLiteral("2"))
            )
          )
        ])
      )
    )
  }

  func testOpenVarInCodeBlockItemList() {
    assertParse(
      """
      func test() {
        open var foo = 2
      }
      """,
      substructure: DeclModifierSyntax(name: .keyword(.open))
    )
  }

  func testAsyncLetInLocalContext() {
    assertParse(
      """
      func foo() async {
        async let x: String = "x"
      }
      """
    )
  }

  func testBorrowingConsumingParameterSpecifiers() {
    assertParse("struct borrowing {}")
    assertParse("struct consuming {}")

    assertParse("struct Foo {}")

    assertParse("func foo(x: borrowing Foo) {}")
    assertParse("func bar(x: consuming Foo) {}")
    assertParse("func baz(x: (borrowing Foo, consuming Foo) -> ()) {}")

    // `borrowing` and `consuming` are contextual keywords, so they should also
    // continue working as type and/or parameter names

    assertParse("func zim(x: borrowing) {}")
    assertParse("func zang(x: consuming) {}")
    assertParse("func zung(x: borrowing consuming) {}")
    assertParse("func zip(x: consuming borrowing) {}")
    assertParse("func zap(x: (borrowing, consuming) -> ()) {}")
    assertParse("func zoop(x: (borrowing consuming, consuming borrowing) -> ()) {}")

    // Parameter specifier names are regular identifiers in other positions,
    // including argument labels.

    assertParse("func argumentLabelOnly(borrowing: Int) {}")
    assertParse("func argumentLabelOnly(consuming: Int) {}")
    assertParse("func argumentLabelOnly(__shared: Int) {}")
    assertParse("func argumentLabelOnly(__owned: Int) {}")

    assertParse("func argumentLabel(borrowing consuming: Int) {}")
    assertParse("func argumentLabel(consuming borrowing: Int) {}")
    assertParse("func argumentLabel(__shared __owned: Int) {}")
    assertParse("func argumentLabel(__owned __shared: Int) {}")

    // We should parse them as argument labels in function types, even though that
    // isn't currently supported.

    assertParse("func argumentLabel(anonBorrowingInClosure: (_ borrowing: Int) -> ()) {}")
    assertParse("func argumentLabel(anonConsumingInClosure: (_ consuming: Int) -> ()) {}")
    assertParse("func argumentLabel(anonSharedInClosure: (_ __shared: Int) -> ()) {}")
    assertParse("func argumentLabel(anonOwnedInClosure: (_ __owned: Int) -> ()) {}")
  }

  func testMisplaceSpecifierInTupleTypeBody() {
    assertParse(
      "func test(a: (1️⃣borrowing F2️⃣ o))",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code 'borrowing' in tuple type"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ',' in tuple type", fixIts: ["insert ','"]),
      ],
      fixedSource: "func test(a: (borrowing F, o))"
    )
  }

  func testWhereClauseWithFunctionType() {
    // A function type in the where clause isn't semantically valid but its fine
    // with the parser. Make sure we don't recover to the arrow to parse the
    // function return type.
    assertParse(
      """
      func badTypeConformance3<T>(_: T) where (T) -> () : EqualComparable { }
      """
    )
  }

  func testSuppressedImplicitConformance() {
    assertParse(
      """
      struct Hello: ~Copyable {}
      """,
      substructure: InheritedTypeSyntax(
        type: SuppressedTypeSyntax(
          withoutTilde: .prefixOperator("~"),
          type: TypeSyntax(stringLiteral: "Copyable")
        )
      )
    )

    assertParse(
      """
      let _: any ~Copyable = 0
      """,
      substructure: SomeOrAnyTypeSyntax(
        someOrAnySpecifier: .keyword(.any),
        constraint: SuppressedTypeSyntax(
          withoutTilde: .prefixOperator("~"),
          type: TypeSyntax(stringLiteral: "Copyable")
        )
      )
    )

    assertParse(
      """
      typealias Z = ~Copyable.Type
      """,
      substructure: SuppressedTypeSyntax(
        withoutTilde: .prefixOperator("~"),
        type: MetatypeTypeSyntax(
          baseType: TypeSyntax(stringLiteral: "Copyable"),
          metatypeSpecifier: .keyword(.Type)
        )
      )
    )

    assertParse(
      """
      typealias Z = ~A.B.C
      """,
      substructure: SuppressedTypeSyntax(
        withoutTilde: .prefixOperator("~"),
        type: MemberTypeSyntax(
          baseType: MemberTypeSyntax(
            baseType: TypeSyntax(stringLiteral: "A"),
            name: .identifier("B")
          ),
          name: .identifier("C")
        )
      )
    )

    assertParse(
      """
      typealias Z = ~A?
      """,
      substructure: SuppressedTypeSyntax(
        withoutTilde: .prefixOperator("~"),
        type: OptionalTypeSyntax(
          wrappedType: IdentifierTypeSyntax(name: .identifier("A"))
        )
      )
    )

    assertParse(
      """
      typealias Z = ~A<T>
      """,
      substructure: SuppressedTypeSyntax(
        withoutTilde: .prefixOperator("~"),
        type: IdentifierTypeSyntax(
          name: .identifier("A"),
          genericArgumentClause: GenericArgumentClauseSyntax(
            arguments: GenericArgumentListSyntax([
              GenericArgumentSyntax(
                argument: .type(TypeSyntax(IdentifierTypeSyntax(name: .identifier("T"))))
              )
            ])
          )
        )
      )
    )

    assertParse(
      """
      struct Hello<T: ~Copyable> {}
      """,
      substructure: GenericParameterListSyntax([
        GenericParameterSyntax(
          attributes: AttributeListSyntax([]),
          name: .identifier("T"),
          colon: .colonToken(),
          inheritedType: SuppressedTypeSyntax(
            withoutTilde: .prefixOperator("~"),
            type: TypeSyntax(stringLiteral: "Copyable")
          )
        )
      ])
    )

    assertParse(
      """
      func henlo<T: ~Copyable>(_ t: T) {}
      """,
      substructure: GenericParameterListSyntax([
        GenericParameterSyntax(
          attributes: AttributeListSyntax([]),
          name: .identifier("T"),
          colon: .colonToken(),
          inheritedType: SuppressedTypeSyntax(
            withoutTilde: .prefixOperator("~"),
            type: TypeSyntax(stringLiteral: "Copyable")
          )
        )
      ])
    )

    assertParse(
      """
      enum Whatever: Int, ~ Hashable, Equatable {}
      """,
      substructure: InheritanceClauseSyntax(
        colon: .colonToken(),
        inheritedTypes: InheritedTypeListSyntax([
          InheritedTypeSyntax(
            type: TypeSyntax(stringLiteral: "Int"),
            trailingComma: .commaToken()
          ),
          InheritedTypeSyntax(
            type: SuppressedTypeSyntax(
              withoutTilde: .prefixOperator("~"),
              type: TypeSyntax(stringLiteral: "Hashable")
            ),
            trailingComma: .commaToken()
          ),
          InheritedTypeSyntax(type: TypeSyntax(stringLiteral: "Equatable")),
        ])
      )
    )

    assertParse(
      """
      typealias T = 1️⃣~Int2️⃣ -> Bool
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected '(' to start function type",
          fixIts: ["insert '('"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected ')' in function type",
          fixIts: ["insert ')'"]
        ),
      ],
      fixedSource: """
        typealias T = (~Int) -> Bool
        """
    )

    assertParse(
      """
      typealias T = (~Int) -> Bool
      """,
      substructure: FunctionTypeSyntax(
        parameters: [
          TupleTypeElementSyntax(
            type: SuppressedTypeSyntax(
              withoutTilde: .prefixOperator("~"),
              type: IdentifierTypeSyntax(name: .identifier("Int"))
            )
          )
        ],
        returnClause: ReturnClauseSyntax(type: TypeSyntax("Bool"))
      )
    )
  }

  func testDoubleRightAngle() {
    assertParse(
      "func foo<A>1️⃣> test()",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '> test' before parameter clause")
      ]
    )
  }

  func testUnexpectedTokenInClassFollowedByUnownedModifier() {
    assertParse(
      """
      class A ℹ️{
        1️⃣^
      }
      unowned 2️⃣B {
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code before modifier"),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected declaration and '}' after 'unowned' modifier",
          fixIts: ["insert declaration and '}'"]
        ),
      ],
      fixedSource:
        """
        class A {
          ^
        }
        unowned <#declaration#>
        }B {
        }
        """
    )
  }

  func testEmptyPrimaryAssociatedType() {
    assertParse(
      "protocol X<1️⃣> {}",
      diagnostics: [
        DiagnosticSpec(message: "expected name in primary associated type clause", fixIts: ["insert name"])
      ],
      fixedSource: "protocol X<<#identifier#>> {}"
    )
  }

  func testCorrectIndentationWithNewline() {
    assertParse(
      """
      func
        test() {}1️⃣ var other: Int
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        )
      ],
      fixedSource: """
        func
          test() {}
        var other: Int
        """
    )
  }

  func testMissingEqualInVariableDeclaration() {
    assertParse(
      "let foo: [Int] 1️⃣[]",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '=' in variable", fixIts: ["insert '='"])
      ],
      fixedSource: "let foo: [Int] = []"
    )
  }

  func testInitAccessorsWithDefaultValues() {
    assertParse(
      """
      struct Test {
        var pair: (Int, Int) = (42, 0) {
          init(initialValue) {}

          get { (0, 42) }
          set { }
        }
      }
      """
    )

    assertParse(
      """
      struct Test {
        var pair: (Int, Int) = (42, 0) {
          get { (0, 42) }
          set { }

          init(initialValue1️⃣) {}
        }
      }
      """,
      substructure: InitializerDeclSyntax(
        initKeyword: .keyword(.`init`),
        signature: FunctionSignatureSyntax(
          parameterClause: FunctionParameterClauseSyntax(
            leftParen: .leftParenToken(),
            parameters: FunctionParameterListSyntax([
              FunctionParameterSyntax(
                firstName: .identifier("initialValue"),
                colon: .colonToken(presence: .missing),
                type: TypeSyntax(MissingTypeSyntax(placeholder: .identifier("<#type#>", presence: .missing)))
              )
            ]),
            rightParen: .rightParenToken(trailingTrivia: .space)
          )
        ),
        body: CodeBlockSyntax(
          leftBrace: .leftBraceToken(),
          statements: CodeBlockItemListSyntax([]),
          rightBrace: .rightBraceToken()
        )
      ),
      diagnostics: [
        DiagnosticSpec(message: "expected ':' and type in parameter", fixIts: ["insert ':' and type"])
      ],
      fixedSource:
        """
        struct Test {
          var pair: (Int, Int) = (42, 0) {
            get { (0, 42) }
            set { }

            init(initialValue: <#type#>) {}
          }
        }
        """
    )
  }

  func testBorrowingGetAccessor() {
    assertParse(
      """
      struct Foo {
        var x: Int {
          borrowing get {}
        }
      }
      """
    )
  }

  func testDeclarationsWithPlaceholders() {
    assertParse(
      """
      func 1️⃣<#name#>(2️⃣<#parameters#>3️⃣) -> 4️⃣<#return type#> {
          5️⃣<#function body#>
      }
      """,
      substructure: FunctionDeclSyntax(
        funcKeyword: .keyword(.func),
        name: .identifier("<#name#>"),
        signature: FunctionSignatureSyntax(
          parameterClause: FunctionParameterClauseSyntax(
            parameters: FunctionParameterListSyntax([
              FunctionParameterSyntax(
                firstName: .identifier("<#parameters#>"),
                colon: .colonToken(presence: .missing),
                type: MissingTypeSyntax(
                  placeholder: .identifier("<#type#>", presence: .missing)
                )
              )
            ])
          ),
          returnClause: ReturnClauseSyntax(
            type: IdentifierTypeSyntax(
              name: .identifier("<#return type#>")
            )
          )
        ),
        body: CodeBlockSyntax(
          statements: CodeBlockItemListSyntax([
            CodeBlockItemSyntax(
              item: .expr(
                ExprSyntax(
                  DeclReferenceExprSyntax(
                    baseName: .identifier("<#function body#>")
                  )
                )
              )
            )
          ])
        )
      ),
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "editor placeholder in source file"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "editor placeholder in source file"),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "expected ':' and type in parameter",
          fixIts: ["insert ':' and type"]
        ),
        DiagnosticSpec(locationMarker: "4️⃣", message: "editor placeholder in source file"),
        DiagnosticSpec(locationMarker: "5️⃣", message: "editor placeholder in source file"),
      ],
      fixedSource: """
        func <#name#>(<#parameters#>: <#type#>) -> <#return type#> {
            <#function body#>
        }
        """
    )

    assertParse(
      """
      func test1️⃣<#name#>() {
          2️⃣<#function body#>
      }
      """,
      substructure: FunctionDeclSyntax(
        funcKeyword: .keyword(.func),
        name: .identifier("test"),
        UnexpectedNodesSyntax([TokenSyntax.identifier("<#name#>")]),
        signature: FunctionSignatureSyntax(
          parameterClause: FunctionParameterClauseSyntax(
            parameters: FunctionParameterListSyntax([])
          )
        ),
        body: CodeBlockSyntax(
          statements: CodeBlockItemListSyntax([
            CodeBlockItemSyntax(
              item: .expr(
                ExprSyntax(
                  DeclReferenceExprSyntax(
                    baseName: .identifier("<#function body#>")
                  )
                )
              )
            )
          ])
        )
      ),
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code '<#name#>' in function"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "editor placeholder in source file"),
      ]
    )

    assertParse(
      """
      class 1️⃣<#name#>: 2️⃣<#super class#> {
          3️⃣<#code#>
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "editor placeholder in source file"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "editor placeholder in source file"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "editor placeholder in source file"),
      ]
    )

    assertParse(
      """
      enum 1️⃣<#name#> {
          case 2️⃣<#code#>
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "editor placeholder in source file"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "editor placeholder in source file"),
      ]
    )

    assertParse(
      """
      struct 1️⃣<#name#> {
          2️⃣<#code#>
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "editor placeholder in source file"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "editor placeholder in source file"),
      ]
    )

    assertParse(
      """
      protocol 1️⃣<#name#> {
          2️⃣<#code#>
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "editor placeholder in source file"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "editor placeholder in source file"),
      ]
    )

    assertParse(
      """
      import 1️⃣<#name#>
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "editor placeholder in source file")
      ]
    )

    assertParse(
      """
      typealias 1️⃣<#name#> = 2️⃣<#code#>
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "editor placeholder in source file"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "editor placeholder in source file"),
      ]
    )
  }

  // https://github.com/swiftlang/swift-syntax/issues/2273
  func testEnumCaseWithGenericParameter() {
    assertParse(
      """
      enum Foo {
        case foo1️⃣<T>(T)
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "generic signature cannot be declared in enum 'case'"
        )
      ]
    )

    assertParse(
      """
      enum Foo {
        case bar1️⃣<T>(param: T)
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "generic signature cannot be declared in enum 'case'"
        )
      ]
    )

    assertParse(
      """
      enum Foo {
        case baz1️⃣<T>
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "generic signature cannot be declared in enum 'case'"
        )
      ]
    )

    assertParse(
      """
      enum Foo {
        case one, two1️⃣<T>
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "generic signature cannot be declared in enum 'case'"
        )
      ]
    )

    assertParse(
      """
      enum Foo {
        case three1️⃣<T>, four
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "generic signature cannot be declared in enum 'case'"
        )
      ]
    )

    assertParse(
      """
      enum Foo {
        case five1️⃣<T>(param: T), six
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "generic signature cannot be declared in enum 'case'"
        )
      ]
    )

    assertParse(
      """
      enum Foo {
        case seven1️⃣<T>, eight2️⃣<U>
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "generic signature cannot be declared in enum 'case'"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "generic signature cannot be declared in enum 'case'"
        ),
      ]
    )

    assertParse(
      """
      enum Foo<T> {
        case five(param: T), six
      }
      """
    )
  }

  func testLiteralInitializerWithTrailingClosure() {
    assertParse(
      "let foo = 1 { return 1 }",
      substructure: AccessorBlockSyntax(accessors: .getter([CodeBlockItemSyntax("return 1")]))
    )
  }

  func testDeclarationEndingWithNewline() {
    let inputs: [UInt: String] = [
      #line: "var x = 0\n",
      #line: "var x = 0 garbage\n",
      #line: "var x = 0 \n",
    ]

    for (line, input) in inputs {
      let decl = DeclSyntax(stringLiteral: input)
      XCTAssertEqual(decl.description, input, line: line)
    }
  }

  func testInitializerWithReturnType() {
    assertParse(
      "init(_ ptr: UnsafeRawBufferPointer, _ a: borrowing Array<Int>) -> dependsOn(a) Self",
      experimentalFeatures: .nonescapableTypes
    )

    // Not actually valid, needs to be diagnosed during type checking
    assertParse("public init() -> Int")
  }

  func testSendingTypeSpecifier() {
    assertParse("func testVarDeclTupleElt() -> (sending String, String) {}")
    assertParse("func testVarDeclTuple2(_ x: (sending String)) {}")
    assertParse("func testVarDeclTuple2(_ x: (sending String, String)) {}")
  }

  func testMisplacedAttributeInVarDeclWithMultipleBindings() {
    assertParse(
      """
      let a = "a", 1️⃣@foo b = "b"
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "misplaced attribute in variable declaration",
          fixIts: ["move attributes in front of 'let'"]
        )
      ],
      fixedSource: """
        @foo let a = "a", b = "b"
        """
    )
  }

  func testConstAsArgumentLabel() {
    assertParse(
      "func const(_const: String) {}",
      substructure: FunctionParameterSyntax(
        firstName: .identifier("_const"),
        colon: .colonToken(),
        type: TypeSyntax(IdentifierTypeSyntax(name: .identifier("String")))
      )
    )

    assertParse(
      "func const(_const map: String) {}",
      substructure: FunctionParameterSyntax(
        firstName: .identifier("_const"),
        secondName: .identifier("map"),
        colon: .colonToken(),
        type: TypeSyntax(IdentifierTypeSyntax(name: .identifier("String")))
      )
    )

    assertParse(
      "func const(_const x y: String) {}",
      substructure: FunctionParameterSyntax(
        modifiers: [DeclModifierSyntax(name: .keyword(._const))],
        firstName: .identifier("x"),
        secondName: .identifier("y"),
        colon: .colonToken(),
        type: TypeSyntax(IdentifierTypeSyntax(name: .identifier("String")))
      )
    )
  }

  func testCoroutineAccessors() {
    assertParse(
      """
      var irm: Int {
        read {
          yield _i
        }
        modify {
          yield &_i
        }
      }
      """,
      experimentalFeatures: .coroutineAccessors
    )
    assertParse(
      """
      public var i: Int {
        _read {
          yield _i
        }
        read {
          yield _i
        }
        _modify {
          yield &_i
        }
        modify {
          yield &_i
        }
      }
      """,
      experimentalFeatures: .coroutineAccessors
    )
    assertParse(
      """
      var i_rm: Int {
        _read {
          yield _i
        }
        1️⃣modify {
          yield &_i
        }
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected code in variable"
        )
      ]
    )
    assertParse(
      """
      var ir_m: Int {
        _modify {
          yield &_i
        }
        1️⃣read {
          yield _i
        }
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected code in variable"
        )
      ]
    )
  }

  func testMissingCommaInParameters() {
    assertParse(
      "func a(foo: Bar1️⃣ foo2: Bar2) {}",
      diagnostics: [
        DiagnosticSpec(
          message: "expected ',' in parameter",
          fixIts: ["insert ','"]
        )
      ],
      fixedSource: "func a(foo: Bar, foo2: Bar2) {}"
    )
  }

  func testMissingMultipleCommasInParameters() {
    assertParse(
      "func a(foo: Bar1️⃣ foo2: Bar2, foo3: Bar32️⃣ foo4: Bar4) {}",
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected ',' in parameter",
          fixIts: ["insert ','"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected ',' in parameter",
          fixIts: ["insert ','"]
        ),
      ],
      fixedSource: "func a(foo: Bar, foo2: Bar2, foo3: Bar3, foo4: Bar4) {}"
    )
  }

  func testMissingCommaInParametersAndAttributes() {
    assertParse(
      "func a(foo: Bar1️⃣ @escaping foo1: () -> Void) {}",
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected ',' in parameter",
          fixIts: ["insert ','"]
        )
      ],
      fixedSource: "func a(foo: Bar, @escaping foo1: () -> Void) {}"
    )
  }

  func testMissingCommaInParametersWithNewline() {
    assertParse(
      """
      func foo(a: Int1️⃣
      x: Int = 2
      ) {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected ',' in parameter",
          fixIts: ["insert ','"]
        )
      ],
      fixedSource:
        """
        func foo(a: Int,
        x: Int = 2
        ) {}
        """
    )
  }

  func testMissingCommaWithgarbageCode() {
    assertParse(
      "func foo(x: Int 1️⃣Int<@abc)",
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'Int<@abc' in parameter clause"
        )
      ]
    )
  }

  func testTrailingCommas() {
    assertParse(
      """
      protocol Baaz<
        Foo,
        Bar,
      > {
        associatedtype Foo
        associatedtype Bar
      }
      """
    )

    assertParse(
      """
      struct Foo<
        T1,
        T2,
        T3,
      >: Baaz<
        T1,
        T2,
      > {}
      """
    )
  }
}

final class UsingDeclarationTests: ParserTestCase {
  override var experimentalFeatures: Parser.ExperimentalFeatures {
    [.defaultIsolationPerFile]
  }

  func testUsing() {
    assertParse(
      "using @MainActor",
      substructure: UsingDeclSyntax(
        usingKeyword: .keyword(.using),
        specifier: .attribute(
          AttributeSyntax(
            attributeName: IdentifierTypeSyntax(
              name: .identifier("MainActor")
            )
          )
        )
      )
    )
    assertParse(
      "using nonisolated",
      substructure: UsingDeclSyntax(
        usingKeyword: .keyword(.using),
        specifier: .modifier(.identifier("nonisolated"))
      )
    )

    assertParse(
      "using @Test",
      substructure: UsingDeclSyntax(
        usingKeyword: .keyword(.using),
        specifier: .attribute(
          AttributeSyntax(
            attributeName: IdentifierTypeSyntax(
              name: .identifier("Test")
            )
          )
        )
      )
    )

    assertParse(
      "using test",
      substructure: UsingDeclSyntax(
        usingKeyword: .keyword(.using),
        specifier: .modifier(.identifier("test"))
      )
    )

    assertParse(
      """
      nonisolated
      using
      """,
      substructure: CodeBlockSyntax(
        DeclReferenceExprSyntax(baseName: .identifier("using"))
      )
    )

    assertParse(
      """
      @MainActor
      using
      """,
      substructure: CodeBlockSyntax(
        DeclReferenceExprSyntax(baseName: .identifier("using"))
      )
    )

    assertParse(
      """
      using
      @MainActor 1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected declaration after attribute",
          fixIts: ["insert declaration"]
        )
      ],
      fixedSource:
        """
        using
        @MainActor <#declaration#>
        """
    )

    assertParse(
      """
      using
      nonisolated
      """,
      substructure: CodeBlockSyntax(
        DeclReferenceExprSyntax(baseName: .identifier("using"))
      )
    )

    assertParse(
      """
      func
      using (x: Int) {}
      """
    )

    assertParse(
      """
      func
      using
      (x: Int) {}
      """
    )

    assertParse(
      """
      let
        using = 42
      """
    )

    assertParse("let (x: Int, using: String) = (x: 42, using: \"\")")

    assertParse(
      """
      do {
        using @MainActor
      }
      """
    )
  }
}
