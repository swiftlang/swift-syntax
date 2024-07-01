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

import SwiftRefactor
import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest
import _SwiftSyntaxTestSupport

final class ConvertComputedPropertyToStoredTest: XCTestCase {
  func testToStored() throws {
    let baseline: DeclSyntax = """
      var defaultColor: Color { Color() }
      """

    let expected: DeclSyntax = """
      let defaultColor: Color = Color()
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testToStoredWithMultipleStatementsInAccessor() throws {
    let baseline: DeclSyntax = """
      var defaultColor: Color {
        let color = Color()
        return color
      }
      """

    let expected: DeclSyntax = """
      let defaultColor: Color = {
        let color = Color()
        return color
      }()
      """

    try assertRefactorConvert(baseline, expected: expected)
  }
}

fileprivate func assertRefactorConvert(
  _ callDecl: DeclSyntax,
  expected: DeclSyntax?,
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  try assertRefactor(
    callDecl,
    context: (),
    provider: ConvertComputedPropertyToStored.self,
    expected: expected,
    file: file,
    line: line
  )
}
