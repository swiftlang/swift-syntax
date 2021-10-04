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
    leftBrace: ExpressibleAsTokenSyntax = TokenSyntax.`leftBrace`,
    rightBrace: ExpressibleAsTokenSyntax = TokenSyntax.`rightBrace`,
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
    expression: ExpressibleAsExprBuildable
  ) {
    self.init(
      awaitKeyword: SyntaxFactory.makeIdentifier(awaitKeyword),
      expression: expression
    )
  }
}

extension DeclNameArguments {
  public init(
    leftParen: ExpressibleAsTokenSyntax = TokenSyntax.`leftParen`,
    rightParen: ExpressibleAsTokenSyntax = TokenSyntax.`rightParen`,
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
    genericArgumentClause: ExpressibleAsGenericArgumentClause? = nil
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
    postfixExpression: ExpressibleAsExprBuildable
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
    throwsToken: ExpressibleAsTokenSyntax? = nil,
    arrowToken: ExpressibleAsTokenSyntax = TokenSyntax.`arrow`
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
    leftParen: ExpressibleAsTokenSyntax = TokenSyntax.`leftParen`,
    rightParen: ExpressibleAsTokenSyntax = TokenSyntax.`rightParen`,
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
    leftSquare: ExpressibleAsTokenSyntax = TokenSyntax.`leftSquareBracket`,
    rightSquare: ExpressibleAsTokenSyntax = TokenSyntax.`rightSquareBracket`,
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
    assignToken: ExpressibleAsTokenSyntax? = nil,
    expression: ExpressibleAsExprBuildable,
    trailingComma: ExpressibleAsTokenSyntax? = nil,
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
    leftSquare: ExpressibleAsTokenSyntax = TokenSyntax.`leftSquareBracket`,
    rightSquare: ExpressibleAsTokenSyntax = TokenSyntax.`rightSquareBracket`,
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
    capture: ExpressibleAsClosureCaptureSignature? = nil,
    input: ExpressibleAsSyntaxBuildable? = nil,
    asyncKeyword: String?,
    throwsTok: ExpressibleAsTokenSyntax? = nil,
    output: ExpressibleAsReturnClause? = nil,
    inTok: ExpressibleAsTokenSyntax = TokenSyntax.`in`,
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
    leftBrace: ExpressibleAsTokenSyntax = TokenSyntax.`leftBrace`,
    signature: ExpressibleAsClosureSignature? = nil,
    rightBrace: ExpressibleAsTokenSyntax = TokenSyntax.`rightBrace`,
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
    calledExpression: ExpressibleAsExprBuildable,
    leftParen: ExpressibleAsTokenSyntax? = nil,
    rightParen: ExpressibleAsTokenSyntax? = nil,
    trailingClosure: ExpressibleAsClosureExpr? = nil,
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
    calledExpression: ExpressibleAsExprBuildable,
    leftBracket: ExpressibleAsTokenSyntax = TokenSyntax.`leftSquareBracket`,
    rightBracket: ExpressibleAsTokenSyntax = TokenSyntax.`rightSquareBracket`,
    trailingClosure: ExpressibleAsClosureExpr? = nil,
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
    expression: ExpressibleAsExprBuildable,
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
    backslash: ExpressibleAsTokenSyntax = TokenSyntax.`backslash`,
    delimiter: String?,
    leftParen: ExpressibleAsTokenSyntax = TokenSyntax.`leftParen`,
    rightParen: ExpressibleAsTokenSyntax = TokenSyntax.`stringInterpolationAnchor`,
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
    openQuote: ExpressibleAsTokenSyntax,
    closeQuote: ExpressibleAsTokenSyntax,
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
    dot: ExpressibleAsTokenSyntax? = nil
  ) {
    self.init(
      name: SyntaxFactory.makeIdentifier(name),
      dot: dot
    )
  }
}

