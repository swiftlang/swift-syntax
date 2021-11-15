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
    leftBrace: ExpressibleByTokenSyntax = TokenSyntax.`leftBrace`,
    rightBrace: ExpressibleByTokenSyntax = TokenSyntax.`rightBrace`,
    @CodeBlockItemListBuilder statementsBuilder: () -> ExpressibleByCodeBlockItemList = { CodeBlockItemList.empty }
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
    expression: ExpressibleByExprBuildable
  ) {
    self.init(
      awaitKeyword: SyntaxFactory.makeIdentifier(awaitKeyword),
      expression: expression
    )
  }
}

extension DeclNameArguments {
  public init(
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`,
    @DeclNameArgumentListBuilder argumentsBuilder: () -> ExpressibleByDeclNameArgumentList = { DeclNameArgumentList.empty }
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
    @ExprListBuilder elementsBuilder: () -> ExpressibleByExprList = { ExprList.empty }
  ) {
    self.init(
      elements: elementsBuilder()
    )
  }
}

extension SymbolicReferenceExpr {
  public init(
    identifier: String,
    genericArgumentClause: ExpressibleByGenericArgumentClause? = nil
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
    postfixExpression: ExpressibleByExprBuildable
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
    throwsToken: ExpressibleByTokenSyntax? = nil,
    arrowToken: ExpressibleByTokenSyntax = TokenSyntax.`arrow`
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
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`,
    @TupleExprElementListBuilder elementListBuilder: () -> ExpressibleByTupleExprElementList = { TupleExprElementList.empty }
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
    leftSquare: ExpressibleByTokenSyntax = TokenSyntax.`leftSquareBracket`,
    rightSquare: ExpressibleByTokenSyntax = TokenSyntax.`rightSquareBracket`,
    @ArrayElementListBuilder elementsBuilder: () -> ExpressibleByArrayElementList = { ArrayElementList.empty }
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
    assignToken: ExpressibleByTokenSyntax? = nil,
    expression: ExpressibleByExprBuildable,
    trailingComma: ExpressibleByTokenSyntax? = nil,
    @TokenListBuilder specifierBuilder: () -> ExpressibleByTokenList? = { nil }
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
    leftSquare: ExpressibleByTokenSyntax = TokenSyntax.`leftSquareBracket`,
    rightSquare: ExpressibleByTokenSyntax = TokenSyntax.`rightSquareBracket`,
    @ClosureCaptureItemListBuilder itemsBuilder: () -> ExpressibleByClosureCaptureItemList? = { nil }
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
    capture: ExpressibleByClosureCaptureSignature? = nil,
    input: ExpressibleBySyntaxBuildable? = nil,
    asyncKeyword: String?,
    throwsTok: ExpressibleByTokenSyntax? = nil,
    output: ExpressibleByReturnClause? = nil,
    inTok: ExpressibleByTokenSyntax = TokenSyntax.`in`,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleByAttributeList? = { nil }
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
    leftBrace: ExpressibleByTokenSyntax = TokenSyntax.`leftBrace`,
    signature: ExpressibleByClosureSignature? = nil,
    rightBrace: ExpressibleByTokenSyntax = TokenSyntax.`rightBrace`,
    @CodeBlockItemListBuilder statementsBuilder: () -> ExpressibleByCodeBlockItemList = { CodeBlockItemList.empty }
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
    calledExpression: ExpressibleByExprBuildable,
    leftParen: ExpressibleByTokenSyntax? = nil,
    rightParen: ExpressibleByTokenSyntax? = nil,
    trailingClosure: ExpressibleByClosureExpr? = nil,
    @TupleExprElementListBuilder argumentListBuilder: () -> ExpressibleByTupleExprElementList = { TupleExprElementList.empty },
    @MultipleTrailingClosureElementListBuilder additionalTrailingClosuresBuilder: () -> ExpressibleByMultipleTrailingClosureElementList? = { nil }
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
    calledExpression: ExpressibleByExprBuildable,
    leftBracket: ExpressibleByTokenSyntax = TokenSyntax.`leftSquareBracket`,
    rightBracket: ExpressibleByTokenSyntax = TokenSyntax.`rightSquareBracket`,
    trailingClosure: ExpressibleByClosureExpr? = nil,
    @TupleExprElementListBuilder argumentListBuilder: () -> ExpressibleByTupleExprElementList = { TupleExprElementList.empty },
    @MultipleTrailingClosureElementListBuilder additionalTrailingClosuresBuilder: () -> ExpressibleByMultipleTrailingClosureElementList? = { nil }
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
    expression: ExpressibleByExprBuildable,
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
    backslash: ExpressibleByTokenSyntax = TokenSyntax.`backslash`,
    delimiter: String?,
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`stringInterpolationAnchor`,
    @TupleExprElementListBuilder expressionsBuilder: () -> ExpressibleByTupleExprElementList = { TupleExprElementList.empty }
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
    openQuote: ExpressibleByTokenSyntax,
    closeQuote: ExpressibleByTokenSyntax,
    closeDelimiter: String?,
    @StringLiteralSegmentsBuilder segmentsBuilder: () -> ExpressibleByStringLiteralSegments = { StringLiteralSegments.empty }
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
    dot: ExpressibleByTokenSyntax? = nil
  ) {
    self.init(
      name: SyntaxFactory.makeIdentifier(name),
      dot: dot
    )
  }
}

