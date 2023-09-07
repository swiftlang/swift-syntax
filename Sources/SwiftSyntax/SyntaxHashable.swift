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

/// Protocol that provides a common Hashable implementation for all syntax nodes
public protocol SyntaxHashable: Hashable {
  var _syntaxNode: Syntax { get }
}

public extension SyntaxHashable {
  func hash(into hasher: inout Hasher) {
    return _syntaxNode.id.hash(into: &hasher)
  }

  static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs._syntaxNode.id == rhs._syntaxNode.id
  }
}
