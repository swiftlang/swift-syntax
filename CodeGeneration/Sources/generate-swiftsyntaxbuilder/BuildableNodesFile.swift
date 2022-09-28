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
            leadingTrivia: .docLineComment("/// The \(side) trivia attached to this syntax node once built.") + .newline,
            .var,
            name: trivia,
            type: "Trivia"
          )
        }

        // Generate members
        for child in node.children {
          VariableDecl(.var, name: child.swiftName, type: child.type.buildable)
        }
      }
      EnumDecl(identifier: "Data") {
        EnumCaseDecl(elements: EnumCaseElement(identifier: "buildable", associatedValue: ParameterClause(parameterList: FunctionParameterList {
          FunctionParameter(type: "BuildableData")
        })))
        EnumCaseDecl(elements: EnumCaseElement(identifier: "constructed", associatedValue: ParameterClause(parameterList: FunctionParameterList {
          FunctionParameter(type: type.syntax)
        })))
      }

      VariableDecl(modifiers: [Token.private], .var, name: "data", type: "Data")
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
  VariableDecl(name: "hasTrailingComma", type: "Bool") {
    SwitchStmt(expression: "data") {
      SwitchCase(
        label: SwitchCaseLabel(
          caseItems: CaseItem(
            pattern: ExpressionPattern(
              expression: FunctionCallExpr(MemberAccessExpr(name: "buildable")) {
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
        ReturnStmt(expression: SequenceExpr {
          MemberAccessExpr(base: "buildableData", name: "trailingComma")
          BinaryOperatorExpr("!=")
          NilLiteralExpr()
        })
      }
      SwitchCase(
        label: SwitchCaseLabel(
          caseItems: CaseItem(
            pattern: ExpressionPattern(
              expression: FunctionCallExpr(MemberAccessExpr(name: "constructed")) {
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
        ReturnStmt(expression: SequenceExpr {
          MemberAccessExpr(base: "node", name: "trailingComma")
          BinaryOperatorExpr("!=")
          NilLiteralExpr()
        })
      }
    }
  }
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
    SequenceExpr {
      MemberAccessExpr(base: "self", name: "data")
      AssignmentExpr()
      FunctionCallExpr(MemberAccessExpr(name: "buildable")) {
        TupleExprElement(expression: FunctionCallExpr("BuildableData") {
          for trivia in trivias {
            TupleExprElement(label: trivia, expression: trivia)
          }
          for child in node.children {
            TupleExprElement(
              label: child.swiftName,
              expression: child.type.generateExprConvertParamTypeToStorageType(varName: child.swiftName)
            )
          }
        })
      }
    }
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
      produceExpr = FunctionCallExpr("\(child.swiftName)Builder")
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
            FunctionCallExpr(builderInitializableType.buildableBaseName) {
              TupleExprElement(expression: ArrayExpr())
            }
          }
        }
      ))
    } else if let token = child.type.token, token.text == nil {
      // Allow initializing identifiers and other tokens without default text with a String
      shouldCreateInitializer = true
      let paramType = child.type.optionalWrapped(type: "String")
      let tokenExpr = MemberAccessExpr(base: "Token", name: token.swiftKind.withFirstCharacterLowercased.backticked)
      if child.type.isOptional {
        produceExpr = FunctionCallExpr(MemberAccessExpr(base: child.swiftName, name: "map"), trailingClosure: ClosureExpr {
          FunctionCallExpr(tokenExpr) {
            TupleExprElement(expression: "$0")
          }
        })
      } else {
        produceExpr = FunctionCallExpr(tokenExpr) {
          TupleExprElement(expression: child.swiftName)
        }
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
    FunctionCallExpr(MemberAccessExpr(base: "self", name: "init")) {
      TupleExprElement(label: "leadingTrivia", expression: "leadingTrivia")
      for arg in delegatedInitArgs {
        arg
      }
    }
  }
}

private func createConstructedInitializer(node: Node) -> InitializerDecl {
  InitializerDecl(
    modifiers: [Token.public],
    signature: FunctionSignature(input: ParameterClause {
    FunctionParameter(
      firstName: .wildcard,
      secondName: .identifier("constructedNode"),
      colon: .colon,
      type: node.type.syntax
    )
  })) {
    SequenceExpr {
      MemberAccessExpr(base: "self", name: "data")
      AssignmentExpr()
      FunctionCallExpr(MemberAccessExpr(name: "constructed")) {
        TupleExprElement(expression: "constructedNode")
      }
    }
  }
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
              expression: FunctionCallExpr(MemberAccessExpr(name: "buildable")) {
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
          initializer: FunctionCallExpr(type.syntaxBaseName) {
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
          createTriviaAttachment(varName: "result", triviaVarName: MemberAccessExpr(base: "buildableData", name: trivia), trivia: trivia)
        }
        ReturnStmt(expression: FunctionCallExpr(MemberAccessExpr(base: "format", name: "format")) {
          TupleExprElement(
            label: "syntax",
            expression: "result"
          )
        })
      }
      SwitchCase(
        label: SwitchCaseLabel(
          caseItems: CaseItem(
            pattern: ExpressionPattern(
              expression: FunctionCallExpr(MemberAccessExpr(name: "constructed")) {
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
        ReturnStmt(expression: "node")
      }
    }
  }
}

/// Generate the function building the base type.
private func createBuildBaseTypeFunction(node: Node) -> FunctionDecl {
  let type = node.type
  let baseType = node.baseType
  return FunctionDecl(
    leadingTrivia: .docLineComment("/// Conformance to `\(baseType.buildableBaseName)`.") + .newline,
    modifiers: [Token.public],
    identifier: .identifier("build\(baseType.baseName)"),
    signature: FunctionSignature(
      input: createFormatParameters(),
      output: baseType.syntax
    )
  ) {
    VariableDecl(
      .let,
      name: "result",
      initializer: FunctionCallExpr("build\(type.baseName)") {
        TupleExprElement(label: "format", expression: "format")
      }
    )
    ReturnStmt(expression: FunctionCallExpr(baseType.syntaxBaseName) {
      TupleExprElement(expression: "result")
    })
  }
}

/// Generate the `withTrailingComma` function.
private func createWithTrailingCommaFunction() -> FunctionDecl {
  FunctionDecl(
    leadingTrivia: .docLineComment("/// Conformance to `HasTrailingComma`.") + .newline,
    modifiers: [Token.public],
    identifier: .identifier("withTrailingComma"),
    signature: FunctionSignature(
      input: ParameterClause {
        FunctionParameter(
          firstName: .wildcard,
          secondName: .identifier("withComma"),
          colon: .colon,
          type: "Bool"
        )
      },
      output: "Self"
    )
  ) {
    SwitchStmt(expression: "data") {
      SwitchCase(
        label: SwitchCaseLabel(
          caseItems: CaseItem(
            pattern: ExpressionPattern(
              expression: FunctionCallExpr(MemberAccessExpr(name: "buildable")) {
                TupleExprElement(
                  expression: UnresolvedPatternExpr(
                    pattern: ValueBindingPattern(
                      letOrVarKeyword: .var,
                      valuePattern: IdentifierPattern("buildableData")
                    )
                  )
                )
              }
            )
          )
        )
      ) {
        SequenceExpr {
          MemberAccessExpr(base: "buildableData", name: "trailingComma")
          AssignmentExpr()
          TernaryExpr(
            if: "withComma",
            then: MemberAccessExpr(name: "comma"),
            else: NilLiteralExpr()
          )
        }
        VariableDecl(.var, name: "result", initializer: "self")
        SequenceExpr {
          MemberAccessExpr(base: "result", name: "data")
          AssignmentExpr()
          FunctionCallExpr(MemberAccessExpr(name: "buildable")) {
            TupleExprElement(expression: "buildableData")
          }
        }
        ReturnStmt(expression: "result")
      }
      SwitchCase(
        label: SwitchCaseLabel(
          caseItems: CaseItem(
            pattern: ExpressionPattern(
              expression: FunctionCallExpr(MemberAccessExpr(name: "constructed")) {
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
        VariableDecl(.let, name: "withComma", initializer: FunctionCallExpr(MemberAccessExpr(base: "node", name: "withTrailingComma")) {
          TupleExprElement(expression: TernaryExpr(
            if: "withComma",
            then: FunctionCallExpr(MemberAccessExpr(name: "commaToken")),
            else: NilLiteralExpr()
          ))
        })
        VariableDecl(.var, name: "result", initializer: "self")
        SequenceExpr {
          MemberAccessExpr(base: "result", name: "data")
          AssignmentExpr()
          FunctionCallExpr(MemberAccessExpr(name: "constructed")) {
            TupleExprElement(expression: "withComma")
          }
        }
        ReturnStmt(expression: "result")
      }
    }
  }
}

/// Generate a `withATrivia` function.
func createWithTriviaFunction2(trivia: String) -> FunctionDecl {
  FunctionDecl(
    modifiers: [Token.public],
    identifier: .identifier("with\(trivia.withFirstCharacterUppercased)"),
    signature: FunctionSignature(
      input: ParameterClause {
        FunctionParameter(
          firstName: .wildcard,
          secondName: .identifier(trivia),
          colon: .colon,
          type: "Trivia"
        )
      },
      output: "Self"
    )
  ) {
    SwitchStmt(expression: "data") {
      SwitchCase(
        label: SwitchCaseLabel(
          caseItems: CaseItem(
            pattern: ExpressionPattern(
              expression: FunctionCallExpr(MemberAccessExpr(name: "buildable")) {
                TupleExprElement(
                  expression: UnresolvedPatternExpr(
                    pattern: ValueBindingPattern(
                      letOrVarKeyword: .var,
                      valuePattern: IdentifierPattern("buildableData")
                    )
                  )
                )
              }
            )
          )
        )
      ) {
        SequenceExpr {
          MemberAccessExpr(base: "buildableData", name: trivia)
          AssignmentExpr()
          trivia
        }
        VariableDecl(.var, name: "result", initializer: "self")
        SequenceExpr {
          MemberAccessExpr(base: "result", name: "data")
          AssignmentExpr()
          FunctionCallExpr(MemberAccessExpr(name: "buildable")) {
            TupleExprElement(expression: "buildableData")
          }
        }
        ReturnStmt(expression: "result")
      }
      SwitchCase(
        label: SwitchCaseLabel(
          caseItems: CaseItem(
            pattern: ExpressionPattern(
              expression: FunctionCallExpr(MemberAccessExpr(name: "constructed")) {
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
        VariableDecl(.let, name: "withNewTrivia", initializer: FunctionCallExpr(MemberAccessExpr(base: "node", name: "withTrailingTrivia")) {
          TupleExprElement(expression: trivia)
        })
        VariableDecl(.var, name: "result", initializer: "self")
        SequenceExpr {
          MemberAccessExpr(base: "result", name: "data")
          AssignmentExpr()
          FunctionCallExpr(MemberAccessExpr(name: "constructed")) {
            TupleExprElement(expression: "withNewTrivia")
          }
        }
        ReturnStmt(expression: "result")
      }
    }
  }
}
