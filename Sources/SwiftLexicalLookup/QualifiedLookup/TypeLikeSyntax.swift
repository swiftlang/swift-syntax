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

import SwiftSyntax

/// A protocol for ``TypeLikeSyntax`` nodes.
@_spi(_QualifiedLookup) public protocol TypeLikeSyntaxProtocol: SyntaxProtocol {}

@_spi(_QualifiedLookup) extension TypeSyntax: TypeLikeSyntaxProtocol {}
@_spi(_QualifiedLookup) extension NominalTypeDeclSyntax: TypeLikeSyntaxProtocol {}

/// Either ``TypeSyntax`` or a nominal type. Helps us track which syntax is
/// responsible for a given type-resolution request.
///
/// E.g. In `let a: Int.MyType`, `MyType` is a source-derived reference. However,
/// we can also have:
///   struct A {
///     struct B {
///       struct C {
///         func f(_: C) // <- Look up here
///       }
///     }
///   }
/// In this case, we look inside "A.B" to find `C`, so we implicitly generate the
/// components `A` and `B`.
@_spi(_QualifiedLookup) public struct TypeLikeSyntax: Sendable, SyntaxHashable, TypeLikeSyntaxProtocol {
  public private(set) var _syntaxNode: Syntax

  public init?(_ node: __shared some SyntaxProtocol) {
    guard node.is(TypeSyntax.self) || node.is(NominalTypeDeclSyntax.self) else { return nil }
    _syntaxNode = Syntax(node)
  }

  public init(_ typeLikeSyntax: some TypeLikeSyntaxProtocol) {
    self._syntaxNode = typeLikeSyntax._syntaxNode
  }

  // TODO: Are we allowed to have non-primitive node types??
  public static let structure = SyntaxNodeStructure.choices([
    SyntaxNodeStructure.SyntaxChoice.node(TypeSyntax.self),
    SyntaxNodeStructure.SyntaxChoice.node(NominalTypeDeclSyntax.self),
  ])
}

extension Attached where Node == TypeLikeSyntax {
  internal init<S: TypeLikeSyntaxProtocol>(_ concrete: Attached<S>) {
    // Cast should succeed because we can initialize `TypeLikeSyntax` with
    // a `TypeLikeSyntaxProtocol`-conforming type.
    self = concrete.as(TypeLikeSyntax.self)!
  }
}
