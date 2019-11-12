//// Automatically Generated From SyntaxNodes.swift.gyb.
//// Do Not Edit Directly!
//===----------- SyntaxTraits.swift - Traits for syntax nodes -------------===//
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

// MARK: - DeclGroupSyntax

public protocol DeclGroupSyntax: SyntaxProtocol {
  var attributes: AttributeListSyntax? { get }
  func withAttributes(_ newChild: AttributeListSyntax?) -> Self
  var modifiers: ModifierListSyntax? { get }
  func withModifiers(_ newChild: ModifierListSyntax?) -> Self
  var members: MemberDeclBlockSyntax { get }
  func withMembers(_ newChild: MemberDeclBlockSyntax?) -> Self
}

public extension SyntaxProtocol {
  /// Check whether the non-type erased version of this syntax node conforms to 
  /// `DeclGroupSyntax`. 
  func `is`(_: DeclGroupSyntax.Protocol) -> Bool {
    return self.as(DeclGroupSyntax.self) != nil
  }

  /// Return the non-type erased version of this syntax node if it conforms to 
  /// `DeclGroupSyntax`. Otherwise return `nil`.
  func `as`(_: DeclGroupSyntax.Protocol) -> DeclGroupSyntax? {
    return Syntax(self).as(SyntaxProtocol.self) as? DeclGroupSyntax
  }
}

// MARK: - BracedSyntax

public protocol BracedSyntax: SyntaxProtocol {
  var leftBrace: TokenSyntax { get }
  func withLeftBrace(_ newChild: TokenSyntax?) -> Self
  var rightBrace: TokenSyntax { get }
  func withRightBrace(_ newChild: TokenSyntax?) -> Self
}

public extension SyntaxProtocol {
  /// Check whether the non-type erased version of this syntax node conforms to 
  /// `BracedSyntax`. 
  func `is`(_: BracedSyntax.Protocol) -> Bool {
    return self.as(BracedSyntax.self) != nil
  }

  /// Return the non-type erased version of this syntax node if it conforms to 
  /// `BracedSyntax`. Otherwise return `nil`.
  func `as`(_: BracedSyntax.Protocol) -> BracedSyntax? {
    return Syntax(self).as(SyntaxProtocol.self) as? BracedSyntax
  }
}

// MARK: - IdentifiedDeclSyntax

public protocol IdentifiedDeclSyntax: SyntaxProtocol {
  var identifier: TokenSyntax { get }
  func withIdentifier(_ newChild: TokenSyntax?) -> Self
}

public extension SyntaxProtocol {
  /// Check whether the non-type erased version of this syntax node conforms to 
  /// `IdentifiedDeclSyntax`. 
  func `is`(_: IdentifiedDeclSyntax.Protocol) -> Bool {
    return self.as(IdentifiedDeclSyntax.self) != nil
  }

  /// Return the non-type erased version of this syntax node if it conforms to 
  /// `IdentifiedDeclSyntax`. Otherwise return `nil`.
  func `as`(_: IdentifiedDeclSyntax.Protocol) -> IdentifiedDeclSyntax? {
    return Syntax(self).as(SyntaxProtocol.self) as? IdentifiedDeclSyntax
  }
}

// MARK: - WithCodeBlockSyntax

public protocol WithCodeBlockSyntax: SyntaxProtocol {
  var body: CodeBlockSyntax { get }
  func withBody(_ newChild: CodeBlockSyntax?) -> Self
}

public extension SyntaxProtocol {
  /// Check whether the non-type erased version of this syntax node conforms to 
  /// `WithCodeBlockSyntax`. 
  func `is`(_: WithCodeBlockSyntax.Protocol) -> Bool {
    return self.as(WithCodeBlockSyntax.self) != nil
  }

  /// Return the non-type erased version of this syntax node if it conforms to 
  /// `WithCodeBlockSyntax`. Otherwise return `nil`.
  func `as`(_: WithCodeBlockSyntax.Protocol) -> WithCodeBlockSyntax? {
    return Syntax(self).as(SyntaxProtocol.self) as? WithCodeBlockSyntax
  }
}

// MARK: - ParenthesizedSyntax

