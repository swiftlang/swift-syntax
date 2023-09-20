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

final class CaseDetectionMacroTests: XCTestCase {
  private let macros = ["CaseDetection": CaseDetectionMacro.self]

  func testExpansionAddsComputedProperties() {
    assertMacroExpansion(
      """
      @CaseDetection
      enum Animal {
        case dog
        case cat(curious: Bool)
      }
      """,
      expandedSource: """
        enum Animal {
          case dog
          case cat(curious: Bool)

          var isDog: Bool {
            if case .dog = self {
              return true
            }

            return false
          }

          var isCat: Bool {
            if case .cat = self {
              return true
            }

            return false
          }
        }
        """,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }
}
