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

final class MemberDeprecatedMacroTests: XCTestCase {
  private let macros = ["memberDeprecated": MemberDeprecatedMacro.self]

  func testExpansionMarksMembersAsDeprecated() {
    assertMacroExpansion(
      """
      @memberDeprecated
      public struct SomeStruct {
        typealias MacroName = String

        public var oldProperty: Int = 420

        func oldMethod() {
          print("This is an old method.")
        }
      }
      """,
      expandedSource: """
        public struct SomeStruct {
          @available(*, deprecated)
          typealias MacroName = String
          @available(*, deprecated)

          public var oldProperty: Int = 420
          @available(*, deprecated)

          func oldMethod() {
            print("This is an old method.")
          }
        }
        """,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }
}
