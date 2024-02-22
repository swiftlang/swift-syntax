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

// This test file has been translated from swift/test/Parse/implicit_getter_incomplete.swift

import XCTest

final class ImplicitGetterIncompleteTests: XCTestCase {
  func testImplicitGetterIncomplete1() {
    assertParsedSource(
      #"""
      // Would trigger assertion when AST verifier checks source ranges ("child source range not contained within its parent")
      func test2() {
        var a : Int {
          switch i {
      }
      """#,
      expecting:
        #"""
        1 │ // Would trigger assertion when AST verifier checks source ranges ("child source range not contained within its parent")
        2 │ func test2() {
          │              ╰─ note: to match this opening '{'
        3 │   var a : Int {
          │               ╰─ note: to match this opening '{'
        4 │     switch i {
        5 │ }
          │  ├─ error: expected '}' to end variable
          │  ╰─ error: expected '}' to end function

        """#
    )
  }
}
