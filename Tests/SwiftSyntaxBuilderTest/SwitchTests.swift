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

final class SwitchTests: XCTestCase {
  func testSwitch() {
    let syntax = SwitchStmt(expression: Expr("count")) {
      for num in 1..<3 {
        SwitchCase("case \(literal: num):") {
          Expr("print(count)")
        }
      }
      SwitchCase("default:") {
        BreakStmt("break")
      }
    }

    AssertBuildResult(
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
