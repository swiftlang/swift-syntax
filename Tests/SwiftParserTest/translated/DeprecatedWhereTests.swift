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

// This test file has been translated from swift/test/Parse/deprecated_where.swift

import XCTest

// TODO: The generic where clause next to generic parameters is only valid in language mode 4. We should disallow them in language mode 5.

final class DeprecatedWhereTests: ParserTestCase {
  func testDeprecatedWhere1() {
    assertParse(
      """
      protocol Mashable { }
      protocol Womparable { }
      """
    )
  }

  func testDeprecatedWhere2() {
    assertParse(
      """
      // FuncDecl: Choose 0
      func f1<T>(x: T) {}
      """
    )
  }

  func testDeprecatedWhere3() {
    assertParse(
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
      """
    )
  }

  func testDeprecatedWhere4() {
    assertParse(
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
      """
    )
  }

  func testDeprecatedWhere5() {
    assertParse(
      """
      // FuncDecl: Choose 3
      // 1,2,3
      func f123<T: Mashable where T: Womparable>(x: T) -> Int { return 2 }
      // 1,2,4
      func f124<T: Mashable where T: Womparable>(x: T) where T: Equatable {}
      // 2,3,4
      func f234<T where T: Womparable>(x: T) -> Int where T: Equatable { return 2 }
      """
    )
  }

  func testDeprecatedWhere6() {
    assertParse(
      """
      // FuncDecl: Choose 4
      // 1,2,3,4
      func f1234<T: Mashable where T: Womparable>(x: T) -> Int where T: Equatable { return 2 }
      """
    )
  }

  func testDeprecatedWhere7() {
    assertParse(
      """
      // NominalTypeDecl: Choose 0
      struct S0<T> {}
      """
    )
  }

  func testDeprecatedWhere8() {
    assertParse(
      """
      // NominalTypeDecl: Choose 1
      // 1: Inherited constraint
      struct S1<T: Mashable> {} // no-warning
      // 2: Non-trailing where
      struct S2<T where T: Womparable> {}
      // 3: Trailing where
      struct S3<T> where T : Equatable {} // no-warning
      """
    )
  }

  func testDeprecatedWhere9() {
    assertParse(
      """
      // NominalTypeDecl: Choose 2
      // 1,2
      struct S12<T: Mashable where T: Womparable> {}
      // 1,3
      struct S13<T: Mashable> where T: Equatable {} // no-warning
      // 2,3
      struct S23<T where T: Womparable> where T: Equatable {}
      """
    )
  }

  func testDeprecatedWhere10() {
    assertParse(
      """
      // NominalTypeDecl: Choose 3
      // 1,2,3
      struct S123<T: Mashable where T: Womparable> where T: Equatable {}
      """
    )
  }

  func testDeprecatedWhere11() {
    assertParse(
      """
      protocol ProtoA {}
      protocol ProtoB {}
      protocol ProtoC {}
      protocol ProtoD {}
      func testCombinedConstraints<T: ProtoA & ProtoB where T: ProtoC>(x: T) {}
      func testCombinedConstraints<T: ProtoA & ProtoB where T: ProtoC>(x: T) where T: ProtoD {}
      """
    )
  }

  func testDeprecatedWhere12() {
    assertParse(
      """
      func testCombinedConstraintsOldℹ️<T: 2️⃣protocol3️⃣<ProtoA, ProtoB> where T: ProtoC4️⃣>(x: T) {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected inherited type in generic parameter",
          fixIts: ["insert inherited type"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected '>' to end generic parameter clause",
          notes: [NoteSpec(message: "to match this opening '<'")],
          fixIts: ["insert '>'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected parameter clause in function signature",
          fixIts: ["insert parameter clause"]
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "expected identifier in protocol",
          fixIts: ["insert identifier"]
        ),
        DiagnosticSpec(
          locationMarker: "4️⃣",
          message: "unexpected code '>(x: T)' in protocol"
        ),
      ],
      fixedSource: """
        func testCombinedConstraintsOld<T: <#type#>>()protocol <#identifier#><ProtoA, ProtoB> where T: ProtoC>(x: T) {}
        """
    )
  }

  func testDeprecatedWhere13() {
    assertParse(
      """
      func testCombinedConstraintsOldℹ️<T: 2️⃣protocol3️⃣<ProtoA, ProtoB> where T: ProtoC4️⃣>(x: T) where T: ProtoD {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected inherited type in generic parameter",
          fixIts: ["insert inherited type"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected '>' to end generic parameter clause",
          notes: [NoteSpec(message: "to match this opening '<'")],
          fixIts: ["insert '>'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected parameter clause in function signature",
          fixIts: ["insert parameter clause"]
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "expected identifier in protocol",
          fixIts: ["insert identifier"]
        ),
        DiagnosticSpec(
          locationMarker: "4️⃣",
          message: "unexpected code '>(x: T) where T: ProtoD' in protocol"
        ),
      ],
      fixedSource: """
        func testCombinedConstraintsOld<T: <#type#>>()protocol <#identifier#><ProtoA, ProtoB> where T: ProtoC>(x: T) where T: ProtoD {}
        """
    )
  }
}
