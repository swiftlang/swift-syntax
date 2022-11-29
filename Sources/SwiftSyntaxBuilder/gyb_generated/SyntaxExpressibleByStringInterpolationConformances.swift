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

import SwiftSyntax
import SwiftParser
import SwiftParserDiagnostics

extension SyntaxParseable {
  public init(stringInterpolationOrThrow stringInterpolation: SyntaxStringInterpolation) throws {
    self = try performParse(source: stringInterpolation.sourceText, parse: { parser in
      return Self.parse(from: &parser)
    })
  }
}

extension DeclSyntaxProtocol {
  public init(stringInterpolationOrThrow stringInterpolation: SyntaxStringInterpolation) throws {
    self = try performParse(source: stringInterpolation.sourceText, parse: { parser in
      let node = DeclSyntax.parse(from: &parser)
      guard let result = node.as(Self.self) else {
        throw SyntaxStringInterpolationError.producedInvalidNodeType(expectedType: Self.self, actualType: node.kind.syntaxNodeType)
      }
      return result
    })
  }
}
extension DeclSyntax: SyntaxExpressibleByStringInterpolation {
  public init(stringInterpolationOrThrow stringInterpolation: SyntaxStringInterpolation) throws {
    self = try performParse(source: stringInterpolation.sourceText, parse: { parser in
      return Self.parse(from: &parser)
    })
  }
}

extension ExprSyntaxProtocol {
  public init(stringInterpolationOrThrow stringInterpolation: SyntaxStringInterpolation) throws {
    self = try performParse(source: stringInterpolation.sourceText, parse: { parser in
      let node = ExprSyntax.parse(from: &parser)
      guard let result = node.as(Self.self) else {
        throw SyntaxStringInterpolationError.producedInvalidNodeType(expectedType: Self.self, actualType: node.kind.syntaxNodeType)
      }
      return result
    })
  }
}
extension ExprSyntax: SyntaxExpressibleByStringInterpolation {
  public init(stringInterpolationOrThrow stringInterpolation: SyntaxStringInterpolation) throws {
    self = try performParse(source: stringInterpolation.sourceText, parse: { parser in
      return Self.parse(from: &parser)
    })
  }
}

extension StmtSyntaxProtocol {
  public init(stringInterpolationOrThrow stringInterpolation: SyntaxStringInterpolation) throws {
    self = try performParse(source: stringInterpolation.sourceText, parse: { parser in
      let node = StmtSyntax.parse(from: &parser)
      guard let result = node.as(Self.self) else {
        throw SyntaxStringInterpolationError.producedInvalidNodeType(expectedType: Self.self, actualType: node.kind.syntaxNodeType)
      }
      return result
    })
  }
}
extension StmtSyntax: SyntaxExpressibleByStringInterpolation {
  public init(stringInterpolationOrThrow stringInterpolation: SyntaxStringInterpolation) throws {
    self = try performParse(source: stringInterpolation.sourceText, parse: { parser in
      return Self.parse(from: &parser)
    })
  }
}

extension TypeSyntaxProtocol {
  public init(stringInterpolationOrThrow stringInterpolation: SyntaxStringInterpolation) throws {
    self = try performParse(source: stringInterpolation.sourceText, parse: { parser in
      let node = TypeSyntax.parse(from: &parser)
      guard let result = node.as(Self.self) else {
        throw SyntaxStringInterpolationError.producedInvalidNodeType(expectedType: Self.self, actualType: node.kind.syntaxNodeType)
      }
      return result
    })
  }
}
extension TypeSyntax: SyntaxExpressibleByStringInterpolation {
  public init(stringInterpolationOrThrow stringInterpolation: SyntaxStringInterpolation) throws {
    self = try performParse(source: stringInterpolation.sourceText, parse: { parser in
      return Self.parse(from: &parser)
    })
  }
}

extension PatternSyntaxProtocol {
  public init(stringInterpolationOrThrow stringInterpolation: SyntaxStringInterpolation) throws {
    self = try performParse(source: stringInterpolation.sourceText, parse: { parser in
      let node = PatternSyntax.parse(from: &parser)
      guard let result = node.as(Self.self) else {
        throw SyntaxStringInterpolationError.producedInvalidNodeType(expectedType: Self.self, actualType: node.kind.syntaxNodeType)
      }
      return result
    })
  }
}
extension PatternSyntax: SyntaxExpressibleByStringInterpolation {
  public init(stringInterpolationOrThrow stringInterpolation: SyntaxStringInterpolation) throws {
    self = try performParse(source: stringInterpolation.sourceText, parse: { parser in
      return Self.parse(from: &parser)
    })
  }
}

extension UnknownDeclSyntax: SyntaxExpressibleByStringInterpolation { }

