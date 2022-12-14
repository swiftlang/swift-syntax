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
import SyntaxSupport
import Utils

let buildableNodesFile = SourceFile {
  ImportDecl(
    leadingTrivia: .docLineComment(generateCopyrightHeader(for: "generate-swiftsyntaxbuilder")),
    path: [AccessPathComponent(name: "SwiftSyntax")]
  )

  for node in SYNTAX_NODES where node.isBuildable {
    let type = node.type
    let hasTrailingComma = node.traits.contains("WithTrailingComma")

    let convenienceInit = createConvenienceInitializer(node: node)
    if convenienceInit != nil || hasTrailingComma {
      let docComment: SwiftSyntax.Trivia = node.documentation.isEmpty ? [] : .docLineComment("/// \(node.documentation)") + .newline
      ExtensionDecl(
        leadingTrivia: docComment,
        extendedType: SimpleTypeIdentifier(name: .identifier(type.shorthandName)),
        inheritanceClause: hasTrailingComma ? TypeInheritanceClause { InheritedType(typeName: Type("HasTrailingComma")) } : nil
      ) {
        if let convenienceInit = convenienceInit {
          convenienceInit
        }

        if hasTrailingComma {
          VariableDecl(
          """
          var hasTrailingComma: Bool {
            return trailingComma != nil
          }
          """
          )

          FunctionDecl(
          """
          /// Conformance to `HasTrailingComma`.
          public func withTrailingComma(_ withComma: Bool) -> Self {
            return withTrailingComma(withComma ? .commaToken() : nil)
          }
          """
          )
        }
      }
    }
  }
}

private func convertFromSyntaxProtocolToSyntaxType(child: Child) -> Expr {
  if child.type.isBaseType && child.nodeChoices.isEmpty {
    return Expr(FunctionCallExpr("\(raw: child.type.syntaxBaseName)(fromProtocol: \(raw: child.swiftName))"))
  } else {
    return Expr(IdentifierExpr(identifier: .identifier(child.swiftName)))
  }
}

/// Create a builder-based convenience initializer, if needed.
private func createConvenienceInitializer(node: Node) -> InitializerDecl? {
  // Only create the convenience initializer if at least one parameter
  // is different than in the default initializer generated above.
  var shouldCreateInitializer = false

  // Keep track of init parameters and result builder parameters in different
  // lists to make sure result builder params occur at the end, so that
  // they can use trailing closure syntax.
  var normalParameters: [FunctionParameter] = []
  var builderParameters: [FunctionParameter] = []
  var delegatedInitArgs: [TupleExprElement] = []

  for child in node.children {
    /// The expression that is used to call the default initializer defined above.
    let produceExpr: Expr
    if child.type.isBuilderInitializable {
      // Allow initializing certain syntax collections with result builders
      shouldCreateInitializer = true
      let builderInitializableType = child.type.builderInitializableType
      if child.type.builderInitializableType != child.type {
        let param = Node.from(type: child.type).singleNonDefaultedChild
        if child.isOptional {
          produceExpr = Expr(FunctionCallExpr("\(raw: child.swiftName)Builder().map { \(raw: child.type.syntaxBaseName)(\(raw: param.swiftName): $0) }"))
        } else {
          produceExpr = Expr(FunctionCallExpr("\(raw: child.type.syntaxBaseName)(\(raw: param.swiftName): \(raw: child.swiftName)Builder())"))
        }
      } else {
        produceExpr = Expr(FunctionCallExpr("\(raw: child.swiftName)Builder()"))
      }
      let defaultArgument = ClosureExpr {
        if child.type.isOptional {
          NilLiteralExpr()
        } else {
          FunctionCallExpr("\(builderInitializableType.syntax)([])")
        }
      }
      builderParameters.append(FunctionParameter(
        "@\(builderInitializableType.resultBuilderBaseName) \(child.swiftName)Builder: () -> \(builderInitializableType.syntax) = \(defaultArgument)",
        for: .functionParameters
      ))
    } else if let token = child.type.token, token.text == nil {
      // Allow initializing identifiers and other tokens without default text with a String
      shouldCreateInitializer = true
      let paramType = child.type.optionalWrapped(type: Type("String"))
      let tokenExpr = MemberAccessExpr("Token.\(raw: token.swiftKind.withFirstCharacterLowercased.backticked)")
      if child.type.isOptional {
        produceExpr = Expr(FunctionCallExpr("\(raw: child.swiftName).map { \(tokenExpr)($0) }"))
      } else {
        produceExpr = Expr(FunctionCallExpr("\(tokenExpr)(\(raw: child.swiftName))"))
      }
      normalParameters.append(FunctionParameter("\(child.swiftName): \(paramType)", for: .functionParameters))
    } else {
      produceExpr = convertFromSyntaxProtocolToSyntaxType(child: child)
      normalParameters.append(FunctionParameter(
        firstName: .identifier(child.swiftName),
        colon: .colon,
        type: child.parameterType,
        defaultArgument: child.type.defaultInitialization.map { InitializerClause(value: $0) }
      ))
    }
    delegatedInitArgs.append(TupleExprElement(label: child.isUnexpectedNodes ? nil : child.swiftName, expression: produceExpr))
  }

  guard shouldCreateInitializer else {
    return nil
  }

  return InitializerDecl(
    leadingTrivia: [
      "/// A convenience initializer that allows:",
      "///  - Initializing syntax collections using result builders",
      "///  - Initializing tokens without default text using strings",
    ].map { .docLineComment($0) + .newline }.reduce([], +),
    modifiers: [DeclModifier(name: .public)],
    signature: FunctionSignature(
      input: ParameterClause {
        FunctionParameter("leadingTrivia: Trivia? = nil", for: .functionParameters)
        for param in normalParameters + builderParameters {
          param
        }
        FunctionParameter("trailingTrivia: Trivia? = nil", for: .functionParameters)
      }
    )
  ) {
    FunctionCallExpr(callee: Expr("self.init")) {
      TupleExprElement(label: "leadingTrivia", expression: "leadingTrivia")
      for arg in delegatedInitArgs {
        arg
      }
      TupleExprElement(label: "trailingTrivia", expression: "trailingTrivia")
    }
  }
}

