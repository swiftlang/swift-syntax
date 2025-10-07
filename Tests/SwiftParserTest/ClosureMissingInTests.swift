//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_spi(ExperimentalLanguageFeatures) @_spi(RawSyntax) import SwiftParser
@_spi(ExperimentalLanguageFeatures) @_spi(RawSyntax) import SwiftSyntax
import XCTest

final class ClosureMissingInTests: ParserTestCase {

  func testMissingInAfterSignature() {
    assertParse(
      """
      _ = { (x: Int) -> Int 1️⃣0 }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected 'in' in closure signature",
          fixIts: ["insert 'in'"]
        )
      ],
      fixedSource: """
        _ = { (x: Int) -> Int in 0 }
        """
    )
  }

  func testArrayLiteralNotMisparsedAsSignature() {
    assertParse(
      """
      _ = { [x, y] }
      """
    )
  }

  func testAsyncIsNotASignatureGate() {
    assertParse(
      """
      _ = { async }
      """
    )
  }

  func testShorthandParamsWithReturnType() {
    assertParse(
      """
      _ = { x, _ -> Int 1️⃣x }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected 'in' in closure signature",
          fixIts: ["insert 'in'"]
        )
      ],
      fixedSource: """
        _ = { x, _ -> Int in x }
        """
    )
  }

  func testResyncTokensBeforeIn() {
    assertParse(
      """
      _ = { () -> Int
        1️⃣0
        in
        1
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code '0' in closure signature"
        )
      ]
    )
  }

  func testMissingInInFunctionArgument() {
    assertParse(
      """
      test(make: { () -> [Int] 1️⃣
        return [3]
      }, consume: { _ in
        print("Test")
      })
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected 'in' in closure signature",
          fixIts: ["insert 'in'"]
        )
      ],
      fixedSource:
        """
        test(make: { () -> [Int] in
          return [3]
        }, consume: { _ in
          print("Test")
        })
        """
    )
  }
}
