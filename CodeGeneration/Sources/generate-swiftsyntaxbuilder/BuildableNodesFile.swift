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

import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder
import SyntaxSupport
import Utils

let buildableNodesFile = SourceFile {
  ImportDecl(
    leadingTrivia: .docLineComment(copyrightHeader),
    path: "SwiftSyntax"
  )
  ImportDecl(
    trailingTrivia: .newline,
    path: "SwiftBasicFormat"
  )

  let triviaSides = ["leading", "trailing"]
  let trivias = triviaSides.map { "\($0)Trivia" }

  for node in SYNTAX_NODES where node.isBuildable {
    let type = node.type
    let baseType = node.baseType
    let hasTrailingComma = node.traits.contains("WithTrailingComma")
    let conformances = [baseType.buildableBaseName, type.expressibleAsBaseName] + (hasTrailingComma ? ["HasTrailingComma"] : [])

    // Generate node struct
    StructDecl(
      leadingTrivia: node.documentation.isEmpty
        ? []
        : .docLineComment("/// \(node.documentation)") + .newline,
      modifiers: [Token.public],
      identifier: type.buildableBaseName,
      inheritanceClause: createTypeInheritanceClause(conformances: conformances)
    ) {
      StructDecl(identifier: "BuildableData") {
        for (side, trivia) in zip(triviaSides, trivias) {
          VariableDecl(
            """
            /// The \(side) trivia attached to this syntax node once built.
            var \(trivia): Trivia
            """
          )
        }

        // Generate members
        for child in node.children {
          VariableDecl("var \(child.swiftName): \(child.type.buildable)")
        }
      }
      EnumDecl(
        """
        enum Data {
          case buildable(BuildableData)
          case constructed(\(type.syntax))
        }
        """
      )

      VariableDecl("private var data: Data")
      if hasTrailingComma {
        createHasTrailingCommaVariable()
      }

      // Generate initializers
      createDefaultInitializer(node: node, trivias: trivias)
      if let convenienceInit = createConvenienceInitializer(node: node) {
        convenienceInit
      }
      createConstructedInitializer(node: node)

      // Generate function declarations
      createBuildFunction(node: node, trivias: trivias)
      createBuildBaseTypeFunction(node: node)
      createExpressibleAsCreateFunction(type: node.type)
      createDisambiguatingExpressibleAsCreateFunction(type: node.type, baseType: node.baseType)
      if baseType.baseName != "Syntax" {
        createDisambiguatingExpressibleAsCreateFunction(type: node.baseType, baseType: .init(syntaxKind: "Syntax"))
      }
      if hasTrailingComma {
        createWithTrailingCommaFunction()
      }
      for trivia in trivias {
        createWithTriviaFunction2(trivia: trivia)
      }
    }
  }
}

private func createHasTrailingCommaVariable() -> VariableDecl {
  return VariableDecl(
    """
    var hasTrailingComma: Bool {
      switch data {
      case .buildable(let buildableData):
        return buildableData.trailingComma != nil
      case .constructed(let node):
        return node.trailingComma != nil
      }
    }
    """
  )
}

