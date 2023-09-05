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

import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest

final class FunctionParameterSyntaxTests: XCTestCase {
  func testFunctionParameterSyntaxSpacing() {
    let builder = FunctionParameterSyntax(firstName: "on", secondName: "eventLoop", type: TypeSyntax("EventLoop"))
    assertBuildResult(
      builder,
      """
      on eventLoop: EventLoop
      """
    )
  }
}
