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

// This test file has been translated from swift/test/Parse/enum.swift

import XCTest

final class EnumTests: XCTestCase {
  func testEnum1() {
    AssertParse(
      """
      // FIXME: this test only passes on platforms which have Float80.
      // <rdar://problem/19508460> Floating point enum raw values are not portable
      """
    )
  }

  func testEnum2() {
    AssertParse(
      """
      // Windows does not support FP80
      // XFAIL: OS=windows-msvc
      """
    )
  }

  func testEnum3() {
    AssertParse(
      """
      enum Empty {}
      """
    )
  }

  func testEnum4() {
    AssertParse(
      """
      enum Boolish {
        case falsy
        case truthy
        init() { self = .falsy }
      }
      """
    )
  }

  func testEnum5() {
    AssertParse(
      """
      var b = Boolish.falsy
      b = .truthy
      """
    )
  }

  func testEnum6() {
    AssertParse(
      """
      enum Optionable<T> {
        case Nought
        case Mere(T)
      }
      """
    )
  }

  func testEnum7() {
    AssertParse(
      """
      var o = Optionable<Int>.Nought
      o = .Mere(0)
      """
    )
  }

  func testEnum8() {
    AssertParse(
      """
      enum Color { case Red, Green, Grayscale(Int), Blue }
      """
    )
  }

  func testEnum9() {
    AssertParse(
      """
      var c = Color.Red
      c = .Green
      c = .Grayscale(255)
      c = .Blue
      """
    )
  }

  func testEnum10() {
    AssertParse(
      """
      let partialApplication = Color.Grayscale
      """
    )
  }

  func testEnum11() {
    AssertParse(
      """
      // Cases are excluded from non-enums.
      1️⃣case FloatingCase
      """,
      diagnostics: [
        DiagnosticSpec(message: "'case' can only appear inside a 'switch' statement or 'enum' declaration")
      ]
    )
  }

  func testEnum12() {
    AssertParse(
      """
      struct SomeStruct {
        case StructCase 
      }
      """
    )
  }

  func testEnum13() {
    AssertParse(
      """
      class SomeClass {
        case ClassCase 
      }
      """
    )
  }

  func testEnum14() {
    AssertParse(
      """
      enum EnumWithExtension1 {
        case A1
      }
      extension EnumWithExtension1 {
        case A2 
      }
      """
    )
  }

  func testEnum15() {
    AssertParse(
      """
      // Attributes for enum cases.
      """
    )
  }

  func testEnum16() {
    AssertParse(
      """
      enum EnumCaseAttributes {
        @xyz case EmptyAttributes  
      }
      """
    )
  }

  // Recover when a switch 'case' label is spelled inside an enum (or outside).
  func testEnum17a() {
    AssertParse(
      """
      enum SwitchEnvy {
        case X1️⃣:
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code ':' in enum")
      ]
    )
  }

  func testEnum17b() {
    AssertParse(
      """
      enum SwitchEnvy {
        case X(Y)1️⃣:
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code ':' in enum")
      ]
    )
  }

  func testEnum17c() {
    AssertParse(
      """
      enum SwitchEnvy {
        case X, Y1️⃣:
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code ':' in enum")
      ]
    )
  }

  func testEnum17d() {
    AssertParse(
      """
      enum SwitchEnvy {
        case X 1️⃣where true:
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'where true:' in enum")
      ]
    )
  }

  func testEnum17e() {
    AssertParse(
      """
      enum SwitchEnvy {
        case X(Y), Z(W)1️⃣:
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code ':' in enum")
      ]
    )
  }

  func testEnum17f() {
    AssertParse(
      """
      enum SwitchEnvy {
        case X(Y) 1️⃣where true:
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'where true:' in enum")
      ]
    )
  }

  func testEnum17g() {
    AssertParse(
      """
      enum SwitchEnvy {
        case 1️⃣02️⃣:
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "identifier can only start with a letter or underscore, not a number"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code ':' in enum"),
      ]
    )
  }

  func testEnum17h() {
    AssertParse(
      """
      enum SwitchEnvy {
        case 1️⃣_2️⃣:
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "'_' cannot be used as an identifier here"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code ':' in enum"),
      ]
    )
  }