extension ObjcKeyPathExpr {
  public init(
    keyPath: ExpressibleByTokenSyntax = TokenSyntax.`poundKeyPath`,
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`,
    @ObjcNameBuilder nameBuilder: () -> ExpressibleByObjcName = { ObjcName.empty }
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
    poundSelector: ExpressibleByTokenSyntax = TokenSyntax.`poundSelector`,
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    kind: String?,
    colon: ExpressibleByTokenSyntax? = nil,
    name: ExpressibleByExprBuildable,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`
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
    identifier: ExpressibleByTokenSyntax,
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`,
    @TupleExprElementListBuilder argumentsBuilder: () -> ExpressibleByTupleExprElementList = { TupleExprElementList.empty }
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
    typealiasKeyword: ExpressibleByTokenSyntax = TokenSyntax.`typealias`,
    identifier: String,
    genericParameterClause: ExpressibleByGenericParameterClause? = nil,
    initializer: ExpressibleByTypeInitializerClause? = nil,
    genericWhereClause: ExpressibleByGenericWhereClause? = nil,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleByAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleByModifierList? = { nil }
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
    associatedtypeKeyword: ExpressibleByTokenSyntax = TokenSyntax.`associatedtype`,
    identifier: String,
    inheritanceClause: ExpressibleByTypeInheritanceClause? = nil,
    initializer: ExpressibleByTypeInitializerClause? = nil,
    genericWhereClause: ExpressibleByGenericWhereClause? = nil,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleByAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleByModifierList? = { nil }
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
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`,
    @FunctionParameterListBuilder parameterListBuilder: () -> ExpressibleByFunctionParameterList = { FunctionParameterList.empty }
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
    input: ExpressibleByParameterClause,
    asyncOrReasyncKeyword: String?,
    throwsOrRethrowsKeyword: ExpressibleByTokenSyntax? = nil,
    output: ExpressibleByReturnClause? = nil
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
    poundEndif: ExpressibleByTokenSyntax = TokenSyntax.`poundEndif`,
    @IfConfigClauseListBuilder clausesBuilder: () -> ExpressibleByIfConfigClauseList = { IfConfigClauseList.empty }
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
    fileArgColon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    fileName: String,
    comma: ExpressibleByTokenSyntax = TokenSyntax.`comma`,
    lineArgLabel: String,
    lineArgColon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
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
    name: ExpressibleByTokenSyntax,
    detailLeftParen: ExpressibleByTokenSyntax? = nil,
    detail: String?,
    detailRightParen: ExpressibleByTokenSyntax? = nil
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
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    @InheritedTypeListBuilder inheritedTypeCollectionBuilder: () -> ExpressibleByInheritedTypeList = { InheritedTypeList.empty }
  ) {
    self.init(
      colon: colon,
      inheritedTypeCollection: inheritedTypeCollectionBuilder()
    )
  }
}

