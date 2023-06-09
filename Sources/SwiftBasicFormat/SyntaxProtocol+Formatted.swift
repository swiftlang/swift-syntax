import SwiftSyntax

public extension SyntaxProtocol {
  /// Build a syntax node from this `Buildable` and format it with the given format.
  func formatted(using format: BasicFormat = BasicFormat()) -> Syntax {
    return format.rewrite(self)
  }
}
