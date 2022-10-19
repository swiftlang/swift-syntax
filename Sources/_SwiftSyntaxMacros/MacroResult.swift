import SwiftDiagnostics

/// Describes the result of rewriting a macro, which contains the rewritten
/// syntax nodes along with any additional information, such as diagnostics
/// generated as part of the rewrite.
public struct MacroResult<Rewritten> {
  public let rewritten: Rewritten
  public let diagnostics: [Diagnostic]

  public init(_ rewritten: Rewritten, diagnostics: [Diagnostic] = []) {
    self.rewritten = rewritten
    self.diagnostics = diagnostics
  }
}
