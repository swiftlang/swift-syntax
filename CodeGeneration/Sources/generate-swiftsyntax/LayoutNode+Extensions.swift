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
import SyntaxSupport

extension LayoutNode {
  func generateInitializerDeclHeader(useDeprecatedChildName: Bool = false) -> PartialSyntaxNodeString {
    if children.isEmpty {
      return "public init()"
    }

    func createFunctionParameterSyntax(for child: Child) -> FunctionParameterSyntax {
      var paramType: TypeSyntax
      if !child.kind.isNodeChoicesEmpty {
        paramType = "\(raw: child.name)"
      } else if child.hasBaseType {
        paramType = "some \(raw: child.syntaxNodeKind.protocolType)"
      } else {
        paramType = child.syntaxNodeKind.syntaxType
      }

      if child.isOptional {
        if paramType.is(ConstrainedSugarTypeSyntax.self) {
          paramType = "(\(paramType))?"
        } else {
          paramType = "\(paramType)?"
        }
      }

      let parameterName: String

      if useDeprecatedChildName, let deprecatedVarName = child.deprecatedVarName {
        parameterName = deprecatedVarName
      } else {
        parameterName = child.varName
      }

      return FunctionParameterSyntax(
        leadingTrivia: .newline,
        firstName: child.isUnexpectedNodes ? .wildcardToken(trailingTrivia: .space) : .identifier(parameterName),
        secondName: child.isUnexpectedNodes ? .identifier(parameterName) : nil,
        colon: .colonToken(),
        type: paramType,
        defaultArgument: child.defaultInitialization
      )
    }

    let params = FunctionParameterListSyntax {
      FunctionParameterSyntax("leadingTrivia: Trivia? = nil")

      for child in children {
        createFunctionParameterSyntax(for: child)
      }

      FunctionParameterSyntax("trailingTrivia: Trivia? = nil")
        .with(\.leadingTrivia, .newline)
    }

    return """
      public init(
      \(params)
      )
      """
  }
}
