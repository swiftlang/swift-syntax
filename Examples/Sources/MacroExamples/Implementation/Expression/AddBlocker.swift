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
import SwiftOperators
import SwiftSyntax
import SwiftSyntaxMacros

/// Implementation of the `addBlocker` macro, which demonstrates how to
/// produce detailed diagnostics from a macro implementation for an utterly
/// silly task: warning about every "add" (binary +) in the argument, with a
/// Fix-It that changes it to a "-".
public struct AddBlocker: ExpressionMacro {
  class AddVisitor: SyntaxRewriter {
    var diagnostics: [Diagnostic] = []

    override func visit(
      _ node: InfixOperatorExprSyntax
    ) -> ExprSyntax {
      // Identify any infix operator + in the tree.
      if var binOp = node.operator.as(BinaryOperatorExprSyntax.self) {
        if binOp.operator.text == "+" {
          // Form the warning
          let messageID = MessageID(domain: "silly", id: "addblock")
          diagnostics.append(
            Diagnostic(
              // Where the warning should go (on the "+").
              node: Syntax(node.operator),
              // The warning message and severity.
              message: SimpleDiagnosticMessage(
                message: "blocked an add; did you mean to subtract?",
                diagnosticID: messageID,
                severity: .warning
              ),
              // Highlight the left and right sides of the `+`.
              highlights: [
                Syntax(node.leftOperand),
                Syntax(node.rightOperand),
              ],
              fixIts: [
                // Fix-It to replace the '+' with a '-'.
                FixIt(
                  message: SimpleDiagnosticMessage(
                    message: "use '-'",
                    diagnosticID: messageID,
                    severity: .error
                  ),
                  changes: [
                    FixIt.Change.replace(
                      oldNode: Syntax(binOp.operator),
                      newNode: Syntax(
                        TokenSyntax(
                          .binaryOperator("-"),
                          leadingTrivia: binOp.operator.leadingTrivia,
                          trailingTrivia: binOp.operator.trailingTrivia,
                          presence: .present
                        )
                      )
                    )
                  ]
                )
              ]
            )
          )

          binOp.operator.tokenKind = .binaryOperator("-")

          return ExprSyntax(node.with(\.operator, ExprSyntax(binOp)))
        }
      }

      return ExprSyntax(node)
    }
  }

  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> ExprSyntax {
    let visitor = AddVisitor()
    let result = visitor.rewrite(Syntax(node))

    for diag in visitor.diagnostics {
      context.diagnose(diag)
    }

    return result.asProtocol(FreestandingMacroExpansionSyntax.self)!.arguments.first!.expression
  }
}
