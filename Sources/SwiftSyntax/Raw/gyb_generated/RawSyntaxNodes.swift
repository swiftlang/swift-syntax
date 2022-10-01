//// Automatically Generated From RawSyntaxNodes.swift.gyb.
//// Do Not Edit Directly!
//===------ RawSyntaxNodes.swift - Typed Raw Syntax Node definitions  ------===//
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

@_spi(RawSyntax)
public protocol RawDeclSyntaxNodeProtocol: RawSyntaxNodeProtocol {}
@_spi(RawSyntax)
public protocol RawExprSyntaxNodeProtocol: RawSyntaxNodeProtocol {}
@_spi(RawSyntax)
public protocol RawStmtSyntaxNodeProtocol: RawSyntaxNodeProtocol {}
@_spi(RawSyntax)
public protocol RawTypeSyntaxNodeProtocol: RawSyntaxNodeProtocol {}
@_spi(RawSyntax)
public protocol RawPatternSyntaxNodeProtocol: RawSyntaxNodeProtocol {}


@_spi(RawSyntax)
public struct RawDeclSyntax: RawDeclSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = DeclSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    switch raw.kind {
    case .unknownDecl, .missingDecl, .typealiasDecl, .associatedtypeDecl, .ifConfigDecl, .poundErrorDecl, .poundWarningDecl, .poundSourceLocation, .classDecl, .actorDecl, .structDecl, .protocolDecl, .extensionDecl, .functionDecl, .initializerDecl, .deinitializerDecl, .subscriptDecl, .importDecl, .accessorDecl, .variableDecl, .enumCaseDecl, .enumDecl, .operatorDecl, .precedenceGroupDecl: return true
    default: return false
    }
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init<Node: RawDeclSyntaxNodeProtocol>(_ other: Node) {
    self.init(raw: other.raw)
  }
}

@_spi(RawSyntax)
public struct RawExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    switch raw.kind {
    case .unknownExpr, .missingExpr, .inOutExpr, .poundColumnExpr, .tryExpr, .awaitExpr, .moveExpr, .identifierExpr, .superRefExpr, .nilLiteralExpr, .discardAssignmentExpr, .assignmentExpr, .sequenceExpr, .poundLineExpr, .poundFileExpr, .poundFileIDExpr, .poundFilePathExpr, .poundFunctionExpr, .poundDsohandleExpr, .symbolicReferenceExpr, .prefixOperatorExpr, .binaryOperatorExpr, .arrowExpr, .infixOperatorExpr, .floatLiteralExpr, .tupleExpr, .arrayExpr, .dictionaryExpr, .integerLiteralExpr, .booleanLiteralExpr, .unresolvedTernaryExpr, .ternaryExpr, .memberAccessExpr, .unresolvedIsExpr, .isExpr, .unresolvedAsExpr, .asExpr, .typeExpr, .closureExpr, .unresolvedPatternExpr, .functionCallExpr, .subscriptExpr, .optionalChainingExpr, .forcedValueExpr, .postfixUnaryExpr, .specializeExpr, .stringLiteralExpr, .regexLiteralExpr, .keyPathExpr, .oldKeyPathExpr, .keyPathBaseExpr, .objcKeyPathExpr, .objcSelectorExpr, .postfixIfConfigExpr, .editorPlaceholderExpr, .objectLiteralExpr: return true
    default: return false
    }
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init<Node: RawExprSyntaxNodeProtocol>(_ other: Node) {
    self.init(raw: other.raw)
  }
}

@_spi(RawSyntax)
public struct RawStmtSyntax: RawStmtSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = StmtSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    switch raw.kind {
    case .unknownStmt, .missingStmt, .labeledStmt, .continueStmt, .whileStmt, .deferStmt, .expressionStmt, .repeatWhileStmt, .guardStmt, .forInStmt, .switchStmt, .doStmt, .returnStmt, .yieldStmt, .fallthroughStmt, .breakStmt, .declarationStmt, .throwStmt, .ifStmt, .poundAssertStmt: return true
    default: return false
    }
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init<Node: RawStmtSyntaxNodeProtocol>(_ other: Node) {
    self.init(raw: other.raw)
  }
}

@_spi(RawSyntax)
public struct RawTypeSyntax: RawTypeSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = TypeSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    switch raw.kind {
    case .unknownType, .missingType, .simpleTypeIdentifier, .memberTypeIdentifier, .classRestrictionType, .arrayType, .dictionaryType, .metatypeType, .optionalType, .constrainedSugarType, .implicitlyUnwrappedOptionalType, .compositionType, .packExpansionType, .tupleType, .functionType, .attributedType, .namedOpaqueReturnType: return true
    default: return false
    }
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init<Node: RawTypeSyntaxNodeProtocol>(_ other: Node) {
    self.init(raw: other.raw)
  }
}

@_spi(RawSyntax)
public struct RawPatternSyntax: RawPatternSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PatternSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    switch raw.kind {
    case .unknownPattern, .missingPattern, .enumCasePattern, .isTypePattern, .optionalPattern, .identifierPattern, .asTypePattern, .tuplePattern, .wildcardPattern, .expressionPattern, .valueBindingPattern: return true
    default: return false
    }
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init<Node: RawPatternSyntaxNodeProtocol>(_ other: Node) {
    self.init(raw: other.raw)
  }
}

@_spi(RawSyntax)
public struct RawUnknownDeclSyntax: RawDeclSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = UnknownDeclSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .unknownDecl
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

}

@_spi(RawSyntax)
public struct RawUnknownExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = UnknownExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .unknownExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

}

@_spi(RawSyntax)
public struct RawUnknownStmtSyntax: RawStmtSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = UnknownStmtSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .unknownStmt
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

}

@_spi(RawSyntax)
public struct RawUnknownTypeSyntax: RawTypeSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = UnknownTypeSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .unknownType
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

}

@_spi(RawSyntax)
public struct RawUnknownPatternSyntax: RawPatternSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = UnknownPatternSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .unknownPattern
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

}

@_spi(RawSyntax)
public struct RawMissingSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = MissingSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .missing
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeEmptyLayout(kind: .missing, arena: arena)
    self.init(raw: raw)
  }

}

@_spi(RawSyntax)
public struct RawMissingDeclSyntax: RawDeclSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = MissingDeclSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .missingDecl
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .missingDecl, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = unexpectedBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    layoutView.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    layoutView.children[3].map(RawModifierListSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawMissingExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = MissingExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .missingExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeEmptyLayout(kind: .missingExpr, arena: arena)
    self.init(raw: raw)
  }

}

@_spi(RawSyntax)
public struct RawMissingStmtSyntax: RawStmtSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = MissingStmtSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .missingStmt
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeEmptyLayout(kind: .missingStmt, arena: arena)
    self.init(raw: raw)
  }

}

@_spi(RawSyntax)
public struct RawMissingTypeSyntax: RawTypeSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = MissingTypeSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .missingType
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeEmptyLayout(kind: .missingType, arena: arena)
    self.init(raw: raw)
  }

}

@_spi(RawSyntax)
public struct RawMissingPatternSyntax: RawPatternSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = MissingPatternSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .missingPattern
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeEmptyLayout(kind: .missingPattern, arena: arena)
    self.init(raw: raw)
  }

}

@_spi(RawSyntax)
public struct RawCodeBlockItemSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = CodeBlockItemSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .codeBlockItem
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeItem: RawUnexpectedNodesSyntax? = nil,
    item: RawSyntax,
    _ unexpectedBetweenItemAndSemicolon: RawUnexpectedNodesSyntax? = nil,
    semicolon: RawTokenSyntax?,
    _ unexpectedBetweenSemicolonAndErrorTokens: RawUnexpectedNodesSyntax? = nil,
    errorTokens: RawSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .codeBlockItem, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeItem?.raw
      layout[1] = item.raw
      layout[2] = unexpectedBetweenItemAndSemicolon?.raw
      layout[3] = semicolon?.raw
      layout[4] = unexpectedBetweenSemicolonAndErrorTokens?.raw
      layout[5] = errorTokens?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeItem: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var item: RawSyntax {
    layoutView.children[1]!
  }
  public var unexpectedBetweenItemAndSemicolon: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var semicolon: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenSemicolonAndErrorTokens: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var errorTokens: RawSyntax? {
    layoutView.children[5]
  }
}

