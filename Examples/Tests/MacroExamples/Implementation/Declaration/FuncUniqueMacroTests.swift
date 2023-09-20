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

final class FuncUniqueMacroTests: XCTestCase {
  private let macros = ["FuncUnique": FuncUniqueMacro.self]

  func testExpansionCreatesDeclarationWithUniqueFunction() {
    assertMacroExpansion(
      """
      #FuncUnique()
      """,
      expandedSource: #"""
        class MyClass {
          func __macro_local_6uniquefMu_() {
          }
        }
        """#,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }
}
