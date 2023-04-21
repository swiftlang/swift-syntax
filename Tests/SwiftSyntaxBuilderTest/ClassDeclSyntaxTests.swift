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

import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class ClassDeclSyntaxTests: XCTestCase {
  func testThrowableClassWithStringInterpolation() throws {
    let buildable = try ClassDeclSyntax("class Foo") {
      try FunctionDeclSyntax("func foo() -> String") {
        StmtSyntax(#"return "hello world""#)
      }
    }

    assertBuildResult(
      buildable,
      """
      class Foo {
          func foo() -> String {
              return "hello world"
          }
      }
      """
    )
  }

  func testThrowableClass() throws {
    let buildable = try ClassDeclSyntax(identifier: .identifier("Foo")) {
      try FunctionDeclSyntax("func foo() -> String") {
        StmtSyntax(#"return "hello world""#)
      }
    }

    assertBuildResult(
      buildable,
      """
      class Foo {
          func foo() -> String {
              return "hello world"
          }
      }
      """
    )
  }

  func testNodeWithoutAnchorPointInResultBuilder() throws {
    let buildable = ClassDeclSyntax(identifier: .identifier("Foo")) {
      DeclSyntax(
        """
          func foo() -> String {
            return "hello world"
          }
        """
      )
    }

    assertBuildResult(
      buildable,
      """
      class Foo {
        func foo() -> String {
          return "hello world"
        }
      }
      """
    )
  }
}
