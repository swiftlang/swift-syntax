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
                  DiagnosticSpec(locationMarker: "DIAG1", message: "Expected '' in function"),
                  DiagnosticSpec(locationMarker: "DIAG1", message: "Expected argument list in function declaration"),
                  DiagnosticSpec(locationMarker: "DIAG2", message: "Expected '=' in same type requirement"),
                ])
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
                  DiagnosticSpec(message: "Expected '{' to start class"),
                  DiagnosticSpec(message: "Expected '}' to end class"),
                ])
    AssertParse("class B<#^DIAG_1^#where g#^DIAG_2^#",
                diagnostics: [
                  DiagnosticSpec(locationMarker: "DIAG_1", message: "Expected '>' to end generic parameter clause"),
                  DiagnosticSpec(locationMarker: "DIAG_2", message: "Expected '=' in same type requirement"),
                  DiagnosticSpec(locationMarker: "DIAG_2", message: "Expected '{' to start class"),
                  DiagnosticSpec(locationMarker: "DIAG_2", message: "Expected '}' to end class"),
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
  }

  func testVariableDeclarations() {
    AssertParse("private unowned(unsafe) var foo: Int")

    AssertParse("_ = foo?.description")

    AssertParse(
      "_ = foo/* */?.description#^DIAG^#",
      diagnostics: [
        DiagnosticSpec(message: "Expected ':' after '? ...' in ternary expression")
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
      async let a = fetch("1.jpg")
      async let b: Image = fetch("2.jpg")
      async let secondPhotoToFetch = fetch("3.jpg")
      async let theVeryLastPhotoWeWant = fetch("4.jpg")
      """
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
        public
      }
      """
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
        DiagnosticSpec(message: "Unexpected text 'third fourth' found in function parameter")
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
      "class ABC { let def = ghi(jkl: mno) } #^DIAG^#}",
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
        // FIXME: This diagnostic should be more contextual
        DiagnosticSpec(message: "Expected '->' in return clause")
      ]
    )
  }

  func testClassWithLeadingNumber() {
    AssertParse(
      """
      class #^DIAG^#23class {
        // expected-error@-1 {{class name can only start with a letter or underscore, not a number}}
        // expected-error@-2 {{'c' is not a valid digit in integer literal}}
        func 24method() {}
        // expected-error@-1 {{function name can only start with a letter or underscore, not a number}}
        // expected-error@-2 {{'m' is not a valid digit in integer literal}}
      }
      """,
      // FIXME: These are simply bad diagnostics. We should be complaining that identifiers cannot start with digits.
      diagnostics: [
        DiagnosticSpec(message: "Expected '' in class"),
        DiagnosticSpec(message: "Expected '{' to start class"),
        DiagnosticSpec(message: "Expected '}' to end class"),
        DiagnosticSpec(message: "Extraneous code at top level"),
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
        #^DIAG^#/ ###line 25 "line-directive.swift"
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: """
            Unexpected text '/ ###line 25 "line-directive.swift"' found in struct
            """
        )
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
        DiagnosticSpec(message: "Unexpected text 'bogus rethrows set' found in variable")
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
        DiagnosticSpec(message: "Unexpected text 'third' found in function parameter")
      ]
    )
  }

  func testRecoverTwoExtraLabels() {
    AssertParse(
      "(first second #^DIAG^#third fourth: Int)",
      { $0.parseFunctionSignature() },
      substructure: Syntax(FunctionParameterSyntax(
        attributes: nil,
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
        DiagnosticSpec(message: "Unexpected text 'third fourth' found in function parameter")
      ]
    )
  }

  func testDontRecoverFromDeclKeyword() {
    AssertParse(
      "func foo(first second #^MISSING_COLON^#third #^MISSING_RPAREN^#struct#^MISSING_IDENTIFIER^##^BRACES^#: Int) {}",
      substructure: Syntax(FunctionParameterSyntax(
        attributes: nil,
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
        // FIXME: We should issues something like "Expected identifier in declaration"
        DiagnosticSpec(locationMarker: "MISSING_IDENTIFIER", message: "Expected '' in struct"),
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
        DiagnosticSpec(message: "Unexpected text '[third fourth]' found in function parameter")
      ]
    )
  }

  func testDontRecoverFromUnbalancedParens() {
    AssertParse(
      "func foo(first second #^COLON^#[third #^END_ARRAY^#fourth: Int) {}",
      substructure: Syntax(FunctionParameterSyntax(
        attributes: nil,
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
        DiagnosticSpec(locationMarker: "END_ARRAY", message: "Unexpected text 'fourth: Int' found in parameter clause")
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
      struct n#^OPENINGBRACES^##if@#^ENDIF^##^CLOSINGBRACES^#
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "OPENINGBRACES", message: "Expected '{' to start struct"),
        DiagnosticSpec(locationMarker: "ENDIF", message: "Expected '#endif' in conditional compilation block"),
        DiagnosticSpec(locationMarker: "CLOSINGBRACES", message: "Expected '}' to end struct")
      ]
    )
  }

  func testDeinitializers() {
    AssertParse("deinit {}", { $0.parseDeinitializerDeclaration(.empty) })
    AssertParse("deinit", { $0.parseDeinitializerDeclaration(.empty) })
  }
}

extension Parser.DeclAttributes {
  static let empty = Parser.DeclAttributes(attributes: nil, modifiers: nil)
}

