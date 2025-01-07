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

@_spi(Testing) import SwiftSyntax
import XCTest

final class MemoryLayoutTest: XCTestCase {

  func testMemoryLayouts() throws {
    #if !arch(x86_64) && !arch(arm64)
    throw XCTSkip("Only runs on x86_64 and arm64")
    #endif

    /// This test result is just for tracking the memory footprint of syntax nodes,
    /// and they are totally informative purpose. Although we want to keep the
    /// numbers as low as possible, nothing should rely on them, and are not hard
    /// limits in any way.
    /// If this fails, just update the numbers.
    let expected: [String: SyntaxMemoryLayout.Value] = [
      "RawSyntaxData.Layout": .init(size: 41, stride: 48, alignment: 8),
      "RawSyntaxData.ParsedToken": .init(size: 44, stride: 48, alignment: 8),
      "RawSyntaxData.MaterializedToken": .init(size: 52, stride: 56, alignment: 8),
      "RawSyntaxData": .init(size: 64, stride: 64, alignment: 8),
      "RawSyntax?": .init(size: 8, stride: 8, alignment: 8),

      "Syntax": .init(size: 16, stride: 16, alignment: 8),
      "SyntaxData": .init(size: 32, stride: 32, alignment: 8),
      "AbsoluteSyntaxInfo": .init(size: 12, stride: 12, alignment: 4),
      "SyntaxDataReference?": .init(size: 8, stride: 8, alignment: 8),
      "AtomicPointer": .init(size: 8, stride: 8, alignment: 8),
    ]

    let values = SyntaxMemoryLayout.values
    XCTAssertEqual(values.count, expected.count)
    for exp in expected {
      let actualValue = try XCTUnwrap(values[exp.key], "Missing '\(exp.key)'")
      XCTAssertEqual(actualValue, exp.value, "Matching '\(exp.key)' values")
    }
  }

  func testSyntaxDataTailAllocation() throws {
    #if !arch(x86_64) && !arch(arm64)
    throw XCTSkip("Only runs on x86_64 and arm64")
    #endif
    let values = SyntaxMemoryLayout.values
    // This ensures 'AtomicPointer' is safe to tail allocate right after 'SyntaxData.stride'
    XCTAssertGreaterThanOrEqual(values["SyntaxData"]!.alignment, values["AtomicPointer"]!.alignment)
  }
}
