//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

/// The position of a child in the layout of a syntax node.
struct SyntaxLayoutIndex: Hashable, Comparable {
  let value: UInt32

  init(_ value: UInt32) {
    self.value = value
  }

  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.value == rhs.value
  }

  public static func < (lhs: Self, rhs: Self) -> Bool {
    lhs.value < rhs.value
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(value)
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
public struct SyntaxLayoutProperty: Hashable {
  /// The kind of the node whose layout this is a position in.
  let syntaxKind: SyntaxKind
  /// The position in that layout.
  let index: SyntaxLayoutIndex

  init(syntaxKind: SyntaxKind, index: SyntaxLayoutIndex) {
    self.syntaxKind = syntaxKind
    self.index = index
  }

  @_spi(RawSyntax)
  public init(syntaxKind: SyntaxKind, index: UInt32) {
    self.init(syntaxKind: syntaxKind, index: SyntaxLayoutIndex(index))
  }
}

/// The layout of a syntax node type: the children it has, each at a fixed position.
public struct SyntaxLayout<Base: SyntaxProtocol> {
  let syntaxKind: SyntaxKind

  // A `SyntaxLayout` is only constructed by the `layout` property of each layout node type.
  private init() { fatalError() }
}

/// A child of a syntax node type, typed by the node type and the child's type.
///
/// Each child of each layout node type is a static property, named like the node's
/// property for that child:
///
/// ```swift
/// let exprProperty: ConcreteSyntaxProperty<ReturnStmtSyntax, ExprSyntax?> = .expression
/// ```
///
/// It reads and replaces the child much as a key path to the node's property would:
///
/// ```swift
/// let expr = returnStmt[exprProperty]  // ExprSyntax?
/// let newReturnStmt = returnStmt.with(.expression, expr)
/// ```
///
/// ``SyntaxLayout/subscript(_:)`` turns it into the ``SyntaxLayoutProperty`` it stands for.
public struct ConcreteSyntaxProperty<Base: SyntaxProtocol, Value> {
  let index: SyntaxLayoutIndex

  // ConcreteSyntaxProperty can only be constructed by `ConcreteSyntaxProperty<Base, Value>.${name}`
  private init() { fatalError() }
}

extension SyntaxLayout {
  /// The ``SyntaxLayoutProperty`` of a child of `Base`, to compare with
  /// ``SyntaxProtocol/propertyInParent``:
  ///
  /// ```swift
  /// if node.propertyInParent == FunctionDeclSyntax.layout[.name] { ... }
  /// ```
  public subscript<T>(property: ConcreteSyntaxProperty<Base, T>) -> SyntaxLayoutProperty {
    return SyntaxLayoutProperty(syntaxKind: syntaxKind, index: property.index)
  }
}

extension SyntaxProtocol {
  /// The position this node occupies in its parent's layout, or `nil` if this node is the
  /// root, or an element of a collection.
  public var propertyInParent: SyntaxLayoutProperty? {
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
    return SyntaxLayoutProperty(
      syntaxKind: parentKind,
      index: SyntaxLayoutIndex(syntax.dataRef.pointee.absoluteInfo.layoutIndexInParent)
    )
  }
}

extension SyntaxProtocol {
  /// The child at `property`, or `nil` if that child is absent or `property` is a position
  /// in the layout of another kind of node.
  public subscript(property: SyntaxLayoutProperty) -> Syntax? {
    let syntax = Syntax(self)
    guard property.syntaxKind == syntax.kind else {
      return nil
    }
    return syntax.child(at: Int(property.index.value))
  }

  /// The child at `property`.
  public subscript<T: SyntaxProtocol>(property: ConcreteSyntaxProperty<Self, T>) -> T {
    return Syntax(self).child(at: Int(property.index.value))!.cast(T.self)
  }

  /// The child at `property`, or `nil` if that child is absent.
  public subscript<T: SyntaxProtocol>(property: ConcreteSyntaxProperty<Self, T?>) -> T? {
    return Syntax(self).child(at: Int(property.index.value))?.cast(T.self)
  }

  /// Returns a new syntax node that has the child at `property` replaced by `value`.
  public func with<T: SyntaxProtocol>(_ property: ConcreteSyntaxProperty<Self, T>, _ value: T) -> Self {
    Syntax(self)
      .replacingChild(at: Int(property.index.value), with: Syntax(value), rawAllocationArena: RawSyntaxArena())
      .cast(Self.self)
  }

  /// Returns a new syntax node that has the child at `property` replaced by `value`, or
  /// removed if `value` is `nil`.
  public func with<T: SyntaxProtocol>(_ property: ConcreteSyntaxProperty<Self, T?>, _ value: T?) -> Self {
    Syntax(self)
      .replacingChild(at: Int(property.index.value), with: Syntax(value), rawAllocationArena: RawSyntaxArena())
      .cast(Self.self)
  }
}
