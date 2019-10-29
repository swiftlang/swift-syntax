//// Automatically Generated From SyntaxNodes.swift.gyb.
//// Do Not Edit Directly!
//===---------- SyntaxBaseNodes.swift - Syntax Node definitions -----------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2019 Apple Inc. and the Swift project authors
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

public struct DeclSyntax: DeclSyntaxProtocol {
  public let _syntaxNode: Syntax

  public init<S: DeclSyntaxProtocol>(_ syntax: S) {
    // We know this cast is going to succeed. Go through init(_: SyntaxData)
    // to do a sanity check and verify the kind matches in debug builds and get
    // maximum performance in release builds.
    self.init(syntax._syntaxNode.data)
  }

  /// Converts the given `Syntax` node to a `DeclSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    switch syntax.raw.kind {
    case .unknownDecl, .typealiasDecl, .associatedtypeDecl, .ifConfigDecl, .poundErrorDecl, .poundWarningDecl, .poundSourceLocation, .classDecl, .structDecl, .protocolDecl, .extensionDecl, .functionDecl, .initializerDecl, .deinitializerDecl, .subscriptDecl, .importDecl, .accessorDecl, .variableDecl, .enumCaseDecl, .enumDecl, .operatorDecl, .precedenceGroupDecl:
      self._syntaxNode = syntax
    default:
      return nil
    }
  }

  /// Creates a `DeclSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    // Assert that the kind of the given data matches in debug builds.
#if DEBUG
    switch data.raw.kind {
    case .unknownDecl, .typealiasDecl, .associatedtypeDecl, .ifConfigDecl, .poundErrorDecl, .poundWarningDecl, .poundSourceLocation, .classDecl, .structDecl, .protocolDecl, .extensionDecl, .functionDecl, .initializerDecl, .deinitializerDecl, .subscriptDecl, .importDecl, .accessorDecl, .variableDecl, .enumCaseDecl, .enumDecl, .operatorDecl, .precedenceGroupDecl:
      break
    default:
      fatalError("Unable to create DeclSyntax from \(data.raw.kind)")
    }
#endif

    self._syntaxNode = Syntax(data)
  }

  public func `is`<S: DeclSyntaxProtocol>(_ syntaxType: S.Type) -> Bool {
    return self.as(syntaxType) != nil
  }

  public func `as`<S: DeclSyntaxProtocol>(_ syntaxType: S.Type) -> S? {
    return S.init(_syntaxNode)
  }
}

extension DeclSyntax: CustomReflectable {
  /// Reconstructs the real syntax type for this type from the node's kind and
  /// provides a mirror that reflects this type.
  public var customMirror: Mirror {
    return Mirror(reflecting: Syntax(self)._asConcreteType)
  }
}

// MARK: - ExprSyntax

/// Protocol to which all `ExprSyntax` nodes conform. Extension point to add
/// common methods to all `ExprSyntax` nodes.
/// DO NOT CONFORM TO THIS PROTOCOL YOURSELF!
public protocol ExprSyntaxProtocol: SyntaxProtocol {}

public struct ExprSyntax: ExprSyntaxProtocol {
  public let _syntaxNode: Syntax

  public init<S: ExprSyntaxProtocol>(_ syntax: S) {
    // We know this cast is going to succeed. Go through init(_: SyntaxData)
    // to do a sanity check and verify the kind matches in debug builds and get
    // maximum performance in release builds.
    self.init(syntax._syntaxNode.data)
  }

  /// Converts the given `Syntax` node to a `ExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    switch syntax.raw.kind {
    case .unknownExpr, .inOutExpr, .poundColumnExpr, .tryExpr, .identifierExpr, .superRefExpr, .nilLiteralExpr, .discardAssignmentExpr, .assignmentExpr, .sequenceExpr, .poundLineExpr, .poundFileExpr, .poundFunctionExpr, .poundDsohandleExpr, .symbolicReferenceExpr, .prefixOperatorExpr, .binaryOperatorExpr, .arrowExpr, .floatLiteralExpr, .tupleExpr, .arrayExpr, .dictionaryExpr, .integerLiteralExpr, .booleanLiteralExpr, .ternaryExpr, .memberAccessExpr, .isExpr, .asExpr, .typeExpr, .closureExpr, .unresolvedPatternExpr, .functionCallExpr, .subscriptExpr, .optionalChainingExpr, .forcedValueExpr, .postfixUnaryExpr, .specializeExpr, .stringLiteralExpr, .keyPathExpr, .keyPathBaseExpr, .objcKeyPathExpr, .objcSelectorExpr, .editorPlaceholderExpr, .objectLiteralExpr:
      self._syntaxNode = syntax
    default:
      return nil
    }
  }

  /// Creates a `ExprSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    // Assert that the kind of the given data matches in debug builds.
