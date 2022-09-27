// This test file has been translated from swift/test/Parse/unknown_platform.swift

import XCTest

final class UnknownPlatformTests: XCTestCase {
  func testUnknownPlatform1() {
    AssertParse(
      """
      #if hasGreeble(blah)
      #endif
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unexpected platform condition
      ]
    )
  }

  func testUnknownPlatform2() {
    AssertParse(
      """
      // Future compiler, short-circuit right-hand side
      #if compiler(>=10.0) && hasGreeble(blah)
      #endif
      """
    )
  }

  func testUnknownPlatform3() {
    AssertParse(
      """
      // Current compiler, short-circuit right-hand side
      #if compiler(<10.0) || hasGreeble(blah)
      #endif
      """
    )
  }

  func testUnknownPlatform4() {
    AssertParse(
      """
      // This compiler, don't short-circuit.
      #if compiler(>=5.7) && hasGreeble(blah)
      #endif
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unexpected platform condition
      ]
    )
  }

  func testUnknownPlatform5() {
    AssertParse(
      """
      // This compiler, don't short-circuit.
      #if compiler(<5.8) || hasGreeble(blah)
      #endif
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unexpected platform condition
      ]
    )
  }

  func testUnknownPlatform6() {
    AssertParse(
      #"""
      // Not a "version" check, so don't short-circuit.
      #if os(macOS) && hasGreeble(blah)
      #endif
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unexpected platform condition
      ]
    )
  }

}