/// Create the default initializer for the given node.
private func createDefaultInitializer(node: Node, trivias: [String]) -> InitializerDecl {
  let type = node.type
  return InitializerDecl(
    leadingTrivia: ([
      "/// Creates a `\(type.buildableBaseName)` using the provided parameters.",
      "/// - Parameters:",
    ] + node.children.map { child in
      "///   - \(child.swiftName): \(child.documentation)"
    }).map { .docLineComment($0) + .newline }.reduce([], +),
    modifiers: [Token.public],
    signature: FunctionSignature(
      input: ParameterClause {
        for trivia in trivias {
          FunctionParameter(
            firstName: .identifier(trivia),
            colon: .colon,
            type: "Trivia",
            defaultArgument: ArrayExpr()
          )
        }
        for child in node.children {
          FunctionParameter(
            firstName: .identifier(child.swiftName),
            colon: .colon,
            type: child.type.expressibleAs,
            defaultArgument: child.type.defaultInitialization
          )
        }
      }
    )
  ) {
    for child in node.children {
      if let assertStmt = child.generateAssertStmtTextChoices(varName: child.swiftName) {
        assertStmt
      }
    }
    let buildableData = FunctionCallExpr(calledExpression: "BuildableData") {
      for trivia in trivias {
        TupleExprElement(label: trivia, expression: trivia)
      }
      for child in node.children {
        TupleExprElement(
          label: child.swiftName,
          expression: child.type.generateExprConvertParamTypeToStorageType(varName: child.swiftName)
        )
      }
    }
    SequenceExpr("self.data = .buildable(\(buildableData))")
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
    let produceExpr: ExpressibleAsExprBuildable
    if child.type.isBuilderInitializable {
      // Allow initializing certain syntax collections with result builders
      shouldCreateInitializer = true
      let builderInitializableType = child.type.builderInitializableType
      produceExpr = FunctionCallExpr(calledExpression: "\(child.swiftName)Builder")
      builderParameters.append(FunctionParameter(
        attributes: [CustomAttribute(attributeName: builderInitializableType.resultBuilderBaseName, argumentList: nil)],
        firstName: .identifier("\(child.swiftName)Builder").withLeadingTrivia(.space),
        colon: .colon,
        type: FunctionType(
          arguments: [],
          returnType: builderInitializableType.expressibleAs
        ),
        defaultArgument: ClosureExpr {
          if child.type.isOptional {
            NilLiteralExpr()
          } else {
            FunctionCallExpr("\(builderInitializableType.buildableBaseName)([])")
          }
        }
      ))
    } else if let token = child.type.token, token.text == nil {
      // Allow initializing identifiers and other tokens without default text with a String
      shouldCreateInitializer = true
      let paramType = child.type.optionalWrapped(type: "String")
      let tokenExpr = MemberAccessExpr("Token.\(token.swiftKind.withFirstCharacterLowercased.backticked)")
      if child.type.isOptional {
        produceExpr = FunctionCallExpr("\(child.swiftName).map { \(tokenExpr)($0) }")
      } else {
        produceExpr = FunctionCallExpr("\(tokenExpr)(\(child.swiftName))")
      }
      normalParameters.append(FunctionParameter(
        firstName: .identifier(child.swiftName),
        colon: .colon,
        type: paramType
      ))
    } else {
      produceExpr = child.swiftName
      normalParameters.append(FunctionParameter(
        firstName: .identifier(child.swiftName),
        colon: .colon,
        type: child.type.expressibleAs,
        defaultArgument: child.type.defaultInitialization
      ))
    }
    delegatedInitArgs.append(TupleExprElement(label: child.swiftName, expression: produceExpr))
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
    modifiers: [Token.public],
    signature: FunctionSignature(
      input: ParameterClause {
        FunctionParameter(
          firstName: .identifier("leadingTrivia"),
          colon: .colon,
          type: "Trivia",
          defaultArgument: ArrayExpr()
        )
        for param in normalParameters + builderParameters {
          param
        }
      }
    )
  ) {
    FunctionCallExpr(calledExpression: MemberAccessExpr("self.init")) {
      TupleExprElement(label: "leadingTrivia", expression: "leadingTrivia")
      for arg in delegatedInitArgs {
        arg
      }
    }
  }
}

private func createConstructedInitializer(node: Node) -> InitializerDecl {
  return InitializerDecl(
    """
    public init(_ constructedNode: \(node.type.syntax)) {
      self.data = .constructed(constructedNode)
    }
    """
  )
}

