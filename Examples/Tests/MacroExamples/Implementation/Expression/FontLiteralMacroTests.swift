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

final class FontLiteralMacroTests: XCTestCase {
  private let macros = ["fontLiteral": FontLiteralMacro.self]

  func testExpansionWithNamedArguments() {
    assertMacroExpansion(
      """
      #fontLiteral(name: "Comic Sans", size: 14, weight: .thin)
      """,
      expandedSource: """
        .init(fontLiteralName: "Comic Sans", size: 14, weight: .thin)
        """,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionWithUnlabeledFirstArgument() {
    assertMacroExpansion(
      """
      #fontLiteral("Copperplate Gothic", size: 69, weight: .bold)
      """,
      expandedSource: """
        .init(fontLiteralName: "Copperplate Gothic", size: 69, weight: .bold)
        """,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }
}
