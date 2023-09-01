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

/// A Syntax node represents a tree of nodes with tokens at the leaves.
/// Each node has accessors for its known children, and allows efficient
/// iteration over the children through its `children` property.
public struct Syntax: SyntaxProtocol, SyntaxHashable {
  let data: SyntaxData

  /// Needed for the conformance to ``SyntaxProtocol``.
  ///
  /// Needed for the conformance to ``SyntaxProtocol``. Just returns `self`.
  public var _syntaxNode: Syntax {
    return self
  }

  init(_ data: SyntaxData) {
    self.data = data
  }

  @_spi(RawSyntax)
  public init(raw: RawSyntax, rawNodeArena: __shared SyntaxArena) {
    self.init(.forRoot(raw, rawNodeArena: rawNodeArena))
  }

  /// Create a ``Syntax`` node from a specialized syntax node.
  public init(_ syntax: some SyntaxProtocol) {
    self = syntax._syntaxNode
  }

  /// Creates a new ``Syntax`` node from any node that conforms to ``SyntaxProtocol``.
  public init(fromProtocol syntax: SyntaxProtocol) {
    self = syntax._syntaxNode
  }

  /// Same as ``init(fromProtocol:)`` but returns `nil` if `syntax` is `nil`.
  public init?(fromProtocol syntax: SyntaxProtocol?) {
    guard let syntax = syntax else { return nil }
    self = syntax._syntaxNode
  }

  /// Syntax nodes always conform to SyntaxProtocol. This API is just added
  /// for consistency.
  /// Note that this will incur an existential conversion.
  @available(*, deprecated, message: "Expression always evaluates to true")
  public func isProtocol(_: SyntaxProtocol.Protocol) -> Bool {
    return true
  }

  /// Return the non-type erased version of this syntax node.
  /// Note that this will incur an existential conversion.
  public func asProtocol(_: SyntaxProtocol.Protocol) -> SyntaxProtocol {
    return self.raw.kind.syntaxNodeType.init(self)!
  }

  /// Add the hash value of this node’s ID to `hasher`.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }

  /// Returns `true` if `rhs` and `lhs` have the same ID.
  ///
  /// Note `lhs` and `rhs` might have the same contents even if their IDs are
  /// different. See documentation on ``SyntaxIdentifier``.
  public static func == (lhs: Syntax, rhs: Syntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }
}

extension Syntax: Identifiable {
  /// ``SyntaxIdentifier`` uniquely identifies a node.
  public typealias ID = SyntaxIdentifier
}

extension Syntax {
  /// Enumerate all of the syntax text present in this node, and all
  /// of its children, to give a source-accurate view of the bytes.
  ///
  /// Unlike `description`, this provides a source-accurate representation
  /// even in the presence of malformed UTF-8 in the input source.
  ///
  /// The ``SyntaxText`` arguments passed to the visitor are only guaranteed
  /// to be valid within that call. It is unsafe to escape the `SyntaxValue`
  /// values outside of the closure.
  @_spi(RawSyntax)
  public func withEachSyntaxText(body: (SyntaxText) throws -> Void) rethrows {
    try raw.withEachSyntaxText(body: body)
  }

  /// Retrieve the syntax text as an array of bytes that models the input
  /// source even in the presence of invalid UTF-8.
  public var syntaxTextBytes: [UInt8] {
    return raw.syntaxTextBytes
  }
}