public protocol ParenthesizedSyntax: SyntaxProtocol {
  var leftParen: TokenSyntax { get }
  func withLeftParen(_ newChild: TokenSyntax?) -> Self
  var rightParen: TokenSyntax { get }
  func withRightParen(_ newChild: TokenSyntax?) -> Self
}

public extension SyntaxProtocol {
  /// Check whether the non-type erased version of this syntax node conforms to 
  /// `ParenthesizedSyntax`. 
  func `is`(_: ParenthesizedSyntax.Protocol) -> Bool {
    return self.as(ParenthesizedSyntax.self) != nil
  }

  /// Return the non-type erased version of this syntax node if it conforms to 
  /// `ParenthesizedSyntax`. Otherwise return `nil`.
  func `as`(_: ParenthesizedSyntax.Protocol) -> ParenthesizedSyntax? {
    return Syntax(self).as(SyntaxProtocol.self) as? ParenthesizedSyntax
  }
}

// MARK: - WithTrailingCommaSyntax

public protocol WithTrailingCommaSyntax: SyntaxProtocol {
  var trailingComma: TokenSyntax? { get }
  func withTrailingComma(_ newChild: TokenSyntax?) -> Self
}

public extension SyntaxProtocol {
  /// Check whether the non-type erased version of this syntax node conforms to 
  /// `WithTrailingCommaSyntax`. 
  func `is`(_: WithTrailingCommaSyntax.Protocol) -> Bool {
    return self.as(WithTrailingCommaSyntax.self) != nil
  }

  /// Return the non-type erased version of this syntax node if it conforms to 
  /// `WithTrailingCommaSyntax`. Otherwise return `nil`.
  func `as`(_: WithTrailingCommaSyntax.Protocol) -> WithTrailingCommaSyntax? {
    return Syntax(self).as(SyntaxProtocol.self) as? WithTrailingCommaSyntax
  }
}

// MARK: - LabeledSyntax

public protocol LabeledSyntax: SyntaxProtocol {
  var labelName: TokenSyntax? { get }
  func withLabelName(_ newChild: TokenSyntax?) -> Self
  var labelColon: TokenSyntax? { get }
  func withLabelColon(_ newChild: TokenSyntax?) -> Self
}

public extension SyntaxProtocol {
  /// Check whether the non-type erased version of this syntax node conforms to 
  /// `LabeledSyntax`. 
  func `is`(_: LabeledSyntax.Protocol) -> Bool {
    return self.as(LabeledSyntax.self) != nil
  }

  /// Return the non-type erased version of this syntax node if it conforms to 
  /// `LabeledSyntax`. Otherwise return `nil`.
  func `as`(_: LabeledSyntax.Protocol) -> LabeledSyntax? {
    return Syntax(self).as(SyntaxProtocol.self) as? LabeledSyntax
  }
}

// MARK: - WithStatementsSyntax

public protocol WithStatementsSyntax: SyntaxProtocol {
  var statements: CodeBlockItemListSyntax { get }
  func withStatements(_ newChild: CodeBlockItemListSyntax?) -> Self
}

public extension SyntaxProtocol {
  /// Check whether the non-type erased version of this syntax node conforms to 
  /// `WithStatementsSyntax`. 
  func `is`(_: WithStatementsSyntax.Protocol) -> Bool {
    return self.as(WithStatementsSyntax.self) != nil
  }

  /// Return the non-type erased version of this syntax node if it conforms to 
  /// `WithStatementsSyntax`. Otherwise return `nil`.
  func `as`(_: WithStatementsSyntax.Protocol) -> WithStatementsSyntax? {
    return Syntax(self).as(SyntaxProtocol.self) as? WithStatementsSyntax
  }
}


