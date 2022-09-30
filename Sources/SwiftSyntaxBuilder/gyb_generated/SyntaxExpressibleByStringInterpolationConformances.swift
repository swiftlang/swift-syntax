//// Automatically Generated From SyntaxExpressilbeByStringInterpolationConformances.swift.gyb.
//// Do Not Edit Directly!
//===----------------------------------------------------------------------===//
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

@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) import SwiftParser

extension DeclSyntaxProtocol {
  public static func parse(from parser: inout Parser) throws -> Self {
    let node = parser.parseDeclaration().syntax
    guard let result = node.as(Self.self) else {
      throw SyntaxStringInterpolationError.producedInvalidNodeType(expectedType: Self.self, actualType: type(of: node.asProtocol(DeclSyntaxProtocol.self)))
    }
    return result
  }
}

extension ExprSyntaxProtocol {
  public static func parse(from parser: inout Parser) throws -> Self {
    let node = parser.parseExpression().syntax
    guard let result = node.as(Self.self) else {
      throw SyntaxStringInterpolationError.producedInvalidNodeType(expectedType: Self.self, actualType: type(of: node.asProtocol(ExprSyntaxProtocol.self)))
    }
    return result
  }
}

extension PatternSyntaxProtocol {
  public static func parse(from parser: inout Parser) throws -> Self {
    let node = parser.parsePattern().syntax
    guard let result = node.as(Self.self) else {
      throw SyntaxStringInterpolationError.producedInvalidNodeType(expectedType: Self.self, actualType: type(of: node.asProtocol(PatternSyntaxProtocol.self)))
    }
    return result
  }
}

extension StmtSyntaxProtocol {
  public static func parse(from parser: inout Parser) throws -> Self {
    let node = parser.parseStatement().syntax
    guard let result = node.as(Self.self) else {
      throw SyntaxStringInterpolationError.producedInvalidNodeType(expectedType: Self.self, actualType: type(of: node.asProtocol(StmtSyntaxProtocol.self)))
    }
    return result
  }
}

extension TypeSyntaxProtocol {
  public static func parse(from parser: inout Parser) throws -> Self {
    let node = parser.parseType().syntax
    guard let result = node.as(Self.self) else {
      throw SyntaxStringInterpolationError.producedInvalidNodeType(expectedType: Self.self, actualType: type(of: node.asProtocol(TypeSyntaxProtocol.self)))
    }
    return result
  }
}


extension DeclSyntax: SyntaxExpressibleByStringInterpolation {
  public static func parse(from parser: inout Parser) -> Self {
    return parser.parseDeclaration().syntax
  }
}

extension ExprSyntax: SyntaxExpressibleByStringInterpolation {
  public static func parse(from parser: inout Parser) -> Self {
    return parser.parseExpression().syntax
  }
}

extension StmtSyntax: SyntaxExpressibleByStringInterpolation {
  public static func parse(from parser: inout Parser) -> Self {
    return parser.parseStatement().syntax
  }
}

extension TypeSyntax: SyntaxExpressibleByStringInterpolation {
  public static func parse(from parser: inout Parser) -> Self {
    return parser.parseType().syntax
  }
}

extension PatternSyntax: SyntaxExpressibleByStringInterpolation {
  public static func parse(from parser: inout Parser) -> Self {
    return parser.parsePattern().syntax
  }
}

extension UnknownDeclSyntax: SyntaxExpressibleByStringInterpolation {}

extension UnknownExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension UnknownStmtSyntax: SyntaxExpressibleByStringInterpolation {}

extension UnknownTypeSyntax: SyntaxExpressibleByStringInterpolation {}

extension UnknownPatternSyntax: SyntaxExpressibleByStringInterpolation {}

extension MissingDeclSyntax: SyntaxExpressibleByStringInterpolation {}

extension MissingExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension MissingStmtSyntax: SyntaxExpressibleByStringInterpolation {}

extension MissingTypeSyntax: SyntaxExpressibleByStringInterpolation {}

extension MissingPatternSyntax: SyntaxExpressibleByStringInterpolation {}

