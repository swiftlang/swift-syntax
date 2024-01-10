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

// This test file has been translated from swift/test/Parse/enum.swift

import XCTest

final class EnumTests: ParserTestCase {
  func testEnum2() {
    assertParse(
      """
      // Windows does not support FP80
      // XFAIL: OS=windows-msvc
      """
    )
  }

  func testEnum3() {
    assertParse(
      """
      enum Empty {}
      """
    )
  }

  func testEnum4() {
    assertParse(
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
    assertParse(
      """
      var b = Boolish.falsy
      b = .truthy
      """
    )
  }

  func testEnum6() {
    assertParse(
      """
      enum Optionable<T> {
        case Nought
        case Mere(T)
      }
      """
    )
  }

  func testEnum7() {
    assertParse(
      """
      var o = Optionable<Int>.Nought
      o = .Mere(0)
      """
    )
  }

  func testEnum8() {
    assertParse(
      """
      enum Color { case Red, Green, Grayscale(Int), Blue }
      """
    )
  }

  func testEnum9() {
    assertParse(
      """
      var c = Color.Red
      c = .Green
      c = .Grayscale(255)
      c = .Blue
      """
    )
  }

  func testEnum10() {
    assertParse(
      """
      let partialApplication = Color.Grayscale
      """
    )
  }

  func testEnum11() {
    assertParse(
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
    assertParse(
      """
      struct SomeStruct {
        case StructCase
      }
      """
    )
  }

  func testEnum13() {
    assertParse(
      """
      class SomeClass {
        case ClassCase
      }
      """
    )
  }

  func testEnum14() {
    assertParse(
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
    assertParse(
      """
      // Attributes for enum cases.
      """
    )
  }

  func testEnum16() {
    assertParse(
      """
      enum EnumCaseAttributes {
        @xyz case EmptyAttributes
      }
      """
    )
  }

  // Recover when a switch 'case' label is spelled inside an enum (or outside).
  func testEnum17a() {
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
      """
      enum SwitchEnvy {
        case 1️⃣(_, var x2️⃣, 3️⃣0)4️⃣:
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected identifier in enum case", fixIts: ["insert identifier"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ':' and type in parameter", fixIts: ["insert ':' and type"]),
        DiagnosticSpec(locationMarker: "3️⃣", message: "unexpected code '0' in parameter clause"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "unexpected code ':' in enum"),
      ],
      fixedSource: """
        enum SwitchEnvy {
          case <#identifier#>(_, var x: <#type#>, 0):
        }
        """
    )
  }

  func testEnum18() {
    assertParse(
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
    assertParse(
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
    // We used to crash on this.  rdar://14678675
    assertParse(
      """
      enum rdar14678675 {
        case U1, 1️⃣
        case U2
        case U3
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in enum case", fixIts: ["insert identifier"])
      ],
      fixedSource: """
        enum rdar14678675 {
          case U1, <#identifier#>
          case U2
          case U3
        }
        """
    )
  }

  func testEnum21a() {
    assertParse(
      """
      enum Recovery1 {
        case1️⃣:
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in enum case", fixIts: ["insert identifier"]),
        DiagnosticSpec(message: "unexpected code ':' in enum"),
      ],
      fixedSource: """
        enum Recovery1 {
          case <#identifier#>:
        }
        """
    )
  }

  func testEnum21b() {
    assertParse(
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
    assertParse(
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
    assertParse(
      """
      enum Recovery4 {
        case 1️⃣Self 2️⃣Self
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "keyword 'Self' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected 'Self' keyword in enum"),
      ],
      fixedSource: """
        enum Recovery4 {
          case `Self` Self
        }
        """
    )
  }

  func testEnum21e() {
    assertParse(
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
    assertParse(
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
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected identifier in enum case", fixIts: ["insert identifier"]),
      ],
      fixedSource: """
        enum Recovery6 {
          case Snout, _;
          case _;
          case Tusk, <#identifier#>
        }
        """
    )
  }

  func testEnum22() {
    assertParse(
      """
      enum RawTypeEmpty : Int {}
      """
    )
  }

  func testEnum23() {
    assertParse(
      """
      enum Raw : Int {
        case Ankeny, Burnside
      }
      """
    )
  }

  func testEnum24() {
    assertParse(
      """
      enum MultiRawType : Int64, Int32 {
        case Couch, Davis
      }
      """
    )
  }

  func testEnum25() {
    assertParse(
      """
      protocol RawTypeNotFirstProtocol {}
      enum RawTypeNotFirst : RawTypeNotFirstProtocol, Int {
        case E
      }
      """
    )
  }

  func testEnum26() {
    assertParse(
      """
      enum ExpressibleByRawTypeNotLiteral : Array<Int> {
        case Ladd, Elliott, Sixteenth, Harrison
      }
      """
    )
  }

  func testEnum27() {
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
      """
      enum RawTypeWithIntValues : Int {
        case Glisan = 17, Hoyt = 219, Irving, Johnson = 97209
      }
      """
    )
  }

