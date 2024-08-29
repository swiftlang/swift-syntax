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

/// Implementations should provide the definition of the syntax node to be generated.
public protocol SyntaxNodeConvertible: TypeConvertible {
  associatedtype Kind: SyntaxNodeKindProtocol

  /// Whether the syntax node is optional.
  var isOptional: Bool {
    get
  }

  /// The kind of the syntax node.
  var syntaxNodeKind: Kind {
    get
  }

  /// Whether the syntax node is a ``Node``.
  var isNode: Bool {
    get
  }
}

// MARK: TypeConvertible
public extension SyntaxNodeConvertible {
  var syntaxType: TypeSyntax {
    self.syntaxNodeKind.syntaxType
  }

  var protocolType: TypeSyntax {
    self.syntaxNodeKind.protocolType
  }

  var isBaseType: Bool {
    self.syntaxNodeKind.isBaseType
  }

  var isDeprecated: Bool {
    self.syntaxNodeKind.isDeprecated
  }

  func doccLink(content: String) -> String {
    self.syntaxNodeKind.doccLink(content: content)
  }
}

public extension SyntaxNodeConvertible {
  /// Whether the type of the syntax node is a base type and the syntax node is a ``Node``.
  var isBaseNode: Bool {
    self.isNode && self.isBaseType
  }

  /// Assuming that this is a collection type, the non-optional type of the result builder
  /// that can be used to build the collection.
  var resultBuilderType: TypeSyntax {
    precondition(self.isNode, "Non-node cannot be constructed using result builders")
    return "\(raw: self.syntaxNodeKind.nameInProperCase)Builder"
  }

  /// The  type of the syntax node taking into account ``SyntaxNodeConvertible/isOptional``.
  var actualType: TypeSyntax {
    self.isOptional ? self.syntaxType.optionalWrapped : self.syntaxType
  }
}