extension ObjcKeyPathExpr {
  public init(
    keyPath: ExpressibleAsTokenSyntax = TokenSyntax.`poundKeyPath`,
    leftParen: ExpressibleAsTokenSyntax = TokenSyntax.`leftParen`,
    rightParen: ExpressibleAsTokenSyntax = TokenSyntax.`rightParen`,
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
    poundSelector: ExpressibleAsTokenSyntax = TokenSyntax.`poundSelector`,
    leftParen: ExpressibleAsTokenSyntax = TokenSyntax.`leftParen`,
    kind: String?,
    colon: ExpressibleAsTokenSyntax? = nil,
    name: ExpressibleAsExprBuildable,
    rightParen: ExpressibleAsTokenSyntax = TokenSyntax.`rightParen`
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
    identifier: ExpressibleAsTokenSyntax,
    leftParen: ExpressibleAsTokenSyntax = TokenSyntax.`leftParen`,
    rightParen: ExpressibleAsTokenSyntax = TokenSyntax.`rightParen`,
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
    typealiasKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`typealias`,
    identifier: String,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    initializer: ExpressibleAsTypeInitializerClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
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
    associatedtypeKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`associatedtype`,
    identifier: String,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    initializer: ExpressibleAsTypeInitializerClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
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
    leftParen: ExpressibleAsTokenSyntax = TokenSyntax.`leftParen`,
    rightParen: ExpressibleAsTokenSyntax = TokenSyntax.`rightParen`,
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
    input: ExpressibleAsParameterClause,
    asyncOrReasyncKeyword: String?,
    throwsOrRethrowsKeyword: ExpressibleAsTokenSyntax? = nil,
    output: ExpressibleAsReturnClause? = nil
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
    poundEndif: ExpressibleAsTokenSyntax = TokenSyntax.`poundEndif`,
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
    fileArgColon: ExpressibleAsTokenSyntax = TokenSyntax.`colon`,
    fileName: String,
    comma: ExpressibleAsTokenSyntax = TokenSyntax.`comma`,
    lineArgLabel: String,
    lineArgColon: ExpressibleAsTokenSyntax = TokenSyntax.`colon`,
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
    name: ExpressibleAsTokenSyntax,
    detailLeftParen: ExpressibleAsTokenSyntax? = nil,
    detail: String?,
    detailRightParen: ExpressibleAsTokenSyntax? = nil
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
    colon: ExpressibleAsTokenSyntax = TokenSyntax.`colon`,
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
    classOrActorKeyword: ExpressibleAsTokenSyntax,
    identifier: String,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    members: ExpressibleAsMemberDeclBlock,
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
    structKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`struct`,
    identifier: String,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    members: ExpressibleAsMemberDeclBlock,
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
    protocolKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`protocol`,
    identifier: String,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    members: ExpressibleAsMemberDeclBlock,
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
    extensionKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`extension`,
    extendedType: ExpressibleAsTypeBuildable,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    members: ExpressibleAsMemberDeclBlock,
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
    leftBrace: ExpressibleAsTokenSyntax = TokenSyntax.`leftBrace`,
    rightBrace: ExpressibleAsTokenSyntax = TokenSyntax.`rightBrace`,
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
    eofToken: ExpressibleAsTokenSyntax,
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
    firstName: ExpressibleAsTokenSyntax? = nil,
    secondName: ExpressibleAsTokenSyntax? = nil,
    colon: ExpressibleAsTokenSyntax? = nil,
    type: ExpressibleAsTypeBuildable? = nil,
    ellipsis: ExpressibleAsTokenSyntax? = nil,
    defaultArgument: ExpressibleAsInitializerClause? = nil,
    trailingComma: ExpressibleAsTokenSyntax? = nil,
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
    funcKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`func`,
    identifier: ExpressibleAsTokenSyntax,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    signature: ExpressibleAsFunctionSignature,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    body: ExpressibleAsCodeBlock? = nil,
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
    initKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`init`,
    optionalMark: ExpressibleAsTokenSyntax? = nil,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    parameters: ExpressibleAsParameterClause,
    throwsOrRethrowsKeyword: ExpressibleAsTokenSyntax? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    body: ExpressibleAsCodeBlock? = nil,
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
    deinitKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`deinit`,
    body: ExpressibleAsCodeBlock,
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
    subscriptKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`subscript`,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    indices: ExpressibleAsParameterClause,
    result: ExpressibleAsReturnClause,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    accessor: ExpressibleAsSyntaxBuildable? = nil,
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
    leftParen: ExpressibleAsTokenSyntax? = nil,
    modifier: String?,
    rightParen: ExpressibleAsTokenSyntax? = nil
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
    trailingDot: ExpressibleAsTokenSyntax? = nil
  ) {
    self.init(
      name: SyntaxFactory.makeIdentifier(name),
      trailingDot: trailingDot
    )
  }
}

