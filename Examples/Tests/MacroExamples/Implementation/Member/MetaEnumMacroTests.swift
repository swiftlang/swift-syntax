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

final class MetaEnumMacroTests: XCTestCase {
  private let macros = ["MetaEnum": MetaEnumMacro.self]

  func testExpansionAddsNestedMetaEnum() {
    assertMacroExpansion(
      """
      @MetaEnum enum Cell {
        case integer(Int)
        case text(String)
        case boolean(Bool)
        case null
      }
      """,
      expandedSource: """
        enum Cell {
          case integer(Int)
          case text(String)
          case boolean(Bool)
          case null

          enum Meta {
            case integer
            case text
            case boolean
            case null
            init(_ __macro_local_6parentfMu_: Cell) {
              switch __macro_local_6parentfMu_ {
              case .integer:
                self = .integer
              case .text:
                self = .text
              case .boolean:
                self = .boolean
              case .null:
                self = .null
              }
            }
          }
        }
        """,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionAddsPublicNestedMetaEnum() {
    assertMacroExpansion(
      """
      @MetaEnum public enum Cell {
        case integer(Int)
        case text(String)
        case boolean(Bool)
      }
      """,
      expandedSource: """
        public enum Cell {
          case integer(Int)
          case text(String)
          case boolean(Bool)

          public enum Meta {
            case integer
            case text
            case boolean
            public init(_ __macro_local_6parentfMu_: Cell) {
              switch __macro_local_6parentfMu_ {
              case .integer:
                self = .integer
              case .text:
                self = .text
              case .boolean:
                self = .boolean
              }
            }
          }
        }
        """,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionOnStructEmitsError() {
    assertMacroExpansion(
      """
      @MetaEnum struct Cell {
        let integer: Int
        let text: String
        let boolean: Bool
      }
      """,
      expandedSource: """
        struct Cell {
          let integer: Int
          let text: String
          let boolean: Bool
        }
        """,
      diagnostics: [
        DiagnosticSpec(
          message: "'@MetaEnum' can only be attached to an enum, not a struct",
          line: 1,
          column: 1,
          severity: .error
        )
      ],
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }
}
