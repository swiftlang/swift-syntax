@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) import SwiftParser
import XCTest

final class DeclarationTests: XCTestCase {
  func testImports() throws {
    try AssertParse({ $0.parseImportDeclaration(.empty) }) {
      "import Foundation"
    }

    try AssertParse({ $0.parseDeclaration() }) {
      "@_spi(Private) import SwiftUI"
    }

    try AssertParse({ $0.parseDeclaration() }) {
      "@_exported import class Foundation.Thread"
    }

    try AssertParse({ $0.parseDeclaration() }) {
      """
      @_private(sourceFile: "YetAnotherFile.swift") import Foundation
      """
    }
  }
  func testStructParsing() throws {
    try AssertParse({ $0.parseStructDeclaration(.empty) }) {
      """
      struct Foo {
      }
      """
    }
  }

  func testFuncParsing() throws {
    try AssertParse({ $0.parseFuncDeclaration(.empty) }) {
      """
      func foo() {
      }
      """
    }

    try AssertParse({ $0.parseFuncDeclaration(.empty) }) {
      """
      func foo() -> Slice<MinimalMutableCollection<T>> {
      }
      """
    }

    try AssertParse({ $0.parseSourceFile() }) {
      """
      func onEscapingAutoclosure(_ fn: @Sendable @autoclosure @escaping () -> Int) { }
      func onEscapingAutoclosure2(_ fn: @escaping @autoclosure @Sendable () -> Int) { }
      func bar(_ : String) async throws -> [[String]: Array<String>] {}
      func tupleMembersFunc() -> (Type.Inner, Type2.Inner2) {}
      func myFun<S: T & U>(var1: S) {
        // do stuff
      }
      """
    }
  }

  func testClassParsing() throws {
    try AssertParse({ $0.parseClassDeclaration(.empty) }) {
      """
      class Foo {
      }
      """
    }

    try AssertParse({ $0.parseSourceFile() }) {
       """
       @dynamicMemberLookup @available(swift 4.0)
       public class MyClass {
         let A: Int
         let B: Double
       }
       """
    }

    try AssertParse({ $0.parseGenericParameters() }) {
      "<@NSApplicationMain T: AnyObject>"
    }
  }

  func testActorParsing() throws {
    try AssertParse({ $0.parseActorDeclaration(.empty) }) {
      """
      actor Foo {
      }
      """
    }

    try AssertParse({ $0.parseActorDeclaration(.empty) }) {
      """
      actor Foo {
        nonisolated init?() throws {
          for (x, y, z) in self.triples {
            assert(isSafe)
          }
        }
        subscript(_ param: String) -> Int {
          return 42
        }
      }
      """
    }
  }

  func testProtocolParsing() throws {
    try AssertParse({ $0.parseProtocolDeclaration(.empty) }) {
      """
      protocol Foo {
      }
      """
    }

    try AssertParse({ $0.parseProtocolDeclaration(.empty) }) {
      """
      protocol P { init() }
      """
    }

    try AssertParse({ $0.parseProtocolDeclaration(.empty) }) {
      """
      protocol P {
        associatedtype Foo: Bar where X.Y == Z.W.W.Self

        var foo: Bool { get set }
        subscript<R>(index: Int) -> R
      }
      """
    }
  }

  func testVariableDeclarations() throws {
    try AssertParse({ $0.parseDeclaration() }) {
      """
      private unowned(unsafe) var foo: Int
      """
    }

    try AssertParse({ $0.parseSourceFile() }) {
      "_ = foo/* */?.description"
    }
    
    try AssertParse({ $0.parseLetOrVarDeclaration(.empty) }) {
      "var a = Array<Int>?(from: decoder)"
    }
    
    try AssertParse({ $0.parseSourceFile() }) {
      "@Wrapper var café = 42"
    }

    try AssertParse({ $0.parseLetOrVarDeclaration(.empty) }) {
      """
      var x: T {
        get async throws {
          foo()
          bar()
        }
      }
      """
    }

    try AssertParse({ $0.parseLetOrVarDeclaration(.empty) }) {
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
    }

    try AssertParse({ $0.parseSourceFile() }) {
      """
      async let a = fetch("1.jpg")
      async let b: Image = fetch("2.jpg")
      async let secondPhotoToFetch = fetch("3.jpg")
      async let theVeryLastPhotoWeWant = fetch("4.jpg")
      """
    }
  }

