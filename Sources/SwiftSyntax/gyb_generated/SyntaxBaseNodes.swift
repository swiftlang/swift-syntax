//// Automatically Generated From SyntaxNodes.swift.gyb.
//// Do Not Edit Directly!
//===---------- SyntaxBaseNodes.swift - Syntax Node definitions -----------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//


// MARK: - DeclSyntax

/// Protocol to which all `DeclSyntax` nodes conform. Extension point to add
/// common methods to all `DeclSyntax` nodes.
/// DO NOT CONFORM TO THIS PROTOCOL YOURSELF!
public protocol DeclSyntaxProtocol: SyntaxProtocol {}

public extension Syntax {
  /// Check whether the non-type erased version of this syntax node conforms to
  /// DeclSyntaxProtocol.
  /// Note that this will incur an existential conversion.
  func isProtocol(_: DeclSyntaxProtocol.Protocol) -> Bool {
    return self.asProtocol(DeclSyntaxProtocol.self) != nil
  }

  /// Return the non-type erased version of this syntax node if it conforms to
  /// DeclSyntaxProtocol. Otherwise return nil.
  /// Note that this will incur an existential conversion.
  func asProtocol(_: DeclSyntaxProtocol.Protocol) -> DeclSyntaxProtocol? {
    return self.asProtocol(SyntaxProtocol.self) as? DeclSyntaxProtocol
  }
}


public struct DeclSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawDeclSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Initialize `DeclSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  /// Checked cast `other` to `DeclSyntax` if possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Create a `DeclSyntax` node from a specialized syntax node.
  public init<Node: DeclSyntaxProtocol>(_ other: Node) {
    // We know T is valid for this protocol.
    self.init(data: other.data)
  }
}

extension DeclSyntax: CustomReflectable {
  /// Reconstructs the real syntax type for this type from the node's kind and
  /// provides a mirror that reflects this type.
  public var customMirror: Mirror {
    return Mirror(reflecting: Syntax(self).asProtocol(SyntaxProtocol.self))
  }
}


// MARK: - ExprSyntax

/// Protocol to which all `ExprSyntax` nodes conform. Extension point to add
/// common methods to all `ExprSyntax` nodes.
/// DO NOT CONFORM TO THIS PROTOCOL YOURSELF!
public protocol ExprSyntaxProtocol: SyntaxProtocol {}

public extension Syntax {
  /// Check whether the non-type erased version of this syntax node conforms to
  /// ExprSyntaxProtocol.
  /// Note that this will incur an existential conversion.
  func isProtocol(_: ExprSyntaxProtocol.Protocol) -> Bool {
    return self.asProtocol(ExprSyntaxProtocol.self) != nil
  }

  /// Return the non-type erased version of this syntax node if it conforms to
  /// ExprSyntaxProtocol. Otherwise return nil.
  /// Note that this will incur an existential conversion.
  func asProtocol(_: ExprSyntaxProtocol.Protocol) -> ExprSyntaxProtocol? {
    return self.asProtocol(SyntaxProtocol.self) as? ExprSyntaxProtocol
  }
}


public struct ExprSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Initialize `ExprSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  /// Checked cast `other` to `ExprSyntax` if possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Create a `ExprSyntax` node from a specialized syntax node.
  public init<Node: ExprSyntaxProtocol>(_ other: Node) {
    // We know T is valid for this protocol.
    self.init(data: other.data)
  }
}

extension ExprSyntax: CustomReflectable {
  /// Reconstructs the real syntax type for this type from the node's kind and
  /// provides a mirror that reflects this type.
  public var customMirror: Mirror {
    return Mirror(reflecting: Syntax(self).asProtocol(SyntaxProtocol.self))
  }
}


// MARK: - StmtSyntax

/// Protocol to which all `StmtSyntax` nodes conform. Extension point to add
/// common methods to all `StmtSyntax` nodes.
/// DO NOT CONFORM TO THIS PROTOCOL YOURSELF!
public protocol StmtSyntaxProtocol: SyntaxProtocol {}

public extension Syntax {
  /// Check whether the non-type erased version of this syntax node conforms to
  /// StmtSyntaxProtocol.
  /// Note that this will incur an existential conversion.
  func isProtocol(_: StmtSyntaxProtocol.Protocol) -> Bool {
    return self.asProtocol(StmtSyntaxProtocol.self) != nil
  }

