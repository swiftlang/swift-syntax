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
}

extension Parser.DeclAttributes {
  static let empty = Parser.DeclAttributes(attributes: nil, modifiers: nil)
}

