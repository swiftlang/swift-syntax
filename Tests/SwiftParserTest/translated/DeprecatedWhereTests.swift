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

  func testDeprecatedWhere3a() {
    // FuncDecl: Choose 1
    // 1: Inherited constraint
    AssertParse(
      """
      func f2<T: Mashable>(x: T) {}
      """
    )
  }

  func testDeprecatedWhere3b() {
    // 2: Non-trailing where
    AssertParse(
      """
      func f3<T 1️⃣where T: Womparable>(x: T) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'where T: Womparable' in generic parameter clause")
      ]
    )
  }

  func testDeprecatedWhere3c() {
    // 3: Has return type
    AssertParse(
      """
      func f4<T>(x: T) -> Int { return 2 }
      """
    )
  }

  func testDeprecatedWhere3d() {
    // 4: Trailing where
    AssertParse(
      """
      func f5<T>(x: T) where T : Equatable {}
      """
    )
  }

  func testDeprecatedWhere4() {
    AssertParse(
      """
      // FuncDecl: Choose 2
      // 1,2
      func f12<T: Mashable 1️⃣where T: Womparable>(x: T) {}
      // 1,3
      func f13<T: Mashable>(x: T) -> Int { return 2 } // no-warning
      // 1,4
      func f14<T: Mashable>(x: T) where T: Equatable {} // no-warning
      // 2,3
      func f23<T 2️⃣where T: Womparable>(x: T) -> Int { return 2 }
      // 2,4
      func f24<T 3️⃣where T: Womparable>(x: T) where T: Equatable {}
      // 3,4
      func f34<T>(x: T) -> Int where T: Equatable { return 2 } // no-warning
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code 'where T: Womparable' in generic parameter clause"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code 'where T: Womparable' in generic parameter clause"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "unexpected code 'where T: Womparable' in generic parameter clause"),
      ]
    )
  }

  func testDeprecatedWhere5() {
    AssertParse(
      """
      // FuncDecl: Choose 3
      // 1,2,3
      func f123<T: Mashable 1️⃣where T: Womparable>(x: T) -> Int { return 2 }
      // 1,2,4
      func f124<T: Mashable 2️⃣where T: Womparable>(x: T) where T: Equatable {}
      // 2,3,4
      func f234<T 3️⃣where T: Womparable>(x: T) -> Int where T: Equatable { return 2 }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code 'where T: Womparable' in generic parameter clause"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code 'where T: Womparable' in generic parameter clause"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "unexpected code 'where T: Womparable' in generic parameter clause"),
      ]
    )
  }

  func testDeprecatedWhere6() {
    AssertParse(
      """
      // FuncDecl: Choose 4
      // 1,2,3,4
      func f1234<T: Mashable 1️⃣where T: Womparable>(x: T) -> Int where T: Equatable { return 2 }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'where T: Womparable' in generic parameter clause"),
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
      struct S2<T 1️⃣where T: Womparable> {}
      // 3: Trailing where
      struct S3<T> where T : Equatable {} // no-warning
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'where T: Womparable' in generic parameter clause"),
      ]
    )
  }

  func testDeprecatedWhere9() {
    AssertParse(
      """
      // NominalTypeDecl: Choose 2
      // 1,2
      struct S12<T: Mashable 1️⃣where T: Womparable> {}
      // 1,3
      struct S13<T: Mashable> where T: Equatable {} // no-warning
      // 2,3
      struct S23<T 2️⃣where T: Womparable> where T: Equatable {}
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code 'where T: Womparable' in generic parameter clause"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code 'where T: Womparable' in generic parameter clause"),
      ]
    )
  }

  func testDeprecatedWhere10() {
    AssertParse(
      """
      // NominalTypeDecl: Choose 3
      // 1,2,3
      struct S123<T: Mashable 1️⃣where T: Womparable> where T: Equatable {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'where T: Womparable' in generic parameter clause"),
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
      func testCombinedConstraints<T: ProtoA & ProtoB 1️⃣where T: ProtoC>(x: T) {}
      func testCombinedConstraints<T: ProtoA & ProtoB 2️⃣where T: ProtoC>(x: T) where T: ProtoD {}
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code 'where T: ProtoC' in generic parameter clause"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code 'where T: ProtoC' in generic parameter clause"),
      ]
    )
  }

  func testDeprecatedWhere12() {
    AssertParse(
      """
      func testCombinedConstraintsOld<T: 2️⃣protocol3️⃣<ProtoA, ProtoB> where T: ProtoC4️⃣>(x: T) {}
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected inherited type in generic parameter"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '>' to end generic parameter clause"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected parameter clause in function signature"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected identifier in protocol"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "unexpected code '>(x: T)' in protocol"),
      ]
    )
  }

  func testDeprecatedWhere13() {
    AssertParse(
      """
      func testCombinedConstraintsOld<T: 2️⃣protocol3️⃣<ProtoA, ProtoB> where T: ProtoC4️⃣>(x: T) where T: ProtoD {}
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected inherited type in generic parameter"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '>' to end generic parameter clause"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected parameter clause in function signature"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected identifier in protocol"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "unexpected code '>(x: T) where T: ProtoD' in protocol"),
      ]
    )
  }

}
