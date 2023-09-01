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

  func makeChildParamType(for child: Child, isOptional: Bool = false) -> TypeSyntax {
    var paramType: TypeSyntax

    if !child.kind.isNodeChoicesEmpty {
      paramType = "\(child.syntaxChoicesType)"
    } else if child.hasBaseType {
      paramType = "some \(child.syntaxNodeKind.protocolType)"
    } else {
      paramType = child.syntaxNodeKind.syntaxType
    }

    if isOptional {
      if paramType.is(SomeOrAnyTypeSyntax.self) {
        paramType = "(\(paramType))?"
      } else {
        paramType = "\(paramType)?"
      }
    }

    return paramType
  }

  /// Generates a memberwise SyntaxNode initializer `SyntaxNodeString`.
  ///
  /// - parameters:
  ///  - rule: The ``NodeInitRule`` to use for generating the initializer. Applying a rule will make some children non-optional, and set default values for other children.
  ///  - useDeprecatedChildName: Whether to use the deprecated child name for the initializer parameter.
  func generateInitializerDeclHeader(for rule: NodeInitRule? = nil, useDeprecatedChildName: Bool = false) -> SyntaxNodeString {
    if children.isEmpty {
      return "public init()"
    }

    func childParameterName(for child: Child) -> TokenSyntax {
      let parameterName: TokenSyntax

      if useDeprecatedChildName, let deprecatedVarName = child.deprecatedVarName {
        parameterName = deprecatedVarName
      } else {
        parameterName = child.varOrCaseName
      }
      return parameterName
    }

    func ruleBasedChildIsOptional(for child: Child, with rule: NodeInitRule?) -> Bool? {
      if let rule = rule {
        if rule.nonOptionalChildName == child.name {
          return false
        } else {
          return child.isOptional
        }
      } else {
        return nil
      }
    }

    func ruleBasedChildDefaultValue(for child: Child, with rule: NodeInitRule?) -> InitializerClauseSyntax? {
      if let rule, let defaultValue = rule.childDefaultValues[child.name] {
        return InitializerClauseSyntax(
          equal: .equalToken(leadingTrivia: .space, trailingTrivia: .space),
          value: ExprSyntax(".\(defaultValue.spec.varOrCaseName)Token()")
        )
      } else {
        return nil
      }
    }

    func ruleBasedShouldOverrideDefault(for child: Child, with rule: NodeInitRule?) -> Bool {
      if let rule {
        // If the rule provides a default for this child, override it and set the rule-based default.
        if rule.childDefaultValues[child.name] != nil {
          return true
        }

        // For the non-optional rule-based parameter, strip the default value (override, but there will be no default)
        return rule.nonOptionalChildName == child.name
      } else {
        return false
      }
    }

    func createFunctionParameterSyntax(for child: Child, overrideOptional: Bool? = nil, shouldOverrideDefault: Bool = false, overrideDefaultValue: InitializerClauseSyntax? = nil) -> FunctionParameterSyntax {

      let parameterName = childParameterName(for: child)

      return FunctionParameterSyntax(
        leadingTrivia: .newline,
        firstName: child.isUnexpectedNodes ? .wildcardToken(trailingTrivia: .space) : parameterName,
        secondName: child.isUnexpectedNodes ? parameterName : nil,
        colon: .colonToken(),
        type: makeChildParamType(for: child, isOptional: overrideOptional ?? child.isOptional),
        defaultValue: shouldOverrideDefault ? overrideDefaultValue : child.defaultInitialization
      )
    }

    // For convenience initializers, we don't need unexpected tokens in the arguments list
    // because convenience initializers are meant to be used bo developers manually
    // hence there should be no unexpected tokens
    let childrenToIterate = rule != nil ? nonUnexpectedChildren : children

    let params = FunctionParameterListSyntax {
      FunctionParameterSyntax("leadingTrivia: Trivia? = nil")

      for child in childrenToIterate {
        createFunctionParameterSyntax(for: child,
                                      overrideOptional: ruleBasedChildIsOptional(for: child, with: rule),
                                      shouldOverrideDefault: ruleBasedShouldOverrideDefault(for: child, with: rule),
                                      overrideDefaultValue: ruleBasedChildDefaultValue(for: child, with: rule))
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

  func generateRuleBasedDefaultValuesDocComment(for rule: NodeInitRule) -> SwiftSyntax.Trivia {
    var params = ""
    for (childName, defaultValue) in rule.childDefaultValues {
      params += " - `\(childName)`: `TokenSyntax.\(defaultValue.spec.varOrCaseName)Token()`\n"
    }
    return docCommentTrivia(from: params)
  }

  func generateInitializerDocComment() -> SwiftSyntax.Trivia {
    func generateParamDocComment(for child: Child) -> String? {
      if child.documentationAbstract.isEmpty {
        return nil
      }
      return "  - \(child.varOrCaseName): \(child.documentationAbstract)"
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
    var delegatedInitArgs: [LabeledExprSyntax] = []

    for child in children {
      /// The expression that is used to call the default initializer defined above.
      let produceExpr: ExprSyntax
      let childName: TokenSyntax

      if useDeprecatedChildName, let deprecatedVarName = child.deprecatedVarName {
        childName = deprecatedVarName
      } else {
        childName = child.varOrCaseName
      }

      if child.buildableType.isBuilderInitializable {
        // Allow initializing certain syntax collections with result builders
        shouldCreateInitializer = true
        let builderInitializableType = child.buildableType.builderInitializableType
        if child.buildableType.builderInitializableType != child.buildableType {
          let param = Node.from(type: child.buildableType).layoutNode!.singleNonDefaultedChild
          if child.isOptional {
            produceExpr = ExprSyntax("\(childName)Builder().map { \(child.buildableType.syntaxBaseName)(\(param.varOrCaseName): $0) }")
          } else {
            produceExpr = ExprSyntax("\(child.buildableType.syntaxBaseName)(\(param.varOrCaseName): \(childName)Builder())")
          }
        } else {
          produceExpr = ExprSyntax("\(childName)Builder()")
        }
        builderParameters.append(
          FunctionParameterSyntax(
            "@\(builderInitializableType.resultBuilderType) \(childName)Builder: () throws-> \(builderInitializableType.syntax)"
          )
        )
      } else {
        produceExpr = convertFromSyntaxProtocolToSyntaxType(child: child, useDeprecatedChildName: useDeprecatedChildName)
        normalParameters.append(
          FunctionParameterSyntax(
            firstName: childName,
            colon: .colonToken(),
            type: child.parameterType,
            defaultValue: child.defaultInitialization
          )
        )
      }
      delegatedInitArgs.append(
        LabeledExprSyntax(
          label: child.isUnexpectedNodes ? nil : child.varOrCaseName,
          colon: child.isUnexpectedNodes ? nil : .colonToken(),
          expression: produceExpr
        )
      )
    }

    guard shouldCreateInitializer else {
      return nil
    }

    let params = FunctionParameterClauseSyntax {
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
        LabeledExprSyntax(label: "leadingTrivia", expression: ExprSyntax("leadingTrivia"))
        for arg in delegatedInitArgs {
          arg
        }
        LabeledExprSyntax(label: "trailingTrivia", expression: ExprSyntax("trailingTrivia"))
      }
    }
  }
}

fileprivate func convertFromSyntaxProtocolToSyntaxType(child: Child, useDeprecatedChildName: Bool = false) -> ExprSyntax {
  let childName: TokenSyntax
  if useDeprecatedChildName, let deprecatedVarName = child.deprecatedVarName {
    childName = deprecatedVarName
  } else {
    childName = child.varOrCaseName
  }

  if child.buildableType.isBaseType && !child.kind.isNodeChoices {
    return ExprSyntax("\(child.buildableType.syntaxBaseName)(fromProtocol: \(childName.backtickedIfNeeded))")
  }
  return ExprSyntax("\(childName.backtickedIfNeeded)")
}
