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
import SwiftParser
import SwiftDiagnostics

/// Describes a macro that is explicitly expanded as an expression.
public protocol ExpressionMacro: Macro {
  /// Expand a macro described by the given macro expansion expression
  /// within the given context to produce a replacement expression.
  static func expansion(
    of node: MacroExpansionExprSyntax,
    in context: inout MacroExpansionContext
  ) throws -> ExprSyntax
}
