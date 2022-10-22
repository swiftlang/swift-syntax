//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class TypeAnnotationTests: XCTestCase {
  func testStringLiteral() {
    let testCases: [UInt: (ExpressibleAsTypeAnnotation, String)] = [
      #line: (TypeAnnotation(type: "Test"), ": Test"),
      #line: (TypeAnnotation(type: SimpleTypeIdentifier("Test")), ": Test"),
      #line: (TypeAnnotation("Test"), ": Test"),
      #line: (SimpleTypeIdentifier("Test"), ": Test"),
      #line: ("Test", ": Test")
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      AssertBuildResult(builder.createTypeAnnotation(), expected, line: line)
    }
  }
}
