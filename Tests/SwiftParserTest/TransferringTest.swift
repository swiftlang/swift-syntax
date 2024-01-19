//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_spi(ExperimentalLanguageFeatures) import SwiftParser
import XCTest

final class TransferringTests: ParserTestCase {
  func testTransferingArg1() {
    assertParse(
      """
      class Klass {}
      func transferMain(_ x: transferring Klass) -> ()
      """,
      experimentalFeatures: .transferringArgsAndResults
    )
  }

  func testTransferingArgMiddle() {
    assertParse(
      """
      class Klass {}
      func transferMain(_ y: Klass, _ x: transferring Klass, _ z: Klass) -> ()
      """,
      experimentalFeatures: .transferringArgsAndResults
    )
  }
}
