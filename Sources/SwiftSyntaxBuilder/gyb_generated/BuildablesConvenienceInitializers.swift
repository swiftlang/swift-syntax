//// Automatically Generated From BuildablesConvenienceInitializers.swift.gyb.
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
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`,
    @CodeBlockItemListBuilder statementsBuilder: () -> CodeBlockItemList = { .empty }
  ) {
    self.init(
      leftBrace: leftBrace,
      statements: statementsBuilder(),
      rightBrace: rightBrace
    )
  }
}

extension AwaitExpr {
  public init(
    awaitKeyword: String,
    expression: ExprBuildable
  ) {
    self.init(
      awaitKeyword: SyntaxFactory.makeIdentifier(awaitKeyword),
      expression: expression
    )
  }
}

extension DeclNameArguments {
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @DeclNameArgumentListBuilder argumentsBuilder: () -> DeclNameArgumentList = { .empty }
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

extension SymbolicReferenceExpr {
  public init(
    identifier: String,
    genericArgumentClause: GenericArgumentClause? = nil
  ) {
    self.init(
      identifier: SyntaxFactory.makeIdentifier(identifier),
      genericArgumentClause: genericArgumentClause
    )
  }
}

extension PrefixOperatorExpr {
  public init(
    operatorToken: String?,
    postfixExpression: ExprBuildable
  ) {
    self.init(
      operatorToken: operatorToken.map(TokenSyntax.prefixOperator),
      postfixExpression: postfixExpression
    )
  }
}

extension ArrowExpr {
  public init(
    asyncKeyword: String?,
    throwsToken: TokenSyntax? = nil,
    arrowToken: TokenSyntax = TokenSyntax.`arrow`
  ) {
    self.init(
      asyncKeyword: asyncKeyword.map({ SyntaxFactory.makeIdentifier($0) }),
      throwsToken: throwsToken,
      arrowToken: arrowToken
    )
  }
}

extension FloatLiteralExpr {
  public init(
    floatingDigits: String
  ) {
    self.init(
      floatingDigits: TokenSyntax.floatingLiteral(floatingDigits)
    )
  }
}

extension TupleExpr {
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @TupleExprElementListBuilder elementListBuilder: () -> TupleExprElementList = { .empty }
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
    leftSquare: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    rightSquare: TokenSyntax = TokenSyntax.`rightSquareBracket`,
    @ArrayElementListBuilder elementsBuilder: () -> ArrayElementList = { .empty }
  ) {
    self.init(
      leftSquare: leftSquare,
      elements: elementsBuilder(),
      rightSquare: rightSquare
    )
  }
}

extension IntegerLiteralExpr {
  public init(
    digits: String
  ) {
    self.init(
      digits: TokenSyntax.integerLiteral(digits)
    )
  }
}

extension ClosureCaptureItem {
  public init(
    name: String?,
    assignToken: TokenSyntax? = nil,
    expression: ExprBuildable,
    trailingComma: TokenSyntax? = nil,
    @TokenListBuilder specifierBuilder: () -> TokenList? = { nil }
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
    leftSquare: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    rightSquare: TokenSyntax = TokenSyntax.`rightSquareBracket`,
    @ClosureCaptureItemListBuilder itemsBuilder: () -> ClosureCaptureItemList? = { nil }
  ) {
    self.init(
      leftSquare: leftSquare,
      items: itemsBuilder(),
      rightSquare: rightSquare
    )
  }
}

extension ClosureSignature {
  public init(
    capture: ClosureCaptureSignature? = nil,
    input: SyntaxBuildable? = nil,
    asyncKeyword: String?,
    throwsTok: TokenSyntax? = nil,
    output: ReturnClause? = nil,
    inTok: TokenSyntax = TokenSyntax.`in`,
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil }
  ) {
    self.init(
      attributes: attributesBuilder(),
      capture: capture,
      input: input,
      asyncKeyword: asyncKeyword.map({ SyntaxFactory.makeIdentifier($0) }),
      throwsTok: throwsTok,
      output: output,
      inTok: inTok
    )
  }
}

extension ClosureExpr {
  public init(
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    signature: ClosureSignature? = nil,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`,
    @CodeBlockItemListBuilder statementsBuilder: () -> CodeBlockItemList = { .empty }
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
    rightParen: TokenSyntax? = nil,
    trailingClosure: ClosureExpr? = nil,
    @TupleExprElementListBuilder argumentListBuilder: () -> TupleExprElementList = { .empty },
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
    leftBracket: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    rightBracket: TokenSyntax = TokenSyntax.`rightSquareBracket`,
    trailingClosure: ClosureExpr? = nil,
    @TupleExprElementListBuilder argumentListBuilder: () -> TupleExprElementList = { .empty },
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

