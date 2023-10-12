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
import SwiftSyntaxMacros

public struct DictionaryStorageMacro {}

extension DictionaryStorageMacro: MemberMacro {
  public static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    return ["\n  var _storage: [String: Any] = [:]"]
  }
}

extension DictionaryStorageMacro: MemberAttributeMacro {
  public static func expansion(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingAttributesFor member: some DeclSyntaxProtocol,
    in context: some MacroExpansionContext
  ) throws -> [AttributeSyntax] {
    guard let property = member.as(VariableDeclSyntax.self),
      property.isStoredProperty
    else {
      return []
    }

    return [
      AttributeSyntax(
        leadingTrivia: [.newlines(1), .spaces(2)],
        attributeName: IdentifierTypeSyntax(
          name: .identifier("DictionaryStorageProperty")
        )
      )
    ]
  }
}

public struct DictionaryStoragePropertyMacro: AccessorMacro {
  public static func expansion<
    Context: MacroExpansionContext,
    Declaration: DeclSyntaxProtocol
  >(
    of node: AttributeSyntax,
    providingAccessorsOf declaration: Declaration,
    in context: Context
  ) throws -> [AccessorDeclSyntax] {
    guard let varDecl = declaration.as(VariableDeclSyntax.self),
      let binding = varDecl.bindings.first,
      let identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier,
      binding.accessorBlock == nil,
      let type = binding.typeAnnotation?.type
    else {
      return []
    }

    // Ignore the "_storage" variable.
    if identifier.text == "_storage" {
      return []
    }

    guard let defaultValue = binding.initializer?.value else {
      throw CustomError.message("stored property must have an initializer")
    }

    return [
      """
      get {
        _storage[\(literal: identifier.text), default: \(defaultValue)] as! \(type)
      }
      """,
      """
      set {
        _storage[\(literal: identifier.text)] = newValue
      }
      """,
    ]
  }
}
