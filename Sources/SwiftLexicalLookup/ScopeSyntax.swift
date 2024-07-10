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

extension SyntaxProtocol {
  /// Returns all names that `for` refers to at this syntax node.
  /// Optional configuration can be passed as `with` to customize the lookup behavior.
  ///
  /// - Returns: An array of `LookupResult` for name `for` at this syntax node,
  /// ordered by visibility. If set to `nil`, returns all available names ordered by visibility.
  /// The order is from the innermost to the outermost scope,
  /// and within each result, names are ordered by their introduction
  /// in the source code.
  ///
  /// Example usage:
  /// ```swift
  /// class C {
  ///   var a = 42
  ///
  ///   func a(a: Int) {
  ///     a // <--- lookup here
  ///
  ///     let a = 0
  ///   }
  ///
  ///   func a() {
  ///     // ...
  ///   }
  /// }
  /// ```
  /// When calling this function on the declaration reference `a` within its name,
  /// the function returns the parameter first, then the identifier of the variable
  /// declaration, followed by the first function name, and then the second function name,
  /// in this exact order. The constant declaration within the function body is omitted
  /// due to the ordering rules that prioritize visibility within the function body.
  @_spi(Experimental) public func lookup(for name: String?, with configArr: [LookupConfig] = []) -> [LookupResult] {
    scope?.lookup(for: name, at: self, with: LookupConfigDictionary(from: configArr)) ?? []
  }
}

@_spi(Experimental) public protocol ScopeSyntax: SyntaxProtocol {
  /// Parent of this scope, or `nil` if it is the root.
  var parentScope: ScopeSyntax? { get }
  /// Names found in this scope. Ordered from first to last introduced.
  var introducedNames: [LookupName] { get }
  /// Finds all declarations `name` refers to. `at` specifies the node lookup was triggered with.
  /// If `name` set to `nil`, returns all available names at the given node.
  func lookup(for name: String?, at syntax: SyntaxProtocol, with configDict: LookupConfigDictionary) -> [LookupResult]
}

@_spi(Experimental) extension ScopeSyntax {
  public var parentScope: ScopeSyntax? {
    self.parent?.scope
  }

  /// Returns `LookupResult` of all names introduced in this scope that `name`
  /// refers to and is accessible at given syntax node then passes lookup to the parent.
  /// If `name` set to `nil`, returns all available names at the given node.
  public func lookup(for name: String?, at syntax: SyntaxProtocol, with configDict: LookupConfigDictionary) -> [LookupResult] {
    defaultLookupImplementation(for: name, at: syntax, with: configDict)
  }

  /// Returns `LookupResult` of all names introduced in this scope that `name`
  /// refers to and is accessible at given syntax node then passes lookup to the parent.
  /// If `name` set to `nil`, returns all available names at the given node.
  func defaultLookupImplementation(
    for name: String?,
    at syntax: SyntaxProtocol,
    with configDict: LookupConfigDictionary
  ) -> [LookupResult] {
    let filteredNames =
      introducedNames
      .filter { introducedName in
        introducedName.isAccessible(at: syntax) && (name == nil || introducedName.refersTo(name!))
      }

    if filteredNames.isEmpty {
      return lookupInParent(for: name, at: syntax, with: configDict)
    } else {
      return [.fromScope(self, withNames: filteredNames)] + lookupInParent(for: name, at: syntax, with: configDict)
    }
  }
  
  /// Looks up in parent scope.
  func lookupInParent(
    for name: String?,
    at syntax: SyntaxProtocol,
    with configDict: LookupConfigDictionary
  ) -> [LookupResult] {
    parentScope?.lookup(for: name, at: syntax, with: configDict) ?? []
  }
}