extension PostfixUnaryExpr {
  public init(
    expression: ExprBuildable,
    operatorToken: String
  ) {
    self.init(
      expression: expression,
      operatorToken: TokenSyntax.postfixOperator(operatorToken)
    )
  }
}

extension StringSegment {
  public init(
    content: String
  ) {
    self.init(
      content: TokenSyntax.stringSegment(content)
    )
  }
}

extension ExpressionSegment {
  public init(
    backslash: TokenSyntax = TokenSyntax.`backslash`,
    delimiter: String?,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`stringInterpolationAnchor`,
    @TupleExprElementListBuilder expressionsBuilder: () -> TupleExprElementList = { .empty }
  ) {
    self.init(
      backslash: backslash,
      delimiter: delimiter.map(TokenSyntax.rawStringDelimiter),
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
    closeQuote: TokenSyntax,
    closeDelimiter: String?,
    @StringLiteralSegmentsBuilder segmentsBuilder: () -> StringLiteralSegments = { .empty }
  ) {
    self.init(
      openDelimiter: openDelimiter.map(TokenSyntax.rawStringDelimiter),
      openQuote: openQuote,
      segments: segmentsBuilder(),
      closeQuote: closeQuote,
      closeDelimiter: closeDelimiter.map(TokenSyntax.rawStringDelimiter)
    )
  }
}

extension ObjcNamePiece {
  public init(
    name: String,
    dot: TokenSyntax? = nil
  ) {
    self.init(
      name: SyntaxFactory.makeIdentifier(name),
      dot: dot
    )
  }
}

extension ObjcKeyPathExpr {
  public init(
    keyPath: TokenSyntax = TokenSyntax.`poundKeyPath`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @ObjcNameBuilder nameBuilder: () -> ObjcName = { .empty }
  ) {
    self.init(
      keyPath: keyPath,
      leftParen: leftParen,
      name: nameBuilder(),
      rightParen: rightParen
    )
  }
}

extension ObjcSelectorExpr {
  public init(
    poundSelector: TokenSyntax = TokenSyntax.`poundSelector`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    kind: String?,
    colon: TokenSyntax? = nil,
    name: ExprBuildable,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.init(
      poundSelector: poundSelector,
      leftParen: leftParen,
      kind: kind.map(TokenSyntax.contextualKeyword),
      colon: colon,
      name: name,
      rightParen: rightParen
    )
  }
}

extension EditorPlaceholderExpr {
  public init(
    identifier: String
  ) {
    self.init(
      identifier: SyntaxFactory.makeIdentifier(identifier)
    )
  }
}

extension ObjectLiteralExpr {
  public init(
    identifier: TokenSyntax,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @TupleExprElementListBuilder argumentsBuilder: () -> TupleExprElementList = { .empty }
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
    typealiasKeyword: TokenSyntax = TokenSyntax.`typealias`,
    identifier: String,
    genericParameterClause: GenericParameterClause? = nil,
    initializer: TypeInitializerClause? = nil,
    genericWhereClause: GenericWhereClause? = nil,
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil }
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
    associatedtypeKeyword: TokenSyntax = TokenSyntax.`associatedtype`,
    identifier: String,
    inheritanceClause: TypeInheritanceClause? = nil,
    initializer: TypeInitializerClause? = nil,
    genericWhereClause: GenericWhereClause? = nil,
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil }
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
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @FunctionParameterListBuilder parameterListBuilder: () -> FunctionParameterList = { .empty }
  ) {
    self.init(
      leftParen: leftParen,
      parameterList: parameterListBuilder(),
      rightParen: rightParen
    )
  }
}

