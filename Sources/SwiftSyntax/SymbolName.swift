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

extension FunctionDeclSyntax {
  /// The symbol name of the function declaration.
  ///
  /// The symbol name is a string representation of the function name along with its parameter labels.
  /// For example, a function `func greet(name: String)` will have the symbol name `greet(name:)`.
  public var symbolName: String {
    SwiftSyntax.symbolName(
      fromBaseName: name.text,
      parameters: signature.parameterClause
    )
  }
}

extension InitializerDeclSyntax {
  /// The symbol name of the initializer declaration.
  ///
  /// The symbol name is a string representation of the initializer along with its parameter labels.
  /// For example, an initializer `init(name: String)` will have the symbol name `init(name:)`.
  public var symbolName: String {
    SwiftSyntax.symbolName(
      fromBaseName: initKeyword.text,
      parameters: signature.parameterClause
    )
  }
}

extension SubscriptDeclSyntax {
  /// The symbol name of the subscript declaration.
  ///
  /// The symbol name is a string representation of the subscript along with its parameter labels.
  /// For example, a subscript `subscript(index: Int)` will have the symbol name `subscript(_:)`.
  public var symbolName: String {
    SwiftSyntax.symbolName(
      fromBaseName: subscriptKeyword.text,
      parameters: parameterClause,
      isForSubscript: true
    )
  }
}

extension EnumCaseElementSyntax {
  /// The symbol name of the enum case element.
  ///
  /// The symbol name is a string representation of the enum case name along with its associated value labels (if any).
  /// For example, an enum case `case foo(bar: Int)` will have the symbol name `foo(bar:)`.
  public var symbolName: String {
    let caseName = name.text

    guard let associatedValues = parameterClause else {
      return caseName
    }

    let argumentLabels = associatedValues.parameters
      .map { parameter in
        guard let firstName = parameter.firstName else {
          return "_:"
        }

        return firstName.text + ":"
      }
      .joined()

    return "\(caseName)(\(argumentLabels))"
  }
}

extension MacroDeclSyntax {
  /// The symbol name of the macro declaration.
  ///
  /// The symbol name is a string representation of the macro name along with its parameter labels.
  /// For example, a macro `macro greet(name: String)` will have the symbol name `greet(name:)`.
  public var symbolName: String {
    SwiftSyntax.symbolName(
      fromBaseName: name.text,
      parameters: signature.parameterClause
    )
  }
}

/// Generates the symbol name by combining the base name and parameter labels.
///
/// If the parameter has two names (e.g., `external internal: Int`), the first name is considered the argument label.
/// If the parameter has only one name and it's not a subscript parameter, it is considered the argument label.
///
/// - Parameters:
///   - baseName: The base name of the symbol (e.g., function name, initializer, subscript).
///   - parameters: The function parameter clause containing the parameter labels.
/// - Returns: The symbol name with the base name and parameter labels combined.
private func symbolName(
  fromBaseName baseName: String,
  parameters: FunctionParameterClauseSyntax,
  isForSubscript: Bool = false
) -> String {
  let argumentLabels = parameters.parameters
    .map { parameter in
      let argumentLabelText = parameter.argumentName(isForSubscript: isForSubscript) ?? "_"
      return argumentLabelText + ":"
    }
    .joined()

  return "\(baseName)(\(argumentLabels))"
}

extension FunctionParameterSyntax {
  /// The argument name (label) of the function parameter.
  fileprivate func argumentName(isForSubscript: Bool = false) -> String? {
    // If we have two names, the first one is the argument label
    if secondName != nil {
      return firstName.asIdentifierToken
    }

    if isForSubscript {
      return nil
    }

    return firstName.asIdentifierToken
  }
}

extension TokenSyntax {
  fileprivate var asIdentifierToken: String? {
    switch tokenKind {
    case .identifier: return self.text
    default: return nil
    }
  }
}
