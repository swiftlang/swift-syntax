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

import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest

final class SubscriptTests: XCTestCase {
  func testSubscriptGetter() throws {
    let buildable = try SubscriptDeclSyntax("subscript(_ index: Int) -> Element") {
      StmtSyntax("return storage[index]")
    }

    assertBuildResult(
      buildable,
      """
      subscript(_ index: Int) -> Element {
          return storage[index]
      }
      """
    )
  }

  func testSubscriptAccessorList() throws {
    let buildable = try SubscriptDeclSyntax("subscript(_ index: Int) -> Element") {
      AccessorDeclSyntax(accessorSpecifier: .keyword(.get)) {
        StmtSyntax("return storage[index]")
      }

      AccessorDeclSyntax(accessorSpecifier: .keyword(.set)) {
        ExprSyntax("storage[index] = newValue")
      }
    }

    assertBuildResult(
      buildable,
      """
      subscript(_ index: Int) -> Element {
          get {
              return storage[index]
          }
          set {
              storage[index] = newValue
          }
      }
      """
    )
  }

  func testSubscriptProtocolRequirement() throws {
    let buildable = DeclSyntax("subscript(_ index: Int) -> Element { get set }")

    assertBuildResult(
      buildable,
      """
      subscript(_ index: Int) -> Element {
          get
          set
      }
      """
    )
  }
}
