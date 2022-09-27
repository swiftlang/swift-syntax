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
        #^DIAG_1^#; 
        var a : Int ; #^DIAG_2^#; 
        func b () {};#^DIAG_3^#
        ; #^DIAG_4^#static func c () {};  #^DIAG_5^#
        ;#^DIAG_6^#;
      #^DIAG_7^#}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unexpected ';' separator, Fix-It replacements: 3 - 5 = ''
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text ';' before variable"),
        // TODO: Old parser expected error on line 3: unexpected ';' separator, Fix-It replacements: 17 - 19 = ''
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text ';' before function"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected declaration in struct"),
        // TODO: Old parser expected error on line 5: unexpected ';' separator, Fix-It replacements: 3 - 5 = ''
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected '}' to end struct"),
        DiagnosticSpec(locationMarker: "DIAG_5", message: "expected expression"),
        // TODO: Old parser expected error on line 6: unexpected ';' separator, Fix-It replacements: 3 - 4 = ''
        // TODO: Old parser expected error on line 6: unexpected ';' separator, Fix-It replacements: 4 - 5 = ''
        DiagnosticSpec(locationMarker: "DIAG_6", message: "expected expression"),
        DiagnosticSpec(locationMarker: "DIAG_7", message: "extraneous '}' at top level"),
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
