//// Automatically Generated From SyntaxCollections.swift.gyb.
//// Do Not Edit Directly!
//===------------ SyntaxCollections.swift.gyb - Syntax Collection ---------===//
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


/// `CodeBlockItemListSyntax` represents a collection of one or more
/// `CodeBlockItemSyntax` nodes. CodeBlockItemListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct CodeBlockItemListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = CodeBlockItemSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawCodeBlockItemListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `CodeBlockItemListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `TupleExprElementListSyntax` represents a collection of one or more
/// `TupleExprElementSyntax` nodes. TupleExprElementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct TupleExprElementListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = TupleExprElementSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawTupleExprElementListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `TupleExprElementListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `ArrayElementListSyntax` represents a collection of one or more
/// `ArrayElementSyntax` nodes. ArrayElementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct ArrayElementListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = ArrayElementSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawArrayElementListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ArrayElementListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `DictionaryElementListSyntax` represents a collection of one or more
/// `DictionaryElementSyntax` nodes. DictionaryElementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct DictionaryElementListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = DictionaryElementSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawDictionaryElementListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `DictionaryElementListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `StringLiteralSegmentsSyntax` represents a collection of one or more
/// `Syntax` nodes. StringLiteralSegmentsSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct StringLiteralSegmentsSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = Syntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawStringLiteralSegmentsSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `StringLiteralSegmentsSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `DeclNameArgumentListSyntax` represents a collection of one or more
/// `DeclNameArgumentSyntax` nodes. DeclNameArgumentListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct DeclNameArgumentListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = DeclNameArgumentSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawDeclNameArgumentListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `DeclNameArgumentListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// 
/// A list of expressions connected by operators. This list is contained
/// by a `SequenceExprSyntax`.
/// 
public struct ExprListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = ExprSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawExprListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ExprListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `ClosureCaptureItemListSyntax` represents a collection of one or more
/// `ClosureCaptureItemSyntax` nodes. ClosureCaptureItemListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct ClosureCaptureItemListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = ClosureCaptureItemSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawClosureCaptureItemListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ClosureCaptureItemListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `ClosureParamListSyntax` represents a collection of one or more
/// `ClosureParamSyntax` nodes. ClosureParamListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct ClosureParamListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = ClosureParamSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawClosureParamListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ClosureParamListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `MultipleTrailingClosureElementListSyntax` represents a collection of one or more
/// `MultipleTrailingClosureElementSyntax` nodes. MultipleTrailingClosureElementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct MultipleTrailingClosureElementListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = MultipleTrailingClosureElementSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawMultipleTrailingClosureElementListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `MultipleTrailingClosureElementListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `ObjcNameSyntax` represents a collection of one or more
/// `ObjcNamePieceSyntax` nodes. ObjcNameSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct ObjcNameSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = ObjcNamePieceSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawObjcNameSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ObjcNameSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `FunctionParameterListSyntax` represents a collection of one or more
/// `FunctionParameterSyntax` nodes. FunctionParameterListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct FunctionParameterListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = FunctionParameterSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawFunctionParameterListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `FunctionParameterListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `IfConfigClauseListSyntax` represents a collection of one or more
/// `IfConfigClauseSyntax` nodes. IfConfigClauseListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct IfConfigClauseListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = IfConfigClauseSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawIfConfigClauseListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `IfConfigClauseListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `InheritedTypeListSyntax` represents a collection of one or more
/// `InheritedTypeSyntax` nodes. InheritedTypeListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct InheritedTypeListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = InheritedTypeSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawInheritedTypeListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `InheritedTypeListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `MemberDeclListSyntax` represents a collection of one or more
/// `MemberDeclListItemSyntax` nodes. MemberDeclListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct MemberDeclListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = MemberDeclListItemSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawMemberDeclListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `MemberDeclListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `ModifierListSyntax` represents a collection of one or more
/// `DeclModifierSyntax` nodes. ModifierListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct ModifierListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = DeclModifierSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawModifierListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ModifierListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `AccessPathSyntax` represents a collection of one or more
/// `AccessPathComponentSyntax` nodes. AccessPathSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct AccessPathSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = AccessPathComponentSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawAccessPathSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `AccessPathSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `AccessorListSyntax` represents a collection of one or more
/// `AccessorDeclSyntax` nodes. AccessorListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct AccessorListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = AccessorDeclSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawAccessorListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `AccessorListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `PatternBindingListSyntax` represents a collection of one or more
/// `PatternBindingSyntax` nodes. PatternBindingListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct PatternBindingListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = PatternBindingSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawPatternBindingListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `PatternBindingListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// A collection of 0 or more `EnumCaseElement`s.
public struct EnumCaseElementListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = EnumCaseElementSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawEnumCaseElementListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `EnumCaseElementListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `IdentifierListSyntax` represents a collection of one or more
/// `TokenSyntax` nodes. IdentifierListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct IdentifierListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = TokenSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawIdentifierListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `IdentifierListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `PrecedenceGroupAttributeListSyntax` represents a collection of one or more
/// `Syntax` nodes. PrecedenceGroupAttributeListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct PrecedenceGroupAttributeListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = Syntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawPrecedenceGroupAttributeListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `PrecedenceGroupAttributeListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `PrecedenceGroupNameListSyntax` represents a collection of one or more
/// `PrecedenceGroupNameElementSyntax` nodes. PrecedenceGroupNameListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct PrecedenceGroupNameListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = PrecedenceGroupNameElementSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawPrecedenceGroupNameListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `PrecedenceGroupNameListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `TokenListSyntax` represents a collection of one or more
/// `TokenSyntax` nodes. TokenListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct TokenListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = TokenSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawTokenListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `TokenListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `NonEmptyTokenListSyntax` represents a collection of one or more
/// `TokenSyntax` nodes. NonEmptyTokenListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct NonEmptyTokenListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = TokenSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawNonEmptyTokenListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `NonEmptyTokenListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `AttributeListSyntax` represents a collection of one or more
/// `Syntax` nodes. AttributeListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct AttributeListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = Syntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawAttributeListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `AttributeListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// 
/// A collection of arguments for the `@_specialize` attribute
/// 
public struct SpecializeAttributeSpecListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = Syntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawSpecializeAttributeSpecListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `SpecializeAttributeSpecListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `ObjCSelectorSyntax` represents a collection of one or more
/// `ObjCSelectorPieceSyntax` nodes. ObjCSelectorSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct ObjCSelectorSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = ObjCSelectorPieceSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawObjCSelectorSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ObjCSelectorSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `DifferentiabilityParamListSyntax` represents a collection of one or more
/// `DifferentiabilityParamSyntax` nodes. DifferentiabilityParamListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct DifferentiabilityParamListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = DifferentiabilityParamSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawDifferentiabilityParamListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `DifferentiabilityParamListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `BackDeployVersionListSyntax` represents a collection of one or more
/// `BackDeployVersionArgumentSyntax` nodes. BackDeployVersionListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct BackDeployVersionListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = BackDeployVersionArgumentSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawBackDeployVersionListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `BackDeployVersionListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `SwitchCaseListSyntax` represents a collection of one or more
/// `Syntax` nodes. SwitchCaseListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct SwitchCaseListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = Syntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawSwitchCaseListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `SwitchCaseListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `CatchClauseListSyntax` represents a collection of one or more
/// `CatchClauseSyntax` nodes. CatchClauseListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct CatchClauseListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = CatchClauseSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawCatchClauseListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `CatchClauseListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `CaseItemListSyntax` represents a collection of one or more
/// `CaseItemSyntax` nodes. CaseItemListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct CaseItemListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = CaseItemSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawCaseItemListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `CaseItemListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `CatchItemListSyntax` represents a collection of one or more
/// `CatchItemSyntax` nodes. CatchItemListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct CatchItemListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = CatchItemSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawCatchItemListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `CatchItemListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `ConditionElementListSyntax` represents a collection of one or more
/// `ConditionElementSyntax` nodes. ConditionElementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct ConditionElementListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = ConditionElementSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawConditionElementListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `ConditionElementListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `GenericRequirementListSyntax` represents a collection of one or more
/// `GenericRequirementSyntax` nodes. GenericRequirementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct GenericRequirementListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = GenericRequirementSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawGenericRequirementListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `GenericRequirementListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `GenericParameterListSyntax` represents a collection of one or more
/// `GenericParameterSyntax` nodes. GenericParameterListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct GenericParameterListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = GenericParameterSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawGenericParameterListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `GenericParameterListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `PrimaryAssociatedTypeListSyntax` represents a collection of one or more
/// `PrimaryAssociatedTypeSyntax` nodes. PrimaryAssociatedTypeListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct PrimaryAssociatedTypeListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = PrimaryAssociatedTypeSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawPrimaryAssociatedTypeListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `PrimaryAssociatedTypeListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `CompositionTypeElementListSyntax` represents a collection of one or more
/// `CompositionTypeElementSyntax` nodes. CompositionTypeElementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct CompositionTypeElementListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = CompositionTypeElementSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawCompositionTypeElementListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `CompositionTypeElementListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `TupleTypeElementListSyntax` represents a collection of one or more
/// `TupleTypeElementSyntax` nodes. TupleTypeElementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct TupleTypeElementListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = TupleTypeElementSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawTupleTypeElementListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `TupleTypeElementListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `GenericArgumentListSyntax` represents a collection of one or more
/// `GenericArgumentSyntax` nodes. GenericArgumentListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct GenericArgumentListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = GenericArgumentSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawGenericArgumentListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `GenericArgumentListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `TuplePatternElementListSyntax` represents a collection of one or more
/// `TuplePatternElementSyntax` nodes. TuplePatternElementListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct TuplePatternElementListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = TuplePatternElementSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawTuplePatternElementListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `TuplePatternElementListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}

/// `AvailabilitySpecListSyntax` represents a collection of one or more
/// `AvailabilityArgumentSyntax` nodes. AvailabilitySpecListSyntax behaves
/// as a regular Swift collection, and has accessors that return new
/// versions of the collection with different children.
public struct AvailabilitySpecListSyntax: SyntaxCollection, Hashable, Identifiable {
  public typealias Element = AvailabilityArgumentSyntax
  public typealias ID = SyntaxIdentifier

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    RawAvailabilitySpecListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public let syntax: Syntax

  /// Converts the given `Syntax` node to a `AvailabilitySpecListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  @inlinable
  public init?<Node: SyntaxProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntax.syntaxKind) else { return nil }
    self.init(data: other.data)
  }

  /// Creates a Syntax node from the provided root and data. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  @usableFromInline
  init(data: SyntaxData) {
    assert(Self.isValid(syntaxKind: data.raw.syntaxKind))
    self.syntax = Syntax(data: data)
  }
}
