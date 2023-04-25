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

import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class FunctionSignatureSyntaxTests: XCTestCase {
  func testFunctionEffectSpecifiersSyntax() throws {
    let functionEffects = FunctionEffectSpecifiersSyntax(asyncSpecifier: .keyword(.async), throwsSpecifier: .keyword(.rethrows))
    let buildable = FunctionSignatureSyntax(input: .init(parameterList: []), effectSpecifiers: functionEffects, output: .init(returnType: TypeSyntax("String")))

    assertBuildResult(
      buildable,
      """
      () async rethrows -> String
      """
    )
  }
}
