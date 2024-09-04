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

/// Instances of a conforming type should provide syntax type information to be used in code generation.
public protocol TypeConvertible {
  /// Whether this is one of the syntax base nodes.
  var isBase: Bool {
    get
  }

  /// The type name of this node in the SwiftSyntax module.
  var syntaxType: TypeSyntax {
    get
  }

  /// For base nodes, the name of the corresponding protocol to which all the
  /// concrete nodes that have this base kind, conform.
  var protocolType: TypeSyntax {
    get
  }

  /// Whether the node is public API and not underscored/deprecated and can thus be referenced in docc links.
  var isAvailableInDocc: Bool {
    get
  }
}

public extension TypeConvertible {
  /// If this node is non-experimental a docc link wrapped in two backticks.
  ///
  /// For experimental nodes, the node's type name in code font.
  var doccLink: String {
    if self.isAvailableInDocc {
      return "``\(self.syntaxType)``"
    } else {
      return "`\(self.syntaxType)`"
    }
  }
}