extension InOutExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension PoundColumnExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension TryExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension AwaitExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension MoveExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension IdentifierExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension SuperRefExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension NilLiteralExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension DiscardAssignmentExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension AssignmentExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension SequenceExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension PoundLineExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension PoundFileExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension PoundFileIDExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension PoundFilePathExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension PoundFunctionExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension PoundDsohandleExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension SymbolicReferenceExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension PrefixOperatorExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension BinaryOperatorExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension ArrowExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension InfixOperatorExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension FloatLiteralExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension TupleExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension ArrayExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension DictionaryExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension IntegerLiteralExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension BooleanLiteralExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension UnresolvedTernaryExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension TernaryExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension MemberAccessExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension UnresolvedIsExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension IsExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension UnresolvedAsExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension AsExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension TypeExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension ClosureExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension UnresolvedPatternExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension FunctionCallExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension SubscriptExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension OptionalChainingExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension ForcedValueExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension PostfixUnaryExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension SpecializeExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension StringLiteralExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension RegexLiteralExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension KeyPathExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension OldKeyPathExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension KeyPathBaseExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension ObjcKeyPathExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension ObjcSelectorExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension PostfixIfConfigExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension EditorPlaceholderExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension ObjectLiteralExprSyntax: SyntaxExpressibleByStringInterpolation {}

extension TypealiasDeclSyntax: SyntaxExpressibleByStringInterpolation {}

extension AssociatedtypeDeclSyntax: SyntaxExpressibleByStringInterpolation {}

extension IfConfigDeclSyntax: SyntaxExpressibleByStringInterpolation {}

extension PoundErrorDeclSyntax: SyntaxExpressibleByStringInterpolation {}

extension PoundWarningDeclSyntax: SyntaxExpressibleByStringInterpolation {}

extension PoundSourceLocationSyntax: SyntaxExpressibleByStringInterpolation {}

extension ClassDeclSyntax: SyntaxExpressibleByStringInterpolation {}

extension ActorDeclSyntax: SyntaxExpressibleByStringInterpolation {}

extension StructDeclSyntax: SyntaxExpressibleByStringInterpolation {}

extension ProtocolDeclSyntax: SyntaxExpressibleByStringInterpolation {}

extension ExtensionDeclSyntax: SyntaxExpressibleByStringInterpolation {}

extension MemberDeclBlockSyntax: SyntaxExpressibleByStringInterpolation {
  public static func parse(from parser: inout Parser) -> Self {
    return parser.parseMemberDeclList().syntax
  }
}

extension SourceFileSyntax: SyntaxExpressibleByStringInterpolation {
  public static func parse(from parser: inout Parser) -> Self {
    return parser.parseSourceFile().syntax
  }
}

extension FunctionDeclSyntax: SyntaxExpressibleByStringInterpolation {}

extension InitializerDeclSyntax: SyntaxExpressibleByStringInterpolation {}

extension DeinitializerDeclSyntax: SyntaxExpressibleByStringInterpolation {}

extension SubscriptDeclSyntax: SyntaxExpressibleByStringInterpolation {}

extension ImportDeclSyntax: SyntaxExpressibleByStringInterpolation {}

extension AccessorDeclSyntax: SyntaxExpressibleByStringInterpolation {}

extension VariableDeclSyntax: SyntaxExpressibleByStringInterpolation {}

extension EnumCaseDeclSyntax: SyntaxExpressibleByStringInterpolation {}

extension EnumDeclSyntax: SyntaxExpressibleByStringInterpolation {}

extension OperatorDeclSyntax: SyntaxExpressibleByStringInterpolation {}

extension PrecedenceGroupDeclSyntax: SyntaxExpressibleByStringInterpolation {}

extension LabeledStmtSyntax: SyntaxExpressibleByStringInterpolation {}

