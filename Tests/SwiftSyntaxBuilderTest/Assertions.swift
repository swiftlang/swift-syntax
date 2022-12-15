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

import SwiftSyntax
import SwiftSyntaxBuilder
import _SwiftSyntaxTestSupport

import XCTest

func AssertBuildResult<T: SyntaxProtocol>(_ buildable: T, _ expectedResult: String, file: StaticString = #file, line: UInt = #line) {
  AssertStringsEqualWithDiff(
    buildable.formatted().description.trimmingTrailingWhitespace(),
    expectedResult.trimmingTrailingWhitespace(),
    file: file,
    line: line
  )
}
