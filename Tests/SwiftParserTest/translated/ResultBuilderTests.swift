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

// This test file has been translated from swift/test/Parse/result-builder.swift

import XCTest

final class ResultBuilderTests: ParserTestCase {
  func testResultBuilder1() {
    assertParse(
      """
      // rdar://70158735
      """
    )
  }

  func testResultBuilder2() {
    assertParse(
      """
      @resultBuilder
      struct A<T> {
        static func buildBlock(_ values: Int...) -> Int { return 0 }
      }
      """
    )
  }

  func testResultBuilder3() {
    assertParse(
      """
      struct B<T> {}
      """
    )
  }

  func testResultBuilder4() {
    assertParse(
      """
      extension B {
        @resultBuilder
        struct Generic<U> {
          static func buildBlock(_ values: Int...) -> Int { return 0 }
        }
        @resultBuilder
        struct NonGeneric {
          static func buildBlock(_ values: Int...) -> Int { return 0 }
        }
      }
      """
    )
  }

  func testResultBuilder5() {
    assertParse(
      """
      @A<Float> var test0: Int {
        1
        2
        3
      }
      """
    )
  }

  func testResultBuilder6() {
    assertParse(
      """
      @B<Float>.NonGeneric var test1: Int {
        1
        2
        3
      }
      """
    )
  }

  func testResultBuilder7() {
    assertParse(
      """
      @B<Float>.Generic<Float> var test2: Int {
        1
        2
        3
      }
      """
    )
  }

}
