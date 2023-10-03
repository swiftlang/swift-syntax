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

import MacroExamplesImplementation
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

final class StringifyMacroTests: XCTestCase {
  private let macros = ["stringify": StringifyMacro.self]

  func testExpansionWithBasicArithmeticExpression() {
    assertMacroExpansion(
      """
      let a = #stringify(x + y)
      """,
      expandedSource: """
        let a = (x + y, "x + y")
        """,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionWithStringInterpolation() {
    assertMacroExpansion(
      #"""
      let b = #stringify("Hello, \(name)")
      """#,
      expandedSource: #"""
        let b = ("Hello, \(name)", #""Hello, \(name)""#)
        """#,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }
}
