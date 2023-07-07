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

/// Describes a macro that can add conformances to the declaration it's
/// attached to.
public protocol ConformanceMacro: ExtensionMacro {
  /// Expand an attached conformance macro to produce a set of conformances.
  ///
  /// - Parameters:
  ///   - node: The custom attribute describing the attached macro.
  ///   - declaration: The declaration the macro attribute is attached to.
  ///   - context: The context in which to perform the macro expansion.
  ///
  /// - Returns: the set of `(type, where-clause?)` pairs that each provide the
  ///   protocol type to which the declared type conforms, along with
  ///   an optional where clause.
  static func expansion(
    of node: AttributeSyntax,
    providingConformancesOf declaration: some DeclGroupSyntax,
    in context: some MacroExpansionContext
  ) throws -> [(TypeSyntax, GenericWhereClauseSyntax?)]
}

extension ConformanceMacro {
  public static func expansion(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [ExtensionDeclSyntax] {

    let newConformances = try expansion(
      of: node,
      providingConformancesOf: declaration,
      in: context
    )

    var extensions: [ExtensionDeclSyntax] = []
    for (proto, whereClause) in newConformances {
      let decl: DeclSyntax =
        """
        extension \(type.trimmed): \(proto.trimmed) {}
        """

      var extensionDecl = decl.cast(ExtensionDeclSyntax.self)

      if let whereClause {
        extensionDecl = extensionDecl.with(\.genericWhereClause, whereClause.trimmed)
      }

      extensions.append(extensionDecl)
    }

    return extensions
  }
}
