//// Automatically Generated From DeclBuildables.swift.gyb.
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

extension CodeBlock {
  public init(
    leftBrace: TokenSyntax = Tokens.`leftBrace`,
    @CodeBlockItemListBuilder statementsBuilder: () -> CodeBlockItemList = { .empty },
    rightBrace: TokenSyntax = Tokens.`rightBrace`
  ) {
    self.init(
      leftBrace: leftBrace,
      statements: statementsBuilder(),
      rightBrace: rightBrace
    )
  }
}

extension DeclNameArguments {
  public init(
    leftParen: TokenSyntax = Tokens.`leftParen`,
    @DeclNameArgumentListBuilder argumentsBuilder: () -> DeclNameArgumentList = { .empty },
    rightParen: TokenSyntax = Tokens.`rightParen`
  ) {
    self.init(
      leftParen: leftParen,
      arguments: argumentsBuilder(),
      rightParen: rightParen
    )
  }
}

extension SequenceExpr {
  public init(
    @ExprListBuilder elementsBuilder: () -> ExprList = { .empty }
  ) {
    self.init(
      elements: elementsBuilder()
    )
  }
}

extension TupleExpr {
  public init(
    leftParen: TokenSyntax = Tokens.`leftParen`,
    @TupleExprElementListBuilder elementListBuilder: () -> TupleExprElementList = { .empty },
    rightParen: TokenSyntax = Tokens.`rightParen`
  ) {
    self.init(
      leftParen: leftParen,
      elementList: elementListBuilder(),
      rightParen: rightParen
    )
  }
}

extension ArrayExpr {
  public init(
    leftSquare: TokenSyntax = Tokens.`leftSquareBracket`,
    @ArrayElementListBuilder elementsBuilder: () -> ArrayElementList = { .empty },
    rightSquare: TokenSyntax = Tokens.`rightSquareBracket`
  ) {
    self.init(
      leftSquare: leftSquare,
      elements: elementsBuilder(),
      rightSquare: rightSquare
    )
  }
}

extension ClosureCaptureItem {
  public init(
    @TokenListBuilder specifierBuilder: () -> TokenList? = { nil },
    name: String?,
    assignToken: TokenSyntax? = nil,
    expression: ExprBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      specifier: specifierBuilder(),
      name: name.map({ SyntaxFactory.makeIdentifier($0) }),
      assignToken: assignToken,
      expression: expression,
      trailingComma: trailingComma
    )
  }
}

extension ClosureCaptureSignature {
  public init(
    leftSquare: TokenSyntax = Tokens.`leftSquareBracket`,
    @ClosureCaptureItemListBuilder itemsBuilder: () -> ClosureCaptureItemList? = { nil },
    rightSquare: TokenSyntax = Tokens.`rightSquareBracket`
  ) {
    self.init(
      leftSquare: leftSquare,
      items: itemsBuilder(),
      rightSquare: rightSquare
    )
  }
}

extension ClosureExpr {
  public init(
    leftBrace: TokenSyntax = Tokens.`leftBrace`,
    signature: ClosureSignature? = nil,
    @CodeBlockItemListBuilder statementsBuilder: () -> CodeBlockItemList = { .empty },
    rightBrace: TokenSyntax = Tokens.`rightBrace`
  ) {
    self.init(
      leftBrace: leftBrace,
      signature: signature,
      statements: statementsBuilder(),
      rightBrace: rightBrace
    )
  }
}

extension FunctionCallExpr {
  public init(
    calledExpression: ExprBuildable,
    leftParen: TokenSyntax? = nil,
    @TupleExprElementListBuilder argumentListBuilder: () -> TupleExprElementList = { .empty },
    rightParen: TokenSyntax? = nil,
    trailingClosure: ClosureExpr? = nil,
    @MultipleTrailingClosureElementListBuilder additionalTrailingClosuresBuilder: () -> MultipleTrailingClosureElementList? = { nil }
  ) {
    self.init(
      calledExpression: calledExpression,
      leftParen: leftParen,
      argumentList: argumentListBuilder(),
      rightParen: rightParen,
      trailingClosure: trailingClosure,
      additionalTrailingClosures: additionalTrailingClosuresBuilder()
    )
  }
}

