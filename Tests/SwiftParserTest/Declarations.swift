@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) import SwiftParser
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

    AssertParse("""
                func #^DIAG1^#where
                r#^DIAG2^#
                """,
                diagnostics: [
                  DiagnosticSpec(locationMarker: "DIAG1", message: "Expected identifier in function"),
                  DiagnosticSpec(locationMarker: "DIAG1", message: "Expected argument list in function declaration"),
                  DiagnosticSpec(locationMarker: "DIAG2", message: "Expected '=' in same type requirement"),
                  DiagnosticSpec(locationMarker: "DIAG2", message: "Expected right-hand type of same type requirement"),
                ])
  }

  func testFuncAfterUnbalancedClosingBrace() {
    AssertParse(
      """
      #^DIAG^#}
      func foo() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "Unexpected text '}' before function")
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

    AssertParse("class T where t#^DIAG^#",
                diagnostics: [
                  DiagnosticSpec(message: "Expected '=' in same type requirement"),
                  DiagnosticSpec(message: "Expected right-hand type of same type requirement"),
                  DiagnosticSpec(message: "Expected '{' to start class"),
                  DiagnosticSpec(message: "Expected '}' to end class"),
                ])
    AssertParse("class B<where g#^DIAG^#",
                diagnostics: [
                  DiagnosticSpec(message: "Expected '=' in same type requirement"),
                  DiagnosticSpec(message: "Expected right-hand type of same type requirement"),
                  DiagnosticSpec(message: "Expected '>' to end generic parameter clause"),
                  DiagnosticSpec(message: "Expected '{' to start class"),
                  DiagnosticSpec(message: "Expected '}' to end class"),
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
      #^DIAG^#}
      actor Foo {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "Unexpected text '}' before actor")
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
      "protocol P{#^DIAG_1^#{}case#^DIAG_2^#",
      diagnostics: [
        DiagnosticSpec(locationMarker: "DIAG_1", message: "Unexpected text '{}' before enum case"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "Expected identifier in enum case"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "Expected '}' to end protocol"),
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

    AssertParse("_ = foo?.description")

    AssertParse(
      "_ = foo/* */?.description#^DIAG^#",
      diagnostics: [
        DiagnosticSpec(message: "Expected ':' after '? ...' in ternary expression"),
        DiagnosticSpec(message: "Expected expression"),
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
      open open(set) var openProp = 0
      public public(set) var publicProp = 0
      internal internal(set) var internalProp = 0
      fileprivate fileprivate(set) var fileprivateProp = 0
      private private(set) var privateProp = 0
      internal(set) var defaultProp = 0
      """
    )

    AssertParse(
      """
      private(#^DIAG^#get) var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "Expected 'set' in modifier"),
        DiagnosticSpec(message: "Unexpected text 'get' in modifier")
      ]
    )

    AssertParse(
      """
      private(#^DIAG^#+
        set
      ) var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "Expected 'set' in modifier"),
        DiagnosticSpec(message: "Expected ')' to end modifier"),
        // FIXME: It should print `+` as detail of text.
        DiagnosticSpec(message: "Unexpected text in variable")
      ]
    )

    AssertParse(
      """
      private(#^DIAG^#get, set) var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "Unexpected text 'get,' in modifier")
      ]
    )

    AssertParse(
      """
      private(#^DIAG^#get: set) var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "Unexpected text 'get:' in modifier")
      ]
    )

    AssertParse(
      """
      #^DIAG^#private(
      """,
      diagnostics: [
        DiagnosticSpec(message: "Extraneous 'private(' at top level")
      ]
    )

    AssertParse(
      """
      private(#^DIAG^#var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "Expected 'set' in modifier"),
        DiagnosticSpec(message: "Expected ')' to end modifier")
      ]
    )

    AssertParse(
      """
      private(#^LEFT^#get, set#^RIGHT^#, didSet) var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "LEFT", message: "Unexpected text 'get,' in modifier"),
        DiagnosticSpec(locationMarker: "RIGHT", message: "Unexpected text ', didSet' in modifier")
      ]
    )

    AssertParse(
      """
      private(#^DIAG^#get, didSet var a = 0
      """,
      diagnostics: [
        DiagnosticSpec(message: "Expected 'set' in modifier"),
        DiagnosticSpec(message: "Expected ')' to end modifier"),
        DiagnosticSpec(message: "Unexpected text 'get, didSet' in variable")
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
        public#^DIAG^#
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "Expected declaration after 'public' modifier in struct")
      ]
    )
  }

  func testMissingColonInFunctionSignature() {
    AssertParse(
      "(first second #^DIAG^#Int)",
      { $0.parseFunctionSignature() },
      diagnostics: [
        DiagnosticSpec(message: "Expected ':' in function parameter")
      ]
    )
  }

  func testExtraArgumentLabelsInFunctionSignature() {
    AssertParse(
      "(first second #^DIAG^#third fourth: Int)",
      { $0.parseFunctionSignature() },
      diagnostics: [
        DiagnosticSpec(message: "Unexpected text 'third fourth' in function parameter")
      ]
    )
  }

  func testMissingClosingParenInFunctionSignature() {
    AssertParse(
      "(first second: Int#^DIAG^#",
      { $0.parseFunctionSignature() },
      diagnostics: [
        DiagnosticSpec(message: "Expected ')' to end parameter clause")
      ]
    )
  }

  func testMissingOpeningParenInFunctionSignature() {
    AssertParse(
      "#^DIAG^#first second: Int)",
      { $0.parseFunctionSignature() },
      diagnostics: [
        DiagnosticSpec(message: "Expected '(' to start parameter clause")
      ]
    )
  }

  func testNoParamsForFunction() {
    AssertParse(
      """
      class MyClass {
        func withoutParameters#^DIAG^#

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
        DiagnosticSpec(message: "Expected argument list in function declaration")
      ]
    )
  }

  func testThrowsInWrongLocation() {
    AssertParse(
      "() -> #^DIAG^#throws Int",
      { $0.parseFunctionSignature() },
      diagnostics: [
        DiagnosticSpec(message: "'throws' may only occur before '->'", fixIts: ["Move 'throws' before '->'"])
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
      #^DIAG^#}
      """,
      diagnostics: [
        DiagnosticSpec(message: "Extraneous '}' at top level")
      ]
    )
  }

  func testMissingSubscriptReturnClause() {
    AssertParse(
      """
      struct Foo {
        subscript(x: String) #^DIAG^#{}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "Expected '->' in subscript"),
        DiagnosticSpec(message: "Expected return type in subscript"),
      ]
    )
  }

  func testClassWithLeadingNumber() {
    AssertParse(
      """
      class #^CLASS_NAME^#23class {
        func #^FUNC_NAME^#24method() {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "CLASS_NAME", message: "identifier can only start with a letter or underscore, not a number"),
        DiagnosticSpec(locationMarker: "FUNC_NAME", message: "identifier can only start with a letter or underscore, not a number"),
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
      struct S {#^EXPECTED_DECL^#
        #^UNEXPECTED_TEXT^#/ ###line 25 "line-directive.swift"
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "EXPECTED_DECL", message: "Expected declaration after '{' in struct"),
        DiagnosticSpec(locationMarker: "UNEXPECTED_TEXT", message: #"Unexpected text '/ ###line 25 "line-directive.swift"' in struct"#)
      ]
    )
  }

  func testBogusProtocolRequirements() {
    AssertParse(
      """
      protocol P {
        var prop : Int { get #^DIAG^#bogus rethrows set }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "Unexpected text 'bogus rethrows set' in variable")
      ]
    )
  }

  func testTextRecovery() {
    AssertParse(
      """
      Lorem ipsum dolor sit amet#^DIAG^#, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
      """,
      diagnostics: [
        DiagnosticSpec(message: "Extraneous code at top level"),
      ]
    )
  }

  func testRecoverOneExtraLabel() {
    AssertParse(
      "(first second #^DIAG^#third: Int)",
      { $0.parseFunctionSignature() },
      substructure: Syntax(FunctionParameterSyntax(
        attributes: nil,
        isolatedToken: nil,
        constToken: nil,
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
        DiagnosticSpec(message: "Unexpected text 'third' in function parameter")
      ]
    )
  }

  func testRecoverTwoExtraLabels() {
    AssertParse(
      "(first second #^DIAG^#third fourth: Int)",
      { $0.parseFunctionSignature() },
      substructure: Syntax(FunctionParameterSyntax(
        attributes: nil,
        isolatedToken: nil,
        constToken: nil,
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
        DiagnosticSpec(message: "Unexpected text 'third fourth' in function parameter")
      ]
    )
  }

  func testDontRecoverFromDeclKeyword() {
    AssertParse(
      "func foo(first second #^MISSING_COLON^#third #^MISSING_RPAREN^#struct#^MISSING_IDENTIFIER^##^BRACES^#: Int) {}",
      substructure: Syntax(FunctionParameterSyntax(
        attributes: nil,
        isolatedToken: nil,
        constToken: nil,
        firstName: .identifier("first"),
        secondName: .identifier("second"),
        colon: .colonToken(presence: .missing),
        type: TypeSyntax(SimpleTypeIdentifierSyntax(name: .identifier("third"), genericArgumentClause: nil)),
        ellipsis: nil,
        defaultArgument: nil,
        trailingComma: nil
      )),
      diagnostics: [
        DiagnosticSpec(locationMarker: "MISSING_COLON", message: "Expected ':' in function parameter"),
        DiagnosticSpec(locationMarker: "MISSING_RPAREN", message: "Expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "MISSING_IDENTIFIER", message: "Expected identifier in struct"),
        DiagnosticSpec(locationMarker: "BRACES", message: "Expected '{' to start struct"),
        DiagnosticSpec(locationMarker: "BRACES", message: "Expected '}' to end struct"),
        DiagnosticSpec(locationMarker: "BRACES", message: "Extraneous ': Int) {}' at top level"),
      ]
    )
  }

  func testRecoverFromParens() {
    AssertParse(
      "(first second #^DIAG^#[third fourth]: Int)",
      { $0.parseFunctionSignature() },
      substructure: Syntax(FunctionParameterSyntax(
        attributes: nil,
        isolatedToken: nil,
        constToken: nil,
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
        DiagnosticSpec(message: "Unexpected text '[third fourth]' in function parameter")
      ]
    )
  }

  func testDontRecoverFromUnbalancedParens() {
    AssertParse(
      "func foo(first second #^COLON^#[third #^END_ARRAY^#fourth: Int) {}",
      substructure: Syntax(FunctionParameterSyntax(
        attributes: nil,
        isolatedToken: nil,
        constToken: nil,
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
        DiagnosticSpec(locationMarker: "COLON", message: "Expected ':' in function parameter"),
        DiagnosticSpec(locationMarker: "END_ARRAY" , message: "Expected ']' to end array type"),
        DiagnosticSpec(locationMarker: "END_ARRAY", message: "Unexpected text 'fourth: Int' in parameter clause")
      ]
    )
  }

  func testDontRecoverIfNewlineIsBeforeColon() {
    AssertParse(
      """
      func foo(first second #^COLON^#third#^RPAREN^#
      #^EXTRANEOUS^#: Int) {}
      """,
      substructure: Syntax(FunctionParameterSyntax(
        attributes: nil,
        isolatedToken: nil,
        constToken: nil,
        firstName: TokenSyntax.identifier("first"),
        secondName: TokenSyntax.identifier("second"),
        colon: TokenSyntax(.colon, presence: .missing),
        type: TypeSyntax(SimpleTypeIdentifierSyntax(name: TokenSyntax.identifier("third"), genericArgumentClause: nil)),
        ellipsis: nil,
        defaultArgument: nil,
        trailingComma: nil
      )),
      diagnostics: [
        DiagnosticSpec(locationMarker: "COLON", message: "Expected ':' in function parameter"),
        DiagnosticSpec(locationMarker: "RPAREN", message: "Expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "EXTRANEOUS", message: "Extraneous ': Int) {}' at top level")
      ]
    )
  }
  
  func testMalforedStruct() {
    AssertParse(
      """
      struct n#^OPENING_BRACE^#
      #if#^AFTER_POUND_IF^#
      @#^END^#
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "OPENING_BRACE", message: "Expected '{' to start struct"),
        DiagnosticSpec(locationMarker: "AFTER_POUND_IF", message: "Expected condition of conditional compilation clause"),
        DiagnosticSpec(locationMarker: "END", message: "Expected declaration after attribute in conditional compilation clause"),
        DiagnosticSpec(locationMarker: "END", message: "Expected name of attribute"),
        DiagnosticSpec(locationMarker: "END", message: "Expected '#endif' in conditional compilation block"),
        DiagnosticSpec(locationMarker: "END", message: "Expected '}' to end struct")
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
    AssertParse("#^DIAG_1^#}class C#^DIAG_2^#",
                diagnostics: [
                  DiagnosticSpec(locationMarker: "DIAG_1", message: "Unexpected text '}' before class"),
                  DiagnosticSpec(locationMarker: "DIAG_2", message: "Expected '{' to start class"),
                  DiagnosticSpec(locationMarker: "DIAG_2", message: "Expected '}' to end class"),
                ])
    AssertParse("#^DIAG_1^#}enum C#^DIAG_2^#",
                diagnostics: [
                  DiagnosticSpec(locationMarker: "DIAG_1", message: "Unexpected text '}' before enum"),
                  DiagnosticSpec(locationMarker: "DIAG_2", message: "Expected '{' to start enum"),
                  DiagnosticSpec(locationMarker: "DIAG_2", message: "Expected '}' to end enum"),
                ])
    AssertParse("#^DIAG_1^#}protocol C#^DIAG_2^#",
                diagnostics: [
                  DiagnosticSpec(locationMarker: "DIAG_1", message: "Unexpected text '}' before protocol"),
                  DiagnosticSpec(locationMarker: "DIAG_2", message: "Expected '{' to start protocol"),
                  DiagnosticSpec(locationMarker: "DIAG_2", message: "Expected '}' to end protocol"),
                ])
    AssertParse("#^DIAG_1^#}actor C#^DIAG_2^#",
                diagnostics: [
                  DiagnosticSpec(locationMarker: "DIAG_1", message: "Unexpected text '}' before actor"),
                  DiagnosticSpec(locationMarker: "DIAG_2", message: "Expected '{' to start actor"),
                  DiagnosticSpec(locationMarker: "DIAG_2", message: "Expected '}' to end actor"),
                ])
    AssertParse("#^DIAG_1^#}struct C#^DIAG_2^#",
                diagnostics: [
                  DiagnosticSpec(locationMarker: "DIAG_1", message: "Unexpected text '}' before struct"),
                  DiagnosticSpec(locationMarker: "DIAG_2", message: "Expected '{' to start struct"),
                  DiagnosticSpec(locationMarker: "DIAG_2", message: "Expected '}' to end struct"),
                ])
    AssertParse("#^DIAG_1^#}func C#^DIAG_2^#",
                diagnostics: [
                  DiagnosticSpec(locationMarker: "DIAG_1", message: "Unexpected text '}' before function"),
                  DiagnosticSpec(locationMarker: "DIAG_2", message: "Expected argument list in function declaration"),
                ])
    AssertParse("#^DIAG_1^#}init#^DIAG_2^#",
                diagnostics: [
                  DiagnosticSpec(locationMarker: "DIAG_1", message: "Unexpected text '}' before initializer"),
                  DiagnosticSpec(locationMarker: "DIAG_2", message: "Expected argument list in function declaration"),
                ])
    AssertParse("#^DIAG_1^#}subscript#^DIAG_2^#",
                diagnostics: [
                  DiagnosticSpec(locationMarker: "DIAG_1", message: "Unexpected text '}' before subscript"),
                  DiagnosticSpec(locationMarker: "DIAG_2", message: "Expected argument list in function declaration"),
                  DiagnosticSpec(locationMarker: "DIAG_2", message: "Expected '->' in subscript"),
                  DiagnosticSpec(locationMarker: "DIAG_2", message: "Expected return type in subscript"),
                ])
  }

  func testBogusTypeDeclName() {
    AssertParse("associatedtype #^DIAG_BEFORE^#5s#^DIAG_AFTER^#",
                diagnostics: [
                  DiagnosticSpec(locationMarker: "DIAG_BEFORE", message: "identifier can only start with a letter or underscore, not a number"),
                ])
  }

  func testModifiedParameter() {
    AssertParse(
      #"""
      func const(_const _ map: String) {}
      func isolated(isolated _ map: String) {}
      func isolatedConst(isolated _const _ map: String) {}
      func nonEphemeralIsolatedConst(@_nonEmphemeral isolated _const _ map: String) {}
      """#)

    AssertParse(
      #"""
      func const(_const map: String) {}
      func isolated(isolated map: String) {}
      func isolatedConst(isolated _const map: String) {}
      """#)

    AssertParse(
      #"""
      func const(_const x: String) {}
      func isolated(isolated: String) {}
      func isolatedConst(isolated _const: String) {}
      """#)
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
}

extension Parser.DeclAttributes {
  static let empty = Parser.DeclAttributes(attributes: nil, modifiers: nil)
}

