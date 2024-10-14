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

import SwiftSyntax

/// Represents result from a specific scope.
@_spi(Experimental) public enum LookupResult {
  /// Scope and the names that matched lookup.
  case fromScope(ScopeSyntax, withNames: [LookupName])
  /// File scope and names that matched lookup.
  case fromFileScope(SourceFileSyntax, withNames: [LookupName])
  /// Indicates where to perform member lookup.
  case lookInMembers(LookInMembersScopeSyntax)
  /// Indicates to lookup generic parameters of extended type.
  ///
  /// ### Example
  /// ```swift
  /// extension Foo {
  ///   func bar() {
  ///     let a = A() // <-- lookup here
  ///   }
  /// }
  /// ```
  /// For a lookup started at the marked position, `lookInGenericParametersOfExtendedType`
  /// will be included as one of the results prompting the client
  /// to lookup the generic parameters of of the extended `Foo` type.
  case lookInGenericParametersOfExtendedType(ExtensionDeclSyntax)
  /// Indicates this closure expression could introduce dollar identifiers.
  ///
  /// ### Example
  /// ```swift
  /// func foo() {
  ///   let a = {
  ///     $0 // <-- lookup here
  ///   }
  /// }
  /// ```
  /// When looking up for any identifier at the indicated position,
  /// the result will include `mightIntroduceDollarIdentifiers`
  /// result kind. If it's performed for a dollar identifier, `LookupName.dollarIdentifier`
  /// with the appropriate identifier will be used in the
  /// result associated with the closure expression inside `a`.
  case mightIntroduceDollarIdentifiers(ClosureExprSyntax)

  /// Associated scope.
  @_spi(Experimental) public var scope: ScopeSyntax {
    switch self {
    case .fromScope(let scopeSyntax, _):
      return scopeSyntax
    case .fromFileScope(let fileScopeSyntax, _):
      return fileScopeSyntax
    case .lookInMembers(let lookInMemb):
      return lookInMemb
    case .lookInGenericParametersOfExtendedType(let extensionDecl):
      return extensionDecl
    case .mightIntroduceDollarIdentifiers(let closureExpr):
      return closureExpr
    }
  }

  /// Names that matched lookup.
  @_spi(Experimental) public var names: [LookupName] {
    switch self {
    case .fromScope(_, let names), .fromFileScope(_, let names):
      return names
    case .lookInMembers(_),
      .lookInGenericParametersOfExtendedType(_),
      .mightIntroduceDollarIdentifiers(_):
      return []
    }
  }

  /// Returns result specific for the particular `scope` kind with provided `names`.
  static func getResult(for scope: ScopeSyntax, withNames names: [LookupName]) -> LookupResult {
    switch Syntax(scope).as(SyntaxEnum.self) {
    case .sourceFile(let sourceFileSyntax):
      return .fromFileScope(sourceFileSyntax, withNames: names)
    default:
      return .fromScope(scope, withNames: names)
    }
  }

  /// Returns result specific for the particular `scope` kind with provided `names`
  /// as an array with one element. If names are empty, returns an empty array.
  static func getResultArray(for scope: ScopeSyntax, withNames names: [LookupName]) -> [LookupResult] {
    guard !names.isEmpty else { return [] }

    return [getResult(for: scope, withNames: names)]
  }

  /// Debug description of this lookup name.
  @_spi(Experimental) public var debugDescription: String {
    var description =
      resultKindDebugName + ": " + scope.scopeDebugDescription

    switch self {
    case .lookInMembers:
      break
    default:
      if !names.isEmpty {
        description += "\n"
      }
    }

    for (index, name) in names.enumerated() {
      if index + 1 == names.count {
        description += "`-" + name.debugDescription
      } else {
        description += "|-" + name.debugDescription + "\n"
      }
    }

    return description
  }

  /// Debug name of this result kind.
  private var resultKindDebugName: String {
    switch self {
    case .fromScope:
      return "fromScope"
    case .fromFileScope:
      return "fromFileScope"
    case .lookInMembers:
      return "lookInMembers"
    case .lookInGenericParametersOfExtendedType(_):
      return "lookInGenericParametersOfExtendedType"
    case .mightIntroduceDollarIdentifiers(_):
      return "mightIntroduceDollarIdentifiers"
    }
  }
}

@_spi(Experimental) extension [LookupResult] {
  /// Debug description this array of lookup results.
  @_spi(Experimental) public var debugDescription: String {
    return self.map(\.debugDescription).joined(separator: "\n")
  }
}
