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

/// Describes a macro that forms declarations.
public protocol DeclarationMacro: FreestandingMacro {
  /// Expand a macro described by the given freestanding macro expansion
  /// declaration within the given context to produce a set of declarations.
  static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax]

  /// Whether to copy attributes on the expansion syntax to expanded declarations,
  /// 'true' by default.
  static var propagateFreestandingMacroAttributes: Bool { get }
  /// Whether to copy modifiers on the expansion syntax to expanded declarations,
  /// 'true' by default.
  static var propagateFreestandingMacroModifiers: Bool { get }
}

public extension DeclarationMacro {
  static var propagateFreestandingMacroAttributes: Bool { true }
  static var propagateFreestandingMacroModifiers: Bool { true }
}
