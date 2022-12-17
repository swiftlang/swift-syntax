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
@_spi(Testing)@_spi(RawSyntax) import SwiftParser
import SwiftSyntaxBuilder
import SwiftBasicFormat
import XCTest

final class DeclarationTests: XCTestCase {
  func testImports() {
    AssertParse("import Foundation")

    AssertParse("@_spi(Private) import SwiftUI")

    AssertParse("@_exported import class Foundation.Thread")

    AssertParse(#"@_private(sourceFile: "YetAnotherFile.swift") import Foundation"#)
  }
  func testStructParsing() {
    AssertParse("struct Foo {}")
  }

  func testFuncParsing() {
    AssertParse("func foo() {}")

    AssertParse("func foo() -> Slice<MinimalMutableCollection<T>> {}")

    AssertParse(
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

    AssertParse(
      """
      func 1️⃣where2️⃣
      r3️⃣
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "keyword 'where' cannot be used as an identifier here", fixIts: ["if this name is unavoidable, use backticks to escape it"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '(' to start parameter clause", fixIts: ["insert '('"]),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected ')' to end parameter clause", fixIts: ["insert ')'"]),
      ],
      fixedSource: """
        func `where`(
        r)
        """
    )

    AssertParse("func /^/ (lhs: Int, rhs: Int) -> Int { 1 / 2 }")

    AssertParse(
      "func 1️⃣/^notoperator^/ (lhs: Int, rhs: Int) -> Int { 1 / 2 }",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in function"),
        DiagnosticSpec(message: "unexpected code '/^notoperator^/' before parameter clause"),
      ]
    )

    AssertParse("func /^ (lhs: Int, rhs: Int) -> Int { 1 / 2 }")

    AssertParse(
      """
      func name(_ default: Int) {}
      """,
      substructure: Syntax(
        FunctionParameterSyntax(
          firstName: .wildcardKeyword(),
          secondName: .identifier("default"),
          colon: .colonToken(),
          type: SimpleTypeIdentifierSyntax(name: .identifier("Int"))
        )
      )
    )
  }

  func testFuncAfterUnbalancedClosingBrace() {
    AssertParse(
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
    AssertParse("class Foo {}")

    AssertParse(
      """
      @dynamicMemberLookup @available(swift 4.0)
      public class MyClass {
        let A: Int
        let B: Double
      }
      """
    )

    AssertParse(
      "<@NSApplicationMain T: AnyObject>",
      { GenericParameterClauseSyntax.parse(from: &$0) }
    )

    AssertParse(
      "class T where t1️⃣",
      diagnostics: [
        DiagnosticSpec(message: "expected '=' and right-hand type in same type requirement"),
        DiagnosticSpec(message: "expected member block in class"),
      ]
    )
    AssertParse(
      "class B<where g1️⃣",
      diagnostics: [
        DiagnosticSpec(message: "expected '=' and right-hand type in same type requirement"),
        DiagnosticSpec(message: "expected '>' to end generic parameter clause"),
        DiagnosticSpec(message: "expected member block in class"),
      ]
    )
  }

  func testActorParsing() {
    AssertParse("actor Foo {}")

    AssertParse(
      """
      actor Foo {
        nonisolated init?() {
          for (x, y, z) in self.triples {
            assert(isSafe)
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
    AssertParse(
      """
      1️⃣}
      actor Foo {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected brace before actor")
      ]
    )
  }

  func testProtocolParsing() {
    AssertParse("protocol Foo {}")

    AssertParse("protocol P { init() }")

    AssertParse(
      """
      protocol P {
        associatedtype Foo: Bar where X.Y == Z.W.W.Self

        var foo: Bool { get set }
        subscript<R>(index: Int) -> R
      }
      """
    )

    AssertParse(
      "protocol P{1️⃣{}case2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code '{}' before enum case"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected identifier in enum case"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '}' to end protocol"),
      ]
    )
  }

  func testVariableDeclarations() {
    AssertParse(
      """
      z

      var x: Double = z
      """
    )

    AssertParse(
      """
      async let a = fetch("1.jpg")
      async let b: Image = fetch("2.jpg")
      async let secondPhotoToFetch = fetch("3.jpg")
      async let theVeryLastPhotoWeWant = fetch("4.jpg")
      """
    )

    AssertParse("private unowned(unsafe) var foo: Int")
    AssertParse("unowned(unsafe) let unmanagedVar: Class = c")

    AssertParse("_ = foo?.description")

    AssertParse(
      "_ = foo/* */?.description1️⃣",
      diagnostics: [
        DiagnosticSpec(message: "expected ':' and expression after '? ...' in ternary expression")
      ]
    )

    AssertParse("var a = Array<Int>?(from: decoder)")

    AssertParse("@Wrapper var café = 42")

    AssertParse(
      """
      var x: T {
        get async {
          foo()
          bar()
        }
      }
      """
    )

    AssertParse(
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

    AssertParse(
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

    AssertParse(
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
    AssertParse(
      """
      open1️⃣ open(set)2️⃣ var openProp = 0
      public public(set) var publicProp = 0
      internal internal(set) var internalProp = 0
      fileprivate fileprivate(set) var fileprivateProp = 0
      private private(set) var privateProp = 0
      internal(set) var defaultProp = 0
      """
    )

    AssertParse(
      """
      private(1️⃣get) var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'set' in modifier"),
        DiagnosticSpec(message: "unexpected code 'get' in modifier"),
      ]
    )

    AssertParse(
      """
      private(1️⃣+
        set
      ) var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'set)' to end modifier"),
        // FIXME: It should print `+` as detail of text.
        DiagnosticSpec(message: "unexpected code in variable"),
      ]
    )

    AssertParse(
      """
      private(1️⃣get, set) var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'get,' in modifier")
      ]
    )

    AssertParse(
      """
      private(1️⃣get: set) var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'get:' in modifier")
      ]
    )

    AssertParse(
      """
      1️⃣private(
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous code 'private(' at top level")
      ]
    )

    AssertParse(
      """
      private(1️⃣var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'set)' to end modifier")
      ]
    )

    AssertParse(
      """
      private(1️⃣get, set2️⃣, didSet) var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code 'get,' in modifier"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code ', didSet' in modifier"),
      ]
    )

    AssertParse(
      """
      private(1️⃣get, didSet var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'set)' to end modifier"),
        DiagnosticSpec(message: "unexpected code 'get, didSet' in variable"),
      ]
    )
  }

  func testTypealias() {
    AssertParse("typealias Foo = Int")

    AssertParse("typealias MyAlias = (_ a: Int, _ b: Double, _ c: Bool, _ d: String) -> Bool")

    AssertParse("typealias A = @attr1 @attr2(hello) (Int) -> Void")
  }

  func testPrecedenceGroup() {
    AssertParse(
      """
      precedencegroup FooGroup {
        higherThan: Group1, Group2
        lowerThan: Group3, Group4
        associativity: left
        assignment: false
      }
      """
    )

    AssertParse(
      """
      precedencegroup FunnyPrecedence {
       associativity: left
       higherThan: MultiplicationPrecedence
      }
      """
    )
  }

  func testOperators() {
    AssertParse("infix operator *-* : FunnyPrecedence")

    AssertParse(
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
    AssertParse(
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
    AssertParse(
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
    AssertParse(#"#error("Unsupported platform")"#)
  }

  func testParsePoundWarning() {
    AssertParse(#"#warning("Unsupported platform")"#)
  }

  func testParseSpecializeAttribute() {
    AssertParse(
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

    AssertParse(
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
  }

  func testParseDynamicReplacement() {
    AssertParse(
      """
      @_dynamicReplacement(for: dynamic_replaceable())
      func replacement() {
        dynamic_replaceable()
      }
      """
    )

    AssertParse(
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

    AssertParse(
      """
      @_dynamicReplacement(for: dynamic_replaceable_var)
      var r : Int {
        return 0
      }
      """
    )

    AssertParse(
      """
      @_dynamicReplacement(for: init(x:))
      init(y: Int) {
        self.init(x: y + 1)
      }
      """
    )
  }

  func testEnumParsing() {
    AssertParse(
      """
      enum Foo {
        @preconcurrency case custom(@Sendable () throws -> Void)
      }
      """
    )

    AssertParse(
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
    AssertParse(
      """
      struct a {
        public1️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected declaration after 'public' modifier in struct")
      ]
    )
  }

  func testMissingColonInFunctionSignature() {
    AssertParse(
      "func test(first second 1️⃣Int)",
      diagnostics: [
        DiagnosticSpec(message: "expected ':' in parameter")
      ]
    )
  }

  func testExtraArgumentLabelsInFunctionSignature() {
    AssertParse(
      "func test(first second 1️⃣third fourth: Int)",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'third fourth' in parameter")
      ]
    )
  }

  func testMissingClosingParenInFunctionSignature() {
    AssertParse(
      "func test(first second: Int1️⃣",
      diagnostics: [
        DiagnosticSpec(message: "expected ')' to end parameter clause")
      ]
    )
  }

  func testMissingOpeningParenInFunctionSignature() {
    AssertParse(
      "func test 1️⃣first second: Int)",
      diagnostics: [
        DiagnosticSpec(message: "expected '(' to start parameter clause")
      ]
    )
  }

  func testNoParamsForFunction() {
    AssertParse(
      """
      class MyClass {
        func withoutParameters1️⃣

        func withParameters() {}
      }
      """,
      substructure: Syntax(
        FunctionDeclSyntax(
          funcKeyword: .funcKeyword(),
          identifier: .identifier("withoutParameters"),
          signature: FunctionSignatureSyntax(
            input: ParameterClauseSyntax(
              leftParen: .leftParenToken(presence: .missing),
              parameterList: FunctionParameterListSyntax([]),
              rightParen: .rightParenToken(presence: .missing)
            )
          )
        )
      ),
      diagnostics: [
        DiagnosticSpec(message: "expected parameter clause in function signature")
      ]
    )
  }

  func testThrowsInWrongLocation() {
    AssertParse(
      "func test() -> 1️⃣throws Int",
      diagnostics: [
        DiagnosticSpec(message: "'throws' may only occur before '->'", fixIts: ["move 'throws' in front of '->'"])
      ],
      fixedSource: "func test() throws -> Int"
    )
  }

  func testExtraneousRightBraceRecovery() {
    AssertParse(
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
    AssertParse(
      """
      struct Foo {
        subscript(x: String) 1️⃣{}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '->' and return type in subscript")
      ]
    )
  }

  func testClassWithLeadingNumber() {
    AssertParse(
      """
      class 1️⃣23class {
        func 2️⃣24method() {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "identifier can only start with a letter or underscore, not a number"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "identifier can only start with a letter or underscore, not a number"),
      ]
    )
  }

  func testAccessors() {
    AssertParse(
      """
      var bad1 : Int {
        _read async { 0 }
      }
      """
    )

    AssertParse(
      """
      var bad2 : Int {
        get reasync { 0 }
      }
      """
    )
  }

  func testExpressionMember() {
    AssertParse(
      """
      struct S {
        1️⃣/ 2️⃣#3️⃣#4️⃣#line 5️⃣25 "line-directive.swift"
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected 'func' in function"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected parameter clause in function signature"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected identifier in pound literal declaration"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "expected identifier in pound literal declaration"),
        DiagnosticSpec(locationMarker: "5️⃣", message: #"unexpected code '25 "line-directive.swift"' in struct"#),
      ]
    )
  }

  func testBogusProtocolRequirements() {
    AssertParse(
      """
      protocol P {
        var prop : Int { get 1️⃣bogus rethrows set }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'bogus rethrows set' in variable")
      ]
    )
  }

  func testTextRecovery() {
    AssertParse(
      """
      Lorem1️⃣ ipsum2️⃣ dolor3️⃣ sit4️⃣ amet5️⃣, consectetur adipiscing elit
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "5️⃣", message: "extraneous code ', consectetur adipiscing elit' at top level"),
      ]
    )
  }

  func testRecoverOneExtraLabel() {
    AssertParse(
      "func test(first second 1️⃣third: Int)",
      substructure: Syntax(
        FunctionParameterSyntax(
          firstName: .identifier("first"),
          secondName: .identifier("second"),
          UnexpectedNodesSyntax([TokenSyntax.identifier("third")]),
          colon: .colonToken(),
          type: SimpleTypeIdentifierSyntax(name: .identifier("Int"))
        )
      ),
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'third' in parameter")
      ]
    )
  }

  func testRecoverTwoExtraLabels() {
    AssertParse(
      "func test(first second 1️⃣third fourth: Int)",
      substructure: Syntax(
        FunctionParameterSyntax(
          firstName: .identifier("first"),
          secondName: .identifier("second"),
          UnexpectedNodesSyntax([TokenSyntax.identifier("third"), TokenSyntax.identifier("fourth")]),
          colon: .colonToken(),
          type: SimpleTypeIdentifierSyntax(name: .identifier("Int"))
        )
      ),
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'third fourth' in parameter")
      ]
    )
  }

  func testDontRecoverFromDeclKeyword() {
    AssertParse(
      "func foo(first second 1️⃣third 2️⃣struct3️⃣: Int4️⃣) {}",
      substructure: Syntax(
        FunctionParameterSyntax(
          firstName: .identifier("first"),
          secondName: .identifier("second"),
          colon: .colonToken(presence: .missing),
          type: SimpleTypeIdentifierSyntax(name: .identifier("third"))
        )
      ),
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ':' in parameter"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected identifier in struct"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "unexpected code ')' in struct"),
      ]
    )
  }

  func testRecoverFromParens() {
    AssertParse(
      "func test(first second 1️⃣[third fourth]: Int)",
      substructure: Syntax(
        FunctionParameterSyntax(
          firstName: .identifier("first"),
          secondName: .identifier("second"),
          UnexpectedNodesSyntax([
            TokenSyntax.leftSquareBracketToken(),
            TokenSyntax.identifier("third"),
            TokenSyntax.identifier("fourth"),
            TokenSyntax.rightSquareBracketToken(),
          ]),
          colon: .colonToken(),
          type: SimpleTypeIdentifierSyntax(name: .identifier("Int"))
        )
      ),
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '[third fourth]' in parameter")
      ]
    )
  }

  func testDontRecoverFromUnbalancedParens() {
    AssertParse(
      "func foo(first second 1️⃣[third 2️⃣fourth: Int) {}",
      substructure: Syntax(
        FunctionParameterSyntax(
          firstName: .identifier("first"),
          secondName: .identifier("second"),
          colon: .colonToken(presence: .missing),
          type: ArrayTypeSyntax(
            leftSquareBracket: .leftSquareBracketToken(),
            elementType: SimpleTypeIdentifierSyntax(name: .identifier("third")),
            rightSquareBracket: .rightSquareBracketToken(presence: .missing)
          )
        )
      ),
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ':' in parameter"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ']' to end array type"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code 'fourth: Int' in parameter clause"),
      ]
    )
  }

  func testDontRecoverIfNewlineIsBeforeColon() {
    AssertParse(
      """
      func foo(first second 1️⃣third2️⃣
      3️⃣: Int) {}
      """,
      substructure: Syntax(
        FunctionParameterSyntax(
          firstName: .identifier("first"),
          secondName: .identifier("second"),
          colon: .colonToken(presence: .missing),
          type: SimpleTypeIdentifierSyntax(name: .identifier("third"))
        )
      ),
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ':' in parameter"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "extraneous code ': Int) {}' at top level"),
      ]
    )
  }

  func testMalforedStruct() {
    AssertParse(
      """
      struct n1️⃣
      #if2️⃣
      @3️⃣
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '{' in struct"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected condition in conditional compilation clause"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected name in attribute"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected declaration after attribute in conditional compilation clause"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected '#endif' in conditional compilation block"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected '}' to end struct"),
      ]
    )
  }

