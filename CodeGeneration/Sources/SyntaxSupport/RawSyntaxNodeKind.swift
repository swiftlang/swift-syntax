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

public extension SyntaxNodeKind {
  /// A wrapper of ``SyntaxNodeKind`` providing syntax type information for the raw side.
  struct Raw: SyntaxNodeKindProtocol {
    public var nonRaw: SyntaxNodeKind

    public var raw: Self {
      self
    }

    public var isBaseType: Bool {
      self.nonRaw.isBaseType
    }

    public var syntaxType: TypeSyntax {
      "Raw\(self.nonRaw.syntaxType)"
    }

    public var protocolType: TypeSyntax {
      switch self {
      case .syntax, .syntaxCollection:
        return "RawSyntaxNodeProtocol"
      default:
        return "\(self.syntaxType)NodeProtocol"
      }
    }

    public func doccLink(content: String) -> String {
      "`\(content)`"
    }

    public static func ~= (lhs: SyntaxNodeKind, rhs: Self) -> Bool {
      lhs == rhs.nonRaw
    }
  }

  var raw: Raw {
    Raw(nonRaw: self)
  }
}
