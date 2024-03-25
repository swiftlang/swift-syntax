//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
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

final class EnvironmentValueMacroMacroTests: XCTestCase {
  private let macros = ["EnvironmentValue": EnvironmentValueMacro.self]

  func testEnvironmentValue() {
    assertMacroExpansion(
      """
      extension EnvironmentValues {
          @EnvironmentValue(for: MyEnvironmentKey.self)
          var myCustomValue: String
      }
      """,
      expandedSource: """
        extension EnvironmentValues {
            var myCustomValue: String {
                get {
                    self[MyEnvironmentKey.self]
                }
                set {
                    self[MyEnvironmentKey.self] = newValue
                }
            }
        }
        """,
      macros: macros
    )
  }
}
