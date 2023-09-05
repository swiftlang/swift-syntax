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

final class SwitchTests: XCTestCase {
  func testSwitch() {
    let syntax = SwitchExprSyntax(subject: ExprSyntax("count")) {
      for num in 1..<3 {
        SwitchCaseSyntax("case \(literal: num):") {
          ExprSyntax("print(count)")
        }
      }
      SwitchCaseSyntax("default:") {
        StmtSyntax("break")
      }
    }

    assertBuildResult(
      syntax,
      """
      switch count {
      case 1:
          print(count)
      case 2:
          print(count)
      default:
          break
      }
      """
    )
  }

  func testSwitchStmtSyntaxWithStringParsing() throws {
    let syntax = try SwitchExprSyntax("switch count") {
      for num in 1..<3 {
        SwitchCaseSyntax("case \(literal: num):") {
          ExprSyntax("print(count)")
        }
      }
      SwitchCaseSyntax("default:") {
        StmtSyntax("break")
      }
    }

    assertBuildResult(
      syntax,
      """
      switch count {
      case 1:
          print(count)
      case 2:
          print(count)
      default:
          break
      }
      """
    )
  }
}
