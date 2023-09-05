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
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacroExpansion
import SwiftSyntaxMacros
import XCTest

final class NewTypePluginTests: XCTestCase {
  let testMacros: [String: Macro.Type] = [
    "NewType": NewTypeMacro.self
  ]

  func testNewType() {
    let sf: SourceFileSyntax =
      #"""
      @NewType(String.self)
      public struct MyString {
      }
      """#

    // print(sf.recursiveDescription)

    let context = BasicMacroExpansionContext(
      sourceFiles: [sf: .init(moduleName: "MyModule", fullFilePath: "test.swift")]
    )

    let transformed = sf.expand(macros: testMacros, in: context)

    // print(transformed.recursiveDescription)

    XCTAssertEqual(
      transformed.description,
      #"""

      public struct MyString {

          public typealias RawValue = String

          public var rawValue: RawValue

          public init(_ rawValue: RawValue) {
              self.rawValue = rawValue
          }
      }
      """#
    )
  }
}