  func testEnum31() {
    assertParse(
      """
      enum RawTypeWithNegativeValues : Int {
        case Glisan = -17, Hoyt = -219, Irving, Johnson = -97209
        case AutoIncAcrossZero = -1, Zero, One
      }
      """
    )
  }

  func testEnum32() {
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
      #"""
      enum RawTypeWithCharacterValues_Error1 : Character {
        case First = "abc"
      }
      """#
    )
  }

  func testEnum36() {
    assertParse(
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
    assertParse(
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
    assertParse(
      """
      enum RawValuesWithoutRawType {
        case Upshur = 22
      }
      """
    )
  }

  func testEnum39() {
    assertParse(
      """
      enum RawTypeWithRepeatValues : Int {
        case Vaughn = 22
        case Wilson = 22
      }
      """
    )
  }

  func testEnum40() {
    assertParse(
      """
      enum RawTypeWithRepeatValues2 : Double {
        case Vaughn = 22
        case Wilson = 22.0
      }
      """
    )
  }

  func testEnum41() {
    assertParse(
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
    assertParse(
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
    assertParse(
      """
      enum RawTypeWithRepeatValues5 : Double {
        // 2^65-1
        case Vaughn = 36893488147419103231
        case Wilson = 36893488147419103231.0
      }
      """
    )
  }

  func testEnum44() {
    assertParse(
      """
      enum RawTypeWithRepeatValues6 : Double {
        // 2^127-1
        case Vaughn = 170141183460469231731687303715884105727
        case Wilson = 170141183460469231731687303715884105727.0
      }
      """
    )
  }

  func testEnum45() {
    assertParse(
      """
      enum RawTypeWithRepeatValues7 : Double {
        // 2^128-1
        case Vaughn = 340282366920938463463374607431768211455
        case Wilson = 340282366920938463463374607431768211455.0
      }
      """
    )
  }

  func testEnum46() {
    assertParse(
      #"""
      enum RawTypeWithRepeatValues8 : String {
        case Vaughn = "XYZ"
        case Wilson = "XYZ"
      }
      """#
    )
  }

  func testEnum47() {
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
      #"""
      enum RawTypeWithRepeatValuesAutoInc4 : String {
        case A = "B"
        case B
      }
      """#
    )
  }

  func testEnum52() {
    assertParse(
      #"""
      enum RawTypeWithRepeatValuesAutoInc5 : String {
        case A
        case B = "A"
      }
      """#
    )
  }

  func testEnum53() {
    assertParse(
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
    assertParse(
      """
      enum NonliteralRawValue : Int {
        case Yeon = 100 + 20 + 3
      }
      """
    )
  }

  func testEnum55() {
    assertParse(
      """
      enum RawTypeWithPayload : Int {
        case Powell(Int)
        case Terwilliger(Int) = 17
      }
      """
    )
  }

  func testEnum56() {
    assertParse(
      #"""
      enum RawTypeMismatch : Int {
        case Barbur = "foo"
      }
      """#
    )
  }

  func testEnum57() {
    assertParse(
      """
      enum DuplicateMembers1 {
        case Foo
        case Foo
      }
      """
    )
  }

  func testEnum58() {
    assertParse(
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
    assertParse(
      """
      enum DuplicateMembers3 {
        case Foo
        case Foo(Int)
      }
      """
    )
  }

  func testEnum60() {
    assertParse(
      """
      enum DuplicateMembers4 : Int {
        case Foo = 1
        case Foo = 2
      }
      """
    )
  }

  func testEnum61() {
    assertParse(
      """
      enum DuplicateMembers5 : Int {
        case Foo = 1
        case Foo = 1 + 1
      }
      """
    )
  }

  func testEnum62() {
    assertParse(
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
    assertParse(
      #"""
      enum DuplicateMembers7 : String {
        case Foo
        case Foo = "Bar"
      }
      """#
    )
  }

  func testEnum64() {
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
      """
      enum ManyLiteralA : ManyLiteralable {
        case A
        case B = 0
      }
      """
    )
  }

  func testEnum68() {
    assertParse(
      #"""
      enum ManyLiteralB : ManyLiteralable {
        case A = "abc"
        case B
      }
      """#
    )
  }

  func testEnum69() {
    assertParse(
      #"""
      enum ManyLiteralC : ManyLiteralable {
        case A
        case B = "0"
      }
      """#
    )
  }

  func testEnum70() {
    assertParse(
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
    assertParse(
      """
      enum RawValueATest: Double, RawValueA {
        case A, B
      }
      """
    )
  }

  func testEnum72() {
    assertParse(
      """
      public protocol RawValueB
      {
        var rawValue: Double { get }
      }
      """
    )
  }

  func testEnum73() {
    assertParse(
      """
      enum RawValueBTest: Double, RawValueB {
        case A, B
      }
      """
    )
  }

  func testEnum74() {
    assertParse(
      """
      enum foo : String {
        case bar = nil
      }
      """
    )
  }

  func testEnum75() {
    assertParse(
      """
      // Static member lookup from instance methods
      """
    )
  }

  func testEnum76() {
    assertParse(
      """
      struct EmptyStruct {}
      """
    )
  }

  func testEnum77() {
    assertParse(
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
    assertParse(
      """
      // SE-0036:
      """
    )
  }

  func testEnum79() {
    assertParse(
      """
      struct SE0036_Auxiliary {}
      """
    )
  }

  func testEnum80() {
    assertParse(
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
    assertParse(
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
    assertParse(
      """
      switch self {
        case A(_): break
      }
      """
    )
  }

  func testEnum82() {
    assertParse(
      """
      enum 1️⃣switch {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'switch' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        enum `switch` {}
        """
    )
  }

  func testEnum83() {
    assertParse(
      """
      enum SE0155 {
        case emptyArgs()
      }
      """
    )
  }

  func testEnum84() {
    assertParse(
      """
      // https://github.com/apple/swift/issues/53662
      """
    )
  }

  func testEnum85() {
    assertParse(
      """
      enum E_53662 {
        case identifier
        case 1️⃣operator
        case identifier2
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'operator' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        enum E_53662 {
          case identifier
          case `operator`
          case identifier2
        }
        """
    )
  }

  func testEnum86() {
    assertParse(
      """
      enum E_53662_var {
        case identifier
        case 1️⃣var
        case identifier2
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'var' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        enum E_53662_var {
          case identifier
          case `var`
          case identifier2
        }
        """
    )
  }

  func testEnum87() {
    assertParse(
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
    assertParse(
      """
      enum E_53662_Comma {
        case a, b, c, 1️⃣func, d
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'func' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        enum E_53662_Comma {
          case a, b, c, `func`, d
        }
        """
    )
  }

  func testEnum89() {
    assertParse(
      """
      enum E_53662_Newline {
        case identifier1
        case identifier2
        case 1️⃣
        case identifier
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in enum case", fixIts: ["insert identifier"])
      ],
      fixedSource: """
        enum E_53662_Newline {
          case identifier1
          case identifier2
          case <#identifier#>
          case identifier
        }
        """
    )
  }

  func testEnum90() {
    assertParse(
      """
      enum E_53662_Newline2 {
        case 1️⃣
        func foo() {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in enum case", fixIts: ["insert identifier"])
      ],
      fixedSource: """
        enum E_53662_Newline2 {
          case <#identifier#>
          func foo() {}
        }
        """
    )
  }

  func testEnum91() {
    assertParse(
      """
      enum E_53662_PatternMatching {
        case 1️⃣let 2️⃣.foo(x, y):
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "keyword 'let' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "unexpected code '.foo(x, y):' in enum"
        ),
      ],
      fixedSource: """
        enum E_53662_PatternMatching {
          case `let` .foo(x, y):
        }
        """
    )
  }

  func testEnum92() {
    assertParse(
      #"""
      enum CasesWithMissingElement: Int {
        case a = "hello", 1️⃣
        case b = "hello", 2️⃣
      }
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected identifier in enum case", fixIts: ["insert identifier"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected identifier in enum case", fixIts: ["insert identifier"]),
      ],
      fixedSource: #"""
        enum CasesWithMissingElement: Int {
          case a = "hello", <#identifier#>
          case b = "hello", <#identifier#>
        }
        """#
    )
  }

  func testEnumCaseWithWildcardAsFirstName() {
    assertParse(
      #"""
      enum Foo {
        case a(_ x: Int)
      }
      """#
    )
  }

  func parseEnumCaseElementParameterOnNewline() {
    assertParse(
      """
      enum E {
        case a
          (Int)
      }
      """
    )
  }
}