extension FunctionSignature {
  public init(
    input: ParameterClause,
    asyncOrReasyncKeyword: String?,
    throwsOrRethrowsKeyword: TokenSyntax? = nil,
    output: ReturnClause? = nil
  ) {
    self.init(
      input: input,
      asyncOrReasyncKeyword: asyncOrReasyncKeyword.map({ SyntaxFactory.makeIdentifier($0) }),
      throwsOrRethrowsKeyword: throwsOrRethrowsKeyword,
      output: output
    )
  }
}

extension IfConfigDecl {
  public init(
    poundEndif: TokenSyntax = TokenSyntax.`poundEndif`,
    @IfConfigClauseListBuilder clausesBuilder: () -> IfConfigClauseList = { .empty }
  ) {
    self.init(
      clauses: clausesBuilder(),
      poundEndif: poundEndif
    )
  }
}

extension PoundSourceLocationArgs {
  public init(
    fileArgLabel: String,
    fileArgColon: TokenSyntax = TokenSyntax.`colon`,
    fileName: String,
    comma: TokenSyntax = TokenSyntax.`comma`,
    lineArgLabel: String,
    lineArgColon: TokenSyntax = TokenSyntax.`colon`,
    lineNumber: String
  ) {
    self.init(
      fileArgLabel: SyntaxFactory.makeIdentifier(fileArgLabel),
      fileArgColon: fileArgColon,
      fileName: TokenSyntax.stringLiteral(fileName),
      comma: comma,
      lineArgLabel: SyntaxFactory.makeIdentifier(lineArgLabel),
      lineArgColon: lineArgColon,
      lineNumber: TokenSyntax.integerLiteral(lineNumber)
    )
  }
}

extension DeclModifier {
  public init(
    name: TokenSyntax,
    detailLeftParen: TokenSyntax? = nil,
    detail: String?,
    detailRightParen: TokenSyntax? = nil
  ) {
    self.init(
      name: name,
      detailLeftParen: detailLeftParen,
      detail: detail.map({ SyntaxFactory.makeIdentifier($0) }),
      detailRightParen: detailRightParen
    )
  }
}

