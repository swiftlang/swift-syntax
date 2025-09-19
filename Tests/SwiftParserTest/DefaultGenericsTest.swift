//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_spi(ExperimentalLanguageFeatures) import SwiftParser
import SwiftSyntax
import XCTest

final class DefaultGenericsTest: ParserTestCase {
  func testBasic() {
    assertParse(
      """
      struct A<T = Int> {}
      """,
      experimentalFeatures: [.defaultGenerics]
    )

    assertParse(
      """
      enum A<T = String> {}
      """,
      experimentalFeatures: [.defaultGenerics]
    )

    assertParse(
      """
      class A<T = Bool> {}
      """,
      experimentalFeatures: [.defaultGenerics]
    )

    // Note: We don't allow default generics on things other than types, but
    // we'll diagnose it during sema.
    assertParse(
      """
      func foo<T = [Int]>() {}
      """,
      experimentalFeatures: [.defaultGenerics]
    )

    assertParse(
      """
      struct A<T = 1️⃣> {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected type in generic parameter",
          fixIts: ["insert type"]
        )
      ],
      fixedSource: """
        struct A<T = <#type#>> {}
        """,
      experimentalFeatures: [.defaultGenerics]
    )

    assertParse(
      """
      struct Aℹ️<each T1️⃣2️⃣= Int> {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '>' to end generic parameter clause",
          notes: [
            NoteSpec(message: "to match this opening '<'")
          ],
          fixIts: ["insert '>'"]
        ),
        DiagnosticSpec(
          message: "unexpected code '= Int>' in struct"
        ),
      ],
      fixedSource: """
        struct A<each T> = Int> {}
        """,
      experimentalFeatures: [.defaultGenerics]
    )

    assertParse(
      """
      struct Aℹ️<let n: Int1️⃣2️⃣= Int> {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '>' to end generic parameter clause",
          notes: [
            NoteSpec(message: "to match this opening '<'")
          ],
          fixIts: ["insert '>'"]
        ),
        DiagnosticSpec(
          message: "unexpected code '= Int>' in struct"
        ),
      ],
      fixedSource: """
        struct A<let n: Int> = Int> {}
        """,
      experimentalFeatures: [.defaultGenerics]
    )
  }
}
