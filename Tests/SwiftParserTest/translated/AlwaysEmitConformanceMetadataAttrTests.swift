// This test file has been translated from swift/test/Parse/alwaysEmitConformanceMetadata_attr.swift

import XCTest

final class AlwaysEmitConformanceMetadataAttrTests: XCTestCase {
  func testAlwaysEmitConformanceMetadataAttr() {
    AssertParse(
      """
      @_alwaysEmitConformanceMetadata
      protocol Test {}
      """
    )
  }

}