extension TypeInheritanceClause {
  public init(
    colon: TokenSyntax = TokenSyntax.`colon`,
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
    classOrActorKeyword: TokenSyntax,
    identifier: String,
    genericParameterClause: GenericParameterClause? = nil,
    inheritanceClause: TypeInheritanceClause? = nil,
    genericWhereClause: GenericWhereClause? = nil,
    members: MemberDeclBlock,
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil }
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
    structKeyword: TokenSyntax = TokenSyntax.`struct`,
    identifier: String,
    genericParameterClause: GenericParameterClause? = nil,
    inheritanceClause: TypeInheritanceClause? = nil,
    genericWhereClause: GenericWhereClause? = nil,
    members: MemberDeclBlock,
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil }
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
    protocolKeyword: TokenSyntax = TokenSyntax.`protocol`,
    identifier: String,
    inheritanceClause: TypeInheritanceClause? = nil,
    genericWhereClause: GenericWhereClause? = nil,
    members: MemberDeclBlock,
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil }
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
    extensionKeyword: TokenSyntax = TokenSyntax.`extension`,
    extendedType: TypeBuildable,
    inheritanceClause: TypeInheritanceClause? = nil,
    genericWhereClause: GenericWhereClause? = nil,
    members: MemberDeclBlock,
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil }
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
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`,
    @MemberDeclListBuilder membersBuilder: () -> MemberDeclList = { .empty }
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
    eofToken: TokenSyntax,
    @CodeBlockItemListBuilder statementsBuilder: () -> CodeBlockItemList = { .empty }
  ) {
    self.init(
      statements: statementsBuilder(),
      eofToken: eofToken
    )
  }
}

extension FunctionParameter {
  public init(
    firstName: TokenSyntax? = nil,
    secondName: TokenSyntax? = nil,
    colon: TokenSyntax? = nil,
    type: TypeBuildable? = nil,
    ellipsis: TokenSyntax? = nil,
    defaultArgument: InitializerClause? = nil,
    trailingComma: TokenSyntax? = nil,
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil }
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
    funcKeyword: TokenSyntax = TokenSyntax.`func`,
    identifier: TokenSyntax,
    genericParameterClause: GenericParameterClause? = nil,
    signature: FunctionSignature,
    genericWhereClause: GenericWhereClause? = nil,
    body: CodeBlock? = nil,
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil }
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
    initKeyword: TokenSyntax = TokenSyntax.`init`,
    optionalMark: TokenSyntax? = nil,
    genericParameterClause: GenericParameterClause? = nil,
    parameters: ParameterClause,
    throwsOrRethrowsKeyword: TokenSyntax? = nil,
    genericWhereClause: GenericWhereClause? = nil,
    body: CodeBlock? = nil,
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil }
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
    deinitKeyword: TokenSyntax = TokenSyntax.`deinit`,
    body: CodeBlock,
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil }
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
    subscriptKeyword: TokenSyntax = TokenSyntax.`subscript`,
    genericParameterClause: GenericParameterClause? = nil,
    indices: ParameterClause,
    result: ReturnClause,
    genericWhereClause: GenericWhereClause? = nil,
    accessor: SyntaxBuildable? = nil,
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil }
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

extension AccessLevelModifier {
  public init(
    name: String,
    leftParen: TokenSyntax? = nil,
    modifier: String?,
    rightParen: TokenSyntax? = nil
  ) {
    self.init(
      name: SyntaxFactory.makeIdentifier(name),
      leftParen: leftParen,
      modifier: modifier.map({ SyntaxFactory.makeIdentifier($0) }),
      rightParen: rightParen
    )
  }
}

extension AccessPathComponent {
  public init(
    name: String,
    trailingDot: TokenSyntax? = nil
  ) {
    self.init(
      name: SyntaxFactory.makeIdentifier(name),
      trailingDot: trailingDot
    )
  }
}

extension ImportDecl {
  public init(
    importTok: TokenSyntax = TokenSyntax.`import`,
    importKind: TokenSyntax? = nil,
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil },
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

extension AccessorParameter {
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    name: String,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.init(
      leftParen: leftParen,
      name: SyntaxFactory.makeIdentifier(name),
      rightParen: rightParen
    )
  }
}

extension AccessorDecl {
  public init(
    modifier: DeclModifier? = nil,
    accessorKind: TokenSyntax,
    parameter: AccessorParameter? = nil,
    asyncKeyword: String?,
    throwsKeyword: TokenSyntax? = nil,
    body: CodeBlock? = nil,
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil }
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
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`,
    @AccessorListBuilder accessorsBuilder: () -> AccessorList = { .empty }
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
    letOrVarKeyword: TokenSyntax,
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil },
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

extension EnumCaseElement {
  public init(
    identifier: String,
    associatedValue: ParameterClause? = nil,
    rawValue: InitializerClause? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      identifier: SyntaxFactory.makeIdentifier(identifier),
      associatedValue: associatedValue,
      rawValue: rawValue,
      trailingComma: trailingComma
    )
  }
}