extension ClassDecl {
  public init(
    classOrActorKeyword: ExpressibleByTokenSyntax,
    identifier: String,
    genericParameterClause: ExpressibleByGenericParameterClause? = nil,
    inheritanceClause: ExpressibleByTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleByGenericWhereClause? = nil,
    members: ExpressibleByMemberDeclBlock,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleByAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleByModifierList? = { nil }
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
    structKeyword: ExpressibleByTokenSyntax = TokenSyntax.`struct`,
    identifier: String,
    genericParameterClause: ExpressibleByGenericParameterClause? = nil,
    inheritanceClause: ExpressibleByTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleByGenericWhereClause? = nil,
    members: ExpressibleByMemberDeclBlock,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleByAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleByModifierList? = { nil }
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
    protocolKeyword: ExpressibleByTokenSyntax = TokenSyntax.`protocol`,
    identifier: String,
    inheritanceClause: ExpressibleByTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleByGenericWhereClause? = nil,
    members: ExpressibleByMemberDeclBlock,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleByAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleByModifierList? = { nil }
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
    extensionKeyword: ExpressibleByTokenSyntax = TokenSyntax.`extension`,
    extendedType: ExpressibleByTypeBuildable,
    inheritanceClause: ExpressibleByTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleByGenericWhereClause? = nil,
    members: ExpressibleByMemberDeclBlock,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleByAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleByModifierList? = { nil }
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
    leftBrace: ExpressibleByTokenSyntax = TokenSyntax.`leftBrace`,
    rightBrace: ExpressibleByTokenSyntax = TokenSyntax.`rightBrace`,
    @MemberDeclListBuilder membersBuilder: () -> ExpressibleByMemberDeclList = { MemberDeclList.empty }
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
    eofToken: ExpressibleByTokenSyntax,
    @CodeBlockItemListBuilder statementsBuilder: () -> ExpressibleByCodeBlockItemList = { CodeBlockItemList.empty }
  ) {
    self.init(
      statements: statementsBuilder(),
      eofToken: eofToken
    )
  }
}

extension FunctionParameter {
  public init(
    firstName: ExpressibleByTokenSyntax? = nil,
    secondName: ExpressibleByTokenSyntax? = nil,
    colon: ExpressibleByTokenSyntax? = nil,
    type: ExpressibleByTypeBuildable? = nil,
    ellipsis: ExpressibleByTokenSyntax? = nil,
    defaultArgument: ExpressibleByInitializerClause? = nil,
    trailingComma: ExpressibleByTokenSyntax? = nil,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleByAttributeList? = { nil }
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
    funcKeyword: ExpressibleByTokenSyntax = TokenSyntax.`func`,
    identifier: ExpressibleByTokenSyntax,
    genericParameterClause: ExpressibleByGenericParameterClause? = nil,
    signature: ExpressibleByFunctionSignature,
    genericWhereClause: ExpressibleByGenericWhereClause? = nil,
    body: ExpressibleByCodeBlock? = nil,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleByAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleByModifierList? = { nil }
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
    initKeyword: ExpressibleByTokenSyntax = TokenSyntax.`init`,
    optionalMark: ExpressibleByTokenSyntax? = nil,
    genericParameterClause: ExpressibleByGenericParameterClause? = nil,
    parameters: ExpressibleByParameterClause,
    throwsOrRethrowsKeyword: ExpressibleByTokenSyntax? = nil,
    genericWhereClause: ExpressibleByGenericWhereClause? = nil,
    body: ExpressibleByCodeBlock? = nil,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleByAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleByModifierList? = { nil }
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
    deinitKeyword: ExpressibleByTokenSyntax = TokenSyntax.`deinit`,
    body: ExpressibleByCodeBlock,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleByAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleByModifierList? = { nil }
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
    subscriptKeyword: ExpressibleByTokenSyntax = TokenSyntax.`subscript`,
    genericParameterClause: ExpressibleByGenericParameterClause? = nil,
    indices: ExpressibleByParameterClause,
    result: ExpressibleByReturnClause,
    genericWhereClause: ExpressibleByGenericWhereClause? = nil,
    accessor: ExpressibleBySyntaxBuildable? = nil,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleByAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleByModifierList? = { nil }
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
    leftParen: ExpressibleByTokenSyntax? = nil,
    modifier: String?,
    rightParen: ExpressibleByTokenSyntax? = nil
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
    trailingDot: ExpressibleByTokenSyntax? = nil
  ) {
    self.init(
      name: SyntaxFactory.makeIdentifier(name),
      trailingDot: trailingDot
    )
  }
}