extension CodeBlockSyntax: BracedSyntax, WithStatementsSyntax {}
extension DeclNameArgumentsSyntax: ParenthesizedSyntax {}
extension TupleExprSyntax: ParenthesizedSyntax {}
extension TupleExprElementSyntax: WithTrailingCommaSyntax {}
extension ArrayElementSyntax: WithTrailingCommaSyntax {}
extension DictionaryElementSyntax: WithTrailingCommaSyntax {}
extension ClosureCaptureItemSyntax: WithTrailingCommaSyntax {}
extension ClosureParamSyntax: WithTrailingCommaSyntax {}
extension ClosureExprSyntax: BracedSyntax, WithStatementsSyntax {}
extension ExpressionSegmentSyntax: ParenthesizedSyntax {}
extension ObjcKeyPathExprSyntax: ParenthesizedSyntax {}
extension ObjcSelectorExprSyntax: ParenthesizedSyntax {}
extension ObjectLiteralExprSyntax: ParenthesizedSyntax {}
extension TypealiasDeclSyntax: IdentifiedDeclSyntax {}
extension AssociatedtypeDeclSyntax: IdentifiedDeclSyntax {}
extension ParameterClauseSyntax: ParenthesizedSyntax {}
extension PoundErrorDeclSyntax: ParenthesizedSyntax {}
extension PoundWarningDeclSyntax: ParenthesizedSyntax {}
extension PoundSourceLocationSyntax: ParenthesizedSyntax {}
extension InheritedTypeSyntax: WithTrailingCommaSyntax {}
extension ClassDeclSyntax: DeclGroupSyntax, IdentifiedDeclSyntax {}
extension StructDeclSyntax: DeclGroupSyntax, IdentifiedDeclSyntax {}
extension ProtocolDeclSyntax: DeclGroupSyntax, IdentifiedDeclSyntax {}
extension ExtensionDeclSyntax: DeclGroupSyntax {}
extension MemberDeclBlockSyntax: BracedSyntax {}
extension SourceFileSyntax: WithStatementsSyntax {}
extension FunctionParameterSyntax: WithTrailingCommaSyntax {}
extension FunctionDeclSyntax: IdentifiedDeclSyntax {}
extension AccessorParameterSyntax: ParenthesizedSyntax {}
extension AccessorBlockSyntax: BracedSyntax {}
extension PatternBindingSyntax: WithTrailingCommaSyntax {}
extension EnumCaseElementSyntax: WithTrailingCommaSyntax {}
extension EnumDeclSyntax: IdentifiedDeclSyntax {}
extension OperatorDeclSyntax: IdentifiedDeclSyntax {}
extension PrecedenceGroupDeclSyntax: IdentifiedDeclSyntax {}
extension LabeledSpecializeEntrySyntax: WithTrailingCommaSyntax {}
extension DifferentiationParamSyntax: WithTrailingCommaSyntax {}
extension DifferentiableAttributeFuncSpecifierSyntax: WithTrailingCommaSyntax {}
extension WhileStmtSyntax: WithCodeBlockSyntax, LabeledSyntax {}
extension DeferStmtSyntax: WithCodeBlockSyntax {}
extension RepeatWhileStmtSyntax: WithCodeBlockSyntax, LabeledSyntax {}
extension GuardStmtSyntax: WithCodeBlockSyntax {}
extension ForInStmtSyntax: WithCodeBlockSyntax, LabeledSyntax {}
extension SwitchStmtSyntax: BracedSyntax, LabeledSyntax {}
extension DoStmtSyntax: WithCodeBlockSyntax, LabeledSyntax {}
extension ConditionElementSyntax: WithTrailingCommaSyntax {}
extension IfStmtSyntax: WithCodeBlockSyntax, LabeledSyntax {}
extension ElseBlockSyntax: WithCodeBlockSyntax {}
extension SwitchCaseSyntax: WithStatementsSyntax {}
extension CaseItemSyntax: WithTrailingCommaSyntax {}
extension GenericRequirementSyntax: WithTrailingCommaSyntax {}
extension GenericParameterSyntax: WithTrailingCommaSyntax {}
extension TupleTypeElementSyntax: WithTrailingCommaSyntax {}
extension TupleTypeSyntax: ParenthesizedSyntax {}
extension FunctionTypeSyntax: ParenthesizedSyntax {}
extension GenericArgumentSyntax: WithTrailingCommaSyntax {}
extension TuplePatternSyntax: ParenthesizedSyntax {}
extension TuplePatternElementSyntax: WithTrailingCommaSyntax, LabeledSyntax {}
