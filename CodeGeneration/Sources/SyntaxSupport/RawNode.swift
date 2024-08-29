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

public extension Node {
  /// The raw representation of ``Node``.  The definition of a syntax node that, when generated, conforms to
  /// `RawSyntaxNodeProtocol`.
  struct Raw: SyntaxNodeConvertible, NodeChoiceConvertible {
    var node: Node

    public var isOptional: Bool {
      self.node.isOptional
    }

    public var syntaxNodeKind: SyntaxNodeKind.Raw {
      self.node.syntaxNodeKind.raw
    }

    public var isNode: Bool {
      self.node.isNode
    }

    public var documentation: SwiftSyntax.Trivia {
      self.node.documentation
    }

    public var experimentalFeature: ExperimentalFeature? {
      self.node.experimentalFeature
    }

    public var apiAttributes: AttributeListSyntax {
      self.node.apiAttributes
    }

    public var identifier: TokenSyntax {
      self.node.identifier
    }
  }

  /// The raw representation of this node.
  var raw: Raw {
    Raw(node: self)
  }
}
