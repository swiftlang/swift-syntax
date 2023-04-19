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

@_spi(RawSyntax) import SwiftSyntax
@_spi(Testing) @_spi(RawSyntax) import SwiftParser
import SwiftSyntaxBuilder
import SwiftBasicFormat
import XCTest

final class DeclarationTests: XCTestCase {
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
        DiagnosticSpec(locationMarker: "1️⃣", message: "keyword 'where' cannot be used as an identifier here", fixIts: ["if this name is unavoidable, use backticks to escape it"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '(' to start parameter clause", fixIts: ["insert '('"]),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected ':' and type in parameter", fixIts: ["insert ':' and type"]),
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
      substructure: Syntax(
        FunctionParameterSyntax(
          firstName: .wildcardToken(),
          secondName: .identifier("default"),
          colon: .colonToken(),
          type: SimpleTypeIdentifierSyntax(name: .identifier("Int"))
        )
      )
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

    assertParse(
      "<@NSApplicationMain T: AnyObject>",
      { GenericParameterClauseSyntax.parse(from: &$0) }
    )

    assertParse(
      "class T where t1️⃣",
      diagnostics: [
        DiagnosticSpec(message: "expected ':' or '==' to indicate a conformance or same-type requirement"),
        DiagnosticSpec(message: "expected member block in class", fixIts: ["insert member block"]),
      ]
    )
    assertParse(
      "class B<where g1️⃣",
      diagnostics: [
        DiagnosticSpec(message: "expected ':' or '==' to indicate a conformance or same-type requirement"),
        DiagnosticSpec(message: "expected '>' to end generic parameter clause", fixIts: ["insert '>'"]),
        DiagnosticSpec(message: "expected member block in class", fixIts: ["insert member block"]),
      ]
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
      "protocol P{1️⃣{}case2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code '{}' before enum case"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected identifier in enum case", fixIts: ["insert identifier"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '}' to end protocol", fixIts: ["insert '}'"]),
      ]
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
        DiagnosticSpec(message: "expected ':' and expression after '? ...' in ternary expression", fixIts: ["insert ':' and expression"])
      ]
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
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'", fixIts: ["insert ';'"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive statements on a line must be separated by ';'", fixIts: ["insert ';'"]),
      ]
    )

    assertParse(
      """
      private(1️⃣get) var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'set' in modifier", fixIts: ["insert 'set'"]),
        DiagnosticSpec(message: "unexpected code 'get' in modifier"),
      ]
    )

    assertParse(
      """
      private(1️⃣+
        set
      ) var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'set)' to end modifier", fixIts: ["insert 'set)'"]),
        // FIXME: It should print `+` as detail of text.
        DiagnosticSpec(message: "unexpected code in variable"),
      ]
    )

    assertParse(
      """
      private(1️⃣get, set) var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'get,' in modifier")
      ]
    )

    assertParse(
      """
      private(1️⃣get: set) var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'get:' in modifier")
      ]
    )

    assertParse(
      """
      1️⃣private(
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous code 'private(' at top level")
      ]
    )

    assertParse(
      """
      private(1️⃣var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'set)' to end modifier", fixIts: ["insert 'set)'"])
      ]
    )

    assertParse(
      """
      private(1️⃣get, set2️⃣, didSet) var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code 'get,' in modifier"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code ', didSet' in modifier"),
      ]
    )

    assertParse(
      """
      private(1️⃣get, didSet var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'set)' to end modifier", fixIts: ["insert 'set)'"]),
        DiagnosticSpec(message: "unexpected code 'get, didSet' in variable"),
      ]
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
      ]
    )
  }

  func testMissingColonInFunctionSignature() {
    assertParse(
      "func test(first second 1️⃣Int)",
      diagnostics: [
        DiagnosticSpec(message: "expected ':' in parameter", fixIts: ["insert ':'"])
      ]
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
      "func test(first second: Int1️⃣",
      diagnostics: [
        DiagnosticSpec(message: "expected ')' to end parameter clause", fixIts: ["insert ')'"])
      ]
    )
  }

  func testMissingOpeningParenInFunctionSignature() {
    assertParse(
      "func test 1️⃣first second: Int)",
      diagnostics: [
        DiagnosticSpec(message: "expected '(' to start parameter clause", fixIts: ["insert '('"])
      ]
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
      substructure: Syntax(
        FunctionDeclSyntax(
          funcKeyword: .keyword(.func),
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
        DiagnosticSpec(message: "expected parameter clause in function signature", fixIts: ["insert parameter clause"])
      ]
    )
  }

  func testThrowsInWrongLocation() {
    assertParse(
      "func test() -> 1️⃣throws Int",
      diagnostics: [
        DiagnosticSpec(message: "'throws' must preceed '->'", fixIts: ["move 'throws' in front of '->'"])
      ],
      fixedSource: "func test() throws -> Int"
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
      ]
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
        DiagnosticSpec(locationMarker: "1️⃣", message: "identifier can only start with a letter or underscore, not a number"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "identifier can only start with a letter or underscore, not a number"),
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
        DiagnosticSpec(message: "expected async specifier; did you mean 'async'?", fixIts: ["replace 'reasync' with 'async'"])
      ]
    )
  }

  func testExpressionMember() {
    assertParse(
      """
      struct S {1️⃣
        /2️⃣ ###line 25 "line-directive.swift"3️⃣
      4️⃣}
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '}' to end struct", fixIts: ["insert '}'"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "bare slash regex literal may not start with space"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected '/' to end regex literal", fixIts: ["insert '/\'"]),
        DiagnosticSpec(locationMarker: "4️⃣", message: "extraneous brace at top level"),
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
      substructure: Syntax(
        AccessorBlockSyntax(
          accessors: AccessorListSyntax([
            AccessorDeclSyntax(
              accessorKind: .keyword(.get)
            )
          ]),
          UnexpectedNodesSyntax([
            TokenSyntax.identifier("bogus"), TokenSyntax.keyword(.rethrows),
            TokenSyntax.identifier("set"),
          ])
        )
      ),
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'bogus rethrows set' in variable")
      ]
    )
  }

  func testTextRecovery() {
    assertParse(
      """
      Lorem1️⃣ ipsum2️⃣ dolor3️⃣ sit4️⃣ amet5️⃣, consectetur adipiscing elit
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'", fixIts: ["insert ';'"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive statements on a line must be separated by ';'", fixIts: ["insert ';'"]),
        DiagnosticSpec(locationMarker: "3️⃣", message: "consecutive statements on a line must be separated by ';'", fixIts: ["insert ';'"]),
        DiagnosticSpec(locationMarker: "4️⃣", message: "consecutive statements on a line must be separated by ';'", fixIts: ["insert ';'"]),
        DiagnosticSpec(locationMarker: "5️⃣", message: "extraneous code ', consectetur adipiscing elit' at top level"),
      ]
    )
  }

  func testRecoverOneExtraLabel() {
    assertParse(
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
    assertParse(
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
    assertParse(
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
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ':' in parameter", fixIts: ["insert ':'"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ')' to end parameter clause", fixIts: ["insert ')'"]),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected identifier in struct", fixIts: ["insert identifier"]),
        DiagnosticSpec(locationMarker: "4️⃣", message: "unexpected code ')' in struct"),
      ]
    )
  }

  func testRecoverFromParens() {
    assertParse(
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
    assertParse(
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
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ':' in parameter", fixIts: ["insert ':'"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ']' to end array type", fixIts: ["insert ']'"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code 'fourth: Int' in parameter clause"),
      ]
    )
  }

  func testDontRecoverIfNewlineIsBeforeColon() {
    assertParse(
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
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ':' in parameter", fixIts: ["insert ':'"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ')' to end parameter clause", fixIts: ["insert ')'"]),
        DiagnosticSpec(locationMarker: "3️⃣", message: "extraneous code ': Int) {}' at top level"),
      ]
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
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected condition in conditional compilation clause", fixIts: ["insert condition"]),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected name in attribute", fixIts: ["insert name"]),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected declaration after attribute", fixIts: ["insert declaration"]),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected '#endif' in conditional compilation block", fixIts: ["insert '#endif'"]),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected '}' to end struct", fixIts: ["insert '}'"]),
      ]
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
        }class C {}
        """
    )
    assertParse(
      "1️⃣}enum C2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace before enum"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected member block in enum", fixIts: ["insert member block"]),
      ]
    )
    assertParse(
      "1️⃣}protocol C2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace before protocol"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected member block in protocol", fixIts: ["insert member block"]),
      ]
    )
    assertParse(
      "1️⃣}actor C2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace before actor"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected member block in actor", fixIts: ["insert member block"]),
      ]
    )
    assertParse(
      "1️⃣}struct C2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace before struct"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected member block in struct", fixIts: ["insert member block"]),
      ]
    )
    assertParse(
      "1️⃣}func C2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace before function"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected parameter clause in function signature", fixIts: ["insert parameter clause"]),
      ]
    )
    assertParse(
      "1️⃣}init2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace before initializer"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected parameter clause in function signature", fixIts: ["insert parameter clause"]),
      ]
    )
    assertParse(
      "1️⃣}subscript2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace before subscript"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected parameter clause in subscript", fixIts: ["insert parameter clause"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '->' and return type in subscript", fixIts: ["insert '->' and return type"]),
      ]
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
      struct U<@1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected name in attribute", fixIts: ["insert name"]),
        DiagnosticSpec(message: "expected name in generic parameter", fixIts: ["insert name"]),
        DiagnosticSpec(message: "expected '>' to end generic parameter clause", fixIts: ["insert '>'"]),
        DiagnosticSpec(message: "expected member block in struct", fixIts: ["insert member block"]),
      ]
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
      ]
    )
  }

  func testFunctionWithoutNameOrArguments() {
    assertParse(
      "func 1️⃣{}",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier and function signature in function", fixIts: ["insert identifier and function signature"])
      ]
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
      substructure: Syntax(
        SourceFileSyntax(
          CodeBlockItemListSyntax {
            MacroExpansionDeclSyntax(macro: "expand") {}
          }
        )
      )
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
      ]
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
      ]
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
      ]
    )
    assertParse(
      "class 1️⃣{}",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in class", fixIts: ["insert identifier"])
      ]
    )
    assertParse(
      "struct 1️⃣{}",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in struct", fixIts: ["insert identifier"])
      ]
    )
    assertParse(
      "enum 1️⃣{}",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in enum", fixIts: ["insert identifier"])
      ]
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
                classKeyword: .keyword(.class),
                identifier: .identifier("A"),
                memberBlock: MemberDeclBlockSyntax(
                  leftBrace: .leftBraceToken(),
                  members: MemberDeclListSyntax([
                    MemberDeclListItemSyntax(
                      decl: DeclSyntax(
                        FunctionDeclSyntax(
                          funcKeyword: .keyword(.func, presence: .missing),
                          identifier: .binaryOperator("^"),
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
                classKeyword: .keyword(.class),
                identifier: .identifier("B"),
                memberBlock: MemberDeclBlockSyntax(
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
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected 'func' in function", fixIts: ["insert 'func'"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected parameter clause in function signature", fixIts: ["insert parameter clause"]),
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
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected parameter clause in function signature", fixIts: ["insert parameter clause"]),
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code ': Int = A.M1' before macro"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected parameter clause in function signature", fixIts: ["insert parameter clause"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code ': T = A.M4 where T.Assoc: P' before macro"),
      ]
    )

    assertParse(
      """
      macro m1 1️⃣= A
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected parameter clause in function signature", fixIts: ["insert parameter clause"])
      ]
    )
  }

  func testPrimaryAssociatedTypeNotTerminatedWithAngleBracket() {
    assertParse(
      "protocol1️⃣<2️⃣:3️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected identifier in protocol", fixIts: ["insert identifier"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected name in primary associated type clause", fixIts: ["insert name"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '>' to end primary associated type clause", fixIts: ["insert '>'"]),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected type in inherited type", fixIts: ["insert type"]),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected member block in protocol", fixIts: ["insert member block"]),
      ]
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
      substructure: Syntax(
        MemberDeclListItemSyntax(decl: EditorPlaceholderDeclSyntax(identifier: .identifier("<#code#>")))
      ),
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
      substructure: Syntax(
        FunctionCallExprSyntax(
          calledExpression: IdentifierExprSyntax(identifier: .identifier("open")),
          leftParen: .leftParenToken(),
          argumentList: TupleExprElementListSyntax([
            TupleExprElementSyntax(
              expression: IdentifierExprSyntax(identifier: .identifier("set"))
            )
          ]),
          rightParen: .rightParenToken()
        )
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
      substructure: Syntax(
        VariableDeclSyntax(
          modifiers: ModifierListSyntax([
            DeclModifierSyntax(name: .keyword(.open))
          ]),
          bindingKeyword: .keyword(.var),
          bindings: PatternBindingListSyntax([
            PatternBindingSyntax(
              pattern: IdentifierPatternSyntax(identifier: .identifier("foo")),
              initializer: InitializerClauseSyntax(
                value: IntegerLiteralExprSyntax(digits: .integerLiteral("2"))
              )
            )
          ])
        )
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
      substructure: Syntax(DeclModifierSyntax(name: .keyword(.open)))
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
    assertParse(
      """
      struct borrowing {}
      struct consuming {}

      struct Foo {}

      func foo(x: borrowing Foo) {}
      func bar(x: consuming Foo) {}
      func baz(x: (borrowing Foo, consuming Foo) -> ()) {}

      // `borrowing` and `consuming` are contextual keywords, so they should also
      // continue working as type and/or parameter names

      func zim(x: borrowing) {}
      func zang(x: consuming) {}
      func zung(x: borrowing consuming) {}
      func zip(x: consuming borrowing) {}
      func zap(x: (borrowing, consuming) -> ()) {}
      func zoop(x: (borrowing consuming, consuming borrowing) -> ()) {}

      // Parameter specifier names are regular identifiers in other positions,
      // including argument labels.

      func argumentLabelOnly(borrowing: Int) {}
      func argumentLabelOnly(consuming: Int) {}
      func argumentLabelOnly(__shared: Int) {}
      func argumentLabelOnly(__owned: Int) {}

      func argumentLabel(borrowing consuming: Int) {}
      func argumentLabel(consuming borrowing: Int) {}
      func argumentLabel(__shared __owned: Int) {}
      func argumentLabel(__owned __shared: Int) {}

      // We should parse them as argument labels in function types, even though that
      // isn't currently supported.

      func argumentLabel(anonBorrowingInClosure: (_ borrowing: Int) -> ()) {}
      func argumentLabel(anonConsumingInClosure: (_ consuming: Int) -> ()) {}
      func argumentLabel(anonSharedInClosure: (_ __shared: Int) -> ()) {}
      func argumentLabel(anonOwnedInClosure: (_ __owned: Int) -> ()) {}
      """
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
      substructure: Syntax(
        InheritedTypeSyntax(
          withoutTilde: .prefixOperator("~"),
          typeName: TypeSyntax(stringLiteral: "Copyable")
        )
      )
    )

    assertParse(
      """
      enum Whatever: Int, ~ Hashable, Equatable {}
      """,
      substructure:
        Syntax(
          TypeInheritanceClauseSyntax(
            colon: .colonToken(),
            inheritedTypeCollection: InheritedTypeListSyntax([
              InheritedTypeSyntax(
                typeName: TypeSyntax(stringLiteral: "Int"),
                trailingComma: .commaToken()
              ),
              InheritedTypeSyntax(
                withoutTilde: .prefixOperator("~"),
                typeName: TypeSyntax(stringLiteral: "Hashable"),
                trailingComma: .commaToken()
              ),
              InheritedTypeSyntax(typeName: TypeSyntax(stringLiteral: "Equatable")),
            ])
          )
        )
    )
  }
}

extension Parser.DeclAttributes {
  static let empty = Parser.DeclAttributes(attributes: nil, modifiers: nil)
}
