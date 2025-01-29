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

/// Protocol for concrete layout syntax nodes.
public protocol _LayoutSyntaxNodeProtocol: _LeafSyntaxNodeProtocol {}

extension _LayoutSyntaxNodeProtocol {
  /// A type metadata describing the layout of the this syntax type.
  public static var layout: SyntaxLayout<Self>.Type {
    SyntaxLayout<Self>.self
  }
}

/// Represent an index in a layout.
public struct SyntaxLayoutIndex: Equatable, Comparable {
  let value: Int

  @_spi(RawSyntax)
  public init(_ value: Int) {
    self.value = value
  }

  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.value == rhs.value
  }

  public static func < (lhs: Self, rhs: Self) -> Bool {
    lhs.value < rhs.value
  }
}

/// Represent a property in a layout syntax.
public struct SyntaxLayoutProperty: Equatable {
  /// 'SyntaxKind' of the parent layout node.
  let syntaxKind: SyntaxKind
  /// Index in the parent node layout.
  let index: SyntaxLayoutIndex

  @_spi(RawSyntax)
  public init(syntaxKind: SyntaxKind, index: SyntaxLayoutIndex) {
    self.syntaxKind = syntaxKind
    self.index = index
  }

  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.syntaxKind == rhs.syntaxKind && lhs.index == rhs.index
  }
}

/// A type describing the layout of a `_LayoutSyntaxProtocol` syntax node.
public struct SyntaxLayout<Base: _LayoutSyntaxNodeProtocol> {
  // 'SyntaxLayout' is a metadata only type (at this point)
  private init() { fatalError() }
}

/// Represent a typed property in a layout syntax.
///
/// Specialized types have static properties to instantiate this type. E.g.:
///
///   let exprProperty: ConcreteSyntaxProperty<ReturnStmtSyntax, ExprSyntax?> = .expression
///
/// The property can be used similar to 'KeyPath'.
///
///   let expr/*: ExprSyntax?*/ = returnStmt[property: exprProperty]
///   let newReturnStmt = returnStmt.with(.expression, expr)
///
public struct ConcreteSyntaxProperty<Base: _LayoutSyntaxNodeProtocol, Value> {
  let index: SyntaxLayoutIndex

  // ConcreteSyntaxProperty can only be constructed by `ConcreteSyntaxProperty<Base, Value>.${name}`
  private init() { fatalError() }
}

extension SyntaxLayout {
  /// Get ``SyntaxLayoutProperty`` from ``ConcreteSyntaxProperty`` of the `Base` type.
  /// This is convenient for comparing with '.propertyInParent'. E.g.
  ///
  ///   // Check if 'node' is a 'FunctionDeclSyntax.name'.
  ///   if node.propertyInParent == FunctionDeclSyntax.layout[.name] { ... }
  ///
  public static subscript<T>(property: ConcreteSyntaxProperty<Base, T>) -> SyntaxLayoutProperty {
    return SyntaxLayoutProperty(syntaxKind: Base.syntaxKind, index: property.index)
  }
}

extension Syntax {
  /// Implementation of `SyntaxProtocol.propertyInParent`
  var propertyInParent: SyntaxLayoutProperty? {
    guard let parentKind = data.parent?.pointee.raw.kind, parentKind.isLayout else {
      return nil
    }
    return SyntaxLayoutProperty(
      syntaxKind: parentKind,
      index: SyntaxLayoutIndex(Int(absoluteInfo.layoutIndexInParent))
    )
  }
}

extension SyntaxProtocol {
  /// Return 'SyntaxLayoutProperty' in the parent node, if this node is a child
  /// of a layout node. 'nil' otherwise.
  @inline(__always)
  public var propertyInParent: SyntaxLayoutProperty? {
    self._syntaxNode.propertyInParent
  }

  /// Get a property value.
  /// The property must be retrieved from the correct 'SyntaxLayout'
  public subscript(property: SyntaxLayoutProperty) -> Syntax? {
    precondition(property.syntaxKind == self.kind)
    return self._syntaxNode.child(at: Int(property.index.value))
  }
}

extension _LayoutSyntaxNodeProtocol {
  /// A property value.
  public subscript<T: SyntaxProtocol>(property: ConcreteSyntaxProperty<Self, T>) -> T {
    get {
      self._syntaxNode.child(at: Int(property.index.value))!.cast(T.self)
    }
    set {
      self = self.with(property, newValue)
    }
  }

  /// A property value.
  public subscript<T: SyntaxProtocol>(property: ConcreteSyntaxProperty<Self, T?>) -> T? {
    get {
      self._syntaxNode.child(at: Int(property.index.value))?.cast(T.self)
    }
    set {
      self = self.with(property, newValue)
    }
  }

  /// Returns a new syntax node that has the `property` replaced by `value`.
  public func with<T: SyntaxProtocol>(_ property: ConcreteSyntaxProperty<Self, T>, _ value: T) -> Self {
    self._syntaxNode
      .replacingChild(at: Int(property.index.value), with: Syntax(value), arena: SyntaxArena())
      .cast(Self.self)
  }

  /// Returns a new syntax node that has the `property` replaced by `value`.
  public func with<T: SyntaxProtocol>(_ property: ConcreteSyntaxProperty<Self, T?>, _ value: T?) -> Self {
    self._syntaxNode
      .replacingChild(at: Int(property.index.value), with: Syntax(value), arena: SyntaxArena())
      .cast(Self.self)
  }
}
