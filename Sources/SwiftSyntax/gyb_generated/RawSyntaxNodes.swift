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
public struct RawDeclSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .decl
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    switch syntaxKind {
    case .unknownDecl, .typealiasDecl, .associatedtypeDecl, .ifConfigDecl, .poundErrorDecl, .poundWarningDecl, .poundSourceLocation, .classDecl, .actorDecl, .structDecl, .protocolDecl, .extensionDecl, .functionDecl, .initializerDecl, .deinitializerDecl, .subscriptDecl, .importDecl, .accessorDecl, .variableDecl, .enumCaseDecl, .enumDecl, .operatorDecl, .precedenceGroupDecl: return true
    default: return false
    }
  }
}

@_spi(RawSyntax)
public struct RawExprSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .expr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    switch syntaxKind {
    case .unknownExpr, .inOutExpr, .poundColumnExpr, .tryExpr, .awaitExpr, .identifierExpr, .superRefExpr, .nilLiteralExpr, .discardAssignmentExpr, .assignmentExpr, .sequenceExpr, .poundLineExpr, .poundFileExpr, .poundFileIDExpr, .poundFilePathExpr, .poundFunctionExpr, .poundDsohandleExpr, .symbolicReferenceExpr, .prefixOperatorExpr, .binaryOperatorExpr, .arrowExpr, .floatLiteralExpr, .tupleExpr, .arrayExpr, .dictionaryExpr, .integerLiteralExpr, .booleanLiteralExpr, .ternaryExpr, .memberAccessExpr, .isExpr, .asExpr, .typeExpr, .closureExpr, .unresolvedPatternExpr, .functionCallExpr, .subscriptExpr, .optionalChainingExpr, .forcedValueExpr, .postfixUnaryExpr, .specializeExpr, .stringLiteralExpr, .regexLiteralExpr, .keyPathExpr, .keyPathBaseExpr, .objcKeyPathExpr, .objcSelectorExpr, .postfixIfConfigExpr, .editorPlaceholderExpr, .objectLiteralExpr: return true
    default: return false
    }
  }
}

@_spi(RawSyntax)
public struct RawStmtSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .stmt
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    switch syntaxKind {
    case .unknownStmt, .continueStmt, .whileStmt, .deferStmt, .expressionStmt, .repeatWhileStmt, .guardStmt, .forInStmt, .switchStmt, .doStmt, .returnStmt, .yieldStmt, .fallthroughStmt, .breakStmt, .declarationStmt, .throwStmt, .ifStmt, .poundAssertStmt: return true
    default: return false
    }
  }
}

@_spi(RawSyntax)
public struct RawTypeSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .type
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    switch syntaxKind {
    case .unknownType, .simpleTypeIdentifier, .memberTypeIdentifier, .classRestrictionType, .arrayType, .dictionaryType, .metatypeType, .optionalType, .constrainedSugarType, .implicitlyUnwrappedOptionalType, .compositionType, .tupleType, .functionType, .attributedType: return true
    default: return false
    }
  }
}

@_spi(RawSyntax)
public struct RawPatternSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .pattern
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    switch syntaxKind {
    case .unknownPattern, .enumCasePattern, .isTypePattern, .optionalPattern, .identifierPattern, .asTypePattern, .tuplePattern, .wildcardPattern, .expressionPattern, .valueBindingPattern: return true
    default: return false
    }
  }
}

@_spi(RawSyntax)
public struct RawUnknownDeclSyntax: RawDeclSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .unknownDecl
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .unknownDecl
  }
}

@_spi(RawSyntax)
public struct RawUnknownExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .unknownExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .unknownExpr
  }
}

@_spi(RawSyntax)
public struct RawUnknownStmtSyntax: RawStmtSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .unknownStmt
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .unknownStmt
  }
}

@_spi(RawSyntax)
public struct RawUnknownTypeSyntax: RawTypeSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .unknownType
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .unknownType
  }
}

@_spi(RawSyntax)
public struct RawUnknownPatternSyntax: RawPatternSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .unknownPattern
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .unknownPattern
  }
}

@_spi(RawSyntax)
public struct RawCodeBlockItemSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .codeBlockItem
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .codeBlockItem
  }
}

@_spi(RawSyntax)
public struct RawCodeBlockItemListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .codeBlockItemList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .codeBlockItemList
  }
}

@_spi(RawSyntax)
public struct RawCodeBlockSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .codeBlock
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .codeBlock
  }
}

@_spi(RawSyntax)
public struct RawInOutExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .inOutExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .inOutExpr
  }
}

@_spi(RawSyntax)
public struct RawPoundColumnExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .poundColumnExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .poundColumnExpr
  }
}

@_spi(RawSyntax)
public struct RawTupleExprElementListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .tupleExprElementList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .tupleExprElementList
  }
}

@_spi(RawSyntax)
public struct RawArrayElementListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .arrayElementList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .arrayElementList
  }
}

@_spi(RawSyntax)
public struct RawDictionaryElementListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .dictionaryElementList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .dictionaryElementList
  }
}

@_spi(RawSyntax)
public struct RawStringLiteralSegmentsSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .stringLiteralSegments
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .stringLiteralSegments
  }
}

@_spi(RawSyntax)
public struct RawTryExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .tryExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .tryExpr
  }
}

@_spi(RawSyntax)
public struct RawAwaitExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .awaitExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .awaitExpr
  }
}

@_spi(RawSyntax)
public struct RawDeclNameArgumentSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .declNameArgument
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .declNameArgument
  }
}

@_spi(RawSyntax)
public struct RawDeclNameArgumentListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .declNameArgumentList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .declNameArgumentList
  }
}

@_spi(RawSyntax)
public struct RawDeclNameArgumentsSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .declNameArguments
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .declNameArguments
  }
}

@_spi(RawSyntax)
public struct RawIdentifierExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .identifierExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .identifierExpr
  }
}

@_spi(RawSyntax)
public struct RawSuperRefExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .superRefExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .superRefExpr
  }
}

@_spi(RawSyntax)
public struct RawNilLiteralExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .nilLiteralExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .nilLiteralExpr
  }
}

@_spi(RawSyntax)
public struct RawDiscardAssignmentExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .discardAssignmentExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .discardAssignmentExpr
  }
}

@_spi(RawSyntax)
public struct RawAssignmentExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .assignmentExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .assignmentExpr
  }
}

@_spi(RawSyntax)
public struct RawSequenceExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .sequenceExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .sequenceExpr
  }
}

@_spi(RawSyntax)
public struct RawExprListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .exprList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .exprList
  }
}

@_spi(RawSyntax)
public struct RawPoundLineExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .poundLineExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .poundLineExpr
  }
}

@_spi(RawSyntax)
public struct RawPoundFileExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .poundFileExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .poundFileExpr
  }
}

@_spi(RawSyntax)
public struct RawPoundFileIDExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .poundFileIDExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .poundFileIDExpr
  }
}

@_spi(RawSyntax)
public struct RawPoundFilePathExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .poundFilePathExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .poundFilePathExpr
  }
}

@_spi(RawSyntax)
public struct RawPoundFunctionExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .poundFunctionExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .poundFunctionExpr
  }
}

@_spi(RawSyntax)
public struct RawPoundDsohandleExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .poundDsohandleExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .poundDsohandleExpr
  }
}

@_spi(RawSyntax)
public struct RawSymbolicReferenceExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .symbolicReferenceExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .symbolicReferenceExpr
  }
}

@_spi(RawSyntax)
public struct RawPrefixOperatorExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .prefixOperatorExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .prefixOperatorExpr
  }
}

@_spi(RawSyntax)
public struct RawBinaryOperatorExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .binaryOperatorExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .binaryOperatorExpr
  }
}

@_spi(RawSyntax)
public struct RawArrowExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .arrowExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .arrowExpr
  }
}

@_spi(RawSyntax)
public struct RawFloatLiteralExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .floatLiteralExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .floatLiteralExpr
  }
}

@_spi(RawSyntax)
public struct RawTupleExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .tupleExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .tupleExpr
  }
}

@_spi(RawSyntax)
public struct RawArrayExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .arrayExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .arrayExpr
  }
}

@_spi(RawSyntax)
public struct RawDictionaryExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .dictionaryExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .dictionaryExpr
  }
}

@_spi(RawSyntax)
public struct RawTupleExprElementSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .tupleExprElement
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .tupleExprElement
  }
}

@_spi(RawSyntax)
public struct RawArrayElementSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .arrayElement
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .arrayElement
  }
}

@_spi(RawSyntax)
public struct RawDictionaryElementSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .dictionaryElement
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .dictionaryElement
  }
}

@_spi(RawSyntax)
public struct RawIntegerLiteralExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .integerLiteralExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .integerLiteralExpr
  }
}

@_spi(RawSyntax)
public struct RawBooleanLiteralExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .booleanLiteralExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .booleanLiteralExpr
  }
}

@_spi(RawSyntax)
public struct RawTernaryExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .ternaryExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .ternaryExpr
  }
}

@_spi(RawSyntax)
public struct RawMemberAccessExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .memberAccessExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .memberAccessExpr
  }
}

@_spi(RawSyntax)
public struct RawIsExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .isExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .isExpr
  }
}

@_spi(RawSyntax)
public struct RawAsExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .asExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .asExpr
  }
}

@_spi(RawSyntax)
public struct RawTypeExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .typeExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .typeExpr
  }
}

@_spi(RawSyntax)
public struct RawClosureCaptureItemSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .closureCaptureItem
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .closureCaptureItem
  }
}

@_spi(RawSyntax)
public struct RawClosureCaptureItemListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .closureCaptureItemList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .closureCaptureItemList
  }
}

@_spi(RawSyntax)
public struct RawClosureCaptureSignatureSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .closureCaptureSignature
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .closureCaptureSignature
  }
}

@_spi(RawSyntax)
public struct RawClosureParamSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .closureParam
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .closureParam
  }
}

@_spi(RawSyntax)
public struct RawClosureParamListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .closureParamList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .closureParamList
  }
}

@_spi(RawSyntax)
public struct RawClosureSignatureSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .closureSignature
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .closureSignature
  }
}

@_spi(RawSyntax)
public struct RawClosureExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .closureExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .closureExpr
  }
}

@_spi(RawSyntax)
public struct RawUnresolvedPatternExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .unresolvedPatternExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .unresolvedPatternExpr
  }
}

@_spi(RawSyntax)
public struct RawMultipleTrailingClosureElementSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .multipleTrailingClosureElement
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .multipleTrailingClosureElement
  }
}

@_spi(RawSyntax)
public struct RawMultipleTrailingClosureElementListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .multipleTrailingClosureElementList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .multipleTrailingClosureElementList
  }
}

@_spi(RawSyntax)
public struct RawFunctionCallExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .functionCallExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .functionCallExpr
  }
}

@_spi(RawSyntax)
public struct RawSubscriptExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .subscriptExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .subscriptExpr
  }
}

@_spi(RawSyntax)
public struct RawOptionalChainingExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .optionalChainingExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .optionalChainingExpr
  }
}

@_spi(RawSyntax)
public struct RawForcedValueExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .forcedValueExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .forcedValueExpr
  }
}

@_spi(RawSyntax)
public struct RawPostfixUnaryExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .postfixUnaryExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .postfixUnaryExpr
  }
}

@_spi(RawSyntax)
public struct RawSpecializeExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .specializeExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .specializeExpr
  }
}

@_spi(RawSyntax)
public struct RawStringSegmentSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .stringSegment
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .stringSegment
  }
}

@_spi(RawSyntax)
public struct RawExpressionSegmentSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .expressionSegment
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .expressionSegment
  }
}

@_spi(RawSyntax)
public struct RawStringLiteralExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .stringLiteralExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .stringLiteralExpr
  }
}

@_spi(RawSyntax)
public struct RawRegexLiteralExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .regexLiteralExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .regexLiteralExpr
  }
}

@_spi(RawSyntax)
public struct RawKeyPathExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .keyPathExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .keyPathExpr
  }
}

@_spi(RawSyntax)
public struct RawKeyPathBaseExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .keyPathBaseExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .keyPathBaseExpr
  }
}

@_spi(RawSyntax)
public struct RawObjcNamePieceSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .objcNamePiece
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .objcNamePiece
  }
}

@_spi(RawSyntax)
public struct RawObjcNameSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .objcName
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .objcName
  }
}

@_spi(RawSyntax)
public struct RawObjcKeyPathExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .objcKeyPathExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .objcKeyPathExpr
  }
}

@_spi(RawSyntax)
public struct RawObjcSelectorExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .objcSelectorExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .objcSelectorExpr
  }
}

@_spi(RawSyntax)
public struct RawPostfixIfConfigExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .postfixIfConfigExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .postfixIfConfigExpr
  }
}

@_spi(RawSyntax)
public struct RawEditorPlaceholderExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .editorPlaceholderExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .editorPlaceholderExpr
  }
}

@_spi(RawSyntax)
public struct RawObjectLiteralExprSyntax: RawExprSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .objectLiteralExpr
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .objectLiteralExpr
  }
}

@_spi(RawSyntax)
public struct RawTypeInitializerClauseSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .typeInitializerClause
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .typeInitializerClause
  }
}

@_spi(RawSyntax)
public struct RawTypealiasDeclSyntax: RawDeclSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .typealiasDecl
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .typealiasDecl
  }
}

@_spi(RawSyntax)
public struct RawAssociatedtypeDeclSyntax: RawDeclSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .associatedtypeDecl
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .associatedtypeDecl
  }
}

@_spi(RawSyntax)
public struct RawFunctionParameterListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .functionParameterList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .functionParameterList
  }
}

@_spi(RawSyntax)
public struct RawParameterClauseSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .parameterClause
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .parameterClause
  }
}

@_spi(RawSyntax)
public struct RawReturnClauseSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .returnClause
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .returnClause
  }
}

@_spi(RawSyntax)
public struct RawFunctionSignatureSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .functionSignature
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .functionSignature
  }
}

@_spi(RawSyntax)
public struct RawIfConfigClauseSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .ifConfigClause
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .ifConfigClause
  }
}

@_spi(RawSyntax)
public struct RawIfConfigClauseListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .ifConfigClauseList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .ifConfigClauseList
  }
}

@_spi(RawSyntax)
public struct RawIfConfigDeclSyntax: RawDeclSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .ifConfigDecl
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .ifConfigDecl
  }
}

@_spi(RawSyntax)
public struct RawPoundErrorDeclSyntax: RawDeclSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .poundErrorDecl
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .poundErrorDecl
  }
}

@_spi(RawSyntax)
public struct RawPoundWarningDeclSyntax: RawDeclSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .poundWarningDecl
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .poundWarningDecl
  }
}

@_spi(RawSyntax)
public struct RawPoundSourceLocationSyntax: RawDeclSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .poundSourceLocation
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .poundSourceLocation
  }
}

@_spi(RawSyntax)
public struct RawPoundSourceLocationArgsSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .poundSourceLocationArgs
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .poundSourceLocationArgs
  }
}

@_spi(RawSyntax)
public struct RawDeclModifierDetailSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .declModifierDetail
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .declModifierDetail
  }
}

@_spi(RawSyntax)
public struct RawDeclModifierSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .declModifier
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .declModifier
  }
}

@_spi(RawSyntax)
public struct RawInheritedTypeSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .inheritedType
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .inheritedType
  }
}

@_spi(RawSyntax)
public struct RawInheritedTypeListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .inheritedTypeList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .inheritedTypeList
  }
}

@_spi(RawSyntax)
public struct RawTypeInheritanceClauseSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .typeInheritanceClause
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .typeInheritanceClause
  }
}

@_spi(RawSyntax)
public struct RawClassDeclSyntax: RawDeclSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .classDecl
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .classDecl
  }
}

@_spi(RawSyntax)
public struct RawActorDeclSyntax: RawDeclSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .actorDecl
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .actorDecl
  }
}

@_spi(RawSyntax)
public struct RawStructDeclSyntax: RawDeclSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .structDecl
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .structDecl
  }
}

@_spi(RawSyntax)
public struct RawProtocolDeclSyntax: RawDeclSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .protocolDecl
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .protocolDecl
  }
}

@_spi(RawSyntax)
public struct RawExtensionDeclSyntax: RawDeclSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .extensionDecl
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .extensionDecl
  }
}

@_spi(RawSyntax)
public struct RawMemberDeclBlockSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .memberDeclBlock
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .memberDeclBlock
  }
}

@_spi(RawSyntax)
public struct RawMemberDeclListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .memberDeclList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .memberDeclList
  }
}

@_spi(RawSyntax)
public struct RawMemberDeclListItemSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .memberDeclListItem
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .memberDeclListItem
  }
}

@_spi(RawSyntax)
public struct RawSourceFileSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .sourceFile
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .sourceFile
  }
}

@_spi(RawSyntax)
public struct RawInitializerClauseSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .initializerClause
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .initializerClause
  }
}

@_spi(RawSyntax)
public struct RawFunctionParameterSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .functionParameter
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .functionParameter
  }
}

@_spi(RawSyntax)
public struct RawModifierListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .modifierList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .modifierList
  }
}

@_spi(RawSyntax)
public struct RawFunctionDeclSyntax: RawDeclSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .functionDecl
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .functionDecl
  }
}

@_spi(RawSyntax)
public struct RawInitializerDeclSyntax: RawDeclSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .initializerDecl
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .initializerDecl
  }
}

@_spi(RawSyntax)
public struct RawDeinitializerDeclSyntax: RawDeclSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .deinitializerDecl
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .deinitializerDecl
  }
}

@_spi(RawSyntax)
public struct RawSubscriptDeclSyntax: RawDeclSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .subscriptDecl
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .subscriptDecl
  }
}

@_spi(RawSyntax)
public struct RawAccessLevelModifierSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .accessLevelModifier
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .accessLevelModifier
  }
}

@_spi(RawSyntax)
public struct RawAccessPathComponentSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .accessPathComponent
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .accessPathComponent
  }
}

@_spi(RawSyntax)
public struct RawAccessPathSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .accessPath
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .accessPath
  }
}

@_spi(RawSyntax)
public struct RawImportDeclSyntax: RawDeclSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .importDecl
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .importDecl
  }
}

@_spi(RawSyntax)
public struct RawAccessorParameterSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .accessorParameter
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .accessorParameter
  }
}

@_spi(RawSyntax)
public struct RawAccessorDeclSyntax: RawDeclSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .accessorDecl
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .accessorDecl
  }
}

@_spi(RawSyntax)
public struct RawAccessorListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .accessorList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .accessorList
  }
}

@_spi(RawSyntax)
public struct RawAccessorBlockSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .accessorBlock
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .accessorBlock
  }
}

@_spi(RawSyntax)
public struct RawPatternBindingSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .patternBinding
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .patternBinding
  }
}

@_spi(RawSyntax)
public struct RawPatternBindingListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .patternBindingList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .patternBindingList
  }
}

@_spi(RawSyntax)
public struct RawVariableDeclSyntax: RawDeclSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .variableDecl
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .variableDecl
  }
}

@_spi(RawSyntax)
public struct RawEnumCaseElementSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .enumCaseElement
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .enumCaseElement
  }
}

@_spi(RawSyntax)
public struct RawEnumCaseElementListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .enumCaseElementList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .enumCaseElementList
  }
}

@_spi(RawSyntax)
public struct RawEnumCaseDeclSyntax: RawDeclSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .enumCaseDecl
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .enumCaseDecl
  }
}

@_spi(RawSyntax)
public struct RawEnumDeclSyntax: RawDeclSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .enumDecl
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .enumDecl
  }
}

@_spi(RawSyntax)
public struct RawOperatorDeclSyntax: RawDeclSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .operatorDecl
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .operatorDecl
  }
}

@_spi(RawSyntax)
public struct RawIdentifierListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .identifierList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .identifierList
  }
}

@_spi(RawSyntax)
public struct RawOperatorPrecedenceAndTypesSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .operatorPrecedenceAndTypes
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .operatorPrecedenceAndTypes
  }
}

@_spi(RawSyntax)
public struct RawPrecedenceGroupDeclSyntax: RawDeclSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .precedenceGroupDecl
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .precedenceGroupDecl
  }
}

@_spi(RawSyntax)
public struct RawPrecedenceGroupAttributeListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .precedenceGroupAttributeList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .precedenceGroupAttributeList
  }
}

@_spi(RawSyntax)
public struct RawPrecedenceGroupRelationSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .precedenceGroupRelation
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .precedenceGroupRelation
  }
}

@_spi(RawSyntax)
public struct RawPrecedenceGroupNameListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .precedenceGroupNameList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .precedenceGroupNameList
  }
}

@_spi(RawSyntax)
public struct RawPrecedenceGroupNameElementSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .precedenceGroupNameElement
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .precedenceGroupNameElement
  }
}

@_spi(RawSyntax)
public struct RawPrecedenceGroupAssignmentSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .precedenceGroupAssignment
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .precedenceGroupAssignment
  }
}

@_spi(RawSyntax)
public struct RawPrecedenceGroupAssociativitySyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .precedenceGroupAssociativity
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .precedenceGroupAssociativity
  }
}

@_spi(RawSyntax)
public struct RawTokenListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .tokenList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .tokenList
  }
}

@_spi(RawSyntax)
public struct RawNonEmptyTokenListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .nonEmptyTokenList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .nonEmptyTokenList
  }
}

@_spi(RawSyntax)
public struct RawCustomAttributeSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .customAttribute
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .customAttribute
  }
}

@_spi(RawSyntax)
public struct RawAttributeSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .attribute
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .attribute
  }
}

@_spi(RawSyntax)
public struct RawAttributeListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .attributeList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .attributeList
  }
}

@_spi(RawSyntax)
public struct RawSpecializeAttributeSpecListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .specializeAttributeSpecList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .specializeAttributeSpecList
  }
}

@_spi(RawSyntax)
public struct RawAvailabilityEntrySyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .availabilityEntry
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .availabilityEntry
  }
}

@_spi(RawSyntax)
public struct RawLabeledSpecializeEntrySyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .labeledSpecializeEntry
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .labeledSpecializeEntry
  }
}

@_spi(RawSyntax)
public struct RawTargetFunctionEntrySyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .targetFunctionEntry
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .targetFunctionEntry
  }
}

@_spi(RawSyntax)
public struct RawNamedAttributeStringArgumentSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .namedAttributeStringArgument
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .namedAttributeStringArgument
  }
}

@_spi(RawSyntax)
public struct RawDeclNameSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .declName
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .declName
  }
}

@_spi(RawSyntax)
public struct RawImplementsAttributeArgumentsSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .implementsAttributeArguments
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .implementsAttributeArguments
  }
}

@_spi(RawSyntax)
public struct RawObjCSelectorPieceSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .objCSelectorPiece
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .objCSelectorPiece
  }
}

@_spi(RawSyntax)
public struct RawObjCSelectorSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .objCSelector
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .objCSelector
  }
}

@_spi(RawSyntax)
public struct RawDifferentiableAttributeArgumentsSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .differentiableAttributeArguments
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .differentiableAttributeArguments
  }
}

@_spi(RawSyntax)
public struct RawDifferentiabilityParamsClauseSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .differentiabilityParamsClause
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .differentiabilityParamsClause
  }
}

@_spi(RawSyntax)
public struct RawDifferentiabilityParamsSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .differentiabilityParams
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .differentiabilityParams
  }
}

@_spi(RawSyntax)
public struct RawDifferentiabilityParamListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .differentiabilityParamList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .differentiabilityParamList
  }
}

@_spi(RawSyntax)
public struct RawDifferentiabilityParamSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .differentiabilityParam
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .differentiabilityParam
  }
}

@_spi(RawSyntax)
public struct RawDerivativeRegistrationAttributeArgumentsSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .derivativeRegistrationAttributeArguments
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .derivativeRegistrationAttributeArguments
  }
}

@_spi(RawSyntax)
public struct RawQualifiedDeclNameSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .qualifiedDeclName
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .qualifiedDeclName
  }
}

@_spi(RawSyntax)
public struct RawFunctionDeclNameSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .functionDeclName
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .functionDeclName
  }
}

@_spi(RawSyntax)
public struct RawBackDeployAttributeSpecListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .backDeployAttributeSpecList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .backDeployAttributeSpecList
  }
}

@_spi(RawSyntax)
public struct RawBackDeployVersionListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .backDeployVersionList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .backDeployVersionList
  }
}

@_spi(RawSyntax)
public struct RawBackDeployVersionArgumentSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .backDeployVersionArgument
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .backDeployVersionArgument
  }
}

@_spi(RawSyntax)
public struct RawContinueStmtSyntax: RawStmtSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .continueStmt
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .continueStmt
  }
}

@_spi(RawSyntax)
public struct RawWhileStmtSyntax: RawStmtSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .whileStmt
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .whileStmt
  }
}

@_spi(RawSyntax)
public struct RawDeferStmtSyntax: RawStmtSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .deferStmt
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .deferStmt
  }
}

@_spi(RawSyntax)
public struct RawExpressionStmtSyntax: RawStmtSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .expressionStmt
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .expressionStmt
  }
}

@_spi(RawSyntax)
public struct RawSwitchCaseListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .switchCaseList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .switchCaseList
  }
}

@_spi(RawSyntax)
public struct RawRepeatWhileStmtSyntax: RawStmtSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .repeatWhileStmt
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .repeatWhileStmt
  }
}

@_spi(RawSyntax)
public struct RawGuardStmtSyntax: RawStmtSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .guardStmt
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .guardStmt
  }
}

@_spi(RawSyntax)
public struct RawWhereClauseSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .whereClause
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .whereClause
  }
}

@_spi(RawSyntax)
public struct RawForInStmtSyntax: RawStmtSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .forInStmt
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .forInStmt
  }
}

@_spi(RawSyntax)
public struct RawSwitchStmtSyntax: RawStmtSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .switchStmt
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .switchStmt
  }
}

@_spi(RawSyntax)
public struct RawCatchClauseListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .catchClauseList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .catchClauseList
  }
}

@_spi(RawSyntax)
public struct RawDoStmtSyntax: RawStmtSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .doStmt
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .doStmt
  }
}

@_spi(RawSyntax)
public struct RawReturnStmtSyntax: RawStmtSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .returnStmt
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .returnStmt
  }
}

@_spi(RawSyntax)
public struct RawYieldStmtSyntax: RawStmtSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .yieldStmt
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .yieldStmt
  }
}

@_spi(RawSyntax)
public struct RawYieldListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .yieldList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .yieldList
  }
}

@_spi(RawSyntax)
public struct RawFallthroughStmtSyntax: RawStmtSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .fallthroughStmt
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .fallthroughStmt
  }
}

@_spi(RawSyntax)
public struct RawBreakStmtSyntax: RawStmtSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .breakStmt
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .breakStmt
  }
}

@_spi(RawSyntax)
public struct RawCaseItemListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .caseItemList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .caseItemList
  }
}

@_spi(RawSyntax)
public struct RawCatchItemListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .catchItemList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .catchItemList
  }
}

@_spi(RawSyntax)
public struct RawConditionElementSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .conditionElement
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .conditionElement
  }
}

@_spi(RawSyntax)
public struct RawAvailabilityConditionSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .availabilityCondition
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .availabilityCondition
  }
}

@_spi(RawSyntax)
public struct RawMatchingPatternConditionSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .matchingPatternCondition
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .matchingPatternCondition
  }
}

@_spi(RawSyntax)
public struct RawOptionalBindingConditionSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .optionalBindingCondition
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .optionalBindingCondition
  }
}

@_spi(RawSyntax)
public struct RawUnavailabilityConditionSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .unavailabilityCondition
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .unavailabilityCondition
  }
}

@_spi(RawSyntax)
public struct RawConditionElementListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .conditionElementList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .conditionElementList
  }
}

@_spi(RawSyntax)
public struct RawDeclarationStmtSyntax: RawStmtSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .declarationStmt
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .declarationStmt
  }
}

@_spi(RawSyntax)
public struct RawThrowStmtSyntax: RawStmtSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .throwStmt
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .throwStmt
  }
}

@_spi(RawSyntax)
public struct RawIfStmtSyntax: RawStmtSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .ifStmt
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .ifStmt
  }
}

@_spi(RawSyntax)
public struct RawElseIfContinuationSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .elseIfContinuation
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .elseIfContinuation
  }
}

@_spi(RawSyntax)
public struct RawElseBlockSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .elseBlock
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .elseBlock
  }
}

@_spi(RawSyntax)
public struct RawSwitchCaseSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .switchCase
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .switchCase
  }
}

@_spi(RawSyntax)
public struct RawSwitchDefaultLabelSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .switchDefaultLabel
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .switchDefaultLabel
  }
}

@_spi(RawSyntax)
public struct RawCaseItemSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .caseItem
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .caseItem
  }
}

@_spi(RawSyntax)
public struct RawCatchItemSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .catchItem
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .catchItem
  }
}

@_spi(RawSyntax)
public struct RawSwitchCaseLabelSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .switchCaseLabel
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .switchCaseLabel
  }
}

@_spi(RawSyntax)
public struct RawCatchClauseSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .catchClause
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .catchClause
  }
}

@_spi(RawSyntax)
public struct RawPoundAssertStmtSyntax: RawStmtSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .poundAssertStmt
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .poundAssertStmt
  }
}

@_spi(RawSyntax)
public struct RawGenericWhereClauseSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .genericWhereClause
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .genericWhereClause
  }
}

@_spi(RawSyntax)
public struct RawGenericRequirementListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .genericRequirementList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .genericRequirementList
  }
}

@_spi(RawSyntax)
public struct RawGenericRequirementSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .genericRequirement
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .genericRequirement
  }
}

@_spi(RawSyntax)
public struct RawSameTypeRequirementSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .sameTypeRequirement
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .sameTypeRequirement
  }
}

@_spi(RawSyntax)
public struct RawGenericParameterListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .genericParameterList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .genericParameterList
  }
}

@_spi(RawSyntax)
public struct RawGenericParameterSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .genericParameter
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .genericParameter
  }
}

@_spi(RawSyntax)
public struct RawPrimaryAssociatedTypeListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .primaryAssociatedTypeList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .primaryAssociatedTypeList
  }
}

@_spi(RawSyntax)
public struct RawPrimaryAssociatedTypeSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .primaryAssociatedType
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .primaryAssociatedType
  }
}

@_spi(RawSyntax)
public struct RawGenericParameterClauseSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .genericParameterClause
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .genericParameterClause
  }
}

@_spi(RawSyntax)
public struct RawConformanceRequirementSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .conformanceRequirement
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .conformanceRequirement
  }
}

@_spi(RawSyntax)
public struct RawPrimaryAssociatedTypeClauseSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .primaryAssociatedTypeClause
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .primaryAssociatedTypeClause
  }
}

@_spi(RawSyntax)
public struct RawSimpleTypeIdentifierSyntax: RawTypeSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .simpleTypeIdentifier
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .simpleTypeIdentifier
  }
}

@_spi(RawSyntax)
public struct RawMemberTypeIdentifierSyntax: RawTypeSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .memberTypeIdentifier
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .memberTypeIdentifier
  }
}

@_spi(RawSyntax)
public struct RawClassRestrictionTypeSyntax: RawTypeSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .classRestrictionType
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .classRestrictionType
  }
}

@_spi(RawSyntax)
public struct RawArrayTypeSyntax: RawTypeSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .arrayType
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .arrayType
  }
}

@_spi(RawSyntax)
public struct RawDictionaryTypeSyntax: RawTypeSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .dictionaryType
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .dictionaryType
  }
}

@_spi(RawSyntax)
public struct RawMetatypeTypeSyntax: RawTypeSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .metatypeType
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .metatypeType
  }
}

@_spi(RawSyntax)
public struct RawOptionalTypeSyntax: RawTypeSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .optionalType
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .optionalType
  }
}

@_spi(RawSyntax)
public struct RawConstrainedSugarTypeSyntax: RawTypeSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .constrainedSugarType
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .constrainedSugarType
  }
}

@_spi(RawSyntax)
public struct RawImplicitlyUnwrappedOptionalTypeSyntax: RawTypeSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .implicitlyUnwrappedOptionalType
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .implicitlyUnwrappedOptionalType
  }
}

@_spi(RawSyntax)
public struct RawCompositionTypeElementSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .compositionTypeElement
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .compositionTypeElement
  }
}

@_spi(RawSyntax)
public struct RawCompositionTypeElementListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .compositionTypeElementList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .compositionTypeElementList
  }
}

@_spi(RawSyntax)
public struct RawCompositionTypeSyntax: RawTypeSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .compositionType
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .compositionType
  }
}

@_spi(RawSyntax)
public struct RawTupleTypeElementSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .tupleTypeElement
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .tupleTypeElement
  }
}

@_spi(RawSyntax)
public struct RawTupleTypeElementListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .tupleTypeElementList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .tupleTypeElementList
  }
}

@_spi(RawSyntax)
public struct RawTupleTypeSyntax: RawTypeSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .tupleType
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .tupleType
  }
}

@_spi(RawSyntax)
public struct RawFunctionTypeSyntax: RawTypeSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .functionType
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .functionType
  }
}

@_spi(RawSyntax)
public struct RawAttributedTypeSyntax: RawTypeSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .attributedType
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .attributedType
  }
}

@_spi(RawSyntax)
public struct RawGenericArgumentListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .genericArgumentList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .genericArgumentList
  }
}

@_spi(RawSyntax)
public struct RawGenericArgumentSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .genericArgument
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .genericArgument
  }
}

@_spi(RawSyntax)
public struct RawGenericArgumentClauseSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .genericArgumentClause
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .genericArgumentClause
  }
}

@_spi(RawSyntax)
public struct RawTypeAnnotationSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .typeAnnotation
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .typeAnnotation
  }
}

@_spi(RawSyntax)
public struct RawEnumCasePatternSyntax: RawPatternSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .enumCasePattern
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .enumCasePattern
  }
}

@_spi(RawSyntax)
public struct RawIsTypePatternSyntax: RawPatternSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .isTypePattern
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .isTypePattern
  }
}

@_spi(RawSyntax)
public struct RawOptionalPatternSyntax: RawPatternSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .optionalPattern
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .optionalPattern
  }
}

@_spi(RawSyntax)
public struct RawIdentifierPatternSyntax: RawPatternSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .identifierPattern
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .identifierPattern
  }
}

@_spi(RawSyntax)
public struct RawAsTypePatternSyntax: RawPatternSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .asTypePattern
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .asTypePattern
  }
}

@_spi(RawSyntax)
public struct RawTuplePatternSyntax: RawPatternSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .tuplePattern
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .tuplePattern
  }
}

@_spi(RawSyntax)
public struct RawWildcardPatternSyntax: RawPatternSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .wildcardPattern
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .wildcardPattern
  }
}

@_spi(RawSyntax)
public struct RawTuplePatternElementSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .tuplePatternElement
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .tuplePatternElement
  }
}

@_spi(RawSyntax)
public struct RawExpressionPatternSyntax: RawPatternSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .expressionPattern
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .expressionPattern
  }
}

@_spi(RawSyntax)
public struct RawTuplePatternElementListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .tuplePatternElementList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .tuplePatternElementList
  }
}

@_spi(RawSyntax)
public struct RawValueBindingPatternSyntax: RawPatternSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .valueBindingPattern
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .valueBindingPattern
  }
}

@_spi(RawSyntax)
public struct RawAvailabilitySpecListSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .availabilitySpecList
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .availabilitySpecList
  }
}

@_spi(RawSyntax)
public struct RawAvailabilityArgumentSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .availabilityArgument
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .availabilityArgument
  }
}

@_spi(RawSyntax)
public struct RawAvailabilityLabeledArgumentSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .availabilityLabeledArgument
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .availabilityLabeledArgument
  }
}

@_spi(RawSyntax)
public struct RawAvailabilityVersionRestrictionSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .availabilityVersionRestriction
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .availabilityVersionRestriction
  }
}

@_spi(RawSyntax)
public struct RawVersionTupleSyntax: RawSyntaxNodeProtocol {
  public static let syntaxKind: SyntaxKind = .versionTuple
  public var raw: RawSyntax
  @usableFromInline init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .versionTuple
  }
}


extension RawDeclSyntax {
  /// Upcast a RawDeclSyntax subtypes.
  @inlinable
  public init<T: RawDeclSyntaxNodeProtocol>(_ other: T) {
    self.init(raw: other.raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> RawDeclSyntax {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return RawDeclSyntax(raw: raw)
  }
}

extension RawExprSyntax {
  /// Upcast a RawExprSyntax subtypes.
  @inlinable
  public init<T: RawExprSyntaxNodeProtocol>(_ other: T) {
    self.init(raw: other.raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> RawExprSyntax {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return RawExprSyntax(raw: raw)
  }
}

extension RawStmtSyntax {
  /// Upcast a RawStmtSyntax subtypes.
  @inlinable
  public init<T: RawStmtSyntaxNodeProtocol>(_ other: T) {
    self.init(raw: other.raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> RawStmtSyntax {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return RawStmtSyntax(raw: raw)
  }
}

extension RawTypeSyntax {
  /// Upcast a RawTypeSyntax subtypes.
  @inlinable
  public init<T: RawTypeSyntaxNodeProtocol>(_ other: T) {
    self.init(raw: other.raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> RawTypeSyntax {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return RawTypeSyntax(raw: raw)
  }
}

extension RawPatternSyntax {
  /// Upcast a RawPatternSyntax subtypes.
  @inlinable
  public init<T: RawPatternSyntaxNodeProtocol>(_ other: T) {
    self.init(raw: other.raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> RawPatternSyntax {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return RawPatternSyntax(raw: raw)
  }
}


extension RawUnknownDeclSyntax {
  public static func makeBlank(arena: SyntaxArena) -> RawUnknownDeclSyntax {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return RawUnknownDeclSyntax(raw: raw)
  }
}

extension RawUnknownExprSyntax {
  public static func makeBlank(arena: SyntaxArena) -> RawUnknownExprSyntax {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return RawUnknownExprSyntax(raw: raw)
  }
}

extension RawUnknownStmtSyntax {
  public static func makeBlank(arena: SyntaxArena) -> RawUnknownStmtSyntax {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return RawUnknownStmtSyntax(raw: raw)
  }
}

extension RawUnknownTypeSyntax {
  public static func makeBlank(arena: SyntaxArena) -> RawUnknownTypeSyntax {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return RawUnknownTypeSyntax(raw: raw)
  }
}

extension RawUnknownPatternSyntax {
  public static func makeBlank(arena: SyntaxArena) -> RawUnknownPatternSyntax {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return RawUnknownPatternSyntax(raw: raw)
  }
}


extension RawCodeBlockItemListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawCodeBlockItemSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawCodeBlockItemSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawCodeBlockItemListSyntax {
      RawCodeBlockItemListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawCodeBlockItemSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawTupleExprElementListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawTupleExprElementSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawTupleExprElementSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawTupleExprElementListSyntax {
      RawTupleExprElementListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawTupleExprElementSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawArrayElementListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawArrayElementSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawArrayElementSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawArrayElementListSyntax {
      RawArrayElementListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawArrayElementSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawDictionaryElementListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawDictionaryElementSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawDictionaryElementSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawDictionaryElementListSyntax {
      RawDictionaryElementListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawDictionaryElementSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawStringLiteralSegmentsSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawStringLiteralSegmentsSyntax {
      RawStringLiteralSegmentsSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawDeclNameArgumentListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawDeclNameArgumentSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawDeclNameArgumentSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawDeclNameArgumentListSyntax {
      RawDeclNameArgumentListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawDeclNameArgumentSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawExprListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawExprSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawExprSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawExprListSyntax {
      RawExprListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawExprSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawClosureCaptureItemListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawClosureCaptureItemSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawClosureCaptureItemSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawClosureCaptureItemListSyntax {
      RawClosureCaptureItemListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawClosureCaptureItemSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawClosureParamListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawClosureParamSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawClosureParamSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawClosureParamListSyntax {
      RawClosureParamListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawClosureParamSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawMultipleTrailingClosureElementListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawMultipleTrailingClosureElementSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawMultipleTrailingClosureElementSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawMultipleTrailingClosureElementListSyntax {
      RawMultipleTrailingClosureElementListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawMultipleTrailingClosureElementSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawObjcNameSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawObjcNamePieceSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawObjcNamePieceSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawObjcNameSyntax {
      RawObjcNameSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawObjcNamePieceSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawFunctionParameterListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawFunctionParameterSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawFunctionParameterSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawFunctionParameterListSyntax {
      RawFunctionParameterListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawFunctionParameterSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawIfConfigClauseListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawIfConfigClauseSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawIfConfigClauseSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawIfConfigClauseListSyntax {
      RawIfConfigClauseListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawIfConfigClauseSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawInheritedTypeListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawInheritedTypeSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawInheritedTypeSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawInheritedTypeListSyntax {
      RawInheritedTypeListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawInheritedTypeSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawMemberDeclListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawMemberDeclListItemSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawMemberDeclListItemSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawMemberDeclListSyntax {
      RawMemberDeclListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawMemberDeclListItemSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawModifierListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawDeclModifierSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawDeclModifierSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawModifierListSyntax {
      RawModifierListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawDeclModifierSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawAccessPathSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawAccessPathComponentSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawAccessPathComponentSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawAccessPathSyntax {
      RawAccessPathSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawAccessPathComponentSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawAccessorListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawAccessorDeclSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawAccessorDeclSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawAccessorListSyntax {
      RawAccessorListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawAccessorDeclSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawPatternBindingListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawPatternBindingSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawPatternBindingSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawPatternBindingListSyntax {
      RawPatternBindingListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawPatternBindingSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawEnumCaseElementListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawEnumCaseElementSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawEnumCaseElementSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawEnumCaseElementListSyntax {
      RawEnumCaseElementListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawEnumCaseElementSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawIdentifierListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawTokenSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawTokenSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawIdentifierListSyntax {
      RawIdentifierListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawTokenSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawPrecedenceGroupAttributeListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawPrecedenceGroupAttributeListSyntax {
      RawPrecedenceGroupAttributeListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawPrecedenceGroupNameListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawPrecedenceGroupNameElementSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawPrecedenceGroupNameElementSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawPrecedenceGroupNameListSyntax {
      RawPrecedenceGroupNameListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawPrecedenceGroupNameElementSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawTokenListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawTokenSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawTokenSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawTokenListSyntax {
      RawTokenListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawTokenSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawNonEmptyTokenListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawTokenSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawTokenSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawNonEmptyTokenListSyntax {
      RawNonEmptyTokenListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawTokenSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawAttributeListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawAttributeListSyntax {
      RawAttributeListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawSpecializeAttributeSpecListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawSpecializeAttributeSpecListSyntax {
      RawSpecializeAttributeSpecListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawObjCSelectorSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawObjCSelectorPieceSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawObjCSelectorPieceSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawObjCSelectorSyntax {
      RawObjCSelectorSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawObjCSelectorPieceSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawDifferentiabilityParamListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawDifferentiabilityParamSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawDifferentiabilityParamSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawDifferentiabilityParamListSyntax {
      RawDifferentiabilityParamListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawDifferentiabilityParamSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawBackDeployVersionListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawBackDeployVersionArgumentSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawBackDeployVersionArgumentSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawBackDeployVersionListSyntax {
      RawBackDeployVersionListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawBackDeployVersionArgumentSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawSwitchCaseListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawSwitchCaseListSyntax {
      RawSwitchCaseListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawCatchClauseListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawCatchClauseSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawCatchClauseSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawCatchClauseListSyntax {
      RawCatchClauseListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawCatchClauseSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawCaseItemListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawCaseItemSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawCaseItemSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawCaseItemListSyntax {
      RawCaseItemListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawCaseItemSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawCatchItemListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawCatchItemSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawCatchItemSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawCatchItemListSyntax {
      RawCatchItemListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawCatchItemSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawConditionElementListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawConditionElementSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawConditionElementSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawConditionElementListSyntax {
      RawConditionElementListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawConditionElementSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawGenericRequirementListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawGenericRequirementSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawGenericRequirementSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawGenericRequirementListSyntax {
      RawGenericRequirementListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawGenericRequirementSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawGenericParameterListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawGenericParameterSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawGenericParameterSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawGenericParameterListSyntax {
      RawGenericParameterListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawGenericParameterSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawPrimaryAssociatedTypeListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawPrimaryAssociatedTypeSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawPrimaryAssociatedTypeSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawPrimaryAssociatedTypeListSyntax {
      RawPrimaryAssociatedTypeListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawPrimaryAssociatedTypeSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawCompositionTypeElementListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawCompositionTypeElementSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawCompositionTypeElementSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawCompositionTypeElementListSyntax {
      RawCompositionTypeElementListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawCompositionTypeElementSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawTupleTypeElementListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawTupleTypeElementSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawTupleTypeElementSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawTupleTypeElementListSyntax {
      RawTupleTypeElementListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawTupleTypeElementSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawGenericArgumentListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawGenericArgumentSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawGenericArgumentSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawGenericArgumentListSyntax {
      RawGenericArgumentListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawGenericArgumentSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawTuplePatternElementListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawTuplePatternElementSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawTuplePatternElementSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawTuplePatternElementListSyntax {
      RawTuplePatternElementListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawTuplePatternElementSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawAvailabilitySpecListSyntax {
  public struct Builder {
    @usableFromInline
    var elements: [RawAvailabilityArgumentSyntax] = []

    @inlinable
    public init() {}

    @inlinable
    mutating func append(_ element: RawAvailabilityArgumentSyntax) {
      elements.append(element)
    }

    @inlinable
    mutating func build(arena: SyntaxArena) -> RawAvailabilitySpecListSyntax {
      RawAvailabilitySpecListSyntax.make(arena: arena, elements: elements)
    }
  }

  public static func make(arena: SyntaxArena, elements: [RawAvailabilityArgumentSyntax]) -> Self {
    let raw = RawSyntax.makeLayout(arena: arena, kind: syntaxKind,
                                   uninitializedCount: elements.count) { layout in
      _ = layout.initialize(from: elements.map { $0.raw })
    }
    return .init(raw: raw)
  }

  public static func makeBlank(arena: SyntaxArena) -> Self {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: syntaxKind)
    return .init(raw: raw)
  }
}

extension RawSyntaxNodeProtocol {
  fileprivate func elem<Cursor: RawRepresentable>(at index: Cursor) -> RawSyntax? where Cursor.RawValue == Int {
    raw.children[index.rawValue]
  }
}

extension RawCodeBlockItemSyntax {
  typealias Cursor = CodeBlockItemSyntax.Cursor
  public var item: RawSyntax {
    elem(at: Cursor.item).map(RawSyntax.init(raw:))!
  }
  public var semicolon: RawTokenSyntax? {
    elem(at: Cursor.semicolon).map(RawTokenSyntax.init(raw:))
  }
  public var errorTokens: RawSyntax? {
    elem(at: Cursor.errorTokens).map(RawSyntax.init(raw:))
  }

  public struct Builder {
    public var item: RawSyntax? = nil
    public var semicolon: RawTokenSyntax? = nil
    public var errorTokens: RawSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawCodeBlockItemSyntax {
      .make(arena: arena
      , item: self.item
          ?? .makeBlank(arena: arena)
      , semicolon: self.semicolon
      , errorTokens: self.errorTokens
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawCodeBlockItemSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, item: RawSyntax, semicolon: RawTokenSyntax? = nil, errorTokens: RawSyntax? = nil) -> RawCodeBlockItemSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .codeBlockItem,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = item.raw
      layout[1] = semicolon?.raw
      layout[2] = errorTokens?.raw
    }
    return .init(raw: raw)
  }
}

extension RawCodeBlockSyntax {
  typealias Cursor = CodeBlockSyntax.Cursor
  public var leftBrace: RawTokenSyntax {
    elem(at: Cursor.leftBrace).map(RawTokenSyntax.init(raw:))!
  }
  public var statements: RawCodeBlockItemListSyntax {
    elem(at: Cursor.statements).map(RawCodeBlockItemListSyntax.init(raw:))!
  }
  public var rightBrace: RawTokenSyntax {
    elem(at: Cursor.rightBrace).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var leftBrace: RawTokenSyntax? = nil
    public var statements: RawCodeBlockItemListSyntax? = nil
    public var rightBrace: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawCodeBlockSyntax {
      .make(arena: arena
      , leftBrace: self.leftBrace
          ?? .makeBlank(arena: arena, tokenKind: .leftBrace)
      , statements: self.statements
          ?? .makeBlank(arena: arena)
      , rightBrace: self.rightBrace
          ?? .makeBlank(arena: arena, tokenKind: .rightBrace)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawCodeBlockSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, leftBrace: RawTokenSyntax, statements: RawCodeBlockItemListSyntax, rightBrace: RawTokenSyntax) -> RawCodeBlockSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .codeBlock,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = leftBrace.raw
      layout[1] = statements.raw
      layout[2] = rightBrace.raw
    }
    return .init(raw: raw)
  }
}

extension RawInOutExprSyntax {
  typealias Cursor = InOutExprSyntax.Cursor
  public var ampersand: RawTokenSyntax {
    elem(at: Cursor.ampersand).map(RawTokenSyntax.init(raw:))!
  }
  public var expression: RawExprSyntax {
    elem(at: Cursor.expression).map(RawExprSyntax.init(raw:))!
  }

  public struct Builder {
    public var ampersand: RawTokenSyntax? = nil
    public var expression: RawExprSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawInOutExprSyntax {
      .make(arena: arena
      , ampersand: self.ampersand
          ?? .makeBlank(arena: arena, tokenKind: .prefixAmpersand)
      , expression: self.expression
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawInOutExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, ampersand: RawTokenSyntax, expression: RawExprSyntax) -> RawInOutExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .inOutExpr,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = ampersand.raw
      layout[1] = expression.raw
    }
    return .init(raw: raw)
  }
}

extension RawPoundColumnExprSyntax {
  typealias Cursor = PoundColumnExprSyntax.Cursor
  public var poundColumn: RawTokenSyntax {
    elem(at: Cursor.poundColumn).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var poundColumn: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawPoundColumnExprSyntax {
      .make(arena: arena
      , poundColumn: self.poundColumn
          ?? .makeBlank(arena: arena, tokenKind: .poundColumnKeyword)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawPoundColumnExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, poundColumn: RawTokenSyntax) -> RawPoundColumnExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundColumnExpr,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = poundColumn.raw
    }
    return .init(raw: raw)
  }
}

extension RawTryExprSyntax {
  typealias Cursor = TryExprSyntax.Cursor
  public var tryKeyword: RawTokenSyntax {
    elem(at: Cursor.tryKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var questionOrExclamationMark: RawTokenSyntax? {
    elem(at: Cursor.questionOrExclamationMark).map(RawTokenSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    elem(at: Cursor.expression).map(RawExprSyntax.init(raw:))!
  }

  public struct Builder {
    public var tryKeyword: RawTokenSyntax? = nil
    public var questionOrExclamationMark: RawTokenSyntax? = nil
    public var expression: RawExprSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawTryExprSyntax {
      .make(arena: arena
      , tryKeyword: self.tryKeyword
          ?? .makeBlank(arena: arena, tokenKind: .tryKeyword)
      , questionOrExclamationMark: self.questionOrExclamationMark
      , expression: self.expression
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawTryExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, tryKeyword: RawTokenSyntax, questionOrExclamationMark: RawTokenSyntax? = nil, expression: RawExprSyntax) -> RawTryExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .tryExpr,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = tryKeyword.raw
      layout[1] = questionOrExclamationMark?.raw
      layout[2] = expression.raw
    }
    return .init(raw: raw)
  }
}

extension RawAwaitExprSyntax {
  typealias Cursor = AwaitExprSyntax.Cursor
  public var awaitKeyword: RawTokenSyntax {
    elem(at: Cursor.awaitKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var expression: RawExprSyntax {
    elem(at: Cursor.expression).map(RawExprSyntax.init(raw:))!
  }

  public struct Builder {
    public var awaitKeyword: RawTokenSyntax? = nil
    public var expression: RawExprSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawAwaitExprSyntax {
      .make(arena: arena
      , awaitKeyword: self.awaitKeyword
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , expression: self.expression
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawAwaitExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, awaitKeyword: RawTokenSyntax, expression: RawExprSyntax) -> RawAwaitExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .awaitExpr,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = awaitKeyword.raw
      layout[1] = expression.raw
    }
    return .init(raw: raw)
  }
}

extension RawDeclNameArgumentSyntax {
  typealias Cursor = DeclNameArgumentSyntax.Cursor
  public var name: RawTokenSyntax {
    elem(at: Cursor.name).map(RawTokenSyntax.init(raw:))!
  }
  public var colon: RawTokenSyntax {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var name: RawTokenSyntax? = nil
    public var colon: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawDeclNameArgumentSyntax {
      .make(arena: arena
      , name: self.name
          ?? .makeBlank(arena: arena, tokenKind: .unknown)
      , colon: self.colon
          ?? .makeBlank(arena: arena, tokenKind: .colon)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawDeclNameArgumentSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, name: RawTokenSyntax, colon: RawTokenSyntax) -> RawDeclNameArgumentSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .declNameArgument,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = name.raw
      layout[1] = colon.raw
    }
    return .init(raw: raw)
  }
}

extension RawDeclNameArgumentsSyntax {
  typealias Cursor = DeclNameArgumentsSyntax.Cursor
  public var leftParen: RawTokenSyntax {
    elem(at: Cursor.leftParen).map(RawTokenSyntax.init(raw:))!
  }
  public var arguments: RawDeclNameArgumentListSyntax {
    elem(at: Cursor.arguments).map(RawDeclNameArgumentListSyntax.init(raw:))!
  }
  public var rightParen: RawTokenSyntax {
    elem(at: Cursor.rightParen).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var leftParen: RawTokenSyntax? = nil
    public var arguments: RawDeclNameArgumentListSyntax? = nil
    public var rightParen: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawDeclNameArgumentsSyntax {
      .make(arena: arena
      , leftParen: self.leftParen
          ?? .makeBlank(arena: arena, tokenKind: .leftParen)
      , arguments: self.arguments
          ?? .makeBlank(arena: arena)
      , rightParen: self.rightParen
          ?? .makeBlank(arena: arena, tokenKind: .rightParen)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawDeclNameArgumentsSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, leftParen: RawTokenSyntax, arguments: RawDeclNameArgumentListSyntax, rightParen: RawTokenSyntax) -> RawDeclNameArgumentsSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .declNameArguments,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = leftParen.raw
      layout[1] = arguments.raw
      layout[2] = rightParen.raw
    }
    return .init(raw: raw)
  }
}

extension RawIdentifierExprSyntax {
  typealias Cursor = IdentifierExprSyntax.Cursor
  public var identifier: RawTokenSyntax {
    elem(at: Cursor.identifier).map(RawTokenSyntax.init(raw:))!
  }
  public var declNameArguments: RawDeclNameArgumentsSyntax? {
    elem(at: Cursor.declNameArguments).map(RawDeclNameArgumentsSyntax.init(raw:))
  }

  public struct Builder {
    public var identifier: RawTokenSyntax? = nil
    public var declNameArguments: RawDeclNameArgumentsSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawIdentifierExprSyntax {
      .make(arena: arena
      , identifier: self.identifier
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , declNameArguments: self.declNameArguments
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawIdentifierExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, identifier: RawTokenSyntax, declNameArguments: RawDeclNameArgumentsSyntax? = nil) -> RawIdentifierExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .identifierExpr,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = identifier.raw
      layout[1] = declNameArguments?.raw
    }
    return .init(raw: raw)
  }
}

extension RawSuperRefExprSyntax {
  typealias Cursor = SuperRefExprSyntax.Cursor
  public var superKeyword: RawTokenSyntax {
    elem(at: Cursor.superKeyword).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var superKeyword: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawSuperRefExprSyntax {
      .make(arena: arena
      , superKeyword: self.superKeyword
          ?? .makeBlank(arena: arena, tokenKind: .superKeyword)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawSuperRefExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, superKeyword: RawTokenSyntax) -> RawSuperRefExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .superRefExpr,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = superKeyword.raw
    }
    return .init(raw: raw)
  }
}

extension RawNilLiteralExprSyntax {
  typealias Cursor = NilLiteralExprSyntax.Cursor
  public var nilKeyword: RawTokenSyntax {
    elem(at: Cursor.nilKeyword).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var nilKeyword: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawNilLiteralExprSyntax {
      .make(arena: arena
      , nilKeyword: self.nilKeyword
          ?? .makeBlank(arena: arena, tokenKind: .nilKeyword)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawNilLiteralExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, nilKeyword: RawTokenSyntax) -> RawNilLiteralExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .nilLiteralExpr,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = nilKeyword.raw
    }
    return .init(raw: raw)
  }
}

extension RawDiscardAssignmentExprSyntax {
  typealias Cursor = DiscardAssignmentExprSyntax.Cursor
  public var wildcard: RawTokenSyntax {
    elem(at: Cursor.wildcard).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var wildcard: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawDiscardAssignmentExprSyntax {
      .make(arena: arena
      , wildcard: self.wildcard
          ?? .makeBlank(arena: arena, tokenKind: .wildcardKeyword)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawDiscardAssignmentExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, wildcard: RawTokenSyntax) -> RawDiscardAssignmentExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .discardAssignmentExpr,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = wildcard.raw
    }
    return .init(raw: raw)
  }
}

extension RawAssignmentExprSyntax {
  typealias Cursor = AssignmentExprSyntax.Cursor
  public var assignToken: RawTokenSyntax {
    elem(at: Cursor.assignToken).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var assignToken: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawAssignmentExprSyntax {
      .make(arena: arena
      , assignToken: self.assignToken
          ?? .makeBlank(arena: arena, tokenKind: .equal)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawAssignmentExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, assignToken: RawTokenSyntax) -> RawAssignmentExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .assignmentExpr,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = assignToken.raw
    }
    return .init(raw: raw)
  }
}

extension RawSequenceExprSyntax {
  typealias Cursor = SequenceExprSyntax.Cursor
  public var elements: RawExprListSyntax {
    elem(at: Cursor.elements).map(RawExprListSyntax.init(raw:))!
  }

  public struct Builder {
    public var elements: RawExprListSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawSequenceExprSyntax {
      .make(arena: arena
      , elements: self.elements
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawSequenceExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, elements: RawExprListSyntax) -> RawSequenceExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .sequenceExpr,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = elements.raw
    }
    return .init(raw: raw)
  }
}

extension RawPoundLineExprSyntax {
  typealias Cursor = PoundLineExprSyntax.Cursor
  public var poundLine: RawTokenSyntax {
    elem(at: Cursor.poundLine).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var poundLine: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawPoundLineExprSyntax {
      .make(arena: arena
      , poundLine: self.poundLine
          ?? .makeBlank(arena: arena, tokenKind: .poundLineKeyword)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawPoundLineExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, poundLine: RawTokenSyntax) -> RawPoundLineExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundLineExpr,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = poundLine.raw
    }
    return .init(raw: raw)
  }
}

extension RawPoundFileExprSyntax {
  typealias Cursor = PoundFileExprSyntax.Cursor
  public var poundFile: RawTokenSyntax {
    elem(at: Cursor.poundFile).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var poundFile: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawPoundFileExprSyntax {
      .make(arena: arena
      , poundFile: self.poundFile
          ?? .makeBlank(arena: arena, tokenKind: .poundFileKeyword)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawPoundFileExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, poundFile: RawTokenSyntax) -> RawPoundFileExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundFileExpr,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = poundFile.raw
    }
    return .init(raw: raw)
  }
}

extension RawPoundFileIDExprSyntax {
  typealias Cursor = PoundFileIDExprSyntax.Cursor
  public var poundFileID: RawTokenSyntax {
    elem(at: Cursor.poundFileID).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var poundFileID: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawPoundFileIDExprSyntax {
      .make(arena: arena
      , poundFileID: self.poundFileID
          ?? .makeBlank(arena: arena, tokenKind: .poundFileIDKeyword)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawPoundFileIDExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, poundFileID: RawTokenSyntax) -> RawPoundFileIDExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundFileIDExpr,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = poundFileID.raw
    }
    return .init(raw: raw)
  }
}

extension RawPoundFilePathExprSyntax {
  typealias Cursor = PoundFilePathExprSyntax.Cursor
  public var poundFilePath: RawTokenSyntax {
    elem(at: Cursor.poundFilePath).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var poundFilePath: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawPoundFilePathExprSyntax {
      .make(arena: arena
      , poundFilePath: self.poundFilePath
          ?? .makeBlank(arena: arena, tokenKind: .poundFilePathKeyword)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawPoundFilePathExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, poundFilePath: RawTokenSyntax) -> RawPoundFilePathExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundFilePathExpr,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = poundFilePath.raw
    }
    return .init(raw: raw)
  }
}

extension RawPoundFunctionExprSyntax {
  typealias Cursor = PoundFunctionExprSyntax.Cursor
  public var poundFunction: RawTokenSyntax {
    elem(at: Cursor.poundFunction).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var poundFunction: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawPoundFunctionExprSyntax {
      .make(arena: arena
      , poundFunction: self.poundFunction
          ?? .makeBlank(arena: arena, tokenKind: .poundFunctionKeyword)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawPoundFunctionExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, poundFunction: RawTokenSyntax) -> RawPoundFunctionExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundFunctionExpr,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = poundFunction.raw
    }
    return .init(raw: raw)
  }
}

extension RawPoundDsohandleExprSyntax {
  typealias Cursor = PoundDsohandleExprSyntax.Cursor
  public var poundDsohandle: RawTokenSyntax {
    elem(at: Cursor.poundDsohandle).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var poundDsohandle: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawPoundDsohandleExprSyntax {
      .make(arena: arena
      , poundDsohandle: self.poundDsohandle
          ?? .makeBlank(arena: arena, tokenKind: .poundDsohandleKeyword)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawPoundDsohandleExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, poundDsohandle: RawTokenSyntax) -> RawPoundDsohandleExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundDsohandleExpr,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = poundDsohandle.raw
    }
    return .init(raw: raw)
  }
}

extension RawSymbolicReferenceExprSyntax {
  typealias Cursor = SymbolicReferenceExprSyntax.Cursor
  public var identifier: RawTokenSyntax {
    elem(at: Cursor.identifier).map(RawTokenSyntax.init(raw:))!
  }
  public var genericArgumentClause: RawGenericArgumentClauseSyntax? {
    elem(at: Cursor.genericArgumentClause).map(RawGenericArgumentClauseSyntax.init(raw:))
  }

  public struct Builder {
    public var identifier: RawTokenSyntax? = nil
    public var genericArgumentClause: RawGenericArgumentClauseSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawSymbolicReferenceExprSyntax {
      .make(arena: arena
      , identifier: self.identifier
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , genericArgumentClause: self.genericArgumentClause
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawSymbolicReferenceExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, identifier: RawTokenSyntax, genericArgumentClause: RawGenericArgumentClauseSyntax? = nil) -> RawSymbolicReferenceExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .symbolicReferenceExpr,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = identifier.raw
      layout[1] = genericArgumentClause?.raw
    }
    return .init(raw: raw)
  }
}

extension RawPrefixOperatorExprSyntax {
  typealias Cursor = PrefixOperatorExprSyntax.Cursor
  public var operatorToken: RawTokenSyntax? {
    elem(at: Cursor.operatorToken).map(RawTokenSyntax.init(raw:))
  }
  public var postfixExpression: RawExprSyntax {
    elem(at: Cursor.postfixExpression).map(RawExprSyntax.init(raw:))!
  }

  public struct Builder {
    public var operatorToken: RawTokenSyntax? = nil
    public var postfixExpression: RawExprSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawPrefixOperatorExprSyntax {
      .make(arena: arena
      , operatorToken: self.operatorToken
      , postfixExpression: self.postfixExpression
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawPrefixOperatorExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, operatorToken: RawTokenSyntax? = nil, postfixExpression: RawExprSyntax) -> RawPrefixOperatorExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .prefixOperatorExpr,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = operatorToken?.raw
      layout[1] = postfixExpression.raw
    }
    return .init(raw: raw)
  }
}

extension RawBinaryOperatorExprSyntax {
  typealias Cursor = BinaryOperatorExprSyntax.Cursor
  public var operatorToken: RawTokenSyntax {
    elem(at: Cursor.operatorToken).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var operatorToken: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawBinaryOperatorExprSyntax {
      .make(arena: arena
      , operatorToken: self.operatorToken
          ?? .makeBlank(arena: arena, tokenKind: .unknown)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawBinaryOperatorExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, operatorToken: RawTokenSyntax) -> RawBinaryOperatorExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .binaryOperatorExpr,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = operatorToken.raw
    }
    return .init(raw: raw)
  }
}

extension RawArrowExprSyntax {
  typealias Cursor = ArrowExprSyntax.Cursor
  public var asyncKeyword: RawTokenSyntax? {
    elem(at: Cursor.asyncKeyword).map(RawTokenSyntax.init(raw:))
  }
  public var throwsToken: RawTokenSyntax? {
    elem(at: Cursor.throwsToken).map(RawTokenSyntax.init(raw:))
  }
  public var arrowToken: RawTokenSyntax {
    elem(at: Cursor.arrowToken).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var asyncKeyword: RawTokenSyntax? = nil
    public var throwsToken: RawTokenSyntax? = nil
    public var arrowToken: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawArrowExprSyntax {
      .make(arena: arena
      , asyncKeyword: self.asyncKeyword
      , throwsToken: self.throwsToken
      , arrowToken: self.arrowToken
          ?? .makeBlank(arena: arena, tokenKind: .arrow)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawArrowExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, asyncKeyword: RawTokenSyntax? = nil, throwsToken: RawTokenSyntax? = nil, arrowToken: RawTokenSyntax) -> RawArrowExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .arrowExpr,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = asyncKeyword?.raw
      layout[1] = throwsToken?.raw
      layout[2] = arrowToken.raw
    }
    return .init(raw: raw)
  }
}

extension RawFloatLiteralExprSyntax {
  typealias Cursor = FloatLiteralExprSyntax.Cursor
  public var floatingDigits: RawTokenSyntax {
    elem(at: Cursor.floatingDigits).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var floatingDigits: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawFloatLiteralExprSyntax {
      .make(arena: arena
      , floatingDigits: self.floatingDigits
          ?? .makeBlank(arena: arena, tokenKind: .floatingLiteral)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawFloatLiteralExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, floatingDigits: RawTokenSyntax) -> RawFloatLiteralExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .floatLiteralExpr,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = floatingDigits.raw
    }
    return .init(raw: raw)
  }
}

extension RawTupleExprSyntax {
  typealias Cursor = TupleExprSyntax.Cursor
  public var leftParen: RawTokenSyntax {
    elem(at: Cursor.leftParen).map(RawTokenSyntax.init(raw:))!
  }
  public var elementList: RawTupleExprElementListSyntax {
    elem(at: Cursor.elementList).map(RawTupleExprElementListSyntax.init(raw:))!
  }
  public var rightParen: RawTokenSyntax {
    elem(at: Cursor.rightParen).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var leftParen: RawTokenSyntax? = nil
    public var elementList: RawTupleExprElementListSyntax? = nil
    public var rightParen: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawTupleExprSyntax {
      .make(arena: arena
      , leftParen: self.leftParen
          ?? .makeBlank(arena: arena, tokenKind: .leftParen)
      , elementList: self.elementList
          ?? .makeBlank(arena: arena)
      , rightParen: self.rightParen
          ?? .makeBlank(arena: arena, tokenKind: .rightParen)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawTupleExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, leftParen: RawTokenSyntax, elementList: RawTupleExprElementListSyntax, rightParen: RawTokenSyntax) -> RawTupleExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .tupleExpr,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = leftParen.raw
      layout[1] = elementList.raw
      layout[2] = rightParen.raw
    }
    return .init(raw: raw)
  }
}

extension RawArrayExprSyntax {
  typealias Cursor = ArrayExprSyntax.Cursor
  public var leftSquare: RawTokenSyntax {
    elem(at: Cursor.leftSquare).map(RawTokenSyntax.init(raw:))!
  }
  public var elements: RawArrayElementListSyntax {
    elem(at: Cursor.elements).map(RawArrayElementListSyntax.init(raw:))!
  }
  public var rightSquare: RawTokenSyntax {
    elem(at: Cursor.rightSquare).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var leftSquare: RawTokenSyntax? = nil
    public var elements: RawArrayElementListSyntax? = nil
    public var rightSquare: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawArrayExprSyntax {
      .make(arena: arena
      , leftSquare: self.leftSquare
          ?? .makeBlank(arena: arena, tokenKind: .leftSquareBracket)
      , elements: self.elements
          ?? .makeBlank(arena: arena)
      , rightSquare: self.rightSquare
          ?? .makeBlank(arena: arena, tokenKind: .rightSquareBracket)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawArrayExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, leftSquare: RawTokenSyntax, elements: RawArrayElementListSyntax, rightSquare: RawTokenSyntax) -> RawArrayExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .arrayExpr,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = leftSquare.raw
      layout[1] = elements.raw
      layout[2] = rightSquare.raw
    }
    return .init(raw: raw)
  }
}

extension RawDictionaryExprSyntax {
  typealias Cursor = DictionaryExprSyntax.Cursor
  public var leftSquare: RawTokenSyntax {
    elem(at: Cursor.leftSquare).map(RawTokenSyntax.init(raw:))!
  }
  public var content: RawSyntax {
    elem(at: Cursor.content).map(RawSyntax.init(raw:))!
  }
  public var rightSquare: RawTokenSyntax {
    elem(at: Cursor.rightSquare).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var leftSquare: RawTokenSyntax? = nil
    public var content: RawSyntax? = nil
    public var rightSquare: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawDictionaryExprSyntax {
      .make(arena: arena
      , leftSquare: self.leftSquare
          ?? .makeBlank(arena: arena, tokenKind: .leftSquareBracket)
      , content: self.content
          ?? .makeBlank(arena: arena)
      , rightSquare: self.rightSquare
          ?? .makeBlank(arena: arena, tokenKind: .rightSquareBracket)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawDictionaryExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, leftSquare: RawTokenSyntax, content: RawSyntax, rightSquare: RawTokenSyntax) -> RawDictionaryExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .dictionaryExpr,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = leftSquare.raw
      layout[1] = content.raw
      layout[2] = rightSquare.raw
    }
    return .init(raw: raw)
  }
}

extension RawTupleExprElementSyntax {
  typealias Cursor = TupleExprElementSyntax.Cursor
  public var label: RawTokenSyntax? {
    elem(at: Cursor.label).map(RawTokenSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax? {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    elem(at: Cursor.expression).map(RawExprSyntax.init(raw:))!
  }
  public var trailingComma: RawTokenSyntax? {
    elem(at: Cursor.trailingComma).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var label: RawTokenSyntax? = nil
    public var colon: RawTokenSyntax? = nil
    public var expression: RawExprSyntax? = nil
    public var trailingComma: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawTupleExprElementSyntax {
      .make(arena: arena
      , label: self.label
      , colon: self.colon
      , expression: self.expression
          ?? .makeBlank(arena: arena)
      , trailingComma: self.trailingComma
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawTupleExprElementSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, label: RawTokenSyntax? = nil, colon: RawTokenSyntax? = nil, expression: RawExprSyntax, trailingComma: RawTokenSyntax? = nil) -> RawTupleExprElementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .tupleExprElement,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = label?.raw
      layout[1] = colon?.raw
      layout[2] = expression.raw
      layout[3] = trailingComma?.raw
    }
    return .init(raw: raw)
  }
}

extension RawArrayElementSyntax {
  typealias Cursor = ArrayElementSyntax.Cursor
  public var expression: RawExprSyntax {
    elem(at: Cursor.expression).map(RawExprSyntax.init(raw:))!
  }
  public var trailingComma: RawTokenSyntax? {
    elem(at: Cursor.trailingComma).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var expression: RawExprSyntax? = nil
    public var trailingComma: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawArrayElementSyntax {
      .make(arena: arena
      , expression: self.expression
          ?? .makeBlank(arena: arena)
      , trailingComma: self.trailingComma
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawArrayElementSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, expression: RawExprSyntax, trailingComma: RawTokenSyntax? = nil) -> RawArrayElementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .arrayElement,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = expression.raw
      layout[1] = trailingComma?.raw
    }
    return .init(raw: raw)
  }
}

extension RawDictionaryElementSyntax {
  typealias Cursor = DictionaryElementSyntax.Cursor
  public var keyExpression: RawExprSyntax {
    elem(at: Cursor.keyExpression).map(RawExprSyntax.init(raw:))!
  }
  public var colon: RawTokenSyntax {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))!
  }
  public var valueExpression: RawExprSyntax {
    elem(at: Cursor.valueExpression).map(RawExprSyntax.init(raw:))!
  }
  public var trailingComma: RawTokenSyntax? {
    elem(at: Cursor.trailingComma).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var keyExpression: RawExprSyntax? = nil
    public var colon: RawTokenSyntax? = nil
    public var valueExpression: RawExprSyntax? = nil
    public var trailingComma: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawDictionaryElementSyntax {
      .make(arena: arena
      , keyExpression: self.keyExpression
          ?? .makeBlank(arena: arena)
      , colon: self.colon
          ?? .makeBlank(arena: arena, tokenKind: .colon)
      , valueExpression: self.valueExpression
          ?? .makeBlank(arena: arena)
      , trailingComma: self.trailingComma
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawDictionaryElementSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, keyExpression: RawExprSyntax, colon: RawTokenSyntax, valueExpression: RawExprSyntax, trailingComma: RawTokenSyntax? = nil) -> RawDictionaryElementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .dictionaryElement,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = keyExpression.raw
      layout[1] = colon.raw
      layout[2] = valueExpression.raw
      layout[3] = trailingComma?.raw
    }
    return .init(raw: raw)
  }
}

extension RawIntegerLiteralExprSyntax {
  typealias Cursor = IntegerLiteralExprSyntax.Cursor
  public var digits: RawTokenSyntax {
    elem(at: Cursor.digits).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var digits: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawIntegerLiteralExprSyntax {
      .make(arena: arena
      , digits: self.digits
          ?? .makeBlank(arena: arena, tokenKind: .integerLiteral)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawIntegerLiteralExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, digits: RawTokenSyntax) -> RawIntegerLiteralExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .integerLiteralExpr,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = digits.raw
    }
    return .init(raw: raw)
  }
}

extension RawBooleanLiteralExprSyntax {
  typealias Cursor = BooleanLiteralExprSyntax.Cursor
  public var booleanLiteral: RawTokenSyntax {
    elem(at: Cursor.booleanLiteral).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var booleanLiteral: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawBooleanLiteralExprSyntax {
      .make(arena: arena
      , booleanLiteral: self.booleanLiteral
          ?? .makeBlank(arena: arena, tokenKind: .trueKeyword)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawBooleanLiteralExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, booleanLiteral: RawTokenSyntax) -> RawBooleanLiteralExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .booleanLiteralExpr,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = booleanLiteral.raw
    }
    return .init(raw: raw)
  }
}

extension RawTernaryExprSyntax {
  typealias Cursor = TernaryExprSyntax.Cursor
  public var conditionExpression: RawExprSyntax {
    elem(at: Cursor.conditionExpression).map(RawExprSyntax.init(raw:))!
  }
  public var questionMark: RawTokenSyntax {
    elem(at: Cursor.questionMark).map(RawTokenSyntax.init(raw:))!
  }
  public var firstChoice: RawExprSyntax {
    elem(at: Cursor.firstChoice).map(RawExprSyntax.init(raw:))!
  }
  public var colonMark: RawTokenSyntax {
    elem(at: Cursor.colonMark).map(RawTokenSyntax.init(raw:))!
  }
  public var secondChoice: RawExprSyntax {
    elem(at: Cursor.secondChoice).map(RawExprSyntax.init(raw:))!
  }

  public struct Builder {
    public var conditionExpression: RawExprSyntax? = nil
    public var questionMark: RawTokenSyntax? = nil
    public var firstChoice: RawExprSyntax? = nil
    public var colonMark: RawTokenSyntax? = nil
    public var secondChoice: RawExprSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawTernaryExprSyntax {
      .make(arena: arena
      , conditionExpression: self.conditionExpression
          ?? .makeBlank(arena: arena)
      , questionMark: self.questionMark
          ?? .makeBlank(arena: arena, tokenKind: .infixQuestionMark)
      , firstChoice: self.firstChoice
          ?? .makeBlank(arena: arena)
      , colonMark: self.colonMark
          ?? .makeBlank(arena: arena, tokenKind: .colon)
      , secondChoice: self.secondChoice
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawTernaryExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, conditionExpression: RawExprSyntax, questionMark: RawTokenSyntax, firstChoice: RawExprSyntax, colonMark: RawTokenSyntax, secondChoice: RawExprSyntax) -> RawTernaryExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .ternaryExpr,
                                   uninitializedCount: 5) { layout in
      layout.initialize(repeating: nil)
      layout[0] = conditionExpression.raw
      layout[1] = questionMark.raw
      layout[2] = firstChoice.raw
      layout[3] = colonMark.raw
      layout[4] = secondChoice.raw
    }
    return .init(raw: raw)
  }
}

extension RawMemberAccessExprSyntax {
  typealias Cursor = MemberAccessExprSyntax.Cursor
  public var base: RawExprSyntax? {
    elem(at: Cursor.base).map(RawExprSyntax.init(raw:))
  }
  public var dot: RawTokenSyntax {
    elem(at: Cursor.dot).map(RawTokenSyntax.init(raw:))!
  }
  public var name: RawTokenSyntax {
    elem(at: Cursor.name).map(RawTokenSyntax.init(raw:))!
  }
  public var declNameArguments: RawDeclNameArgumentsSyntax? {
    elem(at: Cursor.declNameArguments).map(RawDeclNameArgumentsSyntax.init(raw:))
  }

  public struct Builder {
    public var base: RawExprSyntax? = nil
    public var dot: RawTokenSyntax? = nil
    public var name: RawTokenSyntax? = nil
    public var declNameArguments: RawDeclNameArgumentsSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawMemberAccessExprSyntax {
      .make(arena: arena
      , base: self.base
      , dot: self.dot
          ?? .makeBlank(arena: arena, tokenKind: .period)
      , name: self.name
          ?? .makeBlank(arena: arena, tokenKind: .unknown)
      , declNameArguments: self.declNameArguments
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawMemberAccessExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, base: RawExprSyntax? = nil, dot: RawTokenSyntax, name: RawTokenSyntax, declNameArguments: RawDeclNameArgumentsSyntax? = nil) -> RawMemberAccessExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .memberAccessExpr,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = base?.raw
      layout[1] = dot.raw
      layout[2] = name.raw
      layout[3] = declNameArguments?.raw
    }
    return .init(raw: raw)
  }
}

extension RawIsExprSyntax {
  typealias Cursor = IsExprSyntax.Cursor
  public var isTok: RawTokenSyntax {
    elem(at: Cursor.isTok).map(RawTokenSyntax.init(raw:))!
  }
  public var typeName: RawTypeSyntax {
    elem(at: Cursor.typeName).map(RawTypeSyntax.init(raw:))!
  }

  public struct Builder {
    public var isTok: RawTokenSyntax? = nil
    public var typeName: RawTypeSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawIsExprSyntax {
      .make(arena: arena
      , isTok: self.isTok
          ?? .makeBlank(arena: arena, tokenKind: .isKeyword)
      , typeName: self.typeName
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawIsExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, isTok: RawTokenSyntax, typeName: RawTypeSyntax) -> RawIsExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .isExpr,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = isTok.raw
      layout[1] = typeName.raw
    }
    return .init(raw: raw)
  }
}

extension RawAsExprSyntax {
  typealias Cursor = AsExprSyntax.Cursor
  public var asTok: RawTokenSyntax {
    elem(at: Cursor.asTok).map(RawTokenSyntax.init(raw:))!
  }
  public var questionOrExclamationMark: RawTokenSyntax? {
    elem(at: Cursor.questionOrExclamationMark).map(RawTokenSyntax.init(raw:))
  }
  public var typeName: RawTypeSyntax {
    elem(at: Cursor.typeName).map(RawTypeSyntax.init(raw:))!
  }

  public struct Builder {
    public var asTok: RawTokenSyntax? = nil
    public var questionOrExclamationMark: RawTokenSyntax? = nil
    public var typeName: RawTypeSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawAsExprSyntax {
      .make(arena: arena
      , asTok: self.asTok
          ?? .makeBlank(arena: arena, tokenKind: .asKeyword)
      , questionOrExclamationMark: self.questionOrExclamationMark
      , typeName: self.typeName
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawAsExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, asTok: RawTokenSyntax, questionOrExclamationMark: RawTokenSyntax? = nil, typeName: RawTypeSyntax) -> RawAsExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .asExpr,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = asTok.raw
      layout[1] = questionOrExclamationMark?.raw
      layout[2] = typeName.raw
    }
    return .init(raw: raw)
  }
}

extension RawTypeExprSyntax {
  typealias Cursor = TypeExprSyntax.Cursor
  public var type: RawTypeSyntax {
    elem(at: Cursor.type).map(RawTypeSyntax.init(raw:))!
  }

  public struct Builder {
    public var type: RawTypeSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawTypeExprSyntax {
      .make(arena: arena
      , type: self.type
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawTypeExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, type: RawTypeSyntax) -> RawTypeExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .typeExpr,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = type.raw
    }
    return .init(raw: raw)
  }
}

extension RawClosureCaptureItemSyntax {
  typealias Cursor = ClosureCaptureItemSyntax.Cursor
  public var specifier: RawTokenListSyntax? {
    elem(at: Cursor.specifier).map(RawTokenListSyntax.init(raw:))
  }
  public var name: RawTokenSyntax? {
    elem(at: Cursor.name).map(RawTokenSyntax.init(raw:))
  }
  public var assignToken: RawTokenSyntax? {
    elem(at: Cursor.assignToken).map(RawTokenSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    elem(at: Cursor.expression).map(RawExprSyntax.init(raw:))!
  }
  public var trailingComma: RawTokenSyntax? {
    elem(at: Cursor.trailingComma).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var specifier: RawTokenListSyntax? = nil
    public var name: RawTokenSyntax? = nil
    public var assignToken: RawTokenSyntax? = nil
    public var expression: RawExprSyntax? = nil
    public var trailingComma: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawClosureCaptureItemSyntax {
      .make(arena: arena
      , specifier: self.specifier
      , name: self.name
      , assignToken: self.assignToken
      , expression: self.expression
          ?? .makeBlank(arena: arena)
      , trailingComma: self.trailingComma
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawClosureCaptureItemSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, specifier: RawTokenListSyntax? = nil, name: RawTokenSyntax? = nil, assignToken: RawTokenSyntax? = nil, expression: RawExprSyntax, trailingComma: RawTokenSyntax? = nil) -> RawClosureCaptureItemSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .closureCaptureItem,
                                   uninitializedCount: 5) { layout in
      layout.initialize(repeating: nil)
      layout[0] = specifier?.raw
      layout[1] = name?.raw
      layout[2] = assignToken?.raw
      layout[3] = expression.raw
      layout[4] = trailingComma?.raw
    }
    return .init(raw: raw)
  }
}

extension RawClosureCaptureSignatureSyntax {
  typealias Cursor = ClosureCaptureSignatureSyntax.Cursor
  public var leftSquare: RawTokenSyntax {
    elem(at: Cursor.leftSquare).map(RawTokenSyntax.init(raw:))!
  }
  public var items: RawClosureCaptureItemListSyntax? {
    elem(at: Cursor.items).map(RawClosureCaptureItemListSyntax.init(raw:))
  }
  public var rightSquare: RawTokenSyntax {
    elem(at: Cursor.rightSquare).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var leftSquare: RawTokenSyntax? = nil
    public var items: RawClosureCaptureItemListSyntax? = nil
    public var rightSquare: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawClosureCaptureSignatureSyntax {
      .make(arena: arena
      , leftSquare: self.leftSquare
          ?? .makeBlank(arena: arena, tokenKind: .leftSquareBracket)
      , items: self.items
      , rightSquare: self.rightSquare
          ?? .makeBlank(arena: arena, tokenKind: .rightSquareBracket)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawClosureCaptureSignatureSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, leftSquare: RawTokenSyntax, items: RawClosureCaptureItemListSyntax? = nil, rightSquare: RawTokenSyntax) -> RawClosureCaptureSignatureSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .closureCaptureSignature,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = leftSquare.raw
      layout[1] = items?.raw
      layout[2] = rightSquare.raw
    }
    return .init(raw: raw)
  }
}

extension RawClosureParamSyntax {
  typealias Cursor = ClosureParamSyntax.Cursor
  public var name: RawTokenSyntax {
    elem(at: Cursor.name).map(RawTokenSyntax.init(raw:))!
  }
  public var trailingComma: RawTokenSyntax? {
    elem(at: Cursor.trailingComma).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var name: RawTokenSyntax? = nil
    public var trailingComma: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawClosureParamSyntax {
      .make(arena: arena
      , name: self.name
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , trailingComma: self.trailingComma
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawClosureParamSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, name: RawTokenSyntax, trailingComma: RawTokenSyntax? = nil) -> RawClosureParamSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .closureParam,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = name.raw
      layout[1] = trailingComma?.raw
    }
    return .init(raw: raw)
  }
}

extension RawClosureSignatureSyntax {
  typealias Cursor = ClosureSignatureSyntax.Cursor
  public var attributes: RawAttributeListSyntax? {
    elem(at: Cursor.attributes).map(RawAttributeListSyntax.init(raw:))
  }
  public var capture: RawClosureCaptureSignatureSyntax? {
    elem(at: Cursor.capture).map(RawClosureCaptureSignatureSyntax.init(raw:))
  }
  public var input: RawSyntax? {
    elem(at: Cursor.input).map(RawSyntax.init(raw:))
  }
  public var asyncKeyword: RawTokenSyntax? {
    elem(at: Cursor.asyncKeyword).map(RawTokenSyntax.init(raw:))
  }
  public var throwsTok: RawTokenSyntax? {
    elem(at: Cursor.throwsTok).map(RawTokenSyntax.init(raw:))
  }
  public var output: RawReturnClauseSyntax? {
    elem(at: Cursor.output).map(RawReturnClauseSyntax.init(raw:))
  }
  public var inTok: RawTokenSyntax {
    elem(at: Cursor.inTok).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var attributes: RawAttributeListSyntax? = nil
    public var capture: RawClosureCaptureSignatureSyntax? = nil
    public var input: RawSyntax? = nil
    public var asyncKeyword: RawTokenSyntax? = nil
    public var throwsTok: RawTokenSyntax? = nil
    public var output: RawReturnClauseSyntax? = nil
    public var inTok: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawClosureSignatureSyntax {
      .make(arena: arena
      , attributes: self.attributes
      , capture: self.capture
      , input: self.input
      , asyncKeyword: self.asyncKeyword
      , throwsTok: self.throwsTok
      , output: self.output
      , inTok: self.inTok
          ?? .makeBlank(arena: arena, tokenKind: .inKeyword)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawClosureSignatureSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, attributes: RawAttributeListSyntax? = nil, capture: RawClosureCaptureSignatureSyntax? = nil, input: RawSyntax? = nil, asyncKeyword: RawTokenSyntax? = nil, throwsTok: RawTokenSyntax? = nil, output: RawReturnClauseSyntax? = nil, inTok: RawTokenSyntax) -> RawClosureSignatureSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .closureSignature,
                                   uninitializedCount: 7) { layout in
      layout.initialize(repeating: nil)
      layout[0] = attributes?.raw
      layout[1] = capture?.raw
      layout[2] = input?.raw
      layout[3] = asyncKeyword?.raw
      layout[4] = throwsTok?.raw
      layout[5] = output?.raw
      layout[6] = inTok.raw
    }
    return .init(raw: raw)
  }
}

extension RawClosureExprSyntax {
  typealias Cursor = ClosureExprSyntax.Cursor
  public var leftBrace: RawTokenSyntax {
    elem(at: Cursor.leftBrace).map(RawTokenSyntax.init(raw:))!
  }
  public var signature: RawClosureSignatureSyntax? {
    elem(at: Cursor.signature).map(RawClosureSignatureSyntax.init(raw:))
  }
  public var statements: RawCodeBlockItemListSyntax {
    elem(at: Cursor.statements).map(RawCodeBlockItemListSyntax.init(raw:))!
  }
  public var rightBrace: RawTokenSyntax {
    elem(at: Cursor.rightBrace).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var leftBrace: RawTokenSyntax? = nil
    public var signature: RawClosureSignatureSyntax? = nil
    public var statements: RawCodeBlockItemListSyntax? = nil
    public var rightBrace: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawClosureExprSyntax {
      .make(arena: arena
      , leftBrace: self.leftBrace
          ?? .makeBlank(arena: arena, tokenKind: .leftBrace)
      , signature: self.signature
      , statements: self.statements
          ?? .makeBlank(arena: arena)
      , rightBrace: self.rightBrace
          ?? .makeBlank(arena: arena, tokenKind: .rightBrace)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawClosureExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, leftBrace: RawTokenSyntax, signature: RawClosureSignatureSyntax? = nil, statements: RawCodeBlockItemListSyntax, rightBrace: RawTokenSyntax) -> RawClosureExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .closureExpr,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = leftBrace.raw
      layout[1] = signature?.raw
      layout[2] = statements.raw
      layout[3] = rightBrace.raw
    }
    return .init(raw: raw)
  }
}

extension RawUnresolvedPatternExprSyntax {
  typealias Cursor = UnresolvedPatternExprSyntax.Cursor
  public var pattern: RawPatternSyntax {
    elem(at: Cursor.pattern).map(RawPatternSyntax.init(raw:))!
  }

  public struct Builder {
    public var pattern: RawPatternSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawUnresolvedPatternExprSyntax {
      .make(arena: arena
      , pattern: self.pattern
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawUnresolvedPatternExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, pattern: RawPatternSyntax) -> RawUnresolvedPatternExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .unresolvedPatternExpr,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = pattern.raw
    }
    return .init(raw: raw)
  }
}

extension RawMultipleTrailingClosureElementSyntax {
  typealias Cursor = MultipleTrailingClosureElementSyntax.Cursor
  public var label: RawTokenSyntax {
    elem(at: Cursor.label).map(RawTokenSyntax.init(raw:))!
  }
  public var colon: RawTokenSyntax {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))!
  }
  public var closure: RawClosureExprSyntax {
    elem(at: Cursor.closure).map(RawClosureExprSyntax.init(raw:))!
  }

  public struct Builder {
    public var label: RawTokenSyntax? = nil
    public var colon: RawTokenSyntax? = nil
    public var closure: RawClosureExprSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawMultipleTrailingClosureElementSyntax {
      .make(arena: arena
      , label: self.label
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , colon: self.colon
          ?? .makeBlank(arena: arena, tokenKind: .colon)
      , closure: self.closure
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawMultipleTrailingClosureElementSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, label: RawTokenSyntax, colon: RawTokenSyntax, closure: RawClosureExprSyntax) -> RawMultipleTrailingClosureElementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .multipleTrailingClosureElement,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = label.raw
      layout[1] = colon.raw
      layout[2] = closure.raw
    }
    return .init(raw: raw)
  }
}

extension RawFunctionCallExprSyntax {
  typealias Cursor = FunctionCallExprSyntax.Cursor
  public var calledExpression: RawExprSyntax {
    elem(at: Cursor.calledExpression).map(RawExprSyntax.init(raw:))!
  }
  public var leftParen: RawTokenSyntax? {
    elem(at: Cursor.leftParen).map(RawTokenSyntax.init(raw:))
  }
  public var argumentList: RawTupleExprElementListSyntax {
    elem(at: Cursor.argumentList).map(RawTupleExprElementListSyntax.init(raw:))!
  }
  public var rightParen: RawTokenSyntax? {
    elem(at: Cursor.rightParen).map(RawTokenSyntax.init(raw:))
  }
  public var trailingClosure: RawClosureExprSyntax? {
    elem(at: Cursor.trailingClosure).map(RawClosureExprSyntax.init(raw:))
  }
  public var additionalTrailingClosures: RawMultipleTrailingClosureElementListSyntax? {
    elem(at: Cursor.additionalTrailingClosures).map(RawMultipleTrailingClosureElementListSyntax.init(raw:))
  }

  public struct Builder {
    public var calledExpression: RawExprSyntax? = nil
    public var leftParen: RawTokenSyntax? = nil
    public var argumentList: RawTupleExprElementListSyntax? = nil
    public var rightParen: RawTokenSyntax? = nil
    public var trailingClosure: RawClosureExprSyntax? = nil
    public var additionalTrailingClosures: RawMultipleTrailingClosureElementListSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawFunctionCallExprSyntax {
      .make(arena: arena
      , calledExpression: self.calledExpression
          ?? .makeBlank(arena: arena)
      , leftParen: self.leftParen
      , argumentList: self.argumentList
          ?? .makeBlank(arena: arena)
      , rightParen: self.rightParen
      , trailingClosure: self.trailingClosure
      , additionalTrailingClosures: self.additionalTrailingClosures
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawFunctionCallExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, calledExpression: RawExprSyntax, leftParen: RawTokenSyntax? = nil, argumentList: RawTupleExprElementListSyntax, rightParen: RawTokenSyntax? = nil, trailingClosure: RawClosureExprSyntax? = nil, additionalTrailingClosures: RawMultipleTrailingClosureElementListSyntax? = nil) -> RawFunctionCallExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .functionCallExpr,
                                   uninitializedCount: 6) { layout in
      layout.initialize(repeating: nil)
      layout[0] = calledExpression.raw
      layout[1] = leftParen?.raw
      layout[2] = argumentList.raw
      layout[3] = rightParen?.raw
      layout[4] = trailingClosure?.raw
      layout[5] = additionalTrailingClosures?.raw
    }
    return .init(raw: raw)
  }
}

extension RawSubscriptExprSyntax {
  typealias Cursor = SubscriptExprSyntax.Cursor
  public var calledExpression: RawExprSyntax {
    elem(at: Cursor.calledExpression).map(RawExprSyntax.init(raw:))!
  }
  public var leftBracket: RawTokenSyntax {
    elem(at: Cursor.leftBracket).map(RawTokenSyntax.init(raw:))!
  }
  public var argumentList: RawTupleExprElementListSyntax {
    elem(at: Cursor.argumentList).map(RawTupleExprElementListSyntax.init(raw:))!
  }
  public var rightBracket: RawTokenSyntax {
    elem(at: Cursor.rightBracket).map(RawTokenSyntax.init(raw:))!
  }
  public var trailingClosure: RawClosureExprSyntax? {
    elem(at: Cursor.trailingClosure).map(RawClosureExprSyntax.init(raw:))
  }
  public var additionalTrailingClosures: RawMultipleTrailingClosureElementListSyntax? {
    elem(at: Cursor.additionalTrailingClosures).map(RawMultipleTrailingClosureElementListSyntax.init(raw:))
  }

  public struct Builder {
    public var calledExpression: RawExprSyntax? = nil
    public var leftBracket: RawTokenSyntax? = nil
    public var argumentList: RawTupleExprElementListSyntax? = nil
    public var rightBracket: RawTokenSyntax? = nil
    public var trailingClosure: RawClosureExprSyntax? = nil
    public var additionalTrailingClosures: RawMultipleTrailingClosureElementListSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawSubscriptExprSyntax {
      .make(arena: arena
      , calledExpression: self.calledExpression
          ?? .makeBlank(arena: arena)
      , leftBracket: self.leftBracket
          ?? .makeBlank(arena: arena, tokenKind: .leftSquareBracket)
      , argumentList: self.argumentList
          ?? .makeBlank(arena: arena)
      , rightBracket: self.rightBracket
          ?? .makeBlank(arena: arena, tokenKind: .rightSquareBracket)
      , trailingClosure: self.trailingClosure
      , additionalTrailingClosures: self.additionalTrailingClosures
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawSubscriptExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, calledExpression: RawExprSyntax, leftBracket: RawTokenSyntax, argumentList: RawTupleExprElementListSyntax, rightBracket: RawTokenSyntax, trailingClosure: RawClosureExprSyntax? = nil, additionalTrailingClosures: RawMultipleTrailingClosureElementListSyntax? = nil) -> RawSubscriptExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .subscriptExpr,
                                   uninitializedCount: 6) { layout in
      layout.initialize(repeating: nil)
      layout[0] = calledExpression.raw
      layout[1] = leftBracket.raw
      layout[2] = argumentList.raw
      layout[3] = rightBracket.raw
      layout[4] = trailingClosure?.raw
      layout[5] = additionalTrailingClosures?.raw
    }
    return .init(raw: raw)
  }
}

extension RawOptionalChainingExprSyntax {
  typealias Cursor = OptionalChainingExprSyntax.Cursor
  public var expression: RawExprSyntax {
    elem(at: Cursor.expression).map(RawExprSyntax.init(raw:))!
  }
  public var questionMark: RawTokenSyntax {
    elem(at: Cursor.questionMark).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var expression: RawExprSyntax? = nil
    public var questionMark: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawOptionalChainingExprSyntax {
      .make(arena: arena
      , expression: self.expression
          ?? .makeBlank(arena: arena)
      , questionMark: self.questionMark
          ?? .makeBlank(arena: arena, tokenKind: .postfixQuestionMark)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawOptionalChainingExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, expression: RawExprSyntax, questionMark: RawTokenSyntax) -> RawOptionalChainingExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .optionalChainingExpr,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = expression.raw
      layout[1] = questionMark.raw
    }
    return .init(raw: raw)
  }
}

extension RawForcedValueExprSyntax {
  typealias Cursor = ForcedValueExprSyntax.Cursor
  public var expression: RawExprSyntax {
    elem(at: Cursor.expression).map(RawExprSyntax.init(raw:))!
  }
  public var exclamationMark: RawTokenSyntax {
    elem(at: Cursor.exclamationMark).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var expression: RawExprSyntax? = nil
    public var exclamationMark: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawForcedValueExprSyntax {
      .make(arena: arena
      , expression: self.expression
          ?? .makeBlank(arena: arena)
      , exclamationMark: self.exclamationMark
          ?? .makeBlank(arena: arena, tokenKind: .exclamationMark)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawForcedValueExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, expression: RawExprSyntax, exclamationMark: RawTokenSyntax) -> RawForcedValueExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .forcedValueExpr,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = expression.raw
      layout[1] = exclamationMark.raw
    }
    return .init(raw: raw)
  }
}

extension RawPostfixUnaryExprSyntax {
  typealias Cursor = PostfixUnaryExprSyntax.Cursor
  public var expression: RawExprSyntax {
    elem(at: Cursor.expression).map(RawExprSyntax.init(raw:))!
  }
  public var operatorToken: RawTokenSyntax {
    elem(at: Cursor.operatorToken).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var expression: RawExprSyntax? = nil
    public var operatorToken: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawPostfixUnaryExprSyntax {
      .make(arena: arena
      , expression: self.expression
          ?? .makeBlank(arena: arena)
      , operatorToken: self.operatorToken
          ?? .makeBlank(arena: arena, tokenKind: .postfixOperator)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawPostfixUnaryExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, expression: RawExprSyntax, operatorToken: RawTokenSyntax) -> RawPostfixUnaryExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .postfixUnaryExpr,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = expression.raw
      layout[1] = operatorToken.raw
    }
    return .init(raw: raw)
  }
}

extension RawSpecializeExprSyntax {
  typealias Cursor = SpecializeExprSyntax.Cursor
  public var expression: RawExprSyntax {
    elem(at: Cursor.expression).map(RawExprSyntax.init(raw:))!
  }
  public var genericArgumentClause: RawGenericArgumentClauseSyntax {
    elem(at: Cursor.genericArgumentClause).map(RawGenericArgumentClauseSyntax.init(raw:))!
  }

  public struct Builder {
    public var expression: RawExprSyntax? = nil
    public var genericArgumentClause: RawGenericArgumentClauseSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawSpecializeExprSyntax {
      .make(arena: arena
      , expression: self.expression
          ?? .makeBlank(arena: arena)
      , genericArgumentClause: self.genericArgumentClause
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawSpecializeExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, expression: RawExprSyntax, genericArgumentClause: RawGenericArgumentClauseSyntax) -> RawSpecializeExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .specializeExpr,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = expression.raw
      layout[1] = genericArgumentClause.raw
    }
    return .init(raw: raw)
  }
}

extension RawStringSegmentSyntax {
  typealias Cursor = StringSegmentSyntax.Cursor
  public var content: RawTokenSyntax {
    elem(at: Cursor.content).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var content: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawStringSegmentSyntax {
      .make(arena: arena
      , content: self.content
          ?? .makeBlank(arena: arena, tokenKind: .stringSegment)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawStringSegmentSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, content: RawTokenSyntax) -> RawStringSegmentSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .stringSegment,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = content.raw
    }
    return .init(raw: raw)
  }
}

extension RawExpressionSegmentSyntax {
  typealias Cursor = ExpressionSegmentSyntax.Cursor
  public var backslash: RawTokenSyntax {
    elem(at: Cursor.backslash).map(RawTokenSyntax.init(raw:))!
  }
  public var delimiter: RawTokenSyntax? {
    elem(at: Cursor.delimiter).map(RawTokenSyntax.init(raw:))
  }
  public var leftParen: RawTokenSyntax {
    elem(at: Cursor.leftParen).map(RawTokenSyntax.init(raw:))!
  }
  public var expressions: RawTupleExprElementListSyntax {
    elem(at: Cursor.expressions).map(RawTupleExprElementListSyntax.init(raw:))!
  }
  public var rightParen: RawTokenSyntax {
    elem(at: Cursor.rightParen).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var backslash: RawTokenSyntax? = nil
    public var delimiter: RawTokenSyntax? = nil
    public var leftParen: RawTokenSyntax? = nil
    public var expressions: RawTupleExprElementListSyntax? = nil
    public var rightParen: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawExpressionSegmentSyntax {
      .make(arena: arena
      , backslash: self.backslash
          ?? .makeBlank(arena: arena, tokenKind: .backslash)
      , delimiter: self.delimiter
      , leftParen: self.leftParen
          ?? .makeBlank(arena: arena, tokenKind: .leftParen)
      , expressions: self.expressions
          ?? .makeBlank(arena: arena)
      , rightParen: self.rightParen
          ?? .makeBlank(arena: arena, tokenKind: .stringInterpolationAnchor)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawExpressionSegmentSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, backslash: RawTokenSyntax, delimiter: RawTokenSyntax? = nil, leftParen: RawTokenSyntax, expressions: RawTupleExprElementListSyntax, rightParen: RawTokenSyntax) -> RawExpressionSegmentSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .expressionSegment,
                                   uninitializedCount: 5) { layout in
      layout.initialize(repeating: nil)
      layout[0] = backslash.raw
      layout[1] = delimiter?.raw
      layout[2] = leftParen.raw
      layout[3] = expressions.raw
      layout[4] = rightParen.raw
    }
    return .init(raw: raw)
  }
}

extension RawStringLiteralExprSyntax {
  typealias Cursor = StringLiteralExprSyntax.Cursor
  public var openDelimiter: RawTokenSyntax? {
    elem(at: Cursor.openDelimiter).map(RawTokenSyntax.init(raw:))
  }
  public var openQuote: RawTokenSyntax {
    elem(at: Cursor.openQuote).map(RawTokenSyntax.init(raw:))!
  }
  public var segments: RawStringLiteralSegmentsSyntax {
    elem(at: Cursor.segments).map(RawStringLiteralSegmentsSyntax.init(raw:))!
  }
  public var closeQuote: RawTokenSyntax {
    elem(at: Cursor.closeQuote).map(RawTokenSyntax.init(raw:))!
  }
  public var closeDelimiter: RawTokenSyntax? {
    elem(at: Cursor.closeDelimiter).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var openDelimiter: RawTokenSyntax? = nil
    public var openQuote: RawTokenSyntax? = nil
    public var segments: RawStringLiteralSegmentsSyntax? = nil
    public var closeQuote: RawTokenSyntax? = nil
    public var closeDelimiter: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawStringLiteralExprSyntax {
      .make(arena: arena
      , openDelimiter: self.openDelimiter
      , openQuote: self.openQuote
          ?? .makeBlank(arena: arena, tokenKind: .stringQuote)
      , segments: self.segments
          ?? .makeBlank(arena: arena)
      , closeQuote: self.closeQuote
          ?? .makeBlank(arena: arena, tokenKind: .stringQuote)
      , closeDelimiter: self.closeDelimiter
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawStringLiteralExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, openDelimiter: RawTokenSyntax? = nil, openQuote: RawTokenSyntax, segments: RawStringLiteralSegmentsSyntax, closeQuote: RawTokenSyntax, closeDelimiter: RawTokenSyntax? = nil) -> RawStringLiteralExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .stringLiteralExpr,
                                   uninitializedCount: 5) { layout in
      layout.initialize(repeating: nil)
      layout[0] = openDelimiter?.raw
      layout[1] = openQuote.raw
      layout[2] = segments.raw
      layout[3] = closeQuote.raw
      layout[4] = closeDelimiter?.raw
    }
    return .init(raw: raw)
  }
}

extension RawRegexLiteralExprSyntax {
  typealias Cursor = RegexLiteralExprSyntax.Cursor
  public var regex: RawTokenSyntax {
    elem(at: Cursor.regex).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var regex: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawRegexLiteralExprSyntax {
      .make(arena: arena
      , regex: self.regex
          ?? .makeBlank(arena: arena, tokenKind: .regexLiteral)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawRegexLiteralExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, regex: RawTokenSyntax) -> RawRegexLiteralExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .regexLiteralExpr,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = regex.raw
    }
    return .init(raw: raw)
  }
}

extension RawKeyPathExprSyntax {
  typealias Cursor = KeyPathExprSyntax.Cursor
  public var backslash: RawTokenSyntax {
    elem(at: Cursor.backslash).map(RawTokenSyntax.init(raw:))!
  }
  public var rootExpr: RawExprSyntax? {
    elem(at: Cursor.rootExpr).map(RawExprSyntax.init(raw:))
  }
  public var expression: RawExprSyntax {
    elem(at: Cursor.expression).map(RawExprSyntax.init(raw:))!
  }

  public struct Builder {
    public var backslash: RawTokenSyntax? = nil
    public var rootExpr: RawExprSyntax? = nil
    public var expression: RawExprSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawKeyPathExprSyntax {
      .make(arena: arena
      , backslash: self.backslash
          ?? .makeBlank(arena: arena, tokenKind: .backslash)
      , rootExpr: self.rootExpr
      , expression: self.expression
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawKeyPathExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, backslash: RawTokenSyntax, rootExpr: RawExprSyntax? = nil, expression: RawExprSyntax) -> RawKeyPathExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .keyPathExpr,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = backslash.raw
      layout[1] = rootExpr?.raw
      layout[2] = expression.raw
    }
    return .init(raw: raw)
  }
}

extension RawKeyPathBaseExprSyntax {
  typealias Cursor = KeyPathBaseExprSyntax.Cursor
  public var period: RawTokenSyntax {
    elem(at: Cursor.period).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var period: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawKeyPathBaseExprSyntax {
      .make(arena: arena
      , period: self.period
          ?? .makeBlank(arena: arena, tokenKind: .period)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawKeyPathBaseExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, period: RawTokenSyntax) -> RawKeyPathBaseExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .keyPathBaseExpr,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = period.raw
    }
    return .init(raw: raw)
  }
}

extension RawObjcNamePieceSyntax {
  typealias Cursor = ObjcNamePieceSyntax.Cursor
  public var name: RawTokenSyntax {
    elem(at: Cursor.name).map(RawTokenSyntax.init(raw:))!
  }
  public var dot: RawTokenSyntax? {
    elem(at: Cursor.dot).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var name: RawTokenSyntax? = nil
    public var dot: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawObjcNamePieceSyntax {
      .make(arena: arena
      , name: self.name
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , dot: self.dot
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawObjcNamePieceSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, name: RawTokenSyntax, dot: RawTokenSyntax? = nil) -> RawObjcNamePieceSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .objcNamePiece,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = name.raw
      layout[1] = dot?.raw
    }
    return .init(raw: raw)
  }
}

extension RawObjcKeyPathExprSyntax {
  typealias Cursor = ObjcKeyPathExprSyntax.Cursor
  public var keyPath: RawTokenSyntax {
    elem(at: Cursor.keyPath).map(RawTokenSyntax.init(raw:))!
  }
  public var leftParen: RawTokenSyntax {
    elem(at: Cursor.leftParen).map(RawTokenSyntax.init(raw:))!
  }
  public var name: RawObjcNameSyntax {
    elem(at: Cursor.name).map(RawObjcNameSyntax.init(raw:))!
  }
  public var rightParen: RawTokenSyntax {
    elem(at: Cursor.rightParen).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var keyPath: RawTokenSyntax? = nil
    public var leftParen: RawTokenSyntax? = nil
    public var name: RawObjcNameSyntax? = nil
    public var rightParen: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawObjcKeyPathExprSyntax {
      .make(arena: arena
      , keyPath: self.keyPath
          ?? .makeBlank(arena: arena, tokenKind: .poundKeyPathKeyword)
      , leftParen: self.leftParen
          ?? .makeBlank(arena: arena, tokenKind: .leftParen)
      , name: self.name
          ?? .makeBlank(arena: arena)
      , rightParen: self.rightParen
          ?? .makeBlank(arena: arena, tokenKind: .rightParen)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawObjcKeyPathExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, keyPath: RawTokenSyntax, leftParen: RawTokenSyntax, name: RawObjcNameSyntax, rightParen: RawTokenSyntax) -> RawObjcKeyPathExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .objcKeyPathExpr,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = keyPath.raw
      layout[1] = leftParen.raw
      layout[2] = name.raw
      layout[3] = rightParen.raw
    }
    return .init(raw: raw)
  }
}

extension RawObjcSelectorExprSyntax {
  typealias Cursor = ObjcSelectorExprSyntax.Cursor
  public var poundSelector: RawTokenSyntax {
    elem(at: Cursor.poundSelector).map(RawTokenSyntax.init(raw:))!
  }
  public var leftParen: RawTokenSyntax {
    elem(at: Cursor.leftParen).map(RawTokenSyntax.init(raw:))!
  }
  public var kind: RawTokenSyntax? {
    elem(at: Cursor.kind).map(RawTokenSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax? {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))
  }
  public var name: RawExprSyntax {
    elem(at: Cursor.name).map(RawExprSyntax.init(raw:))!
  }
  public var rightParen: RawTokenSyntax {
    elem(at: Cursor.rightParen).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var poundSelector: RawTokenSyntax? = nil
    public var leftParen: RawTokenSyntax? = nil
    public var kind: RawTokenSyntax? = nil
    public var colon: RawTokenSyntax? = nil
    public var name: RawExprSyntax? = nil
    public var rightParen: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawObjcSelectorExprSyntax {
      .make(arena: arena
      , poundSelector: self.poundSelector
          ?? .makeBlank(arena: arena, tokenKind: .poundSelectorKeyword)
      , leftParen: self.leftParen
          ?? .makeBlank(arena: arena, tokenKind: .leftParen)
      , kind: self.kind
      , colon: self.colon
      , name: self.name
          ?? .makeBlank(arena: arena)
      , rightParen: self.rightParen
          ?? .makeBlank(arena: arena, tokenKind: .rightParen)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawObjcSelectorExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, poundSelector: RawTokenSyntax, leftParen: RawTokenSyntax, kind: RawTokenSyntax? = nil, colon: RawTokenSyntax? = nil, name: RawExprSyntax, rightParen: RawTokenSyntax) -> RawObjcSelectorExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .objcSelectorExpr,
                                   uninitializedCount: 6) { layout in
      layout.initialize(repeating: nil)
      layout[0] = poundSelector.raw
      layout[1] = leftParen.raw
      layout[2] = kind?.raw
      layout[3] = colon?.raw
      layout[4] = name.raw
      layout[5] = rightParen.raw
    }
    return .init(raw: raw)
  }
}

extension RawPostfixIfConfigExprSyntax {
  typealias Cursor = PostfixIfConfigExprSyntax.Cursor
  public var base: RawExprSyntax? {
    elem(at: Cursor.base).map(RawExprSyntax.init(raw:))
  }
  public var config: RawIfConfigDeclSyntax {
    elem(at: Cursor.config).map(RawIfConfigDeclSyntax.init(raw:))!
  }

  public struct Builder {
    public var base: RawExprSyntax? = nil
    public var config: RawIfConfigDeclSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawPostfixIfConfigExprSyntax {
      .make(arena: arena
      , base: self.base
      , config: self.config
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawPostfixIfConfigExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, base: RawExprSyntax? = nil, config: RawIfConfigDeclSyntax) -> RawPostfixIfConfigExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .postfixIfConfigExpr,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = base?.raw
      layout[1] = config.raw
    }
    return .init(raw: raw)
  }
}

extension RawEditorPlaceholderExprSyntax {
  typealias Cursor = EditorPlaceholderExprSyntax.Cursor
  public var identifier: RawTokenSyntax {
    elem(at: Cursor.identifier).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var identifier: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawEditorPlaceholderExprSyntax {
      .make(arena: arena
      , identifier: self.identifier
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawEditorPlaceholderExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, identifier: RawTokenSyntax) -> RawEditorPlaceholderExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .editorPlaceholderExpr,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = identifier.raw
    }
    return .init(raw: raw)
  }
}

extension RawObjectLiteralExprSyntax {
  typealias Cursor = ObjectLiteralExprSyntax.Cursor
  public var identifier: RawTokenSyntax {
    elem(at: Cursor.identifier).map(RawTokenSyntax.init(raw:))!
  }
  public var leftParen: RawTokenSyntax {
    elem(at: Cursor.leftParen).map(RawTokenSyntax.init(raw:))!
  }
  public var arguments: RawTupleExprElementListSyntax {
    elem(at: Cursor.arguments).map(RawTupleExprElementListSyntax.init(raw:))!
  }
  public var rightParen: RawTokenSyntax {
    elem(at: Cursor.rightParen).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var identifier: RawTokenSyntax? = nil
    public var leftParen: RawTokenSyntax? = nil
    public var arguments: RawTupleExprElementListSyntax? = nil
    public var rightParen: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawObjectLiteralExprSyntax {
      .make(arena: arena
      , identifier: self.identifier
          ?? .makeBlank(arena: arena, tokenKind: .poundColorLiteralKeyword)
      , leftParen: self.leftParen
          ?? .makeBlank(arena: arena, tokenKind: .leftParen)
      , arguments: self.arguments
          ?? .makeBlank(arena: arena)
      , rightParen: self.rightParen
          ?? .makeBlank(arena: arena, tokenKind: .rightParen)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawObjectLiteralExprSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, identifier: RawTokenSyntax, leftParen: RawTokenSyntax, arguments: RawTupleExprElementListSyntax, rightParen: RawTokenSyntax) -> RawObjectLiteralExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .objectLiteralExpr,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = identifier.raw
      layout[1] = leftParen.raw
      layout[2] = arguments.raw
      layout[3] = rightParen.raw
    }
    return .init(raw: raw)
  }
}

extension RawTypeInitializerClauseSyntax {
  typealias Cursor = TypeInitializerClauseSyntax.Cursor
  public var equal: RawTokenSyntax {
    elem(at: Cursor.equal).map(RawTokenSyntax.init(raw:))!
  }
  public var value: RawTypeSyntax {
    elem(at: Cursor.value).map(RawTypeSyntax.init(raw:))!
  }

  public struct Builder {
    public var equal: RawTokenSyntax? = nil
    public var value: RawTypeSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawTypeInitializerClauseSyntax {
      .make(arena: arena
      , equal: self.equal
          ?? .makeBlank(arena: arena, tokenKind: .equal)
      , value: self.value
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawTypeInitializerClauseSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, equal: RawTokenSyntax, value: RawTypeSyntax) -> RawTypeInitializerClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .typeInitializerClause,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = equal.raw
      layout[1] = value.raw
    }
    return .init(raw: raw)
  }
}

extension RawTypealiasDeclSyntax {
  typealias Cursor = TypealiasDeclSyntax.Cursor
  public var attributes: RawAttributeListSyntax? {
    elem(at: Cursor.attributes).map(RawAttributeListSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    elem(at: Cursor.modifiers).map(RawModifierListSyntax.init(raw:))
  }
  public var typealiasKeyword: RawTokenSyntax {
    elem(at: Cursor.typealiasKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var identifier: RawTokenSyntax {
    elem(at: Cursor.identifier).map(RawTokenSyntax.init(raw:))!
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    elem(at: Cursor.genericParameterClause).map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var initializer: RawTypeInitializerClauseSyntax {
    elem(at: Cursor.initializer).map(RawTypeInitializerClauseSyntax.init(raw:))!
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    elem(at: Cursor.genericWhereClause).map(RawGenericWhereClauseSyntax.init(raw:))
  }

  public struct Builder {
    public var attributes: RawAttributeListSyntax? = nil
    public var modifiers: RawModifierListSyntax? = nil
    public var typealiasKeyword: RawTokenSyntax? = nil
    public var identifier: RawTokenSyntax? = nil
    public var genericParameterClause: RawGenericParameterClauseSyntax? = nil
    public var initializer: RawTypeInitializerClauseSyntax? = nil
    public var genericWhereClause: RawGenericWhereClauseSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawTypealiasDeclSyntax {
      .make(arena: arena
      , attributes: self.attributes
      , modifiers: self.modifiers
      , typealiasKeyword: self.typealiasKeyword
          ?? .makeBlank(arena: arena, tokenKind: .typealiasKeyword)
      , identifier: self.identifier
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , genericParameterClause: self.genericParameterClause
      , initializer: self.initializer
          ?? .makeBlank(arena: arena)
      , genericWhereClause: self.genericWhereClause
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawTypealiasDeclSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, attributes: RawAttributeListSyntax? = nil, modifiers: RawModifierListSyntax? = nil, typealiasKeyword: RawTokenSyntax, identifier: RawTokenSyntax, genericParameterClause: RawGenericParameterClauseSyntax? = nil, initializer: RawTypeInitializerClauseSyntax, genericWhereClause: RawGenericWhereClauseSyntax? = nil) -> RawTypealiasDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .typealiasDecl,
                                   uninitializedCount: 7) { layout in
      layout.initialize(repeating: nil)
      layout[0] = attributes?.raw
      layout[1] = modifiers?.raw
      layout[2] = typealiasKeyword.raw
      layout[3] = identifier.raw
      layout[4] = genericParameterClause?.raw
      layout[5] = initializer.raw
      layout[6] = genericWhereClause?.raw
    }
    return .init(raw: raw)
  }
}

extension RawAssociatedtypeDeclSyntax {
  typealias Cursor = AssociatedtypeDeclSyntax.Cursor
  public var attributes: RawAttributeListSyntax? {
    elem(at: Cursor.attributes).map(RawAttributeListSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    elem(at: Cursor.modifiers).map(RawModifierListSyntax.init(raw:))
  }
  public var associatedtypeKeyword: RawTokenSyntax {
    elem(at: Cursor.associatedtypeKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var identifier: RawTokenSyntax {
    elem(at: Cursor.identifier).map(RawTokenSyntax.init(raw:))!
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    elem(at: Cursor.inheritanceClause).map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var initializer: RawTypeInitializerClauseSyntax? {
    elem(at: Cursor.initializer).map(RawTypeInitializerClauseSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    elem(at: Cursor.genericWhereClause).map(RawGenericWhereClauseSyntax.init(raw:))
  }

  public struct Builder {
    public var attributes: RawAttributeListSyntax? = nil
    public var modifiers: RawModifierListSyntax? = nil
    public var associatedtypeKeyword: RawTokenSyntax? = nil
    public var identifier: RawTokenSyntax? = nil
    public var inheritanceClause: RawTypeInheritanceClauseSyntax? = nil
    public var initializer: RawTypeInitializerClauseSyntax? = nil
    public var genericWhereClause: RawGenericWhereClauseSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawAssociatedtypeDeclSyntax {
      .make(arena: arena
      , attributes: self.attributes
      , modifiers: self.modifiers
      , associatedtypeKeyword: self.associatedtypeKeyword
          ?? .makeBlank(arena: arena, tokenKind: .associatedtypeKeyword)
      , identifier: self.identifier
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , inheritanceClause: self.inheritanceClause
      , initializer: self.initializer
      , genericWhereClause: self.genericWhereClause
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawAssociatedtypeDeclSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, attributes: RawAttributeListSyntax? = nil, modifiers: RawModifierListSyntax? = nil, associatedtypeKeyword: RawTokenSyntax, identifier: RawTokenSyntax, inheritanceClause: RawTypeInheritanceClauseSyntax? = nil, initializer: RawTypeInitializerClauseSyntax? = nil, genericWhereClause: RawGenericWhereClauseSyntax? = nil) -> RawAssociatedtypeDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .associatedtypeDecl,
                                   uninitializedCount: 7) { layout in
      layout.initialize(repeating: nil)
      layout[0] = attributes?.raw
      layout[1] = modifiers?.raw
      layout[2] = associatedtypeKeyword.raw
      layout[3] = identifier.raw
      layout[4] = inheritanceClause?.raw
      layout[5] = initializer?.raw
      layout[6] = genericWhereClause?.raw
    }
    return .init(raw: raw)
  }
}

extension RawParameterClauseSyntax {
  typealias Cursor = ParameterClauseSyntax.Cursor
  public var leftParen: RawTokenSyntax {
    elem(at: Cursor.leftParen).map(RawTokenSyntax.init(raw:))!
  }
  public var parameterList: RawFunctionParameterListSyntax {
    elem(at: Cursor.parameterList).map(RawFunctionParameterListSyntax.init(raw:))!
  }
  public var rightParen: RawTokenSyntax {
    elem(at: Cursor.rightParen).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var leftParen: RawTokenSyntax? = nil
    public var parameterList: RawFunctionParameterListSyntax? = nil
    public var rightParen: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawParameterClauseSyntax {
      .make(arena: arena
      , leftParen: self.leftParen
          ?? .makeBlank(arena: arena, tokenKind: .leftParen)
      , parameterList: self.parameterList
          ?? .makeBlank(arena: arena)
      , rightParen: self.rightParen
          ?? .makeBlank(arena: arena, tokenKind: .rightParen)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawParameterClauseSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, leftParen: RawTokenSyntax, parameterList: RawFunctionParameterListSyntax, rightParen: RawTokenSyntax) -> RawParameterClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .parameterClause,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = leftParen.raw
      layout[1] = parameterList.raw
      layout[2] = rightParen.raw
    }
    return .init(raw: raw)
  }
}

extension RawReturnClauseSyntax {
  typealias Cursor = ReturnClauseSyntax.Cursor
  public var arrow: RawTokenSyntax {
    elem(at: Cursor.arrow).map(RawTokenSyntax.init(raw:))!
  }
  public var returnType: RawTypeSyntax {
    elem(at: Cursor.returnType).map(RawTypeSyntax.init(raw:))!
  }

  public struct Builder {
    public var arrow: RawTokenSyntax? = nil
    public var returnType: RawTypeSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawReturnClauseSyntax {
      .make(arena: arena
      , arrow: self.arrow
          ?? .makeBlank(arena: arena, tokenKind: .arrow)
      , returnType: self.returnType
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawReturnClauseSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, arrow: RawTokenSyntax, returnType: RawTypeSyntax) -> RawReturnClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .returnClause,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = arrow.raw
      layout[1] = returnType.raw
    }
    return .init(raw: raw)
  }
}

extension RawFunctionSignatureSyntax {
  typealias Cursor = FunctionSignatureSyntax.Cursor
  public var input: RawParameterClauseSyntax {
    elem(at: Cursor.input).map(RawParameterClauseSyntax.init(raw:))!
  }
  public var asyncOrReasyncKeyword: RawTokenSyntax? {
    elem(at: Cursor.asyncOrReasyncKeyword).map(RawTokenSyntax.init(raw:))
  }
  public var throwsOrRethrowsKeyword: RawTokenSyntax? {
    elem(at: Cursor.throwsOrRethrowsKeyword).map(RawTokenSyntax.init(raw:))
  }
  public var output: RawReturnClauseSyntax? {
    elem(at: Cursor.output).map(RawReturnClauseSyntax.init(raw:))
  }

  public struct Builder {
    public var input: RawParameterClauseSyntax? = nil
    public var asyncOrReasyncKeyword: RawTokenSyntax? = nil
    public var throwsOrRethrowsKeyword: RawTokenSyntax? = nil
    public var output: RawReturnClauseSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawFunctionSignatureSyntax {
      .make(arena: arena
      , input: self.input
          ?? .makeBlank(arena: arena)
      , asyncOrReasyncKeyword: self.asyncOrReasyncKeyword
      , throwsOrRethrowsKeyword: self.throwsOrRethrowsKeyword
      , output: self.output
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawFunctionSignatureSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, input: RawParameterClauseSyntax, asyncOrReasyncKeyword: RawTokenSyntax? = nil, throwsOrRethrowsKeyword: RawTokenSyntax? = nil, output: RawReturnClauseSyntax? = nil) -> RawFunctionSignatureSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .functionSignature,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = input.raw
      layout[1] = asyncOrReasyncKeyword?.raw
      layout[2] = throwsOrRethrowsKeyword?.raw
      layout[3] = output?.raw
    }
    return .init(raw: raw)
  }
}

extension RawIfConfigClauseSyntax {
  typealias Cursor = IfConfigClauseSyntax.Cursor
  public var poundKeyword: RawTokenSyntax {
    elem(at: Cursor.poundKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var condition: RawExprSyntax? {
    elem(at: Cursor.condition).map(RawExprSyntax.init(raw:))
  }
  public var elements: RawSyntax {
    elem(at: Cursor.elements).map(RawSyntax.init(raw:))!
  }

  public struct Builder {
    public var poundKeyword: RawTokenSyntax? = nil
    public var condition: RawExprSyntax? = nil
    public var elements: RawSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawIfConfigClauseSyntax {
      .make(arena: arena
      , poundKeyword: self.poundKeyword
          ?? .makeBlank(arena: arena, tokenKind: .poundIfKeyword)
      , condition: self.condition
      , elements: self.elements
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawIfConfigClauseSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, poundKeyword: RawTokenSyntax, condition: RawExprSyntax? = nil, elements: RawSyntax) -> RawIfConfigClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .ifConfigClause,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = poundKeyword.raw
      layout[1] = condition?.raw
      layout[2] = elements.raw
    }
    return .init(raw: raw)
  }
}

extension RawIfConfigDeclSyntax {
  typealias Cursor = IfConfigDeclSyntax.Cursor
  public var clauses: RawIfConfigClauseListSyntax {
    elem(at: Cursor.clauses).map(RawIfConfigClauseListSyntax.init(raw:))!
  }
  public var poundEndif: RawTokenSyntax {
    elem(at: Cursor.poundEndif).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var clauses: RawIfConfigClauseListSyntax? = nil
    public var poundEndif: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawIfConfigDeclSyntax {
      .make(arena: arena
      , clauses: self.clauses
          ?? .makeBlank(arena: arena)
      , poundEndif: self.poundEndif
          ?? .makeBlank(arena: arena, tokenKind: .poundEndifKeyword)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawIfConfigDeclSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, clauses: RawIfConfigClauseListSyntax, poundEndif: RawTokenSyntax) -> RawIfConfigDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .ifConfigDecl,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = clauses.raw
      layout[1] = poundEndif.raw
    }
    return .init(raw: raw)
  }
}

extension RawPoundErrorDeclSyntax {
  typealias Cursor = PoundErrorDeclSyntax.Cursor
  public var poundError: RawTokenSyntax {
    elem(at: Cursor.poundError).map(RawTokenSyntax.init(raw:))!
  }
  public var leftParen: RawTokenSyntax {
    elem(at: Cursor.leftParen).map(RawTokenSyntax.init(raw:))!
  }
  public var message: RawStringLiteralExprSyntax {
    elem(at: Cursor.message).map(RawStringLiteralExprSyntax.init(raw:))!
  }
  public var rightParen: RawTokenSyntax {
    elem(at: Cursor.rightParen).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var poundError: RawTokenSyntax? = nil
    public var leftParen: RawTokenSyntax? = nil
    public var message: RawStringLiteralExprSyntax? = nil
    public var rightParen: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawPoundErrorDeclSyntax {
      .make(arena: arena
      , poundError: self.poundError
          ?? .makeBlank(arena: arena, tokenKind: .poundErrorKeyword)
      , leftParen: self.leftParen
          ?? .makeBlank(arena: arena, tokenKind: .leftParen)
      , message: self.message
          ?? .makeBlank(arena: arena)
      , rightParen: self.rightParen
          ?? .makeBlank(arena: arena, tokenKind: .rightParen)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawPoundErrorDeclSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, poundError: RawTokenSyntax, leftParen: RawTokenSyntax, message: RawStringLiteralExprSyntax, rightParen: RawTokenSyntax) -> RawPoundErrorDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundErrorDecl,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = poundError.raw
      layout[1] = leftParen.raw
      layout[2] = message.raw
      layout[3] = rightParen.raw
    }
    return .init(raw: raw)
  }
}

extension RawPoundWarningDeclSyntax {
  typealias Cursor = PoundWarningDeclSyntax.Cursor
  public var poundWarning: RawTokenSyntax {
    elem(at: Cursor.poundWarning).map(RawTokenSyntax.init(raw:))!
  }
  public var leftParen: RawTokenSyntax {
    elem(at: Cursor.leftParen).map(RawTokenSyntax.init(raw:))!
  }
  public var message: RawStringLiteralExprSyntax {
    elem(at: Cursor.message).map(RawStringLiteralExprSyntax.init(raw:))!
  }
  public var rightParen: RawTokenSyntax {
    elem(at: Cursor.rightParen).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var poundWarning: RawTokenSyntax? = nil
    public var leftParen: RawTokenSyntax? = nil
    public var message: RawStringLiteralExprSyntax? = nil
    public var rightParen: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawPoundWarningDeclSyntax {
      .make(arena: arena
      , poundWarning: self.poundWarning
          ?? .makeBlank(arena: arena, tokenKind: .poundWarningKeyword)
      , leftParen: self.leftParen
          ?? .makeBlank(arena: arena, tokenKind: .leftParen)
      , message: self.message
          ?? .makeBlank(arena: arena)
      , rightParen: self.rightParen
          ?? .makeBlank(arena: arena, tokenKind: .rightParen)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawPoundWarningDeclSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, poundWarning: RawTokenSyntax, leftParen: RawTokenSyntax, message: RawStringLiteralExprSyntax, rightParen: RawTokenSyntax) -> RawPoundWarningDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundWarningDecl,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = poundWarning.raw
      layout[1] = leftParen.raw
      layout[2] = message.raw
      layout[3] = rightParen.raw
    }
    return .init(raw: raw)
  }
}

extension RawPoundSourceLocationSyntax {
  typealias Cursor = PoundSourceLocationSyntax.Cursor
  public var poundSourceLocation: RawTokenSyntax {
    elem(at: Cursor.poundSourceLocation).map(RawTokenSyntax.init(raw:))!
  }
  public var leftParen: RawTokenSyntax {
    elem(at: Cursor.leftParen).map(RawTokenSyntax.init(raw:))!
  }
  public var args: RawPoundSourceLocationArgsSyntax? {
    elem(at: Cursor.args).map(RawPoundSourceLocationArgsSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    elem(at: Cursor.rightParen).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var poundSourceLocation: RawTokenSyntax? = nil
    public var leftParen: RawTokenSyntax? = nil
    public var args: RawPoundSourceLocationArgsSyntax? = nil
    public var rightParen: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawPoundSourceLocationSyntax {
      .make(arena: arena
      , poundSourceLocation: self.poundSourceLocation
          ?? .makeBlank(arena: arena, tokenKind: .poundSourceLocationKeyword)
      , leftParen: self.leftParen
          ?? .makeBlank(arena: arena, tokenKind: .leftParen)
      , args: self.args
      , rightParen: self.rightParen
          ?? .makeBlank(arena: arena, tokenKind: .rightParen)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawPoundSourceLocationSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, poundSourceLocation: RawTokenSyntax, leftParen: RawTokenSyntax, args: RawPoundSourceLocationArgsSyntax? = nil, rightParen: RawTokenSyntax) -> RawPoundSourceLocationSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundSourceLocation,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = poundSourceLocation.raw
      layout[1] = leftParen.raw
      layout[2] = args?.raw
      layout[3] = rightParen.raw
    }
    return .init(raw: raw)
  }
}

extension RawPoundSourceLocationArgsSyntax {
  typealias Cursor = PoundSourceLocationArgsSyntax.Cursor
  public var fileArgLabel: RawTokenSyntax {
    elem(at: Cursor.fileArgLabel).map(RawTokenSyntax.init(raw:))!
  }
  public var fileArgColon: RawTokenSyntax {
    elem(at: Cursor.fileArgColon).map(RawTokenSyntax.init(raw:))!
  }
  public var fileName: RawTokenSyntax {
    elem(at: Cursor.fileName).map(RawTokenSyntax.init(raw:))!
  }
  public var comma: RawTokenSyntax {
    elem(at: Cursor.comma).map(RawTokenSyntax.init(raw:))!
  }
  public var lineArgLabel: RawTokenSyntax {
    elem(at: Cursor.lineArgLabel).map(RawTokenSyntax.init(raw:))!
  }
  public var lineArgColon: RawTokenSyntax {
    elem(at: Cursor.lineArgColon).map(RawTokenSyntax.init(raw:))!
  }
  public var lineNumber: RawTokenSyntax {
    elem(at: Cursor.lineNumber).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var fileArgLabel: RawTokenSyntax? = nil
    public var fileArgColon: RawTokenSyntax? = nil
    public var fileName: RawTokenSyntax? = nil
    public var comma: RawTokenSyntax? = nil
    public var lineArgLabel: RawTokenSyntax? = nil
    public var lineArgColon: RawTokenSyntax? = nil
    public var lineNumber: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawPoundSourceLocationArgsSyntax {
      .make(arena: arena
      , fileArgLabel: self.fileArgLabel
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , fileArgColon: self.fileArgColon
          ?? .makeBlank(arena: arena, tokenKind: .colon)
      , fileName: self.fileName
          ?? .makeBlank(arena: arena, tokenKind: .stringLiteral)
      , comma: self.comma
          ?? .makeBlank(arena: arena, tokenKind: .comma)
      , lineArgLabel: self.lineArgLabel
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , lineArgColon: self.lineArgColon
          ?? .makeBlank(arena: arena, tokenKind: .colon)
      , lineNumber: self.lineNumber
          ?? .makeBlank(arena: arena, tokenKind: .integerLiteral)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawPoundSourceLocationArgsSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, fileArgLabel: RawTokenSyntax, fileArgColon: RawTokenSyntax, fileName: RawTokenSyntax, comma: RawTokenSyntax, lineArgLabel: RawTokenSyntax, lineArgColon: RawTokenSyntax, lineNumber: RawTokenSyntax) -> RawPoundSourceLocationArgsSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundSourceLocationArgs,
                                   uninitializedCount: 7) { layout in
      layout.initialize(repeating: nil)
      layout[0] = fileArgLabel.raw
      layout[1] = fileArgColon.raw
      layout[2] = fileName.raw
      layout[3] = comma.raw
      layout[4] = lineArgLabel.raw
      layout[5] = lineArgColon.raw
      layout[6] = lineNumber.raw
    }
    return .init(raw: raw)
  }
}

extension RawDeclModifierDetailSyntax {
  typealias Cursor = DeclModifierDetailSyntax.Cursor
  public var leftParen: RawTokenSyntax {
    elem(at: Cursor.leftParen).map(RawTokenSyntax.init(raw:))!
  }
  public var detail: RawTokenSyntax {
    elem(at: Cursor.detail).map(RawTokenSyntax.init(raw:))!
  }
  public var rightParen: RawTokenSyntax {
    elem(at: Cursor.rightParen).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var leftParen: RawTokenSyntax? = nil
    public var detail: RawTokenSyntax? = nil
    public var rightParen: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawDeclModifierDetailSyntax {
      .make(arena: arena
      , leftParen: self.leftParen
          ?? .makeBlank(arena: arena, tokenKind: .leftParen)
      , detail: self.detail
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , rightParen: self.rightParen
          ?? .makeBlank(arena: arena, tokenKind: .rightParen)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawDeclModifierDetailSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, leftParen: RawTokenSyntax, detail: RawTokenSyntax, rightParen: RawTokenSyntax) -> RawDeclModifierDetailSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .declModifierDetail,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = leftParen.raw
      layout[1] = detail.raw
      layout[2] = rightParen.raw
    }
    return .init(raw: raw)
  }
}

extension RawDeclModifierSyntax {
  typealias Cursor = DeclModifierSyntax.Cursor
  public var name: RawTokenSyntax {
    elem(at: Cursor.name).map(RawTokenSyntax.init(raw:))!
  }
  public var detail: RawDeclModifierDetailSyntax? {
    elem(at: Cursor.detail).map(RawDeclModifierDetailSyntax.init(raw:))
  }

  public struct Builder {
    public var name: RawTokenSyntax? = nil
    public var detail: RawDeclModifierDetailSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawDeclModifierSyntax {
      .make(arena: arena
      , name: self.name
          ?? .makeBlank(arena: arena, tokenKind: .unknown)
      , detail: self.detail
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawDeclModifierSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, name: RawTokenSyntax, detail: RawDeclModifierDetailSyntax? = nil) -> RawDeclModifierSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .declModifier,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = name.raw
      layout[1] = detail?.raw
    }
    return .init(raw: raw)
  }
}

extension RawInheritedTypeSyntax {
  typealias Cursor = InheritedTypeSyntax.Cursor
  public var typeName: RawTypeSyntax {
    elem(at: Cursor.typeName).map(RawTypeSyntax.init(raw:))!
  }
  public var trailingComma: RawTokenSyntax? {
    elem(at: Cursor.trailingComma).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var typeName: RawTypeSyntax? = nil
    public var trailingComma: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawInheritedTypeSyntax {
      .make(arena: arena
      , typeName: self.typeName
          ?? .makeBlank(arena: arena)
      , trailingComma: self.trailingComma
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawInheritedTypeSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, typeName: RawTypeSyntax, trailingComma: RawTokenSyntax? = nil) -> RawInheritedTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .inheritedType,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = typeName.raw
      layout[1] = trailingComma?.raw
    }
    return .init(raw: raw)
  }
}

extension RawTypeInheritanceClauseSyntax {
  typealias Cursor = TypeInheritanceClauseSyntax.Cursor
  public var colon: RawTokenSyntax {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))!
  }
  public var inheritedTypeCollection: RawInheritedTypeListSyntax {
    elem(at: Cursor.inheritedTypeCollection).map(RawInheritedTypeListSyntax.init(raw:))!
  }

  public struct Builder {
    public var colon: RawTokenSyntax? = nil
    public var inheritedTypeCollection: RawInheritedTypeListSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawTypeInheritanceClauseSyntax {
      .make(arena: arena
      , colon: self.colon
          ?? .makeBlank(arena: arena, tokenKind: .colon)
      , inheritedTypeCollection: self.inheritedTypeCollection
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawTypeInheritanceClauseSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, colon: RawTokenSyntax, inheritedTypeCollection: RawInheritedTypeListSyntax) -> RawTypeInheritanceClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .typeInheritanceClause,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = colon.raw
      layout[1] = inheritedTypeCollection.raw
    }
    return .init(raw: raw)
  }
}

extension RawClassDeclSyntax {
  typealias Cursor = ClassDeclSyntax.Cursor
  public var attributes: RawAttributeListSyntax? {
    elem(at: Cursor.attributes).map(RawAttributeListSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    elem(at: Cursor.modifiers).map(RawModifierListSyntax.init(raw:))
  }
  public var classKeyword: RawTokenSyntax {
    elem(at: Cursor.classKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var identifier: RawTokenSyntax {
    elem(at: Cursor.identifier).map(RawTokenSyntax.init(raw:))!
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    elem(at: Cursor.genericParameterClause).map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    elem(at: Cursor.inheritanceClause).map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    elem(at: Cursor.genericWhereClause).map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var members: RawMemberDeclBlockSyntax {
    elem(at: Cursor.members).map(RawMemberDeclBlockSyntax.init(raw:))!
  }

  public struct Builder {
    public var attributes: RawAttributeListSyntax? = nil
    public var modifiers: RawModifierListSyntax? = nil
    public var classKeyword: RawTokenSyntax? = nil
    public var identifier: RawTokenSyntax? = nil
    public var genericParameterClause: RawGenericParameterClauseSyntax? = nil
    public var inheritanceClause: RawTypeInheritanceClauseSyntax? = nil
    public var genericWhereClause: RawGenericWhereClauseSyntax? = nil
    public var members: RawMemberDeclBlockSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawClassDeclSyntax {
      .make(arena: arena
      , attributes: self.attributes
      , modifiers: self.modifiers
      , classKeyword: self.classKeyword
          ?? .makeBlank(arena: arena, tokenKind: .classKeyword)
      , identifier: self.identifier
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , genericParameterClause: self.genericParameterClause
      , inheritanceClause: self.inheritanceClause
      , genericWhereClause: self.genericWhereClause
      , members: self.members
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawClassDeclSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, attributes: RawAttributeListSyntax? = nil, modifiers: RawModifierListSyntax? = nil, classKeyword: RawTokenSyntax, identifier: RawTokenSyntax, genericParameterClause: RawGenericParameterClauseSyntax? = nil, inheritanceClause: RawTypeInheritanceClauseSyntax? = nil, genericWhereClause: RawGenericWhereClauseSyntax? = nil, members: RawMemberDeclBlockSyntax) -> RawClassDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .classDecl,
                                   uninitializedCount: 8) { layout in
      layout.initialize(repeating: nil)
      layout[0] = attributes?.raw
      layout[1] = modifiers?.raw
      layout[2] = classKeyword.raw
      layout[3] = identifier.raw
      layout[4] = genericParameterClause?.raw
      layout[5] = inheritanceClause?.raw
      layout[6] = genericWhereClause?.raw
      layout[7] = members.raw
    }
    return .init(raw: raw)
  }
}

extension RawActorDeclSyntax {
  typealias Cursor = ActorDeclSyntax.Cursor
  public var attributes: RawAttributeListSyntax? {
    elem(at: Cursor.attributes).map(RawAttributeListSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    elem(at: Cursor.modifiers).map(RawModifierListSyntax.init(raw:))
  }
  public var actorKeyword: RawTokenSyntax {
    elem(at: Cursor.actorKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var identifier: RawTokenSyntax {
    elem(at: Cursor.identifier).map(RawTokenSyntax.init(raw:))!
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    elem(at: Cursor.genericParameterClause).map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    elem(at: Cursor.inheritanceClause).map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    elem(at: Cursor.genericWhereClause).map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var members: RawMemberDeclBlockSyntax {
    elem(at: Cursor.members).map(RawMemberDeclBlockSyntax.init(raw:))!
  }

  public struct Builder {
    public var attributes: RawAttributeListSyntax? = nil
    public var modifiers: RawModifierListSyntax? = nil
    public var actorKeyword: RawTokenSyntax? = nil
    public var identifier: RawTokenSyntax? = nil
    public var genericParameterClause: RawGenericParameterClauseSyntax? = nil
    public var inheritanceClause: RawTypeInheritanceClauseSyntax? = nil
    public var genericWhereClause: RawGenericWhereClauseSyntax? = nil
    public var members: RawMemberDeclBlockSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawActorDeclSyntax {
      .make(arena: arena
      , attributes: self.attributes
      , modifiers: self.modifiers
      , actorKeyword: self.actorKeyword
          ?? .makeBlank(arena: arena, tokenKind: .contextualKeyword)
      , identifier: self.identifier
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , genericParameterClause: self.genericParameterClause
      , inheritanceClause: self.inheritanceClause
      , genericWhereClause: self.genericWhereClause
      , members: self.members
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawActorDeclSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, attributes: RawAttributeListSyntax? = nil, modifiers: RawModifierListSyntax? = nil, actorKeyword: RawTokenSyntax, identifier: RawTokenSyntax, genericParameterClause: RawGenericParameterClauseSyntax? = nil, inheritanceClause: RawTypeInheritanceClauseSyntax? = nil, genericWhereClause: RawGenericWhereClauseSyntax? = nil, members: RawMemberDeclBlockSyntax) -> RawActorDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .actorDecl,
                                   uninitializedCount: 8) { layout in
      layout.initialize(repeating: nil)
      layout[0] = attributes?.raw
      layout[1] = modifiers?.raw
      layout[2] = actorKeyword.raw
      layout[3] = identifier.raw
      layout[4] = genericParameterClause?.raw
      layout[5] = inheritanceClause?.raw
      layout[6] = genericWhereClause?.raw
      layout[7] = members.raw
    }
    return .init(raw: raw)
  }
}

extension RawStructDeclSyntax {
  typealias Cursor = StructDeclSyntax.Cursor
  public var attributes: RawAttributeListSyntax? {
    elem(at: Cursor.attributes).map(RawAttributeListSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    elem(at: Cursor.modifiers).map(RawModifierListSyntax.init(raw:))
  }
  public var structKeyword: RawTokenSyntax {
    elem(at: Cursor.structKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var identifier: RawTokenSyntax {
    elem(at: Cursor.identifier).map(RawTokenSyntax.init(raw:))!
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    elem(at: Cursor.genericParameterClause).map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    elem(at: Cursor.inheritanceClause).map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    elem(at: Cursor.genericWhereClause).map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var members: RawMemberDeclBlockSyntax {
    elem(at: Cursor.members).map(RawMemberDeclBlockSyntax.init(raw:))!
  }

  public struct Builder {
    public var attributes: RawAttributeListSyntax? = nil
    public var modifiers: RawModifierListSyntax? = nil
    public var structKeyword: RawTokenSyntax? = nil
    public var identifier: RawTokenSyntax? = nil
    public var genericParameterClause: RawGenericParameterClauseSyntax? = nil
    public var inheritanceClause: RawTypeInheritanceClauseSyntax? = nil
    public var genericWhereClause: RawGenericWhereClauseSyntax? = nil
    public var members: RawMemberDeclBlockSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawStructDeclSyntax {
      .make(arena: arena
      , attributes: self.attributes
      , modifiers: self.modifiers
      , structKeyword: self.structKeyword
          ?? .makeBlank(arena: arena, tokenKind: .structKeyword)
      , identifier: self.identifier
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , genericParameterClause: self.genericParameterClause
      , inheritanceClause: self.inheritanceClause
      , genericWhereClause: self.genericWhereClause
      , members: self.members
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawStructDeclSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, attributes: RawAttributeListSyntax? = nil, modifiers: RawModifierListSyntax? = nil, structKeyword: RawTokenSyntax, identifier: RawTokenSyntax, genericParameterClause: RawGenericParameterClauseSyntax? = nil, inheritanceClause: RawTypeInheritanceClauseSyntax? = nil, genericWhereClause: RawGenericWhereClauseSyntax? = nil, members: RawMemberDeclBlockSyntax) -> RawStructDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .structDecl,
                                   uninitializedCount: 8) { layout in
      layout.initialize(repeating: nil)
      layout[0] = attributes?.raw
      layout[1] = modifiers?.raw
      layout[2] = structKeyword.raw
      layout[3] = identifier.raw
      layout[4] = genericParameterClause?.raw
      layout[5] = inheritanceClause?.raw
      layout[6] = genericWhereClause?.raw
      layout[7] = members.raw
    }
    return .init(raw: raw)
  }
}

extension RawProtocolDeclSyntax {
  typealias Cursor = ProtocolDeclSyntax.Cursor
  public var attributes: RawAttributeListSyntax? {
    elem(at: Cursor.attributes).map(RawAttributeListSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    elem(at: Cursor.modifiers).map(RawModifierListSyntax.init(raw:))
  }
  public var protocolKeyword: RawTokenSyntax {
    elem(at: Cursor.protocolKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var identifier: RawTokenSyntax {
    elem(at: Cursor.identifier).map(RawTokenSyntax.init(raw:))!
  }
  public var primaryAssociatedTypeClause: RawPrimaryAssociatedTypeClauseSyntax? {
    elem(at: Cursor.primaryAssociatedTypeClause).map(RawPrimaryAssociatedTypeClauseSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    elem(at: Cursor.inheritanceClause).map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    elem(at: Cursor.genericWhereClause).map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var members: RawMemberDeclBlockSyntax {
    elem(at: Cursor.members).map(RawMemberDeclBlockSyntax.init(raw:))!
  }

  public struct Builder {
    public var attributes: RawAttributeListSyntax? = nil
    public var modifiers: RawModifierListSyntax? = nil
    public var protocolKeyword: RawTokenSyntax? = nil
    public var identifier: RawTokenSyntax? = nil
    public var primaryAssociatedTypeClause: RawPrimaryAssociatedTypeClauseSyntax? = nil
    public var inheritanceClause: RawTypeInheritanceClauseSyntax? = nil
    public var genericWhereClause: RawGenericWhereClauseSyntax? = nil
    public var members: RawMemberDeclBlockSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawProtocolDeclSyntax {
      .make(arena: arena
      , attributes: self.attributes
      , modifiers: self.modifiers
      , protocolKeyword: self.protocolKeyword
          ?? .makeBlank(arena: arena, tokenKind: .protocolKeyword)
      , identifier: self.identifier
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , primaryAssociatedTypeClause: self.primaryAssociatedTypeClause
      , inheritanceClause: self.inheritanceClause
      , genericWhereClause: self.genericWhereClause
      , members: self.members
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawProtocolDeclSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, attributes: RawAttributeListSyntax? = nil, modifiers: RawModifierListSyntax? = nil, protocolKeyword: RawTokenSyntax, identifier: RawTokenSyntax, primaryAssociatedTypeClause: RawPrimaryAssociatedTypeClauseSyntax? = nil, inheritanceClause: RawTypeInheritanceClauseSyntax? = nil, genericWhereClause: RawGenericWhereClauseSyntax? = nil, members: RawMemberDeclBlockSyntax) -> RawProtocolDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .protocolDecl,
                                   uninitializedCount: 8) { layout in
      layout.initialize(repeating: nil)
      layout[0] = attributes?.raw
      layout[1] = modifiers?.raw
      layout[2] = protocolKeyword.raw
      layout[3] = identifier.raw
      layout[4] = primaryAssociatedTypeClause?.raw
      layout[5] = inheritanceClause?.raw
      layout[6] = genericWhereClause?.raw
      layout[7] = members.raw
    }
    return .init(raw: raw)
  }
}

extension RawExtensionDeclSyntax {
  typealias Cursor = ExtensionDeclSyntax.Cursor
  public var attributes: RawAttributeListSyntax? {
    elem(at: Cursor.attributes).map(RawAttributeListSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    elem(at: Cursor.modifiers).map(RawModifierListSyntax.init(raw:))
  }
  public var extensionKeyword: RawTokenSyntax {
    elem(at: Cursor.extensionKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var extendedType: RawTypeSyntax {
    elem(at: Cursor.extendedType).map(RawTypeSyntax.init(raw:))!
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    elem(at: Cursor.inheritanceClause).map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    elem(at: Cursor.genericWhereClause).map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var members: RawMemberDeclBlockSyntax {
    elem(at: Cursor.members).map(RawMemberDeclBlockSyntax.init(raw:))!
  }

  public struct Builder {
    public var attributes: RawAttributeListSyntax? = nil
    public var modifiers: RawModifierListSyntax? = nil
    public var extensionKeyword: RawTokenSyntax? = nil
    public var extendedType: RawTypeSyntax? = nil
    public var inheritanceClause: RawTypeInheritanceClauseSyntax? = nil
    public var genericWhereClause: RawGenericWhereClauseSyntax? = nil
    public var members: RawMemberDeclBlockSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawExtensionDeclSyntax {
      .make(arena: arena
      , attributes: self.attributes
      , modifiers: self.modifiers
      , extensionKeyword: self.extensionKeyword
          ?? .makeBlank(arena: arena, tokenKind: .extensionKeyword)
      , extendedType: self.extendedType
          ?? .makeBlank(arena: arena)
      , inheritanceClause: self.inheritanceClause
      , genericWhereClause: self.genericWhereClause
      , members: self.members
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawExtensionDeclSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, attributes: RawAttributeListSyntax? = nil, modifiers: RawModifierListSyntax? = nil, extensionKeyword: RawTokenSyntax, extendedType: RawTypeSyntax, inheritanceClause: RawTypeInheritanceClauseSyntax? = nil, genericWhereClause: RawGenericWhereClauseSyntax? = nil, members: RawMemberDeclBlockSyntax) -> RawExtensionDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .extensionDecl,
                                   uninitializedCount: 7) { layout in
      layout.initialize(repeating: nil)
      layout[0] = attributes?.raw
      layout[1] = modifiers?.raw
      layout[2] = extensionKeyword.raw
      layout[3] = extendedType.raw
      layout[4] = inheritanceClause?.raw
      layout[5] = genericWhereClause?.raw
      layout[6] = members.raw
    }
    return .init(raw: raw)
  }
}

extension RawMemberDeclBlockSyntax {
  typealias Cursor = MemberDeclBlockSyntax.Cursor
  public var leftBrace: RawTokenSyntax {
    elem(at: Cursor.leftBrace).map(RawTokenSyntax.init(raw:))!
  }
  public var members: RawMemberDeclListSyntax {
    elem(at: Cursor.members).map(RawMemberDeclListSyntax.init(raw:))!
  }
  public var rightBrace: RawTokenSyntax {
    elem(at: Cursor.rightBrace).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var leftBrace: RawTokenSyntax? = nil
    public var members: RawMemberDeclListSyntax? = nil
    public var rightBrace: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawMemberDeclBlockSyntax {
      .make(arena: arena
      , leftBrace: self.leftBrace
          ?? .makeBlank(arena: arena, tokenKind: .leftBrace)
      , members: self.members
          ?? .makeBlank(arena: arena)
      , rightBrace: self.rightBrace
          ?? .makeBlank(arena: arena, tokenKind: .rightBrace)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawMemberDeclBlockSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, leftBrace: RawTokenSyntax, members: RawMemberDeclListSyntax, rightBrace: RawTokenSyntax) -> RawMemberDeclBlockSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .memberDeclBlock,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = leftBrace.raw
      layout[1] = members.raw
      layout[2] = rightBrace.raw
    }
    return .init(raw: raw)
  }
}

extension RawMemberDeclListItemSyntax {
  typealias Cursor = MemberDeclListItemSyntax.Cursor
  public var decl: RawDeclSyntax {
    elem(at: Cursor.decl).map(RawDeclSyntax.init(raw:))!
  }
  public var semicolon: RawTokenSyntax? {
    elem(at: Cursor.semicolon).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var decl: RawDeclSyntax? = nil
    public var semicolon: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawMemberDeclListItemSyntax {
      .make(arena: arena
      , decl: self.decl
          ?? .makeBlank(arena: arena)
      , semicolon: self.semicolon
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawMemberDeclListItemSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, decl: RawDeclSyntax, semicolon: RawTokenSyntax? = nil) -> RawMemberDeclListItemSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .memberDeclListItem,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = decl.raw
      layout[1] = semicolon?.raw
    }
    return .init(raw: raw)
  }
}

extension RawSourceFileSyntax {
  typealias Cursor = SourceFileSyntax.Cursor
  public var statements: RawCodeBlockItemListSyntax {
    elem(at: Cursor.statements).map(RawCodeBlockItemListSyntax.init(raw:))!
  }
  public var eofToken: RawTokenSyntax {
    elem(at: Cursor.eofToken).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var statements: RawCodeBlockItemListSyntax? = nil
    public var eofToken: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawSourceFileSyntax {
      .make(arena: arena
      , statements: self.statements
          ?? .makeBlank(arena: arena)
      , eofToken: self.eofToken
          ?? .makeBlank(arena: arena, tokenKind: .unknown)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawSourceFileSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, statements: RawCodeBlockItemListSyntax, eofToken: RawTokenSyntax) -> RawSourceFileSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .sourceFile,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = statements.raw
      layout[1] = eofToken.raw
    }
    return .init(raw: raw)
  }
}

extension RawInitializerClauseSyntax {
  typealias Cursor = InitializerClauseSyntax.Cursor
  public var equal: RawTokenSyntax {
    elem(at: Cursor.equal).map(RawTokenSyntax.init(raw:))!
  }
  public var value: RawExprSyntax {
    elem(at: Cursor.value).map(RawExprSyntax.init(raw:))!
  }

  public struct Builder {
    public var equal: RawTokenSyntax? = nil
    public var value: RawExprSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawInitializerClauseSyntax {
      .make(arena: arena
      , equal: self.equal
          ?? .makeBlank(arena: arena, tokenKind: .equal)
      , value: self.value
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawInitializerClauseSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, equal: RawTokenSyntax, value: RawExprSyntax) -> RawInitializerClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .initializerClause,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = equal.raw
      layout[1] = value.raw
    }
    return .init(raw: raw)
  }
}

extension RawFunctionParameterSyntax {
  typealias Cursor = FunctionParameterSyntax.Cursor
  public var attributes: RawAttributeListSyntax? {
    elem(at: Cursor.attributes).map(RawAttributeListSyntax.init(raw:))
  }
  public var firstName: RawTokenSyntax? {
    elem(at: Cursor.firstName).map(RawTokenSyntax.init(raw:))
  }
  public var secondName: RawTokenSyntax? {
    elem(at: Cursor.secondName).map(RawTokenSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax? {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))
  }
  public var type: RawTypeSyntax? {
    elem(at: Cursor.type).map(RawTypeSyntax.init(raw:))
  }
  public var ellipsis: RawTokenSyntax? {
    elem(at: Cursor.ellipsis).map(RawTokenSyntax.init(raw:))
  }
  public var defaultArgument: RawInitializerClauseSyntax? {
    elem(at: Cursor.defaultArgument).map(RawInitializerClauseSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    elem(at: Cursor.trailingComma).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var attributes: RawAttributeListSyntax? = nil
    public var firstName: RawTokenSyntax? = nil
    public var secondName: RawTokenSyntax? = nil
    public var colon: RawTokenSyntax? = nil
    public var type: RawTypeSyntax? = nil
    public var ellipsis: RawTokenSyntax? = nil
    public var defaultArgument: RawInitializerClauseSyntax? = nil
    public var trailingComma: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawFunctionParameterSyntax {
      .make(arena: arena
      , attributes: self.attributes
      , firstName: self.firstName
      , secondName: self.secondName
      , colon: self.colon
      , type: self.type
      , ellipsis: self.ellipsis
      , defaultArgument: self.defaultArgument
      , trailingComma: self.trailingComma
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawFunctionParameterSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, attributes: RawAttributeListSyntax? = nil, firstName: RawTokenSyntax? = nil, secondName: RawTokenSyntax? = nil, colon: RawTokenSyntax? = nil, type: RawTypeSyntax? = nil, ellipsis: RawTokenSyntax? = nil, defaultArgument: RawInitializerClauseSyntax? = nil, trailingComma: RawTokenSyntax? = nil) -> RawFunctionParameterSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .functionParameter,
                                   uninitializedCount: 8) { layout in
      layout.initialize(repeating: nil)
      layout[0] = attributes?.raw
      layout[1] = firstName?.raw
      layout[2] = secondName?.raw
      layout[3] = colon?.raw
      layout[4] = type?.raw
      layout[5] = ellipsis?.raw
      layout[6] = defaultArgument?.raw
      layout[7] = trailingComma?.raw
    }
    return .init(raw: raw)
  }
}

extension RawFunctionDeclSyntax {
  typealias Cursor = FunctionDeclSyntax.Cursor
  public var attributes: RawAttributeListSyntax? {
    elem(at: Cursor.attributes).map(RawAttributeListSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    elem(at: Cursor.modifiers).map(RawModifierListSyntax.init(raw:))
  }
  public var funcKeyword: RawTokenSyntax {
    elem(at: Cursor.funcKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var identifier: RawTokenSyntax {
    elem(at: Cursor.identifier).map(RawTokenSyntax.init(raw:))!
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    elem(at: Cursor.genericParameterClause).map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var signature: RawFunctionSignatureSyntax {
    elem(at: Cursor.signature).map(RawFunctionSignatureSyntax.init(raw:))!
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    elem(at: Cursor.genericWhereClause).map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax? {
    elem(at: Cursor.body).map(RawCodeBlockSyntax.init(raw:))
  }

  public struct Builder {
    public var attributes: RawAttributeListSyntax? = nil
    public var modifiers: RawModifierListSyntax? = nil
    public var funcKeyword: RawTokenSyntax? = nil
    public var identifier: RawTokenSyntax? = nil
    public var genericParameterClause: RawGenericParameterClauseSyntax? = nil
    public var signature: RawFunctionSignatureSyntax? = nil
    public var genericWhereClause: RawGenericWhereClauseSyntax? = nil
    public var body: RawCodeBlockSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawFunctionDeclSyntax {
      .make(arena: arena
      , attributes: self.attributes
      , modifiers: self.modifiers
      , funcKeyword: self.funcKeyword
          ?? .makeBlank(arena: arena, tokenKind: .funcKeyword)
      , identifier: self.identifier
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , genericParameterClause: self.genericParameterClause
      , signature: self.signature
          ?? .makeBlank(arena: arena)
      , genericWhereClause: self.genericWhereClause
      , body: self.body
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawFunctionDeclSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, attributes: RawAttributeListSyntax? = nil, modifiers: RawModifierListSyntax? = nil, funcKeyword: RawTokenSyntax, identifier: RawTokenSyntax, genericParameterClause: RawGenericParameterClauseSyntax? = nil, signature: RawFunctionSignatureSyntax, genericWhereClause: RawGenericWhereClauseSyntax? = nil, body: RawCodeBlockSyntax? = nil) -> RawFunctionDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .functionDecl,
                                   uninitializedCount: 8) { layout in
      layout.initialize(repeating: nil)
      layout[0] = attributes?.raw
      layout[1] = modifiers?.raw
      layout[2] = funcKeyword.raw
      layout[3] = identifier.raw
      layout[4] = genericParameterClause?.raw
      layout[5] = signature.raw
      layout[6] = genericWhereClause?.raw
      layout[7] = body?.raw
    }
    return .init(raw: raw)
  }
}

extension RawInitializerDeclSyntax {
  typealias Cursor = InitializerDeclSyntax.Cursor
  public var attributes: RawAttributeListSyntax? {
    elem(at: Cursor.attributes).map(RawAttributeListSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    elem(at: Cursor.modifiers).map(RawModifierListSyntax.init(raw:))
  }
  public var initKeyword: RawTokenSyntax {
    elem(at: Cursor.initKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var optionalMark: RawTokenSyntax? {
    elem(at: Cursor.optionalMark).map(RawTokenSyntax.init(raw:))
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    elem(at: Cursor.genericParameterClause).map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var signature: RawFunctionSignatureSyntax {
    elem(at: Cursor.signature).map(RawFunctionSignatureSyntax.init(raw:))!
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    elem(at: Cursor.genericWhereClause).map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax? {
    elem(at: Cursor.body).map(RawCodeBlockSyntax.init(raw:))
  }

  public struct Builder {
    public var attributes: RawAttributeListSyntax? = nil
    public var modifiers: RawModifierListSyntax? = nil
    public var initKeyword: RawTokenSyntax? = nil
    public var optionalMark: RawTokenSyntax? = nil
    public var genericParameterClause: RawGenericParameterClauseSyntax? = nil
    public var signature: RawFunctionSignatureSyntax? = nil
    public var genericWhereClause: RawGenericWhereClauseSyntax? = nil
    public var body: RawCodeBlockSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawInitializerDeclSyntax {
      .make(arena: arena
      , attributes: self.attributes
      , modifiers: self.modifiers
      , initKeyword: self.initKeyword
          ?? .makeBlank(arena: arena, tokenKind: .initKeyword)
      , optionalMark: self.optionalMark
      , genericParameterClause: self.genericParameterClause
      , signature: self.signature
          ?? .makeBlank(arena: arena)
      , genericWhereClause: self.genericWhereClause
      , body: self.body
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawInitializerDeclSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, attributes: RawAttributeListSyntax? = nil, modifiers: RawModifierListSyntax? = nil, initKeyword: RawTokenSyntax, optionalMark: RawTokenSyntax? = nil, genericParameterClause: RawGenericParameterClauseSyntax? = nil, signature: RawFunctionSignatureSyntax, genericWhereClause: RawGenericWhereClauseSyntax? = nil, body: RawCodeBlockSyntax? = nil) -> RawInitializerDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .initializerDecl,
                                   uninitializedCount: 8) { layout in
      layout.initialize(repeating: nil)
      layout[0] = attributes?.raw
      layout[1] = modifiers?.raw
      layout[2] = initKeyword.raw
      layout[3] = optionalMark?.raw
      layout[4] = genericParameterClause?.raw
      layout[5] = signature.raw
      layout[6] = genericWhereClause?.raw
      layout[7] = body?.raw
    }
    return .init(raw: raw)
  }
}

extension RawDeinitializerDeclSyntax {
  typealias Cursor = DeinitializerDeclSyntax.Cursor
  public var attributes: RawAttributeListSyntax? {
    elem(at: Cursor.attributes).map(RawAttributeListSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    elem(at: Cursor.modifiers).map(RawModifierListSyntax.init(raw:))
  }
  public var deinitKeyword: RawTokenSyntax {
    elem(at: Cursor.deinitKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var body: RawCodeBlockSyntax? {
    elem(at: Cursor.body).map(RawCodeBlockSyntax.init(raw:))
  }

  public struct Builder {
    public var attributes: RawAttributeListSyntax? = nil
    public var modifiers: RawModifierListSyntax? = nil
    public var deinitKeyword: RawTokenSyntax? = nil
    public var body: RawCodeBlockSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawDeinitializerDeclSyntax {
      .make(arena: arena
      , attributes: self.attributes
      , modifiers: self.modifiers
      , deinitKeyword: self.deinitKeyword
          ?? .makeBlank(arena: arena, tokenKind: .deinitKeyword)
      , body: self.body
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawDeinitializerDeclSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, attributes: RawAttributeListSyntax? = nil, modifiers: RawModifierListSyntax? = nil, deinitKeyword: RawTokenSyntax, body: RawCodeBlockSyntax? = nil) -> RawDeinitializerDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .deinitializerDecl,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = attributes?.raw
      layout[1] = modifiers?.raw
      layout[2] = deinitKeyword.raw
      layout[3] = body?.raw
    }
    return .init(raw: raw)
  }
}

extension RawSubscriptDeclSyntax {
  typealias Cursor = SubscriptDeclSyntax.Cursor
  public var attributes: RawAttributeListSyntax? {
    elem(at: Cursor.attributes).map(RawAttributeListSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    elem(at: Cursor.modifiers).map(RawModifierListSyntax.init(raw:))
  }
  public var subscriptKeyword: RawTokenSyntax {
    elem(at: Cursor.subscriptKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var genericParameterClause: RawGenericParameterClauseSyntax? {
    elem(at: Cursor.genericParameterClause).map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var indices: RawParameterClauseSyntax {
    elem(at: Cursor.indices).map(RawParameterClauseSyntax.init(raw:))!
  }
  public var result: RawReturnClauseSyntax {
    elem(at: Cursor.result).map(RawReturnClauseSyntax.init(raw:))!
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    elem(at: Cursor.genericWhereClause).map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var accessor: RawSyntax? {
    elem(at: Cursor.accessor).map(RawSyntax.init(raw:))
  }

  public struct Builder {
    public var attributes: RawAttributeListSyntax? = nil
    public var modifiers: RawModifierListSyntax? = nil
    public var subscriptKeyword: RawTokenSyntax? = nil
    public var genericParameterClause: RawGenericParameterClauseSyntax? = nil
    public var indices: RawParameterClauseSyntax? = nil
    public var result: RawReturnClauseSyntax? = nil
    public var genericWhereClause: RawGenericWhereClauseSyntax? = nil
    public var accessor: RawSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawSubscriptDeclSyntax {
      .make(arena: arena
      , attributes: self.attributes
      , modifiers: self.modifiers
      , subscriptKeyword: self.subscriptKeyword
          ?? .makeBlank(arena: arena, tokenKind: .subscriptKeyword)
      , genericParameterClause: self.genericParameterClause
      , indices: self.indices
          ?? .makeBlank(arena: arena)
      , result: self.result
          ?? .makeBlank(arena: arena)
      , genericWhereClause: self.genericWhereClause
      , accessor: self.accessor
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawSubscriptDeclSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, attributes: RawAttributeListSyntax? = nil, modifiers: RawModifierListSyntax? = nil, subscriptKeyword: RawTokenSyntax, genericParameterClause: RawGenericParameterClauseSyntax? = nil, indices: RawParameterClauseSyntax, result: RawReturnClauseSyntax, genericWhereClause: RawGenericWhereClauseSyntax? = nil, accessor: RawSyntax? = nil) -> RawSubscriptDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .subscriptDecl,
                                   uninitializedCount: 8) { layout in
      layout.initialize(repeating: nil)
      layout[0] = attributes?.raw
      layout[1] = modifiers?.raw
      layout[2] = subscriptKeyword.raw
      layout[3] = genericParameterClause?.raw
      layout[4] = indices.raw
      layout[5] = result.raw
      layout[6] = genericWhereClause?.raw
      layout[7] = accessor?.raw
    }
    return .init(raw: raw)
  }
}

extension RawAccessLevelModifierSyntax {
  typealias Cursor = AccessLevelModifierSyntax.Cursor
  public var name: RawTokenSyntax {
    elem(at: Cursor.name).map(RawTokenSyntax.init(raw:))!
  }
  public var modifier: RawDeclModifierDetailSyntax? {
    elem(at: Cursor.modifier).map(RawDeclModifierDetailSyntax.init(raw:))
  }

  public struct Builder {
    public var name: RawTokenSyntax? = nil
    public var modifier: RawDeclModifierDetailSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawAccessLevelModifierSyntax {
      .make(arena: arena
      , name: self.name
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , modifier: self.modifier
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawAccessLevelModifierSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, name: RawTokenSyntax, modifier: RawDeclModifierDetailSyntax? = nil) -> RawAccessLevelModifierSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .accessLevelModifier,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = name.raw
      layout[1] = modifier?.raw
    }
    return .init(raw: raw)
  }
}

extension RawAccessPathComponentSyntax {
  typealias Cursor = AccessPathComponentSyntax.Cursor
  public var name: RawTokenSyntax {
    elem(at: Cursor.name).map(RawTokenSyntax.init(raw:))!
  }
  public var trailingDot: RawTokenSyntax? {
    elem(at: Cursor.trailingDot).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var name: RawTokenSyntax? = nil
    public var trailingDot: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawAccessPathComponentSyntax {
      .make(arena: arena
      , name: self.name
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , trailingDot: self.trailingDot
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawAccessPathComponentSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, name: RawTokenSyntax, trailingDot: RawTokenSyntax? = nil) -> RawAccessPathComponentSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .accessPathComponent,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = name.raw
      layout[1] = trailingDot?.raw
    }
    return .init(raw: raw)
  }
}

extension RawImportDeclSyntax {
  typealias Cursor = ImportDeclSyntax.Cursor
  public var attributes: RawAttributeListSyntax? {
    elem(at: Cursor.attributes).map(RawAttributeListSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    elem(at: Cursor.modifiers).map(RawModifierListSyntax.init(raw:))
  }
  public var importTok: RawTokenSyntax {
    elem(at: Cursor.importTok).map(RawTokenSyntax.init(raw:))!
  }
  public var importKind: RawTokenSyntax? {
    elem(at: Cursor.importKind).map(RawTokenSyntax.init(raw:))
  }
  public var path: RawAccessPathSyntax {
    elem(at: Cursor.path).map(RawAccessPathSyntax.init(raw:))!
  }

  public struct Builder {
    public var attributes: RawAttributeListSyntax? = nil
    public var modifiers: RawModifierListSyntax? = nil
    public var importTok: RawTokenSyntax? = nil
    public var importKind: RawTokenSyntax? = nil
    public var path: RawAccessPathSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawImportDeclSyntax {
      .make(arena: arena
      , attributes: self.attributes
      , modifiers: self.modifiers
      , importTok: self.importTok
          ?? .makeBlank(arena: arena, tokenKind: .importKeyword)
      , importKind: self.importKind
      , path: self.path
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawImportDeclSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, attributes: RawAttributeListSyntax? = nil, modifiers: RawModifierListSyntax? = nil, importTok: RawTokenSyntax, importKind: RawTokenSyntax? = nil, path: RawAccessPathSyntax) -> RawImportDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .importDecl,
                                   uninitializedCount: 5) { layout in
      layout.initialize(repeating: nil)
      layout[0] = attributes?.raw
      layout[1] = modifiers?.raw
      layout[2] = importTok.raw
      layout[3] = importKind?.raw
      layout[4] = path.raw
    }
    return .init(raw: raw)
  }
}

extension RawAccessorParameterSyntax {
  typealias Cursor = AccessorParameterSyntax.Cursor
  public var leftParen: RawTokenSyntax {
    elem(at: Cursor.leftParen).map(RawTokenSyntax.init(raw:))!
  }
  public var name: RawTokenSyntax {
    elem(at: Cursor.name).map(RawTokenSyntax.init(raw:))!
  }
  public var rightParen: RawTokenSyntax {
    elem(at: Cursor.rightParen).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var leftParen: RawTokenSyntax? = nil
    public var name: RawTokenSyntax? = nil
    public var rightParen: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawAccessorParameterSyntax {
      .make(arena: arena
      , leftParen: self.leftParen
          ?? .makeBlank(arena: arena, tokenKind: .leftParen)
      , name: self.name
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , rightParen: self.rightParen
          ?? .makeBlank(arena: arena, tokenKind: .rightParen)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawAccessorParameterSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, leftParen: RawTokenSyntax, name: RawTokenSyntax, rightParen: RawTokenSyntax) -> RawAccessorParameterSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .accessorParameter,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = leftParen.raw
      layout[1] = name.raw
      layout[2] = rightParen.raw
    }
    return .init(raw: raw)
  }
}

extension RawAccessorDeclSyntax {
  typealias Cursor = AccessorDeclSyntax.Cursor
  public var attributes: RawAttributeListSyntax? {
    elem(at: Cursor.attributes).map(RawAttributeListSyntax.init(raw:))
  }
  public var modifier: RawDeclModifierSyntax? {
    elem(at: Cursor.modifier).map(RawDeclModifierSyntax.init(raw:))
  }
  public var accessorKind: RawTokenSyntax {
    elem(at: Cursor.accessorKind).map(RawTokenSyntax.init(raw:))!
  }
  public var parameter: RawAccessorParameterSyntax? {
    elem(at: Cursor.parameter).map(RawAccessorParameterSyntax.init(raw:))
  }
  public var asyncKeyword: RawTokenSyntax? {
    elem(at: Cursor.asyncKeyword).map(RawTokenSyntax.init(raw:))
  }
  public var throwsKeyword: RawTokenSyntax? {
    elem(at: Cursor.throwsKeyword).map(RawTokenSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax? {
    elem(at: Cursor.body).map(RawCodeBlockSyntax.init(raw:))
  }

  public struct Builder {
    public var attributes: RawAttributeListSyntax? = nil
    public var modifier: RawDeclModifierSyntax? = nil
    public var accessorKind: RawTokenSyntax? = nil
    public var parameter: RawAccessorParameterSyntax? = nil
    public var asyncKeyword: RawTokenSyntax? = nil
    public var throwsKeyword: RawTokenSyntax? = nil
    public var body: RawCodeBlockSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawAccessorDeclSyntax {
      .make(arena: arena
      , attributes: self.attributes
      , modifier: self.modifier
      , accessorKind: self.accessorKind
          ?? .makeBlank(arena: arena, tokenKind: .unknown)
      , parameter: self.parameter
      , asyncKeyword: self.asyncKeyword
      , throwsKeyword: self.throwsKeyword
      , body: self.body
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawAccessorDeclSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, attributes: RawAttributeListSyntax? = nil, modifier: RawDeclModifierSyntax? = nil, accessorKind: RawTokenSyntax, parameter: RawAccessorParameterSyntax? = nil, asyncKeyword: RawTokenSyntax? = nil, throwsKeyword: RawTokenSyntax? = nil, body: RawCodeBlockSyntax? = nil) -> RawAccessorDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .accessorDecl,
                                   uninitializedCount: 7) { layout in
      layout.initialize(repeating: nil)
      layout[0] = attributes?.raw
      layout[1] = modifier?.raw
      layout[2] = accessorKind.raw
      layout[3] = parameter?.raw
      layout[4] = asyncKeyword?.raw
      layout[5] = throwsKeyword?.raw
      layout[6] = body?.raw
    }
    return .init(raw: raw)
  }
}

extension RawAccessorBlockSyntax {
  typealias Cursor = AccessorBlockSyntax.Cursor
  public var leftBrace: RawTokenSyntax {
    elem(at: Cursor.leftBrace).map(RawTokenSyntax.init(raw:))!
  }
  public var accessors: RawAccessorListSyntax {
    elem(at: Cursor.accessors).map(RawAccessorListSyntax.init(raw:))!
  }
  public var rightBrace: RawTokenSyntax {
    elem(at: Cursor.rightBrace).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var leftBrace: RawTokenSyntax? = nil
    public var accessors: RawAccessorListSyntax? = nil
    public var rightBrace: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawAccessorBlockSyntax {
      .make(arena: arena
      , leftBrace: self.leftBrace
          ?? .makeBlank(arena: arena, tokenKind: .leftBrace)
      , accessors: self.accessors
          ?? .makeBlank(arena: arena)
      , rightBrace: self.rightBrace
          ?? .makeBlank(arena: arena, tokenKind: .rightBrace)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawAccessorBlockSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, leftBrace: RawTokenSyntax, accessors: RawAccessorListSyntax, rightBrace: RawTokenSyntax) -> RawAccessorBlockSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .accessorBlock,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = leftBrace.raw
      layout[1] = accessors.raw
      layout[2] = rightBrace.raw
    }
    return .init(raw: raw)
  }
}

extension RawPatternBindingSyntax {
  typealias Cursor = PatternBindingSyntax.Cursor
  public var pattern: RawPatternSyntax {
    elem(at: Cursor.pattern).map(RawPatternSyntax.init(raw:))!
  }
  public var typeAnnotation: RawTypeAnnotationSyntax? {
    elem(at: Cursor.typeAnnotation).map(RawTypeAnnotationSyntax.init(raw:))
  }
  public var initializer: RawInitializerClauseSyntax? {
    elem(at: Cursor.initializer).map(RawInitializerClauseSyntax.init(raw:))
  }
  public var accessor: RawSyntax? {
    elem(at: Cursor.accessor).map(RawSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    elem(at: Cursor.trailingComma).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var pattern: RawPatternSyntax? = nil
    public var typeAnnotation: RawTypeAnnotationSyntax? = nil
    public var initializer: RawInitializerClauseSyntax? = nil
    public var accessor: RawSyntax? = nil
    public var trailingComma: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawPatternBindingSyntax {
      .make(arena: arena
      , pattern: self.pattern
          ?? .makeBlank(arena: arena)
      , typeAnnotation: self.typeAnnotation
      , initializer: self.initializer
      , accessor: self.accessor
      , trailingComma: self.trailingComma
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawPatternBindingSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, pattern: RawPatternSyntax, typeAnnotation: RawTypeAnnotationSyntax? = nil, initializer: RawInitializerClauseSyntax? = nil, accessor: RawSyntax? = nil, trailingComma: RawTokenSyntax? = nil) -> RawPatternBindingSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .patternBinding,
                                   uninitializedCount: 5) { layout in
      layout.initialize(repeating: nil)
      layout[0] = pattern.raw
      layout[1] = typeAnnotation?.raw
      layout[2] = initializer?.raw
      layout[3] = accessor?.raw
      layout[4] = trailingComma?.raw
    }
    return .init(raw: raw)
  }
}

extension RawVariableDeclSyntax {
  typealias Cursor = VariableDeclSyntax.Cursor
  public var attributes: RawAttributeListSyntax? {
    elem(at: Cursor.attributes).map(RawAttributeListSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    elem(at: Cursor.modifiers).map(RawModifierListSyntax.init(raw:))
  }
  public var letOrVarKeyword: RawTokenSyntax {
    elem(at: Cursor.letOrVarKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var bindings: RawPatternBindingListSyntax {
    elem(at: Cursor.bindings).map(RawPatternBindingListSyntax.init(raw:))!
  }

  public struct Builder {
    public var attributes: RawAttributeListSyntax? = nil
    public var modifiers: RawModifierListSyntax? = nil
    public var letOrVarKeyword: RawTokenSyntax? = nil
    public var bindings: RawPatternBindingListSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawVariableDeclSyntax {
      .make(arena: arena
      , attributes: self.attributes
      , modifiers: self.modifiers
      , letOrVarKeyword: self.letOrVarKeyword
          ?? .makeBlank(arena: arena, tokenKind: .letKeyword)
      , bindings: self.bindings
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawVariableDeclSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, attributes: RawAttributeListSyntax? = nil, modifiers: RawModifierListSyntax? = nil, letOrVarKeyword: RawTokenSyntax, bindings: RawPatternBindingListSyntax) -> RawVariableDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .variableDecl,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = attributes?.raw
      layout[1] = modifiers?.raw
      layout[2] = letOrVarKeyword.raw
      layout[3] = bindings.raw
    }
    return .init(raw: raw)
  }
}

extension RawEnumCaseElementSyntax {
  typealias Cursor = EnumCaseElementSyntax.Cursor
  public var identifier: RawTokenSyntax {
    elem(at: Cursor.identifier).map(RawTokenSyntax.init(raw:))!
  }
  public var associatedValue: RawParameterClauseSyntax? {
    elem(at: Cursor.associatedValue).map(RawParameterClauseSyntax.init(raw:))
  }
  public var rawValue: RawInitializerClauseSyntax? {
    elem(at: Cursor.rawValue).map(RawInitializerClauseSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    elem(at: Cursor.trailingComma).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var identifier: RawTokenSyntax? = nil
    public var associatedValue: RawParameterClauseSyntax? = nil
    public var rawValue: RawInitializerClauseSyntax? = nil
    public var trailingComma: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawEnumCaseElementSyntax {
      .make(arena: arena
      , identifier: self.identifier
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , associatedValue: self.associatedValue
      , rawValue: self.rawValue
      , trailingComma: self.trailingComma
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawEnumCaseElementSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, identifier: RawTokenSyntax, associatedValue: RawParameterClauseSyntax? = nil, rawValue: RawInitializerClauseSyntax? = nil, trailingComma: RawTokenSyntax? = nil) -> RawEnumCaseElementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .enumCaseElement,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = identifier.raw
      layout[1] = associatedValue?.raw
      layout[2] = rawValue?.raw
      layout[3] = trailingComma?.raw
    }
    return .init(raw: raw)
  }
}

extension RawEnumCaseDeclSyntax {
  typealias Cursor = EnumCaseDeclSyntax.Cursor
  public var attributes: RawAttributeListSyntax? {
    elem(at: Cursor.attributes).map(RawAttributeListSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    elem(at: Cursor.modifiers).map(RawModifierListSyntax.init(raw:))
  }
  public var caseKeyword: RawTokenSyntax {
    elem(at: Cursor.caseKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var elements: RawEnumCaseElementListSyntax {
    elem(at: Cursor.elements).map(RawEnumCaseElementListSyntax.init(raw:))!
  }

  public struct Builder {
    public var attributes: RawAttributeListSyntax? = nil
    public var modifiers: RawModifierListSyntax? = nil
    public var caseKeyword: RawTokenSyntax? = nil
    public var elements: RawEnumCaseElementListSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawEnumCaseDeclSyntax {
      .make(arena: arena
      , attributes: self.attributes
      , modifiers: self.modifiers
      , caseKeyword: self.caseKeyword
          ?? .makeBlank(arena: arena, tokenKind: .caseKeyword)
      , elements: self.elements
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawEnumCaseDeclSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, attributes: RawAttributeListSyntax? = nil, modifiers: RawModifierListSyntax? = nil, caseKeyword: RawTokenSyntax, elements: RawEnumCaseElementListSyntax) -> RawEnumCaseDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .enumCaseDecl,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = attributes?.raw
      layout[1] = modifiers?.raw
      layout[2] = caseKeyword.raw
      layout[3] = elements.raw
    }
    return .init(raw: raw)
  }
}

extension RawEnumDeclSyntax {
  typealias Cursor = EnumDeclSyntax.Cursor
  public var attributes: RawAttributeListSyntax? {
    elem(at: Cursor.attributes).map(RawAttributeListSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    elem(at: Cursor.modifiers).map(RawModifierListSyntax.init(raw:))
  }
  public var enumKeyword: RawTokenSyntax {
    elem(at: Cursor.enumKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var identifier: RawTokenSyntax {
    elem(at: Cursor.identifier).map(RawTokenSyntax.init(raw:))!
  }
  public var genericParameters: RawGenericParameterClauseSyntax? {
    elem(at: Cursor.genericParameters).map(RawGenericParameterClauseSyntax.init(raw:))
  }
  public var inheritanceClause: RawTypeInheritanceClauseSyntax? {
    elem(at: Cursor.inheritanceClause).map(RawTypeInheritanceClauseSyntax.init(raw:))
  }
  public var genericWhereClause: RawGenericWhereClauseSyntax? {
    elem(at: Cursor.genericWhereClause).map(RawGenericWhereClauseSyntax.init(raw:))
  }
  public var members: RawMemberDeclBlockSyntax {
    elem(at: Cursor.members).map(RawMemberDeclBlockSyntax.init(raw:))!
  }

  public struct Builder {
    public var attributes: RawAttributeListSyntax? = nil
    public var modifiers: RawModifierListSyntax? = nil
    public var enumKeyword: RawTokenSyntax? = nil
    public var identifier: RawTokenSyntax? = nil
    public var genericParameters: RawGenericParameterClauseSyntax? = nil
    public var inheritanceClause: RawTypeInheritanceClauseSyntax? = nil
    public var genericWhereClause: RawGenericWhereClauseSyntax? = nil
    public var members: RawMemberDeclBlockSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawEnumDeclSyntax {
      .make(arena: arena
      , attributes: self.attributes
      , modifiers: self.modifiers
      , enumKeyword: self.enumKeyword
          ?? .makeBlank(arena: arena, tokenKind: .enumKeyword)
      , identifier: self.identifier
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , genericParameters: self.genericParameters
      , inheritanceClause: self.inheritanceClause
      , genericWhereClause: self.genericWhereClause
      , members: self.members
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawEnumDeclSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, attributes: RawAttributeListSyntax? = nil, modifiers: RawModifierListSyntax? = nil, enumKeyword: RawTokenSyntax, identifier: RawTokenSyntax, genericParameters: RawGenericParameterClauseSyntax? = nil, inheritanceClause: RawTypeInheritanceClauseSyntax? = nil, genericWhereClause: RawGenericWhereClauseSyntax? = nil, members: RawMemberDeclBlockSyntax) -> RawEnumDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .enumDecl,
                                   uninitializedCount: 8) { layout in
      layout.initialize(repeating: nil)
      layout[0] = attributes?.raw
      layout[1] = modifiers?.raw
      layout[2] = enumKeyword.raw
      layout[3] = identifier.raw
      layout[4] = genericParameters?.raw
      layout[5] = inheritanceClause?.raw
      layout[6] = genericWhereClause?.raw
      layout[7] = members.raw
    }
    return .init(raw: raw)
  }
}

extension RawOperatorDeclSyntax {
  typealias Cursor = OperatorDeclSyntax.Cursor
  public var attributes: RawAttributeListSyntax? {
    elem(at: Cursor.attributes).map(RawAttributeListSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    elem(at: Cursor.modifiers).map(RawModifierListSyntax.init(raw:))
  }
  public var operatorKeyword: RawTokenSyntax {
    elem(at: Cursor.operatorKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var identifier: RawTokenSyntax {
    elem(at: Cursor.identifier).map(RawTokenSyntax.init(raw:))!
  }
  public var operatorPrecedenceAndTypes: RawOperatorPrecedenceAndTypesSyntax? {
    elem(at: Cursor.operatorPrecedenceAndTypes).map(RawOperatorPrecedenceAndTypesSyntax.init(raw:))
  }

  public struct Builder {
    public var attributes: RawAttributeListSyntax? = nil
    public var modifiers: RawModifierListSyntax? = nil
    public var operatorKeyword: RawTokenSyntax? = nil
    public var identifier: RawTokenSyntax? = nil
    public var operatorPrecedenceAndTypes: RawOperatorPrecedenceAndTypesSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawOperatorDeclSyntax {
      .make(arena: arena
      , attributes: self.attributes
      , modifiers: self.modifiers
      , operatorKeyword: self.operatorKeyword
          ?? .makeBlank(arena: arena, tokenKind: .operatorKeyword)
      , identifier: self.identifier
          ?? .makeBlank(arena: arena, tokenKind: .unspacedBinaryOperator)
      , operatorPrecedenceAndTypes: self.operatorPrecedenceAndTypes
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawOperatorDeclSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, attributes: RawAttributeListSyntax? = nil, modifiers: RawModifierListSyntax? = nil, operatorKeyword: RawTokenSyntax, identifier: RawTokenSyntax, operatorPrecedenceAndTypes: RawOperatorPrecedenceAndTypesSyntax? = nil) -> RawOperatorDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .operatorDecl,
                                   uninitializedCount: 5) { layout in
      layout.initialize(repeating: nil)
      layout[0] = attributes?.raw
      layout[1] = modifiers?.raw
      layout[2] = operatorKeyword.raw
      layout[3] = identifier.raw
      layout[4] = operatorPrecedenceAndTypes?.raw
    }
    return .init(raw: raw)
  }
}

extension RawOperatorPrecedenceAndTypesSyntax {
  typealias Cursor = OperatorPrecedenceAndTypesSyntax.Cursor
  public var colon: RawTokenSyntax {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))!
  }
  public var precedenceGroupAndDesignatedTypes: RawIdentifierListSyntax {
    elem(at: Cursor.precedenceGroupAndDesignatedTypes).map(RawIdentifierListSyntax.init(raw:))!
  }

  public struct Builder {
    public var colon: RawTokenSyntax? = nil
    public var precedenceGroupAndDesignatedTypes: RawIdentifierListSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawOperatorPrecedenceAndTypesSyntax {
      .make(arena: arena
      , colon: self.colon
          ?? .makeBlank(arena: arena, tokenKind: .colon)
      , precedenceGroupAndDesignatedTypes: self.precedenceGroupAndDesignatedTypes
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawOperatorPrecedenceAndTypesSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, colon: RawTokenSyntax, precedenceGroupAndDesignatedTypes: RawIdentifierListSyntax) -> RawOperatorPrecedenceAndTypesSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .operatorPrecedenceAndTypes,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = colon.raw
      layout[1] = precedenceGroupAndDesignatedTypes.raw
    }
    return .init(raw: raw)
  }
}

extension RawPrecedenceGroupDeclSyntax {
  typealias Cursor = PrecedenceGroupDeclSyntax.Cursor
  public var attributes: RawAttributeListSyntax? {
    elem(at: Cursor.attributes).map(RawAttributeListSyntax.init(raw:))
  }
  public var modifiers: RawModifierListSyntax? {
    elem(at: Cursor.modifiers).map(RawModifierListSyntax.init(raw:))
  }
  public var precedencegroupKeyword: RawTokenSyntax {
    elem(at: Cursor.precedencegroupKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var identifier: RawTokenSyntax {
    elem(at: Cursor.identifier).map(RawTokenSyntax.init(raw:))!
  }
  public var leftBrace: RawTokenSyntax {
    elem(at: Cursor.leftBrace).map(RawTokenSyntax.init(raw:))!
  }
  public var groupAttributes: RawPrecedenceGroupAttributeListSyntax {
    elem(at: Cursor.groupAttributes).map(RawPrecedenceGroupAttributeListSyntax.init(raw:))!
  }
  public var rightBrace: RawTokenSyntax {
    elem(at: Cursor.rightBrace).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var attributes: RawAttributeListSyntax? = nil
    public var modifiers: RawModifierListSyntax? = nil
    public var precedencegroupKeyword: RawTokenSyntax? = nil
    public var identifier: RawTokenSyntax? = nil
    public var leftBrace: RawTokenSyntax? = nil
    public var groupAttributes: RawPrecedenceGroupAttributeListSyntax? = nil
    public var rightBrace: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawPrecedenceGroupDeclSyntax {
      .make(arena: arena
      , attributes: self.attributes
      , modifiers: self.modifiers
      , precedencegroupKeyword: self.precedencegroupKeyword
          ?? .makeBlank(arena: arena, tokenKind: .precedencegroupKeyword)
      , identifier: self.identifier
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , leftBrace: self.leftBrace
          ?? .makeBlank(arena: arena, tokenKind: .leftBrace)
      , groupAttributes: self.groupAttributes
          ?? .makeBlank(arena: arena)
      , rightBrace: self.rightBrace
          ?? .makeBlank(arena: arena, tokenKind: .rightBrace)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawPrecedenceGroupDeclSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, attributes: RawAttributeListSyntax? = nil, modifiers: RawModifierListSyntax? = nil, precedencegroupKeyword: RawTokenSyntax, identifier: RawTokenSyntax, leftBrace: RawTokenSyntax, groupAttributes: RawPrecedenceGroupAttributeListSyntax, rightBrace: RawTokenSyntax) -> RawPrecedenceGroupDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .precedenceGroupDecl,
                                   uninitializedCount: 7) { layout in
      layout.initialize(repeating: nil)
      layout[0] = attributes?.raw
      layout[1] = modifiers?.raw
      layout[2] = precedencegroupKeyword.raw
      layout[3] = identifier.raw
      layout[4] = leftBrace.raw
      layout[5] = groupAttributes.raw
      layout[6] = rightBrace.raw
    }
    return .init(raw: raw)
  }
}

extension RawPrecedenceGroupRelationSyntax {
  typealias Cursor = PrecedenceGroupRelationSyntax.Cursor
  public var higherThanOrLowerThan: RawTokenSyntax {
    elem(at: Cursor.higherThanOrLowerThan).map(RawTokenSyntax.init(raw:))!
  }
  public var colon: RawTokenSyntax {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))!
  }
  public var otherNames: RawPrecedenceGroupNameListSyntax {
    elem(at: Cursor.otherNames).map(RawPrecedenceGroupNameListSyntax.init(raw:))!
  }

  public struct Builder {
    public var higherThanOrLowerThan: RawTokenSyntax? = nil
    public var colon: RawTokenSyntax? = nil
    public var otherNames: RawPrecedenceGroupNameListSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawPrecedenceGroupRelationSyntax {
      .make(arena: arena
      , higherThanOrLowerThan: self.higherThanOrLowerThan
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , colon: self.colon
          ?? .makeBlank(arena: arena, tokenKind: .colon)
      , otherNames: self.otherNames
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawPrecedenceGroupRelationSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, higherThanOrLowerThan: RawTokenSyntax, colon: RawTokenSyntax, otherNames: RawPrecedenceGroupNameListSyntax) -> RawPrecedenceGroupRelationSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .precedenceGroupRelation,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = higherThanOrLowerThan.raw
      layout[1] = colon.raw
      layout[2] = otherNames.raw
    }
    return .init(raw: raw)
  }
}

extension RawPrecedenceGroupNameElementSyntax {
  typealias Cursor = PrecedenceGroupNameElementSyntax.Cursor
  public var name: RawTokenSyntax {
    elem(at: Cursor.name).map(RawTokenSyntax.init(raw:))!
  }
  public var trailingComma: RawTokenSyntax? {
    elem(at: Cursor.trailingComma).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var name: RawTokenSyntax? = nil
    public var trailingComma: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawPrecedenceGroupNameElementSyntax {
      .make(arena: arena
      , name: self.name
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , trailingComma: self.trailingComma
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawPrecedenceGroupNameElementSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, name: RawTokenSyntax, trailingComma: RawTokenSyntax? = nil) -> RawPrecedenceGroupNameElementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .precedenceGroupNameElement,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = name.raw
      layout[1] = trailingComma?.raw
    }
    return .init(raw: raw)
  }
}

extension RawPrecedenceGroupAssignmentSyntax {
  typealias Cursor = PrecedenceGroupAssignmentSyntax.Cursor
  public var assignmentKeyword: RawTokenSyntax {
    elem(at: Cursor.assignmentKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var colon: RawTokenSyntax {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))!
  }
  public var flag: RawTokenSyntax {
    elem(at: Cursor.flag).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var assignmentKeyword: RawTokenSyntax? = nil
    public var colon: RawTokenSyntax? = nil
    public var flag: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawPrecedenceGroupAssignmentSyntax {
      .make(arena: arena
      , assignmentKeyword: self.assignmentKeyword
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , colon: self.colon
          ?? .makeBlank(arena: arena, tokenKind: .colon)
      , flag: self.flag
          ?? .makeBlank(arena: arena, tokenKind: .trueKeyword)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawPrecedenceGroupAssignmentSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, assignmentKeyword: RawTokenSyntax, colon: RawTokenSyntax, flag: RawTokenSyntax) -> RawPrecedenceGroupAssignmentSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .precedenceGroupAssignment,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = assignmentKeyword.raw
      layout[1] = colon.raw
      layout[2] = flag.raw
    }
    return .init(raw: raw)
  }
}

extension RawPrecedenceGroupAssociativitySyntax {
  typealias Cursor = PrecedenceGroupAssociativitySyntax.Cursor
  public var associativityKeyword: RawTokenSyntax {
    elem(at: Cursor.associativityKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var colon: RawTokenSyntax {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))!
  }
  public var value: RawTokenSyntax {
    elem(at: Cursor.value).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var associativityKeyword: RawTokenSyntax? = nil
    public var colon: RawTokenSyntax? = nil
    public var value: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawPrecedenceGroupAssociativitySyntax {
      .make(arena: arena
      , associativityKeyword: self.associativityKeyword
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , colon: self.colon
          ?? .makeBlank(arena: arena, tokenKind: .colon)
      , value: self.value
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawPrecedenceGroupAssociativitySyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, associativityKeyword: RawTokenSyntax, colon: RawTokenSyntax, value: RawTokenSyntax) -> RawPrecedenceGroupAssociativitySyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .precedenceGroupAssociativity,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = associativityKeyword.raw
      layout[1] = colon.raw
      layout[2] = value.raw
    }
    return .init(raw: raw)
  }
}

extension RawCustomAttributeSyntax {
  typealias Cursor = CustomAttributeSyntax.Cursor
  public var atSignToken: RawTokenSyntax {
    elem(at: Cursor.atSignToken).map(RawTokenSyntax.init(raw:))!
  }
  public var attributeName: RawTypeSyntax {
    elem(at: Cursor.attributeName).map(RawTypeSyntax.init(raw:))!
  }
  public var leftParen: RawTokenSyntax? {
    elem(at: Cursor.leftParen).map(RawTokenSyntax.init(raw:))
  }
  public var argumentList: RawTupleExprElementListSyntax? {
    elem(at: Cursor.argumentList).map(RawTupleExprElementListSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax? {
    elem(at: Cursor.rightParen).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var atSignToken: RawTokenSyntax? = nil
    public var attributeName: RawTypeSyntax? = nil
    public var leftParen: RawTokenSyntax? = nil
    public var argumentList: RawTupleExprElementListSyntax? = nil
    public var rightParen: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawCustomAttributeSyntax {
      .make(arena: arena
      , atSignToken: self.atSignToken
          ?? .makeBlank(arena: arena, tokenKind: .atSign)
      , attributeName: self.attributeName
          ?? .makeBlank(arena: arena)
      , leftParen: self.leftParen
      , argumentList: self.argumentList
      , rightParen: self.rightParen
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawCustomAttributeSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, atSignToken: RawTokenSyntax, attributeName: RawTypeSyntax, leftParen: RawTokenSyntax? = nil, argumentList: RawTupleExprElementListSyntax? = nil, rightParen: RawTokenSyntax? = nil) -> RawCustomAttributeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .customAttribute,
                                   uninitializedCount: 5) { layout in
      layout.initialize(repeating: nil)
      layout[0] = atSignToken.raw
      layout[1] = attributeName.raw
      layout[2] = leftParen?.raw
      layout[3] = argumentList?.raw
      layout[4] = rightParen?.raw
    }
    return .init(raw: raw)
  }
}

extension RawAttributeSyntax {
  typealias Cursor = AttributeSyntax.Cursor
  public var atSignToken: RawTokenSyntax {
    elem(at: Cursor.atSignToken).map(RawTokenSyntax.init(raw:))!
  }
  public var attributeName: RawTokenSyntax {
    elem(at: Cursor.attributeName).map(RawTokenSyntax.init(raw:))!
  }
  public var leftParen: RawTokenSyntax? {
    elem(at: Cursor.leftParen).map(RawTokenSyntax.init(raw:))
  }
  public var argument: RawSyntax? {
    elem(at: Cursor.argument).map(RawSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax? {
    elem(at: Cursor.rightParen).map(RawTokenSyntax.init(raw:))
  }
  public var tokenList: RawTokenListSyntax? {
    elem(at: Cursor.tokenList).map(RawTokenListSyntax.init(raw:))
  }

  public struct Builder {
    public var atSignToken: RawTokenSyntax? = nil
    public var attributeName: RawTokenSyntax? = nil
    public var leftParen: RawTokenSyntax? = nil
    public var argument: RawSyntax? = nil
    public var rightParen: RawTokenSyntax? = nil
    public var tokenList: RawTokenListSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawAttributeSyntax {
      .make(arena: arena
      , atSignToken: self.atSignToken
          ?? .makeBlank(arena: arena, tokenKind: .atSign)
      , attributeName: self.attributeName
          ?? .makeBlank(arena: arena, tokenKind: .unknown)
      , leftParen: self.leftParen
      , argument: self.argument
      , rightParen: self.rightParen
      , tokenList: self.tokenList
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawAttributeSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, atSignToken: RawTokenSyntax, attributeName: RawTokenSyntax, leftParen: RawTokenSyntax? = nil, argument: RawSyntax? = nil, rightParen: RawTokenSyntax? = nil, tokenList: RawTokenListSyntax? = nil) -> RawAttributeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .attribute,
                                   uninitializedCount: 6) { layout in
      layout.initialize(repeating: nil)
      layout[0] = atSignToken.raw
      layout[1] = attributeName.raw
      layout[2] = leftParen?.raw
      layout[3] = argument?.raw
      layout[4] = rightParen?.raw
      layout[5] = tokenList?.raw
    }
    return .init(raw: raw)
  }
}

extension RawAvailabilityEntrySyntax {
  typealias Cursor = AvailabilityEntrySyntax.Cursor
  public var label: RawTokenSyntax {
    elem(at: Cursor.label).map(RawTokenSyntax.init(raw:))!
  }
  public var colon: RawTokenSyntax {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))!
  }
  public var availabilityList: RawAvailabilitySpecListSyntax {
    elem(at: Cursor.availabilityList).map(RawAvailabilitySpecListSyntax.init(raw:))!
  }
  public var semicolon: RawTokenSyntax {
    elem(at: Cursor.semicolon).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var label: RawTokenSyntax? = nil
    public var colon: RawTokenSyntax? = nil
    public var availabilityList: RawAvailabilitySpecListSyntax? = nil
    public var semicolon: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawAvailabilityEntrySyntax {
      .make(arena: arena
      , label: self.label
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , colon: self.colon
          ?? .makeBlank(arena: arena, tokenKind: .colon)
      , availabilityList: self.availabilityList
          ?? .makeBlank(arena: arena)
      , semicolon: self.semicolon
          ?? .makeBlank(arena: arena, tokenKind: .semicolon)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawAvailabilityEntrySyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, label: RawTokenSyntax, colon: RawTokenSyntax, availabilityList: RawAvailabilitySpecListSyntax, semicolon: RawTokenSyntax) -> RawAvailabilityEntrySyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .availabilityEntry,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = label.raw
      layout[1] = colon.raw
      layout[2] = availabilityList.raw
      layout[3] = semicolon.raw
    }
    return .init(raw: raw)
  }
}

extension RawLabeledSpecializeEntrySyntax {
  typealias Cursor = LabeledSpecializeEntrySyntax.Cursor
  public var label: RawTokenSyntax {
    elem(at: Cursor.label).map(RawTokenSyntax.init(raw:))!
  }
  public var colon: RawTokenSyntax {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))!
  }
  public var value: RawTokenSyntax {
    elem(at: Cursor.value).map(RawTokenSyntax.init(raw:))!
  }
  public var trailingComma: RawTokenSyntax? {
    elem(at: Cursor.trailingComma).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var label: RawTokenSyntax? = nil
    public var colon: RawTokenSyntax? = nil
    public var value: RawTokenSyntax? = nil
    public var trailingComma: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawLabeledSpecializeEntrySyntax {
      .make(arena: arena
      , label: self.label
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , colon: self.colon
          ?? .makeBlank(arena: arena, tokenKind: .colon)
      , value: self.value
          ?? .makeBlank(arena: arena, tokenKind: .unknown)
      , trailingComma: self.trailingComma
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawLabeledSpecializeEntrySyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, label: RawTokenSyntax, colon: RawTokenSyntax, value: RawTokenSyntax, trailingComma: RawTokenSyntax? = nil) -> RawLabeledSpecializeEntrySyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .labeledSpecializeEntry,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = label.raw
      layout[1] = colon.raw
      layout[2] = value.raw
      layout[3] = trailingComma?.raw
    }
    return .init(raw: raw)
  }
}

extension RawTargetFunctionEntrySyntax {
  typealias Cursor = TargetFunctionEntrySyntax.Cursor
  public var label: RawTokenSyntax {
    elem(at: Cursor.label).map(RawTokenSyntax.init(raw:))!
  }
  public var colon: RawTokenSyntax {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))!
  }
  public var declname: RawDeclNameSyntax {
    elem(at: Cursor.declname).map(RawDeclNameSyntax.init(raw:))!
  }
  public var trailingComma: RawTokenSyntax? {
    elem(at: Cursor.trailingComma).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var label: RawTokenSyntax? = nil
    public var colon: RawTokenSyntax? = nil
    public var declname: RawDeclNameSyntax? = nil
    public var trailingComma: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawTargetFunctionEntrySyntax {
      .make(arena: arena
      , label: self.label
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , colon: self.colon
          ?? .makeBlank(arena: arena, tokenKind: .colon)
      , declname: self.declname
          ?? .makeBlank(arena: arena)
      , trailingComma: self.trailingComma
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawTargetFunctionEntrySyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, label: RawTokenSyntax, colon: RawTokenSyntax, declname: RawDeclNameSyntax, trailingComma: RawTokenSyntax? = nil) -> RawTargetFunctionEntrySyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .targetFunctionEntry,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = label.raw
      layout[1] = colon.raw
      layout[2] = declname.raw
      layout[3] = trailingComma?.raw
    }
    return .init(raw: raw)
  }
}

extension RawNamedAttributeStringArgumentSyntax {
  typealias Cursor = NamedAttributeStringArgumentSyntax.Cursor
  public var nameTok: RawTokenSyntax {
    elem(at: Cursor.nameTok).map(RawTokenSyntax.init(raw:))!
  }
  public var colon: RawTokenSyntax {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))!
  }
  public var stringOrDeclname: RawSyntax {
    elem(at: Cursor.stringOrDeclname).map(RawSyntax.init(raw:))!
  }

  public struct Builder {
    public var nameTok: RawTokenSyntax? = nil
    public var colon: RawTokenSyntax? = nil
    public var stringOrDeclname: RawSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawNamedAttributeStringArgumentSyntax {
      .make(arena: arena
      , nameTok: self.nameTok
          ?? .makeBlank(arena: arena, tokenKind: .unknown)
      , colon: self.colon
          ?? .makeBlank(arena: arena, tokenKind: .colon)
      , stringOrDeclname: self.stringOrDeclname
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawNamedAttributeStringArgumentSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, nameTok: RawTokenSyntax, colon: RawTokenSyntax, stringOrDeclname: RawSyntax) -> RawNamedAttributeStringArgumentSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .namedAttributeStringArgument,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = nameTok.raw
      layout[1] = colon.raw
      layout[2] = stringOrDeclname.raw
    }
    return .init(raw: raw)
  }
}

extension RawDeclNameSyntax {
  typealias Cursor = DeclNameSyntax.Cursor
  public var declBaseName: RawSyntax {
    elem(at: Cursor.declBaseName).map(RawSyntax.init(raw:))!
  }
  public var declNameArguments: RawDeclNameArgumentsSyntax? {
    elem(at: Cursor.declNameArguments).map(RawDeclNameArgumentsSyntax.init(raw:))
  }

  public struct Builder {
    public var declBaseName: RawSyntax? = nil
    public var declNameArguments: RawDeclNameArgumentsSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawDeclNameSyntax {
      .make(arena: arena
      , declBaseName: self.declBaseName
          ?? .makeBlank(arena: arena)
      , declNameArguments: self.declNameArguments
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawDeclNameSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, declBaseName: RawSyntax, declNameArguments: RawDeclNameArgumentsSyntax? = nil) -> RawDeclNameSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .declName,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = declBaseName.raw
      layout[1] = declNameArguments?.raw
    }
    return .init(raw: raw)
  }
}

extension RawImplementsAttributeArgumentsSyntax {
  typealias Cursor = ImplementsAttributeArgumentsSyntax.Cursor
  public var type: RawSimpleTypeIdentifierSyntax {
    elem(at: Cursor.type).map(RawSimpleTypeIdentifierSyntax.init(raw:))!
  }
  public var comma: RawTokenSyntax {
    elem(at: Cursor.comma).map(RawTokenSyntax.init(raw:))!
  }
  public var declBaseName: RawSyntax {
    elem(at: Cursor.declBaseName).map(RawSyntax.init(raw:))!
  }
  public var declNameArguments: RawDeclNameArgumentsSyntax? {
    elem(at: Cursor.declNameArguments).map(RawDeclNameArgumentsSyntax.init(raw:))
  }

  public struct Builder {
    public var type: RawSimpleTypeIdentifierSyntax? = nil
    public var comma: RawTokenSyntax? = nil
    public var declBaseName: RawSyntax? = nil
    public var declNameArguments: RawDeclNameArgumentsSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawImplementsAttributeArgumentsSyntax {
      .make(arena: arena
      , type: self.type
          ?? .makeBlank(arena: arena)
      , comma: self.comma
          ?? .makeBlank(arena: arena, tokenKind: .comma)
      , declBaseName: self.declBaseName
          ?? .makeBlank(arena: arena)
      , declNameArguments: self.declNameArguments
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawImplementsAttributeArgumentsSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, type: RawSimpleTypeIdentifierSyntax, comma: RawTokenSyntax, declBaseName: RawSyntax, declNameArguments: RawDeclNameArgumentsSyntax? = nil) -> RawImplementsAttributeArgumentsSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .implementsAttributeArguments,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = type.raw
      layout[1] = comma.raw
      layout[2] = declBaseName.raw
      layout[3] = declNameArguments?.raw
    }
    return .init(raw: raw)
  }
}

extension RawObjCSelectorPieceSyntax {
  typealias Cursor = ObjCSelectorPieceSyntax.Cursor
  public var name: RawTokenSyntax? {
    elem(at: Cursor.name).map(RawTokenSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax? {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var name: RawTokenSyntax? = nil
    public var colon: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawObjCSelectorPieceSyntax {
      .make(arena: arena
      , name: self.name
      , colon: self.colon
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawObjCSelectorPieceSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, name: RawTokenSyntax? = nil, colon: RawTokenSyntax? = nil) -> RawObjCSelectorPieceSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .objCSelectorPiece,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = name?.raw
      layout[1] = colon?.raw
    }
    return .init(raw: raw)
  }
}

extension RawDifferentiableAttributeArgumentsSyntax {
  typealias Cursor = DifferentiableAttributeArgumentsSyntax.Cursor
  public var diffKind: RawTokenSyntax? {
    elem(at: Cursor.diffKind).map(RawTokenSyntax.init(raw:))
  }
  public var diffKindComma: RawTokenSyntax? {
    elem(at: Cursor.diffKindComma).map(RawTokenSyntax.init(raw:))
  }
  public var diffParams: RawDifferentiabilityParamsClauseSyntax? {
    elem(at: Cursor.diffParams).map(RawDifferentiabilityParamsClauseSyntax.init(raw:))
  }
  public var diffParamsComma: RawTokenSyntax? {
    elem(at: Cursor.diffParamsComma).map(RawTokenSyntax.init(raw:))
  }
  public var whereClause: RawGenericWhereClauseSyntax? {
    elem(at: Cursor.whereClause).map(RawGenericWhereClauseSyntax.init(raw:))
  }

  public struct Builder {
    public var diffKind: RawTokenSyntax? = nil
    public var diffKindComma: RawTokenSyntax? = nil
    public var diffParams: RawDifferentiabilityParamsClauseSyntax? = nil
    public var diffParamsComma: RawTokenSyntax? = nil
    public var whereClause: RawGenericWhereClauseSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawDifferentiableAttributeArgumentsSyntax {
      .make(arena: arena
      , diffKind: self.diffKind
      , diffKindComma: self.diffKindComma
      , diffParams: self.diffParams
      , diffParamsComma: self.diffParamsComma
      , whereClause: self.whereClause
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawDifferentiableAttributeArgumentsSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, diffKind: RawTokenSyntax? = nil, diffKindComma: RawTokenSyntax? = nil, diffParams: RawDifferentiabilityParamsClauseSyntax? = nil, diffParamsComma: RawTokenSyntax? = nil, whereClause: RawGenericWhereClauseSyntax? = nil) -> RawDifferentiableAttributeArgumentsSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .differentiableAttributeArguments,
                                   uninitializedCount: 5) { layout in
      layout.initialize(repeating: nil)
      layout[0] = diffKind?.raw
      layout[1] = diffKindComma?.raw
      layout[2] = diffParams?.raw
      layout[3] = diffParamsComma?.raw
      layout[4] = whereClause?.raw
    }
    return .init(raw: raw)
  }
}

extension RawDifferentiabilityParamsClauseSyntax {
  typealias Cursor = DifferentiabilityParamsClauseSyntax.Cursor
  public var wrtLabel: RawTokenSyntax {
    elem(at: Cursor.wrtLabel).map(RawTokenSyntax.init(raw:))!
  }
  public var colon: RawTokenSyntax {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))!
  }
  public var parameters: RawSyntax {
    elem(at: Cursor.parameters).map(RawSyntax.init(raw:))!
  }

  public struct Builder {
    public var wrtLabel: RawTokenSyntax? = nil
    public var colon: RawTokenSyntax? = nil
    public var parameters: RawSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawDifferentiabilityParamsClauseSyntax {
      .make(arena: arena
      , wrtLabel: self.wrtLabel
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , colon: self.colon
          ?? .makeBlank(arena: arena, tokenKind: .colon)
      , parameters: self.parameters
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawDifferentiabilityParamsClauseSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, wrtLabel: RawTokenSyntax, colon: RawTokenSyntax, parameters: RawSyntax) -> RawDifferentiabilityParamsClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .differentiabilityParamsClause,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = wrtLabel.raw
      layout[1] = colon.raw
      layout[2] = parameters.raw
    }
    return .init(raw: raw)
  }
}

extension RawDifferentiabilityParamsSyntax {
  typealias Cursor = DifferentiabilityParamsSyntax.Cursor
  public var leftParen: RawTokenSyntax {
    elem(at: Cursor.leftParen).map(RawTokenSyntax.init(raw:))!
  }
  public var diffParams: RawDifferentiabilityParamListSyntax {
    elem(at: Cursor.diffParams).map(RawDifferentiabilityParamListSyntax.init(raw:))!
  }
  public var rightParen: RawTokenSyntax {
    elem(at: Cursor.rightParen).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var leftParen: RawTokenSyntax? = nil
    public var diffParams: RawDifferentiabilityParamListSyntax? = nil
    public var rightParen: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawDifferentiabilityParamsSyntax {
      .make(arena: arena
      , leftParen: self.leftParen
          ?? .makeBlank(arena: arena, tokenKind: .leftParen)
      , diffParams: self.diffParams
          ?? .makeBlank(arena: arena)
      , rightParen: self.rightParen
          ?? .makeBlank(arena: arena, tokenKind: .rightParen)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawDifferentiabilityParamsSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, leftParen: RawTokenSyntax, diffParams: RawDifferentiabilityParamListSyntax, rightParen: RawTokenSyntax) -> RawDifferentiabilityParamsSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .differentiabilityParams,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = leftParen.raw
      layout[1] = diffParams.raw
      layout[2] = rightParen.raw
    }
    return .init(raw: raw)
  }
}

extension RawDifferentiabilityParamSyntax {
  typealias Cursor = DifferentiabilityParamSyntax.Cursor
  public var parameter: RawSyntax {
    elem(at: Cursor.parameter).map(RawSyntax.init(raw:))!
  }
  public var trailingComma: RawTokenSyntax? {
    elem(at: Cursor.trailingComma).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var parameter: RawSyntax? = nil
    public var trailingComma: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawDifferentiabilityParamSyntax {
      .make(arena: arena
      , parameter: self.parameter
          ?? .makeBlank(arena: arena)
      , trailingComma: self.trailingComma
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawDifferentiabilityParamSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, parameter: RawSyntax, trailingComma: RawTokenSyntax? = nil) -> RawDifferentiabilityParamSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .differentiabilityParam,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = parameter.raw
      layout[1] = trailingComma?.raw
    }
    return .init(raw: raw)
  }
}

extension RawDerivativeRegistrationAttributeArgumentsSyntax {
  typealias Cursor = DerivativeRegistrationAttributeArgumentsSyntax.Cursor
  public var ofLabel: RawTokenSyntax {
    elem(at: Cursor.ofLabel).map(RawTokenSyntax.init(raw:))!
  }
  public var colon: RawTokenSyntax {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))!
  }
  public var originalDeclName: RawQualifiedDeclNameSyntax {
    elem(at: Cursor.originalDeclName).map(RawQualifiedDeclNameSyntax.init(raw:))!
  }
  public var period: RawTokenSyntax? {
    elem(at: Cursor.period).map(RawTokenSyntax.init(raw:))
  }
  public var accessorKind: RawTokenSyntax? {
    elem(at: Cursor.accessorKind).map(RawTokenSyntax.init(raw:))
  }
  public var comma: RawTokenSyntax? {
    elem(at: Cursor.comma).map(RawTokenSyntax.init(raw:))
  }
  public var diffParams: RawDifferentiabilityParamsClauseSyntax? {
    elem(at: Cursor.diffParams).map(RawDifferentiabilityParamsClauseSyntax.init(raw:))
  }

  public struct Builder {
    public var ofLabel: RawTokenSyntax? = nil
    public var colon: RawTokenSyntax? = nil
    public var originalDeclName: RawQualifiedDeclNameSyntax? = nil
    public var period: RawTokenSyntax? = nil
    public var accessorKind: RawTokenSyntax? = nil
    public var comma: RawTokenSyntax? = nil
    public var diffParams: RawDifferentiabilityParamsClauseSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawDerivativeRegistrationAttributeArgumentsSyntax {
      .make(arena: arena
      , ofLabel: self.ofLabel
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , colon: self.colon
          ?? .makeBlank(arena: arena, tokenKind: .colon)
      , originalDeclName: self.originalDeclName
          ?? .makeBlank(arena: arena)
      , period: self.period
      , accessorKind: self.accessorKind
      , comma: self.comma
      , diffParams: self.diffParams
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawDerivativeRegistrationAttributeArgumentsSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, ofLabel: RawTokenSyntax, colon: RawTokenSyntax, originalDeclName: RawQualifiedDeclNameSyntax, period: RawTokenSyntax? = nil, accessorKind: RawTokenSyntax? = nil, comma: RawTokenSyntax? = nil, diffParams: RawDifferentiabilityParamsClauseSyntax? = nil) -> RawDerivativeRegistrationAttributeArgumentsSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .derivativeRegistrationAttributeArguments,
                                   uninitializedCount: 7) { layout in
      layout.initialize(repeating: nil)
      layout[0] = ofLabel.raw
      layout[1] = colon.raw
      layout[2] = originalDeclName.raw
      layout[3] = period?.raw
      layout[4] = accessorKind?.raw
      layout[5] = comma?.raw
      layout[6] = diffParams?.raw
    }
    return .init(raw: raw)
  }
}

extension RawQualifiedDeclNameSyntax {
  typealias Cursor = QualifiedDeclNameSyntax.Cursor
  public var baseType: RawTypeSyntax? {
    elem(at: Cursor.baseType).map(RawTypeSyntax.init(raw:))
  }
  public var dot: RawTokenSyntax? {
    elem(at: Cursor.dot).map(RawTokenSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    elem(at: Cursor.name).map(RawTokenSyntax.init(raw:))!
  }
  public var arguments: RawDeclNameArgumentsSyntax? {
    elem(at: Cursor.arguments).map(RawDeclNameArgumentsSyntax.init(raw:))
  }

  public struct Builder {
    public var baseType: RawTypeSyntax? = nil
    public var dot: RawTokenSyntax? = nil
    public var name: RawTokenSyntax? = nil
    public var arguments: RawDeclNameArgumentsSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawQualifiedDeclNameSyntax {
      .make(arena: arena
      , baseType: self.baseType
      , dot: self.dot
      , name: self.name
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , arguments: self.arguments
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawQualifiedDeclNameSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, baseType: RawTypeSyntax? = nil, dot: RawTokenSyntax? = nil, name: RawTokenSyntax, arguments: RawDeclNameArgumentsSyntax? = nil) -> RawQualifiedDeclNameSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .qualifiedDeclName,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = baseType?.raw
      layout[1] = dot?.raw
      layout[2] = name.raw
      layout[3] = arguments?.raw
    }
    return .init(raw: raw)
  }
}

extension RawFunctionDeclNameSyntax {
  typealias Cursor = FunctionDeclNameSyntax.Cursor
  public var name: RawSyntax {
    elem(at: Cursor.name).map(RawSyntax.init(raw:))!
  }
  public var arguments: RawDeclNameArgumentsSyntax? {
    elem(at: Cursor.arguments).map(RawDeclNameArgumentsSyntax.init(raw:))
  }

  public struct Builder {
    public var name: RawSyntax? = nil
    public var arguments: RawDeclNameArgumentsSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawFunctionDeclNameSyntax {
      .make(arena: arena
      , name: self.name
          ?? .makeBlank(arena: arena)
      , arguments: self.arguments
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawFunctionDeclNameSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, name: RawSyntax, arguments: RawDeclNameArgumentsSyntax? = nil) -> RawFunctionDeclNameSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .functionDeclName,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = name.raw
      layout[1] = arguments?.raw
    }
    return .init(raw: raw)
  }
}

extension RawBackDeployAttributeSpecListSyntax {
  typealias Cursor = BackDeployAttributeSpecListSyntax.Cursor
  public var beforeLabel: RawTokenSyntax {
    elem(at: Cursor.beforeLabel).map(RawTokenSyntax.init(raw:))!
  }
  public var colon: RawTokenSyntax {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))!
  }
  public var versionList: RawBackDeployVersionListSyntax {
    elem(at: Cursor.versionList).map(RawBackDeployVersionListSyntax.init(raw:))!
  }

  public struct Builder {
    public var beforeLabel: RawTokenSyntax? = nil
    public var colon: RawTokenSyntax? = nil
    public var versionList: RawBackDeployVersionListSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawBackDeployAttributeSpecListSyntax {
      .make(arena: arena
      , beforeLabel: self.beforeLabel
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , colon: self.colon
          ?? .makeBlank(arena: arena, tokenKind: .colon)
      , versionList: self.versionList
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawBackDeployAttributeSpecListSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, beforeLabel: RawTokenSyntax, colon: RawTokenSyntax, versionList: RawBackDeployVersionListSyntax) -> RawBackDeployAttributeSpecListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .backDeployAttributeSpecList,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = beforeLabel.raw
      layout[1] = colon.raw
      layout[2] = versionList.raw
    }
    return .init(raw: raw)
  }
}

extension RawBackDeployVersionArgumentSyntax {
  typealias Cursor = BackDeployVersionArgumentSyntax.Cursor
  public var availabilityVersionRestriction: RawAvailabilityVersionRestrictionSyntax {
    elem(at: Cursor.availabilityVersionRestriction).map(RawAvailabilityVersionRestrictionSyntax.init(raw:))!
  }
  public var trailingComma: RawTokenSyntax? {
    elem(at: Cursor.trailingComma).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var availabilityVersionRestriction: RawAvailabilityVersionRestrictionSyntax? = nil
    public var trailingComma: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawBackDeployVersionArgumentSyntax {
      .make(arena: arena
      , availabilityVersionRestriction: self.availabilityVersionRestriction
          ?? .makeBlank(arena: arena)
      , trailingComma: self.trailingComma
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawBackDeployVersionArgumentSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, availabilityVersionRestriction: RawAvailabilityVersionRestrictionSyntax, trailingComma: RawTokenSyntax? = nil) -> RawBackDeployVersionArgumentSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .backDeployVersionArgument,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = availabilityVersionRestriction.raw
      layout[1] = trailingComma?.raw
    }
    return .init(raw: raw)
  }
}

extension RawContinueStmtSyntax {
  typealias Cursor = ContinueStmtSyntax.Cursor
  public var continueKeyword: RawTokenSyntax {
    elem(at: Cursor.continueKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var label: RawTokenSyntax? {
    elem(at: Cursor.label).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var continueKeyword: RawTokenSyntax? = nil
    public var label: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawContinueStmtSyntax {
      .make(arena: arena
      , continueKeyword: self.continueKeyword
          ?? .makeBlank(arena: arena, tokenKind: .continueKeyword)
      , label: self.label
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawContinueStmtSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, continueKeyword: RawTokenSyntax, label: RawTokenSyntax? = nil) -> RawContinueStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .continueStmt,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = continueKeyword.raw
      layout[1] = label?.raw
    }
    return .init(raw: raw)
  }
}

extension RawWhileStmtSyntax {
  typealias Cursor = WhileStmtSyntax.Cursor
  public var labelName: RawTokenSyntax? {
    elem(at: Cursor.labelName).map(RawTokenSyntax.init(raw:))
  }
  public var labelColon: RawTokenSyntax? {
    elem(at: Cursor.labelColon).map(RawTokenSyntax.init(raw:))
  }
  public var whileKeyword: RawTokenSyntax {
    elem(at: Cursor.whileKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var conditions: RawConditionElementListSyntax {
    elem(at: Cursor.conditions).map(RawConditionElementListSyntax.init(raw:))!
  }
  public var body: RawCodeBlockSyntax {
    elem(at: Cursor.body).map(RawCodeBlockSyntax.init(raw:))!
  }

  public struct Builder {
    public var labelName: RawTokenSyntax? = nil
    public var labelColon: RawTokenSyntax? = nil
    public var whileKeyword: RawTokenSyntax? = nil
    public var conditions: RawConditionElementListSyntax? = nil
    public var body: RawCodeBlockSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawWhileStmtSyntax {
      .make(arena: arena
      , labelName: self.labelName
      , labelColon: self.labelColon
      , whileKeyword: self.whileKeyword
          ?? .makeBlank(arena: arena, tokenKind: .whileKeyword)
      , conditions: self.conditions
          ?? .makeBlank(arena: arena)
      , body: self.body
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawWhileStmtSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, labelName: RawTokenSyntax? = nil, labelColon: RawTokenSyntax? = nil, whileKeyword: RawTokenSyntax, conditions: RawConditionElementListSyntax, body: RawCodeBlockSyntax) -> RawWhileStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .whileStmt,
                                   uninitializedCount: 5) { layout in
      layout.initialize(repeating: nil)
      layout[0] = labelName?.raw
      layout[1] = labelColon?.raw
      layout[2] = whileKeyword.raw
      layout[3] = conditions.raw
      layout[4] = body.raw
    }
    return .init(raw: raw)
  }
}

extension RawDeferStmtSyntax {
  typealias Cursor = DeferStmtSyntax.Cursor
  public var deferKeyword: RawTokenSyntax {
    elem(at: Cursor.deferKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var body: RawCodeBlockSyntax {
    elem(at: Cursor.body).map(RawCodeBlockSyntax.init(raw:))!
  }

  public struct Builder {
    public var deferKeyword: RawTokenSyntax? = nil
    public var body: RawCodeBlockSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawDeferStmtSyntax {
      .make(arena: arena
      , deferKeyword: self.deferKeyword
          ?? .makeBlank(arena: arena, tokenKind: .deferKeyword)
      , body: self.body
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawDeferStmtSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, deferKeyword: RawTokenSyntax, body: RawCodeBlockSyntax) -> RawDeferStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .deferStmt,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = deferKeyword.raw
      layout[1] = body.raw
    }
    return .init(raw: raw)
  }
}

extension RawExpressionStmtSyntax {
  typealias Cursor = ExpressionStmtSyntax.Cursor
  public var expression: RawExprSyntax {
    elem(at: Cursor.expression).map(RawExprSyntax.init(raw:))!
  }

  public struct Builder {
    public var expression: RawExprSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawExpressionStmtSyntax {
      .make(arena: arena
      , expression: self.expression
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawExpressionStmtSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, expression: RawExprSyntax) -> RawExpressionStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .expressionStmt,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = expression.raw
    }
    return .init(raw: raw)
  }
}

extension RawRepeatWhileStmtSyntax {
  typealias Cursor = RepeatWhileStmtSyntax.Cursor
  public var labelName: RawTokenSyntax? {
    elem(at: Cursor.labelName).map(RawTokenSyntax.init(raw:))
  }
  public var labelColon: RawTokenSyntax? {
    elem(at: Cursor.labelColon).map(RawTokenSyntax.init(raw:))
  }
  public var repeatKeyword: RawTokenSyntax {
    elem(at: Cursor.repeatKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var body: RawCodeBlockSyntax {
    elem(at: Cursor.body).map(RawCodeBlockSyntax.init(raw:))!
  }
  public var whileKeyword: RawTokenSyntax {
    elem(at: Cursor.whileKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var condition: RawExprSyntax {
    elem(at: Cursor.condition).map(RawExprSyntax.init(raw:))!
  }

  public struct Builder {
    public var labelName: RawTokenSyntax? = nil
    public var labelColon: RawTokenSyntax? = nil
    public var repeatKeyword: RawTokenSyntax? = nil
    public var body: RawCodeBlockSyntax? = nil
    public var whileKeyword: RawTokenSyntax? = nil
    public var condition: RawExprSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawRepeatWhileStmtSyntax {
      .make(arena: arena
      , labelName: self.labelName
      , labelColon: self.labelColon
      , repeatKeyword: self.repeatKeyword
          ?? .makeBlank(arena: arena, tokenKind: .repeatKeyword)
      , body: self.body
          ?? .makeBlank(arena: arena)
      , whileKeyword: self.whileKeyword
          ?? .makeBlank(arena: arena, tokenKind: .whileKeyword)
      , condition: self.condition
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawRepeatWhileStmtSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, labelName: RawTokenSyntax? = nil, labelColon: RawTokenSyntax? = nil, repeatKeyword: RawTokenSyntax, body: RawCodeBlockSyntax, whileKeyword: RawTokenSyntax, condition: RawExprSyntax) -> RawRepeatWhileStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .repeatWhileStmt,
                                   uninitializedCount: 6) { layout in
      layout.initialize(repeating: nil)
      layout[0] = labelName?.raw
      layout[1] = labelColon?.raw
      layout[2] = repeatKeyword.raw
      layout[3] = body.raw
      layout[4] = whileKeyword.raw
      layout[5] = condition.raw
    }
    return .init(raw: raw)
  }
}

extension RawGuardStmtSyntax {
  typealias Cursor = GuardStmtSyntax.Cursor
  public var guardKeyword: RawTokenSyntax {
    elem(at: Cursor.guardKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var conditions: RawConditionElementListSyntax {
    elem(at: Cursor.conditions).map(RawConditionElementListSyntax.init(raw:))!
  }
  public var elseKeyword: RawTokenSyntax {
    elem(at: Cursor.elseKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var body: RawCodeBlockSyntax {
    elem(at: Cursor.body).map(RawCodeBlockSyntax.init(raw:))!
  }

  public struct Builder {
    public var guardKeyword: RawTokenSyntax? = nil
    public var conditions: RawConditionElementListSyntax? = nil
    public var elseKeyword: RawTokenSyntax? = nil
    public var body: RawCodeBlockSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawGuardStmtSyntax {
      .make(arena: arena
      , guardKeyword: self.guardKeyword
          ?? .makeBlank(arena: arena, tokenKind: .guardKeyword)
      , conditions: self.conditions
          ?? .makeBlank(arena: arena)
      , elseKeyword: self.elseKeyword
          ?? .makeBlank(arena: arena, tokenKind: .elseKeyword)
      , body: self.body
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawGuardStmtSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, guardKeyword: RawTokenSyntax, conditions: RawConditionElementListSyntax, elseKeyword: RawTokenSyntax, body: RawCodeBlockSyntax) -> RawGuardStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .guardStmt,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = guardKeyword.raw
      layout[1] = conditions.raw
      layout[2] = elseKeyword.raw
      layout[3] = body.raw
    }
    return .init(raw: raw)
  }
}

extension RawWhereClauseSyntax {
  typealias Cursor = WhereClauseSyntax.Cursor
  public var whereKeyword: RawTokenSyntax {
    elem(at: Cursor.whereKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var guardResult: RawExprSyntax {
    elem(at: Cursor.guardResult).map(RawExprSyntax.init(raw:))!
  }

  public struct Builder {
    public var whereKeyword: RawTokenSyntax? = nil
    public var guardResult: RawExprSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawWhereClauseSyntax {
      .make(arena: arena
      , whereKeyword: self.whereKeyword
          ?? .makeBlank(arena: arena, tokenKind: .whereKeyword)
      , guardResult: self.guardResult
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawWhereClauseSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, whereKeyword: RawTokenSyntax, guardResult: RawExprSyntax) -> RawWhereClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .whereClause,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = whereKeyword.raw
      layout[1] = guardResult.raw
    }
    return .init(raw: raw)
  }
}

extension RawForInStmtSyntax {
  typealias Cursor = ForInStmtSyntax.Cursor
  public var labelName: RawTokenSyntax? {
    elem(at: Cursor.labelName).map(RawTokenSyntax.init(raw:))
  }
  public var labelColon: RawTokenSyntax? {
    elem(at: Cursor.labelColon).map(RawTokenSyntax.init(raw:))
  }
  public var forKeyword: RawTokenSyntax {
    elem(at: Cursor.forKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var tryKeyword: RawTokenSyntax? {
    elem(at: Cursor.tryKeyword).map(RawTokenSyntax.init(raw:))
  }
  public var awaitKeyword: RawTokenSyntax? {
    elem(at: Cursor.awaitKeyword).map(RawTokenSyntax.init(raw:))
  }
  public var caseKeyword: RawTokenSyntax? {
    elem(at: Cursor.caseKeyword).map(RawTokenSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax {
    elem(at: Cursor.pattern).map(RawPatternSyntax.init(raw:))!
  }
  public var typeAnnotation: RawTypeAnnotationSyntax? {
    elem(at: Cursor.typeAnnotation).map(RawTypeAnnotationSyntax.init(raw:))
  }
  public var inKeyword: RawTokenSyntax {
    elem(at: Cursor.inKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var sequenceExpr: RawExprSyntax {
    elem(at: Cursor.sequenceExpr).map(RawExprSyntax.init(raw:))!
  }
  public var whereClause: RawWhereClauseSyntax? {
    elem(at: Cursor.whereClause).map(RawWhereClauseSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax {
    elem(at: Cursor.body).map(RawCodeBlockSyntax.init(raw:))!
  }

  public struct Builder {
    public var labelName: RawTokenSyntax? = nil
    public var labelColon: RawTokenSyntax? = nil
    public var forKeyword: RawTokenSyntax? = nil
    public var tryKeyword: RawTokenSyntax? = nil
    public var awaitKeyword: RawTokenSyntax? = nil
    public var caseKeyword: RawTokenSyntax? = nil
    public var pattern: RawPatternSyntax? = nil
    public var typeAnnotation: RawTypeAnnotationSyntax? = nil
    public var inKeyword: RawTokenSyntax? = nil
    public var sequenceExpr: RawExprSyntax? = nil
    public var whereClause: RawWhereClauseSyntax? = nil
    public var body: RawCodeBlockSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawForInStmtSyntax {
      .make(arena: arena
      , labelName: self.labelName
      , labelColon: self.labelColon
      , forKeyword: self.forKeyword
          ?? .makeBlank(arena: arena, tokenKind: .forKeyword)
      , tryKeyword: self.tryKeyword
      , awaitKeyword: self.awaitKeyword
      , caseKeyword: self.caseKeyword
      , pattern: self.pattern
          ?? .makeBlank(arena: arena)
      , typeAnnotation: self.typeAnnotation
      , inKeyword: self.inKeyword
          ?? .makeBlank(arena: arena, tokenKind: .inKeyword)
      , sequenceExpr: self.sequenceExpr
          ?? .makeBlank(arena: arena)
      , whereClause: self.whereClause
      , body: self.body
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawForInStmtSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, labelName: RawTokenSyntax? = nil, labelColon: RawTokenSyntax? = nil, forKeyword: RawTokenSyntax, tryKeyword: RawTokenSyntax? = nil, awaitKeyword: RawTokenSyntax? = nil, caseKeyword: RawTokenSyntax? = nil, pattern: RawPatternSyntax, typeAnnotation: RawTypeAnnotationSyntax? = nil, inKeyword: RawTokenSyntax, sequenceExpr: RawExprSyntax, whereClause: RawWhereClauseSyntax? = nil, body: RawCodeBlockSyntax) -> RawForInStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .forInStmt,
                                   uninitializedCount: 12) { layout in
      layout.initialize(repeating: nil)
      layout[0] = labelName?.raw
      layout[1] = labelColon?.raw
      layout[2] = forKeyword.raw
      layout[3] = tryKeyword?.raw
      layout[4] = awaitKeyword?.raw
      layout[5] = caseKeyword?.raw
      layout[6] = pattern.raw
      layout[7] = typeAnnotation?.raw
      layout[8] = inKeyword.raw
      layout[9] = sequenceExpr.raw
      layout[10] = whereClause?.raw
      layout[11] = body.raw
    }
    return .init(raw: raw)
  }
}

extension RawSwitchStmtSyntax {
  typealias Cursor = SwitchStmtSyntax.Cursor
  public var labelName: RawTokenSyntax? {
    elem(at: Cursor.labelName).map(RawTokenSyntax.init(raw:))
  }
  public var labelColon: RawTokenSyntax? {
    elem(at: Cursor.labelColon).map(RawTokenSyntax.init(raw:))
  }
  public var switchKeyword: RawTokenSyntax {
    elem(at: Cursor.switchKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var expression: RawExprSyntax {
    elem(at: Cursor.expression).map(RawExprSyntax.init(raw:))!
  }
  public var leftBrace: RawTokenSyntax {
    elem(at: Cursor.leftBrace).map(RawTokenSyntax.init(raw:))!
  }
  public var cases: RawSwitchCaseListSyntax {
    elem(at: Cursor.cases).map(RawSwitchCaseListSyntax.init(raw:))!
  }
  public var rightBrace: RawTokenSyntax {
    elem(at: Cursor.rightBrace).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var labelName: RawTokenSyntax? = nil
    public var labelColon: RawTokenSyntax? = nil
    public var switchKeyword: RawTokenSyntax? = nil
    public var expression: RawExprSyntax? = nil
    public var leftBrace: RawTokenSyntax? = nil
    public var cases: RawSwitchCaseListSyntax? = nil
    public var rightBrace: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawSwitchStmtSyntax {
      .make(arena: arena
      , labelName: self.labelName
      , labelColon: self.labelColon
      , switchKeyword: self.switchKeyword
          ?? .makeBlank(arena: arena, tokenKind: .switchKeyword)
      , expression: self.expression
          ?? .makeBlank(arena: arena)
      , leftBrace: self.leftBrace
          ?? .makeBlank(arena: arena, tokenKind: .leftBrace)
      , cases: self.cases
          ?? .makeBlank(arena: arena)
      , rightBrace: self.rightBrace
          ?? .makeBlank(arena: arena, tokenKind: .rightBrace)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawSwitchStmtSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, labelName: RawTokenSyntax? = nil, labelColon: RawTokenSyntax? = nil, switchKeyword: RawTokenSyntax, expression: RawExprSyntax, leftBrace: RawTokenSyntax, cases: RawSwitchCaseListSyntax, rightBrace: RawTokenSyntax) -> RawSwitchStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .switchStmt,
                                   uninitializedCount: 7) { layout in
      layout.initialize(repeating: nil)
      layout[0] = labelName?.raw
      layout[1] = labelColon?.raw
      layout[2] = switchKeyword.raw
      layout[3] = expression.raw
      layout[4] = leftBrace.raw
      layout[5] = cases.raw
      layout[6] = rightBrace.raw
    }
    return .init(raw: raw)
  }
}

extension RawDoStmtSyntax {
  typealias Cursor = DoStmtSyntax.Cursor
  public var labelName: RawTokenSyntax? {
    elem(at: Cursor.labelName).map(RawTokenSyntax.init(raw:))
  }
  public var labelColon: RawTokenSyntax? {
    elem(at: Cursor.labelColon).map(RawTokenSyntax.init(raw:))
  }
  public var doKeyword: RawTokenSyntax {
    elem(at: Cursor.doKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var body: RawCodeBlockSyntax {
    elem(at: Cursor.body).map(RawCodeBlockSyntax.init(raw:))!
  }
  public var catchClauses: RawCatchClauseListSyntax? {
    elem(at: Cursor.catchClauses).map(RawCatchClauseListSyntax.init(raw:))
  }

  public struct Builder {
    public var labelName: RawTokenSyntax? = nil
    public var labelColon: RawTokenSyntax? = nil
    public var doKeyword: RawTokenSyntax? = nil
    public var body: RawCodeBlockSyntax? = nil
    public var catchClauses: RawCatchClauseListSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawDoStmtSyntax {
      .make(arena: arena
      , labelName: self.labelName
      , labelColon: self.labelColon
      , doKeyword: self.doKeyword
          ?? .makeBlank(arena: arena, tokenKind: .doKeyword)
      , body: self.body
          ?? .makeBlank(arena: arena)
      , catchClauses: self.catchClauses
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawDoStmtSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, labelName: RawTokenSyntax? = nil, labelColon: RawTokenSyntax? = nil, doKeyword: RawTokenSyntax, body: RawCodeBlockSyntax, catchClauses: RawCatchClauseListSyntax? = nil) -> RawDoStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .doStmt,
                                   uninitializedCount: 5) { layout in
      layout.initialize(repeating: nil)
      layout[0] = labelName?.raw
      layout[1] = labelColon?.raw
      layout[2] = doKeyword.raw
      layout[3] = body.raw
      layout[4] = catchClauses?.raw
    }
    return .init(raw: raw)
  }
}

extension RawReturnStmtSyntax {
  typealias Cursor = ReturnStmtSyntax.Cursor
  public var returnKeyword: RawTokenSyntax {
    elem(at: Cursor.returnKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var expression: RawExprSyntax? {
    elem(at: Cursor.expression).map(RawExprSyntax.init(raw:))
  }

  public struct Builder {
    public var returnKeyword: RawTokenSyntax? = nil
    public var expression: RawExprSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawReturnStmtSyntax {
      .make(arena: arena
      , returnKeyword: self.returnKeyword
          ?? .makeBlank(arena: arena, tokenKind: .returnKeyword)
      , expression: self.expression
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawReturnStmtSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, returnKeyword: RawTokenSyntax, expression: RawExprSyntax? = nil) -> RawReturnStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .returnStmt,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = returnKeyword.raw
      layout[1] = expression?.raw
    }
    return .init(raw: raw)
  }
}

extension RawYieldStmtSyntax {
  typealias Cursor = YieldStmtSyntax.Cursor
  public var yieldKeyword: RawTokenSyntax {
    elem(at: Cursor.yieldKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var yields: RawSyntax {
    elem(at: Cursor.yields).map(RawSyntax.init(raw:))!
  }

  public struct Builder {
    public var yieldKeyword: RawTokenSyntax? = nil
    public var yields: RawSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawYieldStmtSyntax {
      .make(arena: arena
      , yieldKeyword: self.yieldKeyword
          ?? .makeBlank(arena: arena, tokenKind: .yield)
      , yields: self.yields
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawYieldStmtSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, yieldKeyword: RawTokenSyntax, yields: RawSyntax) -> RawYieldStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .yieldStmt,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = yieldKeyword.raw
      layout[1] = yields.raw
    }
    return .init(raw: raw)
  }
}

extension RawYieldListSyntax {
  typealias Cursor = YieldListSyntax.Cursor
  public var leftParen: RawTokenSyntax {
    elem(at: Cursor.leftParen).map(RawTokenSyntax.init(raw:))!
  }
  public var elementList: RawExprListSyntax {
    elem(at: Cursor.elementList).map(RawExprListSyntax.init(raw:))!
  }
  public var trailingComma: RawTokenSyntax? {
    elem(at: Cursor.trailingComma).map(RawTokenSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    elem(at: Cursor.rightParen).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var leftParen: RawTokenSyntax? = nil
    public var elementList: RawExprListSyntax? = nil
    public var trailingComma: RawTokenSyntax? = nil
    public var rightParen: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawYieldListSyntax {
      .make(arena: arena
      , leftParen: self.leftParen
          ?? .makeBlank(arena: arena, tokenKind: .leftParen)
      , elementList: self.elementList
          ?? .makeBlank(arena: arena)
      , trailingComma: self.trailingComma
      , rightParen: self.rightParen
          ?? .makeBlank(arena: arena, tokenKind: .rightParen)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawYieldListSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, leftParen: RawTokenSyntax, elementList: RawExprListSyntax, trailingComma: RawTokenSyntax? = nil, rightParen: RawTokenSyntax) -> RawYieldListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .yieldList,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = leftParen.raw
      layout[1] = elementList.raw
      layout[2] = trailingComma?.raw
      layout[3] = rightParen.raw
    }
    return .init(raw: raw)
  }
}

extension RawFallthroughStmtSyntax {
  typealias Cursor = FallthroughStmtSyntax.Cursor
  public var fallthroughKeyword: RawTokenSyntax {
    elem(at: Cursor.fallthroughKeyword).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var fallthroughKeyword: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawFallthroughStmtSyntax {
      .make(arena: arena
      , fallthroughKeyword: self.fallthroughKeyword
          ?? .makeBlank(arena: arena, tokenKind: .fallthroughKeyword)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawFallthroughStmtSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, fallthroughKeyword: RawTokenSyntax) -> RawFallthroughStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .fallthroughStmt,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = fallthroughKeyword.raw
    }
    return .init(raw: raw)
  }
}

extension RawBreakStmtSyntax {
  typealias Cursor = BreakStmtSyntax.Cursor
  public var breakKeyword: RawTokenSyntax {
    elem(at: Cursor.breakKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var label: RawTokenSyntax? {
    elem(at: Cursor.label).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var breakKeyword: RawTokenSyntax? = nil
    public var label: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawBreakStmtSyntax {
      .make(arena: arena
      , breakKeyword: self.breakKeyword
          ?? .makeBlank(arena: arena, tokenKind: .breakKeyword)
      , label: self.label
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawBreakStmtSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, breakKeyword: RawTokenSyntax, label: RawTokenSyntax? = nil) -> RawBreakStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .breakStmt,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = breakKeyword.raw
      layout[1] = label?.raw
    }
    return .init(raw: raw)
  }
}

extension RawConditionElementSyntax {
  typealias Cursor = ConditionElementSyntax.Cursor
  public var condition: RawSyntax {
    elem(at: Cursor.condition).map(RawSyntax.init(raw:))!
  }
  public var trailingComma: RawTokenSyntax? {
    elem(at: Cursor.trailingComma).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var condition: RawSyntax? = nil
    public var trailingComma: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawConditionElementSyntax {
      .make(arena: arena
      , condition: self.condition
          ?? .makeBlank(arena: arena)
      , trailingComma: self.trailingComma
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawConditionElementSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, condition: RawSyntax, trailingComma: RawTokenSyntax? = nil) -> RawConditionElementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .conditionElement,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = condition.raw
      layout[1] = trailingComma?.raw
    }
    return .init(raw: raw)
  }
}

extension RawAvailabilityConditionSyntax {
  typealias Cursor = AvailabilityConditionSyntax.Cursor
  public var poundAvailableKeyword: RawTokenSyntax {
    elem(at: Cursor.poundAvailableKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var leftParen: RawTokenSyntax {
    elem(at: Cursor.leftParen).map(RawTokenSyntax.init(raw:))!
  }
  public var availabilitySpec: RawAvailabilitySpecListSyntax {
    elem(at: Cursor.availabilitySpec).map(RawAvailabilitySpecListSyntax.init(raw:))!
  }
  public var rightParen: RawTokenSyntax {
    elem(at: Cursor.rightParen).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var poundAvailableKeyword: RawTokenSyntax? = nil
    public var leftParen: RawTokenSyntax? = nil
    public var availabilitySpec: RawAvailabilitySpecListSyntax? = nil
    public var rightParen: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawAvailabilityConditionSyntax {
      .make(arena: arena
      , poundAvailableKeyword: self.poundAvailableKeyword
          ?? .makeBlank(arena: arena, tokenKind: .poundAvailableKeyword)
      , leftParen: self.leftParen
          ?? .makeBlank(arena: arena, tokenKind: .leftParen)
      , availabilitySpec: self.availabilitySpec
          ?? .makeBlank(arena: arena)
      , rightParen: self.rightParen
          ?? .makeBlank(arena: arena, tokenKind: .rightParen)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawAvailabilityConditionSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, poundAvailableKeyword: RawTokenSyntax, leftParen: RawTokenSyntax, availabilitySpec: RawAvailabilitySpecListSyntax, rightParen: RawTokenSyntax) -> RawAvailabilityConditionSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .availabilityCondition,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = poundAvailableKeyword.raw
      layout[1] = leftParen.raw
      layout[2] = availabilitySpec.raw
      layout[3] = rightParen.raw
    }
    return .init(raw: raw)
  }
}

extension RawMatchingPatternConditionSyntax {
  typealias Cursor = MatchingPatternConditionSyntax.Cursor
  public var caseKeyword: RawTokenSyntax {
    elem(at: Cursor.caseKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var pattern: RawPatternSyntax {
    elem(at: Cursor.pattern).map(RawPatternSyntax.init(raw:))!
  }
  public var typeAnnotation: RawTypeAnnotationSyntax? {
    elem(at: Cursor.typeAnnotation).map(RawTypeAnnotationSyntax.init(raw:))
  }
  public var initializer: RawInitializerClauseSyntax {
    elem(at: Cursor.initializer).map(RawInitializerClauseSyntax.init(raw:))!
  }

  public struct Builder {
    public var caseKeyword: RawTokenSyntax? = nil
    public var pattern: RawPatternSyntax? = nil
    public var typeAnnotation: RawTypeAnnotationSyntax? = nil
    public var initializer: RawInitializerClauseSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawMatchingPatternConditionSyntax {
      .make(arena: arena
      , caseKeyword: self.caseKeyword
          ?? .makeBlank(arena: arena, tokenKind: .caseKeyword)
      , pattern: self.pattern
          ?? .makeBlank(arena: arena)
      , typeAnnotation: self.typeAnnotation
      , initializer: self.initializer
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawMatchingPatternConditionSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, caseKeyword: RawTokenSyntax, pattern: RawPatternSyntax, typeAnnotation: RawTypeAnnotationSyntax? = nil, initializer: RawInitializerClauseSyntax) -> RawMatchingPatternConditionSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .matchingPatternCondition,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = caseKeyword.raw
      layout[1] = pattern.raw
      layout[2] = typeAnnotation?.raw
      layout[3] = initializer.raw
    }
    return .init(raw: raw)
  }
}

extension RawOptionalBindingConditionSyntax {
  typealias Cursor = OptionalBindingConditionSyntax.Cursor
  public var letOrVarKeyword: RawTokenSyntax {
    elem(at: Cursor.letOrVarKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var pattern: RawPatternSyntax {
    elem(at: Cursor.pattern).map(RawPatternSyntax.init(raw:))!
  }
  public var typeAnnotation: RawTypeAnnotationSyntax? {
    elem(at: Cursor.typeAnnotation).map(RawTypeAnnotationSyntax.init(raw:))
  }
  public var initializer: RawInitializerClauseSyntax? {
    elem(at: Cursor.initializer).map(RawInitializerClauseSyntax.init(raw:))
  }

  public struct Builder {
    public var letOrVarKeyword: RawTokenSyntax? = nil
    public var pattern: RawPatternSyntax? = nil
    public var typeAnnotation: RawTypeAnnotationSyntax? = nil
    public var initializer: RawInitializerClauseSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawOptionalBindingConditionSyntax {
      .make(arena: arena
      , letOrVarKeyword: self.letOrVarKeyword
          ?? .makeBlank(arena: arena, tokenKind: .letKeyword)
      , pattern: self.pattern
          ?? .makeBlank(arena: arena)
      , typeAnnotation: self.typeAnnotation
      , initializer: self.initializer
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawOptionalBindingConditionSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, letOrVarKeyword: RawTokenSyntax, pattern: RawPatternSyntax, typeAnnotation: RawTypeAnnotationSyntax? = nil, initializer: RawInitializerClauseSyntax? = nil) -> RawOptionalBindingConditionSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .optionalBindingCondition,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = letOrVarKeyword.raw
      layout[1] = pattern.raw
      layout[2] = typeAnnotation?.raw
      layout[3] = initializer?.raw
    }
    return .init(raw: raw)
  }
}

extension RawUnavailabilityConditionSyntax {
  typealias Cursor = UnavailabilityConditionSyntax.Cursor
  public var poundUnavailableKeyword: RawTokenSyntax {
    elem(at: Cursor.poundUnavailableKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var leftParen: RawTokenSyntax {
    elem(at: Cursor.leftParen).map(RawTokenSyntax.init(raw:))!
  }
  public var availabilitySpec: RawAvailabilitySpecListSyntax {
    elem(at: Cursor.availabilitySpec).map(RawAvailabilitySpecListSyntax.init(raw:))!
  }
  public var rightParen: RawTokenSyntax {
    elem(at: Cursor.rightParen).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var poundUnavailableKeyword: RawTokenSyntax? = nil
    public var leftParen: RawTokenSyntax? = nil
    public var availabilitySpec: RawAvailabilitySpecListSyntax? = nil
    public var rightParen: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawUnavailabilityConditionSyntax {
      .make(arena: arena
      , poundUnavailableKeyword: self.poundUnavailableKeyword
          ?? .makeBlank(arena: arena, tokenKind: .poundUnavailableKeyword)
      , leftParen: self.leftParen
          ?? .makeBlank(arena: arena, tokenKind: .leftParen)
      , availabilitySpec: self.availabilitySpec
          ?? .makeBlank(arena: arena)
      , rightParen: self.rightParen
          ?? .makeBlank(arena: arena, tokenKind: .rightParen)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawUnavailabilityConditionSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, poundUnavailableKeyword: RawTokenSyntax, leftParen: RawTokenSyntax, availabilitySpec: RawAvailabilitySpecListSyntax, rightParen: RawTokenSyntax) -> RawUnavailabilityConditionSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .unavailabilityCondition,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = poundUnavailableKeyword.raw
      layout[1] = leftParen.raw
      layout[2] = availabilitySpec.raw
      layout[3] = rightParen.raw
    }
    return .init(raw: raw)
  }
}

extension RawDeclarationStmtSyntax {
  typealias Cursor = DeclarationStmtSyntax.Cursor
  public var declaration: RawDeclSyntax {
    elem(at: Cursor.declaration).map(RawDeclSyntax.init(raw:))!
  }

  public struct Builder {
    public var declaration: RawDeclSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawDeclarationStmtSyntax {
      .make(arena: arena
      , declaration: self.declaration
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawDeclarationStmtSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, declaration: RawDeclSyntax) -> RawDeclarationStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .declarationStmt,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = declaration.raw
    }
    return .init(raw: raw)
  }
}

extension RawThrowStmtSyntax {
  typealias Cursor = ThrowStmtSyntax.Cursor
  public var throwKeyword: RawTokenSyntax {
    elem(at: Cursor.throwKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var expression: RawExprSyntax {
    elem(at: Cursor.expression).map(RawExprSyntax.init(raw:))!
  }

  public struct Builder {
    public var throwKeyword: RawTokenSyntax? = nil
    public var expression: RawExprSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawThrowStmtSyntax {
      .make(arena: arena
      , throwKeyword: self.throwKeyword
          ?? .makeBlank(arena: arena, tokenKind: .throwKeyword)
      , expression: self.expression
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawThrowStmtSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, throwKeyword: RawTokenSyntax, expression: RawExprSyntax) -> RawThrowStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .throwStmt,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = throwKeyword.raw
      layout[1] = expression.raw
    }
    return .init(raw: raw)
  }
}

extension RawIfStmtSyntax {
  typealias Cursor = IfStmtSyntax.Cursor
  public var labelName: RawTokenSyntax? {
    elem(at: Cursor.labelName).map(RawTokenSyntax.init(raw:))
  }
  public var labelColon: RawTokenSyntax? {
    elem(at: Cursor.labelColon).map(RawTokenSyntax.init(raw:))
  }
  public var ifKeyword: RawTokenSyntax {
    elem(at: Cursor.ifKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var conditions: RawConditionElementListSyntax {
    elem(at: Cursor.conditions).map(RawConditionElementListSyntax.init(raw:))!
  }
  public var body: RawCodeBlockSyntax {
    elem(at: Cursor.body).map(RawCodeBlockSyntax.init(raw:))!
  }
  public var elseKeyword: RawTokenSyntax? {
    elem(at: Cursor.elseKeyword).map(RawTokenSyntax.init(raw:))
  }
  public var elseBody: RawSyntax? {
    elem(at: Cursor.elseBody).map(RawSyntax.init(raw:))
  }

  public struct Builder {
    public var labelName: RawTokenSyntax? = nil
    public var labelColon: RawTokenSyntax? = nil
    public var ifKeyword: RawTokenSyntax? = nil
    public var conditions: RawConditionElementListSyntax? = nil
    public var body: RawCodeBlockSyntax? = nil
    public var elseKeyword: RawTokenSyntax? = nil
    public var elseBody: RawSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawIfStmtSyntax {
      .make(arena: arena
      , labelName: self.labelName
      , labelColon: self.labelColon
      , ifKeyword: self.ifKeyword
          ?? .makeBlank(arena: arena, tokenKind: .ifKeyword)
      , conditions: self.conditions
          ?? .makeBlank(arena: arena)
      , body: self.body
          ?? .makeBlank(arena: arena)
      , elseKeyword: self.elseKeyword
      , elseBody: self.elseBody
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawIfStmtSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, labelName: RawTokenSyntax? = nil, labelColon: RawTokenSyntax? = nil, ifKeyword: RawTokenSyntax, conditions: RawConditionElementListSyntax, body: RawCodeBlockSyntax, elseKeyword: RawTokenSyntax? = nil, elseBody: RawSyntax? = nil) -> RawIfStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .ifStmt,
                                   uninitializedCount: 7) { layout in
      layout.initialize(repeating: nil)
      layout[0] = labelName?.raw
      layout[1] = labelColon?.raw
      layout[2] = ifKeyword.raw
      layout[3] = conditions.raw
      layout[4] = body.raw
      layout[5] = elseKeyword?.raw
      layout[6] = elseBody?.raw
    }
    return .init(raw: raw)
  }
}

extension RawElseIfContinuationSyntax {
  typealias Cursor = ElseIfContinuationSyntax.Cursor
  public var ifStatement: RawIfStmtSyntax {
    elem(at: Cursor.ifStatement).map(RawIfStmtSyntax.init(raw:))!
  }

  public struct Builder {
    public var ifStatement: RawIfStmtSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawElseIfContinuationSyntax {
      .make(arena: arena
      , ifStatement: self.ifStatement
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawElseIfContinuationSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, ifStatement: RawIfStmtSyntax) -> RawElseIfContinuationSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .elseIfContinuation,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = ifStatement.raw
    }
    return .init(raw: raw)
  }
}

extension RawElseBlockSyntax {
  typealias Cursor = ElseBlockSyntax.Cursor
  public var elseKeyword: RawTokenSyntax {
    elem(at: Cursor.elseKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var body: RawCodeBlockSyntax {
    elem(at: Cursor.body).map(RawCodeBlockSyntax.init(raw:))!
  }

  public struct Builder {
    public var elseKeyword: RawTokenSyntax? = nil
    public var body: RawCodeBlockSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawElseBlockSyntax {
      .make(arena: arena
      , elseKeyword: self.elseKeyword
          ?? .makeBlank(arena: arena, tokenKind: .elseKeyword)
      , body: self.body
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawElseBlockSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, elseKeyword: RawTokenSyntax, body: RawCodeBlockSyntax) -> RawElseBlockSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .elseBlock,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = elseKeyword.raw
      layout[1] = body.raw
    }
    return .init(raw: raw)
  }
}

extension RawSwitchCaseSyntax {
  typealias Cursor = SwitchCaseSyntax.Cursor
  public var unknownAttr: RawAttributeSyntax? {
    elem(at: Cursor.unknownAttr).map(RawAttributeSyntax.init(raw:))
  }
  public var label: RawSyntax {
    elem(at: Cursor.label).map(RawSyntax.init(raw:))!
  }
  public var statements: RawCodeBlockItemListSyntax {
    elem(at: Cursor.statements).map(RawCodeBlockItemListSyntax.init(raw:))!
  }

  public struct Builder {
    public var unknownAttr: RawAttributeSyntax? = nil
    public var label: RawSyntax? = nil
    public var statements: RawCodeBlockItemListSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawSwitchCaseSyntax {
      .make(arena: arena
      , unknownAttr: self.unknownAttr
      , label: self.label
          ?? .makeBlank(arena: arena)
      , statements: self.statements
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawSwitchCaseSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, unknownAttr: RawAttributeSyntax? = nil, label: RawSyntax, statements: RawCodeBlockItemListSyntax) -> RawSwitchCaseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .switchCase,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = unknownAttr?.raw
      layout[1] = label.raw
      layout[2] = statements.raw
    }
    return .init(raw: raw)
  }
}

extension RawSwitchDefaultLabelSyntax {
  typealias Cursor = SwitchDefaultLabelSyntax.Cursor
  public var defaultKeyword: RawTokenSyntax {
    elem(at: Cursor.defaultKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var colon: RawTokenSyntax {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var defaultKeyword: RawTokenSyntax? = nil
    public var colon: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawSwitchDefaultLabelSyntax {
      .make(arena: arena
      , defaultKeyword: self.defaultKeyword
          ?? .makeBlank(arena: arena, tokenKind: .defaultKeyword)
      , colon: self.colon
          ?? .makeBlank(arena: arena, tokenKind: .colon)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawSwitchDefaultLabelSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, defaultKeyword: RawTokenSyntax, colon: RawTokenSyntax) -> RawSwitchDefaultLabelSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .switchDefaultLabel,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = defaultKeyword.raw
      layout[1] = colon.raw
    }
    return .init(raw: raw)
  }
}

extension RawCaseItemSyntax {
  typealias Cursor = CaseItemSyntax.Cursor
  public var pattern: RawPatternSyntax {
    elem(at: Cursor.pattern).map(RawPatternSyntax.init(raw:))!
  }
  public var whereClause: RawWhereClauseSyntax? {
    elem(at: Cursor.whereClause).map(RawWhereClauseSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    elem(at: Cursor.trailingComma).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var pattern: RawPatternSyntax? = nil
    public var whereClause: RawWhereClauseSyntax? = nil
    public var trailingComma: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawCaseItemSyntax {
      .make(arena: arena
      , pattern: self.pattern
          ?? .makeBlank(arena: arena)
      , whereClause: self.whereClause
      , trailingComma: self.trailingComma
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawCaseItemSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, pattern: RawPatternSyntax, whereClause: RawWhereClauseSyntax? = nil, trailingComma: RawTokenSyntax? = nil) -> RawCaseItemSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .caseItem,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = pattern.raw
      layout[1] = whereClause?.raw
      layout[2] = trailingComma?.raw
    }
    return .init(raw: raw)
  }
}

extension RawCatchItemSyntax {
  typealias Cursor = CatchItemSyntax.Cursor
  public var pattern: RawPatternSyntax? {
    elem(at: Cursor.pattern).map(RawPatternSyntax.init(raw:))
  }
  public var whereClause: RawWhereClauseSyntax? {
    elem(at: Cursor.whereClause).map(RawWhereClauseSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    elem(at: Cursor.trailingComma).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var pattern: RawPatternSyntax? = nil
    public var whereClause: RawWhereClauseSyntax? = nil
    public var trailingComma: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawCatchItemSyntax {
      .make(arena: arena
      , pattern: self.pattern
      , whereClause: self.whereClause
      , trailingComma: self.trailingComma
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawCatchItemSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, pattern: RawPatternSyntax? = nil, whereClause: RawWhereClauseSyntax? = nil, trailingComma: RawTokenSyntax? = nil) -> RawCatchItemSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .catchItem,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = pattern?.raw
      layout[1] = whereClause?.raw
      layout[2] = trailingComma?.raw
    }
    return .init(raw: raw)
  }
}

extension RawSwitchCaseLabelSyntax {
  typealias Cursor = SwitchCaseLabelSyntax.Cursor
  public var caseKeyword: RawTokenSyntax {
    elem(at: Cursor.caseKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var caseItems: RawCaseItemListSyntax {
    elem(at: Cursor.caseItems).map(RawCaseItemListSyntax.init(raw:))!
  }
  public var colon: RawTokenSyntax {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var caseKeyword: RawTokenSyntax? = nil
    public var caseItems: RawCaseItemListSyntax? = nil
    public var colon: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawSwitchCaseLabelSyntax {
      .make(arena: arena
      , caseKeyword: self.caseKeyword
          ?? .makeBlank(arena: arena, tokenKind: .caseKeyword)
      , caseItems: self.caseItems
          ?? .makeBlank(arena: arena)
      , colon: self.colon
          ?? .makeBlank(arena: arena, tokenKind: .colon)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawSwitchCaseLabelSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, caseKeyword: RawTokenSyntax, caseItems: RawCaseItemListSyntax, colon: RawTokenSyntax) -> RawSwitchCaseLabelSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .switchCaseLabel,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = caseKeyword.raw
      layout[1] = caseItems.raw
      layout[2] = colon.raw
    }
    return .init(raw: raw)
  }
}

extension RawCatchClauseSyntax {
  typealias Cursor = CatchClauseSyntax.Cursor
  public var catchKeyword: RawTokenSyntax {
    elem(at: Cursor.catchKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var catchItems: RawCatchItemListSyntax? {
    elem(at: Cursor.catchItems).map(RawCatchItemListSyntax.init(raw:))
  }
  public var body: RawCodeBlockSyntax {
    elem(at: Cursor.body).map(RawCodeBlockSyntax.init(raw:))!
  }

  public struct Builder {
    public var catchKeyword: RawTokenSyntax? = nil
    public var catchItems: RawCatchItemListSyntax? = nil
    public var body: RawCodeBlockSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawCatchClauseSyntax {
      .make(arena: arena
      , catchKeyword: self.catchKeyword
          ?? .makeBlank(arena: arena, tokenKind: .catchKeyword)
      , catchItems: self.catchItems
      , body: self.body
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawCatchClauseSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, catchKeyword: RawTokenSyntax, catchItems: RawCatchItemListSyntax? = nil, body: RawCodeBlockSyntax) -> RawCatchClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .catchClause,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = catchKeyword.raw
      layout[1] = catchItems?.raw
      layout[2] = body.raw
    }
    return .init(raw: raw)
  }
}

extension RawPoundAssertStmtSyntax {
  typealias Cursor = PoundAssertStmtSyntax.Cursor
  public var poundAssert: RawTokenSyntax {
    elem(at: Cursor.poundAssert).map(RawTokenSyntax.init(raw:))!
  }
  public var leftParen: RawTokenSyntax {
    elem(at: Cursor.leftParen).map(RawTokenSyntax.init(raw:))!
  }
  public var condition: RawExprSyntax {
    elem(at: Cursor.condition).map(RawExprSyntax.init(raw:))!
  }
  public var comma: RawTokenSyntax? {
    elem(at: Cursor.comma).map(RawTokenSyntax.init(raw:))
  }
  public var message: RawTokenSyntax? {
    elem(at: Cursor.message).map(RawTokenSyntax.init(raw:))
  }
  public var rightParen: RawTokenSyntax {
    elem(at: Cursor.rightParen).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var poundAssert: RawTokenSyntax? = nil
    public var leftParen: RawTokenSyntax? = nil
    public var condition: RawExprSyntax? = nil
    public var comma: RawTokenSyntax? = nil
    public var message: RawTokenSyntax? = nil
    public var rightParen: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawPoundAssertStmtSyntax {
      .make(arena: arena
      , poundAssert: self.poundAssert
          ?? .makeBlank(arena: arena, tokenKind: .poundAssertKeyword)
      , leftParen: self.leftParen
          ?? .makeBlank(arena: arena, tokenKind: .leftParen)
      , condition: self.condition
          ?? .makeBlank(arena: arena)
      , comma: self.comma
      , message: self.message
      , rightParen: self.rightParen
          ?? .makeBlank(arena: arena, tokenKind: .rightParen)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawPoundAssertStmtSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, poundAssert: RawTokenSyntax, leftParen: RawTokenSyntax, condition: RawExprSyntax, comma: RawTokenSyntax? = nil, message: RawTokenSyntax? = nil, rightParen: RawTokenSyntax) -> RawPoundAssertStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundAssertStmt,
                                   uninitializedCount: 6) { layout in
      layout.initialize(repeating: nil)
      layout[0] = poundAssert.raw
      layout[1] = leftParen.raw
      layout[2] = condition.raw
      layout[3] = comma?.raw
      layout[4] = message?.raw
      layout[5] = rightParen.raw
    }
    return .init(raw: raw)
  }
}

extension RawGenericWhereClauseSyntax {
  typealias Cursor = GenericWhereClauseSyntax.Cursor
  public var whereKeyword: RawTokenSyntax {
    elem(at: Cursor.whereKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var requirementList: RawGenericRequirementListSyntax {
    elem(at: Cursor.requirementList).map(RawGenericRequirementListSyntax.init(raw:))!
  }

  public struct Builder {
    public var whereKeyword: RawTokenSyntax? = nil
    public var requirementList: RawGenericRequirementListSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawGenericWhereClauseSyntax {
      .make(arena: arena
      , whereKeyword: self.whereKeyword
          ?? .makeBlank(arena: arena, tokenKind: .whereKeyword)
      , requirementList: self.requirementList
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawGenericWhereClauseSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, whereKeyword: RawTokenSyntax, requirementList: RawGenericRequirementListSyntax) -> RawGenericWhereClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .genericWhereClause,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = whereKeyword.raw
      layout[1] = requirementList.raw
    }
    return .init(raw: raw)
  }
}

extension RawGenericRequirementSyntax {
  typealias Cursor = GenericRequirementSyntax.Cursor
  public var body: RawSyntax {
    elem(at: Cursor.body).map(RawSyntax.init(raw:))!
  }
  public var trailingComma: RawTokenSyntax? {
    elem(at: Cursor.trailingComma).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var body: RawSyntax? = nil
    public var trailingComma: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawGenericRequirementSyntax {
      .make(arena: arena
      , body: self.body
          ?? .makeBlank(arena: arena)
      , trailingComma: self.trailingComma
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawGenericRequirementSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, body: RawSyntax, trailingComma: RawTokenSyntax? = nil) -> RawGenericRequirementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .genericRequirement,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = body.raw
      layout[1] = trailingComma?.raw
    }
    return .init(raw: raw)
  }
}

extension RawSameTypeRequirementSyntax {
  typealias Cursor = SameTypeRequirementSyntax.Cursor
  public var leftTypeIdentifier: RawTypeSyntax {
    elem(at: Cursor.leftTypeIdentifier).map(RawTypeSyntax.init(raw:))!
  }
  public var equalityToken: RawTokenSyntax {
    elem(at: Cursor.equalityToken).map(RawTokenSyntax.init(raw:))!
  }
  public var rightTypeIdentifier: RawTypeSyntax {
    elem(at: Cursor.rightTypeIdentifier).map(RawTypeSyntax.init(raw:))!
  }

  public struct Builder {
    public var leftTypeIdentifier: RawTypeSyntax? = nil
    public var equalityToken: RawTokenSyntax? = nil
    public var rightTypeIdentifier: RawTypeSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawSameTypeRequirementSyntax {
      .make(arena: arena
      , leftTypeIdentifier: self.leftTypeIdentifier
          ?? .makeBlank(arena: arena)
      , equalityToken: self.equalityToken
          ?? .makeBlank(arena: arena, tokenKind: .spacedBinaryOperator)
      , rightTypeIdentifier: self.rightTypeIdentifier
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawSameTypeRequirementSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, leftTypeIdentifier: RawTypeSyntax, equalityToken: RawTokenSyntax, rightTypeIdentifier: RawTypeSyntax) -> RawSameTypeRequirementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .sameTypeRequirement,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = leftTypeIdentifier.raw
      layout[1] = equalityToken.raw
      layout[2] = rightTypeIdentifier.raw
    }
    return .init(raw: raw)
  }
}

extension RawGenericParameterSyntax {
  typealias Cursor = GenericParameterSyntax.Cursor
  public var attributes: RawAttributeListSyntax? {
    elem(at: Cursor.attributes).map(RawAttributeListSyntax.init(raw:))
  }
  public var name: RawTokenSyntax {
    elem(at: Cursor.name).map(RawTokenSyntax.init(raw:))!
  }
  public var colon: RawTokenSyntax? {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))
  }
  public var inheritedType: RawTypeSyntax? {
    elem(at: Cursor.inheritedType).map(RawTypeSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    elem(at: Cursor.trailingComma).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var attributes: RawAttributeListSyntax? = nil
    public var name: RawTokenSyntax? = nil
    public var colon: RawTokenSyntax? = nil
    public var inheritedType: RawTypeSyntax? = nil
    public var trailingComma: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawGenericParameterSyntax {
      .make(arena: arena
      , attributes: self.attributes
      , name: self.name
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , colon: self.colon
      , inheritedType: self.inheritedType
      , trailingComma: self.trailingComma
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawGenericParameterSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, attributes: RawAttributeListSyntax? = nil, name: RawTokenSyntax, colon: RawTokenSyntax? = nil, inheritedType: RawTypeSyntax? = nil, trailingComma: RawTokenSyntax? = nil) -> RawGenericParameterSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .genericParameter,
                                   uninitializedCount: 5) { layout in
      layout.initialize(repeating: nil)
      layout[0] = attributes?.raw
      layout[1] = name.raw
      layout[2] = colon?.raw
      layout[3] = inheritedType?.raw
      layout[4] = trailingComma?.raw
    }
    return .init(raw: raw)
  }
}

extension RawPrimaryAssociatedTypeSyntax {
  typealias Cursor = PrimaryAssociatedTypeSyntax.Cursor
  public var name: RawTokenSyntax {
    elem(at: Cursor.name).map(RawTokenSyntax.init(raw:))!
  }
  public var trailingComma: RawTokenSyntax? {
    elem(at: Cursor.trailingComma).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var name: RawTokenSyntax? = nil
    public var trailingComma: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawPrimaryAssociatedTypeSyntax {
      .make(arena: arena
      , name: self.name
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , trailingComma: self.trailingComma
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawPrimaryAssociatedTypeSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, name: RawTokenSyntax, trailingComma: RawTokenSyntax? = nil) -> RawPrimaryAssociatedTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .primaryAssociatedType,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = name.raw
      layout[1] = trailingComma?.raw
    }
    return .init(raw: raw)
  }
}

extension RawGenericParameterClauseSyntax {
  typealias Cursor = GenericParameterClauseSyntax.Cursor
  public var leftAngleBracket: RawTokenSyntax {
    elem(at: Cursor.leftAngleBracket).map(RawTokenSyntax.init(raw:))!
  }
  public var genericParameterList: RawGenericParameterListSyntax {
    elem(at: Cursor.genericParameterList).map(RawGenericParameterListSyntax.init(raw:))!
  }
  public var rightAngleBracket: RawTokenSyntax {
    elem(at: Cursor.rightAngleBracket).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var leftAngleBracket: RawTokenSyntax? = nil
    public var genericParameterList: RawGenericParameterListSyntax? = nil
    public var rightAngleBracket: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawGenericParameterClauseSyntax {
      .make(arena: arena
      , leftAngleBracket: self.leftAngleBracket
          ?? .makeBlank(arena: arena, tokenKind: .leftAngle)
      , genericParameterList: self.genericParameterList
          ?? .makeBlank(arena: arena)
      , rightAngleBracket: self.rightAngleBracket
          ?? .makeBlank(arena: arena, tokenKind: .rightAngle)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawGenericParameterClauseSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, leftAngleBracket: RawTokenSyntax, genericParameterList: RawGenericParameterListSyntax, rightAngleBracket: RawTokenSyntax) -> RawGenericParameterClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .genericParameterClause,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = leftAngleBracket.raw
      layout[1] = genericParameterList.raw
      layout[2] = rightAngleBracket.raw
    }
    return .init(raw: raw)
  }
}

extension RawConformanceRequirementSyntax {
  typealias Cursor = ConformanceRequirementSyntax.Cursor
  public var leftTypeIdentifier: RawTypeSyntax {
    elem(at: Cursor.leftTypeIdentifier).map(RawTypeSyntax.init(raw:))!
  }
  public var colon: RawTokenSyntax {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))!
  }
  public var rightTypeIdentifier: RawTypeSyntax {
    elem(at: Cursor.rightTypeIdentifier).map(RawTypeSyntax.init(raw:))!
  }

  public struct Builder {
    public var leftTypeIdentifier: RawTypeSyntax? = nil
    public var colon: RawTokenSyntax? = nil
    public var rightTypeIdentifier: RawTypeSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawConformanceRequirementSyntax {
      .make(arena: arena
      , leftTypeIdentifier: self.leftTypeIdentifier
          ?? .makeBlank(arena: arena)
      , colon: self.colon
          ?? .makeBlank(arena: arena, tokenKind: .colon)
      , rightTypeIdentifier: self.rightTypeIdentifier
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawConformanceRequirementSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, leftTypeIdentifier: RawTypeSyntax, colon: RawTokenSyntax, rightTypeIdentifier: RawTypeSyntax) -> RawConformanceRequirementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .conformanceRequirement,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = leftTypeIdentifier.raw
      layout[1] = colon.raw
      layout[2] = rightTypeIdentifier.raw
    }
    return .init(raw: raw)
  }
}

extension RawPrimaryAssociatedTypeClauseSyntax {
  typealias Cursor = PrimaryAssociatedTypeClauseSyntax.Cursor
  public var leftAngleBracket: RawTokenSyntax {
    elem(at: Cursor.leftAngleBracket).map(RawTokenSyntax.init(raw:))!
  }
  public var primaryAssociatedTypeList: RawPrimaryAssociatedTypeListSyntax {
    elem(at: Cursor.primaryAssociatedTypeList).map(RawPrimaryAssociatedTypeListSyntax.init(raw:))!
  }
  public var rightAngleBracket: RawTokenSyntax {
    elem(at: Cursor.rightAngleBracket).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var leftAngleBracket: RawTokenSyntax? = nil
    public var primaryAssociatedTypeList: RawPrimaryAssociatedTypeListSyntax? = nil
    public var rightAngleBracket: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawPrimaryAssociatedTypeClauseSyntax {
      .make(arena: arena
      , leftAngleBracket: self.leftAngleBracket
          ?? .makeBlank(arena: arena, tokenKind: .leftAngle)
      , primaryAssociatedTypeList: self.primaryAssociatedTypeList
          ?? .makeBlank(arena: arena)
      , rightAngleBracket: self.rightAngleBracket
          ?? .makeBlank(arena: arena, tokenKind: .rightAngle)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawPrimaryAssociatedTypeClauseSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, leftAngleBracket: RawTokenSyntax, primaryAssociatedTypeList: RawPrimaryAssociatedTypeListSyntax, rightAngleBracket: RawTokenSyntax) -> RawPrimaryAssociatedTypeClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .primaryAssociatedTypeClause,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = leftAngleBracket.raw
      layout[1] = primaryAssociatedTypeList.raw
      layout[2] = rightAngleBracket.raw
    }
    return .init(raw: raw)
  }
}

extension RawSimpleTypeIdentifierSyntax {
  typealias Cursor = SimpleTypeIdentifierSyntax.Cursor
  public var name: RawTokenSyntax {
    elem(at: Cursor.name).map(RawTokenSyntax.init(raw:))!
  }
  public var genericArgumentClause: RawGenericArgumentClauseSyntax? {
    elem(at: Cursor.genericArgumentClause).map(RawGenericArgumentClauseSyntax.init(raw:))
  }

  public struct Builder {
    public var name: RawTokenSyntax? = nil
    public var genericArgumentClause: RawGenericArgumentClauseSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawSimpleTypeIdentifierSyntax {
      .make(arena: arena
      , name: self.name
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , genericArgumentClause: self.genericArgumentClause
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawSimpleTypeIdentifierSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, name: RawTokenSyntax, genericArgumentClause: RawGenericArgumentClauseSyntax? = nil) -> RawSimpleTypeIdentifierSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .simpleTypeIdentifier,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = name.raw
      layout[1] = genericArgumentClause?.raw
    }
    return .init(raw: raw)
  }
}

extension RawMemberTypeIdentifierSyntax {
  typealias Cursor = MemberTypeIdentifierSyntax.Cursor
  public var baseType: RawTypeSyntax {
    elem(at: Cursor.baseType).map(RawTypeSyntax.init(raw:))!
  }
  public var period: RawTokenSyntax {
    elem(at: Cursor.period).map(RawTokenSyntax.init(raw:))!
  }
  public var name: RawTokenSyntax {
    elem(at: Cursor.name).map(RawTokenSyntax.init(raw:))!
  }
  public var genericArgumentClause: RawGenericArgumentClauseSyntax? {
    elem(at: Cursor.genericArgumentClause).map(RawGenericArgumentClauseSyntax.init(raw:))
  }

  public struct Builder {
    public var baseType: RawTypeSyntax? = nil
    public var period: RawTokenSyntax? = nil
    public var name: RawTokenSyntax? = nil
    public var genericArgumentClause: RawGenericArgumentClauseSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawMemberTypeIdentifierSyntax {
      .make(arena: arena
      , baseType: self.baseType
          ?? .makeBlank(arena: arena)
      , period: self.period
          ?? .makeBlank(arena: arena, tokenKind: .period)
      , name: self.name
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , genericArgumentClause: self.genericArgumentClause
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawMemberTypeIdentifierSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, baseType: RawTypeSyntax, period: RawTokenSyntax, name: RawTokenSyntax, genericArgumentClause: RawGenericArgumentClauseSyntax? = nil) -> RawMemberTypeIdentifierSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .memberTypeIdentifier,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = baseType.raw
      layout[1] = period.raw
      layout[2] = name.raw
      layout[3] = genericArgumentClause?.raw
    }
    return .init(raw: raw)
  }
}

extension RawClassRestrictionTypeSyntax {
  typealias Cursor = ClassRestrictionTypeSyntax.Cursor
  public var classKeyword: RawTokenSyntax {
    elem(at: Cursor.classKeyword).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var classKeyword: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawClassRestrictionTypeSyntax {
      .make(arena: arena
      , classKeyword: self.classKeyword
          ?? .makeBlank(arena: arena, tokenKind: .classKeyword)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawClassRestrictionTypeSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, classKeyword: RawTokenSyntax) -> RawClassRestrictionTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .classRestrictionType,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = classKeyword.raw
    }
    return .init(raw: raw)
  }
}

extension RawArrayTypeSyntax {
  typealias Cursor = ArrayTypeSyntax.Cursor
  public var leftSquareBracket: RawTokenSyntax {
    elem(at: Cursor.leftSquareBracket).map(RawTokenSyntax.init(raw:))!
  }
  public var elementType: RawTypeSyntax {
    elem(at: Cursor.elementType).map(RawTypeSyntax.init(raw:))!
  }
  public var rightSquareBracket: RawTokenSyntax {
    elem(at: Cursor.rightSquareBracket).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var leftSquareBracket: RawTokenSyntax? = nil
    public var elementType: RawTypeSyntax? = nil
    public var rightSquareBracket: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawArrayTypeSyntax {
      .make(arena: arena
      , leftSquareBracket: self.leftSquareBracket
          ?? .makeBlank(arena: arena, tokenKind: .leftSquareBracket)
      , elementType: self.elementType
          ?? .makeBlank(arena: arena)
      , rightSquareBracket: self.rightSquareBracket
          ?? .makeBlank(arena: arena, tokenKind: .rightSquareBracket)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawArrayTypeSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, leftSquareBracket: RawTokenSyntax, elementType: RawTypeSyntax, rightSquareBracket: RawTokenSyntax) -> RawArrayTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .arrayType,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = leftSquareBracket.raw
      layout[1] = elementType.raw
      layout[2] = rightSquareBracket.raw
    }
    return .init(raw: raw)
  }
}

extension RawDictionaryTypeSyntax {
  typealias Cursor = DictionaryTypeSyntax.Cursor
  public var leftSquareBracket: RawTokenSyntax {
    elem(at: Cursor.leftSquareBracket).map(RawTokenSyntax.init(raw:))!
  }
  public var keyType: RawTypeSyntax {
    elem(at: Cursor.keyType).map(RawTypeSyntax.init(raw:))!
  }
  public var colon: RawTokenSyntax {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))!
  }
  public var valueType: RawTypeSyntax {
    elem(at: Cursor.valueType).map(RawTypeSyntax.init(raw:))!
  }
  public var rightSquareBracket: RawTokenSyntax {
    elem(at: Cursor.rightSquareBracket).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var leftSquareBracket: RawTokenSyntax? = nil
    public var keyType: RawTypeSyntax? = nil
    public var colon: RawTokenSyntax? = nil
    public var valueType: RawTypeSyntax? = nil
    public var rightSquareBracket: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawDictionaryTypeSyntax {
      .make(arena: arena
      , leftSquareBracket: self.leftSquareBracket
          ?? .makeBlank(arena: arena, tokenKind: .leftSquareBracket)
      , keyType: self.keyType
          ?? .makeBlank(arena: arena)
      , colon: self.colon
          ?? .makeBlank(arena: arena, tokenKind: .colon)
      , valueType: self.valueType
          ?? .makeBlank(arena: arena)
      , rightSquareBracket: self.rightSquareBracket
          ?? .makeBlank(arena: arena, tokenKind: .rightSquareBracket)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawDictionaryTypeSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, leftSquareBracket: RawTokenSyntax, keyType: RawTypeSyntax, colon: RawTokenSyntax, valueType: RawTypeSyntax, rightSquareBracket: RawTokenSyntax) -> RawDictionaryTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .dictionaryType,
                                   uninitializedCount: 5) { layout in
      layout.initialize(repeating: nil)
      layout[0] = leftSquareBracket.raw
      layout[1] = keyType.raw
      layout[2] = colon.raw
      layout[3] = valueType.raw
      layout[4] = rightSquareBracket.raw
    }
    return .init(raw: raw)
  }
}

extension RawMetatypeTypeSyntax {
  typealias Cursor = MetatypeTypeSyntax.Cursor
  public var baseType: RawTypeSyntax {
    elem(at: Cursor.baseType).map(RawTypeSyntax.init(raw:))!
  }
  public var period: RawTokenSyntax {
    elem(at: Cursor.period).map(RawTokenSyntax.init(raw:))!
  }
  public var typeOrProtocol: RawTokenSyntax {
    elem(at: Cursor.typeOrProtocol).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var baseType: RawTypeSyntax? = nil
    public var period: RawTokenSyntax? = nil
    public var typeOrProtocol: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawMetatypeTypeSyntax {
      .make(arena: arena
      , baseType: self.baseType
          ?? .makeBlank(arena: arena)
      , period: self.period
          ?? .makeBlank(arena: arena, tokenKind: .period)
      , typeOrProtocol: self.typeOrProtocol
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawMetatypeTypeSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, baseType: RawTypeSyntax, period: RawTokenSyntax, typeOrProtocol: RawTokenSyntax) -> RawMetatypeTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .metatypeType,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = baseType.raw
      layout[1] = period.raw
      layout[2] = typeOrProtocol.raw
    }
    return .init(raw: raw)
  }
}

extension RawOptionalTypeSyntax {
  typealias Cursor = OptionalTypeSyntax.Cursor
  public var wrappedType: RawTypeSyntax {
    elem(at: Cursor.wrappedType).map(RawTypeSyntax.init(raw:))!
  }
  public var questionMark: RawTokenSyntax {
    elem(at: Cursor.questionMark).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var wrappedType: RawTypeSyntax? = nil
    public var questionMark: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawOptionalTypeSyntax {
      .make(arena: arena
      , wrappedType: self.wrappedType
          ?? .makeBlank(arena: arena)
      , questionMark: self.questionMark
          ?? .makeBlank(arena: arena, tokenKind: .postfixQuestionMark)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawOptionalTypeSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, wrappedType: RawTypeSyntax, questionMark: RawTokenSyntax) -> RawOptionalTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .optionalType,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = wrappedType.raw
      layout[1] = questionMark.raw
    }
    return .init(raw: raw)
  }
}

extension RawConstrainedSugarTypeSyntax {
  typealias Cursor = ConstrainedSugarTypeSyntax.Cursor
  public var someOrAnySpecifier: RawTokenSyntax {
    elem(at: Cursor.someOrAnySpecifier).map(RawTokenSyntax.init(raw:))!
  }
  public var baseType: RawTypeSyntax {
    elem(at: Cursor.baseType).map(RawTypeSyntax.init(raw:))!
  }

  public struct Builder {
    public var someOrAnySpecifier: RawTokenSyntax? = nil
    public var baseType: RawTypeSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawConstrainedSugarTypeSyntax {
      .make(arena: arena
      , someOrAnySpecifier: self.someOrAnySpecifier
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , baseType: self.baseType
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawConstrainedSugarTypeSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, someOrAnySpecifier: RawTokenSyntax, baseType: RawTypeSyntax) -> RawConstrainedSugarTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .constrainedSugarType,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = someOrAnySpecifier.raw
      layout[1] = baseType.raw
    }
    return .init(raw: raw)
  }
}

extension RawImplicitlyUnwrappedOptionalTypeSyntax {
  typealias Cursor = ImplicitlyUnwrappedOptionalTypeSyntax.Cursor
  public var wrappedType: RawTypeSyntax {
    elem(at: Cursor.wrappedType).map(RawTypeSyntax.init(raw:))!
  }
  public var exclamationMark: RawTokenSyntax {
    elem(at: Cursor.exclamationMark).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var wrappedType: RawTypeSyntax? = nil
    public var exclamationMark: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawImplicitlyUnwrappedOptionalTypeSyntax {
      .make(arena: arena
      , wrappedType: self.wrappedType
          ?? .makeBlank(arena: arena)
      , exclamationMark: self.exclamationMark
          ?? .makeBlank(arena: arena, tokenKind: .exclamationMark)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawImplicitlyUnwrappedOptionalTypeSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, wrappedType: RawTypeSyntax, exclamationMark: RawTokenSyntax) -> RawImplicitlyUnwrappedOptionalTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .implicitlyUnwrappedOptionalType,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = wrappedType.raw
      layout[1] = exclamationMark.raw
    }
    return .init(raw: raw)
  }
}

extension RawCompositionTypeElementSyntax {
  typealias Cursor = CompositionTypeElementSyntax.Cursor
  public var type: RawTypeSyntax {
    elem(at: Cursor.type).map(RawTypeSyntax.init(raw:))!
  }
  public var ampersand: RawTokenSyntax? {
    elem(at: Cursor.ampersand).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var type: RawTypeSyntax? = nil
    public var ampersand: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawCompositionTypeElementSyntax {
      .make(arena: arena
      , type: self.type
          ?? .makeBlank(arena: arena)
      , ampersand: self.ampersand
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawCompositionTypeElementSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, type: RawTypeSyntax, ampersand: RawTokenSyntax? = nil) -> RawCompositionTypeElementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .compositionTypeElement,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = type.raw
      layout[1] = ampersand?.raw
    }
    return .init(raw: raw)
  }
}

extension RawCompositionTypeSyntax {
  typealias Cursor = CompositionTypeSyntax.Cursor
  public var elements: RawCompositionTypeElementListSyntax {
    elem(at: Cursor.elements).map(RawCompositionTypeElementListSyntax.init(raw:))!
  }

  public struct Builder {
    public var elements: RawCompositionTypeElementListSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawCompositionTypeSyntax {
      .make(arena: arena
      , elements: self.elements
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawCompositionTypeSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, elements: RawCompositionTypeElementListSyntax) -> RawCompositionTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .compositionType,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = elements.raw
    }
    return .init(raw: raw)
  }
}

extension RawTupleTypeElementSyntax {
  typealias Cursor = TupleTypeElementSyntax.Cursor
  public var inOut: RawTokenSyntax? {
    elem(at: Cursor.inOut).map(RawTokenSyntax.init(raw:))
  }
  public var name: RawTokenSyntax? {
    elem(at: Cursor.name).map(RawTokenSyntax.init(raw:))
  }
  public var secondName: RawTokenSyntax? {
    elem(at: Cursor.secondName).map(RawTokenSyntax.init(raw:))
  }
  public var colon: RawTokenSyntax? {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))
  }
  public var type: RawTypeSyntax {
    elem(at: Cursor.type).map(RawTypeSyntax.init(raw:))!
  }
  public var ellipsis: RawTokenSyntax? {
    elem(at: Cursor.ellipsis).map(RawTokenSyntax.init(raw:))
  }
  public var initializer: RawInitializerClauseSyntax? {
    elem(at: Cursor.initializer).map(RawInitializerClauseSyntax.init(raw:))
  }
  public var trailingComma: RawTokenSyntax? {
    elem(at: Cursor.trailingComma).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var inOut: RawTokenSyntax? = nil
    public var name: RawTokenSyntax? = nil
    public var secondName: RawTokenSyntax? = nil
    public var colon: RawTokenSyntax? = nil
    public var type: RawTypeSyntax? = nil
    public var ellipsis: RawTokenSyntax? = nil
    public var initializer: RawInitializerClauseSyntax? = nil
    public var trailingComma: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawTupleTypeElementSyntax {
      .make(arena: arena
      , inOut: self.inOut
      , name: self.name
      , secondName: self.secondName
      , colon: self.colon
      , type: self.type
          ?? .makeBlank(arena: arena)
      , ellipsis: self.ellipsis
      , initializer: self.initializer
      , trailingComma: self.trailingComma
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawTupleTypeElementSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, inOut: RawTokenSyntax? = nil, name: RawTokenSyntax? = nil, secondName: RawTokenSyntax? = nil, colon: RawTokenSyntax? = nil, type: RawTypeSyntax, ellipsis: RawTokenSyntax? = nil, initializer: RawInitializerClauseSyntax? = nil, trailingComma: RawTokenSyntax? = nil) -> RawTupleTypeElementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .tupleTypeElement,
                                   uninitializedCount: 8) { layout in
      layout.initialize(repeating: nil)
      layout[0] = inOut?.raw
      layout[1] = name?.raw
      layout[2] = secondName?.raw
      layout[3] = colon?.raw
      layout[4] = type.raw
      layout[5] = ellipsis?.raw
      layout[6] = initializer?.raw
      layout[7] = trailingComma?.raw
    }
    return .init(raw: raw)
  }
}

extension RawTupleTypeSyntax {
  typealias Cursor = TupleTypeSyntax.Cursor
  public var leftParen: RawTokenSyntax {
    elem(at: Cursor.leftParen).map(RawTokenSyntax.init(raw:))!
  }
  public var elements: RawTupleTypeElementListSyntax {
    elem(at: Cursor.elements).map(RawTupleTypeElementListSyntax.init(raw:))!
  }
  public var rightParen: RawTokenSyntax {
    elem(at: Cursor.rightParen).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var leftParen: RawTokenSyntax? = nil
    public var elements: RawTupleTypeElementListSyntax? = nil
    public var rightParen: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawTupleTypeSyntax {
      .make(arena: arena
      , leftParen: self.leftParen
          ?? .makeBlank(arena: arena, tokenKind: .leftParen)
      , elements: self.elements
          ?? .makeBlank(arena: arena)
      , rightParen: self.rightParen
          ?? .makeBlank(arena: arena, tokenKind: .rightParen)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawTupleTypeSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, leftParen: RawTokenSyntax, elements: RawTupleTypeElementListSyntax, rightParen: RawTokenSyntax) -> RawTupleTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .tupleType,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = leftParen.raw
      layout[1] = elements.raw
      layout[2] = rightParen.raw
    }
    return .init(raw: raw)
  }
}

extension RawFunctionTypeSyntax {
  typealias Cursor = FunctionTypeSyntax.Cursor
  public var leftParen: RawTokenSyntax {
    elem(at: Cursor.leftParen).map(RawTokenSyntax.init(raw:))!
  }
  public var arguments: RawTupleTypeElementListSyntax {
    elem(at: Cursor.arguments).map(RawTupleTypeElementListSyntax.init(raw:))!
  }
  public var rightParen: RawTokenSyntax {
    elem(at: Cursor.rightParen).map(RawTokenSyntax.init(raw:))!
  }
  public var asyncKeyword: RawTokenSyntax? {
    elem(at: Cursor.asyncKeyword).map(RawTokenSyntax.init(raw:))
  }
  public var throwsOrRethrowsKeyword: RawTokenSyntax? {
    elem(at: Cursor.throwsOrRethrowsKeyword).map(RawTokenSyntax.init(raw:))
  }
  public var arrow: RawTokenSyntax {
    elem(at: Cursor.arrow).map(RawTokenSyntax.init(raw:))!
  }
  public var returnType: RawTypeSyntax {
    elem(at: Cursor.returnType).map(RawTypeSyntax.init(raw:))!
  }

  public struct Builder {
    public var leftParen: RawTokenSyntax? = nil
    public var arguments: RawTupleTypeElementListSyntax? = nil
    public var rightParen: RawTokenSyntax? = nil
    public var asyncKeyword: RawTokenSyntax? = nil
    public var throwsOrRethrowsKeyword: RawTokenSyntax? = nil
    public var arrow: RawTokenSyntax? = nil
    public var returnType: RawTypeSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawFunctionTypeSyntax {
      .make(arena: arena
      , leftParen: self.leftParen
          ?? .makeBlank(arena: arena, tokenKind: .leftParen)
      , arguments: self.arguments
          ?? .makeBlank(arena: arena)
      , rightParen: self.rightParen
          ?? .makeBlank(arena: arena, tokenKind: .rightParen)
      , asyncKeyword: self.asyncKeyword
      , throwsOrRethrowsKeyword: self.throwsOrRethrowsKeyword
      , arrow: self.arrow
          ?? .makeBlank(arena: arena, tokenKind: .arrow)
      , returnType: self.returnType
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawFunctionTypeSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, leftParen: RawTokenSyntax, arguments: RawTupleTypeElementListSyntax, rightParen: RawTokenSyntax, asyncKeyword: RawTokenSyntax? = nil, throwsOrRethrowsKeyword: RawTokenSyntax? = nil, arrow: RawTokenSyntax, returnType: RawTypeSyntax) -> RawFunctionTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .functionType,
                                   uninitializedCount: 7) { layout in
      layout.initialize(repeating: nil)
      layout[0] = leftParen.raw
      layout[1] = arguments.raw
      layout[2] = rightParen.raw
      layout[3] = asyncKeyword?.raw
      layout[4] = throwsOrRethrowsKeyword?.raw
      layout[5] = arrow.raw
      layout[6] = returnType.raw
    }
    return .init(raw: raw)
  }
}

extension RawAttributedTypeSyntax {
  typealias Cursor = AttributedTypeSyntax.Cursor
  public var specifier: RawTokenSyntax? {
    elem(at: Cursor.specifier).map(RawTokenSyntax.init(raw:))
  }
  public var attributes: RawAttributeListSyntax? {
    elem(at: Cursor.attributes).map(RawAttributeListSyntax.init(raw:))
  }
  public var baseType: RawTypeSyntax {
    elem(at: Cursor.baseType).map(RawTypeSyntax.init(raw:))!
  }

  public struct Builder {
    public var specifier: RawTokenSyntax? = nil
    public var attributes: RawAttributeListSyntax? = nil
    public var baseType: RawTypeSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawAttributedTypeSyntax {
      .make(arena: arena
      , specifier: self.specifier
      , attributes: self.attributes
      , baseType: self.baseType
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawAttributedTypeSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, specifier: RawTokenSyntax? = nil, attributes: RawAttributeListSyntax? = nil, baseType: RawTypeSyntax) -> RawAttributedTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .attributedType,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = specifier?.raw
      layout[1] = attributes?.raw
      layout[2] = baseType.raw
    }
    return .init(raw: raw)
  }
}

extension RawGenericArgumentSyntax {
  typealias Cursor = GenericArgumentSyntax.Cursor
  public var argumentType: RawTypeSyntax {
    elem(at: Cursor.argumentType).map(RawTypeSyntax.init(raw:))!
  }
  public var trailingComma: RawTokenSyntax? {
    elem(at: Cursor.trailingComma).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var argumentType: RawTypeSyntax? = nil
    public var trailingComma: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawGenericArgumentSyntax {
      .make(arena: arena
      , argumentType: self.argumentType
          ?? .makeBlank(arena: arena)
      , trailingComma: self.trailingComma
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawGenericArgumentSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, argumentType: RawTypeSyntax, trailingComma: RawTokenSyntax? = nil) -> RawGenericArgumentSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .genericArgument,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = argumentType.raw
      layout[1] = trailingComma?.raw
    }
    return .init(raw: raw)
  }
}

extension RawGenericArgumentClauseSyntax {
  typealias Cursor = GenericArgumentClauseSyntax.Cursor
  public var leftAngleBracket: RawTokenSyntax {
    elem(at: Cursor.leftAngleBracket).map(RawTokenSyntax.init(raw:))!
  }
  public var arguments: RawGenericArgumentListSyntax {
    elem(at: Cursor.arguments).map(RawGenericArgumentListSyntax.init(raw:))!
  }
  public var rightAngleBracket: RawTokenSyntax {
    elem(at: Cursor.rightAngleBracket).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var leftAngleBracket: RawTokenSyntax? = nil
    public var arguments: RawGenericArgumentListSyntax? = nil
    public var rightAngleBracket: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawGenericArgumentClauseSyntax {
      .make(arena: arena
      , leftAngleBracket: self.leftAngleBracket
          ?? .makeBlank(arena: arena, tokenKind: .leftAngle)
      , arguments: self.arguments
          ?? .makeBlank(arena: arena)
      , rightAngleBracket: self.rightAngleBracket
          ?? .makeBlank(arena: arena, tokenKind: .rightAngle)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawGenericArgumentClauseSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, leftAngleBracket: RawTokenSyntax, arguments: RawGenericArgumentListSyntax, rightAngleBracket: RawTokenSyntax) -> RawGenericArgumentClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .genericArgumentClause,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = leftAngleBracket.raw
      layout[1] = arguments.raw
      layout[2] = rightAngleBracket.raw
    }
    return .init(raw: raw)
  }
}

extension RawTypeAnnotationSyntax {
  typealias Cursor = TypeAnnotationSyntax.Cursor
  public var colon: RawTokenSyntax {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))!
  }
  public var type: RawTypeSyntax {
    elem(at: Cursor.type).map(RawTypeSyntax.init(raw:))!
  }

  public struct Builder {
    public var colon: RawTokenSyntax? = nil
    public var type: RawTypeSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawTypeAnnotationSyntax {
      .make(arena: arena
      , colon: self.colon
          ?? .makeBlank(arena: arena, tokenKind: .colon)
      , type: self.type
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawTypeAnnotationSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, colon: RawTokenSyntax, type: RawTypeSyntax) -> RawTypeAnnotationSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .typeAnnotation,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = colon.raw
      layout[1] = type.raw
    }
    return .init(raw: raw)
  }
}

extension RawEnumCasePatternSyntax {
  typealias Cursor = EnumCasePatternSyntax.Cursor
  public var type: RawTypeSyntax? {
    elem(at: Cursor.type).map(RawTypeSyntax.init(raw:))
  }
  public var period: RawTokenSyntax {
    elem(at: Cursor.period).map(RawTokenSyntax.init(raw:))!
  }
  public var caseName: RawTokenSyntax {
    elem(at: Cursor.caseName).map(RawTokenSyntax.init(raw:))!
  }
  public var associatedTuple: RawTuplePatternSyntax? {
    elem(at: Cursor.associatedTuple).map(RawTuplePatternSyntax.init(raw:))
  }

  public struct Builder {
    public var type: RawTypeSyntax? = nil
    public var period: RawTokenSyntax? = nil
    public var caseName: RawTokenSyntax? = nil
    public var associatedTuple: RawTuplePatternSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawEnumCasePatternSyntax {
      .make(arena: arena
      , type: self.type
      , period: self.period
          ?? .makeBlank(arena: arena, tokenKind: .period)
      , caseName: self.caseName
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , associatedTuple: self.associatedTuple
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawEnumCasePatternSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, type: RawTypeSyntax? = nil, period: RawTokenSyntax, caseName: RawTokenSyntax, associatedTuple: RawTuplePatternSyntax? = nil) -> RawEnumCasePatternSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .enumCasePattern,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = type?.raw
      layout[1] = period.raw
      layout[2] = caseName.raw
      layout[3] = associatedTuple?.raw
    }
    return .init(raw: raw)
  }
}

extension RawIsTypePatternSyntax {
  typealias Cursor = IsTypePatternSyntax.Cursor
  public var isKeyword: RawTokenSyntax {
    elem(at: Cursor.isKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var type: RawTypeSyntax {
    elem(at: Cursor.type).map(RawTypeSyntax.init(raw:))!
  }

  public struct Builder {
    public var isKeyword: RawTokenSyntax? = nil
    public var type: RawTypeSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawIsTypePatternSyntax {
      .make(arena: arena
      , isKeyword: self.isKeyword
          ?? .makeBlank(arena: arena, tokenKind: .isKeyword)
      , type: self.type
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawIsTypePatternSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, isKeyword: RawTokenSyntax, type: RawTypeSyntax) -> RawIsTypePatternSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .isTypePattern,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = isKeyword.raw
      layout[1] = type.raw
    }
    return .init(raw: raw)
  }
}

extension RawOptionalPatternSyntax {
  typealias Cursor = OptionalPatternSyntax.Cursor
  public var subPattern: RawPatternSyntax {
    elem(at: Cursor.subPattern).map(RawPatternSyntax.init(raw:))!
  }
  public var questionMark: RawTokenSyntax {
    elem(at: Cursor.questionMark).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var subPattern: RawPatternSyntax? = nil
    public var questionMark: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawOptionalPatternSyntax {
      .make(arena: arena
      , subPattern: self.subPattern
          ?? .makeBlank(arena: arena)
      , questionMark: self.questionMark
          ?? .makeBlank(arena: arena, tokenKind: .postfixQuestionMark)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawOptionalPatternSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, subPattern: RawPatternSyntax, questionMark: RawTokenSyntax) -> RawOptionalPatternSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .optionalPattern,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = subPattern.raw
      layout[1] = questionMark.raw
    }
    return .init(raw: raw)
  }
}

extension RawIdentifierPatternSyntax {
  typealias Cursor = IdentifierPatternSyntax.Cursor
  public var identifier: RawTokenSyntax {
    elem(at: Cursor.identifier).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var identifier: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawIdentifierPatternSyntax {
      .make(arena: arena
      , identifier: self.identifier
          ?? .makeBlank(arena: arena, tokenKind: .selfKeyword)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawIdentifierPatternSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, identifier: RawTokenSyntax) -> RawIdentifierPatternSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .identifierPattern,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = identifier.raw
    }
    return .init(raw: raw)
  }
}

extension RawAsTypePatternSyntax {
  typealias Cursor = AsTypePatternSyntax.Cursor
  public var pattern: RawPatternSyntax {
    elem(at: Cursor.pattern).map(RawPatternSyntax.init(raw:))!
  }
  public var asKeyword: RawTokenSyntax {
    elem(at: Cursor.asKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var type: RawTypeSyntax {
    elem(at: Cursor.type).map(RawTypeSyntax.init(raw:))!
  }

  public struct Builder {
    public var pattern: RawPatternSyntax? = nil
    public var asKeyword: RawTokenSyntax? = nil
    public var type: RawTypeSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawAsTypePatternSyntax {
      .make(arena: arena
      , pattern: self.pattern
          ?? .makeBlank(arena: arena)
      , asKeyword: self.asKeyword
          ?? .makeBlank(arena: arena, tokenKind: .asKeyword)
      , type: self.type
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawAsTypePatternSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, pattern: RawPatternSyntax, asKeyword: RawTokenSyntax, type: RawTypeSyntax) -> RawAsTypePatternSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .asTypePattern,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = pattern.raw
      layout[1] = asKeyword.raw
      layout[2] = type.raw
    }
    return .init(raw: raw)
  }
}

extension RawTuplePatternSyntax {
  typealias Cursor = TuplePatternSyntax.Cursor
  public var leftParen: RawTokenSyntax {
    elem(at: Cursor.leftParen).map(RawTokenSyntax.init(raw:))!
  }
  public var elements: RawTuplePatternElementListSyntax {
    elem(at: Cursor.elements).map(RawTuplePatternElementListSyntax.init(raw:))!
  }
  public var rightParen: RawTokenSyntax {
    elem(at: Cursor.rightParen).map(RawTokenSyntax.init(raw:))!
  }

  public struct Builder {
    public var leftParen: RawTokenSyntax? = nil
    public var elements: RawTuplePatternElementListSyntax? = nil
    public var rightParen: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawTuplePatternSyntax {
      .make(arena: arena
      , leftParen: self.leftParen
          ?? .makeBlank(arena: arena, tokenKind: .leftParen)
      , elements: self.elements
          ?? .makeBlank(arena: arena)
      , rightParen: self.rightParen
          ?? .makeBlank(arena: arena, tokenKind: .rightParen)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawTuplePatternSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, leftParen: RawTokenSyntax, elements: RawTuplePatternElementListSyntax, rightParen: RawTokenSyntax) -> RawTuplePatternSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .tuplePattern,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = leftParen.raw
      layout[1] = elements.raw
      layout[2] = rightParen.raw
    }
    return .init(raw: raw)
  }
}

extension RawWildcardPatternSyntax {
  typealias Cursor = WildcardPatternSyntax.Cursor
  public var wildcard: RawTokenSyntax {
    elem(at: Cursor.wildcard).map(RawTokenSyntax.init(raw:))!
  }
  public var typeAnnotation: RawTypeAnnotationSyntax? {
    elem(at: Cursor.typeAnnotation).map(RawTypeAnnotationSyntax.init(raw:))
  }

  public struct Builder {
    public var wildcard: RawTokenSyntax? = nil
    public var typeAnnotation: RawTypeAnnotationSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawWildcardPatternSyntax {
      .make(arena: arena
      , wildcard: self.wildcard
          ?? .makeBlank(arena: arena, tokenKind: .wildcardKeyword)
      , typeAnnotation: self.typeAnnotation
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawWildcardPatternSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, wildcard: RawTokenSyntax, typeAnnotation: RawTypeAnnotationSyntax? = nil) -> RawWildcardPatternSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .wildcardPattern,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = wildcard.raw
      layout[1] = typeAnnotation?.raw
    }
    return .init(raw: raw)
  }
}

extension RawTuplePatternElementSyntax {
  typealias Cursor = TuplePatternElementSyntax.Cursor
  public var labelName: RawTokenSyntax? {
    elem(at: Cursor.labelName).map(RawTokenSyntax.init(raw:))
  }
  public var labelColon: RawTokenSyntax? {
    elem(at: Cursor.labelColon).map(RawTokenSyntax.init(raw:))
  }
  public var pattern: RawPatternSyntax {
    elem(at: Cursor.pattern).map(RawPatternSyntax.init(raw:))!
  }
  public var trailingComma: RawTokenSyntax? {
    elem(at: Cursor.trailingComma).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var labelName: RawTokenSyntax? = nil
    public var labelColon: RawTokenSyntax? = nil
    public var pattern: RawPatternSyntax? = nil
    public var trailingComma: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawTuplePatternElementSyntax {
      .make(arena: arena
      , labelName: self.labelName
      , labelColon: self.labelColon
      , pattern: self.pattern
          ?? .makeBlank(arena: arena)
      , trailingComma: self.trailingComma
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawTuplePatternElementSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, labelName: RawTokenSyntax? = nil, labelColon: RawTokenSyntax? = nil, pattern: RawPatternSyntax, trailingComma: RawTokenSyntax? = nil) -> RawTuplePatternElementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .tuplePatternElement,
                                   uninitializedCount: 4) { layout in
      layout.initialize(repeating: nil)
      layout[0] = labelName?.raw
      layout[1] = labelColon?.raw
      layout[2] = pattern.raw
      layout[3] = trailingComma?.raw
    }
    return .init(raw: raw)
  }
}

extension RawExpressionPatternSyntax {
  typealias Cursor = ExpressionPatternSyntax.Cursor
  public var expression: RawExprSyntax {
    elem(at: Cursor.expression).map(RawExprSyntax.init(raw:))!
  }

  public struct Builder {
    public var expression: RawExprSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawExpressionPatternSyntax {
      .make(arena: arena
      , expression: self.expression
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawExpressionPatternSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, expression: RawExprSyntax) -> RawExpressionPatternSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .expressionPattern,
                                   uninitializedCount: 1) { layout in
      layout.initialize(repeating: nil)
      layout[0] = expression.raw
    }
    return .init(raw: raw)
  }
}

extension RawValueBindingPatternSyntax {
  typealias Cursor = ValueBindingPatternSyntax.Cursor
  public var letOrVarKeyword: RawTokenSyntax {
    elem(at: Cursor.letOrVarKeyword).map(RawTokenSyntax.init(raw:))!
  }
  public var valuePattern: RawPatternSyntax {
    elem(at: Cursor.valuePattern).map(RawPatternSyntax.init(raw:))!
  }

  public struct Builder {
    public var letOrVarKeyword: RawTokenSyntax? = nil
    public var valuePattern: RawPatternSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawValueBindingPatternSyntax {
      .make(arena: arena
      , letOrVarKeyword: self.letOrVarKeyword
          ?? .makeBlank(arena: arena, tokenKind: .letKeyword)
      , valuePattern: self.valuePattern
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawValueBindingPatternSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, letOrVarKeyword: RawTokenSyntax, valuePattern: RawPatternSyntax) -> RawValueBindingPatternSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .valueBindingPattern,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = letOrVarKeyword.raw
      layout[1] = valuePattern.raw
    }
    return .init(raw: raw)
  }
}

extension RawAvailabilityArgumentSyntax {
  typealias Cursor = AvailabilityArgumentSyntax.Cursor
  public var entry: RawSyntax {
    elem(at: Cursor.entry).map(RawSyntax.init(raw:))!
  }
  public var trailingComma: RawTokenSyntax? {
    elem(at: Cursor.trailingComma).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var entry: RawSyntax? = nil
    public var trailingComma: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawAvailabilityArgumentSyntax {
      .make(arena: arena
      , entry: self.entry
          ?? .makeBlank(arena: arena)
      , trailingComma: self.trailingComma
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawAvailabilityArgumentSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, entry: RawSyntax, trailingComma: RawTokenSyntax? = nil) -> RawAvailabilityArgumentSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .availabilityArgument,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = entry.raw
      layout[1] = trailingComma?.raw
    }
    return .init(raw: raw)
  }
}

extension RawAvailabilityLabeledArgumentSyntax {
  typealias Cursor = AvailabilityLabeledArgumentSyntax.Cursor
  public var label: RawTokenSyntax {
    elem(at: Cursor.label).map(RawTokenSyntax.init(raw:))!
  }
  public var colon: RawTokenSyntax {
    elem(at: Cursor.colon).map(RawTokenSyntax.init(raw:))!
  }
  public var value: RawSyntax {
    elem(at: Cursor.value).map(RawSyntax.init(raw:))!
  }

  public struct Builder {
    public var label: RawTokenSyntax? = nil
    public var colon: RawTokenSyntax? = nil
    public var value: RawSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawAvailabilityLabeledArgumentSyntax {
      .make(arena: arena
      , label: self.label
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , colon: self.colon
          ?? .makeBlank(arena: arena, tokenKind: .colon)
      , value: self.value
          ?? .makeBlank(arena: arena)
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawAvailabilityLabeledArgumentSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, label: RawTokenSyntax, colon: RawTokenSyntax, value: RawSyntax) -> RawAvailabilityLabeledArgumentSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .availabilityLabeledArgument,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = label.raw
      layout[1] = colon.raw
      layout[2] = value.raw
    }
    return .init(raw: raw)
  }
}

extension RawAvailabilityVersionRestrictionSyntax {
  typealias Cursor = AvailabilityVersionRestrictionSyntax.Cursor
  public var platform: RawTokenSyntax {
    elem(at: Cursor.platform).map(RawTokenSyntax.init(raw:))!
  }
  public var version: RawVersionTupleSyntax? {
    elem(at: Cursor.version).map(RawVersionTupleSyntax.init(raw:))
  }

  public struct Builder {
    public var platform: RawTokenSyntax? = nil
    public var version: RawVersionTupleSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawAvailabilityVersionRestrictionSyntax {
      .make(arena: arena
      , platform: self.platform
          ?? .makeBlank(arena: arena, tokenKind: .identifier)
      , version: self.version
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawAvailabilityVersionRestrictionSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, platform: RawTokenSyntax, version: RawVersionTupleSyntax? = nil) -> RawAvailabilityVersionRestrictionSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .availabilityVersionRestriction,
                                   uninitializedCount: 2) { layout in
      layout.initialize(repeating: nil)
      layout[0] = platform.raw
      layout[1] = version?.raw
    }
    return .init(raw: raw)
  }
}

extension RawVersionTupleSyntax {
  typealias Cursor = VersionTupleSyntax.Cursor
  public var majorMinor: RawSyntax {
    elem(at: Cursor.majorMinor).map(RawSyntax.init(raw:))!
  }
  public var patchPeriod: RawTokenSyntax? {
    elem(at: Cursor.patchPeriod).map(RawTokenSyntax.init(raw:))
  }
  public var patchVersion: RawTokenSyntax? {
    elem(at: Cursor.patchVersion).map(RawTokenSyntax.init(raw:))
  }

  public struct Builder {
    public var majorMinor: RawSyntax? = nil
    public var patchPeriod: RawTokenSyntax? = nil
    public var patchVersion: RawTokenSyntax? = nil

    @inlinable
    public init() {}

    @inlinable
    public mutating func build(arena: SyntaxArena) -> RawVersionTupleSyntax {
      .make(arena: arena
      , majorMinor: self.majorMinor
          ?? .makeBlank(arena: arena)
      , patchPeriod: self.patchPeriod
      , patchVersion: self.patchVersion
      )
    }

  }

  @inlinable
  public static func makeBlank(arena: SyntaxArena) -> RawVersionTupleSyntax {
    var builder = Builder()
    return builder.build(arena: arena)
  }

  @inlinable
  public static func make(arena: SyntaxArena, majorMinor: RawSyntax, patchPeriod: RawTokenSyntax? = nil, patchVersion: RawTokenSyntax? = nil) -> RawVersionTupleSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .versionTuple,
                                   uninitializedCount: 3) { layout in
      layout.initialize(repeating: nil)
      layout[0] = majorMinor.raw
      layout[1] = patchPeriod?.raw
      layout[2] = patchVersion?.raw
    }
    return .init(raw: raw)
  }
}
