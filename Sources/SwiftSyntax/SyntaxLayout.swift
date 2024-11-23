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

/// Represent an index in a layout.
public struct SyntaxLayoutIndex: Equatable, Comparable {
  let value: UInt32

  @_spi(RawSyntax)
  public init(_ value: UInt32) {
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

/// Protocol for concrete layout syntax nodes.
public protocol _LayoutSyntaxProtocol: SyntaxProtocol {
  static var layout: SyntaxLayout<Self> { get }
}

/// Describes the layout of a `_LayoutSyntaxProtocol` syntax node.
public struct SyntaxLayout<Base: _LayoutSyntaxProtocol> {
  let syntaxKind: SyntaxKind
  let _count: UInt32

  // SyntaxLayout can only be constructed by `_LayoutSyntaxProtocol.layout`
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
public struct ConcreteSyntaxProperty<Base: _LayoutSyntaxProtocol, Value> {
  let index: SyntaxLayoutIndex

  // ConcreteSyntaxProperty can only be constructed by `ConcreteSyntaxProperty<Base, Value>.${name}`
  private init() { fatalError() }
}

extension SyntaxLayout {
  /// Get `AnySyntaxLayoutProperty` from `ConcreteSyntaxProperty` of the `Base` type.
  /// This is convenient for comparing '.propertyInParent'. E.g.
  ///
  ///   if node.propertyInParent == FunctionDeclSyntax.layout[.name] { ... }
  ///
  public subscript<T>(property: ConcreteSyntaxProperty<Base, T>) -> SyntaxLayoutProperty {
    return SyntaxLayoutProperty(syntaxKind: syntaxKind, index: property.index)
  }
}

#if false  // Not needed at this point.
extension SyntaxLayout: Collection {
  public typealias Index = SyntaxLayoutIndex
  public typealias Element = SyntaxLayoutProperty

  public var count: Int { Int(_count) }
  public var startIndex: Index { Index(0) }
  public var endIndex: Index { Index(_count) }
  public func index(after i: Index) -> Index { Index(i.value + 1) }

  public subscript(position: SyntaxLayoutIndex) -> SyntaxLayoutProperty {
    return SyntaxLayoutProperty(syntaxKind: syntaxKind, index: position)
  }
}
#endif

extension SyntaxProtocol {
  /// Return 'SyntaxLayoutProperty' in the parent node, if this node is a child
  /// of a layout node. 'nil' otherwise.
  public var propertyInParent: SyntaxLayoutProperty? {
    return self.withUnownedSyntax { unownedSelf in
      guard
        let parentKind = unownedSelf.parent?.raw.kind,
        parentKind != .token,
        !parentKind.isSyntaxCollection
      else {
        return nil
      }
      return unownedSelf.withValue { guaranteedSelf in
        return SyntaxLayoutProperty(
          syntaxKind: parentKind,
          index: SyntaxLayoutIndex(guaranteedSelf.absoluteInfo.indexInParent)
        )
      }
    }
  }
}

extension SyntaxProtocol {
  /// Get a property value.
  /// The property must be retrieved from the correct 'SyntaxLayout'
  public subscript(property: SyntaxLayoutProperty) -> Syntax? {
    precondition(property.syntaxKind == Syntax(self).kind)
    return Syntax(self).child(at: Int(property.index.value))
  }

  /// Get a property value.
  public subscript<T: SyntaxProtocol>(property: ConcreteSyntaxProperty<Self, T>) -> T {
    return Syntax(self).child(at: Int(property.index.value))!.cast(T.self)
  }
  public subscript<T: SyntaxProtocol>(property: ConcreteSyntaxProperty<Self, T?>) -> T? {
    return Syntax(self).child(at: Int(property.index.value))?.cast(T.self)
  }

  /// Returns a new syntax node that has the child at `property` replaced by `value`.
  public func with<T: SyntaxProtocol>(_ property: ConcreteSyntaxProperty<Self, T>, _ value: T) -> Self {
    Syntax(self)
      .replacingChild(at: Int(property.index.value), with: Syntax(value), arena: SyntaxArena())
      .cast(Self.self)
  }
  public func with<T: SyntaxProtocol>(_ property: ConcreteSyntaxProperty<Self, T?>, _ value: T?) -> Self {
    Syntax(self)
      .replacingChild(at: Int(property.index.value), with: Syntax(value), arena: SyntaxArena())
      .cast(Self.self)
  }
}
