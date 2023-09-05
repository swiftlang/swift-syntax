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

final class ProtocolDeclTests: XCTestCase {
  func testProtocolDecl() throws {
    let buildable = try ProtocolDeclSyntax("public protocol DeclListBuildable") {
      DeclSyntax("func buildDeclList(format: Format, leadingTrivia: Trivia?) -> [DeclSyntax]")
    }

    assertBuildResult(
      buildable,
      """
      public protocol DeclListBuildable {
          func buildDeclList(format: Format, leadingTrivia: Trivia?) -> [DeclSyntax]
      }
      """
    )
  }
}
