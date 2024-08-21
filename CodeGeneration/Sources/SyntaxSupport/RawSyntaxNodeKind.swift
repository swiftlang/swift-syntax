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

/// A wrapper of ``SyntaxNodeKind`` providing syntax type information for the raw side.
public struct RawSyntaxNodeKind: TypeConvertible {
  public var syntaxNodeKind: SyntaxNodeKind

  public var isBase: Bool {
    self.syntaxNodeKind.isBase
  }

  public var syntaxType: TypeSyntax {
    "Raw\(self.syntaxNodeKind.syntaxType)"
  }

  public var protocolType: TypeSyntax {
    switch self {
    case .syntax, .syntaxCollection:
      return "RawSyntaxNodeProtocol"
    default:
      return "\(self.syntaxType)NodeProtocol"
    }
  }

  public var isAvailableInDocc: Bool {
    false
  }

  public static func ~= (lhs: SyntaxNodeKind, rhs: Self) -> Bool {
    lhs == rhs.syntaxNodeKind
  }
}
