//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
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

let syntaxTraitsFile = SourceFileSyntax {
  for trait in TRAITS {
    ProtocolDeclSyntax("""
      // MARK: - \(trait.traitName)Syntax
      
      public protocol \(trait.traitName)Syntax: SyntaxProtocol
      """) {
      
      for child in trait.children {
        VariableDeclSyntax("var \(raw: child.swiftName): \(raw: child.typeName)\(raw: child.isOptional ? "?" : "") { get }")
        FunctionDeclSyntax("func with\(raw: child.name)(_ newChild: \(raw: child.typeName)\(raw: child.isOptional ? "?" : "")) -> Self")
      }
    }
    
    ExtensionDeclSyntax("public extension SyntaxProtocol") {
      FunctionDeclSyntax("""
        /// Check whether the non-type erased version of this syntax node conforms to
        /// `\(raw: trait.traitName)Syntax`.
        /// Note that this will incur an existential conversion.
        func isProtocol(_: \(raw: trait.traitName)Syntax.Protocol) -> Bool {
          return self.asProtocol(\(raw: trait.traitName)Syntax.self) != nil
        }
        """)
      
      FunctionDeclSyntax("""
        /// Return the non-type erased version of this syntax node if it conforms to
        /// `\(raw: trait.traitName)Syntax`. Otherwise return `nil`.
        /// Note that this will incur an existential conversion.
        func asProtocol(_: \(raw: trait.traitName)Syntax.Protocol) -> \(raw: trait.traitName)Syntax? {
          return Syntax(self).asProtocol(SyntaxProtocol.self) as? \(raw: trait.traitName)Syntax
        }
        """)
    }
  }
  
  for node in SYNTAX_NODES where !node.isBase && !node.traits.isEmpty {
    ExtensionDeclSyntax("extension \(raw: node.name): \(raw: node.traits.map { $0 + "Syntax" }.joined(separator: ", ")) {}")
  }
}
