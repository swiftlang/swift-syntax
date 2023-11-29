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
import _SwiftSyntaxTestSupport

func assertBuildResult<T: SyntaxProtocol>(
  _ buildable: T,
  _ expectedResult: String,
  trimTrailingWhitespace: Bool = true,
  format: Bool = true,
  file: StaticString = #file,
  line: UInt = #line
) {
  var buildableDescription =
    format
    ? buildable.formatted().description
    : buildable.description
  var expectedResult = expectedResult
  if trimTrailingWhitespace {
    buildableDescription = buildableDescription.trimmingTrailingWhitespace()
    expectedResult = expectedResult.trimmingTrailingWhitespace()
  }
  assertStringsEqualWithDiff(
    buildableDescription,
    expectedResult,
    file: file,
    line: line
  )
}