extension SubscriptExpr {
  public init(
    calledExpression: ExprBuildable,
    leftBracket: TokenSyntax = Tokens.`leftSquareBracket`,
    @TupleExprElementListBuilder argumentListBuilder: () -> TupleExprElementList = { .empty },
    rightBracket: TokenSyntax = Tokens.`rightSquareBracket`,
    trailingClosure: ClosureExpr? = nil,
    @MultipleTrailingClosureElementListBuilder additionalTrailingClosuresBuilder: () -> MultipleTrailingClosureElementList? = { nil }
  ) {
    self.init(
      calledExpression: calledExpression,
      leftBracket: leftBracket,
      argumentList: argumentListBuilder(),
      rightBracket: rightBracket,
      trailingClosure: trailingClosure,
      additionalTrailingClosures: additionalTrailingClosuresBuilder()
    )
  }
}

extension ExpressionSegment {
  public init(
    backslash: TokenSyntax = Tokens.`backslash`,
    delimiter: String?,
    leftParen: TokenSyntax = Tokens.`leftParen`,
    @TupleExprElementListBuilder expressionsBuilder: () -> TupleExprElementList = { .empty },
    rightParen: TokenSyntax = Tokens.`stringInterpolationAnchor`
  ) {
    self.init(
      backslash: backslash,
      delimiter: delimiter.map(Tokens.rawStringDelimiter),
      leftParen: leftParen,
      expressions: expressionsBuilder(),
      rightParen: rightParen
    )
  }
}

extension StringLiteralExpr {
  public init(
    openDelimiter: String?,
    openQuote: TokenSyntax,
    @StringLiteralSegmentsBuilder segmentsBuilder: () -> StringLiteralSegments = { .empty },
    closeQuote: TokenSyntax,
    closeDelimiter: String?
  ) {
    self.init(
      openDelimiter: openDelimiter.map(Tokens.rawStringDelimiter),
      openQuote: openQuote,
      segments: segmentsBuilder(),
      closeQuote: closeQuote,
      closeDelimiter: closeDelimiter.map(Tokens.rawStringDelimiter)
    )
  }
}

extension ObjcKeyPathExpr {
  public init(
    keyPath: TokenSyntax = Tokens.`poundKeyPath`,
    leftParen: TokenSyntax = Tokens.`leftParen`,
    @ObjcNameBuilder nameBuilder: () -> ObjcName = { .empty },
    rightParen: TokenSyntax = Tokens.`rightParen`
  ) {
    self.init(
      keyPath: keyPath,
      leftParen: leftParen,
      name: nameBuilder(),
      rightParen: rightParen
    )
  }
}

extension ObjectLiteralExpr {
  public init(
    identifier: TokenSyntax,
    leftParen: TokenSyntax = Tokens.`leftParen`,
    @TupleExprElementListBuilder argumentsBuilder: () -> TupleExprElementList = { .empty },
    rightParen: TokenSyntax = Tokens.`rightParen`
  ) {
    self.init(
      identifier: identifier,
      leftParen: leftParen,
      arguments: argumentsBuilder(),
      rightParen: rightParen
    )
  }
}

extension TypealiasDecl {
  public init(
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil },
    typealiasKeyword: TokenSyntax = Tokens.`typealias`,
    identifier: String,
    genericParameterClause: GenericParameterClause? = nil,
    initializer: TypeInitializerClause? = nil,
    genericWhereClause: GenericWhereClause? = nil
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      typealiasKeyword: typealiasKeyword,
      identifier: SyntaxFactory.makeIdentifier(identifier),
      genericParameterClause: genericParameterClause,
      initializer: initializer,
      genericWhereClause: genericWhereClause
    )
  }
}

extension AssociatedtypeDecl {
  public init(
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil },
    associatedtypeKeyword: TokenSyntax = Tokens.`associatedtype`,
    identifier: String,
    inheritanceClause: TypeInheritanceClause? = nil,
    initializer: TypeInitializerClause? = nil,
    genericWhereClause: GenericWhereClause? = nil
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      associatedtypeKeyword: associatedtypeKeyword,
      identifier: SyntaxFactory.makeIdentifier(identifier),
      inheritanceClause: inheritanceClause,
      initializer: initializer,
      genericWhereClause: genericWhereClause
    )
  }
}

extension ParameterClause {
  public init(
    leftParen: TokenSyntax = Tokens.`leftParen`,
    @FunctionParameterListBuilder parameterListBuilder: () -> FunctionParameterList = { .empty },
    rightParen: TokenSyntax = Tokens.`rightParen`
  ) {
    self.init(
      leftParen: leftParen,
      parameterList: parameterListBuilder(),
      rightParen: rightParen
    )
  }
}

