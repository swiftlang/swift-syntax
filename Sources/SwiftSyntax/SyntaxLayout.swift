//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

/// The position of a child in the layout of a syntax node.
@frozen
@usableFromInline
struct SyntaxLayoutIndex: Hashable {
  @usableFromInline
  let value: UInt32

  @_alwaysEmitIntoClient
  init(_ value: UInt32) {
    self.value = value
  }
}

/// A child position in the layout of a particular kind of syntax node.
///
/// ``SyntaxProtocol/propertyInParent`` says which position a node occupies in its parent;
/// compare it with a value from ``SyntaxLayout/subscript(_:)`` to ask whether the node is
/// a specific child:
///
/// ```swift
/// if node.propertyInParent == FunctionDeclSyntax.layout[.name] { ... }
/// ```
public struct AnySyntaxProperty: Hashable {
  /// The kind of the node whose layout this is a position in.
  let syntaxKind: SyntaxKind
  /// The position in that layout.
  let index: SyntaxLayoutIndex

  init(syntaxKind: SyntaxKind, index: SyntaxLayoutIndex) {
    self.syntaxKind = syntaxKind
    self.index = index
  }
}

/// The layout of a syntax node type: the children it has, each at a fixed position.
@frozen
public struct SyntaxLayout<Node: SyntaxProtocol> {
  @usableFromInline
  let syntaxKind: SyntaxKind

  /// Used by the `layout` property of each layout node type, which is the only way to
  /// construct a `SyntaxLayout`.
  @_alwaysEmitIntoClient
  init(syntaxKind: SyntaxKind) {
    self.syntaxKind = syntaxKind
  }
}

/// A child of a syntax node type, typed by the node type and the child's type.
///
/// Each child of each layout node type has a static property, named like the node's
/// property for that child, e.g. `SyntaxProperty<ReturnStmtSyntax, ExprSyntax?>.expression`.
///
/// A `SyntaxProperty` value reads and replaces the child it names:
///
/// ```swift
/// let side: SyntaxProperty<InfixOperatorExprSyntax, ExprSyntax> = .leftOperand
/// let operand = infixExpr[property: side]
/// let replaced = infixExpr.with(side, newOperand)
/// ```
///
/// When the child is known where it is accessed, use the node's property instead, e.g.
/// `infixExpr.leftOperand` and `infixExpr.with(\.leftOperand, newOperand)`.
///
/// ``SyntaxLayout/subscript(_:)`` turns it into the ``AnySyntaxProperty`` it stands for.
@frozen
public struct SyntaxProperty<Node: SyntaxProtocol, Value> {
  @usableFromInline
  let index: SyntaxLayoutIndex

  /// Used by the static property of each child, such as
  /// `SyntaxProperty<ReturnStmtSyntax, ExprSyntax?>.expression`, which are the only way
  /// to construct a `SyntaxProperty`.
  @_alwaysEmitIntoClient
  init(index: UInt32) {
    self.index = SyntaxLayoutIndex(index)
  }
}

extension SyntaxLayout {
  /// The ``AnySyntaxProperty`` of a child of `Node`, to compare with
  /// ``SyntaxProtocol/propertyInParent``:
  ///
  /// ```swift
  /// if node.propertyInParent == FunctionDeclSyntax.layout[.name] { ... }
  /// ```
  public subscript<T>(property: SyntaxProperty<Node, T>) -> AnySyntaxProperty {
    return AnySyntaxProperty(syntaxKind: syntaxKind, index: property.index)
  }
}

extension SyntaxProtocol {
  /// The position this node occupies in its parent's layout, or `nil` if this node is the
  /// root, or an element of a collection.
  public var propertyInParent: AnySyntaxProperty? {
    let syntax = Syntax(self)
    // Reach the parent through the data pointers instead of 'Syntax.parent' so that
    // identifying the property doesn't retain and release the arena.
    guard let parentDataRef = syntax.dataRef.pointee.parent else {
      return nil
    }
    let parentKind = parentDataRef.pointee.raw.kind
    guard parentKind != .token, !parentKind.isSyntaxCollection else {
      return nil
    }
    return AnySyntaxProperty(
      syntaxKind: parentKind,
      index: SyntaxLayoutIndex(syntax.dataRef.pointee.absoluteInfo.layoutIndexInParent)
    )
  }
}

extension SyntaxProtocol {
  /// The child at `property`.
  ///
  /// Returns `nil` if `property` is a position in the layout of another kind of node, and
  /// `.some(nil)` if this node has no child at `property`.
  public subscript(property property: AnySyntaxProperty) -> Syntax?? {
    let syntax = Syntax(self)
    guard property.syntaxKind == syntax.kind else {
      return nil
    }
    return syntax.child(at: Int(property.index.value))
  }

  /// The child at `property`.
  @inlinable
  public subscript<T: SyntaxProtocol>(property property: SyntaxProperty<Self, T>) -> T {
    get {
      return T(Syntax(self).child(at: Int(property.index.value))!)!
    }
    set {
      self = with(property, newValue)
    }
  }

  /// The child at `property`, or `nil` if that child is absent.
  @inlinable
  public subscript<T: SyntaxProtocol>(property property: SyntaxProperty<Self, T?>) -> T? {
    get {
      return Syntax(self).child(at: Int(property.index.value)).map { T($0)! }
    }
    set {
      self = with(property, newValue)
    }
  }

  /// Returns a new syntax node that has the child at `property` replaced by `value`.
  @inlinable
  public func with<T: SyntaxProtocol>(_ property: SyntaxProperty<Self, T>, _ value: T) -> Self {
    return Self(Syntax(self).replacingChild(at: Int(property.index.value), with: Syntax(value)))!
  }

  /// Returns a new syntax node that has the child at `property` replaced by `value`, or
  /// removed if `value` is `nil`.
  @inlinable
  public func with<T: SyntaxProtocol>(_ property: SyntaxProperty<Self, T?>, _ value: T?) -> Self {
    return Self(Syntax(self).replacingChild(at: Int(property.index.value), with: value.map { Syntax($0) }))!
  }
}