  func testTypealias() throws {
    try AssertParse({ $0.parseTypealiasDeclaration(.empty) }) {
      """
      typealias Foo = Int
      """
    }

    try AssertParse({ $0.parseTypealiasDeclaration(.empty) }) {
      """
      typealias MyAlias = (_ a: Int, _ b: Double, _ c: Bool, _ d: String) -> Bool
      """
    }

    try AssertParse({ $0.parseSourceFile() }) {
      """
      typealias A = @attr1 @attr2(hello) (Int) -> Void
      """
    }
  }

  func testPrecedenceGroup() throws {
    try AssertParse({ $0.parsePrecedenceGroupDeclaration(.empty) }) {
      """
      precedencegroup FooGroup {
        higherThan: Group1, Group2
        lowerThan: Group3, Group4
        associativity: left
        assignment: false
      }
      """
    }

    try AssertParse({ $0.parsePrecedenceGroupDeclaration(.empty) }) {
      """
      precedencegroup FunnyPrecedence {
       associativity: left
       higherThan: MultiplicationPrecedence
      }
      """
    }
  }

  func testOperators() throws {
    try AssertParse({ $0.parseDeclaration() }) {
      """
      infix operator *-* : FunnyPrecedence
      """
    }
  }

  func testObjCAttribute() throws {
    try AssertParse({ $0.parseSourceFile() }) {
      """
      @objc(
        thisMethodHasAVeryLongName:
        foo:
        bar:
      )
      func f() {}
      """
    }
  }

  func testDifferentiableAttribute() throws {
    try AssertParse({ $0.parseSourceFile() }) {
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
    }
  }

  func testParsePoundError() throws {
    try AssertParse({ $0.parsePoundDiagnosticDeclaration() }) {
      #"#error("Unsupported platform")"#
    }
  }

  func testParsePoundWarning() throws {
    try AssertParse({ $0.parsePoundDiagnosticDeclaration() }) {
      #"#warning("Unsupported platform")"#
    }
  }

  func testParseSpecializeAttribute() throws {
    try AssertParse({ $0.parseSourceFile() }) {
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
    }

    try AssertParse({ $0.parseSourceFile() }) {
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
    }
  }

  func testParseDynamicReplacement() throws {
    try AssertParse({ $0.parseDeclaration() }) {
      """
      @_dynamicReplacement(for: dynamic_replaceable())
      func replacement() {
        dynamic_replaceable()
      }
      """
    }

    try AssertParse({ $0.parseDeclaration() }) {
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
    }

    try AssertParse({ $0.parseDeclaration() }) {
      """
      @_dynamicReplacement(for: dynamic_replaceable_var)
      var r : Int {
        return 0
      }
      """
    }

    try AssertParse({ $0.parseDeclaration() }) {
      """
      @_dynamicReplacement(for: init(x:))
      init(y: Int) {
        self.init(x: y + 1)
      }
      """
    }
  }

  func testEnumParsing() throws {
    try AssertParse({ $0.parseEnumDeclaration(.empty) }) {
      """
      enum Content {
        case keyPath(KeyPath<FocusedValues, Value?>)
        case keyPath(KeyPath<FocusedValues, Binding<Value>?>)
        case value(Value?)
      }
      """
    }
  }

  func testStandaloneModifier() throws {
    try AssertParse({ $0.parseSourceFile() }) {
      """
      struct a {
        public
      }
      """
    }
  }
}

extension Parser.DeclAttributes {
  static let empty = Parser.DeclAttributes(attributes: nil, modifiers: nil)
}

