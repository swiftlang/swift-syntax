import SwiftDiagnostics
import SwiftSyntax

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

class CheckDeclReferenceVisitor: SyntaxAnyVisitor {
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
          case .stringSegment = node.first! else {
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
  public func checkDefaultArgumentMacroExpression() throws {
    let visitor = CheckDeclReferenceVisitor()
    visitor.walk(arguments)

    if !visitor.diagnostics.isEmpty {
      throw DiagnosticsError(diagnostics: visitor.diagnostics)
    }
  }
}
