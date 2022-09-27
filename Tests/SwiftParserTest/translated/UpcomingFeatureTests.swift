// This test file has been translated from swift/test/Parse/upcoming_feature.swift

import XCTest

final class UpcomingFeatureTests: XCTestCase {
  func testUpcomingFeature1() {
    AssertParse(
      """
      #if hasFeature(17)
      #endif
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unexpected platform condition argument: expected feature name
      ]
    )
  }

}
