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

/// Implementation of the `#fontLiteral` macro, which is similar in spirit
/// to the built-in expressions `#colorLiteral`, `#imageLiteral`, etc., but in
/// a small macro.
public enum FontLiteralMacro: ExpressionMacro {
  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> ExprSyntax {
    let argList = replaceFirstLabel(
      of: node.arguments,
      with: "fontLiteralName"
    )
    return ".init(\(argList))"
  }
}

/// Replace the label of the first element in the tuple with the given
/// new label.
private func replaceFirstLabel(
  of tuple: LabeledExprListSyntax,
  with newLabel: String
) -> LabeledExprListSyntax {
  if tuple.isEmpty {
    return tuple
  }

  var tuple = tuple
  tuple[tuple.startIndex].label = .identifier(newLabel)
  tuple[tuple.startIndex].colon = .colonToken()
  return tuple
}