/// Generate the function building the node syntax.
private func createBuildFunction(node: Node, trivias: [String]) -> FunctionDecl {
  let type = node.type
  let children = node.children
  return FunctionDecl(
    leadingTrivia: [
      "/// Builds a `\(type.syntaxBaseName)`.",
      "/// - Parameter format: The `Format` to use.",
      "/// - Parameter leadingTrivia: Additional leading trivia to attach, typically used for indentation.",
      "/// - Returns: The built `\(type.syntaxBaseName)`.",
    ].map { .docLineComment($0) + .newline }.reduce([], +),
    identifier: .identifier("build\(type.baseName)"),
    signature: FunctionSignature(
      input: createFormatParameters(),
      output: type.syntax
    )
  ) {
    SwitchStmt(expression: "data") {
      SwitchCase(
        label: SwitchCaseLabel(
          caseItems: CaseItem(
            pattern: ExpressionPattern(
              expression: FunctionCallExpr(calledExpression: MemberAccessExpr(name: "buildable")) {
                TupleExprElement(
                  expression: UnresolvedPatternExpr(
                    pattern: ValueBindingPattern(
                      letOrVarKeyword: .let,
                      valuePattern: IdentifierPattern("buildableData")
                    )
                  )
                )
              }
            )
          )
        )
      ) {
        VariableDecl(
          .var,
          name: "result",
          initializer: FunctionCallExpr(calledExpression: type.syntaxBaseName) {
            for child in children {
              TupleExprElement(
                label: child.isUnexpectedNodes ? nil : child.swiftName,
                expression: child.generateExprBuildSyntaxNode(
                  varName: MemberAccessExpr(base: "buildableData", name: child.swiftName),
                  formatName: "format"
                )
              )
            }
          }
        )
        for trivia in trivias {
          createTriviaAttachment(varName: IdentifierExpr("result"), triviaVarName: MemberAccessExpr(base: "buildableData", name: trivia), trivia: trivia)
        }
        ReturnStmt("return format.format(syntax: result)")
      }
      SwitchCase(
        label: SwitchCaseLabel(
          caseItems: CaseItem(
            pattern: ExpressionPattern(
              expression: FunctionCallExpr(calledExpression: MemberAccessExpr(name: "constructed")) {
                TupleExprElement(
                  expression: UnresolvedPatternExpr(
                    pattern: ValueBindingPattern(
                      letOrVarKeyword: .let,
                      valuePattern: IdentifierPattern("node")
                    )
                  )
                )
              }
            )
          )
        )
      ) {
        ReturnStmt("return Indenter.indent(node, indentation: format.indentTrivia)")
      }
    }
  }
}

/// Generate the function building the base type.
private func createBuildBaseTypeFunction(node: Node) -> FunctionDecl {
  let type = node.type
  let baseType = node.baseType
  return FunctionDecl(
    """
    /// Conformance to `\(baseType.buildableBaseName)`.
    public func build\(baseType.baseName)(format: Format) -> \(baseType.syntax) {
      let result = build\(type.baseName)(format: format)
      return \(baseType.syntaxBaseName)(result)
    }
    """
  )
}

/// Generate the `withTrailingComma` function.
private func createWithTrailingCommaFunction() -> FunctionDecl {
  return FunctionDecl(
    """
    /// Conformance to `HasTrailingComma`.
    public func withTrailingComma(_ withComma: Bool) -> Self {
      switch data {
      case .buildable(var buildableData):
        buildableData.trailingComma = withComma ? .comma : nil
        var result = self
        result.data = .buildable(buildableData)
        return result
      case .constructed(let node):
        let withComma = node.withTrailingComma(withComma ? .commaToken() : nil)
        var result = self
        result.data = .constructed(withComma)
        return result
      }
    }
    """
  )
}

/// Generate a `withATrivia` function.
func createWithTriviaFunction2(trivia: String) -> FunctionDecl {
  return FunctionDecl(
    """
    public func with\(trivia.withFirstCharacterUppercased)(_ \(trivia): Trivia) -> Self {
      switch data {
      case .buildable(var buildableData):
        buildableData.\(trivia) = \(trivia)
        var result = self
        result.data = .buildable(buildableData)
        return result
      case .constructed(let node):
        let withNewTrivia = node.with\(trivia.withFirstCharacterUppercased)(\(trivia))
        var result = self
        result.data = .constructed(withNewTrivia)
        return result
      }
    }
    """
  )
}