  /// Return the non-type erased version of this syntax node if it conforms to
  /// StmtSyntaxProtocol. Otherwise return nil.
  /// Note that this will incur an existential conversion.
  func asProtocol(_: StmtSyntaxProtocol.Protocol) -> StmtSyntaxProtocol? {
    return self.asProtocol(SyntaxProtocol.self) as? StmtSyntaxProtocol
  }
}


public struct StmtSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Initialize `StmtSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  /// Checked cast `other` to `StmtSyntax` if possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Create a `StmtSyntax` node from a specialized syntax node.
  public init<Node: StmtSyntaxProtocol>(_ other: Node) {
    // We know T is valid for this protocol.
    self.init(data: other.data)
  }
}

extension StmtSyntax: CustomReflectable {
  /// Reconstructs the real syntax type for this type from the node's kind and
  /// provides a mirror that reflects this type.
  public var customMirror: Mirror {
    return Mirror(reflecting: Syntax(self).asProtocol(SyntaxProtocol.self))
  }
}


// MARK: - TypeSyntax

/// Protocol to which all `TypeSyntax` nodes conform. Extension point to add
/// common methods to all `TypeSyntax` nodes.
/// DO NOT CONFORM TO THIS PROTOCOL YOURSELF!
public protocol TypeSyntaxProtocol: SyntaxProtocol {}

public extension Syntax {
  /// Check whether the non-type erased version of this syntax node conforms to
  /// TypeSyntaxProtocol.
  /// Note that this will incur an existential conversion.
  func isProtocol(_: TypeSyntaxProtocol.Protocol) -> Bool {
    return self.asProtocol(TypeSyntaxProtocol.self) != nil
  }

  /// Return the non-type erased version of this syntax node if it conforms to
  /// TypeSyntaxProtocol. Otherwise return nil.
  /// Note that this will incur an existential conversion.
  func asProtocol(_: TypeSyntaxProtocol.Protocol) -> TypeSyntaxProtocol? {
    return self.asProtocol(SyntaxProtocol.self) as? TypeSyntaxProtocol
  }
}


public struct TypeSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Initialize `TypeSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  /// Checked cast `other` to `TypeSyntax` if possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Create a `TypeSyntax` node from a specialized syntax node.
  public init<Node: TypeSyntaxProtocol>(_ other: Node) {
    // We know T is valid for this protocol.
    self.init(data: other.data)
  }
}

extension TypeSyntax: CustomReflectable {
  /// Reconstructs the real syntax type for this type from the node's kind and
  /// provides a mirror that reflects this type.
  public var customMirror: Mirror {
    return Mirror(reflecting: Syntax(self).asProtocol(SyntaxProtocol.self))
  }
}


// MARK: - PatternSyntax

/// Protocol to which all `PatternSyntax` nodes conform. Extension point to add
/// common methods to all `PatternSyntax` nodes.
/// DO NOT CONFORM TO THIS PROTOCOL YOURSELF!
public protocol PatternSyntaxProtocol: SyntaxProtocol {}

public extension Syntax {
  /// Check whether the non-type erased version of this syntax node conforms to
  /// PatternSyntaxProtocol.
  /// Note that this will incur an existential conversion.
  func isProtocol(_: PatternSyntaxProtocol.Protocol) -> Bool {
    return self.asProtocol(PatternSyntaxProtocol.self) != nil
  }

  /// Return the non-type erased version of this syntax node if it conforms to
  /// PatternSyntaxProtocol. Otherwise return nil.
  /// Note that this will incur an existential conversion.
  func asProtocol(_: PatternSyntaxProtocol.Protocol) -> PatternSyntaxProtocol? {
    return self.asProtocol(SyntaxProtocol.self) as? PatternSyntaxProtocol
  }
}


public struct PatternSyntax: SyntaxProtocol, Hashable, Identifiable {
  public typealias ID = SyntaxIdentifier
  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawPatternSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Initialize `PatternSyntax` unsafely assuming `syntax` is valid.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }

  /// Checked cast `other` to `PatternSyntax` if possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Create a `PatternSyntax` node from a specialized syntax node.
  public init<Node: PatternSyntaxProtocol>(_ other: Node) {
    // We know T is valid for this protocol.
    self.init(data: other.data)
  }
}

extension PatternSyntax: CustomReflectable {
  /// Reconstructs the real syntax type for this type from the node's kind and
  /// provides a mirror that reflects this type.
  public var customMirror: Mirror {
    return Mirror(reflecting: Syntax(self).asProtocol(SyntaxProtocol.self))
  }
}

