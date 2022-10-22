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

final class ProtocolDeclTests: XCTestCase {
  func testProtocolDecl() {
    let returnType = ArrayType(elementType: Type("DeclSyntax"))
    let input = ParameterClause {
      FunctionParameter(firstName: .identifier("format"), colon: .colon, type: Type("Format"))
      FunctionParameter(firstName: .identifier("leadingTrivia"), colon: .colon, type: OptionalType(wrappedType: Type("Trivia")))
    }
    let functionSignature = FunctionSignature(input: input, output: ReturnClause(returnType: returnType))

    let buildable = ProtocolDecl(modifiers: [DeclModifier(name: .public)], identifier: "DeclListBuildable") {
      FunctionDecl(identifier: .identifier("buildDeclList"), signature: functionSignature, body: nil)
    }

    AssertBuildResult(buildable, """
    public protocol DeclListBuildable {
        func buildDeclList(format: Format, leadingTrivia: Trivia?) -> [DeclSyntax]
    }
    """)
  }
}