extension IfConfigDecl {
  public init(
    @IfConfigClauseListBuilder clausesBuilder: () -> IfConfigClauseList = { .empty },
    poundEndif: TokenSyntax = Tokens.`poundEndif`
  ) {
    self.init(
      clauses: clausesBuilder(),
      poundEndif: poundEndif
    )
  }
}

extension TypeInheritanceClause {
  public init(
    colon: TokenSyntax = Tokens.`colon`,
    @InheritedTypeListBuilder inheritedTypeCollectionBuilder: () -> InheritedTypeList = { .empty }
  ) {
    self.init(
      colon: colon,
      inheritedTypeCollection: inheritedTypeCollectionBuilder()
    )
  }
}

extension ClassDecl {
  public init(
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil },
    classOrActorKeyword: TokenSyntax,
    identifier: String,
    genericParameterClause: GenericParameterClause? = nil,
    inheritanceClause: TypeInheritanceClause? = nil,
    genericWhereClause: GenericWhereClause? = nil,
    members: MemberDeclBlock
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      classOrActorKeyword: classOrActorKeyword,
      identifier: SyntaxFactory.makeIdentifier(identifier),
      genericParameterClause: genericParameterClause,
      inheritanceClause: inheritanceClause,
      genericWhereClause: genericWhereClause,
      members: members
    )
  }
}

extension StructDecl {
  public init(
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil },
    structKeyword: TokenSyntax = Tokens.`struct`,
    identifier: String,
    genericParameterClause: GenericParameterClause? = nil,
    inheritanceClause: TypeInheritanceClause? = nil,
    genericWhereClause: GenericWhereClause? = nil,
    members: MemberDeclBlock
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      structKeyword: structKeyword,
      identifier: SyntaxFactory.makeIdentifier(identifier),
      genericParameterClause: genericParameterClause,
      inheritanceClause: inheritanceClause,
      genericWhereClause: genericWhereClause,
      members: members
    )
  }
}

extension ProtocolDecl {
  public init(
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil },
    protocolKeyword: TokenSyntax = Tokens.`protocol`,
    identifier: String,
    inheritanceClause: TypeInheritanceClause? = nil,
    genericWhereClause: GenericWhereClause? = nil,
    members: MemberDeclBlock
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      protocolKeyword: protocolKeyword,
      identifier: SyntaxFactory.makeIdentifier(identifier),
      inheritanceClause: inheritanceClause,
      genericWhereClause: genericWhereClause,
      members: members
    )
  }
}

extension ExtensionDecl {
  public init(
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil },
    extensionKeyword: TokenSyntax = Tokens.`extension`,
    extendedType: TypeBuildable,
    inheritanceClause: TypeInheritanceClause? = nil,
    genericWhereClause: GenericWhereClause? = nil,
    members: MemberDeclBlock
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      extensionKeyword: extensionKeyword,
      extendedType: extendedType,
      inheritanceClause: inheritanceClause,
      genericWhereClause: genericWhereClause,
      members: members
    )
  }
}

extension MemberDeclBlock {
  public init(
    leftBrace: TokenSyntax = Tokens.`leftBrace`,
    @MemberDeclListBuilder membersBuilder: () -> MemberDeclList = { .empty },
    rightBrace: TokenSyntax = Tokens.`rightBrace`
  ) {
    self.init(
      leftBrace: leftBrace,
      members: membersBuilder(),
      rightBrace: rightBrace
    )
  }
}

extension SourceFile {
  public init(
    @CodeBlockItemListBuilder statementsBuilder: () -> CodeBlockItemList = { .empty },
    eofToken: TokenSyntax
  ) {
    self.init(
      statements: statementsBuilder(),
      eofToken: eofToken
    )
  }
}

extension FunctionParameter {
  public init(
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    firstName: TokenSyntax? = nil,
    secondName: TokenSyntax? = nil,
    colon: TokenSyntax? = nil,
    type: TypeBuildable? = nil,
    ellipsis: TokenSyntax? = nil,
    defaultArgument: InitializerClause? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      attributes: attributesBuilder(),
      firstName: firstName,
      secondName: secondName,
      colon: colon,
      type: type,
      ellipsis: ellipsis,
      defaultArgument: defaultArgument,
      trailingComma: trailingComma
    )
  }
}

