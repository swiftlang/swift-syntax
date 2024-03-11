//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#if swift(>=6)
import SwiftDiagnostics
public import SwiftSyntax
#else
import SwiftDiagnostics
import SwiftSyntax
#endif

enum DeclReferenceError: DiagnosticMessage {
  case nonLiteral

  var message: String {
    switch self {
    case .nonLiteral:
      return "only literals are permitted"
    }
  }

  var diagnosticID: MessageID {
    .init(domain: "SwiftMacros", id: "\(self)")
  }

  var severity: DiagnosticSeverity {
    .error
  }
}

/// Check sub-expressions to ensure all expressions are literals, and call
/// `diagnoseNonLiteral` for all other expressions.
class OnlyLiteralExprChecker: SyntaxAnyVisitor {
  var diagnostics: [Diagnostic] = []

  init() {
    super.init(viewMode: .fixedUp)
  }

  // Integer literals
  override func visit(_ node: IntegerLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    .visitChildren
  }

  // Floating point literals
  override func visit(_ node: FloatLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    .visitChildren
  }

  // Negative numbers
  override func visit(_ node: PrefixOperatorExprSyntax) -> SyntaxVisitorContinueKind {
    switch node.operator.tokenKind {
    case .prefixOperator("-")
    // only allow negation on numbers, not other literal types
    where node.expression.is(IntegerLiteralExprSyntax.self)
      || node.expression.is(FloatLiteralExprSyntax.self):
      return .visitChildren
    default:
      return diagnoseNonLiteral(node)
    }
  }

  // Bool literals
  override func visit(_ node: BooleanLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    .visitChildren
  }

  // nil literals
  override func visit(_ node: NilLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    .visitChildren
  }

  // String literals
  override func visit(_ node: StringLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    .visitChildren
  }

  // String interpolation
  override func visit(_ node: StringLiteralSegmentListSyntax) -> SyntaxVisitorContinueKind {
    guard node.count == 1,
      case .stringSegment = node.first!
    else {
      return diagnoseNonLiteral(node)
    }
    return .visitChildren
  }

  // Array literals
  override func visit(_ node: ArrayExprSyntax) -> SyntaxVisitorContinueKind {
    .visitChildren
  }

  // Dictionary literals
  override func visit(_ node: DictionaryExprSyntax) -> SyntaxVisitorContinueKind {
    .visitChildren
  }

  // Tuple literals
  override func visit(_ node: TupleExprSyntax) -> SyntaxVisitorContinueKind {
    .visitChildren
  }

  // Regex literals
  override func visit(_ node: RegexLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    .visitChildren
  }

  // Macro uses.
  override func visit(_ node: MacroExpansionExprSyntax) -> SyntaxVisitorContinueKind {
    .visitChildren
  }

  // References to declarations.
  override func visit(_ node: DeclReferenceExprSyntax) -> SyntaxVisitorContinueKind {
    return diagnoseNonLiteral(node)
  }

  override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
    if node.is(ExprSyntax.self) {
      // We have an expression that is not one of the allowed forms, so
      // diagnose it.
      return diagnoseNonLiteral(node)
    }

    return .visitChildren
  }

  func diagnoseNonLiteral(_ node: some SyntaxProtocol) -> SyntaxVisitorContinueKind {
    diagnostics.append(
      Diagnostic(
        node: node,
        message: DeclReferenceError.nonLiteral
      )
    )

    return .skipChildren
  }
}

extension MacroExpansionExprSyntax {
  /// For compiler to check a macro expression used as default argument.
  ///
  /// Only literals are permitted as arguments to these expressions.
  ///
  /// If there are diagnostics, they will be wrapped into an error and thrown.
  @_spi(Compiler)
  public func checkDefaultArgumentMacroExpression() throws {
    let visitor = OnlyLiteralExprChecker()
    visitor.walk(arguments)

    if !visitor.diagnostics.isEmpty {
      throw DiagnosticsError(diagnostics: visitor.diagnostics)
    }
  }
}
