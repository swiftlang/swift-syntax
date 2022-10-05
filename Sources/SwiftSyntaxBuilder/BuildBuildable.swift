import SwiftBasicFormat
import SwiftSyntax

public extension SyntaxBuildable {
  /// Build a syntax node from this `Buildable` and format it with the given format.
  func build(format: BasicFormat = BasicFormat()) -> Syntax {
    return format.visit(self.buildSyntax())
  }
}