extension ImportDecl {
  public init(
    importTok: ExpressibleByTokenSyntax = TokenSyntax.`import`,
    importKind: ExpressibleByTokenSyntax? = nil,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleByAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleByModifierList? = { nil },
    @AccessPathBuilder pathBuilder: () -> ExpressibleByAccessPath = { AccessPath.empty }
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
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    name: String,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`
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
    modifier: ExpressibleByDeclModifier? = nil,
    accessorKind: ExpressibleByTokenSyntax,
    parameter: ExpressibleByAccessorParameter? = nil,
    asyncKeyword: String?,
    throwsKeyword: ExpressibleByTokenSyntax? = nil,
    body: ExpressibleByCodeBlock? = nil,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleByAttributeList? = { nil }
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
    leftBrace: ExpressibleByTokenSyntax = TokenSyntax.`leftBrace`,
    rightBrace: ExpressibleByTokenSyntax = TokenSyntax.`rightBrace`,
    @AccessorListBuilder accessorsBuilder: () -> ExpressibleByAccessorList = { AccessorList.empty }
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
    letOrVarKeyword: ExpressibleByTokenSyntax,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleByAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleByModifierList? = { nil },
    @PatternBindingListBuilder bindingsBuilder: () -> ExpressibleByPatternBindingList = { PatternBindingList.empty }
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
    associatedValue: ExpressibleByParameterClause? = nil,
    rawValue: ExpressibleByInitializerClause? = nil,
    trailingComma: ExpressibleByTokenSyntax? = nil
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
    caseKeyword: ExpressibleByTokenSyntax = TokenSyntax.`case`,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleByAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleByModifierList? = { nil },
    @EnumCaseElementListBuilder elementsBuilder: () -> ExpressibleByEnumCaseElementList = { EnumCaseElementList.empty }
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
    enumKeyword: ExpressibleByTokenSyntax = TokenSyntax.`enum`,
    identifier: String,
    genericParameters: ExpressibleByGenericParameterClause? = nil,
    inheritanceClause: ExpressibleByTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleByGenericWhereClause? = nil,
    members: ExpressibleByMemberDeclBlock,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleByAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleByModifierList? = { nil }
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
    operatorKeyword: ExpressibleByTokenSyntax = TokenSyntax.`operator`,
    identifier: ExpressibleByTokenSyntax,
    operatorPrecedenceAndTypes: ExpressibleByOperatorPrecedenceAndTypes? = nil,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleByAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleByModifierList? = { nil }
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
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    @IdentifierListBuilder precedenceGroupAndDesignatedTypesBuilder: () -> ExpressibleByIdentifierList = { IdentifierList.empty }
  ) {
    self.init(
      colon: colon,
      precedenceGroupAndDesignatedTypes: precedenceGroupAndDesignatedTypesBuilder()
    )
  }
}

extension PrecedenceGroupDecl {
  public init(
    precedencegroupKeyword: ExpressibleByTokenSyntax = TokenSyntax.`precedencegroup`,
    identifier: String,
    leftBrace: ExpressibleByTokenSyntax = TokenSyntax.`leftBrace`,
    rightBrace: ExpressibleByTokenSyntax = TokenSyntax.`rightBrace`,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleByAttributeList? = { nil },
    @ModifierListBuilder modifiersBuilder: () -> ExpressibleByModifierList? = { nil },
    @PrecedenceGroupAttributeListBuilder groupAttributesBuilder: () -> ExpressibleByPrecedenceGroupAttributeList = { PrecedenceGroupAttributeList.empty }
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
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    @PrecedenceGroupNameListBuilder otherNamesBuilder: () -> ExpressibleByPrecedenceGroupNameList = { PrecedenceGroupNameList.empty }
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
    trailingComma: ExpressibleByTokenSyntax? = nil
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
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    flag: ExpressibleByTokenSyntax
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
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
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
    atSignToken: ExpressibleByTokenSyntax = TokenSyntax.`atSign`,
    attributeName: ExpressibleByTypeBuildable,
    leftParen: ExpressibleByTokenSyntax? = nil,
    rightParen: ExpressibleByTokenSyntax? = nil,
    @TupleExprElementListBuilder argumentListBuilder: () -> ExpressibleByTupleExprElementList? = { nil }
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
    atSignToken: ExpressibleByTokenSyntax = TokenSyntax.`atSign`,
    attributeName: ExpressibleByTokenSyntax,
    leftParen: ExpressibleByTokenSyntax? = nil,
    argument: ExpressibleBySyntaxBuildable? = nil,
    rightParen: ExpressibleByTokenSyntax? = nil,
    @TokenListBuilder tokenListBuilder: () -> ExpressibleByTokenList? = { nil }
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
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    semicolon: ExpressibleByTokenSyntax = TokenSyntax.`semicolon`,
    @AvailabilitySpecListBuilder availabilityListBuilder: () -> ExpressibleByAvailabilitySpecList = { AvailabilitySpecList.empty }
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
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    value: ExpressibleByTokenSyntax,
    trailingComma: ExpressibleByTokenSyntax? = nil
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
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    delcname: ExpressibleByDeclName,
    trailingComma: ExpressibleByTokenSyntax? = nil
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
    colon: ExpressibleByTokenSyntax? = nil
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
    diffKindComma: ExpressibleByTokenSyntax? = nil,
    diffParams: ExpressibleByDifferentiabilityParamsClause? = nil,
    diffParamsComma: ExpressibleByTokenSyntax? = nil,
    whereClause: ExpressibleByGenericWhereClause? = nil
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
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    parameters: ExpressibleBySyntaxBuildable
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
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`,
    @DifferentiabilityParamListBuilder diffParamsBuilder: () -> ExpressibleByDifferentiabilityParamList = { DifferentiabilityParamList.empty }
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
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    originalDeclName: ExpressibleByQualifiedDeclName,
    period: ExpressibleByTokenSyntax? = nil,
    accessorKind: String?,
    comma: ExpressibleByTokenSyntax? = nil,
    diffParams: ExpressibleByDifferentiabilityParamsClause? = nil
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
    continueKeyword: ExpressibleByTokenSyntax = TokenSyntax.`continue`,
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
    labelColon: ExpressibleByTokenSyntax? = nil,
    whileKeyword: ExpressibleByTokenSyntax = TokenSyntax.`while`,
    body: ExpressibleByCodeBlock,
    @ConditionElementListBuilder conditionsBuilder: () -> ExpressibleByConditionElementList = { ConditionElementList.empty }
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
    labelColon: ExpressibleByTokenSyntax? = nil,
    repeatKeyword: ExpressibleByTokenSyntax = TokenSyntax.`repeat`,
    body: ExpressibleByCodeBlock,
    whileKeyword: ExpressibleByTokenSyntax = TokenSyntax.`while`,
    condition: ExpressibleByExprBuildable
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
    guardKeyword: ExpressibleByTokenSyntax = TokenSyntax.`guard`,
    elseKeyword: ExpressibleByTokenSyntax = TokenSyntax.`else`,
    body: ExpressibleByCodeBlock,
    @ConditionElementListBuilder conditionsBuilder: () -> ExpressibleByConditionElementList = { ConditionElementList.empty }
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
    labelColon: ExpressibleByTokenSyntax? = nil,
    forKeyword: ExpressibleByTokenSyntax = TokenSyntax.`for`,
    tryKeyword: ExpressibleByTokenSyntax? = nil,
    awaitKeyword: String?,
    caseKeyword: ExpressibleByTokenSyntax? = nil,
    pattern: ExpressibleByPatternBuildable,
    typeAnnotation: ExpressibleByTypeAnnotation? = nil,
    inKeyword: ExpressibleByTokenSyntax = TokenSyntax.`in`,
    sequenceExpr: ExpressibleByExprBuildable,
    whereClause: ExpressibleByWhereClause? = nil,
    body: ExpressibleByCodeBlock
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
    labelColon: ExpressibleByTokenSyntax? = nil,
    switchKeyword: ExpressibleByTokenSyntax = TokenSyntax.`switch`,
    expression: ExpressibleByExprBuildable,
    leftBrace: ExpressibleByTokenSyntax = TokenSyntax.`leftBrace`,
    rightBrace: ExpressibleByTokenSyntax = TokenSyntax.`rightBrace`,
    @SwitchCaseListBuilder casesBuilder: () -> ExpressibleBySwitchCaseList = { SwitchCaseList.empty }
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
    labelColon: ExpressibleByTokenSyntax? = nil,
    doKeyword: ExpressibleByTokenSyntax = TokenSyntax.`do`,
    body: ExpressibleByCodeBlock,
    @CatchClauseListBuilder catchClausesBuilder: () -> ExpressibleByCatchClauseList? = { nil }
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
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    trailingComma: ExpressibleByTokenSyntax? = nil,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`,
    @ExprListBuilder elementListBuilder: () -> ExpressibleByExprList = { ExprList.empty }
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
    breakKeyword: ExpressibleByTokenSyntax = TokenSyntax.`break`,
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
    poundAvailableKeyword: ExpressibleByTokenSyntax = TokenSyntax.`poundAvailable`,
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`,
    @AvailabilitySpecListBuilder availabilitySpecBuilder: () -> ExpressibleByAvailabilitySpecList = { AvailabilitySpecList.empty }
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
    poundUnavailableKeyword: ExpressibleByTokenSyntax = TokenSyntax.`poundUnavailable`,
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`,
    @AvailabilitySpecListBuilder availabilitySpecBuilder: () -> ExpressibleByAvailabilitySpecList = { AvailabilitySpecList.empty }
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
    labelColon: ExpressibleByTokenSyntax? = nil,
    ifKeyword: ExpressibleByTokenSyntax = TokenSyntax.`if`,
    body: ExpressibleByCodeBlock,
    elseKeyword: ExpressibleByTokenSyntax? = nil,
    elseBody: ExpressibleBySyntaxBuildable? = nil,
    @ConditionElementListBuilder conditionsBuilder: () -> ExpressibleByConditionElementList = { ConditionElementList.empty }
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
    unknownAttr: ExpressibleByAttribute? = nil,
    label: ExpressibleBySyntaxBuildable,
    @CodeBlockItemListBuilder statementsBuilder: () -> ExpressibleByCodeBlockItemList = { CodeBlockItemList.empty }
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
    caseKeyword: ExpressibleByTokenSyntax = TokenSyntax.`case`,
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    @CaseItemListBuilder caseItemsBuilder: () -> ExpressibleByCaseItemList = { CaseItemList.empty }
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
    catchKeyword: ExpressibleByTokenSyntax = TokenSyntax.`catch`,
    body: ExpressibleByCodeBlock,
    @CatchItemListBuilder catchItemsBuilder: () -> ExpressibleByCatchItemList? = { nil }
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
    poundAssert: ExpressibleByTokenSyntax = TokenSyntax.`poundAssert`,
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    condition: ExpressibleByExprBuildable,
    comma: ExpressibleByTokenSyntax? = nil,
    message: String?,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`
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
    whereKeyword: ExpressibleByTokenSyntax = TokenSyntax.`where`,
    @GenericRequirementListBuilder requirementListBuilder: () -> ExpressibleByGenericRequirementList = { GenericRequirementList.empty }
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
    colon: ExpressibleByTokenSyntax? = nil,
    inheritedType: ExpressibleByTypeBuildable? = nil,
    trailingComma: ExpressibleByTokenSyntax? = nil,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleByAttributeList? = { nil }
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
    leftAngleBracket: ExpressibleByTokenSyntax = TokenSyntax.`leftAngle`,
    rightAngleBracket: ExpressibleByTokenSyntax = TokenSyntax.`rightAngle`,
    @GenericParameterListBuilder genericParameterListBuilder: () -> ExpressibleByGenericParameterList = { GenericParameterList.empty }
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
    baseType: ExpressibleByTypeBuildable,
    period: ExpressibleByTokenSyntax = TokenSyntax.`period`,
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
    baseType: ExpressibleByTypeBuildable
  ) {
    self.init(
      someSpecifier: SyntaxFactory.makeIdentifier(someSpecifier),
      baseType: baseType
    )
  }
}

