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

final class SendingTests: ParserTestCase {
  func testSendingArg1() {
    assertParse(
      """
      class Klass {}
      func transferMain(_ x: sending Klass) -> ()
      """,
      experimentalFeatures: .sendingArgsAndResults
    )
  }

  func testSendingArgMiddle() {
    assertParse(
      """
      class Klass {}
      func transferMain(_ y: Klass, _ x: sending Klass, _ z: Klass) -> ()
      """,
      experimentalFeatures: .sendingArgsAndResults
    )
  }
}