extension EnumCaseDecl {
  public init(
    caseKeyword: TokenSyntax = TokenSyntax.`case`,
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil },
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
    enumKeyword: TokenSyntax = TokenSyntax.`enum`,
    identifier: String,
    genericParameters: GenericParameterClause? = nil,
    inheritanceClause: TypeInheritanceClause? = nil,
    genericWhereClause: GenericWhereClause? = nil,
    members: MemberDeclBlock,
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil }
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
    operatorKeyword: TokenSyntax = TokenSyntax.`operator`,
    identifier: TokenSyntax,
    operatorPrecedenceAndTypes: OperatorPrecedenceAndTypes? = nil,
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil }
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
    colon: TokenSyntax = TokenSyntax.`colon`,
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
    precedencegroupKeyword: TokenSyntax = TokenSyntax.`precedencegroup`,
    identifier: String,
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`,
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ModifierList? = { nil },
    @PrecedenceGroupAttributeListBuilder groupAttributesBuilder: () -> PrecedenceGroupAttributeList = { .empty }
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
    colon: TokenSyntax = TokenSyntax.`colon`,
    @PrecedenceGroupNameListBuilder otherNamesBuilder: () -> PrecedenceGroupNameList = { .empty }
  ) {
    self.init(
      higherThanOrLowerThan: SyntaxFactory.makeIdentifier(higherThanOrLowerThan),
      colon: colon,
      otherNames: otherNamesBuilder()
    )
  }
}

extension PrecedenceGroupNameElement {
  public init(
    name: String,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      name: SyntaxFactory.makeIdentifier(name),
      trailingComma: trailingComma
    )
  }
}

extension PrecedenceGroupAssignment {
  public init(
    assignmentKeyword: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    flag: TokenSyntax
  ) {
    self.init(
      assignmentKeyword: SyntaxFactory.makeIdentifier(assignmentKeyword),
      colon: colon,
      flag: flag
    )
  }
}

extension PrecedenceGroupAssociativity {
  public init(
    associativityKeyword: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    value: String
  ) {
    self.init(
      associativityKeyword: SyntaxFactory.makeIdentifier(associativityKeyword),
      colon: colon,
      value: SyntaxFactory.makeIdentifier(value)
    )
  }
}

extension CustomAttribute {
  public init(
    atSignToken: TokenSyntax = TokenSyntax.`atSign`,
    attributeName: TypeBuildable,
    leftParen: TokenSyntax? = nil,
    rightParen: TokenSyntax? = nil,
    @TupleExprElementListBuilder argumentListBuilder: () -> TupleExprElementList? = { nil }
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
    atSignToken: TokenSyntax = TokenSyntax.`atSign`,
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

extension LabeledSpecializeEntry {
  public init(
    label: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    value: TokenSyntax,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      label: SyntaxFactory.makeIdentifier(label),
      colon: colon,
      value: value,
      trailingComma: trailingComma
    )
  }
}

extension TargetFunctionEntry {
  public init(
    label: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    delcname: DeclName,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      label: SyntaxFactory.makeIdentifier(label),
      colon: colon,
      delcname: delcname,
      trailingComma: trailingComma
    )
  }
}

extension ObjCSelectorPiece {
  public init(
    name: String?,
    colon: TokenSyntax? = nil
  ) {
    self.init(
      name: name.map({ SyntaxFactory.makeIdentifier($0) }),
      colon: colon
    )
  }
}

extension DifferentiableAttributeArguments {
  public init(
    diffKind: String?,
    diffKindComma: TokenSyntax? = nil,
    diffParams: DifferentiabilityParamsClause? = nil,
    diffParamsComma: TokenSyntax? = nil,
    whereClause: GenericWhereClause? = nil
  ) {
    self.init(
      diffKind: diffKind.map({ SyntaxFactory.makeIdentifier($0) }),
      diffKindComma: diffKindComma,
      diffParams: diffParams,
      diffParamsComma: diffParamsComma,
      whereClause: whereClause
    )
  }
}

extension DifferentiabilityParamsClause {
  public init(
    wrtLabel: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    parameters: SyntaxBuildable
  ) {
    self.init(
      wrtLabel: SyntaxFactory.makeIdentifier(wrtLabel),
      colon: colon,
      parameters: parameters
    )
  }
}

extension DifferentiabilityParams {
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @DifferentiabilityParamListBuilder diffParamsBuilder: () -> DifferentiabilityParamList = { .empty }
  ) {
    self.init(
      leftParen: leftParen,
      diffParams: diffParamsBuilder(),
      rightParen: rightParen
    )
  }
}

extension DerivativeRegistrationAttributeArguments {
  public init(
    ofLabel: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    originalDeclName: QualifiedDeclName,
    period: TokenSyntax? = nil,
    accessorKind: String?,
    comma: TokenSyntax? = nil,
    diffParams: DifferentiabilityParamsClause? = nil
  ) {
    self.init(
      ofLabel: SyntaxFactory.makeIdentifier(ofLabel),
      colon: colon,
      originalDeclName: originalDeclName,
      period: period,
      accessorKind: accessorKind.map({ SyntaxFactory.makeIdentifier($0) }),
      comma: comma,
      diffParams: diffParams
    )
  }
}

extension ContinueStmt {
  public init(
    continueKeyword: TokenSyntax = TokenSyntax.`continue`,
    label: String?
  ) {
    self.init(
      continueKeyword: continueKeyword,
      label: label.map({ SyntaxFactory.makeIdentifier($0) })
    )
  }
}

extension WhileStmt {
  public init(
    labelName: String?,
    labelColon: TokenSyntax? = nil,
    whileKeyword: TokenSyntax = TokenSyntax.`while`,
    body: CodeBlock,
    @ConditionElementListBuilder conditionsBuilder: () -> ConditionElementList = { .empty }
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

extension RepeatWhileStmt {
  public init(
    labelName: String?,
    labelColon: TokenSyntax? = nil,
    repeatKeyword: TokenSyntax = TokenSyntax.`repeat`,
    body: CodeBlock,
    whileKeyword: TokenSyntax = TokenSyntax.`while`,
    condition: ExprBuildable
  ) {
    self.init(
      labelName: labelName.map({ SyntaxFactory.makeIdentifier($0) }),
      labelColon: labelColon,
      repeatKeyword: repeatKeyword,
      body: body,
      whileKeyword: whileKeyword,
      condition: condition
    )
  }
}

extension GuardStmt {
  public init(
    guardKeyword: TokenSyntax = TokenSyntax.`guard`,
    elseKeyword: TokenSyntax = TokenSyntax.`else`,
    body: CodeBlock,
    @ConditionElementListBuilder conditionsBuilder: () -> ConditionElementList = { .empty }
  ) {
    self.init(
      guardKeyword: guardKeyword,
      conditions: conditionsBuilder(),
      elseKeyword: elseKeyword,
      body: body
    )
  }
}

extension ForInStmt {
  public init(
    labelName: String?,
    labelColon: TokenSyntax? = nil,
    forKeyword: TokenSyntax = TokenSyntax.`for`,
    tryKeyword: TokenSyntax? = nil,
    awaitKeyword: String?,
    caseKeyword: TokenSyntax? = nil,
    pattern: PatternBuildable,
    typeAnnotation: TypeAnnotation? = nil,
    inKeyword: TokenSyntax = TokenSyntax.`in`,
    sequenceExpr: ExprBuildable,
    whereClause: WhereClause? = nil,
    body: CodeBlock
  ) {
    self.init(
      labelName: labelName.map({ SyntaxFactory.makeIdentifier($0) }),
      labelColon: labelColon,
      forKeyword: forKeyword,
      tryKeyword: tryKeyword,
      awaitKeyword: awaitKeyword.map({ SyntaxFactory.makeIdentifier($0) }),
      caseKeyword: caseKeyword,
      pattern: pattern,
      typeAnnotation: typeAnnotation,
      inKeyword: inKeyword,
      sequenceExpr: sequenceExpr,
      whereClause: whereClause,
      body: body
    )
  }
}

extension SwitchStmt {
  public init(
    labelName: String?,
    labelColon: TokenSyntax? = nil,
    switchKeyword: TokenSyntax = TokenSyntax.`switch`,
    expression: ExprBuildable,
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`,
    @SwitchCaseListBuilder casesBuilder: () -> SwitchCaseList = { .empty }
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
    doKeyword: TokenSyntax = TokenSyntax.`do`,
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
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    trailingComma: TokenSyntax? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @ExprListBuilder elementListBuilder: () -> ExprList = { .empty }
  ) {
    self.init(
      leftParen: leftParen,
      elementList: elementListBuilder(),
      trailingComma: trailingComma,
      rightParen: rightParen
    )
  }
}

