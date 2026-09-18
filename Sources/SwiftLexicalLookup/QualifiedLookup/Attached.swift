//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftIfConfig
import SwiftSyntax

/// A syntax node attached to a file, i.e., whose `root` is a `SourceFileSyntax`.
///
/// Useful for carefully admitting syntax into the symbol table and looking
/// up a file's module.
@_spi(_QualifiedLookupTests) public struct Attached<Node: SyntaxProtocol> {
  /// Invariant: Must always be a node whose `root` is a `SourceFileSyntax`
  @_spi(_QualifiedLookupTests) public private(set) var node: Node

  private init(_unchecked: __shared Node) { self.node = _unchecked }
  private init?(_checked node: __shared some SyntaxProtocol) {
    // Root must be source file
    guard node._syntaxNode.root.is(SourceFileSyntax.self) else { return nil }

    guard let node = Node(node) else { return nil }
    self.init(_unchecked: node)
  }

  public var fileRoot: SourceFileSyntax {
    // By `_syntaxNode` invariant
    node.root.cast(SourceFileSyntax.self)
  }
}

// MARK: Casting

extension Attached {
  @_spi(_QualifiedLookupTests) public init?(_ node: __shared Node) {
    self.init(_checked: node)
  }

  @_spi(_QualifiedLookupTests) public var parent: Attached<Syntax>? {
    // Unchecked is fine since our parent must also be a child of the file root.
    node.parent.map({ Attached<Syntax>(_unchecked: $0) })
  }

  @_spi(_QualifiedLookupTests) public func `as`<S: SyntaxProtocol>(_ syntaxType: S.Type) -> Attached<S>? {
    // We force unwrap in case an implementation of `SyntaxProtocol/init` messed up.
    // However, casting should just change the type and not the root.
    node.as(syntaxType).map({ Attached<S>($0)! })
  }

  @_spi(_QualifiedLookupTests) public func `is`<S: SyntaxProtocol>(_ syntaxType: S.Type) -> Bool {
    node.is(syntaxType)
  }
}

// MARK: Convenience

extension Attached {
  internal var kind: SyntaxKind {
    node.kind
  }

  internal var trimmedDescription: String {
    node.trimmedDescription
  }

  internal var position: AbsolutePosition {
    node.position
  }

  /// The `statements` property of `fileRoot`.
  var fileRootStatements: Attached<CodeBlockItemListSyntax> {
    Attached<CodeBlockItemListSyntax>(fileRoot.statements)!
  }
}

extension Attached where Node == ExtensionDeclSyntax {
  internal var extendedType: Attached<TypeSyntax> {
    // Extended type should be a child
    Attached<TypeSyntax>(node.extendedType)!
  }
}
extension Attached where Node == TypeAliasDeclSyntax {
  internal var initializerValue: Attached<TypeSyntax> {
    // Initializer value should be a child
    Attached<TypeSyntax>(node.initializer.value)!
  }
}

extension Attached: Sendable where Node: Sendable {}
extension Attached: Equatable where Node: Equatable {}
extension Attached: Hashable where Node: Hashable {}

// MARK: Debug

@_spi(_QualifiedLookupTests)
extension Attached: CustomDebugStringConvertible {
  public var debugDescription: String {
    node.trimmedDescription
  }
}