  func testInitializers() {
    AssertParse(
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
    AssertParse("deinit {}")
    AssertParse("deinit")
  }

  func testAttributedMember() {
    AssertParse(
      #"""
      struct Foo {
        @Argument(help: "xxx")
        var generatedPath: String
      }
      """#
    )
  }

  func testAnyAsParameterLabel() {
    AssertParse(
      "func at(any kinds: [RawTokenKind]) {}"
    )
  }

  func testPublicClass() {
    AssertParse("public class Foo: Superclass {}")
  }

  func testReturnAsyncContextualKeyword() {
    AssertParse(
      ##"""
      if let async = self.consumeIfContextualKeyword("async") {
        return async
      }

      if let reasync = self.consumeIfContextualKeyword("reasync") {
        return reasync
      }
      """##
    )
  }

  func testLeadingUnexpectedTokens() {
    AssertParse(
      "1️⃣}class C2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace before class"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected member block in class"),
      ],
      fixedSource: """
        }class C {}
        """
    )
    AssertParse(
      "1️⃣}enum C2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace before enum"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected member block in enum"),
      ]
    )
    AssertParse(
      "1️⃣}protocol C2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace before protocol"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected member block in protocol"),
      ]
    )
    AssertParse(
      "1️⃣}actor C2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace before actor"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected member block in actor"),
      ]
    )
    AssertParse(
      "1️⃣}struct C2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace before struct"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected member block in struct"),
      ]
    )
    AssertParse(
      "1️⃣}func C2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace before function"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected parameter clause in function signature"),
      ]
    )
    AssertParse(
      "1️⃣}init2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace before initializer"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected parameter clause in function signature"),
      ]
    )
    AssertParse(
      "1️⃣}subscript2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace before subscript"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected parameter clause in subscript"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '->' and return type in subscript"),
      ]
    )
  }

  func testBogusTypeDeclName() {
    AssertParse(
      "associatedtype 1️⃣5s",
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
      ]
    )
  }

  func testModifiedParameter() {
    AssertParse(
      """
      func const(_const _ map: String) {}
      """
    )

    AssertParse(
      """
      func isolated(isolated _ 1️⃣map: String) {}
      """
    )

    AssertParse(
      """
      func isolatedConst(isolated _const _ 1️⃣map: String) {}
      """
    )

    AssertParse(
      """
      func nonEphemeralIsolatedConst(@_nonEmphemeral isolated _const _ 1️⃣map: String) {}
      """
    )

    AssertParse(
      """
      func const(_const map: String) {}
      """
    )

    AssertParse(
      """
      func isolated(isolated map: String) {}
      """
    )

    AssertParse(
      """
      func isolatedConst(isolated _const map1️⃣: String) {}
      """
    )

    AssertParse(
      """
      func const(_const x: String) {}
      func isolated(isolated: String) {}
      func isolatedConst(isolated _const: String) {}
      """
    )
  }

  func testReasyncFunctions() {
    AssertParse(
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
    AssertParse(
      """
      struct U<@1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected name in attribute"),
        DiagnosticSpec(message: "expected name in generic parameter"),
        DiagnosticSpec(message: "expected '>' to end generic parameter clause"),
        DiagnosticSpec(message: "expected member block in struct"),
      ]
    )
  }

  func testMatchBracesBasedOnSpaces() {
    AssertParse(
      """
      struct Foo {
        struct Bar 1️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected member block in struct")
      ]
    )
  }

  func testFunctionWithoutNameOrArguments() {
    AssertParse(
      "func 1️⃣{}",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier and function signature in function")
      ]
    )
  }

  func testMacroExpansionDeclaration() {
    AssertParse(
      """
      struct X {
        #memberwiseInit(access: .public)
      }
      """
    )
  }

  func testVariableDeclWithGetSetButNoBrace() {
    AssertParse(
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
        DiagnosticSpec(message: "expected '{' in variable")
      ]
    )
  }

  func testVariableDeclWithSetGetButNoBrace() {
    AssertParse(
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
        DiagnosticSpec(message: "expected '{' in variable")
      ]
    )
  }

  func testVariableFollowedByReferenceToSet() {
    AssertParse(
      """
      func bar() {
          let a = b
          set.c
      }
      """
    )
  }

  func testNominalDeclarationRecovery() {
    AssertParse("protocol 1️⃣{}", diagnostics: [DiagnosticSpec(message: "expected identifier in protocol")])
    AssertParse("class 1️⃣{}", diagnostics: [DiagnosticSpec(message: "expected identifier in class")])
    AssertParse("struct 1️⃣{}", diagnostics: [DiagnosticSpec(message: "expected identifier in struct")])
    AssertParse("enum 1️⃣{}", diagnostics: [DiagnosticSpec(message: "expected identifier in enum")])
    // `actor` cannot recover from a missing identifier since it's contextual
    // based on the presence of the identifier.
  }

  func testDontNestClassesIfTheyContainUnexpectedTokens() {
    // There used to be a bug where `class B` was parsed as a nested class of A
    // because recovery to the `class` keyword of B consumed the closing brace.
    AssertParse(
      """
      class A {
        1️⃣^2️⃣
      }
      class B {
      }
      """,
      substructure: Syntax(
        CodeBlockItemListSyntax([
          CodeBlockItemSyntax(
            item: .init(
              ClassDeclSyntax(
                classKeyword: .classKeyword(),
                identifier: .identifier("A"),
                members: MemberDeclBlockSyntax(
                  leftBrace: .leftBraceToken(),
                  members: MemberDeclListSyntax([
                    MemberDeclListItemSyntax(
                      decl: Decl(
                        FunctionDeclSyntax(
                          funcKeyword: .funcKeyword(presence: .missing),
                          identifier: .spacedBinaryOperator("^"),
                          signature: FunctionSignatureSyntax(
                            input: ParameterClauseSyntax(
                              leftParen: .leftParenToken(presence: .missing),
                              parameterList: FunctionParameterListSyntax([]),
                              rightParen: .rightParenToken(presence: .missing)
                            )
                          )
                        )
                      )
                    )
                  ]),
                  rightBrace: .rightBraceToken()
                )
              )
            )
          ),
          CodeBlockItemSyntax(
            item: .init(
              ClassDeclSyntax(
                classKeyword: .classKeyword(),
                identifier: .identifier("B"),
                members: MemberDeclBlockSyntax(
                  leftBrace: .leftBraceToken(),
                  members: MemberDeclListSyntax([]),
                  rightBrace: .rightBraceToken()
                )
              )
            )
          ),
        ])
      ),
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected 'func' in function"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected parameter clause in function signature"),
      ]
    )
  }

  func testIssue1025() {
    AssertParse(
      """
      struct Math {
        public static let pi = 3.14
        @available(*, unavailable) init() {}
      }
      """
    )

    AssertParse("func foo(body: (isolated String) -> Int) {}")
  }

  func testMacroDecl() {
    AssertParse(
      """
      macro m1: Int = A.M1
      macro m2(_: Int) = A.M2
      macro m3(a b: Int) -> Int = A.M3
      macro m4<T>: T = A.M4 where T.Assoc: P
      macro m5<T: P>(_: T)
      """
    )

    AssertParse(
      """
      macro m1 1️⃣= A
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected parameter clause in function signature")
      ]
    )
  }

  func testPrimaryAssociatedTypeNotTerminatedWithAngleBracket() {
    AssertParse(
      "protocol1️⃣<2️⃣:3️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected identifier in protocol"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected name in primary associated type clause"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '>' to end primary associated type clause"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected type in inherited type"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected member block in protocol"),
      ]
    )
  }
}

extension Parser.DeclAttributes {
  static let empty = Parser.DeclAttributes(attributes: nil, modifiers: nil)
}
