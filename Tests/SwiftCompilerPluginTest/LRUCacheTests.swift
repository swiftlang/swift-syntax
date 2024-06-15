//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_spi(Testing) import SwiftCompilerPluginMessageHandling
import XCTest

final class LRUCacheTests: XCTestCase {
  func testBasic() {
    let cache = LRUCache<String, Int>(capacity: 2)
    cache["foo"] = 0
    cache["bar"] = 1
    XCTAssertEqual(cache["foo"], 0)
    cache["baz"] = 2
    XCTAssertEqual(cache["foo"], 0)
    XCTAssertEqual(cache["bar"], nil)
    XCTAssertEqual(cache["baz"], 2)
    XCTAssertEqual(cache.count, 2)

    cache["qux"] = nil
    cache["baz"] = nil
    cache["foo"] = 10
    XCTAssertEqual(cache["foo"], 10)
    XCTAssertEqual(cache["bar"], nil)
    XCTAssertEqual(cache["baz"], nil)
    XCTAssertEqual(cache["qux"], nil)
    XCTAssertEqual(cache.count, 1)
  }
}
