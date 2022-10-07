// This test file has been translated from swift/test/Parse/trailing-semi.swift

import XCTest

final class TrailingSemiTests: XCTestCase {
  func testTrailingSemi1() {
    AssertParse(
      """
      struct S {
        var a : Int ;
        func b () {};
        static func c () {};
      }
      """
    )
  }

  func testTrailingSemi2() {
    AssertParse(
      """
      struct SpuriousSemi {
        1️⃣; 
        var a : Int ; 2️⃣; 
        func b () {};3️⃣
        ;4️⃣ 5️⃣static func c () {};  6️⃣
        ;7️⃣;
      8️⃣}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unexpected ';' separator, Fix-It replacements: 3 - 5 = ''
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected text ';' before variable"),
        // TODO: Old parser expected error on line 3: unexpected ';' separator, Fix-It replacements: 17 - 19 = ''
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected text ';' before function"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected declaration in struct"),
        // TODO: Old parser expected error on line 5: unexpected ';' separator, Fix-It replacements: 3 - 5 = ''
        DiagnosticSpec(locationMarker: "4️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "5️⃣", message: "expected '}' to end struct"),
        DiagnosticSpec(locationMarker: "6️⃣", message: "expected expression"),
        // TODO: Old parser expected error on line 6: unexpected ';' separator, Fix-It replacements: 3 - 4 = ''
        // TODO: Old parser expected error on line 6: unexpected ';' separator, Fix-It replacements: 4 - 5 = ''
        DiagnosticSpec(locationMarker: "7️⃣", message: "expected expression"),
        DiagnosticSpec(locationMarker: "8️⃣", message: "extraneous '}' at top level"),
      ]
    )
  }

  func testTrailingSemi3() {
    AssertParse(
      """
      class C {
        var a : Int = 10 func aa() {}; 
      #if FLAG1
        var aaa: Int = 42 func aaaa() {}; 
      #elseif FLAG2
        var aaa: Int = 42 func aaaa() {} 
      #else
        var aaa: Int = 42 func aaaa() {} 
      #endif
        func b () {};
        class func c () {};
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: consecutive declarations on a line must be separated by ';', Fix-It replacements: 19 - 19 = ';'
        // TODO: Old parser expected error on line 4: consecutive declarations on a line must be separated by ';', Fix-It replacements: 20 - 20 = ';'
        // TODO: Old parser expected error on line 6: consecutive declarations on a line must be separated by ';', Fix-It replacements: 20 - 20 = ';'
        // TODO: Old parser expected error on line 8: consecutive declarations on a line must be separated by ';', Fix-It replacements: 20 - 20 = ';'
      ]
    )
  }

  func testTrailingSemi4() {
    AssertParse(
      """
      extension S {
        //var a : Int ;
        func bb () {};
        static func cc () {};
        func dd() {} subscript(i: Int) -> Int { return 1 } 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 5: consecutive declarations on a line must be separated by ';', Fix-It replacements: 15 - 15 = ';'
      ]
    )
  }

  func testTrailingSemi5() {
    AssertParse(
      """
      protocol P {
        var a : Int { get };
        func b ();
        static func c ();
      }
      """
    )
  }

}
