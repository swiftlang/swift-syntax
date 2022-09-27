// This test file has been translated from swift/test/Parse/matching_patterns.swift

import XCTest

final class MatchingPatternsTests: XCTestCase {
  func testMatchingPatterns1() {
    AssertParse(
      """
      import imported_enums
      """
    )
  }

  func testMatchingPatterns2() {
    AssertParse(
      """
      // TODO: Implement tuple equality in the library.
      // BLOCKED: <rdar://problem/13822406>
      func ~= (x: (Int,Int,Int), y: (Int,Int,Int)) -> Bool {
        return true
      }
      """
    )
  }

  func testMatchingPatterns3() {
    AssertParse(
      """
      var x:Int
      """
    )
  }

  func testMatchingPatterns4() {
    AssertParse(
      """
      func square(_ x: Int) -> Int { return x*x }
      """
    )
  }

  func testMatchingPatterns5() {
    AssertParse(
      """
      struct A<B> {
        struct C<D> { }
      }
      """
    )
  }

  func testMatchingPatterns6() {
    AssertParse(
      #"""
      switch x {
      // Expressions as patterns.
      case 0:
        ()
      case 1 + 2:
        ()
      case square(9):
        ()
      // 'var' and 'let' patterns.
      case var a:
        a = 1
      case let a:
        a = 1         
      case var var a: 
        a += 1
      case var let a: 
        print(a, terminator: "")
      case var (var b): 
        b += 1
      // 'Any' pattern.
      case _:
        ()
      // patterns are resolved in expression-only positions are errors.
      case 1 + (_): 
        ()
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 13: cannot assign
        // TODO: Old parser expected error on line 14: 'var' cannot appear nested inside another 'var' or 'let' pattern
        // TODO: Old parser expected error on line 16: 'let' cannot appear nested inside another 'var' or 'let' pattern
        // TODO: Old parser expected error on line 18: 'var' cannot appear nested inside another 'var'
        // TODO: Old parser expected error on line 24: '_' can only appear in a pattern or on the left side of an assignment
      ]
    )
  }

  func testMatchingPatterns7() {
    AssertParse(
      """
      switch (x,x) {
      case (var a, var a): 
        fallthrough
      case _: 
        ()
      }
      """
    )
  }

  func testMatchingPatterns8() {
    AssertParse(
      """
      var e : Any = 0
      """
    )
  }

  func testMatchingPatterns9() {
    AssertParse(
      """
      switch e { 
      // 'is' pattern.
      case is Int,
           is A<Int>,
           is A<Int>.C<Int>,
           is (Int, Int),
           is (a: Int, b: Int):
        ()
      }
      """
    )
  }

  func testMatchingPatterns10() {
    AssertParse(
      """
      // Enum patterns.
      enum Foo { case A, B, C }
      """
    )
  }

  func testMatchingPatterns11() {
    AssertParse(
      """
      func == <T>(_: Voluntary<T>, _: Voluntary<T>) -> Bool { return true }
      """
    )
  }

  func testMatchingPatterns12() {
    AssertParse(
      """
      enum Voluntary<T> : Equatable {
        case Naught
        case Mere(T)
        case Twain(T, T)
        func enumMethod(_ other: Voluntary<T>, foo: Foo) {
          switch self {
          case other:
            ()
          case .Naught,
               .Naught(), 
               .Naught(_), 
               .Naught(_, _): 
            ()
          case .Mere,
               .Mere(), 
               .Mere(_),
               .Mere(_, _): 
            ()
          case .Twain(), 
               .Twain(_), 
               .Twain(_, _),
               .Twain(_, _, _): 
            ()
          }
          switch foo {
          case .Naught: 
            ()
          case .A, .B, .C:
            ()
          }
        }
      }
      """
    )
  }

  func testMatchingPatterns13() {
    AssertParse(
      """
      var n : Voluntary<Int> = .Naught
      if case let .Naught(value) = n {} 
      if case let .Naught(value1, value2, value3) = n {}
      """
    )
  }

  func testMatchingPatterns14() {
    AssertParse(
      """
      switch n {
      case Foo.A: 
        ()
      case Voluntary<Int>.Naught,
           Voluntary<Int>.Naught(), 
           Voluntary<Int>.Naught(_, _), 
           Voluntary.Naught,
           .Naught:
        ()
      case Voluntary<Int>.Mere,
           Voluntary<Int>.Mere(_),
           Voluntary<Int>.Mere(_, _), 
           Voluntary.Mere,
           Voluntary.Mere(_),
           .Mere,
           .Mere(_):
        ()
      case .Twain,
           .Twain(_), 
           .Twain(_, _),
           .Twain(_, _, _): 
        ()
      }
      """
    )
  }

  func testMatchingPatterns15() {
    AssertParse(
      """
      var notAnEnum = 0
      """
    )
  }

  func testMatchingPatterns16() {
    AssertParse(
      """
      switch notAnEnum {
      case .Foo: 
        ()
      }
      """
    )
  }

  func testMatchingPatterns17() {
    AssertParse(
      """
      struct ContainsEnum {
        enum Possible<T> {
          case Naught
          case Mere(T)
          case Twain(T, T)
        }
        func member(_ n: Possible<Int>) {
          switch n { 
          case ContainsEnum.Possible<Int>.Naught,
               ContainsEnum.Possible.Naught, 
               Possible<Int>.Naught, 
               Possible.Naught, 
               .Naught: 
            ()
          }
        }
      }
      """
    )
  }

