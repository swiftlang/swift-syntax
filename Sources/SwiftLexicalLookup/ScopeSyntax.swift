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
  ///
  /// - Returns: An array of names referred to by `for` at this syntax node,
  /// ordered by visibility. The order is from the innermost to the outermost
  /// scope, and within each scope, names are ordered by their introduction
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
  @_spi(Experimental) public func lookup(for name: String) -> [LookupName] {
    scope?.lookup(for: name, at: self) ?? []
  }
}

protocol ScopeSyntax: SyntaxProtocol {
  /// Parent of this scope, or `nil` if it is the root.
  var parentScope: ScopeSyntax? { get }
  /// Names found in this scope. Ordered from first to last introduced.
  var introducedNames: [LookupName] { get }
  /// Finds all declarations `name` refers to. `at` specifies the node lookup was triggered with.
  func lookup(for name: String, at syntax: SyntaxProtocol) -> [LookupName]
}

extension ScopeSyntax {
  var parentScope: ScopeSyntax? {
    self.parent?.scope
  }

  /// Returns all names introduced in this scope that `name` refers to and then
  /// passes lookup to the parent. Optionally, if `positionSensitive` is set to `true`,
  /// the method filters names that were introduced in this scope after `syntax`.
  func defaultLookupImplementation(
    for name: String,
    at syntax: SyntaxProtocol,
    positionSensitive: Bool = false
  ) -> [LookupName] {
    introducedNames
      .filter { introducedName in
        (!positionSensitive || introducedName.isBefore(syntax)) && introducedName.refersTo(name)
      } + (parentScope?.lookup(for: name, at: syntax) ?? [])
  }
}
