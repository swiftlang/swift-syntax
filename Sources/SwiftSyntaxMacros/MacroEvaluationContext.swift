import SwiftSyntax

/// System-supplied structure that provides information about the context in
/// which a given macro is being expanded.
public struct MacroEvaluationContext {
  /// Used to map the provided syntax nodes into source locations.
  public let sourceLocationConverter: SourceLocationConverter
}
