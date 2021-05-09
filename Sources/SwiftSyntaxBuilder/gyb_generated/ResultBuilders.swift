//// Automatically Generated From ResultBuilders.swift.gyb.
//// Do Not Edit Directly!
//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2021 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

@resultBuilder
public struct CodeBlockItemListBuilder {
  public static func buildBlock(_ elements: CodeBlockItem...) -> CodeBlockItemList {
    CodeBlockItemList(elements)
  }
}

extension CodeBlockItemList {
  public static let empty: CodeBlockItemList = CodeBlockItemList([])
}

@resultBuilder
public struct TupleExprElementListBuilder {
  public static func buildBlock(_ elements: TupleExprElement...) -> TupleExprElementList {
    TupleExprElementList(elements)
  }
}

extension TupleExprElementList {
  public static let empty: TupleExprElementList = TupleExprElementList([])
}

@resultBuilder
public struct ArrayElementListBuilder {
  public static func buildBlock(_ elements: ArrayElement...) -> ArrayElementList {
    ArrayElementList(elements)
  }
}

extension ArrayElementList {
  public static let empty: ArrayElementList = ArrayElementList([])
}

@resultBuilder
public struct DictionaryElementListBuilder {
  public static func buildBlock(_ elements: DictionaryElement...) -> DictionaryElementList {
    DictionaryElementList(elements)
  }
}

extension DictionaryElementList {
  public static let empty: DictionaryElementList = DictionaryElementList([])
}

@resultBuilder
public struct StringLiteralSegmentsBuilder {
  public static func buildBlock(_ elements: SyntaxBuildable...) -> StringLiteralSegments {
    StringLiteralSegments(elements)
  }
}

extension StringLiteralSegments {
  public static let empty: StringLiteralSegments = StringLiteralSegments([])
}

@resultBuilder
public struct DeclNameArgumentListBuilder {
  public static func buildBlock(_ elements: DeclNameArgument...) -> DeclNameArgumentList {
    DeclNameArgumentList(elements)
  }
}

extension DeclNameArgumentList {
  public static let empty: DeclNameArgumentList = DeclNameArgumentList([])
}

@resultBuilder
public struct ExprListBuilder {
  public static func buildBlock(_ elements: ExprBuildable...) -> ExprList {
    ExprList(elements)
  }
}

extension ExprList {
  public static let empty: ExprList = ExprList([])
}

@resultBuilder
public struct ClosureCaptureItemListBuilder {
  public static func buildBlock(_ elements: ClosureCaptureItem...) -> ClosureCaptureItemList {
    ClosureCaptureItemList(elements)
  }
}

extension ClosureCaptureItemList {
  public static let empty: ClosureCaptureItemList = ClosureCaptureItemList([])
}

@resultBuilder
public struct ClosureParamListBuilder {
  public static func buildBlock(_ elements: ClosureParam...) -> ClosureParamList {
    ClosureParamList(elements)
  }
}

extension ClosureParamList {
  public static let empty: ClosureParamList = ClosureParamList([])
}

@resultBuilder
public struct MultipleTrailingClosureElementListBuilder {
  public static func buildBlock(_ elements: MultipleTrailingClosureElement...) -> MultipleTrailingClosureElementList {
    MultipleTrailingClosureElementList(elements)
  }
}

extension MultipleTrailingClosureElementList {
  public static let empty: MultipleTrailingClosureElementList = MultipleTrailingClosureElementList([])
}

@resultBuilder
public struct ObjcNameBuilder {
  public static func buildBlock(_ elements: ObjcNamePiece...) -> ObjcName {
    ObjcName(elements)
  }
}

extension ObjcName {
  public static let empty: ObjcName = ObjcName([])
}

@resultBuilder
public struct FunctionParameterListBuilder {
  public static func buildBlock(_ elements: FunctionParameter...) -> FunctionParameterList {
    FunctionParameterList(elements)
  }
}

extension FunctionParameterList {
  public static let empty: FunctionParameterList = FunctionParameterList([])
}

@resultBuilder
public struct IfConfigClauseListBuilder {
  public static func buildBlock(_ elements: IfConfigClause...) -> IfConfigClauseList {
    IfConfigClauseList(elements)
  }
}

extension IfConfigClauseList {
  public static let empty: IfConfigClauseList = IfConfigClauseList([])
}

