// This test file has been translated from swift/test/Parse/deprecated_where.swift

import XCTest

final class DeprecatedWhereTests: XCTestCase {
  func testDeprecatedWhere1() {
    AssertParse(
      """
      protocol Mashable { }
      protocol Womparable { }
      """
    )
  }

  func testDeprecatedWhere2() {
    AssertParse(
      """
      // FuncDecl: Choose 0
      func f1<T>(x: T) {}
      """
    )
  }

  func testDeprecatedWhere3() {
    AssertParse(
      """
      // FuncDecl: Choose 1
      // 1: Inherited constraint
      func f2<T: Mashable>(x: T) {} // no-warning
      // 2: Non-trailing where
      func f3<T where T: Womparable>(x: T) {} 
      // 3: Has return type
      func f4<T>(x: T) -> Int { return 2 } // no-warning
      // 4: Trailing where
      func f5<T>(x: T) where T : Equatable {} // no-warning
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 5: 'where' clause next to generic parameters is obsolete, Fix-It replacements: 10 - 30 = '', 37 - 37 = ' where T: Womparable'
      ]
    )
  }

  func testDeprecatedWhere4() {
    AssertParse(
      """
      // FuncDecl: Choose 2
      // 1,2
      func f12<T: Mashable where T: Womparable>(x: T) {} 
      // 1,3
      func f13<T: Mashable>(x: T) -> Int { return 2 } // no-warning
      // 1,4
      func f14<T: Mashable>(x: T) where T: Equatable {} // no-warning
      // 2,3
      func f23<T where T: Womparable>(x: T) -> Int { return 2 } 
      // 2,4
      func f24<T where T: Womparable>(x: T) where T: Equatable {} 
      // 3,4
      func f34<T>(x: T) -> Int where T: Equatable { return 2 } // no-warning
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: 'where' clause next to generic parameters is obsolete, Fix-It replacements: 21 - 41 = '', 48 - 48 = ' where T: Womparable'
        // TODO: Old parser expected error on line 9: 'where' clause next to generic parameters is obsolete, Fix-It replacements: 11 - 31 = '', 45 - 45 = ' where T: Womparable'
        // TODO: Old parser expected error on line 11: 'where' clause next to generic parameters is obsolete, Fix-It replacements: 11 - 31 = '', 39 - 44 = 'where T: Womparable,'
      ]
    )
  }

  func testDeprecatedWhere5() {
    AssertParse(
      """
      // FuncDecl: Choose 3
      // 1,2,3
      func f123<T: Mashable where T: Womparable>(x: T) -> Int { return 2 } 
      // 1,2,4
      func f124<T: Mashable where T: Womparable>(x: T) where T: Equatable {} 
      // 2,3,4
      func f234<T where T: Womparable>(x: T) -> Int where T: Equatable { return 2 }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: 'where' clause next to generic parameters is obsolete, Fix-It replacements: 22 - 42 = '', 56 - 56 = ' where T: Womparable'
        // TODO: Old parser expected error on line 5: 'where' clause next to generic parameters is obsolete, Fix-It replacements: 22 - 42 = '', 50 - 55 = 'where T: Womparable,'
        // TODO: Old parser expected error on line 7: 'where' clause next to generic parameters is obsolete, Fix-It replacements: 12 - 32 = '', 47 - 52 = 'where T: Womparable,'
      ]
    )
  }

  func testDeprecatedWhere6() {
    AssertParse(
      """
      // FuncDecl: Choose 4
      // 1,2,3,4
      func f1234<T: Mashable where T: Womparable>(x: T) -> Int where T: Equatable { return 2 }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: 'where' clause next to generic parameters is obsolete, Fix-It replacements: 23 - 43 = '', 58 - 63 = 'where T: Womparable,'
      ]
    )
  }

  func testDeprecatedWhere7() {
    AssertParse(
      """
      // NominalTypeDecl: Choose 0
      struct S0<T> {}
      """
    )
  }

  func testDeprecatedWhere8() {
    AssertParse(
      """
      // NominalTypeDecl: Choose 1
      // 1: Inherited constraint
      struct S1<T: Mashable> {} // no-warning
      // 2: Non-trailing where
      struct S2<T where T: Womparable> {} 
      // 3: Trailing where
      struct S3<T> where T : Equatable {} // no-warning
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 5: 'where' clause next to generic parameters is obsolete, Fix-It replacements: 12 - 32 = '', 33 - 33 = ' where T: Womparable'
      ]
    )
  }

  func testDeprecatedWhere9() {
    AssertParse(
      """
      // NominalTypeDecl: Choose 2
      // 1,2
      struct S12<T: Mashable where T: Womparable> {} 
      // 1,3
      struct S13<T: Mashable> where T: Equatable {} // no-warning
      // 2,3
      struct S23<T where T: Womparable> where T: Equatable {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: 'where' clause next to generic parameters is obsolete, Fix-It replacements: 23 - 43 = '', 44 - 44 = ' where T: Womparable'
        // TODO: Old parser expected error on line 7: 'where' clause next to generic parameters is obsolete, Fix-It replacements: 13 - 33 = '', 35 - 40 = 'where T: Womparable,'
      ]
    )
  }

  func testDeprecatedWhere10() {
    AssertParse(
      """
      // NominalTypeDecl: Choose 3
      // 1,2,3
      struct S123<T: Mashable where T: Womparable> where T: Equatable {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: 'where' clause next to generic parameters is obsolete, Fix-It replacements: 24 - 44 = '', 46 - 51 = 'where T: Womparable,'
      ]
    )
  }

  func testDeprecatedWhere11() {
    AssertParse(
      """
      protocol ProtoA {}
      protocol ProtoB {}
      protocol ProtoC {}
      protocol ProtoD {}
      func testCombinedConstraints<T: ProtoA & ProtoB where T: ProtoC>(x: T) {} 
      func testCombinedConstraints<T: ProtoA & ProtoB where T: ProtoC>(x: T) where T: ProtoD {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 5: 'where' clause next to generic parameters is obsolete, Fix-It replacements: 48 - 64 = '', 71 - 71 = ' where T: ProtoC'
        // TODO: Old parser expected error on line 6: 'where' clause next to generic parameters is obsolete, Fix-It replacements: 48 - 64 = '', 72 - 77 = 'where T: ProtoC,'
      ]
    )
  }

  func testDeprecatedWhere12() {
    AssertParse(
      """
      func testCombinedConstraintsOld<T: #^DIAG_1^#protocol#^DIAG_2^#<ProtoA, ProtoB> where T: ProtoC>(x: T) {} 
      func testCombinedConstraintsOld<T: #^DIAG_3^#protocol#^DIAG_4^#<ProtoA, ProtoB> where T: ProtoC>(x: T) where T: ProtoD {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'where' clause next to generic parameters is obsolete, Fix-It replacements: 60 - 76 = '', 83 - 83 = ' where T: ProtoC'
        // TODO: Old parser expected error on line 1: 'protocol<...>' composition syntax has been removed
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected inherited type in generic parameter"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected '>' to end generic parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected argument list in function declaration"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected identifier in protocol"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected member block in protocol"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text '<ProtoA, ProtoB> where T: ProtoC>(x: T) {}' before function"),
        // TODO: Old parser expected error on line 2: 'where' clause next to generic parameters is obsolete, Fix-It replacements: 60 - 76 = '', 84 - 89 = 'where T: ProtoC,'
        // TODO: Old parser expected error on line 2: 'protocol<...>' composition syntax has been removed
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected inherited type in generic parameter"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected '>' to end generic parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected argument list in function declaration"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected identifier in protocol"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected member block in protocol"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "extraneous '<ProtoA, ProtoB> where T: ProtoC>(x: T) where T: ProtoD {}' at top level"),
      ]
    )
  }

}
