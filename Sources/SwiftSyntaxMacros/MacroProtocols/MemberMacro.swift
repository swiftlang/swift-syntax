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

#if swift(>=6)
public import SwiftSyntax
#else
import SwiftSyntax
#endif

/// Describes a macro that can add members to the declaration it's attached to.
public protocol MemberMacro: AttachedMacro {
  /// Expand an attached declaration macro to produce a set of members.
  ///
  /// - Parameters:
  ///   - node: The custom attribute describing the attached macro.
  ///   - declaration: The declaration the macro attribute is attached to.
  ///   - context: The context in which to perform the macro expansion.
  ///
  /// - Returns: the set of member declarations introduced by this macro, which
  /// are nested inside the `attachedTo` declaration.
  ///
  /// - Warning: This is the legacy `expansion` function of `MemberMacro` that is provided for backwards-compatiblity.
  ///   Use ``expansion(of:providingMembersOf:conformingTo:in:)-1sxoe`` instead.
  static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax]

  /// Expand an attached declaration macro to produce a set of members.
  ///
  /// - Parameters:
  ///   - node: The custom attribute describing the attached macro.
  ///   - declaration: The declaration the macro attribute is attached to.
  ///   - conformingTo: The set of protocols that were declared
  ///     in the set of conformances for the macro and to which the declaration
  ///     does not explicitly conform. The member macro itself cannot declare
  ///     conformances to these protocols (only an extension macro can do that),
  ///     but can provide supporting declarations, such as a required
  ///     initializer or stored property, that cannot be written in an
  ///     extension.
  ///   - context: The context in which to perform the macro expansion.
  ///
  /// - Returns: the set of member declarations introduced by this macro, which
  /// are nested inside the `attachedTo` declaration.
  static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax]
}

private struct UnimplementedExpansionMethodError: Error, CustomStringConvertible {
  var description: String {
    """
    Types conforming to `MemberMacro` must implement either \
    expansion(of:providingMembersOf:in:) or \
    expansion(of:providingMembersOf:conformingTo:in:)
    """
  }
}

public extension MemberMacro {
  /// Default implementation supplies no conformances.
  static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    throw UnimplementedExpansionMethodError()
  }

  /// Default implementation that ignores the unhandled conformances.
  static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    return try expansion(of: node, providingMembersOf: declaration, in: context)
  }
}
