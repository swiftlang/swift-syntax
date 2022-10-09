@_spi(RawSyntax) import SwiftSyntax
@_spi(Testing) @_spi(RawSyntax) import SwiftParser
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
      ], fixedSource: """
      func `where`(
      r)
      """
    )

    AssertParse("func /^/ (lhs: Int, rhs: Int) -> Int { 1 / 2 }")

    AssertParse(
      "func 1️⃣/^notoperator^/ (lhs: Int, rhs: Int) -> Int { 1 / 2 }",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in function"),
        DiagnosticSpec(message: "unexpected text '/^notoperator^/' before parameter clause")
      ]
    )

    AssertParse("func /^ (lhs: Int, rhs: Int) -> Int { 1 / 2 }")
  }

  func testFuncAfterUnbalancedClosingBrace() {
    AssertParse(
      """
      1️⃣}
      func foo() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected text '}' before function")
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
      { $0.parseGenericParameters() }
    )

    AssertParse("class T where t1️⃣",
                diagnostics: [
                  DiagnosticSpec(message: "expected '=' and right-hand type in same type requirement"),
                  DiagnosticSpec(message: "expected member block in class"),
                ])
    AssertParse("class B<where g1️⃣",
                diagnostics: [
                  DiagnosticSpec(message: "expected '=' and right-hand type in same type requirement"),
                  DiagnosticSpec(message: "expected '>' to end generic parameter clause"),
                  DiagnosticSpec(message: "expected member block in class"),
                ])
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
        DiagnosticSpec(message: "unexpected text '}' before actor")
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
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected text '{}' before enum case"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected identifier in enum case"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '}' to end protocol"),
      ])
  }

  func testVariableDeclarations() {
    AssertParse(
      """
      z

      var x: Double = z
      """)
    
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
        DiagnosticSpec(message: "expected ':' after '? ...' in ternary expression"),
        DiagnosticSpec(message: "expected expression"),
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
        DiagnosticSpec(message: "unexpected text 'get' in modifier")
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
        DiagnosticSpec(message: "unexpected text in variable")
      ]
    )

    AssertParse(
      """
      private(1️⃣get, set) var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected text 'get,' in modifier")
      ]
    )

    AssertParse(
      """
      private(1️⃣get: set) var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected text 'get:' in modifier")
      ]
    )

    AssertParse(
      """
      1️⃣private(
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous 'private(' at top level")
      ]
    )

    AssertParse(
      """
      private(1️⃣var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'set)' to end modifier"),
      ]
    )

    AssertParse(
      """
      private(1️⃣get, set2️⃣, didSet) var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected text 'get,' in modifier"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected text ', didSet' in modifier")
      ]
    )

    AssertParse(
      """
      private(1️⃣get, didSet var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'set)' to end modifier"),
        DiagnosticSpec(message: "unexpected text 'get, didSet' in variable")
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
      """)
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
      "(first second 1️⃣Int)",
      { $0.parseFunctionSignature() },
      diagnostics: [
        DiagnosticSpec(message: "expected ':' in function parameter")
      ]
    )
  }

  func testExtraArgumentLabelsInFunctionSignature() {
    AssertParse(
      "(first second 1️⃣third fourth: Int)",
      { $0.parseFunctionSignature() },
      diagnostics: [
        DiagnosticSpec(message: "unexpected text 'third fourth' in function parameter")
      ]
    )
  }

  func testMissingClosingParenInFunctionSignature() {
    AssertParse(
      "(first second: Int1️⃣",
      { $0.parseFunctionSignature() },
      diagnostics: [
        DiagnosticSpec(message: "expected ')' to end parameter clause")
      ]
    )
  }

  func testMissingOpeningParenInFunctionSignature() {
    AssertParse(
      "1️⃣first second: Int)",
      { $0.parseFunctionSignature() },
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
      substructure: Syntax(FunctionDeclSyntax(
        attributes: nil,
        modifiers: nil,
        funcKeyword: .funcKeyword(),
        identifier: .identifier("withoutParameters"),
        genericParameterClause: nil,
        signature: FunctionSignatureSyntax(
          input: ParameterClauseSyntax(
            leftParen: .leftParenToken(presence: .missing),
            parameterList: FunctionParameterListSyntax([]),
            rightParen: .rightParenToken(presence: .missing)
          ),
          asyncOrReasyncKeyword: nil,
          throwsOrRethrowsKeyword: nil,
          output: nil
        ),
        genericWhereClause: nil,
        body: nil
      )),
      diagnostics: [
        DiagnosticSpec(message: "expected argument list in function declaration")
      ]
    )
  }

  func testThrowsInWrongLocation() {
    AssertParse(
      "() -> 1️⃣throws Int",
      { $0.parseFunctionSignature() },
      diagnostics: [
        DiagnosticSpec(message: "'throws' may only occur before '->'", fixIts: ["move 'throws' in front of '->'"])
      ],
      fixedSource: "() throws -> Int"
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
        DiagnosticSpec(message: "extraneous '}' at top level")
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
        DiagnosticSpec(message: "expected '->' and return type in subscript"),
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
      struct S {1️⃣
        2️⃣/ ###line 25 "line-directive.swift"
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected declaration in struct"),
        DiagnosticSpec(locationMarker: "2️⃣", message: #"unexpected text '/ ###line 25 "line-directive.swift"' in struct"#)
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
        DiagnosticSpec(message: "unexpected text 'bogus rethrows set' in variable")
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
        DiagnosticSpec(locationMarker: "5️⃣", message: "extraneous ', consectetur adipiscing elit' at top level"),
      ]
    )
  }

  func testRecoverOneExtraLabel() {
    AssertParse(
      "(first second 1️⃣third: Int)",
      { $0.parseFunctionSignature() },
      substructure: Syntax(FunctionParameterSyntax(
        attributes: nil,
        modifiers: nil,
        firstName: TokenSyntax.identifier("first"),
        secondName: TokenSyntax.identifier("second"),
        UnexpectedNodesSyntax([Syntax(TokenSyntax.identifier("third"))]),
        colon: TokenSyntax.colonToken(),
        type: TypeSyntax(SimpleTypeIdentifierSyntax(name: TokenSyntax.identifier("Int"), genericArgumentClause: nil)),
        ellipsis: nil,
        defaultArgument: nil,
        trailingComma: nil
      )),
      diagnostics: [
        DiagnosticSpec(message: "unexpected text 'third' in function parameter")
      ]
    )
  }

  func testRecoverTwoExtraLabels() {
    AssertParse(
      "(first second 1️⃣third fourth: Int)",
      { $0.parseFunctionSignature() },
      substructure: Syntax(FunctionParameterSyntax(
        attributes: nil,
        modifiers: nil,
        firstName: TokenSyntax.identifier("first"),
        secondName: TokenSyntax.identifier("second"),
        UnexpectedNodesSyntax([Syntax(TokenSyntax.identifier("third")), Syntax(TokenSyntax.identifier("fourth"))]),
        colon: TokenSyntax.colonToken(),
        type: TypeSyntax(SimpleTypeIdentifierSyntax(name: TokenSyntax.identifier("Int"), genericArgumentClause: nil)),
        ellipsis: nil,
        defaultArgument: nil,
        trailingComma: nil
      )),
      diagnostics: [
        DiagnosticSpec(message: "unexpected text 'third fourth' in function parameter")
      ]
    )
  }

  func testDontRecoverFromDeclKeyword() {
    AssertParse(
      "func foo(first second 1️⃣third2️⃣ 3️⃣struct4️⃣: Int) {}",
      substructure: Syntax(FunctionParameterSyntax(
        attributes: nil,
        modifiers: nil,
        firstName: .identifier("first"),
        secondName: .identifier("second"),
        colon: .colonToken(presence: .missing),
        type: TypeSyntax(SimpleTypeIdentifierSyntax(name: .identifier("third"), genericArgumentClause: nil)),
        ellipsis: nil,
        defaultArgument: nil,
        trailingComma: nil
      )),
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ':' in function parameter"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "expected identifier in struct"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "expected member block in struct"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "extraneous ': Int) {}' at top level"),
      ]
    )
  }

  func testRecoverFromParens() {
    AssertParse(
      "(first second 1️⃣[third fourth]: Int)",
      { $0.parseFunctionSignature() },
      substructure: Syntax(FunctionParameterSyntax(
        attributes: nil,
        modifiers: nil,
        firstName: TokenSyntax.identifier("first"),
        secondName: TokenSyntax.identifier("second"),
        UnexpectedNodesSyntax([
          Syntax(TokenSyntax.leftSquareBracketToken()),
          Syntax(TokenSyntax.identifier("third")),
          Syntax(TokenSyntax.identifier("fourth")),
          Syntax(TokenSyntax.rightSquareBracketToken())
        ]),
        colon: TokenSyntax.colonToken(),
        type: TypeSyntax(SimpleTypeIdentifierSyntax(name: TokenSyntax.identifier("Int"), genericArgumentClause: nil)),
        ellipsis: nil,
        defaultArgument: nil,
        trailingComma: nil
      )),
      diagnostics: [
        DiagnosticSpec(message: "unexpected text '[third fourth]' in function parameter")
      ]
    )
  }

  func testDontRecoverFromUnbalancedParens() {
    AssertParse(
      "func foo(first second 1️⃣[third 2️⃣fourth: Int) {}",
      substructure: Syntax(FunctionParameterSyntax(
        attributes: nil,
        modifiers: nil,
        firstName: TokenSyntax.identifier("first"),
        secondName: TokenSyntax.identifier("second"),
        colon: TokenSyntax(.colon, presence: .missing),
        type: TypeSyntax(ArrayTypeSyntax(
          leftSquareBracket: TokenSyntax.leftSquareBracketToken(),
          elementType: TypeSyntax(SimpleTypeIdentifierSyntax(name: TokenSyntax.identifier("third"), genericArgumentClause: nil)),
          rightSquareBracket: TokenSyntax(.rightSquareBracket, presence: .missing)
        )),
        ellipsis: nil,
        defaultArgument: nil,
        trailingComma: nil
      )),
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ':' in function parameter"),
        DiagnosticSpec(locationMarker: "2️⃣" , message: "expected ']' to end array type"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected text 'fourth: Int' in parameter clause")
      ]
    )
  }

  func testDontRecoverIfNewlineIsBeforeColon() {
    AssertParse(
      """
      func foo(first second 1️⃣third2️⃣
      3️⃣: Int) {}
      """,
      substructure: Syntax(FunctionParameterSyntax(
        attributes: nil,
        modifiers: nil,
        firstName: TokenSyntax.identifier("first"),
        secondName: TokenSyntax.identifier("second"),
        colon: TokenSyntax(.colon, presence: .missing),
        type: TypeSyntax(SimpleTypeIdentifierSyntax(name: TokenSyntax.identifier("third"), genericArgumentClause: nil)),
        ellipsis: nil,
        defaultArgument: nil,
        trailingComma: nil
      )),
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ':' in function parameter"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "extraneous ': Int) {}' at top level")
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
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected '}' to end struct")
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
      """)
  }

  func testDeinitializers() {
    AssertParse("deinit {}", { $0.parseDeinitializerDeclaration(.empty, .constant(.deinitKeyword)) })
    AssertParse("deinit", { $0.parseDeinitializerDeclaration(.empty, .constant(.deinitKeyword)) })
  }

  func testAttributedMember() {
    AssertParse(#"""
    struct Foo {
      @Argument(help: "xxx")
      var generatedPath: String
    }
    """#)
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
      """##)
  }

  func testLeadingUnexpectedTokens() {
    AssertParse(
      "1️⃣}class C2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected text '}' before class"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected member block in class"),
      ],
      fixedSource: """
        }class C {}
        """
    )
    AssertParse("1️⃣}enum C2️⃣",
                diagnostics: [
                  DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected text '}' before enum"),
                  DiagnosticSpec(locationMarker: "2️⃣", message: "expected member block in enum"),
                ])
    AssertParse("1️⃣}protocol C2️⃣",
                diagnostics: [
                  DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected text '}' before protocol"),
                  DiagnosticSpec(locationMarker: "2️⃣", message: "expected member block in protocol"),
                ])
    AssertParse("1️⃣}actor C2️⃣",
                diagnostics: [
                  DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected text '}' before actor"),
                  DiagnosticSpec(locationMarker: "2️⃣", message: "expected member block in actor"),
                ])
    AssertParse("1️⃣}struct C2️⃣",
                diagnostics: [
                  DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected text '}' before struct"),
                  DiagnosticSpec(locationMarker: "2️⃣", message: "expected member block in struct"),
                ])
    AssertParse("1️⃣}func C2️⃣",
                diagnostics: [
                  DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected text '}' before function"),
                  DiagnosticSpec(locationMarker: "2️⃣", message: "expected argument list in function declaration"),
                ])
    AssertParse("1️⃣}init2️⃣",
                diagnostics: [
                  DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected text '}' before initializer"),
                  DiagnosticSpec(locationMarker: "2️⃣", message: "expected argument list in function declaration"),
                ])
    AssertParse("1️⃣}subscript2️⃣",
                diagnostics: [
                  DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected text '}' before subscript"),
                  DiagnosticSpec(locationMarker: "2️⃣", message: "expected argument list in function declaration"),
                  DiagnosticSpec(locationMarker: "2️⃣", message: "expected '->' and return type in subscript"),
                ])
  }

  func testBogusTypeDeclName() {
    AssertParse(
      "associatedtype 1️⃣5s",
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number"),
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

  func testReasyncFunctions() throws {
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
      """)
  }

  func testStandaloneAtSignInGenericParameter() {
    AssertParse(
      """
      struct U<@1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected name in attribute"),
        DiagnosticSpec(message: "expected identifier in generic parameter"),
        DiagnosticSpec(message: "expected '>' to end generic parameter clause"),
        DiagnosticSpec(message: "expected member block in struct"),
      ]
    )
  }
}

extension Parser.DeclAttributes {
  static let empty = Parser.DeclAttributes(attributes: nil, modifiers: nil)
}

