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

import SwiftSyntax
import SwiftSyntaxBuilder
import SyntaxSupport
import Utils

let syntaxTraitsFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  for trait in TRAITS {
    try! ProtocolDeclSyntax(
      """
      // MARK: - \(raw: trait.traitName)Syntax

      public protocol \(raw: trait.traitName)Syntax: SyntaxProtocol
      """
    ) {
      for child in trait.children {
        DeclSyntax("var \(raw: child.swiftName): \(raw: child.typeName)\(raw: child.isOptional ? "?" : "") { get set }")
      }
    }

    try! ExtensionDeclSyntax("public extension \(raw: trait.traitName)Syntax") {
      DeclSyntax(
        """
        /// Without this function, the `with` function defined on `SyntaxProtocol`
        /// does not work on existentials of this protocol type.
        @_disfavoredOverload
        func with<T>(_ keyPath: WritableKeyPath<\(raw: trait.traitName)Syntax, T>, _ newChild: T) -> \(raw: trait.traitName)Syntax {
          var copy: \(raw: trait.traitName)Syntax = self
          copy[keyPath: keyPath] = newChild
          return copy
        }
        """
      )
    }

    try! ExtensionDeclSyntax("public extension SyntaxProtocol") {
      DeclSyntax(
        """
        /// Check whether the non-type erased version of this syntax node conforms to
        /// `\(raw: trait.traitName)Syntax`.
        /// Note that this will incur an existential conversion.
        func isProtocol(_: \(raw: trait.traitName)Syntax.Protocol) -> Bool {
          return self.asProtocol(\(raw: trait.traitName)Syntax.self) != nil
        }
        """
      )

      DeclSyntax(
        """
        /// Return the non-type erased version of this syntax node if it conforms to
        /// `\(raw: trait.traitName)Syntax`. Otherwise return `nil`.
        /// Note that this will incur an existential conversion.
        func asProtocol(_: \(raw: trait.traitName)Syntax.Protocol) -> \(raw: trait.traitName)Syntax? {
          return Syntax(self).asProtocol(SyntaxProtocol.self) as? \(raw: trait.traitName)Syntax
        }
        """
      )
    }
  }

  for node in SYNTAX_NODES where !node.isBase && !node.traits.isEmpty {
    DeclSyntax("extension \(raw: node.name): \(raw: node.traits.map { $0 + "Syntax" }.joined(separator: ", ")) {}")
  }
}
