//===----------------------------------------------------------------------===//
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

/// Describes a macro that can introduce "preamble" code into an existing
/// function body.
@_spi(ExperimentalLanguageFeature)
public protocol PreambleMacro: AttachedMacro {
  /// Expand a macro described by the given custom attribute and
  /// attached to the given declaration and evaluated within a
  /// particular expansion context.
  ///
  /// The macro expansion can introduce code items that form a preamble to
  /// the body of the given function. The code items produced by this macro
  /// expansion will be inserted at the beginning of the function body.
  static func expansion(
    of node: AttributeSyntax,
    providingPreambleFor declaration: some DeclSyntaxProtocol & WithOptionalCodeBlockSyntax,
    in context: some MacroExpansionContext
  ) throws -> [CodeBlockItemSyntax]
}