extension UnknownExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension UnknownStmtSyntax: SyntaxExpressibleByStringInterpolation { }

extension UnknownTypeSyntax: SyntaxExpressibleByStringInterpolation { }

extension UnknownPatternSyntax: SyntaxExpressibleByStringInterpolation { }

extension MissingDeclSyntax: SyntaxExpressibleByStringInterpolation { }

extension MissingExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension MissingStmtSyntax: SyntaxExpressibleByStringInterpolation { }

extension MissingTypeSyntax: SyntaxExpressibleByStringInterpolation { }

extension MissingPatternSyntax: SyntaxExpressibleByStringInterpolation { }

extension InOutExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension PoundColumnExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension TryExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension AwaitExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension MoveExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension IdentifierExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension SuperRefExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension NilLiteralExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension DiscardAssignmentExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension AssignmentExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension SequenceExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension PoundLineExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension PoundFileExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension PoundFileIDExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension PoundFilePathExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension PoundFunctionExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension PoundDsohandleExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension SymbolicReferenceExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension PrefixOperatorExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension BinaryOperatorExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension ArrowExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension InfixOperatorExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension FloatLiteralExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension TupleExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension ArrayExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension DictionaryExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension IntegerLiteralExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension BooleanLiteralExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension UnresolvedTernaryExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension TernaryExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension MemberAccessExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension UnresolvedIsExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension IsExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension UnresolvedAsExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension AsExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension TypeExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension ClosureExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension UnresolvedPatternExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension FunctionCallExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension SubscriptExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension OptionalChainingExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension ForcedValueExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension PostfixUnaryExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension SpecializeExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension StringLiteralExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension RegexLiteralExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension KeyPathExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension OldKeyPathExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension KeyPathBaseExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension ObjcKeyPathExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension ObjcSelectorExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension MacroExpansionExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension PostfixIfConfigExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension EditorPlaceholderExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension ObjectLiteralExprSyntax: SyntaxExpressibleByStringInterpolation { }

extension TypealiasDeclSyntax: SyntaxExpressibleByStringInterpolation { }

extension AssociatedtypeDeclSyntax: SyntaxExpressibleByStringInterpolation { }

extension IfConfigDeclSyntax: SyntaxExpressibleByStringInterpolation { }

extension PoundErrorDeclSyntax: SyntaxExpressibleByStringInterpolation { }

extension PoundWarningDeclSyntax: SyntaxExpressibleByStringInterpolation { }

extension PoundSourceLocationSyntax: SyntaxExpressibleByStringInterpolation { }

extension ClassDeclSyntax: SyntaxExpressibleByStringInterpolation { }

extension ActorDeclSyntax: SyntaxExpressibleByStringInterpolation { }

extension StructDeclSyntax: SyntaxExpressibleByStringInterpolation { }

extension ProtocolDeclSyntax: SyntaxExpressibleByStringInterpolation { }

extension ExtensionDeclSyntax: SyntaxExpressibleByStringInterpolation { }

extension MemberDeclBlockSyntax: SyntaxExpressibleByStringInterpolation { }

extension SourceFileSyntax: SyntaxExpressibleByStringInterpolation { }

extension FunctionDeclSyntax: SyntaxExpressibleByStringInterpolation { }

extension InitializerDeclSyntax: SyntaxExpressibleByStringInterpolation { }

extension DeinitializerDeclSyntax: SyntaxExpressibleByStringInterpolation { }

extension SubscriptDeclSyntax: SyntaxExpressibleByStringInterpolation { }

extension ImportDeclSyntax: SyntaxExpressibleByStringInterpolation { }

extension AccessorDeclSyntax: SyntaxExpressibleByStringInterpolation { }

extension VariableDeclSyntax: SyntaxExpressibleByStringInterpolation { }

extension EnumCaseDeclSyntax: SyntaxExpressibleByStringInterpolation { }

extension EnumDeclSyntax: SyntaxExpressibleByStringInterpolation { }

extension OperatorDeclSyntax: SyntaxExpressibleByStringInterpolation { }

extension PrecedenceGroupDeclSyntax: SyntaxExpressibleByStringInterpolation { }

extension MacroDeclSyntax: SyntaxExpressibleByStringInterpolation { }

extension MacroExpansionDeclSyntax: SyntaxExpressibleByStringInterpolation { }

extension LabeledStmtSyntax: SyntaxExpressibleByStringInterpolation { }

extension ContinueStmtSyntax: SyntaxExpressibleByStringInterpolation { }

