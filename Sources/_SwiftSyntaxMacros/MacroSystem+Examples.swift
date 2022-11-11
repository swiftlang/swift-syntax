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
import SwiftSyntaxBuilder

// Macros used for testing purposes
struct StringifyMacro: ExpressionMacro {
  static var name: String { "stringify" }

  static var documentation: String {
    "An example macro that produces the value of an expression and its source text"
  }

  static var genericSignature: GenericParameterClauseSyntax? = "<T>"

  static var signature: TypeSyntax = "(T) -> (T, String)"

  static var owningModule: String = "Swift"

  static func apply(
    _ macro: MacroExpansionExprSyntax, in context: MacroEvaluationContext
  ) -> MacroResult<ExprSyntax> {
    guard let argument = macro.argumentList.first?.expression else {
      // FIXME: Create a diagnostic for the missing argument?
      return MacroResult(ExprSyntax(macro))
    }

    return MacroResult("(\(argument), \(StringLiteralExprSyntax(content: argument.description)))")
  }
}

extension MacroSystem {
  public static var exampleSystem: MacroSystem = {
    var macroSystem = builtinMacroSystem
    try! macroSystem.add(StringifyMacro.self)
    return macroSystem
  }()
}
