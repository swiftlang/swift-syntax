import SwiftSyntax
import SwiftSyntaxBuilder

// Macros used for testing purposes
struct ColumnMacro: ExpressionMacro {
  static var name: String { "column" }

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

struct StringifyMacro: ExpressionMacro {
  static var name: String { "stringify" }

  static func apply(
    _ macro: MacroExpansionExprSyntax, in context: MacroEvaluationContext
  ) -> MacroResult<ExprSyntax> {
    guard let argument = macro.argumentList.first?.expression else {
      // FIXME: Create a diagnostic for the missing argument?
      return MacroResult(ExprSyntax(macro))
    }

    return MacroResult("(\(argument), #\"\(argument)\"#)")
  }
}

struct ColorLiteralMacro: ExpressionMacro {
  static var name: String { "colorLiteral" }

  static func apply(
    _ macro: MacroExpansionExprSyntax, in context: MacroEvaluationContext
  ) -> MacroResult<ExprSyntax> {
    let initSyntax: ExprSyntax = ".init(\(macro.argumentList))"
    if let leadingTrivia = macro.leadingTrivia {
      return MacroResult(initSyntax.withLeadingTrivia(leadingTrivia))
    }
    return MacroResult(initSyntax)
  }
}

struct FileLiteralMacro: ExpressionMacro {
  static var name: String { "fileLiteral" }

  static func apply(
    _ macro: MacroExpansionExprSyntax, in context: MacroEvaluationContext
  ) -> MacroResult<ExprSyntax> {
    let initSyntax: ExprSyntax = ".init(\(macro.argumentList))"
    if let leadingTrivia = macro.leadingTrivia {
      return MacroResult(initSyntax.withLeadingTrivia(leadingTrivia))
    }
    return MacroResult(initSyntax)
  }
}

struct ImageLiteralMacro: ExpressionMacro {
  static var name: String { "imageLiteral" }

  static func apply(
    _ macro: MacroExpansionExprSyntax, in context: MacroEvaluationContext
  ) -> MacroResult<ExprSyntax> {
    let initSyntax: ExprSyntax = ".init(\(macro.argumentList))"
    if let leadingTrivia = macro.leadingTrivia {
      return MacroResult(initSyntax.withLeadingTrivia(leadingTrivia))
    }
    return MacroResult(initSyntax)
  }
}

struct FilePathMacro: ExpressionMacro {
  static var name: String { "filePath" }

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

  static func apply(
    _ macro: MacroExpansionExprSyntax, in context: MacroEvaluationContext
  ) -> MacroResult<ExprSyntax> {
    // FIXME: Macro evaluation context needs to know the semantics of #file,
    // which is a feature check.
    return FilePathMacro.apply(macro, in: context)
  }
}

extension MacroSystem {
  public static var exampleSystem: MacroSystem {
    var macroSystem = MacroSystem()
    try! macroSystem.add(ColorLiteralMacro.self)
    try! macroSystem.add(ColumnMacro.self)
    try! macroSystem.add(FileIDMacro.self)
    try! macroSystem.add(FileLiteralMacro.self)
    try! macroSystem.add(FilePathMacro.self)
    try! macroSystem.add(FunctionMacro.self)
    try! macroSystem.add(ImageLiteralMacro.self)
    try! macroSystem.add(LineMacro.self)
    try! macroSystem.add(StringifyMacro.self)
    return macroSystem
  }
}