  func testMatchingPatterns18() {
    AssertParse(
      """
      func nonmemberAccessesMemberType(_ n: ContainsEnum.Possible<Int>) {
        switch n { 
        case ContainsEnum.Possible<Int>.Naught,
             .Naught: 
          ()
        }
      }
      """
    )
  }

  func testMatchingPatterns19() {
    AssertParse(
      """
      var m : ImportedEnum = .Simple
      """
    )
  }

  func testMatchingPatterns20() {
    AssertParse(
      """
      switch m {
      case imported_enums.ImportedEnum.Simple,
           ImportedEnum.Simple, 
           .Simple: 
        ()
      case imported_enums.ImportedEnum.Compound,
           imported_enums.ImportedEnum.Compound(_), 
           ImportedEnum.Compound, 
           ImportedEnum.Compound(_), 
           .Compound, 
           .Compound(_): 
        ()
      }
      """
    )
  }

  func testMatchingPatterns21() {
    AssertParse(
      """
      // Check that single-element tuple payloads work sensibly in patterns.
      """
    )
  }

  func testMatchingPatterns22() {
    AssertParse(
      """
      enum LabeledScalarPayload {
        case Payload(name: Int)
      }
      """
    )
  }

  func testMatchingPatterns23() {
    AssertParse(
      """
      var lsp: LabeledScalarPayload = .Payload(name: 0)
      func acceptInt(_: Int) {}
      func acceptString(_: String) {}
      """
    )
  }

  func testMatchingPatterns24() {
    AssertParse(
      #"""
      switch lsp {
      case .Payload(0):
        ()
      case .Payload(name: 0):
        ()
      case let .Payload(x):
        acceptInt(x)
        acceptString("\(x)")
      case let .Payload(name: x): 
        acceptInt(x)
        acceptString("\(x)")
      case let .Payload((name: x)): 
        acceptInt(x)
        acceptString("\(x)")
      case .Payload(let (name: x)): 
        acceptInt(x)
        acceptString("\(x)")
      case .Payload(let (name: x)): 
        acceptInt(x)
        acceptString("\(x)")
      case .Payload(let x): 
        acceptInt(x)
        acceptString("\(x)")
      case .Payload((let x)): 
        acceptInt(x)
        acceptString("\(x)")
      }
      """#
    )
  }

  func testMatchingPatterns25() {
    AssertParse(
      """
      // Property patterns.
      """
    )
  }

  func testMatchingPatterns26() {
    AssertParse(
      """
      struct S {
        static var stat: Int = 0
        var x, y : Int
        var comp : Int {
          return x + y
        }
        func nonProperty() {}
      }
      """
    )
  }

  func testMatchingPatterns27() {
    AssertParse(
      """
      // Tuple patterns.
      """
    )
  }

  func testMatchingPatterns28() {
    AssertParse(
      """
      var t = (1, 2, 3)
      """
    )
  }

  func testMatchingPatterns29() {
    AssertParse(
      """
      prefix operator +++
      infix operator +++
      prefix func +++(x: (Int,Int,Int)) -> (Int,Int,Int) { return x }
      func +++(x: (Int,Int,Int), y: (Int,Int,Int)) -> (Int,Int,Int) {
        return (x.0+y.0, x.1+y.1, x.2+y.2)
      }
      """
    )
  }

  func testMatchingPatterns30() {
    AssertParse(
      """
      switch t {
      case (_, var a, 3):
        a += 1
      case var (_, b, 3):
        b += 1
      case var (_, var c, 3): 
        c += 1
      case (1, 2, 3):
        ()
      // patterns in expression-only positions are errors.
      case +++(_, var d, 3):
        ()
      case (_, var e, 3) +++ (1, 2, 3):
        ()
      case (let (_, _, _)) + 1:
        ()
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 6: 'var' cannot appear nested inside another 'var'
        // TODO: Old parser expected error on line 11: '_' can only appear in a pattern or on the left side of an assignment
        // TODO: Old parser expected error on line 13: '_' can only appear in a pattern or on the left side of an assignment
        // TODO: Old parser expected error on line 15: '_' can only appear in a pattern or on the left side of an assignment
      ]
    )
  }

  func testMatchingPatterns31() {
    AssertParse(
      #"""
      // FIXME: We don't currently allow subpatterns for "isa" patterns that
      // require interesting conditional downcasts.
      class Base { }
      class Derived : Base { }
      """#
    )
  }

  func testMatchingPatterns32() {
    AssertParse(
      """
      switch [Derived(), Derived(), Base()] {
      case let ds as [Derived]: 
        ()
      case is [Derived]: 
        ()
      default:
        ()
      }
      """
    )
  }

  func testMatchingPatterns33() {
    AssertParse(
      """
      // Optional patterns.
      let op1 : Int?
      let op2 : Int??
      """
    )
  }

  func testMatchingPatterns34() {
    AssertParse(
      """
      switch op1 {
      case nil: break
      case 1?: break
      case _?: break
      }
      """
    )
  }

  func testMatchingPatterns35() {
    AssertParse(
      """
      switch op2 {
      case nil: break
      case _?: break
      case (1?)?: break
      case (_?)?: break 
      }
      """
    )
  }

  func testMatchingPatterns36() {
    AssertParse(
      #"""
      // <rdar://problem/20365753> Bogus diagnostic "refutable pattern match can fail"
      let (responseObject: Int#^DIAG^#?) = op1
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected ',' separator, Fix-It replacements: 25 - 25 = ','
        // TODO: Old parser expected error on line 2: expected pattern
        DiagnosticSpec(message: "unexpected text '?' in tuple pattern"),
      ]
    )
  }

}
