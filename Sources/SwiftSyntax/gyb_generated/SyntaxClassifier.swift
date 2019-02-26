//// Automatically Generated From SyntaxClassifier.swift.gyb.
//// Do Not Edit Directly!
//===------------ SyntaxClassifier.swift.gyb - Syntax Collection ----------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2018 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

public enum SyntaxClassification {
  /// The token should not receive syntax coloring. 
  case none
  /// A Swift keyword, including contextual keywords. 
  case keyword
  /// A generic identifier. 
  case identifier
  /// An identifier referring to a type. 
  case typeIdentifier
  /// An identifier starting with `$` like `$0`. 
  case dollarIdentifier
  /// An integer literal. 
  case integerLiteral
  /// A floating point literal. 
  case floatingLiteral
  /// A string literal including multiline string literals. 
  case stringLiteral
  /// The opening and closing paranthesis of string interpolation. 
  case stringInterpolationAnchor
  /// A `#` keyword like `#warning`. 
  case poundDirectiveKeyword
  /// A build configuration directive like `#if`, `#elseif`, `#else`. 
  case buildConfigId
  /// An attribute starting with an `@`. 
  case attribute
  /// An image, color, etc. literal. 
  case objectLiteral
  /// An editor placeholder of the form `<#content#>` 
  case editorPlaceholder
  /// A line comment starting with `//`. 
  case lineComment
  /// A doc line comment starting with `///`. 
  case docLineComment
  /// A block comment starting with `/**` and ending with `*/. 
  case blockComment
  /// A doc block comment starting with `/**` and ending with `*/. 
  case docBlockComment
}