#if DEBUG
    switch data.raw.kind {
    case .unknownExpr, .inOutExpr, .poundColumnExpr, .tryExpr, .identifierExpr, .superRefExpr, .nilLiteralExpr, .discardAssignmentExpr, .assignmentExpr, .sequenceExpr, .poundLineExpr, .poundFileExpr, .poundFunctionExpr, .poundDsohandleExpr, .symbolicReferenceExpr, .prefixOperatorExpr, .binaryOperatorExpr, .arrowExpr, .floatLiteralExpr, .tupleExpr, .arrayExpr, .dictionaryExpr, .integerLiteralExpr, .booleanLiteralExpr, .ternaryExpr, .memberAccessExpr, .isExpr, .asExpr, .typeExpr, .closureExpr, .unresolvedPatternExpr, .functionCallExpr, .subscriptExpr, .optionalChainingExpr, .forcedValueExpr, .postfixUnaryExpr, .specializeExpr, .stringLiteralExpr, .keyPathExpr, .keyPathBaseExpr, .objcKeyPathExpr, .objcSelectorExpr, .editorPlaceholderExpr, .objectLiteralExpr:
      break
    default:
      fatalError("Unable to create ExprSyntax from \(data.raw.kind)")
    }
#endif

    self._syntaxNode = Syntax(data)
  }

  public func `is`<S: ExprSyntaxProtocol>(_ syntaxType: S.Type) -> Bool {
    return self.as(syntaxType) != nil
  }

  public func `as`<S: ExprSyntaxProtocol>(_ syntaxType: S.Type) -> S? {
    return S.init(_syntaxNode)
  }
}

extension ExprSyntax: CustomReflectable {
  /// Reconstructs the real syntax type for this type from the node's kind and
  /// provides a mirror that reflects this type.
  public var customMirror: Mirror {
    return Mirror(reflecting: Syntax(self)._asConcreteType)
  }
}

// MARK: - StmtSyntax

/// Protocol to which all `StmtSyntax` nodes conform. Extension point to add
/// common methods to all `StmtSyntax` nodes.
/// DO NOT CONFORM TO THIS PROTOCOL YOURSELF!
public protocol StmtSyntaxProtocol: SyntaxProtocol {}

public struct StmtSyntax: StmtSyntaxProtocol {
  public let _syntaxNode: Syntax

  public init<S: StmtSyntaxProtocol>(_ syntax: S) {
    // We know this cast is going to succeed. Go through init(_: SyntaxData)
    // to do a sanity check and verify the kind matches in debug builds and get
    // maximum performance in release builds.
    self.init(syntax._syntaxNode.data)
  }

  /// Converts the given `Syntax` node to a `StmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    switch syntax.raw.kind {
    case .unknownStmt, .continueStmt, .whileStmt, .deferStmt, .expressionStmt, .repeatWhileStmt, .guardStmt, .forInStmt, .switchStmt, .doStmt, .returnStmt, .yieldStmt, .fallthroughStmt, .breakStmt, .declarationStmt, .throwStmt, .ifStmt, .poundAssertStmt:
      self._syntaxNode = syntax
    default:
      return nil
    }
  }

  /// Creates a `StmtSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    // Assert that the kind of the given data matches in debug builds.
#if DEBUG
    switch data.raw.kind {
    case .unknownStmt, .continueStmt, .whileStmt, .deferStmt, .expressionStmt, .repeatWhileStmt, .guardStmt, .forInStmt, .switchStmt, .doStmt, .returnStmt, .yieldStmt, .fallthroughStmt, .breakStmt, .declarationStmt, .throwStmt, .ifStmt, .poundAssertStmt:
      break
    default:
      fatalError("Unable to create StmtSyntax from \(data.raw.kind)")
    }
#endif

    self._syntaxNode = Syntax(data)
  }

  public func `is`<S: StmtSyntaxProtocol>(_ syntaxType: S.Type) -> Bool {
    return self.as(syntaxType) != nil
  }

  public func `as`<S: StmtSyntaxProtocol>(_ syntaxType: S.Type) -> S? {
    return S.init(_syntaxNode)
  }
}

extension StmtSyntax: CustomReflectable {
  /// Reconstructs the real syntax type for this type from the node's kind and
  /// provides a mirror that reflects this type.
  public var customMirror: Mirror {
    return Mirror(reflecting: Syntax(self)._asConcreteType)
  }
}