@_spi(RawSyntax)
public struct RawCodeBlockItemListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = CodeBlockItemListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .codeBlockItemList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawCodeBlockItemSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .codeBlockItemList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawCodeBlockItemSyntax] {
    layoutView.children.map { RawCodeBlockItemSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawCodeBlockSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = CodeBlockSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .codeBlock
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftBrace: RawUnexpectedNodesSyntax? = nil,
    leftBrace: RawTokenSyntax,
    _ unexpectedBetweenLeftBraceAndStatements: RawUnexpectedNodesSyntax? = nil,
    statements: RawCodeBlockItemListSyntax,
    _ unexpectedBetweenStatementsAndRightBrace: RawUnexpectedNodesSyntax? = nil,
    rightBrace: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .codeBlock, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftBrace?.raw
      layout[1] = leftBrace.raw
      layout[2] = unexpectedBetweenLeftBraceAndStatements?.raw
      layout[3] = statements.raw
      layout[4] = unexpectedBetweenStatementsAndRightBrace?.raw
      layout[5] = rightBrace.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftBrace: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftBrace: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftBraceAndStatements: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var statements: RawCodeBlockItemListSyntax {
    layoutView.children[3].map(RawCodeBlockItemListSyntax.init(raw:))!
  }
  public var unexpectedBetweenStatementsAndRightBrace: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightBrace: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawUnexpectedNodesSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = UnexpectedNodesSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .unexpectedNodes
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .unexpectedNodes, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawSyntax] {
    layoutView.children.map { RawSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawInOutExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = InOutExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .inOutExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAmpersand: RawUnexpectedNodesSyntax? = nil,
    ampersand: RawTokenSyntax,
    _ unexpectedBetweenAmpersandAndExpression: RawUnexpectedNodesSyntax? = nil,
    expression: RawExprSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .inOutExpr, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAmpersand?.raw
      layout[1] = ampersand.raw
      layout[2] = unexpectedBetweenAmpersandAndExpression?.raw
      layout[3] = expression.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAmpersand: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var ampersand: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenAmpersandAndExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    layoutView.children[3].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPoundColumnExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PoundColumnExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .poundColumnExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforePoundColumn: RawUnexpectedNodesSyntax? = nil,
    poundColumn: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .poundColumnExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforePoundColumn?.raw
      layout[1] = poundColumn.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforePoundColumn: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var poundColumn: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawTupleExprElementListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = TupleExprElementListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .tupleExprElementList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawTupleExprElementSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .tupleExprElementList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawTupleExprElementSyntax] {
    layoutView.children.map { RawTupleExprElementSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawArrayElementListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ArrayElementListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .arrayElementList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawArrayElementSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .arrayElementList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawArrayElementSyntax] {
    layoutView.children.map { RawArrayElementSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawDictionaryElementListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = DictionaryElementListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .dictionaryElementList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawDictionaryElementSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .dictionaryElementList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawDictionaryElementSyntax] {
    layoutView.children.map { RawDictionaryElementSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawStringLiteralSegmentsSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = StringLiteralSegmentsSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .stringLiteralSegments
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .stringLiteralSegments, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawSyntax] {
    layoutView.children.map { RawSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawTryExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = TryExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .tryExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeTryKeyword: RawUnexpectedNodesSyntax? = nil,
    tryKeyword: RawTokenSyntax,
    _ unexpectedBetweenTryKeywordAndQuestionOrExclamationMark: RawUnexpectedNodesSyntax? = nil,
    questionOrExclamationMark: RawTokenSyntax?,
    _ unexpectedBetweenQuestionOrExclamationMarkAndExpression: RawUnexpectedNodesSyntax? = nil,
    expression: RawExprSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .tryExpr, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeTryKeyword?.raw
      layout[1] = tryKeyword.raw
      layout[2] = unexpectedBetweenTryKeywordAndQuestionOrExclamationMark?.raw
      layout[3] = questionOrExclamationMark?.raw
      layout[4] = unexpectedBetweenQuestionOrExclamationMarkAndExpression?.raw
      layout[5] = expression.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeTryKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var tryKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenTryKeywordAndQuestionOrExclamationMark: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var questionOrExclamationMark: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenQuestionOrExclamationMarkAndExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    layoutView.children[5].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawAwaitExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = AwaitExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .awaitExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAwaitKeyword: RawUnexpectedNodesSyntax? = nil,
    awaitKeyword: RawTokenSyntax,
    _ unexpectedBetweenAwaitKeywordAndExpression: RawUnexpectedNodesSyntax? = nil,
    expression: RawExprSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .awaitExpr, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAwaitKeyword?.raw
      layout[1] = awaitKeyword.raw
      layout[2] = unexpectedBetweenAwaitKeywordAndExpression?.raw
      layout[3] = expression.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAwaitKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var awaitKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenAwaitKeywordAndExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    layoutView.children[3].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawMoveExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = MoveExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .moveExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeMoveKeyword: RawUnexpectedNodesSyntax? = nil,
    moveKeyword: RawTokenSyntax,
    _ unexpectedBetweenMoveKeywordAndExpression: RawUnexpectedNodesSyntax? = nil,
    expression: RawExprSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .moveExpr, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeMoveKeyword?.raw
      layout[1] = moveKeyword.raw
      layout[2] = unexpectedBetweenMoveKeywordAndExpression?.raw
      layout[3] = expression.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeMoveKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var moveKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenMoveKeywordAndExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    layoutView.children[3].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawDeclNameArgumentSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = DeclNameArgumentSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .declNameArgument
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeName: RawUnexpectedNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ unexpectedBetweenNameAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .declNameArgument, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeName?.raw
      layout[1] = name.raw
      layout[2] = unexpectedBetweenNameAndColon?.raw
      layout[3] = colon.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeName: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawDeclNameArgumentListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = DeclNameArgumentListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .declNameArgumentList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawDeclNameArgumentSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .declNameArgumentList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawDeclNameArgumentSyntax] {
    layoutView.children.map { RawDeclNameArgumentSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawDeclNameArgumentsSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = DeclNameArgumentsSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .declNameArguments
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ unexpectedBetweenLeftParenAndArguments: RawUnexpectedNodesSyntax? = nil,
    arguments: RawDeclNameArgumentListSyntax,
    _ unexpectedBetweenArgumentsAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .declNameArguments, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftParen?.raw
      layout[1] = leftParen.raw
      layout[2] = unexpectedBetweenLeftParenAndArguments?.raw
      layout[3] = arguments.raw
      layout[4] = unexpectedBetweenArgumentsAndRightParen?.raw
      layout[5] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndArguments: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var arguments: RawDeclNameArgumentListSyntax {
    layoutView.children[3].map(RawDeclNameArgumentListSyntax.init(raw:))!
  }
  public var unexpectedBetweenArgumentsAndRightParen: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawIdentifierExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = IdentifierExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .identifierExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ unexpectedBetweenIdentifierAndDeclNameArguments: RawUnexpectedNodesSyntax? = nil,
    declNameArguments: RawDeclNameArgumentsSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .identifierExpr, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeIdentifier?.raw
      layout[1] = identifier.raw
      layout[2] = unexpectedBetweenIdentifierAndDeclNameArguments?.raw
      layout[3] = declNameArguments?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndDeclNameArguments: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var declNameArguments: RawDeclNameArgumentsSyntax? {
    layoutView.children[3].map(RawDeclNameArgumentsSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawSuperRefExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = SuperRefExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .superRefExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeSuperKeyword: RawUnexpectedNodesSyntax? = nil,
    superKeyword: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .superRefExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeSuperKeyword?.raw
      layout[1] = superKeyword.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeSuperKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var superKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawNilLiteralExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = NilLiteralExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .nilLiteralExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeNilKeyword: RawUnexpectedNodesSyntax? = nil,
    nilKeyword: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .nilLiteralExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeNilKeyword?.raw
      layout[1] = nilKeyword.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeNilKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var nilKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawDiscardAssignmentExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = DiscardAssignmentExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .discardAssignmentExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeWildcard: RawUnexpectedNodesSyntax? = nil,
    wildcard: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .discardAssignmentExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeWildcard?.raw
      layout[1] = wildcard.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeWildcard: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var wildcard: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawAssignmentExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = AssignmentExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .assignmentExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAssignToken: RawUnexpectedNodesSyntax? = nil,
    assignToken: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .assignmentExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAssignToken?.raw
      layout[1] = assignToken.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAssignToken: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var assignToken: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawSequenceExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = SequenceExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .sequenceExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeElements: RawUnexpectedNodesSyntax? = nil,
    elements: RawExprListSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .sequenceExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeElements?.raw
      layout[1] = elements.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeElements: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var elements: RawExprListSyntax {
    layoutView.children[1].map(RawExprListSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawExprListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ExprListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .exprList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawExprSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .exprList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawExprSyntax] {
    layoutView.children.map { RawExprSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawPoundLineExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PoundLineExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .poundLineExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforePoundLine: RawUnexpectedNodesSyntax? = nil,
    poundLine: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .poundLineExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforePoundLine?.raw
      layout[1] = poundLine.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforePoundLine: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var poundLine: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPoundFileExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PoundFileExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .poundFileExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforePoundFile: RawUnexpectedNodesSyntax? = nil,
    poundFile: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .poundFileExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforePoundFile?.raw
      layout[1] = poundFile.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforePoundFile: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var poundFile: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPoundFileIDExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PoundFileIDExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .poundFileIDExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforePoundFileID: RawUnexpectedNodesSyntax? = nil,
    poundFileID: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .poundFileIDExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforePoundFileID?.raw
      layout[1] = poundFileID.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforePoundFileID: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var poundFileID: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPoundFilePathExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PoundFilePathExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .poundFilePathExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforePoundFilePath: RawUnexpectedNodesSyntax? = nil,
    poundFilePath: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .poundFilePathExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforePoundFilePath?.raw
      layout[1] = poundFilePath.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforePoundFilePath: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var poundFilePath: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPoundFunctionExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PoundFunctionExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .poundFunctionExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforePoundFunction: RawUnexpectedNodesSyntax? = nil,
    poundFunction: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .poundFunctionExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforePoundFunction?.raw
      layout[1] = poundFunction.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforePoundFunction: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var poundFunction: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPoundDsohandleExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PoundDsohandleExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .poundDsohandleExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforePoundDsohandle: RawUnexpectedNodesSyntax? = nil,
    poundDsohandle: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .poundDsohandleExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforePoundDsohandle?.raw
      layout[1] = poundDsohandle.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforePoundDsohandle: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var poundDsohandle: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawSymbolicReferenceExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = SymbolicReferenceExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .symbolicReferenceExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ unexpectedBetweenIdentifierAndGenericArgumentClause: RawUnexpectedNodesSyntax? = nil,
    genericArgumentClause: RawGenericArgumentClauseSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .symbolicReferenceExpr, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeIdentifier?.raw
      layout[1] = identifier.raw
      layout[2] = unexpectedBetweenIdentifierAndGenericArgumentClause?.raw
      layout[3] = genericArgumentClause?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndGenericArgumentClause: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericArgumentClause: RawGenericArgumentClauseSyntax? {
    layoutView.children[3].map(RawGenericArgumentClauseSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawPrefixOperatorExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PrefixOperatorExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .prefixOperatorExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeOperatorToken: RawUnexpectedNodesSyntax? = nil,
    operatorToken: RawTokenSyntax?,
    _ unexpectedBetweenOperatorTokenAndPostfixExpression: RawUnexpectedNodesSyntax? = nil,
    postfixExpression: RawExprSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .prefixOperatorExpr, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeOperatorToken?.raw
      layout[1] = operatorToken?.raw
      layout[2] = unexpectedBetweenOperatorTokenAndPostfixExpression?.raw
      layout[3] = postfixExpression.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeOperatorToken: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var operatorToken: RawTokenSyntax? {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenOperatorTokenAndPostfixExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var postfixExpression: RawExprSyntax {
    layoutView.children[3].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawBinaryOperatorExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = BinaryOperatorExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .binaryOperatorExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeOperatorToken: RawUnexpectedNodesSyntax? = nil,
    operatorToken: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .binaryOperatorExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeOperatorToken?.raw
      layout[1] = operatorToken.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeOperatorToken: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var operatorToken: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawArrowExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ArrowExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .arrowExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAsyncKeyword: RawUnexpectedNodesSyntax? = nil,
    asyncKeyword: RawTokenSyntax?,
    _ unexpectedBetweenAsyncKeywordAndThrowsToken: RawUnexpectedNodesSyntax? = nil,
    throwsToken: RawTokenSyntax?,
    _ unexpectedBetweenThrowsTokenAndArrowToken: RawUnexpectedNodesSyntax? = nil,
    arrowToken: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .arrowExpr, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAsyncKeyword?.raw
      layout[1] = asyncKeyword?.raw
      layout[2] = unexpectedBetweenAsyncKeywordAndThrowsToken?.raw
      layout[3] = throwsToken?.raw
      layout[4] = unexpectedBetweenThrowsTokenAndArrowToken?.raw
      layout[5] = arrowToken.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAsyncKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var asyncKeyword: RawTokenSyntax? {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenAsyncKeywordAndThrowsToken: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var throwsToken: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenThrowsTokenAndArrowToken: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var arrowToken: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawInfixOperatorExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = InfixOperatorExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .infixOperatorExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftOperand: RawUnexpectedNodesSyntax? = nil,
    leftOperand: RawExprSyntax,
    _ unexpectedBetweenLeftOperandAndOperatorOperand: RawUnexpectedNodesSyntax? = nil,
    operatorOperand: RawExprSyntax,
    _ unexpectedBetweenOperatorOperandAndRightOperand: RawUnexpectedNodesSyntax? = nil,
    rightOperand: RawExprSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .infixOperatorExpr, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftOperand?.raw
      layout[1] = leftOperand.raw
      layout[2] = unexpectedBetweenLeftOperandAndOperatorOperand?.raw
      layout[3] = operatorOperand.raw
      layout[4] = unexpectedBetweenOperatorOperandAndRightOperand?.raw
      layout[5] = rightOperand.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftOperand: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftOperand: RawExprSyntax {
    layoutView.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftOperandAndOperatorOperand: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var operatorOperand: RawExprSyntax {
    layoutView.children[3].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenOperatorOperandAndRightOperand: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightOperand: RawExprSyntax {
    layoutView.children[5].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawFloatLiteralExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = FloatLiteralExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .floatLiteralExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeFloatingDigits: RawUnexpectedNodesSyntax? = nil,
    floatingDigits: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .floatLiteralExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeFloatingDigits?.raw
      layout[1] = floatingDigits.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeFloatingDigits: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var floatingDigits: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawTupleExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = TupleExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .tupleExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ unexpectedBetweenLeftParenAndElementList: RawUnexpectedNodesSyntax? = nil,
    elementList: RawTupleExprElementListSyntax,
    _ unexpectedBetweenElementListAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .tupleExpr, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftParen?.raw
      layout[1] = leftParen.raw
      layout[2] = unexpectedBetweenLeftParenAndElementList?.raw
      layout[3] = elementList.raw
      layout[4] = unexpectedBetweenElementListAndRightParen?.raw
      layout[5] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndElementList: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var elementList: RawTupleExprElementListSyntax {
    layoutView.children[3].map(RawTupleExprElementListSyntax.init(raw:))!
  }
  public var unexpectedBetweenElementListAndRightParen: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawArrayExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ArrayExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .arrayExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftSquare: RawUnexpectedNodesSyntax? = nil,
    leftSquare: RawTokenSyntax,
    _ unexpectedBetweenLeftSquareAndElements: RawUnexpectedNodesSyntax? = nil,
    elements: RawArrayElementListSyntax,
    _ unexpectedBetweenElementsAndRightSquare: RawUnexpectedNodesSyntax? = nil,
    rightSquare: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .arrayExpr, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftSquare?.raw
      layout[1] = leftSquare.raw
      layout[2] = unexpectedBetweenLeftSquareAndElements?.raw
      layout[3] = elements.raw
      layout[4] = unexpectedBetweenElementsAndRightSquare?.raw
      layout[5] = rightSquare.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftSquare: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftSquare: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftSquareAndElements: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var elements: RawArrayElementListSyntax {
    layoutView.children[3].map(RawArrayElementListSyntax.init(raw:))!
  }
  public var unexpectedBetweenElementsAndRightSquare: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightSquare: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawDictionaryExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = DictionaryExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .dictionaryExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftSquare: RawUnexpectedNodesSyntax? = nil,
    leftSquare: RawTokenSyntax,
    _ unexpectedBetweenLeftSquareAndContent: RawUnexpectedNodesSyntax? = nil,
    content: RawSyntax,
    _ unexpectedBetweenContentAndRightSquare: RawUnexpectedNodesSyntax? = nil,
    rightSquare: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .dictionaryExpr, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftSquare?.raw
      layout[1] = leftSquare.raw
      layout[2] = unexpectedBetweenLeftSquareAndContent?.raw
      layout[3] = content.raw
      layout[4] = unexpectedBetweenContentAndRightSquare?.raw
      layout[5] = rightSquare.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftSquare: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftSquare: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftSquareAndContent: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var content: RawSyntax {
    layoutView.children[3]!
  }
  public var unexpectedBetweenContentAndRightSquare: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightSquare: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawTupleExprElementSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = TupleExprElementSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .tupleExprElement
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLabel: RawUnexpectedNodesSyntax? = nil,
    label: RawTokenSyntax?,
    _ unexpectedBetweenLabelAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax?,
    _ unexpectedBetweenColonAndExpression: RawUnexpectedNodesSyntax? = nil,
    expression: RawExprSyntax,
    _ unexpectedBetweenExpressionAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .tupleExprElement, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLabel?.raw
      layout[1] = label?.raw
      layout[2] = unexpectedBetweenLabelAndColon?.raw
      layout[3] = colon?.raw
      layout[4] = unexpectedBetweenColonAndExpression?.raw
      layout[5] = expression.raw
      layout[6] = unexpectedBetweenExpressionAndTrailingComma?.raw
      layout[7] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLabel: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var label: RawTokenSyntax? {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenLabelAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenColonAndExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    layoutView.children[5].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenExpressionAndTrailingComma: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawArrayElementSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ArrayElementSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .arrayElement
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeExpression: RawUnexpectedNodesSyntax? = nil,
    expression: RawExprSyntax,
    _ unexpectedBetweenExpressionAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .arrayElement, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeExpression?.raw
      layout[1] = expression.raw
      layout[2] = unexpectedBetweenExpressionAndTrailingComma?.raw
      layout[3] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    layoutView.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenExpressionAndTrailingComma: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawDictionaryElementSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = DictionaryElementSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .dictionaryElement
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeKeyExpression: RawUnexpectedNodesSyntax? = nil,
    keyExpression: RawExprSyntax,
    _ unexpectedBetweenKeyExpressionAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ unexpectedBetweenColonAndValueExpression: RawUnexpectedNodesSyntax? = nil,
    valueExpression: RawExprSyntax,
    _ unexpectedBetweenValueExpressionAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .dictionaryElement, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeKeyExpression?.raw
      layout[1] = keyExpression.raw
      layout[2] = unexpectedBetweenKeyExpressionAndColon?.raw
      layout[3] = colon.raw
      layout[4] = unexpectedBetweenColonAndValueExpression?.raw
      layout[5] = valueExpression.raw
      layout[6] = unexpectedBetweenValueExpressionAndTrailingComma?.raw
      layout[7] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeKeyExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var keyExpression: RawExprSyntax {
    layoutView.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenKeyExpressionAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndValueExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var valueExpression: RawExprSyntax {
    layoutView.children[5].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenValueExpressionAndTrailingComma: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawIntegerLiteralExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = IntegerLiteralExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .integerLiteralExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeDigits: RawUnexpectedNodesSyntax? = nil,
    digits: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .integerLiteralExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeDigits?.raw
      layout[1] = digits.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeDigits: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var digits: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawBooleanLiteralExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = BooleanLiteralExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .booleanLiteralExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeBooleanLiteral: RawUnexpectedNodesSyntax? = nil,
    booleanLiteral: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .booleanLiteralExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeBooleanLiteral?.raw
      layout[1] = booleanLiteral.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeBooleanLiteral: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var booleanLiteral: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawUnresolvedTernaryExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = UnresolvedTernaryExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .unresolvedTernaryExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeQuestionMark: RawUnexpectedNodesSyntax? = nil,
    questionMark: RawTokenSyntax,
    _ unexpectedBetweenQuestionMarkAndFirstChoice: RawUnexpectedNodesSyntax? = nil,
    firstChoice: RawExprSyntax,
    _ unexpectedBetweenFirstChoiceAndColonMark: RawUnexpectedNodesSyntax? = nil,
    colonMark: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .unresolvedTernaryExpr, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeQuestionMark?.raw
      layout[1] = questionMark.raw
      layout[2] = unexpectedBetweenQuestionMarkAndFirstChoice?.raw
      layout[3] = firstChoice.raw
      layout[4] = unexpectedBetweenFirstChoiceAndColonMark?.raw
      layout[5] = colonMark.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeQuestionMark: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var questionMark: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenQuestionMarkAndFirstChoice: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var firstChoice: RawExprSyntax {
    layoutView.children[3].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenFirstChoiceAndColonMark: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colonMark: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawTernaryExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = TernaryExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .ternaryExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeConditionExpression: RawUnexpectedNodesSyntax? = nil,
    conditionExpression: RawExprSyntax,
    _ unexpectedBetweenConditionExpressionAndQuestionMark: RawUnexpectedNodesSyntax? = nil,
    questionMark: RawTokenSyntax,
    _ unexpectedBetweenQuestionMarkAndFirstChoice: RawUnexpectedNodesSyntax? = nil,
    firstChoice: RawExprSyntax,
    _ unexpectedBetweenFirstChoiceAndColonMark: RawUnexpectedNodesSyntax? = nil,
    colonMark: RawTokenSyntax,
    _ unexpectedBetweenColonMarkAndSecondChoice: RawUnexpectedNodesSyntax? = nil,
    secondChoice: RawExprSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .ternaryExpr, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeConditionExpression?.raw
      layout[1] = conditionExpression.raw
      layout[2] = unexpectedBetweenConditionExpressionAndQuestionMark?.raw
      layout[3] = questionMark.raw
      layout[4] = unexpectedBetweenQuestionMarkAndFirstChoice?.raw
      layout[5] = firstChoice.raw
      layout[6] = unexpectedBetweenFirstChoiceAndColonMark?.raw
      layout[7] = colonMark.raw
      layout[8] = unexpectedBetweenColonMarkAndSecondChoice?.raw
      layout[9] = secondChoice.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeConditionExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var conditionExpression: RawExprSyntax {
    layoutView.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenConditionExpressionAndQuestionMark: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var questionMark: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenQuestionMarkAndFirstChoice: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var firstChoice: RawExprSyntax {
    layoutView.children[5].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenFirstChoiceAndColonMark: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colonMark: RawTokenSyntax {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonMarkAndSecondChoice: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var secondChoice: RawExprSyntax {
    layoutView.children[9].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawMemberAccessExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = MemberAccessExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .memberAccessExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeBase: RawUnexpectedNodesSyntax? = nil,
    base: RawExprSyntax?,
    _ unexpectedBetweenBaseAndDot: RawUnexpectedNodesSyntax? = nil,
    dot: RawTokenSyntax,
    _ unexpectedBetweenDotAndName: RawUnexpectedNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ unexpectedBetweenNameAndDeclNameArguments: RawUnexpectedNodesSyntax? = nil,
    declNameArguments: RawDeclNameArgumentsSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .memberAccessExpr, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeBase?.raw
      layout[1] = base?.raw
      layout[2] = unexpectedBetweenBaseAndDot?.raw
      layout[3] = dot.raw
      layout[4] = unexpectedBetweenDotAndName?.raw
      layout[5] = name.raw
      layout[6] = unexpectedBetweenNameAndDeclNameArguments?.raw
      layout[7] = declNameArguments?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeBase: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var base: RawExprSyntax? {
    layoutView.children[1].map(RawExprSyntax.init(raw:))
  }
  public var unexpectedBetweenBaseAndDot: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var dot: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenDotAndName: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndDeclNameArguments: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var declNameArguments: RawDeclNameArgumentsSyntax? {
    layoutView.children[7].map(RawDeclNameArgumentsSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawUnresolvedIsExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = UnresolvedIsExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .unresolvedIsExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeIsTok: RawUnexpectedNodesSyntax? = nil,
    isTok: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .unresolvedIsExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeIsTok?.raw
      layout[1] = isTok.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeIsTok: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var isTok: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawIsExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = IsExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .isExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeExpression: RawUnexpectedNodesSyntax? = nil,
    expression: RawExprSyntax,
    _ unexpectedBetweenExpressionAndIsTok: RawUnexpectedNodesSyntax? = nil,
    isTok: RawTokenSyntax,
    _ unexpectedBetweenIsTokAndTypeName: RawUnexpectedNodesSyntax? = nil,
    typeName: RawTypeSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .isExpr, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeExpression?.raw
      layout[1] = expression.raw
      layout[2] = unexpectedBetweenExpressionAndIsTok?.raw
      layout[3] = isTok.raw
      layout[4] = unexpectedBetweenIsTokAndTypeName?.raw
      layout[5] = typeName.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    layoutView.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenExpressionAndIsTok: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var isTok: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIsTokAndTypeName: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var typeName: RawTypeSyntax {
    layoutView.children[5].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawUnresolvedAsExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = UnresolvedAsExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .unresolvedAsExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAsTok: RawUnexpectedNodesSyntax? = nil,
    asTok: RawTokenSyntax,
    _ unexpectedBetweenAsTokAndQuestionOrExclamationMark: RawUnexpectedNodesSyntax? = nil,
    questionOrExclamationMark: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .unresolvedAsExpr, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAsTok?.raw
      layout[1] = asTok.raw
      layout[2] = unexpectedBetweenAsTokAndQuestionOrExclamationMark?.raw
      layout[3] = questionOrExclamationMark?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAsTok: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var asTok: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenAsTokAndQuestionOrExclamationMark: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var questionOrExclamationMark: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawAsExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = AsExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .asExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeExpression: RawUnexpectedNodesSyntax? = nil,
    expression: RawExprSyntax,
    _ unexpectedBetweenExpressionAndAsTok: RawUnexpectedNodesSyntax? = nil,
    asTok: RawTokenSyntax,
    _ unexpectedBetweenAsTokAndQuestionOrExclamationMark: RawUnexpectedNodesSyntax? = nil,
    questionOrExclamationMark: RawTokenSyntax?,
    _ unexpectedBetweenQuestionOrExclamationMarkAndTypeName: RawUnexpectedNodesSyntax? = nil,
    typeName: RawTypeSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .asExpr, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeExpression?.raw
      layout[1] = expression.raw
      layout[2] = unexpectedBetweenExpressionAndAsTok?.raw
      layout[3] = asTok.raw
      layout[4] = unexpectedBetweenAsTokAndQuestionOrExclamationMark?.raw
      layout[5] = questionOrExclamationMark?.raw
      layout[6] = unexpectedBetweenQuestionOrExclamationMarkAndTypeName?.raw
      layout[7] = typeName.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    layoutView.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenExpressionAndAsTok: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var asTok: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenAsTokAndQuestionOrExclamationMark: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var questionOrExclamationMark: RawTokenSyntax? {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenQuestionOrExclamationMarkAndTypeName: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var typeName: RawTypeSyntax {
    layoutView.children[7].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawTypeExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = TypeExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .typeExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeType: RawUnexpectedNodesSyntax? = nil,
    type: RawTypeSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .typeExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeType?.raw
      layout[1] = type.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeType: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var type: RawTypeSyntax {
    layoutView.children[1].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawClosureCaptureItemSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ClosureCaptureItemSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .closureCaptureItem
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeSpecifier: RawUnexpectedNodesSyntax? = nil,
    specifier: RawTokenListSyntax?,
    _ unexpectedBetweenSpecifierAndName: RawUnexpectedNodesSyntax? = nil,
    name: RawTokenSyntax?,
    _ unexpectedBetweenNameAndAssignToken: RawUnexpectedNodesSyntax? = nil,
    assignToken: RawTokenSyntax?,
    _ unexpectedBetweenAssignTokenAndExpression: RawUnexpectedNodesSyntax? = nil,
    expression: RawExprSyntax,
    _ unexpectedBetweenExpressionAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .closureCaptureItem, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeSpecifier?.raw
      layout[1] = specifier?.raw
      layout[2] = unexpectedBetweenSpecifierAndName?.raw
      layout[3] = name?.raw
      layout[4] = unexpectedBetweenNameAndAssignToken?.raw
      layout[5] = assignToken?.raw
      layout[6] = unexpectedBetweenAssignTokenAndExpression?.raw
      layout[7] = expression.raw
      layout[8] = unexpectedBetweenExpressionAndTrailingComma?.raw
      layout[9] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeSpecifier: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var specifier: RawTokenListSyntax? {
    layoutView.children[1].map(RawTokenListSyntax.init(raw:))
  }
  public var unexpectedBetweenSpecifierAndName: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenNameAndAssignToken: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var assignToken: RawTokenSyntax? {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenAssignTokenAndExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    layoutView.children[7].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenExpressionAndTrailingComma: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    layoutView.children[9].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawClosureCaptureItemListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ClosureCaptureItemListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .closureCaptureItemList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawClosureCaptureItemSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .closureCaptureItemList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawClosureCaptureItemSyntax] {
    layoutView.children.map { RawClosureCaptureItemSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawClosureCaptureSignatureSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ClosureCaptureSignatureSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .closureCaptureSignature
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftSquare: RawUnexpectedNodesSyntax? = nil,
    leftSquare: RawTokenSyntax,
    _ unexpectedBetweenLeftSquareAndItems: RawUnexpectedNodesSyntax? = nil,
    items: RawClosureCaptureItemListSyntax?,
    _ unexpectedBetweenItemsAndRightSquare: RawUnexpectedNodesSyntax? = nil,
    rightSquare: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .closureCaptureSignature, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftSquare?.raw
      layout[1] = leftSquare.raw
      layout[2] = unexpectedBetweenLeftSquareAndItems?.raw
      layout[3] = items?.raw
      layout[4] = unexpectedBetweenItemsAndRightSquare?.raw
      layout[5] = rightSquare.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftSquare: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftSquare: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftSquareAndItems: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var items: RawClosureCaptureItemListSyntax? {
    layoutView.children[3].map(RawClosureCaptureItemListSyntax.init(raw:))
  }
  public var unexpectedBetweenItemsAndRightSquare: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightSquare: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawClosureParamSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ClosureParamSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .closureParam
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeName: RawUnexpectedNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ unexpectedBetweenNameAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .closureParam, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeName?.raw
      layout[1] = name.raw
      layout[2] = unexpectedBetweenNameAndTrailingComma?.raw
      layout[3] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeName: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndTrailingComma: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawClosureParamListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ClosureParamListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .closureParamList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawClosureParamSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .closureParamList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawClosureParamSyntax] {
    layoutView.children.map { RawClosureParamSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawClosureSignatureSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ClosureSignatureSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .closureSignature
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ unexpectedBetweenAttributesAndCapture: RawUnexpectedNodesSyntax? = nil,
    capture: RawClosureCaptureSignatureSyntax?,
    _ unexpectedBetweenCaptureAndInput: RawUnexpectedNodesSyntax? = nil,
    input: RawSyntax?,
    _ unexpectedBetweenInputAndAsyncKeyword: RawUnexpectedNodesSyntax? = nil,
    asyncKeyword: RawTokenSyntax?,
    _ unexpectedBetweenAsyncKeywordAndThrowsTok: RawUnexpectedNodesSyntax? = nil,
    throwsTok: RawTokenSyntax?,
    _ unexpectedBetweenThrowsTokAndOutput: RawUnexpectedNodesSyntax? = nil,
    output: RawReturnClauseSyntax?,
    _ unexpectedBetweenOutputAndInTok: RawUnexpectedNodesSyntax? = nil,
    inTok: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .closureSignature, uninitializedCount: 14, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = unexpectedBetweenAttributesAndCapture?.raw
      layout[3] = capture?.raw
      layout[4] = unexpectedBetweenCaptureAndInput?.raw
      layout[5] = input?.raw
      layout[6] = unexpectedBetweenInputAndAsyncKeyword?.raw
      layout[7] = asyncKeyword?.raw
      layout[8] = unexpectedBetweenAsyncKeywordAndThrowsTok?.raw
      layout[9] = throwsTok?.raw
      layout[10] = unexpectedBetweenThrowsTokAndOutput?.raw
      layout[11] = output?.raw
      layout[12] = unexpectedBetweenOutputAndInTok?.raw
      layout[13] = inTok.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    layoutView.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndCapture: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var capture: RawClosureCaptureSignatureSyntax? {
    layoutView.children[3].map(RawClosureCaptureSignatureSyntax.init(raw:))
  }
  public var unexpectedBetweenCaptureAndInput: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var input: RawSyntax? {
    layoutView.children[5]
  }
  public var unexpectedBetweenInputAndAsyncKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var asyncKeyword: RawTokenSyntax? {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenAsyncKeywordAndThrowsTok: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var throwsTok: RawTokenSyntax? {
    layoutView.children[9].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenThrowsTokAndOutput: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var output: RawReturnClauseSyntax? {
    layoutView.children[11].map(RawReturnClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenOutputAndInTok: RawUnexpectedNodesSyntax? {
    layoutView.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var inTok: RawTokenSyntax {
    layoutView.children[13].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawClosureExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ClosureExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .closureExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftBrace: RawUnexpectedNodesSyntax? = nil,
    leftBrace: RawTokenSyntax,
    _ unexpectedBetweenLeftBraceAndSignature: RawUnexpectedNodesSyntax? = nil,
    signature: RawClosureSignatureSyntax?,
    _ unexpectedBetweenSignatureAndStatements: RawUnexpectedNodesSyntax? = nil,
    statements: RawCodeBlockItemListSyntax,
    _ unexpectedBetweenStatementsAndRightBrace: RawUnexpectedNodesSyntax? = nil,
    rightBrace: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .closureExpr, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftBrace?.raw
      layout[1] = leftBrace.raw
      layout[2] = unexpectedBetweenLeftBraceAndSignature?.raw
      layout[3] = signature?.raw
      layout[4] = unexpectedBetweenSignatureAndStatements?.raw
      layout[5] = statements.raw
      layout[6] = unexpectedBetweenStatementsAndRightBrace?.raw
      layout[7] = rightBrace.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftBrace: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftBrace: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftBraceAndSignature: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var signature: RawClosureSignatureSyntax? {
    layoutView.children[3].map(RawClosureSignatureSyntax.init(raw:))
  }
  public var unexpectedBetweenSignatureAndStatements: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var statements: RawCodeBlockItemListSyntax {
    layoutView.children[5].map(RawCodeBlockItemListSyntax.init(raw:))!
  }
  public var unexpectedBetweenStatementsAndRightBrace: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightBrace: RawTokenSyntax {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawUnresolvedPatternExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = UnresolvedPatternExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .unresolvedPatternExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforePattern: RawUnexpectedNodesSyntax? = nil,
    pattern: RawPatternSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .unresolvedPatternExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforePattern?.raw
      layout[1] = pattern.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforePattern: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax {
    layoutView.children[1].map(RawPatternSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawMultipleTrailingClosureElementSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = MultipleTrailingClosureElementSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .multipleTrailingClosureElement
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLabel: RawUnexpectedNodesSyntax? = nil,
    label: RawTokenSyntax,
    _ unexpectedBetweenLabelAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ unexpectedBetweenColonAndClosure: RawUnexpectedNodesSyntax? = nil,
    closure: RawClosureExprSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .multipleTrailingClosureElement, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLabel?.raw
      layout[1] = label.raw
      layout[2] = unexpectedBetweenLabelAndColon?.raw
      layout[3] = colon.raw
      layout[4] = unexpectedBetweenColonAndClosure?.raw
      layout[5] = closure.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLabel: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var label: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLabelAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndClosure: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var closure: RawClosureExprSyntax {
    layoutView.children[5].map(RawClosureExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawMultipleTrailingClosureElementListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = MultipleTrailingClosureElementListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .multipleTrailingClosureElementList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawMultipleTrailingClosureElementSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .multipleTrailingClosureElementList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawMultipleTrailingClosureElementSyntax] {
    layoutView.children.map { RawMultipleTrailingClosureElementSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawFunctionCallExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = FunctionCallExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .functionCallExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeCalledExpression: RawUnexpectedNodesSyntax? = nil,
    calledExpression: RawExprSyntax,
    _ unexpectedBetweenCalledExpressionAndLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax?,
    _ unexpectedBetweenLeftParenAndArgumentList: RawUnexpectedNodesSyntax? = nil,
    argumentList: RawTupleExprElementListSyntax,
    _ unexpectedBetweenArgumentListAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax?,
    _ unexpectedBetweenRightParenAndTrailingClosure: RawUnexpectedNodesSyntax? = nil,
    trailingClosure: RawClosureExprSyntax?,
    _ unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: RawUnexpectedNodesSyntax? = nil,
    additionalTrailingClosures: RawMultipleTrailingClosureElementListSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .functionCallExpr, uninitializedCount: 12, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeCalledExpression?.raw
      layout[1] = calledExpression.raw
      layout[2] = unexpectedBetweenCalledExpressionAndLeftParen?.raw
      layout[3] = leftParen?.raw
      layout[4] = unexpectedBetweenLeftParenAndArgumentList?.raw
      layout[5] = argumentList.raw
      layout[6] = unexpectedBetweenArgumentListAndRightParen?.raw
      layout[7] = rightParen?.raw
      layout[8] = unexpectedBetweenRightParenAndTrailingClosure?.raw
      layout[9] = trailingClosure?.raw
      layout[10] = unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures?.raw
      layout[11] = additionalTrailingClosures?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeCalledExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var calledExpression: RawExprSyntax {
    layoutView.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenCalledExpressionAndLeftParen: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenLeftParenAndArgumentList: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var argumentList: RawTupleExprElementListSyntax {
    layoutView.children[5].map(RawTupleExprElementListSyntax.init(raw:))!
  }
  public var unexpectedBetweenArgumentListAndRightParen: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax? {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenRightParenAndTrailingClosure: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingClosure: RawClosureExprSyntax? {
    layoutView.children[9].map(RawClosureExprSyntax.init(raw:))
  }
  public var unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var additionalTrailingClosures: RawMultipleTrailingClosureElementListSyntax? {
    layoutView.children[11].map(RawMultipleTrailingClosureElementListSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawSubscriptExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = SubscriptExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .subscriptExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeCalledExpression: RawUnexpectedNodesSyntax? = nil,
    calledExpression: RawExprSyntax,
    _ unexpectedBetweenCalledExpressionAndLeftBracket: RawUnexpectedNodesSyntax? = nil,
    leftBracket: RawTokenSyntax,
    _ unexpectedBetweenLeftBracketAndArgumentList: RawUnexpectedNodesSyntax? = nil,
    argumentList: RawTupleExprElementListSyntax,
    _ unexpectedBetweenArgumentListAndRightBracket: RawUnexpectedNodesSyntax? = nil,
    rightBracket: RawTokenSyntax,
    _ unexpectedBetweenRightBracketAndTrailingClosure: RawUnexpectedNodesSyntax? = nil,
    trailingClosure: RawClosureExprSyntax?,
    _ unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: RawUnexpectedNodesSyntax? = nil,
    additionalTrailingClosures: RawMultipleTrailingClosureElementListSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .subscriptExpr, uninitializedCount: 12, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeCalledExpression?.raw
      layout[1] = calledExpression.raw
      layout[2] = unexpectedBetweenCalledExpressionAndLeftBracket?.raw
      layout[3] = leftBracket.raw
      layout[4] = unexpectedBetweenLeftBracketAndArgumentList?.raw
      layout[5] = argumentList.raw
      layout[6] = unexpectedBetweenArgumentListAndRightBracket?.raw
      layout[7] = rightBracket.raw
      layout[8] = unexpectedBetweenRightBracketAndTrailingClosure?.raw
      layout[9] = trailingClosure?.raw
      layout[10] = unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures?.raw
      layout[11] = additionalTrailingClosures?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeCalledExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var calledExpression: RawExprSyntax {
    layoutView.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenCalledExpressionAndLeftBracket: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftBracket: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftBracketAndArgumentList: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var argumentList: RawTupleExprElementListSyntax {
    layoutView.children[5].map(RawTupleExprElementListSyntax.init(raw:))!
  }
  public var unexpectedBetweenArgumentListAndRightBracket: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightBracket: RawTokenSyntax {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenRightBracketAndTrailingClosure: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingClosure: RawClosureExprSyntax? {
    layoutView.children[9].map(RawClosureExprSyntax.init(raw:))
  }
  public var unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var additionalTrailingClosures: RawMultipleTrailingClosureElementListSyntax? {
    layoutView.children[11].map(RawMultipleTrailingClosureElementListSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawOptionalChainingExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = OptionalChainingExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .optionalChainingExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeExpression: RawUnexpectedNodesSyntax? = nil,
    expression: RawExprSyntax,
    _ unexpectedBetweenExpressionAndQuestionMark: RawUnexpectedNodesSyntax? = nil,
    questionMark: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .optionalChainingExpr, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeExpression?.raw
      layout[1] = expression.raw
      layout[2] = unexpectedBetweenExpressionAndQuestionMark?.raw
      layout[3] = questionMark.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    layoutView.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenExpressionAndQuestionMark: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var questionMark: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawForcedValueExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ForcedValueExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .forcedValueExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeExpression: RawUnexpectedNodesSyntax? = nil,
    expression: RawExprSyntax,
    _ unexpectedBetweenExpressionAndExclamationMark: RawUnexpectedNodesSyntax? = nil,
    exclamationMark: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .forcedValueExpr, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeExpression?.raw
      layout[1] = expression.raw
      layout[2] = unexpectedBetweenExpressionAndExclamationMark?.raw
      layout[3] = exclamationMark.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    layoutView.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenExpressionAndExclamationMark: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var exclamationMark: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPostfixUnaryExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PostfixUnaryExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .postfixUnaryExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeExpression: RawUnexpectedNodesSyntax? = nil,
    expression: RawExprSyntax,
    _ unexpectedBetweenExpressionAndOperatorToken: RawUnexpectedNodesSyntax? = nil,
    operatorToken: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .postfixUnaryExpr, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeExpression?.raw
      layout[1] = expression.raw
      layout[2] = unexpectedBetweenExpressionAndOperatorToken?.raw
      layout[3] = operatorToken.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    layoutView.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenExpressionAndOperatorToken: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var operatorToken: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawSpecializeExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = SpecializeExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .specializeExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeExpression: RawUnexpectedNodesSyntax? = nil,
    expression: RawExprSyntax,
    _ unexpectedBetweenExpressionAndGenericArgumentClause: RawUnexpectedNodesSyntax? = nil,
    genericArgumentClause: RawGenericArgumentClauseSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .specializeExpr, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeExpression?.raw
      layout[1] = expression.raw
      layout[2] = unexpectedBetweenExpressionAndGenericArgumentClause?.raw
      layout[3] = genericArgumentClause.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    layoutView.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenExpressionAndGenericArgumentClause: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericArgumentClause: RawGenericArgumentClauseSyntax {
    layoutView.children[3].map(RawGenericArgumentClauseSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawStringSegmentSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = StringSegmentSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .stringSegment
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeContent: RawUnexpectedNodesSyntax? = nil,
    content: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .stringSegment, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeContent?.raw
      layout[1] = content.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeContent: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var content: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawExpressionSegmentSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ExpressionSegmentSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .expressionSegment
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeBackslash: RawUnexpectedNodesSyntax? = nil,
    backslash: RawTokenSyntax,
    _ unexpectedBetweenBackslashAndDelimiter: RawUnexpectedNodesSyntax? = nil,
    delimiter: RawTokenSyntax?,
    _ unexpectedBetweenDelimiterAndLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ unexpectedBetweenLeftParenAndExpressions: RawUnexpectedNodesSyntax? = nil,
    expressions: RawTupleExprElementListSyntax,
    _ unexpectedBetweenExpressionsAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .expressionSegment, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeBackslash?.raw
      layout[1] = backslash.raw
      layout[2] = unexpectedBetweenBackslashAndDelimiter?.raw
      layout[3] = delimiter?.raw
      layout[4] = unexpectedBetweenDelimiterAndLeftParen?.raw
      layout[5] = leftParen.raw
      layout[6] = unexpectedBetweenLeftParenAndExpressions?.raw
      layout[7] = expressions.raw
      layout[8] = unexpectedBetweenExpressionsAndRightParen?.raw
      layout[9] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeBackslash: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var backslash: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenBackslashAndDelimiter: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var delimiter: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenDelimiterAndLeftParen: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndExpressions: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expressions: RawTupleExprElementListSyntax {
    layoutView.children[7].map(RawTupleExprElementListSyntax.init(raw:))!
  }
  public var unexpectedBetweenExpressionsAndRightParen: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    layoutView.children[9].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawStringLiteralExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = StringLiteralExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .stringLiteralExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeOpenDelimiter: RawUnexpectedNodesSyntax? = nil,
    openDelimiter: RawTokenSyntax?,
    _ unexpectedBetweenOpenDelimiterAndOpenQuote: RawUnexpectedNodesSyntax? = nil,
    openQuote: RawTokenSyntax,
    _ unexpectedBetweenOpenQuoteAndSegments: RawUnexpectedNodesSyntax? = nil,
    segments: RawStringLiteralSegmentsSyntax,
    _ unexpectedBetweenSegmentsAndCloseQuote: RawUnexpectedNodesSyntax? = nil,
    closeQuote: RawTokenSyntax,
    _ unexpectedBetweenCloseQuoteAndCloseDelimiter: RawUnexpectedNodesSyntax? = nil,
    closeDelimiter: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .stringLiteralExpr, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeOpenDelimiter?.raw
      layout[1] = openDelimiter?.raw
      layout[2] = unexpectedBetweenOpenDelimiterAndOpenQuote?.raw
      layout[3] = openQuote.raw
      layout[4] = unexpectedBetweenOpenQuoteAndSegments?.raw
      layout[5] = segments.raw
      layout[6] = unexpectedBetweenSegmentsAndCloseQuote?.raw
      layout[7] = closeQuote.raw
      layout[8] = unexpectedBetweenCloseQuoteAndCloseDelimiter?.raw
      layout[9] = closeDelimiter?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeOpenDelimiter: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var openDelimiter: RawTokenSyntax? {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenOpenDelimiterAndOpenQuote: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var openQuote: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenOpenQuoteAndSegments: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var segments: RawStringLiteralSegmentsSyntax {
    layoutView.children[5].map(RawStringLiteralSegmentsSyntax.init(raw:))!
  }
  public var unexpectedBetweenSegmentsAndCloseQuote: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var closeQuote: RawTokenSyntax {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenCloseQuoteAndCloseDelimiter: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var closeDelimiter: RawTokenSyntax? {
    layoutView.children[9].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawRegexLiteralExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = RegexLiteralExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .regexLiteralExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeRegex: RawUnexpectedNodesSyntax? = nil,
    regex: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .regexLiteralExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeRegex?.raw
      layout[1] = regex.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeRegex: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var regex: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawKeyPathExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = KeyPathExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .keyPathExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeBackslash: RawUnexpectedNodesSyntax? = nil,
    backslash: RawTokenSyntax,
    _ unexpectedBetweenBackslashAndRoot: RawUnexpectedNodesSyntax? = nil,
    root: RawTypeSyntax?,
    _ unexpectedBetweenRootAndComponents: RawUnexpectedNodesSyntax? = nil,
    components: RawKeyPathComponentListSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .keyPathExpr, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeBackslash?.raw
      layout[1] = backslash.raw
      layout[2] = unexpectedBetweenBackslashAndRoot?.raw
      layout[3] = root?.raw
      layout[4] = unexpectedBetweenRootAndComponents?.raw
      layout[5] = components.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeBackslash: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var backslash: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenBackslashAndRoot: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var root: RawTypeSyntax? {
    layoutView.children[3].map(RawTypeSyntax.init(raw:))
  }
  public var unexpectedBetweenRootAndComponents: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var components: RawKeyPathComponentListSyntax {
    layoutView.children[5].map(RawKeyPathComponentListSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawKeyPathComponentListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = KeyPathComponentListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .keyPathComponentList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawKeyPathComponentSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .keyPathComponentList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawKeyPathComponentSyntax] {
    layoutView.children.map { RawKeyPathComponentSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawKeyPathComponentSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = KeyPathComponentSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .keyPathComponent
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforePeriod: RawUnexpectedNodesSyntax? = nil,
    period: RawTokenSyntax?,
    _ unexpectedBetweenPeriodAndComponent: RawUnexpectedNodesSyntax? = nil,
    component: RawSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .keyPathComponent, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforePeriod?.raw
      layout[1] = period?.raw
      layout[2] = unexpectedBetweenPeriodAndComponent?.raw
      layout[3] = component.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforePeriod: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var period: RawTokenSyntax? {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenPeriodAndComponent: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var component: RawSyntax {
    layoutView.children[3]!
  }
}

@_spi(RawSyntax)
public struct RawKeyPathPropertyComponentSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = KeyPathPropertyComponentSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .keyPathPropertyComponent
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ unexpectedBetweenIdentifierAndDeclNameArguments: RawUnexpectedNodesSyntax? = nil,
    declNameArguments: RawDeclNameArgumentsSyntax?,
    _ unexpectedBetweenDeclNameArgumentsAndGenericArgumentClause: RawUnexpectedNodesSyntax? = nil,
    genericArgumentClause: RawGenericArgumentClauseSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .keyPathPropertyComponent, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeIdentifier?.raw
      layout[1] = identifier.raw
      layout[2] = unexpectedBetweenIdentifierAndDeclNameArguments?.raw
      layout[3] = declNameArguments?.raw
      layout[4] = unexpectedBetweenDeclNameArgumentsAndGenericArgumentClause?.raw
      layout[5] = genericArgumentClause?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndDeclNameArguments: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var declNameArguments: RawDeclNameArgumentsSyntax? {
    layoutView.children[3].map(RawDeclNameArgumentsSyntax.init(raw:))
  }
  public var unexpectedBetweenDeclNameArgumentsAndGenericArgumentClause: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericArgumentClause: RawGenericArgumentClauseSyntax? {
    layoutView.children[5].map(RawGenericArgumentClauseSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawKeyPathSubscriptComponentSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = KeyPathSubscriptComponentSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .keyPathSubscriptComponent
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftBracket: RawUnexpectedNodesSyntax? = nil,
    leftBracket: RawTokenSyntax,
    _ unexpectedBetweenLeftBracketAndArgumentList: RawUnexpectedNodesSyntax? = nil,
    argumentList: RawTupleExprElementListSyntax,
    _ unexpectedBetweenArgumentListAndRightBracket: RawUnexpectedNodesSyntax? = nil,
    rightBracket: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .keyPathSubscriptComponent, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftBracket?.raw
      layout[1] = leftBracket.raw
      layout[2] = unexpectedBetweenLeftBracketAndArgumentList?.raw
      layout[3] = argumentList.raw
      layout[4] = unexpectedBetweenArgumentListAndRightBracket?.raw
      layout[5] = rightBracket.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftBracket: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftBracket: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftBracketAndArgumentList: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var argumentList: RawTupleExprElementListSyntax {
    layoutView.children[3].map(RawTupleExprElementListSyntax.init(raw:))!
  }
  public var unexpectedBetweenArgumentListAndRightBracket: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightBracket: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawKeyPathOptionalComponentSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = KeyPathOptionalComponentSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .keyPathOptionalComponent
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeQuestionOrExclamationMark: RawUnexpectedNodesSyntax? = nil,
    questionOrExclamationMark: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .keyPathOptionalComponent, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeQuestionOrExclamationMark?.raw
      layout[1] = questionOrExclamationMark.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeQuestionOrExclamationMark: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var questionOrExclamationMark: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawOldKeyPathExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = OldKeyPathExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .oldKeyPathExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeBackslash: RawUnexpectedNodesSyntax? = nil,
    backslash: RawTokenSyntax,
    _ unexpectedBetweenBackslashAndRootExpr: RawUnexpectedNodesSyntax? = nil,
    rootExpr: RawExprSyntax?,
    _ unexpectedBetweenRootExprAndExpression: RawUnexpectedNodesSyntax? = nil,
    expression: RawExprSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .oldKeyPathExpr, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeBackslash?.raw
      layout[1] = backslash.raw
      layout[2] = unexpectedBetweenBackslashAndRootExpr?.raw
      layout[3] = rootExpr?.raw
      layout[4] = unexpectedBetweenRootExprAndExpression?.raw
      layout[5] = expression.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeBackslash: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var backslash: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenBackslashAndRootExpr: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rootExpr: RawExprSyntax? {
    layoutView.children[3].map(RawExprSyntax.init(raw:))
  }
  public var unexpectedBetweenRootExprAndExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    layoutView.children[5].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawKeyPathBaseExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = KeyPathBaseExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .keyPathBaseExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforePeriod: RawUnexpectedNodesSyntax? = nil,
    period: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .keyPathBaseExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforePeriod?.raw
      layout[1] = period.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforePeriod: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var period: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawObjcNamePieceSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ObjcNamePieceSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .objcNamePiece
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeName: RawUnexpectedNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ unexpectedBetweenNameAndDot: RawUnexpectedNodesSyntax? = nil,
    dot: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .objcNamePiece, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeName?.raw
      layout[1] = name.raw
      layout[2] = unexpectedBetweenNameAndDot?.raw
      layout[3] = dot?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeName: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndDot: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var dot: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawObjcNameSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ObjcNameSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .objcName
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawObjcNamePieceSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .objcName, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawObjcNamePieceSyntax] {
    layoutView.children.map { RawObjcNamePieceSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawObjcKeyPathExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ObjcKeyPathExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .objcKeyPathExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeKeyPath: RawUnexpectedNodesSyntax? = nil,
    keyPath: RawTokenSyntax,
    _ unexpectedBetweenKeyPathAndLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ unexpectedBetweenLeftParenAndName: RawUnexpectedNodesSyntax? = nil,
    name: RawObjcNameSyntax,
    _ unexpectedBetweenNameAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .objcKeyPathExpr, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeKeyPath?.raw
      layout[1] = keyPath.raw
      layout[2] = unexpectedBetweenKeyPathAndLeftParen?.raw
      layout[3] = leftParen.raw
      layout[4] = unexpectedBetweenLeftParenAndName?.raw
      layout[5] = name.raw
      layout[6] = unexpectedBetweenNameAndRightParen?.raw
      layout[7] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeKeyPath: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var keyPath: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenKeyPathAndLeftParen: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndName: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawObjcNameSyntax {
    layoutView.children[5].map(RawObjcNameSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndRightParen: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawObjcSelectorExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ObjcSelectorExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .objcSelectorExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforePoundSelector: RawUnexpectedNodesSyntax? = nil,
    poundSelector: RawTokenSyntax,
    _ unexpectedBetweenPoundSelectorAndLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ unexpectedBetweenLeftParenAndKind: RawUnexpectedNodesSyntax? = nil,
    kind: RawTokenSyntax?,
    _ unexpectedBetweenKindAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax?,
    _ unexpectedBetweenColonAndName: RawUnexpectedNodesSyntax? = nil,
    name: RawExprSyntax,
    _ unexpectedBetweenNameAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .objcSelectorExpr, uninitializedCount: 12, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforePoundSelector?.raw
      layout[1] = poundSelector.raw
      layout[2] = unexpectedBetweenPoundSelectorAndLeftParen?.raw
      layout[3] = leftParen.raw
      layout[4] = unexpectedBetweenLeftParenAndKind?.raw
      layout[5] = kind?.raw
      layout[6] = unexpectedBetweenKindAndColon?.raw
      layout[7] = colon?.raw
      layout[8] = unexpectedBetweenColonAndName?.raw
      layout[9] = name.raw
      layout[10] = unexpectedBetweenNameAndRightParen?.raw
      layout[11] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforePoundSelector: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var poundSelector: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPoundSelectorAndLeftParen: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndKind: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var kind: RawTokenSyntax? {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenKindAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax? {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenColonAndName: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawExprSyntax {
    layoutView.children[9].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndRightParen: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    layoutView.children[11].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPostfixIfConfigExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PostfixIfConfigExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .postfixIfConfigExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeBase: RawUnexpectedNodesSyntax? = nil,
    base: RawExprSyntax?,
    _ unexpectedBetweenBaseAndConfig: RawUnexpectedNodesSyntax? = nil,
    config: RawIfConfigDeclSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .postfixIfConfigExpr, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeBase?.raw
      layout[1] = base?.raw
      layout[2] = unexpectedBetweenBaseAndConfig?.raw
      layout[3] = config.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeBase: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var base: RawExprSyntax? {
    layoutView.children[1].map(RawExprSyntax.init(raw:))
  }
  public var unexpectedBetweenBaseAndConfig: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var config: RawIfConfigDeclSyntax {
    layoutView.children[3].map(RawIfConfigDeclSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawEditorPlaceholderExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = EditorPlaceholderExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .editorPlaceholderExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .editorPlaceholderExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeIdentifier?.raw
      layout[1] = identifier.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawObjectLiteralExprSyntax: RawExprSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ObjectLiteralExprSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .objectLiteralExpr
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ unexpectedBetweenIdentifierAndLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ unexpectedBetweenLeftParenAndArguments: RawUnexpectedNodesSyntax? = nil,
    arguments: RawTupleExprElementListSyntax,
    _ unexpectedBetweenArgumentsAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .objectLiteralExpr, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeIdentifier?.raw
      layout[1] = identifier.raw
      layout[2] = unexpectedBetweenIdentifierAndLeftParen?.raw
      layout[3] = leftParen.raw
      layout[4] = unexpectedBetweenLeftParenAndArguments?.raw
      layout[5] = arguments.raw
      layout[6] = unexpectedBetweenArgumentsAndRightParen?.raw
      layout[7] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndLeftParen: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndArguments: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var arguments: RawTupleExprElementListSyntax {
    layoutView.children[5].map(RawTupleExprElementListSyntax.init(raw:))!
  }
  public var unexpectedBetweenArgumentsAndRightParen: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawYieldExprListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = YieldExprListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .yieldExprList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawYieldExprListElementSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .yieldExprList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawYieldExprListElementSyntax] {
    layoutView.children.map { RawYieldExprListElementSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawYieldExprListElementSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = YieldExprListElementSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .yieldExprListElement
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeExpression: RawUnexpectedNodesSyntax? = nil,
    expression: RawExprSyntax,
    _ unexpectedBetweenExpressionAndComma: RawUnexpectedNodesSyntax? = nil,
    comma: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .yieldExprListElement, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeExpression?.raw
      layout[1] = expression.raw
      layout[2] = unexpectedBetweenExpressionAndComma?.raw
      layout[3] = comma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    layoutView.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenExpressionAndComma: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var comma: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawTypeInitializerClauseSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = TypeInitializerClauseSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .typeInitializerClause
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeEqual: RawUnexpectedNodesSyntax? = nil,
    equal: RawTokenSyntax,
    _ unexpectedBetweenEqualAndValue: RawUnexpectedNodesSyntax? = nil,
    value: RawTypeSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .typeInitializerClause, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeEqual?.raw
      layout[1] = equal.raw
      layout[2] = unexpectedBetweenEqualAndValue?.raw
      layout[3] = value.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeEqual: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var equal: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenEqualAndValue: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var value: RawTypeSyntax {
    layoutView.children[3].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawTypealiasDeclSyntax: RawDeclSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = TypealiasDeclSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .typealiasDecl
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ unexpectedBetweenModifiersAndTypealiasKeyword: RawUnexpectedNodesSyntax? = nil,
    typealiasKeyword: RawTokenSyntax,
    _ unexpectedBetweenTypealiasKeywordAndIdentifier: RawUnexpectedNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ unexpectedBetweenIdentifierAndGenericParameterClause: RawUnexpectedNodesSyntax? = nil,
    genericParameterClause: RawGenericParameterClauseSyntax?,
    _ unexpectedBetweenGenericParameterClauseAndInitializer: RawUnexpectedNodesSyntax? = nil,
    initializer: RawTypeInitializerClauseSyntax,
    _ unexpectedBetweenInitializerAndGenericWhereClause: RawUnexpectedNodesSyntax? = nil,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .typealiasDecl, uninitializedCount: 14, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = unexpectedBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = unexpectedBetweenModifiersAndTypealiasKeyword?.raw
      layout[5] = typealiasKeyword.raw
      layout[6] = unexpectedBetweenTypealiasKeywordAndIdentifier?.raw
      layout[7] = identifier.raw
      layout[8] = unexpectedBetweenIdentifierAndGenericParameterClause?.raw
      layout[9] = genericParameterClause?.raw
      layout[10] = unexpectedBetweenGenericParameterClauseAndInitializer?.raw
      layout[11] = initializer.raw
      layout[12] = unexpectedBetweenInitializerAndGenericWhereClause?.raw
      layout[13] = genericWhereClause?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    layoutView.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    layoutView.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndTypealiasKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var typealiasKeyword: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenTypealiasKeywordAndIdentifier: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndGenericParameterClause: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    layoutView.children[9].map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericParameterClauseAndInitializer: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var initializer: RawTypeInitializerClauseSyntax {
    layoutView.children[11].map(RawTypeInitializerClauseSyntax.init(raw:))!
  }
  public var unexpectedBetweenInitializerAndGenericWhereClause: RawUnexpectedNodesSyntax? {
    layoutView.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    layoutView.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawAssociatedtypeDeclSyntax: RawDeclSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = AssociatedtypeDeclSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .associatedtypeDecl
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ unexpectedBetweenModifiersAndAssociatedtypeKeyword: RawUnexpectedNodesSyntax? = nil,
    associatedtypeKeyword: RawTokenSyntax,
    _ unexpectedBetweenAssociatedtypeKeywordAndIdentifier: RawUnexpectedNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ unexpectedBetweenIdentifierAndInheritanceClause: RawUnexpectedNodesSyntax? = nil,
    inheritanceClause: RawTypeInheritanceClauseSyntax?,
    _ unexpectedBetweenInheritanceClauseAndInitializer: RawUnexpectedNodesSyntax? = nil,
    initializer: RawTypeInitializerClauseSyntax?,
    _ unexpectedBetweenInitializerAndGenericWhereClause: RawUnexpectedNodesSyntax? = nil,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .associatedtypeDecl, uninitializedCount: 14, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = unexpectedBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = unexpectedBetweenModifiersAndAssociatedtypeKeyword?.raw
      layout[5] = associatedtypeKeyword.raw
      layout[6] = unexpectedBetweenAssociatedtypeKeywordAndIdentifier?.raw
      layout[7] = identifier.raw
      layout[8] = unexpectedBetweenIdentifierAndInheritanceClause?.raw
      layout[9] = inheritanceClause?.raw
      layout[10] = unexpectedBetweenInheritanceClauseAndInitializer?.raw
      layout[11] = initializer?.raw
      layout[12] = unexpectedBetweenInitializerAndGenericWhereClause?.raw
      layout[13] = genericWhereClause?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    layoutView.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    layoutView.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndAssociatedtypeKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var associatedtypeKeyword: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenAssociatedtypeKeywordAndIdentifier: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndInheritanceClause: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    layoutView.children[9].map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenInheritanceClauseAndInitializer: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var initializer: RawTypeInitializerClauseSyntax? {
    layoutView.children[11].map(RawTypeInitializerClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenInitializerAndGenericWhereClause: RawUnexpectedNodesSyntax? {
    layoutView.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    layoutView.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawFunctionParameterListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = FunctionParameterListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .functionParameterList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawFunctionParameterSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .functionParameterList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawFunctionParameterSyntax] {
    layoutView.children.map { RawFunctionParameterSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawParameterClauseSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ParameterClauseSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .parameterClause
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ unexpectedBetweenLeftParenAndParameterList: RawUnexpectedNodesSyntax? = nil,
    parameterList: RawFunctionParameterListSyntax,
    _ unexpectedBetweenParameterListAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .parameterClause, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftParen?.raw
      layout[1] = leftParen.raw
      layout[2] = unexpectedBetweenLeftParenAndParameterList?.raw
      layout[3] = parameterList.raw
      layout[4] = unexpectedBetweenParameterListAndRightParen?.raw
      layout[5] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndParameterList: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var parameterList: RawFunctionParameterListSyntax {
    layoutView.children[3].map(RawFunctionParameterListSyntax.init(raw:))!
  }
  public var unexpectedBetweenParameterListAndRightParen: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawReturnClauseSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ReturnClauseSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .returnClause
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeArrow: RawUnexpectedNodesSyntax? = nil,
    arrow: RawTokenSyntax,
    _ unexpectedBetweenArrowAndReturnType: RawUnexpectedNodesSyntax? = nil,
    returnType: RawTypeSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .returnClause, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeArrow?.raw
      layout[1] = arrow.raw
      layout[2] = unexpectedBetweenArrowAndReturnType?.raw
      layout[3] = returnType.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeArrow: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var arrow: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenArrowAndReturnType: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var returnType: RawTypeSyntax {
    layoutView.children[3].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawFunctionSignatureSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = FunctionSignatureSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .functionSignature
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeInput: RawUnexpectedNodesSyntax? = nil,
    input: RawParameterClauseSyntax,
    _ unexpectedBetweenInputAndAsyncOrReasyncKeyword: RawUnexpectedNodesSyntax? = nil,
    asyncOrReasyncKeyword: RawTokenSyntax?,
    _ unexpectedBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword: RawUnexpectedNodesSyntax? = nil,
    throwsOrRethrowsKeyword: RawTokenSyntax?,
    _ unexpectedBetweenThrowsOrRethrowsKeywordAndOutput: RawUnexpectedNodesSyntax? = nil,
    output: RawReturnClauseSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .functionSignature, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeInput?.raw
      layout[1] = input.raw
      layout[2] = unexpectedBetweenInputAndAsyncOrReasyncKeyword?.raw
      layout[3] = asyncOrReasyncKeyword?.raw
      layout[4] = unexpectedBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword?.raw
      layout[5] = throwsOrRethrowsKeyword?.raw
      layout[6] = unexpectedBetweenThrowsOrRethrowsKeywordAndOutput?.raw
      layout[7] = output?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeInput: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var input: RawParameterClauseSyntax {
    layoutView.children[1].map(RawParameterClauseSyntax.init(raw:))!
  }
  public var unexpectedBetweenInputAndAsyncOrReasyncKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var asyncOrReasyncKeyword: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var throwsOrRethrowsKeyword: RawTokenSyntax? {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenThrowsOrRethrowsKeywordAndOutput: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var output: RawReturnClauseSyntax? {
    layoutView.children[7].map(RawReturnClauseSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawIfConfigClauseSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = IfConfigClauseSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .ifConfigClause
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforePoundKeyword: RawUnexpectedNodesSyntax? = nil,
    poundKeyword: RawTokenSyntax,
    _ unexpectedBetweenPoundKeywordAndCondition: RawUnexpectedNodesSyntax? = nil,
    condition: RawExprSyntax?,
    _ unexpectedBetweenConditionAndElements: RawUnexpectedNodesSyntax? = nil,
    elements: RawSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .ifConfigClause, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforePoundKeyword?.raw
      layout[1] = poundKeyword.raw
      layout[2] = unexpectedBetweenPoundKeywordAndCondition?.raw
      layout[3] = condition?.raw
      layout[4] = unexpectedBetweenConditionAndElements?.raw
      layout[5] = elements.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforePoundKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var poundKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPoundKeywordAndCondition: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var condition: RawExprSyntax? {
    layoutView.children[3].map(RawExprSyntax.init(raw:))
  }
  public var unexpectedBetweenConditionAndElements: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var elements: RawSyntax {
    layoutView.children[5]!
  }
}

@_spi(RawSyntax)
public struct RawIfConfigClauseListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = IfConfigClauseListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .ifConfigClauseList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawIfConfigClauseSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .ifConfigClauseList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawIfConfigClauseSyntax] {
    layoutView.children.map { RawIfConfigClauseSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawIfConfigDeclSyntax: RawDeclSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = IfConfigDeclSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .ifConfigDecl
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeClauses: RawUnexpectedNodesSyntax? = nil,
    clauses: RawIfConfigClauseListSyntax,
    _ unexpectedBetweenClausesAndPoundEndif: RawUnexpectedNodesSyntax? = nil,
    poundEndif: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .ifConfigDecl, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeClauses?.raw
      layout[1] = clauses.raw
      layout[2] = unexpectedBetweenClausesAndPoundEndif?.raw
      layout[3] = poundEndif.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeClauses: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var clauses: RawIfConfigClauseListSyntax {
    layoutView.children[1].map(RawIfConfigClauseListSyntax.init(raw:))!
  }
  public var unexpectedBetweenClausesAndPoundEndif: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var poundEndif: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPoundErrorDeclSyntax: RawDeclSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PoundErrorDeclSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .poundErrorDecl
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforePoundError: RawUnexpectedNodesSyntax? = nil,
    poundError: RawTokenSyntax,
    _ unexpectedBetweenPoundErrorAndLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ unexpectedBetweenLeftParenAndMessage: RawUnexpectedNodesSyntax? = nil,
    message: RawStringLiteralExprSyntax,
    _ unexpectedBetweenMessageAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .poundErrorDecl, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforePoundError?.raw
      layout[1] = poundError.raw
      layout[2] = unexpectedBetweenPoundErrorAndLeftParen?.raw
      layout[3] = leftParen.raw
      layout[4] = unexpectedBetweenLeftParenAndMessage?.raw
      layout[5] = message.raw
      layout[6] = unexpectedBetweenMessageAndRightParen?.raw
      layout[7] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforePoundError: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var poundError: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPoundErrorAndLeftParen: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndMessage: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var message: RawStringLiteralExprSyntax {
    layoutView.children[5].map(RawStringLiteralExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenMessageAndRightParen: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPoundWarningDeclSyntax: RawDeclSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PoundWarningDeclSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .poundWarningDecl
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforePoundWarning: RawUnexpectedNodesSyntax? = nil,
    poundWarning: RawTokenSyntax,
    _ unexpectedBetweenPoundWarningAndLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ unexpectedBetweenLeftParenAndMessage: RawUnexpectedNodesSyntax? = nil,
    message: RawStringLiteralExprSyntax,
    _ unexpectedBetweenMessageAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .poundWarningDecl, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforePoundWarning?.raw
      layout[1] = poundWarning.raw
      layout[2] = unexpectedBetweenPoundWarningAndLeftParen?.raw
      layout[3] = leftParen.raw
      layout[4] = unexpectedBetweenLeftParenAndMessage?.raw
      layout[5] = message.raw
      layout[6] = unexpectedBetweenMessageAndRightParen?.raw
      layout[7] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforePoundWarning: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var poundWarning: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPoundWarningAndLeftParen: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndMessage: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var message: RawStringLiteralExprSyntax {
    layoutView.children[5].map(RawStringLiteralExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenMessageAndRightParen: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPoundSourceLocationSyntax: RawDeclSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PoundSourceLocationSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .poundSourceLocation
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforePoundSourceLocation: RawUnexpectedNodesSyntax? = nil,
    poundSourceLocation: RawTokenSyntax,
    _ unexpectedBetweenPoundSourceLocationAndLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ unexpectedBetweenLeftParenAndArgs: RawUnexpectedNodesSyntax? = nil,
    args: RawPoundSourceLocationArgsSyntax?,
    _ unexpectedBetweenArgsAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .poundSourceLocation, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforePoundSourceLocation?.raw
      layout[1] = poundSourceLocation.raw
      layout[2] = unexpectedBetweenPoundSourceLocationAndLeftParen?.raw
      layout[3] = leftParen.raw
      layout[4] = unexpectedBetweenLeftParenAndArgs?.raw
      layout[5] = args?.raw
      layout[6] = unexpectedBetweenArgsAndRightParen?.raw
      layout[7] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforePoundSourceLocation: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var poundSourceLocation: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPoundSourceLocationAndLeftParen: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndArgs: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var args: RawPoundSourceLocationArgsSyntax? {
    layoutView.children[5].map(RawPoundSourceLocationArgsSyntax.init(raw:))
  }
  public var unexpectedBetweenArgsAndRightParen: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPoundSourceLocationArgsSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PoundSourceLocationArgsSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .poundSourceLocationArgs
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeFileArgLabel: RawUnexpectedNodesSyntax? = nil,
    fileArgLabel: RawTokenSyntax,
    _ unexpectedBetweenFileArgLabelAndFileArgColon: RawUnexpectedNodesSyntax? = nil,
    fileArgColon: RawTokenSyntax,
    _ unexpectedBetweenFileArgColonAndFileName: RawUnexpectedNodesSyntax? = nil,
    fileName: RawTokenSyntax,
    _ unexpectedBetweenFileNameAndComma: RawUnexpectedNodesSyntax? = nil,
    comma: RawTokenSyntax,
    _ unexpectedBetweenCommaAndLineArgLabel: RawUnexpectedNodesSyntax? = nil,
    lineArgLabel: RawTokenSyntax,
    _ unexpectedBetweenLineArgLabelAndLineArgColon: RawUnexpectedNodesSyntax? = nil,
    lineArgColon: RawTokenSyntax,
    _ unexpectedBetweenLineArgColonAndLineNumber: RawUnexpectedNodesSyntax? = nil,
    lineNumber: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .poundSourceLocationArgs, uninitializedCount: 14, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeFileArgLabel?.raw
      layout[1] = fileArgLabel.raw
      layout[2] = unexpectedBetweenFileArgLabelAndFileArgColon?.raw
      layout[3] = fileArgColon.raw
      layout[4] = unexpectedBetweenFileArgColonAndFileName?.raw
      layout[5] = fileName.raw
      layout[6] = unexpectedBetweenFileNameAndComma?.raw
      layout[7] = comma.raw
      layout[8] = unexpectedBetweenCommaAndLineArgLabel?.raw
      layout[9] = lineArgLabel.raw
      layout[10] = unexpectedBetweenLineArgLabelAndLineArgColon?.raw
      layout[11] = lineArgColon.raw
      layout[12] = unexpectedBetweenLineArgColonAndLineNumber?.raw
      layout[13] = lineNumber.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeFileArgLabel: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var fileArgLabel: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenFileArgLabelAndFileArgColon: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var fileArgColon: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenFileArgColonAndFileName: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var fileName: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenFileNameAndComma: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var comma: RawTokenSyntax {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenCommaAndLineArgLabel: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var lineArgLabel: RawTokenSyntax {
    layoutView.children[9].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLineArgLabelAndLineArgColon: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var lineArgColon: RawTokenSyntax {
    layoutView.children[11].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLineArgColonAndLineNumber: RawUnexpectedNodesSyntax? {
    layoutView.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var lineNumber: RawTokenSyntax {
    layoutView.children[13].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawDeclModifierDetailSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = DeclModifierDetailSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .declModifierDetail
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ unexpectedBetweenLeftParenAndDetail: RawUnexpectedNodesSyntax? = nil,
    detail: RawTokenSyntax,
    _ unexpectedBetweenDetailAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .declModifierDetail, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftParen?.raw
      layout[1] = leftParen.raw
      layout[2] = unexpectedBetweenLeftParenAndDetail?.raw
      layout[3] = detail.raw
      layout[4] = unexpectedBetweenDetailAndRightParen?.raw
      layout[5] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndDetail: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var detail: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenDetailAndRightParen: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawDeclModifierSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = DeclModifierSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .declModifier
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeName: RawUnexpectedNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ unexpectedBetweenNameAndDetail: RawUnexpectedNodesSyntax? = nil,
    detail: RawDeclModifierDetailSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .declModifier, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeName?.raw
      layout[1] = name.raw
      layout[2] = unexpectedBetweenNameAndDetail?.raw
      layout[3] = detail?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeName: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndDetail: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var detail: RawDeclModifierDetailSyntax? {
    layoutView.children[3].map(RawDeclModifierDetailSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawInheritedTypeSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = InheritedTypeSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .inheritedType
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeTypeName: RawUnexpectedNodesSyntax? = nil,
    typeName: RawTypeSyntax,
    _ unexpectedBetweenTypeNameAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .inheritedType, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeTypeName?.raw
      layout[1] = typeName.raw
      layout[2] = unexpectedBetweenTypeNameAndTrailingComma?.raw
      layout[3] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeTypeName: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var typeName: RawTypeSyntax {
    layoutView.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenTypeNameAndTrailingComma: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawInheritedTypeListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = InheritedTypeListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .inheritedTypeList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawInheritedTypeSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .inheritedTypeList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawInheritedTypeSyntax] {
    layoutView.children.map { RawInheritedTypeSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawTypeInheritanceClauseSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = TypeInheritanceClauseSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .typeInheritanceClause
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ unexpectedBetweenColonAndInheritedTypeCollection: RawUnexpectedNodesSyntax? = nil,
    inheritedTypeCollection: RawInheritedTypeListSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .typeInheritanceClause, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeColon?.raw
      layout[1] = colon.raw
      layout[2] = unexpectedBetweenColonAndInheritedTypeCollection?.raw
      layout[3] = inheritedTypeCollection.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeColon: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndInheritedTypeCollection: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var inheritedTypeCollection: RawInheritedTypeListSyntax {
    layoutView.children[3].map(RawInheritedTypeListSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawClassDeclSyntax: RawDeclSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ClassDeclSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .classDecl
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ unexpectedBetweenModifiersAndClassKeyword: RawUnexpectedNodesSyntax? = nil,
    classKeyword: RawTokenSyntax,
    _ unexpectedBetweenClassKeywordAndIdentifier: RawUnexpectedNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ unexpectedBetweenIdentifierAndGenericParameterClause: RawUnexpectedNodesSyntax? = nil,
    genericParameterClause: RawGenericParameterClauseSyntax?,
    _ unexpectedBetweenGenericParameterClauseAndInheritanceClause: RawUnexpectedNodesSyntax? = nil,
    inheritanceClause: RawTypeInheritanceClauseSyntax?,
    _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: RawUnexpectedNodesSyntax? = nil,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    _ unexpectedBetweenGenericWhereClauseAndMembers: RawUnexpectedNodesSyntax? = nil,
    members: RawMemberDeclBlockSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .classDecl, uninitializedCount: 16, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = unexpectedBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = unexpectedBetweenModifiersAndClassKeyword?.raw
      layout[5] = classKeyword.raw
      layout[6] = unexpectedBetweenClassKeywordAndIdentifier?.raw
      layout[7] = identifier.raw
      layout[8] = unexpectedBetweenIdentifierAndGenericParameterClause?.raw
      layout[9] = genericParameterClause?.raw
      layout[10] = unexpectedBetweenGenericParameterClauseAndInheritanceClause?.raw
      layout[11] = inheritanceClause?.raw
      layout[12] = unexpectedBetweenInheritanceClauseAndGenericWhereClause?.raw
      layout[13] = genericWhereClause?.raw
      layout[14] = unexpectedBetweenGenericWhereClauseAndMembers?.raw
      layout[15] = members.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    layoutView.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    layoutView.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndClassKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var classKeyword: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenClassKeywordAndIdentifier: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndGenericParameterClause: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    layoutView.children[9].map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericParameterClauseAndInheritanceClause: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    layoutView.children[11].map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenInheritanceClauseAndGenericWhereClause: RawUnexpectedNodesSyntax? {
    layoutView.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    layoutView.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericWhereClauseAndMembers: RawUnexpectedNodesSyntax? {
    layoutView.children[14].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var members: RawMemberDeclBlockSyntax {
    layoutView.children[15].map(RawMemberDeclBlockSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawActorDeclSyntax: RawDeclSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ActorDeclSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .actorDecl
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ unexpectedBetweenModifiersAndActorKeyword: RawUnexpectedNodesSyntax? = nil,
    actorKeyword: RawTokenSyntax,
    _ unexpectedBetweenActorKeywordAndIdentifier: RawUnexpectedNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ unexpectedBetweenIdentifierAndGenericParameterClause: RawUnexpectedNodesSyntax? = nil,
    genericParameterClause: RawGenericParameterClauseSyntax?,
    _ unexpectedBetweenGenericParameterClauseAndInheritanceClause: RawUnexpectedNodesSyntax? = nil,
    inheritanceClause: RawTypeInheritanceClauseSyntax?,
    _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: RawUnexpectedNodesSyntax? = nil,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    _ unexpectedBetweenGenericWhereClauseAndMembers: RawUnexpectedNodesSyntax? = nil,
    members: RawMemberDeclBlockSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .actorDecl, uninitializedCount: 16, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = unexpectedBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = unexpectedBetweenModifiersAndActorKeyword?.raw
      layout[5] = actorKeyword.raw
      layout[6] = unexpectedBetweenActorKeywordAndIdentifier?.raw
      layout[7] = identifier.raw
      layout[8] = unexpectedBetweenIdentifierAndGenericParameterClause?.raw
      layout[9] = genericParameterClause?.raw
      layout[10] = unexpectedBetweenGenericParameterClauseAndInheritanceClause?.raw
      layout[11] = inheritanceClause?.raw
      layout[12] = unexpectedBetweenInheritanceClauseAndGenericWhereClause?.raw
      layout[13] = genericWhereClause?.raw
      layout[14] = unexpectedBetweenGenericWhereClauseAndMembers?.raw
      layout[15] = members.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    layoutView.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    layoutView.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndActorKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var actorKeyword: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenActorKeywordAndIdentifier: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndGenericParameterClause: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    layoutView.children[9].map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericParameterClauseAndInheritanceClause: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    layoutView.children[11].map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenInheritanceClauseAndGenericWhereClause: RawUnexpectedNodesSyntax? {
    layoutView.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    layoutView.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericWhereClauseAndMembers: RawUnexpectedNodesSyntax? {
    layoutView.children[14].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var members: RawMemberDeclBlockSyntax {
    layoutView.children[15].map(RawMemberDeclBlockSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawStructDeclSyntax: RawDeclSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = StructDeclSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .structDecl
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ unexpectedBetweenModifiersAndStructKeyword: RawUnexpectedNodesSyntax? = nil,
    structKeyword: RawTokenSyntax,
    _ unexpectedBetweenStructKeywordAndIdentifier: RawUnexpectedNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ unexpectedBetweenIdentifierAndGenericParameterClause: RawUnexpectedNodesSyntax? = nil,
    genericParameterClause: RawGenericParameterClauseSyntax?,
    _ unexpectedBetweenGenericParameterClauseAndInheritanceClause: RawUnexpectedNodesSyntax? = nil,
    inheritanceClause: RawTypeInheritanceClauseSyntax?,
    _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: RawUnexpectedNodesSyntax? = nil,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    _ unexpectedBetweenGenericWhereClauseAndMembers: RawUnexpectedNodesSyntax? = nil,
    members: RawMemberDeclBlockSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .structDecl, uninitializedCount: 16, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = unexpectedBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = unexpectedBetweenModifiersAndStructKeyword?.raw
      layout[5] = structKeyword.raw
      layout[6] = unexpectedBetweenStructKeywordAndIdentifier?.raw
      layout[7] = identifier.raw
      layout[8] = unexpectedBetweenIdentifierAndGenericParameterClause?.raw
      layout[9] = genericParameterClause?.raw
      layout[10] = unexpectedBetweenGenericParameterClauseAndInheritanceClause?.raw
      layout[11] = inheritanceClause?.raw
      layout[12] = unexpectedBetweenInheritanceClauseAndGenericWhereClause?.raw
      layout[13] = genericWhereClause?.raw
      layout[14] = unexpectedBetweenGenericWhereClauseAndMembers?.raw
      layout[15] = members.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    layoutView.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    layoutView.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndStructKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var structKeyword: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenStructKeywordAndIdentifier: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndGenericParameterClause: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    layoutView.children[9].map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericParameterClauseAndInheritanceClause: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    layoutView.children[11].map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenInheritanceClauseAndGenericWhereClause: RawUnexpectedNodesSyntax? {
    layoutView.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    layoutView.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericWhereClauseAndMembers: RawUnexpectedNodesSyntax? {
    layoutView.children[14].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var members: RawMemberDeclBlockSyntax {
    layoutView.children[15].map(RawMemberDeclBlockSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawProtocolDeclSyntax: RawDeclSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ProtocolDeclSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .protocolDecl
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ unexpectedBetweenModifiersAndProtocolKeyword: RawUnexpectedNodesSyntax? = nil,
    protocolKeyword: RawTokenSyntax,
    _ unexpectedBetweenProtocolKeywordAndIdentifier: RawUnexpectedNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ unexpectedBetweenIdentifierAndPrimaryAssociatedTypeClause: RawUnexpectedNodesSyntax? = nil,
    primaryAssociatedTypeClause: RawPrimaryAssociatedTypeClauseSyntax?,
    _ unexpectedBetweenPrimaryAssociatedTypeClauseAndInheritanceClause: RawUnexpectedNodesSyntax? = nil,
    inheritanceClause: RawTypeInheritanceClauseSyntax?,
    _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: RawUnexpectedNodesSyntax? = nil,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    _ unexpectedBetweenGenericWhereClauseAndMembers: RawUnexpectedNodesSyntax? = nil,
    members: RawMemberDeclBlockSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .protocolDecl, uninitializedCount: 16, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = unexpectedBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = unexpectedBetweenModifiersAndProtocolKeyword?.raw
      layout[5] = protocolKeyword.raw
      layout[6] = unexpectedBetweenProtocolKeywordAndIdentifier?.raw
      layout[7] = identifier.raw
      layout[8] = unexpectedBetweenIdentifierAndPrimaryAssociatedTypeClause?.raw
      layout[9] = primaryAssociatedTypeClause?.raw
      layout[10] = unexpectedBetweenPrimaryAssociatedTypeClauseAndInheritanceClause?.raw
      layout[11] = inheritanceClause?.raw
      layout[12] = unexpectedBetweenInheritanceClauseAndGenericWhereClause?.raw
      layout[13] = genericWhereClause?.raw
      layout[14] = unexpectedBetweenGenericWhereClauseAndMembers?.raw
      layout[15] = members.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    layoutView.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    layoutView.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndProtocolKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var protocolKeyword: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenProtocolKeywordAndIdentifier: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndPrimaryAssociatedTypeClause: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var primaryAssociatedTypeClause: RawPrimaryAssociatedTypeClauseSyntax? {
    layoutView.children[9].map(RawPrimaryAssociatedTypeClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenPrimaryAssociatedTypeClauseAndInheritanceClause: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    layoutView.children[11].map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenInheritanceClauseAndGenericWhereClause: RawUnexpectedNodesSyntax? {
    layoutView.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    layoutView.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericWhereClauseAndMembers: RawUnexpectedNodesSyntax? {
    layoutView.children[14].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var members: RawMemberDeclBlockSyntax {
    layoutView.children[15].map(RawMemberDeclBlockSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawExtensionDeclSyntax: RawDeclSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ExtensionDeclSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .extensionDecl
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ unexpectedBetweenModifiersAndExtensionKeyword: RawUnexpectedNodesSyntax? = nil,
    extensionKeyword: RawTokenSyntax,
    _ unexpectedBetweenExtensionKeywordAndExtendedType: RawUnexpectedNodesSyntax? = nil,
    extendedType: RawTypeSyntax,
    _ unexpectedBetweenExtendedTypeAndInheritanceClause: RawUnexpectedNodesSyntax? = nil,
    inheritanceClause: RawTypeInheritanceClauseSyntax?,
    _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: RawUnexpectedNodesSyntax? = nil,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    _ unexpectedBetweenGenericWhereClauseAndMembers: RawUnexpectedNodesSyntax? = nil,
    members: RawMemberDeclBlockSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .extensionDecl, uninitializedCount: 14, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = unexpectedBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = unexpectedBetweenModifiersAndExtensionKeyword?.raw
      layout[5] = extensionKeyword.raw
      layout[6] = unexpectedBetweenExtensionKeywordAndExtendedType?.raw
      layout[7] = extendedType.raw
      layout[8] = unexpectedBetweenExtendedTypeAndInheritanceClause?.raw
      layout[9] = inheritanceClause?.raw
      layout[10] = unexpectedBetweenInheritanceClauseAndGenericWhereClause?.raw
      layout[11] = genericWhereClause?.raw
      layout[12] = unexpectedBetweenGenericWhereClauseAndMembers?.raw
      layout[13] = members.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    layoutView.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    layoutView.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndExtensionKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var extensionKeyword: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenExtensionKeywordAndExtendedType: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var extendedType: RawTypeSyntax {
    layoutView.children[7].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenExtendedTypeAndInheritanceClause: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    layoutView.children[9].map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenInheritanceClauseAndGenericWhereClause: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    layoutView.children[11].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericWhereClauseAndMembers: RawUnexpectedNodesSyntax? {
    layoutView.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var members: RawMemberDeclBlockSyntax {
    layoutView.children[13].map(RawMemberDeclBlockSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawMemberDeclBlockSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = MemberDeclBlockSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .memberDeclBlock
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftBrace: RawUnexpectedNodesSyntax? = nil,
    leftBrace: RawTokenSyntax,
    _ unexpectedBetweenLeftBraceAndMembers: RawUnexpectedNodesSyntax? = nil,
    members: RawMemberDeclListSyntax,
    _ unexpectedBetweenMembersAndRightBrace: RawUnexpectedNodesSyntax? = nil,
    rightBrace: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .memberDeclBlock, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftBrace?.raw
      layout[1] = leftBrace.raw
      layout[2] = unexpectedBetweenLeftBraceAndMembers?.raw
      layout[3] = members.raw
      layout[4] = unexpectedBetweenMembersAndRightBrace?.raw
      layout[5] = rightBrace.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftBrace: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftBrace: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftBraceAndMembers: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var members: RawMemberDeclListSyntax {
    layoutView.children[3].map(RawMemberDeclListSyntax.init(raw:))!
  }
  public var unexpectedBetweenMembersAndRightBrace: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightBrace: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawMemberDeclListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = MemberDeclListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .memberDeclList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawMemberDeclListItemSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .memberDeclList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawMemberDeclListItemSyntax] {
    layoutView.children.map { RawMemberDeclListItemSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawMemberDeclListItemSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = MemberDeclListItemSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .memberDeclListItem
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeDecl: RawUnexpectedNodesSyntax? = nil,
    decl: RawDeclSyntax,
    _ unexpectedBetweenDeclAndSemicolon: RawUnexpectedNodesSyntax? = nil,
    semicolon: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .memberDeclListItem, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeDecl?.raw
      layout[1] = decl.raw
      layout[2] = unexpectedBetweenDeclAndSemicolon?.raw
      layout[3] = semicolon?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeDecl: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var decl: RawDeclSyntax {
    layoutView.children[1].map(RawDeclSyntax.init(raw:))!
  }
  public var unexpectedBetweenDeclAndSemicolon: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var semicolon: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawSourceFileSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = SourceFileSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .sourceFile
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeStatements: RawUnexpectedNodesSyntax? = nil,
    statements: RawCodeBlockItemListSyntax,
    _ unexpectedBetweenStatementsAndEOFToken: RawUnexpectedNodesSyntax? = nil,
    eofToken: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .sourceFile, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeStatements?.raw
      layout[1] = statements.raw
      layout[2] = unexpectedBetweenStatementsAndEOFToken?.raw
      layout[3] = eofToken.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeStatements: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var statements: RawCodeBlockItemListSyntax {
    layoutView.children[1].map(RawCodeBlockItemListSyntax.init(raw:))!
  }
  public var unexpectedBetweenStatementsAndEOFToken: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var eofToken: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawInitializerClauseSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = InitializerClauseSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .initializerClause
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeEqual: RawUnexpectedNodesSyntax? = nil,
    equal: RawTokenSyntax,
    _ unexpectedBetweenEqualAndValue: RawUnexpectedNodesSyntax? = nil,
    value: RawExprSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .initializerClause, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeEqual?.raw
      layout[1] = equal.raw
      layout[2] = unexpectedBetweenEqualAndValue?.raw
      layout[3] = value.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeEqual: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var equal: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenEqualAndValue: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var value: RawExprSyntax {
    layoutView.children[3].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawFunctionParameterSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = FunctionParameterSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .functionParameter
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ unexpectedBetweenModifiersAndFirstName: RawUnexpectedNodesSyntax? = nil,
    firstName: RawTokenSyntax?,
    _ unexpectedBetweenFirstNameAndSecondName: RawUnexpectedNodesSyntax? = nil,
    secondName: RawTokenSyntax?,
    _ unexpectedBetweenSecondNameAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax?,
    _ unexpectedBetweenColonAndType: RawUnexpectedNodesSyntax? = nil,
    type: RawTypeSyntax?,
    _ unexpectedBetweenTypeAndEllipsis: RawUnexpectedNodesSyntax? = nil,
    ellipsis: RawTokenSyntax?,
    _ unexpectedBetweenEllipsisAndDefaultArgument: RawUnexpectedNodesSyntax? = nil,
    defaultArgument: RawInitializerClauseSyntax?,
    _ unexpectedBetweenDefaultArgumentAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .functionParameter, uninitializedCount: 18, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = unexpectedBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = unexpectedBetweenModifiersAndFirstName?.raw
      layout[5] = firstName?.raw
      layout[6] = unexpectedBetweenFirstNameAndSecondName?.raw
      layout[7] = secondName?.raw
      layout[8] = unexpectedBetweenSecondNameAndColon?.raw
      layout[9] = colon?.raw
      layout[10] = unexpectedBetweenColonAndType?.raw
      layout[11] = type?.raw
      layout[12] = unexpectedBetweenTypeAndEllipsis?.raw
      layout[13] = ellipsis?.raw
      layout[14] = unexpectedBetweenEllipsisAndDefaultArgument?.raw
      layout[15] = defaultArgument?.raw
      layout[16] = unexpectedBetweenDefaultArgumentAndTrailingComma?.raw
      layout[17] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    layoutView.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    layoutView.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndFirstName: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var firstName: RawTokenSyntax? {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenFirstNameAndSecondName: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var secondName: RawTokenSyntax? {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenSecondNameAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax? {
    layoutView.children[9].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenColonAndType: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var type: RawTypeSyntax? {
    layoutView.children[11].map(RawTypeSyntax.init(raw:))
  }
  public var unexpectedBetweenTypeAndEllipsis: RawUnexpectedNodesSyntax? {
    layoutView.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var ellipsis: RawTokenSyntax? {
    layoutView.children[13].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenEllipsisAndDefaultArgument: RawUnexpectedNodesSyntax? {
    layoutView.children[14].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var defaultArgument: RawInitializerClauseSyntax? {
    layoutView.children[15].map(RawInitializerClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenDefaultArgumentAndTrailingComma: RawUnexpectedNodesSyntax? {
    layoutView.children[16].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    layoutView.children[17].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawModifierListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ModifierListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .modifierList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawDeclModifierSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .modifierList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawDeclModifierSyntax] {
    layoutView.children.map { RawDeclModifierSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawFunctionDeclSyntax: RawDeclSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = FunctionDeclSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .functionDecl
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ unexpectedBetweenModifiersAndFuncKeyword: RawUnexpectedNodesSyntax? = nil,
    funcKeyword: RawTokenSyntax,
    _ unexpectedBetweenFuncKeywordAndIdentifier: RawUnexpectedNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ unexpectedBetweenIdentifierAndGenericParameterClause: RawUnexpectedNodesSyntax? = nil,
    genericParameterClause: RawGenericParameterClauseSyntax?,
    _ unexpectedBetweenGenericParameterClauseAndSignature: RawUnexpectedNodesSyntax? = nil,
    signature: RawFunctionSignatureSyntax,
    _ unexpectedBetweenSignatureAndGenericWhereClause: RawUnexpectedNodesSyntax? = nil,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    _ unexpectedBetweenGenericWhereClauseAndBody: RawUnexpectedNodesSyntax? = nil,
    body: RawCodeBlockSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .functionDecl, uninitializedCount: 16, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = unexpectedBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = unexpectedBetweenModifiersAndFuncKeyword?.raw
      layout[5] = funcKeyword.raw
      layout[6] = unexpectedBetweenFuncKeywordAndIdentifier?.raw
      layout[7] = identifier.raw
      layout[8] = unexpectedBetweenIdentifierAndGenericParameterClause?.raw
      layout[9] = genericParameterClause?.raw
      layout[10] = unexpectedBetweenGenericParameterClauseAndSignature?.raw
      layout[11] = signature.raw
      layout[12] = unexpectedBetweenSignatureAndGenericWhereClause?.raw
      layout[13] = genericWhereClause?.raw
      layout[14] = unexpectedBetweenGenericWhereClauseAndBody?.raw
      layout[15] = body?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    layoutView.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    layoutView.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndFuncKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var funcKeyword: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenFuncKeywordAndIdentifier: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndGenericParameterClause: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    layoutView.children[9].map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericParameterClauseAndSignature: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var signature: RawFunctionSignatureSyntax {
    layoutView.children[11].map(RawFunctionSignatureSyntax.init(raw:))!
  }
  public var unexpectedBetweenSignatureAndGenericWhereClause: RawUnexpectedNodesSyntax? {
    layoutView.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    layoutView.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericWhereClauseAndBody: RawUnexpectedNodesSyntax? {
    layoutView.children[14].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax? {
    layoutView.children[15].map(RawCodeBlockSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawInitializerDeclSyntax: RawDeclSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = InitializerDeclSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .initializerDecl
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ unexpectedBetweenModifiersAndInitKeyword: RawUnexpectedNodesSyntax? = nil,
    initKeyword: RawTokenSyntax,
    _ unexpectedBetweenInitKeywordAndOptionalMark: RawUnexpectedNodesSyntax? = nil,
    optionalMark: RawTokenSyntax?,
    _ unexpectedBetweenOptionalMarkAndGenericParameterClause: RawUnexpectedNodesSyntax? = nil,
    genericParameterClause: RawGenericParameterClauseSyntax?,
    _ unexpectedBetweenGenericParameterClauseAndSignature: RawUnexpectedNodesSyntax? = nil,
    signature: RawFunctionSignatureSyntax,
    _ unexpectedBetweenSignatureAndGenericWhereClause: RawUnexpectedNodesSyntax? = nil,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    _ unexpectedBetweenGenericWhereClauseAndBody: RawUnexpectedNodesSyntax? = nil,
    body: RawCodeBlockSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .initializerDecl, uninitializedCount: 16, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = unexpectedBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = unexpectedBetweenModifiersAndInitKeyword?.raw
      layout[5] = initKeyword.raw
      layout[6] = unexpectedBetweenInitKeywordAndOptionalMark?.raw
      layout[7] = optionalMark?.raw
      layout[8] = unexpectedBetweenOptionalMarkAndGenericParameterClause?.raw
      layout[9] = genericParameterClause?.raw
      layout[10] = unexpectedBetweenGenericParameterClauseAndSignature?.raw
      layout[11] = signature.raw
      layout[12] = unexpectedBetweenSignatureAndGenericWhereClause?.raw
      layout[13] = genericWhereClause?.raw
      layout[14] = unexpectedBetweenGenericWhereClauseAndBody?.raw
      layout[15] = body?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    layoutView.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    layoutView.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndInitKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var initKeyword: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenInitKeywordAndOptionalMark: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var optionalMark: RawTokenSyntax? {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenOptionalMarkAndGenericParameterClause: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    layoutView.children[9].map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericParameterClauseAndSignature: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var signature: RawFunctionSignatureSyntax {
    layoutView.children[11].map(RawFunctionSignatureSyntax.init(raw:))!
  }
  public var unexpectedBetweenSignatureAndGenericWhereClause: RawUnexpectedNodesSyntax? {
    layoutView.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    layoutView.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericWhereClauseAndBody: RawUnexpectedNodesSyntax? {
    layoutView.children[14].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax? {
    layoutView.children[15].map(RawCodeBlockSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawDeinitializerDeclSyntax: RawDeclSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = DeinitializerDeclSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .deinitializerDecl
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ unexpectedBetweenModifiersAndDeinitKeyword: RawUnexpectedNodesSyntax? = nil,
    deinitKeyword: RawTokenSyntax,
    _ unexpectedBetweenDeinitKeywordAndBody: RawUnexpectedNodesSyntax? = nil,
    body: RawCodeBlockSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .deinitializerDecl, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = unexpectedBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = unexpectedBetweenModifiersAndDeinitKeyword?.raw
      layout[5] = deinitKeyword.raw
      layout[6] = unexpectedBetweenDeinitKeywordAndBody?.raw
      layout[7] = body?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    layoutView.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    layoutView.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndDeinitKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var deinitKeyword: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenDeinitKeywordAndBody: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax? {
    layoutView.children[7].map(RawCodeBlockSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawSubscriptDeclSyntax: RawDeclSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = SubscriptDeclSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .subscriptDecl
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ unexpectedBetweenModifiersAndSubscriptKeyword: RawUnexpectedNodesSyntax? = nil,
    subscriptKeyword: RawTokenSyntax,
    _ unexpectedBetweenSubscriptKeywordAndGenericParameterClause: RawUnexpectedNodesSyntax? = nil,
    genericParameterClause: RawGenericParameterClauseSyntax?,
    _ unexpectedBetweenGenericParameterClauseAndIndices: RawUnexpectedNodesSyntax? = nil,
    indices: RawParameterClauseSyntax,
    _ unexpectedBetweenIndicesAndResult: RawUnexpectedNodesSyntax? = nil,
    result: RawReturnClauseSyntax,
    _ unexpectedBetweenResultAndGenericWhereClause: RawUnexpectedNodesSyntax? = nil,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    _ unexpectedBetweenGenericWhereClauseAndAccessor: RawUnexpectedNodesSyntax? = nil,
    accessor: RawSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .subscriptDecl, uninitializedCount: 16, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = unexpectedBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = unexpectedBetweenModifiersAndSubscriptKeyword?.raw
      layout[5] = subscriptKeyword.raw
      layout[6] = unexpectedBetweenSubscriptKeywordAndGenericParameterClause?.raw
      layout[7] = genericParameterClause?.raw
      layout[8] = unexpectedBetweenGenericParameterClauseAndIndices?.raw
      layout[9] = indices.raw
      layout[10] = unexpectedBetweenIndicesAndResult?.raw
      layout[11] = result.raw
      layout[12] = unexpectedBetweenResultAndGenericWhereClause?.raw
      layout[13] = genericWhereClause?.raw
      layout[14] = unexpectedBetweenGenericWhereClauseAndAccessor?.raw
      layout[15] = accessor?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    layoutView.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    layoutView.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndSubscriptKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var subscriptKeyword: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenSubscriptKeywordAndGenericParameterClause: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    layoutView.children[7].map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericParameterClauseAndIndices: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var indices: RawParameterClauseSyntax {
    layoutView.children[9].map(RawParameterClauseSyntax.init(raw:))!
  }
  public var unexpectedBetweenIndicesAndResult: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var result: RawReturnClauseSyntax {
    layoutView.children[11].map(RawReturnClauseSyntax.init(raw:))!
  }
  public var unexpectedBetweenResultAndGenericWhereClause: RawUnexpectedNodesSyntax? {
    layoutView.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    layoutView.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericWhereClauseAndAccessor: RawUnexpectedNodesSyntax? {
    layoutView.children[14].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var accessor: RawSyntax? {
    layoutView.children[15]
  }
}

@_spi(RawSyntax)
public struct RawAccessLevelModifierSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = AccessLevelModifierSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .accessLevelModifier
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeName: RawUnexpectedNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ unexpectedBetweenNameAndModifier: RawUnexpectedNodesSyntax? = nil,
    modifier: RawDeclModifierDetailSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .accessLevelModifier, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeName?.raw
      layout[1] = name.raw
      layout[2] = unexpectedBetweenNameAndModifier?.raw
      layout[3] = modifier?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeName: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndModifier: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifier: RawDeclModifierDetailSyntax? {
    layoutView.children[3].map(RawDeclModifierDetailSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawAccessPathComponentSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = AccessPathComponentSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .accessPathComponent
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeName: RawUnexpectedNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ unexpectedBetweenNameAndTrailingDot: RawUnexpectedNodesSyntax? = nil,
    trailingDot: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .accessPathComponent, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeName?.raw
      layout[1] = name.raw
      layout[2] = unexpectedBetweenNameAndTrailingDot?.raw
      layout[3] = trailingDot?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeName: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndTrailingDot: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingDot: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawAccessPathSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = AccessPathSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .accessPath
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawAccessPathComponentSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .accessPath, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawAccessPathComponentSyntax] {
    layoutView.children.map { RawAccessPathComponentSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawImportDeclSyntax: RawDeclSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ImportDeclSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .importDecl
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ unexpectedBetweenModifiersAndImportTok: RawUnexpectedNodesSyntax? = nil,
    importTok: RawTokenSyntax,
    _ unexpectedBetweenImportTokAndImportKind: RawUnexpectedNodesSyntax? = nil,
    importKind: RawTokenSyntax?,
    _ unexpectedBetweenImportKindAndPath: RawUnexpectedNodesSyntax? = nil,
    path: RawAccessPathSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .importDecl, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = unexpectedBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = unexpectedBetweenModifiersAndImportTok?.raw
      layout[5] = importTok.raw
      layout[6] = unexpectedBetweenImportTokAndImportKind?.raw
      layout[7] = importKind?.raw
      layout[8] = unexpectedBetweenImportKindAndPath?.raw
      layout[9] = path.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    layoutView.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    layoutView.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndImportTok: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var importTok: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenImportTokAndImportKind: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var importKind: RawTokenSyntax? {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenImportKindAndPath: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var path: RawAccessPathSyntax {
    layoutView.children[9].map(RawAccessPathSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawAccessorParameterSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = AccessorParameterSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .accessorParameter
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ unexpectedBetweenLeftParenAndName: RawUnexpectedNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ unexpectedBetweenNameAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .accessorParameter, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftParen?.raw
      layout[1] = leftParen.raw
      layout[2] = unexpectedBetweenLeftParenAndName?.raw
      layout[3] = name.raw
      layout[4] = unexpectedBetweenNameAndRightParen?.raw
      layout[5] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndName: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndRightParen: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawAccessorDeclSyntax: RawDeclSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = AccessorDeclSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .accessorDecl
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifier: RawUnexpectedNodesSyntax? = nil,
    modifier: RawDeclModifierSyntax?,
    _ unexpectedBetweenModifierAndAccessorKind: RawUnexpectedNodesSyntax? = nil,
    accessorKind: RawTokenSyntax,
    _ unexpectedBetweenAccessorKindAndParameter: RawUnexpectedNodesSyntax? = nil,
    parameter: RawAccessorParameterSyntax?,
    _ unexpectedBetweenParameterAndAsyncKeyword: RawUnexpectedNodesSyntax? = nil,
    asyncKeyword: RawTokenSyntax?,
    _ unexpectedBetweenAsyncKeywordAndThrowsKeyword: RawUnexpectedNodesSyntax? = nil,
    throwsKeyword: RawTokenSyntax?,
    _ unexpectedBetweenThrowsKeywordAndBody: RawUnexpectedNodesSyntax? = nil,
    body: RawCodeBlockSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .accessorDecl, uninitializedCount: 14, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = unexpectedBetweenAttributesAndModifier?.raw
      layout[3] = modifier?.raw
      layout[4] = unexpectedBetweenModifierAndAccessorKind?.raw
      layout[5] = accessorKind.raw
      layout[6] = unexpectedBetweenAccessorKindAndParameter?.raw
      layout[7] = parameter?.raw
      layout[8] = unexpectedBetweenParameterAndAsyncKeyword?.raw
      layout[9] = asyncKeyword?.raw
      layout[10] = unexpectedBetweenAsyncKeywordAndThrowsKeyword?.raw
      layout[11] = throwsKeyword?.raw
      layout[12] = unexpectedBetweenThrowsKeywordAndBody?.raw
      layout[13] = body?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    layoutView.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifier: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifier: RawDeclModifierSyntax? {
    layoutView.children[3].map(RawDeclModifierSyntax.init(raw:))
  }
  public var unexpectedBetweenModifierAndAccessorKind: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var accessorKind: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenAccessorKindAndParameter: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var parameter: RawAccessorParameterSyntax? {
    layoutView.children[7].map(RawAccessorParameterSyntax.init(raw:))
  }
  public var unexpectedBetweenParameterAndAsyncKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var asyncKeyword: RawTokenSyntax? {
    layoutView.children[9].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenAsyncKeywordAndThrowsKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var throwsKeyword: RawTokenSyntax? {
    layoutView.children[11].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenThrowsKeywordAndBody: RawUnexpectedNodesSyntax? {
    layoutView.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax? {
    layoutView.children[13].map(RawCodeBlockSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawAccessorListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = AccessorListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .accessorList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawAccessorDeclSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .accessorList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawAccessorDeclSyntax] {
    layoutView.children.map { RawAccessorDeclSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawAccessorBlockSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = AccessorBlockSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .accessorBlock
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftBrace: RawUnexpectedNodesSyntax? = nil,
    leftBrace: RawTokenSyntax,
    _ unexpectedBetweenLeftBraceAndAccessors: RawUnexpectedNodesSyntax? = nil,
    accessors: RawAccessorListSyntax,
    _ unexpectedBetweenAccessorsAndRightBrace: RawUnexpectedNodesSyntax? = nil,
    rightBrace: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .accessorBlock, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftBrace?.raw
      layout[1] = leftBrace.raw
      layout[2] = unexpectedBetweenLeftBraceAndAccessors?.raw
      layout[3] = accessors.raw
      layout[4] = unexpectedBetweenAccessorsAndRightBrace?.raw
      layout[5] = rightBrace.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftBrace: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftBrace: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftBraceAndAccessors: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var accessors: RawAccessorListSyntax {
    layoutView.children[3].map(RawAccessorListSyntax.init(raw:))!
  }
  public var unexpectedBetweenAccessorsAndRightBrace: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightBrace: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPatternBindingSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PatternBindingSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .patternBinding
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforePattern: RawUnexpectedNodesSyntax? = nil,
    pattern: RawPatternSyntax,
    _ unexpectedBetweenPatternAndTypeAnnotation: RawUnexpectedNodesSyntax? = nil,
    typeAnnotation: RawTypeAnnotationSyntax?,
    _ unexpectedBetweenTypeAnnotationAndInitializer: RawUnexpectedNodesSyntax? = nil,
    initializer: RawInitializerClauseSyntax?,
    _ unexpectedBetweenInitializerAndAccessor: RawUnexpectedNodesSyntax? = nil,
    accessor: RawSyntax?,
    _ unexpectedBetweenAccessorAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .patternBinding, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforePattern?.raw
      layout[1] = pattern.raw
      layout[2] = unexpectedBetweenPatternAndTypeAnnotation?.raw
      layout[3] = typeAnnotation?.raw
      layout[4] = unexpectedBetweenTypeAnnotationAndInitializer?.raw
      layout[5] = initializer?.raw
      layout[6] = unexpectedBetweenInitializerAndAccessor?.raw
      layout[7] = accessor?.raw
      layout[8] = unexpectedBetweenAccessorAndTrailingComma?.raw
      layout[9] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforePattern: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax {
    layoutView.children[1].map(RawPatternSyntax.init(raw:))!
  }
  public var unexpectedBetweenPatternAndTypeAnnotation: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var typeAnnotation: RawTypeAnnotationSyntax? {
    layoutView.children[3].map(RawTypeAnnotationSyntax.init(raw:))
  }
  public var unexpectedBetweenTypeAnnotationAndInitializer: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var initializer: RawInitializerClauseSyntax? {
    layoutView.children[5].map(RawInitializerClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenInitializerAndAccessor: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var accessor: RawSyntax? {
    layoutView.children[7]
  }
  public var unexpectedBetweenAccessorAndTrailingComma: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    layoutView.children[9].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawPatternBindingListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PatternBindingListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .patternBindingList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawPatternBindingSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .patternBindingList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawPatternBindingSyntax] {
    layoutView.children.map { RawPatternBindingSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawVariableDeclSyntax: RawDeclSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = VariableDeclSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .variableDecl
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ unexpectedBetweenModifiersAndLetOrVarKeyword: RawUnexpectedNodesSyntax? = nil,
    letOrVarKeyword: RawTokenSyntax,
    _ unexpectedBetweenLetOrVarKeywordAndBindings: RawUnexpectedNodesSyntax? = nil,
    bindings: RawPatternBindingListSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .variableDecl, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = unexpectedBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = unexpectedBetweenModifiersAndLetOrVarKeyword?.raw
      layout[5] = letOrVarKeyword.raw
      layout[6] = unexpectedBetweenLetOrVarKeywordAndBindings?.raw
      layout[7] = bindings.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    layoutView.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    layoutView.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndLetOrVarKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var letOrVarKeyword: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLetOrVarKeywordAndBindings: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var bindings: RawPatternBindingListSyntax {
    layoutView.children[7].map(RawPatternBindingListSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawEnumCaseElementSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = EnumCaseElementSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .enumCaseElement
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ unexpectedBetweenIdentifierAndAssociatedValue: RawUnexpectedNodesSyntax? = nil,
    associatedValue: RawParameterClauseSyntax?,
    _ unexpectedBetweenAssociatedValueAndRawValue: RawUnexpectedNodesSyntax? = nil,
    rawValue: RawInitializerClauseSyntax?,
    _ unexpectedBetweenRawValueAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .enumCaseElement, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeIdentifier?.raw
      layout[1] = identifier.raw
      layout[2] = unexpectedBetweenIdentifierAndAssociatedValue?.raw
      layout[3] = associatedValue?.raw
      layout[4] = unexpectedBetweenAssociatedValueAndRawValue?.raw
      layout[5] = rawValue?.raw
      layout[6] = unexpectedBetweenRawValueAndTrailingComma?.raw
      layout[7] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndAssociatedValue: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var associatedValue: RawParameterClauseSyntax? {
    layoutView.children[3].map(RawParameterClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenAssociatedValueAndRawValue: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rawValue: RawInitializerClauseSyntax? {
    layoutView.children[5].map(RawInitializerClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenRawValueAndTrailingComma: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawEnumCaseElementListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = EnumCaseElementListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .enumCaseElementList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawEnumCaseElementSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .enumCaseElementList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawEnumCaseElementSyntax] {
    layoutView.children.map { RawEnumCaseElementSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawEnumCaseDeclSyntax: RawDeclSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = EnumCaseDeclSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .enumCaseDecl
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ unexpectedBetweenModifiersAndCaseKeyword: RawUnexpectedNodesSyntax? = nil,
    caseKeyword: RawTokenSyntax,
    _ unexpectedBetweenCaseKeywordAndElements: RawUnexpectedNodesSyntax? = nil,
    elements: RawEnumCaseElementListSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .enumCaseDecl, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = unexpectedBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = unexpectedBetweenModifiersAndCaseKeyword?.raw
      layout[5] = caseKeyword.raw
      layout[6] = unexpectedBetweenCaseKeywordAndElements?.raw
      layout[7] = elements.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    layoutView.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    layoutView.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndCaseKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var caseKeyword: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenCaseKeywordAndElements: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var elements: RawEnumCaseElementListSyntax {
    layoutView.children[7].map(RawEnumCaseElementListSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawEnumDeclSyntax: RawDeclSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = EnumDeclSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .enumDecl
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ unexpectedBetweenModifiersAndEnumKeyword: RawUnexpectedNodesSyntax? = nil,
    enumKeyword: RawTokenSyntax,
    _ unexpectedBetweenEnumKeywordAndIdentifier: RawUnexpectedNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ unexpectedBetweenIdentifierAndGenericParameters: RawUnexpectedNodesSyntax? = nil,
    genericParameters: RawGenericParameterClauseSyntax?,
    _ unexpectedBetweenGenericParametersAndInheritanceClause: RawUnexpectedNodesSyntax? = nil,
    inheritanceClause: RawTypeInheritanceClauseSyntax?,
    _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: RawUnexpectedNodesSyntax? = nil,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    _ unexpectedBetweenGenericWhereClauseAndMembers: RawUnexpectedNodesSyntax? = nil,
    members: RawMemberDeclBlockSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .enumDecl, uninitializedCount: 16, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = unexpectedBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = unexpectedBetweenModifiersAndEnumKeyword?.raw
      layout[5] = enumKeyword.raw
      layout[6] = unexpectedBetweenEnumKeywordAndIdentifier?.raw
      layout[7] = identifier.raw
      layout[8] = unexpectedBetweenIdentifierAndGenericParameters?.raw
      layout[9] = genericParameters?.raw
      layout[10] = unexpectedBetweenGenericParametersAndInheritanceClause?.raw
      layout[11] = inheritanceClause?.raw
      layout[12] = unexpectedBetweenInheritanceClauseAndGenericWhereClause?.raw
      layout[13] = genericWhereClause?.raw
      layout[14] = unexpectedBetweenGenericWhereClauseAndMembers?.raw
      layout[15] = members.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    layoutView.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    layoutView.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndEnumKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var enumKeyword: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenEnumKeywordAndIdentifier: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndGenericParameters: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericParameters: RawGenericParameterClauseSyntax? {
    layoutView.children[9].map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericParametersAndInheritanceClause: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    layoutView.children[11].map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenInheritanceClauseAndGenericWhereClause: RawUnexpectedNodesSyntax? {
    layoutView.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    layoutView.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericWhereClauseAndMembers: RawUnexpectedNodesSyntax? {
    layoutView.children[14].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var members: RawMemberDeclBlockSyntax {
    layoutView.children[15].map(RawMemberDeclBlockSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawOperatorDeclSyntax: RawDeclSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = OperatorDeclSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .operatorDecl
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ unexpectedBetweenModifiersAndOperatorKeyword: RawUnexpectedNodesSyntax? = nil,
    operatorKeyword: RawTokenSyntax,
    _ unexpectedBetweenOperatorKeywordAndIdentifier: RawUnexpectedNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ unexpectedBetweenIdentifierAndOperatorPrecedenceAndTypes: RawUnexpectedNodesSyntax? = nil,
    operatorPrecedenceAndTypes: RawOperatorPrecedenceAndTypesSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .operatorDecl, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = unexpectedBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = unexpectedBetweenModifiersAndOperatorKeyword?.raw
      layout[5] = operatorKeyword.raw
      layout[6] = unexpectedBetweenOperatorKeywordAndIdentifier?.raw
      layout[7] = identifier.raw
      layout[8] = unexpectedBetweenIdentifierAndOperatorPrecedenceAndTypes?.raw
      layout[9] = operatorPrecedenceAndTypes?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    layoutView.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    layoutView.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndOperatorKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var operatorKeyword: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenOperatorKeywordAndIdentifier: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndOperatorPrecedenceAndTypes: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var operatorPrecedenceAndTypes: RawOperatorPrecedenceAndTypesSyntax? {
    layoutView.children[9].map(RawOperatorPrecedenceAndTypesSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawDesignatedTypeListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = DesignatedTypeListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .designatedTypeList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawDesignatedTypeElementSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .designatedTypeList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawDesignatedTypeElementSyntax] {
    layoutView.children.map { RawDesignatedTypeElementSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawDesignatedTypeElementSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = DesignatedTypeElementSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .designatedTypeElement
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeadingComma: RawUnexpectedNodesSyntax? = nil,
    leadingComma: RawTokenSyntax,
    _ unexpectedBetweenLeadingCommaAndName: RawUnexpectedNodesSyntax? = nil,
    name: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .designatedTypeElement, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeadingComma?.raw
      layout[1] = leadingComma.raw
      layout[2] = unexpectedBetweenLeadingCommaAndName?.raw
      layout[3] = name.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeadingComma: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leadingComma: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeadingCommaAndName: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawOperatorPrecedenceAndTypesSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = OperatorPrecedenceAndTypesSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .operatorPrecedenceAndTypes
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ unexpectedBetweenColonAndPrecedenceGroup: RawUnexpectedNodesSyntax? = nil,
    precedenceGroup: RawTokenSyntax,
    _ unexpectedBetweenPrecedenceGroupAndDesignatedTypes: RawUnexpectedNodesSyntax? = nil,
    designatedTypes: RawDesignatedTypeListSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .operatorPrecedenceAndTypes, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeColon?.raw
      layout[1] = colon.raw
      layout[2] = unexpectedBetweenColonAndPrecedenceGroup?.raw
      layout[3] = precedenceGroup.raw
      layout[4] = unexpectedBetweenPrecedenceGroupAndDesignatedTypes?.raw
      layout[5] = designatedTypes.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeColon: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndPrecedenceGroup: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var precedenceGroup: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPrecedenceGroupAndDesignatedTypes: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var designatedTypes: RawDesignatedTypeListSyntax {
    layoutView.children[5].map(RawDesignatedTypeListSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPrecedenceGroupDeclSyntax: RawDeclSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PrecedenceGroupDeclSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .precedenceGroupDecl
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ unexpectedBetweenModifiersAndPrecedencegroupKeyword: RawUnexpectedNodesSyntax? = nil,
    precedencegroupKeyword: RawTokenSyntax,
    _ unexpectedBetweenPrecedencegroupKeywordAndIdentifier: RawUnexpectedNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ unexpectedBetweenIdentifierAndLeftBrace: RawUnexpectedNodesSyntax? = nil,
    leftBrace: RawTokenSyntax,
    _ unexpectedBetweenLeftBraceAndGroupAttributes: RawUnexpectedNodesSyntax? = nil,
    groupAttributes: RawPrecedenceGroupAttributeListSyntax,
    _ unexpectedBetweenGroupAttributesAndRightBrace: RawUnexpectedNodesSyntax? = nil,
    rightBrace: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .precedenceGroupDecl, uninitializedCount: 14, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = unexpectedBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = unexpectedBetweenModifiersAndPrecedencegroupKeyword?.raw
      layout[5] = precedencegroupKeyword.raw
      layout[6] = unexpectedBetweenPrecedencegroupKeywordAndIdentifier?.raw
      layout[7] = identifier.raw
      layout[8] = unexpectedBetweenIdentifierAndLeftBrace?.raw
      layout[9] = leftBrace.raw
      layout[10] = unexpectedBetweenLeftBraceAndGroupAttributes?.raw
      layout[11] = groupAttributes.raw
      layout[12] = unexpectedBetweenGroupAttributesAndRightBrace?.raw
      layout[13] = rightBrace.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    layoutView.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    layoutView.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndPrecedencegroupKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var precedencegroupKeyword: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPrecedencegroupKeywordAndIdentifier: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndLeftBrace: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftBrace: RawTokenSyntax {
    layoutView.children[9].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftBraceAndGroupAttributes: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var groupAttributes: RawPrecedenceGroupAttributeListSyntax {
    layoutView.children[11].map(RawPrecedenceGroupAttributeListSyntax.init(raw:))!
  }
  public var unexpectedBetweenGroupAttributesAndRightBrace: RawUnexpectedNodesSyntax? {
    layoutView.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightBrace: RawTokenSyntax {
    layoutView.children[13].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPrecedenceGroupAttributeListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PrecedenceGroupAttributeListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .precedenceGroupAttributeList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .precedenceGroupAttributeList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawSyntax] {
    layoutView.children.map { RawSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawPrecedenceGroupRelationSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PrecedenceGroupRelationSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .precedenceGroupRelation
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeHigherThanOrLowerThan: RawUnexpectedNodesSyntax? = nil,
    higherThanOrLowerThan: RawTokenSyntax,
    _ unexpectedBetweenHigherThanOrLowerThanAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ unexpectedBetweenColonAndOtherNames: RawUnexpectedNodesSyntax? = nil,
    otherNames: RawPrecedenceGroupNameListSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .precedenceGroupRelation, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeHigherThanOrLowerThan?.raw
      layout[1] = higherThanOrLowerThan.raw
      layout[2] = unexpectedBetweenHigherThanOrLowerThanAndColon?.raw
      layout[3] = colon.raw
      layout[4] = unexpectedBetweenColonAndOtherNames?.raw
      layout[5] = otherNames.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeHigherThanOrLowerThan: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var higherThanOrLowerThan: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenHigherThanOrLowerThanAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndOtherNames: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var otherNames: RawPrecedenceGroupNameListSyntax {
    layoutView.children[5].map(RawPrecedenceGroupNameListSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPrecedenceGroupNameListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PrecedenceGroupNameListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .precedenceGroupNameList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawPrecedenceGroupNameElementSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .precedenceGroupNameList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawPrecedenceGroupNameElementSyntax] {
    layoutView.children.map { RawPrecedenceGroupNameElementSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawPrecedenceGroupNameElementSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PrecedenceGroupNameElementSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .precedenceGroupNameElement
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeName: RawUnexpectedNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ unexpectedBetweenNameAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .precedenceGroupNameElement, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeName?.raw
      layout[1] = name.raw
      layout[2] = unexpectedBetweenNameAndTrailingComma?.raw
      layout[3] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeName: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndTrailingComma: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawPrecedenceGroupAssignmentSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PrecedenceGroupAssignmentSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .precedenceGroupAssignment
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAssignmentKeyword: RawUnexpectedNodesSyntax? = nil,
    assignmentKeyword: RawTokenSyntax,
    _ unexpectedBetweenAssignmentKeywordAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ unexpectedBetweenColonAndFlag: RawUnexpectedNodesSyntax? = nil,
    flag: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .precedenceGroupAssignment, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAssignmentKeyword?.raw
      layout[1] = assignmentKeyword.raw
      layout[2] = unexpectedBetweenAssignmentKeywordAndColon?.raw
      layout[3] = colon.raw
      layout[4] = unexpectedBetweenColonAndFlag?.raw
      layout[5] = flag.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAssignmentKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var assignmentKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenAssignmentKeywordAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndFlag: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var flag: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPrecedenceGroupAssociativitySyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PrecedenceGroupAssociativitySyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .precedenceGroupAssociativity
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAssociativityKeyword: RawUnexpectedNodesSyntax? = nil,
    associativityKeyword: RawTokenSyntax,
    _ unexpectedBetweenAssociativityKeywordAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ unexpectedBetweenColonAndValue: RawUnexpectedNodesSyntax? = nil,
    value: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .precedenceGroupAssociativity, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAssociativityKeyword?.raw
      layout[1] = associativityKeyword.raw
      layout[2] = unexpectedBetweenAssociativityKeywordAndColon?.raw
      layout[3] = colon.raw
      layout[4] = unexpectedBetweenColonAndValue?.raw
      layout[5] = value.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAssociativityKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var associativityKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenAssociativityKeywordAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndValue: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var value: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawTokenListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = TokenListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .tokenList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawTokenSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .tokenList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawTokenSyntax] {
    layoutView.children.map { RawTokenSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawNonEmptyTokenListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = NonEmptyTokenListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .nonEmptyTokenList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawTokenSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .nonEmptyTokenList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawTokenSyntax] {
    layoutView.children.map { RawTokenSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawCustomAttributeSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = CustomAttributeSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .customAttribute
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAtSignToken: RawUnexpectedNodesSyntax? = nil,
    atSignToken: RawTokenSyntax,
    _ unexpectedBetweenAtSignTokenAndAttributeName: RawUnexpectedNodesSyntax? = nil,
    attributeName: RawTypeSyntax,
    _ unexpectedBetweenAttributeNameAndLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax?,
    _ unexpectedBetweenLeftParenAndArgumentList: RawUnexpectedNodesSyntax? = nil,
    argumentList: RawTupleExprElementListSyntax?,
    _ unexpectedBetweenArgumentListAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .customAttribute, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAtSignToken?.raw
      layout[1] = atSignToken.raw
      layout[2] = unexpectedBetweenAtSignTokenAndAttributeName?.raw
      layout[3] = attributeName.raw
      layout[4] = unexpectedBetweenAttributeNameAndLeftParen?.raw
      layout[5] = leftParen?.raw
      layout[6] = unexpectedBetweenLeftParenAndArgumentList?.raw
      layout[7] = argumentList?.raw
      layout[8] = unexpectedBetweenArgumentListAndRightParen?.raw
      layout[9] = rightParen?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAtSignToken: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var atSignToken: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenAtSignTokenAndAttributeName: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributeName: RawTypeSyntax {
    layoutView.children[3].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenAttributeNameAndLeftParen: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax? {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenLeftParenAndArgumentList: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var argumentList: RawTupleExprElementListSyntax? {
    layoutView.children[7].map(RawTupleExprElementListSyntax.init(raw:))
  }
  public var unexpectedBetweenArgumentListAndRightParen: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax? {
    layoutView.children[9].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawAttributeSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = AttributeSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .attribute
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAtSignToken: RawUnexpectedNodesSyntax? = nil,
    atSignToken: RawTokenSyntax,
    _ unexpectedBetweenAtSignTokenAndAttributeName: RawUnexpectedNodesSyntax? = nil,
    attributeName: RawTokenSyntax,
    _ unexpectedBetweenAttributeNameAndLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax?,
    _ unexpectedBetweenLeftParenAndArgument: RawUnexpectedNodesSyntax? = nil,
    argument: RawSyntax?,
    _ unexpectedBetweenArgumentAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax?,
    _ unexpectedBetweenRightParenAndTokenList: RawUnexpectedNodesSyntax? = nil,
    tokenList: RawTokenListSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .attribute, uninitializedCount: 12, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAtSignToken?.raw
      layout[1] = atSignToken.raw
      layout[2] = unexpectedBetweenAtSignTokenAndAttributeName?.raw
      layout[3] = attributeName.raw
      layout[4] = unexpectedBetweenAttributeNameAndLeftParen?.raw
      layout[5] = leftParen?.raw
      layout[6] = unexpectedBetweenLeftParenAndArgument?.raw
      layout[7] = argument?.raw
      layout[8] = unexpectedBetweenArgumentAndRightParen?.raw
      layout[9] = rightParen?.raw
      layout[10] = unexpectedBetweenRightParenAndTokenList?.raw
      layout[11] = tokenList?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAtSignToken: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var atSignToken: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenAtSignTokenAndAttributeName: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributeName: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenAttributeNameAndLeftParen: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax? {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenLeftParenAndArgument: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var argument: RawSyntax? {
    layoutView.children[7]
  }
  public var unexpectedBetweenArgumentAndRightParen: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax? {
    layoutView.children[9].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenRightParenAndTokenList: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var tokenList: RawTokenListSyntax? {
    layoutView.children[11].map(RawTokenListSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawAttributeListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = AttributeListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .attributeList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .attributeList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawSyntax] {
    layoutView.children.map { RawSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawSpecializeAttributeSpecListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = SpecializeAttributeSpecListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .specializeAttributeSpecList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .specializeAttributeSpecList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawSyntax] {
    layoutView.children.map { RawSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawAvailabilityEntrySyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = AvailabilityEntrySyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .availabilityEntry
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLabel: RawUnexpectedNodesSyntax? = nil,
    label: RawTokenSyntax,
    _ unexpectedBetweenLabelAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ unexpectedBetweenColonAndAvailabilityList: RawUnexpectedNodesSyntax? = nil,
    availabilityList: RawAvailabilitySpecListSyntax,
    _ unexpectedBetweenAvailabilityListAndSemicolon: RawUnexpectedNodesSyntax? = nil,
    semicolon: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .availabilityEntry, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLabel?.raw
      layout[1] = label.raw
      layout[2] = unexpectedBetweenLabelAndColon?.raw
      layout[3] = colon.raw
      layout[4] = unexpectedBetweenColonAndAvailabilityList?.raw
      layout[5] = availabilityList.raw
      layout[6] = unexpectedBetweenAvailabilityListAndSemicolon?.raw
      layout[7] = semicolon.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLabel: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var label: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLabelAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndAvailabilityList: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var availabilityList: RawAvailabilitySpecListSyntax {
    layoutView.children[5].map(RawAvailabilitySpecListSyntax.init(raw:))!
  }
  public var unexpectedBetweenAvailabilityListAndSemicolon: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var semicolon: RawTokenSyntax {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawLabeledSpecializeEntrySyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = LabeledSpecializeEntrySyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .labeledSpecializeEntry
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLabel: RawUnexpectedNodesSyntax? = nil,
    label: RawTokenSyntax,
    _ unexpectedBetweenLabelAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ unexpectedBetweenColonAndValue: RawUnexpectedNodesSyntax? = nil,
    value: RawTokenSyntax,
    _ unexpectedBetweenValueAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .labeledSpecializeEntry, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLabel?.raw
      layout[1] = label.raw
      layout[2] = unexpectedBetweenLabelAndColon?.raw
      layout[3] = colon.raw
      layout[4] = unexpectedBetweenColonAndValue?.raw
      layout[5] = value.raw
      layout[6] = unexpectedBetweenValueAndTrailingComma?.raw
      layout[7] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLabel: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var label: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLabelAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndValue: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var value: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenValueAndTrailingComma: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawTargetFunctionEntrySyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = TargetFunctionEntrySyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .targetFunctionEntry
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLabel: RawUnexpectedNodesSyntax? = nil,
    label: RawTokenSyntax,
    _ unexpectedBetweenLabelAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ unexpectedBetweenColonAndDeclname: RawUnexpectedNodesSyntax? = nil,
    declname: RawDeclNameSyntax,
    _ unexpectedBetweenDeclnameAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .targetFunctionEntry, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLabel?.raw
      layout[1] = label.raw
      layout[2] = unexpectedBetweenLabelAndColon?.raw
      layout[3] = colon.raw
      layout[4] = unexpectedBetweenColonAndDeclname?.raw
      layout[5] = declname.raw
      layout[6] = unexpectedBetweenDeclnameAndTrailingComma?.raw
      layout[7] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLabel: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var label: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLabelAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndDeclname: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var declname: RawDeclNameSyntax {
    layoutView.children[5].map(RawDeclNameSyntax.init(raw:))!
  }
  public var unexpectedBetweenDeclnameAndTrailingComma: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawNamedAttributeStringArgumentSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = NamedAttributeStringArgumentSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .namedAttributeStringArgument
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeNameTok: RawUnexpectedNodesSyntax? = nil,
    nameTok: RawTokenSyntax,
    _ unexpectedBetweenNameTokAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ unexpectedBetweenColonAndStringOrDeclname: RawUnexpectedNodesSyntax? = nil,
    stringOrDeclname: RawSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .namedAttributeStringArgument, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeNameTok?.raw
      layout[1] = nameTok.raw
      layout[2] = unexpectedBetweenNameTokAndColon?.raw
      layout[3] = colon.raw
      layout[4] = unexpectedBetweenColonAndStringOrDeclname?.raw
      layout[5] = stringOrDeclname.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeNameTok: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var nameTok: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameTokAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndStringOrDeclname: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var stringOrDeclname: RawSyntax {
    layoutView.children[5]!
  }
}

@_spi(RawSyntax)
public struct RawDeclNameSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = DeclNameSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .declName
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeDeclBaseName: RawUnexpectedNodesSyntax? = nil,
    declBaseName: RawSyntax,
    _ unexpectedBetweenDeclBaseNameAndDeclNameArguments: RawUnexpectedNodesSyntax? = nil,
    declNameArguments: RawDeclNameArgumentsSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .declName, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeDeclBaseName?.raw
      layout[1] = declBaseName.raw
      layout[2] = unexpectedBetweenDeclBaseNameAndDeclNameArguments?.raw
      layout[3] = declNameArguments?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeDeclBaseName: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var declBaseName: RawSyntax {
    layoutView.children[1]!
  }
  public var unexpectedBetweenDeclBaseNameAndDeclNameArguments: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var declNameArguments: RawDeclNameArgumentsSyntax? {
    layoutView.children[3].map(RawDeclNameArgumentsSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawImplementsAttributeArgumentsSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ImplementsAttributeArgumentsSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .implementsAttributeArguments
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeType: RawUnexpectedNodesSyntax? = nil,
    type: RawTypeSyntax,
    _ unexpectedBetweenTypeAndComma: RawUnexpectedNodesSyntax? = nil,
    comma: RawTokenSyntax,
    _ unexpectedBetweenCommaAndDeclBaseName: RawUnexpectedNodesSyntax? = nil,
    declBaseName: RawTokenSyntax,
    _ unexpectedBetweenDeclBaseNameAndDeclNameArguments: RawUnexpectedNodesSyntax? = nil,
    declNameArguments: RawDeclNameArgumentsSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .implementsAttributeArguments, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeType?.raw
      layout[1] = type.raw
      layout[2] = unexpectedBetweenTypeAndComma?.raw
      layout[3] = comma.raw
      layout[4] = unexpectedBetweenCommaAndDeclBaseName?.raw
      layout[5] = declBaseName.raw
      layout[6] = unexpectedBetweenDeclBaseNameAndDeclNameArguments?.raw
      layout[7] = declNameArguments?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeType: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var type: RawTypeSyntax {
    layoutView.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenTypeAndComma: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var comma: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenCommaAndDeclBaseName: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var declBaseName: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenDeclBaseNameAndDeclNameArguments: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var declNameArguments: RawDeclNameArgumentsSyntax? {
    layoutView.children[7].map(RawDeclNameArgumentsSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawObjCSelectorPieceSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ObjCSelectorPieceSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .objCSelectorPiece
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeName: RawUnexpectedNodesSyntax? = nil,
    name: RawTokenSyntax?,
    _ unexpectedBetweenNameAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .objCSelectorPiece, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeName?.raw
      layout[1] = name?.raw
      layout[2] = unexpectedBetweenNameAndColon?.raw
      layout[3] = colon?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeName: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax? {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenNameAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawObjCSelectorSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ObjCSelectorSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .objCSelector
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawObjCSelectorPieceSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .objCSelector, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawObjCSelectorPieceSyntax] {
    layoutView.children.map { RawObjCSelectorPieceSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawDifferentiableAttributeArgumentsSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = DifferentiableAttributeArgumentsSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .differentiableAttributeArguments
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeDiffKind: RawUnexpectedNodesSyntax? = nil,
    diffKind: RawTokenSyntax?,
    _ unexpectedBetweenDiffKindAndDiffKindComma: RawUnexpectedNodesSyntax? = nil,
    diffKindComma: RawTokenSyntax?,
    _ unexpectedBetweenDiffKindCommaAndDiffParams: RawUnexpectedNodesSyntax? = nil,
    diffParams: RawDifferentiabilityParamsClauseSyntax?,
    _ unexpectedBetweenDiffParamsAndDiffParamsComma: RawUnexpectedNodesSyntax? = nil,
    diffParamsComma: RawTokenSyntax?,
    _ unexpectedBetweenDiffParamsCommaAndWhereClause: RawUnexpectedNodesSyntax? = nil,
    whereClause: RawGenericWhereClauseSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .differentiableAttributeArguments, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeDiffKind?.raw
      layout[1] = diffKind?.raw
      layout[2] = unexpectedBetweenDiffKindAndDiffKindComma?.raw
      layout[3] = diffKindComma?.raw
      layout[4] = unexpectedBetweenDiffKindCommaAndDiffParams?.raw
      layout[5] = diffParams?.raw
      layout[6] = unexpectedBetweenDiffParamsAndDiffParamsComma?.raw
      layout[7] = diffParamsComma?.raw
      layout[8] = unexpectedBetweenDiffParamsCommaAndWhereClause?.raw
      layout[9] = whereClause?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeDiffKind: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var diffKind: RawTokenSyntax? {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenDiffKindAndDiffKindComma: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var diffKindComma: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenDiffKindCommaAndDiffParams: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var diffParams: RawDifferentiabilityParamsClauseSyntax? {
    layoutView.children[5].map(RawDifferentiabilityParamsClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenDiffParamsAndDiffParamsComma: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var diffParamsComma: RawTokenSyntax? {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenDiffParamsCommaAndWhereClause: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var whereClause: RawGenericWhereClauseSyntax? {
    layoutView.children[9].map(RawGenericWhereClauseSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawDifferentiabilityParamsClauseSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = DifferentiabilityParamsClauseSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .differentiabilityParamsClause
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeWrtLabel: RawUnexpectedNodesSyntax? = nil,
    wrtLabel: RawTokenSyntax,
    _ unexpectedBetweenWrtLabelAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ unexpectedBetweenColonAndParameters: RawUnexpectedNodesSyntax? = nil,
    parameters: RawSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .differentiabilityParamsClause, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeWrtLabel?.raw
      layout[1] = wrtLabel.raw
      layout[2] = unexpectedBetweenWrtLabelAndColon?.raw
      layout[3] = colon.raw
      layout[4] = unexpectedBetweenColonAndParameters?.raw
      layout[5] = parameters.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeWrtLabel: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var wrtLabel: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenWrtLabelAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndParameters: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var parameters: RawSyntax {
    layoutView.children[5]!
  }
}

@_spi(RawSyntax)
public struct RawDifferentiabilityParamsSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = DifferentiabilityParamsSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .differentiabilityParams
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ unexpectedBetweenLeftParenAndDiffParams: RawUnexpectedNodesSyntax? = nil,
    diffParams: RawDifferentiabilityParamListSyntax,
    _ unexpectedBetweenDiffParamsAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .differentiabilityParams, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftParen?.raw
      layout[1] = leftParen.raw
      layout[2] = unexpectedBetweenLeftParenAndDiffParams?.raw
      layout[3] = diffParams.raw
      layout[4] = unexpectedBetweenDiffParamsAndRightParen?.raw
      layout[5] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndDiffParams: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var diffParams: RawDifferentiabilityParamListSyntax {
    layoutView.children[3].map(RawDifferentiabilityParamListSyntax.init(raw:))!
  }
  public var unexpectedBetweenDiffParamsAndRightParen: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawDifferentiabilityParamListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = DifferentiabilityParamListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .differentiabilityParamList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawDifferentiabilityParamSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .differentiabilityParamList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawDifferentiabilityParamSyntax] {
    layoutView.children.map { RawDifferentiabilityParamSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawDifferentiabilityParamSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = DifferentiabilityParamSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .differentiabilityParam
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeParameter: RawUnexpectedNodesSyntax? = nil,
    parameter: RawSyntax,
    _ unexpectedBetweenParameterAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .differentiabilityParam, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeParameter?.raw
      layout[1] = parameter.raw
      layout[2] = unexpectedBetweenParameterAndTrailingComma?.raw
      layout[3] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeParameter: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var parameter: RawSyntax {
    layoutView.children[1]!
  }
  public var unexpectedBetweenParameterAndTrailingComma: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawDerivativeRegistrationAttributeArgumentsSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = DerivativeRegistrationAttributeArgumentsSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .derivativeRegistrationAttributeArguments
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeOfLabel: RawUnexpectedNodesSyntax? = nil,
    ofLabel: RawTokenSyntax,
    _ unexpectedBetweenOfLabelAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ unexpectedBetweenColonAndOriginalDeclName: RawUnexpectedNodesSyntax? = nil,
    originalDeclName: RawQualifiedDeclNameSyntax,
    _ unexpectedBetweenOriginalDeclNameAndPeriod: RawUnexpectedNodesSyntax? = nil,
    period: RawTokenSyntax?,
    _ unexpectedBetweenPeriodAndAccessorKind: RawUnexpectedNodesSyntax? = nil,
    accessorKind: RawTokenSyntax?,
    _ unexpectedBetweenAccessorKindAndComma: RawUnexpectedNodesSyntax? = nil,
    comma: RawTokenSyntax?,
    _ unexpectedBetweenCommaAndDiffParams: RawUnexpectedNodesSyntax? = nil,
    diffParams: RawDifferentiabilityParamsClauseSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .derivativeRegistrationAttributeArguments, uninitializedCount: 14, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeOfLabel?.raw
      layout[1] = ofLabel.raw
      layout[2] = unexpectedBetweenOfLabelAndColon?.raw
      layout[3] = colon.raw
      layout[4] = unexpectedBetweenColonAndOriginalDeclName?.raw
      layout[5] = originalDeclName.raw
      layout[6] = unexpectedBetweenOriginalDeclNameAndPeriod?.raw
      layout[7] = period?.raw
      layout[8] = unexpectedBetweenPeriodAndAccessorKind?.raw
      layout[9] = accessorKind?.raw
      layout[10] = unexpectedBetweenAccessorKindAndComma?.raw
      layout[11] = comma?.raw
      layout[12] = unexpectedBetweenCommaAndDiffParams?.raw
      layout[13] = diffParams?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeOfLabel: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var ofLabel: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenOfLabelAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndOriginalDeclName: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var originalDeclName: RawQualifiedDeclNameSyntax {
    layoutView.children[5].map(RawQualifiedDeclNameSyntax.init(raw:))!
  }
  public var unexpectedBetweenOriginalDeclNameAndPeriod: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var period: RawTokenSyntax? {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenPeriodAndAccessorKind: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var accessorKind: RawTokenSyntax? {
    layoutView.children[9].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenAccessorKindAndComma: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var comma: RawTokenSyntax? {
    layoutView.children[11].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenCommaAndDiffParams: RawUnexpectedNodesSyntax? {
    layoutView.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var diffParams: RawDifferentiabilityParamsClauseSyntax? {
    layoutView.children[13].map(RawDifferentiabilityParamsClauseSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawQualifiedDeclNameSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = QualifiedDeclNameSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .qualifiedDeclName
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeBaseType: RawUnexpectedNodesSyntax? = nil,
    baseType: RawTypeSyntax?,
    _ unexpectedBetweenBaseTypeAndDot: RawUnexpectedNodesSyntax? = nil,
    dot: RawTokenSyntax?,
    _ unexpectedBetweenDotAndName: RawUnexpectedNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ unexpectedBetweenNameAndArguments: RawUnexpectedNodesSyntax? = nil,
    arguments: RawDeclNameArgumentsSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .qualifiedDeclName, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeBaseType?.raw
      layout[1] = baseType?.raw
      layout[2] = unexpectedBetweenBaseTypeAndDot?.raw
      layout[3] = dot?.raw
      layout[4] = unexpectedBetweenDotAndName?.raw
      layout[5] = name.raw
      layout[6] = unexpectedBetweenNameAndArguments?.raw
      layout[7] = arguments?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeBaseType: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var baseType: RawTypeSyntax? {
    layoutView.children[1].map(RawTypeSyntax.init(raw:))
  }
  public var unexpectedBetweenBaseTypeAndDot: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var dot: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenDotAndName: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndArguments: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var arguments: RawDeclNameArgumentsSyntax? {
    layoutView.children[7].map(RawDeclNameArgumentsSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawFunctionDeclNameSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = FunctionDeclNameSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .functionDeclName
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeName: RawUnexpectedNodesSyntax? = nil,
    name: RawSyntax,
    _ unexpectedBetweenNameAndArguments: RawUnexpectedNodesSyntax? = nil,
    arguments: RawDeclNameArgumentsSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .functionDeclName, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeName?.raw
      layout[1] = name.raw
      layout[2] = unexpectedBetweenNameAndArguments?.raw
      layout[3] = arguments?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeName: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawSyntax {
    layoutView.children[1]!
  }
  public var unexpectedBetweenNameAndArguments: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var arguments: RawDeclNameArgumentsSyntax? {
    layoutView.children[3].map(RawDeclNameArgumentsSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawBackDeployAttributeSpecListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = BackDeployAttributeSpecListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .backDeployAttributeSpecList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeBeforeLabel: RawUnexpectedNodesSyntax? = nil,
    beforeLabel: RawTokenSyntax,
    _ unexpectedBetweenBeforeLabelAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ unexpectedBetweenColonAndVersionList: RawUnexpectedNodesSyntax? = nil,
    versionList: RawBackDeployVersionListSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .backDeployAttributeSpecList, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeBeforeLabel?.raw
      layout[1] = beforeLabel.raw
      layout[2] = unexpectedBetweenBeforeLabelAndColon?.raw
      layout[3] = colon.raw
      layout[4] = unexpectedBetweenColonAndVersionList?.raw
      layout[5] = versionList.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeBeforeLabel: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var beforeLabel: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenBeforeLabelAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndVersionList: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var versionList: RawBackDeployVersionListSyntax {
    layoutView.children[5].map(RawBackDeployVersionListSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawBackDeployVersionListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = BackDeployVersionListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .backDeployVersionList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawBackDeployVersionArgumentSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .backDeployVersionList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawBackDeployVersionArgumentSyntax] {
    layoutView.children.map { RawBackDeployVersionArgumentSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawBackDeployVersionArgumentSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = BackDeployVersionArgumentSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .backDeployVersionArgument
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAvailabilityVersionRestriction: RawUnexpectedNodesSyntax? = nil,
    availabilityVersionRestriction: RawAvailabilityVersionRestrictionSyntax,
    _ unexpectedBetweenAvailabilityVersionRestrictionAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .backDeployVersionArgument, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAvailabilityVersionRestriction?.raw
      layout[1] = availabilityVersionRestriction.raw
      layout[2] = unexpectedBetweenAvailabilityVersionRestrictionAndTrailingComma?.raw
      layout[3] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAvailabilityVersionRestriction: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var availabilityVersionRestriction: RawAvailabilityVersionRestrictionSyntax {
    layoutView.children[1].map(RawAvailabilityVersionRestrictionSyntax.init(raw:))!
  }
  public var unexpectedBetweenAvailabilityVersionRestrictionAndTrailingComma: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawOpaqueReturnTypeOfAttributeArgumentsSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = OpaqueReturnTypeOfAttributeArgumentsSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .opaqueReturnTypeOfAttributeArguments
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeMangledName: RawUnexpectedNodesSyntax? = nil,
    mangledName: RawTokenSyntax,
    _ unexpectedBetweenMangledNameAndComma: RawUnexpectedNodesSyntax? = nil,
    comma: RawTokenSyntax,
    _ unexpectedBetweenCommaAndOrdinal: RawUnexpectedNodesSyntax? = nil,
    ordinal: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .opaqueReturnTypeOfAttributeArguments, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeMangledName?.raw
      layout[1] = mangledName.raw
      layout[2] = unexpectedBetweenMangledNameAndComma?.raw
      layout[3] = comma.raw
      layout[4] = unexpectedBetweenCommaAndOrdinal?.raw
      layout[5] = ordinal.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeMangledName: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var mangledName: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenMangledNameAndComma: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var comma: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenCommaAndOrdinal: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var ordinal: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawConventionAttributeArgumentsSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ConventionAttributeArgumentsSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .conventionAttributeArguments
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeConventionLabel: RawUnexpectedNodesSyntax? = nil,
    conventionLabel: RawTokenSyntax,
    _ unexpectedBetweenConventionLabelAndComma: RawUnexpectedNodesSyntax? = nil,
    comma: RawTokenSyntax?,
    _ unexpectedBetweenCommaAndCTypeLabel: RawUnexpectedNodesSyntax? = nil,
    cTypeLabel: RawTokenSyntax?,
    _ unexpectedBetweenCTypeLabelAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax?,
    _ unexpectedBetweenColonAndCTypeString: RawUnexpectedNodesSyntax? = nil,
    cTypeString: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .conventionAttributeArguments, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeConventionLabel?.raw
      layout[1] = conventionLabel.raw
      layout[2] = unexpectedBetweenConventionLabelAndComma?.raw
      layout[3] = comma?.raw
      layout[4] = unexpectedBetweenCommaAndCTypeLabel?.raw
      layout[5] = cTypeLabel?.raw
      layout[6] = unexpectedBetweenCTypeLabelAndColon?.raw
      layout[7] = colon?.raw
      layout[8] = unexpectedBetweenColonAndCTypeString?.raw
      layout[9] = cTypeString?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeConventionLabel: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var conventionLabel: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenConventionLabelAndComma: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var comma: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenCommaAndCTypeLabel: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var cTypeLabel: RawTokenSyntax? {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenCTypeLabelAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax? {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenColonAndCTypeString: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var cTypeString: RawTokenSyntax? {
    layoutView.children[9].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawConventionWitnessMethodAttributeArgumentsSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ConventionWitnessMethodAttributeArgumentsSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .conventionWitnessMethodAttributeArguments
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeWitnessMethodLabel: RawUnexpectedNodesSyntax? = nil,
    witnessMethodLabel: RawTokenSyntax,
    _ unexpectedBetweenWitnessMethodLabelAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ unexpectedBetweenColonAndProtocolName: RawUnexpectedNodesSyntax? = nil,
    protocolName: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .conventionWitnessMethodAttributeArguments, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeWitnessMethodLabel?.raw
      layout[1] = witnessMethodLabel.raw
      layout[2] = unexpectedBetweenWitnessMethodLabelAndColon?.raw
      layout[3] = colon.raw
      layout[4] = unexpectedBetweenColonAndProtocolName?.raw
      layout[5] = protocolName.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeWitnessMethodLabel: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var witnessMethodLabel: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenWitnessMethodLabelAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndProtocolName: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var protocolName: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawLabeledStmtSyntax: RawStmtSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = LabeledStmtSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .labeledStmt
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLabelName: RawUnexpectedNodesSyntax? = nil,
    labelName: RawTokenSyntax,
    _ unexpectedBetweenLabelNameAndLabelColon: RawUnexpectedNodesSyntax? = nil,
    labelColon: RawTokenSyntax,
    _ unexpectedBetweenLabelColonAndStatement: RawUnexpectedNodesSyntax? = nil,
    statement: RawStmtSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .labeledStmt, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLabelName?.raw
      layout[1] = labelName.raw
      layout[2] = unexpectedBetweenLabelNameAndLabelColon?.raw
      layout[3] = labelColon.raw
      layout[4] = unexpectedBetweenLabelColonAndStatement?.raw
      layout[5] = statement.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLabelName: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var labelName: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLabelNameAndLabelColon: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var labelColon: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLabelColonAndStatement: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var statement: RawStmtSyntax {
    layoutView.children[5].map(RawStmtSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawContinueStmtSyntax: RawStmtSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ContinueStmtSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .continueStmt
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeContinueKeyword: RawUnexpectedNodesSyntax? = nil,
    continueKeyword: RawTokenSyntax,
    _ unexpectedBetweenContinueKeywordAndLabel: RawUnexpectedNodesSyntax? = nil,
    label: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .continueStmt, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeContinueKeyword?.raw
      layout[1] = continueKeyword.raw
      layout[2] = unexpectedBetweenContinueKeywordAndLabel?.raw
      layout[3] = label?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeContinueKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var continueKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenContinueKeywordAndLabel: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var label: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawWhileStmtSyntax: RawStmtSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = WhileStmtSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .whileStmt
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeWhileKeyword: RawUnexpectedNodesSyntax? = nil,
    whileKeyword: RawTokenSyntax,
    _ unexpectedBetweenWhileKeywordAndConditions: RawUnexpectedNodesSyntax? = nil,
    conditions: RawConditionElementListSyntax,
    _ unexpectedBetweenConditionsAndBody: RawUnexpectedNodesSyntax? = nil,
    body: RawCodeBlockSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .whileStmt, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeWhileKeyword?.raw
      layout[1] = whileKeyword.raw
      layout[2] = unexpectedBetweenWhileKeywordAndConditions?.raw
      layout[3] = conditions.raw
      layout[4] = unexpectedBetweenConditionsAndBody?.raw
      layout[5] = body.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeWhileKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var whileKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenWhileKeywordAndConditions: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var conditions: RawConditionElementListSyntax {
    layoutView.children[3].map(RawConditionElementListSyntax.init(raw:))!
  }
  public var unexpectedBetweenConditionsAndBody: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax {
    layoutView.children[5].map(RawCodeBlockSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawDeferStmtSyntax: RawStmtSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = DeferStmtSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .deferStmt
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeDeferKeyword: RawUnexpectedNodesSyntax? = nil,
    deferKeyword: RawTokenSyntax,
    _ unexpectedBetweenDeferKeywordAndBody: RawUnexpectedNodesSyntax? = nil,
    body: RawCodeBlockSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .deferStmt, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeDeferKeyword?.raw
      layout[1] = deferKeyword.raw
      layout[2] = unexpectedBetweenDeferKeywordAndBody?.raw
      layout[3] = body.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeDeferKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var deferKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenDeferKeywordAndBody: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax {
    layoutView.children[3].map(RawCodeBlockSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawExpressionStmtSyntax: RawStmtSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ExpressionStmtSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .expressionStmt
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeExpression: RawUnexpectedNodesSyntax? = nil,
    expression: RawExprSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .expressionStmt, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeExpression?.raw
      layout[1] = expression.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    layoutView.children[1].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawSwitchCaseListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = SwitchCaseListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .switchCaseList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .switchCaseList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawSyntax] {
    layoutView.children.map { RawSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawRepeatWhileStmtSyntax: RawStmtSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = RepeatWhileStmtSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .repeatWhileStmt
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeRepeatKeyword: RawUnexpectedNodesSyntax? = nil,
    repeatKeyword: RawTokenSyntax,
    _ unexpectedBetweenRepeatKeywordAndBody: RawUnexpectedNodesSyntax? = nil,
    body: RawCodeBlockSyntax,
    _ unexpectedBetweenBodyAndWhileKeyword: RawUnexpectedNodesSyntax? = nil,
    whileKeyword: RawTokenSyntax,
    _ unexpectedBetweenWhileKeywordAndCondition: RawUnexpectedNodesSyntax? = nil,
    condition: RawExprSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .repeatWhileStmt, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeRepeatKeyword?.raw
      layout[1] = repeatKeyword.raw
      layout[2] = unexpectedBetweenRepeatKeywordAndBody?.raw
      layout[3] = body.raw
      layout[4] = unexpectedBetweenBodyAndWhileKeyword?.raw
      layout[5] = whileKeyword.raw
      layout[6] = unexpectedBetweenWhileKeywordAndCondition?.raw
      layout[7] = condition.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeRepeatKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var repeatKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenRepeatKeywordAndBody: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax {
    layoutView.children[3].map(RawCodeBlockSyntax.init(raw:))!
  }
  public var unexpectedBetweenBodyAndWhileKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var whileKeyword: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenWhileKeywordAndCondition: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var condition: RawExprSyntax {
    layoutView.children[7].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawGuardStmtSyntax: RawStmtSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = GuardStmtSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .guardStmt
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeGuardKeyword: RawUnexpectedNodesSyntax? = nil,
    guardKeyword: RawTokenSyntax,
    _ unexpectedBetweenGuardKeywordAndConditions: RawUnexpectedNodesSyntax? = nil,
    conditions: RawConditionElementListSyntax,
    _ unexpectedBetweenConditionsAndElseKeyword: RawUnexpectedNodesSyntax? = nil,
    elseKeyword: RawTokenSyntax,
    _ unexpectedBetweenElseKeywordAndBody: RawUnexpectedNodesSyntax? = nil,
    body: RawCodeBlockSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .guardStmt, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeGuardKeyword?.raw
      layout[1] = guardKeyword.raw
      layout[2] = unexpectedBetweenGuardKeywordAndConditions?.raw
      layout[3] = conditions.raw
      layout[4] = unexpectedBetweenConditionsAndElseKeyword?.raw
      layout[5] = elseKeyword.raw
      layout[6] = unexpectedBetweenElseKeywordAndBody?.raw
      layout[7] = body.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeGuardKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var guardKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenGuardKeywordAndConditions: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var conditions: RawConditionElementListSyntax {
    layoutView.children[3].map(RawConditionElementListSyntax.init(raw:))!
  }
  public var unexpectedBetweenConditionsAndElseKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var elseKeyword: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenElseKeywordAndBody: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax {
    layoutView.children[7].map(RawCodeBlockSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawWhereClauseSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = WhereClauseSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .whereClause
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeWhereKeyword: RawUnexpectedNodesSyntax? = nil,
    whereKeyword: RawTokenSyntax,
    _ unexpectedBetweenWhereKeywordAndGuardResult: RawUnexpectedNodesSyntax? = nil,
    guardResult: RawExprSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .whereClause, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeWhereKeyword?.raw
      layout[1] = whereKeyword.raw
      layout[2] = unexpectedBetweenWhereKeywordAndGuardResult?.raw
      layout[3] = guardResult.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeWhereKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var whereKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenWhereKeywordAndGuardResult: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var guardResult: RawExprSyntax {
    layoutView.children[3].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawForInStmtSyntax: RawStmtSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ForInStmtSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .forInStmt
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeForKeyword: RawUnexpectedNodesSyntax? = nil,
    forKeyword: RawTokenSyntax,
    _ unexpectedBetweenForKeywordAndTryKeyword: RawUnexpectedNodesSyntax? = nil,
    tryKeyword: RawTokenSyntax?,
    _ unexpectedBetweenTryKeywordAndAwaitKeyword: RawUnexpectedNodesSyntax? = nil,
    awaitKeyword: RawTokenSyntax?,
    _ unexpectedBetweenAwaitKeywordAndCaseKeyword: RawUnexpectedNodesSyntax? = nil,
    caseKeyword: RawTokenSyntax?,
    _ unexpectedBetweenCaseKeywordAndPattern: RawUnexpectedNodesSyntax? = nil,
    pattern: RawPatternSyntax,
    _ unexpectedBetweenPatternAndTypeAnnotation: RawUnexpectedNodesSyntax? = nil,
    typeAnnotation: RawTypeAnnotationSyntax?,
    _ unexpectedBetweenTypeAnnotationAndInKeyword: RawUnexpectedNodesSyntax? = nil,
    inKeyword: RawTokenSyntax,
    _ unexpectedBetweenInKeywordAndSequenceExpr: RawUnexpectedNodesSyntax? = nil,
    sequenceExpr: RawExprSyntax,
    _ unexpectedBetweenSequenceExprAndWhereClause: RawUnexpectedNodesSyntax? = nil,
    whereClause: RawWhereClauseSyntax?,
    _ unexpectedBetweenWhereClauseAndBody: RawUnexpectedNodesSyntax? = nil,
    body: RawCodeBlockSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .forInStmt, uninitializedCount: 20, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeForKeyword?.raw
      layout[1] = forKeyword.raw
      layout[2] = unexpectedBetweenForKeywordAndTryKeyword?.raw
      layout[3] = tryKeyword?.raw
      layout[4] = unexpectedBetweenTryKeywordAndAwaitKeyword?.raw
      layout[5] = awaitKeyword?.raw
      layout[6] = unexpectedBetweenAwaitKeywordAndCaseKeyword?.raw
      layout[7] = caseKeyword?.raw
      layout[8] = unexpectedBetweenCaseKeywordAndPattern?.raw
      layout[9] = pattern.raw
      layout[10] = unexpectedBetweenPatternAndTypeAnnotation?.raw
      layout[11] = typeAnnotation?.raw
      layout[12] = unexpectedBetweenTypeAnnotationAndInKeyword?.raw
      layout[13] = inKeyword.raw
      layout[14] = unexpectedBetweenInKeywordAndSequenceExpr?.raw
      layout[15] = sequenceExpr.raw
      layout[16] = unexpectedBetweenSequenceExprAndWhereClause?.raw
      layout[17] = whereClause?.raw
      layout[18] = unexpectedBetweenWhereClauseAndBody?.raw
      layout[19] = body.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeForKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var forKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenForKeywordAndTryKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var tryKeyword: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenTryKeywordAndAwaitKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var awaitKeyword: RawTokenSyntax? {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenAwaitKeywordAndCaseKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var caseKeyword: RawTokenSyntax? {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenCaseKeywordAndPattern: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax {
    layoutView.children[9].map(RawPatternSyntax.init(raw:))!
  }
  public var unexpectedBetweenPatternAndTypeAnnotation: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var typeAnnotation: RawTypeAnnotationSyntax? {
    layoutView.children[11].map(RawTypeAnnotationSyntax.init(raw:))
  }
  public var unexpectedBetweenTypeAnnotationAndInKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var inKeyword: RawTokenSyntax {
    layoutView.children[13].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenInKeywordAndSequenceExpr: RawUnexpectedNodesSyntax? {
    layoutView.children[14].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var sequenceExpr: RawExprSyntax {
    layoutView.children[15].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenSequenceExprAndWhereClause: RawUnexpectedNodesSyntax? {
    layoutView.children[16].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var whereClause: RawWhereClauseSyntax? {
    layoutView.children[17].map(RawWhereClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenWhereClauseAndBody: RawUnexpectedNodesSyntax? {
    layoutView.children[18].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax {
    layoutView.children[19].map(RawCodeBlockSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawSwitchStmtSyntax: RawStmtSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = SwitchStmtSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .switchStmt
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeSwitchKeyword: RawUnexpectedNodesSyntax? = nil,
    switchKeyword: RawTokenSyntax,
    _ unexpectedBetweenSwitchKeywordAndExpression: RawUnexpectedNodesSyntax? = nil,
    expression: RawExprSyntax,
    _ unexpectedBetweenExpressionAndLeftBrace: RawUnexpectedNodesSyntax? = nil,
    leftBrace: RawTokenSyntax,
    _ unexpectedBetweenLeftBraceAndCases: RawUnexpectedNodesSyntax? = nil,
    cases: RawSwitchCaseListSyntax,
    _ unexpectedBetweenCasesAndRightBrace: RawUnexpectedNodesSyntax? = nil,
    rightBrace: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .switchStmt, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeSwitchKeyword?.raw
      layout[1] = switchKeyword.raw
      layout[2] = unexpectedBetweenSwitchKeywordAndExpression?.raw
      layout[3] = expression.raw
      layout[4] = unexpectedBetweenExpressionAndLeftBrace?.raw
      layout[5] = leftBrace.raw
      layout[6] = unexpectedBetweenLeftBraceAndCases?.raw
      layout[7] = cases.raw
      layout[8] = unexpectedBetweenCasesAndRightBrace?.raw
      layout[9] = rightBrace.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeSwitchKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var switchKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenSwitchKeywordAndExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    layoutView.children[3].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenExpressionAndLeftBrace: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftBrace: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftBraceAndCases: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var cases: RawSwitchCaseListSyntax {
    layoutView.children[7].map(RawSwitchCaseListSyntax.init(raw:))!
  }
  public var unexpectedBetweenCasesAndRightBrace: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightBrace: RawTokenSyntax {
    layoutView.children[9].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawCatchClauseListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = CatchClauseListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .catchClauseList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawCatchClauseSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .catchClauseList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawCatchClauseSyntax] {
    layoutView.children.map { RawCatchClauseSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawDoStmtSyntax: RawStmtSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = DoStmtSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .doStmt
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeDoKeyword: RawUnexpectedNodesSyntax? = nil,
    doKeyword: RawTokenSyntax,
    _ unexpectedBetweenDoKeywordAndBody: RawUnexpectedNodesSyntax? = nil,
    body: RawCodeBlockSyntax,
    _ unexpectedBetweenBodyAndCatchClauses: RawUnexpectedNodesSyntax? = nil,
    catchClauses: RawCatchClauseListSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .doStmt, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeDoKeyword?.raw
      layout[1] = doKeyword.raw
      layout[2] = unexpectedBetweenDoKeywordAndBody?.raw
      layout[3] = body.raw
      layout[4] = unexpectedBetweenBodyAndCatchClauses?.raw
      layout[5] = catchClauses?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeDoKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var doKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenDoKeywordAndBody: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax {
    layoutView.children[3].map(RawCodeBlockSyntax.init(raw:))!
  }
  public var unexpectedBetweenBodyAndCatchClauses: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var catchClauses: RawCatchClauseListSyntax? {
    layoutView.children[5].map(RawCatchClauseListSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawReturnStmtSyntax: RawStmtSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ReturnStmtSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .returnStmt
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeReturnKeyword: RawUnexpectedNodesSyntax? = nil,
    returnKeyword: RawTokenSyntax,
    _ unexpectedBetweenReturnKeywordAndExpression: RawUnexpectedNodesSyntax? = nil,
    expression: RawExprSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .returnStmt, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeReturnKeyword?.raw
      layout[1] = returnKeyword.raw
      layout[2] = unexpectedBetweenReturnKeywordAndExpression?.raw
      layout[3] = expression?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeReturnKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var returnKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenReturnKeywordAndExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax? {
    layoutView.children[3].map(RawExprSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawYieldStmtSyntax: RawStmtSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = YieldStmtSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .yieldStmt
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeYieldKeyword: RawUnexpectedNodesSyntax? = nil,
    yieldKeyword: RawTokenSyntax,
    _ unexpectedBetweenYieldKeywordAndYields: RawUnexpectedNodesSyntax? = nil,
    yields: RawSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .yieldStmt, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeYieldKeyword?.raw
      layout[1] = yieldKeyword.raw
      layout[2] = unexpectedBetweenYieldKeywordAndYields?.raw
      layout[3] = yields.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeYieldKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var yieldKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenYieldKeywordAndYields: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var yields: RawSyntax {
    layoutView.children[3]!
  }
}

@_spi(RawSyntax)
public struct RawYieldListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = YieldListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .yieldList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ unexpectedBetweenLeftParenAndElementList: RawUnexpectedNodesSyntax? = nil,
    elementList: RawYieldExprListSyntax,
    _ unexpectedBetweenElementListAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .yieldList, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftParen?.raw
      layout[1] = leftParen.raw
      layout[2] = unexpectedBetweenLeftParenAndElementList?.raw
      layout[3] = elementList.raw
      layout[4] = unexpectedBetweenElementListAndRightParen?.raw
      layout[5] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndElementList: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var elementList: RawYieldExprListSyntax {
    layoutView.children[3].map(RawYieldExprListSyntax.init(raw:))!
  }
  public var unexpectedBetweenElementListAndRightParen: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawFallthroughStmtSyntax: RawStmtSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = FallthroughStmtSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .fallthroughStmt
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeFallthroughKeyword: RawUnexpectedNodesSyntax? = nil,
    fallthroughKeyword: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .fallthroughStmt, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeFallthroughKeyword?.raw
      layout[1] = fallthroughKeyword.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeFallthroughKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var fallthroughKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawBreakStmtSyntax: RawStmtSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = BreakStmtSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .breakStmt
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeBreakKeyword: RawUnexpectedNodesSyntax? = nil,
    breakKeyword: RawTokenSyntax,
    _ unexpectedBetweenBreakKeywordAndLabel: RawUnexpectedNodesSyntax? = nil,
    label: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .breakStmt, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeBreakKeyword?.raw
      layout[1] = breakKeyword.raw
      layout[2] = unexpectedBetweenBreakKeywordAndLabel?.raw
      layout[3] = label?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeBreakKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var breakKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenBreakKeywordAndLabel: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var label: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawCaseItemListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = CaseItemListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .caseItemList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawCaseItemSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .caseItemList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawCaseItemSyntax] {
    layoutView.children.map { RawCaseItemSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawCatchItemListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = CatchItemListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .catchItemList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawCatchItemSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .catchItemList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawCatchItemSyntax] {
    layoutView.children.map { RawCatchItemSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawConditionElementSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ConditionElementSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .conditionElement
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeCondition: RawUnexpectedNodesSyntax? = nil,
    condition: RawSyntax,
    _ unexpectedBetweenConditionAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .conditionElement, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeCondition?.raw
      layout[1] = condition.raw
      layout[2] = unexpectedBetweenConditionAndTrailingComma?.raw
      layout[3] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeCondition: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var condition: RawSyntax {
    layoutView.children[1]!
  }
  public var unexpectedBetweenConditionAndTrailingComma: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawAvailabilityConditionSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = AvailabilityConditionSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .availabilityCondition
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforePoundAvailableKeyword: RawUnexpectedNodesSyntax? = nil,
    poundAvailableKeyword: RawTokenSyntax,
    _ unexpectedBetweenPoundAvailableKeywordAndLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ unexpectedBetweenLeftParenAndAvailabilitySpec: RawUnexpectedNodesSyntax? = nil,
    availabilitySpec: RawAvailabilitySpecListSyntax,
    _ unexpectedBetweenAvailabilitySpecAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .availabilityCondition, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforePoundAvailableKeyword?.raw
      layout[1] = poundAvailableKeyword.raw
      layout[2] = unexpectedBetweenPoundAvailableKeywordAndLeftParen?.raw
      layout[3] = leftParen.raw
      layout[4] = unexpectedBetweenLeftParenAndAvailabilitySpec?.raw
      layout[5] = availabilitySpec.raw
      layout[6] = unexpectedBetweenAvailabilitySpecAndRightParen?.raw
      layout[7] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforePoundAvailableKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var poundAvailableKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPoundAvailableKeywordAndLeftParen: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndAvailabilitySpec: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var availabilitySpec: RawAvailabilitySpecListSyntax {
    layoutView.children[5].map(RawAvailabilitySpecListSyntax.init(raw:))!
  }
  public var unexpectedBetweenAvailabilitySpecAndRightParen: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawMatchingPatternConditionSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = MatchingPatternConditionSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .matchingPatternCondition
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeCaseKeyword: RawUnexpectedNodesSyntax? = nil,
    caseKeyword: RawTokenSyntax,
    _ unexpectedBetweenCaseKeywordAndPattern: RawUnexpectedNodesSyntax? = nil,
    pattern: RawPatternSyntax,
    _ unexpectedBetweenPatternAndTypeAnnotation: RawUnexpectedNodesSyntax? = nil,
    typeAnnotation: RawTypeAnnotationSyntax?,
    _ unexpectedBetweenTypeAnnotationAndInitializer: RawUnexpectedNodesSyntax? = nil,
    initializer: RawInitializerClauseSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .matchingPatternCondition, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeCaseKeyword?.raw
      layout[1] = caseKeyword.raw
      layout[2] = unexpectedBetweenCaseKeywordAndPattern?.raw
      layout[3] = pattern.raw
      layout[4] = unexpectedBetweenPatternAndTypeAnnotation?.raw
      layout[5] = typeAnnotation?.raw
      layout[6] = unexpectedBetweenTypeAnnotationAndInitializer?.raw
      layout[7] = initializer.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeCaseKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var caseKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenCaseKeywordAndPattern: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax {
    layoutView.children[3].map(RawPatternSyntax.init(raw:))!
  }
  public var unexpectedBetweenPatternAndTypeAnnotation: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var typeAnnotation: RawTypeAnnotationSyntax? {
    layoutView.children[5].map(RawTypeAnnotationSyntax.init(raw:))
  }
  public var unexpectedBetweenTypeAnnotationAndInitializer: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var initializer: RawInitializerClauseSyntax {
    layoutView.children[7].map(RawInitializerClauseSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawOptionalBindingConditionSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = OptionalBindingConditionSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .optionalBindingCondition
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLetOrVarKeyword: RawUnexpectedNodesSyntax? = nil,
    letOrVarKeyword: RawTokenSyntax,
    _ unexpectedBetweenLetOrVarKeywordAndPattern: RawUnexpectedNodesSyntax? = nil,
    pattern: RawPatternSyntax,
    _ unexpectedBetweenPatternAndTypeAnnotation: RawUnexpectedNodesSyntax? = nil,
    typeAnnotation: RawTypeAnnotationSyntax?,
    _ unexpectedBetweenTypeAnnotationAndInitializer: RawUnexpectedNodesSyntax? = nil,
    initializer: RawInitializerClauseSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .optionalBindingCondition, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLetOrVarKeyword?.raw
      layout[1] = letOrVarKeyword.raw
      layout[2] = unexpectedBetweenLetOrVarKeywordAndPattern?.raw
      layout[3] = pattern.raw
      layout[4] = unexpectedBetweenPatternAndTypeAnnotation?.raw
      layout[5] = typeAnnotation?.raw
      layout[6] = unexpectedBetweenTypeAnnotationAndInitializer?.raw
      layout[7] = initializer?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLetOrVarKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var letOrVarKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLetOrVarKeywordAndPattern: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax {
    layoutView.children[3].map(RawPatternSyntax.init(raw:))!
  }
  public var unexpectedBetweenPatternAndTypeAnnotation: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var typeAnnotation: RawTypeAnnotationSyntax? {
    layoutView.children[5].map(RawTypeAnnotationSyntax.init(raw:))
  }
  public var unexpectedBetweenTypeAnnotationAndInitializer: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var initializer: RawInitializerClauseSyntax? {
    layoutView.children[7].map(RawInitializerClauseSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawUnavailabilityConditionSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = UnavailabilityConditionSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .unavailabilityCondition
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforePoundUnavailableKeyword: RawUnexpectedNodesSyntax? = nil,
    poundUnavailableKeyword: RawTokenSyntax,
    _ unexpectedBetweenPoundUnavailableKeywordAndLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ unexpectedBetweenLeftParenAndAvailabilitySpec: RawUnexpectedNodesSyntax? = nil,
    availabilitySpec: RawAvailabilitySpecListSyntax,
    _ unexpectedBetweenAvailabilitySpecAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .unavailabilityCondition, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforePoundUnavailableKeyword?.raw
      layout[1] = poundUnavailableKeyword.raw
      layout[2] = unexpectedBetweenPoundUnavailableKeywordAndLeftParen?.raw
      layout[3] = leftParen.raw
      layout[4] = unexpectedBetweenLeftParenAndAvailabilitySpec?.raw
      layout[5] = availabilitySpec.raw
      layout[6] = unexpectedBetweenAvailabilitySpecAndRightParen?.raw
      layout[7] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforePoundUnavailableKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var poundUnavailableKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPoundUnavailableKeywordAndLeftParen: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndAvailabilitySpec: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var availabilitySpec: RawAvailabilitySpecListSyntax {
    layoutView.children[5].map(RawAvailabilitySpecListSyntax.init(raw:))!
  }
  public var unexpectedBetweenAvailabilitySpecAndRightParen: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawHasSymbolConditionSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = HasSymbolConditionSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .hasSymbolCondition
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeHasSymbolKeyword: RawUnexpectedNodesSyntax? = nil,
    hasSymbolKeyword: RawTokenSyntax,
    _ unexpectedBetweenHasSymbolKeywordAndLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ unexpectedBetweenLeftParenAndExpression: RawUnexpectedNodesSyntax? = nil,
    expression: RawExprSyntax,
    _ unexpectedBetweenExpressionAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .hasSymbolCondition, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeHasSymbolKeyword?.raw
      layout[1] = hasSymbolKeyword.raw
      layout[2] = unexpectedBetweenHasSymbolKeywordAndLeftParen?.raw
      layout[3] = leftParen.raw
      layout[4] = unexpectedBetweenLeftParenAndExpression?.raw
      layout[5] = expression.raw
      layout[6] = unexpectedBetweenExpressionAndRightParen?.raw
      layout[7] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeHasSymbolKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var hasSymbolKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenHasSymbolKeywordAndLeftParen: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    layoutView.children[5].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenExpressionAndRightParen: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawConditionElementListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ConditionElementListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .conditionElementList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawConditionElementSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .conditionElementList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawConditionElementSyntax] {
    layoutView.children.map { RawConditionElementSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawDeclarationStmtSyntax: RawStmtSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = DeclarationStmtSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .declarationStmt
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeDeclaration: RawUnexpectedNodesSyntax? = nil,
    declaration: RawDeclSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .declarationStmt, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeDeclaration?.raw
      layout[1] = declaration.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeDeclaration: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var declaration: RawDeclSyntax {
    layoutView.children[1].map(RawDeclSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawThrowStmtSyntax: RawStmtSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ThrowStmtSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .throwStmt
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeThrowKeyword: RawUnexpectedNodesSyntax? = nil,
    throwKeyword: RawTokenSyntax,
    _ unexpectedBetweenThrowKeywordAndExpression: RawUnexpectedNodesSyntax? = nil,
    expression: RawExprSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .throwStmt, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeThrowKeyword?.raw
      layout[1] = throwKeyword.raw
      layout[2] = unexpectedBetweenThrowKeywordAndExpression?.raw
      layout[3] = expression.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeThrowKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var throwKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenThrowKeywordAndExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    layoutView.children[3].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawIfStmtSyntax: RawStmtSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = IfStmtSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .ifStmt
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeIfKeyword: RawUnexpectedNodesSyntax? = nil,
    ifKeyword: RawTokenSyntax,
    _ unexpectedBetweenIfKeywordAndConditions: RawUnexpectedNodesSyntax? = nil,
    conditions: RawConditionElementListSyntax,
    _ unexpectedBetweenConditionsAndBody: RawUnexpectedNodesSyntax? = nil,
    body: RawCodeBlockSyntax,
    _ unexpectedBetweenBodyAndElseKeyword: RawUnexpectedNodesSyntax? = nil,
    elseKeyword: RawTokenSyntax?,
    _ unexpectedBetweenElseKeywordAndElseBody: RawUnexpectedNodesSyntax? = nil,
    elseBody: RawSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .ifStmt, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeIfKeyword?.raw
      layout[1] = ifKeyword.raw
      layout[2] = unexpectedBetweenIfKeywordAndConditions?.raw
      layout[3] = conditions.raw
      layout[4] = unexpectedBetweenConditionsAndBody?.raw
      layout[5] = body.raw
      layout[6] = unexpectedBetweenBodyAndElseKeyword?.raw
      layout[7] = elseKeyword?.raw
      layout[8] = unexpectedBetweenElseKeywordAndElseBody?.raw
      layout[9] = elseBody?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeIfKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var ifKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIfKeywordAndConditions: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var conditions: RawConditionElementListSyntax {
    layoutView.children[3].map(RawConditionElementListSyntax.init(raw:))!
  }
  public var unexpectedBetweenConditionsAndBody: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax {
    layoutView.children[5].map(RawCodeBlockSyntax.init(raw:))!
  }
  public var unexpectedBetweenBodyAndElseKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var elseKeyword: RawTokenSyntax? {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenElseKeywordAndElseBody: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var elseBody: RawSyntax? {
    layoutView.children[9]
  }
}

@_spi(RawSyntax)
public struct RawElseIfContinuationSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ElseIfContinuationSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .elseIfContinuation
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeIfStatement: RawUnexpectedNodesSyntax? = nil,
    ifStatement: RawIfStmtSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .elseIfContinuation, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeIfStatement?.raw
      layout[1] = ifStatement.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeIfStatement: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var ifStatement: RawIfStmtSyntax {
    layoutView.children[1].map(RawIfStmtSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawElseBlockSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ElseBlockSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .elseBlock
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeElseKeyword: RawUnexpectedNodesSyntax? = nil,
    elseKeyword: RawTokenSyntax,
    _ unexpectedBetweenElseKeywordAndBody: RawUnexpectedNodesSyntax? = nil,
    body: RawCodeBlockSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .elseBlock, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeElseKeyword?.raw
      layout[1] = elseKeyword.raw
      layout[2] = unexpectedBetweenElseKeywordAndBody?.raw
      layout[3] = body.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeElseKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var elseKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenElseKeywordAndBody: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax {
    layoutView.children[3].map(RawCodeBlockSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawSwitchCaseSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = SwitchCaseSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .switchCase
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeUnknownAttr: RawUnexpectedNodesSyntax? = nil,
    unknownAttr: RawAttributeSyntax?,
    _ unexpectedBetweenUnknownAttrAndLabel: RawUnexpectedNodesSyntax? = nil,
    label: RawSyntax,
    _ unexpectedBetweenLabelAndStatements: RawUnexpectedNodesSyntax? = nil,
    statements: RawCodeBlockItemListSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .switchCase, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeUnknownAttr?.raw
      layout[1] = unknownAttr?.raw
      layout[2] = unexpectedBetweenUnknownAttrAndLabel?.raw
      layout[3] = label.raw
      layout[4] = unexpectedBetweenLabelAndStatements?.raw
      layout[5] = statements.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeUnknownAttr: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var unknownAttr: RawAttributeSyntax? {
    layoutView.children[1].map(RawAttributeSyntax.init(raw:))
  }
  public var unexpectedBetweenUnknownAttrAndLabel: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var label: RawSyntax {
    layoutView.children[3]!
  }
  public var unexpectedBetweenLabelAndStatements: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var statements: RawCodeBlockItemListSyntax {
    layoutView.children[5].map(RawCodeBlockItemListSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawSwitchDefaultLabelSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = SwitchDefaultLabelSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .switchDefaultLabel
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeDefaultKeyword: RawUnexpectedNodesSyntax? = nil,
    defaultKeyword: RawTokenSyntax,
    _ unexpectedBetweenDefaultKeywordAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .switchDefaultLabel, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeDefaultKeyword?.raw
      layout[1] = defaultKeyword.raw
      layout[2] = unexpectedBetweenDefaultKeywordAndColon?.raw
      layout[3] = colon.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeDefaultKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var defaultKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenDefaultKeywordAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawCaseItemSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = CaseItemSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .caseItem
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforePattern: RawUnexpectedNodesSyntax? = nil,
    pattern: RawPatternSyntax,
    _ unexpectedBetweenPatternAndWhereClause: RawUnexpectedNodesSyntax? = nil,
    whereClause: RawWhereClauseSyntax?,
    _ unexpectedBetweenWhereClauseAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .caseItem, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforePattern?.raw
      layout[1] = pattern.raw
      layout[2] = unexpectedBetweenPatternAndWhereClause?.raw
      layout[3] = whereClause?.raw
      layout[4] = unexpectedBetweenWhereClauseAndTrailingComma?.raw
      layout[5] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforePattern: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax {
    layoutView.children[1].map(RawPatternSyntax.init(raw:))!
  }
  public var unexpectedBetweenPatternAndWhereClause: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var whereClause: RawWhereClauseSyntax? {
    layoutView.children[3].map(RawWhereClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenWhereClauseAndTrailingComma: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawCatchItemSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = CatchItemSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .catchItem
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforePattern: RawUnexpectedNodesSyntax? = nil,
    pattern: RawPatternSyntax?,
    _ unexpectedBetweenPatternAndWhereClause: RawUnexpectedNodesSyntax? = nil,
    whereClause: RawWhereClauseSyntax?,
    _ unexpectedBetweenWhereClauseAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .catchItem, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforePattern?.raw
      layout[1] = pattern?.raw
      layout[2] = unexpectedBetweenPatternAndWhereClause?.raw
      layout[3] = whereClause?.raw
      layout[4] = unexpectedBetweenWhereClauseAndTrailingComma?.raw
      layout[5] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforePattern: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax? {
    layoutView.children[1].map(RawPatternSyntax.init(raw:))
  }
  public var unexpectedBetweenPatternAndWhereClause: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var whereClause: RawWhereClauseSyntax? {
    layoutView.children[3].map(RawWhereClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenWhereClauseAndTrailingComma: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawSwitchCaseLabelSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = SwitchCaseLabelSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .switchCaseLabel
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeCaseKeyword: RawUnexpectedNodesSyntax? = nil,
    caseKeyword: RawTokenSyntax,
    _ unexpectedBetweenCaseKeywordAndCaseItems: RawUnexpectedNodesSyntax? = nil,
    caseItems: RawCaseItemListSyntax,
    _ unexpectedBetweenCaseItemsAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .switchCaseLabel, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeCaseKeyword?.raw
      layout[1] = caseKeyword.raw
      layout[2] = unexpectedBetweenCaseKeywordAndCaseItems?.raw
      layout[3] = caseItems.raw
      layout[4] = unexpectedBetweenCaseItemsAndColon?.raw
      layout[5] = colon.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeCaseKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var caseKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenCaseKeywordAndCaseItems: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var caseItems: RawCaseItemListSyntax {
    layoutView.children[3].map(RawCaseItemListSyntax.init(raw:))!
  }
  public var unexpectedBetweenCaseItemsAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawCatchClauseSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = CatchClauseSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .catchClause
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeCatchKeyword: RawUnexpectedNodesSyntax? = nil,
    catchKeyword: RawTokenSyntax,
    _ unexpectedBetweenCatchKeywordAndCatchItems: RawUnexpectedNodesSyntax? = nil,
    catchItems: RawCatchItemListSyntax?,
    _ unexpectedBetweenCatchItemsAndBody: RawUnexpectedNodesSyntax? = nil,
    body: RawCodeBlockSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .catchClause, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeCatchKeyword?.raw
      layout[1] = catchKeyword.raw
      layout[2] = unexpectedBetweenCatchKeywordAndCatchItems?.raw
      layout[3] = catchItems?.raw
      layout[4] = unexpectedBetweenCatchItemsAndBody?.raw
      layout[5] = body.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeCatchKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var catchKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenCatchKeywordAndCatchItems: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var catchItems: RawCatchItemListSyntax? {
    layoutView.children[3].map(RawCatchItemListSyntax.init(raw:))
  }
  public var unexpectedBetweenCatchItemsAndBody: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax {
    layoutView.children[5].map(RawCodeBlockSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPoundAssertStmtSyntax: RawStmtSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PoundAssertStmtSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .poundAssertStmt
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforePoundAssert: RawUnexpectedNodesSyntax? = nil,
    poundAssert: RawTokenSyntax,
    _ unexpectedBetweenPoundAssertAndLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ unexpectedBetweenLeftParenAndCondition: RawUnexpectedNodesSyntax? = nil,
    condition: RawExprSyntax,
    _ unexpectedBetweenConditionAndComma: RawUnexpectedNodesSyntax? = nil,
    comma: RawTokenSyntax?,
    _ unexpectedBetweenCommaAndMessage: RawUnexpectedNodesSyntax? = nil,
    message: RawTokenSyntax?,
    _ unexpectedBetweenMessageAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .poundAssertStmt, uninitializedCount: 12, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforePoundAssert?.raw
      layout[1] = poundAssert.raw
      layout[2] = unexpectedBetweenPoundAssertAndLeftParen?.raw
      layout[3] = leftParen.raw
      layout[4] = unexpectedBetweenLeftParenAndCondition?.raw
      layout[5] = condition.raw
      layout[6] = unexpectedBetweenConditionAndComma?.raw
      layout[7] = comma?.raw
      layout[8] = unexpectedBetweenCommaAndMessage?.raw
      layout[9] = message?.raw
      layout[10] = unexpectedBetweenMessageAndRightParen?.raw
      layout[11] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforePoundAssert: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var poundAssert: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPoundAssertAndLeftParen: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndCondition: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var condition: RawExprSyntax {
    layoutView.children[5].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenConditionAndComma: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var comma: RawTokenSyntax? {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenCommaAndMessage: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var message: RawTokenSyntax? {
    layoutView.children[9].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenMessageAndRightParen: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    layoutView.children[11].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawGenericWhereClauseSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = GenericWhereClauseSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .genericWhereClause
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeWhereKeyword: RawUnexpectedNodesSyntax? = nil,
    whereKeyword: RawTokenSyntax,
    _ unexpectedBetweenWhereKeywordAndRequirementList: RawUnexpectedNodesSyntax? = nil,
    requirementList: RawGenericRequirementListSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .genericWhereClause, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeWhereKeyword?.raw
      layout[1] = whereKeyword.raw
      layout[2] = unexpectedBetweenWhereKeywordAndRequirementList?.raw
      layout[3] = requirementList.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeWhereKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var whereKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenWhereKeywordAndRequirementList: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var requirementList: RawGenericRequirementListSyntax {
    layoutView.children[3].map(RawGenericRequirementListSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawGenericRequirementListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = GenericRequirementListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .genericRequirementList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawGenericRequirementSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .genericRequirementList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawGenericRequirementSyntax] {
    layoutView.children.map { RawGenericRequirementSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawGenericRequirementSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = GenericRequirementSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .genericRequirement
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeBody: RawUnexpectedNodesSyntax? = nil,
    body: RawSyntax,
    _ unexpectedBetweenBodyAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .genericRequirement, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeBody?.raw
      layout[1] = body.raw
      layout[2] = unexpectedBetweenBodyAndTrailingComma?.raw
      layout[3] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeBody: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var body: RawSyntax {
    layoutView.children[1]!
  }
  public var unexpectedBetweenBodyAndTrailingComma: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawSameTypeRequirementSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = SameTypeRequirementSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .sameTypeRequirement
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftTypeIdentifier: RawUnexpectedNodesSyntax? = nil,
    leftTypeIdentifier: RawTypeSyntax,
    _ unexpectedBetweenLeftTypeIdentifierAndEqualityToken: RawUnexpectedNodesSyntax? = nil,
    equalityToken: RawTokenSyntax,
    _ unexpectedBetweenEqualityTokenAndRightTypeIdentifier: RawUnexpectedNodesSyntax? = nil,
    rightTypeIdentifier: RawTypeSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .sameTypeRequirement, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftTypeIdentifier?.raw
      layout[1] = leftTypeIdentifier.raw
      layout[2] = unexpectedBetweenLeftTypeIdentifierAndEqualityToken?.raw
      layout[3] = equalityToken.raw
      layout[4] = unexpectedBetweenEqualityTokenAndRightTypeIdentifier?.raw
      layout[5] = rightTypeIdentifier.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftTypeIdentifier: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftTypeIdentifier: RawTypeSyntax {
    layoutView.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftTypeIdentifierAndEqualityToken: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var equalityToken: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenEqualityTokenAndRightTypeIdentifier: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightTypeIdentifier: RawTypeSyntax {
    layoutView.children[5].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawLayoutRequirementSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = LayoutRequirementSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .layoutRequirement
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeTypeIdentifier: RawUnexpectedNodesSyntax? = nil,
    typeIdentifier: RawTypeSyntax,
    _ unexpectedBetweenTypeIdentifierAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ unexpectedBetweenColonAndLayoutConstraint: RawUnexpectedNodesSyntax? = nil,
    layoutConstraint: RawTokenSyntax,
    _ unexpectedBetweenLayoutConstraintAndLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax?,
    _ unexpectedBetweenLeftParenAndSize: RawUnexpectedNodesSyntax? = nil,
    size: RawTokenSyntax?,
    _ unexpectedBetweenSizeAndComma: RawUnexpectedNodesSyntax? = nil,
    comma: RawTokenSyntax?,
    _ unexpectedBetweenCommaAndAlignment: RawUnexpectedNodesSyntax? = nil,
    alignment: RawTokenSyntax?,
    _ unexpectedBetweenAlignmentAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .layoutRequirement, uninitializedCount: 16, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeTypeIdentifier?.raw
      layout[1] = typeIdentifier.raw
      layout[2] = unexpectedBetweenTypeIdentifierAndColon?.raw
      layout[3] = colon.raw
      layout[4] = unexpectedBetweenColonAndLayoutConstraint?.raw
      layout[5] = layoutConstraint.raw
      layout[6] = unexpectedBetweenLayoutConstraintAndLeftParen?.raw
      layout[7] = leftParen?.raw
      layout[8] = unexpectedBetweenLeftParenAndSize?.raw
      layout[9] = size?.raw
      layout[10] = unexpectedBetweenSizeAndComma?.raw
      layout[11] = comma?.raw
      layout[12] = unexpectedBetweenCommaAndAlignment?.raw
      layout[13] = alignment?.raw
      layout[14] = unexpectedBetweenAlignmentAndRightParen?.raw
      layout[15] = rightParen?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeTypeIdentifier: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var typeIdentifier: RawTypeSyntax {
    layoutView.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenTypeIdentifierAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndLayoutConstraint: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var layoutConstraint: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLayoutConstraintAndLeftParen: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax? {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenLeftParenAndSize: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var size: RawTokenSyntax? {
    layoutView.children[9].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenSizeAndComma: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var comma: RawTokenSyntax? {
    layoutView.children[11].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenCommaAndAlignment: RawUnexpectedNodesSyntax? {
    layoutView.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var alignment: RawTokenSyntax? {
    layoutView.children[13].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenAlignmentAndRightParen: RawUnexpectedNodesSyntax? {
    layoutView.children[14].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax? {
    layoutView.children[15].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawGenericParameterListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = GenericParameterListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .genericParameterList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawGenericParameterSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .genericParameterList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawGenericParameterSyntax] {
    layoutView.children.map { RawGenericParameterSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawGenericParameterSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = GenericParameterSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .genericParameter
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ unexpectedBetweenAttributesAndName: RawUnexpectedNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ unexpectedBetweenNameAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax?,
    _ unexpectedBetweenColonAndInheritedType: RawUnexpectedNodesSyntax? = nil,
    inheritedType: RawTypeSyntax?,
    _ unexpectedBetweenInheritedTypeAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .genericParameter, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = unexpectedBetweenAttributesAndName?.raw
      layout[3] = name.raw
      layout[4] = unexpectedBetweenNameAndColon?.raw
      layout[5] = colon?.raw
      layout[6] = unexpectedBetweenColonAndInheritedType?.raw
      layout[7] = inheritedType?.raw
      layout[8] = unexpectedBetweenInheritedTypeAndTrailingComma?.raw
      layout[9] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    layoutView.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndName: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax? {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenColonAndInheritedType: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var inheritedType: RawTypeSyntax? {
    layoutView.children[7].map(RawTypeSyntax.init(raw:))
  }
  public var unexpectedBetweenInheritedTypeAndTrailingComma: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    layoutView.children[9].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawPrimaryAssociatedTypeListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PrimaryAssociatedTypeListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .primaryAssociatedTypeList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawPrimaryAssociatedTypeSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .primaryAssociatedTypeList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawPrimaryAssociatedTypeSyntax] {
    layoutView.children.map { RawPrimaryAssociatedTypeSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawPrimaryAssociatedTypeSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PrimaryAssociatedTypeSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .primaryAssociatedType
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeName: RawUnexpectedNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ unexpectedBetweenNameAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .primaryAssociatedType, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeName?.raw
      layout[1] = name.raw
      layout[2] = unexpectedBetweenNameAndTrailingComma?.raw
      layout[3] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeName: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndTrailingComma: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawGenericParameterClauseSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = GenericParameterClauseSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .genericParameterClause
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftAngleBracket: RawUnexpectedNodesSyntax? = nil,
    leftAngleBracket: RawTokenSyntax,
    _ unexpectedBetweenLeftAngleBracketAndGenericParameterList: RawUnexpectedNodesSyntax? = nil,
    genericParameterList: RawGenericParameterListSyntax,
    _ unexpectedBetweenGenericParameterListAndGenericWhereClause: RawUnexpectedNodesSyntax? = nil,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    _ unexpectedBetweenGenericWhereClauseAndRightAngleBracket: RawUnexpectedNodesSyntax? = nil,
    rightAngleBracket: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .genericParameterClause, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftAngleBracket?.raw
      layout[1] = leftAngleBracket.raw
      layout[2] = unexpectedBetweenLeftAngleBracketAndGenericParameterList?.raw
      layout[3] = genericParameterList.raw
      layout[4] = unexpectedBetweenGenericParameterListAndGenericWhereClause?.raw
      layout[5] = genericWhereClause?.raw
      layout[6] = unexpectedBetweenGenericWhereClauseAndRightAngleBracket?.raw
      layout[7] = rightAngleBracket.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftAngleBracket: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftAngleBracket: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftAngleBracketAndGenericParameterList: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericParameterList: RawGenericParameterListSyntax {
    layoutView.children[3].map(RawGenericParameterListSyntax.init(raw:))!
  }
  public var unexpectedBetweenGenericParameterListAndGenericWhereClause: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    layoutView.children[5].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericWhereClauseAndRightAngleBracket: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightAngleBracket: RawTokenSyntax {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawConformanceRequirementSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ConformanceRequirementSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .conformanceRequirement
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftTypeIdentifier: RawUnexpectedNodesSyntax? = nil,
    leftTypeIdentifier: RawTypeSyntax,
    _ unexpectedBetweenLeftTypeIdentifierAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ unexpectedBetweenColonAndRightTypeIdentifier: RawUnexpectedNodesSyntax? = nil,
    rightTypeIdentifier: RawTypeSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .conformanceRequirement, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftTypeIdentifier?.raw
      layout[1] = leftTypeIdentifier.raw
      layout[2] = unexpectedBetweenLeftTypeIdentifierAndColon?.raw
      layout[3] = colon.raw
      layout[4] = unexpectedBetweenColonAndRightTypeIdentifier?.raw
      layout[5] = rightTypeIdentifier.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftTypeIdentifier: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftTypeIdentifier: RawTypeSyntax {
    layoutView.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftTypeIdentifierAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndRightTypeIdentifier: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightTypeIdentifier: RawTypeSyntax {
    layoutView.children[5].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPrimaryAssociatedTypeClauseSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PrimaryAssociatedTypeClauseSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .primaryAssociatedTypeClause
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftAngleBracket: RawUnexpectedNodesSyntax? = nil,
    leftAngleBracket: RawTokenSyntax,
    _ unexpectedBetweenLeftAngleBracketAndPrimaryAssociatedTypeList: RawUnexpectedNodesSyntax? = nil,
    primaryAssociatedTypeList: RawPrimaryAssociatedTypeListSyntax,
    _ unexpectedBetweenPrimaryAssociatedTypeListAndRightAngleBracket: RawUnexpectedNodesSyntax? = nil,
    rightAngleBracket: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .primaryAssociatedTypeClause, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftAngleBracket?.raw
      layout[1] = leftAngleBracket.raw
      layout[2] = unexpectedBetweenLeftAngleBracketAndPrimaryAssociatedTypeList?.raw
      layout[3] = primaryAssociatedTypeList.raw
      layout[4] = unexpectedBetweenPrimaryAssociatedTypeListAndRightAngleBracket?.raw
      layout[5] = rightAngleBracket.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftAngleBracket: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftAngleBracket: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftAngleBracketAndPrimaryAssociatedTypeList: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var primaryAssociatedTypeList: RawPrimaryAssociatedTypeListSyntax {
    layoutView.children[3].map(RawPrimaryAssociatedTypeListSyntax.init(raw:))!
  }
  public var unexpectedBetweenPrimaryAssociatedTypeListAndRightAngleBracket: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightAngleBracket: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawSimpleTypeIdentifierSyntax: RawTypeSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = SimpleTypeIdentifierSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .simpleTypeIdentifier
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeName: RawUnexpectedNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ unexpectedBetweenNameAndGenericArgumentClause: RawUnexpectedNodesSyntax? = nil,
    genericArgumentClause: RawGenericArgumentClauseSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .simpleTypeIdentifier, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeName?.raw
      layout[1] = name.raw
      layout[2] = unexpectedBetweenNameAndGenericArgumentClause?.raw
      layout[3] = genericArgumentClause?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeName: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndGenericArgumentClause: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericArgumentClause: RawGenericArgumentClauseSyntax? {
    layoutView.children[3].map(RawGenericArgumentClauseSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawMemberTypeIdentifierSyntax: RawTypeSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = MemberTypeIdentifierSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .memberTypeIdentifier
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeBaseType: RawUnexpectedNodesSyntax? = nil,
    baseType: RawTypeSyntax,
    _ unexpectedBetweenBaseTypeAndPeriod: RawUnexpectedNodesSyntax? = nil,
    period: RawTokenSyntax,
    _ unexpectedBetweenPeriodAndName: RawUnexpectedNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ unexpectedBetweenNameAndGenericArgumentClause: RawUnexpectedNodesSyntax? = nil,
    genericArgumentClause: RawGenericArgumentClauseSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .memberTypeIdentifier, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeBaseType?.raw
      layout[1] = baseType.raw
      layout[2] = unexpectedBetweenBaseTypeAndPeriod?.raw
      layout[3] = period.raw
      layout[4] = unexpectedBetweenPeriodAndName?.raw
      layout[5] = name.raw
      layout[6] = unexpectedBetweenNameAndGenericArgumentClause?.raw
      layout[7] = genericArgumentClause?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeBaseType: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var baseType: RawTypeSyntax {
    layoutView.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenBaseTypeAndPeriod: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var period: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPeriodAndName: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndGenericArgumentClause: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericArgumentClause: RawGenericArgumentClauseSyntax? {
    layoutView.children[7].map(RawGenericArgumentClauseSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawClassRestrictionTypeSyntax: RawTypeSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ClassRestrictionTypeSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .classRestrictionType
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeClassKeyword: RawUnexpectedNodesSyntax? = nil,
    classKeyword: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .classRestrictionType, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeClassKeyword?.raw
      layout[1] = classKeyword.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeClassKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var classKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawArrayTypeSyntax: RawTypeSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ArrayTypeSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .arrayType
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftSquareBracket: RawUnexpectedNodesSyntax? = nil,
    leftSquareBracket: RawTokenSyntax,
    _ unexpectedBetweenLeftSquareBracketAndElementType: RawUnexpectedNodesSyntax? = nil,
    elementType: RawTypeSyntax,
    _ unexpectedBetweenElementTypeAndRightSquareBracket: RawUnexpectedNodesSyntax? = nil,
    rightSquareBracket: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .arrayType, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftSquareBracket?.raw
      layout[1] = leftSquareBracket.raw
      layout[2] = unexpectedBetweenLeftSquareBracketAndElementType?.raw
      layout[3] = elementType.raw
      layout[4] = unexpectedBetweenElementTypeAndRightSquareBracket?.raw
      layout[5] = rightSquareBracket.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftSquareBracket: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftSquareBracket: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftSquareBracketAndElementType: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var elementType: RawTypeSyntax {
    layoutView.children[3].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenElementTypeAndRightSquareBracket: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightSquareBracket: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawDictionaryTypeSyntax: RawTypeSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = DictionaryTypeSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .dictionaryType
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftSquareBracket: RawUnexpectedNodesSyntax? = nil,
    leftSquareBracket: RawTokenSyntax,
    _ unexpectedBetweenLeftSquareBracketAndKeyType: RawUnexpectedNodesSyntax? = nil,
    keyType: RawTypeSyntax,
    _ unexpectedBetweenKeyTypeAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ unexpectedBetweenColonAndValueType: RawUnexpectedNodesSyntax? = nil,
    valueType: RawTypeSyntax,
    _ unexpectedBetweenValueTypeAndRightSquareBracket: RawUnexpectedNodesSyntax? = nil,
    rightSquareBracket: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .dictionaryType, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftSquareBracket?.raw
      layout[1] = leftSquareBracket.raw
      layout[2] = unexpectedBetweenLeftSquareBracketAndKeyType?.raw
      layout[3] = keyType.raw
      layout[4] = unexpectedBetweenKeyTypeAndColon?.raw
      layout[5] = colon.raw
      layout[6] = unexpectedBetweenColonAndValueType?.raw
      layout[7] = valueType.raw
      layout[8] = unexpectedBetweenValueTypeAndRightSquareBracket?.raw
      layout[9] = rightSquareBracket.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftSquareBracket: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftSquareBracket: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftSquareBracketAndKeyType: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var keyType: RawTypeSyntax {
    layoutView.children[3].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenKeyTypeAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndValueType: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var valueType: RawTypeSyntax {
    layoutView.children[7].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenValueTypeAndRightSquareBracket: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightSquareBracket: RawTokenSyntax {
    layoutView.children[9].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawMetatypeTypeSyntax: RawTypeSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = MetatypeTypeSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .metatypeType
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeBaseType: RawUnexpectedNodesSyntax? = nil,
    baseType: RawTypeSyntax,
    _ unexpectedBetweenBaseTypeAndPeriod: RawUnexpectedNodesSyntax? = nil,
    period: RawTokenSyntax,
    _ unexpectedBetweenPeriodAndTypeOrProtocol: RawUnexpectedNodesSyntax? = nil,
    typeOrProtocol: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .metatypeType, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeBaseType?.raw
      layout[1] = baseType.raw
      layout[2] = unexpectedBetweenBaseTypeAndPeriod?.raw
      layout[3] = period.raw
      layout[4] = unexpectedBetweenPeriodAndTypeOrProtocol?.raw
      layout[5] = typeOrProtocol.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeBaseType: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var baseType: RawTypeSyntax {
    layoutView.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenBaseTypeAndPeriod: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var period: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPeriodAndTypeOrProtocol: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var typeOrProtocol: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawOptionalTypeSyntax: RawTypeSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = OptionalTypeSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .optionalType
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeWrappedType: RawUnexpectedNodesSyntax? = nil,
    wrappedType: RawTypeSyntax,
    _ unexpectedBetweenWrappedTypeAndQuestionMark: RawUnexpectedNodesSyntax? = nil,
    questionMark: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .optionalType, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeWrappedType?.raw
      layout[1] = wrappedType.raw
      layout[2] = unexpectedBetweenWrappedTypeAndQuestionMark?.raw
      layout[3] = questionMark.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeWrappedType: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var wrappedType: RawTypeSyntax {
    layoutView.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenWrappedTypeAndQuestionMark: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var questionMark: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawConstrainedSugarTypeSyntax: RawTypeSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ConstrainedSugarTypeSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .constrainedSugarType
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeSomeOrAnySpecifier: RawUnexpectedNodesSyntax? = nil,
    someOrAnySpecifier: RawTokenSyntax,
    _ unexpectedBetweenSomeOrAnySpecifierAndBaseType: RawUnexpectedNodesSyntax? = nil,
    baseType: RawTypeSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .constrainedSugarType, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeSomeOrAnySpecifier?.raw
      layout[1] = someOrAnySpecifier.raw
      layout[2] = unexpectedBetweenSomeOrAnySpecifierAndBaseType?.raw
      layout[3] = baseType.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeSomeOrAnySpecifier: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var someOrAnySpecifier: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenSomeOrAnySpecifierAndBaseType: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var baseType: RawTypeSyntax {
    layoutView.children[3].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawImplicitlyUnwrappedOptionalTypeSyntax: RawTypeSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ImplicitlyUnwrappedOptionalTypeSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .implicitlyUnwrappedOptionalType
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeWrappedType: RawUnexpectedNodesSyntax? = nil,
    wrappedType: RawTypeSyntax,
    _ unexpectedBetweenWrappedTypeAndExclamationMark: RawUnexpectedNodesSyntax? = nil,
    exclamationMark: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .implicitlyUnwrappedOptionalType, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeWrappedType?.raw
      layout[1] = wrappedType.raw
      layout[2] = unexpectedBetweenWrappedTypeAndExclamationMark?.raw
      layout[3] = exclamationMark.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeWrappedType: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var wrappedType: RawTypeSyntax {
    layoutView.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenWrappedTypeAndExclamationMark: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var exclamationMark: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawCompositionTypeElementSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = CompositionTypeElementSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .compositionTypeElement
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeType: RawUnexpectedNodesSyntax? = nil,
    type: RawTypeSyntax,
    _ unexpectedBetweenTypeAndAmpersand: RawUnexpectedNodesSyntax? = nil,
    ampersand: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .compositionTypeElement, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeType?.raw
      layout[1] = type.raw
      layout[2] = unexpectedBetweenTypeAndAmpersand?.raw
      layout[3] = ampersand?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeType: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var type: RawTypeSyntax {
    layoutView.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenTypeAndAmpersand: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var ampersand: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawCompositionTypeElementListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = CompositionTypeElementListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .compositionTypeElementList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawCompositionTypeElementSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .compositionTypeElementList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawCompositionTypeElementSyntax] {
    layoutView.children.map { RawCompositionTypeElementSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawCompositionTypeSyntax: RawTypeSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = CompositionTypeSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .compositionType
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeElements: RawUnexpectedNodesSyntax? = nil,
    elements: RawCompositionTypeElementListSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .compositionType, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeElements?.raw
      layout[1] = elements.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeElements: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var elements: RawCompositionTypeElementListSyntax {
    layoutView.children[1].map(RawCompositionTypeElementListSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPackExpansionTypeSyntax: RawTypeSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = PackExpansionTypeSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .packExpansionType
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforePatternType: RawUnexpectedNodesSyntax? = nil,
    patternType: RawTypeSyntax,
    _ unexpectedBetweenPatternTypeAndEllipsis: RawUnexpectedNodesSyntax? = nil,
    ellipsis: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .packExpansionType, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforePatternType?.raw
      layout[1] = patternType.raw
      layout[2] = unexpectedBetweenPatternTypeAndEllipsis?.raw
      layout[3] = ellipsis.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforePatternType: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var patternType: RawTypeSyntax {
    layoutView.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenPatternTypeAndEllipsis: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var ellipsis: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawTupleTypeElementSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = TupleTypeElementSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .tupleTypeElement
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeInOut: RawUnexpectedNodesSyntax? = nil,
    inOut: RawTokenSyntax?,
    _ unexpectedBetweenInOutAndName: RawUnexpectedNodesSyntax? = nil,
    name: RawTokenSyntax?,
    _ unexpectedBetweenNameAndSecondName: RawUnexpectedNodesSyntax? = nil,
    secondName: RawTokenSyntax?,
    _ unexpectedBetweenSecondNameAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax?,
    _ unexpectedBetweenColonAndType: RawUnexpectedNodesSyntax? = nil,
    type: RawTypeSyntax,
    _ unexpectedBetweenTypeAndEllipsis: RawUnexpectedNodesSyntax? = nil,
    ellipsis: RawTokenSyntax?,
    _ unexpectedBetweenEllipsisAndInitializer: RawUnexpectedNodesSyntax? = nil,
    initializer: RawInitializerClauseSyntax?,
    _ unexpectedBetweenInitializerAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .tupleTypeElement, uninitializedCount: 16, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeInOut?.raw
      layout[1] = inOut?.raw
      layout[2] = unexpectedBetweenInOutAndName?.raw
      layout[3] = name?.raw
      layout[4] = unexpectedBetweenNameAndSecondName?.raw
      layout[5] = secondName?.raw
      layout[6] = unexpectedBetweenSecondNameAndColon?.raw
      layout[7] = colon?.raw
      layout[8] = unexpectedBetweenColonAndType?.raw
      layout[9] = type.raw
      layout[10] = unexpectedBetweenTypeAndEllipsis?.raw
      layout[11] = ellipsis?.raw
      layout[12] = unexpectedBetweenEllipsisAndInitializer?.raw
      layout[13] = initializer?.raw
      layout[14] = unexpectedBetweenInitializerAndTrailingComma?.raw
      layout[15] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeInOut: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var inOut: RawTokenSyntax? {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenInOutAndName: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenNameAndSecondName: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var secondName: RawTokenSyntax? {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenSecondNameAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax? {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenColonAndType: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var type: RawTypeSyntax {
    layoutView.children[9].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenTypeAndEllipsis: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var ellipsis: RawTokenSyntax? {
    layoutView.children[11].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenEllipsisAndInitializer: RawUnexpectedNodesSyntax? {
    layoutView.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var initializer: RawInitializerClauseSyntax? {
    layoutView.children[13].map(RawInitializerClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenInitializerAndTrailingComma: RawUnexpectedNodesSyntax? {
    layoutView.children[14].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    layoutView.children[15].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawTupleTypeElementListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = TupleTypeElementListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .tupleTypeElementList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawTupleTypeElementSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .tupleTypeElementList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawTupleTypeElementSyntax] {
    layoutView.children.map { RawTupleTypeElementSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawTupleTypeSyntax: RawTypeSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = TupleTypeSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .tupleType
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ unexpectedBetweenLeftParenAndElements: RawUnexpectedNodesSyntax? = nil,
    elements: RawTupleTypeElementListSyntax,
    _ unexpectedBetweenElementsAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .tupleType, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftParen?.raw
      layout[1] = leftParen.raw
      layout[2] = unexpectedBetweenLeftParenAndElements?.raw
      layout[3] = elements.raw
      layout[4] = unexpectedBetweenElementsAndRightParen?.raw
      layout[5] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndElements: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var elements: RawTupleTypeElementListSyntax {
    layoutView.children[3].map(RawTupleTypeElementListSyntax.init(raw:))!
  }
  public var unexpectedBetweenElementsAndRightParen: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawFunctionTypeSyntax: RawTypeSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = FunctionTypeSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .functionType
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ unexpectedBetweenLeftParenAndArguments: RawUnexpectedNodesSyntax? = nil,
    arguments: RawTupleTypeElementListSyntax,
    _ unexpectedBetweenArgumentsAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    _ unexpectedBetweenRightParenAndAsyncKeyword: RawUnexpectedNodesSyntax? = nil,
    asyncKeyword: RawTokenSyntax?,
    _ unexpectedBetweenAsyncKeywordAndThrowsOrRethrowsKeyword: RawUnexpectedNodesSyntax? = nil,
    throwsOrRethrowsKeyword: RawTokenSyntax?,
    _ unexpectedBetweenThrowsOrRethrowsKeywordAndArrow: RawUnexpectedNodesSyntax? = nil,
    arrow: RawTokenSyntax,
    _ unexpectedBetweenArrowAndReturnType: RawUnexpectedNodesSyntax? = nil,
    returnType: RawTypeSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .functionType, uninitializedCount: 14, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftParen?.raw
      layout[1] = leftParen.raw
      layout[2] = unexpectedBetweenLeftParenAndArguments?.raw
      layout[3] = arguments.raw
      layout[4] = unexpectedBetweenArgumentsAndRightParen?.raw
      layout[5] = rightParen.raw
      layout[6] = unexpectedBetweenRightParenAndAsyncKeyword?.raw
      layout[7] = asyncKeyword?.raw
      layout[8] = unexpectedBetweenAsyncKeywordAndThrowsOrRethrowsKeyword?.raw
      layout[9] = throwsOrRethrowsKeyword?.raw
      layout[10] = unexpectedBetweenThrowsOrRethrowsKeywordAndArrow?.raw
      layout[11] = arrow.raw
      layout[12] = unexpectedBetweenArrowAndReturnType?.raw
      layout[13] = returnType.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndArguments: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var arguments: RawTupleTypeElementListSyntax {
    layoutView.children[3].map(RawTupleTypeElementListSyntax.init(raw:))!
  }
  public var unexpectedBetweenArgumentsAndRightParen: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenRightParenAndAsyncKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var asyncKeyword: RawTokenSyntax? {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenAsyncKeywordAndThrowsOrRethrowsKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var throwsOrRethrowsKeyword: RawTokenSyntax? {
    layoutView.children[9].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenThrowsOrRethrowsKeywordAndArrow: RawUnexpectedNodesSyntax? {
    layoutView.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var arrow: RawTokenSyntax {
    layoutView.children[11].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenArrowAndReturnType: RawUnexpectedNodesSyntax? {
    layoutView.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var returnType: RawTypeSyntax {
    layoutView.children[13].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawAttributedTypeSyntax: RawTypeSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = AttributedTypeSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .attributedType
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeSpecifier: RawUnexpectedNodesSyntax? = nil,
    specifier: RawTokenSyntax?,
    _ unexpectedBetweenSpecifierAndAttributes: RawUnexpectedNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ unexpectedBetweenAttributesAndBaseType: RawUnexpectedNodesSyntax? = nil,
    baseType: RawTypeSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .attributedType, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeSpecifier?.raw
      layout[1] = specifier?.raw
      layout[2] = unexpectedBetweenSpecifierAndAttributes?.raw
      layout[3] = attributes?.raw
      layout[4] = unexpectedBetweenAttributesAndBaseType?.raw
      layout[5] = baseType.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeSpecifier: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var specifier: RawTokenSyntax? {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenSpecifierAndAttributes: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    layoutView.children[3].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndBaseType: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var baseType: RawTypeSyntax {
    layoutView.children[5].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawGenericArgumentListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = GenericArgumentListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .genericArgumentList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawGenericArgumentSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .genericArgumentList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawGenericArgumentSyntax] {
    layoutView.children.map { RawGenericArgumentSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawGenericArgumentSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = GenericArgumentSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .genericArgument
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeArgumentType: RawUnexpectedNodesSyntax? = nil,
    argumentType: RawTypeSyntax,
    _ unexpectedBetweenArgumentTypeAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .genericArgument, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeArgumentType?.raw
      layout[1] = argumentType.raw
      layout[2] = unexpectedBetweenArgumentTypeAndTrailingComma?.raw
      layout[3] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeArgumentType: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var argumentType: RawTypeSyntax {
    layoutView.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenArgumentTypeAndTrailingComma: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawGenericArgumentClauseSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = GenericArgumentClauseSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .genericArgumentClause
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftAngleBracket: RawUnexpectedNodesSyntax? = nil,
    leftAngleBracket: RawTokenSyntax,
    _ unexpectedBetweenLeftAngleBracketAndArguments: RawUnexpectedNodesSyntax? = nil,
    arguments: RawGenericArgumentListSyntax,
    _ unexpectedBetweenArgumentsAndRightAngleBracket: RawUnexpectedNodesSyntax? = nil,
    rightAngleBracket: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .genericArgumentClause, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftAngleBracket?.raw
      layout[1] = leftAngleBracket.raw
      layout[2] = unexpectedBetweenLeftAngleBracketAndArguments?.raw
      layout[3] = arguments.raw
      layout[4] = unexpectedBetweenArgumentsAndRightAngleBracket?.raw
      layout[5] = rightAngleBracket.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftAngleBracket: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftAngleBracket: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftAngleBracketAndArguments: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var arguments: RawGenericArgumentListSyntax {
    layoutView.children[3].map(RawGenericArgumentListSyntax.init(raw:))!
  }
  public var unexpectedBetweenArgumentsAndRightAngleBracket: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightAngleBracket: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawNamedOpaqueReturnTypeSyntax: RawTypeSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = NamedOpaqueReturnTypeSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .namedOpaqueReturnType
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeGenericParameters: RawUnexpectedNodesSyntax? = nil,
    genericParameters: RawGenericParameterClauseSyntax,
    _ unexpectedBetweenGenericParametersAndBaseType: RawUnexpectedNodesSyntax? = nil,
    baseType: RawTypeSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .namedOpaqueReturnType, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeGenericParameters?.raw
      layout[1] = genericParameters.raw
      layout[2] = unexpectedBetweenGenericParametersAndBaseType?.raw
      layout[3] = baseType.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeGenericParameters: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericParameters: RawGenericParameterClauseSyntax {
    layoutView.children[1].map(RawGenericParameterClauseSyntax.init(raw:))!
  }
  public var unexpectedBetweenGenericParametersAndBaseType: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var baseType: RawTypeSyntax {
    layoutView.children[3].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawTypeAnnotationSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = TypeAnnotationSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .typeAnnotation
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ unexpectedBetweenColonAndType: RawUnexpectedNodesSyntax? = nil,
    type: RawTypeSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .typeAnnotation, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeColon?.raw
      layout[1] = colon.raw
      layout[2] = unexpectedBetweenColonAndType?.raw
      layout[3] = type.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeColon: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndType: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var type: RawTypeSyntax {
    layoutView.children[3].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawEnumCasePatternSyntax: RawPatternSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = EnumCasePatternSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .enumCasePattern
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeType: RawUnexpectedNodesSyntax? = nil,
    type: RawTypeSyntax?,
    _ unexpectedBetweenTypeAndPeriod: RawUnexpectedNodesSyntax? = nil,
    period: RawTokenSyntax,
    _ unexpectedBetweenPeriodAndCaseName: RawUnexpectedNodesSyntax? = nil,
    caseName: RawTokenSyntax,
    _ unexpectedBetweenCaseNameAndAssociatedTuple: RawUnexpectedNodesSyntax? = nil,
    associatedTuple: RawTuplePatternSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .enumCasePattern, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeType?.raw
      layout[1] = type?.raw
      layout[2] = unexpectedBetweenTypeAndPeriod?.raw
      layout[3] = period.raw
      layout[4] = unexpectedBetweenPeriodAndCaseName?.raw
      layout[5] = caseName.raw
      layout[6] = unexpectedBetweenCaseNameAndAssociatedTuple?.raw
      layout[7] = associatedTuple?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeType: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var type: RawTypeSyntax? {
    layoutView.children[1].map(RawTypeSyntax.init(raw:))
  }
  public var unexpectedBetweenTypeAndPeriod: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var period: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPeriodAndCaseName: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var caseName: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenCaseNameAndAssociatedTuple: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var associatedTuple: RawTuplePatternSyntax? {
    layoutView.children[7].map(RawTuplePatternSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawIsTypePatternSyntax: RawPatternSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = IsTypePatternSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .isTypePattern
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeIsKeyword: RawUnexpectedNodesSyntax? = nil,
    isKeyword: RawTokenSyntax,
    _ unexpectedBetweenIsKeywordAndType: RawUnexpectedNodesSyntax? = nil,
    type: RawTypeSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .isTypePattern, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeIsKeyword?.raw
      layout[1] = isKeyword.raw
      layout[2] = unexpectedBetweenIsKeywordAndType?.raw
      layout[3] = type.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeIsKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var isKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIsKeywordAndType: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var type: RawTypeSyntax {
    layoutView.children[3].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawOptionalPatternSyntax: RawPatternSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = OptionalPatternSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .optionalPattern
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeSubPattern: RawUnexpectedNodesSyntax? = nil,
    subPattern: RawPatternSyntax,
    _ unexpectedBetweenSubPatternAndQuestionMark: RawUnexpectedNodesSyntax? = nil,
    questionMark: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .optionalPattern, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeSubPattern?.raw
      layout[1] = subPattern.raw
      layout[2] = unexpectedBetweenSubPatternAndQuestionMark?.raw
      layout[3] = questionMark.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeSubPattern: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var subPattern: RawPatternSyntax {
    layoutView.children[1].map(RawPatternSyntax.init(raw:))!
  }
  public var unexpectedBetweenSubPatternAndQuestionMark: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var questionMark: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawIdentifierPatternSyntax: RawPatternSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = IdentifierPatternSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .identifierPattern
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .identifierPattern, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeIdentifier?.raw
      layout[1] = identifier.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawAsTypePatternSyntax: RawPatternSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = AsTypePatternSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .asTypePattern
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforePattern: RawUnexpectedNodesSyntax? = nil,
    pattern: RawPatternSyntax,
    _ unexpectedBetweenPatternAndAsKeyword: RawUnexpectedNodesSyntax? = nil,
    asKeyword: RawTokenSyntax,
    _ unexpectedBetweenAsKeywordAndType: RawUnexpectedNodesSyntax? = nil,
    type: RawTypeSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .asTypePattern, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforePattern?.raw
      layout[1] = pattern.raw
      layout[2] = unexpectedBetweenPatternAndAsKeyword?.raw
      layout[3] = asKeyword.raw
      layout[4] = unexpectedBetweenAsKeywordAndType?.raw
      layout[5] = type.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforePattern: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax {
    layoutView.children[1].map(RawPatternSyntax.init(raw:))!
  }
  public var unexpectedBetweenPatternAndAsKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var asKeyword: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenAsKeywordAndType: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var type: RawTypeSyntax {
    layoutView.children[5].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawTuplePatternSyntax: RawPatternSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = TuplePatternSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .tuplePattern
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ unexpectedBetweenLeftParenAndElements: RawUnexpectedNodesSyntax? = nil,
    elements: RawTuplePatternElementListSyntax,
    _ unexpectedBetweenElementsAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .tuplePattern, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftParen?.raw
      layout[1] = leftParen.raw
      layout[2] = unexpectedBetweenLeftParenAndElements?.raw
      layout[3] = elements.raw
      layout[4] = unexpectedBetweenElementsAndRightParen?.raw
      layout[5] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndElements: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var elements: RawTuplePatternElementListSyntax {
    layoutView.children[3].map(RawTuplePatternElementListSyntax.init(raw:))!
  }
  public var unexpectedBetweenElementsAndRightParen: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawWildcardPatternSyntax: RawPatternSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = WildcardPatternSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .wildcardPattern
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeWildcard: RawUnexpectedNodesSyntax? = nil,
    wildcard: RawTokenSyntax,
    _ unexpectedBetweenWildcardAndTypeAnnotation: RawUnexpectedNodesSyntax? = nil,
    typeAnnotation: RawTypeAnnotationSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .wildcardPattern, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeWildcard?.raw
      layout[1] = wildcard.raw
      layout[2] = unexpectedBetweenWildcardAndTypeAnnotation?.raw
      layout[3] = typeAnnotation?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeWildcard: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var wildcard: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenWildcardAndTypeAnnotation: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var typeAnnotation: RawTypeAnnotationSyntax? {
    layoutView.children[3].map(RawTypeAnnotationSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawTuplePatternElementSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = TuplePatternElementSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .tuplePatternElement
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLabelName: RawUnexpectedNodesSyntax? = nil,
    labelName: RawTokenSyntax?,
    _ unexpectedBetweenLabelNameAndLabelColon: RawUnexpectedNodesSyntax? = nil,
    labelColon: RawTokenSyntax?,
    _ unexpectedBetweenLabelColonAndPattern: RawUnexpectedNodesSyntax? = nil,
    pattern: RawPatternSyntax,
    _ unexpectedBetweenPatternAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .tuplePatternElement, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLabelName?.raw
      layout[1] = labelName?.raw
      layout[2] = unexpectedBetweenLabelNameAndLabelColon?.raw
      layout[3] = labelColon?.raw
      layout[4] = unexpectedBetweenLabelColonAndPattern?.raw
      layout[5] = pattern.raw
      layout[6] = unexpectedBetweenPatternAndTrailingComma?.raw
      layout[7] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLabelName: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var labelName: RawTokenSyntax? {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenLabelNameAndLabelColon: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var labelColon: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenLabelColonAndPattern: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax {
    layoutView.children[5].map(RawPatternSyntax.init(raw:))!
  }
  public var unexpectedBetweenPatternAndTrailingComma: RawUnexpectedNodesSyntax? {
    layoutView.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    layoutView.children[7].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawExpressionPatternSyntax: RawPatternSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ExpressionPatternSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .expressionPattern
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeExpression: RawUnexpectedNodesSyntax? = nil,
    expression: RawExprSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .expressionPattern, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeExpression?.raw
      layout[1] = expression.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeExpression: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    layoutView.children[1].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawTuplePatternElementListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = TuplePatternElementListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .tuplePatternElementList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawTuplePatternElementSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .tuplePatternElementList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawTuplePatternElementSyntax] {
    layoutView.children.map { RawTuplePatternElementSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawValueBindingPatternSyntax: RawPatternSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = ValueBindingPatternSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .valueBindingPattern
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLetOrVarKeyword: RawUnexpectedNodesSyntax? = nil,
    letOrVarKeyword: RawTokenSyntax,
    _ unexpectedBetweenLetOrVarKeywordAndValuePattern: RawUnexpectedNodesSyntax? = nil,
    valuePattern: RawPatternSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .valueBindingPattern, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLetOrVarKeyword?.raw
      layout[1] = letOrVarKeyword.raw
      layout[2] = unexpectedBetweenLetOrVarKeywordAndValuePattern?.raw
      layout[3] = valuePattern.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLetOrVarKeyword: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var letOrVarKeyword: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLetOrVarKeywordAndValuePattern: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var valuePattern: RawPatternSyntax {
    layoutView.children[3].map(RawPatternSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawAvailabilitySpecListSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = AvailabilitySpecListSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .availabilitySpecList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(elements: [RawAvailabilityArgumentSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .availabilitySpecList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }

  public var elements: [RawAvailabilityArgumentSyntax] {
    layoutView.children.map { RawAvailabilityArgumentSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawAvailabilityArgumentSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = AvailabilityArgumentSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .availabilityArgument
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeEntry: RawUnexpectedNodesSyntax? = nil,
    entry: RawSyntax,
    _ unexpectedBetweenEntryAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .availabilityArgument, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeEntry?.raw
      layout[1] = entry.raw
      layout[2] = unexpectedBetweenEntryAndTrailingComma?.raw
      layout[3] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeEntry: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var entry: RawSyntax {
    layoutView.children[1]!
  }
  public var unexpectedBetweenEntryAndTrailingComma: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawAvailabilityLabeledArgumentSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = AvailabilityLabeledArgumentSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .availabilityLabeledArgument
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeLabel: RawUnexpectedNodesSyntax? = nil,
    label: RawTokenSyntax,
    _ unexpectedBetweenLabelAndColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ unexpectedBetweenColonAndValue: RawUnexpectedNodesSyntax? = nil,
    value: RawSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .availabilityLabeledArgument, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLabel?.raw
      layout[1] = label.raw
      layout[2] = unexpectedBetweenLabelAndColon?.raw
      layout[3] = colon.raw
      layout[4] = unexpectedBetweenColonAndValue?.raw
      layout[5] = value.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLabel: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var label: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLabelAndColon: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndValue: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var value: RawSyntax {
    layoutView.children[5]!
  }
}

@_spi(RawSyntax)
public struct RawAvailabilityVersionRestrictionSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = AvailabilityVersionRestrictionSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .availabilityVersionRestriction
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforePlatform: RawUnexpectedNodesSyntax? = nil,
    platform: RawTokenSyntax,
    _ unexpectedBetweenPlatformAndVersion: RawUnexpectedNodesSyntax? = nil,
    version: RawVersionTupleSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .availabilityVersionRestriction, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforePlatform?.raw
      layout[1] = platform.raw
      layout[2] = unexpectedBetweenPlatformAndVersion?.raw
      layout[3] = version?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforePlatform: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var platform: RawTokenSyntax {
    layoutView.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPlatformAndVersion: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var version: RawVersionTupleSyntax? {
    layoutView.children[3].map(RawVersionTupleSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawVersionTupleSyntax: RawSyntaxNodeProtocol, RawSyntaxToSyntax {
  public typealias SyntaxType = VersionTupleSyntax

  var layoutView: RawSyntaxLayoutView {
    return raw.layoutView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .versionTuple
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init(
    _ unexpectedBeforeMajorMinor: RawUnexpectedNodesSyntax? = nil,
    majorMinor: RawSyntax,
    _ unexpectedBetweenMajorMinorAndPatchPeriod: RawUnexpectedNodesSyntax? = nil,
    patchPeriod: RawTokenSyntax?,
    _ unexpectedBetweenPatchPeriodAndPatchVersion: RawUnexpectedNodesSyntax? = nil,
    patchVersion: RawTokenSyntax?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .versionTuple, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeMajorMinor?.raw
      layout[1] = majorMinor.raw
      layout[2] = unexpectedBetweenMajorMinorAndPatchPeriod?.raw
      layout[3] = patchPeriod?.raw
      layout[4] = unexpectedBetweenPatchPeriodAndPatchVersion?.raw
      layout[5] = patchVersion?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeMajorMinor: RawUnexpectedNodesSyntax? {
    layoutView.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var majorMinor: RawSyntax {
    layoutView.children[1]!
  }
  public var unexpectedBetweenMajorMinorAndPatchPeriod: RawUnexpectedNodesSyntax? {
    layoutView.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var patchPeriod: RawTokenSyntax? {
    layoutView.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenPatchPeriodAndPatchVersion: RawUnexpectedNodesSyntax? {
    layoutView.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var patchVersion: RawTokenSyntax? {
    layoutView.children[5].map(RawTokenSyntax.init(raw:))
  }
}
