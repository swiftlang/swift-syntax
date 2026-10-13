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

@_spi(RawSyntax) internal import SwiftSyntax

/// All typed raw syntax nodes conform to this protocol.
/// `RawXXXSyntax` is a typed wrapper of ``RawSyntax``.
protocol RawSyntaxNodeProtocol: Sendable {
  /// Returns `true` if `raw` can be cast to this concrete raw syntax type.
  static func isKindOf(_ raw: RawSyntax) -> Bool

  /// Type erased raw syntax.
  var raw: RawSyntax { get }

  /// Create the typed raw syntax if `other` can be cast to `Self`
  init?(_ other: some RawSyntaxNodeProtocol)
}

extension RawSyntaxNodeProtocol {
  /// Cast to the specified raw syntax type if possible.
  func `as`<Node: RawSyntaxNodeProtocol>(_: Node.Type) -> Node? {
    Node(self)
  }

  /// Check if this instance can be cast to the specified syntax type.
  func `is`<Node: RawSyntaxNodeProtocol>(_: Node.Type) -> Bool {
    Node.isKindOf(self.raw)
  }

  func cast<S: RawSyntaxNodeProtocol>(_ syntaxType: S.Type) -> S {
    return self.as(S.self)!
  }

  var isEmpty: Bool {
    return raw.byteLength == 0
  }

  /// Whether the tree contained by this layout has any
  ///  - missing nodes or
  ///  - unexpected nodes or
  ///  - tokens with a ``TokenDiagnostic`` of severity `error`
  var hasError: Bool {
    return raw.hasError
  }
}

/// ``RawSyntax`` itself conforms to `RawSyntaxNodeProtocol`.
extension RawSyntax: RawSyntaxNodeProtocol {
  static func isKindOf(_ raw: RawSyntax) -> Bool {
    return true
  }

  var raw: RawSyntax { self }

  init(raw: RawSyntax) {
    self = raw
  }

  init(_ other: some RawSyntaxNodeProtocol) {
    self = other.raw
  }
}

extension RawTokenSyntax: RawSyntaxNodeProtocol {
  init?(_ other: some RawSyntaxNodeProtocol) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(unchecked: other.raw)
  }
}

extension RawUnexpectedNodesSyntax {
  /// Construct a ``RawUnexpectedNodesSyntax``with the given `elements`.
  ///
  /// If `isMaximumNestingLevelOverflow` is `true`, the node has the
  /// `isMaximumNestingLevelOverflow` error bit set, indicating that the parser
  /// overflowed its maximum nesting level and thus aborted parsing.
  init(elements: [RawSyntax], isMaximumNestingLevelOverflow: Bool, arena: __shared RawSyntaxArena) {
    let raw = RawSyntax.makeCollection(
      kind: .unexpectedNodes,
      count: elements.count,
      isMaximumNestingLevelOverflow: isMaximumNestingLevelOverflow,
      arena: arena
    ) { layout in
      for (index, element) in elements.enumerated() {
        layout.initializeElement(at: index, to: element)
      }
    }
    self.init(raw: raw)
  }
}
