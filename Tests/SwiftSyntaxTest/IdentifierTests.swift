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

import SwiftSyntax
import XCTest

class IdentifierTests: XCTestCase {
  public func testInit() {
    let basicToken = TokenSyntax(stringLiteral: "sometoken")
    XCTAssertEqual(Identifier(basicToken).name, "sometoken")

    let backtickedToken = TokenSyntax(stringLiteral: "`backtickedtoken`")
    XCTAssertEqual(Identifier(backtickedToken).name, "backtickedtoken")

    let multiBacktickedToken = TokenSyntax(stringLiteral: "```backtickedtoken```")
    XCTAssertEqual(Identifier(multiBacktickedToken).name, "backtickedtoken")
  }
}