extension CompositionType {
  public init(
    @CompositionTypeElementListBuilder elementsBuilder: () -> ExpressibleByCompositionTypeElementList = { CompositionTypeElementList.empty }
  ) {
    self.init(
      elements: elementsBuilder()
    )
  }
}

extension TupleType {
  public init(
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`,
    @TupleTypeElementListBuilder elementsBuilder: () -> ExpressibleByTupleTypeElementList = { TupleTypeElementList.empty }
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
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`,
    asyncKeyword: String?,
    throwsOrRethrowsKeyword: ExpressibleByTokenSyntax? = nil,
    arrow: ExpressibleByTokenSyntax = TokenSyntax.`arrow`,
    returnType: ExpressibleByTypeBuildable,
    @TupleTypeElementListBuilder argumentsBuilder: () -> ExpressibleByTupleTypeElementList = { TupleTypeElementList.empty }
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
    specifier: ExpressibleByTokenSyntax? = nil,
    baseType: ExpressibleByTypeBuildable,
    @AttributeListBuilder attributesBuilder: () -> ExpressibleByAttributeList? = { nil }
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
    leftAngleBracket: ExpressibleByTokenSyntax = TokenSyntax.`leftAngle`,
    rightAngleBracket: ExpressibleByTokenSyntax = TokenSyntax.`rightAngle`,
    @GenericArgumentListBuilder argumentsBuilder: () -> ExpressibleByGenericArgumentList = { GenericArgumentList.empty }
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
    type: ExpressibleByTypeBuildable? = nil,
    period: ExpressibleByTokenSyntax = TokenSyntax.`period`,
    caseName: String,
    associatedTuple: ExpressibleByTuplePattern? = nil
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
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`,
    @TuplePatternElementListBuilder elementsBuilder: () -> ExpressibleByTuplePatternElementList = { TuplePatternElementList.empty }
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
    labelColon: ExpressibleByTokenSyntax? = nil,
    pattern: ExpressibleByPatternBuildable,
    trailingComma: ExpressibleByTokenSyntax? = nil
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
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    value: ExpressibleBySyntaxBuildable
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
    version: ExpressibleByVersionTuple? = nil
  ) {
    self.init(
      platform: SyntaxFactory.makeIdentifier(platform),
      version: version
    )
  }
}

extension VersionTuple {
  public init(
    majorMinor: ExpressibleBySyntaxBuildable,
    patchPeriod: ExpressibleByTokenSyntax? = nil,
    patchVersion: String?
  ) {
    self.init(
      majorMinor: majorMinor,
      patchPeriod: patchPeriod,
      patchVersion: patchVersion.map(TokenSyntax.integerLiteral)
    )
  }
}

