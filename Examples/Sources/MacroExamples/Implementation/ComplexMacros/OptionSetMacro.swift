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

import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

enum OptionSetMacroDiagnostic {
  case requiresStruct
  case requiresStringLiteral(String)
  case requiresOptionsEnum(String)
  case requiresOptionsEnumRawType
}

extension OptionSetMacroDiagnostic: DiagnosticMessage {
  func diagnose(at node: some SyntaxProtocol) -> Diagnostic {
    Diagnostic(node: Syntax(node), message: self)
  }

  var message: String {
    switch self {
    case .requiresStruct:
      return "'OptionSet' macro can only be applied to a struct"

    case .requiresStringLiteral(let name):
      return "'OptionSet' macro argument \(name) must be a string literal"

    case .requiresOptionsEnum(let name):
      return "'OptionSet' macro requires nested options enum '\(name)'"

    case .requiresOptionsEnumRawType:
      return "'OptionSet' macro requires a raw type"
    }
  }

  var severity: DiagnosticSeverity { .error }

  var diagnosticID: MessageID {
    MessageID(domain: "Swift", id: "OptionSet.\(self)")
  }
}

/// The label used for the OptionSet macro argument that provides the name of
/// the nested options enum.
private let optionsEnumNameArgumentLabel = "optionsName"

/// The default name used for the nested "Options" enum. This should
/// eventually be overridable.
private let defaultOptionsEnumName = "Options"

extension LabeledExprListSyntax {
  /// Retrieve the first element with the given label.
  func first(labeled name: String) -> Element? {
    return first { element in
      if let label = element.label, label.text == name {
        return true
      }

      return false
    }
  }
}

public struct OptionSetMacro {
  /// Decodes the arguments to the macro expansion.
  ///
  /// - Returns: the important arguments used by the various roles of this
  /// macro inhabits, or nil if an error occurred.
  static func decodeExpansion(
    of attribute: AttributeSyntax,
    attachedTo decl: some DeclGroupSyntax,
    in context: some MacroExpansionContext,
    emitDiagnostics: Bool
  ) -> (StructDeclSyntax, EnumDeclSyntax, TypeSyntax)? {
    // Determine the name of the options enum.
    let optionsEnumName: String
    if case let .argumentList(arguments) = attribute.arguments,
      let optionEnumNameArg = arguments.first(labeled: optionsEnumNameArgumentLabel)
    {
      // We have a options name; make sure it is a string literal.
      guard let stringLiteral = optionEnumNameArg.expression.as(StringLiteralExprSyntax.self),
        stringLiteral.segments.count == 1,
        case let .stringSegment(optionsEnumNameString)? = stringLiteral.segments.first
      else {
        if emitDiagnostics {
          context.diagnose(
            OptionSetMacroDiagnostic.requiresStringLiteral(optionsEnumNameArgumentLabel).diagnose(
              at: optionEnumNameArg.expression
            )
          )
        }
        return nil
      }

      optionsEnumName = optionsEnumNameString.content.text
    } else {
      optionsEnumName = defaultOptionsEnumName
    }

    // Only apply to structs.
    guard let structDecl = decl.as(StructDeclSyntax.self) else {
      if emitDiagnostics {
        context.diagnose(OptionSetMacroDiagnostic.requiresStruct.diagnose(at: decl))
      }
      return nil
    }

    // Find the option enum within the struct.
    guard
      let optionsEnum = decl.memberBlock.members.compactMap({ member in
        if let enumDecl = member.decl.as(EnumDeclSyntax.self),
          enumDecl.name.text == optionsEnumName
        {
          return enumDecl
        }

        return nil
      }).first
    else {
      if emitDiagnostics {
        context.diagnose(OptionSetMacroDiagnostic.requiresOptionsEnum(optionsEnumName).diagnose(at: decl))
      }
      return nil
    }

    // Retrieve the raw type from the attribute.
    guard let genericArgs = attribute.attributeName.as(IdentifierTypeSyntax.self)?.genericArgumentClause,
      let rawType = genericArgs.arguments.first?.argument
    else {
      if emitDiagnostics {
        context.diagnose(OptionSetMacroDiagnostic.requiresOptionsEnumRawType.diagnose(at: attribute))
      }
      return nil
    }

    return (structDecl, optionsEnum, rawType)
  }
}

extension OptionSetMacro: ExtensionMacro {
  public static func expansion(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [ExtensionDeclSyntax] {
    // Decode the expansion arguments.
    guard
      let (structDecl, _, _) = decodeExpansion(of: node, attachedTo: declaration, in: context, emitDiagnostics: false)
    else {
      return []
    }

    // If there is an explicit conformance to OptionSet already, don't add one.
    if let inheritedTypes = structDecl.inheritanceClause?.inheritedTypes,
      inheritedTypes.contains(where: { inherited in inherited.type.trimmedDescription == "OptionSet" })
    {
      return []
    }

    return [try ExtensionDeclSyntax("extension \(type): OptionSet {}")]
  }
}

extension OptionSetMacro: MemberMacro {
  public static func expansion(
    of attribute: AttributeSyntax,
    providingMembersOf decl: some DeclGroupSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    // Decode the expansion arguments.
    guard
      let (_, optionsEnum, rawType) = decodeExpansion(
        of: attribute,
        attachedTo: decl,
        in: context,
        emitDiagnostics: true
      )
    else {
      return []
    }

    // Find all of the case elements.
    let caseElements: [EnumCaseElementSyntax] = optionsEnum.memberBlock.members.flatMap { member in
      guard let caseDecl = member.decl.as(EnumCaseDeclSyntax.self) else {
        return Array<EnumCaseElementSyntax>()
      }

      return Array(caseDecl.elements)
    }

    // Dig out the access control keyword we need.
    let access = decl.modifiers.first(where: \.isNeededAccessLevelModifier)

    let staticVars = caseElements.map { (element) -> DeclSyntax in
      """
      \(access) static let \(element.name): Self =
        Self(rawValue: 1 << \(optionsEnum.name).\(element.name).rawValue)
      """
    }

    return [
      "\(access)typealias RawValue = \(rawType)",
      "\(access)var rawValue: RawValue",
      "\(access)init() { self.rawValue = 0 }",
      "\(access)init(rawValue: RawValue) { self.rawValue = rawValue }",
    ] + staticVars
  }
}
