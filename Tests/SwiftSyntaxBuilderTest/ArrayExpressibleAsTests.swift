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
import SwiftBasicFormat

final class ArrayExpressibleAsTests: XCTestCase {
  func testSimpleModifierList() {
    let modifiers: ExpressibleAsModifierList = [Token.public, Token.static]
    AssertBuildResult(modifiers.createModifierList(), "public static ")
  }

  func testHeterogeneousList() {
    let modifiers: ExpressibleAsModifierList = [Token.open, DeclModifier(name: Token.internal)]
    AssertBuildResult(modifiers.createModifierList(), "open internal ")
  }

  func testExplicitlyTypeErasedList() {
    let modifiers: [DeclModifier] = [DeclModifier(name: Token.private)]
    let expressible: ExpressibleAsModifierList = modifiers as [ExpressibleAsDeclModifier]
    AssertBuildResult(expressible.createModifierList(), "private ")
  }

  func testFunctionParameters() {
    let signature = FunctionSignature(
      input: ParameterClause {
        FunctionParameter(
          attributes: nil,
          firstName: .wildcard,
          secondName: .identifier("args"),
          colon: .colon,
          type: ArrayType(elementType: "String")
        )
      },
      output: "Int"
    )
    AssertBuildResult(signature, "(_ args: [String]) -> Int")
  }
}
