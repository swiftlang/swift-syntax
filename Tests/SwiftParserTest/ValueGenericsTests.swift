//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_spi(ExperimentalLanguageFeatures) import SwiftParser
import SwiftSyntax
import XCTest

final class ValueGenericsTests: ParserTestCase {
  func testBasic() {
    // Note: This is structurally illegal, but we don't diagnose that it is
    // until type checking.
    assertParse(
      """
      func requirement<let T>() {}
      """
    )

    assertParse(
      """
      func requirement<let T: Int>() {}
      """
    )

    assertParse(
      """
      func requirement<let T1️⃣...>() {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "ellipsis operator cannot be used with a type parameter pack",
          fixIts: ["remove '...'"]
        )
      ],
      fixedSource: """
        func requirement<let T>() {}
        """
    )
  }

  func testCombination() {
    assertParse(
      """
      func requirementℹ️<each 1️⃣let T2️⃣>() {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected name in generic parameter",
          fixIts: ["insert name"]
        ),
        DiagnosticSpec(
          message: "expected '>' to end generic parameter clause",
          notes: [
            NoteSpec(
              message: "to match this opening '<'"
            )
          ],
          fixIts: ["insert '>'"]
        ),
        DiagnosticSpec(
          message: "expected parameter clause in function signature",
          fixIts: ["insert parameter clause"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "extraneous code '>() {}' at top level"
        ),
      ],
      fixedSource: """
        func requirement<each <#identifier#>>()let T>() {}
        """
    )

    assertParse(
      """
      func requirementℹ️<let each1️⃣ 2️⃣T>() {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '>' to end generic parameter clause",
          notes: [
            NoteSpec(
              message: "to match this opening '<'"
            )
          ],
          fixIts: ["insert '>'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "unexpected code 'T>' before parameter clause"
        ),
      ],
      fixedSource: """
        func requirement<let each>T>() {}
        """
    )
  }

  func testIntegers() {
    assertParse(
      """
      let x: 1️⃣123
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected type in type annotation",
          fixIts: ["insert type"]
        ),
        DiagnosticSpec(
          message: "expected '=' in variable",
          fixIts: ["insert '='"]
        ),
      ],
      fixedSource: """
        let x: <#type#> = 123
        """,
      experimentalFeatures: .valueGenerics
    )

    assertParse(
      """
      let x: Generic<123>
      """,
      experimentalFeatures: .valueGenerics
    )

    assertParse(
      """
      let x: Generic<-123>
      """,
      experimentalFeatures: .valueGenerics
    )

    assertParse(
      """
      let x = Generic<123>.self
      """,
      experimentalFeatures: .valueGenerics
    )

    assertParse(
      """
      let x = Generic<-123>.self
      """,
      experimentalFeatures: .valueGenerics
    )

    assertParse(
      """
      let x = Generic<123, Int>.self
      """,
      experimentalFeatures: .valueGenerics
    )

    assertParse(
      """
      let x = Generic<-123, Int>.self
      """,
      experimentalFeatures: .valueGenerics
    )

    assertParse(
      """
      let x = Generic<Int, 123>.self
      """,
      experimentalFeatures: .valueGenerics
    )

    assertParse(
      """
      let x: Generic<Int, -123>.self
      """,
      experimentalFeatures: .valueGenerics
    )

    assertParse(
      """
      typealias One = 1️⃣1
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected type in typealias declaration",
          fixIts: ["insert type"]
        )
      ],
      fixedSource: """
        typealias One = <#type#>1
        """,
      experimentalFeatures: .valueGenerics
    )

    assertParse(
      """
      extension Vector where N == 123 {}
      """,
      experimentalFeatures: .valueGenerics
    )

    assertParse(
      """
      extension Vector where 123 == N {}
      """,
      experimentalFeatures: .valueGenerics
    )

    assertParse(
      """
      extension Vector where N == -123 {}
      """,
      experimentalFeatures: .valueGenerics
    )

    assertParse(
      """
      extension Vector where -123 == N {}
      """,
      experimentalFeatures: .valueGenerics
    )

    assertParse(
      """
      extension Vector where N: 1️⃣123 {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected type in conformance requirement",
          fixIts: ["insert type"]
        ),
        DiagnosticSpec(
          message: "unexpected code '123' in extension"
        ),
      ],
      fixedSource: """
        extension Vector where N: <#type#> 123 {}
        """,
      experimentalFeatures: .valueGenerics
    )

    assertParse(
      """
      extension Vector where N: 1️⃣-123 {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected type in conformance requirement",
          fixIts: ["insert type"]
        ),
        DiagnosticSpec(
          message: "unexpected code '-123' in extension"
        ),
      ],
      fixedSource: """
        extension Vector where N: <#type#> -123 {}
        """,
      experimentalFeatures: .valueGenerics
    )

    assertParse(
      """
      extension Vector where 1231️⃣: N {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected ':' or '==' to indicate a conformance or same-type requirement"
        ),
        DiagnosticSpec(
          message: "unexpected code ': N' in extension"
        ),
      ],
      experimentalFeatures: .valueGenerics
    )

    assertParse(
      """
      extension Vector where -1231️⃣: N {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected ':' or '==' to indicate a conformance or same-type requirement"
        ),
        DiagnosticSpec(
          message: "unexpected code ': N' in extension"
        ),
      ],
      experimentalFeatures: .valueGenerics
    )

    assertParse(
      "func foo() -> (1️⃣-1) X",
      diagnostics: [
        DiagnosticSpec(
          message: "expected type in tuple type",
          fixIts: ["insert type"]
        ),
        DiagnosticSpec(message: "unexpected code '-1' in tuple type"),
      ],
      fixedSource: "func foo() -> (<#type#>-1) X",
      experimentalFeatures: [.valueGenerics]
    )
  }
}
