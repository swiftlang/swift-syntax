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
public struct FontLiteralMacro: ExpressionMacro {
  public static func expansion(
    of macro: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) -> ExprSyntax {
    let argList = replaceFirstLabel(
      of: macro.arguments,
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
  guard let firstElement = tuple.first else {
    return tuple
  }

  var tuple = tuple
  tuple[tuple.startIndex] = firstElement.with(\.label, .identifier(newLabel))
  return tuple
}
