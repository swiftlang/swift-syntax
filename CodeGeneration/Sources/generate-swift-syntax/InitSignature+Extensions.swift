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

extension InitSignature {
  var compoundName: String {
    let renamedArguments = children.map { child in
      if child.isUnexpectedNodes {
        return "_:"
      } else {
        return "\(child.labelDeclName):"
      }
    }.joined(separator: "")

    return "init(leadingTrivia:\(renamedArguments)trailingTrivia:)"
  }

  func generateInitializerDeclHeader() -> SyntaxNodeString {
    if children.isEmpty {
      return "public init()"
    }

    func createFunctionParameterSyntax(for child: Child) -> FunctionParameterSyntax {
      var paramType: TypeSyntax
      if !child.kind.isNodeChoicesEmpty {
        paramType = "\(child.syntaxChoicesType)"
      } else if child.hasBaseType {
        paramType = "some \(child.syntaxNodeKind.protocolType)"
      } else {
        paramType = child.syntaxNodeKind.syntaxType
      }

      if child.isOptional {
        if paramType.is(SomeOrAnyTypeSyntax.self) {
          paramType = "(\(paramType))?"
        } else {
          paramType = "\(paramType)?"
        }
      }

      let parameterName = child.labelDeclName

      return FunctionParameterSyntax(
        leadingTrivia: .newline,
        firstName: child.isUnexpectedNodes ? .wildcardToken(trailingTrivia: .space) : parameterName,
        secondName: child.isUnexpectedNodes ? parameterName : nil,
        colon: .colonToken(),
        type: paramType,
        defaultValue: child.defaultInitialization
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
      if child.documentationAbstract.isEmpty {
        return nil
      }
      return "  - \(child.identifier): \(child.documentationAbstract)"
    }

    let formattedParams = """
      - Parameters:
        - leadingTrivia: Trivia to be prepended to the leading trivia of the node’s first token. \
      If the node is empty, there is no token to attach the trivia to and the parameter is ignored.
      \(children.compactMap(generateParamDocComment).joined(separator: "\n"))
        - trailingTrivia: Trivia to be appended to the trailing trivia of the node’s last token. \
      If the node is empty, there is no token to attach the trivia to and the parameter is ignored.
      """.removingEmptyLines

    return SwiftSyntax.Trivia.docCommentTrivia(from: formattedParams)
  }

  /// Create a builder-based convenience initializer, if needed.
  func createConvenienceBuilderInitializer() throws -> InitializerDeclSyntax? {
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
      let childName = child.identifier

      if child.buildableType.isBuilderInitializable {
        // Allow initializing certain syntax collections with result builders
        shouldCreateInitializer = true
        let builderInitializableType = child.buildableType.builderInitializableType
        if child.buildableType.builderInitializableType != child.buildableType {
          let param = Node.from(type: child.buildableType).layoutNode!.singleNonDefaultedChild
          if child.isOptional {
            produceExpr = ExprSyntax(
              "\(childName)Builder().map { \(child.buildableType.syntaxBaseName)(\(param.labelDeclName): $0) }"
            )
          } else {
            produceExpr = ExprSyntax(
              "\(child.buildableType.syntaxBaseName)(\(param.labelDeclName): \(childName)Builder())"
            )
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
        produceExpr = convertFromSyntaxProtocolToSyntaxType(child: child)
        normalParameters.append(
          FunctionParameterSyntax(
            firstName: childName.nonVarCallNameOrLabelDeclName,
            colon: .colonToken(),
            type: child.parameterType,
            defaultValue: child.defaultInitialization
          )
        )
      }
      delegatedInitArgs.append(
        LabeledExprSyntax(
          label: child.isUnexpectedNodes ? nil : child.labelDeclName,
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

fileprivate func convertFromSyntaxProtocolToSyntaxType(
  child: Child
) -> ExprSyntax {
  let childName = child.identifier

  if child.buildableType.isBaseType && !child.kind.isNodeChoices {
    return ExprSyntax("\(child.buildableType.syntaxBaseName)(fromProtocol: \(childName.declNameOrVarCallName))")
  }
  return ExprSyntax("\(childName.declNameOrVarCallName)")
}

extension InitSignature {
  /// Interprets `self` as an initializer parameter list and generates arguments to
  /// call the non-deprecated initializer. This will generate nested initializer calls for
  /// any children with a compound `newestChildPath`.
  func makeArgumentsToInitializeNewestChildren() -> [LabeledExprSyntax] {
    var root: [InitParameterMapping] = []

    for child in children {
      InitParameterMapping.addChild(child, to: &root)
    }

    return root.map { $0.makeArgumentExpr() }
  }
}

/// Represents the means by which a newest child, possibly at a nested position, is created from
/// one or more historical children.
///
/// For example, consider a couple of nodes with some child history:
/// ```
/// Node(
///   kind: .nestedNodeExtractedLater,
///   children: [
///     Child(name: "x", ...),
///     Child(name: "y", ...),
///   ]
/// ),
/// Node(
///   kind: .longstandingNode,
///   children: [
///     Child(name: "a", ...),
///     Child(name: "nested", kind: .node(.nestedNodeExtractedLater), ...),
///   ],
///   childHistory: [
///     [
///       "a": .renamed(from: "b"),
///       "nested": .extracted
///     ]
///   ]
/// )
/// ```
///
/// These will end up being represented by `InitParameterMapping`s that look something like
/// this (with string literals standing in for the object references):
///
/// ```swift
/// [
///   InitParameterMapping(
///     newestChild: "child for current LongstandingNode.a",
///     argument: .decl("child for historical LongstandingNode.b")
///   ),
///   InitParameterMapping(
///     newestChild: "child for current LongstandingNode.nested",
///     argument: .nestedInit(
///       [
///         InitParameterMapping(
///           newestChild: "child for current NestedNodeExtractedLater.x",
///           argument: .decl("child for historical LongstandingNode.x")
///         ),
///         InitParameterMapping(
///           newestChild: "child for current NestedNodeExtractedLater.y",
///           argument: .decl("child for historical LongstandingNode.y")
///         )
///       ]
///     )
///   )
/// ]
/// ```
///
/// Which matches the structure of the `self.init` arguments we must generate to call from the
/// compatibility `LongstandingNodeSyntax.init(b:x:y:)` to the current
/// `LongstandingNodeSyntax.init(a:nested:)`:
///
/// ```swift
/// self.init(
///   a: b,
///   nested: NestedNodeExtractedLaterSyntax(
///     x: x,
///     y: y
///   )
/// )
/// ```
private struct InitParameterMapping {
  var newestChild: Child
  var argument: Argument

  enum Argument {
    case decl(olderChild: Child)
    case nestedInit([InitParameterMapping])
  }

  static func addChild(_ olderChild: Child, to mappings: inout [InitParameterMapping]) {
    guard !olderChild.newestChildPath.isEmpty else {
      // This child is not historical, so we can just pass it right through.
      mappings.append(
        InitParameterMapping(
          newestChild: olderChild,
          argument: .decl(olderChild: olderChild)
        )
      )
      return
    }

    addChild(olderChild, to: &mappings, at: olderChild.newestChildPath[...])
  }

  private static func addChild(
    _ olderChild: Child,
    to mappings: inout [InitParameterMapping],
    at newestChildPath: ArraySlice<Child>
  ) {
    let targetNewestChild = newestChildPath.first!

    if newestChildPath.count == 1 {
      // We've found the argument list this ought to be added to.
      let newMapping = InitParameterMapping(newestChild: targetNewestChild, argument: .decl(olderChild: olderChild))
      mappings.append(newMapping)
      return
    }

    // We've found a parent of the argument list this ought to be added to.
    var (i, nestedArgMappings) = findOrCreateNestedInit(for: targetNewestChild, in: &mappings)
    addChild(olderChild, to: &nestedArgMappings, at: newestChildPath.dropFirst())
    mappings[i].argument = .nestedInit(nestedArgMappings)
  }

  private static func findOrCreateNestedInit(
    for newestChild: Child,
    in mappings: inout [InitParameterMapping]
  ) -> (index: Int, nestedArgMapping: [InitParameterMapping]) {
    // If there isn't an existing mapping, we'll append a new one.
    guard let i = mappings.firstIndex(where: { $0.newestChild == newestChild }) else {
      mappings.append(InitParameterMapping(newestChild: newestChild, argument: .nestedInit([])))
      return (mappings.endIndex - 1, [])
    }

    // We found an existing mapping for this child and its nested children.
    guard case .nestedInit(let nestedArgs) = mappings[i].argument else {
      fatalError("Can't nest parameter inside parameter!")
    }
    return (i, nestedArgs)
  }
}

extension InitParameterMapping {
  func makeArgumentExpr() -> LabeledExprSyntax {
    let argValue =
      switch argument {
      case .decl(olderChild: let olderChild):
        ExprSyntax(DeclReferenceExprSyntax(baseName: olderChild.baseCallName))

      case .nestedInit(let initArgs):
        ExprSyntax(
          FunctionCallExprSyntax(callee: TypeExprSyntax(type: newestChild.syntaxNodeKind.syntaxType)) {
            for initArg in initArgs {
              initArg.makeArgumentExpr()
            }
          }
        )
      }

    return LabeledExprSyntax(
      label: newestChild.isUnexpectedNodes ? nil : newestChild.name,
      expression: argValue
    )
  }
}
