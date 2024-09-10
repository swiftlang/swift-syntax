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

/// Implementations should provide the definition of the syntax type to be generated..
public protocol TypeConvertible {
  /// Whether this is one of the syntax base types.
  var isBaseType: Bool {
    get
  }

  /// The name of this type in the SwiftSyntax module.
  var syntaxType: TypeSyntax {
    get
  }

  /// For base types, the name of the corresponding protocol to which all the
  /// concrete types that have this base type, conform.
  var protocolType: TypeSyntax {
    get
  }

  /// Whether this type is deprecated.
  var isDeprecated: Bool {
    get
  }

  /// If this type is non-experimental and non-deprecated, `content` wrapped in two backticks.
  /// Otherwise, `content` in code font.
  func doccLink(content: String) -> String
}

public extension TypeConvertible {
  /// Convenience version of ``doccLink(content:)`` with `content` set to the syntax type name.
  var doccLink: String {
    self.doccLink(content: "\(self.syntaxType)")
  }
}