@resultBuilder
public struct InheritedTypeListBuilder {
  public static func buildBlock(_ elements: InheritedType...) -> InheritedTypeList {
    InheritedTypeList(elements)
  }
}

extension InheritedTypeList {
  public static let empty: InheritedTypeList = InheritedTypeList([])
}

@resultBuilder
public struct MemberDeclListBuilder {
  public static func buildBlock(_ elements: MemberDeclListItem...) -> MemberDeclList {
    MemberDeclList(elements)
  }
}

extension MemberDeclList {
  public static let empty: MemberDeclList = MemberDeclList([])
}

@resultBuilder
public struct ModifierListBuilder {
  public static func buildBlock(_ elements: DeclModifier...) -> ModifierList {
    ModifierList(elements)
  }
}

extension ModifierList {
  public static let empty: ModifierList = ModifierList([])
}

@resultBuilder
public struct AccessPathBuilder {
  public static func buildBlock(_ elements: AccessPathComponent...) -> AccessPath {
    AccessPath(elements)
  }
}

extension AccessPath {
  public static let empty: AccessPath = AccessPath([])
}

@resultBuilder
public struct AccessorListBuilder {
  public static func buildBlock(_ elements: AccessorDecl...) -> AccessorList {
    AccessorList(elements)
  }
}

extension AccessorList {
  public static let empty: AccessorList = AccessorList([])
}

@resultBuilder
public struct PatternBindingListBuilder {
  public static func buildBlock(_ elements: PatternBinding...) -> PatternBindingList {
    PatternBindingList(elements)
  }
}

extension PatternBindingList {
  public static let empty: PatternBindingList = PatternBindingList([])
}

@resultBuilder
public struct EnumCaseElementListBuilder {
  public static func buildBlock(_ elements: EnumCaseElement...) -> EnumCaseElementList {
    EnumCaseElementList(elements)
  }
}

extension EnumCaseElementList {
  public static let empty: EnumCaseElementList = EnumCaseElementList([])
}

@resultBuilder
public struct IdentifierListBuilder {
  public static func buildBlock(_ elements: TokenSyntax...) -> IdentifierList {
    IdentifierList(elements)
  }
}

extension IdentifierList {
  public static let empty: IdentifierList = IdentifierList([])
}

@resultBuilder
public struct PrecedenceGroupAttributeListBuilder {
  public static func buildBlock(_ elements: SyntaxBuildable...) -> PrecedenceGroupAttributeList {
    PrecedenceGroupAttributeList(elements)
  }
}

extension PrecedenceGroupAttributeList {
  public static let empty: PrecedenceGroupAttributeList = PrecedenceGroupAttributeList([])
}

@resultBuilder
public struct PrecedenceGroupNameListBuilder {
  public static func buildBlock(_ elements: PrecedenceGroupNameElement...) -> PrecedenceGroupNameList {
    PrecedenceGroupNameList(elements)
  }
}

extension PrecedenceGroupNameList {
  public static let empty: PrecedenceGroupNameList = PrecedenceGroupNameList([])
}

@resultBuilder
public struct TokenListBuilder {
  public static func buildBlock(_ elements: TokenSyntax...) -> TokenList {
    TokenList(elements)
  }
}

extension TokenList {
  public static let empty: TokenList = TokenList([])
}

@resultBuilder
public struct NonEmptyTokenListBuilder {
  public static func buildBlock(_ elements: TokenSyntax...) -> NonEmptyTokenList {
    NonEmptyTokenList(elements)
  }
}

extension NonEmptyTokenList {
  public static let empty: NonEmptyTokenList = NonEmptyTokenList([])
}

@resultBuilder
public struct AttributeListBuilder {
  public static func buildBlock(_ elements: SyntaxBuildable...) -> AttributeList {
    AttributeList(elements)
  }
}

extension AttributeList {
  public static let empty: AttributeList = AttributeList([])
}

@resultBuilder
public struct SpecializeAttributeSpecListBuilder {
  public static func buildBlock(_ elements: SyntaxBuildable...) -> SpecializeAttributeSpecList {
    SpecializeAttributeSpecList(elements)
  }
}

extension SpecializeAttributeSpecList {
  public static let empty: SpecializeAttributeSpecList = SpecializeAttributeSpecList([])
}