extension ImportDecl {
  public init(
    importTok: ExpressibleAsTokenSyntax = TokenSyntax.`import`,
    importKind: ExpressibleAsTokenSyntax? = nil,
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
    leftParen: ExpressibleAsTokenSyntax = TokenSyntax.`leftParen`,
    name: String,
    rightParen: ExpressibleAsTokenSyntax = TokenSyntax.`rightParen`
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
    modifier: ExpressibleAsDeclModifier? = nil,
    accessorKind: ExpressibleAsTokenSyntax,
    parameter: ExpressibleAsAccessorParameter? = nil,
    asyncKeyword: String?,
    throwsKeyword: ExpressibleAsTokenSyntax? = nil,
    body: ExpressibleAsCodeBlock? = nil,
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
    leftBrace: ExpressibleAsTokenSyntax = TokenSyntax.`leftBrace`,
    rightBrace: ExpressibleAsTokenSyntax = TokenSyntax.`rightBrace`,
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
    letOrVarKeyword: ExpressibleAsTokenSyntax,
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
    associatedValue: ExpressibleAsParameterClause? = nil,
    rawValue: ExpressibleAsInitializerClause? = nil,
    trailingComma: ExpressibleAsTokenSyntax? = nil
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
    caseKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`case`,
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
    enumKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`enum`,
    identifier: String,
    genericParameters: ExpressibleAsGenericParameterClause? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    members: ExpressibleAsMemberDeclBlock,
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
    operatorKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`operator`,
    identifier: ExpressibleAsTokenSyntax,
    operatorPrecedenceAndTypes: ExpressibleAsOperatorPrecedenceAndTypes? = nil,
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
    colon: ExpressibleAsTokenSyntax = TokenSyntax.`colon`,
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
    precedencegroupKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`precedencegroup`,
    identifier: String,
    leftBrace: ExpressibleAsTokenSyntax = TokenSyntax.`leftBrace`,
    rightBrace: ExpressibleAsTokenSyntax = TokenSyntax.`rightBrace`,
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
    colon: ExpressibleAsTokenSyntax = TokenSyntax.`colon`,
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
    trailingComma: ExpressibleAsTokenSyntax? = nil
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
    colon: ExpressibleAsTokenSyntax = TokenSyntax.`colon`,
    flag: ExpressibleAsTokenSyntax
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
    colon: ExpressibleAsTokenSyntax = TokenSyntax.`colon`,
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
    atSignToken: ExpressibleAsTokenSyntax = TokenSyntax.`atSign`,
    attributeName: ExpressibleAsTypeBuildable,
    leftParen: ExpressibleAsTokenSyntax? = nil,
    rightParen: ExpressibleAsTokenSyntax? = nil,
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
    atSignToken: ExpressibleAsTokenSyntax = TokenSyntax.`atSign`,
    attributeName: ExpressibleAsTokenSyntax,
    leftParen: ExpressibleAsTokenSyntax? = nil,
    argument: ExpressibleAsSyntaxBuildable? = nil,
    rightParen: ExpressibleAsTokenSyntax? = nil,
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

extension AvailabilityEntry {
  public init(
    label: String,
    colon: ExpressibleAsTokenSyntax = TokenSyntax.`colon`,
    semicolon: ExpressibleAsTokenSyntax = TokenSyntax.`semicolon`,
    @AvailabilitySpecListBuilder availabilityListBuilder: () -> AvailabilitySpecList = { .empty }
  ) {
    self.init(
      label: SyntaxFactory.makeIdentifier(label),
      colon: colon,
      availabilityList: availabilityListBuilder(),
      semicolon: semicolon
    )
  }
}

extension LabeledSpecializeEntry {
  public init(
    label: String,
    colon: ExpressibleAsTokenSyntax = TokenSyntax.`colon`,
    value: ExpressibleAsTokenSyntax,
    trailingComma: ExpressibleAsTokenSyntax? = nil
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
    colon: ExpressibleAsTokenSyntax = TokenSyntax.`colon`,
    delcname: ExpressibleAsDeclName,
    trailingComma: ExpressibleAsTokenSyntax? = nil
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
    colon: ExpressibleAsTokenSyntax? = nil
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
    diffKindComma: ExpressibleAsTokenSyntax? = nil,
    diffParams: ExpressibleAsDifferentiabilityParamsClause? = nil,
    diffParamsComma: ExpressibleAsTokenSyntax? = nil,
    whereClause: ExpressibleAsGenericWhereClause? = nil
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
    colon: ExpressibleAsTokenSyntax = TokenSyntax.`colon`,
    parameters: ExpressibleAsSyntaxBuildable
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
    leftParen: ExpressibleAsTokenSyntax = TokenSyntax.`leftParen`,
    rightParen: ExpressibleAsTokenSyntax = TokenSyntax.`rightParen`,
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
    colon: ExpressibleAsTokenSyntax = TokenSyntax.`colon`,
    originalDeclName: ExpressibleAsQualifiedDeclName,
    period: ExpressibleAsTokenSyntax? = nil,
    accessorKind: String?,
    comma: ExpressibleAsTokenSyntax? = nil,
    diffParams: ExpressibleAsDifferentiabilityParamsClause? = nil
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
    continueKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`continue`,
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
    labelColon: ExpressibleAsTokenSyntax? = nil,
    whileKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`while`,
    body: ExpressibleAsCodeBlock,
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
    labelColon: ExpressibleAsTokenSyntax? = nil,
    repeatKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`repeat`,
    body: ExpressibleAsCodeBlock,
    whileKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`while`,
    condition: ExpressibleAsExprBuildable
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
    guardKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`guard`,
    elseKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`else`,
    body: ExpressibleAsCodeBlock,
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
    labelColon: ExpressibleAsTokenSyntax? = nil,
    forKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`for`,
    tryKeyword: ExpressibleAsTokenSyntax? = nil,
    awaitKeyword: String?,
    caseKeyword: ExpressibleAsTokenSyntax? = nil,
    pattern: ExpressibleAsPatternBuildable,
    typeAnnotation: ExpressibleAsTypeAnnotation? = nil,
    inKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`in`,
    sequenceExpr: ExpressibleAsExprBuildable,
    whereClause: ExpressibleAsWhereClause? = nil,
    body: ExpressibleAsCodeBlock
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
    labelColon: ExpressibleAsTokenSyntax? = nil,
    switchKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`switch`,
    expression: ExpressibleAsExprBuildable,
    leftBrace: ExpressibleAsTokenSyntax = TokenSyntax.`leftBrace`,
    rightBrace: ExpressibleAsTokenSyntax = TokenSyntax.`rightBrace`,
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
    labelColon: ExpressibleAsTokenSyntax? = nil,
    doKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`do`,
    body: ExpressibleAsCodeBlock,
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
    leftParen: ExpressibleAsTokenSyntax = TokenSyntax.`leftParen`,
    trailingComma: ExpressibleAsTokenSyntax? = nil,
    rightParen: ExpressibleAsTokenSyntax = TokenSyntax.`rightParen`,
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
    breakKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`break`,
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
    poundAvailableKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`poundAvailable`,
    leftParen: ExpressibleAsTokenSyntax = TokenSyntax.`leftParen`,
    rightParen: ExpressibleAsTokenSyntax = TokenSyntax.`rightParen`,
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
    poundUnavailableKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`poundUnavailable`,
    leftParen: ExpressibleAsTokenSyntax = TokenSyntax.`leftParen`,
    rightParen: ExpressibleAsTokenSyntax = TokenSyntax.`rightParen`,
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
    labelColon: ExpressibleAsTokenSyntax? = nil,
    ifKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`if`,
    body: ExpressibleAsCodeBlock,
    elseKeyword: ExpressibleAsTokenSyntax? = nil,
    elseBody: ExpressibleAsSyntaxBuildable? = nil,
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
    unknownAttr: ExpressibleAsAttribute? = nil,
    label: ExpressibleAsSyntaxBuildable,
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
    caseKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`case`,
    colon: ExpressibleAsTokenSyntax = TokenSyntax.`colon`,
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
    catchKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`catch`,
    body: ExpressibleAsCodeBlock,
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
    poundAssert: ExpressibleAsTokenSyntax = TokenSyntax.`poundAssert`,
    leftParen: ExpressibleAsTokenSyntax = TokenSyntax.`leftParen`,
    condition: ExpressibleAsExprBuildable,
    comma: ExpressibleAsTokenSyntax? = nil,
    message: String?,
    rightParen: ExpressibleAsTokenSyntax = TokenSyntax.`rightParen`
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
    whereKeyword: ExpressibleAsTokenSyntax = TokenSyntax.`where`,
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
    colon: ExpressibleAsTokenSyntax? = nil,
    inheritedType: ExpressibleAsTypeBuildable? = nil,
    trailingComma: ExpressibleAsTokenSyntax? = nil,
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
    leftAngleBracket: ExpressibleAsTokenSyntax = TokenSyntax.`leftAngle`,
    rightAngleBracket: ExpressibleAsTokenSyntax = TokenSyntax.`rightAngle`,
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
    baseType: ExpressibleAsTypeBuildable,
    period: ExpressibleAsTokenSyntax = TokenSyntax.`period`,
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
    baseType: ExpressibleAsTypeBuildable
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
    leftParen: ExpressibleAsTokenSyntax = TokenSyntax.`leftParen`,
    rightParen: ExpressibleAsTokenSyntax = TokenSyntax.`rightParen`,
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
    leftParen: ExpressibleAsTokenSyntax = TokenSyntax.`leftParen`,
    rightParen: ExpressibleAsTokenSyntax = TokenSyntax.`rightParen`,
    asyncKeyword: String?,
    throwsOrRethrowsKeyword: ExpressibleAsTokenSyntax? = nil,
    arrow: ExpressibleAsTokenSyntax = TokenSyntax.`arrow`,
    returnType: ExpressibleAsTypeBuildable,
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
    specifier: ExpressibleAsTokenSyntax? = nil,
    baseType: ExpressibleAsTypeBuildable,
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
    leftAngleBracket: ExpressibleAsTokenSyntax = TokenSyntax.`leftAngle`,
    rightAngleBracket: ExpressibleAsTokenSyntax = TokenSyntax.`rightAngle`,
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
    type: ExpressibleAsTypeBuildable? = nil,
    period: ExpressibleAsTokenSyntax = TokenSyntax.`period`,
    caseName: String,
    associatedTuple: ExpressibleAsTuplePattern? = nil
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
    leftParen: ExpressibleAsTokenSyntax = TokenSyntax.`leftParen`,
    rightParen: ExpressibleAsTokenSyntax = TokenSyntax.`rightParen`,
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
    labelColon: ExpressibleAsTokenSyntax? = nil,
    pattern: ExpressibleAsPatternBuildable,
    trailingComma: ExpressibleAsTokenSyntax? = nil
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
    colon: ExpressibleAsTokenSyntax = TokenSyntax.`colon`,
    value: ExpressibleAsSyntaxBuildable
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
    version: ExpressibleAsVersionTuple? = nil
  ) {
    self.init(
      platform: SyntaxFactory.makeIdentifier(platform),
      version: version
    )
  }
}

extension VersionTuple {
  public init(
    majorMinor: ExpressibleAsSyntaxBuildable,
    patchPeriod: ExpressibleAsTokenSyntax? = nil,
    patchVersion: String?
  ) {
    self.init(
      majorMinor: majorMinor,
      patchPeriod: patchPeriod,
      patchVersion: patchVersion.map(TokenSyntax.integerLiteral)
    )
  }
}

