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

import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxMacros

/// Implementation of the `myWarning` macro, which mimics the behavior of the
/// built-in `#warning`.
public enum WarningMacro: ExpressionMacro {
  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> ExprSyntax {
    guard let firstElement = node.arguments.first,
      let stringLiteral = firstElement.expression
        .as(StringLiteralExprSyntax.self),
      stringLiteral.segments.count == 1,
      case let .stringSegment(messageString)? = stringLiteral.segments.first
    else {
      throw CustomError.message("#myWarning macro requires a string literal")
    }

    context.diagnose(
      Diagnostic(
        node: Syntax(node),
        message: SimpleDiagnosticMessage(
          message: messageString.content.description,
          diagnosticID: MessageID(domain: "test123", id: "error"),
          severity: .warning
        )
      )
    )

    return "()"
  }
}
