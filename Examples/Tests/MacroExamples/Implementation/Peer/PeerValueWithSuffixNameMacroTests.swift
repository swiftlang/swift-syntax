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

final class PeerValueWithSuffixNameMacroTests: XCTestCase {
  private let macros = ["PeerValueWithSuffixName": PeerValueWithSuffixNameMacro.self]

  func testExpansionAddsPeerValueToPrivateActor() {
    assertMacroExpansion(
      """
      @PeerValueWithSuffixName
      private actor Counter {
        var value = 0
      }
      """,
      expandedSource: """
        private actor Counter {
          var value = 0
        }

        var Counter_peer: Int {
          1
        }
        """,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionAddsPeerValueToFunction() {
    assertMacroExpansion(
      """
      @PeerValueWithSuffixName
      func someFunction() {}
      """,
      expandedSource: """
        func someFunction() {}

        var someFunction_peer: Int {
          1
        }
        """,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionIgnoresVariables() {
    assertMacroExpansion(
      """
      @PeerValueWithSuffixName
      var someVariable: Int
      """,
      expandedSource: """
        var someVariable: Int
        """,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }
}
