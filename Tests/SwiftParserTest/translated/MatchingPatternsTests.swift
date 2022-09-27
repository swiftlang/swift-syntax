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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: invalid redeclaration of 'a'
        // TODO: Old parser expected note on line 2: 'a' previously declared here
        // TODO: Old parser expected warning on line 2: variable 'a' was never used; consider replacing with '_' or removing it
        // TODO: Old parser expected warning on line 2: variable 'a' was never used; consider replacing with '_' or removing it
        // TODO: Old parser expected warning on line 4: case is already handled by previous patterns; consider removing it
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: switch must be exhaustive
        // TODO: Old parser expected note on line 1: do you want to add a default clause?
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 4: 'Twain' declared here
        // TODO: Old parser expected error on line 10: pattern with associated values does not match enum case 'Naught'
        // TODO: Old parser expected note on line 10: remove associated values to make the pattern match, Fix-It replacements: 17 - 19 = ''
        // TODO: Old parser expected error on line 11: pattern with associated values does not match enum case 'Naught'
        // TODO: Old parser expected note on line 11: remove associated values to make the pattern match, Fix-It replacements: 17 - 20 = ''
        // TODO: Old parser expected error on line 12: pattern with associated values does not match enum case 'Naught'
        // TODO: Old parser expected note on line 12: remove associated values to make the pattern match, Fix-It replacements: 17 - 23 = ''
        // TODO: Old parser expected error on line 15: tuple pattern cannot match values of the non-tuple type 'T'
        // TODO: Old parser expected error on line 17: tuple pattern cannot match values of the non-tuple type 'T'
        // TODO: Old parser expected error on line 19: tuple pattern has the wrong length for tuple type '(T, T)'
        // TODO: Old parser expected warning on line 20: enum case 'Twain' has 2 associated values; matching them as a tuple is deprecated
        // TODO: Old parser expected error on line 22: tuple pattern has the wrong length for tuple type '(T, T)'
        // TODO: Old parser expected error on line 26: type 'Foo' has no member 'Naught'
      ]
    )
  }

  func testMatchingPatterns13() {
    AssertParse(
      """
      var n : Voluntary<Int> = .Naught
      if case let .Naught(value) = n {} 
      if case let .Naught(value1, value2, value3) = n {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: pattern with associated values does not match enum case 'Naught'
        // TODO: Old parser expected note on line 2: remove associated values to make the pattern match, Fix-It replacements: 20 - 27 = ''
        // TODO: Old parser expected error on line 3: pattern with associated values does not match enum case 'Naught'
        // TODO: Old parser expected note on line 3: remove associated values to make the pattern match, Fix-It replacements: 20 - 44 = ''
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected note on line -47: 'Twain' declared here
        // TODO: Old parser expected error on line 2: enum case 'A' is not a member of type 'Voluntary<Int>'
        // TODO: Old parser expected error on line 5: pattern with associated values does not match enum case 'Naught'
        // TODO: Old parser expected note on line 5: remove associated values to make the pattern match, Fix-It replacements: 27 - 29 = ''
        // TODO: Old parser expected error on line 6: pattern with associated values does not match enum case 'Naught'
        // TODO: Old parser expected note on line 6: remove associated values to make the pattern match, Fix-It replacements: 27 - 33 = ''
        // TODO: Old parser expected error on line 12: tuple pattern cannot match values of the non-tuple type 'Int'
        // TODO: Old parser expected warning on line 19: enum case 'Twain' has 2 associated values; matching them as a tuple is deprecated
        // TODO: Old parser expected error on line 21: tuple pattern has the wrong length for tuple type '(Int, Int)'
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: type 'Int' has no member 'Foo'
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 8: switch must be exhaustive
        // TODO: Old parser expected note on line 8: missing case: '.Mere(_)'
        // TODO: Old parser expected note on line 8: missing case: '.Twain(_, _)'
        // TODO: Old parser expected warning on line 10: case is already handled by previous patterns; consider removing it
        // TODO: Old parser expected warning on line 11: case is already handled by previous patterns; consider removing it
        // TODO: Old parser expected warning on line 12: case is already handled by previous patterns; consider removing it
        // TODO: Old parser expected warning on line 13: case is already handled by previous patterns; consider removing it
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: switch must be exhaustive
        // TODO: Old parser expected note on line 2: missing case: '.Mere(_)'
        // TODO: Old parser expected note on line 2: missing case: '.Twain(_, _)'
        // TODO: Old parser expected warning on line 4: case is already handled by previous patterns; consider removing it
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 3: case is already handled by previous patterns; consider removing it
        // TODO: Old parser expected warning on line 4: case is already handled by previous patterns; consider removing it
        // TODO: Old parser expected warning on line 7: case is already handled by previous patterns; consider removing it
        // TODO: Old parser expected warning on line 8: case is already handled by previous patterns; consider removing it
        // TODO: Old parser expected warning on line 9: case is already handled by previous patterns; consider removing it
        // TODO: Old parser expected warning on line 10: case is already handled by previous patterns; consider removing it
        // TODO: Old parser expected warning on line 11: case is already handled by previous patterns; consider removing it
      ]
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
      """#,
      diagnostics: [
        // TODO: Old parser expected warning on line 9: case is already handled by previous patterns; consider removing it
        // TODO: Old parser expected warning on line 12: case is already handled by previous patterns; consider removing it
        // TODO: Old parser expected warning on line 15: case is already handled by previous patterns; consider removing it
        // TODO: Old parser expected warning on line 18: case is already handled by previous patterns; consider removing it
        // TODO: Old parser expected warning on line 21: case is already handled by previous patterns; consider removing it
        // TODO: Old parser expected warning on line 24: case is already handled by previous patterns; consider removing it
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: collection downcast in cast pattern is not implemented; use an explicit downcast to '[Derived]' instead
        // TODO: Old parser expected error on line 4: collection downcast in cast pattern is not implemented; use an explicit downcast to '[Derived]' instead
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 5: case is already handled by previous patterns; consider removing it
      ]
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
        // TODO: Old parser expected error on line 2: cannot convert value of type 'Int?' to specified type '(responseObject: _)'
        DiagnosticSpec(message: "unexpected text '?' in tuple pattern"),
      ]
    )
  }

}
