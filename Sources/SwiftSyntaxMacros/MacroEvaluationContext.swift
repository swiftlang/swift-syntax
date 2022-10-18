import SwiftSyntax

/// System-supplied structure that provides information about the context in
/// which a given macro is being expanded.
public struct MacroEvaluationContext {
  /// The name of the module in which the macro is being evaluated.
  public let moduleName: String

  /// Used to map the provided syntax nodes into source locations.
  public let sourceLocationConverter: SourceLocationConverter

  @_spi(Testing)
  public init(
    moduleName: String,
    sourceLocationConverter: SourceLocationConverter
  ) {
    self.moduleName = moduleName
    self.sourceLocationConverter = sourceLocationConverter
  }
}
