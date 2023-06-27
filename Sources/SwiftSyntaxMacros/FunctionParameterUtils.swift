import SwiftSyntax

extension FunctionParameterSyntax {
  /// Retrieve the name of the parameter as it is used in source.
  ///
  /// Example:
  ///
  ///     func f(a: Int, _ b: Int, c see: Int) { ... }
  ///
  /// The parameter names for these three parameters are `a`, `b`, and `see`,
  /// respectively.
  var parameterName: TokenSyntax? {
    // If there were two names, the second is the parameter name.
    if let secondName {
      if secondName.text == "_" {
        return nil
      }

      return secondName
    }

    if firstName.text == "_" {
      return nil
    }

    return firstName
  }
}