@resultBuilder
public struct ObjCSelectorBuilder {
  public static func buildBlock(_ elements: ObjCSelectorPiece...) -> ObjCSelector {
    ObjCSelector(elements)
  }
}

extension ObjCSelector {
  public static let empty: ObjCSelector = ObjCSelector([])
}

@resultBuilder
public struct DifferentiabilityParamListBuilder {
  public static func buildBlock(_ elements: DifferentiabilityParam...) -> DifferentiabilityParamList {
    DifferentiabilityParamList(elements)
  }
}

extension DifferentiabilityParamList {
  public static let empty: DifferentiabilityParamList = DifferentiabilityParamList([])
}

@resultBuilder
public struct SwitchCaseListBuilder {
  public static func buildBlock(_ elements: SyntaxBuildable...) -> SwitchCaseList {
    SwitchCaseList(elements)
  }
}

extension SwitchCaseList {
  public static let empty: SwitchCaseList = SwitchCaseList([])
}

@resultBuilder
public struct CatchClauseListBuilder {
  public static func buildBlock(_ elements: CatchClause...) -> CatchClauseList {
    CatchClauseList(elements)
  }
}

extension CatchClauseList {
  public static let empty: CatchClauseList = CatchClauseList([])
}

@resultBuilder
public struct CaseItemListBuilder {
  public static func buildBlock(_ elements: CaseItem...) -> CaseItemList {
    CaseItemList(elements)
  }
}

extension CaseItemList {
  public static let empty: CaseItemList = CaseItemList([])
}

@resultBuilder
public struct CatchItemListBuilder {
  public static func buildBlock(_ elements: CatchItem...) -> CatchItemList {
    CatchItemList(elements)
  }
}

extension CatchItemList {
  public static let empty: CatchItemList = CatchItemList([])
}

@resultBuilder
public struct ConditionElementListBuilder {
  public static func buildBlock(_ elements: ConditionElement...) -> ConditionElementList {
    ConditionElementList(elements)
  }
}

extension ConditionElementList {
  public static let empty: ConditionElementList = ConditionElementList([])
}

@resultBuilder
public struct GenericRequirementListBuilder {
  public static func buildBlock(_ elements: GenericRequirement...) -> GenericRequirementList {
    GenericRequirementList(elements)
  }
}

extension GenericRequirementList {
  public static let empty: GenericRequirementList = GenericRequirementList([])
}

@resultBuilder
public struct GenericParameterListBuilder {
  public static func buildBlock(_ elements: GenericParameter...) -> GenericParameterList {
    GenericParameterList(elements)
  }
}

extension GenericParameterList {
  public static let empty: GenericParameterList = GenericParameterList([])
}

@resultBuilder
public struct CompositionTypeElementListBuilder {
  public static func buildBlock(_ elements: CompositionTypeElement...) -> CompositionTypeElementList {
    CompositionTypeElementList(elements)
  }
}

extension CompositionTypeElementList {
  public static let empty: CompositionTypeElementList = CompositionTypeElementList([])
}

@resultBuilder
public struct TupleTypeElementListBuilder {
  public static func buildBlock(_ elements: TupleTypeElement...) -> TupleTypeElementList {
    TupleTypeElementList(elements)
  }
}

extension TupleTypeElementList {
  public static let empty: TupleTypeElementList = TupleTypeElementList([])
}

@resultBuilder
public struct GenericArgumentListBuilder {
  public static func buildBlock(_ elements: GenericArgument...) -> GenericArgumentList {
    GenericArgumentList(elements)
  }
}

extension GenericArgumentList {
  public static let empty: GenericArgumentList = GenericArgumentList([])
}

@resultBuilder
public struct TuplePatternElementListBuilder {
  public static func buildBlock(_ elements: TuplePatternElement...) -> TuplePatternElementList {
    TuplePatternElementList(elements)
  }
}

extension TuplePatternElementList {
  public static let empty: TuplePatternElementList = TuplePatternElementList([])
}

@resultBuilder
public struct AvailabilitySpecListBuilder {
  public static func buildBlock(_ elements: AvailabilityArgument...) -> AvailabilitySpecList {
    AvailabilitySpecList(elements)
  }
}

extension AvailabilitySpecList {
  public static let empty: AvailabilitySpecList = AvailabilitySpecList([])
}