extension ContinueStmtSyntax: SyntaxExpressibleByStringInterpolation {}

extension WhileStmtSyntax: SyntaxExpressibleByStringInterpolation {}

extension DeferStmtSyntax: SyntaxExpressibleByStringInterpolation {}

extension ExpressionStmtSyntax: SyntaxExpressibleByStringInterpolation {}

extension RepeatWhileStmtSyntax: SyntaxExpressibleByStringInterpolation {}

extension GuardStmtSyntax: SyntaxExpressibleByStringInterpolation {}

extension ForInStmtSyntax: SyntaxExpressibleByStringInterpolation {}

extension SwitchStmtSyntax: SyntaxExpressibleByStringInterpolation {}

extension DoStmtSyntax: SyntaxExpressibleByStringInterpolation {}

extension ReturnStmtSyntax: SyntaxExpressibleByStringInterpolation {}

extension YieldStmtSyntax: SyntaxExpressibleByStringInterpolation {}

extension FallthroughStmtSyntax: SyntaxExpressibleByStringInterpolation {}

extension BreakStmtSyntax: SyntaxExpressibleByStringInterpolation {}

extension DeclarationStmtSyntax: SyntaxExpressibleByStringInterpolation {}

extension ThrowStmtSyntax: SyntaxExpressibleByStringInterpolation {}

extension IfStmtSyntax: SyntaxExpressibleByStringInterpolation {}

extension SwitchCaseSyntax: SyntaxExpressibleByStringInterpolation {
  public static func parse(from parser: inout Parser) -> Self {
    return parser.parseSwitchCase().syntax
  }
}

extension CatchClauseSyntax: SyntaxExpressibleByStringInterpolation {
  public static func parse(from parser: inout Parser) -> Self {
    return parser.parseCatchClause().syntax
  }
}

extension PoundAssertStmtSyntax: SyntaxExpressibleByStringInterpolation {}

extension SimpleTypeIdentifierSyntax: SyntaxExpressibleByStringInterpolation {}

extension MemberTypeIdentifierSyntax: SyntaxExpressibleByStringInterpolation {}

extension ClassRestrictionTypeSyntax: SyntaxExpressibleByStringInterpolation {}

extension ArrayTypeSyntax: SyntaxExpressibleByStringInterpolation {}

extension DictionaryTypeSyntax: SyntaxExpressibleByStringInterpolation {}

extension MetatypeTypeSyntax: SyntaxExpressibleByStringInterpolation {}

extension OptionalTypeSyntax: SyntaxExpressibleByStringInterpolation {}

extension ConstrainedSugarTypeSyntax: SyntaxExpressibleByStringInterpolation {}

extension ImplicitlyUnwrappedOptionalTypeSyntax: SyntaxExpressibleByStringInterpolation {}

extension CompositionTypeSyntax: SyntaxExpressibleByStringInterpolation {}

extension PackExpansionTypeSyntax: SyntaxExpressibleByStringInterpolation {}

extension TupleTypeSyntax: SyntaxExpressibleByStringInterpolation {}

extension FunctionTypeSyntax: SyntaxExpressibleByStringInterpolation {}

extension AttributedTypeSyntax: SyntaxExpressibleByStringInterpolation {}

extension NamedOpaqueReturnTypeSyntax: SyntaxExpressibleByStringInterpolation {}

extension EnumCasePatternSyntax: SyntaxExpressibleByStringInterpolation {}

extension IsTypePatternSyntax: SyntaxExpressibleByStringInterpolation {}

extension OptionalPatternSyntax: SyntaxExpressibleByStringInterpolation {}

extension IdentifierPatternSyntax: SyntaxExpressibleByStringInterpolation {}

extension AsTypePatternSyntax: SyntaxExpressibleByStringInterpolation {}

extension TuplePatternSyntax: SyntaxExpressibleByStringInterpolation {}

extension WildcardPatternSyntax: SyntaxExpressibleByStringInterpolation {}

extension ExpressionPatternSyntax: SyntaxExpressibleByStringInterpolation {}

extension ValueBindingPatternSyntax: SyntaxExpressibleByStringInterpolation {}

