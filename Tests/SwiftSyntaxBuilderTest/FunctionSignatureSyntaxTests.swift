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

final class FunctionSignatureSyntaxTests: XCTestCase {
  func testFunctionEffectSpecifiersSyntax() throws {
    let functionEffects = FunctionEffectSpecifiersSyntax(
      asyncSpecifier: .keyword(.async),
      throwsClause: ThrowsClauseSyntax(throwsSpecifier: .keyword(.rethrows))
    )
    let buildable = FunctionSignatureSyntax(
      parameterClause: .init(parameters: []),
      effectSpecifiers: functionEffects,
      returnClause: .init(type: TypeSyntax("String"))
    )

    assertBuildResult(
      buildable,
      """
      () async rethrows -> String
      """
    )
  }
}
