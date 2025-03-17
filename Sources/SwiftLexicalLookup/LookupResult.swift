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
public enum LookupResult {
  /// Scope and the names that matched lookup.
  case fromScope(Syntax, withNames: [LookupName])
  /// Indicates where to perform member lookup.
  case lookForMembers(in: Syntax)
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
  /// For a lookup started at the marked position, `lookForGenericParameters`
  /// will be included as one of the results prompting the client
  /// to lookup the generic parameters of of the extended `Foo` type.
  case lookForGenericParameters(of: ExtensionDeclSyntax)
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
  /// the result will include `lookForImplicitClosureParameters`.
  case lookForImplicitClosureParameters(ClosureExprSyntax)

  /// Associated scope.
  public var scope: SyntaxProtocol {
    switch self {
    case .fromScope(let scopeSyntax, _):
      return scopeSyntax
    case .lookForMembers(let lookInMemb):
      return lookInMemb
    case .lookForGenericParameters(let extensionDecl):
      return extensionDecl
    case .lookForImplicitClosureParameters(let closureExpr):
      return closureExpr
    }
  }

  /// Names that matched lookup.
  public var names: [LookupName] {
    switch self {
    case .fromScope(_, let names):
      return names
    case .lookForMembers(_),
      .lookForGenericParameters(_),
      .lookForImplicitClosureParameters(_):
      return []
    }
  }

  /// Returns result specific for the particular `scope` kind with provided `names`
  /// as an array with one element. If names are empty, returns an empty array.
  static func getResultArray(for scope: ScopeSyntax, withNames names: [LookupName]) -> [LookupResult] {
    guard !names.isEmpty else { return [] }

    return [.fromScope(Syntax(scope), withNames: names)]
  }

  /// Debug description of this lookup name.
  public var debugDescription: String {
    var description =
      resultKindDebugName + ": "
      + ((Syntax(scope).asProtocol(SyntaxProtocol.self) as? ScopeSyntax)?.scopeDebugDescription ?? "NOT-A-SCOPE")

    switch self {
    case .lookForMembers:
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
    case .lookForMembers:
      return "lookForMembers"
    case .lookForGenericParameters(_):
      return "lookForGenericParameters"
    case .lookForImplicitClosureParameters(_):
      return "lookForImplicitClosureParameters"
    }
  }
}

extension [LookupResult] {
  /// Debug description this array of lookup results.
  public var debugDescription: String {
    return self.map(\.debugDescription).joined(separator: "\n")
  }
}