// MARK: - TypeSyntax

/// Protocol to which all `TypeSyntax` nodes conform. Extension point to add
/// common methods to all `TypeSyntax` nodes.
/// DO NOT CONFORM TO THIS PROTOCOL YOURSELF!
public protocol TypeSyntaxProtocol: SyntaxProtocol {}

public struct TypeSyntax: TypeSyntaxProtocol {
  public let _syntaxNode: Syntax

  public init<S: TypeSyntaxProtocol>(_ syntax: S) {
    // We know this cast is going to succeed. Go through init(_: SyntaxData)
    // to do a sanity check and verify the kind matches in debug builds and get
    // maximum performance in release builds.
    self.init(syntax._syntaxNode.data)
  }

  /// Converts the given `Syntax` node to a `TypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    switch syntax.raw.kind {
    case .unknownType, .simpleTypeIdentifier, .memberTypeIdentifier, .classRestrictionType, .arrayType, .dictionaryType, .metatypeType, .optionalType, .someType, .implicitlyUnwrappedOptionalType, .compositionType, .tupleType, .functionType, .attributedType:
      self._syntaxNode = syntax
    default:
      return nil
    }
  }

  /// Creates a `TypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    // Assert that the kind of the given data matches in debug builds.
#if DEBUG
    switch data.raw.kind {
    case .unknownType, .simpleTypeIdentifier, .memberTypeIdentifier, .classRestrictionType, .arrayType, .dictionaryType, .metatypeType, .optionalType, .someType, .implicitlyUnwrappedOptionalType, .compositionType, .tupleType, .functionType, .attributedType:
      break
    default:
      fatalError("Unable to create TypeSyntax from \(data.raw.kind)")
    }
#endif

    self._syntaxNode = Syntax(data)
  }

  public func `is`<S: TypeSyntaxProtocol>(_ syntaxType: S.Type) -> Bool {
    return self.as(syntaxType) != nil
  }

  public func `as`<S: TypeSyntaxProtocol>(_ syntaxType: S.Type) -> S? {
    return S.init(_syntaxNode)
  }
}

extension TypeSyntax: CustomReflectable {
  /// Reconstructs the real syntax type for this type from the node's kind and
  /// provides a mirror that reflects this type.
  public var customMirror: Mirror {
    return Mirror(reflecting: Syntax(self)._asConcreteType)
  }
}

// MARK: - PatternSyntax

/// Protocol to which all `PatternSyntax` nodes conform. Extension point to add
/// common methods to all `PatternSyntax` nodes.
/// DO NOT CONFORM TO THIS PROTOCOL YOURSELF!
public protocol PatternSyntaxProtocol: SyntaxProtocol {}

public struct PatternSyntax: PatternSyntaxProtocol {
  public let _syntaxNode: Syntax

  public init<S: PatternSyntaxProtocol>(_ syntax: S) {
    // We know this cast is going to succeed. Go through init(_: SyntaxData)
    // to do a sanity check and verify the kind matches in debug builds and get
    // maximum performance in release builds.
    self.init(syntax._syntaxNode.data)
  }

  /// Converts the given `Syntax` node to a `PatternSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    switch syntax.raw.kind {
    case .unknownPattern, .enumCasePattern, .isTypePattern, .optionalPattern, .identifierPattern, .asTypePattern, .tuplePattern, .wildcardPattern, .expressionPattern, .valueBindingPattern:
      self._syntaxNode = syntax
    default:
      return nil
    }
  }

  /// Creates a `PatternSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    // Assert that the kind of the given data matches in debug builds.
#if DEBUG
    switch data.raw.kind {
    case .unknownPattern, .enumCasePattern, .isTypePattern, .optionalPattern, .identifierPattern, .asTypePattern, .tuplePattern, .wildcardPattern, .expressionPattern, .valueBindingPattern:
      break
    default:
      fatalError("Unable to create PatternSyntax from \(data.raw.kind)")
    }
#endif

    self._syntaxNode = Syntax(data)
  }

  public func `is`<S: PatternSyntaxProtocol>(_ syntaxType: S.Type) -> Bool {
    return self.as(syntaxType) != nil
  }

  public func `as`<S: PatternSyntaxProtocol>(_ syntaxType: S.Type) -> S? {
    return S.init(_syntaxNode)
  }
}

extension PatternSyntax: CustomReflectable {
  /// Reconstructs the real syntax type for this type from the node's kind and
  /// provides a mirror that reflects this type.
  public var customMirror: Mirror {
    return Mirror(reflecting: Syntax(self)._asConcreteType)
  }
}