  func testEnum17i() {
    AssertParse(
      """
      enum SwitchEnvy {
        case 1️⃣(_, var x2️⃣, 3️⃣0)4️⃣:
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected identifier in enum case"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ':' and type in parameter"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected type in parameter"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "unexpected code '0' in parameter clause"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "unexpected code ':' in enum"),
      ],
      fixedSource: """
        enum SwitchEnvy {
          case <#identifier#>(_, var x: <#type#>, <#type#>0):
        }
        """
    )
  }

  func testEnum18() {
    AssertParse(
      """
      enum HasMethodsPropertiesAndCtors {
        case TweedleDee
        case TweedleDum
        func method() {}
        func staticMethod() {}
        init() {}
        subscript(x:Int) -> Int {
          return 0
        }
        var property : Int {
          return 0
        }
      }
      """
    )
  }

  func testEnum19() {
    AssertParse(
      """
      enum ImproperlyHasIVars {
        case Flopsy
        case Mopsy
        var ivar : Int 
      }
      """
    )
  }

  func testEnum20() {
    AssertParse(
      """
      // We used to crash on this.  rdar://14678675
      enum rdar14678675 {
        case U1, 1️⃣
        case U2 
        case U3
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in enum case")
      ]
    )
  }

  func testEnum21a() {
    AssertParse(
      """
      enum Recovery1 {
        case1️⃣: 
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in enum case"),
        DiagnosticSpec(message: "unexpected code ':' in enum"),
      ]
    )
  }

  func testEnum21b() {
    AssertParse(
      """
      enum Recovery2 {
        case UE11️⃣:
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code ':' in enum")
      ]
    )
  }

  func testEnum21c() {
    AssertParse(
      """
      enum Recovery3 {
        case UE2(Void)1️⃣:
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code ':' in enum")
      ]
    )
  }

  func testEnum21d() {
    AssertParse(
      """
      enum Recovery4 {
        case 1️⃣Self 2️⃣Self
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "keyword 'Self' cannot be used as an identifier here"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected 'Self' keyword in enum"),
      ]
    )
  }

  func testEnum21e() {
    AssertParse(
      """
      enum Recovery5 {
        case 1️⃣.UE3
        case 2️⃣.UE4, 3️⃣.UE5
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code '.' in enum case"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code '.' in enum case"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "unexpected code '.' in enum case"),
      ]
    )
  }

  func testEnum21f() {
    AssertParse(
      """
      enum Recovery6 {
        case Snout, 1️⃣_;
        case 2️⃣_;
        case Tusk, 3️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "'_' cannot be used as an identifier here"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "'_' cannot be used as an identifier here"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected identifier in enum case"),
      ]
    )
  }

  func testEnum22() {
    AssertParse(
      """
      enum RawTypeEmpty : Int {}
      """
    )
  }

  func testEnum23() {
    AssertParse(
      """
      enum Raw : Int {
        case Ankeny, Burnside
      }
      """
    )
  }

  func testEnum24() {
    AssertParse(
      """
      enum MultiRawType : Int64, Int32 { 
        case Couch, Davis
      }
      """
    )
  }

  func testEnum25() {
    AssertParse(
      """
      protocol RawTypeNotFirstProtocol {}
      enum RawTypeNotFirst : RawTypeNotFirstProtocol, Int { 
        case E
      }
      """
    )
  }

  func testEnum26() {
    AssertParse(
      """
      enum ExpressibleByRawTypeNotLiteral : Array<Int> { 
        case Ladd, Elliott, Sixteenth, Harrison
      }
      """
    )
  }

  func testEnum27() {
    AssertParse(
      """
      enum RawTypeCircularityA : RawTypeCircularityB, ExpressibleByIntegerLiteral { 
        case Morrison, Belmont, Madison, Hawthorne
        init(integerLiteral value: Int) {
          self = .Morrison
        }
      }
      """
    )
  }

