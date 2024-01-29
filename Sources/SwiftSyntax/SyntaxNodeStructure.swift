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

/// Describes the statically allowed structure of a syntax tree node.
public enum SyntaxNodeStructure: Sendable {
  public enum SyntaxChoice: Sendable {
    case node(SyntaxProtocol.Type)
    case token(TokenKind)
  }

  /// The node contains a fixed number of children which can be accessed by these key paths.
  case layout([AnyKeyPath & Sendable])

  /// The node is a `SyntaxCollection` of the given type.
  case collection(SyntaxProtocol.Type)

  /// The node can contain a single node with one of the listed types.
  case choices([SyntaxChoice])

  /// Convenience property that’s `true` if `self` is the `layout` case.
  public var isLayout: Bool {
    switch self {
    case .layout: return true
    default: return false
    }
  }

  /// Convenience property that’s `true` if `self` is the `collection` case.
  public var isCollection: Bool {
    switch self {
    case .collection: return true
    default: return false
    }
  }

  /// Convenience property that’s `true` if `self` is the `choices` case.
  public var isChoices: Bool {
    switch self {
    case .choices: return true
    default: return false
    }
  }
}
