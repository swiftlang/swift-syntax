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

// This test file has been translated from swift/test/Parse/guard-top-level.swift

import XCTest

final class GuardTopLevelTests: XCTestCase {
  func testGuardTopLevel1() {
    AssertParse(
      """
      let a: Int? = 1
      guard let b = a else {
      }
      """
    )
  }

  func testGuardTopLevel2() {
    AssertParse(
      """
      func foo() {} // to interrupt the TopLevelCodeDecl
      """
    )
  }

  func testGuardTopLevel3() {
    AssertParse(
      """
      let c = b
      """
    )
  }

}