extension FunctionDecl {
  public init(
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil },
    funcKeyword: TokenSyntax = Tokens.`func`,
    identifier: TokenSyntax,
    genericParameterClause: GenericParameterClause? = nil,
    signature: FunctionSignature,
    genericWhereClause: GenericWhereClause? = nil,
    body: CodeBlock? = nil
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      funcKeyword: funcKeyword,
      identifier: identifier,
      genericParameterClause: genericParameterClause,
      signature: signature,
      genericWhereClause: genericWhereClause,
      body: body
    )
  }
}

extension InitializerDecl {
  public init(
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil },
    initKeyword: TokenSyntax = Tokens.`init`,
    optionalMark: TokenSyntax? = nil,
    genericParameterClause: GenericParameterClause? = nil,
    parameters: ParameterClause,
    throwsOrRethrowsKeyword: TokenSyntax? = nil,
    genericWhereClause: GenericWhereClause? = nil,
    body: CodeBlock? = nil
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      initKeyword: initKeyword,
      optionalMark: optionalMark,
      genericParameterClause: genericParameterClause,
      parameters: parameters,
      throwsOrRethrowsKeyword: throwsOrRethrowsKeyword,
      genericWhereClause: genericWhereClause,
      body: body
    )
  }
}

extension DeinitializerDecl {
  public init(
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil },
    deinitKeyword: TokenSyntax = Tokens.`deinit`,
    body: CodeBlock
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      deinitKeyword: deinitKeyword,
      body: body
    )
  }
}

extension SubscriptDecl {
  public init(
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil },
    subscriptKeyword: TokenSyntax = Tokens.`subscript`,
    genericParameterClause: GenericParameterClause? = nil,
    indices: ParameterClause,
    result: ReturnClause,
    genericWhereClause: GenericWhereClause? = nil,
    accessor: SyntaxBuildable? = nil
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      subscriptKeyword: subscriptKeyword,
      genericParameterClause: genericParameterClause,
      indices: indices,
      result: result,
      genericWhereClause: genericWhereClause,
      accessor: accessor
    )
  }
}

extension ImportDecl {
  public init(
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil },
    importTok: TokenSyntax = Tokens.`import`,
    importKind: TokenSyntax? = nil,
    @AccessPathBuilder pathBuilder: () -> AccessPath = { .empty }
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      importTok: importTok,
      importKind: importKind,
      path: pathBuilder()
    )
  }
}

extension AccessorDecl {
  public init(
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    modifier: DeclModifier? = nil,
    accessorKind: TokenSyntax,
    parameter: AccessorParameter? = nil,
    asyncKeyword: String?,
    throwsKeyword: TokenSyntax? = nil,
    body: CodeBlock? = nil
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifier: modifier,
      accessorKind: accessorKind,
      parameter: parameter,
      asyncKeyword: asyncKeyword.map({ SyntaxFactory.makeIdentifier($0) }),
      throwsKeyword: throwsKeyword,
      body: body
    )
  }
}

extension AccessorBlock {
  public init(
    leftBrace: TokenSyntax = Tokens.`leftBrace`,
    @AccessorListBuilder accessorsBuilder: () -> AccessorList = { .empty },
    rightBrace: TokenSyntax = Tokens.`rightBrace`
  ) {
    self.init(
      leftBrace: leftBrace,
      accessors: accessorsBuilder(),
      rightBrace: rightBrace
    )
  }
}

extension VariableDecl {
  public init(
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil },
    letOrVarKeyword: TokenSyntax,
    @PatternBindingListBuilder bindingsBuilder: () -> PatternBindingList = { .empty }
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      letOrVarKeyword: letOrVarKeyword,
      bindings: bindingsBuilder()
    )
  }
}

extension EnumCaseDecl {
  public init(
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil },
    caseKeyword: TokenSyntax = Tokens.`case`,
    @EnumCaseElementListBuilder elementsBuilder: () -> EnumCaseElementList = { .empty }
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      caseKeyword: caseKeyword,
      elements: elementsBuilder()
    )
  }
}

extension EnumDecl {
  public init(
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil },
    enumKeyword: TokenSyntax = Tokens.`enum`,
    identifier: String,
    genericParameters: GenericParameterClause? = nil,
    inheritanceClause: TypeInheritanceClause? = nil,
    genericWhereClause: GenericWhereClause? = nil,
    members: MemberDeclBlock
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      enumKeyword: enumKeyword,
      identifier: SyntaxFactory.makeIdentifier(identifier),
      genericParameters: genericParameters,
      inheritanceClause: inheritanceClause,
      genericWhereClause: genericWhereClause,
      members: members
    )
  }
}

