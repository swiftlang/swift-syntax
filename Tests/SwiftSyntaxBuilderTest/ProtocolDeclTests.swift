//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class ProtocolDeclTests: XCTestCase {
  func testProtocolDecl() {
    let buildable = ProtocolDecl("public protocol DeclListBuildable") {
      FunctionDecl("func buildDeclList(format: Format, leadingTrivia: Trivia?) -> [DeclSyntax]")
    }

    AssertBuildResult(
      buildable,
      """
      public protocol DeclListBuildable {
          func buildDeclList(format: Format, leadingTrivia: Trivia?) -> [DeclSyntax]
      }
      """
    )
  }
}
