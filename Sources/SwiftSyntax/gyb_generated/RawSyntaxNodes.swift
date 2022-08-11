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
public struct RawDeclSyntax: RawDeclSyntaxNodeProtocol {
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
public struct RawExprSyntax: RawExprSyntaxNodeProtocol {
  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    switch raw.kind {
    case .unknownExpr, .missingExpr, .inOutExpr, .poundColumnExpr, .tryExpr, .awaitExpr, .moveExpr, .identifierExpr, .superRefExpr, .nilLiteralExpr, .discardAssignmentExpr, .assignmentExpr, .sequenceExpr, .poundLineExpr, .poundFileExpr, .poundFileIDExpr, .poundFilePathExpr, .poundFunctionExpr, .poundDsohandleExpr, .symbolicReferenceExpr, .prefixOperatorExpr, .binaryOperatorExpr, .arrowExpr, .infixOperatorExpr, .floatLiteralExpr, .tupleExpr, .arrayExpr, .dictionaryExpr, .integerLiteralExpr, .booleanLiteralExpr, .ternaryExpr, .memberAccessExpr, .isExpr, .asExpr, .typeExpr, .closureExpr, .unresolvedPatternExpr, .functionCallExpr, .subscriptExpr, .optionalChainingExpr, .forcedValueExpr, .postfixUnaryExpr, .specializeExpr, .stringLiteralExpr, .regexLiteralExpr, .keyPathExpr, .keyPathBaseExpr, .objcKeyPathExpr, .objcSelectorExpr, .postfixIfConfigExpr, .editorPlaceholderExpr, .objectLiteralExpr: return true
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
public struct RawStmtSyntax: RawStmtSyntaxNodeProtocol {
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
public struct RawTypeSyntax: RawTypeSyntaxNodeProtocol {
  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    switch raw.kind {
    case .unknownType, .missingType, .simpleTypeIdentifier, .memberTypeIdentifier, .classRestrictionType, .arrayType, .dictionaryType, .metatypeType, .optionalType, .constrainedSugarType, .implicitlyUnwrappedOptionalType, .compositionType, .tupleType, .functionType, .attributedType: return true
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
public struct RawPatternSyntax: RawPatternSyntaxNodeProtocol {
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
public struct RawUnknownDeclSyntax: RawDeclSyntaxNodeProtocol {
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
public struct RawUnknownExprSyntax: RawExprSyntaxNodeProtocol {
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
public struct RawUnknownStmtSyntax: RawStmtSyntaxNodeProtocol {
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
public struct RawUnknownTypeSyntax: RawTypeSyntaxNodeProtocol {
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
public struct RawUnknownPatternSyntax: RawPatternSyntaxNodeProtocol {
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
public struct RawMissingSyntax: RawSyntaxNodeProtocol {
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
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeEmptyLayout(kind: .missing, arena: arena)
    self.init(raw: raw)
  }

}

@_spi(RawSyntax)
public struct RawMissingDeclSyntax: RawDeclSyntaxNodeProtocol {
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
    _ garbageBeforeAttributes: RawGarbageNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .missingDecl, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = garbageBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAttributes: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawMissingExprSyntax: RawExprSyntaxNodeProtocol {
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
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeEmptyLayout(kind: .missingExpr, arena: arena)
    self.init(raw: raw)
  }

}

@_spi(RawSyntax)
public struct RawMissingStmtSyntax: RawStmtSyntaxNodeProtocol {
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
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeEmptyLayout(kind: .missingStmt, arena: arena)
    self.init(raw: raw)
  }

}

@_spi(RawSyntax)
public struct RawMissingTypeSyntax: RawTypeSyntaxNodeProtocol {
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
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeEmptyLayout(kind: .missingType, arena: arena)
    self.init(raw: raw)
  }

}

@_spi(RawSyntax)
public struct RawMissingPatternSyntax: RawPatternSyntaxNodeProtocol {
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
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeEmptyLayout(kind: .missingPattern, arena: arena)
    self.init(raw: raw)
  }

}

@_spi(RawSyntax)
public struct RawCodeBlockItemSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeItem: RawGarbageNodesSyntax? = nil,
    item: RawSyntax,
    _ garbageBetweenItemAndSemicolon: RawGarbageNodesSyntax? = nil,
    semicolon: RawTokenSyntax?,
    _ garbageBetweenSemicolonAndErrorTokens: RawGarbageNodesSyntax? = nil,
    errorTokens: RawSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .codeBlockItem, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeItem?.raw
      layout[1] = item.raw
      layout[2] = garbageBetweenItemAndSemicolon?.raw
      layout[3] = semicolon?.raw
      layout[4] = garbageBetweenSemicolonAndErrorTokens?.raw
      layout[5] = errorTokens?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeItem: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var item: RawSyntax {
    raw.children[1]!
  }
  public var garbageBetweenItemAndSemicolon: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var semicolon: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenSemicolonAndErrorTokens: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var errorTokens: RawSyntax? {
    raw.children[5]
  }
}

@_spi(RawSyntax)
public struct RawCodeBlockItemListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawCodeBlockItemSyntax {
    let raw = RawSyntax.makeLayout(kind: .codeBlockItemList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawCodeBlockItemSyntax] {
    raw.children.map { RawCodeBlockItemSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawCodeBlockSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeLeftBrace: RawGarbageNodesSyntax? = nil,
    leftBrace: RawTokenSyntax,
    _ garbageBetweenLeftBraceAndStatements: RawGarbageNodesSyntax? = nil,
    statements: RawCodeBlockItemListSyntax,
    _ garbageBetweenStatementsAndRightBrace: RawGarbageNodesSyntax? = nil,
    rightBrace: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .codeBlock, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLeftBrace?.raw
      layout[1] = leftBrace.raw
      layout[2] = garbageBetweenLeftBraceAndStatements?.raw
      layout[3] = statements.raw
      layout[4] = garbageBetweenStatementsAndRightBrace?.raw
      layout[5] = rightBrace.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLeftBrace: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftBrace: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftBraceAndStatements: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var statements: RawCodeBlockItemListSyntax {
    raw.children[3].map(RawCodeBlockItemListSyntax.init(raw:))!
  }
  public var garbageBetweenStatementsAndRightBrace: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightBrace: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawGarbageNodesSyntax: RawSyntaxNodeProtocol {
  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .garbageNodes
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawSyntax {
    let raw = RawSyntax.makeLayout(kind: .garbageNodes, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawSyntax] {
    raw.children.map { RawSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawInOutExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeAmpersand: RawGarbageNodesSyntax? = nil,
    ampersand: RawTokenSyntax,
    _ garbageBetweenAmpersandAndExpression: RawGarbageNodesSyntax? = nil,
    expression: RawExprSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .inOutExpr, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAmpersand?.raw
      layout[1] = ampersand.raw
      layout[2] = garbageBetweenAmpersandAndExpression?.raw
      layout[3] = expression.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAmpersand: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var ampersand: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenAmpersandAndExpression: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    raw.children[3].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPoundColumnExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforePoundColumn: RawGarbageNodesSyntax? = nil,
    poundColumn: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .poundColumnExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforePoundColumn?.raw
      layout[1] = poundColumn.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforePoundColumn: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var poundColumn: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawTupleExprElementListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawTupleExprElementSyntax {
    let raw = RawSyntax.makeLayout(kind: .tupleExprElementList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawTupleExprElementSyntax] {
    raw.children.map { RawTupleExprElementSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawArrayElementListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawArrayElementSyntax {
    let raw = RawSyntax.makeLayout(kind: .arrayElementList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawArrayElementSyntax] {
    raw.children.map { RawArrayElementSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawDictionaryElementListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawDictionaryElementSyntax {
    let raw = RawSyntax.makeLayout(kind: .dictionaryElementList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawDictionaryElementSyntax] {
    raw.children.map { RawDictionaryElementSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawStringLiteralSegmentsSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawSyntax {
    let raw = RawSyntax.makeLayout(kind: .stringLiteralSegments, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawSyntax] {
    raw.children.map { RawSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawTryExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeTryKeyword: RawGarbageNodesSyntax? = nil,
    tryKeyword: RawTokenSyntax,
    _ garbageBetweenTryKeywordAndQuestionOrExclamationMark: RawGarbageNodesSyntax? = nil,
    questionOrExclamationMark: RawTokenSyntax?,
    _ garbageBetweenQuestionOrExclamationMarkAndExpression: RawGarbageNodesSyntax? = nil,
    expression: RawExprSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .tryExpr, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeTryKeyword?.raw
      layout[1] = tryKeyword.raw
      layout[2] = garbageBetweenTryKeywordAndQuestionOrExclamationMark?.raw
      layout[3] = questionOrExclamationMark?.raw
      layout[4] = garbageBetweenQuestionOrExclamationMarkAndExpression?.raw
      layout[5] = expression.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeTryKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var tryKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenTryKeywordAndQuestionOrExclamationMark: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var questionOrExclamationMark: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenQuestionOrExclamationMarkAndExpression: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    raw.children[5].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawAwaitExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeAwaitKeyword: RawGarbageNodesSyntax? = nil,
    awaitKeyword: RawTokenSyntax,
    _ garbageBetweenAwaitKeywordAndExpression: RawGarbageNodesSyntax? = nil,
    expression: RawExprSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .awaitExpr, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAwaitKeyword?.raw
      layout[1] = awaitKeyword.raw
      layout[2] = garbageBetweenAwaitKeywordAndExpression?.raw
      layout[3] = expression.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAwaitKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var awaitKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenAwaitKeywordAndExpression: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    raw.children[3].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawMoveExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeMoveKeyword: RawGarbageNodesSyntax? = nil,
    moveKeyword: RawTokenSyntax,
    _ garbageBetweenMoveKeywordAndExpression: RawGarbageNodesSyntax? = nil,
    expression: RawExprSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .moveExpr, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeMoveKeyword?.raw
      layout[1] = moveKeyword.raw
      layout[2] = garbageBetweenMoveKeywordAndExpression?.raw
      layout[3] = expression.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeMoveKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var moveKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenMoveKeywordAndExpression: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    raw.children[3].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawDeclNameArgumentSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeName: RawGarbageNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ garbageBetweenNameAndColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .declNameArgument, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeName?.raw
      layout[1] = name.raw
      layout[2] = garbageBetweenNameAndColon?.raw
      layout[3] = colon.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeName: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenNameAndColon: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawDeclNameArgumentListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawDeclNameArgumentSyntax {
    let raw = RawSyntax.makeLayout(kind: .declNameArgumentList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawDeclNameArgumentSyntax] {
    raw.children.map { RawDeclNameArgumentSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawDeclNameArgumentsSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeLeftParen: RawGarbageNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ garbageBetweenLeftParenAndArguments: RawGarbageNodesSyntax? = nil,
    arguments: RawDeclNameArgumentListSyntax,
    _ garbageBetweenArgumentsAndRightParen: RawGarbageNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .declNameArguments, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLeftParen?.raw
      layout[1] = leftParen.raw
      layout[2] = garbageBetweenLeftParenAndArguments?.raw
      layout[3] = arguments.raw
      layout[4] = garbageBetweenArgumentsAndRightParen?.raw
      layout[5] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLeftParen: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftParenAndArguments: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var arguments: RawDeclNameArgumentListSyntax {
    raw.children[3].map(RawDeclNameArgumentListSyntax.init(raw:))!
  }
  public var garbageBetweenArgumentsAndRightParen: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawIdentifierExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeIdentifier: RawGarbageNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ garbageBetweenIdentifierAndDeclNameArguments: RawGarbageNodesSyntax? = nil,
    declNameArguments: RawDeclNameArgumentsSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .identifierExpr, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeIdentifier?.raw
      layout[1] = identifier.raw
      layout[2] = garbageBetweenIdentifierAndDeclNameArguments?.raw
      layout[3] = declNameArguments?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeIdentifier: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenIdentifierAndDeclNameArguments: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var declNameArguments: RawDeclNameArgumentsSyntax? {
    raw.children[3].map(RawDeclNameArgumentsSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawSuperRefExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeSuperKeyword: RawGarbageNodesSyntax? = nil,
    superKeyword: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .superRefExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeSuperKeyword?.raw
      layout[1] = superKeyword.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeSuperKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var superKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawNilLiteralExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeNilKeyword: RawGarbageNodesSyntax? = nil,
    nilKeyword: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .nilLiteralExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeNilKeyword?.raw
      layout[1] = nilKeyword.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeNilKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var nilKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawDiscardAssignmentExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeWildcard: RawGarbageNodesSyntax? = nil,
    wildcard: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .discardAssignmentExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeWildcard?.raw
      layout[1] = wildcard.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeWildcard: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var wildcard: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawAssignmentExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeAssignToken: RawGarbageNodesSyntax? = nil,
    assignToken: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .assignmentExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAssignToken?.raw
      layout[1] = assignToken.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAssignToken: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var assignToken: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawSequenceExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeElements: RawGarbageNodesSyntax? = nil,
    elements: RawExprListSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .sequenceExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeElements?.raw
      layout[1] = elements.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeElements: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var elements: RawExprListSyntax {
    raw.children[1].map(RawExprListSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawExprListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawExprSyntax {
    let raw = RawSyntax.makeLayout(kind: .exprList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawExprSyntax] {
    raw.children.map { RawExprSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawPoundLineExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforePoundLine: RawGarbageNodesSyntax? = nil,
    poundLine: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .poundLineExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforePoundLine?.raw
      layout[1] = poundLine.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforePoundLine: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var poundLine: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPoundFileExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforePoundFile: RawGarbageNodesSyntax? = nil,
    poundFile: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .poundFileExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforePoundFile?.raw
      layout[1] = poundFile.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforePoundFile: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var poundFile: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPoundFileIDExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforePoundFileID: RawGarbageNodesSyntax? = nil,
    poundFileID: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .poundFileIDExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforePoundFileID?.raw
      layout[1] = poundFileID.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforePoundFileID: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var poundFileID: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPoundFilePathExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforePoundFilePath: RawGarbageNodesSyntax? = nil,
    poundFilePath: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .poundFilePathExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforePoundFilePath?.raw
      layout[1] = poundFilePath.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforePoundFilePath: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var poundFilePath: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPoundFunctionExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforePoundFunction: RawGarbageNodesSyntax? = nil,
    poundFunction: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .poundFunctionExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforePoundFunction?.raw
      layout[1] = poundFunction.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforePoundFunction: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var poundFunction: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPoundDsohandleExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforePoundDsohandle: RawGarbageNodesSyntax? = nil,
    poundDsohandle: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .poundDsohandleExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforePoundDsohandle?.raw
      layout[1] = poundDsohandle.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforePoundDsohandle: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var poundDsohandle: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawSymbolicReferenceExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeIdentifier: RawGarbageNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ garbageBetweenIdentifierAndGenericArgumentClause: RawGarbageNodesSyntax? = nil,
    genericArgumentClause: RawGenericArgumentClauseSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .symbolicReferenceExpr, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeIdentifier?.raw
      layout[1] = identifier.raw
      layout[2] = garbageBetweenIdentifierAndGenericArgumentClause?.raw
      layout[3] = genericArgumentClause?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeIdentifier: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenIdentifierAndGenericArgumentClause: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var genericArgumentClause: RawGenericArgumentClauseSyntax? {
    raw.children[3].map(RawGenericArgumentClauseSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawPrefixOperatorExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeOperatorToken: RawGarbageNodesSyntax? = nil,
    operatorToken: RawTokenSyntax?,
    _ garbageBetweenOperatorTokenAndPostfixExpression: RawGarbageNodesSyntax? = nil,
    postfixExpression: RawExprSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .prefixOperatorExpr, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeOperatorToken?.raw
      layout[1] = operatorToken?.raw
      layout[2] = garbageBetweenOperatorTokenAndPostfixExpression?.raw
      layout[3] = postfixExpression.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeOperatorToken: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var operatorToken: RawTokenSyntax? {
    raw.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenOperatorTokenAndPostfixExpression: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var postfixExpression: RawExprSyntax {
    raw.children[3].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawBinaryOperatorExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeOperatorToken: RawGarbageNodesSyntax? = nil,
    operatorToken: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .binaryOperatorExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeOperatorToken?.raw
      layout[1] = operatorToken.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeOperatorToken: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var operatorToken: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawArrowExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeAsyncKeyword: RawGarbageNodesSyntax? = nil,
    asyncKeyword: RawTokenSyntax?,
    _ garbageBetweenAsyncKeywordAndThrowsToken: RawGarbageNodesSyntax? = nil,
    throwsToken: RawTokenSyntax?,
    _ garbageBetweenThrowsTokenAndArrowToken: RawGarbageNodesSyntax? = nil,
    arrowToken: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .arrowExpr, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAsyncKeyword?.raw
      layout[1] = asyncKeyword?.raw
      layout[2] = garbageBetweenAsyncKeywordAndThrowsToken?.raw
      layout[3] = throwsToken?.raw
      layout[4] = garbageBetweenThrowsTokenAndArrowToken?.raw
      layout[5] = arrowToken.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAsyncKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var asyncKeyword: RawTokenSyntax? {
    raw.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenAsyncKeywordAndThrowsToken: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var throwsToken: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenThrowsTokenAndArrowToken: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var arrowToken: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawInfixOperatorExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeLeftOperand: RawGarbageNodesSyntax? = nil,
    leftOperand: RawExprSyntax,
    _ garbageBetweenLeftOperandAndOperatorOperand: RawGarbageNodesSyntax? = nil,
    operatorOperand: RawExprSyntax,
    _ garbageBetweenOperatorOperandAndRightOperand: RawGarbageNodesSyntax? = nil,
    rightOperand: RawExprSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .infixOperatorExpr, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLeftOperand?.raw
      layout[1] = leftOperand.raw
      layout[2] = garbageBetweenLeftOperandAndOperatorOperand?.raw
      layout[3] = operatorOperand.raw
      layout[4] = garbageBetweenOperatorOperandAndRightOperand?.raw
      layout[5] = rightOperand.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLeftOperand: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftOperand: RawExprSyntax {
    raw.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var garbageBetweenLeftOperandAndOperatorOperand: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var operatorOperand: RawExprSyntax {
    raw.children[3].map(RawExprSyntax.init(raw:))!
  }
  public var garbageBetweenOperatorOperandAndRightOperand: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightOperand: RawExprSyntax {
    raw.children[5].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawFloatLiteralExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeFloatingDigits: RawGarbageNodesSyntax? = nil,
    floatingDigits: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .floatLiteralExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeFloatingDigits?.raw
      layout[1] = floatingDigits.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeFloatingDigits: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var floatingDigits: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawTupleExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeLeftParen: RawGarbageNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ garbageBetweenLeftParenAndElementList: RawGarbageNodesSyntax? = nil,
    elementList: RawTupleExprElementListSyntax,
    _ garbageBetweenElementListAndRightParen: RawGarbageNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .tupleExpr, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLeftParen?.raw
      layout[1] = leftParen.raw
      layout[2] = garbageBetweenLeftParenAndElementList?.raw
      layout[3] = elementList.raw
      layout[4] = garbageBetweenElementListAndRightParen?.raw
      layout[5] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLeftParen: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftParenAndElementList: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var elementList: RawTupleExprElementListSyntax {
    raw.children[3].map(RawTupleExprElementListSyntax.init(raw:))!
  }
  public var garbageBetweenElementListAndRightParen: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawArrayExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeLeftSquare: RawGarbageNodesSyntax? = nil,
    leftSquare: RawTokenSyntax,
    _ garbageBetweenLeftSquareAndElements: RawGarbageNodesSyntax? = nil,
    elements: RawArrayElementListSyntax,
    _ garbageBetweenElementsAndRightSquare: RawGarbageNodesSyntax? = nil,
    rightSquare: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .arrayExpr, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLeftSquare?.raw
      layout[1] = leftSquare.raw
      layout[2] = garbageBetweenLeftSquareAndElements?.raw
      layout[3] = elements.raw
      layout[4] = garbageBetweenElementsAndRightSquare?.raw
      layout[5] = rightSquare.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLeftSquare: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftSquare: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftSquareAndElements: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var elements: RawArrayElementListSyntax {
    raw.children[3].map(RawArrayElementListSyntax.init(raw:))!
  }
  public var garbageBetweenElementsAndRightSquare: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightSquare: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawDictionaryExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeLeftSquare: RawGarbageNodesSyntax? = nil,
    leftSquare: RawTokenSyntax,
    _ garbageBetweenLeftSquareAndContent: RawGarbageNodesSyntax? = nil,
    content: RawSyntax,
    _ garbageBetweenContentAndRightSquare: RawGarbageNodesSyntax? = nil,
    rightSquare: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .dictionaryExpr, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLeftSquare?.raw
      layout[1] = leftSquare.raw
      layout[2] = garbageBetweenLeftSquareAndContent?.raw
      layout[3] = content.raw
      layout[4] = garbageBetweenContentAndRightSquare?.raw
      layout[5] = rightSquare.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLeftSquare: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftSquare: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftSquareAndContent: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var content: RawSyntax {
    raw.children[3]!
  }
  public var garbageBetweenContentAndRightSquare: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightSquare: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawTupleExprElementSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeLabel: RawGarbageNodesSyntax? = nil,
    label: RawTokenSyntax?,
    _ garbageBetweenLabelAndColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax?,
    _ garbageBetweenColonAndExpression: RawGarbageNodesSyntax? = nil,
    expression: RawExprSyntax,
    _ garbageBetweenExpressionAndTrailingComma: RawGarbageNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .tupleExprElement, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLabel?.raw
      layout[1] = label?.raw
      layout[2] = garbageBetweenLabelAndColon?.raw
      layout[3] = colon?.raw
      layout[4] = garbageBetweenColonAndExpression?.raw
      layout[5] = expression.raw
      layout[6] = garbageBetweenExpressionAndTrailingComma?.raw
      layout[7] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLabel: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var label: RawTokenSyntax? {
    raw.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenLabelAndColon: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenColonAndExpression: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    raw.children[5].map(RawExprSyntax.init(raw:))!
  }
  public var garbageBetweenExpressionAndTrailingComma: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawArrayElementSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeExpression: RawGarbageNodesSyntax? = nil,
    expression: RawExprSyntax,
    _ garbageBetweenExpressionAndTrailingComma: RawGarbageNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .arrayElement, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeExpression?.raw
      layout[1] = expression.raw
      layout[2] = garbageBetweenExpressionAndTrailingComma?.raw
      layout[3] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeExpression: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    raw.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var garbageBetweenExpressionAndTrailingComma: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawDictionaryElementSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeKeyExpression: RawGarbageNodesSyntax? = nil,
    keyExpression: RawExprSyntax,
    _ garbageBetweenKeyExpressionAndColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ garbageBetweenColonAndValueExpression: RawGarbageNodesSyntax? = nil,
    valueExpression: RawExprSyntax,
    _ garbageBetweenValueExpressionAndTrailingComma: RawGarbageNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .dictionaryElement, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeKeyExpression?.raw
      layout[1] = keyExpression.raw
      layout[2] = garbageBetweenKeyExpressionAndColon?.raw
      layout[3] = colon.raw
      layout[4] = garbageBetweenColonAndValueExpression?.raw
      layout[5] = valueExpression.raw
      layout[6] = garbageBetweenValueExpressionAndTrailingComma?.raw
      layout[7] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeKeyExpression: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var keyExpression: RawExprSyntax {
    raw.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var garbageBetweenKeyExpressionAndColon: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenColonAndValueExpression: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var valueExpression: RawExprSyntax {
    raw.children[5].map(RawExprSyntax.init(raw:))!
  }
  public var garbageBetweenValueExpressionAndTrailingComma: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawIntegerLiteralExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeDigits: RawGarbageNodesSyntax? = nil,
    digits: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .integerLiteralExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeDigits?.raw
      layout[1] = digits.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeDigits: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var digits: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawBooleanLiteralExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeBooleanLiteral: RawGarbageNodesSyntax? = nil,
    booleanLiteral: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .booleanLiteralExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeBooleanLiteral?.raw
      layout[1] = booleanLiteral.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeBooleanLiteral: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var booleanLiteral: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawTernaryExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeConditionExpression: RawGarbageNodesSyntax? = nil,
    conditionExpression: RawExprSyntax,
    _ garbageBetweenConditionExpressionAndQuestionMark: RawGarbageNodesSyntax? = nil,
    questionMark: RawTokenSyntax,
    _ garbageBetweenQuestionMarkAndFirstChoice: RawGarbageNodesSyntax? = nil,
    firstChoice: RawExprSyntax,
    _ garbageBetweenFirstChoiceAndColonMark: RawGarbageNodesSyntax? = nil,
    colonMark: RawTokenSyntax,
    _ garbageBetweenColonMarkAndSecondChoice: RawGarbageNodesSyntax? = nil,
    secondChoice: RawExprSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .ternaryExpr, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeConditionExpression?.raw
      layout[1] = conditionExpression.raw
      layout[2] = garbageBetweenConditionExpressionAndQuestionMark?.raw
      layout[3] = questionMark.raw
      layout[4] = garbageBetweenQuestionMarkAndFirstChoice?.raw
      layout[5] = firstChoice.raw
      layout[6] = garbageBetweenFirstChoiceAndColonMark?.raw
      layout[7] = colonMark.raw
      layout[8] = garbageBetweenColonMarkAndSecondChoice?.raw
      layout[9] = secondChoice.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeConditionExpression: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var conditionExpression: RawExprSyntax {
    raw.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var garbageBetweenConditionExpressionAndQuestionMark: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var questionMark: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenQuestionMarkAndFirstChoice: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var firstChoice: RawExprSyntax {
    raw.children[5].map(RawExprSyntax.init(raw:))!
  }
  public var garbageBetweenFirstChoiceAndColonMark: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colonMark: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenColonMarkAndSecondChoice: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var secondChoice: RawExprSyntax {
    raw.children[9].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawMemberAccessExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeBase: RawGarbageNodesSyntax? = nil,
    base: RawExprSyntax?,
    _ garbageBetweenBaseAndDot: RawGarbageNodesSyntax? = nil,
    dot: RawTokenSyntax,
    _ garbageBetweenDotAndName: RawGarbageNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ garbageBetweenNameAndDeclNameArguments: RawGarbageNodesSyntax? = nil,
    declNameArguments: RawDeclNameArgumentsSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .memberAccessExpr, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeBase?.raw
      layout[1] = base?.raw
      layout[2] = garbageBetweenBaseAndDot?.raw
      layout[3] = dot.raw
      layout[4] = garbageBetweenDotAndName?.raw
      layout[5] = name.raw
      layout[6] = garbageBetweenNameAndDeclNameArguments?.raw
      layout[7] = declNameArguments?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeBase: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var base: RawExprSyntax? {
    raw.children[1].map(RawExprSyntax.init(raw:))
  }
  public var garbageBetweenBaseAndDot: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var dot: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenDotAndName: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenNameAndDeclNameArguments: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var declNameArguments: RawDeclNameArgumentsSyntax? {
    raw.children[7].map(RawDeclNameArgumentsSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawIsExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeIsTok: RawGarbageNodesSyntax? = nil,
    isTok: RawTokenSyntax,
    _ garbageBetweenIsTokAndTypeName: RawGarbageNodesSyntax? = nil,
    typeName: RawTypeSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .isExpr, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeIsTok?.raw
      layout[1] = isTok.raw
      layout[2] = garbageBetweenIsTokAndTypeName?.raw
      layout[3] = typeName.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeIsTok: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var isTok: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenIsTokAndTypeName: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var typeName: RawTypeSyntax {
    raw.children[3].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawAsExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeAsTok: RawGarbageNodesSyntax? = nil,
    asTok: RawTokenSyntax,
    _ garbageBetweenAsTokAndQuestionOrExclamationMark: RawGarbageNodesSyntax? = nil,
    questionOrExclamationMark: RawTokenSyntax?,
    _ garbageBetweenQuestionOrExclamationMarkAndTypeName: RawGarbageNodesSyntax? = nil,
    typeName: RawTypeSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .asExpr, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAsTok?.raw
      layout[1] = asTok.raw
      layout[2] = garbageBetweenAsTokAndQuestionOrExclamationMark?.raw
      layout[3] = questionOrExclamationMark?.raw
      layout[4] = garbageBetweenQuestionOrExclamationMarkAndTypeName?.raw
      layout[5] = typeName.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAsTok: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var asTok: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenAsTokAndQuestionOrExclamationMark: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var questionOrExclamationMark: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenQuestionOrExclamationMarkAndTypeName: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var typeName: RawTypeSyntax {
    raw.children[5].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawTypeExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeType: RawGarbageNodesSyntax? = nil,
    type: RawTypeSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .typeExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeType?.raw
      layout[1] = type.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeType: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var type: RawTypeSyntax {
    raw.children[1].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawClosureCaptureItemSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeSpecifier: RawGarbageNodesSyntax? = nil,
    specifier: RawTokenListSyntax?,
    _ garbageBetweenSpecifierAndName: RawGarbageNodesSyntax? = nil,
    name: RawTokenSyntax?,
    _ garbageBetweenNameAndAssignToken: RawGarbageNodesSyntax? = nil,
    assignToken: RawTokenSyntax?,
    _ garbageBetweenAssignTokenAndExpression: RawGarbageNodesSyntax? = nil,
    expression: RawExprSyntax,
    _ garbageBetweenExpressionAndTrailingComma: RawGarbageNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .closureCaptureItem, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeSpecifier?.raw
      layout[1] = specifier?.raw
      layout[2] = garbageBetweenSpecifierAndName?.raw
      layout[3] = name?.raw
      layout[4] = garbageBetweenNameAndAssignToken?.raw
      layout[5] = assignToken?.raw
      layout[6] = garbageBetweenAssignTokenAndExpression?.raw
      layout[7] = expression.raw
      layout[8] = garbageBetweenExpressionAndTrailingComma?.raw
      layout[9] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeSpecifier: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var specifier: RawTokenListSyntax? {
    raw.children[1].map(RawTokenListSyntax.init(raw:))
  }
  public var garbageBetweenSpecifierAndName: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenNameAndAssignToken: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var assignToken: RawTokenSyntax? {
    raw.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenAssignTokenAndExpression: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    raw.children[7].map(RawExprSyntax.init(raw:))!
  }
  public var garbageBetweenExpressionAndTrailingComma: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[9].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawClosureCaptureItemListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawClosureCaptureItemSyntax {
    let raw = RawSyntax.makeLayout(kind: .closureCaptureItemList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawClosureCaptureItemSyntax] {
    raw.children.map { RawClosureCaptureItemSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawClosureCaptureSignatureSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeLeftSquare: RawGarbageNodesSyntax? = nil,
    leftSquare: RawTokenSyntax,
    _ garbageBetweenLeftSquareAndItems: RawGarbageNodesSyntax? = nil,
    items: RawClosureCaptureItemListSyntax?,
    _ garbageBetweenItemsAndRightSquare: RawGarbageNodesSyntax? = nil,
    rightSquare: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .closureCaptureSignature, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLeftSquare?.raw
      layout[1] = leftSquare.raw
      layout[2] = garbageBetweenLeftSquareAndItems?.raw
      layout[3] = items?.raw
      layout[4] = garbageBetweenItemsAndRightSquare?.raw
      layout[5] = rightSquare.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLeftSquare: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftSquare: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftSquareAndItems: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var items: RawClosureCaptureItemListSyntax? {
    raw.children[3].map(RawClosureCaptureItemListSyntax.init(raw:))
  }
  public var garbageBetweenItemsAndRightSquare: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightSquare: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawClosureParamSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeName: RawGarbageNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ garbageBetweenNameAndTrailingComma: RawGarbageNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .closureParam, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeName?.raw
      layout[1] = name.raw
      layout[2] = garbageBetweenNameAndTrailingComma?.raw
      layout[3] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeName: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenNameAndTrailingComma: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawClosureParamListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawClosureParamSyntax {
    let raw = RawSyntax.makeLayout(kind: .closureParamList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawClosureParamSyntax] {
    raw.children.map { RawClosureParamSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawClosureSignatureSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeAttributes: RawGarbageNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ garbageBetweenAttributesAndCapture: RawGarbageNodesSyntax? = nil,
    capture: RawClosureCaptureSignatureSyntax?,
    _ garbageBetweenCaptureAndInput: RawGarbageNodesSyntax? = nil,
    input: RawSyntax?,
    _ garbageBetweenInputAndAsyncKeyword: RawGarbageNodesSyntax? = nil,
    asyncKeyword: RawTokenSyntax?,
    _ garbageBetweenAsyncKeywordAndThrowsTok: RawGarbageNodesSyntax? = nil,
    throwsTok: RawTokenSyntax?,
    _ garbageBetweenThrowsTokAndOutput: RawGarbageNodesSyntax? = nil,
    output: RawReturnClauseSyntax?,
    _ garbageBetweenOutputAndInTok: RawGarbageNodesSyntax? = nil,
    inTok: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .closureSignature, uninitializedCount: 14, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = garbageBetweenAttributesAndCapture?.raw
      layout[3] = capture?.raw
      layout[4] = garbageBetweenCaptureAndInput?.raw
      layout[5] = input?.raw
      layout[6] = garbageBetweenInputAndAsyncKeyword?.raw
      layout[7] = asyncKeyword?.raw
      layout[8] = garbageBetweenAsyncKeywordAndThrowsTok?.raw
      layout[9] = throwsTok?.raw
      layout[10] = garbageBetweenThrowsTokAndOutput?.raw
      layout[11] = output?.raw
      layout[12] = garbageBetweenOutputAndInTok?.raw
      layout[13] = inTok.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAttributes: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var garbageBetweenAttributesAndCapture: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var capture: RawClosureCaptureSignatureSyntax? {
    raw.children[3].map(RawClosureCaptureSignatureSyntax.init(raw:))
  }
  public var garbageBetweenCaptureAndInput: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var input: RawSyntax? {
    raw.children[5]
  }
  public var garbageBetweenInputAndAsyncKeyword: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var asyncKeyword: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenAsyncKeywordAndThrowsTok: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var throwsTok: RawTokenSyntax? {
    raw.children[9].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenThrowsTokAndOutput: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var output: RawReturnClauseSyntax? {
    raw.children[11].map(RawReturnClauseSyntax.init(raw:))
  }
  public var garbageBetweenOutputAndInTok: RawGarbageNodesSyntax? {
    raw.children[12].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var inTok: RawTokenSyntax {
    raw.children[13].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawClosureExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeLeftBrace: RawGarbageNodesSyntax? = nil,
    leftBrace: RawTokenSyntax,
    _ garbageBetweenLeftBraceAndSignature: RawGarbageNodesSyntax? = nil,
    signature: RawClosureSignatureSyntax?,
    _ garbageBetweenSignatureAndStatements: RawGarbageNodesSyntax? = nil,
    statements: RawCodeBlockItemListSyntax,
    _ garbageBetweenStatementsAndRightBrace: RawGarbageNodesSyntax? = nil,
    rightBrace: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .closureExpr, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLeftBrace?.raw
      layout[1] = leftBrace.raw
      layout[2] = garbageBetweenLeftBraceAndSignature?.raw
      layout[3] = signature?.raw
      layout[4] = garbageBetweenSignatureAndStatements?.raw
      layout[5] = statements.raw
      layout[6] = garbageBetweenStatementsAndRightBrace?.raw
      layout[7] = rightBrace.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLeftBrace: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftBrace: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftBraceAndSignature: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var signature: RawClosureSignatureSyntax? {
    raw.children[3].map(RawClosureSignatureSyntax.init(raw:))
  }
  public var garbageBetweenSignatureAndStatements: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var statements: RawCodeBlockItemListSyntax {
    raw.children[5].map(RawCodeBlockItemListSyntax.init(raw:))!
  }
  public var garbageBetweenStatementsAndRightBrace: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightBrace: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawUnresolvedPatternExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforePattern: RawGarbageNodesSyntax? = nil,
    pattern: RawPatternSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .unresolvedPatternExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforePattern?.raw
      layout[1] = pattern.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforePattern: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax {
    raw.children[1].map(RawPatternSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawMultipleTrailingClosureElementSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeLabel: RawGarbageNodesSyntax? = nil,
    label: RawTokenSyntax,
    _ garbageBetweenLabelAndColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ garbageBetweenColonAndClosure: RawGarbageNodesSyntax? = nil,
    closure: RawClosureExprSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .multipleTrailingClosureElement, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLabel?.raw
      layout[1] = label.raw
      layout[2] = garbageBetweenLabelAndColon?.raw
      layout[3] = colon.raw
      layout[4] = garbageBetweenColonAndClosure?.raw
      layout[5] = closure.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLabel: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var label: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLabelAndColon: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenColonAndClosure: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var closure: RawClosureExprSyntax {
    raw.children[5].map(RawClosureExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawMultipleTrailingClosureElementListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawMultipleTrailingClosureElementSyntax {
    let raw = RawSyntax.makeLayout(kind: .multipleTrailingClosureElementList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawMultipleTrailingClosureElementSyntax] {
    raw.children.map { RawMultipleTrailingClosureElementSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawFunctionCallExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeCalledExpression: RawGarbageNodesSyntax? = nil,
    calledExpression: RawExprSyntax,
    _ garbageBetweenCalledExpressionAndLeftParen: RawGarbageNodesSyntax? = nil,
    leftParen: RawTokenSyntax?,
    _ garbageBetweenLeftParenAndArgumentList: RawGarbageNodesSyntax? = nil,
    argumentList: RawTupleExprElementListSyntax,
    _ garbageBetweenArgumentListAndRightParen: RawGarbageNodesSyntax? = nil,
    rightParen: RawTokenSyntax?,
    _ garbageBetweenRightParenAndTrailingClosure: RawGarbageNodesSyntax? = nil,
    trailingClosure: RawClosureExprSyntax?,
    _ garbageBetweenTrailingClosureAndAdditionalTrailingClosures: RawGarbageNodesSyntax? = nil,
    additionalTrailingClosures: RawMultipleTrailingClosureElementListSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .functionCallExpr, uninitializedCount: 12, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeCalledExpression?.raw
      layout[1] = calledExpression.raw
      layout[2] = garbageBetweenCalledExpressionAndLeftParen?.raw
      layout[3] = leftParen?.raw
      layout[4] = garbageBetweenLeftParenAndArgumentList?.raw
      layout[5] = argumentList.raw
      layout[6] = garbageBetweenArgumentListAndRightParen?.raw
      layout[7] = rightParen?.raw
      layout[8] = garbageBetweenRightParenAndTrailingClosure?.raw
      layout[9] = trailingClosure?.raw
      layout[10] = garbageBetweenTrailingClosureAndAdditionalTrailingClosures?.raw
      layout[11] = additionalTrailingClosures?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeCalledExpression: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var calledExpression: RawExprSyntax {
    raw.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var garbageBetweenCalledExpressionAndLeftParen: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenLeftParenAndArgumentList: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var argumentList: RawTupleExprElementListSyntax {
    raw.children[5].map(RawTupleExprElementListSyntax.init(raw:))!
  }
  public var garbageBetweenArgumentListAndRightParen: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenRightParenAndTrailingClosure: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingClosure: RawClosureExprSyntax? {
    raw.children[9].map(RawClosureExprSyntax.init(raw:))
  }
  public var garbageBetweenTrailingClosureAndAdditionalTrailingClosures: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var additionalTrailingClosures: RawMultipleTrailingClosureElementListSyntax? {
    raw.children[11].map(RawMultipleTrailingClosureElementListSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawSubscriptExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeCalledExpression: RawGarbageNodesSyntax? = nil,
    calledExpression: RawExprSyntax,
    _ garbageBetweenCalledExpressionAndLeftBracket: RawGarbageNodesSyntax? = nil,
    leftBracket: RawTokenSyntax,
    _ garbageBetweenLeftBracketAndArgumentList: RawGarbageNodesSyntax? = nil,
    argumentList: RawTupleExprElementListSyntax,
    _ garbageBetweenArgumentListAndRightBracket: RawGarbageNodesSyntax? = nil,
    rightBracket: RawTokenSyntax,
    _ garbageBetweenRightBracketAndTrailingClosure: RawGarbageNodesSyntax? = nil,
    trailingClosure: RawClosureExprSyntax?,
    _ garbageBetweenTrailingClosureAndAdditionalTrailingClosures: RawGarbageNodesSyntax? = nil,
    additionalTrailingClosures: RawMultipleTrailingClosureElementListSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .subscriptExpr, uninitializedCount: 12, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeCalledExpression?.raw
      layout[1] = calledExpression.raw
      layout[2] = garbageBetweenCalledExpressionAndLeftBracket?.raw
      layout[3] = leftBracket.raw
      layout[4] = garbageBetweenLeftBracketAndArgumentList?.raw
      layout[5] = argumentList.raw
      layout[6] = garbageBetweenArgumentListAndRightBracket?.raw
      layout[7] = rightBracket.raw
      layout[8] = garbageBetweenRightBracketAndTrailingClosure?.raw
      layout[9] = trailingClosure?.raw
      layout[10] = garbageBetweenTrailingClosureAndAdditionalTrailingClosures?.raw
      layout[11] = additionalTrailingClosures?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeCalledExpression: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var calledExpression: RawExprSyntax {
    raw.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var garbageBetweenCalledExpressionAndLeftBracket: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftBracket: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftBracketAndArgumentList: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var argumentList: RawTupleExprElementListSyntax {
    raw.children[5].map(RawTupleExprElementListSyntax.init(raw:))!
  }
  public var garbageBetweenArgumentListAndRightBracket: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightBracket: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenRightBracketAndTrailingClosure: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingClosure: RawClosureExprSyntax? {
    raw.children[9].map(RawClosureExprSyntax.init(raw:))
  }
  public var garbageBetweenTrailingClosureAndAdditionalTrailingClosures: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var additionalTrailingClosures: RawMultipleTrailingClosureElementListSyntax? {
    raw.children[11].map(RawMultipleTrailingClosureElementListSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawOptionalChainingExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeExpression: RawGarbageNodesSyntax? = nil,
    expression: RawExprSyntax,
    _ garbageBetweenExpressionAndQuestionMark: RawGarbageNodesSyntax? = nil,
    questionMark: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .optionalChainingExpr, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeExpression?.raw
      layout[1] = expression.raw
      layout[2] = garbageBetweenExpressionAndQuestionMark?.raw
      layout[3] = questionMark.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeExpression: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    raw.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var garbageBetweenExpressionAndQuestionMark: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var questionMark: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawForcedValueExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeExpression: RawGarbageNodesSyntax? = nil,
    expression: RawExprSyntax,
    _ garbageBetweenExpressionAndExclamationMark: RawGarbageNodesSyntax? = nil,
    exclamationMark: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .forcedValueExpr, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeExpression?.raw
      layout[1] = expression.raw
      layout[2] = garbageBetweenExpressionAndExclamationMark?.raw
      layout[3] = exclamationMark.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeExpression: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    raw.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var garbageBetweenExpressionAndExclamationMark: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var exclamationMark: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPostfixUnaryExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeExpression: RawGarbageNodesSyntax? = nil,
    expression: RawExprSyntax,
    _ garbageBetweenExpressionAndOperatorToken: RawGarbageNodesSyntax? = nil,
    operatorToken: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .postfixUnaryExpr, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeExpression?.raw
      layout[1] = expression.raw
      layout[2] = garbageBetweenExpressionAndOperatorToken?.raw
      layout[3] = operatorToken.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeExpression: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    raw.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var garbageBetweenExpressionAndOperatorToken: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var operatorToken: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawSpecializeExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeExpression: RawGarbageNodesSyntax? = nil,
    expression: RawExprSyntax,
    _ garbageBetweenExpressionAndGenericArgumentClause: RawGarbageNodesSyntax? = nil,
    genericArgumentClause: RawGenericArgumentClauseSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .specializeExpr, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeExpression?.raw
      layout[1] = expression.raw
      layout[2] = garbageBetweenExpressionAndGenericArgumentClause?.raw
      layout[3] = genericArgumentClause.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeExpression: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    raw.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var garbageBetweenExpressionAndGenericArgumentClause: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var genericArgumentClause: RawGenericArgumentClauseSyntax {
    raw.children[3].map(RawGenericArgumentClauseSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawStringSegmentSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeContent: RawGarbageNodesSyntax? = nil,
    content: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .stringSegment, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeContent?.raw
      layout[1] = content.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeContent: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var content: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawExpressionSegmentSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeBackslash: RawGarbageNodesSyntax? = nil,
    backslash: RawTokenSyntax,
    _ garbageBetweenBackslashAndDelimiter: RawGarbageNodesSyntax? = nil,
    delimiter: RawTokenSyntax?,
    _ garbageBetweenDelimiterAndLeftParen: RawGarbageNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ garbageBetweenLeftParenAndExpressions: RawGarbageNodesSyntax? = nil,
    expressions: RawTupleExprElementListSyntax,
    _ garbageBetweenExpressionsAndRightParen: RawGarbageNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .expressionSegment, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeBackslash?.raw
      layout[1] = backslash.raw
      layout[2] = garbageBetweenBackslashAndDelimiter?.raw
      layout[3] = delimiter?.raw
      layout[4] = garbageBetweenDelimiterAndLeftParen?.raw
      layout[5] = leftParen.raw
      layout[6] = garbageBetweenLeftParenAndExpressions?.raw
      layout[7] = expressions.raw
      layout[8] = garbageBetweenExpressionsAndRightParen?.raw
      layout[9] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeBackslash: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var backslash: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenBackslashAndDelimiter: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var delimiter: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenDelimiterAndLeftParen: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftParenAndExpressions: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var expressions: RawTupleExprElementListSyntax {
    raw.children[7].map(RawTupleExprElementListSyntax.init(raw:))!
  }
  public var garbageBetweenExpressionsAndRightParen: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    raw.children[9].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawStringLiteralExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeOpenDelimiter: RawGarbageNodesSyntax? = nil,
    openDelimiter: RawTokenSyntax?,
    _ garbageBetweenOpenDelimiterAndOpenQuote: RawGarbageNodesSyntax? = nil,
    openQuote: RawTokenSyntax,
    _ garbageBetweenOpenQuoteAndSegments: RawGarbageNodesSyntax? = nil,
    segments: RawStringLiteralSegmentsSyntax,
    _ garbageBetweenSegmentsAndCloseQuote: RawGarbageNodesSyntax? = nil,
    closeQuote: RawTokenSyntax,
    _ garbageBetweenCloseQuoteAndCloseDelimiter: RawGarbageNodesSyntax? = nil,
    closeDelimiter: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .stringLiteralExpr, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeOpenDelimiter?.raw
      layout[1] = openDelimiter?.raw
      layout[2] = garbageBetweenOpenDelimiterAndOpenQuote?.raw
      layout[3] = openQuote.raw
      layout[4] = garbageBetweenOpenQuoteAndSegments?.raw
      layout[5] = segments.raw
      layout[6] = garbageBetweenSegmentsAndCloseQuote?.raw
      layout[7] = closeQuote.raw
      layout[8] = garbageBetweenCloseQuoteAndCloseDelimiter?.raw
      layout[9] = closeDelimiter?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeOpenDelimiter: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var openDelimiter: RawTokenSyntax? {
    raw.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenOpenDelimiterAndOpenQuote: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var openQuote: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenOpenQuoteAndSegments: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var segments: RawStringLiteralSegmentsSyntax {
    raw.children[5].map(RawStringLiteralSegmentsSyntax.init(raw:))!
  }
  public var garbageBetweenSegmentsAndCloseQuote: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var closeQuote: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenCloseQuoteAndCloseDelimiter: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var closeDelimiter: RawTokenSyntax? {
    raw.children[9].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawRegexLiteralExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeRegex: RawGarbageNodesSyntax? = nil,
    regex: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .regexLiteralExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeRegex?.raw
      layout[1] = regex.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeRegex: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var regex: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawKeyPathExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeBackslash: RawGarbageNodesSyntax? = nil,
    backslash: RawTokenSyntax,
    _ garbageBetweenBackslashAndRootExpr: RawGarbageNodesSyntax? = nil,
    rootExpr: RawExprSyntax?,
    _ garbageBetweenRootExprAndExpression: RawGarbageNodesSyntax? = nil,
    expression: RawExprSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .keyPathExpr, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeBackslash?.raw
      layout[1] = backslash.raw
      layout[2] = garbageBetweenBackslashAndRootExpr?.raw
      layout[3] = rootExpr?.raw
      layout[4] = garbageBetweenRootExprAndExpression?.raw
      layout[5] = expression.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeBackslash: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var backslash: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenBackslashAndRootExpr: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rootExpr: RawExprSyntax? {
    raw.children[3].map(RawExprSyntax.init(raw:))
  }
  public var garbageBetweenRootExprAndExpression: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    raw.children[5].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawKeyPathBaseExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforePeriod: RawGarbageNodesSyntax? = nil,
    period: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .keyPathBaseExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforePeriod?.raw
      layout[1] = period.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforePeriod: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var period: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawObjcNamePieceSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeName: RawGarbageNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ garbageBetweenNameAndDot: RawGarbageNodesSyntax? = nil,
    dot: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .objcNamePiece, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeName?.raw
      layout[1] = name.raw
      layout[2] = garbageBetweenNameAndDot?.raw
      layout[3] = dot?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeName: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenNameAndDot: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var dot: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawObjcNameSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawObjcNamePieceSyntax {
    let raw = RawSyntax.makeLayout(kind: .objcName, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawObjcNamePieceSyntax] {
    raw.children.map { RawObjcNamePieceSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawObjcKeyPathExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeKeyPath: RawGarbageNodesSyntax? = nil,
    keyPath: RawTokenSyntax,
    _ garbageBetweenKeyPathAndLeftParen: RawGarbageNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ garbageBetweenLeftParenAndName: RawGarbageNodesSyntax? = nil,
    name: RawObjcNameSyntax,
    _ garbageBetweenNameAndRightParen: RawGarbageNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .objcKeyPathExpr, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeKeyPath?.raw
      layout[1] = keyPath.raw
      layout[2] = garbageBetweenKeyPathAndLeftParen?.raw
      layout[3] = leftParen.raw
      layout[4] = garbageBetweenLeftParenAndName?.raw
      layout[5] = name.raw
      layout[6] = garbageBetweenNameAndRightParen?.raw
      layout[7] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeKeyPath: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var keyPath: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenKeyPathAndLeftParen: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftParenAndName: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var name: RawObjcNameSyntax {
    raw.children[5].map(RawObjcNameSyntax.init(raw:))!
  }
  public var garbageBetweenNameAndRightParen: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawObjcSelectorExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforePoundSelector: RawGarbageNodesSyntax? = nil,
    poundSelector: RawTokenSyntax,
    _ garbageBetweenPoundSelectorAndLeftParen: RawGarbageNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ garbageBetweenLeftParenAndKind: RawGarbageNodesSyntax? = nil,
    kind: RawTokenSyntax?,
    _ garbageBetweenKindAndColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax?,
    _ garbageBetweenColonAndName: RawGarbageNodesSyntax? = nil,
    name: RawExprSyntax,
    _ garbageBetweenNameAndRightParen: RawGarbageNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .objcSelectorExpr, uninitializedCount: 12, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforePoundSelector?.raw
      layout[1] = poundSelector.raw
      layout[2] = garbageBetweenPoundSelectorAndLeftParen?.raw
      layout[3] = leftParen.raw
      layout[4] = garbageBetweenLeftParenAndKind?.raw
      layout[5] = kind?.raw
      layout[6] = garbageBetweenKindAndColon?.raw
      layout[7] = colon?.raw
      layout[8] = garbageBetweenColonAndName?.raw
      layout[9] = name.raw
      layout[10] = garbageBetweenNameAndRightParen?.raw
      layout[11] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforePoundSelector: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var poundSelector: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenPoundSelectorAndLeftParen: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftParenAndKind: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var kind: RawTokenSyntax? {
    raw.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenKindAndColon: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenColonAndName: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var name: RawExprSyntax {
    raw.children[9].map(RawExprSyntax.init(raw:))!
  }
  public var garbageBetweenNameAndRightParen: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    raw.children[11].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPostfixIfConfigExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeBase: RawGarbageNodesSyntax? = nil,
    base: RawExprSyntax?,
    _ garbageBetweenBaseAndConfig: RawGarbageNodesSyntax? = nil,
    config: RawIfConfigDeclSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .postfixIfConfigExpr, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeBase?.raw
      layout[1] = base?.raw
      layout[2] = garbageBetweenBaseAndConfig?.raw
      layout[3] = config.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeBase: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var base: RawExprSyntax? {
    raw.children[1].map(RawExprSyntax.init(raw:))
  }
  public var garbageBetweenBaseAndConfig: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var config: RawIfConfigDeclSyntax {
    raw.children[3].map(RawIfConfigDeclSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawEditorPlaceholderExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeIdentifier: RawGarbageNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .editorPlaceholderExpr, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeIdentifier?.raw
      layout[1] = identifier.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeIdentifier: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawObjectLiteralExprSyntax: RawExprSyntaxNodeProtocol {
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
    _ garbageBeforeIdentifier: RawGarbageNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ garbageBetweenIdentifierAndLeftParen: RawGarbageNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ garbageBetweenLeftParenAndArguments: RawGarbageNodesSyntax? = nil,
    arguments: RawTupleExprElementListSyntax,
    _ garbageBetweenArgumentsAndRightParen: RawGarbageNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .objectLiteralExpr, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeIdentifier?.raw
      layout[1] = identifier.raw
      layout[2] = garbageBetweenIdentifierAndLeftParen?.raw
      layout[3] = leftParen.raw
      layout[4] = garbageBetweenLeftParenAndArguments?.raw
      layout[5] = arguments.raw
      layout[6] = garbageBetweenArgumentsAndRightParen?.raw
      layout[7] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeIdentifier: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenIdentifierAndLeftParen: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftParenAndArguments: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var arguments: RawTupleExprElementListSyntax {
    raw.children[5].map(RawTupleExprElementListSyntax.init(raw:))!
  }
  public var garbageBetweenArgumentsAndRightParen: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawTypeInitializerClauseSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeEqual: RawGarbageNodesSyntax? = nil,
    equal: RawTokenSyntax,
    _ garbageBetweenEqualAndValue: RawGarbageNodesSyntax? = nil,
    value: RawTypeSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .typeInitializerClause, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeEqual?.raw
      layout[1] = equal.raw
      layout[2] = garbageBetweenEqualAndValue?.raw
      layout[3] = value.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeEqual: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var equal: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenEqualAndValue: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var value: RawTypeSyntax {
    raw.children[3].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawTypealiasDeclSyntax: RawDeclSyntaxNodeProtocol {
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
    _ garbageBeforeAttributes: RawGarbageNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ garbageBetweenModifiersAndTypealiasKeyword: RawGarbageNodesSyntax? = nil,
    typealiasKeyword: RawTokenSyntax,
    _ garbageBetweenTypealiasKeywordAndIdentifier: RawGarbageNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ garbageBetweenIdentifierAndGenericParameterClause: RawGarbageNodesSyntax? = nil,
    genericParameterClause: RawGenericParameterClauseSyntax?,
    _ garbageBetweenGenericParameterClauseAndInitializer: RawGarbageNodesSyntax? = nil,
    initializer: RawTypeInitializerClauseSyntax,
    _ garbageBetweenInitializerAndGenericWhereClause: RawGarbageNodesSyntax? = nil,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .typealiasDecl, uninitializedCount: 14, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = garbageBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = garbageBetweenModifiersAndTypealiasKeyword?.raw
      layout[5] = typealiasKeyword.raw
      layout[6] = garbageBetweenTypealiasKeywordAndIdentifier?.raw
      layout[7] = identifier.raw
      layout[8] = garbageBetweenIdentifierAndGenericParameterClause?.raw
      layout[9] = genericParameterClause?.raw
      layout[10] = garbageBetweenGenericParameterClauseAndInitializer?.raw
      layout[11] = initializer.raw
      layout[12] = garbageBetweenInitializerAndGenericWhereClause?.raw
      layout[13] = genericWhereClause?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAttributes: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var garbageBetweenModifiersAndTypealiasKeyword: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var typealiasKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenTypealiasKeywordAndIdentifier: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenIdentifierAndGenericParameterClause: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    raw.children[9].map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var garbageBetweenGenericParameterClauseAndInitializer: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var initializer: RawTypeInitializerClauseSyntax {
    raw.children[11].map(RawTypeInitializerClauseSyntax.init(raw:))!
  }
  public var garbageBetweenInitializerAndGenericWhereClause: RawGarbageNodesSyntax? {
    raw.children[12].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    raw.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawAssociatedtypeDeclSyntax: RawDeclSyntaxNodeProtocol {
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
    _ garbageBeforeAttributes: RawGarbageNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ garbageBetweenModifiersAndAssociatedtypeKeyword: RawGarbageNodesSyntax? = nil,
    associatedtypeKeyword: RawTokenSyntax,
    _ garbageBetweenAssociatedtypeKeywordAndIdentifier: RawGarbageNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ garbageBetweenIdentifierAndInheritanceClause: RawGarbageNodesSyntax? = nil,
    inheritanceClause: RawTypeInheritanceClauseSyntax?,
    _ garbageBetweenInheritanceClauseAndInitializer: RawGarbageNodesSyntax? = nil,
    initializer: RawTypeInitializerClauseSyntax?,
    _ garbageBetweenInitializerAndGenericWhereClause: RawGarbageNodesSyntax? = nil,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .associatedtypeDecl, uninitializedCount: 14, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = garbageBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = garbageBetweenModifiersAndAssociatedtypeKeyword?.raw
      layout[5] = associatedtypeKeyword.raw
      layout[6] = garbageBetweenAssociatedtypeKeywordAndIdentifier?.raw
      layout[7] = identifier.raw
      layout[8] = garbageBetweenIdentifierAndInheritanceClause?.raw
      layout[9] = inheritanceClause?.raw
      layout[10] = garbageBetweenInheritanceClauseAndInitializer?.raw
      layout[11] = initializer?.raw
      layout[12] = garbageBetweenInitializerAndGenericWhereClause?.raw
      layout[13] = genericWhereClause?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAttributes: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var garbageBetweenModifiersAndAssociatedtypeKeyword: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var associatedtypeKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenAssociatedtypeKeywordAndIdentifier: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenIdentifierAndInheritanceClause: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    raw.children[9].map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var garbageBetweenInheritanceClauseAndInitializer: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var initializer: RawTypeInitializerClauseSyntax? {
    raw.children[11].map(RawTypeInitializerClauseSyntax.init(raw:))
  }
  public var garbageBetweenInitializerAndGenericWhereClause: RawGarbageNodesSyntax? {
    raw.children[12].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    raw.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawFunctionParameterListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawFunctionParameterSyntax {
    let raw = RawSyntax.makeLayout(kind: .functionParameterList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawFunctionParameterSyntax] {
    raw.children.map { RawFunctionParameterSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawParameterClauseSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeLeftParen: RawGarbageNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ garbageBetweenLeftParenAndParameterList: RawGarbageNodesSyntax? = nil,
    parameterList: RawFunctionParameterListSyntax,
    _ garbageBetweenParameterListAndRightParen: RawGarbageNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .parameterClause, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLeftParen?.raw
      layout[1] = leftParen.raw
      layout[2] = garbageBetweenLeftParenAndParameterList?.raw
      layout[3] = parameterList.raw
      layout[4] = garbageBetweenParameterListAndRightParen?.raw
      layout[5] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLeftParen: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftParenAndParameterList: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var parameterList: RawFunctionParameterListSyntax {
    raw.children[3].map(RawFunctionParameterListSyntax.init(raw:))!
  }
  public var garbageBetweenParameterListAndRightParen: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawReturnClauseSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeArrow: RawGarbageNodesSyntax? = nil,
    arrow: RawTokenSyntax,
    _ garbageBetweenArrowAndReturnType: RawGarbageNodesSyntax? = nil,
    returnType: RawTypeSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .returnClause, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeArrow?.raw
      layout[1] = arrow.raw
      layout[2] = garbageBetweenArrowAndReturnType?.raw
      layout[3] = returnType.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeArrow: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var arrow: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenArrowAndReturnType: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var returnType: RawTypeSyntax {
    raw.children[3].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawFunctionSignatureSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeInput: RawGarbageNodesSyntax? = nil,
    input: RawParameterClauseSyntax,
    _ garbageBetweenInputAndAsyncOrReasyncKeyword: RawGarbageNodesSyntax? = nil,
    asyncOrReasyncKeyword: RawTokenSyntax?,
    _ garbageBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword: RawGarbageNodesSyntax? = nil,
    throwsOrRethrowsKeyword: RawTokenSyntax?,
    _ garbageBetweenThrowsOrRethrowsKeywordAndOutput: RawGarbageNodesSyntax? = nil,
    output: RawReturnClauseSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .functionSignature, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeInput?.raw
      layout[1] = input.raw
      layout[2] = garbageBetweenInputAndAsyncOrReasyncKeyword?.raw
      layout[3] = asyncOrReasyncKeyword?.raw
      layout[4] = garbageBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword?.raw
      layout[5] = throwsOrRethrowsKeyword?.raw
      layout[6] = garbageBetweenThrowsOrRethrowsKeywordAndOutput?.raw
      layout[7] = output?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeInput: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var input: RawParameterClauseSyntax {
    raw.children[1].map(RawParameterClauseSyntax.init(raw:))!
  }
  public var garbageBetweenInputAndAsyncOrReasyncKeyword: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var asyncOrReasyncKeyword: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var throwsOrRethrowsKeyword: RawTokenSyntax? {
    raw.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenThrowsOrRethrowsKeywordAndOutput: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var output: RawReturnClauseSyntax? {
    raw.children[7].map(RawReturnClauseSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawIfConfigClauseSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforePoundKeyword: RawGarbageNodesSyntax? = nil,
    poundKeyword: RawTokenSyntax,
    _ garbageBetweenPoundKeywordAndCondition: RawGarbageNodesSyntax? = nil,
    condition: RawExprSyntax?,
    _ garbageBetweenConditionAndElements: RawGarbageNodesSyntax? = nil,
    elements: RawSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .ifConfigClause, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforePoundKeyword?.raw
      layout[1] = poundKeyword.raw
      layout[2] = garbageBetweenPoundKeywordAndCondition?.raw
      layout[3] = condition?.raw
      layout[4] = garbageBetweenConditionAndElements?.raw
      layout[5] = elements.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforePoundKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var poundKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenPoundKeywordAndCondition: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var condition: RawExprSyntax? {
    raw.children[3].map(RawExprSyntax.init(raw:))
  }
  public var garbageBetweenConditionAndElements: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var elements: RawSyntax {
    raw.children[5]!
  }
}

@_spi(RawSyntax)
public struct RawIfConfigClauseListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawIfConfigClauseSyntax {
    let raw = RawSyntax.makeLayout(kind: .ifConfigClauseList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawIfConfigClauseSyntax] {
    raw.children.map { RawIfConfigClauseSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawIfConfigDeclSyntax: RawDeclSyntaxNodeProtocol {
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
    _ garbageBeforeClauses: RawGarbageNodesSyntax? = nil,
    clauses: RawIfConfigClauseListSyntax,
    _ garbageBetweenClausesAndPoundEndif: RawGarbageNodesSyntax? = nil,
    poundEndif: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .ifConfigDecl, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeClauses?.raw
      layout[1] = clauses.raw
      layout[2] = garbageBetweenClausesAndPoundEndif?.raw
      layout[3] = poundEndif.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeClauses: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var clauses: RawIfConfigClauseListSyntax {
    raw.children[1].map(RawIfConfigClauseListSyntax.init(raw:))!
  }
  public var garbageBetweenClausesAndPoundEndif: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var poundEndif: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPoundErrorDeclSyntax: RawDeclSyntaxNodeProtocol {
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
    _ garbageBeforePoundError: RawGarbageNodesSyntax? = nil,
    poundError: RawTokenSyntax,
    _ garbageBetweenPoundErrorAndLeftParen: RawGarbageNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ garbageBetweenLeftParenAndMessage: RawGarbageNodesSyntax? = nil,
    message: RawStringLiteralExprSyntax,
    _ garbageBetweenMessageAndRightParen: RawGarbageNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .poundErrorDecl, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforePoundError?.raw
      layout[1] = poundError.raw
      layout[2] = garbageBetweenPoundErrorAndLeftParen?.raw
      layout[3] = leftParen.raw
      layout[4] = garbageBetweenLeftParenAndMessage?.raw
      layout[5] = message.raw
      layout[6] = garbageBetweenMessageAndRightParen?.raw
      layout[7] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforePoundError: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var poundError: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenPoundErrorAndLeftParen: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftParenAndMessage: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var message: RawStringLiteralExprSyntax {
    raw.children[5].map(RawStringLiteralExprSyntax.init(raw:))!
  }
  public var garbageBetweenMessageAndRightParen: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPoundWarningDeclSyntax: RawDeclSyntaxNodeProtocol {
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
    _ garbageBeforePoundWarning: RawGarbageNodesSyntax? = nil,
    poundWarning: RawTokenSyntax,
    _ garbageBetweenPoundWarningAndLeftParen: RawGarbageNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ garbageBetweenLeftParenAndMessage: RawGarbageNodesSyntax? = nil,
    message: RawStringLiteralExprSyntax,
    _ garbageBetweenMessageAndRightParen: RawGarbageNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .poundWarningDecl, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforePoundWarning?.raw
      layout[1] = poundWarning.raw
      layout[2] = garbageBetweenPoundWarningAndLeftParen?.raw
      layout[3] = leftParen.raw
      layout[4] = garbageBetweenLeftParenAndMessage?.raw
      layout[5] = message.raw
      layout[6] = garbageBetweenMessageAndRightParen?.raw
      layout[7] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforePoundWarning: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var poundWarning: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenPoundWarningAndLeftParen: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftParenAndMessage: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var message: RawStringLiteralExprSyntax {
    raw.children[5].map(RawStringLiteralExprSyntax.init(raw:))!
  }
  public var garbageBetweenMessageAndRightParen: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPoundSourceLocationSyntax: RawDeclSyntaxNodeProtocol {
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
    _ garbageBeforePoundSourceLocation: RawGarbageNodesSyntax? = nil,
    poundSourceLocation: RawTokenSyntax,
    _ garbageBetweenPoundSourceLocationAndLeftParen: RawGarbageNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ garbageBetweenLeftParenAndArgs: RawGarbageNodesSyntax? = nil,
    args: RawPoundSourceLocationArgsSyntax?,
    _ garbageBetweenArgsAndRightParen: RawGarbageNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .poundSourceLocation, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforePoundSourceLocation?.raw
      layout[1] = poundSourceLocation.raw
      layout[2] = garbageBetweenPoundSourceLocationAndLeftParen?.raw
      layout[3] = leftParen.raw
      layout[4] = garbageBetweenLeftParenAndArgs?.raw
      layout[5] = args?.raw
      layout[6] = garbageBetweenArgsAndRightParen?.raw
      layout[7] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforePoundSourceLocation: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var poundSourceLocation: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenPoundSourceLocationAndLeftParen: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftParenAndArgs: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var args: RawPoundSourceLocationArgsSyntax? {
    raw.children[5].map(RawPoundSourceLocationArgsSyntax.init(raw:))
  }
  public var garbageBetweenArgsAndRightParen: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPoundSourceLocationArgsSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeFileArgLabel: RawGarbageNodesSyntax? = nil,
    fileArgLabel: RawTokenSyntax,
    _ garbageBetweenFileArgLabelAndFileArgColon: RawGarbageNodesSyntax? = nil,
    fileArgColon: RawTokenSyntax,
    _ garbageBetweenFileArgColonAndFileName: RawGarbageNodesSyntax? = nil,
    fileName: RawTokenSyntax,
    _ garbageBetweenFileNameAndComma: RawGarbageNodesSyntax? = nil,
    comma: RawTokenSyntax,
    _ garbageBetweenCommaAndLineArgLabel: RawGarbageNodesSyntax? = nil,
    lineArgLabel: RawTokenSyntax,
    _ garbageBetweenLineArgLabelAndLineArgColon: RawGarbageNodesSyntax? = nil,
    lineArgColon: RawTokenSyntax,
    _ garbageBetweenLineArgColonAndLineNumber: RawGarbageNodesSyntax? = nil,
    lineNumber: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .poundSourceLocationArgs, uninitializedCount: 14, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeFileArgLabel?.raw
      layout[1] = fileArgLabel.raw
      layout[2] = garbageBetweenFileArgLabelAndFileArgColon?.raw
      layout[3] = fileArgColon.raw
      layout[4] = garbageBetweenFileArgColonAndFileName?.raw
      layout[5] = fileName.raw
      layout[6] = garbageBetweenFileNameAndComma?.raw
      layout[7] = comma.raw
      layout[8] = garbageBetweenCommaAndLineArgLabel?.raw
      layout[9] = lineArgLabel.raw
      layout[10] = garbageBetweenLineArgLabelAndLineArgColon?.raw
      layout[11] = lineArgColon.raw
      layout[12] = garbageBetweenLineArgColonAndLineNumber?.raw
      layout[13] = lineNumber.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeFileArgLabel: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var fileArgLabel: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenFileArgLabelAndFileArgColon: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var fileArgColon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenFileArgColonAndFileName: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var fileName: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenFileNameAndComma: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var comma: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenCommaAndLineArgLabel: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var lineArgLabel: RawTokenSyntax {
    raw.children[9].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLineArgLabelAndLineArgColon: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var lineArgColon: RawTokenSyntax {
    raw.children[11].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLineArgColonAndLineNumber: RawGarbageNodesSyntax? {
    raw.children[12].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var lineNumber: RawTokenSyntax {
    raw.children[13].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawDeclModifierDetailSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeLeftParen: RawGarbageNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ garbageBetweenLeftParenAndDetail: RawGarbageNodesSyntax? = nil,
    detail: RawTokenSyntax,
    _ garbageBetweenDetailAndRightParen: RawGarbageNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .declModifierDetail, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLeftParen?.raw
      layout[1] = leftParen.raw
      layout[2] = garbageBetweenLeftParenAndDetail?.raw
      layout[3] = detail.raw
      layout[4] = garbageBetweenDetailAndRightParen?.raw
      layout[5] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLeftParen: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftParenAndDetail: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var detail: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenDetailAndRightParen: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawDeclModifierSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeName: RawGarbageNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ garbageBetweenNameAndDetail: RawGarbageNodesSyntax? = nil,
    detail: RawDeclModifierDetailSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .declModifier, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeName?.raw
      layout[1] = name.raw
      layout[2] = garbageBetweenNameAndDetail?.raw
      layout[3] = detail?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeName: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenNameAndDetail: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var detail: RawDeclModifierDetailSyntax? {
    raw.children[3].map(RawDeclModifierDetailSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawInheritedTypeSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeTypeName: RawGarbageNodesSyntax? = nil,
    typeName: RawTypeSyntax,
    _ garbageBetweenTypeNameAndTrailingComma: RawGarbageNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .inheritedType, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeTypeName?.raw
      layout[1] = typeName.raw
      layout[2] = garbageBetweenTypeNameAndTrailingComma?.raw
      layout[3] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeTypeName: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var typeName: RawTypeSyntax {
    raw.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var garbageBetweenTypeNameAndTrailingComma: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawInheritedTypeListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawInheritedTypeSyntax {
    let raw = RawSyntax.makeLayout(kind: .inheritedTypeList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawInheritedTypeSyntax] {
    raw.children.map { RawInheritedTypeSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawTypeInheritanceClauseSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ garbageBetweenColonAndInheritedTypeCollection: RawGarbageNodesSyntax? = nil,
    inheritedTypeCollection: RawInheritedTypeListSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .typeInheritanceClause, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeColon?.raw
      layout[1] = colon.raw
      layout[2] = garbageBetweenColonAndInheritedTypeCollection?.raw
      layout[3] = inheritedTypeCollection.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeColon: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenColonAndInheritedTypeCollection: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var inheritedTypeCollection: RawInheritedTypeListSyntax {
    raw.children[3].map(RawInheritedTypeListSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawClassDeclSyntax: RawDeclSyntaxNodeProtocol {
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
    _ garbageBeforeAttributes: RawGarbageNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ garbageBetweenModifiersAndClassKeyword: RawGarbageNodesSyntax? = nil,
    classKeyword: RawTokenSyntax,
    _ garbageBetweenClassKeywordAndIdentifier: RawGarbageNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ garbageBetweenIdentifierAndGenericParameterClause: RawGarbageNodesSyntax? = nil,
    genericParameterClause: RawGenericParameterClauseSyntax?,
    _ garbageBetweenGenericParameterClauseAndInheritanceClause: RawGarbageNodesSyntax? = nil,
    inheritanceClause: RawTypeInheritanceClauseSyntax?,
    _ garbageBetweenInheritanceClauseAndGenericWhereClause: RawGarbageNodesSyntax? = nil,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    _ garbageBetweenGenericWhereClauseAndMembers: RawGarbageNodesSyntax? = nil,
    members: RawMemberDeclBlockSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .classDecl, uninitializedCount: 16, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = garbageBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = garbageBetweenModifiersAndClassKeyword?.raw
      layout[5] = classKeyword.raw
      layout[6] = garbageBetweenClassKeywordAndIdentifier?.raw
      layout[7] = identifier.raw
      layout[8] = garbageBetweenIdentifierAndGenericParameterClause?.raw
      layout[9] = genericParameterClause?.raw
      layout[10] = garbageBetweenGenericParameterClauseAndInheritanceClause?.raw
      layout[11] = inheritanceClause?.raw
      layout[12] = garbageBetweenInheritanceClauseAndGenericWhereClause?.raw
      layout[13] = genericWhereClause?.raw
      layout[14] = garbageBetweenGenericWhereClauseAndMembers?.raw
      layout[15] = members.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAttributes: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var garbageBetweenModifiersAndClassKeyword: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var classKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenClassKeywordAndIdentifier: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenIdentifierAndGenericParameterClause: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    raw.children[9].map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var garbageBetweenGenericParameterClauseAndInheritanceClause: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    raw.children[11].map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var garbageBetweenInheritanceClauseAndGenericWhereClause: RawGarbageNodesSyntax? {
    raw.children[12].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    raw.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var garbageBetweenGenericWhereClauseAndMembers: RawGarbageNodesSyntax? {
    raw.children[14].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var members: RawMemberDeclBlockSyntax {
    raw.children[15].map(RawMemberDeclBlockSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawActorDeclSyntax: RawDeclSyntaxNodeProtocol {
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
    _ garbageBeforeAttributes: RawGarbageNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ garbageBetweenModifiersAndActorKeyword: RawGarbageNodesSyntax? = nil,
    actorKeyword: RawTokenSyntax,
    _ garbageBetweenActorKeywordAndIdentifier: RawGarbageNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ garbageBetweenIdentifierAndGenericParameterClause: RawGarbageNodesSyntax? = nil,
    genericParameterClause: RawGenericParameterClauseSyntax?,
    _ garbageBetweenGenericParameterClauseAndInheritanceClause: RawGarbageNodesSyntax? = nil,
    inheritanceClause: RawTypeInheritanceClauseSyntax?,
    _ garbageBetweenInheritanceClauseAndGenericWhereClause: RawGarbageNodesSyntax? = nil,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    _ garbageBetweenGenericWhereClauseAndMembers: RawGarbageNodesSyntax? = nil,
    members: RawMemberDeclBlockSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .actorDecl, uninitializedCount: 16, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = garbageBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = garbageBetweenModifiersAndActorKeyword?.raw
      layout[5] = actorKeyword.raw
      layout[6] = garbageBetweenActorKeywordAndIdentifier?.raw
      layout[7] = identifier.raw
      layout[8] = garbageBetweenIdentifierAndGenericParameterClause?.raw
      layout[9] = genericParameterClause?.raw
      layout[10] = garbageBetweenGenericParameterClauseAndInheritanceClause?.raw
      layout[11] = inheritanceClause?.raw
      layout[12] = garbageBetweenInheritanceClauseAndGenericWhereClause?.raw
      layout[13] = genericWhereClause?.raw
      layout[14] = garbageBetweenGenericWhereClauseAndMembers?.raw
      layout[15] = members.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAttributes: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var garbageBetweenModifiersAndActorKeyword: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var actorKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenActorKeywordAndIdentifier: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenIdentifierAndGenericParameterClause: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    raw.children[9].map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var garbageBetweenGenericParameterClauseAndInheritanceClause: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    raw.children[11].map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var garbageBetweenInheritanceClauseAndGenericWhereClause: RawGarbageNodesSyntax? {
    raw.children[12].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    raw.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var garbageBetweenGenericWhereClauseAndMembers: RawGarbageNodesSyntax? {
    raw.children[14].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var members: RawMemberDeclBlockSyntax {
    raw.children[15].map(RawMemberDeclBlockSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawStructDeclSyntax: RawDeclSyntaxNodeProtocol {
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
    _ garbageBeforeAttributes: RawGarbageNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ garbageBetweenModifiersAndStructKeyword: RawGarbageNodesSyntax? = nil,
    structKeyword: RawTokenSyntax,
    _ garbageBetweenStructKeywordAndIdentifier: RawGarbageNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ garbageBetweenIdentifierAndGenericParameterClause: RawGarbageNodesSyntax? = nil,
    genericParameterClause: RawGenericParameterClauseSyntax?,
    _ garbageBetweenGenericParameterClauseAndInheritanceClause: RawGarbageNodesSyntax? = nil,
    inheritanceClause: RawTypeInheritanceClauseSyntax?,
    _ garbageBetweenInheritanceClauseAndGenericWhereClause: RawGarbageNodesSyntax? = nil,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    _ garbageBetweenGenericWhereClauseAndMembers: RawGarbageNodesSyntax? = nil,
    members: RawMemberDeclBlockSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .structDecl, uninitializedCount: 16, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = garbageBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = garbageBetweenModifiersAndStructKeyword?.raw
      layout[5] = structKeyword.raw
      layout[6] = garbageBetweenStructKeywordAndIdentifier?.raw
      layout[7] = identifier.raw
      layout[8] = garbageBetweenIdentifierAndGenericParameterClause?.raw
      layout[9] = genericParameterClause?.raw
      layout[10] = garbageBetweenGenericParameterClauseAndInheritanceClause?.raw
      layout[11] = inheritanceClause?.raw
      layout[12] = garbageBetweenInheritanceClauseAndGenericWhereClause?.raw
      layout[13] = genericWhereClause?.raw
      layout[14] = garbageBetweenGenericWhereClauseAndMembers?.raw
      layout[15] = members.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAttributes: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var garbageBetweenModifiersAndStructKeyword: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var structKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenStructKeywordAndIdentifier: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenIdentifierAndGenericParameterClause: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    raw.children[9].map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var garbageBetweenGenericParameterClauseAndInheritanceClause: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    raw.children[11].map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var garbageBetweenInheritanceClauseAndGenericWhereClause: RawGarbageNodesSyntax? {
    raw.children[12].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    raw.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var garbageBetweenGenericWhereClauseAndMembers: RawGarbageNodesSyntax? {
    raw.children[14].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var members: RawMemberDeclBlockSyntax {
    raw.children[15].map(RawMemberDeclBlockSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawProtocolDeclSyntax: RawDeclSyntaxNodeProtocol {
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
    _ garbageBeforeAttributes: RawGarbageNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ garbageBetweenModifiersAndProtocolKeyword: RawGarbageNodesSyntax? = nil,
    protocolKeyword: RawTokenSyntax,
    _ garbageBetweenProtocolKeywordAndIdentifier: RawGarbageNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ garbageBetweenIdentifierAndPrimaryAssociatedTypeClause: RawGarbageNodesSyntax? = nil,
    primaryAssociatedTypeClause: RawPrimaryAssociatedTypeClauseSyntax?,
    _ garbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause: RawGarbageNodesSyntax? = nil,
    inheritanceClause: RawTypeInheritanceClauseSyntax?,
    _ garbageBetweenInheritanceClauseAndGenericWhereClause: RawGarbageNodesSyntax? = nil,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    _ garbageBetweenGenericWhereClauseAndMembers: RawGarbageNodesSyntax? = nil,
    members: RawMemberDeclBlockSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .protocolDecl, uninitializedCount: 16, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = garbageBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = garbageBetweenModifiersAndProtocolKeyword?.raw
      layout[5] = protocolKeyword.raw
      layout[6] = garbageBetweenProtocolKeywordAndIdentifier?.raw
      layout[7] = identifier.raw
      layout[8] = garbageBetweenIdentifierAndPrimaryAssociatedTypeClause?.raw
      layout[9] = primaryAssociatedTypeClause?.raw
      layout[10] = garbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause?.raw
      layout[11] = inheritanceClause?.raw
      layout[12] = garbageBetweenInheritanceClauseAndGenericWhereClause?.raw
      layout[13] = genericWhereClause?.raw
      layout[14] = garbageBetweenGenericWhereClauseAndMembers?.raw
      layout[15] = members.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAttributes: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var garbageBetweenModifiersAndProtocolKeyword: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var protocolKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenProtocolKeywordAndIdentifier: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenIdentifierAndPrimaryAssociatedTypeClause: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var primaryAssociatedTypeClause: RawPrimaryAssociatedTypeClauseSyntax? {
    raw.children[9].map(RawPrimaryAssociatedTypeClauseSyntax.init(raw:))
  }
  public var garbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    raw.children[11].map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var garbageBetweenInheritanceClauseAndGenericWhereClause: RawGarbageNodesSyntax? {
    raw.children[12].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    raw.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var garbageBetweenGenericWhereClauseAndMembers: RawGarbageNodesSyntax? {
    raw.children[14].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var members: RawMemberDeclBlockSyntax {
    raw.children[15].map(RawMemberDeclBlockSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawExtensionDeclSyntax: RawDeclSyntaxNodeProtocol {
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
    _ garbageBeforeAttributes: RawGarbageNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ garbageBetweenModifiersAndExtensionKeyword: RawGarbageNodesSyntax? = nil,
    extensionKeyword: RawTokenSyntax,
    _ garbageBetweenExtensionKeywordAndExtendedType: RawGarbageNodesSyntax? = nil,
    extendedType: RawTypeSyntax,
    _ garbageBetweenExtendedTypeAndInheritanceClause: RawGarbageNodesSyntax? = nil,
    inheritanceClause: RawTypeInheritanceClauseSyntax?,
    _ garbageBetweenInheritanceClauseAndGenericWhereClause: RawGarbageNodesSyntax? = nil,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    _ garbageBetweenGenericWhereClauseAndMembers: RawGarbageNodesSyntax? = nil,
    members: RawMemberDeclBlockSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .extensionDecl, uninitializedCount: 14, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = garbageBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = garbageBetweenModifiersAndExtensionKeyword?.raw
      layout[5] = extensionKeyword.raw
      layout[6] = garbageBetweenExtensionKeywordAndExtendedType?.raw
      layout[7] = extendedType.raw
      layout[8] = garbageBetweenExtendedTypeAndInheritanceClause?.raw
      layout[9] = inheritanceClause?.raw
      layout[10] = garbageBetweenInheritanceClauseAndGenericWhereClause?.raw
      layout[11] = genericWhereClause?.raw
      layout[12] = garbageBetweenGenericWhereClauseAndMembers?.raw
      layout[13] = members.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAttributes: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var garbageBetweenModifiersAndExtensionKeyword: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var extensionKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenExtensionKeywordAndExtendedType: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var extendedType: RawTypeSyntax {
    raw.children[7].map(RawTypeSyntax.init(raw:))!
  }
  public var garbageBetweenExtendedTypeAndInheritanceClause: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    raw.children[9].map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var garbageBetweenInheritanceClauseAndGenericWhereClause: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    raw.children[11].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var garbageBetweenGenericWhereClauseAndMembers: RawGarbageNodesSyntax? {
    raw.children[12].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var members: RawMemberDeclBlockSyntax {
    raw.children[13].map(RawMemberDeclBlockSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawMemberDeclBlockSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeLeftBrace: RawGarbageNodesSyntax? = nil,
    leftBrace: RawTokenSyntax,
    _ garbageBetweenLeftBraceAndMembers: RawGarbageNodesSyntax? = nil,
    members: RawMemberDeclListSyntax,
    _ garbageBetweenMembersAndRightBrace: RawGarbageNodesSyntax? = nil,
    rightBrace: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .memberDeclBlock, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLeftBrace?.raw
      layout[1] = leftBrace.raw
      layout[2] = garbageBetweenLeftBraceAndMembers?.raw
      layout[3] = members.raw
      layout[4] = garbageBetweenMembersAndRightBrace?.raw
      layout[5] = rightBrace.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLeftBrace: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftBrace: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftBraceAndMembers: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var members: RawMemberDeclListSyntax {
    raw.children[3].map(RawMemberDeclListSyntax.init(raw:))!
  }
  public var garbageBetweenMembersAndRightBrace: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightBrace: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawMemberDeclListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawMemberDeclListItemSyntax {
    let raw = RawSyntax.makeLayout(kind: .memberDeclList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawMemberDeclListItemSyntax] {
    raw.children.map { RawMemberDeclListItemSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawMemberDeclListItemSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeDecl: RawGarbageNodesSyntax? = nil,
    decl: RawDeclSyntax,
    _ garbageBetweenDeclAndSemicolon: RawGarbageNodesSyntax? = nil,
    semicolon: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .memberDeclListItem, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeDecl?.raw
      layout[1] = decl.raw
      layout[2] = garbageBetweenDeclAndSemicolon?.raw
      layout[3] = semicolon?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeDecl: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var decl: RawDeclSyntax {
    raw.children[1].map(RawDeclSyntax.init(raw:))!
  }
  public var garbageBetweenDeclAndSemicolon: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var semicolon: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawSourceFileSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeStatements: RawGarbageNodesSyntax? = nil,
    statements: RawCodeBlockItemListSyntax,
    _ garbageBetweenStatementsAndEOFToken: RawGarbageNodesSyntax? = nil,
    eofToken: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .sourceFile, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeStatements?.raw
      layout[1] = statements.raw
      layout[2] = garbageBetweenStatementsAndEOFToken?.raw
      layout[3] = eofToken.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeStatements: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var statements: RawCodeBlockItemListSyntax {
    raw.children[1].map(RawCodeBlockItemListSyntax.init(raw:))!
  }
  public var garbageBetweenStatementsAndEOFToken: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var eofToken: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawInitializerClauseSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeEqual: RawGarbageNodesSyntax? = nil,
    equal: RawTokenSyntax,
    _ garbageBetweenEqualAndValue: RawGarbageNodesSyntax? = nil,
    value: RawExprSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .initializerClause, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeEqual?.raw
      layout[1] = equal.raw
      layout[2] = garbageBetweenEqualAndValue?.raw
      layout[3] = value.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeEqual: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var equal: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenEqualAndValue: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var value: RawExprSyntax {
    raw.children[3].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawFunctionParameterSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeAttributes: RawGarbageNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ garbageBetweenAttributesAndFirstName: RawGarbageNodesSyntax? = nil,
    firstName: RawTokenSyntax?,
    _ garbageBetweenFirstNameAndSecondName: RawGarbageNodesSyntax? = nil,
    secondName: RawTokenSyntax?,
    _ garbageBetweenSecondNameAndColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax?,
    _ garbageBetweenColonAndType: RawGarbageNodesSyntax? = nil,
    type: RawTypeSyntax?,
    _ garbageBetweenTypeAndEllipsis: RawGarbageNodesSyntax? = nil,
    ellipsis: RawTokenSyntax?,
    _ garbageBetweenEllipsisAndDefaultArgument: RawGarbageNodesSyntax? = nil,
    defaultArgument: RawInitializerClauseSyntax?,
    _ garbageBetweenDefaultArgumentAndTrailingComma: RawGarbageNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .functionParameter, uninitializedCount: 16, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = garbageBetweenAttributesAndFirstName?.raw
      layout[3] = firstName?.raw
      layout[4] = garbageBetweenFirstNameAndSecondName?.raw
      layout[5] = secondName?.raw
      layout[6] = garbageBetweenSecondNameAndColon?.raw
      layout[7] = colon?.raw
      layout[8] = garbageBetweenColonAndType?.raw
      layout[9] = type?.raw
      layout[10] = garbageBetweenTypeAndEllipsis?.raw
      layout[11] = ellipsis?.raw
      layout[12] = garbageBetweenEllipsisAndDefaultArgument?.raw
      layout[13] = defaultArgument?.raw
      layout[14] = garbageBetweenDefaultArgumentAndTrailingComma?.raw
      layout[15] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAttributes: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var garbageBetweenAttributesAndFirstName: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var firstName: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenFirstNameAndSecondName: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var secondName: RawTokenSyntax? {
    raw.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenSecondNameAndColon: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenColonAndType: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var type: RawTypeSyntax? {
    raw.children[9].map(RawTypeSyntax.init(raw:))
  }
  public var garbageBetweenTypeAndEllipsis: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var ellipsis: RawTokenSyntax? {
    raw.children[11].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenEllipsisAndDefaultArgument: RawGarbageNodesSyntax? {
    raw.children[12].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var defaultArgument: RawInitializerClauseSyntax? {
    raw.children[13].map(RawInitializerClauseSyntax.init(raw:))
  }
  public var garbageBetweenDefaultArgumentAndTrailingComma: RawGarbageNodesSyntax? {
    raw.children[14].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[15].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawModifierListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawDeclModifierSyntax {
    let raw = RawSyntax.makeLayout(kind: .modifierList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawDeclModifierSyntax] {
    raw.children.map { RawDeclModifierSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawFunctionDeclSyntax: RawDeclSyntaxNodeProtocol {
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
    _ garbageBeforeAttributes: RawGarbageNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ garbageBetweenModifiersAndFuncKeyword: RawGarbageNodesSyntax? = nil,
    funcKeyword: RawTokenSyntax,
    _ garbageBetweenFuncKeywordAndIdentifier: RawGarbageNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ garbageBetweenIdentifierAndGenericParameterClause: RawGarbageNodesSyntax? = nil,
    genericParameterClause: RawGenericParameterClauseSyntax?,
    _ garbageBetweenGenericParameterClauseAndSignature: RawGarbageNodesSyntax? = nil,
    signature: RawFunctionSignatureSyntax,
    _ garbageBetweenSignatureAndGenericWhereClause: RawGarbageNodesSyntax? = nil,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    _ garbageBetweenGenericWhereClauseAndBody: RawGarbageNodesSyntax? = nil,
    body: RawCodeBlockSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .functionDecl, uninitializedCount: 16, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = garbageBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = garbageBetweenModifiersAndFuncKeyword?.raw
      layout[5] = funcKeyword.raw
      layout[6] = garbageBetweenFuncKeywordAndIdentifier?.raw
      layout[7] = identifier.raw
      layout[8] = garbageBetweenIdentifierAndGenericParameterClause?.raw
      layout[9] = genericParameterClause?.raw
      layout[10] = garbageBetweenGenericParameterClauseAndSignature?.raw
      layout[11] = signature.raw
      layout[12] = garbageBetweenSignatureAndGenericWhereClause?.raw
      layout[13] = genericWhereClause?.raw
      layout[14] = garbageBetweenGenericWhereClauseAndBody?.raw
      layout[15] = body?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAttributes: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var garbageBetweenModifiersAndFuncKeyword: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var funcKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenFuncKeywordAndIdentifier: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenIdentifierAndGenericParameterClause: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    raw.children[9].map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var garbageBetweenGenericParameterClauseAndSignature: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var signature: RawFunctionSignatureSyntax {
    raw.children[11].map(RawFunctionSignatureSyntax.init(raw:))!
  }
  public var garbageBetweenSignatureAndGenericWhereClause: RawGarbageNodesSyntax? {
    raw.children[12].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    raw.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var garbageBetweenGenericWhereClauseAndBody: RawGarbageNodesSyntax? {
    raw.children[14].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax? {
    raw.children[15].map(RawCodeBlockSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawInitializerDeclSyntax: RawDeclSyntaxNodeProtocol {
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
    _ garbageBeforeAttributes: RawGarbageNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ garbageBetweenModifiersAndInitKeyword: RawGarbageNodesSyntax? = nil,
    initKeyword: RawTokenSyntax,
    _ garbageBetweenInitKeywordAndOptionalMark: RawGarbageNodesSyntax? = nil,
    optionalMark: RawTokenSyntax?,
    _ garbageBetweenOptionalMarkAndGenericParameterClause: RawGarbageNodesSyntax? = nil,
    genericParameterClause: RawGenericParameterClauseSyntax?,
    _ garbageBetweenGenericParameterClauseAndSignature: RawGarbageNodesSyntax? = nil,
    signature: RawFunctionSignatureSyntax,
    _ garbageBetweenSignatureAndGenericWhereClause: RawGarbageNodesSyntax? = nil,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    _ garbageBetweenGenericWhereClauseAndBody: RawGarbageNodesSyntax? = nil,
    body: RawCodeBlockSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .initializerDecl, uninitializedCount: 16, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = garbageBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = garbageBetweenModifiersAndInitKeyword?.raw
      layout[5] = initKeyword.raw
      layout[6] = garbageBetweenInitKeywordAndOptionalMark?.raw
      layout[7] = optionalMark?.raw
      layout[8] = garbageBetweenOptionalMarkAndGenericParameterClause?.raw
      layout[9] = genericParameterClause?.raw
      layout[10] = garbageBetweenGenericParameterClauseAndSignature?.raw
      layout[11] = signature.raw
      layout[12] = garbageBetweenSignatureAndGenericWhereClause?.raw
      layout[13] = genericWhereClause?.raw
      layout[14] = garbageBetweenGenericWhereClauseAndBody?.raw
      layout[15] = body?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAttributes: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var garbageBetweenModifiersAndInitKeyword: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var initKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenInitKeywordAndOptionalMark: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var optionalMark: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenOptionalMarkAndGenericParameterClause: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    raw.children[9].map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var garbageBetweenGenericParameterClauseAndSignature: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var signature: RawFunctionSignatureSyntax {
    raw.children[11].map(RawFunctionSignatureSyntax.init(raw:))!
  }
  public var garbageBetweenSignatureAndGenericWhereClause: RawGarbageNodesSyntax? {
    raw.children[12].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    raw.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var garbageBetweenGenericWhereClauseAndBody: RawGarbageNodesSyntax? {
    raw.children[14].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax? {
    raw.children[15].map(RawCodeBlockSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawDeinitializerDeclSyntax: RawDeclSyntaxNodeProtocol {
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
    _ garbageBeforeAttributes: RawGarbageNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ garbageBetweenModifiersAndDeinitKeyword: RawGarbageNodesSyntax? = nil,
    deinitKeyword: RawTokenSyntax,
    _ garbageBetweenDeinitKeywordAndBody: RawGarbageNodesSyntax? = nil,
    body: RawCodeBlockSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .deinitializerDecl, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = garbageBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = garbageBetweenModifiersAndDeinitKeyword?.raw
      layout[5] = deinitKeyword.raw
      layout[6] = garbageBetweenDeinitKeywordAndBody?.raw
      layout[7] = body?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAttributes: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var garbageBetweenModifiersAndDeinitKeyword: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var deinitKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenDeinitKeywordAndBody: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax? {
    raw.children[7].map(RawCodeBlockSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawSubscriptDeclSyntax: RawDeclSyntaxNodeProtocol {
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
    _ garbageBeforeAttributes: RawGarbageNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ garbageBetweenModifiersAndSubscriptKeyword: RawGarbageNodesSyntax? = nil,
    subscriptKeyword: RawTokenSyntax,
    _ garbageBetweenSubscriptKeywordAndGenericParameterClause: RawGarbageNodesSyntax? = nil,
    genericParameterClause: RawGenericParameterClauseSyntax?,
    _ garbageBetweenGenericParameterClauseAndIndices: RawGarbageNodesSyntax? = nil,
    indices: RawParameterClauseSyntax,
    _ garbageBetweenIndicesAndResult: RawGarbageNodesSyntax? = nil,
    result: RawReturnClauseSyntax,
    _ garbageBetweenResultAndGenericWhereClause: RawGarbageNodesSyntax? = nil,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    _ garbageBetweenGenericWhereClauseAndAccessor: RawGarbageNodesSyntax? = nil,
    accessor: RawSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .subscriptDecl, uninitializedCount: 16, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = garbageBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = garbageBetweenModifiersAndSubscriptKeyword?.raw
      layout[5] = subscriptKeyword.raw
      layout[6] = garbageBetweenSubscriptKeywordAndGenericParameterClause?.raw
      layout[7] = genericParameterClause?.raw
      layout[8] = garbageBetweenGenericParameterClauseAndIndices?.raw
      layout[9] = indices.raw
      layout[10] = garbageBetweenIndicesAndResult?.raw
      layout[11] = result.raw
      layout[12] = garbageBetweenResultAndGenericWhereClause?.raw
      layout[13] = genericWhereClause?.raw
      layout[14] = garbageBetweenGenericWhereClauseAndAccessor?.raw
      layout[15] = accessor?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAttributes: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var garbageBetweenModifiersAndSubscriptKeyword: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var subscriptKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenSubscriptKeywordAndGenericParameterClause: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    raw.children[7].map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var garbageBetweenGenericParameterClauseAndIndices: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var indices: RawParameterClauseSyntax {
    raw.children[9].map(RawParameterClauseSyntax.init(raw:))!
  }
  public var garbageBetweenIndicesAndResult: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var result: RawReturnClauseSyntax {
    raw.children[11].map(RawReturnClauseSyntax.init(raw:))!
  }
  public var garbageBetweenResultAndGenericWhereClause: RawGarbageNodesSyntax? {
    raw.children[12].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    raw.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var garbageBetweenGenericWhereClauseAndAccessor: RawGarbageNodesSyntax? {
    raw.children[14].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var accessor: RawSyntax? {
    raw.children[15]
  }
}

@_spi(RawSyntax)
public struct RawAccessLevelModifierSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeName: RawGarbageNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ garbageBetweenNameAndModifier: RawGarbageNodesSyntax? = nil,
    modifier: RawDeclModifierDetailSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .accessLevelModifier, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeName?.raw
      layout[1] = name.raw
      layout[2] = garbageBetweenNameAndModifier?.raw
      layout[3] = modifier?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeName: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenNameAndModifier: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var modifier: RawDeclModifierDetailSyntax? {
    raw.children[3].map(RawDeclModifierDetailSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawAccessPathComponentSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeName: RawGarbageNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ garbageBetweenNameAndTrailingDot: RawGarbageNodesSyntax? = nil,
    trailingDot: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .accessPathComponent, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeName?.raw
      layout[1] = name.raw
      layout[2] = garbageBetweenNameAndTrailingDot?.raw
      layout[3] = trailingDot?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeName: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenNameAndTrailingDot: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingDot: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawAccessPathSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawAccessPathComponentSyntax {
    let raw = RawSyntax.makeLayout(kind: .accessPath, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawAccessPathComponentSyntax] {
    raw.children.map { RawAccessPathComponentSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawImportDeclSyntax: RawDeclSyntaxNodeProtocol {
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
    _ garbageBeforeAttributes: RawGarbageNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ garbageBetweenModifiersAndImportTok: RawGarbageNodesSyntax? = nil,
    importTok: RawTokenSyntax,
    _ garbageBetweenImportTokAndImportKind: RawGarbageNodesSyntax? = nil,
    importKind: RawTokenSyntax?,
    _ garbageBetweenImportKindAndPath: RawGarbageNodesSyntax? = nil,
    path: RawAccessPathSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .importDecl, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = garbageBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = garbageBetweenModifiersAndImportTok?.raw
      layout[5] = importTok.raw
      layout[6] = garbageBetweenImportTokAndImportKind?.raw
      layout[7] = importKind?.raw
      layout[8] = garbageBetweenImportKindAndPath?.raw
      layout[9] = path.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAttributes: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var garbageBetweenModifiersAndImportTok: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var importTok: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenImportTokAndImportKind: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var importKind: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenImportKindAndPath: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var path: RawAccessPathSyntax {
    raw.children[9].map(RawAccessPathSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawAccessorParameterSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeLeftParen: RawGarbageNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ garbageBetweenLeftParenAndName: RawGarbageNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ garbageBetweenNameAndRightParen: RawGarbageNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .accessorParameter, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLeftParen?.raw
      layout[1] = leftParen.raw
      layout[2] = garbageBetweenLeftParenAndName?.raw
      layout[3] = name.raw
      layout[4] = garbageBetweenNameAndRightParen?.raw
      layout[5] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLeftParen: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftParenAndName: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenNameAndRightParen: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawAccessorDeclSyntax: RawDeclSyntaxNodeProtocol {
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
    _ garbageBeforeAttributes: RawGarbageNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ garbageBetweenAttributesAndModifier: RawGarbageNodesSyntax? = nil,
    modifier: RawDeclModifierSyntax?,
    _ garbageBetweenModifierAndAccessorKind: RawGarbageNodesSyntax? = nil,
    accessorKind: RawTokenSyntax,
    _ garbageBetweenAccessorKindAndParameter: RawGarbageNodesSyntax? = nil,
    parameter: RawAccessorParameterSyntax?,
    _ garbageBetweenParameterAndAsyncKeyword: RawGarbageNodesSyntax? = nil,
    asyncKeyword: RawTokenSyntax?,
    _ garbageBetweenAsyncKeywordAndThrowsKeyword: RawGarbageNodesSyntax? = nil,
    throwsKeyword: RawTokenSyntax?,
    _ garbageBetweenThrowsKeywordAndBody: RawGarbageNodesSyntax? = nil,
    body: RawCodeBlockSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .accessorDecl, uninitializedCount: 14, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = garbageBetweenAttributesAndModifier?.raw
      layout[3] = modifier?.raw
      layout[4] = garbageBetweenModifierAndAccessorKind?.raw
      layout[5] = accessorKind.raw
      layout[6] = garbageBetweenAccessorKindAndParameter?.raw
      layout[7] = parameter?.raw
      layout[8] = garbageBetweenParameterAndAsyncKeyword?.raw
      layout[9] = asyncKeyword?.raw
      layout[10] = garbageBetweenAsyncKeywordAndThrowsKeyword?.raw
      layout[11] = throwsKeyword?.raw
      layout[12] = garbageBetweenThrowsKeywordAndBody?.raw
      layout[13] = body?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAttributes: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var garbageBetweenAttributesAndModifier: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var modifier: RawDeclModifierSyntax? {
    raw.children[3].map(RawDeclModifierSyntax.init(raw:))
  }
  public var garbageBetweenModifierAndAccessorKind: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var accessorKind: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenAccessorKindAndParameter: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var parameter: RawAccessorParameterSyntax? {
    raw.children[7].map(RawAccessorParameterSyntax.init(raw:))
  }
  public var garbageBetweenParameterAndAsyncKeyword: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var asyncKeyword: RawTokenSyntax? {
    raw.children[9].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenAsyncKeywordAndThrowsKeyword: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var throwsKeyword: RawTokenSyntax? {
    raw.children[11].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenThrowsKeywordAndBody: RawGarbageNodesSyntax? {
    raw.children[12].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax? {
    raw.children[13].map(RawCodeBlockSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawAccessorListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawAccessorDeclSyntax {
    let raw = RawSyntax.makeLayout(kind: .accessorList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawAccessorDeclSyntax] {
    raw.children.map { RawAccessorDeclSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawAccessorBlockSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeLeftBrace: RawGarbageNodesSyntax? = nil,
    leftBrace: RawTokenSyntax,
    _ garbageBetweenLeftBraceAndAccessors: RawGarbageNodesSyntax? = nil,
    accessors: RawAccessorListSyntax,
    _ garbageBetweenAccessorsAndRightBrace: RawGarbageNodesSyntax? = nil,
    rightBrace: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .accessorBlock, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLeftBrace?.raw
      layout[1] = leftBrace.raw
      layout[2] = garbageBetweenLeftBraceAndAccessors?.raw
      layout[3] = accessors.raw
      layout[4] = garbageBetweenAccessorsAndRightBrace?.raw
      layout[5] = rightBrace.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLeftBrace: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftBrace: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftBraceAndAccessors: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var accessors: RawAccessorListSyntax {
    raw.children[3].map(RawAccessorListSyntax.init(raw:))!
  }
  public var garbageBetweenAccessorsAndRightBrace: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightBrace: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPatternBindingSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforePattern: RawGarbageNodesSyntax? = nil,
    pattern: RawPatternSyntax,
    _ garbageBetweenPatternAndTypeAnnotation: RawGarbageNodesSyntax? = nil,
    typeAnnotation: RawTypeAnnotationSyntax?,
    _ garbageBetweenTypeAnnotationAndInitializer: RawGarbageNodesSyntax? = nil,
    initializer: RawInitializerClauseSyntax?,
    _ garbageBetweenInitializerAndAccessor: RawGarbageNodesSyntax? = nil,
    accessor: RawSyntax?,
    _ garbageBetweenAccessorAndTrailingComma: RawGarbageNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .patternBinding, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforePattern?.raw
      layout[1] = pattern.raw
      layout[2] = garbageBetweenPatternAndTypeAnnotation?.raw
      layout[3] = typeAnnotation?.raw
      layout[4] = garbageBetweenTypeAnnotationAndInitializer?.raw
      layout[5] = initializer?.raw
      layout[6] = garbageBetweenInitializerAndAccessor?.raw
      layout[7] = accessor?.raw
      layout[8] = garbageBetweenAccessorAndTrailingComma?.raw
      layout[9] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforePattern: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax {
    raw.children[1].map(RawPatternSyntax.init(raw:))!
  }
  public var garbageBetweenPatternAndTypeAnnotation: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var typeAnnotation: RawTypeAnnotationSyntax? {
    raw.children[3].map(RawTypeAnnotationSyntax.init(raw:))
  }
  public var garbageBetweenTypeAnnotationAndInitializer: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var initializer: RawInitializerClauseSyntax? {
    raw.children[5].map(RawInitializerClauseSyntax.init(raw:))
  }
  public var garbageBetweenInitializerAndAccessor: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var accessor: RawSyntax? {
    raw.children[7]
  }
  public var garbageBetweenAccessorAndTrailingComma: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[9].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawPatternBindingListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawPatternBindingSyntax {
    let raw = RawSyntax.makeLayout(kind: .patternBindingList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawPatternBindingSyntax] {
    raw.children.map { RawPatternBindingSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawVariableDeclSyntax: RawDeclSyntaxNodeProtocol {
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
    _ garbageBeforeAttributes: RawGarbageNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ garbageBetweenModifiersAndLetOrVarKeyword: RawGarbageNodesSyntax? = nil,
    letOrVarKeyword: RawTokenSyntax,
    _ garbageBetweenLetOrVarKeywordAndBindings: RawGarbageNodesSyntax? = nil,
    bindings: RawPatternBindingListSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .variableDecl, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = garbageBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = garbageBetweenModifiersAndLetOrVarKeyword?.raw
      layout[5] = letOrVarKeyword.raw
      layout[6] = garbageBetweenLetOrVarKeywordAndBindings?.raw
      layout[7] = bindings.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAttributes: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var garbageBetweenModifiersAndLetOrVarKeyword: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var letOrVarKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLetOrVarKeywordAndBindings: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var bindings: RawPatternBindingListSyntax {
    raw.children[7].map(RawPatternBindingListSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawEnumCaseElementSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeIdentifier: RawGarbageNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ garbageBetweenIdentifierAndAssociatedValue: RawGarbageNodesSyntax? = nil,
    associatedValue: RawParameterClauseSyntax?,
    _ garbageBetweenAssociatedValueAndRawValue: RawGarbageNodesSyntax? = nil,
    rawValue: RawInitializerClauseSyntax?,
    _ garbageBetweenRawValueAndTrailingComma: RawGarbageNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .enumCaseElement, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeIdentifier?.raw
      layout[1] = identifier.raw
      layout[2] = garbageBetweenIdentifierAndAssociatedValue?.raw
      layout[3] = associatedValue?.raw
      layout[4] = garbageBetweenAssociatedValueAndRawValue?.raw
      layout[5] = rawValue?.raw
      layout[6] = garbageBetweenRawValueAndTrailingComma?.raw
      layout[7] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeIdentifier: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenIdentifierAndAssociatedValue: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var associatedValue: RawParameterClauseSyntax? {
    raw.children[3].map(RawParameterClauseSyntax.init(raw:))
  }
  public var garbageBetweenAssociatedValueAndRawValue: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rawValue: RawInitializerClauseSyntax? {
    raw.children[5].map(RawInitializerClauseSyntax.init(raw:))
  }
  public var garbageBetweenRawValueAndTrailingComma: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawEnumCaseElementListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawEnumCaseElementSyntax {
    let raw = RawSyntax.makeLayout(kind: .enumCaseElementList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawEnumCaseElementSyntax] {
    raw.children.map { RawEnumCaseElementSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawEnumCaseDeclSyntax: RawDeclSyntaxNodeProtocol {
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
    _ garbageBeforeAttributes: RawGarbageNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ garbageBetweenModifiersAndCaseKeyword: RawGarbageNodesSyntax? = nil,
    caseKeyword: RawTokenSyntax,
    _ garbageBetweenCaseKeywordAndElements: RawGarbageNodesSyntax? = nil,
    elements: RawEnumCaseElementListSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .enumCaseDecl, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = garbageBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = garbageBetweenModifiersAndCaseKeyword?.raw
      layout[5] = caseKeyword.raw
      layout[6] = garbageBetweenCaseKeywordAndElements?.raw
      layout[7] = elements.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAttributes: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var garbageBetweenModifiersAndCaseKeyword: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var caseKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenCaseKeywordAndElements: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var elements: RawEnumCaseElementListSyntax {
    raw.children[7].map(RawEnumCaseElementListSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawEnumDeclSyntax: RawDeclSyntaxNodeProtocol {
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
    _ garbageBeforeAttributes: RawGarbageNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ garbageBetweenModifiersAndEnumKeyword: RawGarbageNodesSyntax? = nil,
    enumKeyword: RawTokenSyntax,
    _ garbageBetweenEnumKeywordAndIdentifier: RawGarbageNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ garbageBetweenIdentifierAndGenericParameters: RawGarbageNodesSyntax? = nil,
    genericParameters: RawGenericParameterClauseSyntax?,
    _ garbageBetweenGenericParametersAndInheritanceClause: RawGarbageNodesSyntax? = nil,
    inheritanceClause: RawTypeInheritanceClauseSyntax?,
    _ garbageBetweenInheritanceClauseAndGenericWhereClause: RawGarbageNodesSyntax? = nil,
    genericWhereClause: RawGenericWhereClauseSyntax?,
    _ garbageBetweenGenericWhereClauseAndMembers: RawGarbageNodesSyntax? = nil,
    members: RawMemberDeclBlockSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .enumDecl, uninitializedCount: 16, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = garbageBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = garbageBetweenModifiersAndEnumKeyword?.raw
      layout[5] = enumKeyword.raw
      layout[6] = garbageBetweenEnumKeywordAndIdentifier?.raw
      layout[7] = identifier.raw
      layout[8] = garbageBetweenIdentifierAndGenericParameters?.raw
      layout[9] = genericParameters?.raw
      layout[10] = garbageBetweenGenericParametersAndInheritanceClause?.raw
      layout[11] = inheritanceClause?.raw
      layout[12] = garbageBetweenInheritanceClauseAndGenericWhereClause?.raw
      layout[13] = genericWhereClause?.raw
      layout[14] = garbageBetweenGenericWhereClauseAndMembers?.raw
      layout[15] = members.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAttributes: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var garbageBetweenModifiersAndEnumKeyword: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var enumKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenEnumKeywordAndIdentifier: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenIdentifierAndGenericParameters: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var genericParameters: RawGenericParameterClauseSyntax? {
    raw.children[9].map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var garbageBetweenGenericParametersAndInheritanceClause: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    raw.children[11].map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var garbageBetweenInheritanceClauseAndGenericWhereClause: RawGarbageNodesSyntax? {
    raw.children[12].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    raw.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var garbageBetweenGenericWhereClauseAndMembers: RawGarbageNodesSyntax? {
    raw.children[14].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var members: RawMemberDeclBlockSyntax {
    raw.children[15].map(RawMemberDeclBlockSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawOperatorDeclSyntax: RawDeclSyntaxNodeProtocol {
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
    _ garbageBeforeAttributes: RawGarbageNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ garbageBetweenModifiersAndOperatorKeyword: RawGarbageNodesSyntax? = nil,
    operatorKeyword: RawTokenSyntax,
    _ garbageBetweenOperatorKeywordAndIdentifier: RawGarbageNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ garbageBetweenIdentifierAndOperatorPrecedenceAndTypes: RawGarbageNodesSyntax? = nil,
    operatorPrecedenceAndTypes: RawOperatorPrecedenceAndTypesSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .operatorDecl, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = garbageBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = garbageBetweenModifiersAndOperatorKeyword?.raw
      layout[5] = operatorKeyword.raw
      layout[6] = garbageBetweenOperatorKeywordAndIdentifier?.raw
      layout[7] = identifier.raw
      layout[8] = garbageBetweenIdentifierAndOperatorPrecedenceAndTypes?.raw
      layout[9] = operatorPrecedenceAndTypes?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAttributes: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var garbageBetweenModifiersAndOperatorKeyword: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var operatorKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenOperatorKeywordAndIdentifier: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenIdentifierAndOperatorPrecedenceAndTypes: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var operatorPrecedenceAndTypes: RawOperatorPrecedenceAndTypesSyntax? {
    raw.children[9].map(RawOperatorPrecedenceAndTypesSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawIdentifierListSyntax: RawSyntaxNodeProtocol {
  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .identifierList
  }

  public var raw: RawSyntax
  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawTokenSyntax {
    let raw = RawSyntax.makeLayout(kind: .identifierList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawTokenSyntax] {
    raw.children.map { RawTokenSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawOperatorPrecedenceAndTypesSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ garbageBetweenColonAndPrecedenceGroupAndDesignatedTypes: RawGarbageNodesSyntax? = nil,
    precedenceGroupAndDesignatedTypes: RawIdentifierListSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .operatorPrecedenceAndTypes, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeColon?.raw
      layout[1] = colon.raw
      layout[2] = garbageBetweenColonAndPrecedenceGroupAndDesignatedTypes?.raw
      layout[3] = precedenceGroupAndDesignatedTypes.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeColon: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenColonAndPrecedenceGroupAndDesignatedTypes: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var precedenceGroupAndDesignatedTypes: RawIdentifierListSyntax {
    raw.children[3].map(RawIdentifierListSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPrecedenceGroupDeclSyntax: RawDeclSyntaxNodeProtocol {
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
    _ garbageBeforeAttributes: RawGarbageNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? = nil,
    modifiers: RawModifierListSyntax?,
    _ garbageBetweenModifiersAndPrecedencegroupKeyword: RawGarbageNodesSyntax? = nil,
    precedencegroupKeyword: RawTokenSyntax,
    _ garbageBetweenPrecedencegroupKeywordAndIdentifier: RawGarbageNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ garbageBetweenIdentifierAndLeftBrace: RawGarbageNodesSyntax? = nil,
    leftBrace: RawTokenSyntax,
    _ garbageBetweenLeftBraceAndGroupAttributes: RawGarbageNodesSyntax? = nil,
    groupAttributes: RawPrecedenceGroupAttributeListSyntax,
    _ garbageBetweenGroupAttributesAndRightBrace: RawGarbageNodesSyntax? = nil,
    rightBrace: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .precedenceGroupDecl, uninitializedCount: 14, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = garbageBetweenAttributesAndModifiers?.raw
      layout[3] = modifiers?.raw
      layout[4] = garbageBetweenModifiersAndPrecedencegroupKeyword?.raw
      layout[5] = precedencegroupKeyword.raw
      layout[6] = garbageBetweenPrecedencegroupKeywordAndIdentifier?.raw
      layout[7] = identifier.raw
      layout[8] = garbageBetweenIdentifierAndLeftBrace?.raw
      layout[9] = leftBrace.raw
      layout[10] = garbageBetweenLeftBraceAndGroupAttributes?.raw
      layout[11] = groupAttributes.raw
      layout[12] = garbageBetweenGroupAttributesAndRightBrace?.raw
      layout[13] = rightBrace.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAttributes: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var garbageBetweenAttributesAndModifiers: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var garbageBetweenModifiersAndPrecedencegroupKeyword: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var precedencegroupKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenPrecedencegroupKeywordAndIdentifier: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenIdentifierAndLeftBrace: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftBrace: RawTokenSyntax {
    raw.children[9].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftBraceAndGroupAttributes: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var groupAttributes: RawPrecedenceGroupAttributeListSyntax {
    raw.children[11].map(RawPrecedenceGroupAttributeListSyntax.init(raw:))!
  }
  public var garbageBetweenGroupAttributesAndRightBrace: RawGarbageNodesSyntax? {
    raw.children[12].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightBrace: RawTokenSyntax {
    raw.children[13].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPrecedenceGroupAttributeListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawSyntax {
    let raw = RawSyntax.makeLayout(kind: .precedenceGroupAttributeList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawSyntax] {
    raw.children.map { RawSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawPrecedenceGroupRelationSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeHigherThanOrLowerThan: RawGarbageNodesSyntax? = nil,
    higherThanOrLowerThan: RawTokenSyntax,
    _ garbageBetweenHigherThanOrLowerThanAndColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ garbageBetweenColonAndOtherNames: RawGarbageNodesSyntax? = nil,
    otherNames: RawPrecedenceGroupNameListSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .precedenceGroupRelation, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeHigherThanOrLowerThan?.raw
      layout[1] = higherThanOrLowerThan.raw
      layout[2] = garbageBetweenHigherThanOrLowerThanAndColon?.raw
      layout[3] = colon.raw
      layout[4] = garbageBetweenColonAndOtherNames?.raw
      layout[5] = otherNames.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeHigherThanOrLowerThan: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var higherThanOrLowerThan: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenHigherThanOrLowerThanAndColon: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenColonAndOtherNames: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var otherNames: RawPrecedenceGroupNameListSyntax {
    raw.children[5].map(RawPrecedenceGroupNameListSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPrecedenceGroupNameListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawPrecedenceGroupNameElementSyntax {
    let raw = RawSyntax.makeLayout(kind: .precedenceGroupNameList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawPrecedenceGroupNameElementSyntax] {
    raw.children.map { RawPrecedenceGroupNameElementSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawPrecedenceGroupNameElementSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeName: RawGarbageNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ garbageBetweenNameAndTrailingComma: RawGarbageNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .precedenceGroupNameElement, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeName?.raw
      layout[1] = name.raw
      layout[2] = garbageBetweenNameAndTrailingComma?.raw
      layout[3] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeName: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenNameAndTrailingComma: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawPrecedenceGroupAssignmentSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeAssignmentKeyword: RawGarbageNodesSyntax? = nil,
    assignmentKeyword: RawTokenSyntax,
    _ garbageBetweenAssignmentKeywordAndColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ garbageBetweenColonAndFlag: RawGarbageNodesSyntax? = nil,
    flag: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .precedenceGroupAssignment, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAssignmentKeyword?.raw
      layout[1] = assignmentKeyword.raw
      layout[2] = garbageBetweenAssignmentKeywordAndColon?.raw
      layout[3] = colon.raw
      layout[4] = garbageBetweenColonAndFlag?.raw
      layout[5] = flag.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAssignmentKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var assignmentKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenAssignmentKeywordAndColon: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenColonAndFlag: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var flag: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPrecedenceGroupAssociativitySyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeAssociativityKeyword: RawGarbageNodesSyntax? = nil,
    associativityKeyword: RawTokenSyntax,
    _ garbageBetweenAssociativityKeywordAndColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ garbageBetweenColonAndValue: RawGarbageNodesSyntax? = nil,
    value: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .precedenceGroupAssociativity, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAssociativityKeyword?.raw
      layout[1] = associativityKeyword.raw
      layout[2] = garbageBetweenAssociativityKeywordAndColon?.raw
      layout[3] = colon.raw
      layout[4] = garbageBetweenColonAndValue?.raw
      layout[5] = value.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAssociativityKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var associativityKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenAssociativityKeywordAndColon: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenColonAndValue: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var value: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawTokenListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawTokenSyntax {
    let raw = RawSyntax.makeLayout(kind: .tokenList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawTokenSyntax] {
    raw.children.map { RawTokenSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawNonEmptyTokenListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawTokenSyntax {
    let raw = RawSyntax.makeLayout(kind: .nonEmptyTokenList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawTokenSyntax] {
    raw.children.map { RawTokenSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawCustomAttributeSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeAtSignToken: RawGarbageNodesSyntax? = nil,
    atSignToken: RawTokenSyntax,
    _ garbageBetweenAtSignTokenAndAttributeName: RawGarbageNodesSyntax? = nil,
    attributeName: RawTypeSyntax,
    _ garbageBetweenAttributeNameAndLeftParen: RawGarbageNodesSyntax? = nil,
    leftParen: RawTokenSyntax?,
    _ garbageBetweenLeftParenAndArgumentList: RawGarbageNodesSyntax? = nil,
    argumentList: RawTupleExprElementListSyntax?,
    _ garbageBetweenArgumentListAndRightParen: RawGarbageNodesSyntax? = nil,
    rightParen: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .customAttribute, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAtSignToken?.raw
      layout[1] = atSignToken.raw
      layout[2] = garbageBetweenAtSignTokenAndAttributeName?.raw
      layout[3] = attributeName.raw
      layout[4] = garbageBetweenAttributeNameAndLeftParen?.raw
      layout[5] = leftParen?.raw
      layout[6] = garbageBetweenLeftParenAndArgumentList?.raw
      layout[7] = argumentList?.raw
      layout[8] = garbageBetweenArgumentListAndRightParen?.raw
      layout[9] = rightParen?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAtSignToken: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var atSignToken: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenAtSignTokenAndAttributeName: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var attributeName: RawTypeSyntax {
    raw.children[3].map(RawTypeSyntax.init(raw:))!
  }
  public var garbageBetweenAttributeNameAndLeftParen: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax? {
    raw.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenLeftParenAndArgumentList: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var argumentList: RawTupleExprElementListSyntax? {
    raw.children[7].map(RawTupleExprElementListSyntax.init(raw:))
  }
  public var garbageBetweenArgumentListAndRightParen: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax? {
    raw.children[9].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawAttributeSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeAtSignToken: RawGarbageNodesSyntax? = nil,
    atSignToken: RawTokenSyntax,
    _ garbageBetweenAtSignTokenAndAttributeName: RawGarbageNodesSyntax? = nil,
    attributeName: RawTokenSyntax,
    _ garbageBetweenAttributeNameAndLeftParen: RawGarbageNodesSyntax? = nil,
    leftParen: RawTokenSyntax?,
    _ garbageBetweenLeftParenAndArgument: RawGarbageNodesSyntax? = nil,
    argument: RawSyntax?,
    _ garbageBetweenArgumentAndRightParen: RawGarbageNodesSyntax? = nil,
    rightParen: RawTokenSyntax?,
    _ garbageBetweenRightParenAndTokenList: RawGarbageNodesSyntax? = nil,
    tokenList: RawTokenListSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .attribute, uninitializedCount: 12, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAtSignToken?.raw
      layout[1] = atSignToken.raw
      layout[2] = garbageBetweenAtSignTokenAndAttributeName?.raw
      layout[3] = attributeName.raw
      layout[4] = garbageBetweenAttributeNameAndLeftParen?.raw
      layout[5] = leftParen?.raw
      layout[6] = garbageBetweenLeftParenAndArgument?.raw
      layout[7] = argument?.raw
      layout[8] = garbageBetweenArgumentAndRightParen?.raw
      layout[9] = rightParen?.raw
      layout[10] = garbageBetweenRightParenAndTokenList?.raw
      layout[11] = tokenList?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAtSignToken: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var atSignToken: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenAtSignTokenAndAttributeName: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var attributeName: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenAttributeNameAndLeftParen: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax? {
    raw.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenLeftParenAndArgument: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var argument: RawSyntax? {
    raw.children[7]
  }
  public var garbageBetweenArgumentAndRightParen: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax? {
    raw.children[9].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenRightParenAndTokenList: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var tokenList: RawTokenListSyntax? {
    raw.children[11].map(RawTokenListSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawAttributeListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawSyntax {
    let raw = RawSyntax.makeLayout(kind: .attributeList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawSyntax] {
    raw.children.map { RawSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawSpecializeAttributeSpecListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawSyntax {
    let raw = RawSyntax.makeLayout(kind: .specializeAttributeSpecList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawSyntax] {
    raw.children.map { RawSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawAvailabilityEntrySyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeLabel: RawGarbageNodesSyntax? = nil,
    label: RawTokenSyntax,
    _ garbageBetweenLabelAndColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ garbageBetweenColonAndAvailabilityList: RawGarbageNodesSyntax? = nil,
    availabilityList: RawAvailabilitySpecListSyntax,
    _ garbageBetweenAvailabilityListAndSemicolon: RawGarbageNodesSyntax? = nil,
    semicolon: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .availabilityEntry, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLabel?.raw
      layout[1] = label.raw
      layout[2] = garbageBetweenLabelAndColon?.raw
      layout[3] = colon.raw
      layout[4] = garbageBetweenColonAndAvailabilityList?.raw
      layout[5] = availabilityList.raw
      layout[6] = garbageBetweenAvailabilityListAndSemicolon?.raw
      layout[7] = semicolon.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLabel: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var label: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLabelAndColon: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenColonAndAvailabilityList: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var availabilityList: RawAvailabilitySpecListSyntax {
    raw.children[5].map(RawAvailabilitySpecListSyntax.init(raw:))!
  }
  public var garbageBetweenAvailabilityListAndSemicolon: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var semicolon: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawLabeledSpecializeEntrySyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeLabel: RawGarbageNodesSyntax? = nil,
    label: RawTokenSyntax,
    _ garbageBetweenLabelAndColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ garbageBetweenColonAndValue: RawGarbageNodesSyntax? = nil,
    value: RawTokenSyntax,
    _ garbageBetweenValueAndTrailingComma: RawGarbageNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .labeledSpecializeEntry, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLabel?.raw
      layout[1] = label.raw
      layout[2] = garbageBetweenLabelAndColon?.raw
      layout[3] = colon.raw
      layout[4] = garbageBetweenColonAndValue?.raw
      layout[5] = value.raw
      layout[6] = garbageBetweenValueAndTrailingComma?.raw
      layout[7] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLabel: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var label: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLabelAndColon: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenColonAndValue: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var value: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenValueAndTrailingComma: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawTargetFunctionEntrySyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeLabel: RawGarbageNodesSyntax? = nil,
    label: RawTokenSyntax,
    _ garbageBetweenLabelAndColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ garbageBetweenColonAndDeclname: RawGarbageNodesSyntax? = nil,
    declname: RawDeclNameSyntax,
    _ garbageBetweenDeclnameAndTrailingComma: RawGarbageNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .targetFunctionEntry, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLabel?.raw
      layout[1] = label.raw
      layout[2] = garbageBetweenLabelAndColon?.raw
      layout[3] = colon.raw
      layout[4] = garbageBetweenColonAndDeclname?.raw
      layout[5] = declname.raw
      layout[6] = garbageBetweenDeclnameAndTrailingComma?.raw
      layout[7] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLabel: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var label: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLabelAndColon: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenColonAndDeclname: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var declname: RawDeclNameSyntax {
    raw.children[5].map(RawDeclNameSyntax.init(raw:))!
  }
  public var garbageBetweenDeclnameAndTrailingComma: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawNamedAttributeStringArgumentSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeNameTok: RawGarbageNodesSyntax? = nil,
    nameTok: RawTokenSyntax,
    _ garbageBetweenNameTokAndColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ garbageBetweenColonAndStringOrDeclname: RawGarbageNodesSyntax? = nil,
    stringOrDeclname: RawSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .namedAttributeStringArgument, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeNameTok?.raw
      layout[1] = nameTok.raw
      layout[2] = garbageBetweenNameTokAndColon?.raw
      layout[3] = colon.raw
      layout[4] = garbageBetweenColonAndStringOrDeclname?.raw
      layout[5] = stringOrDeclname.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeNameTok: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var nameTok: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenNameTokAndColon: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenColonAndStringOrDeclname: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var stringOrDeclname: RawSyntax {
    raw.children[5]!
  }
}

@_spi(RawSyntax)
public struct RawDeclNameSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeDeclBaseName: RawGarbageNodesSyntax? = nil,
    declBaseName: RawSyntax,
    _ garbageBetweenDeclBaseNameAndDeclNameArguments: RawGarbageNodesSyntax? = nil,
    declNameArguments: RawDeclNameArgumentsSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .declName, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeDeclBaseName?.raw
      layout[1] = declBaseName.raw
      layout[2] = garbageBetweenDeclBaseNameAndDeclNameArguments?.raw
      layout[3] = declNameArguments?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeDeclBaseName: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var declBaseName: RawSyntax {
    raw.children[1]!
  }
  public var garbageBetweenDeclBaseNameAndDeclNameArguments: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var declNameArguments: RawDeclNameArgumentsSyntax? {
    raw.children[3].map(RawDeclNameArgumentsSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawImplementsAttributeArgumentsSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeType: RawGarbageNodesSyntax? = nil,
    type: RawSimpleTypeIdentifierSyntax,
    _ garbageBetweenTypeAndComma: RawGarbageNodesSyntax? = nil,
    comma: RawTokenSyntax,
    _ garbageBetweenCommaAndDeclBaseName: RawGarbageNodesSyntax? = nil,
    declBaseName: RawSyntax,
    _ garbageBetweenDeclBaseNameAndDeclNameArguments: RawGarbageNodesSyntax? = nil,
    declNameArguments: RawDeclNameArgumentsSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .implementsAttributeArguments, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeType?.raw
      layout[1] = type.raw
      layout[2] = garbageBetweenTypeAndComma?.raw
      layout[3] = comma.raw
      layout[4] = garbageBetweenCommaAndDeclBaseName?.raw
      layout[5] = declBaseName.raw
      layout[6] = garbageBetweenDeclBaseNameAndDeclNameArguments?.raw
      layout[7] = declNameArguments?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeType: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var type: RawSimpleTypeIdentifierSyntax {
    raw.children[1].map(RawSimpleTypeIdentifierSyntax.init(raw:))!
  }
  public var garbageBetweenTypeAndComma: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var comma: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenCommaAndDeclBaseName: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var declBaseName: RawSyntax {
    raw.children[5]!
  }
  public var garbageBetweenDeclBaseNameAndDeclNameArguments: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var declNameArguments: RawDeclNameArgumentsSyntax? {
    raw.children[7].map(RawDeclNameArgumentsSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawObjCSelectorPieceSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeName: RawGarbageNodesSyntax? = nil,
    name: RawTokenSyntax?,
    _ garbageBetweenNameAndColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .objCSelectorPiece, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeName?.raw
      layout[1] = name?.raw
      layout[2] = garbageBetweenNameAndColon?.raw
      layout[3] = colon?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeName: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax? {
    raw.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenNameAndColon: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawObjCSelectorSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawObjCSelectorPieceSyntax {
    let raw = RawSyntax.makeLayout(kind: .objCSelector, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawObjCSelectorPieceSyntax] {
    raw.children.map { RawObjCSelectorPieceSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawDifferentiableAttributeArgumentsSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeDiffKind: RawGarbageNodesSyntax? = nil,
    diffKind: RawTokenSyntax?,
    _ garbageBetweenDiffKindAndDiffKindComma: RawGarbageNodesSyntax? = nil,
    diffKindComma: RawTokenSyntax?,
    _ garbageBetweenDiffKindCommaAndDiffParams: RawGarbageNodesSyntax? = nil,
    diffParams: RawDifferentiabilityParamsClauseSyntax?,
    _ garbageBetweenDiffParamsAndDiffParamsComma: RawGarbageNodesSyntax? = nil,
    diffParamsComma: RawTokenSyntax?,
    _ garbageBetweenDiffParamsCommaAndWhereClause: RawGarbageNodesSyntax? = nil,
    whereClause: RawGenericWhereClauseSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .differentiableAttributeArguments, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeDiffKind?.raw
      layout[1] = diffKind?.raw
      layout[2] = garbageBetweenDiffKindAndDiffKindComma?.raw
      layout[3] = diffKindComma?.raw
      layout[4] = garbageBetweenDiffKindCommaAndDiffParams?.raw
      layout[5] = diffParams?.raw
      layout[6] = garbageBetweenDiffParamsAndDiffParamsComma?.raw
      layout[7] = diffParamsComma?.raw
      layout[8] = garbageBetweenDiffParamsCommaAndWhereClause?.raw
      layout[9] = whereClause?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeDiffKind: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var diffKind: RawTokenSyntax? {
    raw.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenDiffKindAndDiffKindComma: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var diffKindComma: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenDiffKindCommaAndDiffParams: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var diffParams: RawDifferentiabilityParamsClauseSyntax? {
    raw.children[5].map(RawDifferentiabilityParamsClauseSyntax.init(raw:))
  }
  public var garbageBetweenDiffParamsAndDiffParamsComma: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var diffParamsComma: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenDiffParamsCommaAndWhereClause: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var whereClause: RawGenericWhereClauseSyntax? {
    raw.children[9].map(RawGenericWhereClauseSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawDifferentiabilityParamsClauseSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeWrtLabel: RawGarbageNodesSyntax? = nil,
    wrtLabel: RawTokenSyntax,
    _ garbageBetweenWrtLabelAndColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ garbageBetweenColonAndParameters: RawGarbageNodesSyntax? = nil,
    parameters: RawSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .differentiabilityParamsClause, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeWrtLabel?.raw
      layout[1] = wrtLabel.raw
      layout[2] = garbageBetweenWrtLabelAndColon?.raw
      layout[3] = colon.raw
      layout[4] = garbageBetweenColonAndParameters?.raw
      layout[5] = parameters.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeWrtLabel: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var wrtLabel: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenWrtLabelAndColon: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenColonAndParameters: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var parameters: RawSyntax {
    raw.children[5]!
  }
}

@_spi(RawSyntax)
public struct RawDifferentiabilityParamsSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeLeftParen: RawGarbageNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ garbageBetweenLeftParenAndDiffParams: RawGarbageNodesSyntax? = nil,
    diffParams: RawDifferentiabilityParamListSyntax,
    _ garbageBetweenDiffParamsAndRightParen: RawGarbageNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .differentiabilityParams, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLeftParen?.raw
      layout[1] = leftParen.raw
      layout[2] = garbageBetweenLeftParenAndDiffParams?.raw
      layout[3] = diffParams.raw
      layout[4] = garbageBetweenDiffParamsAndRightParen?.raw
      layout[5] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLeftParen: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftParenAndDiffParams: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var diffParams: RawDifferentiabilityParamListSyntax {
    raw.children[3].map(RawDifferentiabilityParamListSyntax.init(raw:))!
  }
  public var garbageBetweenDiffParamsAndRightParen: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawDifferentiabilityParamListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawDifferentiabilityParamSyntax {
    let raw = RawSyntax.makeLayout(kind: .differentiabilityParamList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawDifferentiabilityParamSyntax] {
    raw.children.map { RawDifferentiabilityParamSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawDifferentiabilityParamSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeParameter: RawGarbageNodesSyntax? = nil,
    parameter: RawSyntax,
    _ garbageBetweenParameterAndTrailingComma: RawGarbageNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .differentiabilityParam, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeParameter?.raw
      layout[1] = parameter.raw
      layout[2] = garbageBetweenParameterAndTrailingComma?.raw
      layout[3] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeParameter: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var parameter: RawSyntax {
    raw.children[1]!
  }
  public var garbageBetweenParameterAndTrailingComma: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawDerivativeRegistrationAttributeArgumentsSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeOfLabel: RawGarbageNodesSyntax? = nil,
    ofLabel: RawTokenSyntax,
    _ garbageBetweenOfLabelAndColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ garbageBetweenColonAndOriginalDeclName: RawGarbageNodesSyntax? = nil,
    originalDeclName: RawQualifiedDeclNameSyntax,
    _ garbageBetweenOriginalDeclNameAndPeriod: RawGarbageNodesSyntax? = nil,
    period: RawTokenSyntax?,
    _ garbageBetweenPeriodAndAccessorKind: RawGarbageNodesSyntax? = nil,
    accessorKind: RawTokenSyntax?,
    _ garbageBetweenAccessorKindAndComma: RawGarbageNodesSyntax? = nil,
    comma: RawTokenSyntax?,
    _ garbageBetweenCommaAndDiffParams: RawGarbageNodesSyntax? = nil,
    diffParams: RawDifferentiabilityParamsClauseSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .derivativeRegistrationAttributeArguments, uninitializedCount: 14, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeOfLabel?.raw
      layout[1] = ofLabel.raw
      layout[2] = garbageBetweenOfLabelAndColon?.raw
      layout[3] = colon.raw
      layout[4] = garbageBetweenColonAndOriginalDeclName?.raw
      layout[5] = originalDeclName.raw
      layout[6] = garbageBetweenOriginalDeclNameAndPeriod?.raw
      layout[7] = period?.raw
      layout[8] = garbageBetweenPeriodAndAccessorKind?.raw
      layout[9] = accessorKind?.raw
      layout[10] = garbageBetweenAccessorKindAndComma?.raw
      layout[11] = comma?.raw
      layout[12] = garbageBetweenCommaAndDiffParams?.raw
      layout[13] = diffParams?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeOfLabel: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var ofLabel: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenOfLabelAndColon: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenColonAndOriginalDeclName: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var originalDeclName: RawQualifiedDeclNameSyntax {
    raw.children[5].map(RawQualifiedDeclNameSyntax.init(raw:))!
  }
  public var garbageBetweenOriginalDeclNameAndPeriod: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var period: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenPeriodAndAccessorKind: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var accessorKind: RawTokenSyntax? {
    raw.children[9].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenAccessorKindAndComma: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var comma: RawTokenSyntax? {
    raw.children[11].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenCommaAndDiffParams: RawGarbageNodesSyntax? {
    raw.children[12].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var diffParams: RawDifferentiabilityParamsClauseSyntax? {
    raw.children[13].map(RawDifferentiabilityParamsClauseSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawQualifiedDeclNameSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeBaseType: RawGarbageNodesSyntax? = nil,
    baseType: RawTypeSyntax?,
    _ garbageBetweenBaseTypeAndDot: RawGarbageNodesSyntax? = nil,
    dot: RawTokenSyntax?,
    _ garbageBetweenDotAndName: RawGarbageNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ garbageBetweenNameAndArguments: RawGarbageNodesSyntax? = nil,
    arguments: RawDeclNameArgumentsSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .qualifiedDeclName, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeBaseType?.raw
      layout[1] = baseType?.raw
      layout[2] = garbageBetweenBaseTypeAndDot?.raw
      layout[3] = dot?.raw
      layout[4] = garbageBetweenDotAndName?.raw
      layout[5] = name.raw
      layout[6] = garbageBetweenNameAndArguments?.raw
      layout[7] = arguments?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeBaseType: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var baseType: RawTypeSyntax? {
    raw.children[1].map(RawTypeSyntax.init(raw:))
  }
  public var garbageBetweenBaseTypeAndDot: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var dot: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenDotAndName: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenNameAndArguments: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var arguments: RawDeclNameArgumentsSyntax? {
    raw.children[7].map(RawDeclNameArgumentsSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawFunctionDeclNameSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeName: RawGarbageNodesSyntax? = nil,
    name: RawSyntax,
    _ garbageBetweenNameAndArguments: RawGarbageNodesSyntax? = nil,
    arguments: RawDeclNameArgumentsSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .functionDeclName, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeName?.raw
      layout[1] = name.raw
      layout[2] = garbageBetweenNameAndArguments?.raw
      layout[3] = arguments?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeName: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var name: RawSyntax {
    raw.children[1]!
  }
  public var garbageBetweenNameAndArguments: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var arguments: RawDeclNameArgumentsSyntax? {
    raw.children[3].map(RawDeclNameArgumentsSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawBackDeployAttributeSpecListSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeBeforeLabel: RawGarbageNodesSyntax? = nil,
    beforeLabel: RawTokenSyntax,
    _ garbageBetweenBeforeLabelAndColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ garbageBetweenColonAndVersionList: RawGarbageNodesSyntax? = nil,
    versionList: RawBackDeployVersionListSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .backDeployAttributeSpecList, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeBeforeLabel?.raw
      layout[1] = beforeLabel.raw
      layout[2] = garbageBetweenBeforeLabelAndColon?.raw
      layout[3] = colon.raw
      layout[4] = garbageBetweenColonAndVersionList?.raw
      layout[5] = versionList.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeBeforeLabel: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var beforeLabel: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenBeforeLabelAndColon: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenColonAndVersionList: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var versionList: RawBackDeployVersionListSyntax {
    raw.children[5].map(RawBackDeployVersionListSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawBackDeployVersionListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawBackDeployVersionArgumentSyntax {
    let raw = RawSyntax.makeLayout(kind: .backDeployVersionList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawBackDeployVersionArgumentSyntax] {
    raw.children.map { RawBackDeployVersionArgumentSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawBackDeployVersionArgumentSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeAvailabilityVersionRestriction: RawGarbageNodesSyntax? = nil,
    availabilityVersionRestriction: RawAvailabilityVersionRestrictionSyntax,
    _ garbageBetweenAvailabilityVersionRestrictionAndTrailingComma: RawGarbageNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .backDeployVersionArgument, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAvailabilityVersionRestriction?.raw
      layout[1] = availabilityVersionRestriction.raw
      layout[2] = garbageBetweenAvailabilityVersionRestrictionAndTrailingComma?.raw
      layout[3] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAvailabilityVersionRestriction: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var availabilityVersionRestriction: RawAvailabilityVersionRestrictionSyntax {
    raw.children[1].map(RawAvailabilityVersionRestrictionSyntax.init(raw:))!
  }
  public var garbageBetweenAvailabilityVersionRestrictionAndTrailingComma: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawLabeledStmtSyntax: RawStmtSyntaxNodeProtocol {
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
    _ garbageBeforeLabelName: RawGarbageNodesSyntax? = nil,
    labelName: RawTokenSyntax,
    _ garbageBetweenLabelNameAndLabelColon: RawGarbageNodesSyntax? = nil,
    labelColon: RawTokenSyntax,
    _ garbageBetweenLabelColonAndStatement: RawGarbageNodesSyntax? = nil,
    statement: RawStmtSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .labeledStmt, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLabelName?.raw
      layout[1] = labelName.raw
      layout[2] = garbageBetweenLabelNameAndLabelColon?.raw
      layout[3] = labelColon.raw
      layout[4] = garbageBetweenLabelColonAndStatement?.raw
      layout[5] = statement.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLabelName: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var labelName: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLabelNameAndLabelColon: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var labelColon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLabelColonAndStatement: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var statement: RawStmtSyntax {
    raw.children[5].map(RawStmtSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawContinueStmtSyntax: RawStmtSyntaxNodeProtocol {
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
    _ garbageBeforeContinueKeyword: RawGarbageNodesSyntax? = nil,
    continueKeyword: RawTokenSyntax,
    _ garbageBetweenContinueKeywordAndLabel: RawGarbageNodesSyntax? = nil,
    label: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .continueStmt, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeContinueKeyword?.raw
      layout[1] = continueKeyword.raw
      layout[2] = garbageBetweenContinueKeywordAndLabel?.raw
      layout[3] = label?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeContinueKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var continueKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenContinueKeywordAndLabel: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var label: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawWhileStmtSyntax: RawStmtSyntaxNodeProtocol {
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
    _ garbageBeforeWhileKeyword: RawGarbageNodesSyntax? = nil,
    whileKeyword: RawTokenSyntax,
    _ garbageBetweenWhileKeywordAndConditions: RawGarbageNodesSyntax? = nil,
    conditions: RawConditionElementListSyntax,
    _ garbageBetweenConditionsAndBody: RawGarbageNodesSyntax? = nil,
    body: RawCodeBlockSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .whileStmt, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeWhileKeyword?.raw
      layout[1] = whileKeyword.raw
      layout[2] = garbageBetweenWhileKeywordAndConditions?.raw
      layout[3] = conditions.raw
      layout[4] = garbageBetweenConditionsAndBody?.raw
      layout[5] = body.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeWhileKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var whileKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenWhileKeywordAndConditions: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var conditions: RawConditionElementListSyntax {
    raw.children[3].map(RawConditionElementListSyntax.init(raw:))!
  }
  public var garbageBetweenConditionsAndBody: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax {
    raw.children[5].map(RawCodeBlockSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawDeferStmtSyntax: RawStmtSyntaxNodeProtocol {
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
    _ garbageBeforeDeferKeyword: RawGarbageNodesSyntax? = nil,
    deferKeyword: RawTokenSyntax,
    _ garbageBetweenDeferKeywordAndBody: RawGarbageNodesSyntax? = nil,
    body: RawCodeBlockSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .deferStmt, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeDeferKeyword?.raw
      layout[1] = deferKeyword.raw
      layout[2] = garbageBetweenDeferKeywordAndBody?.raw
      layout[3] = body.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeDeferKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var deferKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenDeferKeywordAndBody: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax {
    raw.children[3].map(RawCodeBlockSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawExpressionStmtSyntax: RawStmtSyntaxNodeProtocol {
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
    _ garbageBeforeExpression: RawGarbageNodesSyntax? = nil,
    expression: RawExprSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .expressionStmt, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeExpression?.raw
      layout[1] = expression.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeExpression: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    raw.children[1].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawSwitchCaseListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawSyntax {
    let raw = RawSyntax.makeLayout(kind: .switchCaseList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawSyntax] {
    raw.children.map { RawSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawRepeatWhileStmtSyntax: RawStmtSyntaxNodeProtocol {
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
    _ garbageBeforeRepeatKeyword: RawGarbageNodesSyntax? = nil,
    repeatKeyword: RawTokenSyntax,
    _ garbageBetweenRepeatKeywordAndBody: RawGarbageNodesSyntax? = nil,
    body: RawCodeBlockSyntax,
    _ garbageBetweenBodyAndWhileKeyword: RawGarbageNodesSyntax? = nil,
    whileKeyword: RawTokenSyntax,
    _ garbageBetweenWhileKeywordAndCondition: RawGarbageNodesSyntax? = nil,
    condition: RawExprSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .repeatWhileStmt, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeRepeatKeyword?.raw
      layout[1] = repeatKeyword.raw
      layout[2] = garbageBetweenRepeatKeywordAndBody?.raw
      layout[3] = body.raw
      layout[4] = garbageBetweenBodyAndWhileKeyword?.raw
      layout[5] = whileKeyword.raw
      layout[6] = garbageBetweenWhileKeywordAndCondition?.raw
      layout[7] = condition.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeRepeatKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var repeatKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenRepeatKeywordAndBody: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax {
    raw.children[3].map(RawCodeBlockSyntax.init(raw:))!
  }
  public var garbageBetweenBodyAndWhileKeyword: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var whileKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenWhileKeywordAndCondition: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var condition: RawExprSyntax {
    raw.children[7].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawGuardStmtSyntax: RawStmtSyntaxNodeProtocol {
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
    _ garbageBeforeGuardKeyword: RawGarbageNodesSyntax? = nil,
    guardKeyword: RawTokenSyntax,
    _ garbageBetweenGuardKeywordAndConditions: RawGarbageNodesSyntax? = nil,
    conditions: RawConditionElementListSyntax,
    _ garbageBetweenConditionsAndElseKeyword: RawGarbageNodesSyntax? = nil,
    elseKeyword: RawTokenSyntax,
    _ garbageBetweenElseKeywordAndBody: RawGarbageNodesSyntax? = nil,
    body: RawCodeBlockSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .guardStmt, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeGuardKeyword?.raw
      layout[1] = guardKeyword.raw
      layout[2] = garbageBetweenGuardKeywordAndConditions?.raw
      layout[3] = conditions.raw
      layout[4] = garbageBetweenConditionsAndElseKeyword?.raw
      layout[5] = elseKeyword.raw
      layout[6] = garbageBetweenElseKeywordAndBody?.raw
      layout[7] = body.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeGuardKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var guardKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenGuardKeywordAndConditions: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var conditions: RawConditionElementListSyntax {
    raw.children[3].map(RawConditionElementListSyntax.init(raw:))!
  }
  public var garbageBetweenConditionsAndElseKeyword: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var elseKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenElseKeywordAndBody: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax {
    raw.children[7].map(RawCodeBlockSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawWhereClauseSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeWhereKeyword: RawGarbageNodesSyntax? = nil,
    whereKeyword: RawTokenSyntax,
    _ garbageBetweenWhereKeywordAndGuardResult: RawGarbageNodesSyntax? = nil,
    guardResult: RawExprSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .whereClause, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeWhereKeyword?.raw
      layout[1] = whereKeyword.raw
      layout[2] = garbageBetweenWhereKeywordAndGuardResult?.raw
      layout[3] = guardResult.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeWhereKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var whereKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenWhereKeywordAndGuardResult: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var guardResult: RawExprSyntax {
    raw.children[3].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawForInStmtSyntax: RawStmtSyntaxNodeProtocol {
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
    _ garbageBeforeForKeyword: RawGarbageNodesSyntax? = nil,
    forKeyword: RawTokenSyntax,
    _ garbageBetweenForKeywordAndTryKeyword: RawGarbageNodesSyntax? = nil,
    tryKeyword: RawTokenSyntax?,
    _ garbageBetweenTryKeywordAndAwaitKeyword: RawGarbageNodesSyntax? = nil,
    awaitKeyword: RawTokenSyntax?,
    _ garbageBetweenAwaitKeywordAndCaseKeyword: RawGarbageNodesSyntax? = nil,
    caseKeyword: RawTokenSyntax?,
    _ garbageBetweenCaseKeywordAndPattern: RawGarbageNodesSyntax? = nil,
    pattern: RawPatternSyntax,
    _ garbageBetweenPatternAndTypeAnnotation: RawGarbageNodesSyntax? = nil,
    typeAnnotation: RawTypeAnnotationSyntax?,
    _ garbageBetweenTypeAnnotationAndInKeyword: RawGarbageNodesSyntax? = nil,
    inKeyword: RawTokenSyntax,
    _ garbageBetweenInKeywordAndSequenceExpr: RawGarbageNodesSyntax? = nil,
    sequenceExpr: RawExprSyntax,
    _ garbageBetweenSequenceExprAndWhereClause: RawGarbageNodesSyntax? = nil,
    whereClause: RawWhereClauseSyntax?,
    _ garbageBetweenWhereClauseAndBody: RawGarbageNodesSyntax? = nil,
    body: RawCodeBlockSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .forInStmt, uninitializedCount: 20, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeForKeyword?.raw
      layout[1] = forKeyword.raw
      layout[2] = garbageBetweenForKeywordAndTryKeyword?.raw
      layout[3] = tryKeyword?.raw
      layout[4] = garbageBetweenTryKeywordAndAwaitKeyword?.raw
      layout[5] = awaitKeyword?.raw
      layout[6] = garbageBetweenAwaitKeywordAndCaseKeyword?.raw
      layout[7] = caseKeyword?.raw
      layout[8] = garbageBetweenCaseKeywordAndPattern?.raw
      layout[9] = pattern.raw
      layout[10] = garbageBetweenPatternAndTypeAnnotation?.raw
      layout[11] = typeAnnotation?.raw
      layout[12] = garbageBetweenTypeAnnotationAndInKeyword?.raw
      layout[13] = inKeyword.raw
      layout[14] = garbageBetweenInKeywordAndSequenceExpr?.raw
      layout[15] = sequenceExpr.raw
      layout[16] = garbageBetweenSequenceExprAndWhereClause?.raw
      layout[17] = whereClause?.raw
      layout[18] = garbageBetweenWhereClauseAndBody?.raw
      layout[19] = body.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeForKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var forKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenForKeywordAndTryKeyword: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var tryKeyword: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenTryKeywordAndAwaitKeyword: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var awaitKeyword: RawTokenSyntax? {
    raw.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenAwaitKeywordAndCaseKeyword: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var caseKeyword: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenCaseKeywordAndPattern: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax {
    raw.children[9].map(RawPatternSyntax.init(raw:))!
  }
  public var garbageBetweenPatternAndTypeAnnotation: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var typeAnnotation: RawTypeAnnotationSyntax? {
    raw.children[11].map(RawTypeAnnotationSyntax.init(raw:))
  }
  public var garbageBetweenTypeAnnotationAndInKeyword: RawGarbageNodesSyntax? {
    raw.children[12].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var inKeyword: RawTokenSyntax {
    raw.children[13].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenInKeywordAndSequenceExpr: RawGarbageNodesSyntax? {
    raw.children[14].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var sequenceExpr: RawExprSyntax {
    raw.children[15].map(RawExprSyntax.init(raw:))!
  }
  public var garbageBetweenSequenceExprAndWhereClause: RawGarbageNodesSyntax? {
    raw.children[16].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var whereClause: RawWhereClauseSyntax? {
    raw.children[17].map(RawWhereClauseSyntax.init(raw:))
  }
  public var garbageBetweenWhereClauseAndBody: RawGarbageNodesSyntax? {
    raw.children[18].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax {
    raw.children[19].map(RawCodeBlockSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawSwitchStmtSyntax: RawStmtSyntaxNodeProtocol {
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
    _ garbageBeforeSwitchKeyword: RawGarbageNodesSyntax? = nil,
    switchKeyword: RawTokenSyntax,
    _ garbageBetweenSwitchKeywordAndExpression: RawGarbageNodesSyntax? = nil,
    expression: RawExprSyntax,
    _ garbageBetweenExpressionAndLeftBrace: RawGarbageNodesSyntax? = nil,
    leftBrace: RawTokenSyntax,
    _ garbageBetweenLeftBraceAndCases: RawGarbageNodesSyntax? = nil,
    cases: RawSwitchCaseListSyntax,
    _ garbageBetweenCasesAndRightBrace: RawGarbageNodesSyntax? = nil,
    rightBrace: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .switchStmt, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeSwitchKeyword?.raw
      layout[1] = switchKeyword.raw
      layout[2] = garbageBetweenSwitchKeywordAndExpression?.raw
      layout[3] = expression.raw
      layout[4] = garbageBetweenExpressionAndLeftBrace?.raw
      layout[5] = leftBrace.raw
      layout[6] = garbageBetweenLeftBraceAndCases?.raw
      layout[7] = cases.raw
      layout[8] = garbageBetweenCasesAndRightBrace?.raw
      layout[9] = rightBrace.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeSwitchKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var switchKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenSwitchKeywordAndExpression: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    raw.children[3].map(RawExprSyntax.init(raw:))!
  }
  public var garbageBetweenExpressionAndLeftBrace: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftBrace: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftBraceAndCases: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var cases: RawSwitchCaseListSyntax {
    raw.children[7].map(RawSwitchCaseListSyntax.init(raw:))!
  }
  public var garbageBetweenCasesAndRightBrace: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightBrace: RawTokenSyntax {
    raw.children[9].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawCatchClauseListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawCatchClauseSyntax {
    let raw = RawSyntax.makeLayout(kind: .catchClauseList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawCatchClauseSyntax] {
    raw.children.map { RawCatchClauseSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawDoStmtSyntax: RawStmtSyntaxNodeProtocol {
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
    _ garbageBeforeDoKeyword: RawGarbageNodesSyntax? = nil,
    doKeyword: RawTokenSyntax,
    _ garbageBetweenDoKeywordAndBody: RawGarbageNodesSyntax? = nil,
    body: RawCodeBlockSyntax,
    _ garbageBetweenBodyAndCatchClauses: RawGarbageNodesSyntax? = nil,
    catchClauses: RawCatchClauseListSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .doStmt, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeDoKeyword?.raw
      layout[1] = doKeyword.raw
      layout[2] = garbageBetweenDoKeywordAndBody?.raw
      layout[3] = body.raw
      layout[4] = garbageBetweenBodyAndCatchClauses?.raw
      layout[5] = catchClauses?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeDoKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var doKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenDoKeywordAndBody: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax {
    raw.children[3].map(RawCodeBlockSyntax.init(raw:))!
  }
  public var garbageBetweenBodyAndCatchClauses: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var catchClauses: RawCatchClauseListSyntax? {
    raw.children[5].map(RawCatchClauseListSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawReturnStmtSyntax: RawStmtSyntaxNodeProtocol {
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
    _ garbageBeforeReturnKeyword: RawGarbageNodesSyntax? = nil,
    returnKeyword: RawTokenSyntax,
    _ garbageBetweenReturnKeywordAndExpression: RawGarbageNodesSyntax? = nil,
    expression: RawExprSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .returnStmt, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeReturnKeyword?.raw
      layout[1] = returnKeyword.raw
      layout[2] = garbageBetweenReturnKeywordAndExpression?.raw
      layout[3] = expression?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeReturnKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var returnKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenReturnKeywordAndExpression: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax? {
    raw.children[3].map(RawExprSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawYieldStmtSyntax: RawStmtSyntaxNodeProtocol {
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
    _ garbageBeforeYieldKeyword: RawGarbageNodesSyntax? = nil,
    yieldKeyword: RawTokenSyntax,
    _ garbageBetweenYieldKeywordAndYields: RawGarbageNodesSyntax? = nil,
    yields: RawSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .yieldStmt, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeYieldKeyword?.raw
      layout[1] = yieldKeyword.raw
      layout[2] = garbageBetweenYieldKeywordAndYields?.raw
      layout[3] = yields.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeYieldKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var yieldKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenYieldKeywordAndYields: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var yields: RawSyntax {
    raw.children[3]!
  }
}

@_spi(RawSyntax)
public struct RawYieldListSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeLeftParen: RawGarbageNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ garbageBetweenLeftParenAndElementList: RawGarbageNodesSyntax? = nil,
    elementList: RawExprListSyntax,
    _ garbageBetweenElementListAndTrailingComma: RawGarbageNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    _ garbageBetweenTrailingCommaAndRightParen: RawGarbageNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .yieldList, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLeftParen?.raw
      layout[1] = leftParen.raw
      layout[2] = garbageBetweenLeftParenAndElementList?.raw
      layout[3] = elementList.raw
      layout[4] = garbageBetweenElementListAndTrailingComma?.raw
      layout[5] = trailingComma?.raw
      layout[6] = garbageBetweenTrailingCommaAndRightParen?.raw
      layout[7] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLeftParen: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftParenAndElementList: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var elementList: RawExprListSyntax {
    raw.children[3].map(RawExprListSyntax.init(raw:))!
  }
  public var garbageBetweenElementListAndTrailingComma: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenTrailingCommaAndRightParen: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawFallthroughStmtSyntax: RawStmtSyntaxNodeProtocol {
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
    _ garbageBeforeFallthroughKeyword: RawGarbageNodesSyntax? = nil,
    fallthroughKeyword: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .fallthroughStmt, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeFallthroughKeyword?.raw
      layout[1] = fallthroughKeyword.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeFallthroughKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var fallthroughKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawBreakStmtSyntax: RawStmtSyntaxNodeProtocol {
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
    _ garbageBeforeBreakKeyword: RawGarbageNodesSyntax? = nil,
    breakKeyword: RawTokenSyntax,
    _ garbageBetweenBreakKeywordAndLabel: RawGarbageNodesSyntax? = nil,
    label: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .breakStmt, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeBreakKeyword?.raw
      layout[1] = breakKeyword.raw
      layout[2] = garbageBetweenBreakKeywordAndLabel?.raw
      layout[3] = label?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeBreakKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var breakKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenBreakKeywordAndLabel: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var label: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawCaseItemListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawCaseItemSyntax {
    let raw = RawSyntax.makeLayout(kind: .caseItemList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawCaseItemSyntax] {
    raw.children.map { RawCaseItemSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawCatchItemListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawCatchItemSyntax {
    let raw = RawSyntax.makeLayout(kind: .catchItemList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawCatchItemSyntax] {
    raw.children.map { RawCatchItemSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawConditionElementSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeCondition: RawGarbageNodesSyntax? = nil,
    condition: RawSyntax,
    _ garbageBetweenConditionAndTrailingComma: RawGarbageNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .conditionElement, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeCondition?.raw
      layout[1] = condition.raw
      layout[2] = garbageBetweenConditionAndTrailingComma?.raw
      layout[3] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeCondition: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var condition: RawSyntax {
    raw.children[1]!
  }
  public var garbageBetweenConditionAndTrailingComma: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawAvailabilityConditionSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforePoundAvailableKeyword: RawGarbageNodesSyntax? = nil,
    poundAvailableKeyword: RawTokenSyntax,
    _ garbageBetweenPoundAvailableKeywordAndLeftParen: RawGarbageNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ garbageBetweenLeftParenAndAvailabilitySpec: RawGarbageNodesSyntax? = nil,
    availabilitySpec: RawAvailabilitySpecListSyntax,
    _ garbageBetweenAvailabilitySpecAndRightParen: RawGarbageNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .availabilityCondition, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforePoundAvailableKeyword?.raw
      layout[1] = poundAvailableKeyword.raw
      layout[2] = garbageBetweenPoundAvailableKeywordAndLeftParen?.raw
      layout[3] = leftParen.raw
      layout[4] = garbageBetweenLeftParenAndAvailabilitySpec?.raw
      layout[5] = availabilitySpec.raw
      layout[6] = garbageBetweenAvailabilitySpecAndRightParen?.raw
      layout[7] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforePoundAvailableKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var poundAvailableKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenPoundAvailableKeywordAndLeftParen: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftParenAndAvailabilitySpec: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var availabilitySpec: RawAvailabilitySpecListSyntax {
    raw.children[5].map(RawAvailabilitySpecListSyntax.init(raw:))!
  }
  public var garbageBetweenAvailabilitySpecAndRightParen: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawMatchingPatternConditionSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeCaseKeyword: RawGarbageNodesSyntax? = nil,
    caseKeyword: RawTokenSyntax,
    _ garbageBetweenCaseKeywordAndPattern: RawGarbageNodesSyntax? = nil,
    pattern: RawPatternSyntax,
    _ garbageBetweenPatternAndTypeAnnotation: RawGarbageNodesSyntax? = nil,
    typeAnnotation: RawTypeAnnotationSyntax?,
    _ garbageBetweenTypeAnnotationAndInitializer: RawGarbageNodesSyntax? = nil,
    initializer: RawInitializerClauseSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .matchingPatternCondition, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeCaseKeyword?.raw
      layout[1] = caseKeyword.raw
      layout[2] = garbageBetweenCaseKeywordAndPattern?.raw
      layout[3] = pattern.raw
      layout[4] = garbageBetweenPatternAndTypeAnnotation?.raw
      layout[5] = typeAnnotation?.raw
      layout[6] = garbageBetweenTypeAnnotationAndInitializer?.raw
      layout[7] = initializer.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeCaseKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var caseKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenCaseKeywordAndPattern: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax {
    raw.children[3].map(RawPatternSyntax.init(raw:))!
  }
  public var garbageBetweenPatternAndTypeAnnotation: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var typeAnnotation: RawTypeAnnotationSyntax? {
    raw.children[5].map(RawTypeAnnotationSyntax.init(raw:))
  }
  public var garbageBetweenTypeAnnotationAndInitializer: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var initializer: RawInitializerClauseSyntax {
    raw.children[7].map(RawInitializerClauseSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawOptionalBindingConditionSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeLetOrVarKeyword: RawGarbageNodesSyntax? = nil,
    letOrVarKeyword: RawTokenSyntax,
    _ garbageBetweenLetOrVarKeywordAndPattern: RawGarbageNodesSyntax? = nil,
    pattern: RawPatternSyntax,
    _ garbageBetweenPatternAndTypeAnnotation: RawGarbageNodesSyntax? = nil,
    typeAnnotation: RawTypeAnnotationSyntax?,
    _ garbageBetweenTypeAnnotationAndInitializer: RawGarbageNodesSyntax? = nil,
    initializer: RawInitializerClauseSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .optionalBindingCondition, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLetOrVarKeyword?.raw
      layout[1] = letOrVarKeyword.raw
      layout[2] = garbageBetweenLetOrVarKeywordAndPattern?.raw
      layout[3] = pattern.raw
      layout[4] = garbageBetweenPatternAndTypeAnnotation?.raw
      layout[5] = typeAnnotation?.raw
      layout[6] = garbageBetweenTypeAnnotationAndInitializer?.raw
      layout[7] = initializer?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLetOrVarKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var letOrVarKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLetOrVarKeywordAndPattern: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax {
    raw.children[3].map(RawPatternSyntax.init(raw:))!
  }
  public var garbageBetweenPatternAndTypeAnnotation: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var typeAnnotation: RawTypeAnnotationSyntax? {
    raw.children[5].map(RawTypeAnnotationSyntax.init(raw:))
  }
  public var garbageBetweenTypeAnnotationAndInitializer: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var initializer: RawInitializerClauseSyntax? {
    raw.children[7].map(RawInitializerClauseSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawUnavailabilityConditionSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforePoundUnavailableKeyword: RawGarbageNodesSyntax? = nil,
    poundUnavailableKeyword: RawTokenSyntax,
    _ garbageBetweenPoundUnavailableKeywordAndLeftParen: RawGarbageNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ garbageBetweenLeftParenAndAvailabilitySpec: RawGarbageNodesSyntax? = nil,
    availabilitySpec: RawAvailabilitySpecListSyntax,
    _ garbageBetweenAvailabilitySpecAndRightParen: RawGarbageNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .unavailabilityCondition, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforePoundUnavailableKeyword?.raw
      layout[1] = poundUnavailableKeyword.raw
      layout[2] = garbageBetweenPoundUnavailableKeywordAndLeftParen?.raw
      layout[3] = leftParen.raw
      layout[4] = garbageBetweenLeftParenAndAvailabilitySpec?.raw
      layout[5] = availabilitySpec.raw
      layout[6] = garbageBetweenAvailabilitySpecAndRightParen?.raw
      layout[7] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforePoundUnavailableKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var poundUnavailableKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenPoundUnavailableKeywordAndLeftParen: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftParenAndAvailabilitySpec: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var availabilitySpec: RawAvailabilitySpecListSyntax {
    raw.children[5].map(RawAvailabilitySpecListSyntax.init(raw:))!
  }
  public var garbageBetweenAvailabilitySpecAndRightParen: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawConditionElementListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawConditionElementSyntax {
    let raw = RawSyntax.makeLayout(kind: .conditionElementList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawConditionElementSyntax] {
    raw.children.map { RawConditionElementSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawDeclarationStmtSyntax: RawStmtSyntaxNodeProtocol {
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
    _ garbageBeforeDeclaration: RawGarbageNodesSyntax? = nil,
    declaration: RawDeclSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .declarationStmt, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeDeclaration?.raw
      layout[1] = declaration.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeDeclaration: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var declaration: RawDeclSyntax {
    raw.children[1].map(RawDeclSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawThrowStmtSyntax: RawStmtSyntaxNodeProtocol {
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
    _ garbageBeforeThrowKeyword: RawGarbageNodesSyntax? = nil,
    throwKeyword: RawTokenSyntax,
    _ garbageBetweenThrowKeywordAndExpression: RawGarbageNodesSyntax? = nil,
    expression: RawExprSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .throwStmt, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeThrowKeyword?.raw
      layout[1] = throwKeyword.raw
      layout[2] = garbageBetweenThrowKeywordAndExpression?.raw
      layout[3] = expression.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeThrowKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var throwKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenThrowKeywordAndExpression: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    raw.children[3].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawIfStmtSyntax: RawStmtSyntaxNodeProtocol {
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
    _ garbageBeforeIfKeyword: RawGarbageNodesSyntax? = nil,
    ifKeyword: RawTokenSyntax,
    _ garbageBetweenIfKeywordAndConditions: RawGarbageNodesSyntax? = nil,
    conditions: RawConditionElementListSyntax,
    _ garbageBetweenConditionsAndBody: RawGarbageNodesSyntax? = nil,
    body: RawCodeBlockSyntax,
    _ garbageBetweenBodyAndElseKeyword: RawGarbageNodesSyntax? = nil,
    elseKeyword: RawTokenSyntax?,
    _ garbageBetweenElseKeywordAndElseBody: RawGarbageNodesSyntax? = nil,
    elseBody: RawSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .ifStmt, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeIfKeyword?.raw
      layout[1] = ifKeyword.raw
      layout[2] = garbageBetweenIfKeywordAndConditions?.raw
      layout[3] = conditions.raw
      layout[4] = garbageBetweenConditionsAndBody?.raw
      layout[5] = body.raw
      layout[6] = garbageBetweenBodyAndElseKeyword?.raw
      layout[7] = elseKeyword?.raw
      layout[8] = garbageBetweenElseKeywordAndElseBody?.raw
      layout[9] = elseBody?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeIfKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var ifKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenIfKeywordAndConditions: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var conditions: RawConditionElementListSyntax {
    raw.children[3].map(RawConditionElementListSyntax.init(raw:))!
  }
  public var garbageBetweenConditionsAndBody: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax {
    raw.children[5].map(RawCodeBlockSyntax.init(raw:))!
  }
  public var garbageBetweenBodyAndElseKeyword: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var elseKeyword: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenElseKeywordAndElseBody: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var elseBody: RawSyntax? {
    raw.children[9]
  }
}

@_spi(RawSyntax)
public struct RawElseIfContinuationSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeIfStatement: RawGarbageNodesSyntax? = nil,
    ifStatement: RawIfStmtSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .elseIfContinuation, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeIfStatement?.raw
      layout[1] = ifStatement.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeIfStatement: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var ifStatement: RawIfStmtSyntax {
    raw.children[1].map(RawIfStmtSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawElseBlockSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeElseKeyword: RawGarbageNodesSyntax? = nil,
    elseKeyword: RawTokenSyntax,
    _ garbageBetweenElseKeywordAndBody: RawGarbageNodesSyntax? = nil,
    body: RawCodeBlockSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .elseBlock, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeElseKeyword?.raw
      layout[1] = elseKeyword.raw
      layout[2] = garbageBetweenElseKeywordAndBody?.raw
      layout[3] = body.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeElseKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var elseKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenElseKeywordAndBody: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax {
    raw.children[3].map(RawCodeBlockSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawSwitchCaseSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeUnknownAttr: RawGarbageNodesSyntax? = nil,
    unknownAttr: RawAttributeSyntax?,
    _ garbageBetweenUnknownAttrAndLabel: RawGarbageNodesSyntax? = nil,
    label: RawSyntax,
    _ garbageBetweenLabelAndStatements: RawGarbageNodesSyntax? = nil,
    statements: RawCodeBlockItemListSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .switchCase, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeUnknownAttr?.raw
      layout[1] = unknownAttr?.raw
      layout[2] = garbageBetweenUnknownAttrAndLabel?.raw
      layout[3] = label.raw
      layout[4] = garbageBetweenLabelAndStatements?.raw
      layout[5] = statements.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeUnknownAttr: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var unknownAttr: RawAttributeSyntax? {
    raw.children[1].map(RawAttributeSyntax.init(raw:))
  }
  public var garbageBetweenUnknownAttrAndLabel: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var label: RawSyntax {
    raw.children[3]!
  }
  public var garbageBetweenLabelAndStatements: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var statements: RawCodeBlockItemListSyntax {
    raw.children[5].map(RawCodeBlockItemListSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawSwitchDefaultLabelSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeDefaultKeyword: RawGarbageNodesSyntax? = nil,
    defaultKeyword: RawTokenSyntax,
    _ garbageBetweenDefaultKeywordAndColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .switchDefaultLabel, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeDefaultKeyword?.raw
      layout[1] = defaultKeyword.raw
      layout[2] = garbageBetweenDefaultKeywordAndColon?.raw
      layout[3] = colon.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeDefaultKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var defaultKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenDefaultKeywordAndColon: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawCaseItemSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforePattern: RawGarbageNodesSyntax? = nil,
    pattern: RawPatternSyntax,
    _ garbageBetweenPatternAndWhereClause: RawGarbageNodesSyntax? = nil,
    whereClause: RawWhereClauseSyntax?,
    _ garbageBetweenWhereClauseAndTrailingComma: RawGarbageNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .caseItem, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforePattern?.raw
      layout[1] = pattern.raw
      layout[2] = garbageBetweenPatternAndWhereClause?.raw
      layout[3] = whereClause?.raw
      layout[4] = garbageBetweenWhereClauseAndTrailingComma?.raw
      layout[5] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforePattern: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax {
    raw.children[1].map(RawPatternSyntax.init(raw:))!
  }
  public var garbageBetweenPatternAndWhereClause: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var whereClause: RawWhereClauseSyntax? {
    raw.children[3].map(RawWhereClauseSyntax.init(raw:))
  }
  public var garbageBetweenWhereClauseAndTrailingComma: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[5].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawCatchItemSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforePattern: RawGarbageNodesSyntax? = nil,
    pattern: RawPatternSyntax?,
    _ garbageBetweenPatternAndWhereClause: RawGarbageNodesSyntax? = nil,
    whereClause: RawWhereClauseSyntax?,
    _ garbageBetweenWhereClauseAndTrailingComma: RawGarbageNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .catchItem, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforePattern?.raw
      layout[1] = pattern?.raw
      layout[2] = garbageBetweenPatternAndWhereClause?.raw
      layout[3] = whereClause?.raw
      layout[4] = garbageBetweenWhereClauseAndTrailingComma?.raw
      layout[5] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforePattern: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax? {
    raw.children[1].map(RawPatternSyntax.init(raw:))
  }
  public var garbageBetweenPatternAndWhereClause: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var whereClause: RawWhereClauseSyntax? {
    raw.children[3].map(RawWhereClauseSyntax.init(raw:))
  }
  public var garbageBetweenWhereClauseAndTrailingComma: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[5].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawSwitchCaseLabelSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeCaseKeyword: RawGarbageNodesSyntax? = nil,
    caseKeyword: RawTokenSyntax,
    _ garbageBetweenCaseKeywordAndCaseItems: RawGarbageNodesSyntax? = nil,
    caseItems: RawCaseItemListSyntax,
    _ garbageBetweenCaseItemsAndColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .switchCaseLabel, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeCaseKeyword?.raw
      layout[1] = caseKeyword.raw
      layout[2] = garbageBetweenCaseKeywordAndCaseItems?.raw
      layout[3] = caseItems.raw
      layout[4] = garbageBetweenCaseItemsAndColon?.raw
      layout[5] = colon.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeCaseKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var caseKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenCaseKeywordAndCaseItems: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var caseItems: RawCaseItemListSyntax {
    raw.children[3].map(RawCaseItemListSyntax.init(raw:))!
  }
  public var garbageBetweenCaseItemsAndColon: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawCatchClauseSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeCatchKeyword: RawGarbageNodesSyntax? = nil,
    catchKeyword: RawTokenSyntax,
    _ garbageBetweenCatchKeywordAndCatchItems: RawGarbageNodesSyntax? = nil,
    catchItems: RawCatchItemListSyntax?,
    _ garbageBetweenCatchItemsAndBody: RawGarbageNodesSyntax? = nil,
    body: RawCodeBlockSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .catchClause, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeCatchKeyword?.raw
      layout[1] = catchKeyword.raw
      layout[2] = garbageBetweenCatchKeywordAndCatchItems?.raw
      layout[3] = catchItems?.raw
      layout[4] = garbageBetweenCatchItemsAndBody?.raw
      layout[5] = body.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeCatchKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var catchKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenCatchKeywordAndCatchItems: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var catchItems: RawCatchItemListSyntax? {
    raw.children[3].map(RawCatchItemListSyntax.init(raw:))
  }
  public var garbageBetweenCatchItemsAndBody: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax {
    raw.children[5].map(RawCodeBlockSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPoundAssertStmtSyntax: RawStmtSyntaxNodeProtocol {
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
    _ garbageBeforePoundAssert: RawGarbageNodesSyntax? = nil,
    poundAssert: RawTokenSyntax,
    _ garbageBetweenPoundAssertAndLeftParen: RawGarbageNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ garbageBetweenLeftParenAndCondition: RawGarbageNodesSyntax? = nil,
    condition: RawExprSyntax,
    _ garbageBetweenConditionAndComma: RawGarbageNodesSyntax? = nil,
    comma: RawTokenSyntax?,
    _ garbageBetweenCommaAndMessage: RawGarbageNodesSyntax? = nil,
    message: RawTokenSyntax?,
    _ garbageBetweenMessageAndRightParen: RawGarbageNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .poundAssertStmt, uninitializedCount: 12, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforePoundAssert?.raw
      layout[1] = poundAssert.raw
      layout[2] = garbageBetweenPoundAssertAndLeftParen?.raw
      layout[3] = leftParen.raw
      layout[4] = garbageBetweenLeftParenAndCondition?.raw
      layout[5] = condition.raw
      layout[6] = garbageBetweenConditionAndComma?.raw
      layout[7] = comma?.raw
      layout[8] = garbageBetweenCommaAndMessage?.raw
      layout[9] = message?.raw
      layout[10] = garbageBetweenMessageAndRightParen?.raw
      layout[11] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforePoundAssert: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var poundAssert: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenPoundAssertAndLeftParen: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftParenAndCondition: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var condition: RawExprSyntax {
    raw.children[5].map(RawExprSyntax.init(raw:))!
  }
  public var garbageBetweenConditionAndComma: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var comma: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenCommaAndMessage: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var message: RawTokenSyntax? {
    raw.children[9].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenMessageAndRightParen: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    raw.children[11].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawGenericWhereClauseSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeWhereKeyword: RawGarbageNodesSyntax? = nil,
    whereKeyword: RawTokenSyntax,
    _ garbageBetweenWhereKeywordAndRequirementList: RawGarbageNodesSyntax? = nil,
    requirementList: RawGenericRequirementListSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .genericWhereClause, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeWhereKeyword?.raw
      layout[1] = whereKeyword.raw
      layout[2] = garbageBetweenWhereKeywordAndRequirementList?.raw
      layout[3] = requirementList.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeWhereKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var whereKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenWhereKeywordAndRequirementList: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var requirementList: RawGenericRequirementListSyntax {
    raw.children[3].map(RawGenericRequirementListSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawGenericRequirementListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawGenericRequirementSyntax {
    let raw = RawSyntax.makeLayout(kind: .genericRequirementList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawGenericRequirementSyntax] {
    raw.children.map { RawGenericRequirementSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawGenericRequirementSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeBody: RawGarbageNodesSyntax? = nil,
    body: RawSyntax,
    _ garbageBetweenBodyAndTrailingComma: RawGarbageNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .genericRequirement, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeBody?.raw
      layout[1] = body.raw
      layout[2] = garbageBetweenBodyAndTrailingComma?.raw
      layout[3] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeBody: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var body: RawSyntax {
    raw.children[1]!
  }
  public var garbageBetweenBodyAndTrailingComma: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawSameTypeRequirementSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeLeftTypeIdentifier: RawGarbageNodesSyntax? = nil,
    leftTypeIdentifier: RawTypeSyntax,
    _ garbageBetweenLeftTypeIdentifierAndEqualityToken: RawGarbageNodesSyntax? = nil,
    equalityToken: RawTokenSyntax,
    _ garbageBetweenEqualityTokenAndRightTypeIdentifier: RawGarbageNodesSyntax? = nil,
    rightTypeIdentifier: RawTypeSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .sameTypeRequirement, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLeftTypeIdentifier?.raw
      layout[1] = leftTypeIdentifier.raw
      layout[2] = garbageBetweenLeftTypeIdentifierAndEqualityToken?.raw
      layout[3] = equalityToken.raw
      layout[4] = garbageBetweenEqualityTokenAndRightTypeIdentifier?.raw
      layout[5] = rightTypeIdentifier.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLeftTypeIdentifier: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftTypeIdentifier: RawTypeSyntax {
    raw.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var garbageBetweenLeftTypeIdentifierAndEqualityToken: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var equalityToken: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenEqualityTokenAndRightTypeIdentifier: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightTypeIdentifier: RawTypeSyntax {
    raw.children[5].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawLayoutRequirementSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeTypeIdentifier: RawGarbageNodesSyntax? = nil,
    typeIdentifier: RawTypeSyntax,
    _ garbageBetweenTypeIdentifierAndColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ garbageBetweenColonAndLayoutConstraint: RawGarbageNodesSyntax? = nil,
    layoutConstraint: RawTokenSyntax,
    _ garbageBetweenLayoutConstraintAndLeftParen: RawGarbageNodesSyntax? = nil,
    leftParen: RawTokenSyntax?,
    _ garbageBetweenLeftParenAndSize: RawGarbageNodesSyntax? = nil,
    size: RawTokenSyntax?,
    _ garbageBetweenSizeAndComma: RawGarbageNodesSyntax? = nil,
    comma: RawTokenSyntax?,
    _ garbageBetweenCommaAndAlignment: RawGarbageNodesSyntax? = nil,
    alignment: RawTokenSyntax?,
    _ garbageBetweenAlignmentAndRightParen: RawGarbageNodesSyntax? = nil,
    rightParen: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .layoutRequirement, uninitializedCount: 16, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeTypeIdentifier?.raw
      layout[1] = typeIdentifier.raw
      layout[2] = garbageBetweenTypeIdentifierAndColon?.raw
      layout[3] = colon.raw
      layout[4] = garbageBetweenColonAndLayoutConstraint?.raw
      layout[5] = layoutConstraint.raw
      layout[6] = garbageBetweenLayoutConstraintAndLeftParen?.raw
      layout[7] = leftParen?.raw
      layout[8] = garbageBetweenLeftParenAndSize?.raw
      layout[9] = size?.raw
      layout[10] = garbageBetweenSizeAndComma?.raw
      layout[11] = comma?.raw
      layout[12] = garbageBetweenCommaAndAlignment?.raw
      layout[13] = alignment?.raw
      layout[14] = garbageBetweenAlignmentAndRightParen?.raw
      layout[15] = rightParen?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeTypeIdentifier: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var typeIdentifier: RawTypeSyntax {
    raw.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var garbageBetweenTypeIdentifierAndColon: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenColonAndLayoutConstraint: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var layoutConstraint: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLayoutConstraintAndLeftParen: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenLeftParenAndSize: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var size: RawTokenSyntax? {
    raw.children[9].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenSizeAndComma: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var comma: RawTokenSyntax? {
    raw.children[11].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenCommaAndAlignment: RawGarbageNodesSyntax? {
    raw.children[12].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var alignment: RawTokenSyntax? {
    raw.children[13].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenAlignmentAndRightParen: RawGarbageNodesSyntax? {
    raw.children[14].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax? {
    raw.children[15].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawGenericParameterListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawGenericParameterSyntax {
    let raw = RawSyntax.makeLayout(kind: .genericParameterList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawGenericParameterSyntax] {
    raw.children.map { RawGenericParameterSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawGenericParameterSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeAttributes: RawGarbageNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ garbageBetweenAttributesAndName: RawGarbageNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ garbageBetweenNameAndColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax?,
    _ garbageBetweenColonAndInheritedType: RawGarbageNodesSyntax? = nil,
    inheritedType: RawTypeSyntax?,
    _ garbageBetweenInheritedTypeAndTrailingComma: RawGarbageNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .genericParameter, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = garbageBetweenAttributesAndName?.raw
      layout[3] = name.raw
      layout[4] = garbageBetweenNameAndColon?.raw
      layout[5] = colon?.raw
      layout[6] = garbageBetweenColonAndInheritedType?.raw
      layout[7] = inheritedType?.raw
      layout[8] = garbageBetweenInheritedTypeAndTrailingComma?.raw
      layout[9] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeAttributes: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var garbageBetweenAttributesAndName: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenNameAndColon: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax? {
    raw.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenColonAndInheritedType: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var inheritedType: RawTypeSyntax? {
    raw.children[7].map(RawTypeSyntax.init(raw:))
  }
  public var garbageBetweenInheritedTypeAndTrailingComma: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[9].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawPrimaryAssociatedTypeListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawPrimaryAssociatedTypeSyntax {
    let raw = RawSyntax.makeLayout(kind: .primaryAssociatedTypeList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawPrimaryAssociatedTypeSyntax] {
    raw.children.map { RawPrimaryAssociatedTypeSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawPrimaryAssociatedTypeSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeName: RawGarbageNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ garbageBetweenNameAndTrailingComma: RawGarbageNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .primaryAssociatedType, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeName?.raw
      layout[1] = name.raw
      layout[2] = garbageBetweenNameAndTrailingComma?.raw
      layout[3] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeName: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenNameAndTrailingComma: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawGenericParameterClauseSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeLeftAngleBracket: RawGarbageNodesSyntax? = nil,
    leftAngleBracket: RawTokenSyntax,
    _ garbageBetweenLeftAngleBracketAndGenericParameterList: RawGarbageNodesSyntax? = nil,
    genericParameterList: RawGenericParameterListSyntax,
    _ garbageBetweenGenericParameterListAndRightAngleBracket: RawGarbageNodesSyntax? = nil,
    rightAngleBracket: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .genericParameterClause, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLeftAngleBracket?.raw
      layout[1] = leftAngleBracket.raw
      layout[2] = garbageBetweenLeftAngleBracketAndGenericParameterList?.raw
      layout[3] = genericParameterList.raw
      layout[4] = garbageBetweenGenericParameterListAndRightAngleBracket?.raw
      layout[5] = rightAngleBracket.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLeftAngleBracket: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftAngleBracket: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftAngleBracketAndGenericParameterList: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var genericParameterList: RawGenericParameterListSyntax {
    raw.children[3].map(RawGenericParameterListSyntax.init(raw:))!
  }
  public var garbageBetweenGenericParameterListAndRightAngleBracket: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightAngleBracket: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawConformanceRequirementSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeLeftTypeIdentifier: RawGarbageNodesSyntax? = nil,
    leftTypeIdentifier: RawTypeSyntax,
    _ garbageBetweenLeftTypeIdentifierAndColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ garbageBetweenColonAndRightTypeIdentifier: RawGarbageNodesSyntax? = nil,
    rightTypeIdentifier: RawTypeSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .conformanceRequirement, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLeftTypeIdentifier?.raw
      layout[1] = leftTypeIdentifier.raw
      layout[2] = garbageBetweenLeftTypeIdentifierAndColon?.raw
      layout[3] = colon.raw
      layout[4] = garbageBetweenColonAndRightTypeIdentifier?.raw
      layout[5] = rightTypeIdentifier.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLeftTypeIdentifier: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftTypeIdentifier: RawTypeSyntax {
    raw.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var garbageBetweenLeftTypeIdentifierAndColon: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenColonAndRightTypeIdentifier: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightTypeIdentifier: RawTypeSyntax {
    raw.children[5].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawPrimaryAssociatedTypeClauseSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeLeftAngleBracket: RawGarbageNodesSyntax? = nil,
    leftAngleBracket: RawTokenSyntax,
    _ garbageBetweenLeftAngleBracketAndPrimaryAssociatedTypeList: RawGarbageNodesSyntax? = nil,
    primaryAssociatedTypeList: RawPrimaryAssociatedTypeListSyntax,
    _ garbageBetweenPrimaryAssociatedTypeListAndRightAngleBracket: RawGarbageNodesSyntax? = nil,
    rightAngleBracket: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .primaryAssociatedTypeClause, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLeftAngleBracket?.raw
      layout[1] = leftAngleBracket.raw
      layout[2] = garbageBetweenLeftAngleBracketAndPrimaryAssociatedTypeList?.raw
      layout[3] = primaryAssociatedTypeList.raw
      layout[4] = garbageBetweenPrimaryAssociatedTypeListAndRightAngleBracket?.raw
      layout[5] = rightAngleBracket.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLeftAngleBracket: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftAngleBracket: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftAngleBracketAndPrimaryAssociatedTypeList: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var primaryAssociatedTypeList: RawPrimaryAssociatedTypeListSyntax {
    raw.children[3].map(RawPrimaryAssociatedTypeListSyntax.init(raw:))!
  }
  public var garbageBetweenPrimaryAssociatedTypeListAndRightAngleBracket: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightAngleBracket: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawSimpleTypeIdentifierSyntax: RawTypeSyntaxNodeProtocol {
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
    _ garbageBeforeName: RawGarbageNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ garbageBetweenNameAndGenericArgumentClause: RawGarbageNodesSyntax? = nil,
    genericArgumentClause: RawGenericArgumentClauseSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .simpleTypeIdentifier, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeName?.raw
      layout[1] = name.raw
      layout[2] = garbageBetweenNameAndGenericArgumentClause?.raw
      layout[3] = genericArgumentClause?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeName: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenNameAndGenericArgumentClause: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var genericArgumentClause: RawGenericArgumentClauseSyntax? {
    raw.children[3].map(RawGenericArgumentClauseSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawMemberTypeIdentifierSyntax: RawTypeSyntaxNodeProtocol {
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
    _ garbageBeforeBaseType: RawGarbageNodesSyntax? = nil,
    baseType: RawTypeSyntax,
    _ garbageBetweenBaseTypeAndPeriod: RawGarbageNodesSyntax? = nil,
    period: RawTokenSyntax,
    _ garbageBetweenPeriodAndName: RawGarbageNodesSyntax? = nil,
    name: RawTokenSyntax,
    _ garbageBetweenNameAndGenericArgumentClause: RawGarbageNodesSyntax? = nil,
    genericArgumentClause: RawGenericArgumentClauseSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .memberTypeIdentifier, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeBaseType?.raw
      layout[1] = baseType.raw
      layout[2] = garbageBetweenBaseTypeAndPeriod?.raw
      layout[3] = period.raw
      layout[4] = garbageBetweenPeriodAndName?.raw
      layout[5] = name.raw
      layout[6] = garbageBetweenNameAndGenericArgumentClause?.raw
      layout[7] = genericArgumentClause?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeBaseType: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var baseType: RawTypeSyntax {
    raw.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var garbageBetweenBaseTypeAndPeriod: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var period: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenPeriodAndName: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenNameAndGenericArgumentClause: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var genericArgumentClause: RawGenericArgumentClauseSyntax? {
    raw.children[7].map(RawGenericArgumentClauseSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawClassRestrictionTypeSyntax: RawTypeSyntaxNodeProtocol {
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
    _ garbageBeforeClassKeyword: RawGarbageNodesSyntax? = nil,
    classKeyword: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .classRestrictionType, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeClassKeyword?.raw
      layout[1] = classKeyword.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeClassKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var classKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawArrayTypeSyntax: RawTypeSyntaxNodeProtocol {
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
    _ garbageBeforeLeftSquareBracket: RawGarbageNodesSyntax? = nil,
    leftSquareBracket: RawTokenSyntax,
    _ garbageBetweenLeftSquareBracketAndElementType: RawGarbageNodesSyntax? = nil,
    elementType: RawTypeSyntax,
    _ garbageBetweenElementTypeAndRightSquareBracket: RawGarbageNodesSyntax? = nil,
    rightSquareBracket: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .arrayType, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLeftSquareBracket?.raw
      layout[1] = leftSquareBracket.raw
      layout[2] = garbageBetweenLeftSquareBracketAndElementType?.raw
      layout[3] = elementType.raw
      layout[4] = garbageBetweenElementTypeAndRightSquareBracket?.raw
      layout[5] = rightSquareBracket.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLeftSquareBracket: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftSquareBracket: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftSquareBracketAndElementType: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var elementType: RawTypeSyntax {
    raw.children[3].map(RawTypeSyntax.init(raw:))!
  }
  public var garbageBetweenElementTypeAndRightSquareBracket: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightSquareBracket: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawDictionaryTypeSyntax: RawTypeSyntaxNodeProtocol {
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
    _ garbageBeforeLeftSquareBracket: RawGarbageNodesSyntax? = nil,
    leftSquareBracket: RawTokenSyntax,
    _ garbageBetweenLeftSquareBracketAndKeyType: RawGarbageNodesSyntax? = nil,
    keyType: RawTypeSyntax,
    _ garbageBetweenKeyTypeAndColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ garbageBetweenColonAndValueType: RawGarbageNodesSyntax? = nil,
    valueType: RawTypeSyntax,
    _ garbageBetweenValueTypeAndRightSquareBracket: RawGarbageNodesSyntax? = nil,
    rightSquareBracket: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .dictionaryType, uninitializedCount: 10, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLeftSquareBracket?.raw
      layout[1] = leftSquareBracket.raw
      layout[2] = garbageBetweenLeftSquareBracketAndKeyType?.raw
      layout[3] = keyType.raw
      layout[4] = garbageBetweenKeyTypeAndColon?.raw
      layout[5] = colon.raw
      layout[6] = garbageBetweenColonAndValueType?.raw
      layout[7] = valueType.raw
      layout[8] = garbageBetweenValueTypeAndRightSquareBracket?.raw
      layout[9] = rightSquareBracket.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLeftSquareBracket: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftSquareBracket: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftSquareBracketAndKeyType: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var keyType: RawTypeSyntax {
    raw.children[3].map(RawTypeSyntax.init(raw:))!
  }
  public var garbageBetweenKeyTypeAndColon: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenColonAndValueType: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var valueType: RawTypeSyntax {
    raw.children[7].map(RawTypeSyntax.init(raw:))!
  }
  public var garbageBetweenValueTypeAndRightSquareBracket: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightSquareBracket: RawTokenSyntax {
    raw.children[9].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawMetatypeTypeSyntax: RawTypeSyntaxNodeProtocol {
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
    _ garbageBeforeBaseType: RawGarbageNodesSyntax? = nil,
    baseType: RawTypeSyntax,
    _ garbageBetweenBaseTypeAndPeriod: RawGarbageNodesSyntax? = nil,
    period: RawTokenSyntax,
    _ garbageBetweenPeriodAndTypeOrProtocol: RawGarbageNodesSyntax? = nil,
    typeOrProtocol: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .metatypeType, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeBaseType?.raw
      layout[1] = baseType.raw
      layout[2] = garbageBetweenBaseTypeAndPeriod?.raw
      layout[3] = period.raw
      layout[4] = garbageBetweenPeriodAndTypeOrProtocol?.raw
      layout[5] = typeOrProtocol.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeBaseType: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var baseType: RawTypeSyntax {
    raw.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var garbageBetweenBaseTypeAndPeriod: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var period: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenPeriodAndTypeOrProtocol: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var typeOrProtocol: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawOptionalTypeSyntax: RawTypeSyntaxNodeProtocol {
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
    _ garbageBeforeWrappedType: RawGarbageNodesSyntax? = nil,
    wrappedType: RawTypeSyntax,
    _ garbageBetweenWrappedTypeAndQuestionMark: RawGarbageNodesSyntax? = nil,
    questionMark: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .optionalType, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeWrappedType?.raw
      layout[1] = wrappedType.raw
      layout[2] = garbageBetweenWrappedTypeAndQuestionMark?.raw
      layout[3] = questionMark.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeWrappedType: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var wrappedType: RawTypeSyntax {
    raw.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var garbageBetweenWrappedTypeAndQuestionMark: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var questionMark: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawConstrainedSugarTypeSyntax: RawTypeSyntaxNodeProtocol {
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
    _ garbageBeforeSomeOrAnySpecifier: RawGarbageNodesSyntax? = nil,
    someOrAnySpecifier: RawTokenSyntax,
    _ garbageBetweenSomeOrAnySpecifierAndBaseType: RawGarbageNodesSyntax? = nil,
    baseType: RawTypeSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .constrainedSugarType, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeSomeOrAnySpecifier?.raw
      layout[1] = someOrAnySpecifier.raw
      layout[2] = garbageBetweenSomeOrAnySpecifierAndBaseType?.raw
      layout[3] = baseType.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeSomeOrAnySpecifier: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var someOrAnySpecifier: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenSomeOrAnySpecifierAndBaseType: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var baseType: RawTypeSyntax {
    raw.children[3].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawImplicitlyUnwrappedOptionalTypeSyntax: RawTypeSyntaxNodeProtocol {
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
    _ garbageBeforeWrappedType: RawGarbageNodesSyntax? = nil,
    wrappedType: RawTypeSyntax,
    _ garbageBetweenWrappedTypeAndExclamationMark: RawGarbageNodesSyntax? = nil,
    exclamationMark: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .implicitlyUnwrappedOptionalType, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeWrappedType?.raw
      layout[1] = wrappedType.raw
      layout[2] = garbageBetweenWrappedTypeAndExclamationMark?.raw
      layout[3] = exclamationMark.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeWrappedType: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var wrappedType: RawTypeSyntax {
    raw.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var garbageBetweenWrappedTypeAndExclamationMark: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var exclamationMark: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawCompositionTypeElementSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeType: RawGarbageNodesSyntax? = nil,
    type: RawTypeSyntax,
    _ garbageBetweenTypeAndAmpersand: RawGarbageNodesSyntax? = nil,
    ampersand: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .compositionTypeElement, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeType?.raw
      layout[1] = type.raw
      layout[2] = garbageBetweenTypeAndAmpersand?.raw
      layout[3] = ampersand?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeType: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var type: RawTypeSyntax {
    raw.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var garbageBetweenTypeAndAmpersand: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var ampersand: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawCompositionTypeElementListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawCompositionTypeElementSyntax {
    let raw = RawSyntax.makeLayout(kind: .compositionTypeElementList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawCompositionTypeElementSyntax] {
    raw.children.map { RawCompositionTypeElementSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawCompositionTypeSyntax: RawTypeSyntaxNodeProtocol {
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
    _ garbageBeforeElements: RawGarbageNodesSyntax? = nil,
    elements: RawCompositionTypeElementListSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .compositionType, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeElements?.raw
      layout[1] = elements.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeElements: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var elements: RawCompositionTypeElementListSyntax {
    raw.children[1].map(RawCompositionTypeElementListSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawTupleTypeElementSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeInOut: RawGarbageNodesSyntax? = nil,
    inOut: RawTokenSyntax?,
    _ garbageBetweenInOutAndName: RawGarbageNodesSyntax? = nil,
    name: RawTokenSyntax?,
    _ garbageBetweenNameAndSecondName: RawGarbageNodesSyntax? = nil,
    secondName: RawTokenSyntax?,
    _ garbageBetweenSecondNameAndColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax?,
    _ garbageBetweenColonAndType: RawGarbageNodesSyntax? = nil,
    type: RawTypeSyntax,
    _ garbageBetweenTypeAndEllipsis: RawGarbageNodesSyntax? = nil,
    ellipsis: RawTokenSyntax?,
    _ garbageBetweenEllipsisAndInitializer: RawGarbageNodesSyntax? = nil,
    initializer: RawInitializerClauseSyntax?,
    _ garbageBetweenInitializerAndTrailingComma: RawGarbageNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .tupleTypeElement, uninitializedCount: 16, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeInOut?.raw
      layout[1] = inOut?.raw
      layout[2] = garbageBetweenInOutAndName?.raw
      layout[3] = name?.raw
      layout[4] = garbageBetweenNameAndSecondName?.raw
      layout[5] = secondName?.raw
      layout[6] = garbageBetweenSecondNameAndColon?.raw
      layout[7] = colon?.raw
      layout[8] = garbageBetweenColonAndType?.raw
      layout[9] = type.raw
      layout[10] = garbageBetweenTypeAndEllipsis?.raw
      layout[11] = ellipsis?.raw
      layout[12] = garbageBetweenEllipsisAndInitializer?.raw
      layout[13] = initializer?.raw
      layout[14] = garbageBetweenInitializerAndTrailingComma?.raw
      layout[15] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeInOut: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var inOut: RawTokenSyntax? {
    raw.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenInOutAndName: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenNameAndSecondName: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var secondName: RawTokenSyntax? {
    raw.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenSecondNameAndColon: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenColonAndType: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var type: RawTypeSyntax {
    raw.children[9].map(RawTypeSyntax.init(raw:))!
  }
  public var garbageBetweenTypeAndEllipsis: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var ellipsis: RawTokenSyntax? {
    raw.children[11].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenEllipsisAndInitializer: RawGarbageNodesSyntax? {
    raw.children[12].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var initializer: RawInitializerClauseSyntax? {
    raw.children[13].map(RawInitializerClauseSyntax.init(raw:))
  }
  public var garbageBetweenInitializerAndTrailingComma: RawGarbageNodesSyntax? {
    raw.children[14].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[15].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawTupleTypeElementListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawTupleTypeElementSyntax {
    let raw = RawSyntax.makeLayout(kind: .tupleTypeElementList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawTupleTypeElementSyntax] {
    raw.children.map { RawTupleTypeElementSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawTupleTypeSyntax: RawTypeSyntaxNodeProtocol {
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
    _ garbageBeforeLeftParen: RawGarbageNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ garbageBetweenLeftParenAndElements: RawGarbageNodesSyntax? = nil,
    elements: RawTupleTypeElementListSyntax,
    _ garbageBetweenElementsAndRightParen: RawGarbageNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .tupleType, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLeftParen?.raw
      layout[1] = leftParen.raw
      layout[2] = garbageBetweenLeftParenAndElements?.raw
      layout[3] = elements.raw
      layout[4] = garbageBetweenElementsAndRightParen?.raw
      layout[5] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLeftParen: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftParenAndElements: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var elements: RawTupleTypeElementListSyntax {
    raw.children[3].map(RawTupleTypeElementListSyntax.init(raw:))!
  }
  public var garbageBetweenElementsAndRightParen: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawFunctionTypeSyntax: RawTypeSyntaxNodeProtocol {
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
    _ garbageBeforeLeftParen: RawGarbageNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ garbageBetweenLeftParenAndArguments: RawGarbageNodesSyntax? = nil,
    arguments: RawTupleTypeElementListSyntax,
    _ garbageBetweenArgumentsAndRightParen: RawGarbageNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    _ garbageBetweenRightParenAndAsyncKeyword: RawGarbageNodesSyntax? = nil,
    asyncKeyword: RawTokenSyntax?,
    _ garbageBetweenAsyncKeywordAndThrowsOrRethrowsKeyword: RawGarbageNodesSyntax? = nil,
    throwsOrRethrowsKeyword: RawTokenSyntax?,
    _ garbageBetweenThrowsOrRethrowsKeywordAndArrow: RawGarbageNodesSyntax? = nil,
    arrow: RawTokenSyntax,
    _ garbageBetweenArrowAndReturnType: RawGarbageNodesSyntax? = nil,
    returnType: RawTypeSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .functionType, uninitializedCount: 14, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLeftParen?.raw
      layout[1] = leftParen.raw
      layout[2] = garbageBetweenLeftParenAndArguments?.raw
      layout[3] = arguments.raw
      layout[4] = garbageBetweenArgumentsAndRightParen?.raw
      layout[5] = rightParen.raw
      layout[6] = garbageBetweenRightParenAndAsyncKeyword?.raw
      layout[7] = asyncKeyword?.raw
      layout[8] = garbageBetweenAsyncKeywordAndThrowsOrRethrowsKeyword?.raw
      layout[9] = throwsOrRethrowsKeyword?.raw
      layout[10] = garbageBetweenThrowsOrRethrowsKeywordAndArrow?.raw
      layout[11] = arrow.raw
      layout[12] = garbageBetweenArrowAndReturnType?.raw
      layout[13] = returnType.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLeftParen: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftParenAndArguments: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var arguments: RawTupleTypeElementListSyntax {
    raw.children[3].map(RawTupleTypeElementListSyntax.init(raw:))!
  }
  public var garbageBetweenArgumentsAndRightParen: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenRightParenAndAsyncKeyword: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var asyncKeyword: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenAsyncKeywordAndThrowsOrRethrowsKeyword: RawGarbageNodesSyntax? {
    raw.children[8].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var throwsOrRethrowsKeyword: RawTokenSyntax? {
    raw.children[9].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenThrowsOrRethrowsKeywordAndArrow: RawGarbageNodesSyntax? {
    raw.children[10].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var arrow: RawTokenSyntax {
    raw.children[11].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenArrowAndReturnType: RawGarbageNodesSyntax? {
    raw.children[12].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var returnType: RawTypeSyntax {
    raw.children[13].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawAttributedTypeSyntax: RawTypeSyntaxNodeProtocol {
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
    _ garbageBeforeSpecifier: RawGarbageNodesSyntax? = nil,
    specifier: RawTokenSyntax?,
    _ garbageBetweenSpecifierAndAttributes: RawGarbageNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ garbageBetweenAttributesAndBaseType: RawGarbageNodesSyntax? = nil,
    baseType: RawTypeSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .attributedType, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeSpecifier?.raw
      layout[1] = specifier?.raw
      layout[2] = garbageBetweenSpecifierAndAttributes?.raw
      layout[3] = attributes?.raw
      layout[4] = garbageBetweenAttributesAndBaseType?.raw
      layout[5] = baseType.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeSpecifier: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var specifier: RawTokenSyntax? {
    raw.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenSpecifierAndAttributes: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[3].map(RawAttributeListSyntax.init(raw:))
  }
  public var garbageBetweenAttributesAndBaseType: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var baseType: RawTypeSyntax {
    raw.children[5].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawGenericArgumentListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawGenericArgumentSyntax {
    let raw = RawSyntax.makeLayout(kind: .genericArgumentList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawGenericArgumentSyntax] {
    raw.children.map { RawGenericArgumentSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawGenericArgumentSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeArgumentType: RawGarbageNodesSyntax? = nil,
    argumentType: RawTypeSyntax,
    _ garbageBetweenArgumentTypeAndTrailingComma: RawGarbageNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .genericArgument, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeArgumentType?.raw
      layout[1] = argumentType.raw
      layout[2] = garbageBetweenArgumentTypeAndTrailingComma?.raw
      layout[3] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeArgumentType: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var argumentType: RawTypeSyntax {
    raw.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var garbageBetweenArgumentTypeAndTrailingComma: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawGenericArgumentClauseSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeLeftAngleBracket: RawGarbageNodesSyntax? = nil,
    leftAngleBracket: RawTokenSyntax,
    _ garbageBetweenLeftAngleBracketAndArguments: RawGarbageNodesSyntax? = nil,
    arguments: RawGenericArgumentListSyntax,
    _ garbageBetweenArgumentsAndRightAngleBracket: RawGarbageNodesSyntax? = nil,
    rightAngleBracket: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .genericArgumentClause, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLeftAngleBracket?.raw
      layout[1] = leftAngleBracket.raw
      layout[2] = garbageBetweenLeftAngleBracketAndArguments?.raw
      layout[3] = arguments.raw
      layout[4] = garbageBetweenArgumentsAndRightAngleBracket?.raw
      layout[5] = rightAngleBracket.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLeftAngleBracket: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftAngleBracket: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftAngleBracketAndArguments: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var arguments: RawGenericArgumentListSyntax {
    raw.children[3].map(RawGenericArgumentListSyntax.init(raw:))!
  }
  public var garbageBetweenArgumentsAndRightAngleBracket: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightAngleBracket: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawTypeAnnotationSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ garbageBetweenColonAndType: RawGarbageNodesSyntax? = nil,
    type: RawTypeSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .typeAnnotation, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeColon?.raw
      layout[1] = colon.raw
      layout[2] = garbageBetweenColonAndType?.raw
      layout[3] = type.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeColon: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenColonAndType: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var type: RawTypeSyntax {
    raw.children[3].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawEnumCasePatternSyntax: RawPatternSyntaxNodeProtocol {
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
    _ garbageBeforeType: RawGarbageNodesSyntax? = nil,
    type: RawTypeSyntax?,
    _ garbageBetweenTypeAndPeriod: RawGarbageNodesSyntax? = nil,
    period: RawTokenSyntax,
    _ garbageBetweenPeriodAndCaseName: RawGarbageNodesSyntax? = nil,
    caseName: RawTokenSyntax,
    _ garbageBetweenCaseNameAndAssociatedTuple: RawGarbageNodesSyntax? = nil,
    associatedTuple: RawTuplePatternSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .enumCasePattern, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeType?.raw
      layout[1] = type?.raw
      layout[2] = garbageBetweenTypeAndPeriod?.raw
      layout[3] = period.raw
      layout[4] = garbageBetweenPeriodAndCaseName?.raw
      layout[5] = caseName.raw
      layout[6] = garbageBetweenCaseNameAndAssociatedTuple?.raw
      layout[7] = associatedTuple?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeType: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var type: RawTypeSyntax? {
    raw.children[1].map(RawTypeSyntax.init(raw:))
  }
  public var garbageBetweenTypeAndPeriod: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var period: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenPeriodAndCaseName: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var caseName: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenCaseNameAndAssociatedTuple: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var associatedTuple: RawTuplePatternSyntax? {
    raw.children[7].map(RawTuplePatternSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawIsTypePatternSyntax: RawPatternSyntaxNodeProtocol {
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
    _ garbageBeforeIsKeyword: RawGarbageNodesSyntax? = nil,
    isKeyword: RawTokenSyntax,
    _ garbageBetweenIsKeywordAndType: RawGarbageNodesSyntax? = nil,
    type: RawTypeSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .isTypePattern, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeIsKeyword?.raw
      layout[1] = isKeyword.raw
      layout[2] = garbageBetweenIsKeywordAndType?.raw
      layout[3] = type.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeIsKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var isKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenIsKeywordAndType: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var type: RawTypeSyntax {
    raw.children[3].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawOptionalPatternSyntax: RawPatternSyntaxNodeProtocol {
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
    _ garbageBeforeSubPattern: RawGarbageNodesSyntax? = nil,
    subPattern: RawPatternSyntax,
    _ garbageBetweenSubPatternAndQuestionMark: RawGarbageNodesSyntax? = nil,
    questionMark: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .optionalPattern, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeSubPattern?.raw
      layout[1] = subPattern.raw
      layout[2] = garbageBetweenSubPatternAndQuestionMark?.raw
      layout[3] = questionMark.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeSubPattern: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var subPattern: RawPatternSyntax {
    raw.children[1].map(RawPatternSyntax.init(raw:))!
  }
  public var garbageBetweenSubPatternAndQuestionMark: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var questionMark: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawIdentifierPatternSyntax: RawPatternSyntaxNodeProtocol {
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
    _ garbageBeforeIdentifier: RawGarbageNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .identifierPattern, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeIdentifier?.raw
      layout[1] = identifier.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeIdentifier: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawAsTypePatternSyntax: RawPatternSyntaxNodeProtocol {
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
    _ garbageBeforePattern: RawGarbageNodesSyntax? = nil,
    pattern: RawPatternSyntax,
    _ garbageBetweenPatternAndAsKeyword: RawGarbageNodesSyntax? = nil,
    asKeyword: RawTokenSyntax,
    _ garbageBetweenAsKeywordAndType: RawGarbageNodesSyntax? = nil,
    type: RawTypeSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .asTypePattern, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforePattern?.raw
      layout[1] = pattern.raw
      layout[2] = garbageBetweenPatternAndAsKeyword?.raw
      layout[3] = asKeyword.raw
      layout[4] = garbageBetweenAsKeywordAndType?.raw
      layout[5] = type.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforePattern: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax {
    raw.children[1].map(RawPatternSyntax.init(raw:))!
  }
  public var garbageBetweenPatternAndAsKeyword: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var asKeyword: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenAsKeywordAndType: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var type: RawTypeSyntax {
    raw.children[5].map(RawTypeSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawTuplePatternSyntax: RawPatternSyntaxNodeProtocol {
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
    _ garbageBeforeLeftParen: RawGarbageNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ garbageBetweenLeftParenAndElements: RawGarbageNodesSyntax? = nil,
    elements: RawTuplePatternElementListSyntax,
    _ garbageBetweenElementsAndRightParen: RawGarbageNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .tuplePattern, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLeftParen?.raw
      layout[1] = leftParen.raw
      layout[2] = garbageBetweenLeftParenAndElements?.raw
      layout[3] = elements.raw
      layout[4] = garbageBetweenElementsAndRightParen?.raw
      layout[5] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLeftParen: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLeftParenAndElements: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var elements: RawTuplePatternElementListSyntax {
    raw.children[3].map(RawTuplePatternElementListSyntax.init(raw:))!
  }
  public var garbageBetweenElementsAndRightParen: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawWildcardPatternSyntax: RawPatternSyntaxNodeProtocol {
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
    _ garbageBeforeWildcard: RawGarbageNodesSyntax? = nil,
    wildcard: RawTokenSyntax,
    _ garbageBetweenWildcardAndTypeAnnotation: RawGarbageNodesSyntax? = nil,
    typeAnnotation: RawTypeAnnotationSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .wildcardPattern, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeWildcard?.raw
      layout[1] = wildcard.raw
      layout[2] = garbageBetweenWildcardAndTypeAnnotation?.raw
      layout[3] = typeAnnotation?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeWildcard: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var wildcard: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenWildcardAndTypeAnnotation: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var typeAnnotation: RawTypeAnnotationSyntax? {
    raw.children[3].map(RawTypeAnnotationSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawTuplePatternElementSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeLabelName: RawGarbageNodesSyntax? = nil,
    labelName: RawTokenSyntax?,
    _ garbageBetweenLabelNameAndLabelColon: RawGarbageNodesSyntax? = nil,
    labelColon: RawTokenSyntax?,
    _ garbageBetweenLabelColonAndPattern: RawGarbageNodesSyntax? = nil,
    pattern: RawPatternSyntax,
    _ garbageBetweenPatternAndTrailingComma: RawGarbageNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .tuplePatternElement, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLabelName?.raw
      layout[1] = labelName?.raw
      layout[2] = garbageBetweenLabelNameAndLabelColon?.raw
      layout[3] = labelColon?.raw
      layout[4] = garbageBetweenLabelColonAndPattern?.raw
      layout[5] = pattern.raw
      layout[6] = garbageBetweenPatternAndTrailingComma?.raw
      layout[7] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLabelName: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var labelName: RawTokenSyntax? {
    raw.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenLabelNameAndLabelColon: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var labelColon: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenLabelColonAndPattern: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax {
    raw.children[5].map(RawPatternSyntax.init(raw:))!
  }
  public var garbageBetweenPatternAndTrailingComma: RawGarbageNodesSyntax? {
    raw.children[6].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawExpressionPatternSyntax: RawPatternSyntaxNodeProtocol {
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
    _ garbageBeforeExpression: RawGarbageNodesSyntax? = nil,
    expression: RawExprSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .expressionPattern, uninitializedCount: 2, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeExpression?.raw
      layout[1] = expression.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeExpression: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    raw.children[1].map(RawExprSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawTuplePatternElementListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawTuplePatternElementSyntax {
    let raw = RawSyntax.makeLayout(kind: .tuplePatternElementList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawTuplePatternElementSyntax] {
    raw.children.map { RawTuplePatternElementSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawValueBindingPatternSyntax: RawPatternSyntaxNodeProtocol {
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
    _ garbageBeforeLetOrVarKeyword: RawGarbageNodesSyntax? = nil,
    letOrVarKeyword: RawTokenSyntax,
    _ garbageBetweenLetOrVarKeywordAndValuePattern: RawGarbageNodesSyntax? = nil,
    valuePattern: RawPatternSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .valueBindingPattern, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLetOrVarKeyword?.raw
      layout[1] = letOrVarKeyword.raw
      layout[2] = garbageBetweenLetOrVarKeywordAndValuePattern?.raw
      layout[3] = valuePattern.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLetOrVarKeyword: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var letOrVarKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLetOrVarKeywordAndValuePattern: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var valuePattern: RawPatternSyntax {
    raw.children[3].map(RawPatternSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawAvailabilitySpecListSyntax: RawSyntaxNodeProtocol {
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

  public init<C: Collection>(elements: C, arena: SyntaxArena)  where C.Element == RawAvailabilityArgumentSyntax {
    let raw = RawSyntax.makeLayout(kind: .availabilitySpecList, from: elements.map { $0.raw }, arena: arena)
    self.init(raw: raw)
  }

  public var elements: [RawAvailabilityArgumentSyntax] {
    raw.children.map { RawAvailabilityArgumentSyntax(raw: $0!) }
  }
}

@_spi(RawSyntax)
public struct RawAvailabilityArgumentSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeEntry: RawGarbageNodesSyntax? = nil,
    entry: RawSyntax,
    _ garbageBetweenEntryAndTrailingComma: RawGarbageNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .availabilityArgument, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeEntry?.raw
      layout[1] = entry.raw
      layout[2] = garbageBetweenEntryAndTrailingComma?.raw
      layout[3] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeEntry: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var entry: RawSyntax {
    raw.children[1]!
  }
  public var garbageBetweenEntryAndTrailingComma: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawAvailabilityLabeledArgumentSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeLabel: RawGarbageNodesSyntax? = nil,
    label: RawTokenSyntax,
    _ garbageBetweenLabelAndColon: RawGarbageNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ garbageBetweenColonAndValue: RawGarbageNodesSyntax? = nil,
    value: RawSyntax,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .availabilityLabeledArgument, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeLabel?.raw
      layout[1] = label.raw
      layout[2] = garbageBetweenLabelAndColon?.raw
      layout[3] = colon.raw
      layout[4] = garbageBetweenColonAndValue?.raw
      layout[5] = value.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeLabel: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var label: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenLabelAndColon: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenColonAndValue: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var value: RawSyntax {
    raw.children[5]!
  }
}

@_spi(RawSyntax)
public struct RawAvailabilityVersionRestrictionSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforePlatform: RawGarbageNodesSyntax? = nil,
    platform: RawTokenSyntax,
    _ garbageBetweenPlatformAndVersion: RawGarbageNodesSyntax? = nil,
    version: RawVersionTupleSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .availabilityVersionRestriction, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforePlatform?.raw
      layout[1] = platform.raw
      layout[2] = garbageBetweenPlatformAndVersion?.raw
      layout[3] = version?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforePlatform: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var platform: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var garbageBetweenPlatformAndVersion: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var version: RawVersionTupleSyntax? {
    raw.children[3].map(RawVersionTupleSyntax.init(raw:))
  }
}

@_spi(RawSyntax)
public struct RawVersionTupleSyntax: RawSyntaxNodeProtocol {
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
    _ garbageBeforeMajorMinor: RawGarbageNodesSyntax? = nil,
    majorMinor: RawSyntax,
    _ garbageBetweenMajorMinorAndPatchPeriod: RawGarbageNodesSyntax? = nil,
    patchPeriod: RawTokenSyntax?,
    _ garbageBetweenPatchPeriodAndPatchVersion: RawGarbageNodesSyntax? = nil,
    patchVersion: RawTokenSyntax?,
    arena: SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .versionTuple, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = garbageBeforeMajorMinor?.raw
      layout[1] = majorMinor.raw
      layout[2] = garbageBetweenMajorMinorAndPatchPeriod?.raw
      layout[3] = patchPeriod?.raw
      layout[4] = garbageBetweenPatchPeriodAndPatchVersion?.raw
      layout[5] = patchVersion?.raw
    }
    self.init(raw: raw)
  }

  public var garbageBeforeMajorMinor: RawGarbageNodesSyntax? {
    raw.children[0].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var majorMinor: RawSyntax {
    raw.children[1]!
  }
  public var garbageBetweenMajorMinorAndPatchPeriod: RawGarbageNodesSyntax? {
    raw.children[2].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var patchPeriod: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var garbageBetweenPatchPeriodAndPatchVersion: RawGarbageNodesSyntax? {
    raw.children[4].map(RawGarbageNodesSyntax.init(raw:))
  }
  public var patchVersion: RawTokenSyntax? {
    raw.children[5].map(RawTokenSyntax.init(raw:))
  }
}
