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

// This test file has been translated from swift/test/Parse/async-syntax.swift

import XCTest

final class AsyncSyntaxTests: XCTestCase {
  func testAsyncSyntax1() {
    AssertParse(
      """
      func asyncGlobal1() async { }
      func asyncGlobal2() async throws { }
      """
    )
  }

  func testAsyncSyntax2() {
    AssertParse(
      """
      typealias AsyncFunc1 = () async -> ()
      typealias AsyncFunc2 = () async throws -> ()
      typealias AsyncFunc3 = (_ a: Bool, _ b: Bool) async throws -> ()
      """
    )
  }

  func testAsyncSyntax3() {
    AssertParse(
      """
      func testTypeExprs() {
        let _ = [() async -> ()]()
        let _ = [() async throws -> ()]()
      }
      """
    )
  }

  func testAsyncSyntax4() {
    AssertParse(
      """
      func testAwaitOperator() async {
        let _ = await asyncGlobal1()
      }
      """
    )
  }

  func testAsyncSyntax5() {
    AssertParse(
      """
      func testAsyncClosure() {
        let _ = { () async in 5 }
        let _ = { () throws in 5 }
        let _ = { () async throws in 5 }
      }
      """
    )
  }

  func testAsyncSyntax6() {
    AssertParse(
      """
      func testAwait() async {
        let _ = await asyncGlobal1()
      }
      """
    )
  }

}