extension OperatorDecl {
  public init(
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil },
    operatorKeyword: TokenSyntax = Tokens.`operator`,
    identifier: TokenSyntax,
    operatorPrecedenceAndTypes: OperatorPrecedenceAndTypes? = nil
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      operatorKeyword: operatorKeyword,
      identifier: identifier,
      operatorPrecedenceAndTypes: operatorPrecedenceAndTypes
    )
  }
}

extension OperatorPrecedenceAndTypes {
  public init(
    colon: TokenSyntax = Tokens.`colon`,
    @IdentifierListBuilder precedenceGroupAndDesignatedTypesBuilder: () -> IdentifierList = { .empty }
  ) {
    self.init(
      colon: colon,
      precedenceGroupAndDesignatedTypes: precedenceGroupAndDesignatedTypesBuilder()
    )
  }
}

extension PrecedenceGroupDecl {
  public init(
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil },
    precedencegroupKeyword: TokenSyntax = Tokens.`precedencegroup`,
    identifier: String,
    leftBrace: TokenSyntax = Tokens.`leftBrace`,
    @PrecedenceGroupAttributeListBuilder groupAttributesBuilder: () -> PrecedenceGroupAttributeList = { .empty },
    rightBrace: TokenSyntax = Tokens.`rightBrace`
  ) {
    self.init(
      attributes: attributesBuilder(),
      modifiers: modifiersBuilder(),
      precedencegroupKeyword: precedencegroupKeyword,
      identifier: SyntaxFactory.makeIdentifier(identifier),
      leftBrace: leftBrace,
      groupAttributes: groupAttributesBuilder(),
      rightBrace: rightBrace
    )
  }
}

extension PrecedenceGroupRelation {
  public init(
    higherThanOrLowerThan: String,
    colon: TokenSyntax = Tokens.`colon`,
    @PrecedenceGroupNameListBuilder otherNamesBuilder: () -> PrecedenceGroupNameList = { .empty }
  ) {
    self.init(
      higherThanOrLowerThan: SyntaxFactory.makeIdentifier(higherThanOrLowerThan),
      colon: colon,
      otherNames: otherNamesBuilder()
    )
  }
}

extension CustomAttribute {
  public init(
    atSignToken: TokenSyntax = Tokens.`atSign`,
    attributeName: TypeBuildable,
    leftParen: TokenSyntax? = nil,
    @TupleExprElementListBuilder argumentListBuilder: () -> TupleExprElementList? = { nil },
    rightParen: TokenSyntax? = nil
  ) {
    self.init(
      atSignToken: atSignToken,
      attributeName: attributeName,
      leftParen: leftParen,
      argumentList: argumentListBuilder(),
      rightParen: rightParen
    )
  }
}

extension Attribute {
  public init(
    atSignToken: TokenSyntax = Tokens.`atSign`,
    attributeName: TokenSyntax,
    leftParen: TokenSyntax? = nil,
    argument: SyntaxBuildable? = nil,
    rightParen: TokenSyntax? = nil,
    @TokenListBuilder tokenListBuilder: () -> TokenList? = { nil }
  ) {
    self.init(
      atSignToken: atSignToken,
      attributeName: attributeName,
      leftParen: leftParen,
      argument: argument,
      rightParen: rightParen,
      tokenList: tokenListBuilder()
    )
  }
}

extension DifferentiabilityParams {
  public init(
    leftParen: TokenSyntax = Tokens.`leftParen`,
    @DifferentiabilityParamListBuilder diffParamsBuilder: () -> DifferentiabilityParamList = { .empty },
    rightParen: TokenSyntax = Tokens.`rightParen`
  ) {
    self.init(
      leftParen: leftParen,
      diffParams: diffParamsBuilder(),
      rightParen: rightParen
    )
  }
}

extension WhileStmt {
  public init(
    labelName: String?,
    labelColon: TokenSyntax? = nil,
    whileKeyword: TokenSyntax = Tokens.`while`,
    @ConditionElementListBuilder conditionsBuilder: () -> ConditionElementList = { .empty },
    body: CodeBlock
  ) {
    self.init(
      labelName: labelName.map({ SyntaxFactory.makeIdentifier($0) }),
      labelColon: labelColon,
      whileKeyword: whileKeyword,
      conditions: conditionsBuilder(),
      body: body
    )
  }
}

