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

// This test file has been translated from swift/test/Parse/implicit_getter_incomplete.swift

import XCTest

final class ImplicitGetterIncompleteTests: ParserTestCase {
  func testImplicitGetterIncomplete1() {
    assertParse(
      """
      func test1() {
        var a : Int {
      #if arch(x86_64)
          return 0
      #else
          return 1
      #endif
        }
      }
      """
    )
  }

  func testImplicitGetterIncomplete2() {
    assertParse(
      #"""
      // Would trigger assertion when AST verifier checks source ranges ("child source range not contained within its parent")
      func test2() 1️⃣{
        var a : Int 2️⃣{
          switch i {
      }3️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "expected '}' to end variable",
          notes: [NoteSpec(locationMarker: "2️⃣", message: "to match this opening '{'")],
          fixIts: ["insert '}'"]
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "expected '}' to end function",
          notes: [NoteSpec(locationMarker: "1️⃣", message: "to match this opening '{'")],
          fixIts: ["insert '}'"]
        ),
      ],
      fixedSource: #"""
        // Would trigger assertion when AST verifier checks source ranges ("child source range not contained within its parent")
        func test2() {
          var a : Int {
            switch i {
        }
        }
        }
        """#
    )
  }
}