extension WhileStmtSyntax: SyntaxExpressibleByStringInterpolation { }

extension DeferStmtSyntax: SyntaxExpressibleByStringInterpolation { }

extension ExpressionStmtSyntax: SyntaxExpressibleByStringInterpolation { }

extension RepeatWhileStmtSyntax: SyntaxExpressibleByStringInterpolation { }

extension GuardStmtSyntax: SyntaxExpressibleByStringInterpolation { }

extension ForInStmtSyntax: SyntaxExpressibleByStringInterpolation { }

extension SwitchStmtSyntax: SyntaxExpressibleByStringInterpolation { }

extension DoStmtSyntax: SyntaxExpressibleByStringInterpolation { }

extension ReturnStmtSyntax: SyntaxExpressibleByStringInterpolation { }

extension YieldStmtSyntax: SyntaxExpressibleByStringInterpolation { }

extension FallthroughStmtSyntax: SyntaxExpressibleByStringInterpolation { }

extension BreakStmtSyntax: SyntaxExpressibleByStringInterpolation { }

extension DeclarationStmtSyntax: SyntaxExpressibleByStringInterpolation { }

extension ThrowStmtSyntax: SyntaxExpressibleByStringInterpolation { }

extension IfStmtSyntax: SyntaxExpressibleByStringInterpolation { }

extension SwitchCaseSyntax: SyntaxExpressibleByStringInterpolation { }

extension CatchClauseSyntax: SyntaxExpressibleByStringInterpolation { }

extension PoundAssertStmtSyntax: SyntaxExpressibleByStringInterpolation { }

extension GenericParameterClauseSyntax: SyntaxExpressibleByStringInterpolation { }

extension SimpleTypeIdentifierSyntax: SyntaxExpressibleByStringInterpolation { }

extension MemberTypeIdentifierSyntax: SyntaxExpressibleByStringInterpolation { }

extension ClassRestrictionTypeSyntax: SyntaxExpressibleByStringInterpolation { }

extension ArrayTypeSyntax: SyntaxExpressibleByStringInterpolation { }

extension DictionaryTypeSyntax: SyntaxExpressibleByStringInterpolation { }

extension MetatypeTypeSyntax: SyntaxExpressibleByStringInterpolation { }

extension OptionalTypeSyntax: SyntaxExpressibleByStringInterpolation { }

extension ConstrainedSugarTypeSyntax: SyntaxExpressibleByStringInterpolation { }

extension ImplicitlyUnwrappedOptionalTypeSyntax: SyntaxExpressibleByStringInterpolation { }

extension CompositionTypeSyntax: SyntaxExpressibleByStringInterpolation { }

extension PackExpansionTypeSyntax: SyntaxExpressibleByStringInterpolation { }

extension TupleTypeSyntax: SyntaxExpressibleByStringInterpolation { }

extension FunctionTypeSyntax: SyntaxExpressibleByStringInterpolation { }

extension AttributedTypeSyntax: SyntaxExpressibleByStringInterpolation { }

extension NamedOpaqueReturnTypeSyntax: SyntaxExpressibleByStringInterpolation { }

extension EnumCasePatternSyntax: SyntaxExpressibleByStringInterpolation { }

extension IsTypePatternSyntax: SyntaxExpressibleByStringInterpolation { }

extension OptionalPatternSyntax: SyntaxExpressibleByStringInterpolation { }

extension IdentifierPatternSyntax: SyntaxExpressibleByStringInterpolation { }

extension AsTypePatternSyntax: SyntaxExpressibleByStringInterpolation { }

extension TuplePatternSyntax: SyntaxExpressibleByStringInterpolation { }

extension WildcardPatternSyntax: SyntaxExpressibleByStringInterpolation { }

extension ExpressionPatternSyntax: SyntaxExpressibleByStringInterpolation { }

extension ValueBindingPatternSyntax: SyntaxExpressibleByStringInterpolation { }


// TODO: This should be fileprivate, but is currently used in
// `ConvenienceInitializers.swift`. See the corresponding TODO there.
func performParse<SyntaxType: SyntaxProtocol>(source: [UInt8], parse: (inout Parser) throws -> SyntaxType) throws -> SyntaxType {
  return try source.withUnsafeBufferPointer { buffer in
    var parser = Parser(buffer)
    // FIXME: When the parser supports incremental parsing, put the
    // interpolatedSyntaxNodes in so we don't have to parse them again.
    let result = try parse(&parser)
    if result.hasError {
      let diagnostics = ParseDiagnosticsGenerator.diagnostics(for: result)
      assert(!diagnostics.isEmpty)
      throw SyntaxStringInterpolationError.diagnostics(diagnostics, tree: Syntax(result))
    }
    return result
  }
}