extension GuardStmt {
  public init(
    guardKeyword: TokenSyntax = Tokens.`guard`,
    @ConditionElementListBuilder conditionsBuilder: () -> ConditionElementList = { .empty },
    elseKeyword: TokenSyntax = Tokens.`else`,
    body: CodeBlock
  ) {
    self.init(
      guardKeyword: guardKeyword,
      conditions: conditionsBuilder(),
      elseKeyword: elseKeyword,
      body: body
    )
  }
}

extension SwitchStmt {
  public init(
    labelName: String?,
    labelColon: TokenSyntax? = nil,
    switchKeyword: TokenSyntax = Tokens.`switch`,
    expression: ExprBuildable,
    leftBrace: TokenSyntax = Tokens.`leftBrace`,
    @SwitchCaseListBuilder casesBuilder: () -> SwitchCaseList = { .empty },
    rightBrace: TokenSyntax = Tokens.`rightBrace`
  ) {
    self.init(
      labelName: labelName.map({ SyntaxFactory.makeIdentifier($0) }),
      labelColon: labelColon,
      switchKeyword: switchKeyword,
      expression: expression,
      leftBrace: leftBrace,
      cases: casesBuilder(),
      rightBrace: rightBrace
    )
  }
}

extension DoStmt {
  public init(
    labelName: String?,
    labelColon: TokenSyntax? = nil,
    doKeyword: TokenSyntax = Tokens.`do`,
    body: CodeBlock,
    @CatchClauseListBuilder catchClausesBuilder: () -> CatchClauseList? = { nil }
  ) {
    self.init(
      labelName: labelName.map({ SyntaxFactory.makeIdentifier($0) }),
      labelColon: labelColon,
      doKeyword: doKeyword,
      body: body,
      catchClauses: catchClausesBuilder()
    )
  }
}

extension YieldList {
  public init(
    leftParen: TokenSyntax = Tokens.`leftParen`,
    @ExprListBuilder elementListBuilder: () -> ExprList = { .empty },
    trailingComma: TokenSyntax? = nil,
    rightParen: TokenSyntax = Tokens.`rightParen`
  ) {
    self.init(
      leftParen: leftParen,
      elementList: elementListBuilder(),
      trailingComma: trailingComma,
      rightParen: rightParen
    )
  }
}

extension AvailabilityCondition {
  public init(
    poundAvailableKeyword: TokenSyntax = Tokens.`poundAvailable`,
    leftParen: TokenSyntax = Tokens.`leftParen`,
    @AvailabilitySpecListBuilder availabilitySpecBuilder: () -> AvailabilitySpecList = { .empty },
    rightParen: TokenSyntax = Tokens.`rightParen`
  ) {
    self.init(
      poundAvailableKeyword: poundAvailableKeyword,
      leftParen: leftParen,
      availabilitySpec: availabilitySpecBuilder(),
      rightParen: rightParen
    )
  }
}

extension IfStmt {
  public init(
    labelName: String?,
    labelColon: TokenSyntax? = nil,
    ifKeyword: TokenSyntax = Tokens.`if`,
    @ConditionElementListBuilder conditionsBuilder: () -> ConditionElementList = { .empty },
    body: CodeBlock,
    elseKeyword: TokenSyntax? = nil,
    elseBody: SyntaxBuildable? = nil
  ) {
    self.init(
      labelName: labelName.map({ SyntaxFactory.makeIdentifier($0) }),
      labelColon: labelColon,
      ifKeyword: ifKeyword,
      conditions: conditionsBuilder(),
      body: body,
      elseKeyword: elseKeyword,
      elseBody: elseBody
    )
  }
}

extension SwitchCase {
  public init(
    unknownAttr: Attribute? = nil,
    label: SyntaxBuildable,
    @CodeBlockItemListBuilder statementsBuilder: () -> CodeBlockItemList = { .empty }
  ) {
    self.init(
      unknownAttr: unknownAttr,
      label: label,
      statements: statementsBuilder()
    )
  }
}

extension SwitchCaseLabel {
  public init(
    caseKeyword: TokenSyntax = Tokens.`case`,
    @CaseItemListBuilder caseItemsBuilder: () -> CaseItemList = { .empty },
    colon: TokenSyntax = Tokens.`colon`
  ) {
    self.init(
      caseKeyword: caseKeyword,
      caseItems: caseItemsBuilder(),
      colon: colon
    )
  }
}

