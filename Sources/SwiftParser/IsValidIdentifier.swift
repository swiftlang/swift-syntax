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

@_spi(RawSyntax) import SwiftSyntax

/// Context in which to check if a name can be used as an identifier.
///
/// - SeeAlso: `Swift.isValidSwiftIdentifier(for:)` extension added by SwiftParser.
public enum IdentifierCheckContext {
  /// Check if a name can be used to declare a variable, ie. if it can be used after a `let` or `var` keyword.
  ///
  /// ### Examples
  /// - `test` is a valid variable name and `let test: Int` is valid Swift code
  /// - `class` is not a valid variable and `let class: Int` is invalid Swift code
  case variableName

  /// Check if a name can be used as a member access, ie. if it can be used after a `.`.
  ///
  /// ### Examples
  /// - `test` is a valid identifier for member access because `myStruct.test` is valid
  /// - `class` is a valid identifier for member access because `myStruct.class` is valid, even though `class`
  ///   needs to be wrapped in backticks when used to declare a variable.
  /// - `self` is not a valid identifier for member access because `myStruct.self` does not access a member named
  ///   `self` on `myStruct` and instead returns `myStruct` itself.
  case memberAccess
}

extension String {
  /// Checks whether `name` can be used as an identifier in a certain context.
  ///
  /// If the name cannot be used as an identifier in this context, it needs to be escaped.
  ///
  /// For example, `class` is not a valid identifier for a variable name and needs to be be wrapped in backticks
  /// to be valid Swift code, like the following.
  ///
  /// ```swift
  /// let `class`: String
  /// ```
  ///
  /// The context is important here – some names can be used as identifiers in some contexts but not others.
  /// For example, `myStruct.class` is valid without adding backticks `class`, but as mentioned above,
  /// backticks need to be added when `class` is used as a variable name.
  ///
  /// - SeeAlso: ``SwiftParser/IdentifierCheckContext``
  public func isValidSwiftIdentifier(for context: IdentifierCheckContext) -> Bool {
    switch context {
    case .variableName:
      return isValidVariableName(self)
    case .memberAccess:
      return isValidMemberAccess(self)
    }
  }
}

private func isValidVariableName(_ name: String) -> Bool {
  var parser = Parser("var \(name)")
  let decl = DeclSyntax.parse(from: &parser)
  guard parser.at(.endOfFile) else {
    // We didn't parse the entire name. Probably some garbage left in the name, so not an identifier.
    return false
  }
  guard !decl.hasError && !decl.hasWarning else {
    // There were syntax errors in the source code. So not valid.
    return false
  }
  guard let variable = decl.as(VariableDeclSyntax.self) else {
    return false
  }
  guard let identifier = variable.bindings.first?.pattern.as(IdentifierPatternSyntax.self)?.identifier else {
    return false
  }
  guard identifier.rawTokenKind == .identifier else {
    // We parsed the name as a keyword, eg. `self`, so not a valid identifier.
    return false
  }
  guard identifier.rawText.count == name.utf8.count else {
    // The identifier doesn't cover all the characters in `name`, so we parsed
    // some of these characters into trivia or another token.
    // Thus, `name` is not a valid identifier.
    return false
  }
  return true
}

private func isValidMemberAccess(_ name: String) -> Bool {
  var parser = Parser("t.\(name)")
  let expr = ExprSyntax.parse(from: &parser)
  guard parser.at(.endOfFile) else {
    // We didn't parse the entire name. Probably some garbage left in the name, so not an identifier.
    return false
  }
  guard !expr.hasError && !expr.hasWarning else {
    // There were syntax errors in the source code. So not valid.
    return false
  }
  guard let memberAccess = expr.as(MemberAccessExprSyntax.self) else {
    return false
  }
  let identifier = memberAccess.declName.baseName
  guard identifier.rawTokenKind == .identifier else {
    // We parsed the name as a keyword, eg. `self`, so not a valid identifier.
    return false
  }
  guard identifier.rawText.count == name.utf8.count else {
    // The identifier doesn't cover all the characters in `name`, so we parsed
    // some of these characters into trivia or another token.
    // Thus, `name` is not a valid identifier.
    return false
  }
  return true
}