  func testEnum28() {
    AssertParse(
      """
      enum RawTypeCircularityB : RawTypeCircularityA, ExpressibleByIntegerLiteral { 
        case Willamette, Columbia, Sandy, Multnomah
        init(integerLiteral value: Int) { 
          self = .Willamette
        }
      }
      """
    )
  }

  func testEnum29() {
    AssertParse(
      """
      struct ExpressibleByFloatLiteralOnly : ExpressibleByFloatLiteral {
          init(floatLiteral: Double) {}
      }
      enum ExpressibleByRawTypeNotIntegerLiteral : ExpressibleByFloatLiteralOnly { 
        case Everett 
        case Flanders
      }
      """
    )
  }

  func testEnum30() {
    AssertParse(
      """
      enum RawTypeWithIntValues : Int {
        case Glisan = 17, Hoyt = 219, Irving, Johnson = 97209
      }
      """
    )
  }

  func testEnum31() {
    AssertParse(
      """
      enum RawTypeWithNegativeValues : Int {
        case Glisan = -17, Hoyt = -219, Irving, Johnson = -97209
        case AutoIncAcrossZero = -1, Zero, One
      }
      """
    )
  }

  func testEnum32() {
    AssertParse(
      #"""
      enum RawTypeWithUnicodeScalarValues : UnicodeScalar { 
        case Kearney = "K"
        case Lovejoy 
        case Marshall = "M"
      }
      """#
    )
  }

  func testEnum33() {
    AssertParse(
      #"""
      enum RawTypeWithCharacterValues : Character { 
        case First = "い"
        case Second 
        case Third = "は"
      }
      """#
    )
  }

  func testEnum34() {
    AssertParse(
      #"""
      enum RawTypeWithCharacterValues_Correct : Character {
        case First = "😅" // ok
        case Second = "👩‍👩‍👧‍👦" // ok
        case Third = "👋🏽" // ok
        case Fourth = "\u{1F3F4}\u{E0067}\u{E0062}\u{E0065}\u{E006E}\u{E0067}\u{E007F}" // ok
      }
      """#
    )
  }

  func testEnum35() {
    AssertParse(
      #"""
      enum RawTypeWithCharacterValues_Error1 : Character { 
        case First = "abc" 
      }
      """#
    )
  }

  func testEnum36() {
    AssertParse(
      """
      enum RawTypeWithFloatValues : Float { 
        case Northrup = 1.5
        case Overton 
        case Pettygrove = 2.25
      }
      """
    )
  }

  func testEnum37() {
    AssertParse(
      #"""
      enum RawTypeWithStringValues : String {
        case Primrose // okay
        case Quimby = "Lucky Lab"
        case Raleigh // okay
        case Savier = "McMenamin's", Thurman = "Kenny and Zuke's"
      }
      """#
    )
  }

  func testEnum38() {
    AssertParse(
      """
      enum RawValuesWithoutRawType {
        case Upshur = 22 
      }
      """
    )
  }

  func testEnum39() {
    AssertParse(
      """
      enum RawTypeWithRepeatValues : Int {
        case Vaughn = 22 
        case Wilson = 22 
      }
      """
    )
  }

  func testEnum40() {
    AssertParse(
      """
      enum RawTypeWithRepeatValues2 : Double {
        case Vaughn = 22   
        case Wilson = 22.0 
      }
      """
    )
  }

  func testEnum41() {
    AssertParse(
      """
      enum RawTypeWithRepeatValues3 : Double {
        // 2^63-1
        case Vaughn = 9223372036854775807   
        case Wilson = 9223372036854775807.0 
      }
      """
    )
  }

  func testEnum42() {
    AssertParse(
      """
      enum RawTypeWithRepeatValues4 : Double {
        // 2^64-1
        case Vaughn = 18446744073709551615   
        case Wilson = 18446744073709551615.0 
      }
      """
    )
  }

  func testEnum43() {
    AssertParse(
      """
      enum RawTypeWithRepeatValues5 : Double {
        // FIXME: should reject.
        // 2^65-1
        case Vaughn = 36893488147419103231
        case Wilson = 36893488147419103231.0
      }
      """
    )
  }

  func testEnum44() {
    AssertParse(
      """
      enum RawTypeWithRepeatValues6 : Double {
        // FIXME: should reject.
        // 2^127-1
        case Vaughn = 170141183460469231731687303715884105727
        case Wilson = 170141183460469231731687303715884105727.0
      }
      """
    )
  }

  func testEnum45() {
    AssertParse(
      """
      enum RawTypeWithRepeatValues7 : Double {
        // FIXME: should reject.
        // 2^128-1
        case Vaughn = 340282366920938463463374607431768211455
        case Wilson = 340282366920938463463374607431768211455.0
      }
      """
    )
  }

  func testEnum46() {
    AssertParse(
      #"""
      enum RawTypeWithRepeatValues8 : String {
        case Vaughn = "XYZ" 
        case Wilson = "XYZ" 
      }
      """#
    )
  }

  func testEnum47() {
    AssertParse(
      """
      enum RawTypeWithNonRepeatValues : Double {
        case SantaClara = 3.7
        case SanFernando = 7.4
        case SanAntonio = -3.7
        case SanCarlos = -7.4
      }
      """
    )
  }

  func testEnum48() {
    AssertParse(
      """
      enum RawTypeWithRepeatValuesAutoInc : Double {
        case Vaughn = 22 
        case Wilson    
        case Yeon = 23 
      }
      """
    )
  }

  func testEnum49() {
    AssertParse(
      """
      enum RawTypeWithRepeatValuesAutoInc2 : Double {
        case Vaughn = 23 
        case Wilson = 22 
        case Yeon 
      }
      """
    )
  }

  func testEnum50() {
    AssertParse(
      """
      enum RawTypeWithRepeatValuesAutoInc3 : Double {
        case Vaughn 
        case Wilson 
        case Yeon = 1 
      }
      """
    )
  }

  func testEnum51() {
    AssertParse(
      #"""
      enum RawTypeWithRepeatValuesAutoInc4 : String {
        case A = "B" 
        case B 
      }
      """#
    )
  }

  func testEnum52() {
    AssertParse(
      #"""
      enum RawTypeWithRepeatValuesAutoInc5 : String {
        case A 
        case B = "A" 
      }
      """#
    )
  }

  func testEnum53() {
    AssertParse(
      #"""
      enum RawTypeWithRepeatValuesAutoInc6 : String {
        case A
        case B 
        case C = "B" 
      }
      """#
    )
  }

  func testEnum54() {
    AssertParse(
      """
      enum NonliteralRawValue : Int {
        case Yeon = 100 + 20 + 3 
      }
      """
    )
  }

  func testEnum55() {
    AssertParse(
      """
      enum RawTypeWithPayload : Int { 
        case Powell(Int) 
        case Terwilliger(Int) = 17 
      }
      """
    )
  }

  func testEnum56() {
    AssertParse(
      #"""
      enum RawTypeMismatch : Int { 
        case Barbur = "foo" 
      }
      """#
    )
  }

  func testEnum57() {
    AssertParse(
      """
      enum DuplicateMembers1 {
        case Foo 
        case Foo 
      }
      """
    )
  }

  func testEnum58() {
    AssertParse(
      """
      enum DuplicateMembers2 {
        case Foo, Bar 
        case Foo 
        case Bar 
      }
      """
    )
  }

  func testEnum59() {
    AssertParse(
      """
      enum DuplicateMembers3 {
        case Foo 
        case Foo(Int) 
      }
      """
    )
  }

  func testEnum60() {
    AssertParse(
      """
      enum DuplicateMembers4 : Int { 
        case Foo = 1 
        case Foo = 2 
      }
      """
    )
  }

  func testEnum61() {
    AssertParse(
      """
      enum DuplicateMembers5 : Int { 
        case Foo = 1 
        case Foo = 1 + 1 
      }
      """
    )
  }

  func testEnum62() {
    AssertParse(
      """
      enum DuplicateMembers6 {
        case Foo // expected-note 2{{'Foo' previously declared here}}
        case Foo 
        case Foo 
      }
      """
    )
  }

  func testEnum63() {
    AssertParse(
      #"""
      enum DuplicateMembers7 : String { 
        case Foo 
        case Foo = "Bar" 
      }
      """#
    )
  }

  func testEnum64() {
    AssertParse(
      #"""
      // Refs to duplicated enum cases shouldn't crash the compiler.
      // rdar://problem/20922401
      func check20922401() -> String {
        let x: DuplicateMembers1 = .Foo 
        switch x {
          case .Foo:
            return "Foo"
        }
      }
      """#
    )
  }

  func testEnum65() {
    AssertParse(
      """
      enum PlaygroundRepresentation : UInt8 {
        case Class = 1
        case Struct = 2
        case Tuple = 3
        case Enum = 4
        case Aggregate = 5
        case Container = 6
        case IDERepr = 7
        case Gap = 8
        case ScopeEntry = 9
        case ScopeExit = 10
        case Error = 11
        case IndexContainer = 12
        case KeyContainer = 13
        case MembershipContainer = 14
        case Unknown = 0xFF
        static func fromByte(byte : UInt8) -> PlaygroundRepresentation {
          let repr = PlaygroundRepresentation(rawValue: byte)
          if repr == .none { return .Unknown } else { return repr! }
        }
      }
      """
    )
  }

  func testEnum66() {
    AssertParse(
      """
      struct ManyLiteralable : ExpressibleByIntegerLiteral, ExpressibleByStringLiteral, Equatable {
        init(stringLiteral: String) {}
        init(integerLiteral: Int) {}
        init(unicodeScalarLiteral: String) {}
        init(extendedGraphemeClusterLiteral: String) {}
      }
      func ==(lhs: ManyLiteralable, rhs: ManyLiteralable) -> Bool { return true }
      """
    )
  }

  func testEnum67() {
    AssertParse(
      """
      enum ManyLiteralA : ManyLiteralable {
        case A 
        case B = 0 
      }
      """
    )
  }

  func testEnum68() {
    AssertParse(
      #"""
      enum ManyLiteralB : ManyLiteralable { 
        case A = "abc"
        case B 
      }
      """#
    )
  }

  func testEnum69() {
    AssertParse(
      #"""
      enum ManyLiteralC : ManyLiteralable {
        case A
        case B = "0"
      }
      """#
    )
  }

  func testEnum70() {
    AssertParse(
      """
      // rdar://problem/22476643
      public protocol RawValueA: RawRepresentable
      {
        var rawValue: Double { get }
      }
      """
    )
  }

  func testEnum71() {
    AssertParse(
      """
      enum RawValueATest: Double, RawValueA {
        case A, B
      }
      """
    )
  }

  func testEnum72() {
    AssertParse(
      """
      public protocol RawValueB
      {
        var rawValue: Double { get }
      }
      """
    )
  }

  func testEnum73() {
    AssertParse(
      """
      enum RawValueBTest: Double, RawValueB {
        case A, B
      }
      """
    )
  }

  func testEnum74() {
    AssertParse(
      """
      enum foo : String { 
        case bar = nil 
      }
      """
    )
  }

  func testEnum75() {
    AssertParse(
      """
      // Static member lookup from instance methods
      """
    )
  }

  func testEnum76() {
    AssertParse(
      """
      struct EmptyStruct {}
      """
    )
  }

  func testEnum77() {
    AssertParse(
      """
      enum EnumWithStaticMember {
        static let staticVar = EmptyStruct()
        func foo() {
          let _ = staticVar 
        }
      }
      """
    )
  }

  func testEnum78() {
    AssertParse(
      """
      // SE-0036:
      """
    )
  }

  func testEnum79() {
    AssertParse(
      """
      struct SE0036_Auxiliary {}
      """
    )
  }

  func testEnum80() {
    AssertParse(
      """
      enum SE0036 {
        case A
        case B(SE0036_Auxiliary)
        case C(SE0036_Auxiliary)
        static func staticReference() {
          _ = A
          _ = self.A
          _ = SE0036.A
        }
        func staticReferenceInInstanceMethod() {
          _ = A 
          _ = self.A 
          _ = SE0036.A
        }
        static func staticReferenceInSwitchInStaticMethod() {
          switch SE0036.A {
          case A: break
          case B(_): break
          case C(let x): _ = x; break
          }
        }
        func staticReferenceInSwitchInInstanceMethod() {
          switch self {
          case A: break 
          case B(_): break 
          case C(let x): _ = x; break 
          }
        }
        func explicitReferenceInSwitch() {
          switch SE0036.A {
          case SE0036.A: break
          case SE0036.B(_): break
          case SE0036.C(let x): _ = x; break
          }
        }
        func dotReferenceInSwitchInInstanceMethod() {
          switch self {
          case .A: break
          case .B(_): break
          case .C(let x): _ = x; break
          }
        }
        static func dotReferenceInSwitchInStaticMethod() {
          switch SE0036.A {
          case .A: break
          case .B(_): break
          case .C(let x): _ = x; break
          }
        }
        init() {
          self = .A
          self = A 
          self = SE0036.A
          self = .B(SE0036_Auxiliary())
          self = B(SE0036_Auxiliary()) 
          self = SE0036.B(SE0036_Auxiliary())
        }
      }
      """
    )
  }

  func testEnum81() {
    AssertParse(
      """
      enum SE0036_Generic<T> {
        case A(x: T)
        func foo() {
          switch self {
          case A(_): break 
          }
          switch self {
          case .A(let a): print(a)
          }
          switch self {
          case SE0036_Generic.A(let a): print(a)
          }
        }
      }
      """
    )
  }

  func testEnum81b() {
    AssertParse(
      """
      switch self {
        case A(_): break
      }
      """
    )
  }

  func testEnum82() {
    AssertParse(
      """
      enum 1️⃣switch {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "keyword 'switch' cannot be used as an identifier here")
      ]
    )
  }

  func testEnum83() {
    AssertParse(
      """
      enum SE0155 {
        case emptyArgs() 
      }
      """
    )
  }

  func testEnum84() {
    AssertParse(
      """
      // https://github.com/apple/swift/issues/53662
      """
    )
  }

  func testEnum85() {
    AssertParse(
      """
      enum E_53662 {
        case identifier
        case 1️⃣operator 
        case identifier2
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "keyword 'operator' cannot be used as an identifier here")
      ]
    )
  }

  func testEnum86() {
    AssertParse(
      """
      enum E_53662_var {
        case identifier
        case 1️⃣var
        case identifier2
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "keyword 'var' cannot be used as an identifier here")
      ]
    )
  }

  func testEnum87() {
    AssertParse(
      """
      enum E_53662_underscore {
        case identifier
        case 1️⃣_ 
        case identifier2
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "'_' cannot be used as an identifier here")
      ]
    )
  }

  func testEnum88() {
    AssertParse(
      """
      enum E_53662_Comma {
        case a, b, c, 1️⃣func, d
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "keyword 'func' cannot be used as an identifier here")
      ]
    )
  }

  func testEnum89() {
    AssertParse(
      """
      enum E_53662_Newline {
        case identifier1
        case identifier2
        case 1️⃣
        case identifier 
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in enum case")
      ]
    )
  }

  func testEnum90() {
    AssertParse(
      """
      enum E_53662_Newline2 {
        case 1️⃣
        func foo() {} 
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in enum case")
      ]
    )
  }

  func testEnum91() {
    AssertParse(
      """
      enum E_53662_PatternMatching {
        case 1️⃣let 2️⃣.foo(x, y): 
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "keyword 'let' cannot be used as an identifier here"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code '.foo(x, y):' in enum"),
      ]
    )
  }

  func testEnum92() {
    AssertParse(
      #"""
      enum CasesWithMissingElement: Int {
        case a = "hello", 1️⃣
        case b = "hello", 2️⃣
      }
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected identifier in enum case"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected identifier in enum case"),
      ]
    )
  }

}
