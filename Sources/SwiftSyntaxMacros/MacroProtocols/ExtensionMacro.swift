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

/// Describes a macro that can add extensions to the declaration it's
/// attached to.
public protocol ExtensionMacro: AttachedMacro {
  /// Expand an attached extension macro to produce a set of extensions.
  ///
  /// - Parameters:
  ///   - node: The custom attribute describing the attached macro.
  ///   - declaration: The declaration the macro attribute is attached to.
  ///   - type: The type to provide extensions of.
  ///   - protocols: The list of protocols to add conformances to. These will
  ///     always be protocols that `type` does not already state a conformance
  ///     to.
  ///   - context: The context in which to perform the macro expansion.
  ///
  /// - Returns: the set of extension declarations introduced by the macro,
  ///   which are always inserted at top-level scope. Each extension must extend
  ///   the `type` parameter.
  static func expansion(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [ExtensionDeclSyntax]
}
