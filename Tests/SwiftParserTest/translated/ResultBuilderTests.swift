// This test file has been translated from swift/test/Parse/result-builder.swift

import XCTest

final class ResultBuilderTests: XCTestCase {
  func testResultBuilder1() {
    AssertParse(
      """
      // rdar://70158735
      """
    )
  }

  func testResultBuilder2() {
    AssertParse(
      """
      @resultBuilder
      struct A<T> {
        static func buildBlock(_ values: Int...) -> Int { return 0 }
      }
      """
    )
  }

  func testResultBuilder3() {
    AssertParse(
      """
      struct B<T> {}
      """
    )
  }

  func testResultBuilder4() {
    AssertParse(
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
    AssertParse(
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
    AssertParse(
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
    AssertParse(
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
