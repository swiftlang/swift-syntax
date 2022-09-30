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

public struct DeclSyntax: DeclSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  /// Create a `DeclSyntax` node from a specialized syntax node.
  public init<S: DeclSyntaxProtocol>(_ syntax: S) {
    // We know this cast is going to succeed. Go through init(_: SyntaxData)
    // to do a sanity check and verify the kind matches in debug builds and get
    // maximum performance in release builds.
    self.init(syntax._syntaxNode.data)
  }

  /// Create a `DeclSyntax` node from a specialized optional syntax node.
  public init?<S: DeclSyntaxProtocol>(_ syntax: S?) {
    guard let syntax = syntax else { return nil }
    self.init(syntax)
  }

  /// Converts the given `Syntax` node to a `DeclSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    switch syntax.raw.kind {
    case .unknownDecl, .missingDecl, .typealiasDecl, .associatedtypeDecl, .ifConfigDecl, .poundErrorDecl, .poundWarningDecl, .poundSourceLocation, .classDecl, .actorDecl, .structDecl, .protocolDecl, .extensionDecl, .functionDecl, .initializerDecl, .deinitializerDecl, .subscriptDecl, .importDecl, .accessorDecl, .variableDecl, .enumCaseDecl, .enumDecl, .operatorDecl, .precedenceGroupDecl:
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
    case .unknownDecl, .missingDecl, .typealiasDecl, .associatedtypeDecl, .ifConfigDecl, .poundErrorDecl, .poundWarningDecl, .poundSourceLocation, .classDecl, .actorDecl, .structDecl, .protocolDecl, .extensionDecl, .functionDecl, .initializerDecl, .deinitializerDecl, .subscriptDecl, .importDecl, .accessorDecl, .variableDecl, .enumCaseDecl, .enumDecl, .operatorDecl, .precedenceGroupDecl:
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

  /// Syntax nodes always conform to `DeclSyntaxProtocol`. This API is just
  /// added for consistency.
  /// Note that this will incur an existential conversion.
  @available(*, deprecated, message: "Expression always evaluates to true")
  public func isProtocol(_: DeclSyntaxProtocol.Protocol) -> Bool {
    return true
  }

  /// Return the non-type erased version of this syntax node.
  /// Note that this will incur an existential conversion.
  public func asProtocol(_: DeclSyntaxProtocol.Protocol) -> DeclSyntaxProtocol {
    return Syntax(self).asProtocol(DeclSyntaxProtocol.self)!
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return Syntax(self).childNameForDiagnostics(index)
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

public struct ExprSyntax: ExprSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  /// Create a `ExprSyntax` node from a specialized syntax node.
  public init<S: ExprSyntaxProtocol>(_ syntax: S) {
    // We know this cast is going to succeed. Go through init(_: SyntaxData)
    // to do a sanity check and verify the kind matches in debug builds and get
    // maximum performance in release builds.
    self.init(syntax._syntaxNode.data)
  }

  /// Create a `ExprSyntax` node from a specialized optional syntax node.
  public init?<S: ExprSyntaxProtocol>(_ syntax: S?) {
    guard let syntax = syntax else { return nil }
    self.init(syntax)
  }

  /// Converts the given `Syntax` node to a `ExprSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    switch syntax.raw.kind {
    case .unknownExpr, .missingExpr, .inOutExpr, .poundColumnExpr, .tryExpr, .awaitExpr, .moveExpr, .identifierExpr, .superRefExpr, .nilLiteralExpr, .discardAssignmentExpr, .assignmentExpr, .sequenceExpr, .poundLineExpr, .poundFileExpr, .poundFileIDExpr, .poundFilePathExpr, .poundFunctionExpr, .poundDsohandleExpr, .symbolicReferenceExpr, .prefixOperatorExpr, .binaryOperatorExpr, .arrowExpr, .infixOperatorExpr, .floatLiteralExpr, .tupleExpr, .arrayExpr, .dictionaryExpr, .integerLiteralExpr, .booleanLiteralExpr, .unresolvedTernaryExpr, .ternaryExpr, .memberAccessExpr, .unresolvedIsExpr, .isExpr, .unresolvedAsExpr, .asExpr, .typeExpr, .closureExpr, .unresolvedPatternExpr, .functionCallExpr, .subscriptExpr, .optionalChainingExpr, .forcedValueExpr, .postfixUnaryExpr, .specializeExpr, .stringLiteralExpr, .regexLiteralExpr, .keyPathExpr, .oldKeyPathExpr, .keyPathBaseExpr, .objcKeyPathExpr, .objcSelectorExpr, .postfixIfConfigExpr, .editorPlaceholderExpr, .objectLiteralExpr:
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
    case .unknownExpr, .missingExpr, .inOutExpr, .poundColumnExpr, .tryExpr, .awaitExpr, .moveExpr, .identifierExpr, .superRefExpr, .nilLiteralExpr, .discardAssignmentExpr, .assignmentExpr, .sequenceExpr, .poundLineExpr, .poundFileExpr, .poundFileIDExpr, .poundFilePathExpr, .poundFunctionExpr, .poundDsohandleExpr, .symbolicReferenceExpr, .prefixOperatorExpr, .binaryOperatorExpr, .arrowExpr, .infixOperatorExpr, .floatLiteralExpr, .tupleExpr, .arrayExpr, .dictionaryExpr, .integerLiteralExpr, .booleanLiteralExpr, .unresolvedTernaryExpr, .ternaryExpr, .memberAccessExpr, .unresolvedIsExpr, .isExpr, .unresolvedAsExpr, .asExpr, .typeExpr, .closureExpr, .unresolvedPatternExpr, .functionCallExpr, .subscriptExpr, .optionalChainingExpr, .forcedValueExpr, .postfixUnaryExpr, .specializeExpr, .stringLiteralExpr, .regexLiteralExpr, .keyPathExpr, .oldKeyPathExpr, .keyPathBaseExpr, .objcKeyPathExpr, .objcSelectorExpr, .postfixIfConfigExpr, .editorPlaceholderExpr, .objectLiteralExpr:
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

  /// Syntax nodes always conform to `ExprSyntaxProtocol`. This API is just
  /// added for consistency.
  /// Note that this will incur an existential conversion.
  @available(*, deprecated, message: "Expression always evaluates to true")
  public func isProtocol(_: ExprSyntaxProtocol.Protocol) -> Bool {
    return true
  }

  /// Return the non-type erased version of this syntax node.
  /// Note that this will incur an existential conversion.
  public func asProtocol(_: ExprSyntaxProtocol.Protocol) -> ExprSyntaxProtocol {
    return Syntax(self).asProtocol(ExprSyntaxProtocol.self)!
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return Syntax(self).childNameForDiagnostics(index)
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

public struct StmtSyntax: StmtSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  /// Create a `StmtSyntax` node from a specialized syntax node.
  public init<S: StmtSyntaxProtocol>(_ syntax: S) {
    // We know this cast is going to succeed. Go through init(_: SyntaxData)
    // to do a sanity check and verify the kind matches in debug builds and get
    // maximum performance in release builds.
    self.init(syntax._syntaxNode.data)
  }

  /// Create a `StmtSyntax` node from a specialized optional syntax node.
  public init?<S: StmtSyntaxProtocol>(_ syntax: S?) {
    guard let syntax = syntax else { return nil }
    self.init(syntax)
  }

  /// Converts the given `Syntax` node to a `StmtSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    switch syntax.raw.kind {
    case .unknownStmt, .missingStmt, .labeledStmt, .continueStmt, .whileStmt, .deferStmt, .expressionStmt, .repeatWhileStmt, .guardStmt, .forInStmt, .switchStmt, .doStmt, .returnStmt, .yieldStmt, .fallthroughStmt, .breakStmt, .declarationStmt, .throwStmt, .ifStmt, .poundAssertStmt:
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
    case .unknownStmt, .missingStmt, .labeledStmt, .continueStmt, .whileStmt, .deferStmt, .expressionStmt, .repeatWhileStmt, .guardStmt, .forInStmt, .switchStmt, .doStmt, .returnStmt, .yieldStmt, .fallthroughStmt, .breakStmt, .declarationStmt, .throwStmt, .ifStmt, .poundAssertStmt:
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

  /// Syntax nodes always conform to `StmtSyntaxProtocol`. This API is just
  /// added for consistency.
  /// Note that this will incur an existential conversion.
  @available(*, deprecated, message: "Expression always evaluates to true")
  public func isProtocol(_: StmtSyntaxProtocol.Protocol) -> Bool {
    return true
  }

  /// Return the non-type erased version of this syntax node.
  /// Note that this will incur an existential conversion.
  public func asProtocol(_: StmtSyntaxProtocol.Protocol) -> StmtSyntaxProtocol {
    return Syntax(self).asProtocol(StmtSyntaxProtocol.self)!
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return Syntax(self).childNameForDiagnostics(index)
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

public struct TypeSyntax: TypeSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  /// Create a `TypeSyntax` node from a specialized syntax node.
  public init<S: TypeSyntaxProtocol>(_ syntax: S) {
    // We know this cast is going to succeed. Go through init(_: SyntaxData)
    // to do a sanity check and verify the kind matches in debug builds and get
    // maximum performance in release builds.
    self.init(syntax._syntaxNode.data)
  }

  /// Create a `TypeSyntax` node from a specialized optional syntax node.
  public init?<S: TypeSyntaxProtocol>(_ syntax: S?) {
    guard let syntax = syntax else { return nil }
    self.init(syntax)
  }

  /// Converts the given `Syntax` node to a `TypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    switch syntax.raw.kind {
    case .unknownType, .missingType, .simpleTypeIdentifier, .memberTypeIdentifier, .classRestrictionType, .arrayType, .dictionaryType, .metatypeType, .optionalType, .constrainedSugarType, .implicitlyUnwrappedOptionalType, .compositionType, .packExpansionType, .tupleType, .functionType, .attributedType, .namedOpaqueReturnType:
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
    case .unknownType, .missingType, .simpleTypeIdentifier, .memberTypeIdentifier, .classRestrictionType, .arrayType, .dictionaryType, .metatypeType, .optionalType, .constrainedSugarType, .implicitlyUnwrappedOptionalType, .compositionType, .packExpansionType, .tupleType, .functionType, .attributedType, .namedOpaqueReturnType:
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

  /// Syntax nodes always conform to `TypeSyntaxProtocol`. This API is just
  /// added for consistency.
  /// Note that this will incur an existential conversion.
  @available(*, deprecated, message: "Expression always evaluates to true")
  public func isProtocol(_: TypeSyntaxProtocol.Protocol) -> Bool {
    return true
  }

  /// Return the non-type erased version of this syntax node.
  /// Note that this will incur an existential conversion.
  public func asProtocol(_: TypeSyntaxProtocol.Protocol) -> TypeSyntaxProtocol {
    return Syntax(self).asProtocol(TypeSyntaxProtocol.self)!
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return Syntax(self).childNameForDiagnostics(index)
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

public struct PatternSyntax: PatternSyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  /// Create a `PatternSyntax` node from a specialized syntax node.
  public init<S: PatternSyntaxProtocol>(_ syntax: S) {
    // We know this cast is going to succeed. Go through init(_: SyntaxData)
    // to do a sanity check and verify the kind matches in debug builds and get
    // maximum performance in release builds.
    self.init(syntax._syntaxNode.data)
  }

  /// Create a `PatternSyntax` node from a specialized optional syntax node.
  public init?<S: PatternSyntaxProtocol>(_ syntax: S?) {
    guard let syntax = syntax else { return nil }
    self.init(syntax)
  }

  /// Converts the given `Syntax` node to a `PatternSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    switch syntax.raw.kind {
    case .unknownPattern, .missingPattern, .enumCasePattern, .isTypePattern, .optionalPattern, .identifierPattern, .asTypePattern, .tuplePattern, .wildcardPattern, .expressionPattern, .valueBindingPattern:
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
    case .unknownPattern, .missingPattern, .enumCasePattern, .isTypePattern, .optionalPattern, .identifierPattern, .asTypePattern, .tuplePattern, .wildcardPattern, .expressionPattern, .valueBindingPattern:
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

  /// Syntax nodes always conform to `PatternSyntaxProtocol`. This API is just
  /// added for consistency.
  /// Note that this will incur an existential conversion.
  @available(*, deprecated, message: "Expression always evaluates to true")
  public func isProtocol(_: PatternSyntaxProtocol.Protocol) -> Bool {
    return true
  }

  /// Return the non-type erased version of this syntax node.
  /// Note that this will incur an existential conversion.
  public func asProtocol(_: PatternSyntaxProtocol.Protocol) -> PatternSyntaxProtocol {
    return Syntax(self).asProtocol(PatternSyntaxProtocol.self)!
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return Syntax(self).childNameForDiagnostics(index)
  }
}

extension PatternSyntax: CustomReflectable {
  /// Reconstructs the real syntax type for this type from the node's kind and
  /// provides a mirror that reflects this type.
  public var customMirror: Mirror {
    return Mirror(reflecting: Syntax(self).asProtocol(SyntaxProtocol.self))
  }
}

