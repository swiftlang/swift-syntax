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
import Utils

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

  func generateInitializerDocComment() -> SwiftSyntax.Trivia {
    func generateParamDocComment(for child: Child) -> String? {
      guard let documentation = child.documentation,
        let firstLine = documentation.split(whereSeparator: \.isNewline).first
      else {
        return nil
      }

      return "  - \(child.varName): \(firstLine)"
    }

    let formattedParams = """
      - Parameters:
        - leadingTrivia: Trivia to be prepended to the leading trivia of the node’s first token. \
      If the node is empty, there is no token to attach the trivia to and the parameter is ignored.
      \(children.compactMap(generateParamDocComment).joined(separator: "\n"))
        - trailingTrivia: Trivia to be appended to the trailing trivia of the node’s last token. \
      If the node is empty, there is no token to attach the trivia to and the parameter is ignored.
      """.removingEmptyLines

    return docCommentTrivia(from: formattedParams)
  }

  /// Create a builder-based convenience initializer, if needed.
  func createConvenienceBuilderInitializer(useDeprecatedChildName: Bool = false) throws -> InitializerDeclSyntax? {
    // Only create the convenience initializer if at least one parameter
    // is different than in the default initializer generated above.
    var shouldCreateInitializer = false

    // Keep track of init parameters and result builder parameters in different
    // lists to make sure result builder params occur at the end, so that
    // they can use trailing closure syntax.
    var normalParameters: [FunctionParameterSyntax] = []
    var builderParameters: [FunctionParameterSyntax] = []
    var delegatedInitArgs: [TupleExprElementSyntax] = []

    for child in children {
      /// The expression that is used to call the default initializer defined above.
      let produceExpr: ExprSyntax
      let childName: String

      if useDeprecatedChildName, let deprecatedVarName = child.deprecatedVarName {
        childName = deprecatedVarName
      } else {
        childName = child.varName
      }

      if child.type.isBuilderInitializable {
        // Allow initializing certain syntax collections with result builders
        shouldCreateInitializer = true
        let builderInitializableType = child.type.builderInitializableType
        if child.type.builderInitializableType != child.type {
          let param = Node.from(type: child.type).layoutNode!.singleNonDefaultedChild
          if child.isOptional {
            produceExpr = ExprSyntax("\(raw: childName)Builder().map { \(raw: child.type.syntaxBaseName)(\(raw: param.varName): $0) }")
          } else {
            produceExpr = ExprSyntax("\(raw: child.type.syntaxBaseName)(\(raw: param.varName): \(raw: childName)Builder())")
          }
        } else {
          produceExpr = ExprSyntax("\(raw: childName)Builder()")
        }
        builderParameters.append(
          FunctionParameterSyntax(
            "@\(builderInitializableType.resultBuilderType) \(raw: childName)Builder: () throws-> \(raw: builderInitializableType.syntax)"
          )
        )
      } else {
        produceExpr = convertFromSyntaxProtocolToSyntaxType(child: child, useDeprecatedChildName: useDeprecatedChildName)
        normalParameters.append(
          FunctionParameterSyntax(
            firstName: .identifier(childName),
            colon: .colonToken(),
            type: child.parameterType,
            defaultArgument: child.defaultInitialization
          )
        )
      }
      delegatedInitArgs.append(TupleExprElementSyntax(label: child.isUnexpectedNodes ? nil : child.varName, expression: produceExpr))
    }

    guard shouldCreateInitializer else {
      return nil
    }

    let params = ParameterClauseSyntax {
      FunctionParameterSyntax("leadingTrivia: Trivia? = nil")
      for param in normalParameters + builderParameters {
        param
      }
      FunctionParameterSyntax("trailingTrivia: Trivia? = nil")
    }

    return try InitializerDeclSyntax(
      """
      /// A convenience initializer that allows initializing syntax collections using result builders
      public init\(params) rethrows
      """
    ) {
      FunctionCallExprSyntax(callee: ExprSyntax("try self.init")) {
        TupleExprElementSyntax(label: "leadingTrivia", expression: ExprSyntax("leadingTrivia"))
        for arg in delegatedInitArgs {
          arg
        }
        TupleExprElementSyntax(label: "trailingTrivia", expression: ExprSyntax("trailingTrivia"))
      }
    }
  }
}

fileprivate func convertFromSyntaxProtocolToSyntaxType(child: Child, useDeprecatedChildName: Bool = false) -> ExprSyntax {
  let childName: String
  if useDeprecatedChildName, let deprecatedVarName = child.deprecatedVarName {
    childName = deprecatedVarName
  } else {
    childName = child.varName
  }

  if child.type.isBaseType && !child.kind.isNodeChoices {
    return ExprSyntax("\(raw: child.type.syntaxBaseName)(fromProtocol: \(raw: childName))")
  }
  return ExprSyntax("\(raw: childName)")
}