extension CatchClause {
  public init(
    catchKeyword: TokenSyntax = Tokens.`catch`,
    @CatchItemListBuilder catchItemsBuilder: () -> CatchItemList? = { nil },
    body: CodeBlock
  ) {
    self.init(
      catchKeyword: catchKeyword,
      catchItems: catchItemsBuilder(),
      body: body
    )
  }
}

extension GenericWhereClause {
  public init(
    whereKeyword: TokenSyntax = Tokens.`where`,
    @GenericRequirementListBuilder requirementListBuilder: () -> GenericRequirementList = { .empty }
  ) {
    self.init(
      whereKeyword: whereKeyword,
      requirementList: requirementListBuilder()
    )
  }
}

extension GenericParameter {
  public init(
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    name: String,
    colon: TokenSyntax? = nil,
    inheritedType: TypeBuildable? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      attributes: attributesBuilder(),
      name: SyntaxFactory.makeIdentifier(name),
      colon: colon,
      inheritedType: inheritedType,
      trailingComma: trailingComma
    )
  }
}

extension GenericParameterClause {
  public init(
    leftAngleBracket: TokenSyntax = Tokens.`leftAngle`,
    @GenericParameterListBuilder genericParameterListBuilder: () -> GenericParameterList = { .empty },
    rightAngleBracket: TokenSyntax = Tokens.`rightAngle`
  ) {
    self.init(
      leftAngleBracket: leftAngleBracket,
      genericParameterList: genericParameterListBuilder(),
      rightAngleBracket: rightAngleBracket
    )
  }
}

extension CompositionType {
  public init(
    @CompositionTypeElementListBuilder elementsBuilder: () -> CompositionTypeElementList = { .empty }
  ) {
    self.init(
      elements: elementsBuilder()
    )
  }
}

extension TupleType {
  public init(
    leftParen: TokenSyntax = Tokens.`leftParen`,
    @TupleTypeElementListBuilder elementsBuilder: () -> TupleTypeElementList = { .empty },
    rightParen: TokenSyntax = Tokens.`rightParen`
  ) {
    self.init(
      leftParen: leftParen,
      elements: elementsBuilder(),
      rightParen: rightParen
    )
  }
}

extension FunctionType {
  public init(
    leftParen: TokenSyntax = Tokens.`leftParen`,
    @TupleTypeElementListBuilder argumentsBuilder: () -> TupleTypeElementList = { .empty },
    rightParen: TokenSyntax = Tokens.`rightParen`,
    asyncKeyword: String?,
    throwsOrRethrowsKeyword: TokenSyntax? = nil,
    arrow: TokenSyntax = Tokens.`arrow`,
    returnType: TypeBuildable
  ) {
    self.init(
      leftParen: leftParen,
      arguments: argumentsBuilder(),
      rightParen: rightParen,
      asyncKeyword: asyncKeyword.map({ SyntaxFactory.makeIdentifier($0) }),
      throwsOrRethrowsKeyword: throwsOrRethrowsKeyword,
      arrow: arrow,
      returnType: returnType
    )
  }
}

extension AttributedType {
  public init(
    specifier: TokenSyntax? = nil,
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    baseType: TypeBuildable
  ) {
    self.init(
      specifier: specifier,
      attributes: attributesBuilder(),
      baseType: baseType
    )
  }
}

extension GenericArgumentClause {
  public init(
    leftAngleBracket: TokenSyntax = Tokens.`leftAngle`,
    @GenericArgumentListBuilder argumentsBuilder: () -> GenericArgumentList = { .empty },
    rightAngleBracket: TokenSyntax = Tokens.`rightAngle`
  ) {
    self.init(
      leftAngleBracket: leftAngleBracket,
      arguments: argumentsBuilder(),
      rightAngleBracket: rightAngleBracket
    )
  }
}

extension TuplePattern {
  public init(
    leftParen: TokenSyntax = Tokens.`leftParen`,
    @TuplePatternElementListBuilder elementsBuilder: () -> TuplePatternElementList = { .empty },
    rightParen: TokenSyntax = Tokens.`rightParen`
  ) {
    self.init(
      leftParen: leftParen,
      elements: elementsBuilder(),
      rightParen: rightParen
    )
  }
}