extension BreakStmt {
  public init(
    breakKeyword: TokenSyntax = TokenSyntax.`break`,
    label: String?
  ) {
    self.init(
      breakKeyword: breakKeyword,
      label: label.map({ SyntaxFactory.makeIdentifier($0) })
    )
  }
}

extension AvailabilityCondition {
  public init(
    poundAvailableKeyword: TokenSyntax = TokenSyntax.`poundAvailable`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @AvailabilitySpecListBuilder availabilitySpecBuilder: () -> AvailabilitySpecList = { .empty }
  ) {
    self.init(
      poundAvailableKeyword: poundAvailableKeyword,
      leftParen: leftParen,
      availabilitySpec: availabilitySpecBuilder(),
      rightParen: rightParen
    )
  }
}

extension UnavailabilityCondition {
  public init(
    poundUnavailableKeyword: TokenSyntax = TokenSyntax.`poundUnavailable`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @AvailabilitySpecListBuilder availabilitySpecBuilder: () -> AvailabilitySpecList = { .empty }
  ) {
    self.init(
      poundUnavailableKeyword: poundUnavailableKeyword,
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
    ifKeyword: TokenSyntax = TokenSyntax.`if`,
    body: CodeBlock,
    elseKeyword: TokenSyntax? = nil,
    elseBody: SyntaxBuildable? = nil,
    @ConditionElementListBuilder conditionsBuilder: () -> ConditionElementList = { .empty }
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
    caseKeyword: TokenSyntax = TokenSyntax.`case`,
    colon: TokenSyntax = TokenSyntax.`colon`,
    @CaseItemListBuilder caseItemsBuilder: () -> CaseItemList = { .empty }
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
    catchKeyword: TokenSyntax = TokenSyntax.`catch`,
    body: CodeBlock,
    @CatchItemListBuilder catchItemsBuilder: () -> CatchItemList? = { nil }
  ) {
    self.init(
      catchKeyword: catchKeyword,
      catchItems: catchItemsBuilder(),
      body: body
    )
  }
}

extension PoundAssertStmt {
  public init(
    poundAssert: TokenSyntax = TokenSyntax.`poundAssert`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    condition: ExprBuildable,
    comma: TokenSyntax? = nil,
    message: String?,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.init(
      poundAssert: poundAssert,
      leftParen: leftParen,
      condition: condition,
      comma: comma,
      message: message.map(TokenSyntax.stringLiteral),
      rightParen: rightParen
    )
  }
}

extension GenericWhereClause {
  public init(
    whereKeyword: TokenSyntax = TokenSyntax.`where`,
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
    name: String,
    colon: TokenSyntax? = nil,
    inheritedType: TypeBuildable? = nil,
    trailingComma: TokenSyntax? = nil,
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil }
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
    leftAngleBracket: TokenSyntax = TokenSyntax.`leftAngle`,
    rightAngleBracket: TokenSyntax = TokenSyntax.`rightAngle`,
    @GenericParameterListBuilder genericParameterListBuilder: () -> GenericParameterList = { .empty }
  ) {
    self.init(
      leftAngleBracket: leftAngleBracket,
      genericParameterList: genericParameterListBuilder(),
      rightAngleBracket: rightAngleBracket
    )
  }
}

