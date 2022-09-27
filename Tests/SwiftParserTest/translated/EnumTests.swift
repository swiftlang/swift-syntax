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
      #^DIAG^#case FloatingCase
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: enum 'case' is not allowed outside of an enum
        DiagnosticSpec(message: "extraneous 'case FloatingCase' at top level"),
      ]
    )
  }

  func testEnum12() {
    AssertParse(
      """
      struct SomeStruct {
        case StructCase 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: enum 'case' is not allowed outside of an enum
      ]
    )
  }

  func testEnum13() {
    AssertParse(
      """
      class SomeClass {
        case ClassCase 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: enum 'case' is not allowed outside of an enum
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 5: enum 'case' is not allowed outside of an enum
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unknown attribute 'xyz'
      ]
    )
  }

  func testEnum17() {
    AssertParse(
      """
      // Recover when a switch 'case' label is spelled inside an enum (or outside).
      enum SwitchEnvy {
        case X#^DIAG_1^#: 
        case X(Y)#^DIAG_2^#: 
        case X, Y#^DIAG_3^#: 
        case X #^DIAG_4^#where true: 
        case X(Y), Z(W)#^DIAG_5^#: 
        case X(Y) #^DIAG_6^#where true: 
        case #^DIAG_7^#0: 
        case #^DIAG_8^#_: 
        case #^DIAG_9^#(_, var x#^DIAG_10^#, #^DIAG_11^#0)#^DIAG_12^#: 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: 'case' label can only appear inside a 'switch' statement
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text ':' before enum case"),
        // TODO: Old parser expected error on line 4: 'case' label can only appear inside a 'switch' statement
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text ':' before enum case"),
        // TODO: Old parser expected error on line 5: 'case' label can only appear inside a 'switch' statement
        DiagnosticSpec(locationMarker: "DIAG_3", message: "unexpected text ':' before enum case"),
        // TODO: Old parser expected error on line 6: 'case' label can only appear inside a 'switch' statement
        DiagnosticSpec(locationMarker: "DIAG_4", message: "unexpected text 'where true:' before enum case"),
        // TODO: Old parser expected error on line 7: 'case' label can only appear inside a 'switch' statement
        DiagnosticSpec(locationMarker: "DIAG_5", message: "unexpected text ':' before enum case"),
        // TODO: Old parser expected error on line 8: 'case' label can only appear inside a 'switch' statement
        DiagnosticSpec(locationMarker: "DIAG_6", message: "unexpected text 'where true:' before enum case"),
        // TODO: Old parser expected error on line 9: 'case' label can only appear inside a 'switch' statement
        DiagnosticSpec(locationMarker: "DIAG_7", message: "expected identifier in enum case"),
        DiagnosticSpec(locationMarker: "DIAG_7", message: "unexpected text '0:' before enum case"),
        // TODO: Old parser expected error on line 10: 'case' label can only appear inside a 'switch' statement
        DiagnosticSpec(locationMarker: "DIAG_8", message: "expected identifier in enum case"),
        DiagnosticSpec(locationMarker: "DIAG_8", message: "unexpected text '_:' before enum case"),
        // TODO: Old parser expected error on line 11: 'case' label can only appear inside a 'switch' statement
        DiagnosticSpec(locationMarker: "DIAG_9", message: "expected identifier in enum case"),
        DiagnosticSpec(locationMarker: "DIAG_10", message: "expected ':' and type in function parameter"),
        DiagnosticSpec(locationMarker: "DIAG_11", message: "expected type in function parameter"),
        DiagnosticSpec(locationMarker: "DIAG_11", message: "unexpected text '0' in parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_12", message: "expected declaration in enum"),
        DiagnosticSpec(locationMarker: "DIAG_12", message: "unexpected text ':' in enum"),
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: enums must not contain stored properties
      ]
    )
  }

  func testEnum20() {
    AssertParse(
      """
      // We used to crash on this.  rdar://14678675
      enum rdar14678675 {
        case U1, #^DIAG^#
        case U2 
        case U3
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: expected identifier after comma in enum 'case' declaration
        DiagnosticSpec(message: "expected identifier in enum case"),
      ]
    )
  }

  func testEnum21() {
    AssertParse(
      """
      enum Recovery1 {
        case#^DIAG_1^#: 
      }
      enum Recovery2 {
        case UE1#^DIAG_2^#: 
      }
      enum Recovery3 {
        case UE2(Void)#^DIAG_3^#: 
      }
      enum Recovery4 { 
        case Self #^DIAG_4^#Self 
      }
      enum Recovery5 {
        case #^DIAG_5^#.UE3 
        case #^DIAG_6^#.UE4, .UE5
      }
      enum Recovery6 {
        case Snout, #^DIAG_7^#_; 
        case #^DIAG_8^#_; 
        case Tusk, #^DIAG_9^#
      }#^DIAG_10^#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: 'case' label can only appear inside a 'switch' statement
        // TODO: Old parser expected error on line 2: expected pattern
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected identifier in enum case"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text before enum"),
        // TODO: Old parser expected error on line 5: 'case' label can only appear inside a 'switch' statement
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text before enum"),
        // TODO: Old parser expected error on line 8: 'case' label can only appear inside a 'switch' statement
        DiagnosticSpec(locationMarker: "DIAG_3", message: "unexpected text before enum"),
        // TODO: Old parser expected note on line 10: in declaration of 'Recovery4'
        // TODO: Old parser expected error on line 11: keyword 'Self' cannot be used as an identifier here
        // TODO: Old parser expected note on line 11: if this name is unavoidable, use backticks to escape it, Fix-It replacements: 8 - 12 = '`Self`'
        // TODO: Old parser expected error on line 11: consecutive declarations on a line must be separated by ';', Fix-It replacements: 12 - 12 = ';'
        // TODO: Old parser expected error on line 11: expected declaration
        DiagnosticSpec(locationMarker: "DIAG_4", message: "unexpected text before enum"),
        // TODO: Old parser expected error on line 14: extraneous '.' in enum 'case' declaration, Fix-It replacements: 8 - 9 = ''
        DiagnosticSpec(locationMarker: "DIAG_5", message: "expected identifier in enum case"),
        DiagnosticSpec(locationMarker: "DIAG_5", message: "unexpected text '.UE3' before enum case"),
        // TODO: Old parser expected error on line 15: extraneous '.' in enum 'case' declaration, Fix-It replacements: 8 - 9 = ''
        // TODO: Old parser expected error on line 15: extraneous '.' in enum 'case' declaration, Fix-It replacements: 14 - 15 = ''
        DiagnosticSpec(locationMarker: "DIAG_6", message: "expected identifier in enum case"),
        DiagnosticSpec(locationMarker: "DIAG_6", message: "unexpected text before enum"),
        // TODO: Old parser expected error on line 18: keyword '_' cannot be used as an identifier here
        // TODO: Old parser expected note on line 18: if this name is unavoidable, use backticks to escape it, Fix-It replacements: 15 - 16 = '`_`'
        // TODO: Old parser expected note on line 18: '_' previously declared here
        DiagnosticSpec(locationMarker: "DIAG_7", message: "expected identifier in enum case"),
        DiagnosticSpec(locationMarker: "DIAG_7", message: "unexpected text '_;' before enum case"),
        // TODO: Old parser expected error on line 19: keyword '_' cannot be used as an identifier here
        // TODO: Old parser expected note on line 19: if this name is unavoidable, use backticks to escape it, Fix-It replacements: 8 - 9 = '`_`'
        // TODO: Old parser expected error on line 19: invalid redeclaration of '_'
        DiagnosticSpec(locationMarker: "DIAG_8", message: "expected identifier in enum case"),
        DiagnosticSpec(locationMarker: "DIAG_8", message: "unexpected text '_;' before enum case"),
        // TODO: Old parser expected error on line 20: expected identifier after comma in enum 'case' declaration
        DiagnosticSpec(locationMarker: "DIAG_9", message: "expected identifier in enum case"),
        DiagnosticSpec(locationMarker: "DIAG_10", message: "expected '}' to end enum"),
        DiagnosticSpec(locationMarker: "DIAG_10", message: "expected '}' to end enum"),
        DiagnosticSpec(locationMarker: "DIAG_10", message: "expected '}' to end enum"),
        DiagnosticSpec(locationMarker: "DIAG_10", message: "expected '}' to end enum"),
        DiagnosticSpec(locationMarker: "DIAG_10", message: "expected '}' to end enum"),
      ]
    )
  }

  func testEnum22() {
    AssertParse(
      """
      enum RawTypeEmpty : Int {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: an enum with no cases cannot declare a raw type
        // TODO: Old parser expected error on line 1: 'RawTypeEmpty' declares raw type 'Int', but does not conform to RawRepresentable and conformance could not be synthesized
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: multiple enum raw types 'Int64' and 'Int32'
      ]
    )
  }

  func testEnum25() {
    AssertParse(
      """
      protocol RawTypeNotFirstProtocol {}
      enum RawTypeNotFirst : RawTypeNotFirstProtocol, Int { 
        case E
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: raw type 'Int' must appear first in the enum inheritance clause, Fix-It replacements: 24 - 24 = 'Int, ', 47 - 52 = ''
      ]
    )
  }

  func testEnum26() {
    AssertParse(
      """
      enum ExpressibleByRawTypeNotLiteral : Array<Int> { 
        case Ladd, Elliott, Sixteenth, Harrison
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: raw type 'Array<Int>' is not expressible by a string, integer, or floating-point literal
        // TODO: Old parser expected error on line 1: 'ExpressibleByRawTypeNotLiteral' declares raw type 'Array<Int>', but does not conform to RawRepresentable and conformance could not be synthesized
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'RawTypeCircularityA' has a raw type that depends on itself
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 1: enum 'RawTypeCircularityB' declared here
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: 'ExpressibleByRawTypeNotIntegerLiteral' declares raw type 'ExpressibleByFloatLiteralOnly', but does not conform to RawRepresentable and conformance could not be synthesized
        // TODO: Old parser expected error on line 4: RawRepresentable conformance cannot be synthesized because raw type 'ExpressibleByFloatLiteralOnly' is not Equatable
        // TODO: Old parser expected error on line 5: enum cases require explicit raw values when the raw type is not expressible by integer or string literal
      ]
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
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'RawTypeWithUnicodeScalarValues' declares raw type 'UnicodeScalar' (aka 'Unicode.Scalar'), but does not conform to RawRepresentable and conformance could not be synthesized
        // TODO: Old parser expected error on line 3: enum cases require explicit raw values when the raw type is not expressible by integer or string literal
      ]
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
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'RawTypeWithCharacterValues' declares raw type 'Character', but does not conform to RawRepresentable and conformance could not be synthesized
        // TODO: Old parser expected error on line 3: enum cases require explicit raw values when the raw type is not expressible by integer or string literal
      ]
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
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'RawTypeWithCharacterValues_Error1' declares raw type 'Character', but does not conform to RawRepresentable and conformance could not be synthesized
        // TODO: Old parser expected error on line 2: cannot convert value of type 'String' to raw type 'Character'
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'RawTypeWithFloatValues' declares raw type 'Float', but does not conform to RawRepresentable and conformance could not be synthesized
        // TODO: Old parser expected error on line 3: enum case must declare a raw value when the preceding raw value is not an integer
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: enum case cannot have a raw value if the enum does not have a raw type
      ]
    )
  }

  func testEnum39() {
    AssertParse(
      """
      enum RawTypeWithRepeatValues : Int {
        case Vaughn = 22 
        case Wilson = 22 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 2: raw value previously used here
        // TODO: Old parser expected error on line 3: raw value for enum case is not unique
      ]
    )
  }

  func testEnum40() {
    AssertParse(
      """
      enum RawTypeWithRepeatValues2 : Double {
        case Vaughn = 22   
        case Wilson = 22.0 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 2: raw value previously used here
        // TODO: Old parser expected error on line 3: raw value for enum case is not unique
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 3: raw value previously used here
        // TODO: Old parser expected error on line 4: raw value for enum case is not unique
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 3: raw value previously used here
        // TODO: Old parser expected error on line 4: raw value for enum case is not unique
      ]
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
      """#,
      diagnostics: [
        // TODO: Old parser expected note on line 2: raw value previously used here
        // TODO: Old parser expected error on line 3: raw value for enum case is not unique
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 2: raw value auto-incremented from here
        // TODO: Old parser expected note on line 3: raw value previously used here
        // TODO: Old parser expected error on line 4: raw value for enum case is not unique
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 2: raw value previously used here
        // TODO: Old parser expected note on line 3: raw value auto-incremented from here
        // TODO: Old parser expected error on line 4: raw value for enum case is not unique
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 2: raw value implicitly auto-incremented from zero
        // TODO: Old parser expected note on line 3: raw value previously used here
        // TODO: Old parser expected error on line 4: raw value for enum case is not unique
      ]
    )
  }

  func testEnum51() {
    AssertParse(
      #"""
      enum RawTypeWithRepeatValuesAutoInc4 : String {
        case A = "B" 
        case B 
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected note on line 2: raw value previously used here
        // TODO: Old parser expected error on line 3: raw value for enum case is not unique
      ]
    )
  }

  func testEnum52() {
    AssertParse(
      #"""
      enum RawTypeWithRepeatValuesAutoInc5 : String {
        case A 
        case B = "A" 
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected note on line 2: raw value previously used here
        // TODO: Old parser expected error on line 3: raw value for enum case is not unique
      ]
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
      """#,
      diagnostics: [
        // TODO: Old parser expected note on line 3: raw value previously used here
        // TODO: Old parser expected error on line 4: raw value for enum case is not unique
      ]
    )
  }

  func testEnum54() {
    AssertParse(
      """
      enum NonliteralRawValue : Int {
        case Yeon = 100 + 20 + 3 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: raw value for enum case must be a literal
      ]
    )
  }

  func testEnum55() {
    AssertParse(
      """
      enum RawTypeWithPayload : Int { 
        case Powell(Int) 
        case Terwilliger(Int) = 17 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'RawTypeWithPayload' declares raw type 'Int', but does not conform to RawRepresentable and conformance could not be synthesized
        // TODO: Old parser expected note on line 1: declared raw type 'Int' here
        // TODO: Old parser expected note on line 1: declared raw type 'Int' here
        // TODO: Old parser expected error on line 2: enum with raw type cannot have cases with arguments
        // TODO: Old parser expected error on line 3: enum with raw type cannot have cases with arguments
      ]
    )
  }

  func testEnum56() {
    AssertParse(
      #"""
      enum RawTypeMismatch : Int { 
        case Barbur = "foo" 
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'RawTypeMismatch' declares raw type 'Int', but does not conform to RawRepresentable and conformance could not be synthesized
        // TODO: Old parser expected error on line 2: 
      ]
    )
  }

  func testEnum57() {
    AssertParse(
      """
      enum DuplicateMembers1 {
        case Foo 
        case Foo 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 2: 'Foo' previously declared here
        // TODO: Old parser expected error on line 3: invalid redeclaration of 'Foo'
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 2: 'Foo' previously declared here
        // TODO: Old parser expected note on line 2: 'Bar' previously declared here
        // TODO: Old parser expected error on line 3: invalid redeclaration of 'Foo'
        // TODO: Old parser expected error on line 4: invalid redeclaration of 'Bar'
      ]
    )
  }

  func testEnum59() {
    AssertParse(
      """
      enum DuplicateMembers3 {
        case Foo 
        case Foo(Int) 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 2: 'Foo' previously declared here
        // TODO: Old parser expected error on line 3: invalid redeclaration of 'Foo'
      ]
    )
  }

  func testEnum60() {
    AssertParse(
      """
      enum DuplicateMembers4 : Int { 
        case Foo = 1 
        case Foo = 2 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'DuplicateMembers4' declares raw type 'Int', but does not conform to RawRepresentable and conformance could not be synthesized
        // TODO: Old parser expected note on line 2: 'Foo' previously declared here
        // TODO: Old parser expected error on line 3: invalid redeclaration of 'Foo'
      ]
    )
  }

  func testEnum61() {
    AssertParse(
      """
      enum DuplicateMembers5 : Int { 
        case Foo = 1 
        case Foo = 1 + 1 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'DuplicateMembers5' declares raw type 'Int', but does not conform to RawRepresentable and conformance could not be synthesized
        // TODO: Old parser expected note on line 2: 'Foo' previously declared here
        // TODO: Old parser expected error on line 3: invalid redeclaration of 'Foo'
        // TODO: Old parser expected error on line 3: raw value for enum case must be a literal
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: invalid redeclaration of 'Foo'
        // TODO: Old parser expected error on line 4: invalid redeclaration of 'Foo'
      ]
    )
  }

  func testEnum63() {
    AssertParse(
      #"""
      enum DuplicateMembers7 : String { 
        case Foo 
        case Foo = "Bar" 
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'DuplicateMembers7' declares raw type 'String', but does not conform to RawRepresentable and conformance could not be synthesized
        // TODO: Old parser expected note on line 2: 'Foo' previously declared here
        // TODO: Old parser expected error on line 3: invalid redeclaration of 'Foo'
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 2: raw value previously used here
        // TODO: Old parser expected note on line 2: raw value implicitly auto-incremented from zero
        // TODO: Old parser expected error on line 3: raw value for enum case is not unique
      ]
    )
  }

  func testEnum68() {
    AssertParse(
      #"""
      enum ManyLiteralB : ManyLiteralable { 
        case A = "abc"
        case B 
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'ManyLiteralB' declares raw type 'ManyLiteralable', but does not conform to RawRepresentable and conformance could not be synthesized
        // TODO: Old parser expected error on line 3: enum case must declare a raw value when the preceding raw value is not an integer
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'foo' declares raw type 'String', but does not conform to RawRepresentable and conformance could not be synthesized
        // TODO: Old parser expected error on line 2: cannot convert 'nil' to raw type 'String'
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: static member 'staticVar' cannot be used on instance of type 'EnumWithStaticMember'
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 11: enum case 'A' cannot be used as an instance member, Fix-It replacements: 9 - 9 = 'SE0036.'
        // TODO: Old parser expected error on line 12: enum case 'A' cannot be used as an instance member, Fix-It replacements: 9 - 13 = 'SE0036'
        // TODO: Old parser expected error on line 24: enum case 'A' cannot be used as an instance member, Fix-It replacements: 10 - 10 = '.'
        // TODO: Old parser expected error on line 25: '_' can only appear in a pattern or on the left side of an assignment
        // TODO: Old parser expected error on line 26: enum case 'C' cannot be used as an instance member, Fix-It replacements: 10 - 10 = '.'
        // TODO: Old parser expected error on line 52: enum case 'A' cannot be used as an instance member, Fix-It replacements: 12 - 12 = 'SE0036.'
        // TODO: Old parser expected error on line 55: enum case 'B' cannot be used as an instance member, Fix-It replacements: 12 - 12 = 'SE0036.'
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 5: '_' can only appear in a pattern or on the left side of an assignment
      ]
    )
  }

  func testEnum82() {
    AssertParse(
      """
      enum #^DIAG_1^#switch {}#^DIAG_2^#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: keyword 'switch' cannot be used as an identifier here
        // TODO: Old parser expected note on line 1: if this name is unavoidable, use backticks to escape it, Fix-It replacements: 6 - 12 = '`switch`'
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected identifier in enum"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected member block in enum"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected '{}' in 'switch' statement"),
      ]
    )
  }

  func testEnum83() {
    AssertParse(
      """
      enum SE0155 {
        case emptyArgs() 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 2: enum element with associated values must have at least one associated value
        // TODO: Old parser expected note on line 2: did you mean to remove the empty associated value list?, Fix-It replacements: 17 - 19 = ''
        // TODO: Old parser expected note on line 2: did you mean to explicitly add a 'Void' associated value?, Fix-It replacements: 18 - 18 = 'Void'
      ]
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
        case #^DIAG_1^#operator 
        case #^DIAG_2^#identifier2
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: keyword 'operator' cannot be used as an identifier here
        // TODO: Old parser expected note on line 3: if this name is unavoidable, use backticks to escape it, Fix-It replacements: 8 - 16 = '`operator`'
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected identifier in enum case"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected declaration in enum"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text 'identifier2' in enum"),
      ]
    )
  }

  func testEnum86() {
    AssertParse(
      """
      enum E_53662_var {
        case identifier
        case #^DIAG_1^#var #^DIAG_2^#
        case identifier2
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: keyword 'var' cannot be used as an identifier here
        // TODO: Old parser expected note on line 3: if this name is unavoidable, use backticks to escape it, Fix-It replacements: 8 - 11 = '`var`'
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected identifier in enum case"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected pattern in variable"),
      ]
    )
  }

  func testEnum87() {
    AssertParse(
      """
      enum E_53662_underscore {
        case identifier
        case #^DIAG^#_ 
        case identifier2
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: keyword '_' cannot be used as an identifier here
        // TODO: Old parser expected note on line 3: if this name is unavoidable, use backticks to escape it, Fix-It replacements: 8 - 9 = '`_`'
        DiagnosticSpec(message: "expected identifier in enum case"),
        DiagnosticSpec(message: "unexpected text '_' before enum case"),
      ]
    )
  }

  func testEnum88() {
    AssertParse(
      """
      enum E_53662_Comma {
        case a, b, c, #^DIAG_1^#func#^DIAG_2^#, d 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: keyword 'func' cannot be used as an identifier here
        // TODO: Old parser expected note on line 2: if this name is unavoidable, use backticks to escape it, Fix-It replacements: 17 - 21 = '`func`'
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected identifier in enum case"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected identifier in function"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected argument list in function declaration"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected declaration in enum"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text ', d' in enum"),
      ]
    )
  }

  func testEnum89() {
    AssertParse(
      """
      enum E_53662_Newline {
        case identifier1
        case identifier2
        case #^DIAG^#
        case identifier 
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in enum case"),
        // TODO: Old parser expected error on line 5: keyword 'case' cannot be used as an identifier here
        // TODO: Old parser expected note on line 5: if this name is unavoidable, use backticks to escape it, Fix-It replacements: 3 - 7 = '`case`'
      ]
    )
  }

  func testEnum90() {
    AssertParse(
      """
      enum E_53662_Newline2 {
        case #^DIAG^#
        func foo() {} 
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in enum case"),
        // TODO: Old parser expected error on line 3: keyword 'func' cannot be used as an identifier here
        // TODO: Old parser expected note on line 3: if this name is unavoidable, use backticks to escape it, Fix-It replacements: 3 - 7 = '`func`'
      ]
    )
  }

  func testEnum91() {
    AssertParse(
      """
      enum E_53662_PatternMatching {
        case #^DIAG_1^#let #^DIAG_2^#.foo(x, y): 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: 'case' label can only appear inside a 'switch' statement
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected identifier in enum case"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected pattern in variable"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected declaration in enum"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text '.foo(x, y):' in enum"),
      ]
    )
  }

  func testEnum92() {
    AssertParse(
      #"""
      enum CasesWithMissingElement: Int {
        case a = "hello", #^DIAG_1^#
        case b = "hello", #^DIAG_2^#
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'CasesWithMissingElement' declares raw type 'Int', but does not conform to RawRepresentable and conformance could not be synthesized
        // TODO: Old parser expected error on line 2: expected identifier after comma in enum 'case' declaration
        // TODO: Old parser expected error on line 2: cannot convert value of type 'String' to raw type 'Int'
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected identifier in enum case"),
        // TODO: Old parser expected error on line 3: expected identifier after comma in enum 'case' declaration
        // TODO: Old parser expected error on line 3: cannot convert value of type 'String' to raw type 'Int'
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected identifier in enum case"),
      ]
    )
  }

}
