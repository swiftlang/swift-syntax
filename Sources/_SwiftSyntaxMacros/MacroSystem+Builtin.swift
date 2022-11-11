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

struct ColumnMacro: ExpressionMacro {
  static var name: String { "column" }

  static var documentation: String {
    "The column at which this macro is used"
  }

  static var genericSignature: GenericParameterClauseSyntax? =
     """
     <T: ExpressibleByIntegerLiteral>
     """

  static var signature: TypeSyntax = "T"

  static var owningModule: String = "Swift"

  static func apply(
    _ macro: MacroExpansionExprSyntax, in context: MacroEvaluationContext
  ) -> MacroResult<ExprSyntax> {
    let line = macro.startLocation(
      converter: context.sourceLocationConverter
    ).column ?? 0
    return .init("\(line)")
  }
}

struct LineMacro: ExpressionMacro {
  static var name: String { "line" }

  static var documentation: String {
    "The line at which this macro is used"
  }

  static var genericSignature: GenericParameterClauseSyntax? =
     """
     <T: ExpressibleByIntegerLiteral>
     """

  static var signature: TypeSyntax = "T"

  static var owningModule: String = "Swift"

  static func apply(
    _ macro: MacroExpansionExprSyntax, in context: MacroEvaluationContext
  ) -> MacroResult<ExprSyntax> {
    let line = macro.startLocation(
      converter: context.sourceLocationConverter
    ).line ?? 0
    return .init("\(line)")
  }
}

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

struct FunctionMacro: ExpressionMacro {
  static var name: String { "function" }

  static var documentation: String {
    "The name of the function in which this macro is used"
  }

  static var genericSignature: GenericParameterClauseSyntax? =
     """
     <T: ExpressibleByStringLiteral>
     """

  static var signature: TypeSyntax = "T"

  static var owningModule: String = "Swift"

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

  static func apply(
    _ macro: MacroExpansionExprSyntax, in context: MacroEvaluationContext
  ) -> MacroResult<ExprSyntax> {
    let name = findEnclosingName(macro) ?? context.moduleName
    let literal: ExprSyntax = #""\#(name)""#
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

struct ColorLiteralMacro: ExpressionMacro {
  static var name: String { "colorLiteral" }

  static var documentation: String {
    "A color value expressed in terms of its RGBA components"
  }

  static var genericSignature: GenericParameterClauseSyntax? =
     """
     <T: ExpressibleByColorLiteral>
     """

  static var signature: TypeSyntax =
     """
     (
      red: Float, green: Float, blue: Float, alpha: Float
     ) -> T
     """

  // FIXME: Not entirely correct, should use _ColorLiteralType from
  // appropriate place.
  static var owningModule: String = "Swift"

  static func apply(
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

struct FileLiteralMacro: ExpressionMacro {
  static var name: String { "fileLiteral" }

  static var documentation: String {
    "A file resource in the application bundle"
  }

  static var genericSignature: GenericParameterClauseSyntax? =
      """
      <T: ExpressibleByFileReferenceLiteral>
      """

  static var signature: TypeSyntax =
      "(resourceName path: String) -> T"

  static var owningModule: String = "Swift"

  static func apply(
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

struct ImageLiteralMacro: ExpressionMacro {
  static var name: String { "imageLiteral" }

  static var documentation: String {
    "An image resource in the application bundle"
  }

  static var genericSignature: GenericParameterClauseSyntax? =
      """
      <T: ExpressibleByImageLiteral>
      """

  static var signature: TypeSyntax =
      "(resourceName path: String) -> T"

  // FIXME: Not really correct, use _ImageLiteralType
  static var owningModule: String = "Swift"

  static func apply(
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

struct FilePathMacro: ExpressionMacro {
  static var name: String { "filePath" }

  static var documentation: String {
    "The full path to the file in which this macro is used"
  }

  static var genericSignature: GenericParameterClauseSyntax? =
     """
     <T: ExpressibleByStringLiteral>
     """

  static var signature: TypeSyntax = "T"

  static var owningModule: String = "Swift"

  static func apply(
    _ macro: MacroExpansionExprSyntax, in context: MacroEvaluationContext
  ) -> MacroResult<ExprSyntax> {
    let fileName = context.sourceLocationConverter.location(
      for: .init(utf8Offset: 0)
    ).file ?? "<unknown file>"
    let fileLiteral: ExprSyntax = #""\#(fileName)""#
    if let leadingTrivia = macro.leadingTrivia {
      return MacroResult(fileLiteral.withLeadingTrivia(leadingTrivia))
    }
    return MacroResult(fileLiteral)
  }
}

struct FileIDMacro: ExpressionMacro {
  static var name: String { "fileID" }

  static var documentation: String {
    "The file in which this macro is used in the form ModuleName/FileName"
  }

  static var genericSignature: GenericParameterClauseSyntax? =
     """
     <T: ExpressibleByStringLiteral>
     """

  static var signature: TypeSyntax = "T"

  static var owningModule: String = "Swift"

  static func apply(
    _ macro: MacroExpansionExprSyntax, in context: MacroEvaluationContext
  ) -> MacroResult<ExprSyntax> {
    var fileName = context.sourceLocationConverter.location(
      for: .init(utf8Offset: 0)
    ).file ?? "<unknown file>"

    // Only keep everything after the last slash.
    if let lastSlash = fileName.lastIndex(of: "/") {
      fileName = String(fileName[fileName.index(after: lastSlash)...])
    }

    let fileLiteral: ExprSyntax = #""\#(context.moduleName)/\#(fileName)""#
    if let leadingTrivia = macro.leadingTrivia {
      return MacroResult(fileLiteral.withLeadingTrivia(leadingTrivia))
    }
    return MacroResult(fileLiteral)
  }
}

struct FileMacro: ExpressionMacro {
  static var name: String { "file" }

  static var documentation: String {
    "The file in which this macro is used"
  }

  static var genericSignature: GenericParameterClauseSyntax? =
     """
     <T: ExpressibleByStringLiteral>
     """

  static var signature: TypeSyntax = "T"

  static var owningModule: String = "Swift"

  static func apply(
    _ macro: MacroExpansionExprSyntax, in context: MacroEvaluationContext
  ) -> MacroResult<ExprSyntax> {
    // FIXME: Macro evaluation context needs to know the semantics of #file,
    // which is a feature check.
    return FilePathMacro.apply(macro, in: context)
  }
}

extension MacroSystem {
  public static var builtinMacroSystem: MacroSystem = {
    var macroSystem = MacroSystem()
    try! macroSystem.add(ColorLiteralMacro.self)
    try! macroSystem.add(ColumnMacro.self)
    try! macroSystem.add(FileIDMacro.self)
    try! macroSystem.add(FileLiteralMacro.self)
    try! macroSystem.add(FilePathMacro.self)
    try! macroSystem.add(FunctionMacro.self)
    try! macroSystem.add(ImageLiteralMacro.self)
    try! macroSystem.add(LineMacro.self)
    return macroSystem
  }()
}
