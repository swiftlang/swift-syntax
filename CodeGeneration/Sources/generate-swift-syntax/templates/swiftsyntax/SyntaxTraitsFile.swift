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
      // MARK: - \(trait.protocolName)

      \(trait.documentation)\
      public protocol \(trait.protocolName): SyntaxProtocol\(raw:
        trait.baseKind == nil ? "" : ", \(trait.baseKind!.protocolType)"
      )
      """
    ) {
      for child in trait.children {
        let questionMark = child.isOptional ? "?" : ""

        DeclSyntax(
          """
          \(child.documentation)\
          \(child.apiAttributes)var \(child.varOrCaseName): \(child.syntaxNodeKind.syntaxType)\(raw: questionMark) { get set }
          """
        )
      }
    }

    try! ExtensionDeclSyntax("extension \(trait.protocolName)") {
      DeclSyntax(
        """
        /// Without this function, the `with` function defined on `SyntaxProtocol`
        /// does not work on existentials of this protocol type.
        @_disfavoredOverload
        public func with<T>(_ keyPath: WritableKeyPath<\(trait.protocolName), T>, _ newChild: T) -> \(trait.protocolName) {
          var copy: \(trait.protocolName) = self
          copy[keyPath: keyPath] = newChild
          return copy
        }
        """
      )
    }

    try! ExtensionDeclSyntax("extension SyntaxProtocol") {
      DeclSyntax(
        """
        /// Check whether the non-type erased version of this syntax node conforms to
        /// `\(trait.protocolName)`.
        /// Note that this will incur an existential conversion.
        public func isProtocol(_: \(trait.protocolName).Protocol) -> Bool {
          return self.asProtocol(\(trait.protocolName).self) != nil
        }
        """
      )

      DeclSyntax(
        """
        /// Return the non-type erased version of this syntax node if it conforms to
        /// `\(trait.protocolName)`. Otherwise return `nil`.
        /// Note that this will incur an existential conversion.
        public func asProtocol(_: \(trait.protocolName).Protocol) -> \(trait.protocolName)? {
          return Syntax(self).asProtocol(SyntaxProtocol.self) as? \(trait.protocolName)
        }
        """
      )
    }
  }

  for node in SYNTAX_NODES.compactMap(\.layoutNode) where !node.traits.isEmpty {
    DeclSyntax(
      "extension \(node.kind.syntaxType): \(raw: node.traits.map { $0 + "Syntax" }.joined(separator: ", ")) {}"
    )
  }
}
