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

extension PatternBindingSyntax {
  /// When the variable is declaring a single binding, produce the name of
  /// that binding.
  fileprivate var singleBindingName: String? {
    if let identifierPattern = pattern.as(IdentifierPatternSyntax.self) {
      return identifierPattern.identifier.text
    }

    return nil
  }
}

public struct FunctionMacro: ExpressionMacro {
  /// Form a function name.
  private static func formFunctionName(
    _ baseName: String, _ parameters: ParameterClauseSyntax?,
    isSubscript: Bool = false
  ) -> String {
    let argumentNames: [String] = parameters?.parameterList.map { param in
      if let argumentName = param.firstName?.text,
         !isSubscript || param.secondName != nil {
        return "\(argumentName):"
      }

      return "_:"
    } ?? []

    return "\(baseName)(\(argumentNames.joined(separator: "")))"
  }

  private static func findEnclosingName(
    _ macro: MacroExpansionExprSyntax
  ) -> String? {
    var currentNode = Syntax(macro)
    while let parent = currentNode.parent {
      switch parent.as(SyntaxEnum.self) {
      case .accessorDecl(let accessor):
        if let accessorList = accessor.parent?.as(AccessorListSyntax.self),
           let accessorBlock = accessorList.parent?.as(AccessorBlockSyntax.self),
           let binding = accessorBlock.parent?.as(PatternBindingSyntax.self),
           let varName = binding.singleBindingName {
          return varName
        }

        break

      case .functionDecl(let function):
        return formFunctionName(
          function.identifier.text, function.signature.input
        )

      case .initializerDecl(let initializer):
        return formFunctionName("init", initializer.signature.input)

      case .subscriptDecl(let subscriptDecl):
        return formFunctionName(
          "subscript", subscriptDecl.indices, isSubscript: true
        )

      case .enumCaseElement(let enumCase):
        return formFunctionName(
          enumCase.identifier.text, enumCase.associatedValue
        )

      case .structDecl(let structDecl):
        return structDecl.identifier.text

      case .enumDecl(let enumDecl):
        return enumDecl.identifier.text

      case .classDecl(let classDecl):
        return classDecl.identifier.text

      case .actorDecl(let actorDecl):
        return actorDecl.identifier.text

      case .protocolDecl(let protocolDecl):
        return protocolDecl.identifier.text

      case .extensionDecl(let extensionDecl):
        // FIXME: It would be nice to be able to switch on type syntax...
        let extendedType = extensionDecl.extendedType
        if let simple = extendedType.as(SimpleTypeIdentifierSyntax.self) {
          return simple.name.text
        }

        if let member = extendedType.as(MemberTypeIdentifierSyntax.self) {
          return member.name.text
        }

        return nil

      default:
        break
      }

      currentNode = parent
    }

    return nil
  }

  public static func apply(
    _ macro: MacroExpansionExprSyntax, in context: MacroEvaluationContext
  ) -> MacroResult<ExprSyntax> {
    let name = findEnclosingName(macro) ?? context.moduleName
    let literal: ExprSyntax = "\(literal: name)"
    if let leadingTrivia = macro.leadingTrivia {
      return .init(literal.withLeadingTrivia(leadingTrivia))
    }

    return .init(literal)
  }
}

/// Replace the label of the first element in the tuple with the given
/// new label.
private func replaceFirstLabel(
  of tuple: TupleExprElementListSyntax, with newLabel: String
) -> TupleExprElementListSyntax{
  guard let firstElement = tuple.first else {
    return tuple
  }

  return tuple.replacing(
    childAt: 0, with: firstElement.withLabel(.identifier(newLabel)))
}

public struct ColorLiteralMacro: ExpressionMacro {
  public static func apply(
    _ macro: MacroExpansionExprSyntax, in context: MacroEvaluationContext
  ) -> MacroResult<ExprSyntax> {
    let argList = replaceFirstLabel(
      of: macro.argumentList, with: "_colorLiteralRed"
    )
    let initSyntax: ExprSyntax = ".init(\(argList))"
    if let leadingTrivia = macro.leadingTrivia {
      return MacroResult(initSyntax.withLeadingTrivia(leadingTrivia))
    }
    return MacroResult(initSyntax)
  }
}

public struct FileLiteralMacro: ExpressionMacro {
  public static func apply(
    _ macro: MacroExpansionExprSyntax, in context: MacroEvaluationContext
  ) -> MacroResult<ExprSyntax> {
    let argList = replaceFirstLabel(
      of: macro.argumentList, with: "fileReferenceLiteralResourceName"
    )
    let initSyntax: ExprSyntax = ".init(\(argList))"
    if let leadingTrivia = macro.leadingTrivia {
      return MacroResult(initSyntax.withLeadingTrivia(leadingTrivia))
    }
    return MacroResult(initSyntax)
  }
}

public struct ImageLiteralMacro: ExpressionMacro {
  public static func apply(
    _ macro: MacroExpansionExprSyntax, in context: MacroEvaluationContext
  ) -> MacroResult<ExprSyntax> {
    let argList = replaceFirstLabel(
      of: macro.argumentList, with: "imageLiteralResourceName"
    )
    let initSyntax: ExprSyntax = ".init(\(argList))"
    if let leadingTrivia = macro.leadingTrivia {
      return MacroResult(initSyntax.withLeadingTrivia(leadingTrivia))
    }
    return MacroResult(initSyntax)
  }
}

public struct FileIDMacro: ExpressionMacro {
  public static func apply(
    _ macro: MacroExpansionExprSyntax, in context: MacroEvaluationContext
  ) -> MacroResult<ExprSyntax> {
    // FIXME: Compiler has more sophisticated file ID computation
    let fileID = "\(context.moduleName)/\(context.fileName)"
    let fileLiteral: ExprSyntax = "\(literal: fileID)"
    if let leadingTrivia = macro.leadingTrivia {
      return MacroResult(fileLiteral.withLeadingTrivia(leadingTrivia))
    }
    return MacroResult(fileLiteral)
  }
}

extension MacroSystem {
  public static var builtinMacroSystem: MacroSystem = {
    var macroSystem = MacroSystem()
    try! macroSystem.add(ColorLiteralMacro.self, name: "colorLiteral")
    try! macroSystem.add(FileIDMacro.self, name: "fileID")
    try! macroSystem.add(FunctionMacro.self, name: "function")
    try! macroSystem.add(ImageLiteralMacro.self, name: "imageLiteral")
    return macroSystem
  }()
}