extension MetatypeType {
  public init(
    baseType: TypeBuildable,
    period: TokenSyntax = TokenSyntax.`period`,
    typeOrProtocol: String
  ) {
    self.init(
      baseType: baseType,
      period: period,
      typeOrProtocol: SyntaxFactory.makeIdentifier(typeOrProtocol)
    )
  }
}

extension SomeType {
  public init(
    someSpecifier: String,
    baseType: TypeBuildable
  ) {
    self.init(
      someSpecifier: SyntaxFactory.makeIdentifier(someSpecifier),
      baseType: baseType
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
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @TupleTypeElementListBuilder elementsBuilder: () -> TupleTypeElementList = { .empty }
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
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    asyncKeyword: String?,
    throwsOrRethrowsKeyword: TokenSyntax? = nil,
    arrow: TokenSyntax = TokenSyntax.`arrow`,
    returnType: TypeBuildable,
    @TupleTypeElementListBuilder argumentsBuilder: () -> TupleTypeElementList = { .empty }
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
    baseType: TypeBuildable,
    @AttributeListBuilder attributesBuilder: () -> AttributeList? = { nil }
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
    leftAngleBracket: TokenSyntax = TokenSyntax.`leftAngle`,
    rightAngleBracket: TokenSyntax = TokenSyntax.`rightAngle`,
    @GenericArgumentListBuilder argumentsBuilder: () -> GenericArgumentList = { .empty }
  ) {
    self.init(
      leftAngleBracket: leftAngleBracket,
      arguments: argumentsBuilder(),
      rightAngleBracket: rightAngleBracket
    )
  }
}

extension EnumCasePattern {
  public init(
    type: TypeBuildable? = nil,
    period: TokenSyntax = TokenSyntax.`period`,
    caseName: String,
    associatedTuple: TuplePattern? = nil
  ) {
    self.init(
      type: type,
      period: period,
      caseName: SyntaxFactory.makeIdentifier(caseName),
      associatedTuple: associatedTuple
    )
  }
}

extension TuplePattern {
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    @TuplePatternElementListBuilder elementsBuilder: () -> TuplePatternElementList = { .empty }
  ) {
    self.init(
      leftParen: leftParen,
      elements: elementsBuilder(),
      rightParen: rightParen
    )
  }
}

extension TuplePatternElement {
  public init(
    labelName: String?,
    labelColon: TokenSyntax? = nil,
    pattern: PatternBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.init(
      labelName: labelName.map({ SyntaxFactory.makeIdentifier($0) }),
      labelColon: labelColon,
      pattern: pattern,
      trailingComma: trailingComma
    )
  }
}

extension AvailabilityLabeledArgument {
  public init(
    label: String,
    colon: TokenSyntax = TokenSyntax.`colon`,
    value: SyntaxBuildable
  ) {
    self.init(
      label: SyntaxFactory.makeIdentifier(label),
      colon: colon,
      value: value
    )
  }
}

extension AvailabilityVersionRestriction {
  public init(
    platform: String,
    version: VersionTuple? = nil
  ) {
    self.init(
      platform: SyntaxFactory.makeIdentifier(platform),
      version: version
    )
  }
}

extension VersionTuple {
  public init(
    majorMinor: SyntaxBuildable,
    patchPeriod: TokenSyntax? = nil,
    patchVersion: String?
  ) {
    self.init(
      majorMinor: majorMinor,
      patchPeriod: patchPeriod,
      patchVersion: patchVersion.map(TokenSyntax.integerLiteral)
    )
  }
}