fileprivate struct _SyntaxClassifier: SyntaxVisitor {

  /// The top of the `contextStack` determines the classification for all tokens
  /// encountered that do not have a native classification. If `force` is `true`
  /// the top of the stack also determines the classification of tokens with a
  /// native classification
  private var contextStack: [(classification: SyntaxClassification, force: Bool)] = 
      [(classification: .none, force: false)]

  /// The classifications that have determined so far are collected in this
  /// array.
  var classifications: [(TokenSyntax, SyntaxClassification)] = []

  mutating private func visit(
    _ node: Syntax, 
    classification: SyntaxClassification, 
    force: Bool = false
  ) {
    contextStack.append((classification: classification, force: force))
    node.walk(&self)
    contextStack.removeLast()
  }

  private func getContextFreeClassificationForTokenKind(_ tokenKind: TokenKind) 
      -> SyntaxClassification? {
    switch (tokenKind) {
    case .associatedtypeKeyword:
      return SyntaxClassification.keyword
    case .classKeyword:
      return SyntaxClassification.keyword
    case .deinitKeyword:
      return SyntaxClassification.keyword
    case .enumKeyword:
      return SyntaxClassification.keyword
    case .extensionKeyword:
      return SyntaxClassification.keyword
    case .funcKeyword:
      return SyntaxClassification.keyword
    case .importKeyword:
      return SyntaxClassification.keyword
    case .initKeyword:
      return SyntaxClassification.keyword
    case .inoutKeyword:
      return SyntaxClassification.keyword
    case .letKeyword:
      return SyntaxClassification.keyword
    case .operatorKeyword:
      return SyntaxClassification.keyword
    case .precedencegroupKeyword:
      return SyntaxClassification.keyword
    case .protocolKeyword:
      return SyntaxClassification.keyword
    case .structKeyword:
      return SyntaxClassification.keyword
    case .subscriptKeyword:
      return SyntaxClassification.keyword
    case .typealiasKeyword:
      return SyntaxClassification.keyword
    case .varKeyword:
      return SyntaxClassification.keyword
    case .fileprivateKeyword:
      return SyntaxClassification.keyword
    case .internalKeyword:
      return SyntaxClassification.keyword
    case .privateKeyword:
      return SyntaxClassification.keyword
    case .publicKeyword:
      return SyntaxClassification.keyword
    case .staticKeyword:
      return SyntaxClassification.keyword
    case .deferKeyword:
      return SyntaxClassification.keyword
    case .ifKeyword:
      return SyntaxClassification.keyword
    case .guardKeyword:
      return SyntaxClassification.keyword
    case .doKeyword:
      return SyntaxClassification.keyword
    case .repeatKeyword:
      return SyntaxClassification.keyword
    case .elseKeyword:
      return SyntaxClassification.keyword
    case .forKeyword:
      return SyntaxClassification.keyword
    case .inKeyword:
      return SyntaxClassification.keyword
    case .whileKeyword:
      return SyntaxClassification.keyword
    case .returnKeyword:
      return SyntaxClassification.keyword
    case .breakKeyword:
      return SyntaxClassification.keyword
    case .continueKeyword:
      return SyntaxClassification.keyword
    case .fallthroughKeyword:
      return SyntaxClassification.keyword
    case .switchKeyword:
      return SyntaxClassification.keyword
    case .caseKeyword:
      return SyntaxClassification.keyword
    case .defaultKeyword:
      return SyntaxClassification.keyword
    case .whereKeyword:
      return SyntaxClassification.keyword
    case .catchKeyword:
      return SyntaxClassification.keyword
    case .throwKeyword:
      return SyntaxClassification.keyword
    case .asKeyword:
      return SyntaxClassification.keyword
    case .anyKeyword:
      return SyntaxClassification.keyword
    case .falseKeyword:
      return SyntaxClassification.keyword
    case .isKeyword:
      return SyntaxClassification.keyword
    case .nilKeyword:
      return SyntaxClassification.keyword
    case .rethrowsKeyword:
      return SyntaxClassification.keyword
    case .superKeyword:
      return SyntaxClassification.keyword
    case .selfKeyword:
      return SyntaxClassification.keyword
    case .capitalSelfKeyword:
      return SyntaxClassification.keyword
    case .trueKeyword:
      return SyntaxClassification.keyword
    case .tryKeyword:
      return SyntaxClassification.keyword
    case .throwsKeyword:
      return SyntaxClassification.keyword
    case .__file__Keyword:
      return SyntaxClassification.keyword
    case .__line__Keyword:
      return SyntaxClassification.keyword
    case .__column__Keyword:
      return SyntaxClassification.keyword
    case .__function__Keyword:
      return SyntaxClassification.keyword
    case .__dso_handle__Keyword:
      return SyntaxClassification.keyword
    case .wildcardKeyword:
      return SyntaxClassification.keyword
    case .leftParen:
      return SyntaxClassification.none
    case .rightParen:
      return SyntaxClassification.none
    case .leftBrace:
      return SyntaxClassification.none
    case .rightBrace:
      return SyntaxClassification.none
    case .leftSquareBracket:
      return SyntaxClassification.none
    case .rightSquareBracket:
      return SyntaxClassification.none
    case .leftAngle:
      return SyntaxClassification.none
    case .rightAngle:
      return SyntaxClassification.none
    case .period:
      return SyntaxClassification.none
    case .prefixPeriod:
      return SyntaxClassification.none
    case .comma:
      return SyntaxClassification.none
    case .ellipsis:
      return SyntaxClassification.none
    case .colon:
      return SyntaxClassification.none
    case .semicolon:
      return SyntaxClassification.none
    case .equal:
      return SyntaxClassification.none
    case .atSign:
      return SyntaxClassification.attribute
    case .pound:
      return SyntaxClassification.none
    case .prefixAmpersand:
      return SyntaxClassification.none
    case .arrow:
      return SyntaxClassification.none
    case .backtick:
      return SyntaxClassification.none
    case .backslash:
      return SyntaxClassification.none
    case .exclamationMark:
      return SyntaxClassification.none
    case .postfixQuestionMark:
      return SyntaxClassification.none
    case .infixQuestionMark:
      return SyntaxClassification.none
    case .stringQuote:
      return SyntaxClassification.stringLiteral
    case .multilineStringQuote:
      return SyntaxClassification.stringLiteral
    case .poundKeyPathKeyword:
      return SyntaxClassification.keyword
    case .poundLineKeyword:
      return SyntaxClassification.keyword
    case .poundSelectorKeyword:
      return SyntaxClassification.keyword
    case .poundFileKeyword:
      return SyntaxClassification.keyword
    case .poundColumnKeyword:
      return SyntaxClassification.keyword
    case .poundFunctionKeyword:
      return SyntaxClassification.keyword
    case .poundDsohandleKeyword:
      return SyntaxClassification.keyword
    case .poundAssertKeyword:
      return SyntaxClassification.keyword
    case .poundSourceLocationKeyword:
      return SyntaxClassification.poundDirectiveKeyword
    case .poundWarningKeyword:
      return SyntaxClassification.poundDirectiveKeyword
    case .poundErrorKeyword:
      return SyntaxClassification.poundDirectiveKeyword
    case .poundIfKeyword:
      return SyntaxClassification.poundDirectiveKeyword
    case .poundElseKeyword:
      return SyntaxClassification.poundDirectiveKeyword
    case .poundElseifKeyword:
      return SyntaxClassification.poundDirectiveKeyword
    case .poundEndifKeyword:
      return SyntaxClassification.poundDirectiveKeyword
    case .poundAvailableKeyword:
      return SyntaxClassification.keyword
    case .poundFileLiteralKeyword:
      return SyntaxClassification.objectLiteral
    case .poundImageLiteralKeyword:
      return SyntaxClassification.objectLiteral
    case .poundColorLiteralKeyword:
      return SyntaxClassification.objectLiteral
    case .integerLiteral:
      return SyntaxClassification.integerLiteral
    case .floatingLiteral:
      return SyntaxClassification.floatingLiteral
    case .stringLiteral:
      return SyntaxClassification.stringLiteral
    case .unknown:
      return SyntaxClassification.none
    case .identifier:
      return nil
    case .unspacedBinaryOperator:
      return SyntaxClassification.none
    case .spacedBinaryOperator:
      return SyntaxClassification.none
    case .postfixOperator:
      return SyntaxClassification.none
    case .prefixOperator:
      return SyntaxClassification.none
    case .dollarIdentifier:
      return SyntaxClassification.dollarIdentifier
    case .contextualKeyword:
      return SyntaxClassification.keyword
    case .stringSegment:
      return SyntaxClassification.stringLiteral
    case .stringInterpolationAnchor:
      return SyntaxClassification.stringInterpolationAnchor
    case .yield:
      return SyntaxClassification.none
    case .eof:
      return SyntaxClassification.none
    }
  }

  mutating func visit(_ token: TokenSyntax) -> SyntaxVisitorContinueKind {
    assert(token.isPresent)
    // FIXME: We need to come up with some way in which the SyntaxClassifier can
    // classify trivia (i.e. comments). In particular we need to be able to
    // look into the comments to find things like URLs or keywords like MARK.
    var classification = contextStack.last!.classification
    if !contextStack.last!.force {
      if let contextFreeClassification = 
          getContextFreeClassificationForTokenKind(token.tokenKind) {
        classification = contextFreeClassification
      }
      if case .unknown = token.tokenKind, token.text.starts(with: "\"") {
        classification = .stringLiteral
      } else if case .identifier = token.tokenKind, 
          token.text.starts(with: "<#") && token.text.hasSuffix("#>") {
        classification = .editorPlaceholder
      }
    }
    classifications.append((token, classification))
    return .skipChildren
  }

  mutating func visit(_ node: UnknownDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: UnknownExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: UnknownStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: UnknownTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: UnknownPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: CodeBlockItemSyntax) -> SyntaxVisitorContinueKind {
    node.item.walk(&self)
    if let semicolon = node.semicolon { 
      semicolon.walk(&self)
    }
    if let errorTokens = node.errorTokens { 
      errorTokens.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: CodeBlockItemListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: CodeBlockSyntax) -> SyntaxVisitorContinueKind {
    node.leftBrace.walk(&self)
    node.statements.walk(&self)
    node.rightBrace.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: InOutExprSyntax) -> SyntaxVisitorContinueKind {
    node.ampersand.walk(&self)
    node.expression.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: PoundColumnExprSyntax) -> SyntaxVisitorContinueKind {
    node.poundColumn.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: FunctionCallArgumentListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: TupleElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: ArrayElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: DictionaryElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: StringInterpolationSegmentsSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: TryExprSyntax) -> SyntaxVisitorContinueKind {
    node.tryKeyword.walk(&self)
    if let questionOrExclamationMark = node.questionOrExclamationMark { 
      questionOrExclamationMark.walk(&self)
    }
    node.expression.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: DeclNameArgumentSyntax) -> SyntaxVisitorContinueKind {
    node.name.walk(&self)
    node.colon.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: DeclNameArgumentListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: DeclNameArgumentsSyntax) -> SyntaxVisitorContinueKind {
    node.leftParen.walk(&self)
    node.arguments.walk(&self)
    node.rightParen.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: IdentifierExprSyntax) -> SyntaxVisitorContinueKind {
    node.identifier.walk(&self)
    if let declNameArguments = node.declNameArguments { 
      declNameArguments.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: SuperRefExprSyntax) -> SyntaxVisitorContinueKind {
    node.superKeyword.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: NilLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    node.nilKeyword.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: DiscardAssignmentExprSyntax) -> SyntaxVisitorContinueKind {
    node.wildcard.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: AssignmentExprSyntax) -> SyntaxVisitorContinueKind {
    node.assignToken.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: SequenceExprSyntax) -> SyntaxVisitorContinueKind {
    node.elements.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: ExprListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: PoundLineExprSyntax) -> SyntaxVisitorContinueKind {
    node.poundLine.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: PoundFileExprSyntax) -> SyntaxVisitorContinueKind {
    node.poundFile.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: PoundFunctionExprSyntax) -> SyntaxVisitorContinueKind {
    node.poundFunction.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: PoundDsohandleExprSyntax) -> SyntaxVisitorContinueKind {
    node.poundDsohandle.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: SymbolicReferenceExprSyntax) -> SyntaxVisitorContinueKind {
    node.identifier.walk(&self)
    if let genericArgumentClause = node.genericArgumentClause { 
      genericArgumentClause.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: PrefixOperatorExprSyntax) -> SyntaxVisitorContinueKind {
    if let operatorToken = node.operatorToken { 
      operatorToken.walk(&self)
    }
    node.postfixExpression.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: BinaryOperatorExprSyntax) -> SyntaxVisitorContinueKind {
    node.operatorToken.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: ArrowExprSyntax) -> SyntaxVisitorContinueKind {
    if let throwsToken = node.throwsToken { 
      throwsToken.walk(&self)
    }
    node.arrowToken.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: FloatLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    node.floatingDigits.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: TupleExprSyntax) -> SyntaxVisitorContinueKind {
    node.leftParen.walk(&self)
    node.elementList.walk(&self)
    node.rightParen.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: ArrayExprSyntax) -> SyntaxVisitorContinueKind {
    node.leftSquare.walk(&self)
    node.elements.walk(&self)
    node.rightSquare.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: DictionaryExprSyntax) -> SyntaxVisitorContinueKind {
    node.leftSquare.walk(&self)
    node.content.walk(&self)
    node.rightSquare.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: FunctionCallArgumentSyntax) -> SyntaxVisitorContinueKind {
    if let label = node.label { 
      label.walk(&self)
    }
    if let colon = node.colon { 
      colon.walk(&self)
    }
    node.expression.walk(&self)
    if let trailingComma = node.trailingComma { 
      trailingComma.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: TupleElementSyntax) -> SyntaxVisitorContinueKind {
    if let label = node.label { 
      label.walk(&self)
    }
    if let colon = node.colon { 
      colon.walk(&self)
    }
    node.expression.walk(&self)
    if let trailingComma = node.trailingComma { 
      trailingComma.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: ArrayElementSyntax) -> SyntaxVisitorContinueKind {
    node.expression.walk(&self)
    if let trailingComma = node.trailingComma { 
      trailingComma.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: DictionaryElementSyntax) -> SyntaxVisitorContinueKind {
    node.keyExpression.walk(&self)
    node.colon.walk(&self)
    node.valueExpression.walk(&self)
    if let trailingComma = node.trailingComma { 
      trailingComma.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: IntegerLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    node.digits.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: StringLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    node.stringLiteral.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: BooleanLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    node.booleanLiteral.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: TernaryExprSyntax) -> SyntaxVisitorContinueKind {
    node.conditionExpression.walk(&self)
    node.questionMark.walk(&self)
    node.firstChoice.walk(&self)
    node.colonMark.walk(&self)
    node.secondChoice.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: MemberAccessExprSyntax) -> SyntaxVisitorContinueKind {
    if let base = node.base { 
      base.walk(&self)
    }
    node.dot.walk(&self)
    node.name.walk(&self)
    if let declNameArguments = node.declNameArguments { 
      declNameArguments.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: IsExprSyntax) -> SyntaxVisitorContinueKind {
    node.isTok.walk(&self)
    node.typeName.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: AsExprSyntax) -> SyntaxVisitorContinueKind {
    node.asTok.walk(&self)
    if let questionOrExclamationMark = node.questionOrExclamationMark { 
      questionOrExclamationMark.walk(&self)
    }
    node.typeName.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: TypeExprSyntax) -> SyntaxVisitorContinueKind {
    node.type.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: ClosureCaptureItemSyntax) -> SyntaxVisitorContinueKind {
    if let specifier = node.specifier { 
      specifier.walk(&self)
    }
    if let name = node.name { 
      name.walk(&self)
    }
    if let assignToken = node.assignToken { 
      assignToken.walk(&self)
    }
    node.expression.walk(&self)
    if let trailingComma = node.trailingComma { 
      trailingComma.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: ClosureCaptureItemListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: ClosureCaptureSignatureSyntax) -> SyntaxVisitorContinueKind {
    node.leftSquare.walk(&self)
    if let items = node.items { 
      items.walk(&self)
    }
    node.rightSquare.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: ClosureParamSyntax) -> SyntaxVisitorContinueKind {
    node.name.walk(&self)
    if let trailingComma = node.trailingComma { 
      trailingComma.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: ClosureParamListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: ClosureSignatureSyntax) -> SyntaxVisitorContinueKind {
    if let capture = node.capture { 
      capture.walk(&self)
    }
    if let input = node.input { 
      input.walk(&self)
    }
    if let throwsTok = node.throwsTok { 
      throwsTok.walk(&self)
    }
    if let output = node.output { 
      output.walk(&self)
    }
    node.inTok.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: ClosureExprSyntax) -> SyntaxVisitorContinueKind {
    node.leftBrace.walk(&self)
    if let signature = node.signature { 
      signature.walk(&self)
    }
    node.statements.walk(&self)
    node.rightBrace.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: UnresolvedPatternExprSyntax) -> SyntaxVisitorContinueKind {
    node.pattern.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: FunctionCallExprSyntax) -> SyntaxVisitorContinueKind {
    node.calledExpression.walk(&self)
    if let leftParen = node.leftParen { 
      leftParen.walk(&self)
    }
    node.argumentList.walk(&self)
    if let rightParen = node.rightParen { 
      rightParen.walk(&self)
    }
    if let trailingClosure = node.trailingClosure { 
      trailingClosure.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: SubscriptExprSyntax) -> SyntaxVisitorContinueKind {
    node.calledExpression.walk(&self)
    node.leftBracket.walk(&self)
    node.argumentList.walk(&self)
    node.rightBracket.walk(&self)
    if let trailingClosure = node.trailingClosure { 
      trailingClosure.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: OptionalChainingExprSyntax) -> SyntaxVisitorContinueKind {
    node.expression.walk(&self)
    node.questionMark.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: ForcedValueExprSyntax) -> SyntaxVisitorContinueKind {
    node.expression.walk(&self)
    node.exclamationMark.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: PostfixUnaryExprSyntax) -> SyntaxVisitorContinueKind {
    node.expression.walk(&self)
    node.operatorToken.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: SpecializeExprSyntax) -> SyntaxVisitorContinueKind {
    node.expression.walk(&self)
    node.genericArgumentClause.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: StringSegmentSyntax) -> SyntaxVisitorContinueKind {
    node.content.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: ExpressionSegmentSyntax) -> SyntaxVisitorContinueKind {
    node.backslash.walk(&self)
    visit(node.leftParen, 
          classification: .stringInterpolationAnchor, 
          force: true)
    node.expression.walk(&self)
    node.rightParen.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: StringInterpolationExprSyntax) -> SyntaxVisitorContinueKind {
    node.openQuote.walk(&self)
    node.segments.walk(&self)
    node.closeQuote.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: KeyPathExprSyntax) -> SyntaxVisitorContinueKind {
    node.backslash.walk(&self)
    if let rootExpr = node.rootExpr { 
      rootExpr.walk(&self)
    }
    node.expression.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: KeyPathBaseExprSyntax) -> SyntaxVisitorContinueKind {
    node.period.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: ObjcNamePieceSyntax) -> SyntaxVisitorContinueKind {
    node.name.walk(&self)
    if let dot = node.dot { 
      dot.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: ObjcNameSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: ObjcKeyPathExprSyntax) -> SyntaxVisitorContinueKind {
    node.keyPath.walk(&self)
    node.leftParen.walk(&self)
    node.name.walk(&self)
    node.rightParen.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: ObjcSelectorExprSyntax) -> SyntaxVisitorContinueKind {
    node.poundSelector.walk(&self)
    node.leftParen.walk(&self)
    if let kind = node.kind { 
      kind.walk(&self)
    }
    if let colon = node.colon { 
      colon.walk(&self)
    }
    node.name.walk(&self)
    node.rightParen.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: EditorPlaceholderExprSyntax) -> SyntaxVisitorContinueKind {
    node.identifier.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: ObjectLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    node.identifier.walk(&self)
    node.leftParen.walk(&self)
    node.arguments.walk(&self)
    node.rightParen.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: TypeInitializerClauseSyntax) -> SyntaxVisitorContinueKind {
    node.equal.walk(&self)
    node.value.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: TypealiasDeclSyntax) -> SyntaxVisitorContinueKind {
    if let attributes = node.attributes { 
      attributes.walk(&self)
    }
    if let modifiers = node.modifiers { 
      modifiers.walk(&self)
    }
    node.typealiasKeyword.walk(&self)
    node.identifier.walk(&self)
    if let genericParameterClause = node.genericParameterClause { 
      genericParameterClause.walk(&self)
    }
    if let initializer = node.initializer { 
      initializer.walk(&self)
    }
    if let genericWhereClause = node.genericWhereClause { 
      genericWhereClause.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: AssociatedtypeDeclSyntax) -> SyntaxVisitorContinueKind {
    if let attributes = node.attributes { 
      attributes.walk(&self)
    }
    if let modifiers = node.modifiers { 
      modifiers.walk(&self)
    }
    node.associatedtypeKeyword.walk(&self)
    node.identifier.walk(&self)
    if let inheritanceClause = node.inheritanceClause { 
      inheritanceClause.walk(&self)
    }
    if let initializer = node.initializer { 
      initializer.walk(&self)
    }
    if let genericWhereClause = node.genericWhereClause { 
      genericWhereClause.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: FunctionParameterListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: ParameterClauseSyntax) -> SyntaxVisitorContinueKind {
    node.leftParen.walk(&self)
    node.parameterList.walk(&self)
    node.rightParen.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: ReturnClauseSyntax) -> SyntaxVisitorContinueKind {
    node.arrow.walk(&self)
    node.returnType.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: FunctionSignatureSyntax) -> SyntaxVisitorContinueKind {
    node.input.walk(&self)
    if let throwsOrRethrowsKeyword = node.throwsOrRethrowsKeyword { 
      throwsOrRethrowsKeyword.walk(&self)
    }
    if let output = node.output { 
      output.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: IfConfigClauseSyntax) -> SyntaxVisitorContinueKind {
    visit(node.poundKeyword, 
          classification: .buildConfigId, 
          force: false)
    if let condition = node.condition { 
      visit(condition, 
            classification: .buildConfigId, 
            force: false)
    }
    node.elements.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: IfConfigClauseListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: IfConfigDeclSyntax) -> SyntaxVisitorContinueKind {
    node.clauses.walk(&self)
    visit(node.poundEndif, 
          classification: .buildConfigId, 
          force: false)
    return .skipChildren
  }
  mutating func visit(_ node: PoundErrorDeclSyntax) -> SyntaxVisitorContinueKind {
    node.poundError.walk(&self)
    node.leftParen.walk(&self)
    node.message.walk(&self)
    node.rightParen.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: PoundWarningDeclSyntax) -> SyntaxVisitorContinueKind {
    node.poundWarning.walk(&self)
    node.leftParen.walk(&self)
    node.message.walk(&self)
    node.rightParen.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: PoundSourceLocationSyntax) -> SyntaxVisitorContinueKind {
    node.poundSourceLocation.walk(&self)
    node.leftParen.walk(&self)
    if let args = node.args { 
      args.walk(&self)
    }
    node.rightParen.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: PoundSourceLocationArgsSyntax) -> SyntaxVisitorContinueKind {
    node.fileArgLabel.walk(&self)
    node.fileArgColon.walk(&self)
    node.fileName.walk(&self)
    node.comma.walk(&self)
    node.lineArgLabel.walk(&self)
    node.lineArgColon.walk(&self)
    node.lineNumber.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: DeclModifierSyntax) -> SyntaxVisitorContinueKind {
    visit(node.name, 
          classification: .attribute, 
          force: false)
    if let detailLeftParen = node.detailLeftParen { 
      detailLeftParen.walk(&self)
    }
    if let detail = node.detail { 
      detail.walk(&self)
    }
    if let detailRightParen = node.detailRightParen { 
      detailRightParen.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: InheritedTypeSyntax) -> SyntaxVisitorContinueKind {
    node.typeName.walk(&self)
    if let trailingComma = node.trailingComma { 
      trailingComma.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: InheritedTypeListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: TypeInheritanceClauseSyntax) -> SyntaxVisitorContinueKind {
    node.colon.walk(&self)
    node.inheritedTypeCollection.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
    if let attributes = node.attributes { 
      attributes.walk(&self)
    }
    if let modifiers = node.modifiers { 
      modifiers.walk(&self)
    }
    node.classKeyword.walk(&self)
    node.identifier.walk(&self)
    if let genericParameterClause = node.genericParameterClause { 
      genericParameterClause.walk(&self)
    }
    if let inheritanceClause = node.inheritanceClause { 
      inheritanceClause.walk(&self)
    }
    if let genericWhereClause = node.genericWhereClause { 
      genericWhereClause.walk(&self)
    }
    node.members.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
    if let attributes = node.attributes { 
      attributes.walk(&self)
    }
    if let modifiers = node.modifiers { 
      modifiers.walk(&self)
    }
    node.structKeyword.walk(&self)
    node.identifier.walk(&self)
    if let genericParameterClause = node.genericParameterClause { 
      genericParameterClause.walk(&self)
    }
    if let inheritanceClause = node.inheritanceClause { 
      inheritanceClause.walk(&self)
    }
    if let genericWhereClause = node.genericWhereClause { 
      genericWhereClause.walk(&self)
    }
    node.members.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
    if let attributes = node.attributes { 
      attributes.walk(&self)
    }
    if let modifiers = node.modifiers { 
      modifiers.walk(&self)
    }
    node.protocolKeyword.walk(&self)
    node.identifier.walk(&self)
    if let inheritanceClause = node.inheritanceClause { 
      inheritanceClause.walk(&self)
    }
    if let genericWhereClause = node.genericWhereClause { 
      genericWhereClause.walk(&self)
    }
    node.members.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: ExtensionDeclSyntax) -> SyntaxVisitorContinueKind {
    if let attributes = node.attributes { 
      attributes.walk(&self)
    }
    if let modifiers = node.modifiers { 
      modifiers.walk(&self)
    }
    node.extensionKeyword.walk(&self)
    node.extendedType.walk(&self)
    if let inheritanceClause = node.inheritanceClause { 
      inheritanceClause.walk(&self)
    }
    if let genericWhereClause = node.genericWhereClause { 
      genericWhereClause.walk(&self)
    }
    node.members.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: MemberDeclBlockSyntax) -> SyntaxVisitorContinueKind {
    node.leftBrace.walk(&self)
    node.members.walk(&self)
    node.rightBrace.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: MemberDeclListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: MemberDeclListItemSyntax) -> SyntaxVisitorContinueKind {
    node.decl.walk(&self)
    if let semicolon = node.semicolon { 
      semicolon.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: SourceFileSyntax) -> SyntaxVisitorContinueKind {
    node.statements.walk(&self)
    node.eofToken.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: InitializerClauseSyntax) -> SyntaxVisitorContinueKind {
    node.equal.walk(&self)
    node.value.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: FunctionParameterSyntax) -> SyntaxVisitorContinueKind {
    if let attributes = node.attributes { 
      attributes.walk(&self)
    }
    if let firstName = node.firstName { 
      firstName.walk(&self)
    }
    if let secondName = node.secondName { 
      secondName.walk(&self)
    }
    if let colon = node.colon { 
      colon.walk(&self)
    }
    if let type = node.type { 
      type.walk(&self)
    }
    if let ellipsis = node.ellipsis { 
      ellipsis.walk(&self)
    }
    if let defaultArgument = node.defaultArgument { 
      defaultArgument.walk(&self)
    }
    if let trailingComma = node.trailingComma { 
      trailingComma.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: ModifierListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
    if let attributes = node.attributes { 
      attributes.walk(&self)
    }
    if let modifiers = node.modifiers { 
      modifiers.walk(&self)
    }
    node.funcKeyword.walk(&self)
    node.identifier.walk(&self)
    if let genericParameterClause = node.genericParameterClause { 
      genericParameterClause.walk(&self)
    }
    node.signature.walk(&self)
    if let genericWhereClause = node.genericWhereClause { 
      genericWhereClause.walk(&self)
    }
    if let body = node.body { 
      body.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: InitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    if let attributes = node.attributes { 
      attributes.walk(&self)
    }
    if let modifiers = node.modifiers { 
      modifiers.walk(&self)
    }
    node.initKeyword.walk(&self)
    if let optionalMark = node.optionalMark { 
      optionalMark.walk(&self)
    }
    if let genericParameterClause = node.genericParameterClause { 
      genericParameterClause.walk(&self)
    }
    node.parameters.walk(&self)
    if let throwsOrRethrowsKeyword = node.throwsOrRethrowsKeyword { 
      throwsOrRethrowsKeyword.walk(&self)
    }
    if let genericWhereClause = node.genericWhereClause { 
      genericWhereClause.walk(&self)
    }
    if let body = node.body { 
      body.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: DeinitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    if let attributes = node.attributes { 
      attributes.walk(&self)
    }
    if let modifiers = node.modifiers { 
      modifiers.walk(&self)
    }
    node.deinitKeyword.walk(&self)
    node.body.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: SubscriptDeclSyntax) -> SyntaxVisitorContinueKind {
    if let attributes = node.attributes { 
      attributes.walk(&self)
    }
    if let modifiers = node.modifiers { 
      modifiers.walk(&self)
    }
    node.subscriptKeyword.walk(&self)
    if let genericParameterClause = node.genericParameterClause { 
      genericParameterClause.walk(&self)
    }
    node.indices.walk(&self)
    node.result.walk(&self)
    if let genericWhereClause = node.genericWhereClause { 
      genericWhereClause.walk(&self)
    }
    if let accessor = node.accessor { 
      accessor.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: AccessLevelModifierSyntax) -> SyntaxVisitorContinueKind {
    node.name.walk(&self)
    if let leftParen = node.leftParen { 
      leftParen.walk(&self)
    }
    if let modifier = node.modifier { 
      modifier.walk(&self)
    }
    if let rightParen = node.rightParen { 
      rightParen.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: AccessPathComponentSyntax) -> SyntaxVisitorContinueKind {
    node.name.walk(&self)
    if let trailingDot = node.trailingDot { 
      trailingDot.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: AccessPathSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: ImportDeclSyntax) -> SyntaxVisitorContinueKind {
    if let attributes = node.attributes { 
      attributes.walk(&self)
    }
    if let modifiers = node.modifiers { 
      modifiers.walk(&self)
    }
    node.importTok.walk(&self)
    if let importKind = node.importKind { 
      importKind.walk(&self)
    }
    node.path.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: AccessorParameterSyntax) -> SyntaxVisitorContinueKind {
    node.leftParen.walk(&self)
    node.name.walk(&self)
    node.rightParen.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: AccessorDeclSyntax) -> SyntaxVisitorContinueKind {
    if let attributes = node.attributes { 
      attributes.walk(&self)
    }
    if let modifier = node.modifier { 
      modifier.walk(&self)
    }
    node.accessorKind.walk(&self)
    if let parameter = node.parameter { 
      parameter.walk(&self)
    }
    if let body = node.body { 
      body.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: AccessorListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: AccessorBlockSyntax) -> SyntaxVisitorContinueKind {
    node.leftBrace.walk(&self)
    node.accessors.walk(&self)
    node.rightBrace.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: PatternBindingSyntax) -> SyntaxVisitorContinueKind {
    node.pattern.walk(&self)
    if let typeAnnotation = node.typeAnnotation { 
      typeAnnotation.walk(&self)
    }
    if let initializer = node.initializer { 
      initializer.walk(&self)
    }
    if let accessor = node.accessor { 
      accessor.walk(&self)
    }
    if let trailingComma = node.trailingComma { 
      trailingComma.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: PatternBindingListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
    if let attributes = node.attributes { 
      attributes.walk(&self)
    }
    if let modifiers = node.modifiers { 
      modifiers.walk(&self)
    }
    node.letOrVarKeyword.walk(&self)
    node.bindings.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: EnumCaseElementSyntax) -> SyntaxVisitorContinueKind {
    node.identifier.walk(&self)
    if let associatedValue = node.associatedValue { 
      associatedValue.walk(&self)
    }
    if let rawValue = node.rawValue { 
      rawValue.walk(&self)
    }
    if let trailingComma = node.trailingComma { 
      trailingComma.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: EnumCaseElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: EnumCaseDeclSyntax) -> SyntaxVisitorContinueKind {
    if let attributes = node.attributes { 
      attributes.walk(&self)
    }
    if let modifiers = node.modifiers { 
      modifiers.walk(&self)
    }
    node.caseKeyword.walk(&self)
    node.elements.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
    if let attributes = node.attributes { 
      attributes.walk(&self)
    }
    if let modifiers = node.modifiers { 
      modifiers.walk(&self)
    }
    node.enumKeyword.walk(&self)
    node.identifier.walk(&self)
    if let genericParameters = node.genericParameters { 
      genericParameters.walk(&self)
    }
    if let inheritanceClause = node.inheritanceClause { 
      inheritanceClause.walk(&self)
    }
    if let genericWhereClause = node.genericWhereClause { 
      genericWhereClause.walk(&self)
    }
    node.members.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: OperatorDeclSyntax) -> SyntaxVisitorContinueKind {
    if let attributes = node.attributes { 
      attributes.walk(&self)
    }
    if let modifiers = node.modifiers { 
      visit(modifiers, 
            classification: .attribute, 
            force: false)
    }
    node.operatorKeyword.walk(&self)
    node.identifier.walk(&self)
    if let operatorPrecedenceAndTypes = node.operatorPrecedenceAndTypes { 
      operatorPrecedenceAndTypes.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: IdentifierListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: OperatorPrecedenceAndTypesSyntax) -> SyntaxVisitorContinueKind {
    node.colon.walk(&self)
    node.precedenceGroupAndDesignatedTypes.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: PrecedenceGroupDeclSyntax) -> SyntaxVisitorContinueKind {
    if let attributes = node.attributes { 
      attributes.walk(&self)
    }
    if let modifiers = node.modifiers { 
      modifiers.walk(&self)
    }
    node.precedencegroupKeyword.walk(&self)
    node.identifier.walk(&self)
    node.leftBrace.walk(&self)
    node.groupAttributes.walk(&self)
    node.rightBrace.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: PrecedenceGroupAttributeListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: PrecedenceGroupRelationSyntax) -> SyntaxVisitorContinueKind {
    visit(node.higherThanOrLowerThan, 
          classification: .keyword, 
          force: false)
    node.colon.walk(&self)
    node.otherNames.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: PrecedenceGroupNameListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: PrecedenceGroupNameElementSyntax) -> SyntaxVisitorContinueKind {
    node.name.walk(&self)
    if let trailingComma = node.trailingComma { 
      trailingComma.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: PrecedenceGroupAssignmentSyntax) -> SyntaxVisitorContinueKind {
    node.assignmentKeyword.walk(&self)
    node.colon.walk(&self)
    node.flag.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: PrecedenceGroupAssociativitySyntax) -> SyntaxVisitorContinueKind {
    visit(node.associativityKeyword, 
          classification: .keyword, 
          force: false)
    node.colon.walk(&self)
    node.value.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: TokenListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: NonEmptyTokenListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: AttributeSyntax) -> SyntaxVisitorContinueKind {
    node.atSignToken.walk(&self)
    visit(node.attributeName, 
          classification: .attribute, 
          force: false)
    if let leftParen = node.leftParen { 
      leftParen.walk(&self)
    }
    if let argument = node.argument { 
      argument.walk(&self)
    }
    if let rightParen = node.rightParen { 
      rightParen.walk(&self)
    }
    if let tokenList = node.tokenList { 
      tokenList.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: AttributeListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: SpecializeAttributeSpecListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: LabeledSpecializeEntrySyntax) -> SyntaxVisitorContinueKind {
    node.label.walk(&self)
    node.colon.walk(&self)
    node.value.walk(&self)
    if let trailingComma = node.trailingComma { 
      trailingComma.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: NamedAttributeStringArgumentSyntax) -> SyntaxVisitorContinueKind {
    node.nameTok.walk(&self)
    node.colon.walk(&self)
    node.stringOrDeclname.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: DeclNameSyntax) -> SyntaxVisitorContinueKind {
    node.declBaseName.walk(&self)
    if let declNameArguments = node.declNameArguments { 
      declNameArguments.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: ImplementsAttributeArgumentsSyntax) -> SyntaxVisitorContinueKind {
    node.type.walk(&self)
    node.comma.walk(&self)
    node.declBaseName.walk(&self)
    if let declNameArguments = node.declNameArguments { 
      declNameArguments.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: ObjCSelectorPieceSyntax) -> SyntaxVisitorContinueKind {
    if let name = node.name { 
      name.walk(&self)
    }
    if let colon = node.colon { 
      colon.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: ObjCSelectorSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: ContinueStmtSyntax) -> SyntaxVisitorContinueKind {
    node.continueKeyword.walk(&self)
    if let label = node.label { 
      label.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: WhileStmtSyntax) -> SyntaxVisitorContinueKind {
    if let labelName = node.labelName { 
      labelName.walk(&self)
    }
    if let labelColon = node.labelColon { 
      labelColon.walk(&self)
    }
    node.whileKeyword.walk(&self)
    node.conditions.walk(&self)
    node.body.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: DeferStmtSyntax) -> SyntaxVisitorContinueKind {
    node.deferKeyword.walk(&self)
    node.body.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: ExpressionStmtSyntax) -> SyntaxVisitorContinueKind {
    node.expression.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: SwitchCaseListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: RepeatWhileStmtSyntax) -> SyntaxVisitorContinueKind {
    if let labelName = node.labelName { 
      labelName.walk(&self)
    }
    if let labelColon = node.labelColon { 
      labelColon.walk(&self)
    }
    node.repeatKeyword.walk(&self)
    node.body.walk(&self)
    node.whileKeyword.walk(&self)
    node.condition.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: GuardStmtSyntax) -> SyntaxVisitorContinueKind {
    node.guardKeyword.walk(&self)
    node.conditions.walk(&self)
    node.elseKeyword.walk(&self)
    node.body.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: WhereClauseSyntax) -> SyntaxVisitorContinueKind {
    node.whereKeyword.walk(&self)
    node.guardResult.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: ForInStmtSyntax) -> SyntaxVisitorContinueKind {
    if let labelName = node.labelName { 
      labelName.walk(&self)
    }
    if let labelColon = node.labelColon { 
      labelColon.walk(&self)
    }
    node.forKeyword.walk(&self)
    if let caseKeyword = node.caseKeyword { 
      caseKeyword.walk(&self)
    }
    node.pattern.walk(&self)
    if let typeAnnotation = node.typeAnnotation { 
      typeAnnotation.walk(&self)
    }
    node.inKeyword.walk(&self)
    node.sequenceExpr.walk(&self)
    if let whereClause = node.whereClause { 
      whereClause.walk(&self)
    }
    node.body.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: SwitchStmtSyntax) -> SyntaxVisitorContinueKind {
    if let labelName = node.labelName { 
      labelName.walk(&self)
    }
    if let labelColon = node.labelColon { 
      labelColon.walk(&self)
    }
    node.switchKeyword.walk(&self)
    node.expression.walk(&self)
    node.leftBrace.walk(&self)
    node.cases.walk(&self)
    node.rightBrace.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: CatchClauseListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: DoStmtSyntax) -> SyntaxVisitorContinueKind {
    if let labelName = node.labelName { 
      labelName.walk(&self)
    }
    if let labelColon = node.labelColon { 
      labelColon.walk(&self)
    }
    node.doKeyword.walk(&self)
    node.body.walk(&self)
    if let catchClauses = node.catchClauses { 
      catchClauses.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: ReturnStmtSyntax) -> SyntaxVisitorContinueKind {
    node.returnKeyword.walk(&self)
    if let expression = node.expression { 
      expression.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: YieldStmtSyntax) -> SyntaxVisitorContinueKind {
    node.yieldKeyword.walk(&self)
    node.yields.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: YieldListSyntax) -> SyntaxVisitorContinueKind {
    node.leftParen.walk(&self)
    node.elementList.walk(&self)
    if let trailingComma = node.trailingComma { 
      trailingComma.walk(&self)
    }
    node.rightParen.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: FallthroughStmtSyntax) -> SyntaxVisitorContinueKind {
    node.fallthroughKeyword.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: BreakStmtSyntax) -> SyntaxVisitorContinueKind {
    node.breakKeyword.walk(&self)
    if let label = node.label { 
      label.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: CaseItemListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: ConditionElementSyntax) -> SyntaxVisitorContinueKind {
    node.condition.walk(&self)
    if let trailingComma = node.trailingComma { 
      trailingComma.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: AvailabilityConditionSyntax) -> SyntaxVisitorContinueKind {
    node.poundAvailableKeyword.walk(&self)
    node.leftParen.walk(&self)
    node.availabilitySpec.walk(&self)
    node.rightParen.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: MatchingPatternConditionSyntax) -> SyntaxVisitorContinueKind {
    node.caseKeyword.walk(&self)
    node.pattern.walk(&self)
    if let typeAnnotation = node.typeAnnotation { 
      typeAnnotation.walk(&self)
    }
    node.initializer.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: OptionalBindingConditionSyntax) -> SyntaxVisitorContinueKind {
    node.letOrVarKeyword.walk(&self)
    node.pattern.walk(&self)
    if let typeAnnotation = node.typeAnnotation { 
      typeAnnotation.walk(&self)
    }
    node.initializer.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: ConditionElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: DeclarationStmtSyntax) -> SyntaxVisitorContinueKind {
    node.declaration.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: ThrowStmtSyntax) -> SyntaxVisitorContinueKind {
    node.throwKeyword.walk(&self)
    node.expression.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: IfStmtSyntax) -> SyntaxVisitorContinueKind {
    if let labelName = node.labelName { 
      labelName.walk(&self)
    }
    if let labelColon = node.labelColon { 
      labelColon.walk(&self)
    }
    node.ifKeyword.walk(&self)
    node.conditions.walk(&self)
    node.body.walk(&self)
    if let elseKeyword = node.elseKeyword { 
      elseKeyword.walk(&self)
    }
    if let elseBody = node.elseBody { 
      elseBody.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: ElseIfContinuationSyntax) -> SyntaxVisitorContinueKind {
    node.ifStatement.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: ElseBlockSyntax) -> SyntaxVisitorContinueKind {
    node.elseKeyword.walk(&self)
    node.body.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: SwitchCaseSyntax) -> SyntaxVisitorContinueKind {
    if let unknownAttr = node.unknownAttr { 
      unknownAttr.walk(&self)
    }
    node.label.walk(&self)
    node.statements.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: SwitchDefaultLabelSyntax) -> SyntaxVisitorContinueKind {
    node.defaultKeyword.walk(&self)
    node.colon.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: CaseItemSyntax) -> SyntaxVisitorContinueKind {
    node.pattern.walk(&self)
    if let whereClause = node.whereClause { 
      whereClause.walk(&self)
    }
    if let trailingComma = node.trailingComma { 
      trailingComma.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: SwitchCaseLabelSyntax) -> SyntaxVisitorContinueKind {
    node.caseKeyword.walk(&self)
    node.caseItems.walk(&self)
    node.colon.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: CatchClauseSyntax) -> SyntaxVisitorContinueKind {
    node.catchKeyword.walk(&self)
    if let pattern = node.pattern { 
      pattern.walk(&self)
    }
    if let whereClause = node.whereClause { 
      whereClause.walk(&self)
    }
    node.body.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: PoundAssertStmtSyntax) -> SyntaxVisitorContinueKind {
    node.poundAssert.walk(&self)
    node.leftParen.walk(&self)
    node.condition.walk(&self)
    if let comma = node.comma { 
      comma.walk(&self)
    }
    if let message = node.message { 
      message.walk(&self)
    }
    node.rightParen.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: GenericWhereClauseSyntax) -> SyntaxVisitorContinueKind {
    node.whereKeyword.walk(&self)
    node.requirementList.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: GenericRequirementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: SameTypeRequirementSyntax) -> SyntaxVisitorContinueKind {
    node.leftTypeIdentifier.walk(&self)
    node.equalityToken.walk(&self)
    node.rightTypeIdentifier.walk(&self)
    if let trailingComma = node.trailingComma { 
      trailingComma.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: GenericParameterListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: GenericParameterSyntax) -> SyntaxVisitorContinueKind {
    if let attributes = node.attributes { 
      attributes.walk(&self)
    }
    node.name.walk(&self)
    if let colon = node.colon { 
      colon.walk(&self)
    }
    if let inheritedType = node.inheritedType { 
      inheritedType.walk(&self)
    }
    if let trailingComma = node.trailingComma { 
      trailingComma.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: GenericParameterClauseSyntax) -> SyntaxVisitorContinueKind {
    node.leftAngleBracket.walk(&self)
    node.genericParameterList.walk(&self)
    node.rightAngleBracket.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: ConformanceRequirementSyntax) -> SyntaxVisitorContinueKind {
    node.leftTypeIdentifier.walk(&self)
    node.colon.walk(&self)
    node.rightTypeIdentifier.walk(&self)
    if let trailingComma = node.trailingComma { 
      trailingComma.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: SimpleTypeIdentifierSyntax) -> SyntaxVisitorContinueKind {
    visit(node.name, 
          classification: .typeIdentifier, 
          force: false)
    if let genericArgumentClause = node.genericArgumentClause { 
      genericArgumentClause.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: MemberTypeIdentifierSyntax) -> SyntaxVisitorContinueKind {
    node.baseType.walk(&self)
    node.period.walk(&self)
    visit(node.name, 
          classification: .typeIdentifier, 
          force: false)
    if let genericArgumentClause = node.genericArgumentClause { 
      genericArgumentClause.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: ClassRestrictionTypeSyntax) -> SyntaxVisitorContinueKind {
    node.classKeyword.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: ArrayTypeSyntax) -> SyntaxVisitorContinueKind {
    node.leftSquareBracket.walk(&self)
    node.elementType.walk(&self)
    node.rightSquareBracket.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: DictionaryTypeSyntax) -> SyntaxVisitorContinueKind {
    node.leftSquareBracket.walk(&self)
    node.keyType.walk(&self)
    node.colon.walk(&self)
    node.valueType.walk(&self)
    node.rightSquareBracket.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: MetatypeTypeSyntax) -> SyntaxVisitorContinueKind {
    node.baseType.walk(&self)
    node.period.walk(&self)
    node.typeOrProtocol.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: OptionalTypeSyntax) -> SyntaxVisitorContinueKind {
    node.wrappedType.walk(&self)
    node.questionMark.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) -> SyntaxVisitorContinueKind {
    node.wrappedType.walk(&self)
    node.exclamationMark.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: CompositionTypeElementSyntax) -> SyntaxVisitorContinueKind {
    node.type.walk(&self)
    if let ampersand = node.ampersand { 
      ampersand.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: CompositionTypeElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: CompositionTypeSyntax) -> SyntaxVisitorContinueKind {
    node.elements.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: TupleTypeElementSyntax) -> SyntaxVisitorContinueKind {
    if let inOut = node.inOut { 
      inOut.walk(&self)
    }
    if let name = node.name { 
      name.walk(&self)
    }
    if let secondName = node.secondName { 
      secondName.walk(&self)
    }
    if let colon = node.colon { 
      colon.walk(&self)
    }
    node.type.walk(&self)
    if let ellipsis = node.ellipsis { 
      ellipsis.walk(&self)
    }
    if let initializer = node.initializer { 
      initializer.walk(&self)
    }
    if let trailingComma = node.trailingComma { 
      trailingComma.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: TupleTypeElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: TupleTypeSyntax) -> SyntaxVisitorContinueKind {
    node.leftParen.walk(&self)
    node.elements.walk(&self)
    node.rightParen.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: FunctionTypeSyntax) -> SyntaxVisitorContinueKind {
    node.leftParen.walk(&self)
    node.arguments.walk(&self)
    node.rightParen.walk(&self)
    if let throwsOrRethrowsKeyword = node.throwsOrRethrowsKeyword { 
      throwsOrRethrowsKeyword.walk(&self)
    }
    node.arrow.walk(&self)
    node.returnType.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: AttributedTypeSyntax) -> SyntaxVisitorContinueKind {
    if let specifier = node.specifier { 
      specifier.walk(&self)
    }
    if let attributes = node.attributes { 
      attributes.walk(&self)
    }
    node.baseType.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: GenericArgumentListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: GenericArgumentSyntax) -> SyntaxVisitorContinueKind {
    node.argumentType.walk(&self)
    if let trailingComma = node.trailingComma { 
      trailingComma.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: GenericArgumentClauseSyntax) -> SyntaxVisitorContinueKind {
    node.leftAngleBracket.walk(&self)
    node.arguments.walk(&self)
    node.rightAngleBracket.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: TypeAnnotationSyntax) -> SyntaxVisitorContinueKind {
    node.colon.walk(&self)
    node.type.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: EnumCasePatternSyntax) -> SyntaxVisitorContinueKind {
    if let type = node.type { 
      type.walk(&self)
    }
    node.period.walk(&self)
    node.caseName.walk(&self)
    if let associatedTuple = node.associatedTuple { 
      associatedTuple.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: IsTypePatternSyntax) -> SyntaxVisitorContinueKind {
    node.isKeyword.walk(&self)
    node.type.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: OptionalPatternSyntax) -> SyntaxVisitorContinueKind {
    node.subPattern.walk(&self)
    node.questionMark.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: IdentifierPatternSyntax) -> SyntaxVisitorContinueKind {
    node.identifier.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: AsTypePatternSyntax) -> SyntaxVisitorContinueKind {
    node.pattern.walk(&self)
    node.asKeyword.walk(&self)
    node.type.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: TuplePatternSyntax) -> SyntaxVisitorContinueKind {
    node.leftParen.walk(&self)
    node.elements.walk(&self)
    node.rightParen.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: WildcardPatternSyntax) -> SyntaxVisitorContinueKind {
    node.wildcard.walk(&self)
    if let typeAnnotation = node.typeAnnotation { 
      typeAnnotation.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: TuplePatternElementSyntax) -> SyntaxVisitorContinueKind {
    if let labelName = node.labelName { 
      labelName.walk(&self)
    }
    if let labelColon = node.labelColon { 
      labelColon.walk(&self)
    }
    node.pattern.walk(&self)
    if let trailingComma = node.trailingComma { 
      trailingComma.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: ExpressionPatternSyntax) -> SyntaxVisitorContinueKind {
    node.expression.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: TuplePatternElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: ValueBindingPatternSyntax) -> SyntaxVisitorContinueKind {
    node.letOrVarKeyword.walk(&self)
    node.valuePattern.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: AvailabilitySpecListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visit(_ node: AvailabilityArgumentSyntax) -> SyntaxVisitorContinueKind {
    node.entry.walk(&self)
    if let trailingComma = node.trailingComma { 
      trailingComma.walk(&self)
    }
    return .skipChildren
  }
  mutating func visit(_ node: AvailabilityLabeledArgumentSyntax) -> SyntaxVisitorContinueKind {
    node.label.walk(&self)
    node.colon.walk(&self)
    node.value.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: AvailabilityVersionRestrictionSyntax) -> SyntaxVisitorContinueKind {
    visit(node.platform, 
          classification: .keyword, 
          force: false)
    node.version.walk(&self)
    return .skipChildren
  }
  mutating func visit(_ node: VersionTupleSyntax) -> SyntaxVisitorContinueKind {
    node.majorMinor.walk(&self)
    if let patchPeriod = node.patchPeriod { 
      patchPeriod.walk(&self)
    }
    if let patchVersion = node.patchVersion { 
      patchVersion.walk(&self)
    }
    return .skipChildren
  }
}

public enum SyntaxClassifier {
  /// Classify all tokens in the given syntax tree for syntax highlighting.
  /// If a `IncrementalTreeTransferSession` is passed, only nodes that have 
  /// changed since the last transfer will be classified.
  public static func classifyTokensInTree(
    _ syntaxTree: SourceFileSyntax
  ) -> [(TokenSyntax, SyntaxClassification)] {
    var classifier = _SyntaxClassifier()
    syntaxTree.walk(&classifier)
    return classifier.classifications
  }
}
