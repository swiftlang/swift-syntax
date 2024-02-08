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

// This test file has been translated from swift/test/Parse/matching_patterns.swift

@_spi(ExperimentalLanguageFeatures) import SwiftParser
@_spi(ExperimentalLanguageFeatures) @_spi(RawSyntax) import SwiftSyntax
import XCTest

final class MatchingPatternsTests: ParserTestCase {
  func testMatchingPatterns1() {
    assertParse(
      """
      import imported_enums
      """
    )
  }

  func testMatchingPatterns3() {
    assertParse(
      """
      var x:Int
      """
    )
  }

  func testMatchingPatterns4() {
    assertParse(
      """
      func square(_ x: Int) -> Int { return x*x }
      """
    )
  }

  func testMatchingPatterns5() {
    assertParse(
      """
      struct A<B> {
        struct C<D> { }
      }
      """
    )
  }

  func testMatchingPatterns6() {
    assertParse(
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
      case inout a:
        a = 1
      case _mutating a:
        a = 1
      case _borrowing a:
        a = 1
      case _consuming a:
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
      experimentalFeatures: .referenceBindings
    )
  }

  func testMatchingPatterns7() {
    assertParse(
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
    assertParse(
      """
      var e : Any = 0
      """
    )
  }

  func testMatchingPatterns7a() {
    assertParse(
      """
      switch (x,x) {
      case _borrowing a:
        ()
      }
      """,
      experimentalFeatures: .referenceBindings
    )
  }

  func testMatchingPatterns7b() {
    assertParse(
      """
      switch (x,x) {
      case _mutating a:
        ()
      }
      """,
      experimentalFeatures: .referenceBindings
    )
  }

  func testMatchingPatterns7c() {
    assertParse(
      """
      switch (x,x) {
      case _consuming a:
        ()
      }
      """,
      experimentalFeatures: .referenceBindings
    )
  }

  func testMatchingPatterns9() {
    assertParse(
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
    assertParse(
      """
      // Enum patterns.
      enum Foo { case A, B, C }
      """
    )
  }

  func testMatchingPatterns11() {
    assertParse(
      """
      func == <T>(_: Voluntary<T>, _: Voluntary<T>) -> Bool { return true }
      """
    )
  }

  func testMatchingPatterns12() {
    assertParse(
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
    assertParse(
      """
      var n : Voluntary<Int> = .Naught
      if case let .Naught(value) = n {}
      if case let .Naught(value1, value2, value3) = n {}
      if case inout .Naught(value) = n {}
      if case _mutating .Naught(value) = n {}
      if case _borrowing .Naught(value) = n {}
      if case _consuming .Naught(value) = n {}
      """
    )
  }

  func testMatchingPatterns14() {
    assertParse(
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
    assertParse(
      """
      var notAnEnum = 0
      """
    )
  }

  func testMatchingPatterns16() {
    assertParse(
      """
      switch notAnEnum {
      case .Foo:
        ()
      }
      """
    )
  }

  func testMatchingPatterns17() {
    assertParse(
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
    assertParse(
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
    assertParse(
      """
      var m : ImportedEnum = .Simple
      """
    )
  }

  func testMatchingPatterns20() {
    assertParse(
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
    assertParse(
      """
      // Check that single-element tuple payloads work sensibly in patterns.
      """
    )
  }

  func testMatchingPatterns22() {
    assertParse(
      """
      enum LabeledScalarPayload {
        case Payload(name: Int)
      }
      """
    )
  }

  func testMatchingPatterns23() {
    assertParse(
      """
      var lsp: LabeledScalarPayload = .Payload(name: 0)
      func acceptInt(_: Int) {}
      func acceptString(_: String) {}
      """
    )
  }

  func testMatchingPatterns24() {
    assertParse(
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
      case .Payload(inout x):
        acceptInt(x)
      case .Payload(_mutating x):
        acceptInt(x)
      case .Payload(_borrowing x):
        acceptInt(x)
      case .Payload(_consuming x):
        acceptInt(x)
      }
      """#,
      experimentalFeatures: .referenceBindings
    )
  }

  func testMatchingPatterns25() {
    assertParse(
      """
      // Property patterns.
      """
    )
  }

  func testMatchingPatterns26() {
    assertParse(
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
    assertParse(
      """
      // Tuple patterns.
      """
    )
  }

  func testMatchingPatterns28() {
    assertParse(
      """
      var t = (1, 2, 3)
      """
    )
  }

  func testMatchingPatterns29() {
    assertParse(
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
    assertParse(
      """
      switch t {
      case (_, var a, 3):
        a += 1
      case (_, inout a, 3):
        a += 1
      case (_, _mutating a, 3):
        a += 1
      case (_, _borrowing a, 3):
        a += 1
      case (_, _consuming a, 3):
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
      experimentalFeatures: .referenceBindings
    )
  }

  func testMatchingPatterns31() {
    assertParse(
      #"""
      class Base { }
      class Derived : Base { }
      """#
    )
  }

  func testMatchingPatterns32() {
    assertParse(
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
    assertParse(
      """
      // Optional patterns.
      let op1 : Int?
      let op2 : Int??
      """
    )
  }

  func testMatchingPatterns34() {
    assertParse(
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
    assertParse(
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
    assertParse(
      #"""
      // <rdar://problem/20365753> Bogus diagnostic "refutable pattern match can fail"
      let (responseObject: Int1️⃣?) = op1
      """#,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '?' in tuple pattern")
      ]
    )
  }

  func testIfCaseMatchMutating() {
    assertParse(
      """
      if case _mutating x = y {}
      guard case _mutating z = y else {}
      """,
      experimentalFeatures: .referenceBindings
    )
  }

  func testIfCaseMatchConsuming() {
    assertParse(
      """
      if case _consuming x = y {}
      guard case _consuming z = y else {}
      """,
      experimentalFeatures: .referenceBindings
    )
  }

  func testIfCaseMatchBorrowing() {
    assertParse(
      """
      if case _borrowing x = y {}
      guard case _borrowing z = y else {}
      """,
      experimentalFeatures: .referenceBindings
    )
  }

  func testBorrowingContextualParsing() {
    assertParse(
      """
      switch 42 {
      case _borrowing .foo(): // parses as `_borrowing.foo()` as before
        break
      }
      """,
      substructure: ExprSyntax(DeclReferenceExprSyntax(baseName: .identifier("_borrowing"))),
      experimentalFeatures: .borrowingSwitch
    )

    assertParse(
      """
      switch 42 {
      case _borrowing (): // parses as `_borrowing()` as before
        break
      }
      """,
      substructure: ExprSyntax(DeclReferenceExprSyntax(baseName: .identifier("_borrowing"))),
      experimentalFeatures: .borrowingSwitch
    )

    assertParse(
      """
      switch 42 {
      case _borrowing x: // parses as binding
        break
      }
      """,
      substructure: PatternSyntax(
        ValueBindingPatternSyntax(
          bindingSpecifier: .keyword(._borrowing),
          pattern: PatternSyntax(IdentifierPatternSyntax(identifier: .identifier("x")))
        )
      ),
      experimentalFeatures: .borrowingSwitch
    )

    assertParse(
      """
      switch bar {
      case .payload(_borrowing x): // parses as binding
        break
      }
      """,
      substructure: PatternSyntax(
        ValueBindingPatternSyntax(
          bindingSpecifier: .keyword(._borrowing),
          pattern: PatternSyntax(IdentifierPatternSyntax(identifier: .identifier("x")))
        )
      ),
      experimentalFeatures: .borrowingSwitch
    )

    assertParse(
      """
      switch bar {
      case _borrowing x.member: // parses as var introducer surrounding postfix expression (which never is valid)
        break
      }
      """,
      substructure: PatternSyntax(
        ValueBindingPatternSyntax(
          bindingSpecifier: .keyword(._borrowing),
          pattern: ExpressionPatternSyntax(
            expression: MemberAccessExprSyntax(
              base: DeclReferenceExprSyntax(baseName: .identifier("x")),
              declName: DeclReferenceExprSyntax(baseName: .identifier("member"))
            )
          )
        )
      ),
      experimentalFeatures: .borrowingSwitch
    )
    assertParse(
      """
      switch 42 {
      case let _borrowing: // parses as let binding named '_borrowing'
        break
      }
      """,
      substructure: PatternSyntax(
        ValueBindingPatternSyntax(
          bindingSpecifier: .keyword(.let),
          pattern: PatternSyntax(IdentifierPatternSyntax(identifier: .identifier("_borrowing")))
        )
      ),
      experimentalFeatures: .borrowingSwitch
    )
    assertParse(
      """
      switch 42 {
      case _borrowing + _borrowing: // parses as expr pattern
        break
      }
      """,
      substructure: ExprSyntax(DeclReferenceExprSyntax(baseName: .identifier("_borrowing"))),
      experimentalFeatures: .borrowingSwitch
    )
    assertParse(
      """
      switch 42 {
      case _borrowing(let _borrowing): // parses as let binding named '_borrowing' inside a case pattern named 'borrowing'
        break
      }
      """,
      substructure: PatternSyntax(
        ValueBindingPatternSyntax(
          bindingSpecifier: .keyword(.let),
          pattern: PatternSyntax(IdentifierPatternSyntax(identifier: .identifier("_borrowing")))
        )
      ),
      experimentalFeatures: .borrowingSwitch
    )
    assertParse(
      """
      switch 42 {
      case {}(_borrowing + _borrowing): // parses as expr pattern
        break
      }
      """,
      substructure: ExprSyntax(DeclReferenceExprSyntax(baseName: .identifier("_borrowing"))),
      experimentalFeatures: .borrowingSwitch
    )
  }
}
