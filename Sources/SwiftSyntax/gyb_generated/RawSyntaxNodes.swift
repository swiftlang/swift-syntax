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
    arena: __shared SyntaxArena
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    arena: __shared SyntaxArena
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
    arena: __shared SyntaxArena
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
    arena: __shared SyntaxArena
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
    arena: __shared SyntaxArena
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var item: RawSyntax {
    raw.children[1]!
  }
  public var unexpectedBetweenItemAndSemicolon: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var semicolon: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenSemicolonAndErrorTokens: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftBrace: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftBraceAndStatements: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var statements: RawCodeBlockItemListSyntax {
    raw.children[3].map(RawCodeBlockItemListSyntax.init(raw:))!
  }
  public var unexpectedBetweenStatementsAndRightBrace: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightBrace: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
}

@_spi(RawSyntax)
public struct RawUnexpectedNodesSyntax: RawSyntaxNodeProtocol {
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var ampersand: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenAmpersandAndExpression: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var tryKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenTryKeywordAndQuestionOrExclamationMark: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var questionOrExclamationMark: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenQuestionOrExclamationMarkAndExpression: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var awaitKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenAwaitKeywordAndExpression: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var moveKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenMoveKeywordAndExpression: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndColon: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndArguments: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var arguments: RawDeclNameArgumentListSyntax {
    raw.children[3].map(RawDeclNameArgumentListSyntax.init(raw:))!
  }
  public var unexpectedBetweenArgumentsAndRightParen: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndDeclNameArguments: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndGenericArgumentClause: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var operatorToken: RawTokenSyntax? {
    raw.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenOperatorTokenAndPostfixExpression: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var asyncKeyword: RawTokenSyntax? {
    raw.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenAsyncKeywordAndThrowsToken: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var throwsToken: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenThrowsTokenAndArrowToken: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftOperand: RawExprSyntax {
    raw.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftOperandAndOperatorOperand: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var operatorOperand: RawExprSyntax {
    raw.children[3].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenOperatorOperandAndRightOperand: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndElementList: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var elementList: RawTupleExprElementListSyntax {
    raw.children[3].map(RawTupleExprElementListSyntax.init(raw:))!
  }
  public var unexpectedBetweenElementListAndRightParen: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftSquare: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftSquareAndElements: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var elements: RawArrayElementListSyntax {
    raw.children[3].map(RawArrayElementListSyntax.init(raw:))!
  }
  public var unexpectedBetweenElementsAndRightSquare: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftSquare: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftSquareAndContent: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var content: RawSyntax {
    raw.children[3]!
  }
  public var unexpectedBetweenContentAndRightSquare: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var label: RawTokenSyntax? {
    raw.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenLabelAndColon: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenColonAndExpression: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    raw.children[5].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenExpressionAndTrailingComma: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    raw.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenExpressionAndTrailingComma: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var keyExpression: RawExprSyntax {
    raw.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenKeyExpressionAndColon: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndValueExpression: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var valueExpression: RawExprSyntax {
    raw.children[5].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenValueExpressionAndTrailingComma: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var conditionExpression: RawExprSyntax {
    raw.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenConditionExpressionAndQuestionMark: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var questionMark: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenQuestionMarkAndFirstChoice: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var firstChoice: RawExprSyntax {
    raw.children[5].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenFirstChoiceAndColonMark: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colonMark: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonMarkAndSecondChoice: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var base: RawExprSyntax? {
    raw.children[1].map(RawExprSyntax.init(raw:))
  }
  public var unexpectedBetweenBaseAndDot: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var dot: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenDotAndName: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndDeclNameArguments: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    _ unexpectedBeforeIsTok: RawUnexpectedNodesSyntax? = nil,
    isTok: RawTokenSyntax,
    _ unexpectedBetweenIsTokAndTypeName: RawUnexpectedNodesSyntax? = nil,
    typeName: RawTypeSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .isExpr, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeIsTok?.raw
      layout[1] = isTok.raw
      layout[2] = unexpectedBetweenIsTokAndTypeName?.raw
      layout[3] = typeName.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeIsTok: RawUnexpectedNodesSyntax? {
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var isTok: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIsTokAndTypeName: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    _ unexpectedBeforeAsTok: RawUnexpectedNodesSyntax? = nil,
    asTok: RawTokenSyntax,
    _ unexpectedBetweenAsTokAndQuestionOrExclamationMark: RawUnexpectedNodesSyntax? = nil,
    questionOrExclamationMark: RawTokenSyntax?,
    _ unexpectedBetweenQuestionOrExclamationMarkAndTypeName: RawUnexpectedNodesSyntax? = nil,
    typeName: RawTypeSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .asExpr, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAsTok?.raw
      layout[1] = asTok.raw
      layout[2] = unexpectedBetweenAsTokAndQuestionOrExclamationMark?.raw
      layout[3] = questionOrExclamationMark?.raw
      layout[4] = unexpectedBetweenQuestionOrExclamationMarkAndTypeName?.raw
      layout[5] = typeName.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAsTok: RawUnexpectedNodesSyntax? {
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var asTok: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenAsTokAndQuestionOrExclamationMark: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var questionOrExclamationMark: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenQuestionOrExclamationMarkAndTypeName: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var specifier: RawTokenListSyntax? {
    raw.children[1].map(RawTokenListSyntax.init(raw:))
  }
  public var unexpectedBetweenSpecifierAndName: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenNameAndAssignToken: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var assignToken: RawTokenSyntax? {
    raw.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenAssignTokenAndExpression: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    raw.children[7].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenExpressionAndTrailingComma: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftSquare: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftSquareAndItems: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var items: RawClosureCaptureItemListSyntax? {
    raw.children[3].map(RawClosureCaptureItemListSyntax.init(raw:))
  }
  public var unexpectedBetweenItemsAndRightSquare: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndTrailingComma: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndCapture: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var capture: RawClosureCaptureSignatureSyntax? {
    raw.children[3].map(RawClosureCaptureSignatureSyntax.init(raw:))
  }
  public var unexpectedBetweenCaptureAndInput: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var input: RawSyntax? {
    raw.children[5]
  }
  public var unexpectedBetweenInputAndAsyncKeyword: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var asyncKeyword: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenAsyncKeywordAndThrowsTok: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var throwsTok: RawTokenSyntax? {
    raw.children[9].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenThrowsTokAndOutput: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var output: RawReturnClauseSyntax? {
    raw.children[11].map(RawReturnClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenOutputAndInTok: RawUnexpectedNodesSyntax? {
    raw.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftBrace: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftBraceAndSignature: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var signature: RawClosureSignatureSyntax? {
    raw.children[3].map(RawClosureSignatureSyntax.init(raw:))
  }
  public var unexpectedBetweenSignatureAndStatements: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var statements: RawCodeBlockItemListSyntax {
    raw.children[5].map(RawCodeBlockItemListSyntax.init(raw:))!
  }
  public var unexpectedBetweenStatementsAndRightBrace: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var label: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLabelAndColon: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndClosure: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var calledExpression: RawExprSyntax {
    raw.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenCalledExpressionAndLeftParen: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenLeftParenAndArgumentList: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var argumentList: RawTupleExprElementListSyntax {
    raw.children[5].map(RawTupleExprElementListSyntax.init(raw:))!
  }
  public var unexpectedBetweenArgumentListAndRightParen: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenRightParenAndTrailingClosure: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingClosure: RawClosureExprSyntax? {
    raw.children[9].map(RawClosureExprSyntax.init(raw:))
  }
  public var unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var calledExpression: RawExprSyntax {
    raw.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenCalledExpressionAndLeftBracket: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftBracket: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftBracketAndArgumentList: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var argumentList: RawTupleExprElementListSyntax {
    raw.children[5].map(RawTupleExprElementListSyntax.init(raw:))!
  }
  public var unexpectedBetweenArgumentListAndRightBracket: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightBracket: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenRightBracketAndTrailingClosure: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingClosure: RawClosureExprSyntax? {
    raw.children[9].map(RawClosureExprSyntax.init(raw:))
  }
  public var unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    raw.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenExpressionAndQuestionMark: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    raw.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenExpressionAndExclamationMark: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    raw.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenExpressionAndOperatorToken: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    raw.children[1].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenExpressionAndGenericArgumentClause: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var backslash: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenBackslashAndDelimiter: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var delimiter: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenDelimiterAndLeftParen: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndExpressions: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expressions: RawTupleExprElementListSyntax {
    raw.children[7].map(RawTupleExprElementListSyntax.init(raw:))!
  }
  public var unexpectedBetweenExpressionsAndRightParen: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var openDelimiter: RawTokenSyntax? {
    raw.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenOpenDelimiterAndOpenQuote: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var openQuote: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenOpenQuoteAndSegments: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var segments: RawStringLiteralSegmentsSyntax {
    raw.children[5].map(RawStringLiteralSegmentsSyntax.init(raw:))!
  }
  public var unexpectedBetweenSegmentsAndCloseQuote: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var closeQuote: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenCloseQuoteAndCloseDelimiter: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    _ unexpectedBeforeBackslash: RawUnexpectedNodesSyntax? = nil,
    backslash: RawTokenSyntax,
    _ unexpectedBetweenBackslashAndRootExpr: RawUnexpectedNodesSyntax? = nil,
    rootExpr: RawExprSyntax?,
    _ unexpectedBetweenRootExprAndExpression: RawUnexpectedNodesSyntax? = nil,
    expression: RawExprSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .keyPathExpr, uninitializedCount: 6, arena: arena) { layout in
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var backslash: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenBackslashAndRootExpr: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rootExpr: RawExprSyntax? {
    raw.children[3].map(RawExprSyntax.init(raw:))
  }
  public var unexpectedBetweenRootExprAndExpression: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndDot: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var keyPath: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenKeyPathAndLeftParen: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndName: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawObjcNameSyntax {
    raw.children[5].map(RawObjcNameSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndRightParen: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var poundSelector: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPoundSelectorAndLeftParen: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndKind: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var kind: RawTokenSyntax? {
    raw.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenKindAndColon: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenColonAndName: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawExprSyntax {
    raw.children[9].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndRightParen: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var base: RawExprSyntax? {
    raw.children[1].map(RawExprSyntax.init(raw:))
  }
  public var unexpectedBetweenBaseAndConfig: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndLeftParen: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndArguments: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var arguments: RawTupleExprElementListSyntax {
    raw.children[5].map(RawTupleExprElementListSyntax.init(raw:))!
  }
  public var unexpectedBetweenArgumentsAndRightParen: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var equal: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenEqualAndValue: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndTypealiasKeyword: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var typealiasKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenTypealiasKeywordAndIdentifier: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndGenericParameterClause: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    raw.children[9].map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericParameterClauseAndInitializer: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var initializer: RawTypeInitializerClauseSyntax {
    raw.children[11].map(RawTypeInitializerClauseSyntax.init(raw:))!
  }
  public var unexpectedBetweenInitializerAndGenericWhereClause: RawUnexpectedNodesSyntax? {
    raw.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndAssociatedtypeKeyword: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var associatedtypeKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenAssociatedtypeKeywordAndIdentifier: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndInheritanceClause: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    raw.children[9].map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenInheritanceClauseAndInitializer: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var initializer: RawTypeInitializerClauseSyntax? {
    raw.children[11].map(RawTypeInitializerClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenInitializerAndGenericWhereClause: RawUnexpectedNodesSyntax? {
    raw.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndParameterList: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var parameterList: RawFunctionParameterListSyntax {
    raw.children[3].map(RawFunctionParameterListSyntax.init(raw:))!
  }
  public var unexpectedBetweenParameterListAndRightParen: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var arrow: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenArrowAndReturnType: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var input: RawParameterClauseSyntax {
    raw.children[1].map(RawParameterClauseSyntax.init(raw:))!
  }
  public var unexpectedBetweenInputAndAsyncOrReasyncKeyword: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var asyncOrReasyncKeyword: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var throwsOrRethrowsKeyword: RawTokenSyntax? {
    raw.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenThrowsOrRethrowsKeywordAndOutput: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var poundKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPoundKeywordAndCondition: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var condition: RawExprSyntax? {
    raw.children[3].map(RawExprSyntax.init(raw:))
  }
  public var unexpectedBetweenConditionAndElements: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var clauses: RawIfConfigClauseListSyntax {
    raw.children[1].map(RawIfConfigClauseListSyntax.init(raw:))!
  }
  public var unexpectedBetweenClausesAndPoundEndif: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var poundError: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPoundErrorAndLeftParen: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndMessage: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var message: RawStringLiteralExprSyntax {
    raw.children[5].map(RawStringLiteralExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenMessageAndRightParen: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var poundWarning: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPoundWarningAndLeftParen: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndMessage: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var message: RawStringLiteralExprSyntax {
    raw.children[5].map(RawStringLiteralExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenMessageAndRightParen: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var poundSourceLocation: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPoundSourceLocationAndLeftParen: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndArgs: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var args: RawPoundSourceLocationArgsSyntax? {
    raw.children[5].map(RawPoundSourceLocationArgsSyntax.init(raw:))
  }
  public var unexpectedBetweenArgsAndRightParen: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var fileArgLabel: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenFileArgLabelAndFileArgColon: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var fileArgColon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenFileArgColonAndFileName: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var fileName: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenFileNameAndComma: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var comma: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenCommaAndLineArgLabel: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var lineArgLabel: RawTokenSyntax {
    raw.children[9].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLineArgLabelAndLineArgColon: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var lineArgColon: RawTokenSyntax {
    raw.children[11].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLineArgColonAndLineNumber: RawUnexpectedNodesSyntax? {
    raw.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndDetail: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var detail: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenDetailAndRightParen: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndDetail: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var typeName: RawTypeSyntax {
    raw.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenTypeNameAndTrailingComma: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndInheritedTypeCollection: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndClassKeyword: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var classKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenClassKeywordAndIdentifier: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndGenericParameterClause: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    raw.children[9].map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericParameterClauseAndInheritanceClause: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    raw.children[11].map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenInheritanceClauseAndGenericWhereClause: RawUnexpectedNodesSyntax? {
    raw.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    raw.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericWhereClauseAndMembers: RawUnexpectedNodesSyntax? {
    raw.children[14].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndActorKeyword: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var actorKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenActorKeywordAndIdentifier: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndGenericParameterClause: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    raw.children[9].map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericParameterClauseAndInheritanceClause: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    raw.children[11].map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenInheritanceClauseAndGenericWhereClause: RawUnexpectedNodesSyntax? {
    raw.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    raw.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericWhereClauseAndMembers: RawUnexpectedNodesSyntax? {
    raw.children[14].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndStructKeyword: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var structKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenStructKeywordAndIdentifier: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndGenericParameterClause: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    raw.children[9].map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericParameterClauseAndInheritanceClause: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    raw.children[11].map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenInheritanceClauseAndGenericWhereClause: RawUnexpectedNodesSyntax? {
    raw.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    raw.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericWhereClauseAndMembers: RawUnexpectedNodesSyntax? {
    raw.children[14].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndProtocolKeyword: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var protocolKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenProtocolKeywordAndIdentifier: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndPrimaryAssociatedTypeClause: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var primaryAssociatedTypeClause: RawPrimaryAssociatedTypeClauseSyntax? {
    raw.children[9].map(RawPrimaryAssociatedTypeClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenPrimaryAssociatedTypeClauseAndInheritanceClause: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    raw.children[11].map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenInheritanceClauseAndGenericWhereClause: RawUnexpectedNodesSyntax? {
    raw.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    raw.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericWhereClauseAndMembers: RawUnexpectedNodesSyntax? {
    raw.children[14].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndExtensionKeyword: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var extensionKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenExtensionKeywordAndExtendedType: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var extendedType: RawTypeSyntax {
    raw.children[7].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenExtendedTypeAndInheritanceClause: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    raw.children[9].map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenInheritanceClauseAndGenericWhereClause: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    raw.children[11].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericWhereClauseAndMembers: RawUnexpectedNodesSyntax? {
    raw.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftBrace: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftBraceAndMembers: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var members: RawMemberDeclListSyntax {
    raw.children[3].map(RawMemberDeclListSyntax.init(raw:))!
  }
  public var unexpectedBetweenMembersAndRightBrace: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var decl: RawDeclSyntax {
    raw.children[1].map(RawDeclSyntax.init(raw:))!
  }
  public var unexpectedBetweenDeclAndSemicolon: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var statements: RawCodeBlockItemListSyntax {
    raw.children[1].map(RawCodeBlockItemListSyntax.init(raw:))!
  }
  public var unexpectedBetweenStatementsAndEOFToken: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var equal: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenEqualAndValue: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    _ unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? = nil,
    attributes: RawAttributeListSyntax?,
    _ unexpectedBetweenAttributesAndFirstName: RawUnexpectedNodesSyntax? = nil,
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
      kind: .functionParameter, uninitializedCount: 16, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeAttributes?.raw
      layout[1] = attributes?.raw
      layout[2] = unexpectedBetweenAttributesAndFirstName?.raw
      layout[3] = firstName?.raw
      layout[4] = unexpectedBetweenFirstNameAndSecondName?.raw
      layout[5] = secondName?.raw
      layout[6] = unexpectedBetweenSecondNameAndColon?.raw
      layout[7] = colon?.raw
      layout[8] = unexpectedBetweenColonAndType?.raw
      layout[9] = type?.raw
      layout[10] = unexpectedBetweenTypeAndEllipsis?.raw
      layout[11] = ellipsis?.raw
      layout[12] = unexpectedBetweenEllipsisAndDefaultArgument?.raw
      layout[13] = defaultArgument?.raw
      layout[14] = unexpectedBetweenDefaultArgumentAndTrailingComma?.raw
      layout[15] = trailingComma?.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeAttributes: RawUnexpectedNodesSyntax? {
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndFirstName: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var firstName: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenFirstNameAndSecondName: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var secondName: RawTokenSyntax? {
    raw.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenSecondNameAndColon: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenColonAndType: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var type: RawTypeSyntax? {
    raw.children[9].map(RawTypeSyntax.init(raw:))
  }
  public var unexpectedBetweenTypeAndEllipsis: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var ellipsis: RawTokenSyntax? {
    raw.children[11].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenEllipsisAndDefaultArgument: RawUnexpectedNodesSyntax? {
    raw.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var defaultArgument: RawInitializerClauseSyntax? {
    raw.children[13].map(RawInitializerClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenDefaultArgumentAndTrailingComma: RawUnexpectedNodesSyntax? {
    raw.children[14].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndFuncKeyword: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var funcKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenFuncKeywordAndIdentifier: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndGenericParameterClause: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    raw.children[9].map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericParameterClauseAndSignature: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var signature: RawFunctionSignatureSyntax {
    raw.children[11].map(RawFunctionSignatureSyntax.init(raw:))!
  }
  public var unexpectedBetweenSignatureAndGenericWhereClause: RawUnexpectedNodesSyntax? {
    raw.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    raw.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericWhereClauseAndBody: RawUnexpectedNodesSyntax? {
    raw.children[14].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndInitKeyword: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var initKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenInitKeywordAndOptionalMark: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var optionalMark: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenOptionalMarkAndGenericParameterClause: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    raw.children[9].map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericParameterClauseAndSignature: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var signature: RawFunctionSignatureSyntax {
    raw.children[11].map(RawFunctionSignatureSyntax.init(raw:))!
  }
  public var unexpectedBetweenSignatureAndGenericWhereClause: RawUnexpectedNodesSyntax? {
    raw.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    raw.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericWhereClauseAndBody: RawUnexpectedNodesSyntax? {
    raw.children[14].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndDeinitKeyword: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var deinitKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenDeinitKeywordAndBody: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndSubscriptKeyword: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var subscriptKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenSubscriptKeywordAndGenericParameterClause: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    raw.children[7].map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericParameterClauseAndIndices: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var indices: RawParameterClauseSyntax {
    raw.children[9].map(RawParameterClauseSyntax.init(raw:))!
  }
  public var unexpectedBetweenIndicesAndResult: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var result: RawReturnClauseSyntax {
    raw.children[11].map(RawReturnClauseSyntax.init(raw:))!
  }
  public var unexpectedBetweenResultAndGenericWhereClause: RawUnexpectedNodesSyntax? {
    raw.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    raw.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericWhereClauseAndAccessor: RawUnexpectedNodesSyntax? {
    raw.children[14].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndModifier: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndTrailingDot: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndImportTok: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var importTok: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenImportTokAndImportKind: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var importKind: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenImportKindAndPath: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndName: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndRightParen: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifier: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifier: RawDeclModifierSyntax? {
    raw.children[3].map(RawDeclModifierSyntax.init(raw:))
  }
  public var unexpectedBetweenModifierAndAccessorKind: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var accessorKind: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenAccessorKindAndParameter: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var parameter: RawAccessorParameterSyntax? {
    raw.children[7].map(RawAccessorParameterSyntax.init(raw:))
  }
  public var unexpectedBetweenParameterAndAsyncKeyword: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var asyncKeyword: RawTokenSyntax? {
    raw.children[9].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenAsyncKeywordAndThrowsKeyword: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var throwsKeyword: RawTokenSyntax? {
    raw.children[11].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenThrowsKeywordAndBody: RawUnexpectedNodesSyntax? {
    raw.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftBrace: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftBraceAndAccessors: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var accessors: RawAccessorListSyntax {
    raw.children[3].map(RawAccessorListSyntax.init(raw:))!
  }
  public var unexpectedBetweenAccessorsAndRightBrace: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax {
    raw.children[1].map(RawPatternSyntax.init(raw:))!
  }
  public var unexpectedBetweenPatternAndTypeAnnotation: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var typeAnnotation: RawTypeAnnotationSyntax? {
    raw.children[3].map(RawTypeAnnotationSyntax.init(raw:))
  }
  public var unexpectedBetweenTypeAnnotationAndInitializer: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var initializer: RawInitializerClauseSyntax? {
    raw.children[5].map(RawInitializerClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenInitializerAndAccessor: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var accessor: RawSyntax? {
    raw.children[7]
  }
  public var unexpectedBetweenAccessorAndTrailingComma: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndLetOrVarKeyword: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var letOrVarKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLetOrVarKeywordAndBindings: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndAssociatedValue: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var associatedValue: RawParameterClauseSyntax? {
    raw.children[3].map(RawParameterClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenAssociatedValueAndRawValue: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rawValue: RawInitializerClauseSyntax? {
    raw.children[5].map(RawInitializerClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenRawValueAndTrailingComma: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndCaseKeyword: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var caseKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenCaseKeywordAndElements: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndEnumKeyword: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var enumKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenEnumKeywordAndIdentifier: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndGenericParameters: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericParameters: RawGenericParameterClauseSyntax? {
    raw.children[9].map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericParametersAndInheritanceClause: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    raw.children[11].map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenInheritanceClauseAndGenericWhereClause: RawUnexpectedNodesSyntax? {
    raw.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    raw.children[13].map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenGenericWhereClauseAndMembers: RawUnexpectedNodesSyntax? {
    raw.children[14].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndOperatorKeyword: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var operatorKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenOperatorKeywordAndIdentifier: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndOperatorPrecedenceAndTypes: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
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

  public init(elements: [RawTokenSyntax], arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .identifierList, uninitializedCount: elements.count, arena: arena) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
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
    _ unexpectedBeforeColon: RawUnexpectedNodesSyntax? = nil,
    colon: RawTokenSyntax,
    _ unexpectedBetweenColonAndPrecedenceGroupAndDesignatedTypes: RawUnexpectedNodesSyntax? = nil,
    precedenceGroupAndDesignatedTypes: RawIdentifierListSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .operatorPrecedenceAndTypes, uninitializedCount: 4, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeColon?.raw
      layout[1] = colon.raw
      layout[2] = unexpectedBetweenColonAndPrecedenceGroupAndDesignatedTypes?.raw
      layout[3] = precedenceGroupAndDesignatedTypes.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeColon: RawUnexpectedNodesSyntax? {
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndPrecedenceGroupAndDesignatedTypes: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndModifiers: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    raw.children[3].map(RawModifierListSyntax.init(raw:))
  }
  public var unexpectedBetweenModifiersAndPrecedencegroupKeyword: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var precedencegroupKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPrecedencegroupKeywordAndIdentifier: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var identifier: RawTokenSyntax {
    raw.children[7].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIdentifierAndLeftBrace: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftBrace: RawTokenSyntax {
    raw.children[9].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftBraceAndGroupAttributes: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var groupAttributes: RawPrecedenceGroupAttributeListSyntax {
    raw.children[11].map(RawPrecedenceGroupAttributeListSyntax.init(raw:))!
  }
  public var unexpectedBetweenGroupAttributesAndRightBrace: RawUnexpectedNodesSyntax? {
    raw.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var higherThanOrLowerThan: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenHigherThanOrLowerThanAndColon: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndOtherNames: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndTrailingComma: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var assignmentKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenAssignmentKeywordAndColon: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndFlag: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var associativityKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenAssociativityKeywordAndColon: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndValue: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var atSignToken: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenAtSignTokenAndAttributeName: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributeName: RawTypeSyntax {
    raw.children[3].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenAttributeNameAndLeftParen: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax? {
    raw.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenLeftParenAndArgumentList: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var argumentList: RawTupleExprElementListSyntax? {
    raw.children[7].map(RawTupleExprElementListSyntax.init(raw:))
  }
  public var unexpectedBetweenArgumentListAndRightParen: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var atSignToken: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenAtSignTokenAndAttributeName: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributeName: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenAttributeNameAndLeftParen: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax? {
    raw.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenLeftParenAndArgument: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var argument: RawSyntax? {
    raw.children[7]
  }
  public var unexpectedBetweenArgumentAndRightParen: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax? {
    raw.children[9].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenRightParenAndTokenList: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var label: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLabelAndColon: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndAvailabilityList: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var availabilityList: RawAvailabilitySpecListSyntax {
    raw.children[5].map(RawAvailabilitySpecListSyntax.init(raw:))!
  }
  public var unexpectedBetweenAvailabilityListAndSemicolon: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var label: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLabelAndColon: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndValue: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var value: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenValueAndTrailingComma: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var label: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLabelAndColon: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndDeclname: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var declname: RawDeclNameSyntax {
    raw.children[5].map(RawDeclNameSyntax.init(raw:))!
  }
  public var unexpectedBetweenDeclnameAndTrailingComma: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var nameTok: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameTokAndColon: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndStringOrDeclname: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var declBaseName: RawSyntax {
    raw.children[1]!
  }
  public var unexpectedBetweenDeclBaseNameAndDeclNameArguments: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    _ unexpectedBeforeType: RawUnexpectedNodesSyntax? = nil,
    type: RawSimpleTypeIdentifierSyntax,
    _ unexpectedBetweenTypeAndComma: RawUnexpectedNodesSyntax? = nil,
    comma: RawTokenSyntax,
    _ unexpectedBetweenCommaAndDeclBaseName: RawUnexpectedNodesSyntax? = nil,
    declBaseName: RawSyntax,
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var type: RawSimpleTypeIdentifierSyntax {
    raw.children[1].map(RawSimpleTypeIdentifierSyntax.init(raw:))!
  }
  public var unexpectedBetweenTypeAndComma: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var comma: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenCommaAndDeclBaseName: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var declBaseName: RawSyntax {
    raw.children[5]!
  }
  public var unexpectedBetweenDeclBaseNameAndDeclNameArguments: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax? {
    raw.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenNameAndColon: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var diffKind: RawTokenSyntax? {
    raw.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenDiffKindAndDiffKindComma: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var diffKindComma: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenDiffKindCommaAndDiffParams: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var diffParams: RawDifferentiabilityParamsClauseSyntax? {
    raw.children[5].map(RawDifferentiabilityParamsClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenDiffParamsAndDiffParamsComma: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var diffParamsComma: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenDiffParamsCommaAndWhereClause: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var wrtLabel: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenWrtLabelAndColon: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndParameters: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndDiffParams: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var diffParams: RawDifferentiabilityParamListSyntax {
    raw.children[3].map(RawDifferentiabilityParamListSyntax.init(raw:))!
  }
  public var unexpectedBetweenDiffParamsAndRightParen: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var parameter: RawSyntax {
    raw.children[1]!
  }
  public var unexpectedBetweenParameterAndTrailingComma: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var ofLabel: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenOfLabelAndColon: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndOriginalDeclName: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var originalDeclName: RawQualifiedDeclNameSyntax {
    raw.children[5].map(RawQualifiedDeclNameSyntax.init(raw:))!
  }
  public var unexpectedBetweenOriginalDeclNameAndPeriod: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var period: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenPeriodAndAccessorKind: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var accessorKind: RawTokenSyntax? {
    raw.children[9].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenAccessorKindAndComma: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var comma: RawTokenSyntax? {
    raw.children[11].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenCommaAndDiffParams: RawUnexpectedNodesSyntax? {
    raw.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var baseType: RawTypeSyntax? {
    raw.children[1].map(RawTypeSyntax.init(raw:))
  }
  public var unexpectedBetweenBaseTypeAndDot: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var dot: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenDotAndName: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndArguments: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawSyntax {
    raw.children[1]!
  }
  public var unexpectedBetweenNameAndArguments: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var beforeLabel: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenBeforeLabelAndColon: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndVersionList: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var availabilityVersionRestriction: RawAvailabilityVersionRestrictionSyntax {
    raw.children[1].map(RawAvailabilityVersionRestrictionSyntax.init(raw:))!
  }
  public var unexpectedBetweenAvailabilityVersionRestrictionAndTrailingComma: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var labelName: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLabelNameAndLabelColon: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var labelColon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLabelColonAndStatement: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var continueKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenContinueKeywordAndLabel: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var whileKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenWhileKeywordAndConditions: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var conditions: RawConditionElementListSyntax {
    raw.children[3].map(RawConditionElementListSyntax.init(raw:))!
  }
  public var unexpectedBetweenConditionsAndBody: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var deferKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenDeferKeywordAndBody: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var repeatKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenRepeatKeywordAndBody: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax {
    raw.children[3].map(RawCodeBlockSyntax.init(raw:))!
  }
  public var unexpectedBetweenBodyAndWhileKeyword: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var whileKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenWhileKeywordAndCondition: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var guardKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenGuardKeywordAndConditions: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var conditions: RawConditionElementListSyntax {
    raw.children[3].map(RawConditionElementListSyntax.init(raw:))!
  }
  public var unexpectedBetweenConditionsAndElseKeyword: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var elseKeyword: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenElseKeywordAndBody: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var whereKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenWhereKeywordAndGuardResult: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var forKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenForKeywordAndTryKeyword: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var tryKeyword: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenTryKeywordAndAwaitKeyword: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var awaitKeyword: RawTokenSyntax? {
    raw.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenAwaitKeywordAndCaseKeyword: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var caseKeyword: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenCaseKeywordAndPattern: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax {
    raw.children[9].map(RawPatternSyntax.init(raw:))!
  }
  public var unexpectedBetweenPatternAndTypeAnnotation: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var typeAnnotation: RawTypeAnnotationSyntax? {
    raw.children[11].map(RawTypeAnnotationSyntax.init(raw:))
  }
  public var unexpectedBetweenTypeAnnotationAndInKeyword: RawUnexpectedNodesSyntax? {
    raw.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var inKeyword: RawTokenSyntax {
    raw.children[13].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenInKeywordAndSequenceExpr: RawUnexpectedNodesSyntax? {
    raw.children[14].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var sequenceExpr: RawExprSyntax {
    raw.children[15].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenSequenceExprAndWhereClause: RawUnexpectedNodesSyntax? {
    raw.children[16].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var whereClause: RawWhereClauseSyntax? {
    raw.children[17].map(RawWhereClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenWhereClauseAndBody: RawUnexpectedNodesSyntax? {
    raw.children[18].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var switchKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenSwitchKeywordAndExpression: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    raw.children[3].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenExpressionAndLeftBrace: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftBrace: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftBraceAndCases: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var cases: RawSwitchCaseListSyntax {
    raw.children[7].map(RawSwitchCaseListSyntax.init(raw:))!
  }
  public var unexpectedBetweenCasesAndRightBrace: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var doKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenDoKeywordAndBody: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax {
    raw.children[3].map(RawCodeBlockSyntax.init(raw:))!
  }
  public var unexpectedBetweenBodyAndCatchClauses: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var returnKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenReturnKeywordAndExpression: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var yieldKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenYieldKeywordAndYields: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    _ unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax? = nil,
    leftParen: RawTokenSyntax,
    _ unexpectedBetweenLeftParenAndElementList: RawUnexpectedNodesSyntax? = nil,
    elementList: RawExprListSyntax,
    _ unexpectedBetweenElementListAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax?,
    _ unexpectedBetweenTrailingCommaAndRightParen: RawUnexpectedNodesSyntax? = nil,
    rightParen: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .yieldList, uninitializedCount: 8, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftParen?.raw
      layout[1] = leftParen.raw
      layout[2] = unexpectedBetweenLeftParenAndElementList?.raw
      layout[3] = elementList.raw
      layout[4] = unexpectedBetweenElementListAndTrailingComma?.raw
      layout[5] = trailingComma?.raw
      layout[6] = unexpectedBetweenTrailingCommaAndRightParen?.raw
      layout[7] = rightParen.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax? {
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndElementList: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var elementList: RawExprListSyntax {
    raw.children[3].map(RawExprListSyntax.init(raw:))!
  }
  public var unexpectedBetweenElementListAndTrailingComma: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    raw.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenTrailingCommaAndRightParen: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var breakKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenBreakKeywordAndLabel: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var condition: RawSyntax {
    raw.children[1]!
  }
  public var unexpectedBetweenConditionAndTrailingComma: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var poundAvailableKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPoundAvailableKeywordAndLeftParen: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndAvailabilitySpec: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var availabilitySpec: RawAvailabilitySpecListSyntax {
    raw.children[5].map(RawAvailabilitySpecListSyntax.init(raw:))!
  }
  public var unexpectedBetweenAvailabilitySpecAndRightParen: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var caseKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenCaseKeywordAndPattern: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax {
    raw.children[3].map(RawPatternSyntax.init(raw:))!
  }
  public var unexpectedBetweenPatternAndTypeAnnotation: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var typeAnnotation: RawTypeAnnotationSyntax? {
    raw.children[5].map(RawTypeAnnotationSyntax.init(raw:))
  }
  public var unexpectedBetweenTypeAnnotationAndInitializer: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var letOrVarKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLetOrVarKeywordAndPattern: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax {
    raw.children[3].map(RawPatternSyntax.init(raw:))!
  }
  public var unexpectedBetweenPatternAndTypeAnnotation: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var typeAnnotation: RawTypeAnnotationSyntax? {
    raw.children[5].map(RawTypeAnnotationSyntax.init(raw:))
  }
  public var unexpectedBetweenTypeAnnotationAndInitializer: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var poundUnavailableKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPoundUnavailableKeywordAndLeftParen: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndAvailabilitySpec: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var availabilitySpec: RawAvailabilitySpecListSyntax {
    raw.children[5].map(RawAvailabilitySpecListSyntax.init(raw:))!
  }
  public var unexpectedBetweenAvailabilitySpecAndRightParen: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var throwKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenThrowKeywordAndExpression: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var ifKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIfKeywordAndConditions: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var conditions: RawConditionElementListSyntax {
    raw.children[3].map(RawConditionElementListSyntax.init(raw:))!
  }
  public var unexpectedBetweenConditionsAndBody: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax {
    raw.children[5].map(RawCodeBlockSyntax.init(raw:))!
  }
  public var unexpectedBetweenBodyAndElseKeyword: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var elseKeyword: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenElseKeywordAndElseBody: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var elseKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenElseKeywordAndBody: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var unknownAttr: RawAttributeSyntax? {
    raw.children[1].map(RawAttributeSyntax.init(raw:))
  }
  public var unexpectedBetweenUnknownAttrAndLabel: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var label: RawSyntax {
    raw.children[3]!
  }
  public var unexpectedBetweenLabelAndStatements: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var defaultKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenDefaultKeywordAndColon: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax {
    raw.children[1].map(RawPatternSyntax.init(raw:))!
  }
  public var unexpectedBetweenPatternAndWhereClause: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var whereClause: RawWhereClauseSyntax? {
    raw.children[3].map(RawWhereClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenWhereClauseAndTrailingComma: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax? {
    raw.children[1].map(RawPatternSyntax.init(raw:))
  }
  public var unexpectedBetweenPatternAndWhereClause: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var whereClause: RawWhereClauseSyntax? {
    raw.children[3].map(RawWhereClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenWhereClauseAndTrailingComma: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var caseKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenCaseKeywordAndCaseItems: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var caseItems: RawCaseItemListSyntax {
    raw.children[3].map(RawCaseItemListSyntax.init(raw:))!
  }
  public var unexpectedBetweenCaseItemsAndColon: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var catchKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenCatchKeywordAndCatchItems: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var catchItems: RawCatchItemListSyntax? {
    raw.children[3].map(RawCatchItemListSyntax.init(raw:))
  }
  public var unexpectedBetweenCatchItemsAndBody: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var poundAssert: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPoundAssertAndLeftParen: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndCondition: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var condition: RawExprSyntax {
    raw.children[5].map(RawExprSyntax.init(raw:))!
  }
  public var unexpectedBetweenConditionAndComma: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var comma: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenCommaAndMessage: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var message: RawTokenSyntax? {
    raw.children[9].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenMessageAndRightParen: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var whereKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenWhereKeywordAndRequirementList: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var body: RawSyntax {
    raw.children[1]!
  }
  public var unexpectedBetweenBodyAndTrailingComma: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftTypeIdentifier: RawTypeSyntax {
    raw.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftTypeIdentifierAndEqualityToken: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var equalityToken: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenEqualityTokenAndRightTypeIdentifier: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var typeIdentifier: RawTypeSyntax {
    raw.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenTypeIdentifierAndColon: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndLayoutConstraint: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var layoutConstraint: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLayoutConstraintAndLeftParen: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenLeftParenAndSize: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var size: RawTokenSyntax? {
    raw.children[9].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenSizeAndComma: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var comma: RawTokenSyntax? {
    raw.children[11].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenCommaAndAlignment: RawUnexpectedNodesSyntax? {
    raw.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var alignment: RawTokenSyntax? {
    raw.children[13].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenAlignmentAndRightParen: RawUnexpectedNodesSyntax? {
    raw.children[14].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[1].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndName: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndColon: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax? {
    raw.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenColonAndInheritedType: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var inheritedType: RawTypeSyntax? {
    raw.children[7].map(RawTypeSyntax.init(raw:))
  }
  public var unexpectedBetweenInheritedTypeAndTrailingComma: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndTrailingComma: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    _ unexpectedBeforeLeftAngleBracket: RawUnexpectedNodesSyntax? = nil,
    leftAngleBracket: RawTokenSyntax,
    _ unexpectedBetweenLeftAngleBracketAndGenericParameterList: RawUnexpectedNodesSyntax? = nil,
    genericParameterList: RawGenericParameterListSyntax,
    _ unexpectedBetweenGenericParameterListAndRightAngleBracket: RawUnexpectedNodesSyntax? = nil,
    rightAngleBracket: RawTokenSyntax,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeLayout(
      kind: .genericParameterClause, uninitializedCount: 6, arena: arena) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unexpectedBeforeLeftAngleBracket?.raw
      layout[1] = leftAngleBracket.raw
      layout[2] = unexpectedBetweenLeftAngleBracketAndGenericParameterList?.raw
      layout[3] = genericParameterList.raw
      layout[4] = unexpectedBetweenGenericParameterListAndRightAngleBracket?.raw
      layout[5] = rightAngleBracket.raw
    }
    self.init(raw: raw)
  }

  public var unexpectedBeforeLeftAngleBracket: RawUnexpectedNodesSyntax? {
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftAngleBracket: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftAngleBracketAndGenericParameterList: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var genericParameterList: RawGenericParameterListSyntax {
    raw.children[3].map(RawGenericParameterListSyntax.init(raw:))!
  }
  public var unexpectedBetweenGenericParameterListAndRightAngleBracket: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftTypeIdentifier: RawTypeSyntax {
    raw.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftTypeIdentifierAndColon: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndRightTypeIdentifier: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftAngleBracket: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftAngleBracketAndPrimaryAssociatedTypeList: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var primaryAssociatedTypeList: RawPrimaryAssociatedTypeListSyntax {
    raw.children[3].map(RawPrimaryAssociatedTypeListSyntax.init(raw:))!
  }
  public var unexpectedBetweenPrimaryAssociatedTypeListAndRightAngleBracket: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndGenericArgumentClause: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var baseType: RawTypeSyntax {
    raw.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenBaseTypeAndPeriod: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var period: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPeriodAndName: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenNameAndGenericArgumentClause: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftSquareBracket: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftSquareBracketAndElementType: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var elementType: RawTypeSyntax {
    raw.children[3].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenElementTypeAndRightSquareBracket: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftSquareBracket: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftSquareBracketAndKeyType: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var keyType: RawTypeSyntax {
    raw.children[3].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenKeyTypeAndColon: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndValueType: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var valueType: RawTypeSyntax {
    raw.children[7].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenValueTypeAndRightSquareBracket: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var baseType: RawTypeSyntax {
    raw.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenBaseTypeAndPeriod: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var period: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPeriodAndTypeOrProtocol: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var wrappedType: RawTypeSyntax {
    raw.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenWrappedTypeAndQuestionMark: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var someOrAnySpecifier: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenSomeOrAnySpecifierAndBaseType: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var wrappedType: RawTypeSyntax {
    raw.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenWrappedTypeAndExclamationMark: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var type: RawTypeSyntax {
    raw.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenTypeAndAmpersand: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var inOut: RawTokenSyntax? {
    raw.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenInOutAndName: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var name: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenNameAndSecondName: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var secondName: RawTokenSyntax? {
    raw.children[5].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenSecondNameAndColon: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenColonAndType: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var type: RawTypeSyntax {
    raw.children[9].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenTypeAndEllipsis: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var ellipsis: RawTokenSyntax? {
    raw.children[11].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenEllipsisAndInitializer: RawUnexpectedNodesSyntax? {
    raw.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var initializer: RawInitializerClauseSyntax? {
    raw.children[13].map(RawInitializerClauseSyntax.init(raw:))
  }
  public var unexpectedBetweenInitializerAndTrailingComma: RawUnexpectedNodesSyntax? {
    raw.children[14].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndElements: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var elements: RawTupleTypeElementListSyntax {
    raw.children[3].map(RawTupleTypeElementListSyntax.init(raw:))!
  }
  public var unexpectedBetweenElementsAndRightParen: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndArguments: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var arguments: RawTupleTypeElementListSyntax {
    raw.children[3].map(RawTupleTypeElementListSyntax.init(raw:))!
  }
  public var unexpectedBetweenArgumentsAndRightParen: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenRightParenAndAsyncKeyword: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var asyncKeyword: RawTokenSyntax? {
    raw.children[7].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenAsyncKeywordAndThrowsOrRethrowsKeyword: RawUnexpectedNodesSyntax? {
    raw.children[8].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var throwsOrRethrowsKeyword: RawTokenSyntax? {
    raw.children[9].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenThrowsOrRethrowsKeywordAndArrow: RawUnexpectedNodesSyntax? {
    raw.children[10].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var arrow: RawTokenSyntax {
    raw.children[11].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenArrowAndReturnType: RawUnexpectedNodesSyntax? {
    raw.children[12].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var specifier: RawTokenSyntax? {
    raw.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenSpecifierAndAttributes: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    raw.children[3].map(RawAttributeListSyntax.init(raw:))
  }
  public var unexpectedBetweenAttributesAndBaseType: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var argumentType: RawTypeSyntax {
    raw.children[1].map(RawTypeSyntax.init(raw:))!
  }
  public var unexpectedBetweenArgumentTypeAndTrailingComma: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftAngleBracket: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftAngleBracketAndArguments: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var arguments: RawGenericArgumentListSyntax {
    raw.children[3].map(RawGenericArgumentListSyntax.init(raw:))!
  }
  public var unexpectedBetweenArgumentsAndRightAngleBracket: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndType: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var type: RawTypeSyntax? {
    raw.children[1].map(RawTypeSyntax.init(raw:))
  }
  public var unexpectedBetweenTypeAndPeriod: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var period: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPeriodAndCaseName: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var caseName: RawTokenSyntax {
    raw.children[5].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenCaseNameAndAssociatedTuple: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var isKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenIsKeywordAndType: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var subPattern: RawPatternSyntax {
    raw.children[1].map(RawPatternSyntax.init(raw:))!
  }
  public var unexpectedBetweenSubPatternAndQuestionMark: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax {
    raw.children[1].map(RawPatternSyntax.init(raw:))!
  }
  public var unexpectedBetweenPatternAndAsKeyword: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var asKeyword: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenAsKeywordAndType: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLeftParenAndElements: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var elements: RawTuplePatternElementListSyntax {
    raw.children[3].map(RawTuplePatternElementListSyntax.init(raw:))!
  }
  public var unexpectedBetweenElementsAndRightParen: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var wildcard: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenWildcardAndTypeAnnotation: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var labelName: RawTokenSyntax? {
    raw.children[1].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenLabelNameAndLabelColon: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var labelColon: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenLabelColonAndPattern: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax {
    raw.children[5].map(RawPatternSyntax.init(raw:))!
  }
  public var unexpectedBetweenPatternAndTrailingComma: RawUnexpectedNodesSyntax? {
    raw.children[6].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var letOrVarKeyword: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLetOrVarKeywordAndValuePattern: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var entry: RawSyntax {
    raw.children[1]!
  }
  public var unexpectedBetweenEntryAndTrailingComma: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var label: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenLabelAndColon: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax {
    raw.children[3].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenColonAndValue: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var platform: RawTokenSyntax {
    raw.children[1].map(RawTokenSyntax.init(raw:))!
  }
  public var unexpectedBetweenPlatformAndVersion: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
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
    raw.children[0].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var majorMinor: RawSyntax {
    raw.children[1]!
  }
  public var unexpectedBetweenMajorMinorAndPatchPeriod: RawUnexpectedNodesSyntax? {
    raw.children[2].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var patchPeriod: RawTokenSyntax? {
    raw.children[3].map(RawTokenSyntax.init(raw:))
  }
  public var unexpectedBetweenPatchPeriodAndPatchVersion: RawUnexpectedNodesSyntax? {
    raw.children[4].map(RawUnexpectedNodesSyntax.init(raw:))
  }
  public var patchVersion: RawTokenSyntax? {
    raw.children[5].map(RawTokenSyntax.init(raw:))
  }
}
